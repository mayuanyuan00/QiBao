package cn.com.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;

import cn.com.domain.User;
import cn.com.utils.SessionUtils;

public class loginFilter implements Filter {
	
	private List list;
	
	public void init(FilterConfig config) throws ServletException {
		list=new ArrayList();
		list.add("/home/enter.do");
		list.add("/user/toLogin.do");
		list.add("/user/toRegister.do");
		list.add("/user/login.do");
		list.add("/user/register.do");
		list.add("/user/toAdminLogin.do");
		list.add("/user/captcha.do");
		list.add("/user/verifycode.do");
		list.add("/order/test.do");
		list.add("/home/homeIndex.do");
		list.add("/home/bookArtTypeList.do");
		list.add("/home/bookDetail.do");
		list.add("/home/bookTypeList.do");
		list.add("/home/type_news.do");
		list.add("/home/systemdetail.do");
		list.add("/news/detail.do");
		list.add("/home/bookArtList.do");
		list.add("/home/download/file.do");
		list.add("/home/bookArtList/books.do");
		list.add("/news/newsList.do");
		list.add("/home/newsList.do");
		list.add("/search/search.do");
		list.add("/message/save.do");
		list.add("/adminUser/userCheck.do");
		list.add("/user/userCharts.do");
        list.add("/user/checkrepeat.do");
		list.add("/adminUser/loginAdmin.do");
		/*图书搜索*/
		list.add("/home/bookSearch/books.do");
		/*互动专区*/
		list.add("/home/contact.do");
		list.add("/contacts/submit_contacts.do");
		list.add("/contacts/contactsInfo.do");
		/*关于我们*/
		list.add("/home/pressIntroduction.do");
		list.add("/home/structure.do");
		/*联系方式*/
		list.add("/home/contactUs.do");
		/*我社文化*/
		list.add("/home/pressCulture.do");
		list.add("/home/academicJson.do");
		/*规章制度*/
		list.add("/home/institution.do");

		list.add("/home/header.do");
		/*常*/
		list.add("/home/gopage.do");
		/*出书业务*/
		list.add("/home/bookwork.do");
		list.add("/order/selectOrder.do");
		list.add("/order/deleteUser.do");
		list.add("/order/orderInfo.do");
		list.add("/order/updateStatus.do");
		list.add("/home/personalInformation.do");

		/*收货地址*/
		list.add("/home/address/upset.do");
		list.add("/home/address/delete.do");
		list.add("/home/address.do");
		list.add("/user/getShippingAddress.do");
	}
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest) request;
		HttpServletResponse res=(HttpServletResponse) response;
		String path=req.getServletPath();
		System.out.println(path);
		if(list!=null&&list.contains(path)){
			chain.doFilter(req, res);
			return;
		}
		HttpSession session=req.getSession();
		User adminUser=null;
		if(session!=null){
			adminUser=(User)session.getAttribute("adminUser");
		}
		User user=SessionUtils.getSysUserFromSession(req);
		if(user!=null||adminUser!=null){
			chain.doFilter(req, res);
		}else{
			//res.sendRedirect(req.getContextPath());
			String uri = req.getRequestURI();
			res.setContentType("text/html;charset=UTF-8");
			if(req.getHeader("x-requested-with") != null
					&& req.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){
				// Ajax请求, 前段根据此header进行处理
				res.setHeader("sessionTimeout", "Session time out, you need relogin !");
				// 返回未认证的状态码(401)
				res.setStatus(HttpStatus.UNAUTHORIZED.value());

			}else {

				path = req.getContextPath();

				StringBuffer basePath = new StringBuffer()
						.append(request.getScheme())
						.append("://")
						.append(request.getServerName())
						.append(":")
						.append(request.getServerPort())
						.append(path)
						.append("/");
				StringBuffer responseStr = new StringBuffer()
						.append("<html><header><script type=\"text/javascript\">alert('会话过期,请重新登录');")
						.append("window.location.href=\"")
						.append(basePath).append("/user/toAdminLogin.do").append("\";")
						.append("</script></header></html>");
				response.getWriter().write(responseStr.toString());
			}
		}
	}

	public void destroy() {
		
	}
}
