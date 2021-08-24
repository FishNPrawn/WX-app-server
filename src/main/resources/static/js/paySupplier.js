// BASE_DOMAIN
const TABLE = "paySupplier"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好


const openModalButtons = document.querySelectorAll('[data-modal-target]')
const overlay = document.getElementById('overlay')
const paySupplier_close_btn = document.getElementById("paySupplier_close_btn")
const update_paySupplier_close_btn = document.getElementById('update_paySupplier_close_btn');

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

paySupplier_close_btn.addEventListener('click', ()=>{
    // delete button todo
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})

update_paySupplier_close_btn.addEventListener('click', ()=>{
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
const add_paySupplier = document.getElementById('add_paySupplier');
add_paySupplier.addEventListener('click', ()=>{
    var pay_supplier_input = document.getElementById('pay_supplier_input').value;
    var pay_supplier_date_input = document.getElementById('pay_supplier_date_input').value;
    var pay_supplier_price_input = document.getElementById('pay_supplier_price_input').value;
    var pay_supplier_or_not_input = document.getElementById('pay_supplier_or_not_input').value;

    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "add"]).join("/")

    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    let data = JSON.stringify({
        "pay_supplier": pay_supplier_input,
        "pay_supplier_date": pay_supplier_date_input,
        "pay_supplier_price": pay_supplier_price_input,
        "pay_supplier_or_not": pay_supplier_or_not_input
    });
    xhr.send(data);
})
// =======================添加退款=======================
function deletePaySupplier(pay_supplier_id){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "deletebyid",`${pay_supplier_id}`]).join("/")
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}
// =======================添加退款=======================

function updatePaySupplier(r){
    var li = r.parentElement.parentElement;
    var pay_supplier_or_not_text;
    if(li.querySelector('.pay_supplier_or_not_text').textContent == "未结算"){
        pay_supplier_or_not_text = 0;
    }else if(li.querySelector('.pay_supplier_or_not_text').textContent == "已结算"){
        pay_supplier_or_not_text = 1;
    }

    document.getElementById('update_pay_supplier_input').value = li.querySelector('.pay_supplier_text').innerHTML;
    document.getElementById('update_pay_supplier_date_input').value = li.querySelector('.pay_supplier_date_text').innerHTML;
    document.getElementById('update_pay_supplier_price_input').value = li.querySelector('.pay_supplier_price_text').innerHTML;
    document.getElementById('update_pay_supplier_or_not_input').value = pay_supplier_or_not_text;

    var pay_supplier_id = li.querySelector('.pay_supplier_id').textContent

    var update_paySupplier = document.getElementById('update_paySupplier');
    update_paySupplier.onclick = function (){
        var update_pay_supplier_input = document.getElementById('update_pay_supplier_input').value;
        var update_pay_supplier_date_input = document.getElementById('update_pay_supplier_date_input').value;
        var update_pay_supplier_price_input = document.getElementById('update_pay_supplier_price_input').value;
        var update_pay_supplier_or_not_input = document.getElementById('update_pay_supplier_or_not_input').value;

        let xhr = new XMLHttpRequest();
        let url = ([PREFIX, "updatebyid", pay_supplier_id]).join("/")
        console.log(url)
        xhr.open("PUT", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");
        let data = JSON.stringify(
            {
                "pay_supplier": update_pay_supplier_input,
                "pay_supplier_date": update_pay_supplier_date_input,
                "pay_supplier_price": update_pay_supplier_price_input,
                "pay_supplier_or_not": update_pay_supplier_or_not_input
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
        td = tr[i].getElementsByTagName("td")[3];
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
        td = tr[i].getElementsByTagName("td")[3];
        tr[i].style.display = "";
    }
}


// -----------------------------------------filter-----------------------------------------

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

