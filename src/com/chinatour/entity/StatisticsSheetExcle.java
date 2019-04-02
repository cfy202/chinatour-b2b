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
public class StatisticsSheetExcle extends AbstractExcelView {
	@JsonProperty
	private String[] excleTittle = new String[]{"NO.","Tour Code","Grand Total","Booking No.","Agent","Arrival Date","Settlement Date","Total Passenger","Amount","Income","Cost","Profit","5%Profit","Balance Profit"};
	@JsonProperty
	private List<Order> orderList = new ArrayList<Order>();
	@JsonProperty
	private String deptName = null;
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    String excelName = "StatisticsSheet.xls";  
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
	        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
	        
	        int begin=2;
	    	int end=2;
        //保存团号
    	HashSet<String> tourIdStrings = new HashSet<String>();
    	  for(Order o:orderList){
    		  tourIdStrings.add(o.getTourCode());
    	  }
    	  BigDecimal grandSum=new BigDecimal(0.00);
    	  Integer totalPeople=0;
    	  BigDecimal amountSum=new BigDecimal(0.00);
    	  BigDecimal incomeSum=new BigDecimal(0.00);
    	  BigDecimal costSum=new BigDecimal(0.00);
    	  BigDecimal profigSum=new BigDecimal(0.00);
    	  BigDecimal Sum5=new BigDecimal(0.00);
  		if(tourIdStrings!=null&&tourIdStrings.size()!=0){
		 Iterator<String> it=tourIdStrings.iterator();
		 int tt=0;
		 while(it.hasNext()){
			//tourIdString	团id
			String tourIdString=it.next();
			BigDecimal sum=new BigDecimal(0.00);
    		Integer num=0;
    		tt++;
	        for(int i=0;i<orderList.size();i++){
	        	Order ord= orderList.get(i);
	        	if(tourIdString.equalsIgnoreCase(ord.getTourCode())){
	        		HSSFRow rowHd=sheet.createRow(begin+num);
	        		rowHd.createCell(0);
	        		rowHd.createCell(1);
			    	rowHd.createCell(2);
		        	HSSFCell cell3 = rowHd.createCell(3); 
			        setText(cell3, ord.getOrderNo());
			        HSSFCell cell4 =  rowHd.createCell(4);    
			        setText(cell4,ord.getUserName());
			        HSSFCell cell5 = rowHd.createCell(5);    
			        setText(cell5,ord.getArriveDateTime()==null?"":simpleDateFormat.format(ord.getArriveDateTime()));
			        HSSFCell cell6 = rowHd.createCell(6);    
			        setText(cell6,ord.getCheckTime()==null?"":simpleDateFormat.format(ord.getCheckTime()));
			        HSSFCell cell7 = rowHd.createCell(7);
			        if(ord.getTotalPeople()!=null){
			        	totalPeople=totalPeople+ord.getTotalPeople();
			        	cell7.setCellValue(Double.parseDouble(ord.getTotalPeople()+""));
			        }
			        HSSFCell cell8 = rowHd.createCell(8);
			        if(ord.getCommonTourFee()!=null){
		        	   amountSum=amountSum.add(ord.getCommonTourFee());
		        	   cell8.setCellValue(Double.parseDouble(ord.getCommonTourFee()+""));
			        }
			        HSSFCell cell9 = rowHd.createCell(9);
			        if(ord.getPay()!=null){
			        	incomeSum=incomeSum.add(ord.getPay());
			        	 cell9.setCellValue(Double.parseDouble(ord.getPay()+""));
			        }
			        HSSFCell cell10 = rowHd.createCell(10);
			        if(ord.getCost()!=null){
			        	costSum=costSum.add(ord.getCost());
			        	cell10.setCellValue(Double.parseDouble(ord.getCost()+""));
			        }
			        HSSFCell cell11 = rowHd.createCell(11);
			        BigDecimal b=ord.getPay().subtract(ord.getCost());
			        profigSum=profigSum.add(b);
			        cell11.setCellValue(Double.parseDouble(b+""));
			        HSSFCell cell12 = rowHd.createCell(12);
			        HSSFCell cell13 = rowHd.createCell(13);
			        if(ord.getOrderType()==null||ord.getOrderType()!=5){
			        	if(ord.getState()!=5&&ord.getPriceExpression()!=null){
			        		cell12.setCellValue(Double.parseDouble(b.multiply(ord.getPriceExpression())+""));
			        		cell13.setCellValue(Double.parseDouble(b.subtract(b.multiply(ord.getPriceExpression()))+""));
			        		if(b!=null){
			        			Sum5=Sum5.add(b.multiply(ord.getPriceExpression()));
			        			sum=sum.add(b.subtract(b.multiply(ord.getPriceExpression())));
			        		}
			        	}else{
			        		cell12.setCellValue(Double.parseDouble("0.00"));
			        		if(b!=null){
			        			cell13.setCellValue(Double.parseDouble(b+""));
			        			sum=sum.add(b);
			        		}
			        	}
			        }
			        num++;
	        	}
	        }
    		end = begin + num - 1;
			
		    if(begin<=end){
		    	sheet.addMergedRegion(new CellRangeAddress(begin, end, 0, 0));
		    	sheet.addMergedRegion(new CellRangeAddress(begin, end, 1, 1));
		    	sheet.addMergedRegion(new CellRangeAddress(begin, end, 2, 2));
				HSSFRow rowHd = sheet.getRow(begin);
				HSSFCell celHad0 = rowHd.getCell(0);
				HSSFCell celHad1 = rowHd.getCell(1);
				HSSFCell celHad2 = rowHd.getCell(2);
				celHad0.setCellValue(tt);
				celHad1.setCellValue(tourIdString);
				celHad2.setCellValue(Double.parseDouble(sum+""));
				grandSum=grandSum.add(sum);
		    }
		   
		    begin = begin + num;
		}
  		}
  	   HSSFRow r=sheet.createRow(orderList.size()+3);
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
	    c0.setCellValue("Total");
	    c1.setCellValue("");
	    c2.setCellValue(Double.parseDouble(grandSum+""));
 	 	c3.setCellValue("");
 	 	c4.setCellValue("");
 	 	c5.setCellValue("");
 	 	c6.setCellValue("");
 	 	c7.setCellValue(Double.parseDouble(totalPeople+""));
 	 	c8.setCellValue(Double.parseDouble(amountSum+""));
 	 	c9.setCellValue(Double.parseDouble(incomeSum+""));
 	 	c10.setCellValue(Double.parseDouble(costSum+""));
 	 	c11.setCellValue(Double.parseDouble(profigSum+""));
 	 	c12.setCellValue(Double.parseDouble(Sum5+""));
 	 	c13.setCellValue(Double.parseDouble(grandSum+""));
	}
}
