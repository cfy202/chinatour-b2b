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
public class CustomerSheetExcle extends AbstractExcelView {
	@JsonProperty
	private String[] excleTittle = new String[]{"Pax","No.","Tour Code","Last/First  Middle Name","Gender","Date of Birth","Nationality","Passport No.","Passport Expire Date","Language","Room","Room No","Agent","Fight(Arrival)","Fight(Departure)","Requirement","Remark"};
	@JsonProperty
	private Order order = new Order();
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
	        sheet.setDefaultColumnWidth(17);
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
	        HSSFRow row1 = sheet.createRow(0);
	        row1.setHeight((short)(3*200));
	        for(int i=0;i<excleTittle.length;i++){
	        	HSSFCell cell = row1.createCell(i);    
		        setText(cell, excleTittle[i]);
		        cell.setCellStyle(titleStyle);
	        }
	        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
	        int i=1;
	    	for (Customer cus : order.getCustomerList()) {
	    		HSSFRow rowHd=sheet.createRow(i+1);
	    		HSSFCell cell0 = rowHd.createCell(0); 
		        setText(cell0, i+"");
		        HSSFCell cell1 = rowHd.createCell(1); 
		        setText(cell1, cus.getCustomerCode());
		        HSSFCell cell2 = rowHd.createCell(2); 
		        setText(cell2, cus.getCompanyName());
		        /*HSSFCell cell3 = rowHd.createCell(3); 
		        setText(cell3, cus.getOrderNo());*/
		        HSSFCell cell3 = rowHd.createCell(3); 
		        setText(cell3, cus.getLastName()+"/ "+cus.getFirstName()+"/"+cus.getMiddleName());
		        HSSFCell cell4 = rowHd.createCell(4); 
		        setText(cell4, cus.getSex()==1?"F":"M");
		        HSSFCell cell5 = rowHd.createCell(5); 
		        setText(cell5, cus.getDateOfBirth()==null?"":simpleDateFormat.format(cus.getDateOfBirth()));
		        HSSFCell cell6 = rowHd.createCell(6); 
		        setText(cell6, cus.getNationalityOfPassport());
		        HSSFCell cell7 = rowHd.createCell(7); 
		        setText(cell7, cus.getPassportNo());
		        HSSFCell cell8 = rowHd.createCell(8); 
		        setText(cell8, cus.getExpireDateOfPassport()==null?"":simpleDateFormat.format(cus.getExpireDateOfPassport()));
		        HSSFCell cell9 = rowHd.createCell(9); 
		        setText(cell9, cus.getLanguage()==null?"":cus.getLanguage().getLanguage());
		        HSSFCell cell10 = rowHd.createCell(10); 
		        setText(cell10, cus.getGuestRoomType());
		        HSSFCell cell11 = rowHd.createCell(11); 
		        setText(cell11, cus.getRoomNumber()+"/"+cus.getOrderNo());
		        HSSFCell cell12 = rowHd.createCell(12); 
		        setText(cell12, cus.getDisplayName());
		        /*HSSFCell cell14 = rowHd.createCell(14); 
		        setText(cell14, cus.getMobile());
		        HSSFCell cell15 = rowHd.createCell(15); 
		        setText(cell15, cus.getResidency());
		        HSSFCell cell16 = rowHd.createCell(16); 
		        setText(cell16, cus.getTicketType());*/
		        HSSFCell cell13 = rowHd.createCell(13); 
		        String arrival="";
		        if(!StringUtils.isEmpty(cus.getCustomerFlightList().get(0).getFlightCode())){
		        	arrival=cus.getCustomerFlightList().get(0).getFlightCode();
		        }
		        if(!StringUtils.isEmpty(cus.getCustomerFlightList().get(0).getFlightNumber())){
		        	arrival=arrival+"/"+cus.getCustomerFlightList().get(0).getFlightNumber();
		        }
		        if(cus.getCustomerFlightList().get(0).getArriveDate()!=null){
		        	arrival=arrival+"/"+simpleDateFormat.format(cus.getCustomerFlightList().get(0).getArriveDate());
		        }
		        if(!StringUtils.isEmpty(cus.getCustomerFlightList().get(0).getArriveTime())){
		        	arrival=arrival+"/"+cus.getCustomerFlightList().get(0).getArriveTime();
		        }
		        setText(cell13, arrival);
		        HSSFCell cell14 = rowHd.createCell(14); 
		        String departure="";
		        if(!StringUtils.isEmpty(cus.getCustomerFlightList().get(1).getFlightCode())){
		        	departure=cus.getCustomerFlightList().get(1).getFlightCode();
		        }
		        if(!StringUtils.isEmpty(cus.getCustomerFlightList().get(1).getFlightNumber())){
		        	departure=departure+"/"+cus.getCustomerFlightList().get(1).getFlightNumber();
		        }
		        if(cus.getCustomerFlightList().get(1).getArriveDate()!=null){
		        	departure=departure+"/"+simpleDateFormat.format(cus.getCustomerFlightList().get(1).getArriveDate());
		        }
		        if(!StringUtils.isEmpty(cus.getCustomerFlightList().get(1).getArriveTime())){
		        	departure=departure+"/"+cus.getCustomerFlightList().get(1).getArriveTime();
		        }
		        setText(cell14, departure);
		        HSSFCell cell15 = rowHd.createCell(15); 
		        setText(cell15, cus.getPayHistoryInfo());
		        HSSFCell cell16 = rowHd.createCell(16); 
		        setText(cell16, cus.getOtherInfo());
		       /* HSSFCell cell21 = rowHd.createCell(21); 
		        setText(cell21, cus.getCarName());*/
		        i++;
	    	}
	    	
