package cn.com.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.*;

import java.io.*;
import java.lang.reflect.Type;
import java.util.Date;

public class JsonUtil {
    private static final GsonBuilder gsonBuilder = new GsonBuilder();
    private static final Gson gson;
    private static final ObjectMapper objectMapper = new ObjectMapper();

    static {
        gsonBuilder.registerTypeAdapter(Date.class, new DateDeserializer());
        gson = gsonBuilder.create();
    }

    public static Gson getGson() {
        return gson;
    }

    public static ObjectMapper getObjectMapper() {
        return objectMapper;
    }

    public static String toJson(Object o) {
        if (o == null) return "{}";
        if (o instanceof String) return o.toString();
        try {
            return getObjectMapper().writeValueAsString(o);
        } catch (JsonProcessingException e) {
            return "{}";
        }
    }

    public static String toJsonByGson(Object o) {
        if (o == null) return "{}";
        if (o instanceof String) return o.toString();
        return gson.toJson(o);
    }

    public static void write(Object m, String path) {
        FileWriter fw = null;
        OutputStreamWriter out = null;
        try {
            File file = new File(path);
            if (file.exists() && file.isFile()) {
                file.delete();
            }
            out = new OutputStreamWriter(
                    new FileOutputStream(path), "UTF-8");
            String ob = objectMapper.writeValueAsString(m);
            out.write(ob);
            out.flush();
            out.close();
//            fw = new FileWriter(path, false);
//            fw.write(ob);
//            fw.flush();
//            fw.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void createDir(String path) {
        File file = new File(path);
        if (!file.exists()) {
            file.mkdir();
            file.setReadable(true, false);
            file.setWritable(true);
        }
    }

    public static void deleteDir(String path) {
        File file = new File(path);
        String[] tempList = file.list();
        File temp;
        if (tempList != null) {
            for (String aTempList : tempList) {
                temp = new File(path, aTempList);
                for (String tem : tempList) {
                    if (path.endsWith(File.separator)) {
                        temp = new File(path + tem);
                    } else {
                        temp = new File(path + File.separator + tem);
                    }
                    if (temp.isFile()) {
                        temp.delete();
                    }
                }
            }
        }
    }

    /**
     * Created by GaoXun on 2016/12/20.
     */
    private static class DateDeserializer implements JsonDeserializer<Date> {
        public Date deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
                throws JsonParseException {
            return new Date(Long.parseLong(json.getAsJsonPrimitive().getAsString()));
        }
    }
}
