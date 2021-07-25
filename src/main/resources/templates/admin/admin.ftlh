
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<title>欢喜食货(管理员)</title>
<body>


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <#--主要内容content-->
    <#if !isAdmin??>
        <main>
            <div class="container">
                <div class="d-flex justify-content-between">
                    <div class="center d-flex">
                        <img width="200" src="${path}/img/avatar.jpg" alt="" style="border-radius: 50%;"/>
                        <h2 class="d-flex text-center align-content-center align-items-center">您不是管理员，没有管理权限</h2>
                    </div>
                </div>
            </div>
        </main>


    <#else >
    <main>
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="admin_name">管理员</h2>
                </div>
                <button class="btn btn-danger text-white my-3" data-modal-target="#modal-test" id="addCategory">
                    添加用户
                </button>
            </div>
            <div class="row">
                <div class="col-md-12 column">
                    <div class="table-wrap">
                        <table class="table table-responsive-xl">
                            <thead class="thead-dark">
                            <tr class="table-info  table-hover text-center">
    <#--                            <th>Admin Id</th>-->
                                <th>用户名</th>
                                <th>密码</th>
                                <th>电话</th>
                                <th>账号类型</th>
                                <th>创建时间</th>
                                <th>修改时间</th>
                                <th>修改</th>
                                <th>删除</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list adminlist as admin>
                                <tr>
    <#--                                <td>${admin.adminid}</td>-->
                                    <td contenteditable="true" id="username${admin.adminid}">${admin.username}</td>
                                    <#--                                <td contenteditable="true" id="password${admin.adminid}">${admin.password}</td>-->
                                    <td contenteditable="true" id="password${admin.adminid}" data-hidden-value="${admin.password}">********</td>
                                    <td contenteditable="true" id="phone${admin.adminid}">${admin.phone}</td>
                                    <td contenteditable="true" id="admintype${admin.adminid}">${admin.admintype}</td>
                                    <td>${admin.admin_create_time!''}</td>
                                    <td>${admin.admin_update_time!''}</td>
                                    <td><a class="btn btn-primary" onclick="sendUpdateRequest(`${admin.adminid}`)" href = "/admin/addadminsuccess">修改</a>
                                    <td><a class="btn btn-danger" onclick="sendDeleteRequest(`${admin.adminid}`)" href = "/admin/addadminsuccess">删除</a>
                                </tr>
                            </#list>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
    </#if>

</div>
<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加用户</div>
        <button data-close-button class="close-button-test" id="admin_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test">
        <form role="form">
            <div class="form-group">
                <label>用户名</label>
                <input id="admin_username" type="text" minlength="3" maxlength="20" class="form-control"/>
                <label>密码</label>
                <input id="admin_password" type="password" class="form-control"/>
                <label>手机</label>
                <input id="admin_phone" type="text" class="form-control"/>
                <label>Admin Type(1 for staff，2 for admin)</label>
                <input id="admin_type" type="text" minlength="3" maxlength="20" class="form-control"/>
            </div>
            <a href="/admin/addadminsuccess" id="add_admin_btm" class="btn btn-info btn-dark">add</a>
        </form>
    </div>
</div>
<div id="overlay"></div>
<script type="text/javascript" src="${path}/js/admin.js"></script>



</body>
</html>