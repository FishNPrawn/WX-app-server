
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
                    <h2 class="orderlist_name">待发货订单</h2>
                </div>
                <div>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#modal-test" id="addCategory">
                        添加订单
                    </button>
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
                            <th>删除订单</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list orderlist?sort_by("orderId")?reverse as order>
                            <tr>
                                <#if order.orderStatus == 1>
                                    <td>${order.orderId}</td>
                                    <td>${order.openId}</td>
                                    <td>${order.order_number}</td>
                                    <td>${order.user_name}</td>
                                    <td>${order.user_address}</td>
                                    <td>${order.user_phone}</td>
                                    <td>${order.order_total_price}</td>
                                    <td>${order.order_create_time}</td>
                                    <td><div class="prepare_deliver">待发货1</div></td>
                                    <td><a class="btn btn-primary btn-sm" href="/detail?orderId=${order.orderId}">详情</a>
                                    <td><a class="btn btn-danger btn-sm text-white" data-toggle="modal" data-target="#confirmModal${order.orderId}">删除订单</a></td>
                                    <!-- Modal -->
                                    <div class="modal fade" id="confirmModal${order.orderId}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">是否取消订单</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                                                    <button type="button" class="btn btn-danger" onclick="window.parent.location.href='/order/cancelOrderServer?orderId=${order.orderId}';">取消订单</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

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


<script type="text/javascript"  src="${path}/js/createorder.js"></script>


</body>
</html>