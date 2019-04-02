package com.chinatour.entity;

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
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.fasterxml.jackson.annotation.JsonProperty;

@Data
@EqualsAndHashCode(callSuper=false)
public class ReportForGroupExcle  extends AbstractExcelView {
	@JsonProperty
	private String tableTittle = "accountReport";
	@JsonProperty
	private String[] tableHeader = new String[] {"Office","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","SubTotal($)"};
	@JsonProperty
	List<StatisticalProfit> listStatisticalProfit = new ArrayList<StatisticalProfit>();
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String excelName = "accountReport.xls";  
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
        
        for(int i=0;i<listStatisticalProfit.size();i++){
        	StatisticalProfit statisticalProfit = listStatisticalProfit.get(i);
        	HSSFCell cell11 = getCell(sheet, i*3+2, 0);
        	setText(cell11, "");
        	HSSFCell cell12 = getCell(sheet, i*3+2, 1);
        	cell12.setCellValue(Double.parseDouble(statisticalProfit.getJan().getIncome()+""));
        	HSSFCell cell13 = getCell(sheet, i*3+2, 2);
        	cell13.setCellValue(Double.parseDouble(statisticalProfit.getFeb().getIncome()+""));
        	HSSFCell cell14 = getCell(sheet, i*3+2, 3);
        	cell14.setCellValue(Double.parseDouble(statisticalProfit.getMar().getIncome()+""));
        	HSSFCell cell15 = getCell(sheet, i*3+2, 4);
        	cell15.setCellValue(Double.parseDouble(statisticalProfit.getApr().getIncome()+""));
        	HSSFCell cell16 = getCell(sheet, i*3+2, 5);
        	cell16.setCellValue(Double.parseDouble(statisticalProfit.getMay().getIncome()+""));
        	HSSFCell cell17 = getCell(sheet, i*3+2, 6);
        	cell17.setCellValue(Double.parseDouble(statisticalProfit.getJun().getIncome()+""));
        	HSSFCell cell18 = getCell(sheet, i*3+2, 7);
        	cell18.setCellValue(Double.parseDouble(statisticalProfit.getJul().getIncome()+""));
        	HSSFCell cell19 = getCell(sheet, i*3+2, 8);
        	cell19.setCellValue(Double.parseDouble(statisticalProfit.getAug().getIncome()+""));
        	HSSFCell cell110 = getCell(sheet, i*3+2, 9);
        	cell110.setCellValue(Double.parseDouble(statisticalProfit.getSep().getIncome()+""));
        	HSSFCell cell111 = getCell(sheet, i*3+2, 10);
        	cell111.setCellValue(Double.parseDouble(statisticalProfit.getOct().getIncome()+""));
        	HSSFCell cell112 = getCell(sheet, i*3+2, 11);
        	cell112.setCellValue(Double.parseDouble(statisticalProfit.getNov().getIncome()+""));
        	HSSFCell cell113 = getCell(sheet, i*3+2, 12);
        	cell113.setCellValue(Double.parseDouble(statisticalProfit.getDec().getIncome()+""));
        	HSSFCell cell114 = getCell(sheet, i*3+2, 13);
        	cell114.setCellValue(Double.parseDouble(statisticalProfit.getTotal().getIncome()+""));
        	
        	HSSFCell cell21 = getCell(sheet, i*3+3, 0);
        	String str = statisticalProfit.getChildAccDept();
        	if(str.equals("100")){
        		str="GrandTotal($)";
        	}else{
        		str=statisticalProfit.getChildAccDeptName();
        	}
        	setText(cell21, str);
        	HSSFCell cell22 = getCell(sheet, i*3+3, 1);
        	cell22.setCellValue(Double.parseDouble(statisticalProfit.getJan().getCost()+""));
        	HSSFCell cell23 = getCell(sheet, i*3+3, 2);
        	cell23.setCellValue(Double.parseDouble(statisticalProfit.getFeb().getCost()+""));
        	HSSFCell cell24 = getCell(sheet, i*3+3, 3);
        	cell24.setCellValue(Double.parseDouble(statisticalProfit.getMar().getCost()+""));
        	HSSFCell cell25 = getCell(sheet, i*3+3, 4);
        	cell25.setCellValue(Double.parseDouble(statisticalProfit.getApr().getCost()+""));
        	HSSFCell cell26 = getCell(sheet, i*3+3, 5);
        	cell26.setCellValue(Double.parseDouble(statisticalProfit.getMay().getCost()+""));
        	HSSFCell cell27 = getCell(sheet, i*3+3, 6);
        	cell27.setCellValue(Double.parseDouble(statisticalProfit.getJun().getCost()+""));
        	HSSFCell cell28 = getCell(sheet, i*3+3, 7);
        	cell28.setCellValue(Double.parseDouble(statisticalProfit.getJul().getCost()+""));
        	HSSFCell cell29 = getCell(sheet, i*3+3, 8);
        	cell29.setCellValue(Double.parseDouble(statisticalProfit.getAug().getCost()+""));
        	HSSFCell cell210 = getCell(sheet, i*3+3, 9);
        	cell210.setCellValue(Double.parseDouble(statisticalProfit.getSep().getCost()+""));
        	HSSFCell cell211 = getCell(sheet, i*3+3, 10);
        	cell211.setCellValue(Double.parseDouble(statisticalProfit.getOct().getCost()+""));
        	HSSFCell cell212 = getCell(sheet, i*3+3, 11);
        	cell212.setCellValue(Double.parseDouble(statisticalProfit.getNov().getCost()+""));
        	HSSFCell cell213 = getCell(sheet, i*3+3, 12);
        	cell213.setCellValue(Double.parseDouble(statisticalProfit.getDec().getCost()+""));
        	HSSFCell cell214 = getCell(sheet, i*3+3, 13);
        	cell214.setCellValue(Double.parseDouble(statisticalProfit.getTotal().getCost()+""));
        	
        	HSSFCell cell31 = getCell(sheet, i*3+4, 0);
        	setText(cell31, "");
        	HSSFCell cell32 = getCell(sheet, i*3+4, 1);
        	cell32.setCellValue(Double.parseDouble(statisticalProfit.getJan().getProfit()+""));
        	HSSFCell cell33 = getCell(sheet, i*3+4, 2);
        	cell33.setCellValue(Double.parseDouble(statisticalProfit.getFeb().getProfit()+""));
        	HSSFCell cell34 = getCell(sheet, i*3+4, 3);
        	cell34.setCellValue(Double.parseDouble(statisticalProfit.getMar().getProfit()+""));
        	HSSFCell cell35 = getCell(sheet, i*3+4, 4);
        	cell35.setCellValue(Double.parseDouble(statisticalProfit.getApr().getProfit()+""));
        	HSSFCell cell36 = getCell(sheet, i*3+4, 5);
        	cell36.setCellValue(Double.parseDouble(statisticalProfit.getMay().getProfit()+""));
        	HSSFCell cell37 = getCell(sheet, i*3+4, 6);
        	cell37.setCellValue(Double.parseDouble(statisticalProfit.getJun().getProfit()+""));
        	HSSFCell cell38 = getCell(sheet, i*3+4, 7);
        	cell38.setCellValue(Double.parseDouble(statisticalProfit.getJul().getProfit()+""));
        	HSSFCell cell39 = getCell(sheet, i*3+4, 8);
        	cell39.setCellValue(Double.parseDouble(statisticalProfit.getAug().getProfit()+""));
        	HSSFCell cell310 = getCell(sheet, i*3+4, 9);
        	cell310.setCellValue(Double.parseDouble(statisticalProfit.getSep().getProfit()+""));
        	HSSFCell cell311 = getCell(sheet, i*3+4, 10);
        	cell311.setCellValue(Double.parseDouble(statisticalProfit.getOct().getProfit()+""));
        	HSSFCell cell312 = getCell(sheet, i*3+4, 11);
        	cell312.setCellValue(Double.parseDouble(statisticalProfit.getNov().getProfit()+""));
        	HSSFCell cell313 = getCell(sheet, i*3+4, 12);
        	cell313.setCellValue(Double.parseDouble(statisticalProfit.getDec().getProfit()+""));
        	HSSFCell cell314 = getCell(sheet, i*3+4, 13);
        	cell314.setCellValue(Double.parseDouble(statisticalProfit.getTotal().getProfit()+""));
        }
	}

}
