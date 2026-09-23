<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smhrd.entity.User" %>
<%@ page import="com.smhrd.entity.IntakeLog" %>
<%@ page import="com.smhrd.dto.IntakeScheduleDto" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>복용 관리 - NUTRI_FIT</title>

<link rel="manifest"
      href="${pageContext.request.contextPath}/manifest.json">

<link rel="icon"
      type="image/png"
      href="${pageContext.request.contextPath}/images/nutriFitIcon.png">


<style>

/* =====================================================
   기본
===================================================== */

* {
    box-sizing: border-box;
}

html {
    margin: 0;
    padding: 0;
}

body {
    margin: 0;
    padding-top: 70px !important;
    font-family: Arial, sans-serif;
    color: #333;
    background-color: #f8faf8;
}


/* =====================================================
   HEADER
===================================================== */

header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 70px;
    background-color: white;
    border-bottom: 1px solid #eee;
    z-index: 9999;
}


/* 로고 */

.logo {
    position: absolute;
    left: 60px;
    top: 50%;
    transform: translateY(-50%);
}

.logo a {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    color: #4CAF50;
    font-size: 30px;
    font-weight: bold;
}

.logo img {
    width: 55px;
    height: 55px;
    object-fit: contain;
}


/* PC 메뉴 */

nav {
    position: absolute;
    right: 350px;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    align-items: center;
    gap: 35px;
    margin: 0;
    padding: 0;
}

nav a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
    font-weight: bold;
    white-space: nowrap;
}

nav a:hover {
    color: #4CAF50;
}

nav a.active {
    color: #4CAF50;
}


/* 로그인 / 로그아웃 */

.login-btn,
.logout-btn {
    position: absolute;
    right: 60px;
    top: 50%;
    transform: translateY(-50%);
    width: 102px;
    height: 46px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #4CAF50;
    border-radius: 8px;
    background-color: white;
    color: #4CAF50;
    font-size: 16px;
    font-weight: bold;
    text-decoration: none;
    cursor: pointer;
}


/* 사용자 */

.user-welcome {
    position: absolute;
    right: 180px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 15px;
    font-weight: bold;
    white-space: nowrap;
}

.nickname {
    color: #2196F3;
}


/* =====================================================
   모바일 메뉴
===================================================== */

.mobile-menu-btn {
    display: none;
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    width: 42px;
    height: 42px;
    border: none;
    border-radius: 8px;
    background: white;
    font-size: 28px;
    color: #333;
    cursor: pointer;
    align-items: center;
    justify-content: center;
}

.mobile-nav {
    display: none;
    position: absolute;
    top: 70px;
    left: 0;
    width: 100%;
    background-color: white;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #ddd;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    padding: 10px 15px;
}

.mobile-nav a {
    display: block;
    width: 100%;
    padding: 15px 10px;
    text-decoration: none;
    color: #333;
    font-size: 15px;
    font-weight: bold;
    border-bottom: 1px solid #f1f1f1;
}

.mobile-nav a:hover {
    color: #4CAF50;
    background-color: #f7faf7;
}

.mobile-nav a.active {
    color: #4CAF50;
}


/* =====================================================
   MAIN
===================================================== */

main {
    width: 100%;
    max-width: 1000px;
    margin: 0 auto;
    padding: 40px 20px 80px;
}


/* 페이지 제목 */

.page-title {
    margin-bottom: 30px;
}

.page-title h1 {
    margin: 0 0 8px;
    font-size: 32px;
    color: #222;
}

.page-title p {
    margin: 0;
    color: #777;
    font-size: 15px;
}


/* =====================================================
   공통 카드
===================================================== */

.summary-card,
.next-card,
.schedule-card,
.weekly-card {
    background-color: white;
    border-radius: 15px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
}


/* =====================================================
   오늘 복용 현황
===================================================== */

.summary-card {
    padding: 30px;
    margin-bottom: 25px;
}

.summary-title {
    margin-bottom: 25px;
    font-size: 20px;
    font-weight: bold;
}

.summary-content {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 50px;
}


/* 원형 그래프 */

.progress-area {
    position: relative;
    width: 150px;
    height: 150px;
    flex-shrink: 0;
    border-radius: 50%;
    background:
        conic-gradient(
            #4CAF50 var(--progress),
            #e8eee8 0deg
        );
    display: flex;
    align-items: center;
    justify-content: center;
}

.progress-area::before {
    content: "";
    position: absolute;
    width: 115px;
    height: 115px;
    border-radius: 50%;
    background-color: white;
}

