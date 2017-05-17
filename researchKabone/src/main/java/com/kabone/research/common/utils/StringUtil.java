package com.kabone.research.common.utils;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

/**
 * @class StringUtil.java
 * @Description 	
 * @see
 *
 * 2005. 11. 3. 처음 작성
 * 2005. 11. 3. 문서화 작성
 */
public class StringUtil {
	public static final String PRE = "PRE";
	public static final String POST = "POST";
	
	/**
	 * White Space 정보
	 */
	private final static String WHITE_SPACE = " \t\n\r\f";

	public static void main(String[] args) throws NoSuchAlgorithmException {

	}
	
	/**
	 * <P>
	 * 입력된 숫자값의 앞에 0을 붙여서 스트링으로 리턴
	 * </p>
	 * @param a int
	 * @param size int
	 * @return String
	 */
	public static String getSizeString(int a, int size) {
		return getSizeString(a, size, "0");
	}

	/**
	 * <P>
	 * 입력된 숫자값의 앞에 0을 붙여서 스트링으로 리턴
	 * </p>
	 * @param a long
	 * @param size int
	 * @return String
	 */
	public static String getSizeString(long a, int size) {
		return getSizeString(a, size, "0");
	}

	/**
	 * Method getSizeString.
	 * 
	 * <pre>
	 *  입력된 값의 앞에 preFix을 붙여서 스트링으로 리턴
	 * <br>
	 * </pre>
	 * 
	 * @param a
	 * @param size
	 * @param preFix
	 * @return String
	 */
	public static String getSizeString(int a, int size, String preFix) {
		StringBuffer rvalue = new StringBuffer();

		for (double i = Math.pow(10, (size - 1)); i >= 1; i = i / 10) {
			if (a < i) {
				rvalue.append(preFix);
			}
			else {
				rvalue.append(a);
				break;
			}

		}
		return rvalue.toString();
	}

