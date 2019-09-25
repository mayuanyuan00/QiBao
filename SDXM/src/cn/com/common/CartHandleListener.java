package cn.com.common;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.com.domain.User;
import cn.com.service.ICartService;
/**
 * 购物车监听登录事件，加载数据库中购物车信息到session
 * @author 常东旭
 *
 */
@Component
public class CartHandleListener implements EventListener{

	@Autowired
	ICartService cartService;
	
	@PostConstruct
	void init(){
		JobDispatcher.regist(this, Constants.EVENT.LOGIN);
	}
	
	@Override
	public void handleEvent(Map<String, Object> eventParam) {
		HttpSession session = (HttpSession) eventParam.get(Constants.COMMONPARAM.HTTPSESSION);
		User user = (User) session.getAttribute("user");
		session.setAttribute(Constants.SESSION.CARTINFO, cartService.getCartDetail(user.getId()));
	}

}
