package cn.com.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 简易事件调度器
 * @author 常东旭
 *
 */
public class JobDispatcher {

	static HashMap<String, List<EventListener>> queue = new HashMap<String, List<EventListener>>();
	/**
	 * 注册对应监听器坚挺的事件
	 * @param listener 监听器
	 * @param event 具体事件名字
	 */
	public static void regist(EventListener listener,String event){
		List<EventListener> l = queue.get(event);
		if (l == null) {
			l = new ArrayList<EventListener>();
		}
		l.add(listener);
		queue.put(event, l);
	}
	
	/**
	 * 事件通知
	 * @param event 事件名
	 * @param param 传递参数
	 */
	public static void notify(String event,Map<String, Object> param){
		List<EventListener> l = queue.get(event);
		if (l != null) {
			for (EventListener el : l) {
				el.handleEvent(param);
			}
		}
	}
}
