<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%request.setCharacterEncoding("utf-8");%> 
<%@ page  import="java.sql.*"%>
<%@ page  import="java.util.logging.*"%>
<%@ page  import="com.mysql.jdbc.Driver"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page  trimDirectiveWhitespaces="true" %>

<% 
    try{
         Class.forName("com.mysql.jdbc.Driver");
         String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8";
         Connection conn=DriverManager.getConnection(url,"root","");
         if(conn!=null){
        	 Statement statement = conn.createStatement();
             Statement statement2 = conn.createStatement();
             String name = request.getParameter("name") ; 
             String phone = request.getParameter("phone") ; 
             String sex = request.getParameter("sex") ;
             String collegeId=request.getParameter("collegeId");
             String idCardNo = request.getParameter("idCardNo") ; 
             String joindate = request.getParameter("joindate") ; 
             String birthday = request.getParameter("birthday") ; 
             
             JSONObject jsonObj = new JSONObject(); 
                try{
                	
                    ResultSet rs=statement.executeQuery("select  * from teacher where idCardNo='"+idCardNo+"' and name='"+name+"'");
                    rs.last(); 
                    int rowCount=rs.getRow();
                    if(rowCount>0){
                    	jsonObj.put("code","0001");
                    	jsonObj.put("msg","用户已存在");
                    	out.println(jsonObj);
                    	return;
                    }
                    String sql="insert into teacher(name,phone,sex,collegeId,idCardNo,birthday,joindate) values('"+name+"','"+phone+"','"+sex+"','"+collegeId+"','"+idCardNo+"','"+birthday+"','"+joindate+"')";
                    System.out.println(sql);
                    int count=statement.executeUpdate(sql);
                    
                    if(count==1){
                        jsonObj.put("code","0000");
                        
                    }else{
                    	jsonObj.put("code","0002");
                    }
                }catch(SQLException e){
                	System.out.println(e);
                	jsonObj.put("code","0003");
                	jsonObj.put("msg","插入失败");
                	
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
