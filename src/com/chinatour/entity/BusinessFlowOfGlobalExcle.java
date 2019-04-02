package com.chinatour.entity;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.GroupLayout.Alignment;

import lombok.Data;
import lombok.EqualsAndHashCode;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.chinatour.persistence.AccountSubjectMapper;
import com.fasterxml.jackson.annotation.JsonProperty;
@Data
@EqualsAndHashCode(callSuper=false)
public class BusinessFlowOfGlobalExcle  extends AbstractExcelView{
	@Autowired
	private AccountSubjectMapper accountSubjectMapper;
	@JsonProperty
	private String tableTittle = "CTS - Los Angeles Monthly Profit & Loss 文景假期月报表";
	private String datastr="2019";
	@JsonProperty
	private String tittle1 = datastr+"- Net Income Summary ( Jan.- Dec. )";
	@JsonProperty
	private String tittle2 = datastr+"- Net Cost & Expense Summary ( Jan.- Dec. )";
	@JsonProperty
	private String tittle3 = datastr+"- Sales Income Summary ( Jan.- Dec. )";
	@JsonProperty
	private String tittle4 = datastr+"- Tour Cost & Expense Summary ( Jan.- Dec. )";
	@JsonProperty
	private String[] tableHeader1 = new String[] {"Gross Profit","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","Total","Percent"};
	private String[] tableHeader2 = new String[] {"Expense","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","Total","Percent"};
	private String[] tableHeader3 = new String[] {"Sales Income","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","Total","Percent"};
	private String[] tableHeader4 = new String[] {"Tour Cost","Jan.","Feb.","Mar.","Apr.","May.","June.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.","Total","Percent"};
	@JsonProperty
	private List<BusinessFlow> businessFlows = new ArrayList<BusinessFlow>();
	@JsonProperty
	private List<AccountSubject> accountSubjects = new ArrayList<AccountSubject>();
	@JsonProperty
	private List<AccountSubject> accountSubjectListForIncome = new ArrayList<AccountSubject>();
	@JsonProperty
	private List<AccountSubject> accountSubjectListForCost = new ArrayList<AccountSubject>();
	@JsonProperty
	private List<AccountSubject> accountSubjectListForSalesIncome = new ArrayList<AccountSubject>();
	@JsonProperty
	private List<AccountSubject> accountSubjectListForTourCost = new ArrayList<AccountSubject>();
	@JsonProperty
	private int rowsForIncome = 0;
	@JsonProperty
	private List<BusinessFlow> totalMonthlyForIncome = new ArrayList<BusinessFlow>(); 
	@JsonProperty
	private List<BusinessFlow> totalMonthlyForCost = new ArrayList<BusinessFlow>();
	@JsonProperty
	private List<BusinessFlow> totalMonthlyForSalesIncome = new ArrayList<BusinessFlow>(); 
	@JsonProperty
	private List<BusinessFlow> totalMonthlyForTourCost = new ArrayList<BusinessFlow>();
	@JsonProperty
	private List<BusinessFlow> totalMonthlyForProfit = new ArrayList<BusinessFlow>();
	@JsonProperty
	private BigDecimal totalYearForIncome = new BigDecimal(0.00);
	@JsonProperty
	private BigDecimal totalYearForCost = new BigDecimal(0.00);
	@JsonProperty
	private BigDecimal totalYearForSalesIncome = new BigDecimal(0.00);
	@JsonProperty
	private BigDecimal totalYearForTourCost = new BigDecimal(0.00);
	
	
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		    String excelName = "financialReport.xls";  
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
	        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	        titleStyle.setFont(font);
	        //创建第一行
	        HSSFRow row = null;
	         row = sheet.createRow(0);
	        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 17));
	        row.setHeight((short)(3*200));
	        //创建第一行第一列
	        HSSFCell cell11=row.createCell(0);
	        cell11.setCellValue(tableTittle);
	        cell11.setCellStyle(titleStyle);
	        //创建第二行
	        row = sheet.createRow(1);
	        row.setHeight((short)(3*160));
	        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 17));
	        HSSFCell cell21=row.createCell(0);
	        cell21.setCellValue(tittle3);
	        cell21.setCellStyle(titleStyle);
	        //创建第三行
	        row = sheet.createRow(2);
	        for(int i=0;i<18;i++){
	        	HSSFCell cell = row.createCell(i);
	        	if(i==0){
	        		sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 3));
	        		setText(cell, tableHeader3[i]);
	        		cell.setCellStyle(titleStyle);
	        		i=3;
	        	}else{
		        	setText(cell, tableHeader3[i-3]);
		        	cell.setCellStyle(titleStyle);
	        	}
	        }
	        //创建Sales Income数据
	        for(int i=0;i<accountSubjectListForSalesIncome.size();i++){
	        	if(accountSubjectListForSalesIncome.get(i).getSubjectType()==3){
	        		if(accountSubjectListForSalesIncome.get(i).getHasChild()==0&&accountSubjectListForSalesIncome.get(i).getBusinessFlowList().size()>0){
	        			int col = accountSubjectListForSalesIncome.get(i).getLevel()-1;
	        			 row = sheet.createRow(i+3);
	        			 HSSFCell cell1 = row.createCell(col);
	        			 setText(cell1, accountSubjectListForSalesIncome.get(i).getSubjectCode());
	        			 HSSFCell cell2 = row.createCell(col+1);
	        			 setText(cell2, accountSubjectListForSalesIncome.get(i).getSubjectName());
	        			 
	        				 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForSalesIncome.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 cell3.setCellValue(accountSubjectListForSalesIncome.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForSalesIncome.get(i).getTotalYearly()+""));
		        			 HSSFCell cell4 = row.createCell(17);
		        			 setText(cell4, accountSubjectListForSalesIncome.get(i).getPercentYearly()); 
	        			 }else if(accountSubjectListForSalesIncome.get(i).getHasChild()==1){
	        				 int col = accountSubjectListForSalesIncome.get(i).getLevel()-1;
		        			 row = sheet.createRow(i+3);
		        			 HSSFCell cell1 = row.createCell(col);
		        			 setText(cell1, accountSubjectListForSalesIncome.get(i).getSubjectCode());
		        			 HSSFCell cell2 = row.createCell(col+1);
		        			 setText(cell2, accountSubjectListForSalesIncome.get(i).getSubjectName());
		        			 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForSalesIncome.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 HSSFCell cell4 = row.createCell(17);
	        				 if(accountSubjectListForSalesIncome.get(i).getTotalYearly().compareTo(new BigDecimal(0.00))!=0){
	        					 cell3.setCellValue(accountSubjectListForSalesIncome.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForSalesIncome.get(i).getTotalYearly()+""));
			        			 setText(cell4, accountSubjectListForSalesIncome.get(i).getPercentYearly());
	        				 }
	        			 }
	        	}
	        }
	        int rowsForSalesIncome = accountSubjectListForSalesIncome.size();
	       //创建月度合计行
	        row = sheet.createRow(rowsForSalesIncome+3);
	        sheet.addMergedRegion(new CellRangeAddress(rowsForSalesIncome+3, rowsForSalesIncome+3, 0, 2));
	        HSSFCell toForMonth1=row.createCell(3);
	        toForMonth1.setCellValue("Total");
	        for(int i=0;i<totalMonthlyForSalesIncome.size();i++){
	        	HSSFCell cell = row.createCell(4+i);
	        	cell.setCellValue(Double.parseDouble(totalMonthlyForSalesIncome.get(i).getAccountsSum()+""));
	        };
	        HSSFCell cell = row.createCell(16);
	        cell.setCellValue(Double.parseDouble(totalYearForSalesIncome+""));
        	HSSFCell cell17 = row.createCell(17);
         	setText(cell17, "100%");
         	
         	//创建第二行
	        row = sheet.createRow(rowsForSalesIncome+5);
	        row.setHeight((short)(3*160));
	        sheet.addMergedRegion(new CellRangeAddress(rowsForSalesIncome+5, rowsForSalesIncome+5, 0, 17));
	        HSSFCell ce21=row.createCell(0);
	        ce21.setCellValue(tittle4);
	        ce21.setCellStyle(titleStyle);
	        
	      //创建表头
	        row = sheet.createRow(rowsForSalesIncome+6);
	        for(int i=0;i<18;i++){
	        	HSSFCell cell8 = row.createCell(i);
	        	if(i==0){
	        		sheet.addMergedRegion(new CellRangeAddress(rowsForSalesIncome+6, rowsForSalesIncome+6, 0, 3));
	        		setText(cell8, tableHeader4[i]);
	        		cell8.setCellStyle(titleStyle);
	        		i=3;
	        	}else{
		        	setText(cell8, tableHeader4[i-3]);
		        	cell8.setCellStyle(titleStyle);
	        	}
	        }
	        
	       for(int i=0;i<accountSubjectListForTourCost.size();i++){
	        		if(accountSubjectListForTourCost.get(i).getHasChild()==0&&accountSubjectListForTourCost.get(i).getBusinessFlowList().size()>0){
	        			 int col = accountSubjectListForTourCost.get(i).getLevel()-1;
	        			 row = sheet.createRow(rowsForSalesIncome+7+i);
	        			 HSSFCell cell1 = row.createCell(col);
	        			 setText(cell1, accountSubjectListForTourCost.get(i).getSubjectCode());
	        			 HSSFCell cell2 = row.createCell(col+1);
	        			 setText(cell2, accountSubjectListForTourCost.get(i).getSubjectName());
	        				 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForTourCost.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 cell3.setCellValue(accountSubjectListForTourCost.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForTourCost.get(i).getTotalYearly()+""));
		        			 HSSFCell cell4 = row.createCell(17);
		        			 setText(cell4, accountSubjectListForTourCost.get(i).getPercentYearly());
	        			 }else if(accountSubjectListForTourCost.get(i).getHasChild()==1){
	        				 int col = accountSubjectListForTourCost.get(i).getLevel()-1;
		        			 row = sheet.createRow(rowsForSalesIncome+7+i);
		        			 HSSFCell cell1 = row.createCell(col);
		        			 setText(cell1, accountSubjectListForTourCost.get(i).getSubjectCode());
		        			 HSSFCell cell2 = row.createCell(col+1);
		        			 setText(cell2, accountSubjectListForTourCost.get(i).getSubjectName());
		        			 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForTourCost.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 HSSFCell cell4 = row.createCell(17);
	        				 if(accountSubjectListForTourCost.get(i).getTotalYearly().compareTo(new BigDecimal(0.00))!=0){
	        					 cell3.setCellValue(accountSubjectListForTourCost.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForTourCost.get(i).getTotalYearly()+""));
			        			 setText(cell4, accountSubjectListForTourCost.get(i).getPercentYearly());
	        				 }
	        			 }
	        }
	       int rowsForTourCost = accountSubjectListForTourCost.size();
	     //创建月度合计行
	        row = sheet.createRow(rowsForTourCost+rowsForSalesIncome+8);
	        sheet.addMergedRegion(new CellRangeAddress(rowsForTourCost+rowsForSalesIncome+8, rowsForTourCost+rowsForSalesIncome+8, 0, 2));
	        HSSFCell toForMonth2=row.createCell(3);
	        toForMonth2.setCellValue("Total");
	        for(int i=0;i<totalMonthlyForTourCost.size();i++){
	        	HSSFCell cell7 = row.createCell(4+i);
	        	cell7.setCellValue(Double.parseDouble(totalMonthlyForTourCost.get(i).getAccountsSum()+""));
	        };
	        HSSFCell cell5 = row.createCell(16);
	        cell5.setCellValue(Double.parseDouble(totalYearForTourCost+""));
        	HSSFCell cell27 = row.createCell(17);
         	setText(cell27, "100%");
         	
         	//创建第二行
         	int cellRows=rowsForTourCost+rowsForSalesIncome;
	        row = sheet.createRow(cellRows+10);
	        row.setHeight((short)(3*160));
	        sheet.addMergedRegion(new CellRangeAddress(cellRows+10, cellRows+10, 0, 17));
	        HSSFCell ce31=row.createCell(0);
	        ce31.setCellValue(tittle1);
	        ce31.setCellStyle(titleStyle);
	        
	      //创建表头
	        row = sheet.createRow(cellRows+11);
	        for(int i=0;i<18;i++){
	        	HSSFCell cell3 = row.createCell(i);
	        	if(i==0){
	        		sheet.addMergedRegion(new CellRangeAddress(cellRows+11, cellRows+11, 0, 3));
	        		setText(cell3, tableHeader1[i]);
	        		cell3.setCellStyle(titleStyle);
	        		i=3;
	        	}else{
		        	setText(cell3, tableHeader1[i-3]);
		        	cell3.setCellStyle(titleStyle);
	        	}
	        }
	        for(int i=0;i<accountSubjectListForIncome.size();i++){
	        	if(accountSubjectListForIncome.get(i).getSubjectType()==1){
	        		if(accountSubjectListForIncome.get(i).getHasChild()==0&&accountSubjectListForIncome.get(i).getBusinessFlowList().size()>0){
	        			int col = accountSubjectListForIncome.get(i).getLevel()-1;
	        			 row = sheet.createRow(cellRows+i+12);
	        			 HSSFCell cell1 = row.createCell(col);
	        			 setText(cell1, accountSubjectListForIncome.get(i).getSubjectCode());
	        			 HSSFCell cell2 = row.createCell(col+1);
	        			 setText(cell2, accountSubjectListForIncome.get(i).getSubjectName());
	        			 
	        				 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForIncome.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 cell3.setCellValue(accountSubjectListForIncome.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForIncome.get(i).getTotalYearly()+""));
		        			 HSSFCell cell4 = row.createCell(17);
		        			 setText(cell4, accountSubjectListForIncome.get(i).getPercentYearly()); 
	        			 }else if(accountSubjectListForIncome.get(i).getHasChild()==1){
	        				 int col = accountSubjectListForIncome.get(i).getLevel()-1;
		        			 row = sheet.createRow(cellRows+i+12);
		        			 HSSFCell cell1 = row.createCell(col);
		        			 setText(cell1, accountSubjectListForIncome.get(i).getSubjectCode());
		        			 HSSFCell cell2 = row.createCell(col+1);
		        			 setText(cell2, accountSubjectListForIncome.get(i).getSubjectName());
		        			 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForIncome.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 HSSFCell cell4 = row.createCell(17);
	        				 if(accountSubjectListForIncome.get(i).getTotalYearly().compareTo(new BigDecimal(0.00))!=0){
	        					 cell3.setCellValue(accountSubjectListForIncome.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForIncome.get(i).getTotalYearly()+""));
			        			 setText(cell4, accountSubjectListForIncome.get(i).getPercentYearly());
	        				 }
	        			 }
	        	}
	        }
	        int rowsForIncome = accountSubjectListForIncome.size();
	       //创建月度合计行
	        row = sheet.createRow(cellRows+rowsForIncome+13);
	        sheet.addMergedRegion(new CellRangeAddress(cellRows+rowsForIncome+13, cellRows+rowsForIncome+13, 0, 2));
	        HSSFCell toForMonth3=row.createCell(3);
	        toForMonth3.setCellValue("Total");
	        for(int i=0;i<totalMonthlyForIncome.size();i++){
	        	HSSFCell cell33 = row.createCell(4+i);
	        	cell33.setCellValue(Double.parseDouble(totalMonthlyForIncome.get(i).getAccountsSum()+""));
	        };
	        HSSFCell cell36 = row.createCell(16);
	        cell36.setCellValue(Double.parseDouble(totalYearForIncome+""));
        	HSSFCell cell37 = row.createCell(17);
         	setText(cell37, "100%");
         	
	      //创建第二行
         	cellRows=cellRows+rowsForIncome;
	        row = sheet.createRow(cellRows+15);
	        row.setHeight((short)(3*160));
	        sheet.addMergedRegion(new CellRangeAddress(cellRows+15, cellRows+15, 0, 17));
	        HSSFCell ce41=row.createCell(0);
	        ce41.setCellValue(tittle2);
	        ce41.setCellStyle(titleStyle);
	        
	      //创建表头
	        row = sheet.createRow(cellRows+16);
	        for(int i=0;i<18;i++){
	        	HSSFCell cell8 = row.createCell(i);
	        	if(i==0){
	        		sheet.addMergedRegion(new CellRangeAddress(cellRows+16, cellRows+16, 0, 3));
	        		setText(cell8, tableHeader2[i]);
	        		cell8.setCellStyle(titleStyle);
	        		i=3;
	        	}else{
		        	setText(cell8, tableHeader2[i-3]);
		        	cell8.setCellStyle(titleStyle);
	        	}
	        }
	        
	       for(int i=0;i<accountSubjectListForCost.size();i++){
	        		if(accountSubjectListForCost.get(i).getHasChild()==0&&accountSubjectListForCost.get(i).getBusinessFlowList().size()>0){
	        			 int col = accountSubjectListForCost.get(i).getLevel()-1;
	        			 row = sheet.createRow(cellRows+17+i);
	        			 HSSFCell cell1 = row.createCell(col);
	        			 setText(cell1, accountSubjectListForCost.get(i).getSubjectCode());
	        			 HSSFCell cell2 = row.createCell(col+1);
	        			 setText(cell2, accountSubjectListForCost.get(i).getSubjectName());
	        				 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForCost.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 cell3.setCellValue(accountSubjectListForCost.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForCost.get(i).getTotalYearly()+""));
		        			 HSSFCell cell4 = row.createCell(17);
		        			 setText(cell4, accountSubjectListForCost.get(i).getPercentYearly());
	        			 }else if(accountSubjectListForCost.get(i).getHasChild()==1){
	        				 int col = accountSubjectListForCost.get(i).getLevel()-1;
		        			 row = sheet.createRow(cellRows+17+i);
		        			 HSSFCell cell1 = row.createCell(col);
		        			 setText(cell1, accountSubjectListForCost.get(i).getSubjectCode());
		        			 HSSFCell cell2 = row.createCell(col+1);
		        			 setText(cell2, accountSubjectListForCost.get(i).getSubjectName());
		        			 for(int j=1;j<13;j++){
	        					 for(BusinessFlow businessFlow:businessFlows){
	        						 if(businessFlow.getAccountSubjectId().equals(accountSubjectListForCost.get(i).getAccountSubjectId())){
	        							 if(businessFlow.getAccountDateStr()!=null&&businessFlow.getAccountDateStr()==j){
	        								 HSSFCell cell3 = row.createCell(3+j);
	        								 cell3.setCellValue(Double.parseDouble(businessFlow.getAccountsSum()+""));
	        							 }
	        						 }
	        					 }
	        				 }
	        				 HSSFCell cell3 = row.createCell(16);
	        				 HSSFCell cell4 = row.createCell(17);
	        				 if(accountSubjectListForCost.get(i).getTotalYearly().compareTo(new BigDecimal(0.00))!=0){
	        					 cell3.setCellValue(accountSubjectListForCost.get(i).getTotalYearly()==null?0:Double.parseDouble(accountSubjectListForCost.get(i).getTotalYearly()+""));
			        			 setText(cell4, accountSubjectListForCost.get(i).getPercentYearly());
	        				 }
	        			 }
	        }
	       int rowsForCost = accountSubjectListForCost.size();
	     //创建月度合计行
	        row = sheet.createRow(rowsForCost+cellRows+18);
	        sheet.addMergedRegion(new CellRangeAddress(rowsForCost+cellRows+18, rowsForCost+cellRows+18, 0, 2));
	        HSSFCell toForMonth4=row.createCell(3);
	        toForMonth4.setCellValue("Total");
	        for(int i=0;i<totalMonthlyForCost.size();i++){
	        	HSSFCell cell7 = row.createCell(4+i);
	        	cell7.setCellValue(Double.parseDouble(totalMonthlyForCost.get(i).getAccountsSum()+""));
	        };
	        HSSFCell cell4 = row.createCell(16);
	        cell4.setCellValue(Double.parseDouble(totalYearForCost+""));
        	HSSFCell cell47 = row.createCell(17);
         	setText(cell47, "100%");
         	
         	//创建利润合计
         	 //创建月度合计行
	        row = sheet.createRow(rowsForCost+cellRows+19);
	        sheet.addMergedRegion(new CellRangeAddress(rowsForCost+cellRows+19, rowsForCost+cellRows+19, 0, 2));
	        HSSFCell profitForMonth2=row.createCell(3);
	        profitForMonth2.setCellValue("Profit");
	        for(int i=0;i<totalMonthlyForProfit.size();i++){
	        	HSSFCell cell7 = row.createCell(4+i);
	        	cell7.setCellValue(Double.parseDouble(totalMonthlyForProfit.get(i).getAccountsSum()+""));
	        };
	        HSSFCell cell13 = row.createCell(16);
	        cell13.setCellValue(Double.parseDouble(totalYearForIncome.subtract(totalYearForCost)+""));
        	
	    }     
}