.progress-inner {
    position: relative;
    z-index: 1;
    text-align: center;
}

.progress-number {
    font-size: 22px;
    font-weight: bold;
    color: #333;
}

.progress-text {
    margin-top: 5px;
    font-size: 13px;
    color: #777;
}


/* 설명 */

.summary-info {
    min-width: 300px;
}

.summary-info h3 {
    margin: 0 0 10px;
    font-size: 22px;
}

.summary-info p {
    margin: 7px 0;
    color: #777;
    line-height: 1.6;
}

.summary-info strong {
    color: #4CAF50;
}


/* =====================================================
   다음 복용
===================================================== */

.next-card {
    padding: 25px 30px;
    margin-bottom: 25px;
}

.next-title {
    margin-bottom: 12px;
    font-size: 18px;
    font-weight: bold;
}

.next-time {
    display: inline-block;
    margin-bottom: 6px;
    font-size: 25px;
    font-weight: bold;
    color: #4CAF50;
}

.next-name {
    margin-bottom: 7px;
    font-size: 18px;
    font-weight: bold;
    color: #222;
}

.next-relation {
    display: inline-block;
    padding: 5px 9px;
    border-radius: 5px;
    background-color: #e8f5e9;
    color: #4CAF50;
    font-size: 12px;
    font-weight: bold;
}

.next-warning {
    display: inline-block;
    margin-top: 10px;
    padding: 7px 10px;
    border-radius: 6px;
    background-color: #fff0f0;
    color: #d32f2f;
    font-size: 13px;
    font-weight: bold;
}


/* 시간이 지난 다음 일정 */

.next-card.overdue {
    border: 2px solid #d32f2f;
    background-color: #fffafa;
}

.next-card.overdue .next-title {
    color: #d32f2f;
}

.next-card.overdue .next-time {
    color: #c62828;
}


/* =====================================================
   복용 일정
===================================================== */

.schedule-card {
    padding: 30px;
    margin-bottom: 25px;
}

.schedule-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    margin-bottom: 20px;
}

.schedule-title {
    font-size: 20px;
    font-weight: bold;
}


/* =====================================================
   알림 버튼
===================================================== */

.notification-btn {
    border: none;
    border-radius: 8px;
    background-color: #4CAF50;
    color: white;
    padding: 9px 14px;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
    white-space: nowrap;
}

.notification-btn:hover {
    background-color: #43a047;
}


/* 알림 허용 상태 */

.notification-btn.enabled {
    background-color: #e8f5e9;
    color: #4CAF50;
    border: 1px solid #4CAF50;
    cursor: pointer;
}


/* 알림 해제 상태 */

.notification-btn.disabled-state {
    background-color: #f5f5f5;
    color: #666;
    border: 1px solid #ccc;
}


/* 일정 목록 */

.schedule-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}


/* 일정 하나 */

.schedule-item {
    display: grid;
    grid-template-columns: 80px 1fr auto;
    align-items: center;
    gap: 15px;
    padding: 18px 20px;
    border: 1px solid #e5e5e5;
    border-radius: 12px;
    background-color: white;
    transition: 0.2s;
}


/* 시간이 지난 일정 */

.schedule-item.overdue {
    border: 1px solid #e53935;
    background-color: #fff8f8;
}

.schedule-item.overdue .schedule-time {
    color: #c62828;
}

.schedule-item.overdue .schedule-product {
    color: #8e0000;
}


/* 복용 완료 일정 */

.schedule-item.completed {
    opacity: 0.65;
    background-color: #fafafa;
}


/* 시간 */

.schedule-time {
    font-size: 20px;
    font-weight: bold;
    color: #4CAF50;
}


/* 영양제 */

.schedule-product {
    font-size: 16px;
    font-weight: bold;
    color: #333;
}

.schedule-manufacturer {
    margin-top: 4px;
    font-size: 13px;
    color: #888;
}


/* 식사 관계 */

