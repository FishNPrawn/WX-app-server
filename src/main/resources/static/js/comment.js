
// BASE_DOMAIN
const TABLE = "comment"
const PREFIX = ([BASE_DOMAIN, TABLE]).join("/");


function sendDeleteRequest(commentId){
    let xhr = new XMLHttpRequest();
    let url = ([PREFIX, "deletebyid",`${commentId}`]).join("/")
    xhr.open("DELETE", url);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send();
}