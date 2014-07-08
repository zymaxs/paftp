package com.paftp.util;

import java.util.Comparator;

import com.paftp.entity.Testcase;

public class CompareObjects implements Comparator {
	
	@Override
	public int compare(Object arg0, Object arg1) {
		Testcase case1 = (Testcase) arg0;
		Testcase case2 = (Testcase) arg1;
		String name1 = case1.getCaseName().toLowerCase();
		String name2 = case2.getCaseName().toLowerCase();

		if (name1.charAt(0) > name2.charAt(0)) {
			return 1;
		} else if (name1.charAt(0) < name2.charAt(0)) {
			return -1;
		} else {
			String alphabet1 = name1.replaceAll("\\d", "");
			String alphabet2 = name2.replaceAll("\\d", "");
			int cmpAlphabet = alphabet1.compareToIgnoreCase(alphabet2);
			if (cmpAlphabet != 0) {
				return cmpAlphabet;
			}
			String numeric1 = name1.replaceAll("[^0-9]", "");
			String numeric2 = name2.replaceAll("[^0-9]", "");
			if ("".equals(numeric1)) {
				return -1;
			}
			if ("".equals(numeric2)) {
				return 1;
			}
			int result = Integer.parseInt(numeric1) - Integer.parseInt(numeric2);
			return result;
		}
	}

}
