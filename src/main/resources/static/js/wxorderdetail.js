const openModalButtons = document.querySelectorAll('[data-modal-target]')
const add_good_detail = document.getElementById('add_good_detail')
const addRemark = document.getElementById('addRemark');
const overlay = document.getElementById('overlay')
const category_user_input = document.getElementById('category_user_input')
const cat_image = document.getElementById('category_image');
const closecat_close_btn = document.getElementById("cat_close_btn")
const remark_close = document.getElementById("remark_close")
const remark_close_update = document.getElementById("remark_close_update")

//选择
var selectGoodTag = document.getElementById('all_good')
const order_number = document.getElementById('order_number')

// 物流信息
let order_status = document.getElementById('order_status').textContent;
//订单状态条
function orderStatus(){
    if(order_status == 0){
        document.getElementById('order_detail_line1').style.backgroundColor = "#576EE0";
        document.getElementById('order_detail_rounder2').style.backgroundColor = "#576EE0";
        document.getElementById('submit_order_text2').style.color = "#5269DA";

        document.getElementById('order_detail_line2').style.backgroundColor = "#576EE0";
        document.getElementById('order_detail_rounder3').style.backgroundColor = "#576EE0";
        document.getElementById('submit_order_text3').style.color = "#5269DA";

        document.getElementById('order_detail_line3').style.backgroundColor = "#576EE0";
        document.getElementById('order_detail_rounder4').style.backgroundColor = "#576EE0";
        document.getElementById('submit_order_text4').style.color = "#5269DA";

        document.getElementById('submit_order_text4').style.fontWeight = "700";
    }

    if(order_status == 1){
        document.getElementById('submit_order_text1').style.fontWeight = "700";
    }

    if(order_status == 2){
        document.getElementById('order_detail_line1').style.backgroundColor = "#576EE0";
        document.getElementById('order_detail_rounder2').style.backgroundColor = "#576EE0";
        document.getElementById('submit_order_text2').style.color = "#5269DA";
        document.getElementById('submit_order_text2').style.fontWeight = "600";
    }
    if(order_status == 3){
        document.getElementById('order_detail_line1').style.backgroundColor = "#576EE0";
        document.getElementById('order_detail_rounder2').style.backgroundColor = "#576EE0";
        document.getElementById('submit_order_text2').style.color = "#5269DA";

        document.getElementById('order_detail_line2').style.backgroundColor = "#576EE0";
        document.getElementById('order_detail_rounder3').style.backgroundColor = "#576EE0";
        document.getElementById('submit_order_text3').style.color = "#5269DA";

        document.getElementById('submit_order_text3').style.fontWeight = "700";
    }

    if(order_status == 4){
        document.getElementById('submit_order_text1').innerText = "订单取消";
        document.getElementById('order_detail_rounder1').style.backgroundColor = "red";
        document.getElementById('submit_order_text1').style.color = "red";
        document.getElementById("submit_order_text1").style.fontWeight = "700";
    }

}

// 复制名字
function copyText(obj){
    var tmpInput = $("<input>");
    $("body").append(tmpInput);
    var tdVal = $(obj).parent().prev().text();
    tmpInput.val(tdVal).select();
    document.execCommand("copy");
    tmpInput.remove();

    var x = document.getElementById("toast")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
}

// 复制快递单号
function copyDeliverNumber(id){
    var text = document.getElementById(id).innerText;
    var elem = document.createElement("textarea");
    document.body.appendChild(elem);
    elem.value = text;
    elem.select();
    document.execCommand("copy");
    document.body.removeChild(elem);

    var x = document.getElementById("toast")
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 2000);
}


//放上騰訊雲只要改這邊就好
const BASE_DOMAIN = "http://localhost:8080"
// const BASE_DOMAIN = "https://fishnprawn.cn"     // For 腾讯云
const DB_NAME = "fishnprawn"
const TABLE = "order"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好

openModalButtons.forEach(button => {
    button.addEventListener('click', () => {
        const modal = document.querySelector(button.dataset.modalTarget)
        openModal(modal)
    })
})

