
<#--<div class="navigation">-->
<#--    <ul>-->
<#--        <li class="li">-->
<#--            <a href="../home">-->
<#--                <span class="icon"><i class="fa fa-home" aria-hidden="true"></i></span>-->
<#--                <span class="title">Home</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../admin">-->
<#--                <span class="icon"><i class="fa fa-user" aria-hidden="true"></i></span>-->
<#--                <span class="title">Admin</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../category">-->
<#--                <span class="icon"><i class="fa fa-lemon-o" aria-hidden="true"></i></span>-->
<#--                <span class="title">Food category</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../menulist">-->
<#--                <span class="icon"><i class="fa fa-cutlery" aria-hidden="true"></i></span>-->
<#--                <span class="title">Goods</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../orderlist">-->
<#--                <span class="icon"><i class="fa fa-shopping-cart" aria-hidden="true"></i></span>-->
<#--                <span class="title">Order</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../allorder">-->
<#--                <span class="icon"><i class="fa fa-list-alt" aria-hidden="true"></i></span>-->
<#--                <span class="title">总订单</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../commentList">-->
<#--                <span class="icon"><i class="fa fa-comment-o" aria-hidden="true"></i></span>-->
<#--                <span class="title">评论</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../allswiper">-->
<#--                <span class="icon"><i class="fa fa-picture-o" aria-hidden="true"></i></span>-->
<#--                <span class="title">轮播图</span>-->
<#--            </a>-->
<#--        </li>-->
<#--        <li class="li">-->
<#--            <a href="../logout">-->
<#--                <span class="icon"><i class="fa fa-sign-out" aria-hidden="true"></i></span>-->
<#--                <span class="title">sign out</span>-->
<#--            </a>-->
<#--        </li>-->
<#--    </ul>-->
<#--</div>-->
<link rel="stylesheet" type="text/css" href="${path}/css/sidebar.css">
<div class="sidebar">
    <ul class="nav_list">
        <li>
            <a href="../home">
                <i class='bx bx-grid-alt'></i>
                <span class="links_name">主页面</span>
            </a>
            <span class="tooltip">主页面</span>
        </li>
        <li>
            <a href="../admin">
                <i class='bx bx-user' ></i>
                <span class="links_name">管理员</span>
            </a>
            <span class="tooltip">管理员</span>
        </li>
        <li>
            <a href="../userInfoList">
                <i class="fa fa-weixin" aria-hidden="true"></i>
                <span class="links_name">微信用户</span>
            </a>
            <span class="tooltip">微信用户</span>
        </li>
        <li>
            <a href="../category">
                <i class='bx bx-category'></i>
                <span class="links_name">食品分类</span>
            </a>
            <span class="tooltip">食品分类</span>
        </li>
        <li>
            <a href="../menulist">
                <i class='bx bx-pie-chart-alt-2' ></i>
                <span class="links_name">商品列表</span>
            </a>
            <span class="tooltip">商品列表</span>
        </li>
        <li>
            <a href="../orderlist">
                <i class='bx bx-list-ol' ></i>
                <span class="links_name">待发货订单</span>
            </a>
            <span class="tooltip">待发货订单</span>
        </li>
        <li>
            <a href="../allorder">
                <i class='bx bx-list-check' ></i>
                <span class="links_name">全部订单</span>
            </a>
            <span class="tooltip">全部订单</span>
        </li>
        <li>
            <a href="../commentList">
                <i class='fa fa-comment-o' ></i>
                <span class="links_name">用户评论</span>
            </a>
            <span class="tooltip">用户评论</span>
        </li>
        <li>
            <a href="../allswiper">
                <i class='fa fa-picture-o' ></i>
                <span class="links_name">轮播图</span>
            </a>
            <span class="tooltip">轮播图</span>
        </li>
    </ul>
    <div class="profile_content">
        <div class="profile">
            <a href='../logout'>
                <i class='bx bx-log-out' id="log_out" ></i>
            </a>

        </div>
    </div>
</div>

<#include "../header/navbar.ftlh">