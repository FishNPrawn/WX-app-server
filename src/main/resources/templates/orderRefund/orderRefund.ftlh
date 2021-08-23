
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link rel="stylesheet" href="${path}/css/wxorderdetail.css">
<title>欢喜食货(待发货订单)</title>
<style>
    .sidebar ul li .orderRefundIcon{
        color: #11101d;
        background: #fff;
    }
    .modal-body-test{
        max-height: calc(100vh - 300px);
        overflow-y: auto;
    }
</style>
<body>
<#assign total_refund_price = 0 >
<#list orderRefundList as orderRefundList>
    <#assign total_refund_price = total_refund_price + orderRefundList.refund_price>
</#list>


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <main>
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="center">
                <h2 class="category_name">退款列表</h2>
            </div>
            <div class="d-flex justify-content-between">
                <div class="d-flex align-items-center mt-2">
                    <input type="date" id="min_date" onchange="min_date_change()">
                    <h5 class="pl-1 pr-1 mt-1">To</h5>
                    <input type="date" id="max_date" onchange="max_date_change()">
                    <button class="btn btn-success btn-sm ml-2" onclick="confirmDate()">提交</button>
                    <button class="btn btn-danger btn-sm ml-2" onclick="clearDate()">清除</button>
                </div>
                <div class="d-flex">
                    <h4 class="d-flex align-items-center text-center pr-4 mt-2 text-danger">退款总金额: ${total_refund_price}</h4>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#orderRefund_modal-test" id="addOrderRefund">
                        添加
                    </button>
                </div>
            </div>
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <table class="table table-responsive-xl" id="myTable">
                            <thead class="thead-dark">
                            <tr class="table-info table-hover text-center">
                                <th class="d-none">id</th>
                                <th>订单编号</th>
                                <th>商品名</th>
                                <th>数量</th>
                                <th>退款金额</th>
                                <th>备注</th>
                                <th>时间</th>
                                <th>修改</th>
                                <th>删除</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list orderRefundList?sort_by("order_refund_id")?reverse as orderRefundList>
                                <tr>
                                    <td class="order_refund_id d-none">${orderRefundList.order_refund_id}</td>
                                    <td class="order_number_text">${orderRefundList.orderNumber}</td>
                                    <td class="good_name_text">${orderRefundList.good_name}</td>
                                    <td class="good_quantity_text">${orderRefundList.good_quantity}</td>
                                    <td class="refund_price_text">${orderRefundList.refund_price}</td>
                                    <td class="refund_remark_text">${orderRefundList.refund_remark}</td>
                                    <td id="abc">${orderRefundList.order_refund_time}</td>
                                    <td><a class="btn btn-primary btn-sm" data-modal-target="#update_orderRefund_modal-test" onclick="updateOrderRefund(this)" href = "#" >修改</a>
                                    <td><a class="btn btn-danger btn-sm" onclick="deleteOrderRefund(`${orderRefundList.order_refund_id}`)" href = "/orderRefund/addsuccess">删除</a>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
        </div>
    </main>
</div>

<#--添加-->
<div class="modal-test" id="orderRefund_modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加退款</div>
        <button data-close-button class="close-button-test" id="orderRefund_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="orderRefund-window">
        <form role="form">
            <div class="form-group">
                <label>订单编号</label>
                <input id="order_number_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>商品名</label>
                <input id="good_name_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>数量</label>
                <input id="good_quantity_input" type="number" class="form-control"/>
            </div>

            <div class="form-group">
                <label>退款金额</label>
                <input id="refund_price_input" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>备注(可不填)</label>
                <input id="refund_remark_input" type="text" class="form-control"/>
            </div>
            <a href="/orderRefund/addsuccess" id="add_orderRefund" class="btn btn-info btn-dark">添加</a>
        </form>
    </div>
</div>

<#--修改-->
<div class="modal-test" id="update_orderRefund_modal-test">
    <div class="modal-header-test">
        <div class="title-test">修改退款</div>
        <button data-close-button class="close-button-test" id="update_orderRefund_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="orderRefund-window">
        <form role="form">
            <div class="form-group">
                <label>订单编号</label>
                <input id="update_order_number_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>商品名</label>
                <input id="update_good_name_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>数量</label>
                <input id="update_good_quantity_input" type="number" class="form-control"/>
            </div>

            <div class="form-group">
                <label>退款金额</label>
                <input id="update_refund_price_input" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>备注(可不填)</label>
                <input id="update_refund_remark_input" type="text" class="form-control"/>
            </div>
            <a href="/orderRefund/addsuccess" id="update_orderRefund" class="btn btn-info btn-dark">修改</a>
        </form>
    </div>
</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/orderRefund.js"></script>

</body>
</html>