<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <title>排考</title>
    <link rel="stylesheet" href="../assets/css/bootstrap-theme.css">
    <link rel="stylesheet" href="../assets/css/bootstrap.css">
    <link rel="stylesheet" href="../assets/css/home.css">
    <link rel="stylesheet" href="../assets/css/aside.css">

</head>
<body>
    <%@  include file="./layout/header.jsp"%>

    <div id="home" class="container">
    	<header class="adminAside">
    		<%@  include file="./layout/aside.jsp"%>
    	</header>
         <header class="teacherAside">
    		<%@  include file="./layout/asideTeacher.jsp"%>
    	</header>
    	<header class="studentAside">
    		<%@  include file="./layout/asideStudent.jsp"%>
    	</header>

        <%-- <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
                <li><a href="#">Reports</a></li>
                <li><a href="javascript:void(0);" type="0">管理员<span class="sr-only">(current)</span></a></li>
                <li><a href="javascript:void(0);" type="1">老师<span class="sr-only">(current)</span></a></li>
            </ul>
            
        </div> --%>
        <div id="content" class="col-sm-9 col-md-10">
            
        </div>
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="./index.js"></script>
    <script>
        
    </script>
</body>
</html>