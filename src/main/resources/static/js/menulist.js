
// BASE_DOMAIN
// const PREFIX = ([BASE_DOMAIN, DB_NAME]).join("/");
const PREFIX = BASE_DOMAIN;
//放上騰訊雲只要改這邊就好

const openModalButtons = document.querySelectorAll('[data-modal-target]')
const overlay = document.getElementById('overlay')
const good_close_btn = document.getElementById("good_close_btn")
const good_close_btn1 = document.getElementById("good_close_btn1")


const good_name_input = document.getElementById('good_name_input')
const good_category_input = document.getElementById('good_category_input')
const good_price_input = document.getElementById('good_price_input')
const good_origin_price_input = document.getElementById('good_origin_price_input')
const good_stock_input = document.getElementById('good_stock_input')
const good_weight_input = document.getElementById('good_weight_input')
const good_supplier_input = document.getElementById('good_supplier_input')
const good_description_input = document.getElementById('good_description_input')
const good_production_input = document.getElementById('good_production_input')
const good_size_input = document.getElementById('good_size_input')
const good_expiration_input = document.getElementById('good_expiration_input')
const good_optimal_period = document.getElementById('good_optimal_period')
const good_publish_date = document.getElementById('good_publish_date')
const good_status_input = document.getElementById('good_status_input')
const good_image_input = document.getElementById('good_image_input')
const good_image_1_input = document.getElementById('good_image_1_input')
const good_image_description = document.getElementById('good_image_description')
const good_cat_image = document.getElementById('good_cat_image')




openModalButtons.forEach(button => {
    button.addEventListener('click', () => {
        const modal = document.querySelector(button.dataset.modalTarget)
        openModal(modal)
    })
})

