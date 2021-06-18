
<div class="navigation">
    <ul>
        <li class="li">
            <a href="../home">
                <span class="icon"><i class="fa fa-home" aria-hidden="true"></i></span>
                <span class="title">Home</span>
            </a>
        </li>
        <li class="li">
            <a href="../admin">
                <span class="icon"><i class="fa fa-user" aria-hidden="true"></i></span>
                <span class="title">Admin</span>
            </a>
        </li>
        <li class="li">
            <a href="../category">
                <span class="icon"><i class="fa fa-lemon-o" aria-hidden="true"></i></span>
                <span class="title">Food category</span>
            </a>
        </li>
        <li class="li">
            <a href="../menulist">
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
            <a href="../logout">
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
<#include "../header/navbar.ftlh">