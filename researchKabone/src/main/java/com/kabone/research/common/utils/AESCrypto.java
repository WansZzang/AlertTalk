package com.kabone.research.common.utils;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Hex;    //commons-codec-1.6.jar

public class AESCrypto {

	public final static String ENCODE = "ENCODE";
	public final static String DECODE = "DECODE";
							   
	private String cryptoKey = "keywesoftpwd";
									
	private SecretKeySpec secretKey = null;
	private Cipher cipher = null;

	/**
	 * 
	 * 키생성 알고리즘은 AES 이며\n데이터 암호화 방식은 AES 의 ECB 블록 방식을 따르며 페딩 규칙은 사용자 정의 페딩 규칙을
	 * 따름\n참조 사이트
	 * http://java.sun.com/j2se/1.5.0/docs/guide/security/jce/JCERefGuide
	 * .html(128b it rijndael)
	 * 
	 * 
	 * 
	 * @author gnoo
	 * 
	 * @version 2005. 3. 25 오전 10:11:43
	 * 
	 * @param plainText
	 *            암호화 하고자 하는 String
	 * 
	 * @return
	 * 
	 * @throws Exception
	 */

	private String encrypt(String plainText) throws Exception {

		secretKey = new SecretKeySpec(cryptoKey.getBytes(), "AES");

		cipher = Cipher.getInstance("AES/ECB/NoPadding");

		cipher.init(Cipher.ENCRYPT_MODE, secretKey);

		byte[] lackBuf = plainText.getBytes("UTF-8");

		byte[] fullBuf = this.addPadding(lackBuf);

		byte[] encBuf = cipher.doFinal(fullBuf);

		char[] encHex = Hex.encodeHex(encBuf);

		String cipherText = new String(encHex);

		return cipherText.toUpperCase();

	}

	/**
	 * 
	 * 키생성 알고리즘은 AES 이며\n데이터 복호화 방식은 AES 의 ECB 블록 방식을 따르며 페딩 규칙은 사용자 정의 페딩 규칙을
	 * 따름
	 * 
	 * 
	 * 
	 * @author gnoo
	 * 
	 * @version 2005. 3. 25 오전 10:11:46
	 * 
	 * @param cipherData
	 *            복호화 하고자 하는 String
	 * 
	 * @return
	 * 
	 * @throws Exception
	 */

	private String decrypt(String cipherData) throws Exception {

		secretKey = new SecretKeySpec(cryptoKey.getBytes(), "AES");

		cipher = Cipher.getInstance("AES/ECB/NoPadding");

		cipher.init(Cipher.DECRYPT_MODE, secretKey);

		String cipherText = new String(cipherData.getBytes("UTF-8"));

		char[] encHex = new char[cipherText.length()];

		for (int i = 0; i < cipherText.length(); i++) {

			encHex[i] = cipherText.charAt(i);

		}

		byte[] decHex = Hex.decodeHex(encHex);

		byte[] decBuf = cipher.doFinal(decHex);

		byte[] cutBuf = this.deletePadding(decBuf);

		String plainText = new String(cutBuf, "UTF-8");

		return plainText;

	}

	/**
	 * 
	 * 사용자 정의 키값으로 암호화 와 복호화를 사용하고자 할경우 사용
	 * 
	 * 
	 * 
	 * @version 2005. 3. 25 오전 10:28:23
	 * 
	 * @param encType
	 * 
	 * @param content
	 * 
	 * @param key
	 * 
	 * @return
	 */

	public static String getSecure(String encType, String content, String key) {

		AESCrypto fc = new AESCrypto();

		String returnStr = null;

		fc.setCryptoKey(key);

		try {

			if (encType != null && encType.equals(ENCODE)) {

				returnStr = fc.encrypt(content);

			} else if (encType != null && encType.equals(DECODE)) {

				returnStr = fc.decrypt(content);

			}

		} catch (Exception e) {

		}

		return returnStr;

	}

	/**
	 * 
	 * 디폴트 키값으로 암호화 와 복호화를 사용하고자 할경우 사용
	 * 
	 * 
	 * 
	 * @version 2005. 3. 25 오전 10:28:23
	 * 
	 * @param encType
	 * 
	 * @param content
	 * 
	 * @return
	 */

	public static String getSecure(String encType, String content) {

		AESCrypto fc = new AESCrypto();

		String returnStr = null;

		try {

			if (encType != null && encType.equals(ENCODE)) {

				returnStr = fc.encrypt(content);

			} else if (encType != null && encType.equals(DECODE)) {

				returnStr = fc.decrypt(content);

			}

		} catch (Exception e) {

		}

		return returnStr;

	}

	/**
	 * 
	 * 16바이트의 배수를 만들기 위해서 0x00(공백) 바이트 추가 함수 (현재 16바이트의 배수일 경우에도 한번은 붙여줌)
	 * 
	 * 
	 * 
	 * @author gnoo
	 * 
	 * @version 2005. 3. 25 오전 10:11:49
	 * 
	 * @param lackBuf
	 * 
	 * @return
	 */

	private byte[] addPadding(byte[] lackBuf) {

		int fullLen = lackBuf.length + (16 - (lackBuf.length % 16));

		byte[] fullBuf = new byte[fullLen];

		System.arraycopy(lackBuf, 0, fullBuf, 0, lackBuf.length);

		for (int i = lackBuf.length; i < fullBuf.length; i++) {

			fullBuf[i] = 0x00;

		}

		return fullBuf;

	}

	/**
	 * 
	 * 암호화시에 추가한 0x00(공백) 바이트 제거 함수
	 * 
	 * 
	 * 
	 * @author gnoo
	 * 
	 * @version 2005. 3. 25 오전 10:11:51
	 * 
	 * @param fullBuf
	 * 
	 * @return
	 */

	private byte[] deletePadding(byte[] fullBuf) {

		int i = 0;

		boolean loop = true;

		while (loop) {

			if (i == fullBuf.length || fullBuf[i] == 0x00) {

				loop = false;

				i--;

			}

			i++;

		}

		byte[] cutBuf = new byte[i];

		System.arraycopy(fullBuf, 0, cutBuf, 0, i);

		return cutBuf;

	}

	/**
	 * 
	 * @param cryptoKey
	 *            The cryptoKey to set.
	 */

	public void setCryptoKey(String cryptoKey) {

		this.cryptoKey = cryptoKey;

	}
	
	public static void main(String args[]) {

		String data = "1234";
		String encodeData = AESCrypto.getSecure(AESCrypto.ENCODE, data);
		String decodeData = AESCrypto.getSecure(AESCrypto.DECODE, encodeData);
		
	}

}
