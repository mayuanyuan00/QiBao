package cn.com.common;

import cn.com.utils.RandomStringUtil;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.io.IOUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class FileManager {
    /**
     * 保存文件
     *
     * @param file
     * @param absDest 保存文件到指定的绝对路径
     * @return 返回新文件的文件名
     */
    public static String saveFile(MultipartFile file, String absDest) throws IOException {
        String originalFilename = file.getOriginalFilename();
        int dotIndex = originalFilename.lastIndexOf(".");
        String suffix = originalFilename.substring(dotIndex + 1);
        String name = originalFilename.substring(0, dotIndex);
        String fileName = UUID.randomUUID().toString()+"."+suffix;
        File directory = new File(absDest);
        if (!directory.exists()) directory.mkdirs();
        File newFile = new File(directory, fileName);
        file.transferTo(newFile);
        return fileName;
    }

    /**
     * 保存文件
     *
     * @param file
     * @param absDest 保存文件到指定的绝对路径
     * @param newFileName 若fileName不是null 则存储为FileName
     * @return 返回新文件的文件名
     */
    public static String saveFile(MultipartFile file, String absDest,String newFileName) throws IOException {
        String originalFilename =newFileName;
        if (originalFilename==null){
            originalFilename= file.getOriginalFilename();
        }
        int dotIndex = originalFilename.lastIndexOf(".");
        String suffix = originalFilename.substring(dotIndex + 1);
        String name = originalFilename.substring(0, dotIndex);
        String fileName = String.format("%s-%s-%d.%s", name,
                RandomStringUtil.getRandomCode(4, 6), System.currentTimeMillis() % 1000, suffix);
        File directory = new File(absDest);
        if (!directory.exists()) directory.mkdirs();
        File newFile = new File(directory, fileName);
        file.transferTo(newFile);
        return fileName;
    }
    /**
     * 根据url下载图 jpg
     */
    public static String getImgByUrl(String url,String fileName,String path) {
        BufferedInputStream in = null;
        String filename = url.substring(url.lastIndexOf("/"));
        String suffix = filename.substring(filename.lastIndexOf("."));
        if (!"jpg".equalsIgnoreCase(suffix)){
            return "上传图片格式有误，请上传jpg格式";
        }
        path=path+fileName+suffix;
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 11.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 遍历所有的响应头字段
            for (String key : map.keySet()) {
                System.out.println(key + "--->" + map.get(key));
            }
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedInputStream(connection.getInputStream());
            try (OutputStream os = new BufferedOutputStream(new FileOutputStream(path))) {
                IOUtils.copy(in, os);
            }
        } catch (Exception e) {
            System.out.println("发送GET请求出现异常！" + e);
            e.printStackTrace();
            return "上传失败";
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return "success";
    }


    public static String postImg(MultipartFile file, String fileName, String path) {
        String filename = file.getOriginalFilename();
        String suffix = filename.substring(filename.lastIndexOf("."));
        File directory=new File(path);
        if (!directory.exists()) {
            directory.mkdirs();
        }
        if (".png".equalsIgnoreCase(suffix)){
            File deleteFile=new File(path,fileName+".jpg");
            if (deleteFile.exists()){
                deleteFile.delete();
            }
            suffix=".png";
        } else {
                return "图片格式不对，请选择png格式图片";
        }
        String filePath=path+File.separator+fileName+suffix;
        File newFile=new File(filePath);
        try {
            //Thumbnails.of(file.getInputStream()).size(1920,500).toFile(filePath);
           //Thumbnails.of(file.getInputStream()).toFile(filePath);
            file.transferTo(newFile);
        } catch (IOException e) {
            e.printStackTrace();
            return "上传失败";
        }
        return "success";
    }

    /**
     * 下载文件
     */
    public static void downLoad(String filePath, HttpServletResponse response, boolean isOnLine) throws Exception {
        File f = new File(filePath);
        if (!f.exists()) {
            response.sendError(404, "File not found!");
            return;
        }
        BufferedInputStream br = new BufferedInputStream(new FileInputStream(f));
        byte[] buf = new byte[1024];
        int len = 0;

        response.reset(); // 非常重要
        if (isOnLine) { // 在线打开方式
            URL u = new URL("file:///" + filePath);
            response.setContentType(u.openConnection().getContentType());
            response.setHeader("Content-Disposition", "inline; filename=" + f.getName());
            // 文件名应该编码成UTF-8
        } else { // 纯下载方式
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename=" + f.getName());
        }
        OutputStream out = response.getOutputStream();
        while ((len = br.read(buf)) > 0)
            out.write(buf, 0, len);
        br.close();
        out.close();
    }
}
