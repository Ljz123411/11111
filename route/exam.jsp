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
				<button type="button" class="btn btn-primary submit">查看考试相关信息</button>
             	<p class="info"></p>
             	<p class="info2"></p>
				 <hr>
                <div class="form-group">
                    <label for="exampleInputName">考试时间：</label>
                    <input type="text"  id="datetimepicker" data-date-format="yyyy-mm-dd">
                    —— ——
                    <input type="text"  id="datetimepickerEnd" data-date-format="yyyy-mm-dd">    
                    </select>
                </div>
                <div id="error">请重新选择时间</div>
                <div id="error2">请先选择考试时间区间</div>
                <div id="error3">选择的考试时间小于最少时间要求，请重新选择。</div>
				<button type="button" class="btn btn-primary onOk">产生排考结果</button>
                
            </div>
        </div>
       
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/bootstrap-datetimepicker.min.js"></script>   
    <script src="./index.js"></script>
    <script>
	let startDate,endDate,teacherList,courseList,roomList,InvigilateTime,courseCount,teacherCount,roomCount,InvigilateNum;
	// InvigilateNum:每人的监考次数
	let ONEDAY_MILLIS=24*60*60*1000;
	let dailyExamTime=['8','10','14','16'];
	let InvigilatePersonNum=2;
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
    		startDate=new Date(e.date.valueOf()).setHours(0,0,0);
    	})
    	$("#datetimepickerEnd").on('changeDate',function(e){
    		endDate=new Date(e.date.valueOf()).setHours(0,0,0)+ONEDAY_MILLIS;
    		if(endDate<startDate){
    			$("#error").show();
    		}else{
    			$("#error").hide();
    		}
    	})
    	$(".submit").click(function(){
    		$.when(
    			$.ajax({
        			type:'get',
        			url:'../interface/listClassCourse.jsp',
        			dataType:'json'
        		}),
        		
        		$.ajax({
        			type:'get',
        			url:'../interface/listTeacher.jsp',
        			dataType:'json'
        		}),
        		
        		$.ajax({
        			type:'get',
        			url:'../interface/listClassRoom.jsp',
        			dataType:'json'
        		})
    		).done((courses,teachers,rooms)=>{
    			courseList=courses[0].data.list;
    			teacherList=teachers[0].data.list;
    			roomList=rooms[0].data.list;
    			courseCount=courses[0].data.count;
    			teacherCount=teachers[0].data.count;
    			roomCount=rooms[0].data.count;
    			console.log(courseCount);
    			let roomLimit=courseCount/(4*roomCount)//根据教室数量限制的天数
    			let teacherLimit=courseCount/(2*teacherCount)//根据老师数量限制的天数
				InvigilateTime=Math.ceil(teacherLimit>roomLimit?teacherLimit:roomLimit)
				InvigilateNum=Math.ceil(courseCount/(teacherCount*2));
				
    			$(".info").html('总考试门数：'+courseCount+'  老师总数：'+teacherCount+'  教室总数：'+roomCount)
    			$(".info2").html(`每个教室一天最多有4场考试，上午两场，下午两场。考试最短所需时间为：`+InvigilateTime+`天。`);
    		})

		})
		
		$(".onOk").click(function(){
			
			if (!startDate||!endDate) {
				$("#error2").show();
				return;
			}
			$("#error2").hide();
			
			let time=(endDate-startDate)/ONEDAY_MILLIS;
			if (time<InvigilateTime) {
				$("#error3").show();
				return;
			}
			$("#error3").hide();
			if(!teacherList){
				$(".submit").click();
			}
			let dailyCount=Math.ceil(courseCount/time);
			console.log(courseCount,time,dailyCount);
			let newCourse=courseList.slice(0);

			teacherList=teacherList.map((item,index)=>{
				item.count=0;
				item.index=index;
				return item;
			})
			// console.log(teacherList);
			

			// for(let i=0;i<time;i++){
			// 	time.push(startDate+ONEDAY_MILLIS*i)
			// }
			let exams=[]
			for(let i=0;i<2;i++){
				console.log("i",i);
				
				let exam=[]
				for(let j=0;j<dailyCount;j++){
					console.log("j:",j);
					
					let index=Math.floor(Math.random()*(courseCount-(i*dailyCount+j)));
					let info=newCourse.splice(index,1);
					
					let examTimeIndex=Math.floor(Math.random()*4);
					let examTime=new Date(startDate+ONEDAY_MILLIS*i).setHours(dailyExamTime[examTimeIndex],0,0,0);//考试时间
					let roomIndex=Math.floor(Math.random()*(roomCount));
					let roomInfo=roomList[roomIndex];//教室
					let roomRepeatNum=0;
					function checkRepeat(exams,roomInfo,examTime){
						let repeatroom=exams.find(el=>el.examTime==examTime&&el.roomInfo.id==roomInfo.id)
						if (repeatroom) {//重复
							roomRepeatNum++;
							if (roomRepeatNum>=roomCount) {
								examTimeIndex=Math.floor(Math.random()*3);
								let dailyExamTime2=dailyExamTime.slice(0);
								dailyExamTime2.splice(examTimeIndex,1)
								examTime=new Date(startDate+ONEDAY_MILLIS*i).setHours(dailyExamTime2[examTimeIndex],0,0,0);//考试时间
							}else{
								roomIndex=Math.floor(Math.random()*(roomCount));
								roomInfo=roomList[roomIndex];//教室
							}
							
							checkRepeat(exams,roomInfo,examTime)
						}
					}
					checkRepeat(exams,roomInfo,examTime);

					let newTeacherList=teacherList.slice(0);
					let teachers=[];//老师
					let teacherTime=InvigilatePersonNum;
					for(let k=0;k<teacherTime;k++){
						let teacherIndex=Math.floor(Math.random()*(newTeacherList.length))
						let teacherInfo=newTeacherList[teacherIndex];
						if (teacherList[teacherInfo.index].count<InvigilateNum) {
							newTeacherList.splice(teacherIndex,1);
							teachers.push(teacherInfo);
							teacherList[teacherInfo.index].count++;//老师监考次数增加
						}else{
							teacherTime++;
						}
						
					}
					let obj={
						courseInfo:info[0],
						examTime,
						roomInfo,
						teachers,
					}
					exam.push(obj);
				}
				
				console.log(exam);
				exams.push(exam);
				
			}
			console.log(exams);
			
		})
    </script>
</body>
</html>