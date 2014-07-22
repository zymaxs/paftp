package com.paftp.dbtools;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import com.paftp.bean.TestcaseResult;
import com.paftp.bean.TestcaseResultContent;
import com.paftp.bean.Testpass;
import com.paftp.bean.TestsuiteResult;

public class DBWriter {

	private String driverName = "com.mysql.jdbc.Driver";

	private Connection dbConn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	
	private String dbURL;
	private String userName;
	private String userPwd;

	public void insertTestpass(Testpass testpass, String path, Boolean tag) throws SQLException {
		this.setDBParameters(path, tag);
		this.getConnection(this.getDbURL(), this.getUserName(), this.getUserPwd());
		String sut_name = testpass.getSut_name();
		ResultSet resultset = this.execute("select * from Sut where name = '"
				+ sut_name + "';");
		String sut_id = null;
		if (resultset != null) {
			sut_id = this.getResult(resultset, "id");
		} else {
			System.out.println("The Sut is not exist:" + sut_name);
			return;
		}
		String version_num = testpass.getVersion_name();
		resultset = this.execute("select * from Version where version_num = '"
				+ version_num + "';");
		String version_id = null;
			if (resultset.next()) {
				version_id = resultset.getString(1);
			} else {
				System.out.println("The Version is not exist:" + version_num);
				return;
			}
		
		Date date = new Date();
		java.sql.Timestamp createtime = new java.sql.Timestamp(date.getTime());
		String testset = testpass.getTestset();
		String name = createtime.toString();
		String env = testpass.getEnv();
		String sql = "INSERT INTO Testpass(createtime,testset,sut_id,version_id,name, env) VALUES (?,?,?,?,?,?);";
		PreparedStatement st;
		try {
			st = dbConn.prepareStatement(sql);
			st.setTimestamp(1, createtime);
			st.setString(2, testset);
			st.setInt(3, Integer.parseInt(sut_id));
			st.setInt(4, Integer.parseInt(version_id));
			st.setString(5, name);
			st.setString(6, env);
			st.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		List<TestsuiteResult> testsuite_results = testpass
				.getTestsuite_results();
		for (int i = 0; i < testsuite_results.size(); i++) {
			TestsuiteResult testsuite_result = testsuite_results.get(i);
			String suitename = testsuite_result.getSuitename();
			resultset = this.execute("select * from Testpass where name = '"
					+ name + "';");
			String testpass_id = this.getResult(resultset, "id");
			String testsuite_name = testsuite_result.getSuitename();
			resultset = this.execute("select * from Testsuite where name = '"
					+ testsuite_name + "';");
			
			String testsuite_id = null;
			String testsuite_status = null;
			if (resultset.next()){
				testsuite_id = resultset.getString(1);
				testsuite_status = this.getResult(resultset, "status");
				if (testsuite_status != null && testsuite_status.equals("discard") == true){
					System.out.println("The testsuite is abanded:" + testsuite_name);
					continue;
				}
			} else {
				System.out.println("The testsuite is not exist: " + testsuite_name);
				continue;
			}
//			String checksql = "select * from testsuiteresult where suitename = '" + testsuite_name + "' and testpass_id = '" + testpass_id + "'";
//			resultset = this.execute(checksql);
//			if (resultset.next()){
//				break;
//			}
			sql = "INSERT INTO TestsuiteResult(suitename,testpass_id,testsuite_id) VALUES (?,?,?);";
			PreparedStatement st_testsuite_result;
			try {
				st_testsuite_result = dbConn.prepareStatement(sql);
				st_testsuite_result.setString(1, suitename);
				st_testsuite_result.setInt(2, Integer.parseInt(testpass_id));
				st_testsuite_result.setInt(3, Integer.parseInt(testsuite_id));
				st_testsuite_result.executeUpdate();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			List<TestcaseResult> testcase_results = testsuite_result.getTestcase_results();
			for (int j = 0; j < testcase_results.size(); j++) {
				TestcaseResult testcase_result = testcase_results.get(j);
				String casename = testcase_result.getCasename();
				Boolean Ispass = testcase_result.getIspass();
				String testcase_description = testcase_result.getDescription();
				resultset = this.execute("select * from TestsuiteResult where suitename = '"
						+ suitename + "';");
				String testsuiteresult_id = this.getResult(resultset, "id");
				String testcase_name = testcase_result.getCasename();
				resultset = this.execute("select * from Testcase where casename = '"
						+ testcase_name + "';");
				String testcase_id = null;
				if (resultset.next()){
					testcase_id = resultset.getString(1);
				}else{
					System.out.println("The testcase is not exist:" + testcase_name);
					continue;
				}
//				checksql = "select * from testcaseresult where casename = '" + testcase_name + "' and testsuiteresult_id = '" + testsuiteresult_id + "'";
//				resultset = this.execute(checksql);
//				if (resultset.next()){
//					break;
//				}
				sql = "INSERT INTO TestcaseResult(casename,ispass,description,testsuiteresult_id,testcase_id) VALUES (?,?,?,?,?);";
				PreparedStatement st_testcase_result;
				try {
					st_testcase_result = dbConn.prepareStatement(sql);
					st_testcase_result.setString(1, casename);
					int myInt = (Ispass) ? 1 : 0;
					st_testcase_result.setInt(2, myInt);
					st_testcase_result.setString(3, testcase_description);
					st_testcase_result.setInt(4, Integer.parseInt(testsuiteresult_id));
					st_testcase_result.setInt(5, Integer.parseInt(testcase_id));
					st_testcase_result.executeUpdate();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				List<TestcaseResultContent> testcaseresult_contents = testcase_result.getTestcaseresult_contents();
				for (int k = 0; k < testcaseresult_contents.size(); k++) {
					TestcaseResultContent testcaseresult_content = testcaseresult_contents.get(k);
					String status = testcaseresult_content.getType();
					String result = testcaseresult_content.getResult();
					String value = testcaseresult_content.getValue();
					resultset = this.execute("select * from TestcaseResult where casename = '"
							+ casename + "';");
					String testcaseresult_id = this.getResult(resultset, "id");	
					sql = "INSERT INTO TestcaseResultContent(status,result,value,testcase_id) VALUES (?,?,?,?);";
					PreparedStatement st_testcaseresult_content;
					try {
						st_testcaseresult_content = dbConn.prepareStatement(sql);
						st_testcaseresult_content.setString(1, status);
						st_testcaseresult_content.setString(2, result);
						st_testcaseresult_content.setString(3, value);
						st_testcaseresult_content.setInt(4, Integer.parseInt(testcaseresult_id));
						st_testcaseresult_content.executeUpdate();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						System.out.println("TestcaseContent long value is : " + casename );
						e1.printStackTrace();
					}
				
				}
			}
		}

	}

	private Connection getConnection(String dbUrl, String userName, String userPwd) {

		try {
			Class.forName(driverName);
			dbConn = DriverManager.getConnection(dbUrl, userName, userPwd);
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
	
	private void setDBParameters(String path, Boolean tag){
		Properties p;
		if (tag){
			p = this.getProperties(path + "/db.properties");
		}else{
			p = this.getProperties(path + "\\db.properties");
		}
		
		this.setDbURL(p.getProperty("dbUrl"));
		this.setUserName(p.getProperty("userName"));
		this.setUserPwd(p.getProperty("userPwd"));
	}
	
	public String getDbURL() {
		return dbURL;
	}

	public void setDbURL(String dbURL) {
		this.dbURL = dbURL;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	
	private Properties getProperties(String path) {
		InputStream in = null;
		Properties p = new Properties();
		try {
			in = new BufferedInputStream(new FileInputStream(path));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			p.load(in);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	}
}
