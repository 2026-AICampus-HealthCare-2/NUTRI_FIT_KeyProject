package com.smhrd.controller;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.time.DayOfWeek;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import java.time.LocalTime;
import java.util.Optional;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smhrd.entity.IntakeLog;
import com.smhrd.entity.IntakeSchedule;
import com.smhrd.entity.Supplement;
import com.smhrd.entity.User;
import com.smhrd.entity.UserSupplement;
import com.smhrd.repository.IntakeLogRepository;
import com.smhrd.repository.IntakeScheduleRepository;
import com.smhrd.repository.SupplementRepository;
import com.smhrd.repository.UserRepository;
import com.smhrd.repository.UserSupplementRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

    @Autowired
    private IntakeScheduleRepository intakeScheduleRepository;

    @Autowired
    private IntakeLogRepository intakeLogRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserSupplementRepository userSupplementRepository;

    @Autowired
    private SupplementRepository supplementRepository;


    // =========================
    // 메인
    // =========================

    @GetMapping("/main")
    public String main() {
        return "main";
    }


    // =========================
    // 영양제 분석
    // =========================

    @GetMapping("/aiAnalysis")
    public String aiAnalysis() {
        return "aiAnalysis";
    }


    // =========================
    // 내 영양제
    // =========================

    @GetMapping("/mySupplement")
    public String mySupplement(
            HttpSession session,
            Model model
    ) {

        User loginUser =
                (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        List<UserSupplement> supplementList =
                userSupplementRepository
                        .findByUserIdAndIsActiveTrue(
                                loginUser.getUserIndex()
                        );

        List<Supplement> supplements =
                supplementList.stream()
                        .map(userSupplement ->
                                supplementRepository
                                        .findById(
                                                userSupplement
                                                        .getSupplementId()
                                        )
                                        .orElse(null)
                        )
                        .filter(supplement -> supplement != null)
                        .toList();

        model.addAttribute(
                "supplementList",
                supplementList
        );

        model.addAttribute(
                "supplements",
                supplements
        );

        return "mySupplement";
    }
    // =========================
    // 영양제 삭제
    // =========================

    @PostMapping("/mySupplement/delete")
    @ResponseBody
    public ResponseEntity<String> deleteSupplement(
            @RequestParam("userSupplementId")
            Long userSupplementId,

            HttpSession session
    ) {

        User loginUser =
                (User) session.getAttribute("loginUser");

        if (loginUser == null) {

            return ResponseEntity
                    .status(
                            HttpStatus.UNAUTHORIZED
                    )
                    .body("""
                        {
                            "status": "error",
                            "message": "로그인 시 이용 가능합니다."
                        }
                        """);
        }


        UserSupplement userSupplement =
                userSupplementRepository
                        .findById(
                                userSupplementId
                        )
                        .orElse(null);


        if (userSupplement == null) {

            return ResponseEntity
                    .status(
                            HttpStatus.NOT_FOUND
                    )
                    .body("""
                        {
                            "status": "error",
                            "message": "영양제를 찾을 수 없습니다."
                        }
                        """);
        }


        // 다른 사용자의 영양제 삭제 방지
        if (!userSupplement.getUserId()
                .equals(
                        loginUser.getUserIndex()
                )) {

            return ResponseEntity
                    .status(
                            HttpStatus.FORBIDDEN
                    )
                    .body("""
                        {
                            "status": "error",
                            "message": "삭제할 수 없는 영양제입니다."
                        }
                        """);
        }


        userSupplementRepository.delete(
                userSupplement
        );


        return ResponseEntity.ok("""
            {
                "status": "success",
                "message": "영양제가 삭제되었습니다."
            }
            """);
    }
    
 // =========================
 // 복용 일정 추가
 // =========================
 // =========================
 // 복용 일정 추가
 // =========================
 @PostMapping("/intake/add")
 @ResponseBody
 public ResponseEntity<String> addIntakeSchedule(
         @RequestParam("userSupplementId") Long userSupplementId,
         HttpSession session) {

     User loginUser =
             (User) session.getAttribute("loginUser");

     if (loginUser == null) {
         return ResponseEntity
                 .status(HttpStatus.UNAUTHORIZED)
                 .body("""
                     {
                         "status": "error",
                         "message": "로그인 시 이용 가능합니다."
                     }
                     """);
     }

     UserSupplement userSupplement =
             userSupplementRepository
                     .findById(userSupplementId)
                     .orElse(null);

     if (userSupplement == null) {
         return ResponseEntity
                 .status(HttpStatus.NOT_FOUND)
                 .body("""
                     {
                         "status": "error",
                         "message": "영양제 정보를 찾을 수 없습니다."
                     }
                     """);
     }

     // 본인의 영양제인지 확인
     if (!userSupplement.getUserId()
             .equals(loginUser.getUserIndex())) {

         return ResponseEntity
                 .status(HttpStatus.FORBIDDEN)
                 .body("""
                     {
                         "status": "error",
                         "message": "복용 일정을 추가할 수 없습니다."
                     }
                     """);
     }

     // 이미 일정이 있는지 확인
     List<IntakeSchedule> existingSchedules =
             intakeScheduleRepository
                     .findByUserSupplementIdAndIsActiveTrue(
                             userSupplementId
                     );

     if (!existingSchedules.isEmpty()) {
         return ResponseEntity.ok("""
             {
                 "status": "already",
                 "message": "이미 복용 일정이 추가되어 있습니다."
             }
             """);
     }

     try {

         // 영양제 조회
         Supplement supplement =
                 supplementRepository
                         .findById(userSupplement.getSupplementId())
                         .orElse(null);

         if (supplement == null) {
             return ResponseEntity
                     .status(HttpStatus.NOT_FOUND)
                     .body("""
                         {
                             "status": "error",
                             "message": "영양제 정보를 찾을 수 없습니다."
                         }
                         """);
         }

         /*
          * 현재 supplement의 ocrText에
          * AI 분석 결과 JSON이 저장되어 있음
          */
         String analysisJson =
                 supplement.getOcrText();

         ObjectMapper objectMapper =
                 new ObjectMapper();

         JsonNode analysis =
                 objectMapper.readTree(analysisJson);

         // AI 추천 시간
         String recommendedTime =
                 analysis.path("recommended_time").asText();

         if (recommendedTime == null
                 || recommendedTime.isBlank()) {

             return ResponseEntity
                     .status(HttpStatus.BAD_REQUEST)
                     .body("""
                         {
                             "status": "error",
                             "message": "AI 추천 복용 시간을 찾을 수 없습니다."
                         }
                         """);
         }

         // 시간 변환
         LocalTime intakeTime =
                 LocalTime.parse(recommendedTime);

         // AI 식사 관계
         String mealRelationText =
                 analysis.path("meal_relation").asText();

         IntakeSchedule.MealRelation mealRelation;

         if ("식사 전".equals(mealRelationText)
                 || "BEFORE_MEAL".equals(mealRelationText)) {

             mealRelation =
                     IntakeSchedule.MealRelation.BEFORE_MEAL;

         } else if ("식사 중".equals(mealRelationText)
                 || "WITH_MEAL".equals(mealRelationText)) {

             mealRelation =
                     IntakeSchedule.MealRelation.WITH_MEAL;

         } else if ("식사 후".equals(mealRelationText)
                 || "AFTER_MEAL".equals(mealRelationText)) {

             mealRelation =
                     IntakeSchedule.MealRelation.AFTER_MEAL;

         } else {

             mealRelation =
                     IntakeSchedule.MealRelation.ANYTIME;
         }

         // AI 추천 이유
         String recommendation =
                 analysis.path("reason").asText();

         if (recommendation == null
                 || recommendation.isBlank()) {

             recommendation =
                     "AI 분석 결과를 바탕으로 추천된 복용 일정입니다.";
         }

         // 복용 일정 저장
         IntakeSchedule schedule =
                 new IntakeSchedule();

         schedule.setUserSupplementId(
                 userSupplementId
         );

         schedule.setIntakeTime(
                 intakeTime
         );

         schedule.setMealRelation(
                 mealRelation
         );

         schedule.setRecommendation(
                 recommendation
         );

         schedule.setIsActive(true);

         intakeScheduleRepository.save(schedule);

         return ResponseEntity.ok("""
             {
                 "status": "success",
                 "message": "복용 일정이 추가되었습니다."
             }
             """);

     } catch (Exception e) {

         e.printStackTrace();

         return ResponseEntity
                 .status(HttpStatus.INTERNAL_SERVER_ERROR)
                 .body("""
                     {
                         "status": "error",
                         "message": "복용 일정 추가 중 오류가 발생했습니다."
                     }
                     """);
     }
 }
 @GetMapping("/myPage")
 public String myPage(
         HttpSession session,
         Model model) {

     // ==========================================
     // 1. 로그인 확인
     // ==========================================

     User loginUser =
             (User) session.getAttribute("loginUser");

     if (loginUser == null) {
         return "redirect:/login";
     }


     // ==========================================
     // 2. 로그인 사용자 정보
     // ==========================================

     model.addAttribute(
             "loginUser",
             loginUser
     );


     // ==========================================
     // 3. 현재 사용자의 등록 영양제 조회
     // ==========================================

     List<UserSupplement> userSupplementList =
             userSupplementRepository
                     .findByUserIdAndIsActiveTrue(
                             loginUser.getUserIndex()
                     );


     // 총 등록 영양제
     int totalSupplement =
             userSupplementList.size();


     // ==========================================
     // 4. 복용 영양제 정보 조회
     // ==========================================

     List<Supplement> supplementList =
             new ArrayList<>();


     for (UserSupplement userSupplement
             : userSupplementList) {

         Supplement supplement =
                 supplementRepository
                         .findById(
                                 userSupplement
                                         .getSupplementId()
                         )
                         .orElse(null);

         if (supplement != null) {

             supplementList.add(
                     supplement
             );
         }
     }


     // ==========================================
     // 5. 사용자의 복용 일정 조회
     // ==========================================

     List<IntakeSchedule> userScheduleList =
             new ArrayList<>();


     for (UserSupplement userSupplement
             : userSupplementList) {

         List<IntakeSchedule> scheduleList =
                 intakeScheduleRepository
                         .findByUserSupplementIdAndIsActiveTrue(
                                 userSupplement
                                         .getUserSupplementId()
                         );

         userScheduleList.addAll(
                 scheduleList
         );
     }


     // ==========================================
     // 6. 복용 일정 ID 저장
     // ==========================================

     Set<Long> scheduleIdSet =
             new HashSet<>();


     for (IntakeSchedule schedule
             : userScheduleList) {

         scheduleIdSet.add(
                 schedule.getScheduleId()
         );
     }


     // ==========================================
     // 7. 현재 사용자의 복용 기록 조회
     // ==========================================

     List<IntakeLog> userLogList =
             new ArrayList<>();


     List<IntakeLog> allLogList =
             intakeLogRepository.findAll();


     for (IntakeLog log : allLogList) {

         if (scheduleIdSet.contains(
                 log.getScheduleId())) {

             userLogList.add(
                     log
             );
         }
     }


     // ==========================================
     // 8. 복용 기록을 화면용 데이터로 변환
     // ==========================================

     List<Map<String, Object>> historyList =
             new ArrayList<>();


     for (IntakeLog log : userLogList) {

         // -------------------------------
         // 복용 일정 찾기
         // -------------------------------

         IntakeSchedule schedule =
                 userScheduleList
                         .stream()
                         .filter(s ->
                                 s.getScheduleId()
                                         .equals(
                                                 log.getScheduleId()
                                         )
                         )
                         .findFirst()
                         .orElse(null);


         if (schedule == null) {
             continue;
         }


         // -------------------------------
         // 사용자 영양제 찾기
         // -------------------------------

         UserSupplement userSupplement =
                 userSupplementList
                         .stream()
                         .filter(us ->
                                 us.getUserSupplementId()
                                         .equals(
                                                 schedule
                                                         .getUserSupplementId()
                                         )
                         )
                         .findFirst()
                         .orElse(null);


         if (userSupplement == null) {
             continue;
         }


         // -------------------------------
         // 영양제 찾기
         // -------------------------------

         Supplement supplement =
                 supplementList
                         .stream()
                         .filter(s ->
                                 s.getSupplementId()
                                         .equals(
                                                 userSupplement
                                                         .getSupplementId()
                                         )
                         )
                         .findFirst()
                         .orElse(null);


         if (supplement == null) {
             continue;
         }


         // -------------------------------
         // 화면에 전달할 데이터
         // -------------------------------

         Map<String, Object> history =
                 new HashMap<>();


         // 영양제 이름
         history.put(
                 "productName",
                 supplement.getProductName()
         );


         // 날짜
         history.put(
                 "intakeDate",
                 log.getIntakeDate()
         );


         // 예정 복용 시간
         history.put(
                 "scheduledTime",
                 log.getScheduledTime()
         );


         // 실제 복용 시간
         history.put(
                 "takenAt",
                 log.getTakenAt()
         );


         // 섭취량
         history.put(
                 "dailyDose",
                 userSupplement.getDailyDose()
         );


         // 단위
         history.put(
                 "doseUnit",
                 userSupplement.getDoseUnit()
         );


         // 상태
         history.put(
                 "status",
                 log.getStatus()
         );


         historyList.add(
                 history
         );
     }


     // ==========================================
     // 9. 복용 기록 최신순 정렬
     // ==========================================

     historyList.sort((a, b) -> {

         LocalDate dateA =
                 (LocalDate) a.get("intakeDate");

         LocalDate dateB =
                 (LocalDate) b.get("intakeDate");


         return dateB.compareTo(dateA);
     });


     // ==========================================
     // 10. 총 복용 횟수
     // ==========================================

     long totalIntake = 0;

     long takenCount = 0;

     long missedCount = 0;


     for (IntakeLog log : userLogList) {

         if (log.getStatus()
                 == IntakeLog.IntakeStatus.TAKEN) {

             totalIntake++;

             takenCount++;

         } else if (
                 log.getStatus()
                         == IntakeLog.IntakeStatus.MISSED) {

             missedCount++;
         }
     }


     // ==========================================
     // 11. 평균 복용률
     // ==========================================

     long completedCount =
             takenCount + missedCount;


     int averageRate = 0;


     if (completedCount > 0) {

         averageRate =
                 (int) Math.round(
                         takenCount * 100.0
                                 / completedCount
                 );
     }


     // ==========================================
     // 12. JSP에 데이터 전달
     // ==========================================

     model.addAttribute(
             "totalSupplement",
             totalSupplement
     );


     model.addAttribute(
             "totalIntake",
             totalIntake
     );


     model.addAttribute(
             "averageRate",
             averageRate
     );


     // 복용 영양제
     model.addAttribute(
             "userSupplementList",
             userSupplementList
     );


     model.addAttribute(
             "supplementList",
             supplementList
     );


     // 전체 복용 기록
     model.addAttribute(
             "historyList",
             historyList
     );


     // ==========================================
     // 13. myPage.jsp
     // ==========================================

     return "myPage";
 }


    // =========================
    // 로그인 페이지
    // =========================

    @GetMapping("/login")
    public String login() {
        return "login";
    }


    // =========================
    // 회원가입 페이지
    // =========================

    @GetMapping("/join")
    public String join() {
        return "join";
    }


    // =========================
    // 회원가입 처리
    // =========================

    @PostMapping("/join")
    public String joinProcess(
            @RequestParam("userId")
            String userId,

            @RequestParam("password")
            String password,

            @RequestParam("passwordConfirm")
            String passwordConfirm,

            @RequestParam("nickname")
            String nickname,

            @RequestParam("wakeTime")
            String wakeTime,

            @RequestParam("breakfastTime")
            String breakfastTime,

            @RequestParam("lunchTime")
            String lunchTime,

            @RequestParam("dinnerTime")
            String dinnerTime,

            @RequestParam("sleepTime")
            String sleepTime
    ) {

        if (!password.equals(passwordConfirm)) {
            return "redirect:/join?error=password";
        }


        User existingUser =
                userRepository.findByUserId(
                        userId
                );

        if (existingUser != null) {
            return "redirect:/join?error=id";
        }


        User user =
                new User();

        user.setUserId(userId);

        user.setPassword(password);

        user.setNickname(nickname);

        user.setWakeTime(
                LocalTime.parse(wakeTime)
        );

        user.setBreakfastTime(
                LocalTime.parse(breakfastTime)
        );

        user.setLunchTime(
                LocalTime.parse(lunchTime)
        );

        user.setDinnerTime(
                LocalTime.parse(dinnerTime)
        );

        user.setSleepTime(
                LocalTime.parse(sleepTime)
        );


        userRepository.save(user);


        return "redirect:/login";
    }


    // =========================
    // 로그인 처리
    // =========================

    @PostMapping("/login")
    public String loginProcess(
            @RequestParam("userId")
            String userId,

            @RequestParam("password")
            String password,

            HttpSession session
    ) {

        User user =
                userRepository.findByUserId(
                        userId
                );


        if (user == null
                || !user.getPassword()
                        .equals(password)) {

            return "redirect:/login?error=true";
        }


        session.setAttribute(
                "loginUser",
                user
        );


        return "redirect:/main";
    }


    // =========================
    // 로그아웃
    // =========================

    @GetMapping("/logout")
    public String logout(
            HttpSession session
    ) {

        session.invalidate();

        return "redirect:/main";
    }


    // =========================
    // 복용 완료
    // =========================

    @PostMapping("/intake/complete")
    @ResponseBody
    public ResponseEntity<String> completeIntake(
            @RequestParam("scheduleId")
            Long scheduleId,

            HttpSession session
    ) {

        User loginUser =
                (User) session.getAttribute("loginUser");


        if (loginUser == null) {

            return ResponseEntity
                    .status(
                            HttpStatus.UNAUTHORIZED
                    )
                    .body("""
                        {
                            "status": "error",
                            "message": "로그인 시 이용 가능합니다."
                        }
                        """);
        }


        IntakeSchedule schedule =
                intakeScheduleRepository
                        .findById(scheduleId)
                        .orElse(null);


        if (schedule == null) {

            return ResponseEntity
                    .status(
                            HttpStatus.NOT_FOUND
                    )
                    .body("""
                        {
                            "status": "error",
                            "message": "복용 일정을 찾을 수 없습니다."
                        }
                        """);
        }


        LocalDate today =
                LocalDate.now();


        IntakeLog log =
                intakeLogRepository
                        .findByScheduleIdAndIntakeDate(
                                scheduleId,
                                today
                        )
                        .orElse(null);


        if (log == null) {

            log =
                    new IntakeLog();

            log.setScheduleId(
                    scheduleId
            );

            log.setIntakeDate(
                    today
            );

            log.setScheduledTime(
                    schedule.getIntakeTime()
            );
        }


        log.setStatus(
                IntakeLog.IntakeStatus.TAKEN
        );

        log.setTakenAt(
                java.time.LocalDateTime.now()
        );


        intakeLogRepository.save(
                log
        );


        return ResponseEntity.ok("""
            {
                "status": "success",
                "message": "복용 완료가 저장되었습니다."
            }
            """);
    }
    
    
    @PostMapping("/myPage/update")
    @ResponseBody
    public ResponseEntity<String> updateUserInfo(
            @RequestParam("nickname") String nickname,
            @RequestParam("wakeTime") String wakeTime,
            @RequestParam("breakfastTime") String breakfastTime,
            @RequestParam("lunchTime") String lunchTime,
            @RequestParam("dinnerTime") String dinnerTime,
            @RequestParam("sleepTime") String sleepTime,
            HttpSession session) {

        try {

            // 로그인 사용자 확인
            User loginUser =
                    (User) session.getAttribute("loginUser");

            if (loginUser == null) {

                return ResponseEntity
                        .status(HttpStatus.UNAUTHORIZED)
                        .body("""
                            {
                                "status": "error",
                                "message": "로그인이 필요합니다."
                            }
                            """);
            }

            // DB에서 현재 사용자 조회
            User user =
                    userRepository.findById(
                            loginUser.getUserIndex()
                    ).orElse(null);

            if (user == null) {

                return ResponseEntity
                        .status(HttpStatus.NOT_FOUND)
                        .body("""
                            {
                                "status": "error",
                                "message": "사용자 정보를 찾을 수 없습니다."
                            }
                            """);
            }

            // 사용자 정보 수정
            user.setNickname(nickname);
            user.setWakeTime(LocalTime.parse(wakeTime));
            user.setBreakfastTime(LocalTime.parse(breakfastTime));
            user.setLunchTime(LocalTime.parse(lunchTime));
            user.setDinnerTime(LocalTime.parse(dinnerTime));
            user.setSleepTime(LocalTime.parse(sleepTime));

            // DB 저장
            userRepository.save(user);

            // 세션 정보도 최신 정보로 변경
            session.setAttribute("loginUser", user);

            return ResponseEntity.ok("""
                {
                    "status": "success",
                    "message": "정보가 수정되었습니다."
                }
                """);

        } catch (Exception e) {

            e.printStackTrace();

            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("""
                        {
                            "status": "error",
                            "message": "정보 수정 중 오류가 발생했습니다."
                        }
                        """);
        }
    }
    
    @GetMapping("/myPage/pdf")
    public ResponseEntity<byte[]> downloadIntakeHistoryPdf(
            HttpSession session) {

        // ==========================================
        // 1. 로그인 확인
        // ==========================================

        User loginUser =
                (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .build();
        }


        try {

            // ==========================================
            // 2. 현재 사용자의 등록 영양제 조회
            // ==========================================

            List<UserSupplement> userSupplementList =
                    userSupplementRepository
                            .findByUserIdAndIsActiveTrue(
                                    loginUser.getUserIndex()
                            );


            // ==========================================
            // 3. 사용자의 복용 일정 조회
            // ==========================================

            List<IntakeSchedule> userScheduleList =
                    new ArrayList<>();

            for (UserSupplement userSupplement
                    : userSupplementList) {

                List<IntakeSchedule> scheduleList =
                        intakeScheduleRepository
                                .findByUserSupplementIdAndIsActiveTrue(
                                        userSupplement
                                                .getUserSupplementId()
                                );

                userScheduleList.addAll(scheduleList);
            }


            // ==========================================
            // 4. 복용 일정 ID 저장
            // ==========================================

            Set<Long> scheduleIdSet =
                    new HashSet<>();

            for (IntakeSchedule schedule
                    : userScheduleList) {

                scheduleIdSet.add(
                        schedule.getScheduleId()
                );
            }


            // ==========================================
            // 5. 현재 사용자의 복용 기록 조회
            // ==========================================

            List<IntakeLog> userLogList =
                    new ArrayList<>();

            List<IntakeLog> allLogList =
                    intakeLogRepository.findAll();

            for (IntakeLog log : allLogList) {

                if (scheduleIdSet.contains(
                        log.getScheduleId())) {

                    userLogList.add(log);
                }
            }


            // ==========================================
            // 6. 날짜순 정렬
            // ==========================================

            userLogList.sort(
                    (a, b) -> {

                        int dateCompare =
                                b.getIntakeDate()
                                        .compareTo(
                                                a.getIntakeDate()
                                        );

                        if (dateCompare != 0) {
                            return dateCompare;
                        }

                        return b.getScheduledTime()
                                .compareTo(
                                        a.getScheduledTime()
                                );
                    }
            );


            // ==========================================
            // 7. 영양제 이름 조회용 Map 생성
            // ==========================================

            Map<Long, String> supplementNameMap =
                    new HashMap<>();


            for (UserSupplement userSupplement
                    : userSupplementList) {

                Supplement supplement =
                        supplementRepository
                                .findById(
                                        userSupplement
                                                .getSupplementId()
                                )
                                .orElse(null);

                if (supplement != null) {

                    supplementNameMap.put(
                            userSupplement
                                    .getUserSupplementId(),

                            supplement
                                    .getProductName()
                    );
                }
            }


            // ==========================================
            // 8. PDF 생성
            // ==========================================

            Document document =
                    new Document(
                            PageSize.A4,
                            40,
                            40,
                            50,
                            50
                    );


            ByteArrayOutputStream outputStream =
                    new ByteArrayOutputStream();


            PdfWriter.getInstance(
                    document,
                    outputStream
            );


            document.open();


            // ==========================================
            // 9. 한글 폰트 설정
            // ==========================================

            BaseFont baseFont =
                    BaseFont.createFont(
                            "c:/Windows/Fonts/malgun.ttf",
                            BaseFont.IDENTITY_H,
                            BaseFont.EMBEDDED
                    );


            Font titleFont =
                    new Font(
                            baseFont,
                            22,
                            Font.BOLD
                    );


            Font normalFont =
                    new Font(
                            baseFont,
                            10,
                            Font.NORMAL
                    );


            Font headerFont =
                    new Font(
                            baseFont,
                            10,
                            Font.BOLD
                    );


            Font smallFont =
                    new Font(
                            baseFont,
                            9,
                            Font.NORMAL
                    );


            // ==========================================
            // 10. 제목
            // ==========================================

            Paragraph title =
                    new Paragraph(
                            "NUTRI_FIT",
                            titleFont
                    );

            title.setAlignment(
                    Element.ALIGN_CENTER
            );

            document.add(title);


            Paragraph subTitle =
                    new Paragraph(
                            "전체 복용 기록",
                            headerFont
                    );

            subTitle.setAlignment(
                    Element.ALIGN_CENTER
            );

            document.add(subTitle);


            document.add(
                    new Paragraph(
                            " ",
                            normalFont
                    )
            );


            // ==========================================
            // 11. 사용자 정보
            // ==========================================

            Paragraph userInfo =
                    new Paragraph(
                            "사용자 : "
                            + loginUser.getNickname(),
                            normalFont
                    );

            document.add(userInfo);


            Paragraph downloadDate =
                    new Paragraph(
                            "다운로드 날짜 : "
                            + LocalDate.now(),
                            normalFont
                    );

            document.add(downloadDate);


            document.add(
                    new Paragraph(
                            " ",
                            normalFont
                    )
            );


            // ==========================================
            // 12. 복용 기록 테이블
            // ==========================================

            PdfPTable table =
                    new PdfPTable(5);

            table.setWidthPercentage(100);


            // 열 너비

            table.setWidths(
                    new float[]{
                            3.0f,
                            1.8f,
                            1.8f,
                            1.5f,
                            1.5f
                    }
            );


            // ==========================================
            // 13. 테이블 헤더
            // ==========================================

            PdfPCell cell;


            cell = new PdfPCell(
                    new Phrase(
                            "영양제",
                            headerFont
                    )
            );

            cell.setHorizontalAlignment(
                    Element.ALIGN_CENTER
            );

            cell.setPadding(7);

            table.addCell(cell);


            cell = new PdfPCell(
                    new Phrase(
                            "날짜",
                            headerFont
                    )
            );

            cell.setHorizontalAlignment(
                    Element.ALIGN_CENTER
            );

            cell.setPadding(7);

            table.addCell(cell);


            cell = new PdfPCell(
                    new Phrase(
                            "복용 시간",
                            headerFont
                    )
            );

            cell.setHorizontalAlignment(
                    Element.ALIGN_CENTER
            );

            cell.setPadding(7);

            table.addCell(cell);


            cell = new PdfPCell(
                    new Phrase(
                            "상태",
                            headerFont
                    )
            );

            cell.setHorizontalAlignment(
                    Element.ALIGN_CENTER
            );

            cell.setPadding(7);

            table.addCell(cell);


            cell = new PdfPCell(
                    new Phrase(
                            "실제 복용 시간",
                            headerFont
                    )
            );

            cell.setHorizontalAlignment(
                    Element.ALIGN_CENTER
            );

            cell.setPadding(7);

            table.addCell(cell);


            // ==========================================
            // 14. 복용 기록 출력
            // ==========================================

            for (IntakeLog log : userLogList) {

                IntakeSchedule schedule =
                        intakeScheduleRepository
                                .findById(
                                        log.getScheduleId()
                                )
                                .orElse(null);

                if (schedule == null) {
                    continue;
                }


                String supplementName =
                        supplementNameMap.get(
                                userSupplementList
                                        .stream()
                                        .filter(us ->
                                                us.getUserSupplementId()
                                                        .equals(
                                                                findUserSupplementId(
                                                                        schedule.getUserSupplementId(),
                                                                        userSupplementList
                                                                )
                                                        )
                                        )
                                        .map(UserSupplement::getUserSupplementId)
                                        .findFirst()
                                        .orElse(null)
                        );


                /*
                 * 위 방식보다 직접 userSupplement를
                 * 찾는 방식으로 처리
                 */

                UserSupplement targetUserSupplement =
                        null;

                for (UserSupplement us
                        : userSupplementList) {

                    if (us.getUserSupplementId()
                            .equals(
                                    schedule
                                        .getUserSupplementId()
                            )) {

                        targetUserSupplement = us;
                        break;
                    }
                }


                if (targetUserSupplement != null) {

                    supplementName =
                            supplementNameMap.get(
                                    targetUserSupplement
                                        .getUserSupplementId()
                            );
                }


                if (supplementName == null) {

                    supplementName =
                            "영양제";
                }


                // 영양제

                table.addCell(
                        createPdfCell(
                                supplementName,
                                normalFont
                        )
                );


                // 날짜

                table.addCell(
                        createPdfCell(
                                log.getIntakeDate()
                                        .toString(),
                                normalFont
                        )
                );


                // 예정 시간

                table.addCell(
                        createPdfCell(
                                log.getScheduledTime()
                                        .toString(),
                                normalFont
                        )
                );


                // 상태

                String statusText;


                if (log.getStatus()
                        == IntakeLog.IntakeStatus.TAKEN) {

                    statusText =
                            "복용 완료";

                } else if (
                        log.getStatus()
                                == IntakeLog.IntakeStatus.MISSED) {

                    statusText =
                            "미복용";

                } else if (
                        log.getStatus()
                                == IntakeLog.IntakeStatus.SKIPPED) {

                    statusText =
                            "건너뜀";

                } else {

                    statusText =
                            "대기";
                }


                table.addCell(
                        createPdfCell(
                                statusText,
                                normalFont
                        )
                );


                // 실제 복용 시간

                String takenTime = "-";


                if (log.getTakenAt() != null) {

                    takenTime =
                            log.getTakenAt()
                                    .toLocalTime()
                                    .toString();
                }


                table.addCell(
                        createPdfCell(
                                takenTime,
                                normalFont
                        )
                );
            }


            document.add(table);


            // ==========================================
            // 15. 기록이 없는 경우
            // ==========================================

            if (userLogList.isEmpty()) {

                document.add(
                        new Paragraph(
                                "등록된 복용 기록이 없습니다.",
                                normalFont
                        )
                );
            }


            // ==========================================
            // 16. PDF 종료
            // ==========================================

            document.close();


            byte[] pdfBytes =
                    outputStream.toByteArray();


            // ==========================================
            // 17. 다운로드 응답
            // ==========================================

            HttpHeaders headers =
                    new HttpHeaders();

            headers.setContentType(
                    MediaType.APPLICATION_PDF
            );

            headers.setContentDisposition(
                    ContentDisposition
                            .attachment()
                            .filename(
                                    "NUTRI_FIT_복용기록.pdf",
                                    StandardCharsets.UTF_8
                            )
                            .build()
            );


            return new ResponseEntity<>(
                    pdfBytes,
                    headers,
                    HttpStatus.OK
            );


        } catch (Exception e) {

            e.printStackTrace();

            return ResponseEntity
                    .status(
                            HttpStatus.INTERNAL_SERVER_ERROR
                    )
                    .build();
        }
    }
    
    private Object findUserSupplementId(Long userSupplementId, List<UserSupplement> userSupplementList) {
		// TODO Auto-generated method stub
		return null;
	}


	private PdfPCell createPdfCell(
            String text,
            Font font) {

        PdfPCell cell =
                new PdfPCell(
                        new Phrase(
                                text,
                                font
                        )
                );

        cell.setHorizontalAlignment(
                Element.ALIGN_CENTER
        );

        cell.setVerticalAlignment(
                Element.ALIGN_MIDDLE
        );

        cell.setPadding(7);

        return cell;
    }
}