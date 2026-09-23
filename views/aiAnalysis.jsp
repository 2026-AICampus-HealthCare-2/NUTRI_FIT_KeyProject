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

<title>AI 영양제 분석 - NUTRI_FIT</title>


<style>

/* =========================
   기본
========================= */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    padding-top: 90px !important;
    margin: 0;
    font-family: Arial, "Noto Sans KR", sans-serif;
    background-color: #f7f9f7;
    color: #333;
}


/* =========================
   Header
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
}

.page-title {
    font-size: 32px;
    margin-bottom: 30px;
}


/* =========================
   사진 업로드 영역
========================= */

.upload-box {
    background-color: white;
    border: 2px dashed #b8d9bd;
    border-radius: 16px;
    padding: 45px 30px;
    text-align: center;
    margin-bottom: 30px;
    transition: 0.2s;
}

.upload-box:hover {
    border-color: #4CAF50;
    background-color: #fbfffb;
}


/* =========================
   업로드 아이콘
========================= */

.upload-icon {
    font-size: 48px;
    margin-bottom: 15px;
}


/* =========================
   업로드 제목
========================= */

.upload-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}


/* =========================
   업로드 설명
========================= */

.upload-description {
    color: #888;
    font-size: 14px;
    margin-bottom: 25px;
    line-height: 1.5;
}


/* =========================
   사진 선택 버튼
========================= */

.file-label {
    display: inline-block;
    padding: 12px 25px;
    background-color: #4CAF50;
    color: white;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

.file-label:hover {
    background-color: #43A047;
}


/* 실제 파일 선택창 숨기기 */

#image {
    display: none;
}


/* =========================
   선택된 파일 이름
========================= */

#fileName {
    margin-top: 15px;
    color: #555;
    font-size: 14px;
    word-break: break-all;
}


/* =========================
   이미지 미리보기
========================= */

#preview-container {
    display: none;
    margin-top: 30px;
    padding-top: 30px;
    border-top: 1px solid #eee;
}

#preview {
    width: 280px;
    height: 280px;
    max-width: 100%;
    object-fit: contain;
    border-radius: 12px;
    border: 1px solid #ddd;
    background-color: #fafafa;
}


/* =========================
   AI 분석 버튼
========================= */

.analyze-btn {
    display: none;
    margin: 25px auto 0;
    padding: 12px 25px;
    border: none;
    border-radius: 8px;
    background-color: #4CAF50;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
}

.analyze-btn:hover {
    background-color: #43A047;
}

.analyze-btn:disabled {
    background-color: #aaa;
    cursor: not-allowed;
}


/* =========================
   로딩
========================= */

#loading {
    display: none;
    text-align: center;
    margin: 20px 0;
    color: #4CAF50;
    font-weight: bold;
    line-height: 1.5;
}


/* =========================
   분석 결과
========================= */

#result {
    display: none;
    background-color: white;
    border-radius: 12px;
    padding: 35px;
    margin-top: 30px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
}


/* =========================
   분석 결과 제목 영역
========================= */

.result-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    margin-bottom: 25px;
}

.result-header h2 {
    margin: 0;
    font-size: 26px;
}


/* =========================
   내 영양제로 등록 버튼
========================= */

.register-btn {
    padding: 12px 25px;
    border: none;
    border-radius: 8px;
    background-color: #4CAF50;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.2s;
    white-space: nowrap;
}

.register-btn:hover {
    background-color: #43A047;
}


/* =========================
   결과 항목
========================= */

.result-section {
    margin-bottom: 30px;
}

.result-section h3 {
    color: #4CAF50;
    border-bottom: 2px solid #4CAF50;
    padding-bottom: 8px;
    margin-bottom: 15px;
}

.result-section p {
    margin: 10px 0;
    font-size: 16px;
    line-height: 1.6;
    word-break: break-word;
}

.result-section ul {
    padding-left: 20px;
}

