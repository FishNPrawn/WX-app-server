

<#--<h2>hello${name}</h2>-->

<#--<h3>if statement</h3>-->
<#--<#if (age>= 18)>-->
<#--    <h2>adult</h2>-->
<#--</#if>-->
<#--<hr>-->
<#--<h3>if else statement</h3>-->
<#--<#if (age>=18)>-->
<#--    adult-->
<#--<#else>-->
<#--    not adult-->
<#--</#if>-->
<#--<hr>-->
<#--<h3>elseif statement</h3>-->
<#--<#if (age>=12)>-->
<#--    <h3>middle school</h3>-->
<#--<#elseif (age>6)>-->
<#--    <h3>primary school</h3>-->
<#--<#else>-->
<#--    <h3>幼儿园</h3>-->
<#--</#if>-->

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FishNprawn</title>
    <#assign path="${springMacroRequestContext.getContextPath()}">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${path}/css/style.css">
</head>
<body>
<div class="navigation">
    <ul>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-home" aria-hidden="true"></i></span>
                <span class="title">Home</span>
            </a>
        </li>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-user" aria-hidden="true"></i></span>
                <span class="title">Admin</span>
            </a>
        </li>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-lemon-o" aria-hidden="true"></i></span>
                <span class="title">Food category</span>
            </a>
        </li>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-cutlery" aria-hidden="true"></i></span>
                <span class="title">Goods</span>
            </a>
        </li>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-shopping-cart" aria-hidden="true"></i></span>
                <span class="title">Order</span>
            </a>
        </li>
        <li class="li">
            <a href="#">
                <span class="icon"><i class="fa fa-sign-out" aria-hidden="true"></i></span>
                <span class="title">sign out</span>
            </a>
        </li>
    </ul>
</div>
<div class="toggle" onclick="toggleMenu()"></div>
<script type="text/javascript">
    function toggleMenu() {
        let navigation = document.querySelector('.navigation');
        let toggle = document.querySelector('.toggle');
        navigation.classList.toggle('active');
        toggle.classList.toggle('active');
    }
</script>
</body>
</html>