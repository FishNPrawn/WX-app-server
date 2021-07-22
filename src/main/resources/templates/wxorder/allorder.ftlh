
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<style>
    .searchInput{
        border-radius: 20px;
        font-size: 14px;
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
                <#include "../header/pagination.ftlh">
                <div class="form-outline col-xs-4">
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
                            <th>总金额</th>
                            <th>创建时间</th>
                            <th>状态</th>
                            <#--                            <th>删除</th>-->
                        </tr>
                        </thead>
                        <tbody id="loop">
                        <#list orderlist?sort_by("orderStatus") as order>
                            <tr class="list-group_name">
<#--                                <td>${order.orderId}</td>-->
<#--                                <td>${order.openId}</td>-->
                                <td><a href="/detail?orderId=${order.orderId}">${order.order_number}</a></td>
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
                                <#elseif order.orderStatus == 4>
                                    <td><div class="order_cancel">订单取消4</div></td>
                                </#if>
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

<#--分页面（页数）-->
<script type="text/javascript" src="${path}/js/pagination.js"></script>

<script>
    function mySearch() {
        // Declare variables
        var input, filter, table, tr, td, td_username, i, txtValue, txtUserNameValue;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
            td_username = tr[i].getElementsByTagName("td")[1];
            if (td || td_username) {
                txtValue = td.textContent || td.innerText;
                txtUserNameValue = td_username.textContent || td_username.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1 || txtUserNameValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }

        }
    }
</script>

</body>
</html>