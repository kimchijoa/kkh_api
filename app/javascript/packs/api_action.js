window.test_js = function(){
    alert("test!");
}

//========================================

//==============================
//window.send_API_Get_all = function(){
function send_API_Get_all(){
    console.log("Wating for Access...");
    $.ajax({ 
        url: "https://kkhapi.herokuapp.com/books", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
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
        url: "https://kkhapi.herokuapp.com/books/s_id", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
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
//===============================================================
function send_API_Delete(){
    console.log("Wating for Access...");
    var get_id = document.getElementById('d_book_id').value;
    $.ajax({ 
        // url: "https://kkhapi.herokuapp.com/books/d_book", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        url: "https://kkhapi.herokuapp.com/books/d_book", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        data: { id: get_id }, //HTTP 요청과 함께 서버로 보낼 데이터 
        method: "DELETE", // HTTP 요청 메소드(GET, POST 등) 
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

//==============================================================

     function LoadingWithMask() {
        //화면의 높이와 너비를 구합니다.
        var maskHeight = $(document).height();
        var maskWidth  = window.document.body.clientWidth;
        alert("test_loading!");
         
        //화면에 출력할 마스크를 설정해줍니다.
        var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
        var loadingImg = '';
          
        loadingImg += "<div id='loadingImg'>";
        loadingImg += " <img src='/Spinner.gif' style='position: relative; display: block; margin: 0px auto;'/>";
        loadingImg += "</div>";  
      
        //화면에 레이어 추가
        $('body')
            .append(mask)
            .append(loadingImg)
            
        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
        $('#mask').css({
                'width' : maskWidth
                , 'height': maskHeight
                , 'opacity' : '0.3'
        }); 
      
        //마스크 표시
        $('#mask').show();   
      
        //로딩중 이미지 표시
        $('#loadingImg').show();
    }

window.onload = function(){
    //get_id
    const get_btn = document.getElementById("get_btn");
        get_btn.addEventListener('click', send_API_Get, false);

    //get_all
    const get_all_btn = document.getElementById("get_all_btn");
        get_all_btn.addEventListener('click', send_API_Get_all, false);
    //get_all
    const d_btn = document.getElementById("delete_btn");
        d_btn.addEventListener('click', send_API_Delete, false);

    const make_v = document.getElementById("make_v");
        make_v.addEventListener('click', LoadingWithMask, false);

}