.result-section li {
    margin-bottom: 8px;
    line-height: 1.5;
    word-break: break-word;
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
   태블릿 / 작은 화면
   950px 이하
========================================================= */

@media (max-width: 950px) {

    .container {
        width: 90%;
        max-width: none;
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


    /* =========================
       PC 메뉴 숨기기
    ========================= */

    nav {
        display: none;
    }


    /* =========================
       로그인 / 로그아웃 숨기기
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
       Main Container
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
        margin-bottom: 20px;
    }


    /* =========================
       업로드 영역
    ========================= */

    .upload-box {
        width: 100%;
        padding: 35px 18px;
        border-radius: 15px;
        margin-bottom: 20px;
    }


    /* =========================
       업로드 아이콘
    ========================= */

    .upload-icon {
        font-size: 42px;
        margin-bottom: 12px;
    }


    /* =========================
       업로드 제목
    ========================= */

    .upload-title {
        font-size: 18px;
        line-height: 1.5;
    }


    /* =========================
       업로드 설명
    ========================= */

    .upload-description {
        font-size: 13px;
        line-height: 1.6;
        margin-bottom: 20px;
    }


    /* =========================
       사진 선택 버튼
    ========================= */

    .file-label {
        width: 100%;
        max-width: 240px;
        padding: 13px 20px;
        font-size: 15px;
    }


    /* =========================
       파일 이름
    ========================= */

    #fileName {
        font-size: 13px;
        line-height: 1.5;
    }


    /* =========================
       미리보기
    ========================= */

    #preview-container {
        margin-top: 25px;
        padding-top: 25px;
    }

    #preview {
        width: 220px;
        height: 220px;
        max-width: 100%;
    }


    /* =========================
       분석 버튼
    ========================= */

    .analyze-btn {
        width: 100%;
        max-width: 240px;
        padding: 13px 20px;
        font-size: 15px;
        min-height: 45px;
    }


    /* =========================
       로딩
    ========================= */

    #loading {
        padding: 0 15px;
        font-size: 14px;
    }


    /* =========================
       분석 결과
    ========================= */

    #result {
        width: 100%;
        padding: 22px 18px;
        margin-top: 20px;
        border-radius: 12px;
    }


    /* =========================
       결과 헤더
    ========================= */

    .result-header {
        flex-direction: column;
        align-items: stretch;
        gap: 15px;
        margin-bottom: 25px;
    }

    .result-header h2 {
        font-size: 23px;
        text-align: left;
    }


    /* =========================
       등록 버튼
    ========================= */

    .register-btn {
        width: 100%;
        min-height: 45px;
        padding: 12px 15px;
        font-size: 15px;
    }


    /* =========================
       결과 항목
    ========================= */

    .result-section {
        margin-bottom: 25px;
    }

    .result-section h3 {
        font-size: 18px;
        padding-bottom: 7px;
        margin-bottom: 13px;
    }

    .result-section p {
        font-size: 14px;
        line-height: 1.7;
        margin: 9px 0;
    }

    .result-section ul {
        padding-left: 18px;
    }

    .result-section li {
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 7px;
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
       Header
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
       Body
    ========================= */

    body {
        padding-top: 90px !important;
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


    /* =========================
       업로드 영역
    ========================= */

    .upload-box {
        padding: 30px 15px;
    }

    .upload-title {
        font-size: 17px;
    }

    .upload-description {
        font-size: 12px;
    }


    /* =========================
       미리보기
    ========================= */

    #preview {
        width: 190px;
        height: 190px;
    }


    /* =========================
       분석 결과
    ========================= */

    #result {
        padding: 20px 15px;
    }

    .result-header h2 {
        font-size: 21px;
    }

    .result-section h3 {
        font-size: 17px;
    }

    .result-section p,
    .result-section li {
        font-size: 13px;
    }


    /* =========================
       Footer
    ========================= */

    .footer-description {
        font-size: 12px;
    }
}

</style>

</head>


<body>


<!-- =========================
     Header
========================= -->

