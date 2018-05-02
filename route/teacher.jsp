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
         <%@  include file="./layout/aside.jsp"%>
        <%-- <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li><a href="#">Overview <span class="sr-only">(current)</span></a></li>
                <li><a href="#">Reports</a></li>
                <li><a href="javascript:void(0);" type="0">管理员<span class="sr-only">(current)</span></a></li>
                <li class="active"><a href="javascript:void(0);" type="1">老师<span class="sr-only">(current)</span></a></li>
            </ul>
            
        </div> --%>
        <div id="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div id="admin">
                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal">添加老师</button>
                <div class="adminList">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>老师名称</th><th>联系方式</th><th>所属学院</th></tr>
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
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">添加老师</h4>
                </div>
                <div class="modal-body">
                    <form method="post">
                        <div class="form-group">
                            <label for="exampleInputName">老师名称</label>
                            <input type="text" class="form-control" id="exampleInputName" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputidCard">身份证号码</label>
                            <input type="text" class="form-control" id="exampleInputidCard" placeholder="身份证号码">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPhone">联系方式</label>
                            <input type="phone" class="form-control" id="exampleInputPhone" placeholder="Phone">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputSex">性别</label>
                            <label><input type="radio" name="sex" value="1" checked/>男</label>
                            <label><input type="radio" name="sex" value="2"/>女</label>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputCollege">所属学院</label>
                            <select class="custom-select" id="exampleInputCollege">
                                <option value="1" selected >电子信息与电气工程学院</option>
                                <option value="2">教育学院</option>
                                <option value="3">数学统计学院</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputJoinDate">入职时间</label>
                            <input type="date" id="exampleInputJoinDate"/>	
                        </div>
                        <div class="form-group">
                            <label for="exampleInputJoinDate">出生年月</label>
                            <input type="date" id="exampleInputBirth"/>	
                        </div>
                        <p class="text-danger">请填写姓名、身份证号码、学院</p>
                        <p class="text-danger2">该老师已存在</p>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary addAdmin">添加</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="./index.js"></script>
    <script>
    	$(".nav-sidebar").find("li[type='1']").addClass("active").siblings("li").removeClass("active");
    	function getAdminList(){
    		$.when(
   				$.ajax({
	    			type:'get',
	    			url:'../interface/listTeacher.jsp',
	    			dataType:'json'
	    		}),
	   			$.ajax({
	   				type:'get',
	   				url:'../interface/listCollege.jsp',
	   				dataType:'json'
	   			})
    			
    		).done((data1,data2)=>{
    			const {code,data}=data1[0];
    			const {data:collegedata}=data2[0]

                if (code=="0000") {
                    $(".adminTable").html("");
                    let adminList="";
                    data.list.forEach((item)=>{
                    	let collegeName=collegedata.list.filter(el=>el.collegeId==item.collegeId)

                        adminList+='<tr><td>'+item.name+'</td><td>'+item.phone+'</td><td>'+collegeName[0].name+'</td></tr>'

                    })
                    $(".adminTable").html(adminList);  
                } 
                
            })
        }
        getAdminList();
        
        $(".addAdmin").click(function () {
        	if ($("#exampleInputName").val()==""||$("#exampleInputCollege").val()==""||$("#exampleInputidCard").val()=="") {
            	console.log("输入完整");
                $(".text-danger").show();
                return;
            }
        	$(".text-danger").hide();
        	let joindate=$("#exampleInputJoinDate").val();
        	let birthday=$("#exampleInputBirth").val();
            $.ajax({
                type:'post',
                url:'../interface/addTeacher.jsp',
                dataType:'json',
                data:{
                    name:$("#exampleInputName").val(),
                    phone:$("#exampleInputPhone").val(),
                    collegeId:$("#exampleInputCollege").val(),
                    sex:$('input[name="sex"]:checked').val(),
                    joindate,
                    birthday,
                    idCardNo:$("#exampleInputidCard").val(),
                }
            }).done(data=>{
            	if(data.code=='0000'){
                	$('#myModal').modal('hide');
                    getAdminList();

                	$("#myModal input").val("");
                }else if(data.code=="0001"){
                		$(".text-danger2").show();
                }else if(data.code=="0002"){
                	$(".text-danger").show();
                }else if(data.code=="0003"){
            		alert("插入失败，请检查老师信息填写是否符合格式！");
            	}
            })
        })
    </script>
</body>
</html>