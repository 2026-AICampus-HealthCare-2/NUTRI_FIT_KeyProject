package com.smhrd.dto;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class AiSupplementData {

    private Long userSupplementId;

    private Long supplementId;

    private String productName;

    private String manufacturer;

    private BigDecimal dailyDose;

    private String doseUnit;

    private String intakeTime;

    private String mealRelation;

    private String recommendation;
}