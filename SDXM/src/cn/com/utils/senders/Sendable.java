package cn.com.utils.senders;


/**
 * 邮件，短信等发送接口
 * @author 常东旭
 *
 */
public interface Sendable {
	
	void send(String subject, String mailTo, String content) throws Exception;
	
}
