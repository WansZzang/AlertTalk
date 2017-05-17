package com.kabone.research.research.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kabone.research.common.excel.ExcelHeader;
import com.kabone.research.common.excel.ExcelHeaderCell;
import com.kabone.research.member.vo.UserInfoVO;
import com.kabone.research.research.service.ResearchService;
import com.kabone.research.research.vo.PollDetailVO;
import com.kabone.research.research.vo.PollMasterVO;
import com.kabone.research.research.vo.PollOptionVO;



@Controller
public class ResearchController {
	private static final Logger logger = LoggerFactory.getLogger(ResearchController.class);
	
	@Resource(name = "researchService")
    private ResearchService researchService;
	
    @RequestMapping(value = "/research/research.do")
    public String research(Locale locale, String locales, Model model,HttpServletRequest request, HttpServletResponse response) throws Exception{
    	
    	logger.info("research param : "+request.getParameter("pollUrlParam"));
    	
    	String pollUrlParam = request.getParameter("pollUrlParam");
    	if(pollUrlParam != null)
    	{
    		PollMasterVO pollMasterVO = researchService.getPollMaster(pollUrlParam);
    		
    		if(pollMasterVO == null)
    		{
    			return "/research/temp2";
    		}
    	
    	
	    	List<PollDetailVO> pollDetailList = researchService.getPollDetailList(pollMasterVO);
	    	
	    	List<PollOptionVO> polloptionList = new ArrayList();
	    	for (int i = 0; i <pollDetailList.size(); i++) {
	    		PollDetailVO temp = pollDetailList.get(i);
	    		
	    		if(temp.getPollType().equals("5"))
	    		{
	    			List<PollOptionVO> pollOptionTempList = researchService.getPollOptionList(temp);
	    			polloptionList.addAll(pollOptionTempList);
	    		}
	    	}
	    	
	    	
	    	
	    	model.addAttribute("pollMaster", pollMasterVO);
	    	model.addAttribute("pollDetailList", pollDetailList);    		    			
	    	
	    	model.addAttribute("polloptionList", polloptionList);
	    	return "/research/research";
    	}
    	else
    	{
    		return "/research/temp";
    	}
    }
    
    
    @RequestMapping("/research/researchInsert.do")
    public @ResponseBody Map<String, Object> researchInsert( Model model, @RequestParam Map<String, Object> paramMap ) throws Exception {
		logger.debug("################################# researchInsert :: " + paramMap);
		Map<String, Object> rtnJsonMap = new HashMap<>();
		//폼 인서트
		researchService.researchInsert(paramMap);
		//맵 전체를 던진후 for문 돌면서 인서트
		rtnJsonMap.put("result", "SUCCESS");
		return rtnJsonMap;
	}
    

