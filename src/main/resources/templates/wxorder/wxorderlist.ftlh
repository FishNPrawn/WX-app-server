
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link rel="stylesheet" href="${path}/css/wxorderdetail.css">
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
                    <table class="table table-responsive-xl">
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
                            <th>详情</th>
                            <th>删除订单</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list orderlist?sort_by("orderId")?reverse as order>
                            <tr>
                                <#if order.orderStatus == 1>
<#--                                    <td>${order.orderId}</td>-->
<#--                                    <td>${order.openId}</td>-->
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

<div class="modal-test" id="modal-test" style="width: 44%;">
    <div class="modal-header-test">
        <div class="title-test">添加订单</div>
        <button data-close-button class="close-button-test" id="close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="good-window">
        <form action="#" autocomplete="on">
            <div class="form-group">
                <div class="form-inline">
                    <label>姓名</label>
                    <input class="form-control mx-sm-3 w-25" type="text" value="" id="user_name" autocomplete="on" required oninvalid="this.setCustomValidity('填写姓名')">
                    <label>电话</label>
                    <input type="text" class="form-control mx-sm-3"  id="user_phone" style="width: 25%;" autocomplete="on" required oninvalid="this.setCustomValidity('填写电话')"/>
                </div>
                <div class="form-inline">
                    <label>地址</label>
                    <input class="form-control mx-sm-3 mb-2 mt-2" type="text" value="" style="width: 84%;" id="user_address" autocomplete="on" required oninvalid="this.setCustomValidity('填写地址')">
                </div>
                <div class="form-inline">
                    <label>总价</label>
                    <input class="form-control mx-sm-3 mb-2 w-25 mt-2" type="text" value="" id="order_total_price" readonly>
                </div>
                <div class="d-flex justify-content-between">
                    <div class="center d-flex orderlist_name">
                        <span class="orderlist_name_line"></span>
                        <div class="d-flex align-items-center text-center ml-2 mt-1">
                            <h6>商品详情</h6>
                        </div>
                    </div>
                    <button class="btn btn-primary text-white my-3 btn-sm mt-4" id="addGoodList" type="button">
                        添加商品
                    </button>
                </div>
                <div>
                    <table class="table table-striped" id="new_order_table">
                        <thead>
                        <tr class="text-center">
                            <th>商品名</th>
                            <th>单价</th>
                            <th>数量</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody id="goods_list">
<#--                            <tr class="list-group_name" id="list-group_name">-->
<#--                                <td class="good_name">-->
<#--                                    <select class="form-select form-select-sm" name="all_good" id="all_good">-->
<#--                                        <#list menulist as good>-->
<#--                                            <option value='{"good_id":"${good.good_id}","good_price":"${good.good_price}", "good_image": "${good.good_image}"}'>${good.good_name}</option>-->
<#--                                        </#list>-->
<#--                                    </select>-->
<#--                                </td>-->
<#--                                <td class="good_price">-->
<#--                                    <input class="form-control form-control-sm mx-sm-3 good_price" type="text" value="" id="good_price" readonly>-->
<#--                                </td>-->
<#--                                <td class="good_quantity">-->
<#--                                    <input class="form-control form-control-sm mx-sm-3 good_quantity" type="number" value="" id="good_quantity">-->
<#--                                </td>-->
<#--                                <td onclick="deleteRow(this)">-->
<#--                                    <button class="d-flex align-items-center justify-content-center text-center btn btn-danger text-white btn-sm" style="font-size: 13px;">删除</button>-->
<#--                                </td>-->
<#--                            </tr>-->
                        </tbody>
                    </table>
                </div>
            </div>

<#--            <a href="#" id="add_good_btn" class="btn btn-info btn-dark add_good_btn" type="submit">添加</a>-->
            <input id="add_good_btn" class="btn btn-info btn-dark add_good_btn" type="submit" value="添加">
        </form>
    </div>
</div>
<#assign myvariable= "value">
<#assign answer = 0>
<#assign first_good_price = "">
<#list menulist as good>
    <#assign first_good_price = good.good_price>
    <#break >
</#list>
<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/createorder.js"></script>

<script type="text/javascript">
    var myvariable = ${answer};
    var first_good_price = ${first_good_price};

    $(document).ready(function(){
        $("#addGoodList").click(function(){
            $("#goods_list").append(
                " <tr class=\"list-group_name\" id=\"list-group_name" + myvariable + "\">\n" +
                "                                <td class=\"good_name\">\n" +
                "                                    <select class=\"form-select form-select-sm\" name=\"all_good\" id=\"all_good" + myvariable +"\" onchange=\"show(this," + myvariable + ")\">\n" +
                "                                        <#list menulist as good>\n" +
                "                                            <option value='{\"good_id\":\"${good.good_id}\",\"good_price\":\"${good.good_price}\", \"good_image\": \"${good.good_image}\",\"good_name\":\"${good.good_name}\",}'>${good.good_name}</option>\n" +
                "                                        </#list>\n" +
                "                                    </select>\n" +
                "                                </td>\n" +
                "                                <td class=\"good_price\">\n" +
                "                                    <input class=\"form-control form-control-sm mx-sm-3 good_price\" type=\"text\" value=\"" + first_good_price +"\" id=\"good_price" + myvariable +  "\" readonly>\n" +
                "                                </td>\n" +
                "                                <td class=\"good_quantity\">\n" +
                "                                    <input class=\"form-control form-control-sm mx-sm-3 good_quantity\" type=\"number\" min=\"1\" value=\"1\" id=\"good_quantity" + myvariable + "\">\n" +
                "                                </td>\n" +
                "                                <td onclick=\"deleteRow(" + myvariable + ")\">\n" +
                "                                    <button class=\"d-flex align-items-center justify-content-center text-center btn btn-danger text-white btn-sm\" style=\"font-size: 13px;\">删除</button>\n" +
                "                                </td>\n" +
                "                            </tr>"
            );
            myvariable = myvariable + 1;
        });
    });


</script>

</body>
</html>