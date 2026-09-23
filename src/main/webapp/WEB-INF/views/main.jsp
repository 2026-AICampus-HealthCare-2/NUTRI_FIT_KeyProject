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

    <title>NUTRI_FIT</title>


<style>

/* =========================================================
   기본
========================================================= */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {

    font-family:
        Arial,
        "Noto Sans KR",
        sans-serif;

    background-color: #f4f8fa;

    color: #263238;
}


/* =========================================================
   Header
========================================================= */

header {

    position: fixed;

    top: 0;
    left: 0;

    width: 100%;
    height: 70px;

    background-color: #ffffff;

    border-bottom: 1px solid #e5eeee;

    box-sizing: border-box;

    z-index: 9999;
}


/* =========================================================
   로고
========================================================= */

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

/* =========================================================
   PC 메뉴
========================================================= */

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

    color: #263238;

    font-size: 15px;

    font-weight: bold;

    white-space: nowrap;

    transition: 0.2s;
}

nav a:hover {

    color: #16847d;
}

nav a.active {

    color: #16847d;

    font-weight: bold;
}


/* =========================================================
   로그인 / 로그아웃
========================================================= */

.nickname {
    color: #2196F3;
}

.user-welcome {

    position: absolute;

    right: 180px;
    top: 50%;

    transform: translateY(-50%);

    font-size: 14px;

    font-weight: bold;

    color: #263238;

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


/* =========================================================
   모바일 메뉴 버튼
========================================================= */

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

    color: #263238;

    cursor: pointer;

    align-items: center;

    justify-content: center;
}


/* =========================================================
   모바일 메뉴
========================================================= */

.mobile-nav {

    display: none;

    position: absolute;

    top: 70px;
    left: 0;

    width: 100%;

    background-color: white;

    border-top: 1px solid #e5eeee;

    border-bottom: 1px solid #dce7e7;

    box-shadow:
        0 8px 20px rgba(20, 92, 88, 0.12);

    padding: 10px 15px;
}

.mobile-nav a {

    display: block;

    width: 100%;

    padding: 15px 10px;

    text-decoration: none;

    color: #263238;

    font-size: 15px;

    font-weight: bold;

    border-bottom: 1px solid #edf2f2;
}

.mobile-nav a:last-child {

    border-bottom: none;
}

.mobile-nav a:hover {

    color: #16847d;

    background-color: #f1f8f7;
}

.mobile-nav a.active {

    color: #16847d;
}


/* =========================================================
   Main
========================================================= */

main {

    width: 100%;

    max-width: 1200px;

    margin: 0 auto;

    padding:
        110px 30px 70px;
}


/* =========================================================
   Hero
========================================================= */

.hero {

    position: relative;

    width: 100%;

    min-height: 350px;

    padding:
        55px 60px;

    display: flex;

    align-items: center;

    justify-content: space-between;

    overflow: hidden;

    border-radius: 24px;

    background:
        linear-gradient(
            135deg,
            #0c5652 0%,
            #145f5a 55%,
            #17736d 100%
        );

    box-shadow:
        0 12px 30px rgba(17, 91, 86, 0.16);
}


/* Hero 배경 장식 */

.hero::before {

    content: "";

    position: absolute;

    width: 300px;
    height: 300px;

    border-radius: 50%;

    right: 180px;
    top: -130px;

    background:
        rgba(255, 255, 255, 0.05);
}

.hero::after {

    content: "";

    position: absolute;

    width: 220px;
    height: 220px;

    border-radius: 50%;

    right: -80px;
    bottom: -100px;

    background:
        rgba(90, 205, 151, 0.14);
}


/* =========================================================
   Hero Text
========================================================= */

.hero-text {

    position: relative;

    z-index: 2;

    width: 55%;
}

.hero-text::before {

    content:
        "오늘도 건강한 하루 되세요!";

    display: block;

    margin-bottom: 15px;

    color: #75d9b2;

    font-size: 14px;

    font-weight: bold;
}

.hero-text h1 {

    color: white;

    font-size: 39px;

    line-height: 1.4;

    margin-bottom: 20px;

    letter-spacing: -1px;
}

.hero-text h1 span {

    color: #8de3bc;
}

.hero-text p {

    color: #d6eeee;

    font-size: 16px;

    line-height: 1.7;

    margin-bottom: 28px;
}


/* =========================================================
   시작 버튼
========================================================= */

