package cn.com.utils;

import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

/**
 * json 实体转换工具类
 * 
 * @author 张炜婕
 *
 */
public final class Json2Object {

	@SuppressWarnings("unchecked")
	public static <T> T jsonToObject(String jsonString, Class<T> pojoCalss) {
		Gson gson = new Gson();
		Object bdPushID2 = gson.fromJson(jsonString, pojoCalss);
		return (T) bdPushID2;
	}

	public static Map<String, Object> jsonToMap(String data) {
		GsonBuilder gb = new GsonBuilder();
		Gson g = gb.create();
		Map<String, Object> map = g.fromJson(data, new TypeToken<Map<String, Object>>() {
		}.getType());
		return map;
	}

}
