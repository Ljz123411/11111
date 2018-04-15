$(".nav-sidebar").on("click",function (e) {
	console.log(e);
    let type=e.target.getAttribute("type");
    // $("#content").html("<%@  include file='./admin.jsp'%>")
    if (type==0) {
        location.href="./admin.jsp"
        
    }else if(type==1){
        location.href="./teacher.jsp";
    }else if(type==2){
        location.href="./student.jsp";
    }else if(type==3){
        location.href="./teacher.jsp";
    }
})

// $(".nav-sidebar").get(0).addEventListener("change", function(e) { 
//     console.log(e,process(e.type));
    
// });