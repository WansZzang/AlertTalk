package com.kabone.research.common.excel;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class CustomExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<ExcelHeader> excelHeaders = (List<ExcelHeader>) model.get("headers");
		List<HashMap<String, Object>> excelBodys = (List<HashMap<String, Object>>) model.get("excelBodys");
		String sheetName = model.get("sheetName").toString();
		HSSFSheet sheet = workBook.createSheet(sheetName);
        sheet.setDefaultColumnWidth(15);
        
        CellStyle style = workBook.createCellStyle();
        Font font = workBook.createFont();
        font.setFontName("Arial");
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
//        style.setFillForegroundColor(HSSFColor.YELLOW.index);
//        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
      //  font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
      //  font.setColor(HSSFColor.WHITE.index);
        style.setFont(font);
        
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        
        List<String> headerKeys = null;
        
        for(int i = 0;i<excelHeaders.size();i++) {
        	ExcelHeader excelHeader = excelHeaders.get(i);
        	
        	HSSFRow header = sheet.createRow(i);
        	List<ExcelHeaderCell> excelHeaderCells = excelHeader.getHeaderCells();
        	for(int j = 0;j<excelHeaderCells.size();j++) {
        		ExcelHeaderCell excelHeaderCell = excelHeaderCells.get(j);
        		HSSFCell cell = header.createCell(excelHeaderCell.getCellIndex());
        		cell.setCellValue(excelHeaderCell.getTitle());
        		
        		if(excelHeaderCell.getMergeSize() > 1) {
        			sheet.addMergedRegion(new CellRangeAddress(i, i, excelHeaderCell.getCellIndex(), excelHeaderCell.getCellIndex() + excelHeaderCell.getMergeSize() - 1));        			
        		}
        		
        		if(excelHeader.isKey()) {
        			headerKeys = excelHeader.getHeaderKeys();
        		}
        		cell.setCellStyle(style);
        	}
        }
        
//        style.setFillForegroundColor(HSSFColor.WHITE.index);
        
        for(int i = 0;i<excelBodys.size();i++) {
        	HSSFRow aRow = sheet.createRow(excelHeaders.size() + i);
        	
        	HashMap<String, Object> excelBody = excelBodys.get(i);
        	for(int j = 0;j<headerKeys.size();j++) {
        		HSSFCell cell = aRow.createCell(j);
        		Object value = excelBody.get(headerKeys.get(j));
        		
        		if(value != null) {
        			cell.setCellValue(value.toString());
        		} else {
        			cell.setCellValue("");
        		}
        		cell.setCellStyle(style);
        	}
        }
        
        
        
        String header = getBrowser(request);
        if (header.contains("MSIE")) {
        	String docName = URLEncoder.encode((sheetName + ".xls"),"UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
	     } else if (header.contains("Firefox")) {
	    	 String docName = new String((sheetName + ".xls").getBytes("UTF-8"), "ISO-8859-1");
	    	 response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");
	     } else if (header.contains("Opera")) {
	    	 String docName = new String((sheetName + ".xls").getBytes("UTF-8"), "ISO-8859-1");
	    	 response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");
	     } else if (header.contains("Chrome")) {
	    	 String docName = new String((sheetName + ".xls").getBytes("UTF-8"), "ISO-8859-1");
	    	 response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "\"");
	     } else if(header.contains("WIN11")){
	    	 String docName = new String((sheetName + ".xls").getBytes("euc-kr"), "8859_1");
	    	 response.setHeader("Content-Disposition", "attachment; fileName=\"" + docName + "\";");
	    	 response.setHeader("Content-Transfer-Encoding", "binary");
	     }
        
//        response.setHeader("Content-Disposition", "attachment; filename=\"download.xls\"");
        	
	}

	private String getBrowser(HttpServletRequest request) {
        String header =request.getHeader("User-Agent");
        if (header.contains("MSIE")) {
               return "MSIE";
        } else if(header.contains("Chrome")) {
               return "Chrome";
        } else if(header.contains("Opera")) {
               return "Opera";
        } else if(header.contains("Firefox")) {
            return "Firefox";
        } else if(header.contains("rv:11")) {
            return "WIN11";
        }
        return "Firefox";
  }
}
