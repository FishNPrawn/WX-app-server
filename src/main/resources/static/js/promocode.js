
// BASE_DOMAIN
const TABLE = "promo_code"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好


const openModalButtons = document.querySelectorAll('[data-modal-target]')
const closeModalButtons = document.getElementById('add_promo_code')
const overlay = document.getElementById('overlay')
const promo_code_close_btn = document.getElementById("promo_code_close_btn")
const update_promo_code_close_btn = document.getElementById('update_promo_code_close_btn')


// =======================modal===========================================
openModalButtons.forEach(button => {
    button.addEventListener('click', () => {
        const modal = document.querySelector(button.dataset.modalTarget)
        openModal(modal)
    })
})

overlay.addEventListener('click', () => {
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})

promo_code_close_btn.addEventListener('click', ()=>{
    // delete button todo
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})

update_promo_code_close_btn.addEventListener('click', ()=>{
    // delete button todo
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})

function openModal(modal) {
    if (modal == null) return
    modal.classList.add('active')
    overlay.classList.add('active')
}

function closeModal(modal) {
    if (modal == null) return
    modal.classList.remove('active')
    overlay.classList.remove('active')
}
// =======================modal===========================================

// =======================添加团长码===========================================
const add_promo_code = document.getElementById('add_promo_code');
add_promo_code.addEventListener('click', ()=>{
    var username = document.getElementById('username').value;
    var promo_code = document.getElementById('promo_code').value;
    var commission_rate = document.getElementById('commission_rate').value;
    var discount_rate = document.getElementById('discount_rate').value;
    var phone = document.getElementById('phone').value;
    var address = document.getElementById('address').value;
    var city = document.getElementById('city').value;
    var remark = document.getElementById('remark').value;
    var openid = document.getElementById('openid').value

    if(remark == ""){
        remark = "无备注";
    }
    if(username == ""){
        alert("请填写姓名");
    }else if(promo_code == ""){
        alert("请填写团长码");
    }
    else if(commission_rate == ""){
        alert("请填写团长佣金率");
    }
    else if(discount_rate == ""){
        alert("请填写客户折扣率");
    }
    else if(phone == ""){
        alert("请填写电话");
    }
    else if(address == ""){
        alert("请填写地址");
    }
    else if(city == ""){
        alert("请填写城市");
    }else if(openid == ""){
        alert("请填写");
    }else{
        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "add"]).join("/")

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        let data = JSON.stringify(
        {"username": username,
            "promoCode": promo_code,
            "commission_rate": commission_rate,
            "discount_rate": discount_rate,
            "phone": phone,
            "address": address,
            "city": city,
            "remark": remark,
            "openId": openid
        });
        xhr.send(data);
    }
})
// =======================添加团长码===========================================

// =======================删除团长===========================================
function sendDeleteRequest(promoCodeHeaderId){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "deletebyid",`${promoCodeHeaderId}`]).join("/")
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}
// =======================删除团长===========================================



function updatePromoCode(r){
    var li = r.parentElement.parentElement;

    document.getElementById('update_username_input').value = li.querySelector('.username_text').innerHTML;
    document.getElementById('update_openid_input').value = li.querySelector('.openId_text').innerHTML;
    document.getElementById('update_promo_code_input').value = li.querySelector('.promoCode_text').innerHTML;
    document.getElementById('update_commission_rate').value = li.querySelector('.commission_rate_text').innerHTML;
    document.getElementById('update_discount_rate_input').value = li.querySelector('.discount_rate_text').innerHTML;
    document.getElementById('update_phone_input').value = li.querySelector('.phone_text').innerHTML;
    document.getElementById('update_address_input').value = li.querySelector('.address_text').innerHTML;
    document.getElementById('update_city_input').value = li.querySelector('.city_text').innerHTML;
    document.getElementById('update_remark_input').value = li.querySelector('.remark_text').innerHTML;

    let promoCodeHeaderId = li.querySelector('.promoCodeHeaderId_text a').textContent;
    console.log(promoCodeHeaderId)

    var update_promo_code = document.getElementById('update_promo_code');
    update_promo_code.onclick = function (){

        var username = document.getElementById('update_username_input').value;
        var openid = document.getElementById('update_openid_input').value
        var promo_code = document.getElementById('update_promo_code_input').value;
        var commission_rate = document.getElementById('update_commission_rate').value;
        var discount_rate = document.getElementById('update_discount_rate_input').value;
        var phone = document.getElementById('update_phone_input').value;
        var address = document.getElementById('update_address_input').value;
        var city = document.getElementById('update_city_input').value;
        var remark = document.getElementById('update_remark_input').value;


        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "updatebyid", promoCodeHeaderId]).join("/")
        console.log(url)
        xhr.open("PUT", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        let data = JSON.stringify(
            {
                "username": username,
                "promoCode": promo_code,
                "commission_rate": commission_rate,
                "discount_rate": discount_rate,
                "phone": phone,
                "address": address,
                "city": city,
                "remark": remark,
                "openId": openid
            });
        xhr.send(data);
    }

}


