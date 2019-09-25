package cn.com.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * String工具类<br>
 * 继承了apache.common.lang中的Stringutils
 * 
 * @author 常东旭
 *
 */
public class StringUtils extends org.apache.commons.lang3.StringUtils {

	/**
	 * 验证邮箱
	 *
	 * @param email
	 * @return
	 */

	public static boolean checkEmail(String email) {
		boolean flag = false;
		try {
			String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
			Pattern regex = Pattern.compile(check);
			Matcher matcher = regex.matcher(email);
			flag = matcher.matches();
		} catch (Exception e) {
			flag = false;
		}
		return flag;
	}

	/**
	 * 验证手机号码，11位数字，1开通，第二位数必须是3456789这些数字之一 *
	 * 
	 * @param mobileNumber
	 * @return
	 */
	public static boolean checkMobileNumber(String mobileNumber) {
		boolean flag = false;
		try {
			// Pattern regex =
			// Pattern.compile("^(((13[0-9])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8})|(0\\d{2}-\\d{8})|(0\\d{3}-\\d{7})$");
			Pattern regex = Pattern.compile("^1[345789]\\d{9}$");
			Matcher matcher = regex.matcher(mobileNumber);
			flag = matcher.matches();
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;

		}
		return flag;
	}

	/**
	 * 为指定的字符串左侧或右侧按照给定长度补充特定字符
	 * @param length 补充后的长度
	 * @param code	当前字符串
	 * @param isleft 是否左侧补充
	 * @param padding 补充内容
	 * @return 
	 */
	public static String autoZeroPadding(int length, String code, boolean isleft, String padding) {
		int strLen = code.length();
		StringBuffer sb = null;
		while (strLen < length) {
			sb = new StringBuffer();
			if (isleft) {
				sb.append(padding).append(code);// 左补0
			} else {
				sb.append(code).append(padding);// 右补0
			}
			code = sb.toString();
			strLen = code.length();
		}
		return code;
	}

	/**
	 * 去除字符串中html标签
	 */
	public static String removeHtml(String str){
		if (str==null){
			str="";
		}
		str = str.replaceAll("</?[^>]+>", "");
		str = str.replaceAll("<a>\\s*|t|r|n</a>", "");
		return str;
	}
	
}
