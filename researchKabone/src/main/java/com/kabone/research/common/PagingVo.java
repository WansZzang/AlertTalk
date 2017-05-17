package com.kabone.research.common;

public class PagingVo {
	
	private int currentPage = 1;
	private int recordsPerPage = 10;
	
	private boolean isExcel = false;	//엑셀여부
	
	private String searchType;
	private String searchType1;		//대상구분	 A:전체, T:회원전체, P:프로젝트, U:개별회원
	private String searchType2;		//검색범위	 1:제목, 2:본문, 3:제목+본문
	private String searchWords;		//검색어
	private String searchTermBasisType;	//기준시간  1:발송일
	private String searchTermType;	//검색기간  1:전체, 2:어제, 3:오늘, 4:1주일, 5:1개월, 6:3개월, 7:6개월, 8:1년, 9:직접입력
	private String searchStartDt;	//시작일
	private String searchEndDt;		//종료일
	/**
	 * @return the currentPage
	 */
	public int getCurrentPage() {
		return currentPage;
	}
	/**
	 * @param currentPage the currentPage to set
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	/**
	 * @return the recordsPerPage
	 */
	public int getRecordsPerPage() {
		return recordsPerPage;
	}
	/**
	 * @param recordsPerPage the recordsPerPage to set
	 */
	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}
	/**
	 * @return the isExcel
	 */
	public boolean isExcel() {
		return isExcel;
	}
	/**
	 * @param isExcel the isExcel to set
	 */
	public void setExcel(boolean isExcel) {
		this.isExcel = isExcel;
	}
	/**
	 * @return the searchType
	 */
	public String getSearchType() {
		return searchType;
	}
	/**
	 * @param searchType the searchType to set
	 */
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	/**
	 * @return the searchType1
	 */
	public String getSearchType1() {
		return searchType1;
	}
	/**
	 * @param searchType1 the searchType1 to set
	 */
	public void setSearchType1(String searchType1) {
		this.searchType1 = searchType1;
	}
	/**
	 * @return the searchType2
	 */
	public String getSearchType2() {
		return searchType2;
	}
	/**
	 * @param searchType2 the searchType2 to set
	 */
	public void setSearchType2(String searchType2) {
		this.searchType2 = searchType2;
	}
	/**
	 * @return the searchWords
	 */
	public String getSearchWords() {
		return searchWords;
	}
	/**
	 * @param searchWords the searchWords to set
	 */
	public void setSearchWords(String searchWords) {
		this.searchWords = searchWords;
	}
	/**
	 * @return the searchTermBasisType
	 */
	public String getSearchTermBasisType() {
		return searchTermBasisType;
	}
	/**
	 * @param searchTermBasisType the searchTermBasisType to set
	 */
	public void setSearchTermBasisType(String searchTermBasisType) {
		this.searchTermBasisType = searchTermBasisType;
	}
	/**
	 * @return the searchTermType
	 */
	public String getSearchTermType() {
		return searchTermType;
	}
	/**
	 * @param searchTermType the searchTermType to set
	 */
	public void setSearchTermType(String searchTermType) {
		this.searchTermType = searchTermType;
	}
	/**
	 * @return the searchStartDt
	 */
	public String getSearchStartDt() {
		return searchStartDt;
	}
	/**
	 * @param searchStartDt the searchStartDt to set
	 */
	public void setSearchStartDt(String searchStartDt) {
		this.searchStartDt = searchStartDt;
	}
	/**
	 * @return the searchEndDt
	 */
	public String getSearchEndDt() {
		return searchEndDt;
	}
	/**
	 * @param searchEndDt the searchEndDt to set
	 */
	public void setSearchEndDt(String searchEndDt) {
		this.searchEndDt = searchEndDt;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PagingVo [currentPage=" + currentPage + ", recordsPerPage="
				+ recordsPerPage + ", isExcel=" + isExcel + ", searchType="
				+ searchType + ", searchType1=" + searchType1
				+ ", searchType2=" + searchType2 + ", searchWords="
				+ searchWords + ", searchTermBasisType=" + searchTermBasisType
				+ ", searchTermType=" + searchTermType + ", searchStartDt="
				+ searchStartDt + ", searchEndDt=" + searchEndDt + "]";
	}
	
	
	
}