<header>


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


    <!-- PC 메뉴 -->

    <nav>

        <a
            href="${pageContext.request.contextPath}/aiAnalysis"
            class="active">

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


    <!-- PC 로그인 / 로그아웃 -->

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
            href="${pageContext.request.contextPath}/aiAnalysis"
            class="active">

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


<!-- =========================
     메인
========================= -->

<div class="container">


    <h1 class="page-title">

        AI 영양제 분석

    </h1>


    <!-- =========================
         사진 업로드
    ========================= -->

    <div class="upload-box">


        <div class="upload-icon">

            📷

        </div>


        <div class="upload-title">

            영양제 사진을 등록해주세요

        </div>


        <div class="upload-description">

            영양제의 앞면 또는 성분표가

            <br>

            잘 보이는 사진을 선택해주세요.

        </div>


        <!-- 사진 선택 -->

        <label
            for="image"
            class="file-label">

            📁 사진 선택

        </label>


        <input
            type="file"
            id="image"
            accept="image/*">


        <!-- 선택된 파일 이름 -->

        <div id="fileName">

            선택된 파일 없음

        </div>


        <!-- =========================
             사진 미리보기
        ========================= -->

        <div id="preview-container">


            <img
                id="preview"
                src=""
                alt="영양제 이미지 미리보기">


        </div>


        <!-- =========================
             AI 분석하기
        ========================= -->

        <button
            type="button"
            class="analyze-btn"
            id="analyzeBtn"
            onclick="analyzeSupplement()">

            AI 분석하기

        </button>


    </div>


    <!-- =========================
         로딩
    ========================= -->

    <div id="loading">

        AI가 영양제 정보를 분석하고 있습니다...

    </div>


    <!-- =========================
         분석 결과
    ========================= -->

    <div id="result">


        <!-- 분석 결과 제목 + 등록 버튼 -->

        <div class="result-header">


            <h2>

                분석 결과

            </h2>


            <button
                type="button"
                class="register-btn"
                onclick="registerSupplement()">

                내 영양제로 등록

            </button>


        </div>


        <!-- =========================
             제품 정보
        ========================= -->

        <div class="result-section">


            <h3>

                제품 정보

            </h3>


            <p>

                제품명 :

                <span id="supplementName">

                    확인되지 않음

                </span>

            </p>


            <p>

                제조사 :

                <span id="manufacturer">

                    확인되지 않음

                </span>

            </p>


            <p>

                1일 섭취량 :

                <span id="dailyDose">

                    확인되지 않음

                </span>

            </p>


        </div>


        <!-- =========================
             주요 성분
        ========================= -->

        <div class="result-section">


            <h3>

                주요 성분

            </h3>


            <ul id="ingredients">

            </ul>


        </div>


        <!-- =========================
             AI 분석
        ========================= -->

        <div class="result-section">


            <h3>

                AI 분석

            </h3>


            <p>

                주요 효과

            </p>


            <ul id="effects">

            </ul>


            <p>

                추천 복용 시간 :

                <span id="recommendedTime">

                    확인 필요

                </span>

            </p>


            <p>

                식사 관계 :

                <span id="mealRelation">

                    확인 필요

                </span>

            </p>


            <p>

                추천 이유 :

                <span id="reason">

                    확인 필요

                </span>

            </p>


        </div>


        <!-- =========================
             주의사항
        ========================= -->

        <div class="result-section">


            <h3>

                주의사항

            </h3>


            <ul id="cautions">

            </ul>


        </div>


        <!-- =========================
             상호작용
        ========================= -->

        <div class="result-section">


            <h3>

                함께 복용할 때 주의사항

            </h3>


            <ul id="interactionNotes">

            </ul>


        </div>


    </div>


</div>


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
   이미지 선택
========================= */

var latestAnalysis = null;


