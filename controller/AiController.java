package com.smhrd.controller;

import java.time.LocalDateTime;

import java.time.LocalTime;

import java.io.File;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.UUID;
import java.math.BigDecimal;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.core.io.ByteArrayResource;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.client.RestTemplate;

import org.springframework.web.multipart.MultipartFile;

import com.smhrd.entity.IntakeSchedule;
import com.smhrd.entity.Supplement;
import com.smhrd.entity.User;
import com.smhrd.entity.UserSupplement;

import com.smhrd.repository.IntakeScheduleRepository;
import com.smhrd.repository.SupplementRepository;
import com.smhrd.repository.UserSupplementRepository;

import jakarta.servlet.http.HttpSession;


@RestController
@RequestMapping("/ai")
public class AiController {


    @Autowired
    private SupplementRepository supplementRepository;


    @Autowired
    private UserSupplementRepository userSupplementRepository;


    @Autowired
    private IntakeScheduleRepository intakeScheduleRepository;



    // =========================================================
    // 1. AI 영양제 분석
    // =========================================================

    @PostMapping("/analyze")
    public ResponseEntity<String> analyze(

            @RequestParam("image") MultipartFile image,

            HttpSession session

    ) {

        try {

            // 현재 사용 중인 ngrok 주소
            String aiServerUrl =
                    "https://province-doorbell-mouse.ngrok-free.dev/analyze";


            // -------------------------------------------------
            // 로그인 사용자 확인
            // -------------------------------------------------

            User loginUser =
                    (User) session.getAttribute("loginUser");


            // -------------------------------------------------
            // 이미지 파일 생성
            // -------------------------------------------------

            ByteArrayResource imageResource =
                    new ByteArrayResource(image.getBytes()) {

                @Override
                public String getFilename() {

                    return image.getOriginalFilename();

                }

            };


            // -------------------------------------------------
            // Python AI 서버로 보낼 데이터
            // -------------------------------------------------

            MultiValueMap<String, Object> body =
                    new LinkedMultiValueMap<>();


            body.add(
                    "image",
                    imageResource
            );


            body.add(
                    "supplements",
                    ""
            );


            // -------------------------------------------------
            // 로그인 여부에 따른 루틴 설정
            // -------------------------------------------------

            if (loginUser != null) {

                // =============================================
                // 로그인 회원
                // DB에 저장된 실제 루틴 시간 사용
                // =============================================

                body.add(
                        "wake_up",
                        formatTime(
                                loginUser.getWakeTime()
                        )
                );


                body.add(
                        "breakfast",
                        formatTime(
                                loginUser.getBreakfastTime()
                        )
                );


                body.add(
                        "lunch",
                        formatTime(
                                loginUser.getLunchTime()
                        )
                );


                body.add(
                        "dinner",
                        formatTime(
                                loginUser.getDinnerTime()
                        )
                );


                body.add(
                        "bedtime",
                        formatTime(
                                loginUser.getSleepTime()
                        )
                );

            } else {

                // =============================================
                // 비로그인 사용자
                // 기존 기본값 그대로 사용
                // =============================================

                body.add(
                        "wake_up",
                        "07:30"
                );


                body.add(
                        "breakfast",
                        "08:00"
                );


                body.add(
                        "lunch",
                        "12:30"
                );


                body.add(
                        "dinner",
                        "18:30"
                );


                body.add(
                        "bedtime",
                        "23:30"
                );

            }


            body.add(
                    "question",
                    ""
            );


            // -------------------------------------------------
            // 헤더 설정
            // -------------------------------------------------

            HttpHeaders headers =
                    new HttpHeaders();


            headers.setContentType(
                    MediaType.MULTIPART_FORM_DATA
            );


            // -------------------------------------------------
            // 요청 생성
            // -------------------------------------------------

            HttpEntity<MultiValueMap<String, Object>> request =
                    new HttpEntity<>(
                            body,
                            headers
                    );


            // -------------------------------------------------
            // Python AI 서버 호출
            // -------------------------------------------------

            RestTemplate restTemplate =
                    new RestTemplate();


            ResponseEntity<String> response =
                    restTemplate.postForEntity(
                            aiServerUrl,
                            request,
                            String.class
                    );


            // -------------------------------------------------
            // Python 서버 결과 그대로 전달
            // -------------------------------------------------

            return ResponseEntity
                    .status(
                            response.getStatusCode()
                    )
                    .body(
                            response.getBody()
                    );


        } catch (Exception e) {

            e.printStackTrace();


            return ResponseEntity
                    .status(
                            HttpStatus.INTERNAL_SERVER_ERROR
                    )
                    .body(
                        """
                        {
                            "status": "error",
                            "message": "AI 서버 호출 중 오류가 발생했습니다."
                        }
                        """
                    );

        }

    }