overlay.addEventListener('click', () => {
    const modals = document.querySelectorAll('.modal-test.active')
    const modals_remark = document.querySelectorAll('.modal-test-remark.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
    modals_remark.forEach(modal => {
        closeModal(modal)
    })
})

var good_id;
var good_name;
var good_price = document.getElementById('good_price')
var good_quantity = document.getElementById('good_quantity')
var order_id = document.getElementById('order_id')
var good_image
var opt;

function show(){
    opt = selectGoodTag.options[selectGoodTag.selectedIndex];

    good_price.value = opt.value.split("\"")[7]; //good_price
    good_id = opt.value.split("\"")[3];
    good_image = opt.value.split("\"")[11]
}

selectGoodTag.onchange=show;
show();

//send post(create new category) request to backend server
add_good_detail.addEventListener('click', () => {
    let order_number_value = order_number.textContent   //订单标号
    let good_name_value = opt.text;
    let good_price_value = good_price.value;
    let good_quantity_value = good_quantity.value;
    let order_id_value = order_id.textContent;

    if(good_quantity_value == ''){
        alert('请填写商品数量');
    }else{
        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "add"]).join("/")

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        let data = JSON.stringify(
        {"order_number": order_number_value,
            "orderId": order_id_value,
            "good_id": good_id,
            "good_name": good_name_value,
            "good_price": good_price_value,
            "good_quantity": good_quantity_value,
            "good_image": good_image
        });
        xhr.send(data);
        setTimeout(function(){ location.reload(); }, 1000);
    }
})


function sendDeleteRequest(order_detail_id){
    var totalRowCount = 0;
    var rowCount = 0;
    var table = document.getElementById("table");
    var rows = table.getElementsByTagName("tr")
    for (var i = 0; i < rows.length; i++) {
        totalRowCount++;
        if (rows[i].getElementsByTagName("td").length > 0) {
            rowCount++;
        }
    }
    if(rowCount == 1){
        alert('订单不能低于一件商品,无法删除');
    }else{
        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "deletebyid",`${order_detail_id}`]).join("/")
        xhr.open("DELETE", url);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.send();
    }
    setTimeout(function(){ location.reload(); }, 1000);
}


closecat_close_btn.addEventListener('click', ()=>{
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})

remark_close.addEventListener('click', ()=>{
    const modals_remark_value = document.querySelectorAll('.modal-test.active')
    modals_remark_value.forEach(modal => {
        closeModal(modal)
    })
})
remark_close_update.addEventListener('click', ()=>{
    const modals_remark_update_value = document.querySelectorAll('.modal-test.active')
    modals_remark_update_value.forEach(modal => {
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


// checkbox select all
$(document).ready(function() {
    $('#selectAllBoxes').click(function(event){
        if(this.checked){
            $('.checkBoxes').each(function(){
                this.checked = true;
            });
        }else{
            $('.checkBoxes').each(function(){
                this.checked = false;
            });
        }
    });
});



// 添加备注
const save_remark_btn = document.getElementById('save_remark');
save_remark_btn.addEventListener('click', ()=>{
    let remark_textarea_value = document.getElementById('remark_value').value;
    let order_id_value = order_id.textContent;
    console.log(order_id_value)

    if(remark_textarea_value == ""){
        alert("备注不能为空");
    }else{
        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "remark"]).join("/")
        url = ([url, "add"]).join("/")

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        let data = JSON.stringify({
            "order_id": order_id_value,
            "remark": remark_textarea_value
        });
        xhr.send(data);
        setTimeout(function(){ location.reload(); }, 1000);
    }
})




function updateRemark(){
    document.getElementById("remark_value_update").value =  document.querySelector('.remark_value_db').innerHTML;

    var update_remark_btn = document.getElementById('update_remark');
    update_remark_btn.onclick = function () {
        let wx_order_detail_remark_id = document.getElementById('wx_order_detail_remark_id').textContent;
        let order_id_value = order_id.textContent;
        let remark_textarea_value = document.getElementById('remark_value_update').value;

        if(remark_textarea_value == ""){
            alert("备注不能为空");
        }else{
            let http = new XMLHttpRequest();
            let url = ([PREFIX, "remark"]).join("/")
            url = ([url, "updatebyid",`${wx_order_detail_remark_id}`]).join("/")

            let data = JSON.stringify({
                "wx_order_detail_remark_id": wx_order_detail_remark_id,
                "order_id": order_id_value,
                "remark": remark_textarea_value
            });
            http.open("PUT", url);
            http.setRequestHeader("Content-Type", "application/json");
            http.send(data);
            setTimeout(function(){ location.reload(); }, 1000);
        }
    }
}




// remark_value_update