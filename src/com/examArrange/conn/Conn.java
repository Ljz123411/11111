package com.examArrange.conn;

import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.omg.CORBA.INTERNAL;
import org.omg.PortableServer.ServantActivator;

import java.util.ArrayList;
import java.sql.*;
import java.util.logging.*;
import com.mysql.jdbc.Driver;
import com.sun.org.apache.xml.internal.security.Init;
public class Conn {
	private static Connection conn;
	   Statement stmt;
	   ResultSet rs ;
	 
	   public static void main() {
	   
		   try {
		 
		     Class.forName("com.mysql.jdbc.Driver");
		     String url="jdbc:mysql://localhost:3306/test";
		     conn=DriverManager.getConnection(url,"root","");
		 
		   } catch(java.lang.ClassNotFoundException e) {
		 
		     System.err.println("Load Driver Error: " + e.getMessage());
		 
		   } catch(SQLException ex) {
		 
		     System.err.println("Get Connection Error: " + ex.getMessage());
		   }
	   }
	   
	   public ResultSet executeQuery(String sql) {
	 
		   try {
		 
		     stmt = conn.createStatement();
		 
		     rs = stmt.executeQuery(sql);
		 
		   } catch(SQLException ex) {
		 
		     System.err.println("SQL Error: " + ex.getMessage());
		   }
	 
	     return rs;
	 
	   }
	 
	   public void close() throws SQLException {
	     
	     stmt.close();
	     conn.close();
	 
	   }
	   

    
}