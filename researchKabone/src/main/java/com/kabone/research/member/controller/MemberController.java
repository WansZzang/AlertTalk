
package com.kabone.research.member.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
//import java.util.Iterator;
import java.util.Map;
//import java.util.Map.Entry;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kabone.research.common.exception.RestfulAPIException;
import com.kabone.research.common.service.CodeService;
import com.kabone.research.member.service.MemberService;
import com.kabone.research.member.vo.AdminVO;
import com.kabone.research.member.vo.UserCertVO;
import com.kabone.research.member.vo.UserInfoVO;
import com.kabone.research.research.service.ResearchService;
import com.kabone.research.research.vo.PollDetailVO;
import com.kabone.research.research.vo.PollMasterVO;

@Controller
public class MemberController {

	@Value("#{system['homepage.url']}")
	private String HOMEPAGE_URL;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
    @Resource(name = "memberService")
    private MemberService service;
        
    
    @RequestMapping(value ="/member/login.do")
    public void login(@RequestParam Map<String,Object> paramMap , ModelMap model) throws Throwable{
    	
    }
    @RequestMapping(value ="/member/loginFail.do")
    public void loginFail(@RequestParam Map<String,Object> paramMap , ModelMap model) throws Throwable{
    	
    }  
    @RequestMapping(value ="/member/logout.do")
    public void logout(HttpSession session) throws Throwable{
    	//AdminVo userDetails = (AdminVo)session.getAttribute("userLoginInfo");
    	//logger.info("Welcome logout! {}, {}", session.getId(), userDetails.getUserId());
    	
    	session.invalidate();
    }
       
    
    /**
     * 인증 후 메인 (스프링 시큐리티)
     * @param paramMap
     * @param model
     * @param principal
     * @return
     * @throws Throwable
     * @description CMS 로르인 
     */
    @RequestMapping(value ="/member/main.do")
    public String loginMain(HttpSession session , HttpServletRequest request, ModelMap model, Principal principal) throws Throwable{
   		if (null == principal) {
    		return "redirect:/member/login.do";
    	}
    	logger.info("###############  principal is:[" + principal + "]");		
    
    	String username = principal.getName();
    	
    	
    	logger.info("###############  member controller:[" + username + "]");
    	
    	AdminVO admin = this.service.getLoginInfo(username);
    	session.setAttribute("userLoginInfo", admin);
    	
    	//페이지별 권한 처리시
//    	List<AdminURLVo> adminUrl = memberService.getAdminUrlInfo(admin);
//    	session.setAttribute("adminUrl", adminUrl);
    	
    	logger.info("Admin : " + admin.toString());
    	
    	//필요시 권한에 따라 초기페이지를 return 해준다.
    	return "/member/main";
    }
    /**
	* @brief	: 회원관리 > 회원관리
	* @details	: 회원을 관리합니다.
	* @date	: 2016. 4. 15.
	* @param session
	* @param request
	* @param param
	* @param model
	* @return
	* @throws Throwable
	* 
	* @remark	: 주의사항
	*/
    //회원관리  > 리스트
  	@RequestMapping(value ="/MM/ME/ME01")
      public String _cms_user_list(HttpSession session , HttpServletRequest request, @ModelAttribute UserInfoVO param, ModelMap model) throws Throwable{
      	
  		param.setCurrentPage((param.getCurrentPage()-1)*param.getRecordsPerPage());
  		
  		Integer listTotalCnt = service.selectCountUserList(param);
  		List<UserInfoVO> list = service.selectUserList(param);
  		
  		model.addAttribute("list", list);		
  		model.addAttribute("totalRecordCount", listTotalCnt);	//리스트 개수
          model.addAttribute("currentPage", (param.getCurrentPage()/param.getRecordsPerPage())+1); 		//현재페이지번호       
          int totalPageCount = listTotalCnt / param.getRecordsPerPage();
          if(listTotalCnt % param.getRecordsPerPage() > 0){
          	totalPageCount += 1;
          }
          model.addAttribute("totalPageCount", totalPageCount);				//전체페이지 개수        
          model.addAttribute("recordsPerPage", param.getRecordsPerPage());	//한페이지당 리스트 개수        
          model.addAttribute("params", param);
          
      	return "/admin/MM/ME/MM_ME0101";
  	}
  	

  	//사용자관리  > 추가 등록
  	@RequestMapping(value ="/MM/ME/ME02")
      public String _cms_user_add_form(HttpSession session , HttpServletRequest request, @ModelAttribute UserInfoVO param, ModelMap model) throws Throwable{
      	
  		UserInfoVO item = service.selectUser(param);
  		
  		model.put("item", item);
          
      	return "/admin/MM/ME/MM_ME0102";
  	}
  	
  	
  	//회원관리  > 상세
  	@RequestMapping(value ="/MM/ME/ME04")
      public String _cms_user_edit_form(HttpSession session , HttpServletRequest request, @ModelAttribute UserInfoVO param, ModelMap model) throws Throwable{
      	
  		UserInfoVO item = service.selectUser(param);
  		
  		model.put("item", item);
          
      	return "/admin/MM/ME/MM_ME0104";
  	}
  	
  	//회원관리 > 업데이트
  	@RequestMapping(value ="/MM/ME/ME04", method=RequestMethod.POST)
	@ResponseBody
    public void _cms_user_edit_process(HttpSession session , HttpServletRequest request, @ModelAttribute UserInfoVO param, ModelMap model) throws Throwable{
    	  		
  		//1. 유저정보 업데이트
		int ret = service.updateUser(param);	//userLevel, userType, profileImg, nick, modDt 만 업데이트 됨
		if ( ret < 1 ){
			throw new RestfulAPIException(HttpStatus.SC_BAD_GATEWAY, "저장실패");
		}		
		ret = service.updateUserExt(param);		//메모 업데이트
		if ( ret < 1 ){
			throw new RestfulAPIException(HttpStatus.SC_BAD_GATEWAY, "저장실패");
		}
    }
  	
}
