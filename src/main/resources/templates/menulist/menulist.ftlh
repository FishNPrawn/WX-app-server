
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link href="${path}/css/menulist.css" rel="stylesheet" />
<title>欢喜食货(商品列表)</title>

<body>
<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <main>
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="menulist_name">商品列表</h2>
                </div>
                <div>
                    <button class="btn btn-danger" id="deleteSelected"
                            type="submit" name='delete' value="delete"
                            data-toggle="tooltip" data-placement="right"
                            form="good_form"
                    >
                        删除选中
                    </button>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#modal-test" id="addCategory">
                        添加单个
                    </button>
                    <button class="btn border my-3" onclick="window.parent.location.href='/menulist/menulistExcel';">
                        批量添加
                    </button>
                </div>
            </div>

            <#include "../header/pagination.ftlh">

            <form action='/good/deleteGoodSelected' method="post" id="good_form">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <table class="table table-responsive-xl" id="example" style="box-shadow: 5px 5px 13px #ededed, -5px -5px 13px #ffffff;">
                            <thead class="thead-dark">
                            <tr class="table-info  table-hover text-center">
                                <th><input class="checkbox" id="selectAllBoxes" type="checkbox"></th>
                                <th>商品名</th>
                                <th>分类</th>
                                <th>原价格</th>
                                <th>优惠价</th>
                                <th>库存</th>
                                <th>重量</th>
                                <th>规格</th>
                                <th>供应商</th>
                                <th>产地</th>
                                <th>销量</th>
                                <th>品味最佳期</th>
                                <th>发布日期</th>
                                <th>商品详情</th>
                                <th>状态</th>
                                <th>图片1</th>
                                <th>图片2</th>
                                <th>长图片</th>
                                <th>修改</th>
                                <th>删除</th>
                            </tr>
                            </thead>
                            <tbody id="loop">
                            <#list menulist as good>
                                <tr class="list-group_name">
                                    <td>
                                        <div class="form-check">
                                            <input class="form-check-input checkBoxes idtext" type="checkbox" name="idChecked" value="${good.good_id}">
                                        </div>
                                    </td>
                                    <td class="nametext">${good.good_name}</td>
                                    <td class="catnametext">${good.cat_name}</td>
                                    <td class="priceorigintext">${good.good_origin_price}</td>
                                    <td class="pricetext">${good.good_price}</td>
                                    <td class="stocktext">${good.good_stock}</td>
                                    <td class="weighttext">${good.good_weight}</td>
                                    <td class="sizetext">${good.good_size}</td>
                                    <td class="suppliertext">${good.good_supplier}</td>
                                    <td class="productiontext">${good.good_production}</td>
                                    <td class="expirationtext">${good.good_expiration}</td>
                                    <td class="optimal_period_text">${good.good_optimal_period}</td>
                                    <td class="publish_text">${good.good_publish_date?string('yyyy-MM-dd')}</td>
                                    <td class="descriptiontext">${good.good_description}</td>
                                    <td class="statustext">${good.good_status}</td>
                                    <td><img class="imagetext" height="40" width="40" src="${good.good_image}"></td>
                                    <td><img class="image1text" height="40" width="40" src="${good.good_image_1}"></td>
                                    <td><img class="image_description_text" height="40" width="40" src="${good.good_image_description}"></td>
                                    <td><button type="button" data-modal-target="#modal-test1" onclick="updateMenulist(this)" class="btn btn-primary btn-sm">修改</button>
                                    <td><a onclick="sendDeleteRequest(`${good.good_id}`)" href="/goodlist/deletesuccess" class="btn btn-danger btn-sm">删除</a>
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
<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加商品</div>
        <button data-close-button class="close-button-test" id="good_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="good-window">
        <form role="form">
            <div class="form-group">
                <label class="label_name">商品名</label>
                <input id="good_name_input" type="text" class="form-control"/>

                <label class="label_category">分类</label>
                <input id="good_category_input" type="text" class="form-control"/>

                <label class="label_price">原价格</label>
                <input id="good_origin_price_input" type="text" class="form-control"/>

                <label class="label_price">优惠价</label>
                <input id="good_price_input" type="text" class="form-control"/>

                <label class="label_stock">库存</label>
                <input id="good_stock_input" type="text" class="form-control"/>

                <label class="label_weight">重量</label>
                <input id="good_weight_input" type="text" class="form-control"/>

                <label class="label_size">规格</label>
                <input id="good_size_input" type="text" class="form-control"/>

                <label class="label_supplier">供应商</label>
                <input id="good_supplier_input" type="text" class="form-control"/>

                <label class="label_description">产地</label>
                <input id="good_production_input" type="text" class="form-control"/>

                <label class="label_expiration">销量</label>
                <input id="good_expiration_input" type="text" class="form-control"/>

                <label class="label_optimal_period">品味最佳期</label>
                <input id="good_optimal_period" type="text" class="form-control"/>

                <label class="label_publish_date">发布日期</label>
                <input id="good_publish_date" type="date" class="form-control"/>

                <label class="label_description">商品详情</label>
                <input id="good_description_input" type="text" class="form-control"/>

                <label class="label_status">状态(0/1)</label>
                <input id="good_status_input" type="text" class="form-control"/>

                <label class="label_image">图片1</label>
                <input id="good_image_input"  type="text" class="form-control"/>

                <label class="label_image_1">图片2</label>
                <input id="good_image_1_input"  type="text" class="form-control"/>

                <label class="label_image_description">长图片</label>
                <input id="good_image_description"  type="text" class="form-control"/>
            </div>
            <a href="/goodlist/addgoodsuccess" id="add_good_btm" class="btn btn-info btn-dark">添加</a>
        </form>
    </div>
