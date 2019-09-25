package cn.com.common;

import org.springframework.stereotype.Service;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeCloseRequest;
import com.alipay.api.request.AlipayTradeFastpayRefundQueryRequest;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;

@Service
public class PayService {
	
	/**
	 * 关闭交易<br>
	 * 两个参数二选一即可
	 * @param out_trade_no 订单号
	 * @param trade_no	支付宝交易号
	 * @return
	 * @throws AlipayApiException
	 */
	public String tradeClose(String out_trade_no,String trade_no) throws AlipayApiException{
		//获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		//设置请求参数
		AlipayTradeCloseRequest alipayRequest = new AlipayTradeCloseRequest();
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," +"\"trade_no\":\""+ trade_no +"\"}");
		//请求
		String result = alipayClient.execute(alipayRequest).getBody();
		//返回
		return result;
	}
	
	/**
	 * 
	 * 退款查询<br>
	 * 订单号和支付宝交易号两个参数二选一即可
	 * @param out_trade_no  订单号
	 * @param trade_no 支付宝交易号
	 * @param out_request_no  请求退款接口时，传入的退款请求号，如果在退款请求时未传入，则该值为创建交易时的外部交易号，必填
	 * @return
	 * @throws AlipayApiException 
	 */
	public String tradeRefundQuery(String out_trade_no,String trade_no,String out_request_no) throws AlipayApiException{
		//获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		
		//设置请求参数
		AlipayTradeFastpayRefundQueryRequest alipayRequest = new AlipayTradeFastpayRefundQueryRequest();
		
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
				+"\"trade_no\":\""+ trade_no +"\","
				+"\"out_request_no\":\""+ out_request_no +"\"}");
		
		//请求
		String result = alipayClient.execute(alipayRequest).getBody();
		
		//返回
		return result;
	}
	
	/**
	 * 支付
	 * @param out_trade_no  订单号，订单系统中唯一订单号，必填
	 * @param total_amount  付款金额，必填
	 * @param subject  		订单名称，必填
	 * @param desc			商品描述，可空
	 * @return
	 * @throws AlipayApiException 
	 */
	public String tradePay(String out_trade_no,String total_amount,String subject,String desc) throws AlipayApiException{
		//获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		
		//设置请求参数
		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
		alipayRequest.setReturnUrl(AlipayConfig.return_url);
		alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
		
		
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
				+ "\"total_amount\":\""+ total_amount +"\"," 
				+ "\"subject\":\""+ subject +"\"," 
				+ "\"body\":\""+ desc +"\"," 
				+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
		
		//若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
		//alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
		//		+ "\"total_amount\":\""+ total_amount +"\"," 
		//		+ "\"subject\":\""+ subject +"\"," 
		//		+ "\"body\":\""+ body +"\"," 
		//		+ "\"timeout_express\":\"10m\"," 
		//		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
		//请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节
		
		//请求
		String result = alipayClient.pageExecute(alipayRequest).getBody();
		
		//返回
		return result;
	}
	
	/**
	 * 
	 * 交易查询<br>
	 * 订单号和支付宝交易号两个参数二选一即可
	 * @param out_trade_no	订单号，订单系统中唯一订单号
	 * @param trade_no		支付宝交易号
	 * @return
	 * @throws AlipayApiException
	 */
	public String tradeQuery(String out_trade_no,String trade_no) throws AlipayApiException{
		//获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		
		//设置请求参数
		AlipayTradeQueryRequest alipayRequest = new AlipayTradeQueryRequest();
		
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","+"\"trade_no\":\""+ trade_no +"\"}");
		
		//请求
		String result = alipayClient.execute(alipayRequest).getBody();
		
		//返回
		return result;
	}
	
	/**
	 * 
	 * 订单号和支付宝交易号两个参数二选一即可
	 * @param out_trade_no	订单号，订单系统中唯一订单号
	 * @param trade_no		支付宝交易号
	 * @param refund_amount	需要退款的金额，该金额不能大于订单金额，必填
	 * @param refund_reason	退款的原因说明
	 * @param out_request_no标识一次退款请求，同一笔交易多次退款需要保证唯一，如需部分退款，则此参数必传
	 * @return
	 * @throws AlipayApiException 
	 */
	public String tradeRefund(String out_trade_no,String trade_no,String refund_amount,String refund_reason,String out_request_no) throws AlipayApiException{
		//获得初始化的AlipayClient
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		
		//设置请求参数
		AlipayTradeRefundRequest alipayRequest = new AlipayTradeRefundRequest();
		
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
				+ "\"trade_no\":\""+ trade_no +"\"," 
				+ "\"refund_amount\":\""+ refund_amount +"\"," 
				+ "\"refund_reason\":\""+ refund_reason +"\"," 
				+ "\"out_request_no\":\""+ out_request_no +"\"}");
		
		//请求
		String result = alipayClient.execute(alipayRequest).getBody();
		
		//返回
		return result;
	}
}
