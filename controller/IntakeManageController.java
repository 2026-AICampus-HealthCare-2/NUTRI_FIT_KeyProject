package com.smhrd.controller;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.dto.IntakeScheduleDto;
import com.smhrd.entity.IntakeLog;
import com.smhrd.entity.IntakeSchedule;
import com.smhrd.entity.User;
import com.smhrd.entity.UserSupplement;
import com.smhrd.repository.IntakeLogRepository;
import com.smhrd.repository.IntakeScheduleRepository;
import com.smhrd.repository.UserSupplementRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class IntakeManageController {

    private final IntakeScheduleRepository intakeScheduleRepository;

    private final IntakeLogRepository intakeLogRepository;

    private final UserSupplementRepository userSupplementRepository;


    /*
     * =====================================================
     * 복용 관리 페이지
     * =====================================================
     */
    @GetMapping("/intakeManage")
    public String intakeManage(
            HttpSession session,
            Model model) {

        User loginUser =
                (User) session.getAttribute("loginUser");

        /*
         * 로그인하지 않은 경우
         */
        if (loginUser == null) {
            return "redirect:/login";
        }

        Long userId =
                loginUser.getUserIndex();


        /*
         * =================================================
         * 오늘 활성화된 복용 일정
         * =================================================
         *
         * 영양제 이름 / 제조사까지 같이 가져오기 위해
         * DTO 쿼리를 사용
         */
        List<IntakeScheduleDto> scheduleList =
                intakeScheduleRepository
                        .findActiveScheduleDetailsByUserId(userId);


        /*
         * 시간순 정렬
         */
        scheduleList.sort(
                Comparator.comparing(
                        IntakeScheduleDto::getIntakeTime
                )
        );


        /*
         * =================================================
         * 오늘 복용 기록
         * =================================================
         */
        LocalDate today =
                LocalDate.now();

        List<IntakeLog> todayLogList =
                intakeLogRepository
                        .findByIntakeDate(today);


        /*
         * =================================================
         * 오늘 복용 개수
         * =================================================
         */
        int totalCount =
                scheduleList.size();

        int takenCount = 0;

        for (IntakeLog log : todayLogList) {

            if (
                log.getStatus()
                    == IntakeLog.IntakeStatus.TAKEN
            ) {

                /*
                 * 현재 사용자의 일정인지 확인
                 */
                for (IntakeScheduleDto schedule
                        : scheduleList) {

                    if (
                        schedule.getScheduleId()
                            .equals(log.getScheduleId())
                    ) {

                        takenCount++;
                        break;
                    }
                }
            }
        }


        /*
         * =================================================
         * 오늘 복용률
         * =================================================
         */
        int intakeRate = 0;

        if (totalCount > 0) {

            intakeRate =
                    (int) Math.round(
                            (takenCount * 100.0)
                            / totalCount
                    );
        }


        /*
         * =================================================
         * 최근 7일 복용률
         * =================================================
         *
         * 최근 7일 데이터를 가져온 후
         * 월 → 화 → 수 → 목 → 금 → 토 → 일 순서로 정렬
         */
        List<Integer> weeklyRateList =
                createWeeklyRateList(
                        scheduleList,
                        userId
                );


        /*
         * =================================================
         * 등록된 영양제
         * =================================================
         */
        List<UserSupplement> userSupplementList =
                userSupplementRepository
                        .findByUserIdAndIsActiveTrue(userId);


        /*
         * =================================================
         * JSP 전달
         * =================================================
         */
        model.addAttribute(
                "scheduleList",
                scheduleList
        );

        model.addAttribute(
                "todayLogList",
                todayLogList
        );

        model.addAttribute(
                "userSupplementList",
                userSupplementList
        );

        model.addAttribute(
                "totalCount",
                totalCount
        );

        model.addAttribute(
                "takenCount",
                takenCount
        );

        model.addAttribute(
                "intakeRate",
                intakeRate
        );

        model.addAttribute(
                "weeklyRateList",
                weeklyRateList
        );


        return "intakeManage";
    }


    /*
     * =====================================================
     * 최근 7일 복용률 계산
     * =====================================================
     */
    private List<Integer> createWeeklyRateList(
            List<IntakeScheduleDto> scheduleList,
            Long userId) {

        List<Integer> result =
                new ArrayList<>();

        LocalDate today =
                LocalDate.now();


        /*
         * 최근 7일
         *
         * 6일 전 ~ 오늘
         */
        Map<DayOfWeek, Integer> rateMap =
                new HashMap<>();


        for (int i = 0; i < 7; i++) {

            LocalDate date =
                    today.minusDays(6 - i);


            List<IntakeLog> logs =
                    intakeLogRepository
                            .findByIntakeDate(date);


            int taken = 0;


            for (IntakeLog log : logs) {

                if (
                    log.getStatus()
                        == IntakeLog.IntakeStatus.TAKEN
                ) {

                    for (
                        IntakeScheduleDto schedule
                        : scheduleList
                    ) {

                        if (
                            schedule
                                .getScheduleId()
                                .equals(
                                    log.getScheduleId()
                                )
                        ) {

                            taken++;
                            break;
                        }
                    }
                }
            }


            int rate = 0;

            if (!scheduleList.isEmpty()) {

                rate =
                    (int) Math.round(
                        (taken * 100.0)
                        / scheduleList.size()
                    );
            }


            rateMap.put(
                    date.getDayOfWeek(),
                    rate
            );
        }


        /*
         * 월 → 화 → 수 → 목 → 금 → 토 → 일
         */
        DayOfWeek[] days = {

            DayOfWeek.MONDAY,
            DayOfWeek.TUESDAY,
            DayOfWeek.WEDNESDAY,
            DayOfWeek.THURSDAY,
            DayOfWeek.FRIDAY,
            DayOfWeek.SATURDAY,
            DayOfWeek.SUNDAY

        };


        for (DayOfWeek day : days) {

            result.add(
                    rateMap.getOrDefault(
                            day,
                            0
                    )
            );
        }


        return result;
    }


    /*
     * =====================================================
     * 복용 완료
     * =====================================================
     */
    @PostMapping("/intakeManage/take")
    public String takeSupplement(
            @RequestParam("scheduleId") Long scheduleId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loginUser =
                (User) session.getAttribute("loginUser");

        /*
         * 로그인 확인
         */
        if (loginUser == null) {
            return "redirect:/login";
        }


        try {

            /*
             * 일정 찾기
             */
            IntakeSchedule schedule =
                    intakeScheduleRepository
                            .findById(scheduleId)
                            .orElse(null);


            if (schedule == null) {

                redirectAttributes.addFlashAttribute(
                        "message",
                        "복용 일정을 찾을 수 없습니다."
                );

                return "redirect:/intakeManage";
            }


            /*
             * 해당 일정이 현재 로그인한 사용자의 것인지 확인
             */
            UserSupplement userSupplement =
                    userSupplementRepository
                            .findById(
                                    schedule
                                        .getUserSupplementId()
                            )
                            .orElse(null);


            if (
                userSupplement == null
                ||
                !userSupplement
                    .getUserId()
                    .equals(
                        loginUser.getUserIndex()
                    )
            ) {

                redirectAttributes.addFlashAttribute(
                        "message",
                        "잘못된 복용 일정입니다."
                );

                return "redirect:/intakeManage";
            }


            /*
             * 오늘 날짜
             */
            LocalDate today =
                    LocalDate.now();


            /*
             * 오늘 이미 복용했는지 확인
             */
            var existingLog =
                    intakeLogRepository
                            .findByScheduleIdAndIntakeDate(
                                    scheduleId,
                                    today
                            );


            /*
             * 이미 복용 완료
             */
            if (
                existingLog.isPresent()
                &&
                existingLog
                    .get()
                    .getStatus()
                    ==
                    IntakeLog.IntakeStatus.TAKEN
            ) {

                redirectAttributes.addFlashAttribute(
                        "message",
                        "오늘은 이미 복용 완료 처리되었습니다."
                );

                return "redirect:/intakeManage";
            }


            IntakeLog intakeLog;


            /*
             * 기존 기록이 있으면 업데이트
             */
            if (existingLog.isPresent()) {

                intakeLog =
                        existingLog.get();

            }

            /*
             * 기록이 없으면 새로 생성
             */
            else {

                intakeLog =
                        new IntakeLog();

                intakeLog.setScheduleId(
                        scheduleId
                );

                intakeLog.setIntakeDate(
                        today
                );

                intakeLog.setScheduledTime(
                        schedule.getIntakeTime()
                );
            }


            /*
             * 복용 완료 처리
             */
            intakeLog.setTakenAt(
                    LocalDateTime.now()
            );

            intakeLog.setStatus(
                    IntakeLog.IntakeStatus.TAKEN
            );


            intakeLogRepository.save(
                    intakeLog
            );


            redirectAttributes.addFlashAttribute(
                    "message",
                    "복용 완료 처리되었습니다."
            );

        }

        catch (Exception e) {

            e.printStackTrace();

            redirectAttributes.addFlashAttribute(
                    "message",
                    "복용 완료 처리 중 오류가 발생했습니다."
            );
        }


        return "redirect:/intakeManage";
    }
}