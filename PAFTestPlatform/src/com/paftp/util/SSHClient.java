package com.paftp.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;

/************************************************************************************
 * @File name   :      SSHClient.java
 * @Author      :      duanjuding451
 * @Date        :      2014年5月22日
 * @Copyright   :      平安付-科技中心-移动研发-测试部
 ************************************************************************************/

/**
 *
 */
public class SSHClient {
	private Connection conn;
	
	
	public boolean connect(String host, String username, String password)
			throws IOException {
		conn= new Connection(host);
		conn.connect();
		return conn.authenticateWithPassword(username, password);

	}
	
	public String execute(String cmd) throws IOException{
		Session sess = conn.openSession();
		sess.execCommand(cmd);
		InputStream inp = sess.getStdout();
		InputStreamReader reader = new InputStreamReader(inp);
		BufferedReader br = new BufferedReader(reader);
		String line = null;
		line = br.readLine();	
		return line;		
	}
	
	public void close(){
		conn.close();
	}
}
