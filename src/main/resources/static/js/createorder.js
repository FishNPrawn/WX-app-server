
// BASE_DOMAIN
const TABLE = "order"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好

const openModalButtons = document.querySelectorAll('[data-modal-target]')
const overlay = document.getElementById('overlay')
const close_btn = document.getElementById("close_btn")



// -------------Modal-----------------------------------------------------
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

close_btn.addEventListener('click', ()=>{
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
    console.log("in here")
    if (modal == null) return
    modal.classList.remove('active')
    overlay.classList.remove('active')
}
// -------------Modal end-----------------------------------------------------

// const list_group_name = document.getElementById('list-group_name');
// console.log(list_group_name)
// -------------添加 li----------------------------------------------------



// -------------添加 li end----------------------------------------------------

function show(e,id){
    const good_id = e.value.split("\"")[3];
    const good_price = e.value.split("\"")[7]; //good_price
    const good_image = e.value.split("\"")[11];
    const good_name = e.value.split("\"")[15];

    let good_price_idx = 'good_price' + id;
    let good_prive_value = document.getElementById(good_price_idx);
    good_prive_value.value = good_price;
    total_price();
}

function total_price(){
    var order_total_price = document.getElementById('order_total_price');

    var totalRowCount = 0;
    var rowCount = 0;
    var table = document.getElementById("new_order_table");
    var rows = table.getElementsByTagName("tr")
    for (var i = 0; i < rows.length; i++) {
        totalRowCount++;
        if (rows[i].getElementsByTagName("td").length > 0) {
            rowCount++;
        }
    }
    var total_price = 0;
    for (var j = 0; j < rowCount; j++) {
        //good id
        var all_good_id = 'all_good'+j;
        var e = document.getElementById(all_good_id);
        var good_arr = e.options[e.selectedIndex].value;
        var good_price = good_arr.split("\"")[7]; //good_price

        // good_quantity
        var good_quantity_id = 'good_quantity'+j;
        var good_quantity_value = document.getElementById(good_quantity_id).value;


        //total price
        total_price = total_price + good_quantity_value*good_price;
    }
    order_total_price.value = total_price;

}

const add_good_btn = document.getElementById('add_good_btn');
add_good_btn.addEventListener('click', ()=>{
    // 订单编号
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth() + 1;
    var day = today.getDate();
    var hour = today.getHours();
    var minute = today.getMinutes();
    var second = today.getSeconds();
    if (month < 10) {
        month = '0' + month;
    }
    var date = year + '' + month + '' + day;
    var time = hour + '' + minute + ''+ second;
    var randomNumber = Math.floor(1000 + Math.random() * 9000);


    const openId = "自己添加的openId";
    const order_number = date + '' + time + '' + randomNumber;
    const access_token = "自己添加的access_token";
    const user_name = document.getElementById('user_name').value;
    const user_address = document.getElementById('user_address').value;
    const user_phone = document.getElementById('user_phone').value;
    const orderStatus = 1;

    var totalRowCount = 0;
    var rowCount = 0;
    var table = document.getElementById("new_order_table");
    var rows = table.getElementsByTagName("tr")
    for (var i = 0; i < rows.length; i++) {
        totalRowCount++;
        if (rows[i].getElementsByTagName("td").length > 0) {
            rowCount++;
        }
    }

    if(user_name == ''){

    }else if(user_phone == ''){

    }else if(user_address == ''){

    }else if(rowCount <= 0){
        alert("必须添加商品");
    }
    else{
        let goods_array = [];
        var total_price = 0;
        for (var j = 0; j < rowCount; j++) {
            //good id
            var all_good_id = 'all_good'+j;
            var e = document.getElementById(all_good_id);
            var good_arr = e.options[e.selectedIndex].value;
            var good_id = good_arr.split("\"")[3];
            var good_price = good_arr.split("\"")[7]; //good_price
            var good_image = good_arr.split("\"")[11];
            var good_name = good_arr.split("\"")[15];

            //good price
            var good_price_id= 'good_price'+j;
            var good_price_value = document.getElementById(good_price_id).value;

            // good_quantity
            var good_quantity_id = 'good_quantity'+j;
            var good_quantity_value = document.getElementById(good_quantity_id).value;

            //total price
            total_price = total_price + good_quantity_value*good_price;


            var goods = new Object();
            goods.order_number = order_number;
            goods.good_id = good_id;
            goods.good_name = good_name;
            goods.good_price = good_price;
            goods.good_quantity = good_quantity_value;
            goods.good_image = good_image;
            goods_array.push(goods)
        }

        let good_json = JSON.stringify(goods_array);

        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "createByOwn"]).join("/")
        console.log(url)

        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        let data = JSON.stringify({
            "openId": openId,
            "order_number": order_number,
            "access_token": access_token,
            "user_name": user_name,
            "user_address": user_address,
            "user_phone": user_phone,
            "order_total_price": total_price,
            "order_comment": "无备注",
            "orderStatus": orderStatus,
            "order_total_weight": 123,
            "order_express_fee": 18,
            "items": good_json,
        });
        xhr.send(data);
        setTimeout(function(){ location.reload(); }, 2000);
    }
})

function deleteRow(id){
    var rowIdx = 'list-group_name' + id;
    document.getElementById(rowIdx).remove();
}











