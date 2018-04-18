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
                <li class="active"><a href="javascript:void(0);" type="0">管理员<span class="sr-only">(current)</span></a></li>
                <li><a href="#">Export</a></li>
            </ul>
            
        </div> --%>
        <div id="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div id="admin">
                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal">添加班级</button>
                <div class="adminList">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>学院</th><th>班级</th><th>入学时间</th></tr>
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
                    <h4 class="modal-title" id="myModalLabel">添加班级</h4>
                </div>
                <div class="modal-body">
                    <form method="post">
                    	<div class="form-group">
                            <label for="exampleInputCollege">所属学院</label>
                            <select class="custom-select" id="exampleInputCollege">
                                <option value="1" selected >电子信息与电气工程学院</option>
                                <option value="2">教育学院</option>
                                <option value="3">数学统计学院</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputClass">班级名称</label>
                            <input type="text"  class="form-control" id="exampleInputClass"/>

                        </div>
                        <div class="form-group">
                            <label for="exampleInputName">入学时间</label>
                            <input type="text"  class="form-control" id="exampleInputGrade"/>
                        </div>
                     
                        <p class="text-danger">请填写班级、学院</p>
                        <p class="text-danger2">该班级已存在</p>
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
    $(".nav-sidebar").find("li[type='3']").addClass("active").siblings("li").removeClass("active");
        function getAdminList(){
        	$.when(
        			$.ajax({
                        type:'get',
                        url:"../interface/listClass.jsp",
                        dataType:'json'
                    }),
                    $.ajax({
        				type:'get',
        				url:'../interface/listCollege.jsp',
        				dataType:'json'
        			}),
        	).done((data1,data2)=>{
        		console.log(data1)
        		const {code,data:{list}}=data1[0];
        		const {data:{list:collegeList}}=data2[0];
                if (code=="0000") {
                    $(".adminTable").html("");
                    let adminList="";
                    list.forEach((item)=>{
                        // let $clone=$(".tr").clone(true);
                        // $clone.removeClass("tr").appendTo($(".adminTable"));
                        // $clone.find("td").eq(0).html(item.name)
                        // $clone.find("td").eq(1).html(item.phone)
                        let college=collegeList.filter(el=>el.collegeId==item.collegeId)[0];
                        let collegeName=college?college.name:"";
                        adminList+='<tr><td>'+collegeName+'</td><td>'+item.name+'</td><td>'+item.grade+'</td></tr>'

                    })
                    $(".adminTable").html(adminList);  
                }
                
            })
        }
/*         $.ajax({
            type:'get',
            url:"../interface/listClass.jsp",
            dataType:'json'
        }).done(({code,data})=>{
        	let teacherStr='';
        	data.list.forEach(el=>{
        		console.log(el);
        		teacherStr+='<option value='+el.classId+' data-collegeId='+el.collegeId+'>'+el.name+'</option>'
        	})
        	
        	$("#exampleInputClass").html(teacherStr);
        }) */
        getAdminList();
        
        $(".addAdmin").click(function () {
            if ($("#exampleInputClass").val()==""||$("#exampleInputCollege").val()=="") {
                $(".text-danger").show();
                return;
            }
            $(".text-danger").hide();
            $.ajax({
                type:'post',
                url:'../interface/addClass.jsp',
                dataType:'json',
                data:{
                    name:$("#exampleInputClass").val(),
                    collegeId:$("#exampleInputCollege").val(),
                    grade:$("#exampleInputGrade").val(),
                }
            }).done(data=>{
                if(data.code=='0000'){
                	$('#myModal').modal('hide');
                    getAdminList();
                }else if(data.code=="0001"){
                		$(".text-danger2").show();
                }else{
                	$(".text-danger").show();
                }
            })
        })
    </script>
</body>
</html>