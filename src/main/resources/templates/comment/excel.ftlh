<!doctype html>
<html lang="en">
<#include "../header/top.ftlh">

<body>
<div id="wrapper" class="toggled container1">
    <#--Left Side Bar-->
    <#include "../header/sidebar.ftlh">

    <main>
        <#--主要内容content-->
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-8 offset-1 column">
                    <h2 class="category_excel">批量导入评论Excel表格</h2>
                    <form action="/comment/uploadCommentByExcel" method="post"
                          enctype="multipart/form-data">
                        <input class="mt-4 mb-2" type="file" name="file">
                        <p><input class="btn btn-success " type="submit" value="提交"></p>
                    </form>
                    <h1 class="mt-4">注意事项</h1>
                    <p>1. 文件必须是excel(.xlsx)</p>
                    <p>2. Excel内容的列必须和下图对应，下图仅供参考</p>
                    <img class="img-fluid" src="https://fnpphoto.cn/excel/commentList.png"/>
                </div>
            </div>
        </div>
    </main>

</div>

</body>
</html>
