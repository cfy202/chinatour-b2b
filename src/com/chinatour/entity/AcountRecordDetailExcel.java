package com.chinatour.entity;

import java.io.OutputStream;
import java.net.URLEncoder;
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
public class AcountRecordDetailExcel extends AbstractExcelView {
	
	@JsonProperty
	private String excleName = null;  //表名信息
	@JsonProperty
	private String[] tableHeader = new String[] {"Month","No.","Remarks","TourCode","Receivable Amount($)","Receivable Dollar Amount($)"};
	@JsonProperty
	private List<AccountRecord> accountRecords = new ArrayList<AccountRecord>(); //表内循环内容
	@JsonProperty
	private String excleForDept = null; //制表部门
	@JsonProperty
	private String excleForAdmin = null; //制表人
	@JsonProperty
	private String dept = null; //本部门
	@JsonProperty
	private String todept = null; //对账部门
	@JsonProperty
	private AccountRecord accountRecordYearly = new AccountRecord(); //年总额
	@JsonProperty
	private String startMonth = ""; //
	@JsonProperty
	private String endMonth = ""; //
	
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
        response.setContentType("APPLICATION/OCTET-STREAM");  
        response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(excleName, "UTF-8"));    
        //创建excle表
        HSSFSheet sheet = workbook.createSheet("list");
        sheet.setDefaultColumnWidth(15);//设置默认列宽
        //设置表头字体
        HSSFFont font = workbook.createFont();
        font.setFontHeightInPoints((short)12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        //设置表头样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        //titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        //titleStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
        titleStyle.setFont(font);
        HSSFRow row1 = sheet.createRow(1);
        row1.setHeight((short)(3*200));
        
        HSSFCell tableTit = getCell(sheet, 0, 0);    
        setText(tableTit, "本部门:"+dept+"   "+"对账部门:"+todept);
        //创建表头
        for(int i=0;i<tableHeader.length;i++){
        	HSSFCell cell = row1.createCell(i);    
	        setText(cell, tableHeader[i]);
	        cell.setCellStyle(titleStyle);
        }
        //创建表内容
	        int sMonth = 0;
	        int eMonth = 0;
	    List<AccountRecord>  accList = new ArrayList<AccountRecord>();
        if((startMonth!=null&&!startMonth.equals(""))&&(endMonth!=null&&!endMonth.equals(""))){
	        sMonth = Integer.parseInt(startMonth.substring(5, 7));
	        eMonth = Integer.parseInt(endMonth.substring(5, 7));
	        for(int i=0;i<accountRecords.size();i++){
	        	AccountRecord accountRecord = accountRecords.get(i);
	        	int month = Integer.parseInt(accountRecord.getMonth().substring(5, 7));
	        	if(sMonth!=0&&eMonth!=0&&month>=sMonth&&month<=eMonth){
	        		accList.add(accountRecord);
	        	}
	        }
        }else{
        	accList.addAll(accountRecords);
        }
        
        for(int i=0;i<accList.size();i++){
        	AccountRecord accountRecord = accList.get(i);
        		HSSFCell cell0 = getCell(sheet, i+2, 0);    
    	        setText(cell0, accountRecord.getIsData()==false?accountRecord.getLabel():accountRecord.getMonth());
    	        HSSFCell cell1 = getCell(sheet, i+2, 1);    
    	        setText(cell1, accountRecord.getIsData()==false?"":accountRecord.getBusinessName()+"-"+accountRecord.getBusinessNo());
    	        HSSFCell cell2 = getCell(sheet, i+2, 2);    
    	        setText(cell2, accountRecord.getRemarks());
    	        HSSFCell cell3 = getCell(sheet, i+2, 3);    
    	        setText(cell3, accountRecord.getTourCode());
    	        HSSFCell cell4 = getCell(sheet, i+2, 4);
    	        cell4.setCellValue(accountRecord.getReceivableCurrency()==null?0:Double.parseDouble(accountRecord.getReceivableCurrency()+""));
    	        HSSFCell cell5 = getCell(sheet, i+2, 5);    
    	        cell5.setCellValue(accountRecord.getReceivableAmount()==null?0:Double.parseDouble(accountRecord.getReceivableAmount()+""));
        }
        //创建年总额
       /* HSSFCell cell20 = getCell(sheet, accountRecords.size()+1, 0);    
        setText(cell20,"Yearly Total：");
        HSSFCell cell8 = getCell(sheet, accountRecords.size()+1, 4);    
        setText(cell8,accountRecordYearly.getReceivableCurrency().setScale(2).toString());
        HSSFCell cell9 = getCell(sheet, accountRecords.size()+1, 5);    
        setText(cell9,accountRecordYearly.getReceivableAmount().setScale(2).toString());*/
        //创建制表部门及制表人
        HSSFCell cell6 = getCell(sheet, accountRecords.size()+5, 4);    
        setText(cell6, "制表部门:"+excleForDept);
        HSSFCell cell7 = getCell(sheet, accountRecords.size()+5, 5);    
        setText(cell7, "制表人:"+excleForAdmin);
	}

}
