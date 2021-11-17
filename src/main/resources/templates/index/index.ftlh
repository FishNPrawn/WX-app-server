<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <#assign path="${springMacroRequestContext.getContextPath()}">
<#--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"-->
<#--          integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">-->
<#--    <link-->
<#--            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;1,100;1,200;1,300;1,400;1,500;1,600&display=swap"-->
<#--            rel="stylesheet">-->
    <title>Zanyuan Yang</title>
<#--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
    <link rel="icon" href="image/logo1.png" type="image/png" sizes="16x16">
<#--    <script>-->
<#--        $(function () {-->
<#--            $(".toggle").on('click', function () {-->
<#--                if ($(".item").hasClass("active")) {-->
<#--                    $(".item").removeClass("active");-->
<#--                }-->
<#--                else {-->
<#--                    $(".item").addClass("active");-->
<#--                }-->
<#--            })-->
<#--        });-->
<#--    </script>-->
    <style>
        *{
            font-family: 'Poppins', sans-serif;
            margin:0;
            padding:0;
        }
        :root{
            --main-text-color: #fff;
        }

        body{
            background-color: black;
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            width: 100%;
            height: 100%;
            /* padding: .7em 0; */
        }
        .footer_bottom{
            position: absolute;
            bottom: 10px;
            text-align: center;
            font-size: 30px;
            left:50%;
            background-color: black;
        }
        /* nav bar */
        .navbar{
            z-index: 999;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
        }
        nav{
            padding: 5px 20px;
        }
        ul{
            list-style-type: none;
        }
        .logo a,.item a{
            color: var(--main-text-color);
            text-decoration: none;
        }
        a:hover{
            text-decoration: underline;
        }
        .logo a:hover{
            text-decoration: none;
        }
        .logo1 {
            width: 40px;
            margin-top: 5px;
            margin-left: 4px;
        }

        .menu li{
            font-size:23px;
            padding: 15px 15px;

        }
        .menu li a{
            display: block;
        }

        .logo a{
            font-size: 30px;
        }
        .toggle a{
            font-size: 20px;
        }


        /* mobile menu */
        .menu{
            display:flex;
            flex-wrap:wrap;
            justify-content: space-between;
            align-items: center;

        }
        .toggle{
            order:1;
        }
        .item.button{
            order:2;
        }
        .item{
            width: 100%;
            text-align:center;
            order:3;
            display: none;
        }
        .item.active {
            display: block;
            background-color: black;
        }

        .toggle{
            cursor: pointer;
        }
        .bars{
            background: #999999;
            display:inline-block;
            height:2px;
            position:relative;
            width: 18px;
        }
        .bars::before,.bars::after{
            background: #999999;
            content: '';
            display:block;
            height:2px;
            position: absolute;
            width: 18px;
        }
        .bars::before{
            top:5px;
        }
        .bars::after{
            top:-5px;
        }



        /* table menu */
        @media all and (min-width:468px){
            .menu{
                justify-content: center;
            }
            .logo{
                flex: 1;
            }
            .item.button{
                width: auto;
                order:1;
                display: block;
            }
            .toggle{
                order:2;
            }
        }

        @media all and (min-width:768px){
            .item{
                display: block;
                width:auto;
            }
            .toggle{
                display: none;
            }
            .logo{
                order:0;
            }
            .item{
                order:1;
            }
            .button{
                order:2;
            }
            .menu li{
                padding: 15px 10px;
            }
            .menu li.button{
                padding-right: 0;
            }
        }

        /* about */
        .about{
            position:absolute;
            z-index: -1;
            top: 10%;
        }
        .content1{
            color: var(--main-text-color);
            text-align:center;
            font-size: 2.2em;
            margin-top: 20px;
        }

        .container{
            display: flex;
            font-family: initial;
            justify-content: space-evenly;
            margin-top: 80px;
        }

        .left-box{
            color: var(--main-text-color);
            width: 30%;
        }
        .right-box{
            color: var(--main-text-color);
            width: 30%;
        }



        .left-box h2{
            letter-spacing: 0.25rem;
            font-size: 1.8em;
            color:rgb(111, 156, 163);
            font-family: 'Poppins';font-size: 32px;
        }
        .left-box p{
            color: rgb(196, 196, 196);
            font-family: "lora-regular", serif;
            font-size: 1.3rem;
        }
        .left-box span{
            color: rgb(196, 196, 196);
        }

        .right-box h2{
            letter-spacing: 0.25rem;
            font-size: 1.8em;
            color:rgb(111, 156, 163);
            font-family: 'Poppins';font-size: 32px;
        }
        .right-box span{
            color: rgb(196, 196, 196);
        }

        .right-box h3{
            color: rgb(255, 255, 255);
        }

        .two-button{
            margin-top: 90px;
            display: flex;
            justify-content: center;

        }
        .two-button a{
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #ffffff;
            color: var(--main-text-color);
            width: 250px;
            height: 50px;
            text-decoration: none;
            letter-spacing: 0.3rem;
            font-size: 1rem;
            cursor: pointer;
            margin: -1rem 3rem 0rem 2rem;
        }
        .button:hover {
            border: 2px solid #c9743c;
            color: #fc7f0b;
            transition: 0.6s;
        }


        @media screen and (max-width:768px){
            .content1 h2{
                text-align: center;
            }
            .c-row {
                padding-left: 25px;
                padding-right: 25px;
            }
            .container{
                display: block;

            }
            .left-box{
                color: var(--main-text-color);
                width: 80%;
            }
            .left-box h2{
                text-align: center;
            }
            .right-box{
                color: var(--main-text-color);
                width: 80%;
            }
            .right-box h2{
                text-align: center;
                margin-top: 80px;
            }
            .two-button{
                display: block;
            }
            .two-button a{
                width: 80%;
            }
            .two-button .button2{
                margin-top: 20px;
            }
        }
    </style>
    <title>主页</title>
