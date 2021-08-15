
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link rel="stylesheet" href="${path}/css/promoCodeDetail.css">
<title>欢喜食货(团长)</title>
<body>

<#list promocode as promocode>
    <#if promocode.promoCodeHeaderId == promo_code_header_id  >
        <#assign username = promocode.username>
        <#assign phone = promocode.phone>
        <#assign city = promocode.city>
        <#assign address = promocode.address>
        <#assign commission_rate = promocode.commission_rate>
    </#if>
</#list>

<#assign order_number = 0>
<#list orderlist as order>
    <#if order.promoCodeHeaderId == promo_code_header_id>
        <#assign order_number = order_number + 1>
    </#if>
</#list>

<#assign total_price_without_express_fee = 0>
<#list orderlist as order>
    <#if order.promoCodeHeaderId == promo_code_header_id>
        <#assign total_price_without_express_fee = total_price_without_express_fee + order.order_total_price>
    </#if>
</#list>
<#assign earning = total_price_without_express_fee * commission_rate>

<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <main>
        <div id="page-content-wrapper" class="container">
            <div class="d-flex">
                <div class="center">
                    <h2 class="orderlist_name">团长: ${username}</h2>
                </div>
            </div>
            <div class="commander_wrapper">
                <div class="commander_box commander_box1">
                    <i class="fa fa-info fa-2x text-white" aria-hidden="true"></i>
                    <div class="commander_box_info_title">
                        <div class="commander_box_info_info_title">电话</div>
                        <div class="commander_box_info_info_title mt-2">城市</div>
                        <div class="commander_box_info_info_title mt-2">地址</div>
                    </div>
                    <div class="commander_box_info_value">
                        <div class="commander_box_info_info_value">${phone}</div>
                        <div class="commander_box_info_info_value mt-2">${city}</div>
                        <div class="commander_box_info_info_value mt-2">${address}</div>
                    </div>
                </div>
                <div class="commander_box commander_box2">
                    <i class="fa fa-calendar fa-2x text-white" aria-hidden="true"></i>
                    <div class="commander_box_info commander_box2_info">
                        <div class="commander_box2_info_title">
                            <div>订单数量</div>
                            <div>订单总额</div>
                        </div>
                        <div class="commander_box2_info_value">
                            <div>${order_number}</div>
                            <div class="d-flex">${total_price_without_express_fee} <div class="ml-1">RMB</div> </div>
                        </div>
                    </div>
                </div>
                <div class="commander_box commander_box3">
                    <i class="fa fa-money fa-2x text-white" aria-hidden="true"></i>
                    <div class="commander_box_info commander_box3_info">
                        <div class="commander_box3_info_title">
                            <div>团长佣金率</div>
                            <div>赚取佣金</div>
                        </div>
                        <div class="commander_box3_info_value">
                            <div>${commission_rate}</div>
                            <div class="d-flex">${earning} <div class="ml-1">RMB</div></div>
                        </div>
                    </div>
                </div>
            </div>




            <#--  table start-->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-responsive-xl">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover text-center">
                            <th>订单编号</th>
                            <th>姓名</th>
                            <th>总重量(g)</th>
                            <th>运费</th>
                            <th>金额(不含运费)</th>
                            <th>总金额(含运费)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list orderlist?sort_by("orderId")?reverse as order>
                            <tr>
                                <#if order.promoCodeHeaderId == promo_code_header_id>
                                    <td><a href="/detail?orderId=${order.orderId}" target="_blank">${order.order_number}</a></td>
                                    <td>${order.user_name}</td>
                                    <td>${order.order_total_weight}</td>
                                    <td>${order.order_express_fee}</td>
                                    <td>${order.order_total_price}</td>
                                    <td>${order.order_total_price_with_express_fee}</td>
                                </#if>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
            <#--  table end-->
        </div>
    </main>
</div>


<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/createorder.js"></script>


</body>
</html>