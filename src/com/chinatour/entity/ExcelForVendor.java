package com.chinatour.entity;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
public class ExcelForVendor<WritableCellFormat> extends AbstractExcelView {
	@JsonProperty
	private String tableTittle = "Supplier/Agencies";
	@JsonProperty
	private String[] excleTittle = new String[]{ "number","name","contactor","Suburb/City","address","State","Country","zipCode","Username","tel","fax","email","remarks"};
	@JsonProperty
	private List<Vender> VenderList = new ArrayList<Vender>();

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    String excelName = "Supplier/Agencies";  
		    
		    final String userAgent = request.getHeader("USER-AGENT");
	        try {
	            if(StringUtils.contains(userAgent, "MSIE")){//IE浏览器
	            	excelName = URLEncoder.encode(excelName,"UTF8");
	            }else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
	            	excelName = new String(excelName.getBytes(), "ISO8859-1");
	            }else{
	            	excelName = URLEncoder.encode(excelName,"UTF8");//其他浏览器
	            }
	        } catch (UnsupportedEncodingException e) {
	        }
	        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
	        response.setContentType("APPLICATION/OCTET-STREAM");  
	        response.setHeader("Content-Disposition", "attachment; filename="+ excelName);    
	        //创建excle表
	        HSSFSheet sheet = workbook.createSheet("list");
	        sheet.setDefaultColumnWidth(14);
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
	        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 14));
	        row.setHeight((short)(3*200));
	        //创建第一行第一列
	        HSSFCell cell0=row.createCell(0);
	        cell0.setCellValue(tableTittle);
	        cell0.setCellStyle(titleStyle);
	        
	        //创建表头
	        HSSFRow row1 = sheet.createRow(1);
	        row1.setHeight((short)(3*200));
	        for(int i=0;i<excleTittle.length;i++){
	        	HSSFCell cell = row1.createCell(i);    
		        setText(cell, excleTittle[i]);
		        cell.setCellStyle(titleStyle);
	        }
 
    	  HSSFCellStyle currencyStyle = workbook.createCellStyle(); 
    	  currencyStyle.setDataFormat((short)4);
	        for(int i=0;i<VenderList.size();i++){
	        	Vender spfo= VenderList.get(i);
        		HSSFRow rowHd=sheet.createRow(i+2);
        		HSSFCell cell1 = rowHd.createCell(0); 
	        	setText (cell1,i+1+"");
 
	        	HSSFCell cell2 = rowHd.createCell(1); 
	        	setText (cell2,spfo.getName());
	        	HSSFCell cell3 = rowHd.createCell(2);
	        	setText (cell3,spfo.getContactor());

	        	HSSFCell cell4 = rowHd.createCell(3);
	        	setText (cell4,spfo.getCityId());
	        	HSSFCell cell5 = rowHd.createCell(4);
	        	setText (cell5,spfo.getAddress().toString());
	        	
	        	HSSFCell cell6 = rowHd.createCell(5);
	        	setText (cell6,spfo.getStateId());
	        	HSSFCell cell7 = rowHd.createCell(6); 
	        	setText (cell7,spfo.getCountryName());
	        	
	        	HSSFCell cell8 = rowHd.createCell(7);
		        setText(cell8, spfo.getZipCode());
	        	HSSFCell cell9 = rowHd.createCell(8); 
	        	setText (cell9,spfo.getUserName());
	        	HSSFCell cell10 = rowHd.createCell(9);
	        	setText (cell10,spfo.getTel()+"");
	        	HSSFCell cell11 = rowHd.createCell(10); 
	        	setText (cell11,spfo.getFax());
	        	HSSFCell cell12 = rowHd.createCell(11);
	        	setText (cell12,spfo.getEmail()+"");
	        	HSSFCell cell13 = rowHd.createCell(13); 
	        	setText (cell13,spfo.getRemarks());

		     
	}
}

}