</head>
<body>
<div class="navbar">
    <nav>
        <ul class="menu">
<#--            <li><a href="#"><img class="logo1" src="/image/logo1.png" alt="logo"></a></li>-->
            <li class="logo"><a href="#">Zanyuan Yang</a></li>
            <li class="item"><a href="#">Home</a></li>
            <li class="item"><a href="#">Project</a></li>
            <li class="item"><a href="#">Photography</a></li>
            <li class="item"><a href="#">Contact</a></li>
            <li class="item"><a href="#">About</a></li>
            <li class="toggle"><a href="#"><span class="bars"></span></a></li>
        </ul>
    </nav>
</div>

<!-- about -->
<section class="about">
    <div class="content1">
        <h2>About</h2>
    </div>
    <div class="container">
        <div class="left-box c-row">
            <h2>PROFOLE</h2>
            <br>
            <p>My name is Zanyuan. I currently study at UC San Diego(B.S.), major in Computer Science.
                I'm currently on China because of epidemic. I love taking picture, and I'm looking for
                the full-time intership in 2021.
            </p>
            <br>
            <h3>NAME</h3>
            <span>Zanyuan Yang</span>
            <br><br>
            <h3>EMAIL</h3>
            <span>zayang@ucsd.edu</span>
            <br><br>
            <h3>SCHOOL</h3>
            <span>UC San Diego</span>
        </div>

        <div class="right-box c-row">
            <h2>SKILL</h2>
            <br>
            <h3>Language:</h3>
            <span>C++, Java, HTML, CSS, JavaScript, PHP, SQL</span>
            <br><br>
            <h3>Database:</h3>
            <span>MySQL, Google Firebase</span>
            <br><br>
            <h3>Tools:</h3>
            <span>Intellij IDEA, vscode, Android Studio</span>
        </div>
    </div>
    <div class="button-container">
        <div class="two-button c-row">
            <a href="#" class="button button1">CONTACT ME</a>
            <a href="#" class="button button2">DOWNLOAD CV</a>
        </div>
    </div>
</section>



<#--<div class="footer-copyright text-center py-3 fixed-bottom">© 2021 Copyright:-->
<#--    <a href="http://beian.miit.gov.cn"> 粤ICP备2021048567号</a>-->
<#--</div>-->

<div style="color: white;" class="footer_bottom">© 2021 Copyright:
    <a href="http://beian.miit.gov.cn" style="color: white;"> 粤ICP备2021107781号-1</a>
</div>

</body>
</html>