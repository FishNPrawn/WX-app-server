
<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">
<title>欢喜食货(轮播图)</title>
<style>
    .sidebar ul li .swiperIcon{
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
                    <h2 class="swiper_name">轮播图</h2>
                </div>
                <div>
                    <button class="btn btn-primary text-white my-3" data-modal-target="#modal-test" id="addswiper">
                        添加单个
                    </button>
                </div>
            </div>
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <table class="table table-responsive-xl">
                            <thead class="thead-dark">
                            <tr class="table-info table-hover text-center">
                                <th>轮播图id</th>
                                <th>轮播图url</th>
                                <th>轮播图图片</th>
                                <th>修改</th>
                                <th>删除</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list swiperImgList as swiperImg>
                                <tr>
                                    <td>${swiperImg.swiper_img_id}</td>
                                    <td contenteditable="true" id="${swiperImg.swiper_img_id}" style="width: 70%;">${swiperImg.image_src}</td>
                                    <td><img src="${swiperImg.image_src}" alt="" height="80" width="120" /></td>
                                    <td><a onclick="sendUpdateRequest(`${swiperImg.swiper_img_id}`)" href = "/swiper/addsuccess" class="btn btn-primary btn-sm">修改</a>
                                    <td><a onclick="sendDeleteRequest(`${swiperImg.swiper_img_id}`)" href = "/swiper/addsuccess" class="btn btn-danger btn-sm">删除</a>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
        </div>
    </main>
</div>
<div class="modal-test" id="modal-test">
    <div class="modal-header-test">
        <div class="title-test">添加轮播图</div>
        <button data-close-button class="close-button-test" id="swiper_close_btn" >&times;</button>
    </div>
    <div class="modal-body-test">
        <form role="form">
            <div class="form-group">
                <label>轮播图url</label>
                <input id="swiper_user_input" type="text" class="form-control"/>
            </div>
            <a href="/allswiper/addsuccess" id="add_swiper_btn" class="btn btn-info btn-dark">添加</a>
        </form>

    </div>
</div>
<div id="overlay"></div>
<script type="text/javascript"  src="${path}/js/swiper.js"></script>


</body>
</html>