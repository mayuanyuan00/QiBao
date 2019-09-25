package cn.com.common;
import java.text.SimpleDateFormat;  
import java.util.Calendar;  
import java.util.Locale;
public class TimerTask {
	public void printTimeStamp(){  
        Calendar ca= Calendar.getInstance();  
        ca.setTimeInMillis(System.currentTimeMillis());  
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS ", Locale.CHINA);  
        //显示当前时间 精确到毫秒  
        System.out.print(sdf.format(ca.getTime()));       
    }  
    public TimerTask(){  
        this.printTimeStamp();  
        System.out.println("计划任务被初始化了");  
    }  
    public void doTask(){  
        this.printTimeStamp();        
        System.out.print("计划任务被执行,线程id:");  
        System.out.println(Thread.currentThread().getId());  
    }  
}
