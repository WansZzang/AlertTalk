/**
 * @file	: ErrorVO.java
 * @brief	: 파일 간략한 설명
 * @details	: 파일 자세한 설명
 * @date	: 2016. 2. 26.
 */
package com.kabone.research.common.vo;

/**
 * @brief	: 간략한 설명
 * @details	: 자세한 설명
 * @author	: yongchul
 * @date	: 2016. 2. 26.
 * @version	: 0.0.1
 */

public class ErrorVO {

	private String errCode;
	
    private String errMsg;

	/**
	 * @return the errCode
	 */
	public String getErrCode() {
		return errCode;
	}

	/**
	 * @param errCode the errCode to set
	 */
	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}

	/**
	 * @return the errMsg
	 */
	public String getErrMsg() {
		return errMsg;
	}

	/**
	 * @param errMsg the errMsg to set
	 */
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ErrorVO [errCode=" + errCode + ", errMsg=" + errMsg + "]";
	}
}
