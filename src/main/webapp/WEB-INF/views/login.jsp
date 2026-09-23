<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<link rel="icon"
      type="image/png"
      href="${pageContext.request.contextPath}/images/nutriFitIcon.png">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>로그인 - NUTRI_FIT</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f7faf7;
    color: #333;

    min-height: 100vh;

    display: flex;
    flex-direction: column;
}


/* =========================
   Header
========================= */

header {
    height: 70px;

    background-color: white;
    border-bottom: 1px solid #eee;

    display: flex;
    align-items: center;

    padding: 0 60px;
}


/* 로고 */

.logo {
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
   로그인 영역
========================= */

.login-container {
    width: 420px;

    margin: auto;

    padding: 40px;

    background-color: white;

    border-radius: 16px;

    box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
}


/* 제목 */

.login-title {
    text-align: center;
    margin-bottom: 35px;
}

.login-title h1 {
    margin: 0 0 10px;
    font-size: 30px;
}

.login-title p {
    margin: 0;
    color: #888;
    font-size: 14px;
}


/* 입력 영역 */

.input-group {
    margin-bottom: 18px;
}

.input-group label {
    display: block;

    margin-bottom: 8px;

    font-size: 14px;
    font-weight: bold;
}

.input-group input {
    width: 100%;

    height: 48px;

    padding: 0 14px;

    border: 1px solid #ddd;
    border-radius: 8px;

    font-size: 15px;

    outline: none;
}

.input-group input:focus {
    border-color: #4CAF50;
}
.login-icon {
    width: 150px;
    height: 150px;
    object-fit: contain;

    display: block;
    margin: 0 auto 15px;
}
/* 로그인 버튼 */

.login-button {
    width: 100%;
    height: 50px;

    margin-top: 10px;

    border: none;
    border-radius: 8px;

    background-color: #4CAF50;
    color: white;

    font-size: 16px;
    font-weight: bold;

    cursor: pointer;
}

.login-button:hover {
    background-color: #43A047;
}


/* 회원가입 안내 */

.signup-link {
    margin-top: 25px;

    text-align: center;

    font-size: 14px;
}

.signup-link a {
    color: #4CAF50;

    text-decoration: none;

    font-weight: bold;
}

.signup-link a:hover {
    text-decoration: underline;
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

/* =========================
   반응형
========================= */

@media (max-width: 600px) {

    header {
        padding: 0 30px;
    }

    .login-container {
        width: calc(100% - 40px);

        padding: 30px 25px;
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
    <a href="/main">
        <img src="/images/nutriFitIcon.png" alt="NUTRI_FIT아이콘">
        <span>NUTRI_FIT</span>
    </a>
	</div>

</header>



<!-- =========================
     Login
========================= -->

<div class="login-container">


    <div class="login-title">

    <img
        src="/images/nutriFitIcon.png"
        alt="NUTRI_FIT 아이콘"
        class="login-icon">

    <h1>로그인</h1>

</div>



   <form
    action="/login"
    method="post">

    <div class="input-group">

        <label for="userId">
            아이디
        </label>

        <input
            type="text"
            id="userId"
            name="userId"
            placeholder="아이디를 입력해주세요"
            required>

    </div>


    <div class="input-group">

        <label for="password">
            비밀번호
        </label>

        <input
            type="password"
            id="password"
            name="password"
            placeholder="비밀번호를 입력해주세요"
            required>

    </div>


    <button
        type="submit"
        class="login-button">

        로그인

    </button>

</form>



    <!-- 회원가입 -->

    <div class="signup-link">

        <a href="/join">
        아직 회원이 아니라면 여기를 클릭해주세요
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


</body>

</html>