package com.kabone.research.research.vo;

public class PollDetailResultVO {
	
	public String userIp;
	public String pollDetailSeq;
	public String pollDetailResult;
	public String pollType;
	
	
	
	
	
	/**
	 * @return the userIp
	 */
	public String getUserIp() {
		return userIp;
	}
	/**
	 * @param userIp the userIp to set
	 */
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	/**
	 * @return the pollDetailSeq
	 */
	public String getPollDetailSeq() {
		return pollDetailSeq;
	}
	/**
	 * @param pollDetailSeq the pollDetailSeq to set
	 */
	public void setPollDetailSeq(String pollDetailSeq) {
		this.pollDetailSeq = pollDetailSeq;
	}
	/**
	 * @return the pollDetailResult
	 */
	public String getPollDetailResult() {
		return pollDetailResult;
	}
	/**
	 * @param pollDetailResult the pollDetailResult to set
	 */
	public void setPollDetailResult(String pollDetailResult) {
		this.pollDetailResult = pollDetailResult;
	}
	/**
	 * @return the pollType
	 */
	public String getPollType() {
		return pollType;
	}
	/**
	 * @param pollType the pollType to set
	 */
	public void setPollType(String pollType) {
		this.pollType = pollType;
	}
	
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PollDetailResultVO [pollDetailSeq=" + pollDetailSeq + ", pollDetailResult=" + pollDetailResult
				+ ", pollType=" + pollType + "]";
	}
}
