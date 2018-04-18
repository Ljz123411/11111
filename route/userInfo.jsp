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
	    <header class="studentAside">
	    	<%@  include file="./layout/asideStudent.jsp"%>
	    </header>
	    <header class=teacherAside>
	    	<%@  include file="./layout/asideTeacher.jsp"%>
	    </header>     
       
        <div id="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        	<p class="name"></p>
        </div>
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="./index.js"></script>
    <script>
    	$(".nav-sidebar").find("li[type='1']").addClass("active").siblings("li").removeClass("active");
    	let id=localStorage.getItem("id");
    	let type=localStorage.getItem("role");
    	console.log(type);
    	function getAdminList(){
    		$.when(
   				$.ajax({
	    			type:'get',
	    			url:'../interface/userInfo.jsp',
	    			dataType:'json',
	    			data:{
	    				id:id,
	    				type,
	    			}
	    		}),
	   		
    			
    		).done((data1,data2)=>{
    			const {code,data}=data1[0];

                if (code=="0000") {
                   
                } 
                
            })
        }
        getAdminList();
        
    
    </script>
</body>
</html>