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
    <title>欢喜食货</title>
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
            <a href="../orderlist">
                <span class="icon"><i class="fa fa-shopping-cart" aria-hidden="true"></i></span>
                <span class="title">Order</span>
            </a>
        </li>
        <li class="li">
            <a href="../allorder">
                <span class="icon"><i class="fa fa-list-alt" aria-hidden="true"></i></span>
                <span class="title">总订单</span>
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
                    <h1>Hello 欢喜食货</h1>
                    <p>Welcome to your admin dashboard</p>
                </div>
            </div>

            <!-- MAIN TITLE ENDS HERE -->

            <!-- MAIN CARDS STARTS HERE -->
            <div class="main__cards">
                <#-- -----------------用户量------------------------------->
                <div class="card">
                    <i
                            class="fa fa-user-o fa-2x text-lightblue"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">用户量</p>
                        <span class="font-bold text-title">578</span>
                    </div>
                </div>

                <#-- -----------------总订单------------------------------->
                <div class="card">
                    <i class="fa fa-calendar fa-2x text-red" aria-hidden="true"></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">总订单</p>
                        <span class="font-bold text-title">2467</span>
                    </div>
                </div>

                <#-- -----------------未发货订单------------------------------->
                <#assign order_no_deliver = 0>
                <#list orderlist as orderlist>
                    <#assign order_no_deliver = order_no_deliver+1 >
                </#list>
                <div class="card">
                    <i
                            class="fa fa-cart-plus fa-2x text-yellow"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">未发货订单</p>
                        <span class="font-bold text-title">${order_no_deliver}</span>
                    </div>
                </div>

                <#-- -----------------总交易金额------------------------------->
                <#assign totol_order_money = 0>
                <#list orderdetailist as orderdetailist>
                    <#assign totol_order_money = totol_order_money +  orderdetailist.good_price*orderdetailist.good_quantity >
                </#list>
                <div class="card">
                    <i
                            class="fa fa-money fa-2x text-green"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">总交易金额</p>
                        <span class="font-bold text-title">${totol_order_money}</span>
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