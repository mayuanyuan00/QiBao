package cn.com.common;

import java.io.FileWriter;
import java.io.IOException;

public class AlipayConfig {
	// 应用ID
	public static String app_id = "2017112200094595";

	// 商户私钥，PKCS8格式RSA2私钥
	public static String merchant_private_key = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCapmfqMKk4xluw1oMYHce3YV5sjbMfDhuCqfUWlIosX5B+/l72ePT6bhH2O8EHhfNZuCoRgdxaMZHM7ZbeBI47YCh7maqthFBWaw9HX2v0Rx6m/ZHxFtdhOD1UfdQiTgWubUUQNW6VsnLMK0gO0YR4FlH1LVLrHlBZ9lJdYNLNjTzjdfLMwwzZTBmrO3IrCJ4AvJkWZebOFzx8UDcRpNPJHsI2bwDt7deZC54uar+Qy5qXqB5FjF1Ncwli3GZaETnYjUiAfy3EoqMX4kvZAYSMih31RZ/A+7UFDQFWPSSjju+vb2M78syxKeTdgbtBHfPcb7UZF0IGzootPd8QcxatAgMBAAECggEAdpE6fnzMYPEDf3MXkzfR1TDbuhJx0E96nBU+CQ/dV+P03sibehCGkjItp0Fs3x290321EzMjBCuZAyrtTk7j1XYF062fA+W7ymXOkwP/uouEXrduWw8OFkWOD+dg6uQyyuaP2rt8i10DUrGkT2gnTgKe14DmX8kgBbkqsNj5Bgoes/n0UpvI5tjPYIyEcLlN/3zpvlLt3u2U6wYCRqCuVMqIRtalufkEFWSrT+vLplux5KsXSjABgRJBHdIs1krEfbAlDIRELgYc2PI9bYbhB3WLqkwujcrCAMs1Bh7OLaFvUodqIIsjEglW1Fz/0SzO5MI+SNLKOC6dyH+wi3KHKQKBgQDa6KDRcCRSf7NxCYRz3TM6vV+Gss4PAt4WbjMHpFcP9rdZwqDxHRwUPnBcOdf/u4w9GrPGLkUamC/mgjjzhLWW5GVSdtAJ99nTNwPgYN0QJAhTkJaQNQs/t1Z/YgGlYaTTAHjAB0+E5IBq2oXZiR1AF09NNcjNJbGC3YwQJwZLUwKBgQC02n8qxjzJEjUkslMogQ8uVTtgu4xzHmKxiocNJR/DU0VRRgw3kso2TcDS9t7ZdbC3Sh9V2lOAC6nRjUInAh0l9meiQN2h9Y12OPmdWZI8zOeh8LlT6RvWZ7N7b5obxYdeDTdHWBzL7OvJsA9FqPrNTD+kgx5tKSGQL6PSizbV/wKBgHkX6CYTD7SnOX8VEbT6LuWWbipX7M62+l2UFhxrF1IYWzKHDHp0bNzx8TvDL64idCA1Di9Z1xYwC4dKj/B9f+n5a+cjHE/3UAKb00QisQbFt+lp+S/Kd++GHo4Wi+yNSB0EjMdFBALyV+tD+HjudUTH4DFIyExbRoeqwFkLDVtLAoGAdUJlyVoW91ey1UQ53r0vFp90jFeNzOYan3pt7fvwCDjpbLS6Hx4xtdvb9ezSuLQyC+UnRAb2tMLbLF8mURxxwbdtoinkiaooOkrerULyKjHAzaLCxsERp4Y9PP8zMGZ2SmjPOpbKtP28M1zPyh6x3oJdkVDiXWyZsl7xHQXeXAkCgYAhJ/FEgRpInWPWXU3aSVYJMKcpxn5FQgqxlOn2Z8tjjrljxtXeEgUFoyHE+MJ8AbsoDVcGy60tf9buwA1l37hrFEY4Kb4fErlivE0TRnMVodezua82aiJN8xZND1tqcJngLWkKr+3YZhT6yVuOM8BWfLv7TSrS+fTkOD10TqTikA==";

	// 支付宝公钥
	public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnqM2l2GAkke5oGjH5kcTuaxFlXZM+JmOWWRSnYnbGtTcsSrY08dN6vuBR/f259VNTddmKRDgxrMWiFLcAyZg92a3qv0+p4gEi3fzSunYHZhwqUgRU1mG//vFRic9VvGrFrmF9W68/ENykOboBhf+OP4+9cogH1tWn8FxtVtBX0y6tDt6ZDmU9Rb6WPXwa4WrZE4FFcCDjHKZ4XfwXpMRnTUA4M3GbXVumqLF+Y43q8DueLotG8J8os9eMHP30Xz4u0GZrAMyiKADc2b5na+isdG6nFQFWdN7VH5RY3paJkT7p5rBAKCWG+SnI3OoXR1p03N8cOWSfqkRj+7xbk9cSwIDAQAB";

	// 服务器异步通知页面路径
	public static String notify_url = "http://localhost:8080/pay/notify.do";

	// 页面跳转同步通知页面路径
	public static String return_url = "http://localhost:8080/pay/return.do";

	// 签名方式
	public static String sign_type = "RSA2";

	// 字符编码格式
	public static String charset = "utf-8";

	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipay.com/gateway.do";

	// 日志
//	public static String log_path = "";
	public static String log_path = "C:\\";

	public static void logResult(String sWord) {
		FileWriter writer = null;
		try {
			writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis() + ".txt");
			writer.write(sWord);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (writer != null) {
				try {
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