overlay.addEventListener('click', () => {
    const modals = document.querySelectorAll('.modal-test.active')
    const modals1 = document.querySelectorAll('.modal-test1.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
    modals1.forEach(modal => {
        closeModal(modal)
    })
})

good_close_btn.addEventListener('click', ()=>{
    const modals = document.querySelectorAll('.modal-test.active')
    modals.forEach(modal => {
        closeModal(modal)
    })
    //window.location.replace(([PREFIX, "menulist"]).join("/"));
    // window.location.replace("https://fishnprawn.cn/fishnprawn/menulist"); // For 腾讯云
})
good_close_btn1.addEventListener('click', ()=>{
    const modals1 = document.querySelectorAll('.modal-test1.active')
    modals1.forEach(modal => {
        closeModal(modal)
    })
    //window.location.replace(([PREFIX, "menulist"]).join("/"));
    // window.location.replace("https://fishnprawn.cn/fishnprawn/menulist"); // For 腾讯云
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

const addGood_Btm = document.getElementById('add_good_btm')
addGood_Btm.addEventListener('click', ()=>{
    //add category
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX,"category", "add"]).join("/");
    // let url = "https://fishnprawn.cn/fishnprawn/category/add";  // For 腾讯云
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    let data = JSON.stringify({ "catname":good_category_input.value, "cat_image": "url1"  });
    xhr.send(data);
    //add goods
    xhr = new XMLHttpRequest();
    url = ([PREFIX, "good", "add"]).join("/");
    // url = "https://fishnprawn.cn/fishnprawn/good/add";   // For 腾讯云
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    data = JSON.stringify({
        "good_name": good_name_input.value,
        "good_price": good_price_input.value,
        "good_origin_price": good_origin_price_input.value,
        "good_stock": good_stock_input.value,
        "good_weight": good_weight_input.value,
        "good_status":good_status_input.value,
        "good_image":good_image_input.value,
        "cat_name":good_category_input.value,
        //new add element
        "good_image_1":good_image_1_input.value,
        "good_supplier":good_supplier_input.value,
        "good_description":good_description_input.value,
        "good_production":good_production_input.value,
        "good_size":good_size_input.value,
        "good_expiration":good_expiration_input.value,
        "good_optimal_period":good_optimal_period.value,
        "good_publish_date":good_publish_date.value,
        "good_image_description":good_image_description.value,
        "good_cat_image": good_cat_image.value
    });
    xhr.send(data);
})

function updateMenulist(r){
    var li = r.parentElement.parentElement;
    var updateBtn = document.getElementById("updateBtn");

    // src = li.querySelector('.imagetext').innerHTML;
    // start = src.indexOf("src=\"") + 5;
    // end = src.length - 2;
    // document.getElementById("update_good_image_input").value = src.substring(start, end) ;

    // console.log( li.querySelector('.publish_text').innerHTML);
    document.getElementById("update_good_name_input").value = li.querySelector('.nametext').innerHTML;
    document.getElementById("update_good_price_input").value = removeDot(li.querySelector('.pricetext').innerHTML);
    document.getElementById("update_good_stock_input").value = removeDot(li.querySelector('.stocktext').innerHTML);
    document.getElementById("update_good_category_input").value = li.querySelector('.catnametext').innerHTML;
    document.getElementById("update_good_weight_input").value = removeDot(li.querySelector('.weighttext').innerHTML);
    document.getElementById("update_good_image_input").value = li.querySelector('.imagetext').src;
    document.getElementById("update_good_image_1_input").value = li.querySelector('.image1text').src;
    document.getElementById("update_good_status_input").value = li.querySelector('.statustext').innerHTML;
    document.getElementById("update_good_supplier_input").value = li.querySelector('.suppliertext').innerHTML;
    document.getElementById("update_good_description_input").value = li.querySelector('.descriptiontext').innerHTML;
    document.getElementById("update_good_production_input").value = li.querySelector('.productiontext').innerHTML;
    document.getElementById("update_good_size_input").value = removeDot(li.querySelector('.sizetext').innerHTML);
    document.getElementById("update_good_expiration_input").value = li.querySelector('.expirationtext').innerHTML;
    document.getElementById("update_good_optimal_period").value = li.querySelector('.optimal_period_text').innerHTML;
    document.getElementById("update_good_publish_date").value = li.querySelector('.publish_text').innerHTML;
    document.getElementById("update_good_image_description").value =  li.querySelector('.image_description_text').src;
    document.getElementById("update_good_origin_price_input").value = li.querySelector('.priceorigintext').innerHTML;
    document.getElementById("update_good_cat_image_input").value = li.querySelector('.cat_image_text').src;
    let content_id = li.querySelector('.idtext').value;

    updateBtn.onclick = function(){
        let goodtext =  document.getElementById("update_good_name_input").value
        let pricetext =   document.getElementById("update_good_price_input").value
        let stocktext =  document.getElementById("update_good_stock_input").value
        let catnametext =  document.getElementById("update_good_category_input").value
        let weighttext =  document.getElementById("update_good_weight_input").value
        let statustext =  document.getElementById("update_good_status_input").value
        let imagetext = document.getElementById("update_good_image_input").value
        let imagetext1 = document.getElementById("update_good_image_1_input").value;
        let supptext = document.getElementById("update_good_supplier_input").value;
        let descriptiontext = document.getElementById("update_good_description_input").value;
        let producttext = document.getElementById("update_good_production_input").value;
        let sizetext = document.getElementById("update_good_size_input").value;
        let expiretext = document.getElementById("update_good_expiration_input").value;
        let optimaltext = document.getElementById("update_good_optimal_period").value;
        let publishtext = document.getElementById("update_good_publish_date").value;
        let img_descriptiontext = document.getElementById("update_good_image_description").value;
        let originpricetext =document.getElementById("update_good_origin_price_input").value;
        let goodcatimagetext = document.getElementById('update_good_cat_image_input').value;

        let http = new XMLHttpRequest();
        let data = JSON.stringify({
            "good_id": content_id,
            "good_name": goodtext,
            "good_price": pricetext,
            "good_stock": stocktext,
            "good_weight": weighttext,
            "good_origin_price": originpricetext,
            "good_status":statustext,
            "good_image":imagetext,
            "cat_name":catnametext,
            "good_image_1":imagetext1,
            "good_supplier":supptext,
            "good_description":descriptiontext,
            "good_production":producttext,
            "good_size":sizetext,
            "good_expiration":expiretext,
            "good_optimal_period":optimaltext,
            "good_publish_date":publishtext,
            "good_image_description":img_descriptiontext,
            "good_cat_image": goodcatimagetext
        });
        let url = ([PREFIX, "good/updatebyid", `${content_id}` ]).join("/")
        // let url = `https://fishnprawn.cn/good/updatebyid/${goodid}`     // For 腾讯云
        http.open("PUT", url);
        http.setRequestHeader("Content-Type", "application/json");
        http.send(data);
        // add category if the new one is not present
        http = new XMLHttpRequest();
        url = ([PREFIX, "category", "add" ]).join("/")
        // url = "https://fishnprawn.cn/category/add";      // For 腾讯云
        http.open("POST", url, true);
        http.setRequestHeader("Content-Type", "application/json");
        data = JSON.stringify({ "catname":catnametext, "cat_image": "https://images.unsplash.com/photo-1533656878820-0331502c8f70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80"  });
        http.send(data);
    }
}

function sendDeleteRequest(goodid){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "good", "deletebyid", `${goodid}` ]).join("/")
    // let url = `https://fishnprawn.cn/fishnprawn/good/deletebyid/${goodid}`      // For 腾讯云
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}


function mySearch() {
    // Declare variables
    var input, filter, table, tr, td_good_name, td_cat, i, txtGoodName, txtCat, td_createTime, txtCreateTimeValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("myTable");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td_good_name = tr[i].getElementsByTagName("td")[1];
        td_cat = tr[i].getElementsByTagName("td")[2];
        if (td_good_name || td_cat) {
            txtGoodName = td_good_name.textContent || td_good_name.innerText;
            txtCat = td_cat.textContent || td_cat.innerText;
            if (txtGoodName.toUpperCase().indexOf(filter) > -1 || txtCat.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }

    }
}

function process_url(src){
    start = src.indexOf("src=\"") + 5;
    end = src.length - 2;
    return src.substring(start, end);
}

function removeDot(input){
    ret = "";
    for (let i = 0; i < input.length; i++) {
        if(input.charAt(i)!=","){
            ret += input.charAt(i);
        }
    }
    return ret;
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