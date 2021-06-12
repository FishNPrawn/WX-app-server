
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<style>
    *, *::after, *::before {
        box-sizing: border-box;
    }

    .modal-test {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%) scale(0);
        transition: 200ms ease-in-out;
        border: 1px solid black;
        border-radius: 5px;
        z-index: 10;
        background-color: white;
        width: 500px;
        max-width: 80%;
    }

    .modal-test.active {
        transform: translate(-50%, -50%) scale(1);
    }

    .modal-header-test {
        padding: 10px 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid black;
    }

    .modal-header-test .title-test {
        font-size: 1.25rem;
        font-weight: bold;
    }

    .modal-header-test .close-button-test {
        cursor: pointer;
        border: none;
        outline: none;
        background: none;
        font-size: 1.25rem;
        font-weight: bold;
    }

    .modal-body-test {
        padding: 10px 15px;
    }

    #overlay {
        position: fixed;
        opacity: 0;
        transition: 200ms ease-in-out;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, .5);
        pointer-events: none;
    }

    #overlay.active {
        opacity: 1;
        pointer-events: all;
    }

</style>
<body>


<div id="wrapper" class="toggled">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <div id="page-content-wrapper" class="container">
        <div class="center">
            <h1>Category</h1>
        </div>
        <button class="btn btn-dark text-white my-3" data-modal-target="#modal-test" id="addCategory">
             Add Category
        </button>
        <button class="btn btn-dark text-white my-3">
            Add Category by Excel
        </button>
        <div class="row clearfix">
            <div class="col-md-12 column">
                <table class="table table-bordered">
                    <thead class="thead-dark">
                    <tr class="table-info  table-hover">
                        <th>cat Id</th>
                        <th>Cat Name</th>
                        <th>Create Time</th>
                        <th>Update Time</th>
                        <th colspan="2">Update/Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list categoryList as category>
                        <tr>
                            <td>${category.cat_id}</td>
                            <td contenteditable="true" id=${category.cat_id}>${category.cat_name}</td>
                            <td>${category.cat_create_time!''}</td>
                            <td>${category.cat_update_time!''}</td>
                            <td><a onclick="sendUpdateRequest(`${category.cat_id}`)" href = "/category" >Update</a>
                            <td><a onclick="sendDeleteRequest(`${category.cat_id}`)" href = "/category">Delete</a>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">Add Category</div>
        <button data-close-button class="close-button-test" id="cat_close_btn" >&times;</button>

    </div>
    <div class="modal-body-test" id="cat-window">
        <form role="form">
            <div class="form-group">
                <label>Category Name</label>
                <input id="category_user_input" minlength="3" maxlength="20" type="text" class="form-control"/>
            </div>
            <a href="/category/addsuccess" id="add_category_btm" class="btn btn-info btn-dark">add</a>
        </form>

    </div>
</div>
<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/style.js"></script>



</body>
</html>