
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<title>欢喜食货(全部订单)</title>
<style>
    .searchInput{
        border-radius: 20px;
        font-size: 14px;
    }
    .sidebar ul li .allorderIcon{
        color: #11101d;
        background: #fff;
    }
</style>
<body>


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <main>
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="orderlist_name">全部订单</h2>
                </div>
                <div>
                    <button class="btn btn-danger my-3" data-toggle="modal" data-target="#confirmModal">
                        导出订单Excel
                    </button>
                </div>
            </div>
            <#--   页数       -->
            <div class="d-flex justify-content-between">
                <script>
                    var limitPerPage = 20;
                </script>
                <#include "../header/pagination.ftlh">
                <div class="form-inline col-xs-4">
                    <select class="form-select mr-2" name="date" class="date" onchange="dateSearch()">
                        <option value="">显示全部</option>
                        <option value="订单完成">订单完成</option>
                        <option value="待发货">待发货</option>
                        <option value="待收货">待收货</option>
                        <option value="待评价">待评价</option>
                        <option value="订单取消">订单取消</option>
                    </select>
                    <input class="form-control searchInput" type="text" id="myInput" onkeyup="mySearch()" placeholder="查找订单编号/用户名...">
                </div>
            </div>


            <#--  table start-->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-responsive-xl" id="myTable">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover text-center">
<#--                            <th>订单id</th>-->
<#--                            <th>open id</th>-->
                            <th>订单编号</th>
                            <th>姓名</th>
                            <th>地址</th>
                            <th>电话</th>
                            <th>运费</th>
                            <th>总金额(含运费)</th>
                            <th>创建时间</th>
                            <th>状态</th>
                            <th>物流</th>
                            <#--                            <th>删除</th>-->
                        </tr>
                        </thead>
                        <tbody id="loop">
                        <#list orderlist?sort_by("orderId")?reverse as order>
                            <tr class="list-group_name">
<#--                                <td>${order.orderId}</td>-->
<#--                                <td>${order.openId}</td>-->
                                <td><a href="/detail?orderId=${order.orderId}" target="_blank">${order.order_number}</a></td>
                                <td>${order.user_name}</td>
                                <td>${order.user_address}</td>
                                <td>${order.user_phone}</td>
                                <td>${order.order_express_fee}</td>
                                <td>${order.order_total_price_with_express_fee}</td>
                                <td>${order.order_create_time}</td>

                                <#if order.orderStatus == 0>
                                    <td><div class="finish_deliver">订单完成0</div></td>
                                <#elseif order.orderStatus == 1>
                                    <td><div class="prepare_deliver">待发货1</div></td>
                                <#elseif order.orderStatus == 2>
                                    <td><div class="wait_deliver">待收货2</div></td>
                                <#elseif order.orderStatus == 3>
                                    <td><div class="wait_comment">待评价3</div></td>
                                <#elseif order.orderStatus == 4>
                                    <td><div class="order_cancel">订单取消4</div></td>
                                </#if>
                                <#assign shipment_or_not = false >
                                <#list shipments as shipments>
                                    <#if shipments.orderNumber == order.order_number >
                                        <td><a class="btn btn-success btn-sm" href="https://m.kuaidi100.com/result.jsp?nu=${shipments.shipment_number}&com=jd" target="_blank">查看物流</a></td>
                                        <#assign shipment_or_not = true>
                                    </#if>
                                </#list>
                                <#if shipment_or_not == false >
                                    <td>无物流信息</td>
                                </#if>
<#--                                <td>查看物流</td>-->
                                    <#--                                <td><a class="btn btn-danger">删除</a>-->
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

<!-- Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">是否导出订单Excel</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="window.parent.location.href='/order/export';">导出</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript"  src="${path}/js/allorder.js"></script>

<#--分页面（页数）-->
<script type="text/javascript" src="${path}/js/pagination.js"></script>


</body>
</html>