
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
                    <a class="btn btn-warning text-white my-3" onclick="history.go(-1)">返回</a>
                    <button class="btn btn-danger text-white my-3" data-toggle="modal" data-target="#confirmModal">
                        发货
                    </button>
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
                        <#assign order_price = 0>
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
                            <#assign order_price = order_price + orderdetail.good_quantity*orderdetail.good_price>
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
                        <#assign user_name = order.user_name>
                        <#assign user_phone = order.user_phone>
                        <#assign user_address = order.user_address>
                        <#assign order_number = order.order_number>
                    </#if>
                </#list>
            </#list>
            <table class="table mt-5 table-striped" style="width: 60%">
                <tr>
                    <td class="column" style="width: 20%">订单编号</td>
                    <td>${order_number}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">姓名</td>
                    <td>${user_name}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">电话</td>
                    <td>${user_phone}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">配送地址</td>
                    <td>${user_address}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">备注</td>
                    <td>${comment}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">总价格</td>
                    <td>${order_price}</td>
                </tr>
            </table>
        </div>
    </main>


</div>

<!-- Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">是否确认发货</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary">发货</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>