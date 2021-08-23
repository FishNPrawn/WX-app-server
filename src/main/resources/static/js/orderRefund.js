// BASE_DOMAIN
const TABLE = "orderRefund"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好


const openModalButtons = document.querySelectorAll('[data-modal-target]')
const overlay = document.getElementById('overlay')
const orderRefund_close_btn = document.getElementById("orderRefund_close_btn")
const update_orderRefund_close_btn = document.getElementById('update_orderRefund_close_btn');

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

orderRefund_close_btn.addEventListener('click', ()=>{
    // delete button todo
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})

update_orderRefund_close_btn.addEventListener('click', ()=>{
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

// =======================添加退款=======================
const add_orderRefund = document.getElementById('add_orderRefund');
add_orderRefund.addEventListener('click', ()=>{
    var order_number_input = document.getElementById('order_number_input').value;
    var good_name_input = document.getElementById('good_name_input').value;
    var good_quantity_input = document.getElementById('good_quantity_input').value;
    var refund_price_input = document.getElementById('refund_price_input').value;
    var refund_remark_input = document.getElementById('refund_remark_input').value;

    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "add"]).join("/")

    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    let data = JSON.stringify({
            "orderNumber": order_number_input,
            "good_name": good_name_input,
            "good_quantity": good_quantity_input,
            "refund_price": refund_price_input,
            "refund_remark": refund_remark_input
        });
    xhr.send(data);
})
// =======================添加退款=======================
function deleteOrderRefund(order_refund_id){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "deletebyid",`${order_refund_id}`]).join("/")
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}
// =======================添加退款=======================

function updateOrderRefund(r){
    var li = r.parentElement.parentElement;

    document.getElementById('update_order_number_input').value = li.querySelector('.order_number_text').innerHTML;
    document.getElementById('update_good_name_input').value = li.querySelector('.good_name_text').innerHTML;
    document.getElementById('update_good_quantity_input').value = li.querySelector('.good_quantity_text').innerHTML;
    document.getElementById('update_refund_price_input').value = li.querySelector('.refund_price_text').innerHTML;
    document.getElementById('update_refund_remark_input').value = li.querySelector('.refund_remark_text').innerHTML;

    var order_refund_id = li.querySelector('.order_refund_id').textContent

    var update_orderRefund = document.getElementById('update_orderRefund');
    update_orderRefund.onclick = function (){
        var update_order_number_input = document.getElementById('update_order_number_input').value;
        var update_good_name_input = document.getElementById('update_good_name_input').value;
        var update_good_quantity_input = document.getElementById('update_good_quantity_input').value;
        var update_refund_price_input = document.getElementById('update_refund_price_input').value;
        var update_refund_remark_input = document.getElementById('update_refund_remark_input').value;

        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "updatebyid", order_refund_id]).join("/")
        console.log(url)
        xhr.open("PUT", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        let data = JSON.stringify(
            {
                "orderNumber": update_order_number_input,
                "good_name": update_good_name_input,
                "good_quantity": update_good_quantity_input,
                "refund_price": update_refund_price_input,
                "refund_remark": update_refund_remark_input
            });
        xhr.send(data);
    }
}

// -----------------------------------------filter-----------------------------------------
var min_date = null;
var max_date = null;
function min_date_change () {
    min_date = document.getElementById("min_date").value;
}
function max_date_change () {
    max_date = document.getElementById("max_date").value;
}

function confirmDate() {
    var endDate;
    if (max_date == null) {
        endDate = new Date();
    } else {
        endDate = new Date(max_date);
    }
    var startDate = new Date(min_date);
    startDate.setHours(0,0,0,0);
    endDate.setHours(23,59,59,0);


    var td, tdValue, i;
    var table = document.getElementById("myTable");
    var tr = table.getElementsByTagName("tr");

    for (i = 0; i < tr.length; i++){
        td = tr[i].getElementsByTagName("td")[6];
        if (td) {
            tdValue = td.textContent;
            var date = new Date(tdValue);

            if (date >= startDate && date <= endDate) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }


}
function clearDate() {
    document.getElementById("min_date").value = '';
    document.getElementById("max_date").value = '';
    min_date = null;
    max_date = null;
    var td, tdValue, i;
    var table = document.getElementById("myTable");
    var tr = table.getElementsByTagName("tr");

    for (i = 0; i < tr.length; i++){
        td = tr[i].getElementsByTagName("td")[2];
        tr[i].style.display = "";
    }
}


// -----------------------------------------filter-----------------------------------------