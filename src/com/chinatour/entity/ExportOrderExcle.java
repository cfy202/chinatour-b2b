package com.chinatour.entity;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.chinatour.vo.TourOrderListVO;
import com.fasterxml.jackson.annotation.JsonProperty;
@Data
@EqualsAndHashCode(callSuper=false)
public class ExportOrderExcle extends AbstractExcelView  {
	
	@JsonProperty
	private String[] excleTittle = new String[]{"BOOKING NO.","TOUR CODE","TOUR NAME","TOUR DATE","PAX","STATUS"};
	
	@JsonProperty
	private List<TourOrderListVO> tourOrderListVOs = new ArrayList<TourOrderListVO>();
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String excelName = "orderForVenderInfo.xls";  
        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
        response.setContentType("APPLICATION/OCTET-STREAM");  
        response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(excelName, "UTF-8"));    
        //创建excle表
        HSSFSheet sheet = workbook.createSheet("orderList");
        sheet.setDefaultColumnWidth(15);
        //设置表头字体
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short)12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        //设置表头样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        //titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        //titleStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
        titleStyle.setFont(font);
       
        //创建表头
        HSSFRow row1 = sheet.createRow(1);
        row1.setHeight((short)(3*200));
        for(int i=0;i<excleTittle.length;i++){
        	HSSFCell cell = row1.createCell(i);    
	        setText(cell, excleTittle[i]);
	        cell.setCellStyle(titleStyle);
        }
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
       for(int i=0;i<tourOrderListVOs.size();i++){
        	TourOrderListVO tourOrderListVO = tourOrderListVOs.get(i);
        	HSSFCell cell0 = getCell(sheet, i+2, 0);    
	        setText(cell0, tourOrderListVO.getOrderNo());
	        HSSFCell cell1 = getCell(sheet, i+2, 1);    
	        setText(cell1,tourOrderListVO.getTourCode());
	        HSSFCell cell2 = getCell(sheet, i+2, 2);    
	        setText(cell2,tourOrderListVO.getLineName());
	        HSSFCell cell3 = getCell(sheet, i+2, 3);    
	        setText(cell3,simpleDateFormat.format(tourOrderListVO.getScheduleOfArriveTime()));
	        HSSFCell cell4 = getCell(sheet, i+2, 4);
	        setText(cell4,Integer.toString(tourOrderListVO.getTotalPeople()));
	        String status = tourOrderListVO.getState();
	        if(status.equals("0")){
				 status="NEW";
			}else if(status.equals("2")){
				status="COMPOSED";
			}else if(status.equals("3")){
				status="UPDATE";
			}else if(status.equals("4")){
				 status="CACELLING";
			}else if(status.equals("5")){
				status="CANCELLED";
			}else if(status.equals("6")){
				 status="CANCELLED";
			}else if(status.equals("7")){
				 status="RECOVERING";
			}
	        HSSFCell cell10 = getCell(sheet, i+2, 5);
	        setText(cell10,status);
        }
		
	}

}
