$(".nav-sidebar").on("click",function (e) {
    let type=e.target.getAttribute("type");
    console.log(type);
    
    if (type==0) {
        location.href="./admin.jsp"
        
    }
})
