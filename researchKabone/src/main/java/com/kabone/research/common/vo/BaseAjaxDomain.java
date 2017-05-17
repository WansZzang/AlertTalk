/**
 * 
 */
package com.kabone.research.common.vo;

import java.util.Map;

import com.kabone.research.common.CommonConsts;

/**
 * @author yongch
 *
 */
public class BaseAjaxDomain {

	public BaseAjaxDomain(){
		this.retCode = CommonConsts.SP_RTN_CD_SUCCESS;
		this.retMsg = "success";
	}
	
	private String retCode;
	
	private String retMsg;
	
	private Map<String, Object> dataMap;

	public String getRetCode() {
		return retCode;
	}

	public void setRetCode(String retCode) {
		this.retCode = retCode;
	}

	public String getRetMsg() {
		return retMsg;
	}

	public void setRetMsg(String retMsg) {
		this.retMsg = retMsg;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	@Override
	public String toString() {
		return "BaseAjaxDomain [retCode=" + retCode + ", retMsg=" + retMsg + ", dataMap=" + dataMap + "]";
	}
	
}
