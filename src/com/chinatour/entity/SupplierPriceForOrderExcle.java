package com.chinatour.entity;

import java.io.OutputStream;
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
public class SupplierPriceForOrderExcle extends AbstractExcelView {
	@JsonProperty
	private String[] excleTittle = new String[]{"Date","No.","Qty","Ticket #","Air","ARC","Bill/Credit","Charge","Selling","Net","Profit","Remark","Class","DES","PNR","Agent","Card","Dept","Agency","Name"};
	@JsonProperty
	private List<SupplierPriceForOrder> airList = new ArrayList<SupplierPriceForOrder>();
	@JsonProperty
	private String deptName = null;
	@JsonProperty
	private Integer temp = 0;//判断是操作导出 还是 财务 ： 默认 财务 0  操作1
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    String excelName = "AirTicket.xls";  
	        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开  
	        response.setContentType("APPLICATION/OCTET-STREAM");  
	        response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(excelName, "UTF-8"));    
	        //创建excle表
	        HSSFSheet sheet = workbook.createSheet("list");
	        sheet.setDefaultColumnWidth(17);
	        //设置表头字体
	        HSSFFont font = workbook.createFont();
	        font.setFontHeightInPoints((short)12);
	        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        //设置表头样式
	        HSSFCellStyle titleStyle = workbook.createCellStyle();
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
    	  Integer totalPeople=0;
    	  BigDecimal chargeSum=new BigDecimal(0.00);
    	  BigDecimal sellingSum=new BigDecimal(0.00);
    	  BigDecimal netSum=new BigDecimal(0.00);
    	  BigDecimal arcSum=new BigDecimal(0.00);
    	  BigDecimal creditSum=new BigDecimal(0.00);
    	  BigDecimal profitSum=new BigDecimal(0.00);
    	  HSSFCellStyle currencyStyle = workbook.createCellStyle(); 
    	  currencyStyle.setDataFormat((short)4);
	        for(int i=0;i<airList.size();i++){
        		SupplierPriceForOrder spfo= airList.get(i);
        		HSSFRow rowHd=sheet.createRow(i+2);
        		HSSFCell cell0 = rowHd.createCell(0); 
		        setText(cell0, spfo.getDate()==null?"":simpleDateFormat.format(spfo.getDate()));
		        HSSFCell cell1 = rowHd.createCell(1); 
		        setText(cell1, spfo.getInvoiceNum());
		        HSSFCell cell2 = rowHd.createCell(2); 
		        if(spfo.getQuantity()!=null){
		        	if(temp!=0){
		        		totalPeople++;
		        		cell2.setCellValue("1");
		        	}else{
		        		totalPeople=totalPeople+spfo.getQuantity();
		        		cell2.setCellValue(Double.parseDouble(spfo.getQuantity()+""));
		        	}
		        }
	        	HSSFCell cell3 = rowHd.createCell(3); 
		        setText(cell3, spfo.getTicketNo());
		        HSSFCell cell4 =  rowHd.createCell(4);    
		        setText(cell4,spfo.getAirline());
		        HSSFCell cell5 = rowHd.createCell(5);
		        BigDecimal arc=new BigDecimal(0.00);
		        if(spfo.getTempValue06()!=null&&spfo.getTempValue06()!=""){
		        	cell5.setCellStyle(currencyStyle);  
		        	if(temp!=0){
		        		if(Double.parseDouble(spfo.getTempValue06())==0){
		        			cell5.setCellValue(0.00);
		        		}else{
		        			arc=spfo.getOperatorFee().subtract(spfo.getCharge());
		    		        cell5.setCellValue(Double.parseDouble(arc+""));
		        		}
		        	}else{
		        		arc=new BigDecimal(spfo.getTempValue06());
		        		cell5.setCellValue(Double.parseDouble(arc+""));
		        	}
		        	arcSum=arcSum.add(arc);
		        }
		        HSSFCell cell6 = rowHd.createCell(6);
		        BigDecimal credit=new BigDecimal(0.00);
		        if(spfo.getCharge()!=null||spfo.getAmount()!=null){
		        	credit=spfo.getAmount().subtract(spfo.getCharge());
		        	creditSum=creditSum.add(credit);
		        	cell6.setCellStyle(currencyStyle);  
		        	cell6.setCellValue(Double.parseDouble(credit+""));
		        }
		        HSSFCell cell7 = rowHd.createCell(7);
		        if(spfo.getCharge()!=null){
		        	chargeSum=chargeSum.add(spfo.getCharge());
		        	cell7.setCellStyle(currencyStyle);  
		        	cell7.setCellValue(Double.parseDouble(spfo.getCharge()+""));
		        }
		        HSSFCell cell8 = rowHd.createCell(8);    
		        if(spfo.getAmount()!=null){
		        	sellingSum=sellingSum.add(spfo.getAmount());
		        	cell8.setCellStyle(currencyStyle);  
		        	cell8.setCellValue(Double.parseDouble(spfo.getAmount()+""));
		        }
		        HSSFCell cell9 = rowHd.createCell(9);
		        if(spfo.getOperatorFee()!=null){
		        	netSum=netSum.add(spfo.getOperatorFee());
		        	cell9.setCellStyle(currencyStyle);  
		        	cell9.setCellValue(Double.parseDouble(spfo.getOperatorFee()+""));
		        }
		        HSSFCell cell10 = rowHd.createCell(10);
		        BigDecimal profit=spfo.getAmount().subtract(spfo.getOperatorFee());
		        profitSum=profitSum.add(profit);
		        cell10.setCellStyle(currencyStyle);  
		        cell10.setCellValue(Double.parseDouble(profit+""));
		        HSSFCell cell11 = rowHd.createCell(11);
		        setText(cell11,spfo.getRemark());
		        HSSFCell cell12 = rowHd.createCell(12);
		        setText(cell12,spfo.getTempValue04());
		        HSSFCell cell13 = rowHd.createCell(13);
		        setText(cell13,spfo.getTempValue05());
		        
		        HSSFCell cell14 = rowHd.createCell(14);
		        setText(cell14,spfo.getFlightPnr());
		        HSSFCell cell15 = rowHd.createCell(15);
		        setText(cell15,spfo.getTempValue01());
		        HSSFCell cell16 = rowHd.createCell(16);
		        setText(cell16,spfo.getCard());
		        HSSFCell cell17 = rowHd.createCell(17);
		        setText(cell17,spfo.getDeptName());
		        HSSFCell cell18 = rowHd.createCell(18);
		        setText(cell18,spfo.getVenderName());
		        HSSFCell cell19 = rowHd.createCell(19);
		        setText(cell19,spfo.getAccRemarkOfOp());
        	}
  	   HSSFRow r=sheet.createRow(airList.size()+3);
	    HSSFCell c0=r.createCell(0);
	    HSSFCell c1=r.createCell(1);
	    HSSFCell c2=r.createCell(2);
	    HSSFCell c3=r.createCell(3);
	    HSSFCell c4=r.createCell(4);
	    HSSFCell c5=r.createCell(5);
	    HSSFCell c6=r.createCell(6);
	    HSSFCell c7=r.createCell(7);
	    HSSFCell c8=r.createCell(8);
	    HSSFCell c9=r.createCell(9);
	    HSSFCell c10=r.createCell(10);
	    HSSFCell c11=r.createCell(11);
	    HSSFCell c12=r.createCell(12);
	    HSSFCell c13=r.createCell(13);
	    HSSFCell c14=r.createCell(14);
	    HSSFCell c15=r.createCell(15);
	    HSSFCell c16=r.createCell(16);
	    HSSFCell c17=r.createCell(17);
	    HSSFCell c18=r.createCell(18);
	    HSSFCell c19=r.createCell(19);
	    c0.setCellValue("Total");
	    c1.setCellValue("");
	    c2.setCellValue(Double.parseDouble(totalPeople+""));
 	 	c3.setCellValue("");
 	 	c4.setCellValue("");
 	 	c5.setCellStyle(currencyStyle);  
 		c5.setCellValue(Double.parseDouble(arcSum+""));
 		c6.setCellStyle(currencyStyle); 
 	 	c6.setCellValue(Double.parseDouble(creditSum+""));
 	 	c7.setCellStyle(currencyStyle); 
 	 	c7.setCellValue(Double.parseDouble(chargeSum+""));
 	 	c8.setCellStyle(currencyStyle); 
 	 	c8.setCellValue(Double.parseDouble(sellingSum+""));
 	 	c9.setCellStyle(currencyStyle); 
 	 	c9.setCellValue(Double.parseDouble(netSum+""));
 	 	c10.setCellStyle(currencyStyle); 
 	 	c10.setCellValue(Double.parseDouble(profitSum+""));
 	 	c11.setCellValue("");
 	 	c12.setCellValue("");
 	 	c13.setCellValue("");
 	 	c14.setCellValue("");
 	 	c15.setCellValue("");
 	 	c16.setCellValue("");
 	 	c17.setCellValue("");
 	 	c18.setCellValue("");
 	 	c19.setCellValue("");
	}
}
