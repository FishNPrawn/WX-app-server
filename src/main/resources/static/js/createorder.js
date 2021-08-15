
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
    const good_weight = e.value.split("\"")[19];

    let good_price_idx = 'good_price' + id;
    let good_prive_value = document.getElementById(good_price_idx);
    good_prive_value.value = good_price;

    let good_weight_idx = 'good_weight' + id;
    let good_weight_value = document.getElementById(good_weight_idx);
    good_weight_value.value = good_weight;
}


// 计算总重量 运费 总价格
function calculate_price_weight_express(){
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

    if(rowCount == 0){
        alert("请添加商品")
    }else{

        var order_total_price = document.getElementById('order_total_price');
        var order_total_weight = document.getElementById('order_total_weight');
        var order_express_fee = document.getElementById('express_fee');
        var order_total_price_with_express_fee = document.getElementById('order_total_price_with_express_fee');

        var total_price = 0;
        var total_good_weight_value = 0;
        for (var j = 0; j < rowCount; j++) {
            var good_price = document.getElementsByClassName('good_price')[j].value;
            var good_quantity_value = document.getElementsByClassName('good_quantity')[j].value;
            total_price = parseFloat(total_price) +  parseFloat(good_quantity_value)*parseFloat(good_price);
            var good_weight = document.getElementsByClassName('good_weight')[j].value;
            total_good_weight_value = total_good_weight_value + parseFloat(good_weight)* parseFloat(good_quantity_value);
            console.log(total_good_weight_value)
        }

        var express_fee  = calculateExpressFee(total_good_weight_value, total_price);
        var order_total_price_with_express_fee_value = parseFloat(express_fee) + parseFloat(total_price);

        order_total_price.value = parseFloat(total_price);
        order_total_weight.value = parseFloat(total_good_weight_value);
        order_express_fee.value = parseFloat(express_fee);
        order_total_price_with_express_fee.value = parseFloat(order_total_price_with_express_fee_value);
    }
}

// 创建订单
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
        var total_good_weight_value = 0;
        var order_express_fee_value = 0;
        var order_total_price_with_express_fee_value = 0;
        for (var j = 0; j < rowCount; j++) {
            //good id
            var all_good_id = 'all_good'+j;
            // var e = document.getElementById(all_good_id);
            var e = document.getElementsByClassName("all_good")[j];
            var good_arr = e.options[e.selectedIndex].value;
            var good_id = good_arr.split("\"")[3];
            var good_price = good_arr.split("\"")[7]; //good_price
            var good_image = good_arr.split("\"")[11];
            var good_name = good_arr.split("\"")[15];


            //good price
            var good_price = document.getElementsByClassName('good_price')[j].value;
            var good_quantity_value = document.getElementsByClassName('good_quantity')[j].value;

            //total price
            total_price = parseFloat(total_price) +  parseFloat(good_quantity_value)*parseFloat(good_price);

            // total weight
            var good_weight = document.getElementsByClassName('good_weight')[j].value;
            total_good_weight_value = total_good_weight_value + parseFloat(good_weight)* parseFloat(good_quantity_value);


            var goods = new Object();
            goods.order_number = order_number;
            goods.good_id = good_id;
            goods.good_name = good_name;
            goods.good_price = good_price;
            goods.good_quantity = good_quantity_value;
            goods.good_image = good_image;
            goods_array.push(goods)
        }

        // 运费
        order_express_fee_value  = parseFloat(calculateExpressFee(total_good_weight_value, total_price));

        //总价格+运费
        order_total_price_with_express_fee_value = parseFloat(order_express_fee_value) + parseFloat(total_price);


        var ExpressFeeForWeight = parseFloat(calculateExpressFeeForWeight(total_good_weight_value));
        var order_total_discount = ExpressFeeForWeight - order_express_fee_value;

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
            "order_total_weight": total_good_weight_value,
            "order_express_fee": order_express_fee_value,
            "order_total_price_with_express_fee": order_total_price_with_express_fee_value,
            "promoCodeHeaderId": 1,
            "order_total_discount":order_total_discount,
            "items": good_json,
        });
        xhr.send(data);
        // setTimeout(function(){ location.reload(); }, 2000);
    }
})


function deleteRow(id){
    var rowIdx = 'list-group_name' + id;
    document.getElementById(rowIdx).remove();
}


function calculateExpressFeeForWeight(weight){
    var express_fee = 20;
    if(weight>0 && weight<=1000){
        express_fee = 20;
    }else if(weight > 1000 && weight <= 2000){
        express_fee = 20;
    }else if(weight > 2000 && weight <= 3000){
        express_fee = 23;
    }else if(weight > 3000 && weight <= 4000){
        express_fee = 26;
    }else if(weight > 4000 && weight <= 5000){
        express_fee = 29;
    }else if(weight > 5000 && weight <= 6000){
        express_fee = 32;
    }else if(weight > 6000 && weight <= 7000){
        express_fee = 35;
    }else if(weight > 7000 && weight <= 8000){
        express_fee = 38;
    }else if(weight > 8000 && weight <= 9000){
        express_fee = 41;
    }else if(weight > 9000 && weight <= 10000){
        express_fee = 44;
    }else{
        express_fee = 47;
    }
    return express_fee;
}


function calculateExpressFee(weight, order_total_price){
    var express_fee = 20;
    if(weight>0 && weight<=1000){
        express_fee = 20;
    }else if(weight > 1000 && weight <= 2000){
        express_fee = 20;
    }else if(weight > 2000 && weight <= 3000){
        express_fee = 23;
    }else if(weight > 3000 && weight <= 4000){
        express_fee = 26;
    }else if(weight > 4000 && weight <= 5000){
        express_fee = 29;
    }else if(weight > 5000 && weight <= 6000){
        express_fee = 32;
    }else if(weight > 6000 && weight <= 7000){
        express_fee = 35;
    }else if(weight > 7000 && weight <= 8000){
        express_fee = 38;
    }else if(weight > 8000 && weight <= 9000){
        express_fee = 41;
    }else if(weight > 9000 && weight <= 10000){
        express_fee = 44;
    }else{
        express_fee = 47;
    }
    if(order_total_price>=99 && order_total_price<199){
        express_fee = express_fee - 5;
    }else if(order_total_price>=199 && order_total_price<298){
        express_fee = express_fee - 12;
    }else if(order_total_price>=298){
        express_fee = 0;
    }
    return express_fee;
}








