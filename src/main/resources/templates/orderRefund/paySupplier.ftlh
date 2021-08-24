
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<#--<link rel="stylesheet" href="${path}/css/wxorderdetail.css">-->
<title>欢喜食货(供应商结算)</title>
<style>
    .sidebar ul li .paySupplier{
        color: #11101d;
        background: #fff;
    }
    .modal-body-test{
        max-height: calc(100vh - 300px);
        overflow-y: auto;
    }
</style>
<body>

<#assign pay_supplier_no = 0>
<#assign pay_supplier_yes = 0>
<#assign pay_supplier_total = 0>
<#list paySupplierList as paySupplierList>
    <#if paySupplierList.pay_supplier_or_not == 0>
        <#assign pay_supplier_no = pay_supplier_no + paySupplierList.pay_supplier_price>
        <#elseif paySupplierList.pay_supplier_or_not == 1>
            <#assign pay_supplier_yes = pay_supplier_yes + paySupplierList.pay_supplier_price>
    </#if>
    <#assign pay_supplier_total = pay_supplier_total + paySupplierList.pay_supplier_price>
</#list>


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <main>
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="center">
                <h2 class="category_name">供应商结算</h2>
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
                    <h5 class="d-flex align-items-center text-center pr-4 mt-2 text-danger">未结算金额:${pay_supplier_no}</h5>
                    <h4 class="d-flex align-items-center text-center pr-4 mt-2 text-success">结算金额:${pay_supplier_yes}</h4>
                    <h5 class="d-flex align-items-center text-center pr-4 mt-2 text-primary">总金额:#{pay_supplier_total}</h5>
                    <button class="btn btn-danger text-white my-3 mr-1" id="changeSelected"
                            type="button" name='change' value="change"
                             data-toggle="modal" data-target="#paySupplierModal"
                    >
                        结算选中
                    </button>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#paySupplier_modal-test" id="addPaySupplier">
                        添加
                    </button>
                </div>
            </div>
            <form action='/paySupplier/PaySupplierSelected' method="post" id="paySupplier_form">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <table class="table table-responsive-xl" id="myTable">
                            <thead class="thead-dark">
                            <tr class="table-info table-hover text-center">
                                <th><input class="checkbox" id="selectAllBoxes" type="checkbox"></th>
                                <th class="d-none">pay_supplier_id</th>
                                <th>供应商</th>
                                <th>退款日期</th>
                                <th>金额</th>
                                <th>状态</th>
                                <th>修改</th>
                                <th>删除</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list paySupplierList?sort_by("pay_supplier_id")?reverse as paySupplierList>
                                <tr
                                    <#if paySupplierList.pay_supplier_or_not == 1>
                                        style="background-color: #c2d9ad"
                                    </#if>
                                >
                                    <td>
                                        <div class="form-check">
                                            <input class="form-check-input checkBoxes" type="checkbox" name="idChecked" value="${paySupplierList.pay_supplier_id}" id="flexCheckDefault">
                                            <span class="default"></span>
                                        </div>
                                    </td>
                                    <td class="pay_supplier_id d-none">${paySupplierList.pay_supplier_id}</td>
                                    <td class="pay_supplier_text">${paySupplierList.pay_supplier}</td>
                                    <td class="pay_supplier_date_text">${paySupplierList.pay_supplier_date}</td>
                                    <td class="pay_supplier_price_text">${paySupplierList.pay_supplier_price}</td>
                                    <#if paySupplierList.pay_supplier_or_not == 0>
                                        <td class="pay_supplier_or_not_text">未结算</td>
                                        <#elseif paySupplierList.pay_supplier_or_not == 1>
                                            <td class="pay_supplier_or_not_text">已结算</td>
                                    </#if>
    <#--                                <td class="pay_supplier_or_not_text">${paySupplierList.pay_supplier_or_not}</td>-->
                                    <td><a class="btn btn-primary btn-sm" data-modal-target="#update_orderRefund_modal-test" onclick="updatePaySupplier(this)" href="#">修改</a>
                                    <td><a class="btn btn-danger btn-sm" onclick="deletePaySupplier(`${paySupplierList.pay_supplier_id}`)"  href = "/paySupplier/addsuccess">删除</a>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<#--添加-->
<div class="modal-test" id="paySupplier_modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加供应商结算</div>
        <button data-close-button class="close-button-test" id="paySupplier_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="orderRefund-window">
        <form role="form">
            <div class="form-group">
                <label>供应商</label>
                <select id="pay_supplier_input">
                    <option value="小林">小林</option>
                </select>
            </div>
            <div class="form-group">
                <label>退款日期</label>
                <input id="pay_supplier_date_input" type="date" class="form-control"/>
            </div>
            <div class="form-group">
                <label>金额</label>
                <input id="pay_supplier_price_input" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>是否结算(0:否 1:是)</label>
                <input id="pay_supplier_or_not_input" type="number" class="form-control"/>
            </div>
            <a href="/paySupplier/addsuccess" id="add_paySupplier" class="btn btn-info btn-dark">添加</a>
        </form>
    </div>
</div>

<#--修改-->
<div class="modal-test" id="update_orderRefund_modal-test">
    <div class="modal-header-test">
        <div class="title-test">修改供应商结算</div>
        <button data-close-button class="close-button-test" id="update_paySupplier_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="orderRefund-window">
        <form role="form">
            <div class="form-group">
                <label>供应商</label>
                <select id="update_pay_supplier_input">
                    <option value="小林">小林</option>
                </select>
            </div>
            <div class="form-group">
                <label>退款日期</label>
                <input id="update_pay_supplier_date_input" type="date" class="form-control"/>
            </div>
            <div class="form-group">
                <label>金额</label>
                <input id="update_pay_supplier_price_input" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>是否结算(0:否 1:是)</label>
                <input id="update_pay_supplier_or_not_input" type="number" class="form-control"/>
            </div>
            <a href="/paySupplier/addsuccess" id="update_paySupplier" class="btn btn-info btn-dark">修改</a>
        </form>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="paySupplierModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                <button type="submit" class="btn btn-danger" form="paySupplier_form" data-placement="right" data-toggle="tooltip">结算</button>
            </div>
        </div>
    </div>
</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/paySupplier.js"></script>

</body>
</html>