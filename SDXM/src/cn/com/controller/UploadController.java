package cn.com.controller;

import cn.com.utils.PropertiesUtil;
import cn.com.utils.StringUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

@Controller
@RequestMapping("/upload")
public class UploadController {

    @Autowired
    private PropertiesUtil propertiesUtil;

    /**
     * 用来存储分块上传的文件数据
     * 第一个key为文件名+文件大小
     * 第二个key为分块ID，比总分快数小1
     * 第二个value存储分块文件的绝对路径
     */
    private Map<String, Map<Integer, String>> chunkMap = new HashMap<>();

    @RequestMapping(value = "/file.do", method = RequestMethod.POST)
    @ResponseBody
    public String uploadFile(@RequestParam(value = "file") MultipartFile file,
                             @RequestParam(required = false) Integer chunks,
                             @RequestParam(required = false) Integer chunk,
                             @RequestParam(required = false) Integer size) {
        String directory = propertiesUtil.getProperty("upload.path.base");
        if (StringUtils.isEmpty(directory)) return "系统错误";
        String contentType = file.getContentType();
        String originFilename = file.getOriginalFilename();
        String subDirName = propertiesUtil.getProperty("upload.dir.name." + (contentType.startsWith("image/") ? "image" : "file"));
        String destFilename = getDestFileName(originFilename);
        if (StringUtils.isEmpty(subDirName)) return "系统错误";
        File destDir = new File(directory, subDirName);
        if (!destDir.exists()) destDir.mkdirs();
        File destFile = new File(destDir, destFilename);
        try {
            file.transferTo(destFile);
        } catch (IOException e) {
            e.printStackTrace();
            return "系统错误";
        }
        if (chunks != null && chunk != null && size != null) {//此时为分块上传
            Map<Integer, String> existsChunk = chunkMap.get(originFilename);
            if (existsChunk == null) {
                existsChunk = new TreeMap<>();
                chunkMap.put(originFilename, existsChunk);
            }
            existsChunk.put(chunk, destFile.getAbsolutePath());
            if (chunks == existsChunk.size()) {//已经上传了所有的分块
                try {
                    destFilename = this.combine(destDir.getAbsolutePath(), originFilename);
                    return String.format("%s/%s", subDirName, destFilename);
                } catch (IOException e) {
                    e.printStackTrace();
                    return "系统错误";
                }
            } else {
                return "waiting for more";
            }
        } else {
            return String.format("%s/%s", subDirName, destFilename);
        }
    }

    /**
     * 合并分块文件
     *
     * @param filename
     * @return
     */
    private String combine(String dir, String filename) throws IOException {
        Map<Integer, String> chunksMap = chunkMap.get(filename);
        chunkMap.remove(filename);
        String destFilename = getDestFileName(filename);
        File destFile = new File(dir, destFilename);
        try (OutputStream os = new BufferedOutputStream(new FileOutputStream(destFile))) {
            for (Map.Entry<Integer, String> entry : chunksMap.entrySet()) {
                try (InputStream is = new FileInputStream(entry.getValue())) {
                    IOUtils.copy(is, os);
                }
                new File(entry.getValue()).delete();
            }
        }
        return destFilename;
    }

    private String getDestFileName(String originFilename) {
        String suffix = originFilename.substring(originFilename.lastIndexOf(".") + 1);
        return String.format("%s-%d-%d.%s",
                originFilename.substring(0, originFilename.lastIndexOf(".")),
                System.currentTimeMillis(), new Random().nextInt(), suffix);

    }
}
