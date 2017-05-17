/**
 * @file	: RestfulException.java
 * @brief	: 파일 간략한 설명
 * @details	: 파일 자세한 설명
 * @date	: 2016. 2. 26.
 */
package com.kabone.research.common.exception;

import java.text.MessageFormat;
import java.util.Locale;

import org.springframework.context.MessageSource;

/**
 * @brief	: 간략한 설명
 * @details	: 자세한 설명
 * @author	: yongchul
 * @date	: 2016. 2. 26.
 * @version	: 0.0.1
 */

public class RestfulAPIException extends BaseException{

	private static final long serialVersionUID = 1L;
	
	private int status;
	
	private Error error;
	
	public static final int SUCCESS = 0x00;
	
	public static final int ERR_204 = 0x11;
	
	public static final int ERR_400_VALID_FAILED = 0x01;
	
	public static final int ERR_401_INVALID_LOGIN = 0x02;
	
	public static final int ERR_401_UNAUTHORIZED = 0x03;
	
	public static final int ERR_403 = 0x04;
	
	public static final int ERR_404 = 0x05;
	
	public static final int ERR_404_API_NOT_FOUND = 0x06;
	
	public static final int ERR_500_ETC = 0x07;
	
	public static final int ERR_400_CUSTOM_ERROR_CODE = 0x08;
	
	/**
	 * YoungAppException 생성자
	 */
	public RestfulAPIException() {
		this("YoungAppException without message", null, null);
	}

	/**
	 * YoungAppException 생성자
	 * @param defaultMessage 메세지 지정
	 */
	public RestfulAPIException(String defaultMessage) {
		this(defaultMessage, null, null);
	}
	/**
	 * YoungAppException 생성자
	 * @param defaultMessage 메세지 지정
	 * @param wrappedException 발생한 Exception 내포함
	 */
	public RestfulAPIException(String defaultMessage, Exception wrappedException) {
		this(defaultMessage, null, wrappedException);
	}

	/**
	 * YoungAppException 생성자
	 * @param defaultMessage 메세지 지정(변수지정)
	 * @param messageParameters 치환될 메세지 리스트
	 * @param wrappedException 발생한 Exception 내포함.
	 */
	public RestfulAPIException(String defaultMessage, Object[] messageParameters, Exception wrappedException) {
		String userMessage = defaultMessage;
		if (messageParameters != null) {
			userMessage = MessageFormat.format(defaultMessage, messageParameters);
		}
		this.message = userMessage;
		this.wrappedException = wrappedException;
	}
	/**
	 * YoungAppException 생성자
	 * @param messageSource 메세지 리소스
	 * @param messageKey 메세지키값
	 */
	public RestfulAPIException(MessageSource messageSource, String messageKey) {
		this(messageSource, messageKey, null, null, Locale.getDefault(), null);
	}
	/**
	 * YoungAppException 생성자
	 * @param messageSource 메세지 리소스
	 * @param messageKey 메세지키값
	 * @param wrappedException 발생한 Exception 내포함.
	 */
	public RestfulAPIException(MessageSource messageSource, String messageKey, Exception wrappedException) {
		this(messageSource, messageKey, null, null, Locale.getDefault(), wrappedException);
	}

	public RestfulAPIException(MessageSource messageSource, String messageKey, Locale locale, Exception wrappedException) {
		this(messageSource, messageKey, null, null, locale, wrappedException);
	}

	public RestfulAPIException(MessageSource messageSource, String messageKey, Object[] messageParameters, Locale locale,
	        Exception wrappedException) {
		this(messageSource, messageKey, messageParameters, null, locale, wrappedException);
	}

	public RestfulAPIException(MessageSource messageSource, String messageKey, Object[] messageParameters,
	        Exception wrappedException) {
		this(messageSource, messageKey, messageParameters, null, Locale.getDefault(), wrappedException);
	}

	public RestfulAPIException(MessageSource messageSource, String messageKey, Object[] messageParameters,
	        String defaultMessage, Exception wrappedException) {
		this(messageSource, messageKey, messageParameters, defaultMessage, Locale.getDefault(), wrappedException);
	}

	public RestfulAPIException(MessageSource messageSource, String messageKey, Object[] messageParameters,
	        String defaultMessage, Locale locale, Exception wrappedException) {
		this.messageKey = messageKey;
		this.messageParameters = messageParameters;
		this.message = messageSource.getMessage(messageKey, messageParameters, defaultMessage, locale);
		this.wrappedException = wrappedException;
	}

	public RestfulAPIException(int status){
		this(status, "", null);
	}
			
	public RestfulAPIException(int status, String message) {
		this(status, message, null);
		
	}
	
	public RestfulAPIException(int status, String message, Exception ex) {
		this(status, "", message, ex);
	}

	public RestfulAPIException(int status, String code, String message, Exception ex) {
		this(message, null, ex);
		
		if ( ex != null)
			this.wrappedException = wrappedException;
		
		switch ( status ){
			case 0x00:
				this.status = 200;
				break;
			case 0x11:
				this.status = 204;
				this.error = new Error("ETC Error", message);
				break;
			case 0x01 :
				/* ERR_400_VALID_FAILED */
				this.status = 400;
				this.error = new Error("VALIDATION_FAILED", message);
				break;
			case 0x02:
				/* ERR_401_INVALID_LOGIN */
				this.status = 401;
				this.error = new Error("INVALID_LOGIN", "이메일 혹은 비밀번호가 틀립니다.");
				break;
			case 0x03:
				/* ERR_401_UNAUTHORIZED */
				this.status = 401;
				this.error = new Error("UNAUTHORIZED", "로그인이 필요한 서비스입니다.");
				break;
			case 0x04:
				/* ERR_403 */
				this.status = 403;
				this.error = new Error("FORBIDDEN", "프로젝트 접근권한이 없습니다.");
				break;
			case 0x05:
				/* ERR_404 */
				this.status = 404;
				this.error = new Error("RESOURCE_NOT_FOUND", "요청하신 자원을 찾지 못했습니다.");
				break;
			case 0x06:
				/* ERR_404_API_NOT_FOUND */
				this.status = 404;
				this.error = new Error("API_NOT_FOUND", "요청하신 API를 찾지 못했습니다.");
				break;
			case 0x07:
				/* ERR_500_ETC */
				this.status = 500;
				this.error = new Error("ETC Error", message);
				break;
			case 0x08:
				/* ERR_500_ETC */
				this.status = 400;
				this.error = new Error(code, message);
				break;
			default:
				/* ERR ETC */
				this.status = 500;
				if ( "".equals(code) ){
					code = "ETC Error";
				}
				this.error = new Error(code, message);
				break;
		}
	}
	
	public RestfulAPIException(int status, Exception wrappedException) {
		this(""+ status, null, wrappedException);
		
		this.status = status;
		this.wrappedException = wrappedException;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public Error getError() {
		return error;
	}

	public void setError(Error error) {
		this.error = error;
	}

	public class Error{
		private String code;
		private String message;
		
		public Error(String code, String message){
			this.code = code;
			this.message = message;
		}
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public String getMessage() {
			return message;
		}
		public void setMessage(String message) {
			this.message = message;
		}
		
	}
}
