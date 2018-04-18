<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="com.alibaba.fastjson.JSON" %>

<%@ page  trimDirectiveWhitespaces="true" %>

<% 

    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test";
         Connection conn=DriverManager.getConnection(url,"root","");
         if(conn!=null){
                Statement statement = conn.createStatement();
                String Id = request.getParameter("id") ; 
                String type = request.getParameter("type") ; 
                String sql="";
                if("1".equals( type )){
                    sql=" select teacherId,name,collegeId,joindate,phone,sex,birthday,idCardNo from teacher where teacherId='"+Id+"'";
                }else{
                    sql=" select studentId,name,collegeId,classId,phone,sex,birthday,idCardNo from student where studentId='"+Id+"'";
                }
          
                ResultSet rs = statement.executeQuery(sql);
                ResultSetMetaData md = rs.getMetaData();
                int columnCount = md.getColumnCount();
                JSONObject obj=new JSONObject();
                JSONObject ob = new JSONObject();
                JSONArray JsonArray = new JSONArray();
                ob.put("code","0000");
                JsonArray = new JSONArray();  
                while(rs.next()){
                	JSONObject item=new JSONObject();
                    for(int i=1;i<=columnCount;i++){
                    	String columnName=md.getColumnLabel(i);
                    	item.put(md.getColumnLabel(i),rs.getString(columnName));
                    }
                    
                    JsonArray.add(item);
                }
                rs.last();
                int rowCount=rs.getRow();
                obj.put("list",JsonArray);
                obj.put("count",rowCount);
                ob.put("data",obj);
                out.println(ob.toString()); 

              
                rs.close();
         }else{
             out.println("数据库连接失败！！！");
         }
     }catch(ClassNotFoundException e){
        JsonObject result= new JsonObject();
        e.printStackTrace();
        result.addProperty("code","9999");
        result.addProperty("msg","接口错误");
        out.println(result.toString());

     } 
 
 
 %>