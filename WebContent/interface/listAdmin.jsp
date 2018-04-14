<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="net.sf.json.JSONObject" %> 
<%@ page import="net.sf.json.JSONArray" %>
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
                JSONObject obj=new JSONObject();
                JSONObject ob = new JSONObject();
                JSONArray JsonArray = new JSONArray();
                ob.put("code","0000");
                int rowCount=rs.getRow();
                while(rs.next()){
                	JSONArray array = new JSONArray();  
                    JSONObject object=new JSONObject();
                    object.put("id",rs.getString("adminId"));
                    
                    object.put("name",rs.getString("name"));
                    object.put("phone",rs.getString("phone"));
                    array.add(object);
                    
                }
                obj.put("list",JsonArray);
                ob.put("data",obj);
                out.println(ob.toString());
                rs.close();
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
