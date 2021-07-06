
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<body>


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <main>
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="orderlist_name">订单详情</h2>
                </div>
                <div>
                    <a class="btn btn-warning text-white my-3" href="../orderlist">返回</a>
                </div>
            </div>

            <#--  table start-->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover text-center">
                            <th>order_detail_id</th>
                            <th>订单编号</th>
                            <th>good_id</th>
                            <th>商品名</th>
                            <th>商品价格</th>
                            <th>数量</th>
                            <th>总额</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list orderDTO.orderDetailList as orderdetail>
                            <tr>
                                <td>${orderdetail.order_detail_id}</td>
                                <td>${orderdetail.order_number}</td>
                                <td>${orderdetail.good_id}</td>
                                <td>${orderdetail.good_name}</td>
                                <td>${orderdetail.good_price}</td>
                                <td>${orderdetail.good_quantity}</td>
                                <td>${orderdetail.good_quantity*orderdetail.good_price}</td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
            <#--  table end-->
            <#list orderlist as order>
                <#list orderDTO.orderDetailList as orderdetail>
                    <#if order.orderId == orderDTO.orderId  >
                        <#assign comment = order.order_comment>

                    </#if>
                </#list>
            </#list>
            ${comment}
        </div>
    </main>


</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/style.js"></script>


</body>
</html>