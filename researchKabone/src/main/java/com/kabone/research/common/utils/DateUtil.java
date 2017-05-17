package com.kabone.research.common.utils;

import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class DateUtil {
	/**
	 * 디폴트 날짜 형식
	 */
	private final static String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	/**
	 * SHORT 날짜 형식
	 */
	private final static String SHORT_DATE_FORMAT = "yyMMdd";
	
	
	/**
	 * 한시간을 100만 분의 1초로 환산
	 */
	private final static int MILLIS_PER_HOUR = 3600000; // 60*60*1000
	
	/**
	 * 열두달의 마지막날을 나타내는 배열.
	 */
	private final static int[] SOLAR_MONTH_ARRAY = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	
	
    /**
	 * 특정 일짜에 특정 날짜 만큼 더해진 날짜를 반환한다. <br>
	 * ex) DateUtil.addDate("20080226", 2L) - 입력 날짜에 이틀뒤의 날짜를 구함.
	 * @param dt 시작일자 (8 자리 또는 14자리 이어야함.)
	 * @param day 시작일자에 더할 날짜
	 * @return Date - 시작일자에 day일짜 만큼 더해진 Data 객체를 반환한다.
	 */
    public static Date addDate(String dt, long day) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static java.util.Date addDate(String dt, long day) {
		if (dt == null) {
		    throw new IllegalArgumentException("dt can not be null");
		}
	
		int len = dt.length();
		if (!(len == 8 || len == 14)) {
		    throw new IllegalArgumentException("dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
		}
	
		if (len == 8) {
		    dt += "000000";
		}

		return addDate(getDate(dt), day);
    }

    /**
	 * 특정 일짜에 특정 날짜 만큼 더해진 날짜를 반환한다. <br>
	 * ex)DateUtil.addDate(new Date(1204013345828L), 2L) <br>
	 * 위 예제에서의 Date객체의 인자는 1970.1.1 00:00:00 이후의 milliseconds 값임.
	 * @param dt Date 객체
	 * @param day 시작일자에 더할 날짜
	 * @return Date - 시작일자에 day일짜 만큼 더해진 Data 객체를 반환한다.
	 */
    public static Date addDate(Date dt, long day) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static java.util.Date addDate(java.util.Date dt, long day) {
    	return new Date(dt.getTime() + (MILLIS_PER_HOUR * 24L * day));
    	//2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    	//return new java.util.Date(dt.getTime() + (MILLIS_PER_HOUR * 24L * day));
    }

    /**
	 * 날짜를 yyyy/MM/dd HH:mm:ss 형식으로 바꾼다.<br>
	 * 입력된 날짜가 null 일경우 "" 리턴, 에러 발생시 입력된 날짜 반환.
	 * @param dt 날짜(8자리 또는 14자리)
	 * @return 특정 포멧으로 변환된 날짜
	 */
    public static String convertQuicsFormat(String dt) {
		if (dt == null)
		    return "";
		try {
		    return convertFormat(dt, "yyyy/MM/dd HH:mm:ss");
		} catch (Exception e) {
		    return dt;
		}
    }

    /**
	 * 날짜를 yyyy/MM/dd 형식으로 바꾼다.<br>
	 * 입력된 날짜가 null 일경우 "" 리턴, 에러 발생시 입력된 날짜 반환.
	 * @param dt 날짜(8자리 또는 14자리)
	 * @return 특정 포멧으로 변환된 날짜
	 */
    public static String convertShortQuicsFormat(String dt) {
		if (dt == null)
		    return "";
		try {
		    return convertFormat(dt, "yyyy/MM/dd");
		} catch (Exception e) {
		    return dt;
		}
    }

    /**
	 * 특정 일자에 특정 날짜 만큼 더해진 날짜를 다음 형식<br>
	 * (14자리-yyyyMMddHHmmss)에 따라 반환한다.<br>
	 * @param dt 날짜 (8자리 또는 14자리)-yyyyMMdd 또는 yyyyMMddHHmmss
	 * @param day 증가시킬 날짜
	 * @return String - 시작일자에 day 만큼 더한 날짜를 String 으로 14자리 반환한다.
	 */
    public static String addDay(String dt, long day) {
		if (dt == null) {
		    throw new IllegalArgumentException("dt can not be null");
		}
	
		int len = dt.length();
		if (!(len == 8 || len == 14)) {
		    throw new IllegalArgumentException("dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
		}
	
		if (len == 8) {
		    dt += "000000";
		}
	
		return addDay(getDate(dt), day);
    }

    /**
	 * 특정 일자에 특정 날짜 만큼 더해진 날짜를 다음 형식<br>
	 * (14자리-yyyyMMddHHmmss)에 따라 반환한다.
	 * @param dt Date 객체
	 * @param day 증가시킬 날짜
	 * @return String 시작일자에 day 만큼 더한 날짜를 String 으로 14자리 반환한다.
	 */
    public static String addDay(Date dt, long day) {
 	//2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static String addDay(java.util.Date dt, long day) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		sdf.setTimeZone(getTimeZone());
	
		return sdf.format(addDate(dt, day));
    }

    /**
	 * 시작일 부터 종료일 사이의 일수를 구한다.
	 * @param from 시작날짜 (8자리 또는 14자리)-yyyyMMdd 또는 yyyyMMddHHmmss
	 * @param to 종료날짜 (8자리 또는 14자리)-yyyyMMdd 또는 yyyyMMddHHmmss
	 * @return long
	 */
    public static long betweenDate(String from, String to) {
		if (from == null) {
		    throw new IllegalArgumentException("from can not be null");
		}
		if (to == null) {
		    throw new IllegalArgumentException("to can not be null");
		}
	
		int len = from.length();
		if (!(len == 8 || len == 14)) {
		    throw new IllegalArgumentException("from length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
		}
	
		if (len == 8) {
		    from += "000000";
		}
	
		len = to.length();
		if (!(len == 8 || len == 14)) {
		    throw new IllegalArgumentException("to length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
		}
	
		if (len == 8) {
		    to += "000000";
		}
	
		return betweenDate(getDate(from), getDate(to));
    }

    /**
	 * 시작일 부터 종료일 사이의 일수를 구한다.
	 * @param from 시작날짜 Date 객체
	 * @param to 종료날짜 Date 객체
	 * @return long
	 */
    public static long betweenDate(Date from, Date to) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static long betweenDate(java.util.Date from, java.util.Date to) {
    	return new Double(Math.ceil((to.getTime() - from.getTime()) / (MILLIS_PER_HOUR * 24))).longValue();
    }

    /**
	 * 날짜를 formatter 형식으로 바꾸어 반환한다.
	 * @param dt 날짜 (8자리 또는 14자리)-yyyyMMdd 또는 yyyyMMddHHmmss
	 * @param formatter 보여줄 형식
	 * @return String 특정 포멧으로 변환된 날짜
	 */
    public static String convertFormat(String dt, String formatter) {
		if (dt == null)
		    throw new IllegalArgumentException("dt can not be null");
	
		int len = dt.length();
		if (!(len == 8 || len == 14))
		    throw new IllegalArgumentException("dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
	
		if (dt.length() == 8)
		    dt += "000000";
	
		SimpleDateFormat sdf = new SimpleDateFormat(formatter);
		return sdf.format(getDate(dt));
    }

    /**
	 * Long 형의 milliseconds 정보를 입력받아 특정 포멧형식으로 변환하여 준다.
	 * @param dt milliseconds - 14자리
	 * @param formatter 표시할 포멧 형식(yyyyMM,yyyyMMdd,yyyyMMddHHmmss...)
	 * @return String 특정 포멧으로 변환된 날짜
	 */
    public static String convertFormat(long dt, String formatter) {
    	return convertFormat(toUtilDate(dt), formatter);
    }

    /**
	 * Date객체의 날짜 정보를 정보를 입력받아 특정 포멧형식으로 변환하여 준다.
	 * @param dt Date객체의 날짜 정보
	 * @param formatter 표시할 포멧 형식(yyyyMM,yyyyMMdd,yyyyMMddHHmmss...)
	 * @return String 특정 포멧으로 변환된 날짜
	 */
    public static String convertFormat(Date dt, String formatter) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static String convertFormat(java.util.Date dt, String formatter) {
		SimpleDateFormat sdf = new SimpleDateFormat(formatter);
		return sdf.format(dt);
    }

    /**
	 * 시스템의 시간을 Date 객체로 반환한다.
	 * @return Date
	 */
    public static Date getCurrentDate() {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static java.util.Date getCurrentDate() {
    	return new Date(System.currentTimeMillis());
    	//2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
        //return new java.util.Date(System.currentTimeMillis());
    }

    /**
	 * 시스템의 시간을 Default 포멧형식으로 반환한다.<br>
	 * 디폴트 포멧 형식 : yyyy-MM-dd HH:mm:ss
	 * @return String
	 */
    public static String getCurrentTime() {
    	return getCurrentTime(getDefaultFormat());
    }
    

    /**
	 * 시스템의 시간을  yyMMdd 포멧형식으로 반환한다.<br>
	 * @return String
	 */
    public static String getCurrentTimeShortFormat() {
    	return getCurrentTime(getShortFormat());
    }

    /**
	 * 시스템의 시간을 주어진 포멧형식으로 반환한다
	 * @param formatter 표시할 포멧 형식(yyyyMM,yyyyMMdd,yyyyMMddHHmmss...)
	 * @return String
	 */
    public static String getCurrentTime(String formatter) {
    	SimpleDateFormat fmt = new SimpleDateFormat(formatter);
    	fmt.setTimeZone(getTimeZone());

    	return fmt.format(new Date(System.currentTimeMillis()));
    	//2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
        //return fmt.format(new java.util.Date(System.currentTimeMillis()));
    }

    /**
	 * 14 자리의 String 문자열을 받아 Data 객체를 생성하여 반환한다.
	 * @param dt String 14 자리 날짜 (yyyyMMddHHmmss)
	 * @return Date
	 */
    private static Date getDate(String dt) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //private static java.util.Date getDate(String dt) {
    	Calendar cal = Calendar.getInstance();
    	cal.set(Integer.valueOf(dt.substring(0, 4)).intValue(), Integer.valueOf(dt.substring(4, 6)).intValue() - 1, Integer.valueOf(
		dt.substring(6, 8)).intValue(), Integer.valueOf(dt.substring(8, 10)).intValue(), Integer.valueOf(dt.substring(10, 12)).intValue(),
		Integer.valueOf(dt.substring(12, 14)).intValue());

    	return cal.getTime();
    }

    /**
	 * 1부터 31 일까지 의 날짜를 2자리수로 맞춰 연결한 문자열을 반환한다.<br>
	 * 문자 연결 구분자는 "," 이다.<br>
	 * ex) 01,02,03,04,05,06 ....
	 * @return String
	 */
    public static String getDayList() {
		StringBuilder sb = new StringBuilder();
	
		for (int i = 0; i < 31; i++) {
		    sb.append(StringUtil.getSizeString(i + 1, 2, "0"));
		    sb.append(",");
		}
	
		return sb.toString();
    }

    /**
	 * 날짜의 디폴트 포멧을 반환한다.<br>
	 * 디폴트 날짜 포맷 : yyyy-MM-dd HH:mm:ss
	 * @return String 디폴트 날짜 포멧.
	 */
    public static String getDefaultFormat() {
    	return DEFAULT_DATE_FORMAT;
    }
    
    /**
	 * 날짜의 쇼트 포멧을 반환한다.<br>
	 * 쇼트 날짜 포맷 : yyMMdd
	 * @return String 쇼트 날짜 포멧.
	 */
    public static String getShortFormat() {
    	return SHORT_DATE_FORMAT;
    }

    

    /**
	 * 해당 일자에 해당하는 월의 마지말 일자를 얻는다.
	 * @param dt 해당일자(yyyyMM, yyyyMMdd, yyyyMMddHHmmss형식)
	 * @return int 28, 29, 30, 31
	 */
    public static int getLastDay(String dt) {
		if (dt.length() < 6)
		    throw new IllegalArgumentException("date type -- yyyyMM, yyyyMMdd, yyyyMMddHHmmss");
		int year = Integer.parseInt(dt.substring(0, 4));
		int month = Integer.parseInt(dt.substring(4, 6));
		if (isLeapYear(year))
		    return (month == 2) ? 29 : SOLAR_MONTH_ARRAY[month - 1];
		else
		    return SOLAR_MONTH_ARRAY[month - 1];
    }

    /**
	 * 해당 일자에 해당하는 월의 마지말 일자를 얻는다.
	 * @param dt Date객체
	 * @return int 28, 29, 30, 31
	 */
    public static int getLastDay(Date dt) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static int getLastDay(java.util.Date dt) {
    	return getLastDay(convertFormat(dt, "yyyyMM"));
    }

    /**
	 * 1월부터 12월까지의 월을 2자리수로 맞춰 연결한 문자열을 반환한다.<br>
	 * 문자 연결 구분자는 "," 이다.<br>
	 * ex) 01,02,03,04,05,06,07,08,09,10,11,12,
	 * @return String
	 */
    public static String getMonthList() {
		StringBuilder sb = new StringBuilder();
	
		for (int i = 0; i < 12; i++) {
		    sb.append(StringUtil.getSizeString(i + 1, 2, "0"));
		    sb.append(",");
		}
	
		return sb.toString();
    }

    /**
	 * 시스템에 설정된 TimeZone RawOffSet을 반환한다.
	 * @return int
	 */
    public static int getRawOffSet() {
    	return (TimeZone.getDefault()).getRawOffset();
    }

    /**
	 * 시스템에 설정된 TimeZone 객체를 반환한다.
	 * @return TimeZone
	 */
    public static TimeZone getTimeZone() {
    	return TimeZone.getDefault();
    }

    /**
	 * 시스템에 설정된 TimeZone ID를 반환한다.<br>
	 * ex) Asia/Seoul
	 * @return String
	 */
    public static String getTimeZoneID() {
    	return (TimeZone.getDefault()).getID();
    }

    /**
	 * maxyear 로부터 1년이 될대까지 년도를 연결한 문자열을 반환한다.<br>
	 * 문자 연결 구분자는 "," 이다.<br>
	 * ex)2008,2007,2006,2005,2004,2003, ....., 2,1,
	 * @param maxyear 4자리 년도
	 * @return String
	 */
    public static String getYearList(int maxyear) {
		StringBuilder sb = new StringBuilder();
	
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
	
		for (int i = 0; i < maxyear; i++) {
		    sb.append(String.valueOf(year));
		    sb.append(",");
		    year--;
		}

		return sb.toString();
    }

    /**
	 * 해당 년도의 윤년여부를 반환한다.
	 * @param year 4자리의 년도
	 * @return boolean - true 윤년, false 평년
	 */
    public static boolean isLeapYear(int year) {
    	return (year % 400 == 0 || year % 100 != 0 && year % 4 == 0);
    }

    /**
	 * Long형 milliseconds를 받아들여 Date 객체를 반환한다.
	 * @param dt 14자리 - milliseconds
	 * @return Date
	 */
    public static Date toUtilDate(long dt) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static java.util.Date toUtilDate(long dt) {
    	return new Date(dt);
    	//2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
        //return new java.util.Date(dt);
    }

    /**
	 * 날자를 입력받아 Date 객체를 반환한다.
	 * @param dt 날짜 (8자리 또는 14자리)-yyyyMMdd 또는 yyyyMMddHHmmss
	 * @return Date
	 */
    public static Date toUtilDate(String dt) {
    //2013.11.05 - PMD수정(Import에 java.util.Date추가하여 java.util.Date => Date로 사용)
    //public static java.util.Date toUtilDate(String dt) {
		if (dt == null) {
		    throw new IllegalArgumentException("dt can not be null");
		}
	
		int len = dt.length();
		if (!(len == 8 || len == 14)) {
		    throw new IllegalArgumentException("dt length must be 8 or 14 (yyyyMMdd or yyyyMMddHHmmss)");
		}
	
		if (dt.length() == 8) {
		    dt += "000000";
		}
	
		return getDate(dt);
    }

    /**
	 * 특정 년의 월 에 대하여 그달에 첫번째 월요일 날짜를 반환한다.
	 * @param year 년
	 * @param month 월 0부터 시작함.(0(1월),1,2,3,...11(12월))
	 * @return int
	 */
    public static int getFirstMonday(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1);
	
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		if (dayOfWeek < 2) {
		    cal.add(Calendar.DATE, 2 - dayOfWeek);
		} else if (dayOfWeek > 2) {
		    cal.add(Calendar.DATE, 9 - dayOfWeek);
		}
		return cal.get(Calendar.DAY_OF_MONTH);
    }
    
    /** JUNGILK 20140121
	 * 해당 일에 대한 월 WEEK 정보를 리턴 한다.
	 * @param date ,flag
	 * @return string
	 */
	public static String getDateWeek(String date, String flag) {
		String ret = null;
		String fmt = "yyyy.MM.dd";
		try {	
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat(fmt);
			Date dt = dateFormat.parse(date);
			cal.setTime(dt);
			if ("W".equals(flag)) {
				int week = cal.get(Calendar.WEEK_OF_MONTH);
				ret = dateFormat.format(cal.getTime()).substring(0, 7) +" "+ week +"week";
			}
		} catch (Exception e) {
		    return date;
		}
		return ret;
	}

    /**
	 * 날짜 포맷을 반환하는 기능을 수행
	 * @param date
	 * @return
	 */
    public static String getDateForm(String date) {
		if (date == null || date.equals(" ")) {
		    return date;
		}
		date = trim(date);
		return putChar(date, '.', 4, 2);
    }

    /**
	 * 시간 포맷을 반환하는 기능을 수행
	 * @param HHMMSS
	 * @return
	 */
    public static String getHHMMSS(String sHHMMSS) {
    	sHHMMSS = trim(sHHMMSS);
		if (sHHMMSS.length() < 6)
		    return sHHMMSS;
	
		Object[] testArgs = { sHHMMSS.substring(0, 2), sHHMMSS.substring(2, 4), sHHMMSS.substring(4, 6) };
		MessageFormat form = new MessageFormat("{0}:{1}:{2}");
		return form.format(testArgs);
    }

    /**
	 * 공백 및 특수한 blank 를 잘라 주는 기능을 수행
	 * @param s 문자열
	 * @return
	 */
    private static String trim(String s) {
		if (s == null)
		    return "";
		int st = 0;
		char[] val = s.toCharArray();
		int count = val.length;
		int len = count;
		while ((st < len) && ((val[st] <= ' ') || (val[st] == '　')))
		    st++;
		while ((st < len) && ((val[len - 1] <= ' ') || (val[len - 1] == '　')))
		    len--;
		return ((st > 0) || (len < count)) ? s.substring(st, len) : s;
    }

    /**
	 * 특정한 위치에 특정한 문자를 삽입하는 기능을 수행<br>
	 * ex) putDash("1234567890",'*', 4, 3) => "1234*567*89"
	 * @param str
	 * @param c
	 * @param offset1
	 * @param cnt2
	 * @return
	 */
    private static String putChar(String str, char c, int offset1, int cnt2) {
		int offset2 = offset1 + cnt2;
		if (str.length() < offset2 || offset2 <= 0)
		    return str;
	
		StringBuffer sb = new StringBuffer();
		char ctmp;
		for (int i = 0; i < str.length(); i++) {
		    ctmp = str.charAt(i);
		    if (i == offset1 || i == offset2)
			sb.append(c);
		    if (ctmp != ' ')
			sb.append(ctmp);
		}
		return sb.toString();
    }
    
    /**
     * USE CASE :
	 *	System.out.println("getPreDate (Y) > " + getPreDate("Y", "2013", -1));
	 *	System.out.println("getPreDate (M) > " + getPreDate("M", "201310", -1));
	 *	System.out.println("getPreDate (W) > " + getPreDate("W", "20131030", -1));
	 *	System.out.println("getPreDate (D) > " + getPreDate("D", "20131030", -1));
     * @param flag
     * @param fmt
     * @param date
     * @return
     */
	public static String getPreDate(String flag, String date, int daySpan) {
		String ret = null;
		String fmt = "yyyy.MM.dd";

		try {
			if ("Y".equals(flag)) {
				fmt = "yyyy";
			} else if ("M".equals(flag)) {
				fmt = "yyyy.MM";
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat(fmt);
			Date dt = dateFormat.parse(date);
			cal.setTime(dt);
			if ("Y".equals(flag)) {
				cal.add(Calendar.YEAR, daySpan);
				ret = dateFormat.format(cal.getTime()).substring(0, 4);
			} else if ("M".equals(flag)) {
				cal.add(Calendar.MONTH, daySpan);
				ret = dateFormat.format(cal.getTime()).substring(0, 7);
			} else if ("W".equals(flag)) {
				cal.add(Calendar.WEEK_OF_YEAR, daySpan);
				ret = dateFormat.format(cal.getTime()).substring(0, 10);
			} else if ("D".equals(flag)) {
				cal.add(Calendar.DATE, daySpan);
				ret = dateFormat.format(cal.getTime()).substring(0, 10);
			}
			
		} catch (Exception e) {
		    return date;
		}

		return ret;
	}
}
