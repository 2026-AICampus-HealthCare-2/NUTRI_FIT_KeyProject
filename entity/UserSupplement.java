package com.smhrd.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_supplements")
@Getter
@Setter
public class UserSupplement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_supplement_id")
    private Long userSupplementId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "supplement_id", nullable = false)
    private Long supplementId;

    @Column(name = "daily_dose", nullable = false)
    private BigDecimal dailyDose;

    @Column(name = "dose_unit", nullable = false, length = 20)
    private String doseUnit;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive;

    @Column(name = "registered_at", nullable = false)
    private LocalDateTime registeredAt;
}