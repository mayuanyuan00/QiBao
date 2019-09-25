package cn.com.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.com.domain.User;
import cn.com.utils.SessionUtils;
import cn.com.utils.StringUtils;

public class WebLoginInterceptor extends HandlerInterceptorAdapter{
	/** 
     * 日志对象 
     */  
    
    private  Logger logger = Logger.getLogger(WebLoginInterceptor.class);
    
    /**
         * 默认注销URL
         * 即Session超时后，发起请求到此地址，只对普通请求有效
         */
    private static final String DEFAULT_LOGOUT_URL = "/web/logout";
    /** 
     * 默认注销URL 
     * 即Session超时后，发起请求到此地址，只对普通请求有效 
     */  
    private String logoutUrl;
    
    @Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,  
            Object handler) throws Exception {  
        User user = SessionUtils.getSysUserFromSession(request);  
        String uri = request.getRequestURI();      
                if(user == null){  
                    response.setContentType("text/html;charset=UTF-8");  
                    if(request.getHeader("x-requested-with") != null   
                                && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){   
                        // Ajax请求, 前段根据此header进行处理  
                        response.setHeader("sessionTimeout", "Session time out, you need relogin !");  
                        // 返回未认证的状态码(401)  
                        response.setStatus(HttpStatus.UNAUTHORIZED.value());  
                            logger.debug("请求路径：" + uri + ", 请求方式 ：Ajax请求, Session超时, 需要重新登录!");  
                        }else{  
                            // 普通请求
                            String path = request.getContextPath();
                            StringBuffer basePath = new StringBuffer()  
                                    .append(request.getScheme())  
                                    .append("://")  
                                    .append(request.getServerName())  
                                    .append(":")  
                                    .append(request.getServerPort())  
                                    .append(path)  
                                    .append("/");  
                            StringBuffer responseStr = new StringBuffer()  
                                    .append("<html><header><script type=\"text/javascript\">")
                                    .append("window.location.href=\"")  
                                        .append(basePath).append(getLogoutUrl()).append("\";")  
                                    .append("</script></header></html>");  
                                response.getWriter().write(responseStr.toString());  
                                logger.debug("请求路径：" + uri + ",请求方式 ：普通请求, Session超时, 需要重新登录!");  
                        }  
                    return false;  
                }  
                return true;  
    }  
    public String getLogoutUrl() {  
        // 使用默认值  
        if(StringUtils.isEmpty(logoutUrl)){  
            return DEFAULT_LOGOUT_URL;  
        }  
        return logoutUrl;  
    }
	public void setLogoutUrl(String logoutUrl) {
		this.logoutUrl = logoutUrl;
	}  
   
}
