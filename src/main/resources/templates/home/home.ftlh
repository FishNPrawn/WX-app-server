<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <#include "../header/top.ftlh">
<#--    <link rel="stylesheet" type="text/css" href="${path}/css/sidebar.css">-->
    <style>
        .sidebar ul li .homeIcon{
            color: #11101d;
            background: #fff;
        }
    </style>
    <title>欢喜食货</title>
</head>
<body id="body">

<div class="container1">
    <#include "../header/sidebar.ftlh">

    <#if !isAdmin??>
    <main>
        <div class="container">
            <div class="d-flex justify-content-between">
                <div class="center d-flex">
                    <img width="200" src="https://fnpphoto.cn/backend/avatar.jpg" alt="" style="border-radius: 50%;"/>
                    <h2 class="d-flex text-center align-content-center align-items-center">您不是管理员，没有管理权限</h2>
                </div>
            </div>
        </div>
    </main>
    <#else >
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
                <a class="card_wrapper text-decoration-none" href="../userInfoList">
                    <i
                            class="fa fa-user-o fa-2x text-lightblue"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">用户量</p>
                        <span class="font-bold text-title">${userCount}</span>
                    </div>
                </a>

                <#-- -----------------总订单------------------------------->
                <#assign totol_order = 0>
                <#list orderlist as orderlist>
                    <#assign totol_order = totol_order+1 >
                </#list>
                <a class="card_wrapper text-decoration-none" href="../allorder">
                    <i class="fa fa-calendar fa-2x text-red" aria-hidden="true"></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">总订单</p>
                        <span class="font-bold text-title">${totol_order}</span>
                    </div>
                </a>

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

                <#assign refund_total = 0>
                <#list orderRefundList as orderRefundList>
                    <#assign refund_total = refund_total + orderRefundList.refund_price>
                </#list>
                <a class="card_wrapper text-decoration-none" href="../orderRefund">
                    <i
                            class="fa fa-times fa-2x text-yellow"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">退款金额</p>
                        <span class="font-bold text-title">${refund_total}</span>
                    </div>
                </a>

                <#-- -----------------总交易金额------------------------------->
                <#assign totol_order_money = 0>
                <#list orderlist as orderlist>
                    <#assign totol_order_money = totol_order_money+orderlist.order_total_price_with_express_fee >
                </#list>

                <a class="card_wrapper text-decoration-none" href="../allorder">
                    <i
                            class="fa fa-money fa-2x text-green"
                            aria-hidden="true"
                    ></i>
                    <div class="card_inner">
                        <p class="text-primary-p mt-3">总交易金额</p>
                        <span class="font-bold text-title">${totol_order_money}</span>
                    </div>
                </a>
            </div>
            <!-- MAIN CARDS ENDS HERE -->
            <#assign pay_supplier_total = 0>
            <#list paySupplierList as paySupplierList>
                <#assign pay_supplier_total = pay_supplier_total + paySupplierList.pay_supplier_price>
            </#list>
            <#assign earning = totol_order_money - refund_total - pay_supplier_total>
            <!-- CHARTS STARTS HERE -->
            <div class="charts">
                <div class="charts__left">
                    <div class="charts__left__title">
                        <div>
                            <h1>资金</h1>
<#--                            <p>Cupertino, California, USA</p>-->
                        </div>
                        <i class="fa fa-usd" aria-hidden="true"></i>
                    </div>
<#--                    <div id="apex1"></div>-->
                    <div class="charts__right__cards">
                        <a class="card5 text-decoration-none" href="../allorder">
                            <h1>总交易金额</h1>
                            <p>$${totol_order_money}</p>
                        </a>

                        <div class="card6">
                            <h1>收益</h1>
                            <p>$${earning}</p>
                        </div>

                        <a class="card7 text-decoration-none" href="../orderRefund">
                            <h1>商家退款</h1>
                            <p>$${refund_total}</p>
                        </a>

                        <a class="card8 text-decoration-none" href="../paySupplier">
                            <h1>供应商结算</h1>
                            <p>$${pay_supplier_total}</p>
                        </a>
                    </div>
                </div>

                <div class="charts__right">
                    <div class="charts__right__title">
                        <div>
                            <h1>订单报告</h1>
<#--                            <p>Cupertino, California, USA</p>-->
                        </div>
                        <i class="fa fa-usd" aria-hidden="true"></i>
                    </div>

                    <div class="charts__right__cards">
                        <a class="card1 text-decoration-none" href="../orderlist">
                            <h1>待发货</h1>
                            <p>${order_no_deliver}</p>
                        </a>

                        <div class="card2">
                            <h1>待收货</h1>
                            <p>${order_wait_get_number}</p>
                        </div>

                        <div class="card3">
                            <h1>待评价</h1>
                            <p>${order_wait_comment}</p>
                        </div>

                        <a class="card4 text-decoration-none" href="../cancelorder">
                            <h1>订单取消</h1>
                            <p>${order_cancel_number}</p>
                        </a>
                    </div>
                </div>
            </div>
            <!-- CHARTS ENDS HERE -->
        </div>
    </main>
    </#if>
</div>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="${path}/js/home.js"></script>
<script type="text/javascript" src="${path}/js/showmenu.js"></script>
</body>
</html>