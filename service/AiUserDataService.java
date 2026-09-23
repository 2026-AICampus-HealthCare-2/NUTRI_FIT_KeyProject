package com.smhrd.service;

import com.smhrd.dto.AiSupplementData;
import com.smhrd.dto.AiUserData;
import com.smhrd.entity.IntakeSchedule;
import com.smhrd.entity.Supplement;
import com.smhrd.entity.User;
import com.smhrd.entity.UserSupplement;
import com.smhrd.repository.IntakeScheduleRepository;
import com.smhrd.repository.SupplementRepository;
import com.smhrd.repository.UserRepository;
import com.smhrd.repository.UserSupplementRepository;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AiUserDataService {

    private final UserRepository userRepository;
    private final UserSupplementRepository userSupplementRepository;
    private final SupplementRepository supplementRepository;
    private final IntakeScheduleRepository intakeScheduleRepository;

    public AiUserDataService(
            UserRepository userRepository,
            UserSupplementRepository userSupplementRepository,
            SupplementRepository supplementRepository,
            IntakeScheduleRepository intakeScheduleRepository
    ) {
        this.userRepository = userRepository;
        this.userSupplementRepository = userSupplementRepository;
        this.supplementRepository = supplementRepository;
        this.intakeScheduleRepository = intakeScheduleRepository;
    }

    public AiUserData getUserData(Long userId) {

        User user = userRepository.findById(userId)
                .orElseThrow(() ->
                        new RuntimeException("사용자를 찾을 수 없습니다.")
                );

        List<UserSupplement> userSupplements =
                userSupplementRepository
                        .findByUserIdAndIsActiveTrue(userId);

        List<AiSupplementData> supplementData =
                new ArrayList<>();

        for (UserSupplement us : userSupplements) {

            Supplement supplement =
                    supplementRepository
                            .findById(us.getSupplementId())
                            .orElseThrow(() ->
                                    new RuntimeException(
                                            "영양제를 찾을 수 없습니다."
                                    )
                            );

            List<IntakeSchedule> schedules =
                    intakeScheduleRepository
                            .findByUserSupplementIdAndIsActiveTrue(
                                    us.getUserSupplementId()
                            );

            for (IntakeSchedule schedule : schedules) {

                AiSupplementData data =
                        new AiSupplementData();

                data.setUserSupplementId(
                        us.getUserSupplementId()
                );

                data.setSupplementId(
                        supplement.getSupplementId()
                );

                data.setProductName(
                        supplement.getProductName()
                );

                data.setManufacturer(
                        supplement.getManufacturer()
                );

                data.setDailyDose(
                        us.getDailyDose()
                );

                data.setDoseUnit(
                        us.getDoseUnit()
                );

                data.setIntakeTime(
                        schedule.getIntakeTime().toString()
                );

                data.setMealRelation(
                        schedule.getMealRelation().name()
                );

                data.setRecommendation(
                        schedule.getRecommendation()
                );

                supplementData.add(data);
            }
        }

        AiUserData result = new AiUserData();

        result.setUserId(userId);
        result.setWakeUp(user.getWakeTime().toString());
        result.setBreakfast(user.getBreakfastTime().toString());
        result.setLunch(user.getLunchTime().toString());
        result.setDinner(user.getDinnerTime().toString());
        result.setBedtime(user.getSleepTime().toString());
        result.setSupplements(supplementData);

        return result;
    }
}