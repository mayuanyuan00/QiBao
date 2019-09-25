package cn.com.common;

import java.util.HashMap;
import java.util.Map;



/**
 * 常量类<br>
 * 要求:<br>
 * 1.功能模块单独写内部类区分常量<br>
 * 2.原则上常量名简洁明了，全部大写<br>
 * @author 常东旭
 *
 */
public final class Constants {
	
	public static final int PAGE_SIZE = 10;
	public static final int PAGE_SHORET_SIZE = 5;
	
	/**
	 * session内存储的信息key常量
	 * @author 常东旭
	 *
	 */
	public final class SESSION{
		public static final String CAPTCHATIMEOUT = "captchatimeout";
		public static final String CAPTCHA = "captcha";
		public static final String CAPTCHATEl = "captchatel";
		
		public static final String VERIFYCODE = "verCode";
		
		public static final String CARTINFO = "cartinfo";
	}
	
	
	/**
	 * 邮件SMTP服务器相关配置项的名称。<br>
	 * 具体信息存储在utils.properties
	 * @author 常东旭
	 *
	 */
	public final class MAIL{
		public static final String FROM = "mail.from";
		public static final String HOST = "mail.host";
		public static final String PORT = "mail.port";
		public static final String USERNAME = "mail.username";
		public static final String PASSWORD = "mail.password";
		public static final String AUTH = "mail.smtp.auth";
		public static final String TIMEOUT = "mail.smtp.timeout";
		
	}
	
	
	/**
	 * 物流查询相关常量
	 * @author 张炜婕
	 *
	 */
	
	public static final class EXPRESS{

		public static final String SHENTONG ="STO";
		
		public static final Map<String, String> EXPINFO = new HashMap<String, String>();
		static {
			EXPINFO.put("STO", "申通");
		}
	}
	
	/**
	 * 手机验证码SNS服务器相关配置项的名称。<br>
	 * 具体信息存储在utils.properties
	 * @author 张炜婕
	 *
	 */
	public final class SNS{
		public static final String URL = "sns.url";
		public static final String TESTURL = "sns.test.url";
		public static final String PORT = "sns.port";
		public static final String SID = "sns.acount.sid";
		public static final String TOKEN = "sns.auth.token";
		public static final String APPID = "sns.appid";
		public static final String MODE = "sns.mode";
		
	}
	
	/**
	 * Ping++相关配置项key
	 * @author 常东旭
	 *
	 */
	public final class PingPP{
		public static final String APPID = "pingpp.appid";
		public static final String APIKEY = "pingpp.apikey";
		public static final String PRIVATEKEYFILEPATH = "pingpp.privatekeyfilepath";
	}
	
	/**
	 * ping++支付渠道
	 * @author 常东旭
	 *
	 */
	public enum PayChannel{
		ALIPAY_WAP("alipay_wap");
		
		private final String name;
	    
	    private PayChannel(String name)
	    {
	        this.name = name;
	    }

	    public String getName() {
	        return name;
	    }
	}
	
	/**
	 * 事件监听常量
	 * @author 常东旭
	 *
	 */
	public final class EVENT{
		public static final String LOGIN = "loginEvent";
	}
	
	/**
	 * 系统内参数传递key
	 * @author 常东旭
	 *
	 */
	public final class COMMONPARAM{
		public static final String HTTPSESSION = "httpsession";
	}
}
