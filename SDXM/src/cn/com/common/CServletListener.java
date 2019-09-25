package cn.com.common;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import java.io.*;
import java.util.Random;
import java.util.concurrent.atomic.AtomicInteger;

public class CServletListener implements ServletRequestListener {

    public static AtomicInteger count = new AtomicInteger();

    private static Random rd = new Random();

    static{
        count.set(getCount());
    }


    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {

    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
        //自增
        int writeresult = count.getAndIncrement();
        //二十分之一的概率写回
        if((rd.nextInt(20) +1) == 7){
            writeCount(getFile(),writeresult);
        }
    }


    public static int getCount() {
        String encoding = "UTF-8";
        File file = getFile();
        Long filelength = file.length();
        byte[] filecontent = new byte[filelength.intValue()];
        try {
            FileInputStream in = new FileInputStream(file);
            in.read(filecontent);
            in.close();
            String str = new String(filecontent, encoding);
            int re = 0;
            if(str!=null && !("null".equalsIgnoreCase(str))){
                re = Integer.parseInt(str);
            }
            return re;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (NumberFormatException e){
            e.printStackTrace();
        }
        return 0;
    }

    public static void writeCount(File file,int res){
        //覆盖写入
        try {
            FileOutputStream fos = new FileOutputStream(file,false);
//            OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
//            osw.write(res);
//            osw.flush();
//            osw.close();
            fos.write((res+"").getBytes());
            fos.flush();
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
    }

    public static File creatFile(File file){
        try {
            file.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file;
    }

    public static File getFile(){
        File file =new File(CServletListener.class.getResource("data.sdxm").getPath());
        System.out.println(file.getAbsolutePath());
        if(!file.exists()){
            return creatFile(file);
        }else{
            return file;
        }
    }

    public static void main(String[] a){
        System.out.println(getCount());
        writeCount(getFile(),250);
        System.out.println(getCount());
    }
}