</div>

<div class="modal-test1" id="modal-test1">
    <div class="modal-header-test">
        <div class="title-test">更改商品</div>
        <button data-close-button class="close-button-test" id="good_close_btn1" >&times;</button>
    </div>
    <div class="modal-body-test" id="good-window">
        <form role="form">
            <div class="form-group">
                <label class="label_name">商品名</label>
                <input id="update_good_name_input" type="text" class="form-control"/>

                <label class="label_category">分类</label>
                <input id="update_good_category_input" type="text" class="form-control"/>

                <label class="label_price">原价格</label>
                <input id="update_good_origin_price_input" type="text" class="form-control"/>

                <label class="label_price">优惠价</label>
                <input id="update_good_price_input" type="text" class="form-control"/>

                <label class="label_weight">重量</label>
                <input id="update_good_weight_input" type="text" class="form-control"/>

                <label class="label_size">规格</label>
                <input id="update_good_size_input" type="text" class="form-control"/>

                <label class="label_stock">库存</label>
                <input id="update_good_stock_input" type="text" class="form-control"/>

                <label class="label_supplier">供应商</label>
                <input id="update_good_supplier_input" type="text" class="form-control"/>

                <label class="label_production">产地</label>
                <input id="update_good_production_input" type="text" class="form-control"/>

                <label class="label_expiration">销量</label>
                <input id="update_good_expiration_input" type="text" class="form-control"/>

                <label class="label_optimal_period">品味最佳期</label>
                <input id="update_good_optimal_period" type="text" class="form-control"/>

                <label class="label_publish_date">发布日期</label>
                <input id="update_good_publish_date" type="date" class="form-control"/>

                <label class="label_description">商品详情</label>
                <input id="update_good_description_input" type="text" class="form-control"/>

                <label class="label_status">状态(0/1)</label>
                <input id="update_good_status_input" type="text" class="form-control"/>

                <label class="label_image">图片1</label>
                <input id="update_good_image_input"  type="text" class="form-control"/>

                <label class="label_image_1">图片2</label>
                <input id="update_good_image_1_input"  type="text" class="form-control"/>

                <label class="label_image_description">长图片</label>
                <input id="update_good_image_description"  type="text" class="form-control"/>
            </div>
            <a href="/goodlist/addgoodsuccess" id="updateBtn" class="btn btn-info btn-dark">更改</a>
        </form>
    </div>
</div>
<#--    update module -->


<div id="overlay"></div>
<script type="text/javascript" src="${path}/js/menulist.js"></script>

<#--分页面（页数）-->
<script type="text/javascript" src="${path}/js/pagination.js"></script>


</body>
</html>
