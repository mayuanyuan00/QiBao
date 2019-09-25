package cn.com.utils.senders;

import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import cn.com.common.Constants;
import cn.com.utils.PropertiesUtil;

/**
 * 邮件发送工具类<br>
 * 按照配置文件指定的smtp服务器启动单独的线程发送邮件。
 * @author 常东旭
 */
@Component
public class MailSender implements Sendable {

	@Autowired
	private PropertiesUtil properties;
	
	@Autowired
	private ThreadPoolTaskExecutor taskExecutor;

	class EmailSender implements Runnable {

		JavaMailSenderImpl mailSender;

		MimeMessage message;

		public EmailSender(JavaMailSenderImpl mailSender, MimeMessage message) {
			this.mailSender = mailSender;
			this.message = message;
		}

		@Override
		public void run() {
			mailSender.send(message);
		}

	}

	@Override
	public void send(String subject, String mailTo, String content) throws Exception {
		String mailFrom = properties.getProperty(Constants.MAIL.FROM);
		String mailHost = properties.getProperty(Constants.MAIL.HOST);
		String mailPort = properties.getProperty(Constants.MAIL.PORT);
		String userName = properties.getProperty(Constants.MAIL.USERNAME);
		String password = properties.getProperty(Constants.MAIL.PASSWORD);
		String mailAuth = properties.getProperty(Constants.MAIL.AUTH);
		String mailTimeout = properties.getProperty(Constants.MAIL.TIMEOUT);

		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost(mailHost);
		mailSender.setPort(Integer.valueOf(mailPort));
		mailSender.setUsername(userName);
		mailSender.setPassword(password);
		Properties mailProperties = new Properties();
		mailProperties.setProperty(Constants.MAIL.AUTH, mailAuth);
		mailProperties.setProperty(Constants.MAIL.TIMEOUT, mailTimeout);
		mailSender.setJavaMailProperties(mailProperties);

		try {
			MimeMessageHelper helper = new MimeMessageHelper(mailSender.createMimeMessage(), "UTF-8");
			helper.setSubject(subject);
			helper.setFrom(mailFrom);
			helper.setTo(mailTo);
			
			helper.setText(content, true);
			
			EmailSender sender  = new EmailSender(mailSender, helper.getMimeMessage());
			//（已修复） 此处使用单独线程发送邮件，未使用线程池，请后期注意优化，防止线程炸弹
//			Thread thread = new Thread(sender);
//			thread.start();
			taskExecutor.execute(sender);

		} catch (MailException  e) {
			e.printStackTrace();
			throw e;
		} catch (MessagingException e){
			e.printStackTrace();
			throw e;
		}
	}
	
	

}
