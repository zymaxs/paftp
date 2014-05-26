package com.paftp.dbtools;

import java.sql.*;
import java.util.Date;

import com.paftp.bean.Testpass;

public class DBWriter {

	private String driverName = "com.mysql.jdbc.Driver";
	private String dbURL = "jdbc:mysql://localhost:3306/paftp";
	private String userName = "root";
	private String userPwd = "Paic#234";

	private Connection dbConn = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	public void insertTestpass(Testpass testpass) {
		this.getConnection();
		String sutname = testpass.getSut();
		ResultSet resultset = this.execute("select * from sut where code = '"
				+ sutname + "';");
		String sutid = this.getResult(resultset, "id");
		String version_num = testpass.getVersion();
		resultset = this.execute("select * from version where version_num = '"
				+ version_num + "';");
		String versionid = this.getResult(resultset, "id");
		//Date date = new Date();
		
		java.util.Date date = new java.util.Date();  
	    java.sql.Date e = new java.sql.Date(date.getTime());
		String testset = testpass.getTestset();
		String sql = "INSERT INTO testpass(createtime,testset,sut_id,version_id) VALUES (?,?,?,?);";
		
		PreparedStatement st;
		try {
			st = dbConn.prepareStatement(sql);
	        st.setDate(1,e); 
	        st.setString(2, testset);
	        st.setInt(3, Integer.parseInt(sutid));
	        st.setInt(4, Integer.parseInt(version_num));
	        st.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

       

		//this.execute(sql);



	}

	private Connection getConnection() {

		try {
			Class.forName(driverName);
			dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
			System.out.println("Connection Successful!");
		} catch (Exception e) {
			// e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return dbConn;
	}

	private ResultSet execute(String sql) {

		try {
			stmt = dbConn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}

	private String getResult(ResultSet resultset, String column) {
		String result = null;
		try {
			while (resultset.next()) {

				try {
					result = resultset.getString(column);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.print("\t");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}