package com.kabone.research.research.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.kabone.research.member.vo.AdminURLVO;
import com.kabone.research.member.vo.AdminVO;
import com.kabone.research.member.vo.UserCertVO;
import com.kabone.research.member.vo.UserInfoVO;
import com.kabone.research.research.vo.PollDetailResultVO;
import com.kabone.research.research.vo.PollDetailVO;
import com.kabone.research.research.vo.PollMasterVO;
import com.kabone.research.research.vo.PollOptionVO;

@Repository(value = "researchMapper")
public interface ResearchMapper {
	public PollMasterVO getPollMaster(String pollUrlParam) throws DataAccessException;

	public List<PollDetailVO> getPollDetailList(PollMasterVO pollMasterVO) throws DataAccessException;

	public void insertPollDetailResult(PollDetailResultVO pollResult) throws DataAccessException;

	public List<PollDetailVO> getPollResultList(PollMasterVO pollMasterVO) throws DataAccessException;

	public List<PollMasterVO> getPollMasterList() throws DataAccessException;

	public List<PollOptionVO> getPollOptionList(PollDetailVO temp) throws DataAccessException;
}
