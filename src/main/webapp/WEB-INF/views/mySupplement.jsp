<%@ page language="java" contentType="text/html; charset=UTF-8"
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

<title>내 영양제 - NUTRI_FIT</title>


<style>

/* =========================
   기본
========================= */

* {
    box-sizing: border-box;
}

body {
    padding-top: 90px !important;
    margin: 0;
    font-family: Arial, "Noto Sans KR", sans-serif;
    background-color: #f7f9f7;
    color: #333;
}


/* =========================
   헤더
========================= */

header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 70px;
    background-color: white;
    border-bottom: 1px solid #eee;
    box-sizing: border-box;
    z-index: 9999;
}


/* =========================
   로고
========================= */

.logo {
    position: absolute;
    left: 60px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 30px;
    font-weight: bold;
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


/* =========================
   PC 메뉴
========================= */

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
    font-weight: bold;
}


/* =========================
   로그인 / 로그아웃
========================= */

.nickname {
    color: #2196F3;
}

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


/* =========================
   모바일 햄버거 버튼
========================= */

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


/* =========================
   모바일 메뉴
========================= */

.mobile-nav {
    display: none;
    position: absolute;
    top: 70px;
    left: 0;
    width: 100%;
    background-color: white;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #ddd;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
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


/* =========================
   메인
========================= */

.container {
    width: 900px;
    max-width: calc(100% - 40px);
    margin: 50px auto;
    min-height: 600px;
}

.page-title {
    font-size: 32px;
    margin-bottom: 10px;
}

.page-description {
    color: #777;
    margin-bottom: 35px;
}


/* =========================
   상단 정보
========================= */

.supplement-count {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.supplement-count span {
    font-size: 15px;
    color: #666;
}


/* =========================
   영양제 카드
========================= */

.supplement-card {
    background-color: white;
    border-radius: 14px;
    padding: 25px;
    margin-bottom: 18px;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
    transition: 0.2s;
}

.supplement-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.1);
}


/* =========================
   영양제 이미지
========================= */

.supplement-image {
    width: 120px;
    height: 120px;
    border-radius: 12px;
    background-color: #f3f6f3;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 25px;
    overflow: hidden;
}

.supplement-image img {
    width: 100%;
    height: 100%;
    object-fit: contain;
}


/* =========================
   영양제 정보
========================= */

.supplement-info {
    flex: 1;
    min-width: 0;
}

.supplement-name {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 8px;
    word-break: break-word;
}

.supplement-ingredient {
    color: #666;
    font-size: 14px;
    margin-bottom: 15px;
}

.intake-time {
    font-size: 14px;
    color: #555;
    margin-bottom: 15px;
}

.intake-time strong {
    color: #4CAF50;
}


/* =========================
   카드 버튼
========================= */

.card-buttons {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.card-btn {
    padding: 9px 14px;
    border-radius: 7px;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
    border: 1px solid #ddd;
    background-color: white;
    color: #555;
}

.card-btn:hover {
    border-color: #4CAF50;
    color: #4CAF50;
}

.complete-btn {
    border: none;
    background-color: #4CAF50;
    color: white;
}

.complete-btn:hover {
    background-color: #43A047;
    color: white;
}

.delete-btn {
    color: #f44336;
    border: 1px solid #f44336;
    background-color: white;
}

.delete-btn:hover {
    background-color: #f44336;
    color: white;
}


/* =========================
   상세보기
========================= */

.supplement-detail {
    display: none;
    width: 100%;
    flex-basis: 100%;
    margin-top: 20px;
    padding: 20px;
    border-top: 1px solid #eee;
    background-color: #f8faf8;
    border-radius: 10px;
}

.supplement-detail.show {
    display: block;
}

.detail-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
}

.detail-item {
    margin-bottom: 18px;
}

.detail-item strong {
    display: block;
    margin-bottom: 8px;
    color: #4CAF50;
}

