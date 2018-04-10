<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%-- <%@ page import="org.json.JSONObject" %> --%>
<%-- <%@ page import="org.json.JSONArray" %> --%>
<%@ page  trimDirectiveWhitespaces="true" %>

<% 
    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test";
         Connection conn=DriverManager.getConnection(url,"root","");
         if(conn!=null){
                Statement statement = conn.createStatement();
                String index = request.getParameter("index") ; 
                String number = request.getParameter("number") ; 
                
                String sql="";
                sql=" select * from admin ";
                ResultSet rs = statement.executeQuery(sql);
                JsonObject obj=new JsonObject();
                JsonObject ob = new JsonObject();
                JsonArray JsonArray = new JsonArray();
                ob.addProperty("code","0000");
                int rowCount=rs.getRow();
                while(rs.next()){
                    JsonArray = new JsonArray();  
                    JsonObject object=new JsonObject();
                    object.addProperty("id",rs.getString("adminId"));
                    
                    object.addProperty("name",rs.getString("name"));
                    object.addProperty("phone",rs.getString("phone"));
                    JsonArray.add(object);
                    
                }
                obj.add("list",JsonArray);
                ob.add("data",obj);
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
