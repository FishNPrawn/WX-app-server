const openModalButtons = document.querySelectorAll('[data-modal-target]')
const add_good_detail = document.getElementById('add_good_detail')
const overlay = document.getElementById('overlay')
const category_user_input = document.getElementById('category_user_input')
const cat_image = document.getElementById('category_image');
const closecat_close_btn = document.getElementById("cat_close_btn")

//选择
var selectGoodTag = document.getElementById('all_good')

const order_number = document.getElementById('order_number')

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
    modals.forEach(modal => {
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
    }



})


function sendUpdateRequest(catid){
    let content_id = catid
    let contenteditable = document.getElementById(content_id)
    let text = contenteditable.textContent;
    let contenteditableImage = document.getElementById(content_id+"Image");
    let imagetext = contenteditableImage.textContent;
    // let catid = document.getElementById ( "catid" ).innerText
    let http = new XMLHttpRequest();
    let url = ([PREFIX, "updatebyid",`${catid}`]).join("/")
    // let url = `https://fishnprawn.cn/fishnprawn/category/updatebyid/${catid}` // For 腾讯云
    let data = JSON.stringify({
        "cat_id": content_id,
        "catname": text,
        "cat_image": imagetext
    });
    http.open("PUT", url);
    http.setRequestHeader("Content-Type", "application/json");
    http.send(data);
}

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
}


closecat_close_btn.addEventListener('click', ()=>{
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

