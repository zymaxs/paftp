package com.paftp.util;

import java.security.MessageDigest;
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
}