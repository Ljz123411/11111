<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page  import="net.sf.json.JSONArray"%>
<%@ page  import="net.sf.json.JSONObject"%>
<%@ page  trimDirectiveWhitespaces="true" %>
<%-- <%
    String username = request.getParameter("username") ; 
    if(username==null){
        out.println("非法请求");
        return;
    }
%> --%>
<% 
    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test";
         Connection conn=DriverManager.getConnection(url,"root","your_password");
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
                	JSONObject ob = new JSONObject();
                    ob.put("code","0000");
                    JSONObject object=new JSONObject();
                    if("0".equals( type )){
                        object.put("id",rs.getString("adminId"));
                    }else if("1".equals( type )){
                        object.put("id",rs.getString("teacherId"));
                    }else{
                        object.put("id",rs.getString("studentId"));
                    }
                    
                    object.put("name",rs.getString("name"));
                    ob.put("data",object);
                    out.println(ob.toString());
                }else{
                	JSONObject ob = new JSONObject();
                    ob.put("code","0001");
                    out.print(ob.toString());                
                }
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
