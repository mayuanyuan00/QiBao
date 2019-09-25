package cn.com.utils;

import java.io.IOException;
import java.util.Properties;

import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Component;

/**
 * 读取Properties配置文件的工具类
 * @author 常东旭
 *
 */
@Component
public class PropertiesUtil {
	Properties props;
	
	public PropertiesUtil() {
		try {
			props = PropertiesLoaderUtils.loadAllProperties("utils.properties");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String getProperty(String name) {
		String result = null;
		result = props.getProperty(name);// 根据name得到对应的value
		return result;

	}
	
}
