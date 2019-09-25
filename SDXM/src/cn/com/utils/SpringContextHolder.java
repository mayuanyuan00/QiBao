/**
 * 
 */
package cn.com.utils;

import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * 静态持有spring上下文用于在任意地点获取Spring内的bean
 * @since 2017.09.12
 * @author 常东旭
 * @version v1
 */
public class SpringContextHolder implements ApplicationContextAware {

	
	private static ApplicationContext applicationContext;
	
	@Override
	public void setApplicationContext(ApplicationContext context) throws BeansException {
		applicationContext = context;
	}
	
	
	/**
	 * 取得存储在静态变量中的ApplicationContext.
	 * @return 返回上下文对象
	 */
    public static ApplicationContext getApplicationContext() {
        checkApplicationContext();
        return applicationContext;
    }
    
    
    /**
     * 从静态变量ApplicationContext中取得Bean, 自动转型为所赋值对象的类型.
     * @param name bean的名字
     * @return 所查找的bean
     */
    @SuppressWarnings("unchecked")
    public static <T> T getBean(String name) {
        checkApplicationContext();
        return (T) applicationContext.getBean(name);
    }
    
    
  /**
   * 从静态变量ApplicationContext中取得Bean, 自动转型为所赋值对象的类型.<br/>
   * 如果有多个Bean符合Class, 取出第一个.
   * @param clazz 要查找bean的类型
   * @return 所查找的bean
   */
    //
    @SuppressWarnings("unchecked")
    public static <T> T getBean(Class<T> clazz) {
        checkApplicationContext();
        @SuppressWarnings("rawtypes")
        Map beanMaps = applicationContext.getBeansOfType(clazz);
        if (beanMaps!=null && !beanMaps.isEmpty()) {
            return (T) beanMaps.values().iterator().next();
        } else{
            return null;
        }
    }
    
    //校验上下文对象是否注入成功
    private static void checkApplicationContext() {
        if (applicationContext == null) {
            throw new IllegalStateException("applicaitonContext未注入,请在applicationContext.xml中定义SpringContextHolder");
        }
    }

}
