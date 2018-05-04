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
                <table id="result" class="table">
					<thead>
						<th>课程名</th><th>班级</th><th>考试时间</th><th>考试教室</th><th>监考老师</th>
					</thead>
					<today>
						<tr class="hidden">
							<td class="courseName"></td><td class="className"></td><td class="courseTime"></td><td class="courseRoom"></td><td class="courseTeacher"></td>
						</tr>
					</today>
				</table>
            </div>
        </div>
       
    </div>
    <script src="../assets/js/jquery-3.2.1.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/bootstrap-datetimepicker.min.js"></script>   
    <script src="./index.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.10/lodash.min.js"></script>
    <script>
	let startDate,endDate,teacherList,courseList,roomList,InvigilateTime,courseCount,teacherCount,roomCount,InvigilateNum,roomList2,classes;
	// InvigilateNum:每人的监考次数
	let coursesCombine=[],exams=[];//合并相同课程后的课程数组
	let courseCombineCount;//合并相同课程后的课程数量
	let ONEDAY_MILLIS=24*60*60*1000;
	let ONEHOUR_MILLIS=1*60*60*1000;
	let courseDuration_MILLIS=ONEHOUR_MILLIS*1.5
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
			console.log(startDate,new Date(startDate));
			
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
				}),
				$.ajax({
        			type:'get',
        			url:'../interface/listClass.jsp',
        			dataType:'json'
        		})
				
    		).done((courses,teachers,rooms,class2)=>{
    			courseList=courses[0].data.list;
    			teacherList=teachers[0].data.list;
				roomList=rooms[0].data.list;
				classes=class2[0].data.list;
    			courseCount=courses[0].data.count;
    			teacherCount=teachers[0].data.count;
    			roomCount=rooms[0].data.count;
    			let roomLimit=courseCount/(4*roomCount)//根据教室数量限制的天数
    			let teacherLimit=courseCount/(2*teacherCount)//根据老师数量限制的天数
				InvigilateTime=Math.ceil(teacherLimit>roomLimit?teacherLimit:roomLimit)
				InvigilateNum=Math.ceil(courseCount/(teacherCount/2));
				roomList2=_.cloneDeep(roomList);
				
				let i=0;
				courseList.map((item)=>{
					let repeatCourse=coursesCombine.find(el=>el.find(x=>x.courseId==item.courseId))
					
					if(repeatCourse){//多个班级选择同一门课 有重复课程
						item.index=repeatCourse[0].index;
						coursesCombine[repeatCourse[0].index].push(item);
					}else{
						item.index=i++;
						coursesCombine.push([item])
					}
				})
				console.log(coursesCombine);
				
				courseCombineCount=coursesCombine.length;
    			$(".info").html('总考试门数：'+courseCount+'  老师总数：'+teacherCount+'  教室总数：'+roomCount +'  合并相同课程后的考试门数：'+courseCombineCount)
    			$(".info2").html('每个教室一天最多有4场考试，上午两场，下午两场。考试最短所需时间为：'+InvigilateTime+'天。最多所需时间为：'+courseCombineCount+'天。');
    		})

		})
		
		function checkRepeat(exams,roomInfo,examTime){//检测该时间点的教室是否被占用
			let repeatroom=exams.find(el=>el.examTime==examTime&&el.roomInfo.id==roomInfo.id)
			if (repeatroom) {//重复
				roomRepeatNum++;
				if (roomRepeatNum>=roomCount) {//所有教室都安排了考试，则更改时间
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

		function addZero(num){
			return num>10?num:'0'+num;
		}

		


		$(".onOk").click(function(){
			
			if (!startDate||!endDate) {
				$("#error2").show();
				return;
			}
			$("#error2").hide();
			
			let day=(endDate-startDate)/ONEDAY_MILLIS;
			if (day<InvigilateTime) {
				$("#error3").show();
				return;
			}else if(day>courseCombineCount){
				alert('所选时间总数大于考试最多需要的天数！请重新选择。');
				return;
			}
			$("#error3").hide();
			if(!teacherList){
				$(".submit").click();
			}

			// exams=handleExamResult(day,courseCount,courseCombineCount,courseList,coursesCombine,teacherList,roomList);
			let dailyCount=Math.ceil(courseCombineCount/day);
			console.log(courseCount,day,dailyCount);
			let newCourse=coursesCombine.slice(0);

			teacherList=teacherList.map((item,index)=>{
				item.count=0;
				item.index=index;
				return item;
			})
			let newTeacherList=teacherList.slice(0);
			
			let haveinvigilateTeacher={};
			// console.log(teacherList);
			var timeCount=0;
			let exams=new Array(day).fill(1).map((item,i)=>getDailyCourse(i,day));
			console.log(exams,classes);
			
			let days=new Array(day).fill(1).map((item,i)=>startDate+i*ONEDAY_MILLIS);
			let result={};
			days.forEach((element,i) => {
				result[element]=exams[i]//结果以对象形式存在
			});
			for(let key in result){
				result[key].forEach(el=>el.forEach(item=>{
					let $clone=$("#result tr.hidden").clone();
					const {courseInfo:{courseName,classId},room,time,teachers}=item
					$clone.removeClass("hidden").find(".courseName").html(courseName)
					
					let className=classes.filter(x=>x.classId==classId)[0]
					$clone.find(".className").html(className.name);
					let courseTime=new Date(parseInt(key)+time*ONEHOUR_MILLIS );
					let courseEndTime=new Date(parseInt(key)+time*ONEHOUR_MILLIS+courseDuration_MILLIS)
					$clone.find(".courseTime").html(courseTime.getMonth()+1+'月'+courseTime.getDate()+'日  '+courseTime.getHours()+':'+addZero(courseTime.getMinutes())+'——'+courseEndTime.getHours()+':'+addZero(courseEndTime.getMinutes()));
					$clone.find(".courseRoom").html(room.name);
					teachers.forEach(x=>{
						$clone.find(".courseTeacher").html($clone.find(".courseTeacher").html()+'  '+x.name)
					})
					$("#result tbody").append($clone);
				}))
			}
			
			function getDailyCourse(i,day){//每天的课程
				let lastCourseCount=newCourse.length;
				
				let minDailyCount=lastCourseCount>dailyCount?dailyCount:lastCourseCount;
				console.log(lastCourseCount,day-i);
				
				if (lastCourseCount/minDailyCount<=day-i-1) {
					minDailyCount=1;
				}
				
				// minDailyCount= minDailyCount<0?0:minDailyCount;
				let checkedRoom={};
				dailyExamTime.forEach(x=>roomList.forEach(y=>checkedRoom[x]=checkedRoom[x].push(y)))
				let examsItem=new Array(minDailyCount).fill(1).map(item=>getCourse(checkedRoom));
				return examsItem;
			}

			function getCourse(checkedRoom){//一节课的课程安排
				let index=Math.floor(Math.random()*newCourse.length);//课程index
				let courseInfos=newCourse.splice(index,1)[0];
				const time=dailyExamTime[timeCount%4];//考试时间
				timeCount++;
				// console.log(courseInfos);
				
				return courseInfos.map(element => {
					let teachers=new Array(InvigilatePersonNum).fill(1).map(item=>getTeacher());
					let roomRepeatNum=0;
					let room=getRoom(checkedRoom,time,roomRepeatNum);
					
					return {
						courseInfo:element,
						time,
						teachers,
						room,
					}
				});
				
				//
				// // let teachers=new Array(InvigilatePersonNum).map(item=>getTeacher());
		
			}

			function getTeacher(){
				if(newTeacherList.length==0){
					newTeacherList=Object.values(haveinvigilateTeacher)
				}
				let teacherIndex=Math.floor(Math.random()*(newTeacherList.length))
				let teacherInfo=newTeacherList.splice(teacherIndex,1)[0];
				
				if(!haveinvigilateTeacher[teacherInfo.teacherId]){
					haveinvigilateTeacher[teacherInfo.teacherId]=teacherInfo;
				}
				
				if(haveinvigilateTeacher[teacherInfo.teacherId].count>InvigilateNum){//盖老师监考次数超过平均值
					getTeacher();
				}
				haveinvigilateTeacher[teacherInfo.teacherId].count=haveinvigilateTeacher[teacherInfo.teacherId].count+1;
				// console.log(teacherInfo.count);
				
				return teacherInfo;
			}

			function getRoom(checkedRoom,time,roomRepeatNum){
				if(roomList2.length==0){
					roomList2=_.cloneDeep(roomList);
				}
				let roomIndex=Math.ceil(Math.random()*(roomList2.length-1));
				let roomInfo=roomList2.splice(roomIndex,1)[0];
				
				if(!checkedRoom[roomInfo.id]){
					checkedRoom[roomInfo.id]=time;
				}else{
					if (checkedRoom[roomInfo.id].includes(time)) {//某个教室的时间段重复
						roomRepeatNum++;
						console.log('重复：',roomInfo.id,checkedRoom[roomInfo.id],time,roomRepeatNum);
						
						getRoom(checkedRoom,time,roomRepeatNum);
					}else{
						checkedRoom[roomInfo.id]+=","+time;
					}
				}
				return roomInfo;
			}

			function getCourseTeacherRoom(){
				courseInfos.map(element => {
					let teachers=new Array(InvigilatePersonNum).fill(1).map(item=>getTeacher());
					let room=getRoom(checkedRoom,time);
					
					return {
						courseInfo:element,
						time,
						teachers,
						room,
					}
				});
			}

			


			
			
			function handleExamResult(day,courseCount,courseCombineCount,courseList,coursesCombine,teacherList,roomList){
				let dailyCount=Math.ceil(courseCombineCount/day);
				console.log(courseCount,day,dailyCount);
				let newCourse=coursesCombine.slice(0);

				teacherList=teacherList.map((item,index)=>{
					item.count=0;
					item.index=index;
					return item;
				})
				let newTeacherList=teacherList.slice(0);
				let haveinvigilateTeacher={};
				// console.log(teacherList);
				var timeCount=0;
				let exams=new Array(day).fill(1).map((item,i)=>getDailyCourse(i,newTeacherList,haveinvigilateTeacher,newCourse,dailyExamTime,InvigilatePersonNum,courseCount,dailyCount,timeCount,courseCombineCount));
				console.log(exams);
				
			}
			
	
			// for(let i=0;i<time;i++){
			// 	time.push(startDate+ONEDAY_MILLIS*i)
			// }
			
			// for(let i=0;i<day;i++){
				
			// 	let exam=[]
			// 	for(let j=0;j<dailyCount;j++){
			// 		console.log("j:",j);
			// 		let index=Math.floor(Math.random()*(courseCount-(i*dailyCount+j)));//课程index
			// 		let info=newCourse.splice(index,1);//考试课程信息
					
			// 		let examTimeIndex=Math.floor(Math.random()*4);//考试时间
			// 		let examTime=new Date(startDate+ONEDAY_MILLIS*i).setHours(dailyExamTime[examTimeIndex],0,0,0);//考试时间
			// 		let roomIndex=Math.floor(Math.random()*(roomCount));
			// 		let roomInfo=roomList[roomIndex];//教室
			// 		var roomRepeatNum=0;
					
			// 		//checkRepeat(exams,roomInfo,examTime);
			// 		//console.log(roomRepeatNum);
					
			// 		let newTeacherList=teacherList.slice(0);
			// 		let teachers=[];//老师
			// 		let teacherTime=InvigilatePersonNum;
			// 		for(let k=0;k<teacherTime;k++){
			// 			let teacherIndex=Math.floor(Math.random()*(newTeacherList.length))
			// 			let teacherInfo=newTeacherList[teacherIndex];
			// 			if (teacherList[teacherInfo.index].count<InvigilateNum) {
			// 				newTeacherList.splice(teacherIndex,1);
			// 				teachers.push(teacherInfo);
			// 				teacherList[teacherInfo.index].count++;//老师监考次数增加
			// 			}else{
			// 				teacherTime++;
			// 			}
						
			// 		}
			// 		let obj={
			// 			courseInfo:info[0],
			// 			examTime,
			// 			roomInfo,
			// 			teachers,
			// 		}
			// 		exam.push(obj);
			// 	}
				
			// 	console.log(exam);
			// 	exams.push(exam);
				
			// }
			
		})
    </script>
</body>
</html>