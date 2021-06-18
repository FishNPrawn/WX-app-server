const openModalButtons = document.querySelectorAll('[data-modal-target]')
const closeModalButtons = document.getElementById('add_category_btm')
const overlay = document.getElementById('overlay')
const category_user_input = document.getElementById('category_user_input')
const closecat_close_btn = document.getElementById("admin_close_btn")

//放上騰訊雲只要改這邊就好
const BASE_DOMAIN = "http://localhost:8080"
// const BASE_DOMAIN = "https://fishnprawn.cn"     // For 腾讯云
const DB_NAME = "fishnprawn"
const TABLE = "admin"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好

const FIELD_MAPPING = {
    'username':'admin_username',
    'password':'admin_password',
    'phone':'admin_phone',
    'admintype':'admin_type'
}

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



closecat_close_btn.addEventListener('click', ()=>{
    // delete button todo
    window.location.replace(PREFIX);
    // window.location.replace("https://fishnprawn.cn/fishnprawn/admin");     // For 腾讯云
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


const addAdmin_Btm = document.getElementById('add_admin_btm')
addAdmin_Btm.addEventListener('click', ()=>{
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "add"]).join("/");
    // let url = String.join("/", PREFIX, "add");
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    var data = {};
    Object.keys(FIELD_MAPPING).forEach(key => {
        data[key] = document.getElementById(FIELD_MAPPING[key]).value
    })
    let body = JSON.stringify(data);
    xhr.send(body);
})

function sendUpdateRequest(adminid){
    //get fields of given adminid
    var data = {};
    Object.keys(FIELD_MAPPING).forEach(key => {
        data[key] = document.getElementById(key+adminid).innerText
    })
    let xhr = new XMLHttpRequest();
    xhr.withCredentials = true;
    // let url = String.join("/", PREFIX, `updatebyid/${adminid}`)
    let url = ([PREFIX, `updatebyid/${adminid}`]).join("/")
    xhr.open("PUT", url); //snyc is deprecated
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify(data));
}

function sendDeleteRequest(adminid){
    let xhr = new XMLHttpRequest();

    let url = ([PREFIX, `deletebyid/${adminid}`]).join("/")
    xhr.withCredentials = true;
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}

$('[data-hidden-value]').on('click', function () {
    var
        $wrapper = $(this).parent(),
        revealed = $wrapper.data('revealed')
    ;
    $wrapper.data('revealed', !revealed);
});