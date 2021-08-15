
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<title>欢喜食货(微信用户)</title>
<style>
    .sidebar ul li .userInfoListIcon{
        color: #11101d;
        background: #fff;
    }
</style>
<body>


<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
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
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="category_name">微信用户</h2>
                </div>
            </div>

            <#--   页数       -->
            <#include "../header/pagination.ftlh">

            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                        <tr class="table-info table-hover text-center">
                            <th>openid</th>
                            <th>session_key</th>
                            <th>用户名</th>
                            <th>城市</th>
                            <th>电话</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody id="loop">
                        <#list userInfoList as userInfoList>
                            <tr class="list-group_name">
                                <td>${userInfoList.openid}</td>
                                <td>${userInfoList.session_key}</td>
                                <td>${userInfoList.username}</td>
                                <td>${userInfoList.city}</td>
                                <td>${userInfoList.phone}</td>
                                <td>${userInfoList.user_create_time}</td>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    </#if>
</div>

<#--分页面（页数）-->
<script type="text/javascript" src="${path}/js/pagination.js"></script>


</body>
</html>