.start-btn {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    min-width: 180px;

    padding:
        14px 24px;

    background-color: white;

    color: #12615c;

    border-radius: 30px;

    text-decoration: none;

    font-size: 14px;

    font-weight: bold;

    transition: 0.2s;

    box-shadow:
        0 5px 15px rgba(0, 0, 0, 0.08);
}

.start-btn::after {
    content: "➜";
    font-size: 17px;
    margin-left: 8px;
    margin-bottom: 2px;
}

.start-btn:hover {

    background-color: #e7fff4;

    transform: translateY(-2px);
}


/* =========================================================
   Hero Image
========================================================= */

.hero-image {

    position: relative;

    z-index: 2;

    width: 400px;

    height: 300px;

    display: flex;

    align-items: center;

    justify-content: center;
}


/* 아이콘 배경 */

.hero-image::before {

    content: "";

    position: absolute;

    width: 235px;
    height: 235px;

    border-radius: 50%;

    background:
        rgba(255, 255, 255, 0.09);

    box-shadow:
        0 15px 35px rgba(0, 0, 0, 0.08);
}


/* 아이콘 */

.hero-image img.hero-icon {

    position: relative;

    z-index: 2;

    width: 240px !important;

    height: 240px !important;

    max-width: 240px !important;

    max-height: 240px !important;

    object-fit: contain !important;

    display: block;

    filter:
        drop-shadow(
            0 12px 20px
            rgba(0, 0, 0, 0.15)
        );
}


/* =========================================================
   Feature
========================================================= */

.section-title {

    margin-top: 48px;

    margin-bottom: 20px;

    font-size: 23px;

    color: #263238;

    font-weight: bold;
}

.feature-list {

    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 16px;
}


/* =========================================================
   Feature Card
========================================================= */

.feature {

    position: relative;

    min-height: 170px;

    padding:
        25px 18px;

    border-radius: 18px;

    text-align: center;

    border: 1px solid rgba(0, 0, 0, 0.04);

    background-color: white;

    box-shadow:
        0 6px 18px rgba(40, 70, 70, 0.06);

    transition:
        transform 0.2s,
        box-shadow 0.2s;

    overflow: hidden;
}

.feature:hover {

    transform: translateY(-4px);

    box-shadow:
        0 12px 25px rgba(40, 70, 70, 0.10);
}


/* 카드별 배경 */

.feature:nth-child(1) {

    background:
        linear-gradient(
            145deg,
            #f2f8ff,
            #ffffff
        );
}

.feature:nth-child(2) {

    background:
        linear-gradient(
            145deg,
            #f4fdf9,
            #ffffff
        );
}

.feature:nth-child(3) {

    background:
        linear-gradient(
            145deg,
            #fff5f7,
            #ffffff
        );
}

.feature:nth-child(4) {

    background:
        linear-gradient(
            145deg,
            #f5f8ff,
            #ffffff
        );
}


/* =========================================================
   Feature Icon
========================================================= */

.feature-icon {

    width: 55px;
    height: 55px;

    margin:
        0 auto 14px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 50%;

    font-size: 27px;

    background-color: white;

    box-shadow:
        0 4px 12px rgba(0, 0, 0, 0.07);
}

.feature:nth-child(1)
.feature-icon {

    background-color: #e4f1ff;
}

.feature:nth-child(2)
.feature-icon {

    background-color: #e3f8ed;
}

.feature:nth-child(3)
.feature-icon {

    background-color: #ffe8ef;
}

.feature:nth-child(4)
.feature-icon {

    background-color: #e9efff;
}


/* =========================================================
   Feature Text
========================================================= */

.feature h3 {

    margin-bottom: 8px;

    color: #263238;

    font-size: 17px;
}

.feature p {

    color: #78909c;

    font-size: 13px;

    line-height: 1.55;
}


/* =========================================================
   Footer
========================================================= */

footer {

    background-color: #123f3d;

    color: white;

    padding:
        38px 30px;

    text-align: center;
}

.footer-logo {

    font-size: 21px;

    font-weight: bold;

    margin-bottom: 8px;
}

.footer-description {

    color: #c5dddd;

    font-size: 13px;

    margin-bottom: 12px;
}

.footer-copy {

    color: #91b2b0;

    font-size: 11px;
}


/* =========================================================
   Tablet
========================================================= */

