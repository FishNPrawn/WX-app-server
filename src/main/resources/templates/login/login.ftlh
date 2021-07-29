<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<#include "../header/top.ftlh">
<link rel="stylesheet" type="text/css" href="${path}/css/login.css">
<body>
<img class="wave" src="img/wave.png">
<div class="container">
    <div class="img">
        <img src="${path}/img/bg.svg">
    </div>
    <div class="login-content">
        <form method="POST" th:action="@{/login}">
            <img src="${path}/img/avatar.svg">
            <h3 class="title">欢喜食货</h3>
            <div class="input-div one">
                <div class="i">
                    <i class="fa fa-user login_icon_size"></i>
                </div>
                <div class="div">
                    <h5>用户名</h5>
                    <input type="text" class="input" id="username" name="username" required autofocus>
                </div>
            </div>
            <div class="input-div pass">
                <div class="i">
                    <i class="fa fa-lock login_icon_size"></i>
                </div>
                <div class="div">
                    <h5>密码</h5>
                    <input type="password" class="input" id="password" name="password" required>
                </div>
            </div>
            <input name="_csrf" type="hidden" value="f97158be-e75c-4eb7-8824-df46b9365eb1" />
            <input type="submit" id="loginBtn" class="btn" value="Login">
        </form>
    </div>
</div>
<script type="text/javascript" src="${path}/js/login.js"></script>
</body>
</html>