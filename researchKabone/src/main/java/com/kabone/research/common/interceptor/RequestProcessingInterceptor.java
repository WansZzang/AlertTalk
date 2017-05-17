package com.kabone.research.common.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kabone.research.main.controller.MainController;
import com.kabone.research.member.vo.AdminURLVO;
import com.kabone.research.member.vo.AdminVO;

public class RequestProcessingInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
 
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	HttpSession session = request.getSession();
    	
    	boolean isAvailable = false;
    	String currentUri = request.getRequestURI().toString();
    	
        //logger.info("Request URL::" + currentUri);
        
        AdminVO admin = (AdminVO) session.getAttribute("userLoginInfo");
        
    	//AdminVO admin = new AdminVO();
    	
    	//admin.setAdminId("test");
    	//admin.setAdminPw("test");
        
        //페이지별 권한 처리시
    	//List<AdminURLVo> adminUrl = (List<AdminURLVo>) session.getAttribute("adminUrl");
        
    	if (currentUri.contains("/member/") || currentUri.equals("/") || currentUri.contains("/research/") 
    			|| currentUri.contains("/js") || currentUri.contains("/css") || currentUri.contains("/images")	//front에서 가져온 Resource용
    			) {
    		isAvailable = true;
		}
    	
    	//페이지별 권한 처리시
        /*if (admin != null && adminUrl != null) {
        	for (int i = 0; i < adminUrl.size(); i++) {
        		//logger.info("Admin URL::" + adminUrl.get(i).getMenuUrl());
				if (currentUri.contains(adminUrl.get(i).getMenuUrl()) && "90".equals(admin.getUseFlg())) {
					isAvailable = true;
					break;
				}
			}
		}*/
    	if (admin != null) {
        	if ("90".equals(admin.getUseFlg())) {
				isAvailable = true;
        	}
		}
        
        if (!isAvailable) {
        	String exceptionUrl = "/accessDenied";
			throw new ModelAndViewDefiningException(new ModelAndView(exceptionUrl));
		}
        
        return isAvailable;
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	logger.info("Request URL::" + request.getRequestURL().toString()
                + " Sent to Handler :: Current Time=" + System.currentTimeMillis());
        //we can add attributes in the modelAndView and use that in the view page
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        logger.info("Request URL::" + request.getRequestURL().toString());
    }
}