    // =========================================================
    // 시간 → 문자열 변환
    // =========================================================

    private String formatTime(
            LocalTime time
    ) {

        if (time == null) {

            return "";

        }

        return time.toString();

    }





    // =========================================================
    // 2. 분석한 영양제를 내 영양제로 등록
    // =========================================================

    @PostMapping("/register")
    public ResponseEntity<String> registerSupplement(

            @RequestParam("productName")
            String productName,

            @RequestParam("manufacturer")
            String manufacturer,

            @RequestParam("dailyDose")
            String dailyDose,

            @RequestParam("analysis")
            String analysis,

            @RequestParam("image")
            MultipartFile image,

            HttpSession session

    ) {

        try {

            // -------------------------------------------------
            // 로그인 사용자 확인
            // -------------------------------------------------

            User loginUser =
                    (User) session.getAttribute(
                            "loginUser"
                    );


            // 로그인하지 않은 경우

            if (loginUser == null) {

                return ResponseEntity
                        .status(
                                HttpStatus.UNAUTHORIZED
                        )
                        .body(
                            """
                            {
                                "status": "error",
                                "message": "로그인 시 이용 가능합니다."
                            }
                            """
                        );

            }


            // -------------------------------------------------
            // supplements 테이블에 영양제 저장
            // -------------------------------------------------

            Supplement supplement =
                    new Supplement();


            supplement.setProductName(
                    productName
            );


            supplement.setManufacturer(
                    manufacturer
            );


            supplement.setOcrText(
                    analysis
            );


            supplement.setCreatedAt(
                    LocalDateTime.now()
            );


            // -------------------------------------------------
            // 이미지 저장
            // -------------------------------------------------

            String uploadDir =
                    System.getProperty("user.dir")
                    + "/uploads/supplement/";


            File directory =
                    new File(uploadDir);


            if (!directory.exists()) {

                directory.mkdirs();

            }


            String originalFilename =
                    image.getOriginalFilename();


            String extension = "";


            if (
                    originalFilename != null
                    && originalFilename.contains(".")
            ) {

                extension =
                        originalFilename.substring(
                                originalFilename.lastIndexOf(".")
                        );

            }


            String savedFilename =
                    UUID.randomUUID().toString()
                    + extension;


            Path filePath =
                    Paths.get(
                            uploadDir
                            + savedFilename
                    );


            Files.write(
                    filePath,
                    image.getBytes()
            );


            // -------------------------------------------------
            // DB에는 웹에서 접근할 경로 저장
            // -------------------------------------------------

            supplement.setImageUrl(
                    "/images/supplement/"
                    + savedFilename
            );


            Supplement savedSupplement =
                    supplementRepository.save(
                            supplement
                    );


            // -------------------------------------------------
            // user_supplements 테이블에 등록
            // -------------------------------------------------

            UserSupplement userSupplement =
                    new UserSupplement();


            // 현재 로그인한 사용자

            userSupplement.setUserId(
                    loginUser.getUserIndex()
            );


            // 방금 저장한 영양제 ID

            userSupplement.setSupplementId(
                    savedSupplement.getSupplementId()
            );


            userSupplement.setDailyDose(
                    parseDailyDose(
                            dailyDose
                    )
            );


            userSupplement.setDoseUnit(
                    "회"
            );


            userSupplement.setIsActive(
                    true
            );


            // 등록일시 저장

            userSupplement.setRegisteredAt(
                    LocalDateTime.now()
            );


            userSupplementRepository.save(
                    userSupplement
            );


            // -------------------------------------------------
            // 성공
            // -------------------------------------------------

            return ResponseEntity.ok(

                """
                {
                    "status": "success",
                    "message": "내 영양제로 등록되었습니다."
                }
                """

            );


        } catch (Exception e) {

            e.printStackTrace();


            return ResponseEntity
                    .status(
                            HttpStatus.INTERNAL_SERVER_ERROR
                    )
                    .body(

                        """
                        {
                            "status": "error",
                            "message": "내 영양제 등록 중 오류가 발생했습니다."
                        }
                        """

                    );

        }

    }





