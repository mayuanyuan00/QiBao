package cn.com.common;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.TimeZone;

import cn.com.utils.StringUtils;

/**
 * 订单编号生成器
 * 
 * @author 常东旭
 *
 */
public class OrderNoGenerator {

	private static long lastreset = 0;

	private static HashMap<String, Integer> serials = new HashMap<>(); 
	
	/**
	 * 生成订单号（简易,不考虑多线程大并发和分布式）<br>
	 * 
	 * @param uid
	 *            用户id(要求纯数字长度小于4位,若超过截取后四位,不足前面补充0)
	 * @param platform
	 *            (要求纯数字，长度一位，超过截取后一位)
	 * @return
	 * @throws Exception 
	 */
	public static String generate(String uid) throws Exception {
		if (uid == null ) {
			throw new Exception("参数不能为null");
		}
		Date date = new Date();
		String year = getYear(date);
		String month = getMonth(date);
		String day = getDay(date);
		uid = getUID(uid);
//		String serialNo = getSerial(uid);
		long current = System.currentTimeMillis();
        long zero = current/(1000*3600*24)*(1000*3600*24) - TimeZone.getDefault().getRawOffset();
        long tamp = current -zero;
		return year + month + uid + day + StringUtils.autoZeroPadding(4, tamp+"", true, "0");
	}
	
	/**
	 * 获取流水号，用户后四位一样的人共享一个流水号增长池
	 * @param uid 用户id,注意调用顺序
	 * @return
	 * @throws Exception
	 */
	private static String getSerial(String uid) throws Exception{
		resetCheck();
		// 判断是否有对应serial
		Integer serial = serials.get(uid);
		if (serial == null) {
			serials.put(uid, 0);
			serial = 0;
		}
		serial++;
		serials.put(uid, serial);
		if ((serial+"").length() > 4) {
			throw new Exception("流水号不足");
		}
		return StringUtils.autoZeroPadding(4, serial+"", true, "0");
	}
	
	/**
	 * 获取UID，长度为4，超过时截取后四位，不足前面补0
	 * @param uid
	 * @return
	 */
	private static String getUID(String uid){
		if (uid.length()>=4) {
			return uid.substring(uid.length()-4);
		}
		return StringUtils.autoZeroPadding(4, uid, true, "0");
	}
	
	/**
	 * 获取订单来源，一位，超过截取最后一位
	 * @param platform 
	 * @return
	 */
	private static String getPlatForm(String platform){
		return platform.substring(platform.length()-1);
	}

	private static String getYear(Date date) {
		return date.getYear()-100+"";
	}

	private static String getMonth(Date date) {
		return StringUtils.autoZeroPadding(2, date.getMonth()+1+"", true, "0");

	}

	private static String getDay(Date date) {
		return StringUtils.autoZeroPadding(2, date.getDate()+"", true, "0");

	}
	
	/**
	 * 流水号重置检测
	 */
	private static void resetCheck(){
		long current = System.currentTimeMillis();
        long zero = current/(1000*3600*24)*(1000*3600*24) - TimeZone.getDefault().getRawOffset();
        if (lastreset < zero) {
        	lastreset = current;
        	serials.clear();
		}
	}
	
}