.detail-item p {
    margin: 0;
    line-height: 1.6;
    color: #555;
    word-break: break-word;
}

.detail-item ul {
    margin: 5px 0 0 20px;
    padding: 0;
}

.detail-item li {
    margin-bottom: 5px;
    line-height: 1.5;
    color: #555;
    word-break: break-word;
}


/* =========================
   영양제 추가
========================= */

.add-area {
    text-align: center;
    margin-top: 35px;
}

.add-btn {
    display: inline-block;
    padding: 13px 25px;
    border: none;
    border-radius: 8px;
    background-color: #4CAF50;
    color: white;
    font-size: 15px;
    font-weight: bold;
    text-decoration: none;
    cursor: pointer;
}

.add-btn:hover {
    background-color: #43A047;
}


/* =========================
   등록된 영양제가 없을 때
========================= */

.empty-message {
    background-color: white;
    border-radius: 14px;
    padding: 70px 30px;
    text-align: center;
    color: #777;
}

.empty-icon {
    font-size: 45px;
    margin-bottom: 15px;
}


/* =========================
   Footer
========================= */

footer {
    background-color: #333;
    color: white;
    padding: 40px 30px;
    text-align: center;
}

.footer-logo {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 10px;
}

.footer-description {
    color: #ccc;
    font-size: 14px;
    margin-bottom: 15px;
}

.footer-copy {
    color: #999;
    font-size: 12px;
}


/* =========================================================
   태블릿
   950px 이하
========================================================= */

@media (max-width: 950px) {

    .container {
        width: 90%;
        max-width: none;
    }

    header {
        height: 70px;
    }

    nav {
        right: 250px;
        gap: 15px;
    }

    .logo {
        left: 30px;
    }

    .user-welcome {
        display: none;
    }

    .login-btn,
    .logout-btn {
        right: 30px;
    }
}


/* =========================================================
   모바일
   768px 이하
========================================================= */

@media (max-width: 768px) {

    /* =========================
       Header
    ========================= */

    header {
        position: fixed;
        height: 70px;
        min-height: 70px;
        padding: 0 15px;
    }


    /* =========================
       로고
    ========================= */

    .logo {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        width: auto;
        display: flex;
        justify-content: flex-start;
    }

    .logo a {
        font-size: 24px;
        gap: 5px;
    }

    .logo img {
        width: 42px;
        height: 42px;
    }


    /* =========================
       PC 메뉴 숨기기
    ========================= */

    nav {
        display: none;
    }


    /* =========================
       PC 로그인 / 로그아웃 숨기기
    ========================= */

    .login-btn,
    .logout-btn,
    .user-welcome {
        display: none;
    }


    /* =========================
       햄버거 버튼 표시
    ========================= */

    .mobile-menu-btn {
        display: flex;
    }


    /* =========================
       Body
    ========================= */

    body {
        padding-top: 90px !important;
    }


    /* =========================
       Main
    ========================= */

    .container {
        width: 100%;
        max-width: none;
        margin: 30px 0;
        padding: 0 15px;
    }


    /* =========================
       제목
    ========================= */

    .page-title {
        font-size: 27px;
        margin-bottom: 10px;
    }

    .page-description {
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 25px;
    }


    /* =========================
       등록 영양제 개수
    ========================= */

    .supplement-count {
        margin-bottom: 15px;
    }

    .supplement-count span {
        font-size: 14px;
    }


    /* =========================
       영양제 카드
    ========================= */

    .supplement-card {
        flex-direction: column;
        align-items: flex-start;
        width: 100%;
        padding: 20px;
        margin-bottom: 15px;
    }


    /* =========================
       이미지
    ========================= */

    .supplement-image {
        width: 110px;
        height: 110px;
        margin-right: 0;
        margin-bottom: 18px;
    }


    /* =========================
       정보
    ========================= */

    .supplement-info {
        width: 100%;
    }

    .supplement-name {
        font-size: 19px;
        line-height: 1.4;
    }

    .supplement-ingredient {
        font-size: 13px;
        line-height: 1.5;
    }

    .intake-time {
        font-size: 13px;
        line-height: 1.5;
    }


    /* =========================
       버튼
    ========================= */

    .card-buttons {
        width: 100%;
        margin-top: 5px;
        gap: 7px;
    }

    .card-btn {
        flex: 1;
        min-width: 0;
        padding: 10px 8px;
        font-size: 12px;
    }


    /* =========================
       상세보기
    ========================= */

    .supplement-detail {
        margin-top: 20px;
        padding: 18px;
    }

    .detail-title {
        font-size: 17px;
    }

    .detail-item {
        margin-bottom: 17px;
    }

    .detail-item strong {
        font-size: 14px;
    }

    .detail-item p,
    .detail-item li {
        font-size: 13px;
        line-height: 1.6;
    }

    .detail-item ul {
        margin-left: 18px;
    }


    /* =========================
       영양제 추가
    ========================= */

    .add-area {
        margin-top: 25px;
    }

    .add-btn {
        width: 100%;
        max-width: 240px;
        padding: 13px 20px;
        font-size: 14px;
    }


    /* =========================
       등록된 영양제 없음
    ========================= */

    .empty-message {
        padding: 55px 20px;
        font-size: 14px;
        line-height: 1.7;
    }

    .empty-icon {
        font-size: 40px;
    }


    /* =========================
       Footer
    ========================= */

    footer {
        padding: 30px 15px;
    }

    .footer-logo {
        font-size: 20px;
    }

    .footer-description {
        font-size: 13px;
        line-height: 1.5;
    }

    .footer-copy {
        font-size: 11px;
    }
}


