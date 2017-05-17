package com.kabone.research.main.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(Locale locale, String locales, Model model,HttpServletRequest request, HttpServletResponse response) throws Exception{
    	
    	HttpSession session = request.getSession();
		
    	return "/member/login";
    }

    @RequestMapping(value = "/accessDenied.do")
    public String accessDenied() throws Exception{
    	return "accessDenied";
    }
}
