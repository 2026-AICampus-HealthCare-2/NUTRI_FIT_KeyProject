<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">
<link rel="icon"
      type="image/png"
      href="${pageContext.request.contextPath}/images/nutriFitIcon.png">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>마이페이지 - NUTRI_FIT</title>


<style>

/* =========================================
   기본
========================================= */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding-top: 90px;
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    color: #333;
}


/* =========================================
   헤더
========================================= */

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


/* =========================================
   로고
========================================= */

.logo {
    position: absolute;
    left: 60px;
    top: 50%;
    transform: translateY(-50%);
}

.logo a {
    text-decoration: none;
    color: #4CAF50;
    font-size: 30px;
    font-weight: bold;
    display: flex;
    align-items: center;
    gap: 8px;
}

.logo img {
    width: 55px;
    height: 55px;
    object-fit: contain;
}

.logo a:hover {
    text-decoration: none;
    color: #4CAF50;
}


/* =========================================
   PC 네비게이션
========================================= */

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


/* =========================================
   모바일 메뉴 버튼
========================================= */

.mobile-menu-btn {
    display: none;

    position: absolute;
    right: 15px;
    top: 50%;

    transform: translateY(-50%);

    width: 42px;
    height: 42px;

    border: none;
    border-radius: 8px;

    background-color: white;

    font-size: 28px;
    color: #333;

    cursor: pointer;

    align-items: center;
    justify-content: center;
}


/* =========================================
   모바일 메뉴
========================================= */

