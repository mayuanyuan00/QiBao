package cn.com.converter;


import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

public class DateInjectConverter implements Converter<String, Date> {
    private SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd");
    private SimpleDateFormat complexFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private Pattern simplePattern = Pattern.compile("^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$");

    private static DateInjectConverter converter;

    public DateInjectConverter() {
        converter = this;
    }

    @Override
    public Date convert(String text) {
        if (text == null || text.trim().equals("")) {
            return null;
        }
        Date result = null;
        if (simplePattern.matcher(text).matches()) {
            try {
                result = simpleFormat.parse(text);
            } catch (ParseException ignored) {
            }
        } else {
            try {
                result = complexFormat.parse(text);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static Date converts(String text) {
        return converter.convert(text);
    }
}
