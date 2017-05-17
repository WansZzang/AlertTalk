package com.kabone.research.member.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kabone.research.member.dao.MemberMapper;
import com.kabone.research.member.vo.AdminURLVO;
import com.kabone.research.member.vo.AdminVO;
import com.kabone.research.member.vo.UserCertVO;
import com.kabone.research.member.vo.UserInfoVO;

@Service(value = "MemberService")
public class MemberService implements UserDetailsService{
	@Resource(name = "memberMapper")
	private MemberMapper mapper;

	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	/**
	 * spring secuiry login check
	 */
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		AdminVO adminVo = mapper.getUserPwd(username);
		
		username = adminVo.getAdminId();
		String userPwd = adminVo.getAdminPw();
			
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		roles.add(new SimpleGrantedAuthority("ROLE_USER"));
		
		UserDetails user = new User(username, userPwd, roles);
	
		return user;
	}
	/**
	 * 로그인 완료된 정보
	 * @param username
	 * @return
	 */
	public AdminVO getLoginInfo(String username){
		return mapper.getUserPwd(username);
	}
	public List<AdminURLVO> getAdminUrlInfo(AdminVO admin) {
		return mapper.getAdminUrlInfo(admin);
	}
	
	
	
	public List<UserInfoVO> selectUserList(UserInfoVO param) throws Exception{
		return mapper.selectUserList(param);
	}
	
	public Integer selectCountUserList(UserInfoVO param) throws Exception{
		return mapper.selectCountUserList(param);
	}
	
	public UserInfoVO selectUser(UserInfoVO param) throws Exception{
		return mapper.selectUser(param);
	}
	
	public List<UserCertVO> selectAuthEmailForUser(UserInfoVO param) throws Exception{
		return mapper.selectAuthEmailForUser(param);
	}
	
	public Integer updateUser(UserInfoVO param) throws Exception{
		return mapper.updateUser(param);
	}
	public Integer updateUser2(UserInfoVO param) throws Exception{
		return mapper.updateUser2(param);
	}
	
	public Integer updateUserCert(UserCertVO param) throws Exception{
		return mapper.updateUserCert(param);
	}
	
	public Integer updateUserExt(UserInfoVO param) throws Exception{
		return mapper.updateUserExt(param);
	}
	
	public Integer updateUserInitIdConfirm(UserInfoVO param) throws Exception{
		return mapper.updateUserInitIdConfirm(param);
	}
	
	
	public Integer selectCountAuthEmail(UserInfoVO param) throws Exception{
		return mapper.selectCountAuthEmail(param);
	}
	public Integer insertUserCert(UserCertVO param) throws Exception{
		return mapper.insertUserCert(param);
	}
	
	
}
