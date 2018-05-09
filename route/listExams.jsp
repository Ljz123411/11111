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
	    <header class="adminAside">
	    	<%@  include file="./layout/aside.jsp"%>
	    </header>

        <div id="content" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div id="admin">
                <h3 class="hidden">暂时没有考试相关信息！</h3>
                <div class="examList">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>课程名称</th><th>考试时间</th><th>班级</th><th>考试地点</th><th>监考老师</th></tr>
                        </thead>
                        <tbody class="adminTable">
                            <tr class="tr">
                            	<td class="courseName"></td>
                            	<td class="courseTime">
                            		<span class="startTime"><span class="date"></span><span class="time"></span></span>
                            		-
                            		<span class="endTime"><span class="time"></span></span>
                            	</td>
                            	<td class="className"></td>
                            	<td class="courseRoom"></td>
                            	<td class="courseTeacher"></td>
                            </tr>
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
    $(".nav-sidebar").find("li[type='7']").addClass("active").siblings("li").removeClass("active");
    let classId=JSON.parse(localStorage.getItem("classId"));
    let Id=JSON.parse(localStorage.getItem("id"));
    let roles=JSON.parse(localStorage.getItem("role"));
    let teacherId;
    if (roles==1) {
		teacherId=Id
	}
        	$.ajax({
        		type:'get',
        		url:'../interface/listExams.jsp',
        		data:{
        			classId,
        			teacherId,
        		},
        		dataType:'json'
        	}).done(({code,data})=>{
        		if (code=="0000") {
        			const {list}=data;
        			if(list.length==0){
        				$(".hidden").show();
        				$(".examList").hide();
        			}else{//有考试安排结果
        				$(".hidden").hide();
        				$(".examList").show();
        				let relativeInfo=getRelativeInfo(list);
        			}
				}
        		
        	})
        	
        	function getRelativeInfo(list) {
        		$.when(
            			$.ajax({
                            type:'get',
                            url:"../interface/listClass.jsp",
                            dataType:'json'
                        }),
                        $.ajax({
            				type:'get',
            				url:'../interface/listTeacher.jsp',
            				dataType:'json'
            			}),
            			 $.ajax({
             				type:'get',
             				url:'../interface/listClassCourse.jsp',
             				dataType:'json'
             			}),
             			 $.ajax({
             				type:'get',
             				url:'../interface/listClassRoom.jsp',
             				dataType:'json'
             			}),
             			/*  $.ajax({
              				type:'get',
              				url:'../interface/listTeacher.jsp',
              				dataType:'json'
              			}), */
            	).done((data1,data2,data3,d4)=>{
            		if(data1[1]=="success"){
            			let result={
                				classes:data1[0].data.list,
                				teachers:data2[0].data.list,
                				classCourses:data3[0].data.list,
                				rooms:d4[0].data.list,
                			}

        				getExamsTable(list,result);
            			
            		}
                    
                })
			}
        	
        	function getExamsTable(list,relativeInfo) {
        		console.log(relativeInfo)
        		const {classes,teachers,classCourses,rooms}=relativeInfo;
        		list.forEach(x=>{
    				let $clone=$("table tbody .tr").clone(true);
    				let classCourseInfo=classCourses.filter(item=>item.id==x.examId)[0];
    				$clone.attr({"colspan":2})
    				$clone.removeClass("tr").find(".courseName").html(classCourseInfo.courseName);
    				let className=classes.filter(item=>item.classId==classCourseInfo.classId)[0]
    				$clone.find(".className").html(className.name);
    				let startTime=new Date(parseInt(x.startTime));
    				let endTime=new Date(parseInt(x.endTime));
    			
    				$clone.find(".courseTime .startTime .date").html(startTime.getMonth()+1+"月"+startTime.getDate()+"日")
    				$clone.find(".courseTime .startTime .time").html(addZero(startTime.getHours())+":"+addZero(startTime.getMinutes()))
    				//$clone.find(".courseTime .endTime .date").html(endTime.getMonth()+1+"月"+endTime.getDate()+"日")
    				$clone.find(".courseTime .endTime .time").html(addZero(endTime.getHours())+":"+addZero(endTime.getMinutes()))
    				let room=rooms.filter(item=>item.id==x.roomId)[0]
    				$clone.find(".courseRoom").html(room?room.name:"");
    				let teacherIds=x.teacherIds.split(",");
    				let teacherName=teacherIds.map(item=>{
    					let name=teachers.filter(y=>y.teacherId==item)[0].name
    					let tname=$clone.find(".courseTeacher").html()
    					$clone.find(".courseTeacher").html(tname+" "+name)
    					})
    				
    				$("table tbody").append($clone);
        		})
			}
       
			function addZero(num){
				if(num<10){
					return '0'+num;
				}else{
					return num;
				}
			}
     
    </script>
</body>
</html>