@media (max-width: 950px) {

	.container {
        width: 90%;
        max-width: none;
    }

    header {
        height: 70px;
    }

    .logo {

        left: 30px;
    }

    nav {

        right: 250px;

        gap: 15px;
    }

    .user-welcome {

        display: none;
    }

    .login-btn,
    .logout-btn {

        right: 30px;
    }


    .hero {

        padding:
            45px 40px;
    }

    .hero-text h1 {

        font-size: 34px;
    }

    .hero-image {

        width: 320px;
    }

    .feature-list {

        grid-template-columns:
            repeat(2, 1fr);
    }

}


/* =========================================================
   Mobile
========================================================= */

@media (max-width: 768px) {

    header {
        position: fixed;
        height: 70px;
        min-height: 70px;
        padding: 0 15px;
    }

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

        width: 100%;

        max-width: 100%;

        margin: 0;

        padding:
            95px 15px 50px;
    }

    .hero {

        width: 100%;

        min-height: auto;

        padding:
            35px 20px;

        border-radius: 20px;

        display: flex;

        flex-direction: column;

        justify-content: center;

        align-items: center;

        text-align: center;

        gap: 20px;
    }

    .hero-text {

        width: 100%;
    }

    .hero-text::before {

        font-size: 12px;

        margin-bottom: 10px;
    }

    .hero-text h1 {

        font-size: 29px;

        line-height: 1.4;

        margin-bottom: 15px;
    }

    .hero-text p {

        font-size: 14px;

        line-height: 1.7;

        margin-bottom: 22px;
    }

    .start-btn {

        width: 100%;

        max-width: 250px;

        padding:
            13px 20px;

        font-size: 14px;
    }

    .hero-image {

        width: 100%;

        height: 210px;
    }

    .hero-image::before {

        width: 175px;
        height: 175px;
    }

    .hero-image img.hero-icon {

        width: 175px !important;

        height: 175px !important;

        max-width: 175px !important;

        max-height: 175px !important;
    }

    .section-title {

        margin-top: 35px;

        margin-bottom: 16px;

        font-size: 21px;
    }

    .feature-list {

        display: grid;

        grid-template-columns:
            repeat(2, 1fr);

        gap: 12px;
    }

    .feature {

        min-height: 165px;

        padding:
            22px 12px;

        border-radius: 16px;
    }

    .feature-icon {

        width: 48px;
        height: 48px;

        font-size: 24px;

        margin-bottom: 11px;
    }

    .feature h3 {

        font-size: 16px;

        margin-bottom: 7px;
    }

    .feature p {

        font-size: 12px;

        line-height: 1.5;
    }

    footer {

        padding:
            30px 15px;
    }

    .footer-logo {

        font-size: 19px;
    }

    .footer-description {

        font-size: 12px;

        line-height: 1.5;
    }

    .footer-copy {

        font-size: 10px;
    }

}


/* =========================================================
   작은 스마트폰
========================================================= */

@media (max-width: 480px) {


    /* =========================
       Logo
    ========================= */

    .logo a {
        font-size: 22px;
    }

    .logo img {
        width: 38px;
        height: 38px;
    }


    /* =========================
       메뉴 버튼
    ========================= */

    .mobile-menu-btn {

        width: 40px;
        height: 40px;

        font-size: 26px;
    }


    /* =========================
       Main
    ========================= */

    main {

        padding-left: 12px;

        padding-right: 12px;
    }


    /* =========================
       Hero
    ========================= */

    .hero {

        padding:
            30px 17px;

        border-radius: 18px;
    }

    .hero-text h1 {

        font-size: 26px;
    }

    .hero-text p {

        font-size: 13px;
    }


    /* =========================
       Hero Image
    ========================= */

    .hero-image {

        height: 180px;
    }

    .hero-image::before {

        width: 145px;
        height: 145px;
    }

    .hero-image img.hero-icon {

        width: 145px !important;

        height: 145px !important;

        max-width: 145px !important;

        max-height: 145px !important;
    }


    /* =========================
       주요 기능
    ========================= */

    .section-title {

        font-size: 20px;
    }

    .feature {

        min-height: 155px;

        padding:
            20px 10px;
    }

    .feature-icon {

        width: 45px;
        height: 45px;

        font-size: 22px;
    }

    .feature h3 {

        font-size: 15px;
    }

    .feature p {

        font-size: 11px;
    }

}

</style>

</head>


<body>


<!-- =========================================================
     Header
========================================================= -->