.schedule-meal {
    display: inline-block;
    width: fit-content;
    padding: 6px 10px;
    border-radius: 6px;
    background-color: #e8f5e9;
    color: #4CAF50;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}


/* 추천 이유 */

.schedule-reason {
    grid-column: 2 / 4;
    padding-top: 10px;
    border-top: 1px solid #f0f0f0;
    color: #777;
    font-size: 13px;
    line-height: 1.5;
}


/* 복용 버튼 */

.take-form {
    grid-column: 1 / 4;
    margin-top: 3px;
}

.take-button {
    display: inline-block;
    width: 110px;
    padding: 9px 15px;
    border: none;
    border-radius: 7px;
    background-color: #4CAF50;
    color: white;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
}

.take-button:hover {
    background-color: #43a047;
}

.take-button.completed {
    background-color: #aaa;
    cursor: default;
}


/* 비어있을 때 */

.empty-schedule {
    padding: 40px 20px;
    text-align: center;
    color: #999;
    font-size: 14px;
}


/* =====================================================
   최근 7일
===================================================== */

.weekly-card {
    padding: 30px;
    margin-bottom: 25px;
}

.weekly-title {
    margin-bottom: 25px;
    font-size: 20px;
    font-weight: bold;
}

.week-row {
    display: grid;
    grid-template-columns: 40px 1fr 50px;
    align-items: center;
    gap: 12px;
    margin-bottom: 15px;
}

.week-day {
    font-size: 14px;
    font-weight: bold;
    color: #555;
}

.week-bar {
    width: 100%;
    height: 10px;
    overflow: hidden;
    border-radius: 10px;
    background-color: #edf1ed;
}

.week-progress {
    height: 100%;
    border-radius: 10px;
    background-color: #4CAF50;
    transition: width 0.3s ease;
}

.week-percent {
    text-align: right;
    font-size: 13px;
    color: #777;
}


/* =====================================================
   FOOTER
===================================================== */

footer {
    width: 100%;
    padding: 40px 20px;
    text-align: center;
    background-color: #333;
    color: white;
}

footer strong {
    display: block;
    margin-bottom: 8px;
    font-size: 18px;
}

footer p {
    margin: 5px 0;
    font-size: 13px;
    color: #ccc;
}


/* =====================================================
   TABLET
===================================================== */

@media (max-width: 950px) {

    .logo {
        left: 15px;
    }

    .logo a {
        font-size: 24px;
    }

    .logo img {
        width: 42px;
        height: 42px;
    }

    nav {
        right: 230px;
        gap: 20px;
    }

    nav a {
        font-size: 14px;
    }

    .login-btn,
    .logout-btn {
        right: 25px;
    }

    .user-welcome {
        display: none;
    }
}


/* =====================================================
   MOBILE
===================================================== */

@media (max-width: 768px) {

    header {
        height: 70px;
    }

    nav {
        display: none;
    }

    .login-btn,
    .logout-btn,
    .user-welcome {
        display: none;
    }

    .mobile-menu-btn {
        display: flex;
    }

    main {
        padding: 25px 15px 60px;
    }

    .page-title {
        margin-bottom: 20px;
    }

    .page-title h1 {
        font-size: 26px;
    }

    .summary-card {
        padding: 22px 18px;
    }

    .summary-content {
        flex-direction: column;
        gap: 25px;
    }

    .summary-info {
        width: 100%;
        min-width: 0;
        text-align: center;
    }

    .next-card {
        padding: 20px;
    }

    .schedule-card {
        padding: 20px 18px;
    }

    .schedule-header {
        align-items: flex-start;
        flex-direction: column;
        gap: 12px;
    }

    .notification-btn {
        width: auto;
    }

    .schedule-item {
        grid-template-columns: 1fr auto;
        gap: 12px;
    }

    .schedule-time {
        grid-column: 1;
        grid-row: 1;
    }

    .schedule-meal {
        grid-column: 2;
        grid-row: 1;
    }

    .schedule-info {
        grid-column: 1 / 3;
        grid-row: 2;
    }

    .schedule-reason {
        grid-column: 1 / 3;
    }

    .take-form {
        grid-column: 1 / 3;
    }

    .take-button {
        width: 110px;
    }

    .weekly-card {
        padding: 20px 18px;
    }

    .weekly-title {
        font-size: 18px;
    }
}


/* =====================================================
   작은 모바일
===================================================== */

@media (max-width: 480px) {

    .logo a {
        font-size: 22px;
    }

    .logo img {
        width: 38px;
        height: 38px;
    }

    .mobile-menu-btn {
        right: 8px;
    }
}

</style>

</head>


<body>


<!-- =====================================================
     HEADER
===================================================== -->

<header>


    <!-- 로고 -->

    <div class="logo">

        <a href="${pageContext.request.contextPath}/main">

            <img
                src="${pageContext.request.contextPath}/images/nutriFitIcon.png"
                alt="NUTRI_FIT 아이콘">

            <span>
                NUTRI_FIT
            </span>

        </a>

    </div>


    <!-- PC 메뉴 -->

    <nav>

        <a
            href="${pageContext.request.contextPath}/aiAnalysis">

            영양제 분석

        </a>


        <a
            href="${pageContext.request.contextPath}/mySupplement">

            내 영양제

        </a>


        <a
            href="${pageContext.request.contextPath}/intakeManage"
            class="active">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage">

            마이페이지

        </a>

    </nav>


<%

User loginUser =
    (User) session.getAttribute("loginUser");

%>


    <!-- 로그인 -->

<%

if (loginUser == null) {

%>

    <a
        href="${pageContext.request.contextPath}/login"
        class="login-btn">

        로그인

    </a>

<%

} else {

%>

    <div class="user-welcome">

        <span class="nickname">

            <%= loginUser.getNickname() %>

        </span>

        님 환영합니다.

    </div>


    <a
        href="${pageContext.request.contextPath}/logout"
        class="logout-btn">

        로그아웃

    </a>

<%

}

%>


    <!-- 모바일 메뉴 버튼 -->

    <button
        type="button"
        class="mobile-menu-btn"
        id="mobileMenuBtn"
        onclick="toggleMobileMenu()">

        ☰

    </button>


    <!-- 모바일 메뉴 -->

    <div
        class="mobile-nav"
        id="mobileNav">


        <a
            href="${pageContext.request.contextPath}/aiAnalysis">

            영양제 분석

        </a>


        <a
            href="${pageContext.request.contextPath}/mySupplement">

            내 영양제

        </a>


        <a
            href="${pageContext.request.contextPath}/intakeManage"
            class="active">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage">

            마이페이지

        </a>


<%

if (loginUser == null) {

%>

        <a
            href="${pageContext.request.contextPath}/login">

            로그인

        </a>

<%

} else {

%>

        <a
            href="${pageContext.request.contextPath}/logout">

            로그아웃

        </a>

<%

}

%>

    </div>

</header>




<main>


<%

/* =====================================================
   Controller 데이터
===================================================== */

List<IntakeScheduleDto> scheduleList =
    (List<IntakeScheduleDto>)
    request.getAttribute("scheduleList");

List<IntakeLog> todayLogList =
    (List<IntakeLog>)
    request.getAttribute("todayLogList");

List<Integer> weeklyRateList =
    (List<Integer>)
    request.getAttribute("weeklyRateList");

Integer totalCount =
    (Integer)
    request.getAttribute("totalCount");

Integer takenCount =
    (Integer)
    request.getAttribute("takenCount");

Integer intakeRate =
    (Integer)
    request.getAttribute("intakeRate");


if (scheduleList == null) {

    scheduleList =
        new java.util.ArrayList<IntakeScheduleDto>();

}

if (todayLogList == null) {

    todayLogList =
        new java.util.ArrayList<IntakeLog>();

}

if (weeklyRateList == null) {

    weeklyRateList =
        new java.util.ArrayList<Integer>();

}

if (totalCount == null) {

    totalCount = 0;

}

if (takenCount == null) {

    takenCount = 0;

}

if (intakeRate == null) {

    intakeRate = 0;

}


/* =====================================================
   현재 시간
===================================================== */

LocalTime now =
    LocalTime.now();


/* =====================================================
   다음 복용 / 지난 복용 계산
===================================================== */

IntakeScheduleDto nextSchedule =
    null;

IntakeScheduleDto overdueSchedule =
    null;


for (
    IntakeScheduleDto schedule
    : scheduleList
) {

    boolean taken =
        false;


    for (
        IntakeLog log
        : todayLogList
    ) {

        if (
            log.getScheduleId()
                .equals(
                    schedule.getScheduleId()
                )
            &&
            log.getStatus()
                ==
                IntakeLog.IntakeStatus.TAKEN
        ) {

            taken = true;
            break;

        }

    }


    /*
     * 이미 복용한 일정은 다음 일정에서 제외
     */

    if (taken) {

        continue;

    }


    LocalTime scheduleTime =
        schedule.getIntakeTime();


    /*
     * 시간이 지난 일정
     */

    if (
        scheduleTime.isBefore(now)
    ) {

        if (overdueSchedule == null) {

            overdueSchedule =
                schedule;

        }

        continue;

    }


    /*
     * 아직 시간이 안 된 일정
     */

    if (nextSchedule == null) {

        nextSchedule =
            schedule;

    }

}

%>


<!-- =====================================================
     페이지 제목
===================================================== -->

<div class="page-title">

    <h1>
        복용 관리
    </h1>

    <p>
        오늘의 영양제 복용 일정을 확인하고 관리하세요.
    </p>

</div>




<!-- =====================================================
     오늘 복용 현황
===================================================== -->

<div class="summary-card">

    <div class="summary-title">

        오늘의 복용 현황

    </div>


    <div class="summary-content">


        <!-- 원형 그래프 -->

        <div
            class="progress-area"
            id="progressArea"
            style="--progress:<%= intakeRate * 3.6 %>deg;">

            <div class="progress-inner">

                <div class="progress-number">

                    <span id="completedCount">
                        <%= takenCount %>
                    </span>

                    /

                    <span id="totalCount">
                        <%= totalCount %>
                    </span>

                </div>

                <div class="progress-text">
                    복용 완료
                </div>

            </div>

        </div>


        <!-- 복용률 -->

        <div class="summary-info">

            <h3>
                오늘의 복용률
            </h3>


            <p>

                오늘 예정된 영양제 중

                <strong id="percent">
                    <%= intakeRate %>%
                </strong>

                를 복용했습니다.

            </p>


            <p id="summaryMessage">

<%

if (totalCount == 0) {

%>

                오늘 예정된 복용 일정이 없습니다.

<%

}

else if (takenCount >= totalCount) {

%>

                오늘 예정된 영양제를 모두 복용했습니다.

<%

}

else {

%>

                아직 복용하지 않은 영양제가

                <%= totalCount - takenCount %>개 있습니다.

<%

}

%>

            </p>

        </div>

    </div>

</div>




<!-- =====================================================
     다음 복용
===================================================== -->

<div
    class="next-card
<%

if (overdueSchedule != null) {

%>
 overdue
<%

}

%>"
    id="nextCard">


<%

/*
 * 일정 자체가 없는 경우
 */

if (scheduleList.isEmpty()) {

%>

    <div class="next-title">

        복용 일정 없음

    </div>


    <div class="next-name">

        등록된 영양제가 없습니다.

    </div>


    <div class="next-relation">

        내 영양제에서 영양제를 등록해주세요.

    </div>

<%

}

/*
 * 시간이 지난 미복용 일정이 있는 경우
 */

else if (overdueSchedule != null) {

%>

    <div class="next-title">

        ⚠ 아직 복용하지 않았습니다.

    </div>


    <div class="next-time">

        <%= overdueSchedule.getIntakeTime()
                .toString()
                .substring(0, 5) %>

    </div>


    <div class="next-name">

        <%= overdueSchedule.getProductName() %>

    </div>


    <div class="next-relation">

<%

    switch (
        overdueSchedule.getMealRelation()
    ) {

        case BEFORE_MEAL:

%>

        식사 전

<%

        break;

        case WITH_MEAL:

%>

        식사 중

<%

        break;

        case AFTER_MEAL:

%>

        식사 후

<%

        break;

        default:

%>

        시간 관계없음

<%

        break;

    }

%>

    </div>


    <div class="next-warning">

        예정 시간이 지났습니다.
        복용 여부를 확인해주세요.

    </div>

<%

}

/*
 * 다음 미래 일정이 있는 경우
 */

else if (nextSchedule != null) {

%>

    <div class="next-title">

        다음 복용 예정

    </div>


    <div class="next-time">

        <%= nextSchedule.getIntakeTime()
                .toString()
                .substring(0, 5) %>

    </div>


    <div class="next-name">

        <%= nextSchedule.getProductName() %>

    </div>


    <div class="next-relation">

<%

    switch (
        nextSchedule.getMealRelation()
    ) {

        case BEFORE_MEAL:

%>

        식사 전

<%

        break;

        case WITH_MEAL:

%>

        식사 중

<%

        break;

        case AFTER_MEAL:

%>

        식사 후

<%

        break;

        default:

%>

        시간 관계없음

<%

        break;

    }

%>

    </div>

<%

}

/*
 * 오늘 모든 일정 완료
 */

else {

%>

    <div class="next-title">

        오늘의 복용 완료

    </div>


    <div class="next-name">

        오늘 예정된 영양제를 모두 복용했습니다.

    </div>

<%

}

%>

</div>




<!-- =====================================================
     오늘의 복용 일정
===================================================== -->

<div class="schedule-card">


    <div class="schedule-header">

        <div class="schedule-title">

            오늘의 복용 일정

        </div>


        <!-- 알림 버튼 -->

        <button
            type="button"
            class="notification-btn"
            id="notificationBtn">

            🔔 알림 허용

        </button>

    </div>




<%

if (scheduleList.isEmpty()) {

%>

    <div class="empty-schedule">

        오늘 예정된 복용 일정이 없습니다.

    </div>

<%

}

else {

%>

    <div class="schedule-list">


<%

for (
    IntakeScheduleDto schedule
    : scheduleList
) {

    boolean isTaken =
        false;


    for (
        IntakeLog log
        : todayLogList
    ) {

        if (
            log.getScheduleId()
                .equals(
                    schedule.getScheduleId()
                )
            &&
            log.getStatus()
                ==
                IntakeLog.IntakeStatus.TAKEN
        ) {

            isTaken = true;
            break;

        }

    }


    boolean isOverdue =
        !isTaken
        &&
        schedule
            .getIntakeTime()
            .isBefore(now);


    String mealText;


    switch (
        schedule.getMealRelation()
    ) {

        case BEFORE_MEAL:

            mealText = "식사 전";
            break;

        case WITH_MEAL:

            mealText = "식사 중";
            break;

        case AFTER_MEAL:

            mealText = "식사 후";
            break;

        default:

            mealText = "시간 관계없음";
            break;

    }

%>


        <div
            class="schedule-item
<%

if (isOverdue) {

%>
 overdue
<%

}

if (isTaken) {

%>
 completed
<%

}

%>"
            data-schedule-id="<%= schedule.getScheduleId() %>">


            <!-- 복용 시간 -->

            <div class="schedule-time">

                <%= schedule.getIntakeTime()
                        .toString()
                        .substring(0, 5) %>

            </div>


            <!-- 영양제 정보 -->

            <div class="schedule-info">

                <div class="schedule-product">

                    <%= schedule.getProductName() %>

                </div>

                <div class="schedule-manufacturer">

                    <%= schedule.getManufacturer() %>

                </div>

            </div>


            <!-- 식사 관계 -->

            <div class="schedule-meal">

                <%= mealText %>

            </div>


            <!-- 추천 이유 -->

            <div class="schedule-reason">

                <%= schedule.getRecommendation() %>

            </div>


            <!-- 복용 완료 -->

            <form
                action="${pageContext.request.contextPath}/intakeManage/take"
                method="post"
                class="take-form">


                <input
                    type="hidden"
                    name="scheduleId"
                    value="<%= schedule.getScheduleId() %>">


                <button
                    type="submit"
                    class="take-button
<%

if (isTaken) {

%>
 completed
<%

}

%>"
<%

if (isTaken) {

%>
                    disabled
<%

}

%>
                >

<%

if (isTaken) {

%>

                    복용 완료 ✓

<%

}

else {

%>

                    복용 완료

<%

}

%>

                </button>

            </form>

        </div>


<%

}

%>

    </div>

<%

}

%>

</div>




<!-- =====================================================
     최근 7일 복용 기록
===================================================== -->

<div class="weekly-card">


    <div class="weekly-title">

        최근 7일 복용률

    </div>


<%

String[] dayNames = {
    "월",
    "화",
    "수",
    "목",
    "금",
    "토",
    "일"
};


for (
    int i = 0;
    i < 7;
    i++
) {

    int rate = 0;


    if (
        weeklyRateList.size() > i
        &&
        weeklyRateList.get(i) != null
    ) {

        rate =
            weeklyRateList.get(i);

    }

%>


    <div class="week-row">


        <div class="week-day">

            <%= dayNames[i] %>

        </div>


        <div class="week-bar">

            <div
                class="week-progress"
                style="width:<%= rate %>%;">
            </div>

        </div>


        <div class="week-percent">

            <%= rate %>%

        </div>

    </div>


<%

}

%>

</div>


</main>




<!-- =====================================================
     FOOTER
===================================================== -->

<footer>

    <strong>
        NUTRI_FIT
    </strong>

    <p>
        나에게 맞는 영양제 복용 관리 서비스
    </p>

    <p>
        © 2026 NUTRI_FIT
    </p>

</footer>




<!-- =====================================================
     JAVASCRIPT
===================================================== -->

<script>


/* =====================================================
   모바일 메뉴
===================================================== */

function toggleMobileMenu() {

    var mobileNav =
        document.getElementById("mobileNav");

    var menuButton =
        document.getElementById("mobileMenuBtn");


    if (
        mobileNav.style.display === "block"
    ) {

        mobileNav.style.display = "none";

        menuButton.textContent = "☰";

        menuButton.setAttribute(
            "aria-label",
            "메뉴 열기"
        );

    }

    else {

        mobileNav.style.display = "block";

        menuButton.textContent = "✕";

        menuButton.setAttribute(
            "aria-label",
            "메뉴 닫기"
        );

    }
}



/* =====================================================
   VAPID 공개키
===================================================== */

const VAPID_PUBLIC_KEY =
    "BH5GKGd8KdR1Ks80OHZEJHFV49Xoj4DQpmRNcpAnIYuJme0UyMCcJfQz57HuhYNIsqUjyAmYB2vZ2BglsIAH0MU";



/* =====================================================
   알림 버튼 상태 변경
===================================================== */

function setNotificationButton(
    subscribed
) {

    const button =
        document.getElementById(
            "notificationBtn"
        );


    if (!button) {
        return;
    }


    if (subscribed) {

        button.textContent =
            "🔕 알림 해제";

        button.classList.add(
            "enabled"
        );

        button.classList.remove(
            "disabled-state"
        );

    }

    else {

        button.textContent =
            "🔔 알림 허용";

        button.classList.remove(
            "enabled"
        );

        button.classList.add(
            "disabled-state"
        );

    }
}



/* =====================================================
   현재 Push 구독 상태 확인
===================================================== */

async function checkNotificationStatus() {

    const button =
        document.getElementById(
            "notificationBtn"
        );


    if (!button) {
        return;
    }


    if (
        !("serviceWorker" in navigator)
        ||
        !("PushManager" in window)
    ) {

        button.textContent =
            "🔔 알림 허용";

        return;
    }


    try {

        const registration =
            await navigator
                .serviceWorker
                .ready;


        const subscription =
            await registration
                .pushManager
                .getSubscription();


        if (subscription) {

            setNotificationButton(true);

        }

        else {

            setNotificationButton(false);

        }

    }

    catch (error) {

        console.error(
            "Push 구독 상태 확인 실패:",
            error
        );

        setNotificationButton(false);

    }

}



/* =====================================================
   알림 허용
===================================================== */

async function enableNotification() {

    if (
        !("Notification" in window)
    ) {

        alert(
            "이 브라우저는 알림 기능을 지원하지 않습니다."
        );

        return;

    }


    if (
        !("serviceWorker" in navigator)
    ) {

        alert(
            "이 브라우저는 Service Worker를 지원하지 않습니다."
        );

        return;

    }


    if (
        !("PushManager" in window)
    ) {

        alert(
            "이 브라우저는 Push 알림을 지원하지 않습니다."
        );

        return;

    }


    try {


        /* 알림 권한 요청 */

        const permission =
            await Notification.requestPermission();


        if (
            permission !== "granted"
        ) {

            if (
                permission === "denied"
            ) {

                alert(
                    "알림 권한이 거부되었습니다.\n\n"
                    +
                    "브라우저 설정에서 NUTRI_FIT의 알림 권한을 허용해주세요."
                );

            }

            else {

                alert(
                    "알림 권한이 허용되지 않았습니다."
                );

            }

            return;

        }


        /* Service Worker */

        const registration =
            await navigator
                .serviceWorker
                .ready;


        /* 기존 구독 확인 */

        let subscription =
            await registration
                .pushManager
                .getSubscription();


        /*
         * 기존 구독이 없다면 새로 생성
         */

        if (!subscription) {

            const applicationServerKey =
                urlBase64ToUint8Array(
                    VAPID_PUBLIC_KEY
                );


            subscription =
                await registration
                    .pushManager
                    .subscribe({

                        userVisibleOnly: true,

                        applicationServerKey:
                            applicationServerKey

                    });

        }


        /* Push 구독 정보 */

        const subscriptionData =
            subscription.toJSON();


        /* Spring 서버에 저장 */

        const response =
            await fetch(
                "${pageContext.request.contextPath}/push/subscribe",
                {

                    method: "POST",

                    headers: {
                        "Content-Type":
                            "application/json"
                    },

                    body:
                        JSON.stringify({

                            userIndex:
                                "${sessionScope.loginUser.userIndex}",

                            endpoint:
                                subscriptionData.endpoint,

                            keys: {

                                p256dh:
                                    subscriptionData
                                        .keys
                                        .p256dh,

                                auth:
                                    subscriptionData
                                        .keys
                                        .auth

                            }

                        })

                }
            );


        const result =
            await response.json();


        if (
            result.status === "success"
        ) {

            setNotificationButton(true);

            alert(
                "복용 알림 설정이 완료되었습니다."
            );

        }

        else {

            alert(
                result.message ||
                "Push 구독 정보 저장에 실패했습니다."
            );

        }


    }

    catch (error) {

        console.error(
            "Push 구독 실패:",
            error
        );


        alert(
            "복용 알림 설정에 실패했습니다."
        );

    }

}



/* =====================================================
   알림 해제
===================================================== */

async function disableNotification() {

    try {

        const registration =
            await navigator
                .serviceWorker
                .ready;


        const subscription =
            await registration
                .pushManager
                .getSubscription();


        // 브라우저 Push 구독 해제
        if (subscription) {

            const success =
                await subscription.unsubscribe();


            if (!success) {

                alert(
                    "알림 해제에 실패했습니다."
                );

                return;
            }
        }


        // Spring 서버에서도 Push 정보 삭제
        const response =
            await fetch(
                "${pageContext.request.contextPath}/push/unsubscribe",
                {

                    method: "POST",

                    headers: {
                        "Content-Type":
                            "application/json"
                    },

                    body:
                        JSON.stringify({

                            userIndex:
                                "${sessionScope.loginUser.userIndex}"

                        })

                }
            );


        const result =
            await response.json();


        if (
            result.status === "success"
        ) {

            setNotificationButton(false);

            alert(
                "알림이 해제되었습니다."
            );

        }

        else {

            alert(
                result.message ||
                "알림 해제에 실패했습니다."
            );

        }


    }
    catch (error) {

        console.error(
            "Push 구독 해제 실패:",
            error
        );


        alert(
            "알림 해제 중 오류가 발생했습니다."
        );

    }

}



/* =====================================================
   알림 버튼 클릭
===================================================== */

async function toggleNotification() {

    if (
        !("serviceWorker" in navigator)
    ) {

        alert(
            "이 브라우저는 Service Worker를 지원하지 않습니다."
        );

        return;

    }


    try {

        const registration =
            await navigator
                .serviceWorker
                .ready;


        const subscription =
            await registration
                .pushManager
                .getSubscription();


        /*
         * 구독이 있으면 → 알림 해제
         */

        if (subscription) {

            await disableNotification();

        }

        /*
         * 구독이 없으면 → 알림 허용
         */

        else {

            await enableNotification();

        }

    }

    catch (error) {

        console.error(
            "알림 상태 확인 실패:",
            error
        );

    }

}



/* =====================================================
   Base64 변환
===================================================== */

function urlBase64ToUint8Array(
    base64String
) {

    const padding =
        "=".repeat(
            (4 -
                base64String.length % 4)
            % 4
        );


    const base64 =
        (
            base64String +
            padding
        )
        .replace(
            /-/g,
            "+"
        )
        .replace(
            /_/g,
            "/"
        );


    const rawData =
        window.atob(base64);


    const outputArray =
        new Uint8Array(
            rawData.length
        );


    for (
        let i = 0;
        i < rawData.length;
        ++i
    ) {

        outputArray[i] =
            rawData.charCodeAt(i);

    }


    return outputArray;

}



/* =====================================================
   알림 버튼 이벤트
===================================================== */

document.addEventListener(
    "DOMContentLoaded",
    function() {


        const notificationBtn =
            document.getElementById(
                "notificationBtn"
            );


        if (notificationBtn) {

            notificationBtn.addEventListener(
                "click",
                toggleNotification
            );

        }


        /*
         * 페이지가 열리면
         * 실제 Push 구독 상태 확인
         */

        checkNotificationStatus();

    }
);



/* =====================================================
   SERVICE WORKER
===================================================== */

if (
    "serviceWorker" in navigator
) {

    window.addEventListener(
        "load",
        function() {

            navigator
                .serviceWorker
                .register(
                    "${pageContext.request.contextPath}/service-worker.js"
                )
                .then(
                    function(registration) {

                        console.log(
                            "Service Worker 등록 성공:",
                            registration.scope
                        );


                        /*
                         * Service Worker가 준비된 후
                         * 실제 Push 상태 다시 확인
                         */

                        checkNotificationStatus();

                    }
                )
                .catch(
                    function(error) {

                        console.error(
                            "Service Worker 등록 실패:",
                            error
                        );

                    }
                );

        }
    );

}

</script>


</body>

</html>