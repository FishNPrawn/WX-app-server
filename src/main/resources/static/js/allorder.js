function mySearch() {
    // Declare variables
    var input, filter, table, tr, td, td_username, i, txtValue, txtUserNameValue, td_createTime, txtCreateTimeValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("myTable");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        td_username = tr[i].getElementsByTagName("td")[1];
        td_createTime = tr[i].getElementsByTagName("td")[5];
        if (td || td_username || td_createTime) {
            txtValue = td.textContent || td.innerText;
            txtUserNameValue = td_username.textContent || td_username.innerText;
            txtCreateTimeValue = td_createTime.textContent || td_createTime.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1 || txtUserNameValue.toUpperCase().indexOf(filter) > -1 || txtCreateTimeValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }

    }
}

function dateSearch(){
    var input, filter, table, tr, i, td_status, txtStatus;

    var dateControl = document.querySelector('select');
    filter = dateControl.value.toUpperCase();
    table = document.getElementById("myTable");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td_status = tr[i].getElementsByTagName("td")[6];
        if (td_status) {
            txtStatus = td_status.textContent || td_status.innerText;
            if (txtStatus.toUpperCase().indexOf(filter) > -1 ) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }

    }


}