/* =========================================================
   작은 스마트폰
   480px 이하
========================================================= */

@media (max-width: 480px) {

    /* =========================
       로고
    ========================= */

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


    /* =========================
       Container
    ========================= */

    .container {
        padding: 0 12px;
    }


    /* =========================
       제목
    ========================= */

    .page-title {
        font-size: 24px;
    }

    .page-description {
        font-size: 13px;
    }


    /* =========================
       영양제 카드
    ========================= */

    .supplement-card {
        padding: 17px;
    }

    .supplement-image {
        width: 100px;
        height: 100px;
    }

    .supplement-name {
        font-size: 17px;
    }


    /* =========================
       버튼
    ========================= */

    .card-buttons {
        gap: 5px;
    }

    .card-btn {
        padding: 9px 5px;
        font-size: 11px;
    }


    /* =========================
       상세보기
    ========================= */

    .supplement-detail {
        padding: 15px;
    }

    .detail-title {
        font-size: 16px;
    }

    .detail-item p,
    .detail-item li {
        font-size: 12px;
    }


    /* =========================
       Empty
    ========================= */

    .empty-message {
        padding: 45px 15px;
        font-size: 13px;
    }
}

</style>

</head>


<body>


<!-- =========================
     헤더
========================= -->

<header>


    <!-- 로고 -->

    <div class="logo">

        <a href="${pageContext.request.contextPath}/main">

            <img
                src="${pageContext.request.contextPath}/images/nutriFitIcon.png"
                alt="NUTRI_FIT아이콘">

            <span>
                NUTRI_FIT
            </span>

        </a>

    </div>


    <!-- =========================
         PC 메뉴
    ========================= -->

    <nav>

        <a
            href="${pageContext.request.contextPath}/aiAnalysis">

            영양제 분석

        </a>


        <a
            href="${pageContext.request.contextPath}/mySupplement"
            class="active">

            내 영양제

        </a>


        <a
            href="${pageContext.request.contextPath}/intakeManage">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage">

            마이페이지

        </a>

    </nav>


    <%

    com.smhrd.entity.User loginUser =

        (com.smhrd.entity.User)
        session.getAttribute("loginUser");

    %>


    <!-- =========================
         PC 로그인 / 로그아웃
    ========================= -->

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


    <!-- =========================
         모바일 햄버거 버튼
    ========================= -->

    <button
        type="button"
        class="mobile-menu-btn"
        id="mobileMenuBtn"
        onclick="toggleMobileMenu()"
        aria-label="메뉴 열기">

        ☰

    </button>


    <!-- =========================
         모바일 메뉴
    ========================= -->

    <div
        class="mobile-nav"
        id="mobileNav">


        <a
            href="${pageContext.request.contextPath}/aiAnalysis">

            영양제 분석

        </a>


        <a
            href="${pageContext.request.contextPath}/mySupplement"
            class="active">

            내 영양제

        </a>


        <a
            href="${pageContext.request.contextPath}/intakeManage">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage">

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


