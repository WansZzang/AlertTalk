package com.kabone.research.member.vo;

public class UserCertVO {
	private int seqNo;
	private String createDt;
	private String modDt;
	private String userNo;
	private String authSnsType;
	private String authSnsId;
	private String authSnsTocken;
	private String authEmail;
	private String certLevel;
	private int certPay;
	private int certGameCnt;
	private String certPayYn;
	private String certGameCntYn;
	public int getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(int seqNo) {
		this.seqNo = seqNo;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String getModDt() {
		return modDt;
	}
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getAuthSnsType() {
		return authSnsType;
	}
	public void setAuthSnsType(String authSnsType) {
		this.authSnsType = authSnsType;
	}
	public String getAuthSnsId() {
		return authSnsId;
	}
	public void setAuthSnsId(String authSnsId) {
		this.authSnsId = authSnsId;
	}
	public String getAuthSnsTocken() {
		return authSnsTocken;
	}
	public void setAuthSnsTocken(String authSnsTocken) {
		this.authSnsTocken = authSnsTocken;
	}
	public String getAuthEmail() {
		return authEmail;
	}
	public void setAuthEmail(String authEmail) {
		this.authEmail = authEmail;
	}
	public String getCertLevel() {
		return certLevel;
	}
	public void setCertLevel(String certLevel) {
		this.certLevel = certLevel;
	}
	public int getCertPay() {
		return certPay;
	}
	public void setCertPay(int certPay) {
		this.certPay = certPay;
	}
	public int getCertGameCnt() {
		return certGameCnt;
	}
	public void setCertGameCnt(int certGameCnt) {
		this.certGameCnt = certGameCnt;
	}
	public String getCertPayYn() {
		return certPayYn;
	}
	public void setCertPayYn(String certPayYn) {
		this.certPayYn = certPayYn;
	}
	public String getCertGameCntYn() {
		return certGameCntYn;
	}
	public void setCertGameCntYn(String certGameCntYn) {
		this.certGameCntYn = certGameCntYn;
	}
	@Override
	public String toString() {
		return "UserCertVO [seqNo=" + seqNo + ", createDt=" + createDt
				+ ", modDt=" + modDt + ", userNo=" + userNo + ", authSnsType="
				+ authSnsType + ", authSnsId=" + authSnsId + ", authSnsTocken="
				+ authSnsTocken + ", authEmail=" + authEmail + ", certLevel="
				+ certLevel + ", certPay=" + certPay + ", certGameCnt="
				+ certGameCnt + ", certPayYn=" + certPayYn + ", certGameCntYn="
				+ certGameCntYn + "]";
	}
	
	
	
}