<header>


    <!-- 로고 -->

    <div class="logo">

        <a
            href="${pageContext.request.contextPath}/main">

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
            href="${pageContext.request.contextPath}/mySupplement"
            onclick="return checkLogin();">

            내 영양제

        </a>


        <a
            href="${pageContext.request.contextPath}/intakeManage"
            onclick="return checkLogin();">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage"
            onclick="return checkLogin();">

            마이페이지

        </a>

    </nav>


    <%

    com.smhrd.entity.User loginUser =

        (com.smhrd.entity.User)

        session.getAttribute("loginUser");

    %>


    <!-- 로그인하지 않은 상태 -->

    <% if (loginUser == null) { %>


        <a
            href="${pageContext.request.contextPath}/login"
            class="login-btn">

            로그인

        </a>


    <% } else { %>


        <!-- 로그인한 상태 -->

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


    <!-- =====================================================
         모바일 메뉴 버튼
    ====================================================== -->

    <button

        type="button"

        class="mobile-menu-btn"

        id="mobileMenuBtn"

        onclick="toggleMobileMenu()"

        aria-label="메뉴 열기">

        ☰

    </button>


    <!-- =====================================================
         모바일 메뉴
    ====================================================== -->

    <div

        class="mobile-nav"

        id="mobileNav">


        <a
            href="${pageContext.request.contextPath}/aiAnalysis">

            영양제 분석

        </a>


        <a
            href="${pageContext.request.contextPath}/mySupplement"
            onclick="return checkLogin();">

            내 영양제

        </a>


        <a
            href="${pageContext.request.contextPath}/intakeManage"
            onclick="return checkLogin();">

            복용 관리

        </a>


        <a
            href="${pageContext.request.contextPath}/myPage"
            onclick="return checkLogin();">

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


<!-- =========================================================
     Main
========================================================= -->

<main>


    <!-- =====================================================
         Hero
    ====================================================== -->

    <section class="hero">


        <div class="hero-text">


            <h1>

                당신의 건강한 습관,

                <br>

                <span>
                    NUTRI_FIT
                </span>
                이 함께합니다.

            </h1>


            <p>

                정확한 복용 관리로

                <br>

                건강한 내일을 만들어보세요.

            </p>


            <a

                href="${pageContext.request.contextPath}/aiAnalysis"

                class="start-btn">

                영양제 분석하기 

            </a>


        </div>


        <div class="hero-image">


            <img

                src="${pageContext.request.contextPath}/images/nutriFitIcon.png"

                alt="NUTRI_FIT 아이콘"

                class="hero-icon">


        </div>


    </section>


    <!-- =====================================================
         주요 기능
    ====================================================== -->

    <h2 class="section-title">

        주요 기능

    </h2>


    <section class="feature-list">


        <!-- 영양제 분석 -->

        <div class="feature">


            <div class="feature-icon">

                🔍

            </div>


            <h3>

                영양제 분석

            </h3>


            <p>

                AI가 분석하는

                <br>

                맞춤 영양제 분석

            </p>


        </div>


        <!-- 내 영양제 -->

        <div class="feature">


            <div class="feature-icon">

                💊

            </div>


            <h3>

                내 영양제

            </h3>


            <p>

                등록한 영양제를

                <br>

                한눈에 확인하세요

            </p>


        </div>


        <!-- 복용 관리 -->

        <div class="feature">


            <div class="feature-icon">

                📅

            </div>


            <h3>

                복용 관리

            </h3>


            <p>

                오늘의 복용 일정을

                <br>

                간편하게 관리하세요

            </p>


        </div>


        <!-- 마이페이지 -->

        <div class="feature">


            <div class="feature-icon">

                👤

            </div>


            <h3>

                마이페이지

            </h3>


            <p>

                개인정보와 복용 패턴을

                <br>

                편리하게 관리하세요

            </p>


        </div>


    </section>


</main>


<!-- =========================================================
     Footer
========================================================= -->

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


<script>


/* =====================================================
   로그인 확인
===================================================== */

function checkLogin() {

    <% if (session.getAttribute("loginUser") == null) { %>

        alert("로그인 시 이용 가능합니다.");

        location.href =
            "${pageContext.request.contextPath}/login";

        return false;

    <% } else { %>

        return true;

    <% } %>

}


/* =====================================================
   모바일 메뉴 열기 / 닫기
===================================================== */

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


/* =====================================================
   화면 크기가 다시 커졌을 때 메뉴 닫기
===================================================== */

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


/* =====================================================
   모바일 메뉴에서 메뉴 선택 후 닫기
===================================================== */

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


                        document
                            .getElementById(
                                "mobileMenuBtn"
                            )
                            .textContent = "☰";

                    }

                );

            }

        );

    }

);

</script>


</body>

</html>