<!-- =========================
     데이터 가져오기
========================= -->

<%

java.util.List<com.smhrd.entity.UserSupplement> supplementList =

    (java.util.List<com.smhrd.entity.UserSupplement>)
    request.getAttribute("supplementList");


java.util.List<com.smhrd.entity.Supplement> supplements =

    (java.util.List<com.smhrd.entity.Supplement>)
    request.getAttribute("supplements");

%>


<!-- =========================
     메인
========================= -->

<div class="container">


    <h1 class="page-title">

        내 영양제

    </h1>


    <p class="page-description">

        현재 복용 중인 영양제를 한눈에 확인하고
        관리할 수 있습니다.

    </p>


    <div class="supplement-count">

        <span>

            현재 등록된 영양제

            <strong>

                <%= supplementList != null
                    ? supplementList.size()
                    : 0 %>개

            </strong>

        </span>

    </div>


<%

if (supplementList != null

        && !supplementList.isEmpty()

        && supplements != null) {


    for (int i = 0;

         i < supplementList.size();

         i++) {


        com.smhrd.entity.UserSupplement userSupplement =

            supplementList.get(i);


        if (i >= supplements.size()) {

            continue;

        }


        com.smhrd.entity.Supplement supplement =

            supplements.get(i);

%>


<!-- =========================
     영양제 카드
========================= -->

<div class="supplement-card">


    <!-- 영양제 이미지 -->

    <div class="supplement-image">

        <%

        if (supplement.getImageUrl() != null

                && !supplement.getImageUrl().isEmpty()) {

        %>


            <img
                src="${pageContext.request.contextPath}<%= supplement.getImageUrl() %>"
                alt="<%= supplement.getProductName() %>">


        <%

        } else {

        %>


            <div style="font-size:45px;">

                💊

            </div>


        <%

        }

        %>

    </div>


    <!-- 영양제 정보 -->

    <div class="supplement-info">


        <div class="supplement-name">

            <%= supplement.getProductName() %>

        </div>


        <div class="supplement-ingredient">

            제조사 :

            <%= supplement.getManufacturer() %>

        </div>


        <div class="intake-time">

            1일 섭취량 :

            <strong>

                <%= userSupplement.getDailyDose() %>

                <%= userSupplement.getDoseUnit() %>

            </strong>

        </div>


        <!-- 버튼 -->

        <div class="card-buttons">


            <button
                type="button"
                class="card-btn complete-btn"
                onclick="addIntakeSchedule(<%= userSupplement.getUserSupplementId() %>)">

                복용 일정 추가

            </button>


            <button
                type="button"
                class="card-btn detail-btn"
                onclick="toggleDetail(this)">

                상세보기

            </button>


            <button
                type="button"
                class="card-btn delete-btn"
                onclick="deleteSupplement(<%= userSupplement.getUserSupplementId() %>)">

                삭제

            </button>


        </div>


    </div>


    <!-- =========================
         AI 분석 상세
    ========================= -->

    <div class="supplement-detail">


        <div class="detail-title">

            AI 분석 결과

        </div>


<%

String analysisJson =

    supplement.getOcrText();


if (analysisJson != null

        && !analysisJson.trim().isEmpty()) {


    try {


        com.fasterxml.jackson.databind.ObjectMapper objectMapper =

            new com.fasterxml.jackson.databind.ObjectMapper();


        com.fasterxml.jackson.databind.JsonNode analysis =

            objectMapper.readTree(analysisJson);


        if (analysis.has("analysis")) {

            analysis =
                analysis.get("analysis");

        }

%>


<!-- 주요 효과 -->

<div class="detail-item">


    <strong>

        주요 효과

    </strong>


    <ul>


<%

if (analysis.has("effects")

        && analysis.get("effects").isArray()) {


    for (com.fasterxml.jackson.databind.JsonNode effect

            : analysis.get("effects")) {

%>


        <li>

            <%= effect.asText() %>

        </li>


<%

    }

} else {

%>


        <li>

            확인되지 않음

        </li>


<%

}

%>


    </ul>


</div>


<!-- 추천 복용 시간 -->

<div class="detail-item">


    <strong>

        추천 복용 시간

    </strong>


    <p>


<%

String recommendedTime = "확인되지 않음";


if (analysis.has("recommended_time")

        && !analysis.get("recommended_time").isNull()) {


    recommendedTime =

        analysis.get("recommended_time").asText();

}

%>


        <%= recommendedTime %>


    </p>


</div>


<!-- 식사와의 관계 -->

<div class="detail-item">


    <strong>

        식사와의 관계

    </strong>


    <p>


<%

String mealRelation = "확인되지 않음";


if (analysis.has("meal_relation")

        && !analysis.get("meal_relation").isNull()) {


    String relation =

        analysis.get("meal_relation").asText();


    if ("WITH_MEAL".equalsIgnoreCase(relation)) {

        mealRelation = "식사 중";

    }

    else if ("AFTER_MEAL".equalsIgnoreCase(relation)) {

        mealRelation = "식사 후";

    }

    else if ("BEFORE_MEAL".equalsIgnoreCase(relation)) {

        mealRelation = "식사 전";

    }

    else if ("ANYTIME".equalsIgnoreCase(relation)) {

        mealRelation = "식사와 관계없이";

    }

    else {

        mealRelation = relation;

    }

}

%>


        <%= mealRelation %>


    </p>


</div>


<!-- 추천 이유 -->

<div class="detail-item">


    <strong>

        추천 이유

    </strong>


    <p>


<%

if (analysis.has("reason")

        && !analysis.get("reason").isNull()) {

%>


        <%= analysis.get("reason").asText() %>


<%

} else {

%>


        확인되지 않음


<%

}

%>


    </p>


</div>


<!-- 주의사항 -->

<div class="detail-item">


    <strong>

        주의사항

    </strong>


    <ul>


<%

if (analysis.has("cautions")

        && analysis.get("cautions").isArray()) {


    for (com.fasterxml.jackson.databind.JsonNode caution

            : analysis.get("cautions")) {

%>


        <li>

            <%= caution.asText() %>

        </li>


<%

    }

} else {

%>


        <li>

            특별한 주의사항이 확인되지 않았습니다.

        </li>


<%

}

%>


    </ul>


</div>


<!-- 함께 복용할 때 주의사항 -->

<div class="detail-item">


    <strong>

        함께 복용할 때 주의사항

    </strong>


    <ul>


<%

if (analysis.has("interaction_notes")

        && analysis.get("interaction_notes").isArray()) {


    for (com.fasterxml.jackson.databind.JsonNode note

            : analysis.get("interaction_notes")) {

%>


        <li>

            <%= note.asText() %>

        </li>


<%

    }

} else if (analysis.has("interaction_note")) {

%>


        <li>

            <%= analysis.get("interaction_note").asText() %>

        </li>


<%

} else {

%>


        <li>

            확인되지 않음

        </li>


<%

}

%>


    </ul>


</div>


<%

    } catch (Exception e) {

%>


        <p>

            AI 분석 결과를 불러올 수 없습니다.

        </p>


<%

        e.printStackTrace();

    }


} else {

%>


        <p>

            저장된 AI 분석 결과가 없습니다.

        </p>


<%

}

%>


    </div>


</div>


<%

    }

} else {

%>


<!-- =========================
     등록된 영양제가 없을 때
========================= -->

<div class="empty-message">


    <div class="empty-icon">

        💊

    </div>


    <p>

        아직 등록된 영양제가 없습니다.

    </p>


    <p>

        AI 분석을 통해 영양제를 등록해보세요.

    </p>


</div>


<%

}

