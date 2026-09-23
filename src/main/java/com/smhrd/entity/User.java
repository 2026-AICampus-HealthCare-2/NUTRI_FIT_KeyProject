package com.smhrd.entity;

import java.time.LocalDateTime;
import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
public class User {

    // 회원 번호
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_index")
    private Long userIndex;


    // 로그인 아이디
    @Column(name = "user_id")
    private String userId;


    // 비밀번호
    @Column(name = "password")
    private String password;


    // 닉네임
    @Column(name = "nickname")
    private String nickname;


    // 기상 시간
    @Column(name = "wake_time")
    private LocalTime wakeTime;


    // 아침 식사 시간
    @Column(name = "breakfast_time")
    private LocalTime breakfastTime;


    // 점심 식사 시간
    @Column(name = "lunch_time")
    private LocalTime lunchTime;


    // 저녁 식사 시간
    @Column(name = "dinner_time")
    private LocalTime dinnerTime;


    // 취침 시간
    @Column(name = "sleep_time")
    private LocalTime sleepTime;
    
    @Column(name = "push_endpoint", columnDefinition = "TEXT")
    private String pushEndpoint;

    @Column(name = "push_p256dh", columnDefinition = "TEXT")
    private String pushP256dh;

    @Column(name = "push_auth", columnDefinition = "TEXT")
    private String pushAuth;

    // 가입일
    @Column(name = "created_at",
            insertable = false,
            updatable = false)
    private LocalDateTime createdAt;
}