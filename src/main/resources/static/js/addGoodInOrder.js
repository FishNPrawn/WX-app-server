// const openModalButtons = document.querySelectorAll('[data-modal-target]')
// const closeModalButtons = document.getElementById('add_category_btm')
// const overlay = document.getElementById('overlay')
// const category_user_input = document.getElementById('category_user_input')
// const cat_image = document.getElementById('category_image');
// const closecat_close_btn = document.getElementById("cat_close_btn")
//
// //放上騰訊雲只要改這邊就好
// const BASE_DOMAIN = "http://localhost:8080"
// // const BASE_DOMAIN = "https://fishnprawn.cn"     // For 腾讯云
// const DB_NAME = "fishnprawn"
// const TABLE = "category"
// const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");
// //放上騰訊雲只要改這邊就好
//
// openModalButtons.forEach(button => {
//     button.addEventListener('click', () => {
//         const modal = document.querySelector(button.dataset.modalTarget)
//         openModal(modal)
//     })
// })
//
// overlay.addEventListener('click', () => {
//     const modals = document.querySelectorAll('.modal-test.active')
//     modals.forEach(modal => {
//         closeModal(modal)
//     })
// })
//
//
// //send post(create new category) request to backend server
// closeModalButtons.addEventListener('click', () => {
//     let cat_input_value = String(category_user_input.value).trim()
//     let cat_image_value = String(cat_image.value).trim();
//
//     let xhr = new XMLHttpRequest();
//     let url = ([PREFIX, "add"]).join("/")
//
//     xhr.open("POST", url, true);
//     xhr.setRequestHeader("Content-Type", "application/json");
//     let data = JSON.stringify({"catname": cat_input_value, "cat_image": cat_image_value});
//     xhr.send(data);
//     window.location.href = url
//
// })
//
// function sendUpdateRequest(catid){
//     let content_id = catid
//     let contenteditable = document.getElementById(content_id)
//     let text = contenteditable.textContent;
//     let contenteditableImage = document.getElementById(content_id+"Image");
//     let imagetext = contenteditableImage.textContent;
//     // let catid = document.getElementById ( "catid" ).innerText
//     let http = new XMLHttpRequest();
//     let url = ([PREFIX, "updatebyid",`${catid}`]).join("/")
//     // let url = `https://fishnprawn.cn/fishnprawn/category/updatebyid/${catid}` // For 腾讯云
//     let data = JSON.stringify({
//         "cat_id": content_id,
//         "catname": text,
//         "cat_image": imagetext
//     });
//     http.open("PUT", url);
//     http.setRequestHeader("Content-Type", "application/json");
//     http.send(data);
// }
//
// function sendDeleteRequest(catid){
//     let xhr = new XMLHttpRequest();
//     let url = ([PREFIX, "deletebyid",`${catid}`]).join("/")
//     // let url = `https://fishnprawn.cn/fishnprawn/category/deletebyid/${catid}`  // For 腾讯云
//     xhr.open("DELETE", url);
//     xhr.setRequestHeader("Content-Type", "application/json");
//     xhr.send();
// }
//
//
// closecat_close_btn.addEventListener('click', ()=>{
//     // delete button todo
//     const modals = document.querySelectorAll('.modal-test.active')
//     modals.forEach(modal => {
//         closeModal(modal)
//     })
// })
//
// function openModal(modal) {
//     if (modal == null) return
//     modal.classList.add('active')
//     overlay.classList.add('active')
// }
//
// function closeModal(modal) {
//     if (modal == null) return
//     modal.classList.remove('active')
//     overlay.classList.remove('active')
// }
//
// // checkbox select all
// $(document).ready(function() {
//     $('#selectAllBoxes').click(function(event){
//         if(this.checked){
//             $('.checkBoxes').each(function(){
//                 this.checked = true;
//             });
//         }else{
//             $('.checkBoxes').each(function(){
//                 this.checked = false;
//             });
//         }
//     });
// });
//
//
