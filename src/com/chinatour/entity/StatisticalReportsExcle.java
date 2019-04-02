package com.chinatour.entity;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatisticalReportsExcle extends AbstractExcelView {
	@JsonProperty
	private String[] excleTittleMonth = new String[]{"Year","Brand","Office.","Agent","Agency","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","Total"};
	@JsonProperty
	private String[] excleTittleWeek = new String[]{"Year","Brand","Office.","Agent","Agency","-5 W.","-4 W.","-3 W.","-2 W.","-1 W.","0 W.","1 W.","2 W.","3 W.","4 W.","5 W.","Total"};
	@JsonProperty
	private List<Statistical> statisticalList = new ArrayList<Statistical>();
	@JsonProperty
	private int type;
	@JsonProperty
	private Statistical statistical;
	@JsonProperty
	private List<Dept> deptList = new ArrayList<Dept>();
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    String excelName = "StatisticalReport.xls";  
	        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
	        response.setContentType("APPLICATION/OCTET-STREAM");  
	        response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(excelName, "UTF-8"));    
	        //创建excle表
	        HSSFSheet sheet = workbook.createSheet("Statistical Report");
	        sheet.setDefaultColumnWidth(15);
	        //设置表头字体
	        HSSFFont font = workbook.createFont();
	        font.setFontHeightInPoints((short)12);
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        //设置表头样式
	        HSSFCellStyle titleStyle = workbook.createCellStyle();
	        titleStyle.setFont(font);
	        
	        HSSFRow rowT = null;
	         rowT = sheet.createRow(0);
	        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 17));
	        rowT.setHeight((short)(3*200));
	        //创建第一行第一列
	        HSSFCell cell11=rowT.createCell(0);
	        cell11.setCellValue("Statistical Report");
	        cell11.setCellStyle(titleStyle);
	       
	        //创建表头
	        HSSFRow row1 = sheet.createRow(1);
	        row1.setHeight((short)(3*200));
	        if(type==0){
	        	for(int i=0;i<excleTittleMonth.length;i++){
		        	HSSFCell cell = row1.createCell(i);    
			        setText(cell, excleTittleMonth[i]);
			        cell.setCellStyle(titleStyle);
		        }
	        }else{
	        	for(int i=0;i<excleTittleWeek.length;i++){
		        	HSSFCell cell = row1.createCell(i);    
			        setText(cell, excleTittleWeek[i]);
			        cell.setCellStyle(titleStyle);
		        }
	        }
	        
	        for(int n=0;n<Integer.parseInt(statistical.getDate())-Integer.parseInt(statistical.getTime())+1;n++){
	        	int d=deptList.size();
        		for(int i=n*d;i<d*(n+1);i++){
			    	HSSFRow row=sheet.createRow(i+2);
			    	row.createCell(2).setCellValue(deptList.get(i%d).getDeptName());
			    	Double sum=0.0;
			    	for(Statistical s:statisticalList){
   						 if(s.getDeptId().equals(deptList.get(i%d).getDeptId())&&Integer.parseInt(statistical.getTime())+n==Integer.parseInt(s.getDate())){
   							
   					    	row.createCell(0).setCellValue(s.getDate());  
   					    	row.createCell(1).setCellValue(s.getBrand());
   					    	row.createCell(3).setCellValue(s.getAgent());
   					    	row.createCell(4).setCellValue(s.getVenderName());
   					    	for(int j=1;j<13;j++){
   							 if(Integer.parseInt(s.getTime().substring(5))==j){
   								 HSSFCell cell3 = row.createCell(4+j);
   								 cell3.setCellValue(Double.parseDouble(s.getSum()+""));
   								 sum=sum+Double.parseDouble(s.getSum()+"");
   							 }
   					    	}
   					    	HSSFCell cell3 = row.createCell(17);
   					    	cell3.setCellValue(sum);
   						 }
			    		
	   				 }
				    	
			    }
	        	CellRangeAddress region=new CellRangeAddress(n*d+2, d*(n+1)+1, 0, 0);
	        	sheet.addMergedRegion(region);
			    	
	        } 
	}
}
