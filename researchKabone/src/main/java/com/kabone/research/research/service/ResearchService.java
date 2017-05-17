package com.kabone.research.research.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
//import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import com.kabone.research.research.dao.ResearchMapper;
import com.kabone.research.research.vo.PollDetailResultVO;
import com.kabone.research.research.vo.PollDetailVO;
import com.kabone.research.research.vo.PollMasterVO;
import com.kabone.research.research.vo.PollOptionVO;

@Service(value = "researchService")
public class ResearchService {
	@Resource(name = "researchMapper")
	private ResearchMapper mapper;

	private static final Logger logger = LoggerFactory.getLogger(ResearchService.class);
	
	
	public PollMasterVO getPollMaster(String pollUrlParam) throws DataAccessException{
		return mapper.getPollMaster(pollUrlParam);
	}


	public List<PollDetailVO> getPollDetailList(PollMasterVO pollMasterVO) throws DataAccessException{
		// TODO Auto-generated method stub
		return mapper.getPollDetailList(pollMasterVO);
	}


	public void researchInsert(Map<String, Object> paramMap) throws DataAccessException{
		// TODO Auto-generated method stub
		
		
		Iterator<String> iterator = paramMap.keySet().iterator();
		String userIp = "";
	    while (iterator.hasNext()) {
	        String key = (String) iterator.next();
	        logger.info("key="+key);
	        logger.info("value="+paramMap.get(key));
	        
	        
	        if(key.equals("userIp"))
	        {
	        	userIp = (String) paramMap.get(key);
	        }
	        else if(key.equals("checkIp"))
	        {
	        	
	        }
	        else
	        {
	        	String pollDetailSeq = key.substring(12);
		        String pollDetailResult = (String) paramMap.get(key);
		        
		        PollDetailResultVO pollResult = new PollDetailResultVO();

		        pollResult.setUserIp(userIp);
	        	pollResult.setPollDetailSeq(pollDetailSeq);
	        	pollResult.setPollDetailResult(pollDetailResult);
	        	
	        	mapper.insertPollDetailResult(pollResult);
	        }
	    }
	}


	public List<PollDetailVO> getPollResultList(PollMasterVO pollMasterVO) throws DataAccessException{
		// TODO Auto-generated method stub
		return mapper.getPollResultList(pollMasterVO);
	}


	public List<PollMasterVO> getPollMasterList() {
		// TODO Auto-generated method stub
		return mapper.getPollMasterList();
	}


	public List<PollOptionVO> getPollOptionList(PollDetailVO temp) {
		// TODO Auto-generated method stub
		return mapper.getPollOptionList(temp);
	}
	
	
}
