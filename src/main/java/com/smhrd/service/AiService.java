package com.smhrd.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.dto.AiUserData;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClient;
import org.springframework.web.multipart.MultipartFile;

import java.nio.charset.StandardCharsets;

@Service
public class AiService {

    private final RestClient restClient;
    private final AiUserDataService aiUserDataService;
    private final ObjectMapper objectMapper;

    public AiService(AiUserDataService aiUserDataService) {

        this.aiUserDataService = aiUserDataService;
        this.objectMapper = new ObjectMapper();

        // 현재 Colab의 ngrok 주소로 변경
        this.restClient = RestClient.builder()
                .baseUrl("https://province-doorbell-mouse.ngrok-free.dev")
                .build();
    }

    public String analyzeImage(
            MultipartFile image,
            Long userId
    ) throws Exception {

        // =====================================
        // 1. DB 사용자 정보 가져오기
        // =====================================
        AiUserData userData =
                aiUserDataService.getUserData(userId);

        String userDataJson =
                objectMapper.writeValueAsString(userData);

        System.out.println("=================================");
        System.out.println("===== Spring DB 사용자 정보 =====");
        System.out.println("=================================");
        System.out.println(userDataJson);


        // =====================================
        // 2. 이미지 준비
        // =====================================
        ByteArrayResource imageResource =
                new ByteArrayResource(image.getBytes()) {

                    @Override
                    public String getFilename() {
                        return image.getOriginalFilename();
                    }
                };


        // =====================================
        // 3. multipart/form-data 생성
        // =====================================
        MultiValueMap<String, Object> body =
                new LinkedMultiValueMap<>();

        body.add("image", imageResource);
        body.add("user_data", userDataJson);


        System.out.println("=================================");
        System.out.println("===== Python으로 전송 =====");
        System.out.println("=================================");
        System.out.println("파일명 : " + image.getOriginalFilename());
        System.out.println("user_data : " + userDataJson);


        // =====================================
        // 4. Python FastAPI 호출
        // =====================================
        try {

            return restClient.post()
                    .uri("/analyze")
                    .contentType(MediaType.MULTIPART_FORM_DATA)
                    .body(body)

                    // retrieve() 대신 exchange() 사용
                    // → Python의 500 오류도 직접 확인 가능
                    .exchange((request, response) -> {

                        String responseBody =
                                new String(
                                        response.getBody().readAllBytes(),
                                        StandardCharsets.UTF_8
                                );

                        System.out.println("=================================");
                        System.out.println("===== Python 응답 =====");
                        System.out.println("=================================");

                        System.out.println(
                                "상태 코드 : "
                                        + response.getStatusCode()
                        );

                        System.out.println(
                                "응답 내용 : "
                                        + responseBody
                        );


                        // Python이 200이 아니어도
                        // 응답 내용을 그대로 반환
                        return responseBody;
                    });

        } catch (Exception e) {

            System.out.println("=================================");
            System.out.println("===== Python 연결 오류 =====");
            System.out.println("=================================");

            e.printStackTrace();

            return """
                    {
                        "status": "error",
                        "message": "Python 서버 호출 중 오류 발생",
                        "error": "%s"
                    }
                    """.formatted(
                    e.getMessage()
            );
        }
    }
}