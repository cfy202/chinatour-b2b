package com.chinatour.entity;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class InvoiceAndCreditExcle extends AbstractExcelView {
	@JsonProperty
	private String[] excleTittle = new String[]{"业务编码","汇率","金额","Dollar","记录月份","记录类型","团号","BillTo","审核摘要","记录摘要","状态"};
	@JsonProperty
	private List<InvoiceAndCredit> invoiceAndCredits = new ArrayList<InvoiceAndCredit>();
	@JsonProperty
	private String deptName = null;
	@JsonProperty
	private InvoiceAndCredit invoiceAndCreditSum = new InvoiceAndCredit();
	
	
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
	        for(int i=0;i<invoiceAndCredits.size();i++){
	        	InvoiceAndCredit invoiceAndCredit = invoiceAndCredits.get(i);
	        	HSSFCell cell0 = getCell(sheet, i+2, 0);    
		        setText(cell0, invoiceAndCredit.getPrefix()+"-"+invoiceAndCredit.getBusinessNo());
		        HSSFCell cell1 = getCell(sheet, i+2, 1);    
		        setText(cell1,invoiceAndCredit.getExchangeRate()==null?"":invoiceAndCredit.getExchangeRate().toString() );
		        
		        BigDecimal enterCurrency=new BigDecimal(0.00);
		        if(invoiceAndCredit.getRecordType().equals("INVOICE")){
		        	enterCurrency=invoiceAndCredit.getEnterCurrency();
		        }else{
		        	enterCurrency=enterCurrency.subtract(invoiceAndCredit.getEnterCurrency());
		        }
		        HSSFCell cell2 = getCell(sheet, i+2, 2);    
		        cell2.setCellValue(invoiceAndCredit.getEnterCurrency()==null?0:Double.parseDouble(enterCurrency+""));
		        
		        BigDecimal dollar=new BigDecimal(0.00);
		        if(invoiceAndCredit.getRecordType().equals("INVOICE")){
		        	dollar=invoiceAndCredit.getDollar();
		        }else{
		        	dollar=dollar.subtract(invoiceAndCredit.getDollar());
		        }
		        HSSFCell cell3 = getCell(sheet, i+2, 3);  
		        cell3.setCellValue(invoiceAndCredit.getDollar()==null?0:Double.parseDouble(dollar+""));
		        HSSFCell cell4 = getCell(sheet, i+2, 4);
		        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
		        setText(cell4,simpleDateFormat.format(invoiceAndCredit.getMonth()));
		        HSSFCell cell5 = getCell(sheet, i+2, 5);
		        setText(cell5,invoiceAndCredit.getRecordType());
		        HSSFCell cell6 = getCell(sheet, i+2, 6);
		        setText(cell6,invoiceAndCredit.getTourCode());
		        HSSFCell cell7 = getCell(sheet, i+2, 7);
		        setText(cell7,invoiceAndCredit.getBillToReceiver());
		        HSSFCell cell8 = getCell(sheet, i+2, 8);
		        setText(cell8,invoiceAndCredit.getConfirmRemarks());
		        HSSFCell cell9 = getCell(sheet, i+2, 9);
		        setText(cell9,invoiceAndCredit.getRemarks());
		        String confirmStatus = invoiceAndCredit.getConfirmStatus();
		        if(confirmStatus.equals("NEW")){
		        	confirmStatus=("未审核");
		        }else if(confirmStatus=="NEWAUTO"){
		        	confirmStatus=("未审核");
		        }else if(confirmStatus=="CONFIRM"){
		        	confirmStatus = "审核通过";
		        }else if(confirmStatus.equals("CONFIRMAUTO")){
		        	confirmStatus = "审核通过";
		        }else if(confirmStatus.equals("CONFIRMSEND")){
		        	confirmStatus = "审核通过";
		        }else if(confirmStatus.equals("REJECT")){
		        	confirmStatus = "不通过";
		        }
		        HSSFCell cell10 = getCell(sheet, i+2, 10);
		        setText(cell10,confirmStatus);
	        }
	        
	        HSSFRow row = sheet.createRow(invoiceAndCredits.size()+2);
	        row.setHeight((short)(3*150));
	        HSSFCell cell00 = row.createCell(0);    
	        setText(cell00, "Total");
	        cell00.setCellStyle(titleStyle);
	        
	        BigDecimal enterCurrencySum=new BigDecimal(0.00);
	        enterCurrencySum=invoiceAndCreditSum.getEnterCurrency();
	        HSSFCell cell02 = row.createCell(2);    
	        //setText(cell02, invoiceAndCreditSum.getEnterCurrency().setScale(2).toString());
	        cell02.setCellValue(invoiceAndCreditSum.getEnterCurrency()==null?0:Double.parseDouble(enterCurrencySum+""));
	        cell02.setCellStyle(titleStyle);
	        
	        BigDecimal dollarSum=new BigDecimal(0.00);
	        dollarSum=invoiceAndCreditSum.getDollar();
	        HSSFCell cell03 = row.createCell(3);    
	        //setText(cell03, invoiceAndCreditSum.getDollar().setScale(2).toString());
	        cell03.setCellValue(invoiceAndCreditSum.getDollar()==null?0:Double.parseDouble(dollarSum+""));
	        cell03.setCellStyle(titleStyle);
		
	}

}
