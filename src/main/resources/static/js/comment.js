

//放上騰訊雲只要改這邊就好
const BASE_DOMAIN = "http://localhost:8080"
// const BASE_DOMAIN = "https://fishnprawn.cn"     // For 腾讯云
const DB_NAME = "fishnprawn"
const TABLE = "comment"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");


function sendDeleteRequest(commentId){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "deletebyid",`${commentId}`]).join("/")
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}