.mobile-nav {
    display: none;

    position: absolute;

    top: 90px;
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

.mobile-nav a:last-child {
    border-bottom: none;
}

.mobile-nav a:hover {
    color: #4CAF50;
    background-color: #f7faf7;
}

.mobile-nav a.active {
    color: #4CAF50;
}


/* =========================================
   로그인 / 로그아웃
========================================= */

.user-welcome {
    position: absolute;

    right: 180px;
    top: 50%;

    transform: translateY(-50%);

    font-size: 15px;
    font-weight: bold;

    color: #333;

    white-space: nowrap;
}

.nickname {
    color: #2196F3;
}


.login-btn,
.logout-btn {
    position: absolute;

    right: 60px;
    top: 50%;

    transform: translateY(-50%);

    width: 102px;
    height: 46px;

    padding: 0;

    border: 1px solid #4CAF50;
    border-radius: 8px;

    background-color: white;
    color: #4CAF50;

    font-size: 16px;
    font-weight: bold;

    cursor: pointer;

    white-space: nowrap;

    text-decoration: none;

    display: flex;
    align-items: center;
    justify-content: center;
}

.login-btn:hover,
.logout-btn:hover {
    background-color: #4CAF50;
    color: white;
}


/* =========================================
   전체 컨테이너
========================================= */

.container {
    width: 1200px;

    max-width: calc(100% - 40px);

    margin: 0 auto;

    padding: 40px 0 80px;
}


/* =========================================
   제목
========================================= */

.page-title {
    font-size: 30px;

    font-weight: bold;

    margin-bottom: 30px;
}


/* =========================================
   카드 공통
========================================= */

.card {
    background-color: white;

    border-radius: 12px;

    padding: 30px;

    margin-bottom: 25px;

    box-shadow:
        0 2px 8px rgba(0,0,0,0.06);
}

.card-title {
    font-size: 21px;

    font-weight: bold;

    margin-bottom: 25px;
}


/* =========================================
   내 정보
========================================= */

.info-grid {
    display: grid;

    grid-template-columns: 1fr 1fr 1fr;

    gap: 20px;
}

.info-item {
    background-color: #f8f9fa;

    border-radius: 10px;

    padding: 18px;
}

.info-label {
    font-size: 14px;

    color: #777;

    margin-bottom: 8px;
}

.info-value {
    font-size: 17px;

    font-weight: bold;
}


/* =========================================
   수정 버튼
========================================= */

.edit-btn {
    margin-top: 20px;

    padding: 10px 20px;

    border: 1px solid #4CAF50;
    border-radius: 7px;

    background-color: white;

    color: #4CAF50;

    font-weight: bold;

    cursor: pointer;
}

.edit-btn:hover {
    background-color: #4CAF50;
    color: white;
}


/* =========================================
   수정 영역
========================================= */

.edit-area {
    display: none;

    margin-top: 25px;

    padding-top: 25px;

    border-top: 1px solid #ddd;
}

.edit-grid {
    display: grid;

    grid-template-columns: 1fr 1fr 1fr;

    gap: 18px;
}

.edit-item label {
    display: block;

    font-size: 14px;

    margin-bottom: 7px;

    color: #666;
}

.edit-item input {
    width: 100%;

    height: 40px;

    border: 1px solid #ddd;

    border-radius: 6px;

    padding: 0 10px;

    font-size: 15px;
}

.save-btn {
    margin-top: 20px;

    padding: 10px 25px;

    border: none;

    border-radius: 7px;

    background-color: #4CAF50;

    color: white;

    font-weight: bold;

    cursor: pointer;
}


/* =========================================
   복용 통계
========================================= */

.statistics {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 20px;
}

.stat-box {
    padding: 25px;

    background-color: #f8f9fa;

    border-radius: 10px;

    text-align: center;
}

.stat-label {
    color: #777;

    font-size: 15px;

    margin-bottom: 12px;
}

.stat-value {
    font-size: 32px;

    font-weight: bold;

    color: #4CAF50;
}


/* =========================================
   전체 복용 기록
========================================= */

.filter-area {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 20px;
}

.filter-area select {
    padding: 9px 15px;

    border: 1px solid #ddd;

    border-radius: 6px;
}

.pdf-btn {
    padding: 9px 15px;

    border: 1px solid #4CAF50;

    border-radius: 6px;

    background-color: white;

    color: #4CAF50;

    font-weight: bold;

    cursor: pointer;
}

.pdf-btn:hover {
    background-color: #4CAF50;

    color: white;
}


/* =========================================
   복용 기록 테이블
========================================= */

.history-table-wrapper {
    width: 100%;

    overflow-x: auto;
}

.history-table {
    width: 100%;

    min-width: 700px;

    border-collapse: collapse;
}

.history-table th {
    background-color: #f4f6f7;

    padding: 14px;

    border-bottom: 1px solid #ddd;

    font-size: 14px;
}

.history-table td {
    padding: 14px;

    border-bottom: 1px solid #eee;

    text-align: center;

    font-size: 14px;
}

.status-taken {
    color: #4CAF50;

    font-weight: bold;
}

.status-missed {
    color: #e53935;

    font-weight: bold;
}


/* =========================================
   복용 영양제
========================================= */

.supplement-grid {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 20px;
}

.supplement-card {
    border: 1px solid #eee;

    border-radius: 10px;

    padding: 20px;

    background-color: white;
}

.supplement-name {
    font-size: 18px;

    font-weight: bold;

    margin-bottom: 10px;
}

.supplement-info {
    color: #777;

    font-size: 14px;

    line-height: 1.7;
}


/* =========================================
   푸터
========================================= */

footer {
    background-color: #333;

    color: white;

    text-align: center;

    padding: 30px 0;

    margin-top: 30px;
}

.footer-logo {
    font-size: 20px;

    font-weight: bold;

    margin-bottom: 10px;
}

.footer-text {
    font-size: 13px;

    color: #ccc;
}


/* =========================================
   태블릿
========================================= */

@media (max-width: 950px) {

    .container {
        width: 90%;

        max-width: none;
    }

    .info-grid {
        grid-template-columns: 1fr 1fr;
    }

    .edit-grid {
        grid-template-columns: 1fr 1fr;
    }

    .statistics {
        grid-template-columns:
            1fr 1fr 1fr;
    }

    .supplement-grid {
        grid-template-columns: 1fr 1fr;
    }

    nav {
        right: 250px;

        gap: 15px;
    }

    .logo {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        width: auto;
        display: flex;
        justify-content: flex-start;
        font-size: 24px;
    }

    .logo a {
        font-size: 24px;
        gap: 5px;
    }

    .logo img {
        width: 42px;
        height: 42px;
    }

    .user-welcome {
        display: none;
    }

    .login-btn,
    .logout-btn {
        right: 30px;
    }
}


/* =========================================
   모바일
========================================= */

@media (max-width: 768px) {

    body {
        padding-top: 90px;
    }


    /* -----------------------------------------
       헤더
    ----------------------------------------- */

    header {
        height: 70px;
    }


    /* 로고 */

    .logo {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        width: auto;
        display: flex;
        justify-content: flex-start;
        font-size: 24px;
    }

    .logo a {
        font-size: 24px;
        gap: 5px;
    }

    .logo img {
        width: 42px;
        height: 42px;
    }
    /* PC 메뉴 숨기기 */

    nav {
        display: none;
    }


    /* 로그인 / 로그아웃 숨기기 */

    .login-btn,
    .logout-btn,
    .user-welcome {
        display: none;
    }


    /* 햄버거 버튼 */

    .mobile-menu-btn {
        display: flex;
    }


    /* -----------------------------------------
       컨테이너
    ----------------------------------------- */

    .container {
        width: 100%;

        max-width: none;

        padding: 25px 15px 50px;
    }


    /* -----------------------------------------
       제목
    ----------------------------------------- */

    .page-title {
        font-size: 26px;

        margin-bottom: 20px;
    }


    /* -----------------------------------------
       카드
    ----------------------------------------- */

    .card {
        padding: 20px;

        margin-bottom: 18px;

        border-radius: 10px;
    }

    .card-title {
        font-size: 19px;

        margin-bottom: 18px;
    }


    /* -----------------------------------------
       내 정보
    ----------------------------------------- */

    .info-grid {
        grid-template-columns: 1fr;

        gap: 12px;
    }

    .info-item {
        padding: 15px;
    }


    /* -----------------------------------------
       정보 수정
    ----------------------------------------- */

    .edit-grid {
        grid-template-columns: 1fr;

        gap: 15px;
    }

    .edit-item input {
        height: 42px;
    }

    .edit-btn {
        width: 100%;

        height: 44px;
    }

    .save-btn {
        width: 100%;

        height: 44px;
    }


    /* -----------------------------------------
       복용 통계
    ----------------------------------------- */

    .statistics {
        grid-template-columns: 1fr;

        gap: 12px;
    }

    .stat-box {
        padding: 20px;
    }

    .stat-value {
        font-size: 28px;
    }


    /* -----------------------------------------
       복용 기록 필터
    ----------------------------------------- */

    .filter-area {
        flex-direction: column;

        align-items: stretch;

        gap: 10px;
    }

    .filter-area select {
        width: 100%;

        height: 42px;
    }

    .pdf-btn {
        width: 100%;

        height: 42px;
    }


    /* -----------------------------------------
       복용 기록
    ----------------------------------------- */

    .history-table-wrapper {
        margin: 0 -5px;

        width: calc(100% + 10px);

        overflow-x: auto;
    }

    .history-table {
        min-width: 700px;
    }


    /* -----------------------------------------
       복용 영양제
    ----------------------------------------- */

    .supplement-grid {
        grid-template-columns: 1fr;

        gap: 12px;
    }

    .supplement-card {
        padding: 18px;
    }


    /* -----------------------------------------
       푸터
    ----------------------------------------- */

    footer {
        padding: 25px 15px;
    }
}


/* =========================================
   작은 모바일
========================================= */

@media (max-width: 480px) {

    .logo a {
        font-size: 22px;
    }

    .logo img {
        width: 38px;
        height: 38px;
    }

    .mobile-menu-btn {
        right: 10px;
    }

    .container {
        padding-left: 10px;

        padding-right: 10px;
    }

    .card {
        padding: 16px;
    }

    .page-title {
        font-size: 24px;
    }

    .card-title {
        font-size: 18px;
    }
}

</style>

</head>


<body>


<%
    /*
     * 로그인 사용자 정보
     */

    com.smhrd.entity.User loginUser =
        (com.smhrd.entity.User)
        session.getAttribute("loginUser");
%>


<!-- =========================================
     헤더
========================================= -->

<header>


    <!-- 로고 -->

    <div class="logo">

        <a href="${pageContext.request.contextPath}/main">

            <img
                src="${pageContext.request.contextPath}/images/nutriFitIcon.png"
                alt="NUTRI_FIT 아이콘">

            <span>NUTRI_FIT</span>

        </a>

    </div>


    <!-- PC 네비게이션 -->

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
            href="${pageContext.request.contextPath}/intakeManage">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage"
            class="active">

            마이페이지

        </a>

    </nav>


    <!-- 로그인 / 로그아웃 -->

    <% if (loginUser == null) { %>

        <a
            href="${pageContext.request.contextPath}/login"
            class="login-btn">

            로그인

        </a>

    <% } else { %>


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

    <% } %>


    <!-- =====================================
         모바일 메뉴 버튼
    ====================================== -->

    <button
        type="button"
        class="mobile-menu-btn"
        id="mobileMenuBtn"
        onclick="toggleMobileMenu()"
        aria-label="메뉴 열기">

        ☰

    </button>


    <!-- =====================================
         모바일 메뉴
    ====================================== -->

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
            href="${pageContext.request.contextPath}/intakeManage">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage"
            class="active">

            마이페이지

        </a>


        <% if (loginUser == null) { %>

            <a
                href="${pageContext.request.contextPath}/login">

                로그인

            </a>

        <% } else { %>

            <a
                href="${pageContext.request.contextPath}/logout">

                로그아웃

            </a>

        <% } %>


    </div>


</header>


<!-- =========================================
     메인
========================================= -->

<div class="container">


    <div class="page-title">

        마이페이지

    </div>


    <!-- =====================================
         내 정보
    ====================================== -->

    <div class="card">


        <div class="card-title">

            내 정보

        </div>


        <div class="info-grid">


            <!-- 닉네임 -->

            <div class="info-item">

                <div class="info-label">

                    닉네임

                </div>

                <div class="info-value">

                    <%= loginUser.getNickname() != null
                        ? loginUser.getNickname()
                        : "-" %>

                </div>

            </div>


            <!-- 기상 시간 -->

            <div class="info-item">

                <div class="info-label">

                    기상 시간

                </div>

                <div class="info-value">

                    <%= loginUser.getWakeTime() != null
                        ? loginUser.getWakeTime()
                        : "-" %>

                </div>

            </div>


            <!-- 아침 식사 -->

            <div class="info-item">

                <div class="info-label">

                    아침 식사

                </div>

                <div class="info-value">

                    <%= loginUser.getBreakfastTime() != null
                        ? loginUser.getBreakfastTime()
                        : "-" %>

                </div>

            </div>


            <!-- 점심 식사 -->

            <div class="info-item">

                <div class="info-label">

                    점심 식사

                </div>

                <div class="info-value">

                    <%= loginUser.getLunchTime() != null
                        ? loginUser.getLunchTime()
                        : "-" %>

                </div>

            </div>


            <!-- 저녁 식사 -->

            <div class="info-item">

                <div class="info-label">

                    저녁 식사

                </div>

                <div class="info-value">

                    <%= loginUser.getDinnerTime() != null
                        ? loginUser.getDinnerTime()
                        : "-" %>

                </div>

            </div>


            <!-- 취침 시간 -->

            <div class="info-item">

                <div class="info-label">

                    취침 시간

                </div>

                <div class="info-value">

                    <%= loginUser.getSleepTime() != null
                        ? loginUser.getSleepTime()
                        : "-" %>

                </div>

            </div>


        </div>


        <!-- 정보 수정 버튼 -->

        <button
            type="button"
            class="edit-btn"
            onclick="showEditArea()">

            정보 수정

        </button>


        <!-- =================================
             수정 영역
        ================================== -->

        <div
            id="editArea"
            class="edit-area">


            <div class="edit-grid">


                <!-- 닉네임 -->

                <div class="edit-item">

                    <label>

                        닉네임

                    </label>

                    <input
                        type="text"
                        id="editNickname"
                        value="<%= loginUser.getNickname() != null
                            ? loginUser.getNickname()
                            : "" %>">

                </div>


                <!-- 기상 -->

                <div class="edit-item">

                    <label>

                        기상 시간

                    </label>

                    <input
                        type="time"
                        id="editWakeTime"
                        value="<%= loginUser.getWakeTime() != null
                            ? loginUser.getWakeTime()
                            : "" %>">

                </div>


                <!-- 아침 -->

                <div class="edit-item">

                    <label>

                        아침 식사

                    </label>

                    <input
                        type="time"
                        id="editBreakfastTime"
                        value="<%= loginUser.getBreakfastTime() != null
                            ? loginUser.getBreakfastTime()
                            : "" %>">

                </div>


                <!-- 점심 -->

                <div class="edit-item">

                    <label>

                        점심 식사

                    </label>

                    <input
                        type="time"
                        id="editLunchTime"
                        value="<%= loginUser.getLunchTime() != null
                            ? loginUser.getLunchTime()
                            : "" %>">

                </div>


                <!-- 저녁 -->

                <div class="edit-item">

                    <label>

                        저녁 식사

                    </label>

                    <input
                        type="time"
                        id="editDinnerTime"
                        value="<%= loginUser.getDinnerTime() != null
                            ? loginUser.getDinnerTime()
                            : "" %>">

                </div>


                <!-- 취침 -->

                <div class="edit-item">

                    <label>

                        취침 시간

                    </label>

                    <input
                        type="time"
                        id="editSleepTime"
                        value="<%= loginUser.getSleepTime() != null
                            ? loginUser.getSleepTime()
                            : "" %>">

                </div>


            </div>


            <button
                type="button"
                class="save-btn"
                onclick="saveUserInfo()">

                저장

            </button>


        </div>


    </div>


    <!-- =====================================
         복용 통계
    ====================================== -->

    <div class="card">


        <div class="card-title">

            복용 통계

        </div>


        <div class="statistics">


            <!-- 총 등록 영양제 -->

            <div class="stat-box">

                <div class="stat-label">

                    총 등록 영양제

                </div>

                <div class="stat-value">

                    ${totalSupplement}

                </div>

            </div>


            <!-- 총 복용 횟수 -->

            <div class="stat-box">

                <div class="stat-label">

                    총 복용 횟수

                </div>

                <div class="stat-value">

                    ${totalIntake}

                </div>

            </div>


            <!-- 평균 복용률 -->

            <div class="stat-box">

                <div class="stat-label">

                    평균 복용률

                </div>

                <div class="stat-value">

                    ${averageRate}%

                </div>

            </div>


        </div>


    </div>


    <!-- =====================================
         전체 복용 기록
    ====================================== -->

    <div class="card">


        <div class="card-title">

            전체 복용 기록

        </div>


        <div class="filter-area">


            <select
                id="historyFilter"
                onchange="filterHistory()">

                <option value="all">

                    전체

                </option>

                <option value="taken">

                    복용 완료

                </option>

                <option value="missed">

                    미복용

                </option>

            </select>


            <button
                type="button"
                class="pdf-btn"
                onclick="downloadPdf()">

                PDF 다운로드

            </button>


        </div>


        <!-- 모바일 가로 스크롤 -->

        <div class="history-table-wrapper">


            <table class="history-table">


                <thead>

                    <tr>

                        <th>

                            영양제

                        </th>

                        <th>

                            날짜

                        </th>

                        <th>

                            복용 시간

                        </th>

                        <th>

                            섭취량

                        </th>

                        <th>

                            상태

                        </th>

                    </tr>

                </thead>


                <tbody id="historyTableBody">


<%

    java.util.List<java.util.Map<String, Object>>
        historyList =
        (java.util.List<java.util.Map<String, Object>>)
        request.getAttribute("historyList");


    if (historyList == null || historyList.isEmpty()) {

%>


                    <tr>

                        <td
                            colspan="5"
                            style="
                                text-align:center;
                                padding:30px;
                                color:#777;
                            ">

                            등록된 복용 기록이 없습니다.

                        </td>

                    </tr>


<%

    } else {


        for (
            java.util.Map<String, Object> history
            : historyList
        ) {


            String productName =
                history.get("productName") != null
                ? history.get("productName").toString()
                : "-";


            String intakeDate =
                history.get("intakeDate") != null
                ? history.get("intakeDate").toString()
                : "-";


            String scheduledTime =
                history.get("scheduledTime") != null
                ? history.get("scheduledTime").toString()
                : "-";


            String takenTime = "-";


            if (history.get("takenAt") != null) {

                java.time.LocalDateTime takenAt =
                    (java.time.LocalDateTime)
                    history.get("takenAt");


                takenTime =
                    takenAt.toLocalTime().toString();


                if (takenTime.length() >= 5) {

                    takenTime =
                        takenTime.substring(0, 5);

                }

            }


            String displayTime;


            if (!"-".equals(takenTime)) {

                displayTime = takenTime;

            } else {

                displayTime = scheduledTime;


                if (displayTime.length() >= 5) {

                    displayTime =
                        displayTime.substring(0, 5);

                }

            }


            java.math.BigDecimal dailyDose =
                (java.math.BigDecimal)
                history.get("dailyDose");


            String doseUnit =
                history.get("doseUnit") != null
                ? history.get("doseUnit").toString()
                : "";


            com.smhrd.entity.IntakeLog.IntakeStatus status =
                (com.smhrd.entity.IntakeLog.IntakeStatus)
                history.get("status");


            String statusText = "대기";

            String statusClass = "";

            String dataStatus = "missed";


            if (
                status ==
                com.smhrd.entity.IntakeLog.IntakeStatus.TAKEN
            ) {

                statusText = "복용 완료";

                statusClass = "status-taken";

                dataStatus = "taken";


            } else if (
                status ==
                com.smhrd.entity.IntakeLog.IntakeStatus.MISSED
            ) {

                statusText = "미복용";

                statusClass = "status-missed";

                dataStatus = "missed";


            } else if (
                status ==
                com.smhrd.entity.IntakeLog.IntakeStatus.SKIPPED
            ) {

                statusText = "건너뜀";

                statusClass = "status-missed";

                dataStatus = "missed";


            } else {

                statusText = "대기";

                dataStatus = "missed";

            }

%>


                    <tr
                        data-status="<%= dataStatus %>">


                        <td>

                            <%= productName %>

                        </td>


                        <td>

                            <%= intakeDate %>

                        </td>


                        <td>

                            <%= displayTime %>

                        </td>


                        <td>

                            <%= dailyDose != null
                                ? dailyDose
                                : "-" %>

                            <%= doseUnit %>

                        </td>


                        <td
                            class="<%= statusClass %>">

                            <%= statusText %>

                        </td>


                    </tr>


<%

        }

    }

%>


                </tbody>


            </table>


        </div>


    </div>


    <!-- =====================================
         복용 영양제
    ====================================== -->

    <div class="card">


        <div class="card-title">

            복용 영양제

        </div>


        <div class="supplement-grid">


<%

    java.util.List<com.smhrd.entity.UserSupplement>
        userSupplementList =
        (java.util.List<com.smhrd.entity.UserSupplement>)
        request.getAttribute("userSupplementList");


    java.util.List<com.smhrd.entity.Supplement>
        supplementList =
        (java.util.List<com.smhrd.entity.Supplement>)
        request.getAttribute("supplementList");


    if (
        userSupplementList == null
        || userSupplementList.isEmpty()
    ) {

%>


            <div
                class="supplement-card"
                style="
                    grid-column:1 / -1;
                    text-align:center;
                    color:#777;
                ">

                등록된 영양제가 없습니다.

            </div>


<%

    } else {


        for (
            com.smhrd.entity.UserSupplement userSupplement
            : userSupplementList
        ) {


            com.smhrd.entity.Supplement supplement = null;


            if (supplementList != null) {


                for (
                    com.smhrd.entity.Supplement supplementItem
                    : supplementList
                ) {


                    if (
                        supplementItem
                            .getSupplementId()
                            .equals(
                                userSupplement
                                    .getSupplementId()
                            )
                    ) {

                        supplement =
                            supplementItem;

                        break;

                    }

                }

            }


            if (supplement == null) {

                continue;

            }

%>


            <div class="supplement-card">


                <div class="supplement-name">

                    <%= supplement.getProductName() %>

                </div>


                <div class="supplement-info">

                    제조사 :

                    <%= supplement.getManufacturer() %>

                    <br>


                    1일 복용량 :

                    <%= userSupplement.getDailyDose() %>

                    <%= userSupplement.getDoseUnit() %>

                </div>


            </div>


<%

        }

    }

%>


        </div>


    </div>


</div>


<!-- =========================================
     푸터
========================================= -->

<footer>


    <div class="footer-logo">

        NUTRI_FIT

    </div>


    <div class="footer-text">

        개인 맞춤형 영양제 안전관리 서비스

    </div>


</footer>


<script>


/* =========================================
   모바일 메뉴
========================================= */

function toggleMobileMenu() {

    var mobileNav =
        document.getElementById("mobileNav");

    var menuButton =
        document.getElementById("mobileMenuBtn");


    if (mobileNav.style.display === "block") {

        mobileNav.style.display = "none";

        menuButton.textContent = "☰";

        menuButton.setAttribute(
            "aria-label",
            "메뉴 열기"
        );

    } else {

        mobileNav.style.display = "block";

        menuButton.textContent = "✕";

        menuButton.setAttribute(
            "aria-label",
            "메뉴 닫기"
        );

    }

}


/* =========================================
   화면 크기 변경 시 모바일 메뉴 초기화
========================================= */

window.addEventListener(
    "resize",
    function() {

        if (window.innerWidth > 768) {

            var mobileNav =
                document.getElementById("mobileNav");

            var menuButton =
                document.getElementById("mobileMenuBtn");


            mobileNav.style.display = "none";

            menuButton.textContent = "☰";

            menuButton.setAttribute(
                "aria-label",
                "메뉴 열기"
            );

        }

    }
);


/* =========================================
   모바일 메뉴 클릭 후 닫기
========================================= */

document.addEventListener(
    "DOMContentLoaded",
    function() {

        var mobileNav =
            document.getElementById("mobileNav");


        var mobileLinks =
            mobileNav.querySelectorAll("a");


        mobileLinks.forEach(
            function(link) {

                link.addEventListener(
                    "click",
                    function() {

                        mobileNav.style.display =
                            "none";


                        document.getElementById(
                            "mobileMenuBtn"
                        ).textContent = "☰";

                    }
                );

            }
        );

    }
);


/* =========================================
   정보 수정 영역 표시
========================================= */

function showEditArea() {

    var editArea =
        document.getElementById("editArea");


    if (
        editArea.style.display === "none"
        || editArea.style.display === ""
    ) {

        editArea.style.display = "block";

    } else {

        editArea.style.display = "none";

    }

}


/* =========================================
   사용자 정보 저장
========================================= */

function saveUserInfo() {

    var nickname =
        document.getElementById(
            "editNickname"
        ).value;


    var wakeTime =
        document.getElementById(
            "editWakeTime"
        ).value;


    var breakfastTime =
        document.getElementById(
            "editBreakfastTime"
        ).value;


    var lunchTime =
        document.getElementById(
            "editLunchTime"
        ).value;


    var dinnerTime =
        document.getElementById(
            "editDinnerTime"
        ).value;


    var sleepTime =
        document.getElementById(
            "editSleepTime"
        ).value;


    /*
     * 현재는 화면에만 반영
     *
     * DB 저장은 Controller의
     * 사용자 정보 수정 기능을
     * 연결하면 됨
     */

    var infoValues =
        document.querySelectorAll(
            ".info-value"
        );


    infoValues[0].textContent =
        nickname || "-";


    infoValues[1].textContent =
        wakeTime || "-";


    infoValues[2].textContent =
        breakfastTime || "-";


    infoValues[3].textContent =
        lunchTime || "-";


    infoValues[4].textContent =
        dinnerTime || "-";


    infoValues[5].textContent =
        sleepTime || "-";


    alert(
        "정보가 수정되었습니다."
    );


    document.getElementById(
        "editArea"
    ).style.display = "none";

}


/* =========================================
   복용 기록 필터
========================================= */

function filterHistory() {

    var filter =
        document.getElementById(
            "historyFilter"
        ).value;


    var rows =
        document.querySelectorAll(
            "#historyTableBody tr"
        );


    rows.forEach(
        function(row) {


            var status =
                row.getAttribute(
                    "data-status"
                );


            /*
             * 데이터가 없는 안내 행은
             * 필터링하지 않음
             */

            if (!status) {

                return;

            }


            if (filter === "all") {

                row.style.display = "";

            } else if (
                filter === status
            ) {

                row.style.display = "";

            } else {

                row.style.display = "none";

            }

        }
    );

}


/* =========================================
   PDF 다운로드
========================================= */

function downloadPdf() {

    window.location.href =
        "${pageContext.request.contextPath}/myPage/pdf";

}

</script>


</body>

</html>