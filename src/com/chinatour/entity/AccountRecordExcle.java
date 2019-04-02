package com.chinatour.entity;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.web.servlet.view.document.AbstractExcelView;
import com.fasterxml.jackson.annotation.JsonProperty;
@Data
@EqualsAndHashCode(callSuper=false)
public class AccountRecordExcle  extends AbstractExcelView{
	@JsonProperty
	private String tableTittle = "accountRecordInfo";
	@JsonProperty
	private String[] tableHeader = new String[] {"Office","Beginning Value","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","SubTotal($)"};
	@JsonProperty
	private List<StasticAccount> accs = new ArrayList<StasticAccount>();
	
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    String excelName = "accountInfo.xls";  
	        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
	        response.setContentType("APPLICATION/OCTET-STREAM");  
	        response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(excelName, "UTF-8"));    
	        //创建excle表
	        HSSFSheet sheet = workbook.createSheet("list");
	        //设置表头字体
	        HSSFFont font = workbook.createFont();
	        font.setFontHeightInPoints((short)12);
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        //设置表头样式
	        HSSFCellStyle titleStyle = workbook.createCellStyle();
	        //titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	        //titleStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
	        titleStyle.setFont(font);
	        HSSFCell tableTit = getCell(sheet, 0, 0);    
	        setText(tableTit, tableTittle);
	        sheet.setDefaultColumnWidth(13);
	        HSSFRow row1 = sheet.createRow(1);
	        row1.setHeight((short)(3*200));
	        //创建表头
	        for(int i=0;i<tableHeader.length;i++){
	        	HSSFCell cell = row1.createCell(i);
	        	setText(cell, tableHeader[i]);
	        	cell.setCellStyle(titleStyle);
	        }
	        //创建表内容
	        for(int i=0;i<accs.size();i++){
	        	StasticAccount acc = accs.get(i);
	        	List<MonthAccountRecord> listMonth = accs.get(i).getListMonth();
	        	for(int j=0;j<listMonth.size();j++){
	        		HSSFCell cell = getCell(sheet, j+2, 0);    
			        setText(cell, listMonth.get(j).getBillToReceiver());
			        HSSFCell cell1 = getCell(sheet, j+2, 1);
			        setText(cell1, listMonth.get(j).getBeginningValue()==null?"":listMonth.get(j).getBeginningValue().toString());
			        HSSFCell cell2 = getCell(sheet, j+2, 2);    
			        setText(cell2, listMonth.get(j).getJan()==null?"":listMonth.get(j).getJan().toString());
			        HSSFCell cell3 = getCell(sheet, j+2, 3);    
			        setText(cell3, listMonth.get(j).getFeb()==null?"":listMonth.get(j).getFeb().toString());
			        HSSFCell cell4 = getCell(sheet, j+2, 4);    
			        setText(cell4, listMonth.get(j).getMar()==null?"":listMonth.get(j).getMar().toString());
			        HSSFCell cell5 = getCell(sheet, j+2, 5);    
			        setText(cell5, listMonth.get(j).getApr()==null?"":listMonth.get(j).getApr().toString());
			        HSSFCell cell6 = getCell(sheet, j+2, 6);    
			        setText(cell6, listMonth.get(j).getMay()==null?"":listMonth.get(j).getMay().toString());
			        HSSFCell cell7 = getCell(sheet, j+2, 7);    
			        setText(cell7, listMonth.get(j).getJune()==null?"":listMonth.get(j).getJune().toString());
			        HSSFCell cell8 = getCell(sheet, j+2, 8);    
			        setText(cell8, listMonth.get(j).getJuly()==null?"":listMonth.get(j).getJuly().toString());
			        HSSFCell cell9 = getCell(sheet, j+2, 9);    
			        setText(cell9, listMonth.get(j).getAug()==null?"":listMonth.get(j).getAug().toString());
			        HSSFCell cell10 = getCell(sheet, j+2, 10);    
			        setText(cell10, listMonth.get(j).getSept()==null?"":listMonth.get(j).getSept().toString());
			        HSSFCell cell11 = getCell(sheet, j+2, 11);    
			        setText(cell11, listMonth.get(j).getOct()==null?"":listMonth.get(j).getOct().toString());
			        HSSFCell cell12 = getCell(sheet, j+2, 12);    
			        setText(cell12, listMonth.get(j).getNov()==null?"":listMonth.get(j).getNov().toString());
			        HSSFCell cell13 = getCell(sheet, j+2, 13);    
			        setText(cell13, listMonth.get(j).getDec()==null?"":listMonth.get(j).getDec().toString());
			        HSSFCell cell14 = getCell(sheet, j+2, 14);    
			        setText(cell14, listMonth.get(j).getSubtotal()==null?"":listMonth.get(j).getSubtotal().toString());
	        	}
	        	
	        	HSSFCell[] hss = new HSSFCell[14];//记录最后一行 
	        	String[] bigDec = new String[]{
	        			acc.getBeginningValueSub().toString(),
	        			acc.getJanSub().toString(),
	        			acc.getFebSub().toString(),
	        			acc.getMarSub().toString(),
	        			acc.getAprSub().toString(),
	        			acc.getMaySub().toString(),
	        			acc.getJuneSub().toString(),
	        			acc.getJulySub().toString(),
	        			acc.getAugSub().toString(),
	        			acc.getSeptSub().toString(),
	        			acc.getOctSub().toString(),
	        			acc.getDecSub().toString(),
	        			acc.getNovSub().toString(),
	        			acc.getGrandTotal().toString()
	        	};
	        	
	        	HSSFCell cell15 = getCell(sheet, listMonth.size()+2, 0);    
		        setText(cell15, "GrandTotal($):");
		        HSSFCell cell16 = getCell(sheet, listMonth.size()+2, 1);    
		        setText(cell16, bigDec[0]);
		        HSSFCell cell17 = getCell(sheet, listMonth.size()+2, 2);    
		        setText(cell17, bigDec[1]);
		        HSSFCell cell18 = getCell(sheet, listMonth.size()+2, 3);    
		        setText(cell18, bigDec[2]);
		        HSSFCell cell19 = getCell(sheet, listMonth.size()+2, 4);    
		        setText(cell19, bigDec[3]);
		        HSSFCell cell20 = getCell(sheet, listMonth.size()+2, 5);    
		        setText(cell20, bigDec[4]);
		        HSSFCell cell21 = getCell(sheet, listMonth.size()+2, 6);    
		        setText(cell21, bigDec[5]);
		        HSSFCell cell22 = getCell(sheet, listMonth.size()+2, 7);    
		        setText(cell22, bigDec[6]);
		        HSSFCell cell23 = getCell(sheet, listMonth.size()+2, 8);    
		        setText(cell23, bigDec[7]);
		        HSSFCell cell24 = getCell(sheet, listMonth.size()+2, 9);    
		        setText(cell24, bigDec[8]);
		        HSSFCell cell25 = getCell(sheet, listMonth.size()+2, 10);    
		        setText(cell25, bigDec[9]);
		        HSSFCell cell26 = getCell(sheet, listMonth.size()+2, 11);    
		        setText(cell26, bigDec[10]);
		        HSSFCell cell27 = getCell(sheet, listMonth.size()+2, 12);    
		        setText(cell27, bigDec[11]);
		        HSSFCell cell28 = getCell(sheet, listMonth.size()+2, 13);    
		        setText(cell28, bigDec[12]);
		        HSSFCell cell29 = getCell(sheet, listMonth.size()+2, 14);    
		        setText(cell29, bigDec[13]);
	        }
	    }     
}
