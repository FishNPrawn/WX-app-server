
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
                    <h2 class="category_name">微信用户</h2>
                </div>
            </div>
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
                        <tbody>
                        <#list userInfoList as userInfoList>
                            <tr>
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
</div>



</body>
</html>