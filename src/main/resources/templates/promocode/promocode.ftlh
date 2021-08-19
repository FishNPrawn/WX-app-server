
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<title>欢喜食货(团长码)</title>
<style>
    .sidebar ul li .promocodeIcon{
        color: #11101d;
        background: #fff;
    }

    .modal-body-test{
        max-height: calc(100vh - 300px);
        overflow-y: auto;
    }
</style>
<body>

<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <main>
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="category_name">团长信息</h2>
                </div>
                <div>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#promo_code_modal-test" id="addPromoCode">
                        添加团长
                    </button>
                </div>
            </div>

            <#--       Checkbox delete selected -->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-responsive-xl">
                        <thead class="thead-dark">
                        <tr class="table-info table-hover text-center ">
                            <th>团长id</th>
                            <th>open id</th>
                            <th>团长姓名</th>
                            <th>团长码</th>
                            <th>团长佣金率</th>
                            <th>客户折扣率</th>
                            <th>审核</th>
<#--                            <th>电话</th>-->
<#--                            <th>地址</th>-->
<#--                            <th>城市</th>-->
                            <th>备注</th>
                            <th>修改</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list promocode as promocode>
                            <tr>
                                <td class="promoCodeHeaderId_text"><a href="/promocode/detail?promoCodeHeaderId=${promocode.promoCodeHeaderId}" target="_blank">${promocode.promoCodeHeaderId}</a></td>
                                <td class="openId_text">${promocode.openId}</td>
                                <td class="username_text">${promocode.username}</td>
                                <td class="promoCode_text">${promocode.promoCode}</td>
                                <td class="commission_rate_text">${promocode.commission_rate}</td>
                                <td class="discount_rate_text">${promocode.discount_rate}</td>
                                <#if promocode.promo_code_verify == 0>
                                    <td class="promo_code_verify_text">审核中</td>
                                <#elseif promocode.promo_code_verify == 1>
                                    <td class="promo_code_verify_text">审核通过</td>
                                <#elseif promocode.promo_code_verify == 2>
                                    <td class="promo_code_verify_text">审核不通过</td>
                                </#if>
                                <td class="phone_text d-none">${promocode.phone}</td>
                                <td class="address_text d-none">${promocode.address}</td>
                                <td class="city_text d-none">${promocode.city}</td>
                                <td class="remark_text">${promocode.remark}</td>
                                <td><button class="btn btn-primary btn-sm" data-modal-target="#update_promo_code_modal-test" onclick="updatePromoCode(this)">修改</button>
                                <td><a class="btn btn-danger btn-sm" onclick="sendDeleteRequest(`${promocode.promoCodeHeaderId}`)" href = "/promocode/addsuccess">删除</a>
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
<div class="modal-test" id="promo_code_modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加团长</div>
        <button data-close-button class="close-button-test" id="promo_code_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="cat-window">
        <form role="form">
            <div class="form-group">
                <label>团长姓名</label>
                <input id="username" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>open id</label>
                <input id="openid" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>团长码</label>
                <input id="promo_code" type="text" class="form-control"/>
            </div>

            <div class="form-group">
                <label>团长佣金率</label>
                <input id="commission_rate" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>客户折扣率</label>
                <input id="discount_rate" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>审核(0: 待审核; 1: 审核通过; 2: 审核不通过)</label>
                <input id="promo_code_verify" type="number" class="form-control" min="0" max="2"/>
            </div>
            <div class="form-group">
                <label>电话</label>
                <input id="phone" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>地址</label>
                <input id="address" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>城市</label>
                <input id="city" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>备注(可不填)</label>
                <input id="remark" type="text" class="form-control"/>
            </div>
            <a href="/promocode/addsuccess" id="add_promo_code" class="btn btn-info btn-dark">添加</a>
        </form>
    </div>
</div>

<#--修改-->
<div class="modal-test" id="update_promo_code_modal-test">
    <div class="modal-header-test">
        <div class="title-test">修改团长信息</div>
        <button data-close-button class="close-button-test" id="update_promo_code_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="cat-window">
        <form role="form">
            <div class="form-group">
                <label>团长姓名</label>
                <input id="update_username_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>open id</label>
                <input id="update_openid_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>团长码</label>
                <input id="update_promo_code_input" type="text" class="form-control"/>
            </div>

            <div class="form-group">
                <label>团长佣金率</label>
                <input id="update_commission_rate" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>客户折扣率</label>
                <input id="update_discount_rate_input" type="number" class="form-control"/>
            </div>
            <div class="form-group">
                <label>审核(0: 待审核; 1: 审核通过; 2: 审核不通过)</label>
                <input id="update_promo_code_verify_input" type="number" class="form-control" min="0" max="2"/>
            </div>
            <div class="form-group">
                <label>电话</label>
                <input id="update_phone_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>地址</label>
                <input id="update_address_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>城市</label>
                <input id="update_city_input" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>备注(可不填)</label>
                <input id="update_remark_input" type="text" class="form-control"/>
            </div>
            <a href="/promocode/addsuccess" id="update_promo_code" class="btn btn-info btn-dark">修改</a>
        </form>
    </div>
</div>


<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/promocode.js"></script>

</body>
</html>