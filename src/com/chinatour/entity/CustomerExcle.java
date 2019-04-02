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
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.fasterxml.jackson.annotation.JsonProperty;
@Data
@EqualsAndHashCode(callSuper=false)
public class CustomerExcle extends AbstractExcelView {
	@JsonProperty
	private List<Customer> customerList = new ArrayList<Customer>();
	
	@JsonProperty
	private String[] tableHeader = new String[] {"LastName","FirstName","MiddleName","性别","国籍","E-mail","Tel","护照号","护照有效期"};
	@JsonProperty
	private String tableTittle = "Customer Information";
	
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String excelName = "customerInfo.xls";  
        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
        response.setContentType("APPLICATION/OCTET-STREAM");  
        response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(excelName, "UTF-8"));    
        //创建excle表
        HSSFSheet sheet = workbook.createSheet("list");
        sheet.setDefaultColumnWidth(13);
        //设置表头字体
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short)12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        //设置表头样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);
        //创建第一行
        HSSFRow row = null;
         row = sheet.createRow(0);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 8));
        row.setHeight((short)(3*200));
        //创建第一行第一列
        HSSFCell cell11=row.createCell(0);
        cell11.setCellValue(tableTittle);
        cell11.setCellStyle(titleStyle);
      
        //创建表头
        row = sheet.createRow(1);
        for(int i=0;i<9;i++){
        	HSSFCell cell = row.createCell(i);
        	setText(cell, tableHeader[i]);
        	cell.setCellStyle(titleStyle);
        }
        
        //创建客人信息
        for(int i=0;i<customerList.size();i++){
        	if(i>65500){
        		break;
        	}
        	 row = sheet.createRow(i+2);
			 HSSFCell cell1 = row.createCell(0);
			 setText(cell1, customerList.get(i).getLastName());
			 HSSFCell cell2 = row.createCell(1);
			 setText(cell2, customerList.get(i).getFirstName());
			 HSSFCell cell3 = row.createCell(2);
			 setText(cell3, customerList.get(i).getMiddleName());
			 HSSFCell cell4 = row.createCell(3);
			 String sex = "";
			 if( customerList.get(i).getSex()==1){
				 sex="F"; 
			 }else if(customerList.get(i).getSex()==2){
				 sex="M"; 
			 }
			 setText(cell4,sex);
			 HSSFCell cell5 = row.createCell(4);
			 setText(cell5, customerList.get(i).getNationalityOfPassport());
			 HSSFCell cell6 = row.createCell(5);
			 setText(cell6, customerList.get(i).getEmail());
			 HSSFCell cell7 = row.createCell(6);
			 setText(cell7, customerList.get(i).getTel());
			 HSSFCell cell8 = row.createCell(7);
			 setText(cell8, customerList.get(i).getPassportNo());
			 HSSFCell cell9 = row.createCell(8);
			 SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
			 String date = "";
			 if(customerList.get(i).getExpireDateOfPassport()!=null){
				 date = simpleDateFormat.format(customerList.get(i).getExpireDateOfPassport());
			 }
			 setText(cell9, date);
        }
		
	}

}
