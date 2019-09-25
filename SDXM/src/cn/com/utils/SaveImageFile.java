package cn.com.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import cn.com.common.Constants;
import cn.com.domain.User;

public class SaveImageFile {

	/**
	 * 保存图片
	 * @param request
	 * @param user
	 * @throws Exception
	 */
	public static void save(HttpServletRequest request,User user) throws Exception{
		user.setUserName(request.getParameter("username"));
		user.setPassword(AESUtil.encode(request.getParameter("password"),"1031"));
		//user.setSex(request.getParameter("sex"));
		user.setStatus("1");
		user.setPhone(request.getParameter("phone"));
		user.setEmail(request.getParameter("email"));
		user.setGroupCode("3");
		new DateUtils();
		user.setCreateDate(DateUtils.getNowDate());
		//首先转换request
		/*MultipartHttpServletRequest rm=(MultipartHttpServletRequest) request;
		//获得文件
		CommonsMultipartFile cfile=(CommonsMultipartFile) rm.getFile("imageUrl");
		//获得文件的字节数据
		byte[] bf=cfile.getBytes();
		String filename="";
		SimpleDateFormat format=new SimpleDateFormat("yyyyMMddHHmmssSSS");
		filename=format.format(new Date());
		Random random=new Random();
		for(int i=0;i<3;i++){
			filename=filename+random.nextInt(9);
		}
		//获得原始文件名
		String orignFilename=cfile.getOriginalFilename();
		String suffix=orignFilename.substring(orignFilename.lastIndexOf("."));
		//获得项目的部署路径
		String path=request.getSession().getServletContext().getRealPath("/");
		//确定文件名与后缀名
		user.setImageUrl(filename+suffix);
		//定义文件的输出流
		OutputStream out=new FileOutputStream(new File(path+"/upload/"+filename+suffix));
		out.write(bf);
		out.flush();
		out.close();*/
	}
	/**
	* Java上传图片到服务器图片保存到Tomcat的webapps目录下
	* @param request
	* @return
	*/
	public static String uploadFile(MultipartFile file, HttpServletRequest request)
			throws IllegalStateException, IOException {

		if (file != null) {
			// 获取上传文件的原始名称
			String originalFilename = file.getOriginalFilename();
			String newFileName = "";
			String pic_path;
			// 上传图片
			if (originalFilename != null && originalFilename.length() > 0) {
				// 获取Tomcat服务器所在的路径
				String tomcat_path = System.getProperty("catalina.home");
				System.out.println(tomcat_path);
				// 获取Tomcat服务器所在路径的最后一个文件目录
				String bin_path = tomcat_path.substring(tomcat_path.lastIndexOf("\\") + 1, tomcat_path.length());
				System.out.println(bin_path);
				// 若最后一个文件目录为bin目录，则服务器为手动启动
				if (("bin").equals(bin_path)) {// 手动启动Tomcat时获取路径为：D:\Software\Tomcat-8.5\bin
					// 获取保存上传图片的文件路径
					pic_path = tomcat_path.substring(0, System.getProperty("user.dir").lastIndexOf("\\")) + "\\webapps"
							+ "\\pic_file\\";
				} else {// 服务中自启动Tomcat时获取路径为：E:\Software\Tomcat-8.5
					pic_path = tomcat_path + "\\webapps" + "\\pic_file\\";
				}
				// 新的图片名称
				newFileName = UUID.randomUUID() + originalFilename.substring(originalFilename.lastIndexOf("."));

				// 新图片
				File newFile = new File(pic_path + newFileName);
				// 将内存中的数据写入磁盘
				file.transferTo(newFile);
			}
			return newFileName;
		} else {
			return null;
		}
	}

	/**
	 * 图片格式转换
	 * @param source
	 * @param formatName
	 * @param result
	 */
	public static void convert(String source, String formatName, String result)
	{
		try
		{
			File f = new File(source);
			f.canRead();
			BufferedImage src = ImageIO.read(f);
			ImageIO.write(src, formatName, new File(result));
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
