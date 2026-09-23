package com.smhrd.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.smhrd.entity.User;
import com.smhrd.repository.UserRepository;
import com.smhrd.service.WebPushService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/push")
@RequiredArgsConstructor
public class PushController {

    private final UserRepository userRepository;
    private final WebPushService webPushService;


    // =========================================================
    // Push 알림 해제
    // =========================================================

    @PostMapping("/unsubscribe")
    public ResponseEntity<?> unsubscribe(
            @RequestBody Map<String, Object> request) {

        try {

            Long userIndex =
                    Long.valueOf(
                            request.get("userIndex").toString()
                    );


            User user =
                    userRepository.findById(userIndex)
                            .orElse(null);


            if (user == null) {

                return ResponseEntity.badRequest().body(
                        Map.of(
                                "status", "error",
                                "message", "사용자를 찾을 수 없습니다."
                        )
                );
            }


            // Push 구독 정보 삭제
            user.setPushEndpoint(null);
            user.setPushP256dh(null);
            user.setPushAuth(null);

            userRepository.save(user);


            return ResponseEntity.ok(
                    Map.of(
                            "status", "success",
                            "message", "Push 알림이 해제되었습니다."
                    )
            );


        } catch (Exception e) {

            e.printStackTrace();

            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", "error",
                            "message", "Push 알림 해제에 실패했습니다.",
                            "detail", e.getMessage()
                    )
            );
        }
    }


    // =========================================================
    // Push 구독 정보 저장
    // =========================================================

    @PostMapping("/subscribe")
    public ResponseEntity<?> subscribe(
            @RequestBody Map<String, Object> request) {

        try {

            // 사용자 번호
            Long userIndex =
                    Long.valueOf(
                            request.get("userIndex").toString()
                    );


            // Push endpoint
            String endpoint =
                    request.get("endpoint").toString();


            // keys
            @SuppressWarnings("unchecked")
            Map<String, Object> keys =
                    (Map<String, Object>) request.get("keys");


            String p256dh =
                    keys.get("p256dh").toString();


            String auth =
                    keys.get("auth").toString();


            // 사용자 조회
            User user =
                    userRepository.findById(userIndex)
                            .orElse(null);


            if (user == null) {

                return ResponseEntity.badRequest().body(
                        Map.of(
                                "status", "error",
                                "message", "사용자를 찾을 수 없습니다."
                        )
                );
            }


            // Push 정보 저장
            user.setPushEndpoint(endpoint);
            user.setPushP256dh(p256dh);
            user.setPushAuth(auth);

            userRepository.save(user);


            return ResponseEntity.ok(
                    Map.of(
                            "status", "success",
                            "message", "Push 구독 정보가 저장되었습니다."
                    )
            );


        } catch (Exception e) {

            e.printStackTrace();

            return ResponseEntity.badRequest().body(
                    Map.of(
                            "status", "error",
                            "message", "Push 구독 저장에 실패했습니다.",
                            "detail", e.getMessage()
                    )
            );
        }
    }


    // =========================================================
    // Push 테스트
    // =========================================================

    @GetMapping("/test")
    public ResponseEntity<?> testPush(
            @RequestParam("userIndex") Long userIndex) {

        try {

            System.out.println("=================================");
            System.out.println("[Push Test] 시작");
            System.out.println("[Push Test] userIndex = " + userIndex);


            // 사용자 조회
            User user =
                    userRepository.findById(userIndex)
                            .orElse(null);


            if (user == null) {

                System.out.println("[Push Test] 사용자 없음");

                return ResponseEntity.badRequest().body(
                        Map.of(
                                "status", "error",
                                "message", "사용자를 찾을 수 없습니다."
                        )
                );
            }


            System.out.println("[Push Test] 사용자 조회 성공");
            System.out.println("[Push Test] pushEndpoint = "
                    + user.getPushEndpoint());


            // Push 구독 정보 확인
            if (user.getPushEndpoint() == null
                    || user.getPushP256dh() == null
                    || user.getPushAuth() == null) {

                System.out.println("[Push Test] Push 구독 정보 없음");

                return ResponseEntity.badRequest().body(
                        Map.of(
                                "status", "error",
                                "message", "Push 구독 정보가 없습니다."
                        )
                );
            }


            System.out.println("[Push Test] Push 구독 정보 확인 완료");
            System.out.println("[Push Test] WebPushService 호출 직전");


            // Push 전송
            int statusCode =
                    webPushService.sendPush(
                            user.getPushEndpoint(),
                            user.getPushP256dh(),
                            user.getPushAuth(),
                            "NUTRI_FIT 테스트",
                            "영양제 복용 알림 테스트입니다."
                    );


            System.out.println("[Push Test] WebPushService 호출 완료");
            System.out.println("[Push Test] Push 응답 코드 = "
                    + statusCode);


            return ResponseEntity.ok(
                    Map.of(
                            "status", "success",
                            "pushStatusCode", statusCode,
                            "message", "Push 전송 요청 완료"
                    )
            );


        } catch (Exception e) {

            e.printStackTrace();

            System.out.println("[Push Test] 예외 발생");
            System.out.println("[Push Test] " + e.getMessage());


            return ResponseEntity.internalServerError().body(
                    Map.of(
                            "status", "error",
                            "message", "Push 전송 실패",
                            "detail", e.getMessage()
                    )
            );
        }
    }
}
