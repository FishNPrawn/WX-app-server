
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link href="${path}/css/menulist.css" rel="stylesheet" />

<body>
<div id="wrapper" class="toggled">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
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

        <form action='/good/deleteGoodSelected' method="post" id="good_form">
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                        <tr class="table-info  table-hover">
                            <th><input class="checkbox" id="selectAllBoxes" type="checkbox"></th>
                            <th>商品名</th>
                            <th>分类</th>
                            <th>价格</th>
                            <th>库存</th>
                            <th>重量</th>
                            <th>供应商</th>
                            <th>商品详情</th>
                            <th>产地</th>
                            <th>规格</th>
                            <th>过期</th>
                            <th>品味最佳期</th>
                            <th>发布日期</th>
                            <th>状态</th>
                            <th>图片1</th>
                            <th>图片2</th>
                            <th>长图片</th>
                            <th>修改</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <#list menulist as good>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input class="form-check-input checkBoxes" type="checkbox" name="idChecked" value="${good.good_id}" id="flexCheckDefault">
                                    </div>
                                </td>
                                <td class="nametext">${good.good_name}</td>
                                <td class="catnametext">${good.cat_name}</td>
                                <td class="pricetext">${good.good_price}</td>
                                <td class="stocktext">${good.good_stock}</td>
                                <td class="weighttext">${good.good_weight}</td>
                                <td class="suppliertext">${good.good_supplier}</td>
                                <td class="descriptiontext">${good.good_description}</td>
                                <td class="productiontext">${good.good_production}</td>
                                <td class="sizetext">${good.good_size}</td>
                                <td class="expirationtext">${good.good_expiration}</td>
                                <td class="optimal_period_text">${good.good_optimal_period}</td>
                                <td class="publish_text">${good.good_publish_date?string('yyyy-MM-dd')}</td>
                                <td class="statustext">${good.good_status}</td>
                                <td><img class="imagetext" height="40" width="40" src="${good.good_image}"></td>
                                <td><img class="image1text" height="40" width="40" src="${good.good_image_1}"></td>
                                <td><img class="image_description_text" height="40" width="40" src="${good.good_image_description}"></td>
                                <td><button data-modal-target="#modal-test1" onclick="updateMenulist(this)" class="btn btn-primary">修改</button>
                                <td><a onclick="sendDeleteRequest(`${good.good_id}`)" href="/menulist" class="btn btn-danger">删除</a>
                            </tr>
                        </#list>
                    </table>
                </div>
            </div>
        </form>

    </div>
</div>
<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">Add Good</div>
        <button data-close-button class="close-button-test" id="good_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test" id="good-window">
        <form role="form">
            <div class="form-group">
                <label class="label_name">Good Name</label>
                <input id="good_name_input" type="text" class="form-control"/>
                <label class="label_category">Good Category</label>
                <input id="good_category_input" type="text" class="form-control"/>
                <label class="label_price">Good Price</label>
                <input id="good_price_input" type="text" class="form-control"/>
                <label class="label_stock">Good Stock</label>
                <input id="good_stock_input" type="text" class="form-control"/>
                <label class="label_weight">Good Weight</label>
                <input id="good_weight_input" type="text" class="form-control"/>
                <label class="label_supplier">Good Supplier</label>
                <input id="good_supplier_input" type="text" class="form-control"/>
                <label class="label_description">Good Description</label>
                <input id="good_description_input" type="text" class="form-control"/>
                <label class="label_description">Good Production</label>
                <input id="good_production_input" type="text" class="form-control"/>
                <label class="label_size">Good Size</label>
                <input id="good_size_input" type="text" class="form-control"/>
                <label class="label_expiration">Good Expiration</label>
                <input id="good_expiration_input" type="text" class="form-control"/>
                <label class="label_optimal_period">Good Optimal Period</label>
                <input id="good_optimal_period" type="text" class="form-control"/>
                <label class="label_publish_date">Good Publish Date</label>
                <input id="good_publish_date" type="date" class="form-control"/>
                <label class="label_status">Good Status(0/1)</label>
                <input id="good_status_input" type="text" class="form-control"/>
                <label class="label_image">Good Image</label>
                <input id="good_image_input"  type="text" class="form-control"/>
                <label class="label_image_1">Good Image_1</label>
                <input id="good_image_1_input"  type="text" class="form-control"/>
                <label class="label_image_description">Good Description</label>
                <input id="good_image_description"  type="text" class="form-control"/>
            </div>
            <a href="/goodlist/addgoodsuccess" id="add_good_btm" class="btn btn-info btn-dark">add</a>
        </form>
    </div>
</div>

<div class="modal-test1" id="modal-test1">
    <div class="modal-header-test">
        <div class="title-test">Update</div>
        <button data-close-button class="close-button-test" id="good_close_btn1" >&times;</button>
    </div>
    <div class="modal-body-test" id="good-window">
        <form role="form">
            <div class="form-group">
                <label class="label_name">Good Name</label>
                <input id="update_good_name_input" type="text" class="form-control"/>

                <label class="label_category">Good Category</label>
                <input id="update_good_category_input" type="text" class="form-control"/>

                <label class="label_price">Good Price</label>
                <input id="update_good_price_input" type="text" class="form-control"/>

                <label class="label_stock">Good Stock</label>
                <input id="update_good_stock_input" type="text" class="form-control"/>

                <label class="label_weight">Good Weight</label>
                <input id="update_good_weight_input" type="text" class="form-control"/>

                <label class="label_supplier">Good Supplier</label>
                <input id="update_good_supplier_input" type="text" class="form-control"/>

                <label class="label_description">Good Description</label>
                <input id="update_good_description_input" type="text" class="form-control"/>

                <label class="label_production">Good Production</label>
                <input id="update_good_production_input" type="text" class="form-control"/>

                <label class="label_size">Good Size</label>
                <input id="update_good_size_input" type="text" class="form-control"/>

                <label class="label_expiration">Good Expiration</label>
                <input id="update_good_expiration_input" type="text" class="form-control"/>

                <label class="label_optimal_period">Good Optimal Period</label>
                <input id="update_good_optimal_period" type="text" class="form-control"/>

                <label class="label_publish_date">Good Publish Date</label>
                <input id="update_good_publish_date" type="date" class="form-control"/>

                <label class="label_status">Good Status(0/1)</label>
                <input id="update_good_status_input" type="text" class="form-control"/>

                <label class="label_image">Good Image</label>
                <input id="update_good_image_input"  type="text" class="form-control"/>

                <label class="label_image_1">Good Image_1</label>
                <input id="update_good_image_1_input"  type="text" class="form-control"/>

                <label class="label_image_description">Good Description</label>
                <input id="update_good_image_description"  type="text" class="form-control"/>
            </div>
            <a href="/menulist" id="updateBtn" class="btn btn-info btn-dark">Update</a>
        </form>
    </div>
</div>
<#--    update module -->


<div id="overlay"></div>
<script type="text/javascript" src="${path}/js/menulist.js"></script>

</body>
</html>