%>


<!-- =========================
     영양제 추가
========================= -->

<div class="add-area">


    <a
        href="${pageContext.request.contextPath}/aiAnalysis"
        class="add-btn">

        + 영양제 추가하기

    </a>


</div>


</div>


<!-- =========================
     Footer
========================= -->

<footer>


    <div class="footer-logo">

        NUTRI_FIT

    </div>


    <div class="footer-description">

        개인 맞춤형 영양제 안전관리 서비스

    </div>


    <div class="footer-copy">

        © 2026 NUTRI_FIT. All rights reserved.

    </div>


</footer>


<!-- =========================
     JavaScript
========================= -->

<script>


/* =========================
   모바일 메뉴
========================= */

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


/* =========================
   화면 크기 변경
========================= */

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


/* =========================
   모바일 메뉴 클릭 시 닫기
========================= */

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


/* =========================
   복용 일정 추가
========================= */

async function addIntakeSchedule(userSupplementId) {


    try {


        var response = await fetch(

            "${pageContext.request.contextPath}/intake/add",

            {
                method: "POST",

                headers: {
                    "Content-Type":
                        "application/x-www-form-urlencoded"
                },

                body:
                    "userSupplementId=" +
                    encodeURIComponent(userSupplementId)
            }

        );


        var data =
            await response.json();


        if (data.status === "success") {

            alert(
                "복용 일정이 추가되었습니다."
            );

        }

        else if (data.status === "already") {

            alert(
                "이미 복용 일정이 추가되어 있습니다."
            );

        }

        else {

            alert(
                data.message ||
                "복용 일정 추가에 실패했습니다."
            );

        }


    } catch (error) {


        console.error(error);


        alert(
            "복용 일정 추가 중 오류가 발생했습니다."
        );

    }

}


