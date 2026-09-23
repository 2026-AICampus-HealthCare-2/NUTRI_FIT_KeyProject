package com.smhrd.dto;

import java.time.LocalTime;

import com.smhrd.entity.IntakeSchedule.MealRelation;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class IntakeScheduleDto {

    private Long scheduleId;

    private Long userSupplementId;

    private String productName;

    private String manufacturer;

    private LocalTime intakeTime;

    private MealRelation mealRelation;

    private String recommendation;

    private Boolean isActive;


    // JPQL 생성자
    public IntakeScheduleDto(
            Long scheduleId,
            Long userSupplementId,
            String productName,
            String manufacturer,
            LocalTime intakeTime,
            MealRelation mealRelation,
            String recommendation,
            Boolean isActive) {

        this.scheduleId = scheduleId;
        this.userSupplementId = userSupplementId;
        this.productName = productName;
        this.manufacturer = manufacturer;
        this.intakeTime = intakeTime;
        this.mealRelation = mealRelation;
        this.recommendation = recommendation;
        this.isActive = isActive;
    }
}