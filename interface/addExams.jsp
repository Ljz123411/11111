<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%request.setCharacterEncoding("utf-8");%> 
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="com.examArrange.bean.Exams" %>
<%@ page  trimDirectiveWhitespaces="true" %>

<% 
    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8";
         Connection conn=DriverManager.getConnection(url,"root","");
         if(conn!=null){
                Statement statement = conn.createStatement();
                String resultArray = request.getParameter("result") ; 
                statement.executeUpdate("truncate table exams");
                //转化为数组
                Exams[] exams =(Exams[])JSONArray.toArray(JSONArray.fromObject(resultArray),Exams.class);
                JSONObject jsonObj=new JSONObject();
                for (Exams exam : exams) {
	               	 String sql="insert into exams(examId,startTime,endTime,roomId,teacherIds,classId) "+
               	 	"values('"+exam.getCourseInfo().getId()+"','"+exam.getCourseTime()+"','"+exam.getCourseEndTime()+"','"+exam.getRoom().getId()+"','"+exam.getTeachers()[0].getTeacherId()+","+exam.getTeachers()[1].getTeacherId()+"','"+exam.getCourseInfo().getClassId()+"')";
	                 System.out.println(sql);
	               try{
	             	   int count=statement.executeUpdate(sql);
	                    
	                    if(count==1){
	                        jsonObj.put("code","0000");
	                        
	                    }else{
	                    	jsonObj.put("code","0002");
	                    }
	                }catch(SQLException e){
	             	   jsonObj.put("code","0003");
	             	   jsonObj.put("msg","插入失败");
	                }
                }
               	
                
                
                out.println(jsonObj);
         }else{
             out.println("数据库连接失败！！！");
         }
     }catch(ClassNotFoundException e){
        JSONObject result= new JSONObject();
        e.printStackTrace();
        result.put("code","9999");
        result.put("msg","接口错误");
        out.println(result.toString());

     } 
 
 
 %>
