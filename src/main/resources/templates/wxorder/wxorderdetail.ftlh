
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
                    <button class="btn btn-primary text-white my-3" data-modal-target="#modal-test" id="addCategory">
                        添加
                    </button>
                    <button class="btn btn-danger text-white my-3">
                        发货
                    </button>
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
                        <#assign order_id_val = order.orderId>
                        <#assign orderId = order.orderId>
                    </#if>
                </#list>
            </#list>

            <#--  table start-->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-bordered" id="table">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover text-center">
                            <th>order_detail_id</th>
                            <th>订单编号</th>
                            <th>good_id</th>
                            <th>商品图</th>
                            <th>商品名</th>
                            <th>商品价格</th>
                            <th>数量</th>
                            <th>总额</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#assign order_price = 0>
                        <#list orderDTO.orderDetailList as orderdetail>
                            <tr>
                                <td>${orderdetail.order_detail_id}</td>
                                <td>${orderdetail.order_number}</td>
                                <td>${orderdetail.good_id}</td>
                                <td><img height="40" width="40" src="${orderdetail.good_image}"></td>
                                <td>${orderdetail.good_name}</td>
                                <td>${orderdetail.good_price}</td>
                                <td>${orderdetail.good_quantity}</td>
                                <td>${orderdetail.good_quantity*orderdetail.good_price}</td>
                                <td><a class="btn btn-danger btn-sm text-white"  data-toggle="modal" data-target="#confirmModal">删除</a>
                                <!-- Modal -->
                                <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">是否取消商品订单</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">否</button>
                                                <a type="button" class="btn btn-danger" href="./detail?orderId=${order_id_val}" onclick="sendDeleteRequest(`${orderdetail.order_detail_id}`)">删除</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </tr>
                            <#assign order_price = order_price + orderdetail.good_quantity*orderdetail.good_price>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>

            <table class="table mt-5 table-striped" style="width: 60%">
                <tr>
                    <td class="column" style="width: 20%">订单编号</td>
                    <td id="order_number">${order_number}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">order_id</td>
                    <td id="order_id">${orderId}</td>
                </tr>
                <tr>
                    <td class="column" style="width: 20%">姓名</td>
                    <td id="user_name">${user_name}</td>
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



<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加订单商品</div>
        <button data-close-button class="close-button-test" id="cat_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="cat-window">
        <div class="form-group">
            <label>选择商品</label>
            <select class="form-select mx-sm-3 mb-2" name="all_good" id="all_good">
                <#list menulist as good>
                    <option value='{"good_id":"${good.good_id}","good_price":"${good.good_price}", "good_image": "${good.good_image}"}'>${good.good_name}</option>
                </#list>
            </select>
        </div>
        <div class="form-inline">
            <label>商品价格</label>
            <input class="form-control mx-sm-3 mb-2 w-25" type="text" value="价格" id="good_price" readonly>
            <label>数量</label>
            <input type="number" id="good_quantity" class="form-control mx-sm-3 mb-2 w-25" required/>
        </div>
        <a href="/detail?orderId=${orderId}" id="add_good_detail" class="btn btn-info btn-dark">添加</a>
    </div>
</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/wxorderdetail.js"></script>

</body>
</html>