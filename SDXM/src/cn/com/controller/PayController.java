package cn.com.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.com.domain.Links;
import cn.com.service.ILinksService;
import cn.com.vo.PageResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;

import cn.com.common.AlipayConfig;
import cn.com.common.PayService;
import cn.com.domain.Order;
import cn.com.domain.User;
import cn.com.service.IOrderService;

@Controller
@RequestMapping("pay")
public class PayController {

	@Autowired
	private PayService payService;
	
	@Autowired
	private IOrderService orderService;

	@Resource(name = "linksService")
	private ILinksService linksService;
	
	@RequestMapping("notify.do")
	public @ResponseBody String callBackHandle(HttpServletRequest request) throws UnsupportedEncodingException, AlipayApiException{
		Map<String,String> params = new HashMap<String,String>();
		Map<String,String[]> requestParams = request.getParameterMap();
		
		for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用
			valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}
		
		boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

		//——请在这里编写您的程序（以下代码仅作参考）——
		
		/* 后期验证过程建议添加以下校验：
		1、需要验证该通知数据中的out_trade_no是否为系统中创建的订单号，
		2、判断total_amount是否确实为该订单的实际金额（即订单创建时的金额），
		3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，可能有多个seller_id/seller_email）
		4、验证app_id是否正确。
		*/
		if(signVerified) {//验证成功
			//商户订单号
			String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		
			//支付宝交易号
			String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		
			//交易状态
			String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
			
			// 支付状态切换（状态只能增长，不能降低）
			if(trade_status.equals("TRADE_FINISHED")){
				//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
					
				//注意：
				//退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
				orderService.updateStatus(out_trade_no, 7);
			}else if (trade_status.equals("TRADE_SUCCESS")){
				//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
				
				//注意：
				//付款完成后，支付宝系统发送该交易状态通知
				orderService.updateStatus(out_trade_no, 3);
			}
			return "success";
		}else {//验证失败
			//调试用，写文本函数记录程序运行情况是否正常
			String sWord = AlipaySignature.getSignCheckContentV1(params);
			AlipayConfig.logResult(sWord);
			return "fail";
		}
	}
	
	@RequestMapping("return.do")
	public String returnUrl(HttpServletRequest request) throws UnsupportedEncodingException, AlipayApiException{
		//获取支付宝GET过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map<String,String[]> requestParams = request.getParameterMap();
		for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用
			valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}
		
		boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

		//——请在这里编写您的程序（以下代码仅作参考）——
		if(signVerified) {
			//商户订单号
			String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		
			//支付宝交易号
			String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
		
			//付款金额
			String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");
			
			// 支付状态切换（状态只能增长，不能降低）
			orderService.updateStatus(out_trade_no, 4);
//			out.println("trade_no:"+trade_no+"<br/>out_trade_no:"+out_trade_no+"<br/>total_amount:"+total_amount);
		}else {
			//验签失败
		}
		//TODO 支付完成页
		return "redirect:/order/myorderlist.do?status=4";
	}
	
	// 支付控制注意修改收货地址和收货人
	@RequestMapping("tradepay.do")
	public @ResponseBody String tradePay(HttpSession session,String owner,@RequestParam(required=true)String address,String orderno,String subject,String desc) throws AlipayApiException, UnsupportedEncodingException{
		Order order = orderService.getOrder(orderno);
		String result = payService.tradePay(orderno, order.getCount()+"", subject == null ? "订单"+order.getOrderno() : encode(subject), encode(desc));
		User user = (User) session.getAttribute("user");
		orderService.updateAddress(orderno, address, owner==null?user.getUserName()+"   "+user.getPhone() : owner);
		return result;
	}
	
	private String encode(String content) throws UnsupportedEncodingException{
		if (content==null) {
			return null;
		}
		return new String(content.getBytes("iso8859-1"),"utf-8");
	}

	/**
	 * footer链接传送
	 * @param model
	 */
	@ModelAttribute
	public void links(Model model) {
		PageResults<Links> linksResults = linksService.getLinksByPage(1);
		List<Links> urlList = linksResults.getResults();
		model.addAttribute("urlList", urlList);
	}
	
}
