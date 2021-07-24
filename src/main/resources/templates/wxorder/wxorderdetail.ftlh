
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link rel="stylesheet" href="${path}/css/wxorderdetail.css">
<body onload="orderStatus()">


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--  table end-->
    <main>
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center d-flex orderlist_name">
                    <h2>订单详情</h2>
                </div>
                <div>
                    <a class="btn btn-secondary text-white my-3" onclick="history.go(-1)">返回</a>
                </div>
            </div>
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
                        <#assign order_status = order.orderStatus>
                    </#if>
                </#list>
            </#list>
            <#--    订单状态（隐藏）        -->
            <div class="d-none" id="order_status">${order_status}</div>

            <#--     物流信息       -->
            <div class="pt-4 pb-4 order_status_bar">
                <div class="rounder_line d-flex align-items-center">
                    <span class="order_detail_rounder order_detail_rounder1" id="order_detail_rounder1"></span>
                    <span class="submit_order_text submit_order_text1" id="submit_order_text1">提交订单</span>
                    <span class="order_detail_line" id="order_detail_line1"></span>
                </div>
                <div class="rounder_line d-flex align-items-center pl-4">
                    <span class="order_detail_rounder" id="order_detail_rounder2"></span>
                    <span class="submit_order_text" id="submit_order_text2">已发货</span>
                    <span class="order_detail_line" id="order_detail_line2"></span>
                </div>
                <div class="rounder_line d-flex align-items-center pl-4">
                    <span class="order_detail_rounder" id="order_detail_rounder3"></span>
                    <span class="submit_order_text" id="submit_order_text3">已签收</span>
                    <span class="order_detail_line" id="order_detail_line3"></span>
                </div>
                <div class="rounder_line pl-4">
                    <div class="d-flex align-items-center">
                        <span class="order_detail_rounder" id="order_detail_rounder4"></span>
                        <span class="submit_order_text" id="submit_order_text4">订单完成</span>
                    </div>
                </div>
            </div>


            <div class="d-flex justify-content-between">
                <div class="center d-flex orderlist_name">
                    <span class="orderlist_name_line"></span>
                    <div class="d-flex align-items-center text-center ml-2">
                        <h6>订单号: </h6>
                        <h6 class="pl-2" id="order_number">${order_number}</h6>
                    </div>
                </div>
                <div>
                    <#if order_status == 1 || order_status==2>
                        <button class="btn btn-primary text-white my-3" data-modal-target="#modal-test" id="addCategory">
                            添加
                        </button>
                        <button class="btn btn-danger text-white my-3" data-modal-target="#modal-test-shipment" id="shipmentBtn">
                            发货
                        </button>
                        <#else>
                            <button class="btn btn-secondary text-white my-3 disabled" style="cursor:default;">
                                添加
                            </button>
                            <button class="btn btn-secondary text-white my-3 disabled" style="cursor:default;">
                                发货
                            </button>
                    </#if>
                </div>
            </div>
            <#--  table start-->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-bordered" id="table">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover text-center">
<#--                            <th>order_detail_id</th>-->
<#--                            <th>good_id</th>-->
                            <th>商品名</th>
                            <th>商品图</th>
                            <th>商品单价</th>
                            <th>数量</th>
                            <th>总额</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#assign order_price = 0>
                        <#list orderDTO.orderDetailList as orderdetail>
                            <tr>
