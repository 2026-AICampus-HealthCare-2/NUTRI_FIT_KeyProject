package com.smhrd.service;

import java.time.LocalTime;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.smhrd.entity.IntakeSchedule;
import com.smhrd.entity.User;
import com.smhrd.entity.UserSupplement;
import com.smhrd.entity.Supplement;
import com.smhrd.repository.IntakeScheduleRepository;
import com.smhrd.repository.UserRepository;
import com.smhrd.repository.UserSupplementRepository;
import com.smhrd.repository.SupplementRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PushScheduler {

    private final IntakeScheduleRepository intakeScheduleRepository;
    private final UserSupplementRepository userSupplementRepository;
    private final UserRepository userRepository;
    private final SupplementRepository supplementRepository;
    private final WebPushService webPushService;


    // 매 1분마다 실행
    @Scheduled(cron = "0 * * * * *")
    public void sendIntakeNotification() {

        LocalTime now = LocalTime.now();

        int currentHour = now.getHour();
        int currentMinute = now.getMinute();

        System.out.println("=================================");
        System.out.println("[자동 알림 확인]");
        System.out.println("현재 시간 : " + now);
        System.out.println("=================================");


        // 활성화된 모든 복용 일정 조회
        List<IntakeSchedule> scheduleList =
                intakeScheduleRepository.findByIsActiveTrue();


        for (IntakeSchedule schedule : scheduleList) {

            LocalTime intakeTime =
                    schedule.getIntakeTime();


            if (intakeTime == null) {
                continue;
            }


            // 현재 시간과 복용 시간이 같은지 확인
            if (intakeTime.getHour() != currentHour
                    || intakeTime.getMinute() != currentMinute) {

                continue;
            }


            // UserSupplement 조회
            UserSupplement userSupplement =
                    userSupplementRepository
                            .findById(
                                    schedule.getUserSupplementId()
                            )
                            .orElse(null);


            if (userSupplement == null) {

                System.out.println(
                        "UserSupplement를 찾을 수 없습니다. ID : "
                        + schedule.getUserSupplementId()
                );

                continue;
            }


            // 사용자 조회
            User user =
                    userRepository
                            .findById(
                                    userSupplement.getUserId()
                            )
                            .orElse(null);


            if (user == null) {

                System.out.println(
                        "사용자를 찾을 수 없습니다. ID : "
                        + userSupplement.getUserId()
                );

                continue;
            }


            // Push 구독 정보 확인
            if (user.getPushEndpoint() == null
                    || user.getPushP256dh() == null
                    || user.getPushAuth() == null) {

                System.out.println(
                        "Push 구독 정보가 없습니다. 사용자 ID : "
                        + user.getUserIndex()
                );

                continue;
            }


            // 영양제 조회
            Supplement supplement =
                    supplementRepository
                            .findById(
                                    userSupplement.getSupplementId()
                            )
                            .orElse(null);


            if (supplement == null) {

                System.out.println(
                        "영양제를 찾을 수 없습니다. ID : "
                        + userSupplement.getSupplementId()
                );

                continue;
            }


            String supplementName =
                    supplement.getProductName();


            try {

                // Push 전송
                int statusCode =
                        webPushService.sendPush(
                                user.getPushEndpoint(),
                                user.getPushP256dh(),
                                user.getPushAuth(),
                                "NUTRI_FIT 복용 알림",
                                supplementName
                                        + "을(를) 복용할 시간입니다."
                        );


                System.out.println(
                        "[자동 Push 전송 완료]"
                );

                System.out.println(
                        "사용자 ID : "
                        + user.getUserIndex()
                );

                System.out.println(
                        "영양제 : "
                        + supplementName
                );

                System.out.println(
                        "복용 시간 : "
                        + intakeTime
                );

                System.out.println(
                        "Push 상태 코드 : "
                        + statusCode
                );

            } catch (Exception e) {

                System.out.println(
                        "[자동 Push 전송 실패]"
                );

                e.printStackTrace();
            }
        }
    }
}