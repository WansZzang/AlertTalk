package com.kabone.research.research.vo;

public class PollMasterVO {
	
	public String pollSeq;
	public String evlnId;
	public String pollTitle;
	public String pollMasterDesc;
	public String pollUrlParam;
	public String pollStartDt;
	public String pollEndDt;
	/**
	 * @return the pollSeq
	 */
	public String getPollSeq() {
		return pollSeq;
	}
	/**
	 * @param pollSeq the pollSeq to set
	 */
	public void setPollSeq(String pollSeq) {
		this.pollSeq = pollSeq;
	}
	/**
	 * @return the evlnId
	 */
	public String getEvlnId() {
		return evlnId;
	}
	/**
	 * @param evlnId the evlnId to set
	 */
	public void setEvlnId(String evlnId) {
		this.evlnId = evlnId;
	}
	/**
	 * @return the pollTitle
	 */
	public String getPollTitle() {
		return pollTitle;
	}
	/**
	 * @param pollTitle the pollTitle to set
	 */
	public void setPollTitle(String pollTitle) {
		this.pollTitle = pollTitle;
	}
	/**
	 * @return the pollMasterDesc
	 */
	public String getPollMasterDesc() {
		return pollMasterDesc;
	}
	/**
	 * @param pollMasterDesc the pollMasterDesc to set
	 */
	public void setPollMasterDesc(String pollMasterDesc) {
		this.pollMasterDesc = pollMasterDesc;
	}
	/**
	 * @return the pollUrlParam
	 */
	public String getPollUrlParam() {
		return pollUrlParam;
	}
	/**
	 * @param pollUrlParam the pollUrlParam to set
	 */
	public void setPollUrlParam(String pollUrlParam) {
		this.pollUrlParam = pollUrlParam;
	}
	
	/**
	 * @return the pollStartDt
	 */
	public String getPollStartDt() {
		return pollStartDt;
	}
	/**
	 * @param pollStartDt the pollStartDt to set
	 */
	public void setPollStartDt(String pollStartDt) {
		this.pollStartDt = pollStartDt;
	}
	/**
	 * @return the pollEndDt
	 */
	public String getPollEndDt() {
		return pollEndDt;
	}
	/**
	 * @param pollEndDt the pollEndDt to set
	 */
	public void setPollEndDt(String pollEndDt) {
		this.pollEndDt = pollEndDt;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PollMasterVO [pollSeq=" + pollSeq + ", evlnId=" + evlnId + ", pollTitle=" + pollTitle
				+ ", pollMasterDesc=" + pollMasterDesc + ", pollUrlParam=" + pollUrlParam + "]";
	}
	
}
