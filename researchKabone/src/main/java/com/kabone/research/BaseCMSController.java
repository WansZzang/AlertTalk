/**
 * @file	: BaseCMSController.java
 * @brief	: 파일 간략한 설명
 * @details	: 파일 자세한 설명
 * @date	: 2016. 2. 26.
 */
package com.kabone.research;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kabone.research.common.exception.RestfulAPIException;
import com.kabone.research.common.type.ErrorType;
import com.kabone.research.common.vo.ErrorVO;

import net.sf.json.JSONSerializer;

/**
 * @brief	: 간략한 설명
 * @details	: 자세한 설명
 * @author	: yongchul
 * @date	: 2016. 2. 26.
 * @version	: 0.0.1
 */
abstract public class BaseCMSController {

	protected static Logger logger = LoggerFactory.getLogger(BaseCMSController.class);
	
	@ExceptionHandler(MissingServletRequestParameterException.class)
    ErrorVO handleIllegalArgumentException(HttpServletResponse response, Exception e) throws IOException {

    	ErrorVO errorModel = new ErrorVO();
        errorModel.setErrCode(ErrorType.PARAMETER_ERROR);
        errorModel.setErrMsg(ErrorType.PARAMETER_ERROR_MSG + " [ " + e.getMessage() + " ]");

        return errorModel;
    }
    
    @ExceptionHandler(value=RestfulAPIException.class)
	public void handleCustomException(HttpServletRequest req, HttpServletResponse res, RestfulAPIException ex) throws Exception{
		
		Map<String, Object> rtnObj = new HashMap<String, Object>();
		rtnObj.put("error", ex.getError());
		
		res.setStatus(ex.getStatus());
		
		res.setContentType("application/json; charset=UTF-8");
		res.getWriter().write( new JSONSerializer().toJSON(rtnObj).toString());
		res.getWriter().flush();
	}
    
    @ExceptionHandler(value=DuplicateKeyException.class)
	void handleDuplicateKeyException(HttpServletRequest req, HttpServletResponse res, Exception ex) throws Exception{
		
    	res.setStatus(HttpStatus.BAD_REQUEST.value());
		
    	ErrorVO errorModel = new ErrorVO();
        errorModel.setErrCode(ErrorType.PARAMETER_ERROR);
        errorModel.setErrMsg(ErrorType.PARAMETER_ERROR_MSG + " [ " + ex.getMessage() + " ]");
        
		res.setContentType("application/json; charset=UTF-8");
		res.getWriter().write( new JSONSerializer().toJSON(errorModel).toString());
		res.getWriter().flush();
	}
}
