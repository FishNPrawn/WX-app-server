
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<title>欢喜食货(用户评论)</title>
<style>
    .sidebar ul li .commentListIcon{
        color: #11101d;
        background: #fff;
    }
</style>
<body>

<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">
    <main>
        <#--主要内容content-->
        <div id="page-content-wrapper" class="container">
            <div class="d-flex justify-content-between">
                <div class="center">
                    <h2 class="category_name">用户评论</h2>
                </div>
            </div>

            <#--   页数       -->
            <#include "../header/pagination.ftlh">

            <div class="row clearfix">
                <div class="col-md-12 column">
                    <table class="table table-responsive-xl">
                        <thead class="thead-dark">
                        <tr class="table-info table-hover text-center">
                            <th>comment_id</th>
                            <th>open_id</th>
                            <th>good_id</th>
                            <th>商品名</th>
                            <th>内容</th>
                            <th>头像</th>
                            <th>创建时间</th>
                            <th>删除</th>
                        </tr>
                        </thead>
                        <tbody id="loop">
                        <#list commentList as commentList>
                            <tr class="list-group_name">
                                <td>${commentList.commentId}</td>
                                <td>${commentList.username}</td>
                                <td>${commentList.goodId}</td>
                                <td>${commentList.name}</td>
                                <td>${commentList.content}</td>
                                <td><img height="40" width="40" src="${commentList.image}"></td>
                                <td>${commentList.comment_create_time}</td>
                                <td><a onclick="sendDeleteRequest(`${commentList.commentId}`)" href = "/comment/deletesuccess" class="btn btn-danger">删除</a>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/comment.js"></script>

<#--分页面（页数）-->
<script type="text/javascript" src="${path}/js/pagination.js"></script>

</body>
</html>