package com.smhrd.entity;

import java.time.LocalDateTime;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "intake_schedules")
@Getter
@Setter
public class IntakeSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "schedule_id")
    private Long scheduleId;

    @Column(name = "user_supplement_id", nullable = false)
    private Long userSupplementId;

    @Column(name = "intake_time", nullable = false)
    private LocalTime intakeTime;

    @Enumerated(EnumType.STRING)
    @Column(name = "meal_relation", nullable = false)
    private MealRelation mealRelation;

    @Column(name = "recommendation", nullable = false, length = 500)
    private String recommendation;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    @Column(name = "created_at",
            insertable = false,
            updatable = false)
    private LocalDateTime createdAt;


    public enum MealRelation {
        BEFORE_MEAL,
        WITH_MEAL,
        AFTER_MEAL,
        ANYTIME
    }
}