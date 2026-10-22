package test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JavaMySql {

	 public static void main(String[] args) {
	 

	   try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		System.out.println("驱动不存在");
		e.printStackTrace();
	}
	   Connection con;
	try {
		con = DriverManager.getConnection(
		     "jdbc:mysql://192.168.1.13/fajxc", "root", "12345");
	
	   PreparedStatement pstmt = null;

	   /*
	    create table mypicture 
	    ( name varchar(20),
	    image blob  );      
	    */

	  
		pstmt = con.prepareStatement("select * from questioncategory");
	

	  ResultSet rs;

		rs = pstmt.executeQuery();
	

		while(rs.next()){
			 
			 System.out.println(rs.getInt("id"));
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

//	   System.out.println("file length:" + length);
//	   System.out.println("byte length:" + byteLength);
	   System.out.println("插入成功.");


	 }

	}