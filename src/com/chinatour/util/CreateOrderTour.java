package com.chinatour.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.CellStyle;

import com.chinatour.entity.Dept;
import com.chinatour.entity.SupplierPrice;

@SuppressWarnings("deprecation")
public class CreateOrderTour {
	/**
	 * 
	 * @param path
	 * @param supplierPriceList
	 * @param supplierPriceListF
	 * @param supplierPriceDeptList
	 * @param os
	 * @param supplierPrice
	 * @param supplierPriceListOfTour
	 * @param supplierPriceRemarkDept  根据部门查找变更单
	 * @param SupplierPriceRemarkSupplierName  根据地接,酒店等查找变更单
	 * @param deptList
	 */
	public static void createOrder(String path,List<SupplierPrice> supplierPriceList,List<SupplierPrice> supplierPriceListF ,List<SupplierPrice> supplierPriceDeptList,OutputStream os,SupplierPrice supplierPrice,List<SupplierPrice> supplierPriceListOfTour,List<SupplierPrice> supplierPriceRemarkDept,List<SupplierPrice> supplierPriceRemarkSupplierName,List<Dept> deptList){
		try{
			InputStream inp = new FileInputStream(path+"TourBill.xls");
			HSSFWorkbook wb=new HSSFWorkbook(inp);
			
			HSSFSheet sh=wb.getSheet("1");
		    HSSFRow rowHead=sh.createRow(0);
		    HSSFCell celHead1=rowHead.createCell(0);
	    	HSSFCell celHead2=rowHead.createCell(1);
	    	HSSFCell celHead3=rowHead.createCell(2);
	    	HSSFCell celHead4=rowHead.createCell(3);
	    	HSSFCell celHead5=rowHead.createCell(4);
	    	celHead1.setCellValue("名称");
	    	celHead2.setCellValue("应付合计");
	    	celHead3.setCellValue("团号");
	    	celHead4.setCellValue("应付");
	    	celHead5.setCellValue("OP");
	    	
	    	
	    	CellStyle cell=wb.createCellStyle();
	    	cell.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	cell.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    	celHead1.setCellStyle(cell);
	    	
	    	BigDecimal TotalSum = new BigDecimal(0.00);
	    	BigDecimal tempSum = new BigDecimal(0.00);
	    	BigDecimal insuranceSum = new BigDecimal(0.00);
	    	String name="";
	    	int begin=1;
	    	int end=0;
	    	List<SupplierPrice> spList=new ArrayList<SupplierPrice>();
	    	for(int i=0;i<supplierPriceList.size();i++){
	    		if(!supplierPriceList.get(i).getType().equals("3")){
	    			spList.add(supplierPriceList.get(i));
	    		}
	    	}
		    for(int i=0;i<spList.size();i++){
		    	if(spList.get(i).getType().equals("4")){
		    		spList.get(i).setSupplierName("保险");
		    		insuranceSum=insuranceSum.add(spList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP));
		    	}
		    	if(!spList.get(i).getType().equals("3")){
		    		HSSFRow rowHd=sh.createRow(1+i);
				    HSSFCell celHad1=rowHd.createCell(0);
			    	HSSFCell celHad2=rowHd.createCell(1);
			    	HSSFCell celHad3=rowHd.createCell(2);
			    	HSSFCell celHad4=rowHd.createCell(3);
			    	HSSFCell celHad5=rowHd.createCell(4);
			    	
				    celHad1.setCellValue(spList.get(i).getSupplierName());
			    	celHad3.setCellValue(spList.get(i).getTourCode());
			    	celHad4.setCellValue(spList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
			    	TotalSum=TotalSum.add(spList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP));
			    	tempSum=tempSum.add(spList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP));
			    	celHad5.setCellValue(spList.get(i).getUserName());			    	
			    	
			    	if(spList.size()>i+1){
				    	if(!spList.get(i).getType().equals("4")&&spList.get(i).getSupplierName()!=null&&spList.get(i+1).getSupplierName()!=null&&!spList.get(i+1).getSupplierName().equals(spList.get(i).getSupplierName())){
				    		celHad2.setCellValue(tempSum.doubleValue());
				    		tempSum=new BigDecimal(0.00);
				    	}
			    	}
			    	
			    	if(i==spList.size()-1){
			    		celHad2.setCellValue(insuranceSum.doubleValue());	
			    	}
			    	if(spList.get(i).getSupplierName()!=null&&name.equals(spList.get(i).getSupplierName())){
			    		end=i+1;
			    		if(i==spList.size()-1){
			    			//sh.addMergedRegion(new CellRangeAddress(begin, end, 1, 1));
			    			sh.addMergedRegion(new CellRangeAddress(begin, end, 0, 0));
			    			//celHad2.setCellValue(tempSum.doubleValue());
			    		}
			    	}else if(spList.get(i).getSupplierName()!=null&&!name.equals(spList.get(i).getSupplierName())){
			    		if(i==0){
			    			//celHad2.setCellValue(supplierPriceList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
			    			begin=i+1;
			    			end=i+1;
			    		}else{
			    			//tempSum=tempSum.subtract(supplierPriceList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP));
			    			//sh.addMergedRegion(new CellRangeAddress(begin, end, 1, 1));
			    			sh.addMergedRegion(new CellRangeAddress(begin, end, 0, 0));
			    			//celHad2.setCellValue(tempSum.doubleValue());
			    		//	tempSum=new BigDecimal(0.00);
			    			begin=i+1;
			    			end=i+1;
			    		}
			    		name=spList.get(i).getSupplierName();
			    	}
			    	
		    	}
		    }
		  
