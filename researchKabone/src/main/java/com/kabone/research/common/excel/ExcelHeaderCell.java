package com.kabone.research.common.excel;

public class ExcelHeaderCell {

	int cellIndex;
	int mergeSize;
	String title;
	public int getCellIndex() {
		return cellIndex;
	}
	public void setCellIndex(int cellIndex) {
		this.cellIndex = cellIndex;
	}
	public int getMergeSize() {
		return mergeSize;
	}
	public void setMergeSize(int mergeSize) {
		this.mergeSize = mergeSize;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
