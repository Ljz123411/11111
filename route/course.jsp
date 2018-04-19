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
         <header class="studentAside">
         	<%@  include file="./layout/asideStudent.jsp"%>
         </header>

        <div id="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div id="admin">
               <!-- <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal">添加班级</button>  -->
                <div class="adminList">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>班级</th><th>课程名</th><th>必修</th></tr>
                        </thead>
                        <tbody class="adminTable">
                            <%-- <tr class="tr">
                                <td></td>
                                <td></td>
                            </tr> --%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="./index.js"></script>
    <script>
    $(".nav-sidebar").find("li[type='4']").addClass("active").siblings("li").removeClass("active");
    let classId=localStorage.getItem("classId");
        function getAdminList(){
        	$.when(
        			$.ajax({
                        type:'get',
                        url:"../interface/listClass.jsp",
                        dataType:'json'
                    }),
                    $.ajax({
        				type:'get',
        				url:'../interface/listClassCourse.jsp',
        				dataType:'json',
        				data:{
        					classId:classId,
        				}
        			}),
        	).done((data1,data2)=>{
        		console.log(data1)
        		const {code,data:{list}}=data1[0];
        		const {data:{list:courseList}}=data2[0];
        		console.log(data1[0]);
                if (code=="0000") {
                    $(".adminTable").html("");
                    let adminList="";
                    courseList.forEach((item)=>{
                 	console.log(item)
                        let classId=list.filter(el=>el.classId==item.classId)[0];
                        let className=classId?classId.name:"";
                        let obligatory=item.obligatory=='1'?'是':'否';
                        adminList+='<tr><td>'+className+'</td><td>'+item.courseName+'</td><td>'+obligatory+'</td></tr>'

                    })
                    $(".adminTable").html(adminList);  
                }
                
            })
        }

        getAdminList();

    </script>
</body>
</html>