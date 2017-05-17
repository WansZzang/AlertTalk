package com.kabone.research.member.vo;

public class AdminVO {
	
	public String adminId;
	public String adminPw;
	public String adminLevel;
	public String adminNm;
	public String company;
	public String email;
	public String mPhone;
	public String userNm;
	public String useFlg;
	
	
	public String getUseFlg() {
		return useFlg;
	}
	public void setUseFlg(String useFlg) {
		this.useFlg = useFlg;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getAdminLevel() {
		return adminLevel;
	}
	public void setAdminLevel(String adminLevel) {
		this.adminLevel = adminLevel;
	}
	public String getAdminNm() {
		return adminNm;
	}
	public void setAdminNm(String adminNm) {
		this.adminNm = adminNm;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getmPhone() {
		return mPhone;
	}
	public void setmPhone(String mPhone) {
		this.mPhone = mPhone;
	}
	@Override
	public String toString() {
		return "AdminVO [adminId=" + adminId + ", adminPw=" + adminPw
				+ ", adminLevel=" + adminLevel + ", adminNm=" + adminNm
				+ ", company=" + company + ", email=" + email + ", mPhone="
				+ mPhone + ", userNm=" + userNm + ", useFlg=" + useFlg + "]";
	}
	
	
	
}
