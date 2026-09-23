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

<title>회원가입 - NUTRI_FIT</title>

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
   회원가입 영역
========================= */

.signup-container {

    width: 500px;

    margin: 50px auto;

    padding: 40px;

    background-color: white;

    border-radius: 16px;

    box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
}


/* 제목 */

.signup-title {

    text-align: center;

    margin-bottom: 30px;
}

.signup-title h1 {

    margin: 0;

    font-size: 30px;
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

    height: 46px;

    padding: 0 14px;

    border: 1px solid #ddd;

    border-radius: 8px;

    font-size: 15px;

    outline: none;
}

.input-group input:focus {

    border-color: #4CAF50;
}


/* 시간 입력 */

.time-group {

    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 15px;
}


/* 회원가입 버튼 */

.signup-button {

    width: 100%;

    height: 50px;

    margin-top: 15px;

    border: none;

    border-radius: 8px;

    background-color: #4CAF50;

    color: white;

    font-size: 16px;

    font-weight: bold;

    cursor: pointer;
}

.signup-button:hover {

    background-color: #43A047;
}


/* 로그인으로 돌아가기 */

.login-link {

    margin-top: 20px;

    text-align: center;

    font-size: 14px;
}

.login-link a {

    color: #4CAF50;

    text-decoration: none;

    font-weight: bold;
}


/* =========================
   Footer
========================= */

footer {

    margin-top: auto;

    padding: 25px 30px;

    background-color: #333;

    color: white;

    text-align: center;
}

.footer-logo {

    font-size: 20px;

    font-weight: bold;

    margin-bottom: 8px;
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

    .signup-container {

        width: calc(100% - 40px);

        padding: 30px 25px;

        margin: 30px auto;
    }

    .time-group {

        grid-template-columns: 1fr;
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
     회원가입
========================= -->

<div class="signup-container">


    <div class="signup-title">

        <h1>회원가입</h1>

    </div>


    <form action="/join" method="post">


        <!-- 아이디 -->

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



        <!-- 비밀번호 -->

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



        <!-- 비밀번호 확인 -->

        <div class="input-group">

            <label for="passwordConfirm">
                비밀번호 확인
            </label>

            <input
                type="password"
                id="passwordConfirm"
                name="passwordConfirm"
                placeholder="비밀번호를 다시 입력해주세요"
                required>

        </div>



        <!-- 닉네임 -->

        <div class="input-group">

            <label for="nickname">
                닉네임
            </label>

            <input
                type="text"
                id="nickname"
                name="nickname"
                placeholder="닉네임을 입력해주세요"
                required>

        </div>



        <!-- 기상 시간 -->

        <div class="input-group">

            <label for="wakeTime">
                기상 시간
            </label>

            <input
                type="time"
                id="wakeTime"
                name="wakeTime"
                required>

        </div>



        <!-- 식사 시간 -->

        <div class="time-group">


            <!-- 아침 -->

            <div class="input-group">

                <label for="breakfastTime">
                    아침 식사 시간
                </label>

                <input
                    type="time"
                    id="breakfastTime"
                    name="breakfastTime"
                    required>

            </div>



            <!-- 점심 -->

            <div class="input-group">

                <label for="lunchTime">
                    점심 식사 시간
                </label>

                <input
                    type="time"
                    id="lunchTime"
                    name="lunchTime"
                    required>

            </div>



            <!-- 저녁 -->

            <div class="input-group">

                <label for="dinnerTime">
                    저녁 식사 시간
                </label>

                <input
                    type="time"
                    id="dinnerTime"
                    name="dinnerTime"
                    required>

            </div>



            <!-- 취침 -->

            <div class="input-group">

                <label for="sleepTime">
                    취침 시간
                </label>

                <input
                    type="time"
                    id="sleepTime"
                    name="sleepTime"
                    required>

            </div>

        </div>



        <!-- 회원가입 버튼 -->

        <button
            type="submit"
            class="signup-button">

            회원가입

        </button>


    </form>


    <!-- 로그인으로 돌아가기 -->

    <div class="login-link">

        이미 회원이라면

        <a href="${pageContext.request.contextPath}/login">
            로그인하기
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

    <div class="footer-copy">
        © 2026 NUTRI_FIT. All rights reserved.
    </div>

</footer>



<script>

function signup(event) {

    event.preventDefault();


    var password =
        document.getElementById("password").value;

    var passwordConfirm =
        document.getElementById("passwordConfirm").value;


    /* 비밀번호 확인 */

    if (password !== passwordConfirm) {

        alert("비밀번호가 일치하지 않습니다.");

        return;
    }


    /* 회원가입 완료 */

    alert("회원가입이 완료되었습니다.");

    location.href =
        "${pageContext.request.contextPath}/login";

}

</script>


</body>

</html>