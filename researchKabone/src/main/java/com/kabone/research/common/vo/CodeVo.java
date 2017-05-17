package com.kabone.research.common.vo;


public class CodeVo {
	private String seqNo;
	private String codeType;
	private int codeSeq;
	private String codeNm;
	private String codeValue;
	private String description;
	
	private String yn = "N";
	
	public CodeVo() {
		
	}
	public CodeVo(String codeType) {
		super();
		this.codeType = codeType;
	}
	
	
	
	
	public String getYn() {
		return yn;
	}
	public void setYn(String yn) {
		this.yn = yn;
	}
	public String getCodeNm() {
		return codeNm;
	}
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getCodeType() {
		return codeType;
	}
	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}
	public int getCodeSeq() {
		return codeSeq;
	}
	public void setCodeSeq(int codeSeq) {
		this.codeSeq = codeSeq;
	}
	public String getCodeValue() {
		return codeValue;
	}
	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "CodeVo [seqNo=" + seqNo + ", codeType=" + codeType
				+ ", codeSeq=" + codeSeq + ", codeNm=" + codeNm
				+ ", codeValue=" + codeValue + ", description=" + description
				+ ", yn=" + yn + "]";
	}


	
	
	
	
	
}
