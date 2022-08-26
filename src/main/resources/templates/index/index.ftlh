<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <#assign path="${springMacroRequestContext.getContextPath()}">
    <link rel="stylesheet" type="text/css" href="${path}/css/index.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="icon" href="${path}/img/favicon.png" type="image/png" sizes="16x16">
    <title>欢喜食货</title>
</head>
<body>
<!----hero Section start---->

<div class="hero">
    <nav>
        <h2 class="logo">欢喜食货<span>-广州汇洋网络技术有限公司旗下平台</span></h2>
        <ul>
            <li><a href="#">主页</a></li>
            <li><a href="#aboutus">公司介绍</a></li>
            <li><a href="#speical">品牌特色</a></li>
            <li><a href="#containus">联系我们</a></li>
        </ul>
    </nav>

    <div class="content">
        <h4>你好, 我们是</h4>
        <h1> <span>广州汇洋网络技术有限公司</span></h1>
        <h3>互联网海鲜购物平台</h3>
        <div class="newslatter">
            <form>
                <input type="email" name="email" id="mail" placeholder="输入微信号">
                <input type="submit" name="submit" value="联系我们" />
            </form>
        </div>
    </div>
</div>

<!----About section start---->
<section class="about" id="aboutus">
    <div class="main">
        <img src="${path}/img/background.png">
        <div class="about-text">
            <h3>广州汇洋网络技术有限公司</h3>
            <h5>公司旗下拥有微信购物</h5>
            <h5>小程序 <span>”欢喜食货“</span></h5>
            <h5>主营 <span>软件和信息技术服务</span></h5>
            <p>一般经营：技术服务，技术开发，技术咨询，技术交流，技术转让，技术推广。信息咨询服务，互联网销售，网络技术服务。
                公司旗下有微信小程序“欢喜食货”，主要销售品种：深海鱼、浅海鱼、虾蟹类、贝壳类、干货类、熟制产品以及名贵干货
                甄选供应商，海港源头采购，没有中间商环节，为顾客提供新鲜和划算海鲜
                专业客服团队以及运营，为顾客提供更优质服务</p>
            <button type="button">联系我们</button>
        </div>
    </div>
</section>

<!-----service section start----------->
<div class="service" id="speical">
    <div class="title">
        <h2>品牌特色</h2>
    </div>

    <div class="box">
        <div class="card">
            <i class="fas fa-bars"></i>
            <h5>产品</h5>
            <div class="pra">
                <p>产品是通过了解升级，不断从产品的保温、包装、源头潜心钻研，致力于带来第一手新鲜野生海鲜，确保客户收到的产品是优质的。</p>

                <p style="text-align: center;">
                    <a class="button" href="#">更多</a>
                </p>
            </div>
        </div>

        <div class="card">
            <i class="far fa-user"></i>
            <h5>服务</h5>
            <div class="pra">
                <p>有别于传统市场上无售后，我们团会不断更新最新的产品图片，为客户提供完整的下单教程，让每个消费者都能简单上手。同时我们有优秀的售前售后服务团队。</p>
                <p style="text-align: center;">
                    <a class="button">更多</a>
                </p>
            </div>
        </div>

        <div class="card">
            <i class="far fa-bell"></i>
            <h5>效率</h5>
            <div class="pra">
                <p>当天海鲜野生捕捞，上岸处理后，
                    冷链现货实现全国隔天到达。保证产品最新鲜状态送达客户手上。让全国各地的粉丝尝到新鲜的海味海鲜。</p>

                <p style="text-align: center;">
                    <a class="button">更多</a>
                </p>
            </div>
        </div>
    </div>
</div>

<!------Contact Me------>
<div class="contact-me" id="containus">
    <p>联系我们</p>
    <p>电话: +86 13760799250</p>
    <p>邮箱: fnpapa@hotmail.com</p>
    <p>网址: https://www.joynfish.com/</p>
    <img class='qrcode' src="${path}/img/qrcode.jpg" alt="qrcode">
</div>

<!------footer start--------->
<footer>
    <p>广州汇洋网络技术有限公司</p>
    <p>这一切主要得益于快递的冷链输送</p>
    <p>国内大型冷链现在基本可实现全国隔天到达</p>
    <p>致力于让国内哪里的粉丝</p>
    <p>第一时间尝到新鲜的海味海鲜</p>
    <p>区别于市场上的海鲜参差不齐</p>
    <p>经常会有人工养殖的海鲜进入</p>
    <p>我们的海鲜保证都是野生捕捞</p>
    <div class="social">
        <a><i class="fab fa-facebook-f"></i></a>
        <a><i class="fab fa-instagram"></i></a>
        <a><i class="fab fa-dribbble"></i></a>
    </div>
    <a href="https://beian.miit.gov.cn/" style="color: white; font-size: 30px;"> 粤ICP备2021107781号</a>
</footer>
</body>
</html>