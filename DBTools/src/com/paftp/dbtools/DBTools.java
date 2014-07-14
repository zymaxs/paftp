package com.paftp.dbtools;

import java.sql.SQLException;
import java.util.Properties;

import com.paftp.bean.Testpass;
import com.paftp.bean.TestsuiteResult;

public class DBTools {

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		
		String root;
		if (args.length > 0 && args[0] != null && args[0].equals("") == false){
			root = args[0];
		} else {
			root = "C:\\GitHub\\paftp\\DBTools\\results";
		}
		
		ResultParser rp = new ResultParser();
		DBWriter dbw = new DBWriter();
		Testpass testpass = rp.getTestpass(root);
		dbw.insertTestpass(testpass, root);
		
	}

}
