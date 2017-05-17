package com.kabone.research.member.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.kabone.research.member.vo.AdminURLVO;
import com.kabone.research.member.vo.AdminVO;
import com.kabone.research.member.vo.UserCertVO;
import com.kabone.research.member.vo.UserInfoVO;
import com.kabone.research.research.vo.PollMasterVO;

@Repository(value = "memberMapper")
public interface MemberMapper {

	public AdminVO getUserPwd(String userid);
	public List<AdminURLVO> getAdminUrlInfo(AdminVO admin);
	
	
	public List<UserInfoVO> selectUserList(UserInfoVO param) throws DataAccessException;
	public Integer selectCountUserList(UserInfoVO param) throws DataAccessException;
	
	public UserInfoVO selectUser(UserInfoVO param) throws DataAccessException;
	
	public List<UserCertVO> selectAuthEmailForUser(UserInfoVO param) throws DataAccessException;
		
	public Integer updateUser(UserInfoVO param) throws DataAccessException;
	public Integer updateUser2(UserInfoVO param) throws DataAccessException;
	public Integer updateUserInitIdConfirm(UserInfoVO param) throws DataAccessException;
	
	public Integer updateUserCert(UserCertVO param) throws DataAccessException;
	
	public Integer updateUserExt(UserInfoVO param) throws DataAccessException;
	
	public Integer selectCountAuthEmail(UserInfoVO param) throws DataAccessException;
	public Integer insertUserCert(UserCertVO param) throws DataAccessException;
}
