package cn.com.common;

import java.util.Map;

/**
 * 事件监听器接口
 * @author 常东旭
 *
 */
public interface EventListener {
	
	public void handleEvent(Map<String, Object> eventParam);
}
