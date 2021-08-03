<link rel="stylesheet" type="text/css" href="${path}/css/sidebar.css">
<div class="sidebar nav__menu nav" id="nav-menu">
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
            <a href="../promocode">
                <i class='bx bxs-coupon'></i>
                <span class="links_name">团长码</span>
            </a>
            <span class="tooltip">团长码</span>
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
            <a href="../cancelorder">
                <i class='bx bx-list-minus'></i>
                <span class="links_name">已取消订单</span>
            </a>
            <span class="tooltip">已取消订单</span>
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
    <i class="fa fa-times nav__close" id="nav-close"></i>
</div>

<#include "../header/navbar.ftlh">
<script type="text/javascript" src="${path}/js/showmenu.js"></script>
