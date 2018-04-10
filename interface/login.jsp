<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page  trimDirectiveWhitespaces="true" %>
<%
    String username = request.getParameter("username") ; 
    if(username==null){
        out.println("非法请求");
        return;
    }
%>
<% 
    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test";
         Connection conn=DriverManager.getConnection(url,"root","");
         if(conn!=null){
                Statement statement = conn.createStatement();
                String type = request.getParameter("type") ; 
                String user = request.getParameter("username") ; 
                String pwd = request.getParameter("password") ;
                String sql="";
                if("0".equals( type )){
                    sql=" select * from admin where name='"+user+"' and password='"+pwd+"'";
                }else if("1".equals( type )){
                    sql=" select * from teacher where teacherId='"+user+"' and password='"+pwd+"'";
                }else{
                    sql=" select * from student where studentId='"+user+"' and password='"+pwd+"'";
                }
                ResultSet rs = statement.executeQuery(sql);
                String name=null;
             
                rs.last();
                int rowCount=rs.getRow();
                if(rowCount==1){
                    JsonObject ob = new JsonObject();
                    ob.addProperty("code","0000");
                    JsonObject object=new JsonObject();
                    if("0".equals( type )){
                        object.addProperty("id",rs.getString("adminId"));
                    }else if("1".equals( type )){
                        object.addProperty("id",rs.getString("teacherId"));
                    }else{
                        object.addProperty("id",rs.getString("studentId"));
                    }
                    
                    object.addProperty("name",rs.getString("name"));
                    ob.add("data",object);
                    out.println(ob.toString());
                }else{
                    JsonObject ob = new JsonObject();
                    ob.addProperty("code","0001");
                    out.print(ob.toString());                
                }
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
