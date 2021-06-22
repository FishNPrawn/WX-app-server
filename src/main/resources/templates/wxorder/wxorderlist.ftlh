
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<body>


<div id="wrapper" class="toggled">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <div id="page-content-wrapper" class="container">
        <div class="d-flex justify-content-between">
            <div class="center">
                <h2 class="orderlist_name">订单管理</h2>
            </div>
            <div>
                <button class="btn border my-3">
                    导出订单
                </button>
            </div>
        </div>

        <#--  table start-->
        <div class="row clearfix">
            <div class="col-md-12 column">
                <table class="table table-bordered">
                    <thead class="thead-dark">
                    <tr class="table-info  table-hover">
                        <th>订单id</th>
                        <th>订单编号</th>
                        <th>用户名</th>
                        <th>地址</th>
                        <th>电话</th>
                        <th>订单金额</th>
                        <th>创建时间</th>
                        <th>评论</th>
                        <th>详情</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list orderlist as order>
                        <tr>
                            <td>${order.order_id}</td>
                            <td>${order.order_number}</td>
                            <td>${order.user_name}</td>
                            <td>${order.user_address}</td>
                            <td>${order.user_phone}</td>
                            <td>${order.order_total_price}</td>
                            <td>${order.order_create_time}</td>
                            <td>${order.order_comment}</td>
                            <td><a class="btn btn-primary" href="/detail?orderId=${order.order_id}">详情</a>
                            <td><a class="btn btn-danger">删除</a>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>
        <#--  table end-->

    </div>
</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/style.js"></script>


</body>
</html>