    // =========================================================
    // 3. AI 분석 결과에서 추천 복용 시간 추출
    // =========================================================

    private String extractRecommendedTime(
            String analysis
    ) {

        try {

            ObjectMapper objectMapper =
                    new ObjectMapper();


            JsonNode root =
                    objectMapper.readTree(
                            analysis
                    );


            JsonNode timeNode =
                    root.get(
                            "recommended_time"
                    );


            if (
                    timeNode == null
                    || timeNode.isNull()
            ) {

                return null;

            }


            String time =
                    timeNode.asText();


            // HH:MM 형식 확인

            if (
                    time.matches(
                            "^\\d{2}:\\d{2}$"
                    )
            ) {

                return time;

            }


            return null;


        } catch (Exception e) {

            e.printStackTrace();

            return null;

        }

    }





    // =========================================================
    // 4. AI 분석 결과에서 식사 관계 추출
    // =========================================================

    private String extractMealRelation(
            String analysis
    ) {

        try {

            ObjectMapper objectMapper =
                    new ObjectMapper();


            JsonNode root =
                    objectMapper.readTree(
                            analysis
                    );


            JsonNode relationNode =
                    root.get(
                            "meal_relation"
                    );


            if (
                    relationNode == null
                    || relationNode.isNull()
            ) {

                return "시간 관계없음";

            }


            return relationNode.asText();


        } catch (Exception e) {

            e.printStackTrace();


            return "시간 관계없음";

        }

    }





    // =========================================================
    // 5. AI 한글 식사 관계 → Java Enum 변환
    // =========================================================

    private IntakeSchedule.MealRelation convertMealRelation(
            String mealRelation
    ) {

        if (
                "식사 전".equals(
                        mealRelation
                )
        ) {

            return IntakeSchedule.MealRelation.BEFORE_MEAL;

        }


        if (
                "식사 후".equals(
                        mealRelation
                )
        ) {

            return IntakeSchedule.MealRelation.AFTER_MEAL;

        }


        return IntakeSchedule.MealRelation.ANYTIME;

    }





    // =========================================================
    // 6. AI 분석 결과에서 추천 이유 추출
    // =========================================================

    private String extractReason(
            String analysis
    ) {

        try {

            ObjectMapper objectMapper =
                    new ObjectMapper();


            JsonNode root =
                    objectMapper.readTree(
                            analysis
                    );


            JsonNode reasonNode =
                    root.get(
                            "reason"
                    );


            if (
                    reasonNode == null
                    || reasonNode.isNull()
            ) {

                return "AI 추천 복용 시간에 따라 복용하세요.";

            }


            return reasonNode.asText();


        } catch (Exception e) {

            e.printStackTrace();


            return "AI 추천 복용 시간에 따라 복용하세요.";

        }

    }





    // =========================================================
    // 7. dailyDose 문자열 → BigDecimal 변환
    // =========================================================

    private BigDecimal parseDailyDose(
            String dailyDose
    ) {

        try {

            // 숫자와 소수점만 남김

            String number =
                    dailyDose.replaceAll(
                            "[^0-9.]",
                            ""
                    );


            // 숫자가 없는 경우

            if (number.isEmpty()) {

                return BigDecimal.ONE;

            }


            // BigDecimal로 변환

            return new BigDecimal(
                    number
            );


        } catch (Exception e) {

            // 변환 실패 시 기본값 1

            return BigDecimal.ONE;

        }

    }

}