<#--                                <td>${orderdetail.order_detail_id}</td>-->
<#--                                <td>${orderdetail.good_id}</td>-->
                                <td>${orderdetail.good_name}</td>
                                <td><img height="40" width="40" src="${orderdetail.good_image}"></td>
                                <td>${orderdetail.good_price}</td>
                                <td>${orderdetail.good_quantity}</td>
                                <td>${orderdetail.good_quantity*orderdetail.good_price}</td>
                                <td><a class="btn btn-danger btn-sm text-white"  data-toggle="modal" data-target="#confirmModal${orderdetail.order_detail_id}">删除</a>
                                <!-- Modal -->
                                <div class="modal fade" id="confirmModal${orderdetail.order_detail_id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

            <div class="d-flex justify-content-between">
                <div class="center d-flex orderlist_name"></div>
                <div>
                    <h5>总价格: ${order_price}</h5>
                </div>
            </div>

            <div class="userinfo_comment mb-4">
            <#--  --------------------------------------    收件人信息     -------------------------------------- -->
                <div>
                    <div class="d-flex">
                        <div class="center d-flex orderlist_name">
                            <span class="orderlist_user_info_line"></span>
                            <h6 class="d-flex align-items-center text-center ml-2 mt-1">收件人信息</h6>
                        </div>
                    </div>
                    <div class="userinfo mt-3 d-flex justify-content-between">
                        <div class="d-block">
                            <div class="userinfo_row d-none">
                                <h6>order_id</h6>
                                <h6 class="userinfo_value" id="order_id">${orderId}</h6>
                            </div>
                            <div class="userinfo_row d-flex">
                                <h6>姓名</h6>
                                <h6 class="userinfo_value" id="user_name">${user_name}</h6>
                            </div>
                            <div class="userinfo_row d-flex">
                                <h6>电话</h6>
                                <h6 class="userinfo_value" id="user_phone">${user_phone}</h6>
                            </div>
                            <div class="userinfo_row d-flex">
                                <h6>姓名</h6>
                                <h6 class="userinfo_value" id="user_address">${user_address}</h6>
                            </div>
                        </div>
                        <div>
                            <button class="btn btn-success btn-sm mt-4" onclick="copyText(this)">复制</button>
                        </div>

                    </div>
                </div>

            <#--  --------------------------------------    收件人信息  end   -------------------------------------- -->

            <#--  --------------------------------------    买家备注     -------------------------------------- -->
                <div>
                    <div class="d-flex">
                        <div class="center d-flex orderlist_name">
                            <span class="orderlist_user_info_line"></span>
                            <h6 class="d-flex align-items-center text-center ml-2 mt-1">买家备注</h6>
                        </div>
                    </div>
                    <div class="comment-box mt-3">${comment}的完全打完球端午期间低级趣味父亲节免费么我金佛；偶尔玩家们欺负；抢福利全微分腊味饭你</div>
                </div>
            <#--  --------------------------------------    买家备注  end   -------------------------------------- -->
            </div>



            <#--  --------------------------------------    包裹及物流信息  -------------------------------------- -->
            <div class="d-flex justify-content-between">
                <div class="center d-flex orderlist_name">
                    <span class="orderlist_user_info_line mt-2"></span>
                    <h6 class="d-flex align-items-center text-center ml-2 mt-1">包裹及物流信息</h6>
                </div>
                <div>
                    <#if order_status != 1>
                        <button class="btn btn-primary text-white my-3 btn-sm" data-modal-target="#modal-test-change-shipment-number" id="changeShipmentNumber">
                            修改快递单号
                        </button>
                    </#if>
                </div>
            </div>

            <div class="package_info_wrapper mb-4 ">
                <div class="package_info">
                    <h6>包裹信息</h6>
                    <div class="mt-4">
                        <div class="deliver_company d-flex">
                            <h6 class="deliver_company_title">快递公司</h6>
                            <#assign shipment_or_not = false >
                            <#list shipments as shipments>
                                <#if shipments.order_number == order_number >
                                    <h6 class="d-none" id="shipment_id">${shipments.shipment_id}</h6>
                                    <h6 class="deliver_company_value" id="deliver_company_value">${shipments.shipment_company}</h6>
                                    <#assign shipment_or_not = true >
                                    <#break>
                                </#if>
                            </#list>
                            <#if shipment_or_not == false >
                                <h6 class="deliver_company_value">暂无快递公司</h6>
                            </#if>
                        </div>
                        <div class="deliver_package d-flex mt-1">
                            <h6 class="deliver_package_title mt-2">快递单号</h6>
                            <#list shipments as shipments>
                                <#if shipments.order_number == order_number >
                                    <h6 class="deliver_package_value mt-2" id="deliver_package_number">${shipments.shipment_number}</h6>
                                    <button class="btn btn-success btn-sm ml-2 copy_deliver_package" onclick="copyDeliverNumber('deliver_package_number')">复制</button>
                                </#if>
                            </#list>
                            <#if shipment_or_not == false >
                                <h6 class="deliver_package_value  mt-2">暂无订单编号</h6>
                            </#if>
                        </div>
                        <div class="package_weight d-flex mt-1">
                            <h6 class="package_weight_title mt-2">包裹重量</h6>
                            <#list shipments as shipments>
                                <#if shipments.order_number == order_number >
                                    <h6 class="package_weight_value mt-2" id="package_weight_value">${shipments.package_weight}</h6>
                                </#if>
                            </#list>
                            <#if shipment_or_not == false >
                                <h6 class="deliver_package_value mt-2">暂无重量信息</h6>
                            </#if>
                        </div>
                    </div>
                </div>
                <div class="package_info_line"></div>
                <div class="package_status">

                </div>
            </div>
            <#--  --------------------------------------    包裹及物流信息 end  -------------------------------------- -->

            <#--  --------------------------------------    商家备注     -------------------------------------- -->
            <div class="d-flex justify-content-between">
                <div class="center d-flex orderlist_name">
                    <span class="orderlist_name_line"></span>
                    <div class="d-flex align-items-center text-center ml-2 mt-1">
                        <h6>商家备注(订单备注自行添加，仅平台客服可见)</h6>
                    </div>
                </div>
                <div>
                    <#assign remark_or_not_btn = false >
                    <#list wxOrderDetailRemarks as wxOrderDetailRemarks>
                        <#if wxOrderDetailRemarks.order_id == orderId >
                            <button class="btn btn-primary text-white my-3 btn-sm" data-modal-target="#modal-test-remark-update" id="updateRemark" onclick="updateRemark()">
                                修改备注
                            </button>
                            <#assign remark_or_not_btn = true >
                        </#if>
                    </#list>
                    <#if remark_or_not_btn == false >
                        <button class="btn btn-primary text-white my-3 btn-sm" data-modal-target="#modal-test-remark" id="addRemark">
                            添加备注
                        </button>
                    </#if>
                </div>
            </div>

            <div class="admin_remark mb-4">
                <h6 class="pl-4">备注详情:</h6>
                <#assign remark_or_not = false >
                <#list wxOrderDetailRemarks as wxOrderDetailRemarks>
                    <#if wxOrderDetailRemarks.order_id == orderId >
                        <h6 class="ml-2 remark_value_db">${wxOrderDetailRemarks.remark}</h6>
                        <h6 class="d-none" id="wx_order_detail_remark_id">${wxOrderDetailRemarks.wx_order_detail_remark_id}</h6>
                        <#assign remark_or_not = true >
                    </#if>
                </#list>
                <#if remark_or_not == false >
                    <h6 class="ml-2 remark_value_db">无备注</h6>
                </#if>
            </div>
            <#--  --------------------------------------    商家备注  end   -------------------------------------- -->


        </div>
    </main>
