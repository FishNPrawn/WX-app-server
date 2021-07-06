
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
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

            <#--  table start-->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover text-center">
                            <th>订单id</th>
                            <th>open id</th>
                            <th>订单编号</th>
                            <th>用户名</th>
                            <th>地址</th>
                            <th>电话</th>
                            <th>订单金额</th>
                            <th>创建时间</th>
                            <th>状态</th>
                            <th>详情</th>
                            <#--                            <th>删除</th>-->
                        </tr>
                        </thead>
                        <tbody>
                        <#list orderlist as order>
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.openId}</td>
                                <td>${order.order_number}</td>
                                <td>${order.user_name}</td>
                                <td>${order.user_address}</td>
                                <td>${order.user_phone}</td>
                                <td>${order.order_total_price}</td>
                                <td>${order.order_create_time}</td>

                                <#if order.orderStatus == 0>
                                    <td><div class="finish_deliver">订单完成0</div></td>
                                <#elseif order.orderStatus == 1>
                                    <td><div class="prepare_deliver">待发货1</div></td>
                                <#elseif order.orderStatus == 2>
                                    <td><div class="wait_deliver">待收货2</div></td>
                                <#elseif order.orderStatus == 3>
                                    <td><div class="wait_comment">待评价3</div></td>
                                </#if>

                                <td><a class="btn btn-primary btn-sm" href="/detail?orderId=${order.orderId}">详情</a>

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

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/style.js"></script>


</body>
</html>