<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%-- <link rel="stylesheet" href="../../assets/css/aside.css"> --%>
<link rel="stylesheet" href="../assets/css/aside.css">

<div class="col-sm-3 col-md-2 sidebar">
    <ul class="nav nav-sidebar">
        <!-- <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li> -->
        
        <li type="1"><a href="./userInfo.jsp" type="my">个人信息</a></li>
        <li type="4"><a href="./course.jsp" type="4">课程</a></li>
        <li type="2"><a href="./student.jsp" type="7">考试安排</a></li>
    </ul>
    
</div>
<script src="../assets/js/jquery-3.2.1.js"></script>
<script>
     $(".nav-sidebar").click(function (e) {
        let type=e.target.getAttribute("type");
        console.log(type);
		$(e.target).parent("li").addClass("active").siblings("li").removeClass("active");
        //$(this).change(type);
        // $(this).trigger("change",[type])
        // var event = new CustomEvent("cat", {"type":type});
        // $(this).get(0).dispatchEvent(event);
    }); 
</script>