<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%-- <link rel="stylesheet" href="../../assets/css/aside.css"> --%>
<link rel="stylesheet" href="../assets/css/aside.css">

<div class="col-sm-3 col-md-2 sidebar">
    <ul class="nav nav-sidebar">
        <!-- <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li> -->
        
        <li><a href="./class.jsp" type="3">班级</a></li>
        <li><a href="./course.jsp" type="4">课程</a></li>
        <li><a href="javascript:void(0);" type="5">教室</a></li>
        <li><a href="javascript:void(0);" type="0">管理员</a></li>
        <li type="1"><a href="./teacher.jsp" type="1">老师</a></li>
        <li type="2"><a href="./student.jsp" type="2">学生</a></li>
        <li><a href="./exam.jsp" type="6">安排考试</a></li>
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