		    HSSFRow r=sh.createRow(spList.size()+1);
		    HSSFCell c1=r.createCell(0);
	    	HSSFCell c2=r.createCell(1);
	    	HSSFCell c3=r.createCell(2);
	    	HSSFCell c4=r.createCell(3);
	    	HSSFCell c5=r.createCell(4);
	    	c1.setCellValue("Total");
	    	c2.setCellValue("");
	    	c3.setCellValue("");
	    	c4.setCellValue(TotalSum.doubleValue());
	    	c5.setCellValue("");
		 createBillF(wb,supplierPriceList);
	   	 createBillT(wb,supplierPriceList,supplierPriceListF,supplierPrice,supplierPriceDeptList,deptList);
	     createBillB(wb,supplierPriceDeptList,deptList);
	     createBillC(wb,supplierPriceListOfTour);
	     //变更单
	     createBillR(wb,supplierPriceRemarkDept,supplierPriceRemarkSupplierName);
	     CreateOrderTour.save(wb,os);
	   	 inp.close();
	   	 os.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @param wb
	 * @param supplierPriceList
	 * @param supplierPriceListF
	 * @param supplierPriceDeptList
	 * @param os
	 * @param supplierPrice
	 */
	public static void createBillF(HSSFWorkbook wb,List<SupplierPrice> supplierPriceList){
		try{
			
			List<SupplierPrice> supplierPriceListF = new ArrayList<SupplierPrice>();
			for(int i=0;i<supplierPriceList.size();i++){
		    	if(supplierPriceList.get(i).getType().equals("3")){
		    		supplierPriceListF.add(supplierPriceList.get(i));
		    	}
		    }
			
			HSSFSheet sh=wb.getSheet("6");
		    HSSFRow rowHead=sh.createRow(0);
		    HSSFCell celHead1=rowHead.createCell(0);
	    	HSSFCell celHead2=rowHead.createCell(1);
	    	HSSFCell celHead3=rowHead.createCell(2);
	    	HSSFCell celHead4=rowHead.createCell(3);
	    	celHead1.setCellValue("机票名称");
	    	celHead2.setCellValue("团号");
	    	celHead3.setCellValue("应付");
	    	celHead4.setCellValue("OP");
	    	
	    	
	    	CellStyle cell=wb.createCellStyle();
	    	cell.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	cell.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    	celHead1.setCellStyle(cell);
	    	
	    	Double sum = 0.0;
	    	for(int i=0;i<supplierPriceListF.size();i++){
		    	if(!supplierPriceListF.get(i).getType().equals("3")){
		    		supplierPriceListF.remove(i);
		    		i--;
		    	}
		    }
		    for(int i=0;i<supplierPriceListF.size();i++){
		    	if(supplierPriceListF.get(i).getType().equals("3")){
		    		HSSFRow rowHd=sh.createRow(1+i);
				    HSSFCell celHad1=rowHd.createCell(0);
			    	HSSFCell celHad2=rowHd.createCell(1);
			    	HSSFCell celHad3=rowHd.createCell(2);
			    	HSSFCell celHad4=rowHd.createCell(3);
			    	
				    celHad1.setCellValue(supplierPriceListF.get(i).getSupplierName());
			    	celHad2.setCellValue(supplierPriceListF.get(i).getTourCode());
			    	celHad3.setCellValue(supplierPriceListF.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
			    	celHad4.setCellValue(supplierPriceListF.get(i).getUserName());
			    	
			    	sum+=supplierPriceListF.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		    	}
		    }
    		
		    HSSFRow rowHd=sh.createRow(supplierPriceListF.size()+1);
		    HSSFCell celHad1=rowHd.createCell(1);
		    HSSFCell celHad2=rowHd.createCell(2);
		    celHad1.setCellValue("合计");
		    celHad2.setCellValue(sum);
		    
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @param wb
	 * @param supplierPriceList
	 * @param supplierPriceListF
	 * @param supplierPriceDeptList
	 * @param os
	 * @param supplierPrice
	 */
	public static void createBillT(HSSFWorkbook wb,List<SupplierPrice> supplierPriceList,List<SupplierPrice> supplierPriceListF,SupplierPrice supplierPrice,List<SupplierPrice> supplierPriceDeptList,List<Dept> deptList){
		try{
			//Set<String> tourId=new HashSet<String>();
			List<String> name=new ArrayList<String>();
			Map<String,String> tourCode = new HashMap<String,String>();
			Map<String,Double> costmap = new HashMap<String,Double>();
			Map<String,Double> map = new HashMap<String,Double>();
			
			for(int i=0;i<supplierPriceList.size();i++){
				if(supplierPriceList.get(i).getType().equals("3")){
		    		supplierPriceList.remove(i);
		    		i--;
		    	}
			}
			supplierPriceList.addAll(supplierPriceListF);
			
			for(int i=0;i<supplierPriceList.size();i++){
				if(supplierPriceList.get(i).getType().equals("4")){
		    		supplierPriceList.get(i).setSupplierName("保险");
		    	}
				
				if(supplierPriceList.get(i).getType().equals("3")){
		    		supplierPriceList.get(i).setSupplierName("机票");
		    	}
				
				if(map.get(supplierPriceList.get(i).getSupplierName())==null){
					map.put(supplierPriceList.get(i).getSupplierName(), 0.00);
					costmap.put(supplierPriceList.get(i).getSupplierName(), 0.00);
					name.add(supplierPriceList.get(i).getSupplierName());
				}
				tourCode.put(supplierPriceList.get(i).getTourId(), supplierPriceList.get(i).getTourCode());
			}

			//将map装载List中对tourcode的“-”之后的第二位数字进行排序
			List<Map.Entry<String, String>> tourCodeList = new ArrayList<Map.Entry<String, String>>(tourCode.entrySet());
			Collections.sort(tourCodeList, new Comparator<Map.Entry<String, String>>() {
				public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
					String begin = o1.getValue().substring(o1.getValue().indexOf("-") + 2);
					String end = o2.getValue().substring(o2.getValue().indexOf("-") + 2);
					return begin.compareTo(end);
				}
			});
			
			SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd");
			String date="";
			if(supplierPrice.getEndingDate()!=null){
				date=sdf.format(supplierPrice.getBeginningDate());
			}
			if(supplierPrice.getEndingDate()!=null){
				date+="—"+sdf.format(supplierPrice.getEndingDate());
			}
			HSSFSheet sh=wb.getSheet("2");
			HSSFRow rowHead0=sh.getRow(0);
			HSSFCell celHeadr0=rowHead0.getCell(0);
			celHeadr0.setCellValue("关于"+date+"账单");
		    HSSFRow rowHead1=sh.getRow(1);

		    HSSFCell celHead0=rowHead1.getCell(0);
	    	HSSFCell celHead1=rowHead1.getCell(1);
	    	HSSFCell celHead2=rowHead1.getCell(2);
	    	HSSFCell celHead3=rowHead1.getCell(3);
    	    HSSFCell celHead4=rowHead1.getCell(4);
	    	HSSFCell celHead5=rowHead1.getCell(5);
	    	celHead0.setCellValue("序号");
	    	celHead1.setCellValue("人数");
	    	celHead2.setCellValue("天数");
	    	celHead3.setCellValue("人天数");
	    	celHead4.setCellValue("团号");
	    	celHead5.setCellValue("收支栏");
	    	
	    	int sq=6;
	    	for(String str :name) {
	    		HSSFCell celHead=rowHead1.getCell(sq);
	    		celHead.setCellValue(str);
	    		sq++;
	    	}
	    	
	    	HSSFCell celHeadT=rowHead1.getCell(sq);
	    	celHeadT.setCellValue("合计");
	    	HSSFCell celHeadP=rowHead1.getCell(sq+1);
	    	celHeadP.setCellValue("毛利");
	    	HSSFCell celHeadO=rowHead1.getCell(sq+2);
	    	celHeadO.setCellValue("OP");
	    	
	    	sq=1;
	    	for (int p=0;p<tourCodeList.size();p++) {
	    		String tourid=tourCodeList.get(p).getKey();
	    		
	    		HSSFRow rowHd=sh.getRow(sq*2);
			    HSSFCell celHad0=rowHd.getCell(0);
		    	HSSFCell celHad1=rowHd.getCell(1);
		    	HSSFCell celHad2=rowHd.getCell(2);
		    	HSSFCell celHad3=rowHd.getCell(3);
		    	HSSFCell celHad4=rowHd.getCell(4);
		    	HSSFCell celHad5=rowHd.getCell(5);
		    	celHad0.setCellValue(sq);
			    celHad4.setCellValue(tourCode.get(tourid));
			    celHad5.setCellValue("收入栏");
			    
			    HSSFRow rowHd2=sh.getRow(sq*2+1);
		    	HSSFCell celHads4=rowHd2.getCell(4);
		    	HSSFCell celHads5=rowHd2.getCell(5);
			    celHads4.setCellValue(tourCode.get(tourid));
			    celHads5.setCellValue("支出栏");
			    
			    int sqs=6;
			    double pay=0;
			    double cost =0;
			    String op="";
		    	for(String sname :name) {
		    		for(int i=0;i<supplierPriceList.size();i++){

		    			supplierPriceList.get(i).setSupplierName(supplierPriceList.get(i).getSupplierName()==null?"":supplierPriceList.get(i).getSupplierName());
		    			if(supplierPriceList.get(i).getTourId().equals(tourid)&&supplierPriceList.get(i).getSupplierName().equals(sname)){
				    		HSSFCell celHadO=rowHd.getCell(sqs);
				    		int big_decimal=supplierPriceList.get(i).getSupplierCost().compareTo(BigDecimal.ZERO); 
				    		//if(big_decimal!=0){
				    			celHadO.setCellValue(supplierPriceList.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    			pay=pay+supplierPriceList.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				    		//}
				    		
				    		HSSFCell celHadT=rowHd2.getCell(sqs);
				    		//if(big_decimal!=0){
				    			celHadT.setCellValue(supplierPriceList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    			cost=cost+supplierPriceList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				    		//}
				    	
				    		celHad1.setCellValue(supplierPriceList.get(i).getTotalPeople());
				    		celHad2.setCellValue(supplierPriceList.get(i).getDayNum()!=null?supplierPriceList.get(i).getDayNum():0);
				    		if(supplierPriceList.get(i).getDayNum()!=null){
				    			celHad3.setCellValue(supplierPriceList.get(i).getTotalPeople()*supplierPriceList.get(i).getDayNum());
				    		}
				    		op=supplierPriceList.get(i).getUserName();
				    		
				    		/*map.put(sname, (map.get(sname)!=null?map.get(sname):0.00)+supplierPriceList.get(i).getSupplierPrice());
				    		costmap.put(sname, (map.get(sname)!=null?map.get(sname):0.00)+supplierPriceList.get(i).getSupplierCost());*/
				    		
				    		map.put(sname, map.get(sname)+supplierPriceList.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    		costmap.put(sname, costmap.get(sname)+supplierPriceList.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    	}
				    } 
		    	 	sqs++;
		    	}
		    	
		    	
		    	HSSFCell celHadP=rowHd.getCell(name.size()+6);
		    	celHadP.setCellValue(pay);
		    	HSSFCell celHadC=rowHd2.getCell(name.size()+6);
		    	celHadC.setCellValue(cost);
		    	HSSFCell celHadPF=rowHd.getCell(name.size()+7);
		    	celHadPF.setCellValue(pay-cost);
		    	
		    	HSSFCell celHadOP=rowHd.getCell(name.size()+8);
		    	celHadOP.setCellValue(op);
		    	HSSFCell celHadOPa=rowHd2.getCell(name.size()+8);
		    	celHadOPa.setCellValue(op);
		    	
		    	int num=name.size()+9;
		    	int row = 0;
		    	//团下分部门账单
		    	for(int i=0;i<supplierPriceDeptList.size();i++){
		    		if(tourid.endsWith(supplierPriceDeptList.get(i).getTourId())){
						HSSFCell celHadD = null;
						HSSFCell celHadDD = null;
						// 偶数放第一行,奇数放第二行
						if (row % 2 == 0) {
							celHadD = rowHd.getCell(num + row);
							celHadDD = rowHd.getCell(num + row + 1);
						} else {
							celHadD = rowHd2.getCell(num + row - 1);
							celHadDD = rowHd2.getCell(num + row);
						}
						row++;
						// 币种符号，汇率换算
						String str = "";
						for (int k = 0; k < deptList.size(); k++) {
							if (deptList.get(k).getDeptId().endsWith(supplierPriceDeptList.get(i).getDeptId())) {
								str = deptList.get(k).getSymbol();
							}
						}
		    			
		    			celHadD.setCellValue(supplierPriceDeptList.get(i).getDeptName() + "("+str+")");
						/*BigDecimal b = new BigDecimal(supplierPriceDeptList.get(i).getSupplierUSAPrice());   
				    	celHadDD.setCellValue(b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());*/
		    			BigDecimal b = supplierPriceDeptList.get(i).getSupplierDifCost();   
				    	celHadDD.setCellValue(supplierPriceDeptList.get(i).getSupplierDifCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
		    		}
		    	}
			    sq++;
	    	}
	    	
	    	/**
	    	 * 计算合计
	    	 */
	    	HSSFRow rowHd=sh.getRow(sq*2);
		    HSSFCell celHad0=rowHd.getCell(0);
	    	HSSFCell celHad3=rowHd.getCell(3);
	    	HSSFCell celHad5=rowHd.getCell(5);
	    	celHad0.setCellValue(sq);
		    celHad3.setCellValue("合计");
		    celHad5.setCellValue("收入栏");
		    
		    HSSFRow rowHd2=sh.getRow(sq*2+1);
	    	HSSFCell celHads5=rowHd2.getCell(5);
		    celHads5.setCellValue("支出栏");
		    Double price = 0.0;
		    Double cost = 0.0 ;
	    	for(int i=0;i<name.size();i++) {
	    		HSSFCell celHadO=rowHd.getCell(i+6);
	    		celHadO.setCellValue(map.get(name.get(i)));
	    		price+=map.get(name.get(i));
	    		
	    		HSSFCell celHadP=rowHd2.getCell(i+6);
	    		celHadP.setCellValue(costmap.get(name.get(i)));
	    		cost+=costmap.get(name.get(i));
	    		
	    	}
	    	
	    	HSSFCell celHadO=rowHd.getCell(name.size()+6);
    		celHadO.setCellValue(price);
    		
    		HSSFCell celHadP=rowHd2.getCell(name.size()+6);
    		celHadP.setCellValue(cost);
    		
    		HSSFCell celHadOP=rowHd.getCell(name.size()+7);
    		celHadOP.setCellValue(price-cost);
    		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void createBillB(HSSFWorkbook wb,List<SupplierPrice> supplierPriceDeptList,List<Dept> deptList){
		try{
			
			HSSFSheet sh=wb.getSheet("3");
		    HSSFRow rowHead=sh.createRow(0);
		    HSSFCell celHead0=rowHead.createCell(0);
	    	HSSFCell celHead1=rowHead.createCell(1);
	    	HSSFCell celHead2=rowHead.createCell(2);
	    	HSSFCell celHead3=rowHead.createCell(3);
	    	HSSFCell celHead4=rowHead.createCell(4);
	    	HSSFCell celHead5=rowHead.createCell(5);
	    	HSSFCell celHead6=rowHead.createCell(6);
	    	celHead0.setCellValue("部门名称");
	    	celHead1.setCellValue("美元合计");
	    	celHead2.setCellValue("人民币合计");
	    	celHead3.setCellValue("团号");
	    	celHead4.setCellValue("人民币");
	    	celHead5.setCellValue("美元");
	    	celHead6.setCellValue("OP");
	    	
	    	
	    	CellStyle cell=wb.createCellStyle();
	    	cell.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	cell.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    	celHead1.setCellStyle(cell);
	    	
	    	int begin=1;
	    	int end=1;
	    	for(int j=0;j<deptList.size();j++){
	    		Double sum=0.0;
	    		Double rmbSum =0.0;
	    		Integer num=0;
			    for(int i=0;i<supplierPriceDeptList.size();i++){
			    	if(deptList.get(j).getDeptId().equals(supplierPriceDeptList.get(i).getDeptId())){
				    	HSSFRow rowHd=sh.createRow(begin+num);
					    HSSFCell celHad0=rowHd.createCell(0);
				    	rowHd.createCell(1);
				    	rowHd.createCell(2);
				    	HSSFCell celHad3=rowHd.createCell(3);
				    	HSSFCell celHad4=rowHd.createCell(4);
				    	HSSFCell celHad5=rowHd.createCell(5);
				    	HSSFCell celHad6=rowHd.createCell(6);
				    	
				       	//币种符号，汇率换算
		    			String str="";
		    			for(int k=0;k<deptList.size();k++){
		    				if (deptList.get(k).getDeptId().endsWith(supplierPriceDeptList.get(i).getDeptId())) {
								str = deptList.get(k).getSymbol();
							}
		    			}
		    			
					    celHad0.setCellValue(supplierPriceDeptList.get(i).getDeptName()+"("+str+")");
				    	celHad3.setCellValue(supplierPriceDeptList.get(i).getTourCode());
				    	celHad4.setCellValue(supplierPriceDeptList.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    	
		    			
		    			BigDecimal b = supplierPriceDeptList.get(i).getSupplierUSAPrice();
		    			BigDecimal rmb = supplierPriceDeptList.get(i).getSupplierPrice();   
				    	celHad5.setCellValue(b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    	celHad6.setCellValue(supplierPriceDeptList.get(i).getUserName());
						sum += b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
						rmbSum +=rmb.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
						num++;
			    	}
			    }
			    end = begin + num - 1;
				
	    		//sh.addMergedRegion(new CellRangeAddress(begin, end, 1, 1));
			    if(begin<=end){
			    	sh.addMergedRegion(new CellRangeAddress(begin, end, 0, 0));
			    	sh.addMergedRegion(new CellRangeAddress(begin, end, 1, 1));
			    	sh.addMergedRegion(new CellRangeAddress(begin, end, 2, 2));
					HSSFRow rowHd = sh.getRow(begin);
					HSSFCell celHad0 = rowHd.getCell(1);
					HSSFCell celHad1 = rowHd.getCell(2);
					celHad0.setCellValue(sum);
					celHad1.setCellValue(rmbSum);
			    }
			   
			    begin = begin + num;
	    	}
	    	
			HSSFSheet sh4=wb.getSheet("4");
		    HSSFRow rowHead4=sh4.createRow(0);
		    HSSFCell celHead40=rowHead4.createCell(0);
	    	HSSFCell celHead41=rowHead4.createCell(1);
	    	HSSFCell celHead42=rowHead4.createCell(2);
	    	HSSFCell celHead43=rowHead4.createCell(3);
	    	celHead40.setCellValue("西安（团号）");
	    	celHead41.setCellValue("OP");
	    	celHead42.setCellValue("Agent");
	    	celHead43.setCellValue("应收");
	    	

	    	CellStyle cell4=wb.createCellStyle();
	    	cell4.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	cell4.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    	celHead40.setCellStyle(cell);
	    	
			for (int i = 0; i < supplierPriceDeptList.size(); i++) {
				if (!supplierPriceDeptList.get(i).getDeptName().equals("Xian")) {
					supplierPriceDeptList.remove(i);
					i--;
				}
			}
	    	begin=1;
	    	end=0;
		    for(int i=0;i<supplierPriceDeptList.size();i++){
    			for(int j=0;j<supplierPriceDeptList.get(i).getSupplierPriceList().size();j++){
    				SupplierPrice supplierPriceS  = supplierPriceDeptList.get(i).getSupplierPriceList().get(j);
	    			HSSFRow rowHd=sh4.createRow(begin+j);
					HSSFCell celHad0=rowHd.createCell(0);
			    	HSSFCell celHad1=rowHd.createCell(1);
			    	HSSFCell celHad2=rowHd.createCell(2);
			    	HSSFCell celHad3=rowHd.createCell(3);
			    	
			    	celHad0.setCellValue(supplierPriceDeptList.get(i).getTourCode());
			    	celHad1.setCellValue(supplierPriceDeptList.get(i).getUserName());
			    	celHad2.setCellValue(supplierPriceS.getUserIdOfAgent());
			    	celHad3.setCellValue(supplierPriceS.getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
	    		  }
    			sh4.addMergedRegion(new CellRangeAddress(begin, begin+supplierPriceDeptList.get(i).getSupplierPriceList().size()-1, 0, 0));
    			begin=begin+supplierPriceDeptList.get(i).getSupplierPriceList().size();
		    }
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void createBillC(HSSFWorkbook wb,List<SupplierPrice> supplierPriceListOfTour){
		try{
			HSSFSheet sh=wb.getSheet("5");
		    HSSFRow rowHead=sh.createRow(0);
		    HSSFCell celHead0=rowHead.createCell(0);
	    	HSSFCell celHead1=rowHead.createCell(1);
	    	HSSFCell celHead2=rowHead.createCell(2);
	    	HSSFCell celHead3=rowHead.createCell(3);
	    	HSSFCell celHead4=rowHead.createCell(4);
	    	HSSFCell celHead5=rowHead.createCell(5);
	    	HSSFCell celHead6=rowHead.createCell(6);
	    	celHead0.setCellValue("序号");
	    	celHead1.setCellValue("团号");
	    	celHead2.setCellValue("人数");
	    	celHead3.setCellValue("OP");
	    	celHead4.setCellValue("收入");
	    	celHead5.setCellValue("成本");
	    	celHead6.setCellValue("毛利");
	    	
	    	CellStyle cell=wb.createCellStyle();
	    	cell.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	cell.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    	celHead1.setCellStyle(cell);
	    	Double price=0.0;
	    	Double cost=0.0;
		    for(int i=0;i<supplierPriceListOfTour.size();i++){
		    	HSSFRow rowHd=sh.createRow(1+i);
		    	HSSFCell cel0=rowHd.createCell(0);
		    	HSSFCell cel1=rowHd.createCell(1);
		    	HSSFCell cel2=rowHd.createCell(2);
		    	HSSFCell cel3=rowHd.createCell(3);
		    	HSSFCell cel4=rowHd.createCell(4);
		    	HSSFCell cel5=rowHd.createCell(5);
		    	HSSFCell cel6=rowHd.createCell(6);
		    	
		    	cel0.setCellValue(i+1);
		    	cel1.setCellValue(supplierPriceListOfTour.get(i).getTourCode());
		    	cel2.setCellValue(supplierPriceListOfTour.get(i).getTotalPeople());
		    	cel3.setCellValue(supplierPriceListOfTour.get(i).getUserName());
		    	cel4.setCellValue(supplierPriceListOfTour.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
		    	cel5.setCellValue(supplierPriceListOfTour.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
		    	BigDecimal profit=supplierPriceListOfTour.get(i).getSupplierPrice().subtract(supplierPriceListOfTour.get(i).getSupplierCost());
		    	cel6.setCellValue(profit.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
		    	price+=supplierPriceListOfTour.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		    	cost+=supplierPriceListOfTour.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		    }
		    
		    
		    HSSFRow rowHd=sh.createRow(supplierPriceListOfTour.size()+2);
	    	HSSFCell cel2=rowHd.createCell(2);
	    	HSSFCell cel3=rowHd.createCell(3);
	    	HSSFCell cel4=rowHd.createCell(4);
	    	HSSFCell cel5=rowHd.createCell(5);
	    	
	    	cel2.setCellValue("合计");
	    	cel3.setCellValue(price);
	    	cel4.setCellValue(cost);
	    	cel5.setCellValue(price-cost);
	    	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void createBillR(HSSFWorkbook wb,List<SupplierPrice> supplierPriceRemarkDept,List<SupplierPrice> supplierPriceRemarkSupplierName){
		try{
			HSSFSheet sh=wb.getSheet("7");
			HSSFRow rowHead0=sh.createRow(0);
	    	HSSFCell celHead01=rowHead0.createCell(2);
	    	HSSFCell celHead05=rowHead0.createCell(5);
	    	celHead01.setCellValue("收入");
	    	celHead05.setCellValue("支出");
	    	
		    HSSFRow rowHead=sh.createRow(1);
		    HSSFCell celHead0=rowHead.createCell(0);
	    	HSSFCell celHead1=rowHead.createCell(1);
	    	HSSFCell celHead2=rowHead.createCell(2);
	    	HSSFCell celHead3=rowHead.createCell(3);
	    	HSSFCell celHead4=rowHead.createCell(4);
	    	HSSFCell celHead5=rowHead.createCell(5);
	    	HSSFCell celHead6=rowHead.createCell(6);
	    	HSSFCell celHead7=rowHead.createCell(7);
	    	HSSFCell celHead8=rowHead.createCell(8);
	    	HSSFCell celHead9=rowHead.createCell(9);
	    	celHead0.setCellValue("团号");
	    	celHead1.setCellValue("OP");
	    	celHead2.setCellValue("办公室");
	    	celHead3.setCellValue("¥");
	    	celHead4.setCellValue("$");
	    	celHead5.setCellValue("地接社");
	    	celHead6.setCellValue("¥");
	    	celHead7.setCellValue("收入合计");
	    	celHead8.setCellValue("支出合计");
	    	celHead9.setCellValue("毛利");
	    	CellStyle cell=wb.createCellStyle();
	    	cell.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	cell.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    	celHead1.setCellStyle(cell);
	    	Double price=0.0;
	    	Double cost=0.0;
	    	Set<String> tourIdTree = new TreeSet<String>();
	    	for(int i=0;i<supplierPriceRemarkDept.size();i++){
	    		tourIdTree.add(supplierPriceRemarkDept.get(i).getTourId());
		    }
	    	
			Iterator<String> tourId = tourIdTree.iterator();
			int begin = 2;
			int end = 2;
			int tt=0;
			while(tourId.hasNext()) {
				String tId = tourId.next();
				int sdow = begin;
				int rr=begin+tt;
				double sp = 0.0;
				for(int i=0;i<supplierPriceRemarkDept.size();i++){
			    	if(tId.equals(supplierPriceRemarkDept.get(i).getTourId())){
			    		HSSFRow rowHd=sh.createRow(sdow+tt);
					    HSSFCell cel0=rowHd.createCell(0);
				    	HSSFCell cel1=rowHd.createCell(1);
				    	HSSFCell cel2=rowHd.createCell(2);
				    	HSSFCell cel3=rowHd.createCell(3);
				    	HSSFCell cel4=rowHd.createCell(4);
				    	
				    	cel0.setCellValue(supplierPriceRemarkDept.get(i).getTourCode());
				    	cel1.setCellValue(supplierPriceRemarkDept.get(i).getUserName());
				    	cel2.setCellValue(supplierPriceRemarkDept.get(i).getDeptName());
				    	cel3.setCellValue(supplierPriceRemarkDept.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    	cel4.setCellValue(supplierPriceRemarkDept.get(i).getSupplierUSAPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    	
				    	sp += supplierPriceRemarkDept.get(i).getSupplierPrice().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				    	sdow++;
			    	}
			    }
				
				double sc = 0.0;
				int srow = sdow+tt;
				
				for(int i=0;i<supplierPriceRemarkSupplierName.size();i++){
			    	if(tId.equals(supplierPriceRemarkSupplierName.get(i).getTourId())){
			    		HSSFRow rowHd ;
			    		if(sh.getRow(srow) != null ){
			    			rowHd = sh.getRow(srow);
			    		}else {
			    			rowHd = sh.createRow(srow);
			    		}
				    	HSSFCell cel5=rowHd.createCell(5);
				    	HSSFCell cel6=rowHd.createCell(6);
				    	cel5.setCellValue(supplierPriceRemarkSupplierName.get(i).getSupplierName());
				    	cel6.setCellValue(supplierPriceRemarkSupplierName.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
				    	
				    	sc += supplierPriceRemarkSupplierName.get(i).getSupplierCost().setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				    	srow++;
				    	tt++;
			    	}
			    }
				
				if(sdow > srow){
					end = sdow -1;
				}else{
					end = srow -1;
				}
				
				end = sdow -1;
				//int hh=begin+tt;
				HSSFRow rowHd1 = null;
				if(sh.getRow(rr) != null){
	    			rowHd1 = sh.getRow(rr);
	    		}
				
				HSSFCell cel7=rowHd1.createCell(7);
		    	HSSFCell cel8=rowHd1.createCell(8);
		    	HSSFCell cel9=rowHd1.createCell(9);
				sh.addMergedRegion(new CellRangeAddress(begin, end, 0, 0));
		    	cel7.setCellValue(sp);
		    	cel8.setCellValue(sc);
		    	cel9.setCellValue(sp-sc);
		    	begin = end + 1;
		    	end = begin ;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void save(HSSFWorkbook Wb,OutputStream os){
		try{
			Wb.write(os);
			os.flush();
			os.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		CreateOrderTour.createOrder();
	}
	
}
