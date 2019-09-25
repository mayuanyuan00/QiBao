package cn.com.utils;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Hashtable;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.ReaderException;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeReader;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;


/**
 * 二维码工具类
 * @author 张炜婕
 *
 */
public class QRCodeUtil {

	/**
	 * 默认二维码创建级别,纠错能力EncodeHintType.ERROR_CORRECTION  为ErrorCorrectionLevel.L 低
	 * @param outputStream  生成后的定向输出流  可以是具体的file也可以是imageoutputStream
	 * @param content  二维码包含的内容
	 * @param qrCodeSize 二维码大小
	 * @param imageFormat 二维码格式
	 * @return 返回创建成功或是失败
	 * @throws WriterException 
	 * @throws IOException
	 */
	public static boolean createQrCode(OutputStream outputStream, String content, int qrCodeSize, String imageFormat)
			throws WriterException, IOException {
		// 设置二维码纠错级别ＭＡＰ
		Hashtable<EncodeHintType, ErrorCorrectionLevel> hintMap = new Hashtable<EncodeHintType, ErrorCorrectionLevel>();
		hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L); // 矫错级别
		return createQrCode(outputStream, content, qrCodeSize, imageFormat, hintMap);

	}

	/**
	 * 可自定的二维码生成工具方法
	 * @param outputStream	outputStream  生成后的定向输出流  可以是具体的file也可以是imageoutputStream
	 * @param _content  二维码包含的内容
	 * @param qrCodeSize 二维码的大小
	 * @param imageFormat 二维码的格式
	 * @param hintMap 设置二维码纠错级别ＭＡＰ
	 * @return 返回创建成功或是失败
	 * @throws WriterException 
	 * @throws IOException
	 */
	public static boolean createQrCode(OutputStream outputStream, String _content, int qrCodeSize, String imageFormat,
			Hashtable<EncodeHintType, ErrorCorrectionLevel> hintMap) throws WriterException, IOException {
		//content 编码
		String content = new String(_content.getBytes("UTF-8"),"ISO-8859-1");
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		// 创建比特矩阵(位矩阵)的QR码编码的字符串
		BitMatrix byteMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, qrCodeSize, qrCodeSize, hintMap);
		// 使BufferedImage勾画QRCode (matrixWidth 是行二维码像素点)
		int matrixWidth = byteMatrix.getWidth();
		BufferedImage image = new BufferedImage(matrixWidth - 200, matrixWidth - 200, BufferedImage.TYPE_INT_RGB);
		image.createGraphics();
		Graphics2D graphics = (Graphics2D) image.getGraphics();
		graphics.setColor(Color.WHITE);
		graphics.fillRect(0, 0, matrixWidth, matrixWidth);
		// 使用比特矩阵画并保存图像
		graphics.setColor(Color.BLACK);
		for (int i = 0; i < matrixWidth; i++) {
			for (int j = 0; j < matrixWidth; j++) {
				if (byteMatrix.get(i, j)) {
					graphics.fillRect(i - 100, j - 100, 1, 1);
				}
			}
		}
		return ImageIO.write(image, imageFormat, outputStream);
	}

	/**
	 * 二维码读取工具类,用于默认编码
	 * @param inputStream 二维码输入流
	 * @return
	 * @throws IOException
	 */
	public static String readQrCode(InputStream inputStream) throws IOException{
		return readQrCode(inputStream, "ISO-8859-1", "UTF-8");
	}
	
	/**
	 * 二维码读取工具类，用于自定义编码
	 * @param inputStream 二维码输入流
	 * @param encoding 原始编码方式
	 * @param decoding 目标解码方式
	 * @return
	 * @throws IOException
	 */
	public static String readQrCode(InputStream inputStream,String encoding,String decoding) throws IOException {
		// 从输入流中获取字符串信息
		BufferedImage image = ImageIO.read(inputStream);
		// 将图像转换为二进制位图源
		LuminanceSource source = new BufferedImageLuminanceSource(image);
		BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
		QRCodeReader reader = new QRCodeReader();
		Result result = null;
		try {
			result = reader.decode(bitmap);
		} catch (ReaderException e) {
			e.printStackTrace();
		}
		System.out.println(result.getText());
		String re = result.getText();
		return new String(re.getBytes(encoding),decoding);
	}

	//test  测试
	public static void main(String[] args) throws IOException, WriterException {
		createQrCode(new FileOutputStream(new File("E:\\qrcode.jpg")),
				"http://www.baidu.com", 900, "JPEG");
		readQrCode(new FileInputStream(new File("E:\\qrcode.jpg")));
	}
}
