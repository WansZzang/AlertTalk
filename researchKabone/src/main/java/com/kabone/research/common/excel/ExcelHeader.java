package com.kabone.research.common.excel;

import java.util.List;

public class ExcelHeader {

	boolean isKey;
	List<String> headerKeys;
	List<ExcelHeaderCell> headerCells;

	public List<String> getHeaderKeys() {
		return headerKeys;
	}

	public void setHeaderKeys(List<String> headerKeys) {
		this.headerKeys = headerKeys;
	}

	public List<ExcelHeaderCell> getHeaderCells() {
		return headerCells;
	}

	public void setHeaderCells(List<ExcelHeaderCell> headerCells) {
		this.headerCells = headerCells;
	}
	public boolean isKey() {
		return isKey;
	}

	public void setKey(boolean isKey) {
		this.isKey = isKey;
	}
	
}
