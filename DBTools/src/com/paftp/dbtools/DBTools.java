package com.paftp.dbtools;

import com.paftp.bean.Testpass;
import com.paftp.bean.TestsuiteResult;

public class DBTools {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ResultParser rp = new ResultParser();
		DBWriter dbw = new DBWriter();
		Testpass testpass = rp.getTestpass("C:\\GitHub\\paftp\\DBTools\\results");
		dbw.insertTestpass(testpass);
		
	}

}
