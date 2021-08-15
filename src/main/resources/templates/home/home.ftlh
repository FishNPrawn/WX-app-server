<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <#include "../header/top.ftlh">
    <link rel="stylesheet" type="text/css" href="${path}/css/sidebar.css">
    <style>
        .sidebar ul li .homeIcon{
            color: #11101d;
            background: #fff;
        }
    </style>
    <title>欢喜食货</title>
</head>
<body id="body">

<div class="sidebar nav__menu nav" id="nav-menu">
    <ul class="nav_list">
        <li>
            <a href="../home" class="homeIcon">
                <i class='bx bx-home-alt'></i>
                <span class="links_name">主页面</span>
            </a>
            <span class="tooltip">主页面</span>
        </li>
        <li>
            <a href="../admin">
                <i class='bx bx-user' ></i>
                <span class="links_name">管理员</span>
            </a>
            <span class="tooltip">管理员</span>
        </li>
        <li>
            <a href="../userInfoList">
                <i class="fa fa-weixin" aria-hidden="true"></i>
                <span class="links_name">微信用户</span>
            </a>
            <span class="tooltip">微信用户</span>
        </li>
        <li>
            <a href="../promocode">
                <i class='bx bxs-coupon'></i>
                <span class="links_name">团长码</span>
            </a>
            <span class="tooltip">团长码</span>
        </li>
        <li>
            <a href="../category">
                <i class='bx bx-category'></i>
                <span class="links_name">食品分类</span>
            </a>
            <span class="tooltip">食品分类</span>
        </li>
        <li>
            <a href="../menulist">
                <i class="fa fa-cutlery"></i>
                <span class="links_name">商品列表</span>
            </a>
            <span class="tooltip">商品列表</span>
        </li>
        <li>
            <a href="../orderlist">
                <i class='bx bx-list-ol' ></i>
                <span class="links_name">待发货订单</span>
            </a>
            <span class="tooltip">待发货订单</span>
        </li>
        <li>
            <a href="../cancelorder">
                <i class='bx bx-list-minus'></i>
                <span class="links_name">已取消订单</span>
            </a>
            <span class="tooltip">已取消订单</span>
        </li>
        <li>
            <a href="../allorder">
                <i class='bx bx-list-check' ></i>
                <span class="links_name">全部订单</span>
            </a>
            <span class="tooltip">全部订单</span>
        </li>
        <li>
            <a href="../commentList">
                <i class='fa fa-comment-o' ></i>
                <span class="links_name">用户评论</span>
            </a>
            <span class="tooltip">用户评论</span>
        </li>
        <li>
            <a href="../swiper">
                <i class='fa fa-picture-o' ></i>
                <span class="links_name">轮播图</span>
            </a>
            <span class="tooltip">轮播图</span>
        </li>
    </ul>
    <div class="profile_content">
        <div class="profile">
            <a href='../logout'>
                <i class='bx bx-log-out' id="log_out" ></i>
            </a>
        </div>
    </div>
    <i class="fa fa-times nav__close" id="nav-close"></i>
</div>

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
                <#-- -----------------总交易金额------------------------------->
                <#assign userCount = 0>
                <#list userInfoList as userInfoList>
                    <#assign userCount = userCount +  1 >
                </#list>
                <div class="card_wrapper">
                    <i
                            class="fa fa-user-o fa-2x text-lightblue"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">用户量</p>
                        <span class="font-bold text-title">${userCount}</span>
                    </div>
                </div>

                <#-- -----------------总订单------------------------------->
                <#assign totol_order = 0>
                <#list orderlist as orderlist>
                    <#assign totol_order = totol_order+1 >
                </#list>
                <div class="card_wrapper">
                    <i class="fa fa-calendar fa-2x text-red" aria-hidden="true"></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">总订单</p>
                        <span class="font-bold text-title">${totol_order}</span>
                    </div>
                </div>

                <#-- -----------------未发货订单------------------------------->
                <#assign order_finish = 0>
                <#assign order_no_deliver = 0>
                <#assign order_wait_get_number = 0>
                <#assign order_wait_comment= 0>
                <#assign order_cancel_number = 0>
                <#list orderlist as orderlist>
                    <#if (orderlist.orderStatus) == 0>
                        <#assign order_finish = order_finish+1 >
                    </#if>
                    <#if (orderlist.orderStatus) == 1>
                        <#assign order_no_deliver = order_no_deliver+1 >
                    </#if>
                    <#if (orderlist.orderStatus) == 2>
                        <#assign order_wait_get_number = order_wait_get_number+1 >
                    </#if>
                    <#if (orderlist.orderStatus) == 3>
                        <#assign order_wait_comment = order_wait_comment+1 >
                    </#if>
                    <#if (orderlist.orderStatus) == 4>
                        <#assign order_cancel_number = order_cancel_number+1 >
                    </#if>
                </#list>
                <div class="card_wrapper">
                    <i
                            class="fa fa-calendar-check-o fa-2x text-yellow"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">已完成订单</p>
                        <span class="font-bold text-title">${order_no_deliver}</span>
                    </div>
                </div>

                <#-- -----------------总交易金额------------------------------->
                <#assign totol_order_money = 0>
                <#list orderdetailist as orderdetailist>
                    <#assign totol_order_money = totol_order_money +  orderdetailist.good_price*orderdetailist.good_quantity >
                </#list>
                <div class="card_wrapper">
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
                            <h1>订单报告</h1>
                            <p>Cupertino, California, USA</p>
                        </div>
                        <i class="fa fa-usd" aria-hidden="true"></i>
                    </div>

                    <div class="charts__right__cards">
                        <div class="card1">
                            <h1>待发货</h1>
                            <p>${order_no_deliver}</p>
                        </div>

                        <div class="card2">
                            <h1>待收货</h1>
                            <p>${order_wait_get_number}</p>
                        </div>

                        <div class="card3">
                            <h1>待评价</h1>
                            <p>${order_wait_comment}</p>
                        </div>

                        <div class="card4">
                            <h1>订单取消</h1>
                            <p>${order_cancel_number}</p>
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
<script type="text/javascript" src="${path}/js/showmenu.js"></script>
</body>
</html>