document.getElementById("image")
    .addEventListener(
        "change",
        function(event) {

            var file =
                event.target.files[0];


            if (!file) {
                return;
            }


            /* 이미지 파일인지 확인 */

            if (!file.type.startsWith("image/")) {

                alert(
                    "이미지 파일만 선택할 수 있습니다."
                );

                return;

            }


            /* 파일명 표시 */

            document.getElementById("fileName")
                .textContent = file.name;


            /* 이미지 미리보기 */

            var reader =
                new FileReader();


            reader.onload =
                function(e) {

                    document.getElementById("preview")
                        .src = e.target.result;


                    document.getElementById(
                        "preview-container"
                    ).style.display = "block";


                    document.getElementById(
                        "analyzeBtn"
                    ).style.display = "block";

                };


            reader.readAsDataURL(file);

        }
    );


/* =========================
   AI 분석
========================= */

async function analyzeSupplement() {


    var imageInput =
        document.getElementById("image");


    var file =
        imageInput.files[0];


    if (!file) {

        alert(
            "먼저 영양제 사진을 선택해주세요."
        );

        return;

    }


    /* FormData 생성 */

    var formData =
        new FormData();


    formData.append(
        "image",
        file
    );


    var analyzeBtn =
        document.getElementById(
            "analyzeBtn"
        );


    var loading =
        document.getElementById(
            "loading"
        );


    analyzeBtn.disabled = true;

    loading.style.display = "block";


    try {


        /* =========================
           Spring Controller 호출
        ========================= */

        var response =
            await fetch(
                "${pageContext.request.contextPath}/ai/analyze",
                {
                    method: "POST",
                    body: formData
                }
            );

        console.log("AI 요청 상태 코드 :", response.status);
        console.log("AI 요청 성공 여부 :", response.ok);

        var responseText =
            await response.text();

        console.log("AI 서버 응답 :", responseText);

        var data;

        try {

            data = JSON.parse(responseText);

        } catch (e) {

            console.error(
                "JSON 변환 실패:",
                e
            );

            throw new Error(
                "서버에서 JSON 형식의 응답을 받지 못했습니다."
            );
        }


        console.log(
            "AI 분석 결과:"
        );

        console.log(data);


        /* =========================
           오류 확인
        ========================= */

        if (data.status !== "success") {

            alert(
                "AI 분석에 실패했습니다."
            );

            console.error(data);

            return;

        }


        /* AI 분석 결과 저장 */

        latestAnalysis = data.analysis;


        /* =========================
           OCR 결과
        ========================= */

        if (data.ocr) {


            document.getElementById(
                "supplementName"
            ).textContent =
                data.ocr.supplement_name ||
                "확인되지 않음";


            document.getElementById(
                "manufacturer"
            ).textContent =
                data.ocr.manufacturer ||
                "확인되지 않음";


            document.getElementById(
                "dailyDose"
            ).textContent =
                data.ocr.daily_dose ||
                "확인되지 않음";


            /* 성분 */

            var ingredients =
                document.getElementById(
                    "ingredients"
                );


            ingredients.innerHTML = "";


            if (data.ocr.ingredients) {

                data.ocr.ingredients.forEach(
                    function(item) {

                        var li =
                            document.createElement(
                                "li"
                            );


                        li.textContent =
                            (item.name || "") +
                            " : " +
                            (item.amount || "") +
                            " " +
                            (item.unit || "");


                        ingredients.appendChild(li);

                    }
                );

            }

        }


        /* =========================
           AI 분석 결과
        ========================= */

        if (data.analysis) {


            /* 효과 */

            var effects =
                document.getElementById(
                    "effects"
                );


            effects.innerHTML = "";


            if (data.analysis.effects) {

                data.analysis.effects.forEach(
                    function(item) {

                        var li =
                            document.createElement(
                                "li"
                            );


                        li.textContent = item;


                        effects.appendChild(li);

                    }
                );

            }


            /* 추천 시간 */

            document.getElementById(
                "recommendedTime"
            ).textContent =
                data.analysis.recommended_time ||
                "확인 필요";


            /* 식사 관계 */

            document.getElementById(
                "mealRelation"
            ).textContent =
                data.analysis.meal_relation ||
                "확인 필요";


            /* 추천 이유 */

            document.getElementById(
                "reason"
            ).textContent =
                data.analysis.reason ||
                "확인 필요";


            /* =========================
               주의사항
            ========================= */

            var cautions =
                document.getElementById(
                    "cautions"
                );


            cautions.innerHTML = "";


            if (data.analysis.cautions) {

                data.analysis.cautions.forEach(
                    function(item) {

                        var li =
                            document.createElement(
                                "li"
                            );


                        li.textContent = item;


                        cautions.appendChild(li);

                    }
                );

            }


            /* =========================
               상호작용
            ========================= */

            var interactionNotes =
                document.getElementById(
                    "interactionNotes"
                );


            interactionNotes.innerHTML = "";


            if (data.analysis.interaction_notes) {

                data.analysis.interaction_notes.forEach(
                    function(item) {

                        var li =
                            document.createElement(
                                "li"
                            );


                        li.textContent = item;


                        interactionNotes.appendChild(li);

                    }
                );

            }

        }


        /* =========================
           결과 화면 표시
        ========================= */

        document.getElementById(
            "result"
        ).style.display = "block";


        /* 결과 위치로 이동 */

        document.getElementById(
            "result"
        ).scrollIntoView({
            behavior: "smooth"
        });


    }


    catch(error) {

        console.error(
            "AI 분석 오류:",
            error
        );

        alert(
            "AI 서버와 통신하는 중 오류가 발생했습니다.\n\n"
            + error.message
        );

    }


    finally {

        analyzeBtn.disabled = false;

        loading.style.display = "none";

    }

}

