<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <#include "../header/top.ftlh">
    <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
            integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
            crossorigin="anonymous"
    />
    <title>DASHBOARD</title>
</head>
<body id="body">
<div class="navigation">
    <ul>
        <li class="li">
            <a href="../home">
                <span class="icon"><i class="fa fa-home" aria-hidden="true"></i></span>
                <span class="title">Home</span>
            </a>
        </li>
        <li class="li">
            <a href="../admin">
                <span class="icon"><i class="fa fa-user" aria-hidden="true"></i></span>
                <span class="title">Admin</span>
            </a>
        </li>
        <li class="li">
            <a href="../category">
                <span class="icon"><i class="fa fa-lemon-o" aria-hidden="true"></i></span>
                <span class="title">Food category</span>
            </a>
        </li>
        <li class="li">
            <a href="../menulist">
                <span class="icon"><i class="fa fa-cutlery" aria-hidden="true"></i></span>
                <span class="title">Goods</span>
            </a>
        </li>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-shopping-cart" aria-hidden="true"></i></span>
                <span class="title">Order</span>
            </a>
        </li>
        <li class="li">
            <a href="../logout">
                <span class="icon"><i class="fa fa-sign-out" aria-hidden="true"></i></span>
                <span class="title">sign out</span>
            </a>
        </li>
    </ul>
</div>

<div class="toggle" onclick="toggleMenu()"></div>
<script type="text/javascript">
    function toggleMenu() {
        let navigation = document.querySelector('.navigation');
        let toggle = document.querySelector('.toggle');
        navigation.classList.toggle('active');
        toggle.classList.toggle('active');
    }
</script>
<div class="container1">
    <#include "../header/navbar.ftlh">
    <main>
        <div class="main__container">
            <!-- MAIN TITLE STARTS HERE -->

            <div class="main__title">
                <img src="${path}/img/hello.svg" alt="" />
                <div class="main__greeting">
                    <h1>Hello Codersbite</h1>
                    <p>Welcome to your admin dashboard</p>
                </div>
            </div>

            <!-- MAIN TITLE ENDS HERE -->

            <!-- MAIN CARDS STARTS HERE -->
            <div class="main__cards">
                <div class="card">
                    <i
                            class="fa fa-user-o fa-2x text-lightblue"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p">Number of Subscribers</p>
                        <span class="font-bold text-title">578</span>
                    </div>
                </div>

                <div class="card">
                    <i class="fa fa-calendar fa-2x text-red" aria-hidden="true"></i>
                    <div class="card_inner">
                        <p class="text-primary-p">Times of Watching</p>
                        <span class="font-bold text-title">2467</span>
                    </div>
                </div>

                <div class="card">
                    <i
                            class="fa fa-video-camera fa-2x text-yellow"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p">Number of Videos</p>
                        <span class="font-bold text-title">340</span>
                    </div>
                </div>

                <div class="card">
                    <i
                            class="fa fa-thumbs-up fa-2x text-green"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p">Number of Likes</p>
                        <span class="font-bold text-title">645</span>
                    </div>
                </div>
            </div>
            <!-- MAIN CARDS ENDS HERE -->

            <!-- CHARTS STARTS HERE -->
            <div class="charts">
                <div class="charts__left">
                    <div class="charts__left__title">
                        <div>
                            <h1>Daily Reports</h1>
                            <p>Cupertino, California, USA</p>
                        </div>
                        <i class="fa fa-usd" aria-hidden="true"></i>
                    </div>
                    <div id="apex1"></div>
                </div>

                <div class="charts__right">
                    <div class="charts__right__title">
                        <div>
                            <h1>Stats Reports</h1>
                            <p>Cupertino, California, USA</p>
                        </div>
                        <i class="fa fa-usd" aria-hidden="true"></i>
                    </div>

                    <div class="charts__right__cards">
                        <div class="card1">
                            <h1>Income</h1>
                            <p>$75,300</p>
                        </div>

                        <div class="card2">
                            <h1>Sales</h1>
                            <p>$124,200</p>
                        </div>

                        <div class="card3">
                            <h1>Users</h1>
                            <p>3900</p>
                        </div>

                        <div class="card4">
                            <h1>Orders</h1>
                            <p>1881</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- CHARTS ENDS HERE -->
        </div>
    </main>
</div>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="${path}/js/home.js"></script>
</body>
</html>