</div>


<#--添加商品-->
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
            <label>商品单价</label>
            <input class="form-control mx-sm-3 mb-2 w-25" type="text" value="价格" id="good_price" readonly>
            <label>数量</label>
            <input type="number" id="good_quantity" class="form-control mx-sm-3 mb-2 w-25" required/>
        </div>
        <a href="/detail?orderId=${orderId}" id="add_good_detail" class="btn btn-info btn-dark">添加</a>
    </div>
</div>
<#--添加商品end-->

<#--发货-->
<div class="modal-test" id="modal-test-shipment">
    <div class="modal-header-test">
        <div class="title-test">发货</div>
        <button data-close-button class="close-button-test" id="shipment_close" >&times;</button>
    </div>
    <div class="modal-body-test d-block">
        <div class="d-flex form-group">
            <h6>订单编号</h6>
            <h6 class="mx-sm-3">${order_number}</h6>
        </div>
        <div class="form-inline">
            <h6>快递公司</h6>
            <select class="form-select mx-sm-3 mb-2" id="shipmentSelect">
                <option value="京东快递">京东快递</option>
                <option value="顺丰速运">顺丰速运</option>
                <option value="中通速递">中通速递</option>
                <option value="圆通速递">圆通速递</option>
                <option value="申通快递">申通快递</option>
                <option value="韵达速递">韵达速递</option>
            </select>
        </div>
        <div class="form-inline mt-2">
            <h6>快递单号</h6>
            <input type="text" class="form-control mx-sm-3 mb-2" id="shipment_number" required/>
            <h6>重量</h6>
            <input type="number" id="package_weight" class="form-control mx-sm-3 mb-2 w-25" required/>
        </div>
        <a href="#" class="btn btn-info btn-dark" id="save_shipment">发货</a>
    </div>
