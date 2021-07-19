
// BASE_DOMAIN
const TABLE = "allswiper"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
//放上騰訊雲只要改這邊就好

const openModalButtons = document.querySelectorAll('[data-modal-target]')
const closeModalButtons = document.getElementById('add_swiper_btn')
const overlay = document.getElementById('overlay')
const swiper_user_input = document.getElementById('swiper_user_input')
const closeswiper_close_btn = document.getElementById("swiper_close_btn")


// -----------Modal----------------------
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
// -----------Modal----------------------

//send post(create new swiper) request to backend server
closeModalButtons.addEventListener('click', () => {
    let cat_input_value = swiper_user_input.value;

    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "add"]).join("/")
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    let data = JSON.stringify({"image_src": cat_input_value});
    xhr.send(data);
    window.location.href = url
})

function sendUpdateRequest(swiper_img_id){
    let content_id = swiper_img_id
    let contenteditable = document.getElementById(content_id)
    let text = contenteditable.textContent;
    let http = new XMLHttpRequest();
    let url = ([PREFIX, "updatebyid",`${swiper_img_id}`]).join("/")
    let data = JSON.stringify({
        "swiper_img_id": content_id,
        "image_src": text
    });
    http.open("PUT", url);
    http.setRequestHeader("Content-Type", "application/json");
    http.send(data);
}

function sendDeleteRequest(swiper_img_id){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "deletebyid",`${swiper_img_id}`]).join("/")
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}


closeswiper_close_btn.addEventListener('click', ()=>{
    // delete button todo
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
})



