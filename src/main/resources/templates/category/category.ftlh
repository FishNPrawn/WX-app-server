
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
                    <h2 class="category_name">分类</h2>
                </div>
                <div>
                    <button class="btn btn-danger" id="deleteSelected"
                            type="submit" name='delete' value="delete"
                            data-toggle="tooltip" data-placement="right"
                            form="category_form"
                    >
                        删除选中
                    </button>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#modal-test" id="addCategory">
                        添加单个
                    </button>
                    <button class="btn border my-3" onclick="window.parent.location.href='/category/categoryExcel';">
                        批量导入
                    </button>
                </div>
            </div>
            <#--       Checkbox delete selected -->
            <form action='/category/deleteCategorySelected' method="post" id="category_form">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <table class="table table-responsive-xl">
                            <thead class="thead-dark">
                            <tr class="table-info table-hover text-center ">
                                <th><input class="checkbox" id="selectAllBoxes" type="checkbox"></th>
                                <th>分类名字</th>
                                <th>分类图片</th>
                                <th>创建时间</th>
                                <th>更新时间</th>
                                <th colspan="2">修改/删除</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list categoryList as category>
                                <tr>
                                    <td>
                                        <div class="form-check">
                                            <input class="form-check-input checkBoxes" type="checkbox" name="idChecked" value="${category.cat_id}" id="flexCheckDefault">
                                            <span class="default"></span>
                                        </div>
                                    </td>
                                    <td contenteditable="true" id=${category.cat_id}>${category.catname}</td>
                                    <td contenteditable="true" id="${category.cat_id}Image">${category.cat_image}</td>
                                    <td>${category.cat_create_time!''}</td>
                                    <td>${category.cat_update_time!''}</td>
                                    <td><a onclick="sendUpdateRequest(`${category.cat_id}`)" href = "/category/addsuccess" >修改</a>
                                    <td><a onclick="sendDeleteRequest(`${category.cat_id}`)" href = "/category/addsuccess">删除</a>
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
        <div class="title-test">添加分类</div>
        <button data-close-button class="close-button-test" id="cat_close_btn" >&times;</button>

    </div>
    <div class="modal-body-test" id="cat-window">
        <form role="form">
            <div class="form-group">
                <label>分类名字</label>
                <input id="category_user_input" minlength="3" maxlength="20" type="text" class="form-control"/>
            </div>
            <div class="form-group">
                <label>分类图片</label>
                <input id="category_image" type="text" class="form-control"/>
            </div>
            <a href="/category/addsuccess" id="add_category_btm" class="btn btn-info btn-dark">添加</a>
        </form>

    </div>
</div>
<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/style.js"></script>


</body>
</html>