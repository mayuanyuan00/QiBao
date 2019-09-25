package cn.com.utils;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
/**
 * AES加密工具类
 * @author 常东旭
 */
public class AESUtil {

	private static byte[] encrypt(String content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
			secureRandom.setSeed(password.getBytes());
			kgen.init(128, secureRandom);
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(byteContent);
			return result; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	private static byte[] decrypt(byte[] content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
			secureRandom.setSeed(password.getBytes());
			kgen.init(128, secureRandom);
			// kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(content);
			return result; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}
	

	private static String parseByte2HexStr(byte buf[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++) {
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sb.append(hex.toUpperCase());
		}
		return sb.toString();
	}

	private static byte[] parseHexStr2Byte(String hexStr) {
		if (hexStr.length() < 1)
			return null;
		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++) {
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

	/**
	 * 对给定的content利用key加密<br>
	 * 加密方式为AES
	 * 
	 * @param content
	 *            明文
	 * @param key
	 *            密钥
	 * @author cdx
	 */
	public static String encode(String content, String key) {
		byte[] encryptResult = encrypt(content, key);
		String encryptResultStr = parseByte2HexStr(encryptResult);
		return encryptResultStr;
	}

	/**
	 * 对给定的content利用key解密<br>
	 * 加密方式为AES
	 * 
	 * @param content
	 *            密文
	 * @param key
	 *            密钥
	 * @return
	 */
	public static String decode(String content, String key) {
		byte[] decryptFrom = parseHexStr2Byte(content);
		byte[] decryptResult = decrypt(decryptFrom, key);
		return new String(decryptResult);
	}

	public static void main(String[] args) {
		String content = "test洒家收购价款水电费和凤凰";
		String password = "123sss45678";
		// 加密
		System.out.println("加密前：" + content);
		byte[] encryptResult = encrypt(content, password);
		String encryptResultStr = parseByte2HexStr(encryptResult);
		System.out.println("加密后：" + encryptResultStr);
		// 解密
		byte[] decryptFrom = parseHexStr2Byte(encryptResultStr);
		byte[] decryptResult = decrypt(decryptFrom, password);
		System.out.println("解密后：" + new String(decryptResult));
		
		System.out.println();
	}
}
