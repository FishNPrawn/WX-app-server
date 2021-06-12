
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<link href="${path}/css/menulist.css" rel="stylesheet" />

<body>
<div id="wrapper" class="toggled">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <div id="page-content-wrapper" class="container float-left">
        <div class="center">
            <h1>Good List</h1>
        </div>
        <button class="btn btn-dark text-white my-3" data-modal-target="#modal-test" id="addCategory">
            Add Good
        </button>
        <button class="btn btn-dark text-white my-3">
            Add Goods by Excel
        </button>
        <div class="row clearfix">
            <div class="col-md-12 column">
                <table class="table table-bordered">
                    <thead class="thead-dark">
                    <tr class="table-info  table-hover">
                        <th>Good Id</th>
                        <th>Good Name</th>
                        <th>Good Category</th>
                        <th>Good Price</th>
                        <th>Good Stock</th>
                        <th>Good Weight</th>
                        <th>Good Supplier</th>
                        <th>Good Description</th>
                        <th>Good Production</th>
                        <th>Good Size</th>
                        <th>Good Expiration</th>
                        <th>Good Optimal Period</th>
                        <th>Good Publish Date</th>
                        <th>status</th>
                        <th>Good Image</th>
                        <th>Good Image1</th>
                        <th>Good Image Description</th>
                        <th>Update</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <#list menulist as good>
                        <tr>
                            <td class="idtext">${good.good_id}</td>
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
                            <td><img class="imagetext" height="50" width="50" src="${good.good_image}"></td>
                            <td><img class="image1text" height="50" width="50" src="${good.good_image_1}"></td>
                            <td><img class="image_description_text" height="50" width="50" src="${good.good_image_description}"></td>
<#--                            <td class="image_description_text">${good.good_image_description}</td>-->
<#--                            <td><a onclick="sendUpdateRequest(`${good.good_id}`)" href = "/fishnprawn/menulist" >Update</a>-->
                            <td><button data-modal-target="#modal-test1" onclick="updateMenulist(this)" class="btn btn-primary">Update</button>
                            <td><a onclick="sendDeleteRequest(`${good.good_id}`)" href="/menulist" class="btn btn-danger">Delete</a>
                        </tr>
                    </#list>
                </table>
            </div>
        </div>
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
