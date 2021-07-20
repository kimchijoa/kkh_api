// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("packs/api_action")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)



//================================================

function send_API_Get(params_id){
    console.log("Wating for Access...");
    $.ajax({ 
        url: "http://localhost:3000/books/s_id", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        data: { id: params_id }, //HTTP 요청과 함께 서버로 보낼 데이터 
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