	/**
	 * Method getSizeString.
	 * 
	 * <pre>
	 *  입력된 값의 앞에 preFix을 붙여서 스트링으로 리턴
	 * <br>
	 * </pre>
	 * 
	 * @param a
	 * @param size
	 * @param preFix
	 * @return String
	 */
	public static String getSizeString(long a, int size, String preFix) {
		StringBuffer rvalue = new StringBuffer();

		for (double i = Math.pow(10, (size - 1)); i >= 1; i = i / 10) {
			if (a < i) {
				rvalue.append(preFix);
			}
			else {
				rvalue.append(a);
				break;
			}
		}
		return rvalue.toString();
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param a
	 * @param size
	 * @param preFix
	 * @param preflg
	 * @return
	 */
	public static byte[] getSizeString(byte[] a, int size, String preFix, String preflg) {
		byte[] rvalue = new byte[size];
		int index = 0;
		//byte[] tmp = a.getBytes();

		if (PRE.equals(preflg)) {
			for (int s = size; s > a.length; s--) {
				System.arraycopy(preFix.getBytes(), 0, rvalue, index, 1);
				index++;
			}
			System.arraycopy(a, 0, rvalue, index, a.length);
		}
		else {
			System.arraycopy(a, 0, rvalue, index, a.length);
			index += a.length;

			for (int s = size; s > a.length; s--) {
				System.arraycopy(preFix.getBytes(), 0, rvalue, index, 1);
				index++;
			}
		}

		return rvalue;
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param a
	 * @return
	 */
	public static String getNextNumString(String a) {
		int num = Integer.parseInt(a);
		num++;
		return getSizeString(num, a.length());
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param a
	 * @param size
	 * @return
	 */
	public static String getSizeString(String a, int size) {
		return getSizeString(a, size, "0", "PRE");
	}

	/**
	 * Method getSizeString.
	 * 
	 * <pre>
	 *  입력된 값의 앞에 preFix을 붙여서 스트링으로 리턴
	 * <br>
	 * </pre>
	 * 
	 * @param a
	 * @param size
	 * @param preFix
	 * @param preflg 여백 문자를 어느쪽에 위치하는지에 대한 Flag ("PRE","POST")
	 * @return String
	 */
	public static String getSizeString(String a, int size, String preFix, String preflg) {
		StringBuffer rvalue = new StringBuffer();
		byte[] tmp = a.getBytes();
		if ("PRE".equals(preflg)) {
			for (int s = size; s > tmp.length; s--) {
				rvalue.append(preFix);
			}
			rvalue.append(a);
		}
		else {
			rvalue.append(a);
			for (int s = size; s > tmp.length; s--) {
				rvalue.append(preFix);
			}
		}

		return rvalue.toString();
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param FieldName
	 * @return
	 */
	public static String makeMethodName(String sFieldName) {
		String methodName = new String();
		String[] token = sFieldName.toLowerCase().split("_");

		//methodName = token[0];
		for (int i = 0; i < token.length; i++) {
			methodName += (token[i].substring(0, 1).toUpperCase() + token[i].substring(1));
		}
		return methodName;
	}

	
	/**
	 * 정렬항목을 table field name형식으로 변경
	 * @param orderByType
	 * @return
	 */
	public static String getConvertFieldName(String orderByType){
		int i=0, byLen = orderByType.length();
		String ss = "", rtString = "";
		for ( i=0;i<byLen;i++) {
			ss = orderByType.substring(i,i+1);
			if ( ss == ss.toUpperCase() && ss != ss.toLowerCase()) {
				rtString = rtString + "_" + ss;
			} else {
				rtString = rtString + ss;	
			}
		}
		return rtString.toUpperCase();
	}
		

	/**
	 * Token으로 분리된 문자열을 String array로 만든다
	 * 
	 * @param str token으로 분리된 문자열 
	 * @param token 문자
	 * @return String 배열
	 */
	public static String[] splitString(String str, String token){
		StringTokenizer tokenizer;
		String[] arrRtn = null;
		int cnt, idx;
		if(null != str){
			tokenizer = new StringTokenizer(str, token);
			cnt = tokenizer.countTokens();
			arrRtn = new String[cnt];
	        idx = 0;
	        while(tokenizer.hasMoreElements()){
				arrRtn[idx++] = tokenizer.nextToken().trim();
	        }
		}
		return arrRtn;
	}
	
	
	/**
	 * <P>
	 *
	 * </p>
	 * @param src
	 * @param len
	 * @return
	 */
	public static byte[] hexstr2ascii(String src, int len) {
		int i = 0;

		byte[] ret = new byte[len / 2];
		String temp = new String();

		for (i = 0; i < len / 2; i++) {
			temp = src.substring(i * 2, i * 2 + 1);
			temp += src.substring(i * 2 + 1, i * 2 + 2);
			ret[i] = (byte) Integer.parseInt(temp, 16);
			temp = null;
		}

		return ret;
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param ascii
	 * @return
	 */
	public static String ascii2hexstr(byte[] ascii) {
		String ret = new String();
		//System.out.println("ascii.length : "+ascii.length);
		int i = 0;

		for (i = 0; i < ascii.length; i++) {
			ret += printHex(ascii[i]);
		}
		return ret;
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param data
	 * @return
	 */
	public static String printHex(byte data) {
		String ret = new String();
		String temp = new String();

		temp = Integer.toHexString((int) data);
		if (temp.length() == 2) {
			return temp;
		}
		if (temp.length() < 2) {
			ret = "0" + temp;
			return ret;
		}
		if (temp.length() > 2) {
			ret = temp.substring(temp.length() - 2, temp.length());
		}
		return ret;
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param english
	 * @return
	 */
	public static String strE2K(String english) {
		String korean = null;

		if (english == null)
			return null;
		//if (english == null ) return "";

		try {
			korean = new String(english.getBytes("8859_1"), "KSC5601");
		}
		catch (UnsupportedEncodingException e) {
			korean = new String(english);
		}
		return korean;
	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param english
	 * @return
	 */
	public static String strUTF82K(String english) {
		String korean = null;

		if (english == null)
			return null;
		//if (english == null ) return "";

		try {
			korean = new String(english.getBytes("utf-8"), "KSC5601");
		}
		catch (UnsupportedEncodingException e) {
			korean = new String(english);
		}
		return korean;
	}
	
	/**
	 * <P>
	 *
	 * </p>
	 * @param english
	 * @return
	 */
	public static String strUTF82EUCKR(String english) {
		String korean = null;

		if (english == null)
			return null;
		//if (english == null ) return "";

		try {
			korean = new String(english.getBytes("utf-8"), "euc-kr");
		}
		catch (UnsupportedEncodingException e) {
			korean = new String(english);
		}
		return korean;
	}
	
	/**
	 * <P>
	 *
	 * </p>
	 * @param korean
	 * @return
	 */
	public static String strK2E(String korean) {
		String english = null;

		if (korean == null)
			return null;
		//if (korean == null ) return "";

		english = new String(korean);
		try {
			english = new String(korean.getBytes("KSC5601"), "8859_1");
		}
		catch (UnsupportedEncodingException e) {
			english = new String(korean);
		}
		return english;
	}

	/**
	 * 
	 * @param dateFormat
	 * @return
	 * @throws Exception
	 */
	public static String getSysDate(String dateFormat) throws Exception {
		Calendar calendar = Calendar.getInstance();
		return getDate(calendar.getTime(), dateFormat);
	}
	
	public static String getDate(Date date, String dateFormat) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		return sdf.format(date);
	}
	
	/**
	 * <P>
	 *
	 * </p>
	 * @param strDate
	 * @param format
	 * @return
	 * @throws ParseException
	 */
//	public static Date getDate(String strDate, String format) throws ParseException {
//		SimpleDateFormat formatter = new java.text.SimpleDateFormat(format, java.util.Locale.KOREA);
//		Date date = formatter.parse(strDate);
//		return date;
//	}

	/**
	 * <P>
	 *
	 * </p>
	 * @param date
	 * @return
	 */
	public static java.sql.Date getSqlDate(Date date) {
		java.sql.Date sqlDate = new java.sql.Date(date.getTime());
		return sqlDate;
	}

	/**
	 * Method cutString.
	 * 입력된str을 size만큼 자른 후 '...'을 덧붙여 리턴함
	 * @param str - String
	 * @param size - int
	 * @return String - 
	 */
	public static String cutString(String str, int size) {
		String result = null;
		try {
			if (str == null || size == 0) {
				result = "";
			}
			else {
				String subKor = null;
				String resultKor = null;
				String kscKor = null;
				//subKor = str.substring(0,size);
				byte[] tmp = str.getBytes();
				if (tmp.length <= size) {
					result = str;
				}
				else {

					byte[] tt = new byte[size];
					for (int i = 0; i < size; i++)
						tt[i] = tmp[i];

					subKor = new String(tt);
					try {
						kscKor = new String(subKor.getBytes("8859_1"), "euc-kr");
					}
					catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					try {
						resultKor = new String(kscKor.getBytes("euc-kr"), "8859_1");
					}
					catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					if (resultKor == null) {
						resultKor = subKor;
					}
					if (resultKor.equals(""))
						subKor = str.substring(0, size - 1);

					result = subKor + "...";
				}
			}
		}
		catch (IndexOutOfBoundsException e) {
			result = str;
		}
		return result;
	}

	/**
	 * MethodName: isNull<br>
	 * 널이거나 blank이면 true, 그렇지 않으면 false값을 리턴<br>
	 * @param String value
	 * @return boolean
	 */
	public static boolean isNull(String value) {
		if (value == null || value.trim().equals(""))
			return true;

		return false;
	}

	/**
	 * MethodName: replaceNull<br>
	 * 널값이면 ''값을, 그렇지않으면 trim()한 값을 리턴<br>
	 * @param String value
	 * @return String
	 */
	public static String replaceNull(String value) {
		return replaceNull(value, "");
	}

	/**
	 * MethodName: replaceNull<br>
	 * NULL이거나 "" 값이면 repStr 값을, 그렇지않으면 trim()한 값을 리턴<br>
	 * @param String value
	 * @param String repStr
	 * @return String
	 */
	public static String replaceNull(String value, String repStr) {
		if (isNull(value))
			return repStr;

		return value.trim();
	}
	
	
	/**
	 * MethodName: replaceNull<br>
	 * NULL이거나 "" 값이거나 undefined라면 defaultValue 값을, 그렇지않으면 toString()한 값을 리턴<br>
	 * @param object value
	 * @param String repStr
	 * @return String
	 */
	public static String replaceNull(Object obj, String defaultValue) {
		String	retVal	=	"";
		if ((obj == null) || obj.equals("") || obj.equals("undefined")) {
			retVal	=	defaultValue;
		} else {
			retVal	=	obj.toString();
		}
		return retVal;
	}

	/**
	 * MethodName: replaceNull<br>
	 * NULL이거나 "" 값이거나 undefined라면 defaultValue 값을, 그렇지않으면 toString()한 값을 리턴<br>
	 * @param object value
	 * @return String
	 */
	public static String replaceNull(Object obj) {
		return replaceNull(obj, "");
	}
	
	
	
	
	

	/**
	 * <P>
	 * 스트링 숫자를 int형으로 만든다.
	 * </p>
	 * @param value String
	 * @return int
	 */
	public static int parseInt(String value) {
		int rvalue = 0;
		if (value == null || "".equals(value)) {
			rvalue = 0;
		}
		else {
			try{
				rvalue = Integer.parseInt(value);
			}catch(Exception e){
				rvalue = 0;
			}
		}
		return rvalue;
	}
	
	/**
	 * <P>
	 * 스트링 숫자를 long형으로 만든다.
	 * </p>
	 * @param value String
	 * @return long
	 */
	public static long parseLong(String value) {
		long rvalue = 0;
		if (value == null || "".equals(value)) {
			rvalue = 0;
		}
		else {
			try{
				rvalue = Long.parseLong(value);
			}catch(Exception e){
				rvalue = 0;
			}
		}
		return rvalue;
	}

	/**
	 * <P>
	 * 스트링의 특정 문자열을 다른 문자열로 치환한다.
	 * </p>
	 * @param buffer String
	 * @param src String
	 * @param dst String
	 * @return String
	 */
	public static String replaceAll(String buffer, String src, String dst)
	{
		if (buffer == null)
			return null;
		if (src == null || buffer.indexOf(src) < 0)
			return buffer;

		int bufLen = buffer.length();
		int srcLen = src.length();
		StringBuffer result = new StringBuffer();

		int i = 0;
		int j = 0;
		//2013.11.05 - PMD수정(for문 대신 while문 사용하도록 처리)
		//for (; i < bufLen;)
		while(i < bufLen)
		{
			j = buffer.indexOf(src, j);
			if (j >= 0)
			{
				result.append(buffer.substring(i, j));
				result.append(dst);

				j += srcLen;
				i = j;
			}
			else
				break;
		}
		result.append(buffer.substring(i));
		return result.toString();
	}

	/**
	 * 문자열의 길이를 구한다.(한글 2바이트 처리)
	 * 
	 * @param str
	 * @return
	 */
	public static int getLength(String str) {
		return str.getBytes().length;
	}
	
	
	/**
	 * string 자르기
	 * @param str
	 * @param start
	 * @param end
	 * @return
	 */
	public static String getSubstring(String str, int start, int end, boolean bl) {
		if (null == str) {
			return null;
		}

		int srcLen = getLength(str);
		if (srcLen <= start) {
			return str;
		}

		// 시작 Index 찾기
		char chr;
		int sIdx = 0;
		int eIdx = 0;
		int readLen = 0;

		//DB에 깨진 binary 문자가 입력된 경우 오류 발생
		String readStr = str;
		try {
			
			for (sIdx = 0; sIdx < start && readLen < start; sIdx++) {
				chr = str.charAt(sIdx);
				if (0 == (chr & 0xFF00)) {
					readLen++;
				} else {
					readLen += 2;
				}
			}
			
			// 종료 Index 찾기
			readLen = 0;
			for (eIdx = 0; eIdx < end && readLen < end && readLen < srcLen; eIdx++) {
				chr = str.charAt(eIdx);
				if (0 == (chr & 0xFF00)) {
					readLen++;
				} else {
					readLen += 2;
				}
			}
			// 한글이 endIdex 중간에 걸릴경우 마지막 글자(한글) 버림
			if (end < readLen) {
				eIdx--;
			}
			readStr = str.substring(sIdx, eIdx);

		}catch (Exception e) {
			
		}
		if ( srcLen > readLen ) {
			readStr = readStr + "...";
		}
		return readStr;
	}
	
	
    /**
     * 왼쪽에 지정문자 추가
     * 
     * @param src 원본
     * @param pad padding char
     * @param size 최종 문자열 길이
     * @return Padding 결과
     */
    public static String getLeftPadding(String src, String pad, int size) {
            StringBuffer sb = new StringBuffer(10);
            if (null == src) {
                    return null;
            }
            for (int i = 0; i < size - src.length(); i++) {
                    sb.append(pad);
            }
            sb.append(src);
            return sb.toString();
    }
    
    /**
	 * 현재 날짜에서 n달 전날짜 구하기
	 * ex) 2012-01-01
	 * @return
	 */
	public static String getMonthDate(int n) {
		String monthDate = "";
		Calendar calendar = Calendar.getInstance();
		calendar.add ( calendar.MONTH, n ); //n개월 전후(+,-)....
	
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		monthDate = dateFormat.format(calendar.getTime());

		return monthDate;
	}
	
    /**
	 * 
	 * @param format
	 * 			ex> format : yyyyMMddHHmmssSSS
	 * @return
	 */
	public static String getCurrentTime(String format) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(calendar.getTime());
	}
	
	public synchronized static String getCurrentTimeString() {
			
		String currentTimeString = new String();
		int tempint = 0;
		String tempString = new String();

		Calendar calendar = Calendar.getInstance();

		currentTimeString += calendar.get(Calendar.YEAR);		
		
		tempint = calendar.get(Calendar.MONTH) + 1;
		tempString = int2ZeroFillString(tempint, 2);
		currentTimeString += tempString;
		
		tempint = calendar.get(Calendar.DAY_OF_MONTH);
		tempString = int2ZeroFillString(tempint, 2);
		currentTimeString += tempString;
						
		tempint = calendar.get(Calendar.HOUR_OF_DAY);
		tempString = int2ZeroFillString(tempint, 2);
		currentTimeString += tempString;
		
		tempint = calendar.get(Calendar.MINUTE);
		tempString = int2ZeroFillString(tempint, 2);
		currentTimeString += tempString;
		
		tempint = calendar.get(Calendar.SECOND);
		tempString = int2ZeroFillString(tempint, 2);
		currentTimeString += tempString;

//		currentTimeString += calendar.get(13);
		tempint = calendar.get(Calendar.MILLISECOND);
		tempString = int2ZeroFillString(tempint, 3);
		currentTimeString += tempString;
		
		calendar = null;

		return currentTimeString;
	}
	
	public static String int2ZeroFillString(int value, int length) {
		String returnString = new String();
		String valueString = new String();
		Integer mInteger;
		int i = 0;

		mInteger = new Integer(value);
		valueString = mInteger.toString();
		if (valueString.length() > length) {
			return null;
		}

		if (valueString.length() == length) {
			return valueString;
		}

		for (i = 0; i < length - valueString.length(); i++) {
			returnString += "0";
		}

		returnString += valueString;
		return returnString;
	}
	
	public static String long2ZeroFillString(long value, int length) {
		String returnString = new String();
		String valueString = new String();
		Long mLong;
		int i = 0;

		mLong = new Long(value);
		valueString = mLong.toString();
		if (valueString.length() > length) {
			return null;
		}

		if (valueString.length() == length) {
			return valueString;
		}

		for (i = 0; i < length - valueString.length(); i++) {
			returnString += "0";
		}

		returnString += valueString;
		return returnString;
	}
	
	/**
     * Base64Decoding 방식으로 아스키 문자열을 바이트 배열로 디코딩한다.
     * In-Ascii, Out-Binany
     *
     * @param  strDecode 디코딩할 아스키 문자열(String)
     * @return  디코딩된 바이트 배열(byte[])
     */
   /*public static byte[] base64Decode(String source) {
	   byte[] buffer = null;
    
	   BASE64Decoder base64Decoder 	= new BASE64Decoder();
	   ByteArrayInputStream  in 	= new ByteArrayInputStream(source.getBytes());
	   ByteArrayOutputStream out 	= new ByteArrayOutputStream();

	   try {
		   base64Decoder.decodeBuffer(in, out);
	   } catch (Exception e) {
		   e.printStackTrace();
	   }
	   buffer = out.toByteArray();
	   return buffer;
   }*/
 
   /**
    * 적당한 길이로 자른다.
    * 
    * @param size	
    * @param value
    * @return
    */
   public static String longDouble2String(int size, double value) {
		NumberFormat nf = NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(size);
//		nf.setMinimumFractionDigits(size);
		nf.setGroupingUsed(false);
		return nf.format(value);
	}
   
   public static String makeListToString(String[] list, String token) {
	   
	   StringBuffer buffer = new StringBuffer();
	   
	   for(int i = 0;i<list.length;i++) {
		   buffer.append(list[i]);
		   
		   if(i < (list.length-1))
		   buffer.append(token);
	   }
	   return buffer.toString();
   }
   
   public static String removeFormat(String strTarget) {
		if ( strTarget == null || strTarget.equals( "" ) )
			return strTarget;
		
		return strTarget.replaceAll( "[$|^|*|+|?|/|:|\\-|,|.|\\s]", "" );
	}
   
   // 전화번호 변환
	public static String makePhoneNumber(String strTarget)
	{
		String strValue = removeFormat( strTarget );
		int nLength = strValue.length();
		
		if ( nLength < 9 || nLength > 12 )  return strTarget;
		
		StringBuffer objSB = new StringBuffer( strValue );
		
		if ( strValue.startsWith( "02" ) == true ) { 
			if ( nLength == 9 ) {
				objSB.insert( 2, "-" );
				objSB.insert( 6, "-" );
			} else {
				objSB.insert( 2, "-" );
				objSB.insert( 7, "-" );
			}
		} else { 
			if ( nLength == 10 ) {
				objSB.insert( 3, "-" );
				objSB.insert( 7, "-" );
			} else {
				objSB.insert( 3, "-" );
				objSB.insert( 8, "-" );
			}
		}
		return objSB.toString();
	}
	
	public static String md5(String str) {
		if("".equals(str)) {
			return "";
		}
		
		try {
			MessageDigest di = MessageDigest.getInstance("MD5");  
	        di.update(new String(str).getBytes());  
	        byte[] md5Code = di.digest();  
	        StringBuffer sb = new StringBuffer();  
	        
	        for (int i=0;i<md5Code.length;i++) {  
	            String md5Char = Integer.toHexString(0xff&(char)md5Code[i]);  
	            sb.append(md5Char);  
	        }
	        str = sb.toString();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return "";
		}
		
		return str;
		
	}
	
	/**
	 * null값이 있을 경우 공백을 리턴한다.
	 * @param str
	 * @return String
	 */
	public static final String parseNull(String str) {
		return parseNull( str, "" );
	}

	/**
	 * null값이 있을 경우 특정 문자로 대체하여 리턴한다.
	 * @param str
	 * @param defaultVal
	 * @return val
	 */
	public static final String parseNull(String str, String defaultVal) {
		String val = null;

		if( str == null || str.equals(""))
			val = defaultVal;
		else
			val = str.trim();
		
		return val;
	}
	
	/*
	 *  Object를 Map으로 변경해주는 ObjectUtil!
	 *  1. getDeclaredFields()를 통해 선언되어있는 필드를 가져온후 Loop돌며
	 *  2. Field.setAccessible(true)를 통해 private 필드접근을 가능하도록 한다.
	 *  3. 그담엔? 필드명을 Key로하고 값을 저장하여 Map을 뱉어내면 끝~!!
	 */
	public static HashMap<String, Object> convertObjectToMap(Object obj){
        try {
            //Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음.
            Field[] fields = obj.getClass().getDeclaredFields();
            HashMap<String, Object> resultMap = new HashMap<String, Object>();
            for(int i=0; i<=fields.length-1;i++){
                fields[i].setAccessible(true);
                resultMap.put(fields[i].getName(), fields[i].get(obj));
            }
            return resultMap;
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
    }
	
	/*
	 * Map으로 사용하던 데이터를 Object(보통 POJO기반의 get/set메소드가 있는 객체)로 변환
	 * 1. Map의 key만큼 Loop를 돌며 + key값의 첫번째 글자를 대문자로 바꾼다.(보통 name이라는 필드가 있다면 set메소드는 setName 이니까)
	 * 2. 넘긴 POJO의 선언된 Method를 가져와서 우리가 필요한(set할) 메소드를 찾는당
	 * 3. 메소드 실행하며 값을 넘겨준다~ (invoke)
	 */

	public static Object convertMapToObject(HashMap<String, Object> map, Object objClass){
        String keyAttribute = null;
        String setMethodString = "set";
        String methodString = null;
        String paramName = "";
        Iterator<String> itr = map.keySet().iterator();
        while(itr.hasNext()){
            keyAttribute = (String) itr.next();

            paramName = keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
            methodString = setMethodString+paramName;

            try {
            	Method[] methods = objClass.getClass().getDeclaredMethods();
            	
                for(int i=0;i<=methods.length-1;i++){

                    if(methodString.equals(methods[i].getName())){
                        System.out.println("invoke : "+methodString);
                        methods[i].invoke(objClass, map.get(keyAttribute));
                    }
                }
            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
        return objClass;
    }
	
	/**
	 * 문자열을 Double형으로 변환하여 반환한다.<br>
	 * 단, Double형으로 변환할수 없는 경우 디폴트 값을 반환.
	 * @param value - Double형으로 변환할 문자열
	 * @param defaultValue - 디폴트 Double값
	 * @return 문자열을 Double형으로 변환한 값.
	 */
	public static double parseDouble(String value, double defaultValue) {
		try {
			return (value == null || value.equals("")) ? defaultValue : Double.parseDouble(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

	/**
	 * 문자열을 Double형으로 변환하여 반환한다.<br>
	 * 단, Double형으로 변환할수 없는 경우 -1.0 을 반환.
	 * @param value - Double형으로 변환할 문자열
	 * @return 문자열을 Double형으로 변환한 값.
	 */
	public static double parseDouble(String value) {
		return parseDouble(value, -1.0);
	}
	
	/**
	 * 섭씨를 화씨로 변경
	 * @param temp
	 * @return
	 */
	public static String convertTemp(String temp) {
		double retVal = 0d;
		retVal	=	(parseDouble(temp)*9)/5 + 32;
		return String.valueOf(retVal);
	}
	
	
	/**
	 * 아래에 정의된 공백이 제거된 문자열을 반환한다.<br>
	 * If the argument string is null, returns empty string (&quot;&quot;).<br>
	 * <caption>white space</caption> <table>
	 * <tr>
	 * <td>'\t'</td>
	 * <td>&#92;u0009</td>
	 * <td><code>HORIZONTAL TABULATION</code></td>
	 * </tr>
	 * <tr>
	 * <td>'\n'</td>
	 * <td>&#92;u000A</td>
	 * <td><code>NEW LINE</code></td>
	 * </tr>
	 * <tr>
	 * <td>'\f'</td>
	 * <td>&#92;u000C</td>
	 * <td><code>FORM FEED</code></td>
	 * </tr>
	 * <tr>
	 * <td>'\r'</td>
	 * <td>&#92;u000D</td>
	 * <td><code>CARRIAGE RETURN</code></td>
	 * </tr>
	 * <tr>
	 * <td>'&nbsp;&nbsp;'</td>
	 * <td>&#92;u0020</td>
	 * <td><code>SPACE</code></td>
	 * </tr>
	 * </table>
	 * @param value 공백을 제거할 문자열
	 * @return String - 공백이 제거된 문자열
	 */
	public static String trim(String value) {
		return (value == null) ? "" : value.trim();
	}

	/**
	 * 문자열의 왼쪽에 존재하는 공백을 제거하여 반환한다.
	 * @param value - 공백을 제거할 문자열
	 * @return String - 문자열 왼쪽부분의 공백이 제거된 문자열.
	 */
	public static String ltrim(String value) {
		if (value == null)
			return "";

		for (int i = 0; i < value.length(); i++) {
			if (WHITE_SPACE.indexOf(value.charAt(i)) == -1)
				return value.substring(i);
		}

		return "";
	}

	/**
	 * 문자열의 오른쪽에 존재하는 공백을 제거하여 반환한다.
	 * @param value - 공백을 제거할 문자열
	 * @return String - 문자열 오른쪽 부분의 공백이 제거된 문자열.
	 */
	public static String rtrim(String value) {
		if (value == null || value.equals(""))
			return "";

		for (int i = value.length() - 1; i >= 0; i--) {
			if (WHITE_SPACE.indexOf(value.charAt(i)) == -1)
				return value.substring(0, i + 1);
		}

		return "";
	}
	
	/**
	 * @brief	    : 금액에 comma로 구분
	 * @details	: 거리값에 comma로 구분하여 리턴
	 * @return     : comma가 추가된 거리값
	 * @date	    : 2014/10/20
	 *
	 * @remark	: 주의사항
	 */
	public static String comma(int num) {
		DecimalFormat df = new DecimalFormat("#,##0");
		return df.format(num);
	}
	/**
	 * @brief	    : 금액에 comma제거
	 * @details	: 거리값에 comma로 구분하여 리턴
	 * @return     : comma가 추가된 거리값
	 * @date	    : 2014/10/20
	 *
	 * @remark	: 주의사항
	 */
	public static String uncomma(int num) {
		String rNum = String.valueOf(num);
	    return rNum.replaceAll(",", "");
	}
	

}