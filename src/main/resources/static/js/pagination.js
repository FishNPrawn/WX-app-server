var numberOfItems = $('#loop .list-group_name').length;
// var limitPerPage = 10;

$("#loop .list-group_name:gt(" + (limitPerPage - 1) + ")").hide();
var totolPages = Math.ceil(numberOfItems / limitPerPage);
$(".pagination").append("<li class='current-page page-item active'><a class='page-link' href='javascript:void(0)'>" + 1 + "</a></li>");

for(var i = 2; i <= totolPages; i++){
    $(".pagination").append("<li class='current-page page-item'><a class='page-link' href='javascript:void(0)'>" + i + "</a></li>");
}

$(".pagination").append("<li id='next-page'><a class='page-link' href='javascript:void(0)' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>");


$(".pagination li.current-page").on("click", function(){
    if($(this).hasClass("active")){
        return false;
    }else{
        var currentPage = $(this).index();
        $(".pagination li").removeClass("active");
        $(this).addClass("active");
        $("#loop .list-group_name").hide();

        var grandTotal = limitPerPage * currentPage;

        for(var i = grandTotal - limitPerPage; i < grandTotal; i++){
            $("#loop .list-group_name:eq(" + i + ")").show();
        }
    }
});

$("#next-page").on("click", function(){
    var currentPage = $(".pagination li.active").index();
    if(currentPage === totolPages){
        return false;
    }else{
        currentPage++;
        $(".pagination li").removeClass("active");
        $("#loop .list-group_name").hide();

        var grandTotal = limitPerPage * currentPage;

        for(var i = grandTotal - limitPerPage; i < grandTotal; i++){
            $("#loop .list-group_name:eq(" + i + ")").show();
        }
        $(".pagination li.current-page:eq(" + (currentPage - 1) + ")").addClass("active");
    }
});

$("#previous-page").on("click", function(){
    var currentPage = $(".pagination li.active").index();
    if(currentPage === 1){
        return false;
    }else{
        currentPage--;
        $(".pagination li").removeClass("active");
        $("#loop .list-group_name").hide();

        var grandTotal = limitPerPage * currentPage;

        for(var i = grandTotal - limitPerPage; i < grandTotal; i++){
            $("#loop .list-group_name:eq(" + i + ")").show();
        }
        $(".pagination li.current-page:eq(" + (currentPage - 1) + ")").addClass("active");
    }
});