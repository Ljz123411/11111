<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <title>排考</title>
    <link rel="stylesheet" href="../assets/css/bootstrap-theme.css">
    <link rel="stylesheet" href="../assets/css/bootstrap.css">
    <link rel="stylesheet" href="../assets/css/bootstrap-datetimepicker.min.css">
    
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
            <div id="exam">
                <div class="form-group">
                    <label for="exampleInputName">考试时间：</label>
                    <input type="text"  id="datetimepicker" data-date-format="yyyy-mm-dd">
                    —— ——
                    <input type="text"  id="datetimepickerEnd" data-date-format="yyyy-mm-dd">    
                    </select>
                </div>
                <div id="error">请重新选择时间</div>
                <button type="button" class="btn btn-primary submit">制定考试安排</button>
             
            </div>
        </div>
       
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/bootstrap-datetimepicker.min.js"></script>   
    <script src="./index.js"></script>
    <script>
    let startDate,endDate,teacherList,courseList,roomList,InvigilateTime;
    	$('#datetimepicker').datetimepicker({
    		startDate:new Date(),
    		autoclose:true,
    		todayBtn:true,
    		timePicker:false,
    		maxView:'year',
    		minView:'month',
		
    	});
    	
    	$('#datetimepickerEnd').datetimepicker({
    		startDate:new Date(),
    		autoclose:true,
    		todayBtn:true,
    		timePicker:false,
    		maxView:'year',
    		minView:'month',
    		
    	});
    	$("#datetimepicker").on('changeDate',function(e){
    		startDate=e.date.valueOf();
    		
    	})
    	$("#datetimepickerEnd").on('changeDate',function(e){
    		endDate=e.date.valueOf();
    		if(endDate<startDate){
    			$("#error").show();
    		}
    	})
    	$(".submit").click(function(){
    		$.ajax({
    			type:'get',
    			url:'../interface/listClassCourse.jsp',
    			dataType:'json'
    		}).then(({data,code})=>{
    			if(code=='0000'){
    				courseList=data.list;
    			}
    		})
    		
    		$.ajax({
    			type:'get',
    			url:'../interface/listTeacher.jsp',
    			dataType:'json'
    		}).then(({data,code})=>{
    			if(code=='0000'){
    				teacherList=data.list;
    			}
    		})
    		
    		$.ajax({
    			type:'get',
    			url:'../interface/listClassRoom.jsp',
    			dataType:'json'
    		}).then(({data,code})=>{
    			if(code=='0000'){
    				roomList=data.list;
    			}
    		})
    		
    		InvigilateTime=courseList/teacherList.length;
    		
    	})
    </script>
</body>
</html>