    @RequestMapping(value = "/research/result.do")
    public String result(Locale locale, String locales, Model model,HttpServletRequest request, HttpServletResponse response) throws Exception{
    	
    	
    	
    	return "/research/result";
    }
    
    
    /**
	* @brief	: 만족도 조사 > 현재 진행중인 만족도 조사
	* @details	: 현재 진행중인 만족도 조사 현황을 보여줍니다.
	* @date	: 2017. 1. 20.
	* @param session
	* @param request
	* @param param
	* @param model
	* @return
	* @throws Throwable
	* 
	* @remark	: 주의사항
	*/
    @RequestMapping(value ="/RM/RM/RM01")
    public String _cms_poll_data_list(HttpSession session , HttpServletRequest request, @ModelAttribute UserInfoVO param, ModelMap model) throws Throwable{
        List<PollMasterVO> pollMasterVOList = researchService.getPollMasterList();
		if(pollMasterVOList.size() > 0)
		{
	    	model.addAttribute("pollMasterVOList", pollMasterVOList);    		    			
	      	return "/admin/RM/RM/RM_0101";
  		}
		else
		{
			return "/admin/RM/RM/RM_0102";
		}
  	
	}
    
    
    /**
	* @brief	: 만족도 조사 > 현재 진행중인 만족도 조사 > 선택후 데이터 리턴
	* @details	: 현재 진행중인 만족도 조사 현황을 보여줍니다.
	* @date	: 2017. 1. 20.
	* @param session
	* @param request
	* @param param
	* @param model
	* @return
	* @throws Throwable
	* 
	* @remark	: 주의사항
	*/
  	@RequestMapping(value ="/RM/RM/RM0101")
      public String _cms_poll_data(HttpSession session , HttpServletRequest request, @ModelAttribute PollMasterVO pollMasterVO, ModelMap model) throws Throwable{
  			pollMasterVO = researchService.getPollMaster(pollMasterVO.getPollUrlParam());
  			List<PollDetailVO> pollDetailList = researchService.getPollResultList(pollMasterVO);
  	    	model.addAttribute("pollMaster", pollMasterVO);
  	    	model.addAttribute("pollDetailList", pollDetailList);    		    			
  	      	return "/admin/RM/RM/RM_RM0101";
  	}
  	
  	
  	/**
	* @brief	: 만족도 조사 > 현재 진행중인 만족도 조사
	* @details	: 현재 진행중인 만족도 조사 현황을 보여줍니다.
	* @date	: 2017. 1. 20.
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
  	@RequestMapping(value ="/RM/RM/RM02")
      public ModelAndView _cms_poll_data_result(HttpSession session , HttpServletRequest request, @ModelAttribute UserInfoVO param,ModelAndView mav) throws Throwable{
  		PollMasterVO pollMasterVO = researchService.getPollMaster("1CE2016022");
    	if(pollMasterVO != null)
    	{
    		List<PollDetailVO> pollDetailList = researchService.getPollResultList(pollMasterVO);
     	
    		mav.addObject("pollMaster", pollMasterVO);
    		mav.addObject("pollDetailList", pollDetailList);
    	}
    	mav.setViewName("jsonView");
		return mav;
  	}
  	  	

  	
  	@RequestMapping(value ="/RM/RM/RM04")
    public String _cms_adver_list_for_excel(HttpSession session , HttpServletRequest request, @ModelAttribute PollMasterVO pollMasterVO, ModelMap model) throws Throwable{
    	
 		pollMasterVO = researchService.getPollMaster(pollMasterVO.getPollUrlParam());
		List<PollDetailVO> list = researchService.getPollResultList(pollMasterVO);
		
		List<ExcelHeader> excelHeader = new ArrayList<ExcelHeader>();
		excelHeader.add(excelHeader());
		
        model.put("headers", excelHeader);
        model.put("excelBodys", excelBody(list));
        model.put("sheetName", pollMasterVO.getPollTitle());
    	return "excelView";
    }
  	
  	/**
	 * Excel - 이메일 - HEADER  
	 * @param 
	 * @return header
	 * @throws Exception
	 */
	private ExcelHeader excelHeader() {
		List<ExcelHeaderCell> excelHeaderCells = new ArrayList<ExcelHeaderCell>();
		
		String[] title = new String[]{"USER IP","이미지","제목","등록일자","등록자","노출순서","노출여부"};
		
		for(int i = 0;i<title.length;i++) {
			ExcelHeaderCell cell = new ExcelHeaderCell();
			cell.setCellIndex(i);
			cell.setMergeSize(1);
			cell.setTitle(title[i]);
			excelHeaderCells.add(cell);
		}
		
		List<String> keys = new ArrayList<String>();
		keys.add("seqNo");
		keys.add("contImgUrl");
		keys.add("title");
		keys.add("createDt");
		keys.add("modRegId");
		keys.add("showNo");
		keys.add("showYn");
		
		ExcelHeader header = new ExcelHeader();
		header.setHeaderCells(excelHeaderCells);
		header.setHeaderKeys(keys);
		header.setKey(true);
		
		return header;
	}
	
	public List<HashMap<String, Object>> excelBody(List<PollDetailVO> dataList) {
		
		List<HashMap<String, Object>> retList = new ArrayList<HashMap<String, Object>>();
		if(dataList == null) return retList;
		
		for(int i = 0;i<dataList.size();i++) {
			PollDetailVO vo = dataList.get(i);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			/*
			map.put("seqNo", vo.getSeqNo());
			map.put("contImgUrl", vo.getContImgUrl());
			map.put("title", vo.getTitle());
			map.put("createDt", vo.getCreateDt());
			map.put("modRegId", vo.getModRegId());
			map.put("showNo", vo.getShowNo());
			map.put("showYn", "Y".equals(vo.getShowYn())?"노출":"노출안함");
			*/
			retList.add(map);
		}
		return retList;
	}
  	
}