</div>
<#--发货-->

<#--添加备注-->
<div class="modal-test" id="modal-test-remark">
    <div class="modal-header-test">
        <div class="title-test">添加备注</div>
        <button data-close-button class="close-button-test" id="remark_close" >&times;</button>
    </div>
    <div class="modal-body-test d-block">
        <textarea name="remark" id="remark_value" class="remark_textarea"></textarea>
        <a href="#" class="btn btn-info btn-dark" id="save_remark">保存</a>
    </div>
</div>
<#--添加备注end-->

<#--修改备注-->
<div class="modal-test" id="modal-test-remark-update">
    <div class="modal-header-test">
        <div class="title-test">修改备注</div>
        <button data-close-button class="close-button-test" id="remark_close_update" >&times;</button>
    </div>
    <div class="modal-body-test d-block">
        <textarea name="remark" id="remark_value_update" class="remark_textarea"></textarea>
        <a href="#" class="btn btn-info btn-dark" id="update_remark">修改</a>
    </div>
</div>
<#--修改备注end-->


<#--发货-->
<div class="modal-test" id="modal-test-change-shipment-number">
    <div class="modal-header-test">
        <div class="title-test">修改快递单号</div>
        <button data-close-button class="close-button-test" id="change_shipment_close" >&times;</button>
    </div>
    <div class="modal-body-test d-block">
        <div class="d-flex form-group">
            <h6>订单编号</h6>
            <h6 class="mx-sm-3">${order_number}</h6>
        </div>
        <div class="form-inline">
            <h6>快递公司</h6>
            <select class="form-select mx-sm-3 mb-2" id="shipmentChangeSelect">
                <option value="京东快递">京东快递</option>
                <option value="顺丰速运">顺丰速运</option>
                <option value="中通速递">中通速递</option>
                <option value="圆通速递">圆通速递</option>
                <option value="申通快递">申通快递</option>
                <option value="韵达速递">韵达速递</option>
            </select>
        </div>
        <div class="form-inline mt-2">
            <h6>快递单号</h6>
            <input type="text" class="form-control mx-sm-3 mb-2" id="shipment_number_change" required/>
            <h6>重量</h6>
            <input type="number" id="package_weight_change" class="form-control mx-sm-3 mb-2 w-25" required/>
        </div>
        <a href="#" class="btn btn-info btn-dark" id="save_change_shipment">修改</a>
    </div>
</div>
<#--发货-->


<#--Toast-->
<div id="toast">
    <div id="img">复制</div>
    <div id="desc">复制成功</div>
</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/wxorderdetail.js"></script>

</body>
</html>