</script>


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


<script>


/* =========================
   로그인 확인
========================= */

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


/* =========================
   내 영양제로 등록
========================= */

async function registerSupplement() {


    /* 로그인 여부 확인 */

    <% if (session.getAttribute("loginUser") == null) { %>

        alert("로그인 시 이용 가능합니다.");

        return;

    <% } %>


    /* 분석 결과 가져오기 */

    var supplementName =
        document.getElementById("supplementName")
            .textContent
            .trim();


    var manufacturer =
        document.getElementById("manufacturer")
            .textContent
            .trim();


    var dailyDose =
        document.getElementById("dailyDose")
            .textContent
            .trim();


    var image =
        document.getElementById("image")
            .files[0];


    /* 분석 결과가 없는 경우 */

    if (!supplementName ||
        supplementName === "확인되지 않음") {

        alert(
            "먼저 영양제 분석을 진행해주세요."
        );

        return;

    }


    /* AI 분석 결과가 없는 경우 */

    if (!latestAnalysis) {

        alert(
            "AI 분석 결과를 먼저 확인해주세요."
        );

        return;

    }


    /* Spring으로 보낼 데이터 */

    var formData =
        new FormData();


    formData.append(
        "productName",
        supplementName
    );


    formData.append(
        "manufacturer",
        manufacturer
    );


    formData.append(
        "dailyDose",
        dailyDose
    );


    /* AI 분석 결과 */

    formData.append(
        "analysis",
        JSON.stringify(latestAnalysis)
    );


    /* 이미지 */

    if (image) {

        formData.append(
            "image",
            image
        );

    }


    try {


        var response =
            await fetch(
                "${pageContext.request.contextPath}/ai/register",
                {
                    method: "POST",
                    body: formData
                }
            );


        var data =
            await response.json();


        /* 등록 성공 */

        if (data.status === "success") {

            alert(
                "내 영양제로 등록되었습니다."
            );

            return;

        }


        /* 등록 실패 */

        alert(
            data.message ||
            "내 영양제 등록에 실패했습니다."
        );


    }


    catch(error) {

        console.error(error);


        alert(
            "내 영양제 등록 중 오류가 발생했습니다."
        );

    }

}

</script>


</body>

</html>