/* =========================
   상세보기
========================= */

function toggleDetail(button) {


    var card =
        button.closest(".supplement-card");


    var detail =
        card.querySelector(".supplement-detail");


    if (detail.classList.contains("show")) {

        detail.classList.remove("show");

        button.textContent = "상세보기";

    } else {

        detail.classList.add("show");

        button.textContent = "접기";

    }

}


/* =========================
   영양제 삭제
========================= */

async function deleteSupplement(userSupplementId) {


    if (!confirm("이 영양제를 삭제하시겠습니까?")) {

        return;

    }


    try {


        var response = await fetch(

            "${pageContext.request.contextPath}/mySupplement/delete",

            {
                method: "POST",

                headers: {
                    "Content-Type":
                        "application/x-www-form-urlencoded"
                },

                body:
                    "userSupplementId=" +
                    encodeURIComponent(userSupplementId)
            }

        );


        var data =
            await response.json();


        if (data.status === "success") {


            alert(
                "영양제가 삭제되었습니다."
            );


            location.reload();


        } else {


            alert(
                data.message ||
                "영양제 삭제에 실패했습니다."
            );

        }


    } catch (error) {


        console.error(error);


        alert(
            "영양제 삭제 중 오류가 발생했습니다."
        );

    }

}

</script>


</body>

</html>