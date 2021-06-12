
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
            <h1>Admin</h1>
        </div>
        <button class="btn btn-dark text-white my-3" data-modal-target="#modal-test" id="addCategory">
            Add User
        </button>
        <div class="row clearfix">
            <div class="col-md-12 column">
                <table class="table table-bordered">
                    <thead class="thead-dark">
                    <tr class="table-info  table-hover">
                        <th>Admin Id</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Phone</th>
                        <th>Admin Type</th>
                        <th>Create Time</th>
                        <th>Update Time</th>
                        <th colspan="2">Update/Delete</th>
                    </tr>
                    </thead>
                    <tbody>
<#--                    <#if adminlist??>-->
                        <#list adminlist as admin>
                            <tr>
                                <td>${admin.adminid}</td>
                                <td contenteditable="true" id="username${admin.adminid}">${admin.username}</td>
                                <td contenteditable="true" id="password${admin.adminid}">${admin.password}</td>
                                <td contenteditable="true" id="phone${admin.adminid}">${admin.phone}</td>
                                <td contenteditable="true" id="admintype${admin.adminid}">${admin.admintype}</td>
                                <td>${admin.admin_create_time!''}</td>
                                <td>${admin.admin_update_time!''}</td>
                                <td><a onclick="sendUpdateRequest(`${admin.adminid}`)" href = "/admin" >Update</a>
                                <td><a onclick="sendDeleteRequest(`${admin.adminid}`)" href = "/admin" >Delete</a>
                                    <#--                            <td><a href="/fishnprawn/admin/removeadmin?adminid=${admin.adminid}">Delete</a>-->
                            </tr>
                        </#list>
<#--                    </#if>-->

                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">Add User</div>
        <button data-close-button class="close-button-test" id="admin_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test">
        <form role="form">
            <div class="form-group">
                <label>Username</label>
                <input id="admin_username" type="text" minlength="3" maxlength="20" class="form-control"/>
                <label>password</label>
                <input id="admin_password" type="password" class="form-control"/>
                <label>Phone</label>
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