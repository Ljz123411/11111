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
       
        <div id="content " class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 userInfo">
        	<div class="row">
        		<p class="col-sm-5 col-md-5 name">姓名：<span></span><input id="inputName"/></p>
        		<p class="col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 sex">性别：<span></span><input id="inputSex"/></p>
        		
        	</div>

        	<div class="row">
        		<p class="col-sm-5 col-md-5 birth">出生日期：<span></span><input id="inputBirth"/></p>
        		<p class="col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 idcard">证件号码：<span></span><input id="inputIdCard"/></p>
        		
        	</div>
        	<div class="row">
        		<p class="col-sm-5 col-md-5 id">学号：<span></span><input id="inputId"/></p>
        		<p class="col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 phone">联系电话：<span></span><input id="inputPhone"/></p>
        		
        	</div>
        	<p class="text-danger">姓名、证件号不能为空</p>
        	<p class="error">修改失败</p>
        	<button  class="btn btn-default btn-modify" id="modify">修改信息</button>
        	<div class="confirmBox">
        		<button  class="btn btn-default btn-cancel" id="cancel">取消</button>
        		<button  class="btn btn-primary btn-save" id="save">保存</button>
        	</div>
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
    		
			$.ajax({
	   			type:'get',
	   			url:'../interface/userInfo.jsp',
	   			dataType:'json',
	   			data:{
	   				id:id,
	   				type,
	   			}
	   		}).done(({code,data})=>{		
				const {list}=data
                if (code=="0000") {
                   $(".name span").html(list[0].name);
                   $(".name input").val(list[0].name);
                   $(".sex span").html(list[0].sex==1?'男':'女');
                   $(".sex input").val(list[0].sex==1?'男':'女');
                   $(".birth span").html(list[0].birthday);
                   $(".birth input").val(list[0].birthday);
                   $(".idcard span").html(list[0].idCardNo);
                   $(".idcard input").val(list[0].idCardNo);
                   $(".id span").html(list[0].studentId||list[0].teacherId);
                   $(".id input").val(list[0].studentId||list[0].teacherId);
                   $(".phone span").html(list[0].phone);
                   $(".phone input").val(list[0].phone);
                } 
                
            })
        }
        getAdminList();
        $("#modify").click(function(){
        	$(".userInfo .row p span").hide();
        	$(".userInfo .row p input").show();
        	$("#inputId").hide();
        	$(".row .id span").show();
        	$("#modify").hide();
        	$(".confirmBox").show();
        })
        $("#cancel").click(function(){
        	$("#modify").show();
        	$(".confirmBox").hide();
        	$(".userInfo .row p ").find("span").show();
        	$(".userInfo .row p ").find("input").hide();
        })
        $("#save").click(function(){
        	let sex=$("#inputSex").val()=='男'?1:2;
        	let name=$("#inputName").val();
        	let idCard=$("#inputIdCard").val();
        	if(name==""||idCard==""){
        		$(".text-danger").show();
        		return;
        	}
        	$(".text-danger").hide();
        	
        	$.ajax({
        		type:'post',
        		url:'./interface/updateUserInfo.jsp',
        		data:{
        			name,
        			sex,
        			birthday:$("#inputBirth").val(),
        			idCardNo:idCard,
        			phone:$("#inputPhone").val()
        			
        		}
        	}).done(data=>{
        		location.href="./userInfo.jsp"
        	}).fail(data=>{
        		$(".error").show();
        	})
        
        })
    
    </script>
</body>
</html>