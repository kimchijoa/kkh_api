window.test_js = function(){
    alert("test!");
}

//==============================
//window.send_API_Get_all = function(){
function send_API_Get_all(){
    console.log("Wating for Access...");
    $.ajax({ 
        url: "http://localhost:3000/books", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        data: {  }, //HTTP 요청과 함께 서버로 보낼 데이터 
        method: "GET", // HTTP 요청 메소드(GET, POST 등) 
        dataType: "json" // 서버에서 보내줄 데이터의 타입 
        
    })


    // HTTP 요청이 성공하면 요청한 데이터가 done() 메소드로 전달됨. 
    .done(function(json) {
        console.log("Good");
        console.log(json);
    })
    .fail(function(xhr, status, errorThrown) { 
            $("#text").html("오류가 발생했다.<br>")
        .append("오류명: " + errorThrown + "<br>")
        .append("상태: " + status); 
    }) 
        
    .always(function(xhr, status) { 
        alert("요청이 완료되었습니다!");
    });
}

//=======================================================

// window.send_API_Get = function(){
function send_API_Get(){
    console.log("Wating for Access...");
    var get_id = document.getElementById('get_book_id').value;
    $.ajax({ 
        url: "http://localhost:3000/books/s_id", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        data: { id: get_id }, //HTTP 요청과 함께 서버로 보낼 데이터 
        method: "GET", // HTTP 요청 메소드(GET, POST 등) 
        dataType: "json" // 서버에서 보내줄 데이터의 타입 
        
    })


    // HTTP 요청이 성공하면 요청한 데이터가 done() 메소드로 전달됨. 
    .done(function(json) {
        console.log("Good");
        console.log(json);
        console.log(json.id);
    })
    .fail(function(xhr, status, errorThrown) { 
            $("#text").html("오류가 발생했다.<br>")
        .append("오류명: " + errorThrown + "<br>")
        .append("상태: " + status); 
    }) 
        
    .always(function(xhr, status) { 
        alert("요청이 완료되었습니다!");
    });
}
window.onload = function(){
    //get_id
    const get_btn = document.getElementById("get_btn");
        get_btn.addEventListener('click', send_API_Get, false);

    //get_all
    const get_all_btn = document.getElementById("get_all_btn");
        get_all_btn.addEventListener('click', send_API_Get_all, false);


}