	    	/*HSSFRow r=sheet.createRow(order.getCustomerList().size()+3);
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
		    c0.setCellValue("OutOrEnter");
		    c0.setCellStyle(titleStyle);
		    c1.setCellValue("Customer Name");
		    c1.setCellStyle(titleStyle);
		    c2.setCellValue("Flight Number");
		    c2.setCellStyle(titleStyle);
		    c3.setCellValue("Airline");
		    c3.setCellStyle(titleStyle);
	 	 	c4.setCellValue("Arrive/Departure Time");
	 	 	c4.setCellStyle(titleStyle);
	 	 	c5.setCellValue("Arrive/Departure Date");
	 	 	c5.setCellStyle(titleStyle);
	 	 	c6.setCellValue("Deviation");
	 	 	c6.setCellStyle(titleStyle);
	 	 	c7.setCellValue("ifPickUp");
	 	 	c7.setCellStyle(titleStyle);
	 	 	c8.setCellValue("ifSendUp");
	 	 	c8.setCellStyle(titleStyle);
	 	 	c9.setCellValue("Agent");
	 	 	c9.setCellStyle(titleStyle);
	 	 	int a=1;
	 	 	for (CustomerFlight cfl : order.getCustomerFlightList()) {
	    		HSSFRow rowHd=sheet.createRow(order.getCustomerList().size()+3+a);
	    		HSSFCell cell0 = rowHd.createCell(0);
	    		setText(cell0, cfl.getOutOrEnter()==1?"入境":"出境");
	    		HSSFCell cell1 = rowHd.createCell(1);
	    		setText(cell1, cfl.getCustomer().getLastName()+"/ "+cfl.getCustomer().getFirstName()+"/"+cfl.getCustomer().getMiddleName());
	    		HSSFCell cell2 = rowHd.createCell(2);
	    		setText(cell2, cfl.getFlightNumber());
	    		HSSFCell cell3 = rowHd.createCell(3);
	    		setText(cell3, cfl.getFlightCode());
	    		HSSFCell cell4 = rowHd.createCell(4);
	    		setText(cell4, cfl.getArriveTime());
	    		HSSFCell cell5 = rowHd.createCell(5);
	    		setText(cell5, cfl.getArriveDate()==null?"":simpleDateFormat.format(cfl.getArriveDate()));
	    		HSSFCell cell6 = rowHd.createCell(6);
	    		setText(cell6, cfl.getRemark());
	    		HSSFCell cell7 = rowHd.createCell(7);
	    		setText(cell7, cfl.getIfPickUp()==1?"Pick-up":"");
	    		HSSFCell cell8 = rowHd.createCell(8);
	    		setText(cell8, cfl.getIfSendUp()==1?"Drop-off":"");
	    		HSSFCell cell9 = rowHd.createCell(9);
	    		setText(cell9, cfl.getUserId());
	    		a++;
	 	 	}*/
	 	 	/*HSSFRow optional = sheet.createRow(order.getCustomerList().size()+5+order.getCustomerFlightList().size());
	 	 	 	HSSFCell optionalc0=optional.createCell(0);
	 	 	 	setText(optionalc0, "No.");
	 	 	 	optionalc0.setCellStyle(titleStyle);
			    HSSFCell optionalc1=optional.createCell(1);
			    setText(optionalc1, "Order No");
			    optionalc1.setCellStyle(titleStyle);
			    HSSFCell optionalc2=optional.createCell(2);
			    setText(optionalc2, "Name");
			    optionalc2.setCellStyle(titleStyle);
			    HSSFCell optionalc3=optional.createCell(3);
			    setText(optionalc3, "Price");
			    optionalc3.setCellStyle(titleStyle);
			    HSSFCell optionalc4=optional.createCell(4);
			    setText(optionalc4, "Num");
			    optionalc4.setCellStyle(titleStyle);
			    int num=1;
			    for (ReceivableInfoOfOrder receivableInfoOfOrder:order.getReceivableInfoOfOrders()) {
			        for (OrderReceiveItem reOrder: receivableInfoOfOrder.getOrderReceiveItemList()) {
			    		HSSFRow rowHd=sheet.createRow(order.getCustomerList().size()+5+order.getCustomerFlightList().size()+num);
			    		HSSFCell cell0 = rowHd.createCell(0); 
				        setText(cell0, num+"");
			    		HSSFCell cell1 = rowHd.createCell(1); 
				        setText(cell1, receivableInfoOfOrder.getOrderNo());
				        HSSFCell cell2 = rowHd.createCell(2); 
				        setText(cell2, reOrder.getRemark());
				        HSSFCell cell3 = rowHd.createCell(3); 
				        setText(cell3, reOrder.getItemFee()+"");
				        HSSFCell cell4 = rowHd.createCell(4); 
				        setText(cell4, reOrder.getItemFeeNum()+"");
				        num++;
			        }
			    }*/
	}
}
