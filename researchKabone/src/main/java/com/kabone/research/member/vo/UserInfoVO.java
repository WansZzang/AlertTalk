package com.kabone.research.member.vo;

import com.kabone.research.common.PagingVo;

public class UserInfoVO extends PagingVo{
	
	private String userId;
	private String userTy;
	private String userNm;
	private String mobNo;
	private String email;
	private String regDtm;
	private String modDtm;
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the userTy
	 */
	public String getUserTy() {
		return userTy;
	}
	/**
	 * @param userTy the userTy to set
	 */
	public void setUserTy(String userTy) {
		this.userTy = userTy;
	}
	/**
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * @return the mobNo
	 */
	public String getMobNo() {
		return mobNo;
	}
	/**
	 * @param mobNo the mobNo to set
	 */
	public void setMobNo(String mobNo) {
		this.mobNo = mobNo;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	/**
	 * @return the regDtm
	 */
	public String getRegDtm() {
		return regDtm;
	}
	/**
	 * @param regDtm the regDtm to set
	 */
	public void setRegDtm(String regDtm) {
		this.regDtm = regDtm;
	}
	/**
	 * @return the modDtm
	 */
	public String getModDtm() {
		return modDtm;
	}
	/**
	 * @param modDtm the modDtm to set
	 */
	public void setModDtm(String modDtm) {
		this.modDtm = modDtm;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "UserInfoVO [userId=" + userId + ", userTy=" + userTy + ", userNm=" + userNm + ", mobNo=" + mobNo
				+ ", email=" + email + "]";
	}
	
	
}
