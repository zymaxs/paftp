package com.paftp.util;

import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.misc.BASE64Encoder;


/**
 * 閫氱敤宸ュ叿绫�
 */
public class Util {

	/**
	 * 瀵瑰瓧绗︿覆杩涜MD5鍔犲瘑
	 * 
	 * @param str
	 * @return String
	 */
	public String md5Encryption(String str) {
		String newStr = null;
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.reset();
			md5.update(str.getBytes("UTF-8"));
			BASE64Encoder base = new BASE64Encoder();
			newStr = base.encode(md5.digest());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newStr;
	}

	/**
	 * 鍒ゆ柇瀛楃涓叉槸鍚︿负绌�
	 * 
	 * @param str
	 *            瀛楃涓�
	 * @return true锛氫负绌猴紱 false锛氶潪绌�
	 */
	public static boolean isNull(String str) {
		if (str != null && !str.trim().equals("")) {
			return false;
		} else {
			return true;
		}
	}

	public java.sql.Date stringToSqlDate(String time) throws ParseException {

		DateFormat format = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
		if (time == null || time.equals(""))
			return null;
		java.util.Date date = format.parse(time);
		if (date == null)
			return null;
		java.sql.Date sqlDate = new java.sql.Date(date.getTime());

		return sqlDate;
	}

	public String[] splitString(String stringstream) {
		if (stringstream == null)
			return null;
		String strings[] = stringstream.split(";");
		if (strings.length == 1 && strings[0].equals(""))
			return null;
		return strings;
	}

	public JSONObject childNode(Integer id, String text, String type, JSONArray parent) {

		JSONObject children = new JSONObject();
		children.put("id", id);
		children.put("text", text);
		children.put("type", type);

		if (parent != null) {
			children.put("children", parent);
		}

		return children;
	}
	
	public String nodeType(String type){
		if (type == "0"){
			return "interfacetestcase";
		}
		
		if (type == "00"){
			return "testcase";
		}
		
		if (type == "01"){
			return "stresstestcase";
		}
		
		return "";
	}
}