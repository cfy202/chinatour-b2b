package com.chinatour.util;

import java.awt.Color;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;

import com.chinatour.entity.Enquirys;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.PageSize;
import com.lowagie.text.Table;
import com.lowagie.text.rtf.RtfWriter2;


public class EnquiryItemsExcel {

	public static void createEnquiryItemsPlan(
			Enquirys enquirys, OutputStream os) {
		
		EnquiryItemsExcel.word(enquirys,os);
		try {
		/*	EnquiryItems enquiryItems = new EnquiryItems();
			for (int i = 0; i < enquiryItemsList.size(); i++) {
				enquiryItems = enquiryItemsList.get(i);
			}
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sh = wb.createSheet("Enquiry");
			sh = setColumnWidthForOneRow(sh);
			
			
			HSSFCellStyle titleStyle = wb.createCellStyle(); // 在工作薄的基础上建立一个样式
			titleStyle.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE); // 设置边框样式
			titleStyle.setBorderLeft((short) 1); // 左边框
			titleStyle.setBorderRight((short) 1); // 右边框
			titleStyle.setBorderTop(HSSFCellStyle.BORDER_DOUBLE); // 顶边框
			titleStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index); // 填充的背景颜色
			titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND); // 填充图案

			
			HSSFCellStyle cellStyle=wb.createCellStyle();
	    	cellStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	    	cellStyle.setVerticalAlignment(HSSFCellStyle.ALIGN_LEFT);
	    	cellStyle.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE); // 设置边框样式
	    	cellStyle.setBorderLeft((short) 1); // 左边框
	    	cellStyle.setBorderRight((short) 1); // 右边框
	    	cellStyle.setBorderTop(HSSFCellStyle.BORDER_DOUBLE); // 顶边框
	    	
			// 第三行
			HSSFRow rowHead2 = sh.createRow(0);
			rowHead2 = setCell(rowHead2);
			rowHead2.getCell(0).setCellStyle(titleStyle);
			rowHead2.getCell(2).setCellStyle(titleStyle);
			String[] str2 = { "抵达时间:",enquiryItems.getArriveDate()==null?"":dt.format(enquiryItems.getArriveDate()),
					"州:", enquiryItems.getStateID() };
			rowHead2 = setCellOfValue(rowHead2, str2);

			// 第四行
			HSSFRow rowHead3 = sh.createRow(1);
			rowHead3 = setCell(rowHead3);
			rowHead3.getCell(0).setCellStyle(titleStyle);
			rowHead3.getCell(2).setCellStyle(titleStyle);
			String[] str3 = { "酒店等级:", enquiryItems.getHotelStandard(),
					" 人种:", enquiryItems.getHumanRaceID() };
			rowHead3 = setCellOfValue(rowHead3, str3);

			// 第五行
			HSSFRow rowHead4 = sh.createRow(2);
			rowHead4 = setCell(rowHead4);
			rowHead4.getCell(0).setCellStyle(titleStyle);
			rowHead4.getCell(2).setCellStyle(titleStyle);
			String[] str4 = { "语言:", enquiryItems.getLanguageID()," Nationality:", enquiryItems.getCountryID() };
			rowHead4 = setCellOfValue(rowHead4, str4);

			// 第六行
			HSSFRow rowHead5 = sh.createRow(3);
			rowHead5 = setCell(rowHead5);
			rowHead5.getCell(0).setCellStyle(titleStyle);
			rowHead5.getCell(2).setCellStyle(titleStyle);
			if (enquiryItems.getShoppingOption() == 1) {
				String[] str5 = { "是否购物:", "是", "成人人数:", Integer.toString(enquiryItems.getAmountOfAdult())};
				rowHead5 = setCellOfValue(rowHead5, str5);
			} else {
				String[] str5 = { "是否购物:", "否", "成人人数:", Integer.toString(enquiryItems.getAmountOfAdult())};
				rowHead5 = setCellOfValue(rowHead5, str5);
			}

			// 第七行
			HSSFRow rowHead6 = sh.createRow(4);
			rowHead6 = setCell(rowHead6);
			rowHead6.getCell(0).setCellStyle(titleStyle);
			rowHead6.getCell(2).setCellStyle(titleStyle);
			String[] str6 = { "小于12岁人数:",
					Integer.toString(enquiryItems.getAmountBelow12()),
					"无购物能力",
					Integer.toString(enquiryItems.getAmountBelow21())};
			rowHead6 = setCellOfValue(rowHead6, str6);

			// 第八行
			HSSFRow rowHead7 = sh.createRow(5);
			rowHead7 = setCell(rowHead7);

			// 第九行
			HSSFRow rowHead8 = sh.createRow(6);
			rowHead8 = setCell(rowHead8);
			rowHead8.getCell(0).setCellStyle(titleStyle);
			String[] str8 = { "客人特殊要求:" };
			rowHead8 = setCellOfValue(rowHead8, str8);
			
			// 第十行
			HSSFRow rowHead9 = sh.createRow(7);
			rowHead9.setHeight((short) 2000);
			rowHead9 = setCell(rowHead9);
			// 合并单元格  9-13行 ，0-4行
			sh.addMergedRegion(new CellRangeAddress(7, 7, 0, 3));
			rowHead9.getCell(0).setCellStyle(cellStyle);
			String[] str9 = { enquiryItems.getSpecialRequirment() };
			rowHead9 = setCellOfValue(rowHead9, str9);

			// 第十一行
			HSSFRow rowHead10 = sh.createRow(8);
			rowHead10 = setCell(rowHead10);
			rowHead10.getCell(0).setCellStyle(titleStyle);
			String[] str10 = { "团队注意事项和备注" };
			rowHead10 = setCellOfValue(rowHead10, str10);

			// 第十二行
			HSSFRow rowHead11 = sh.createRow(9);
			rowHead11.setHeight((short) 2000);
			rowHead11 = setCell(rowHead11);
			// 合并单元格  9-13行 ，0-4行
			sh.addMergedRegion(new CellRangeAddress(9, 9, 0, 3));
			rowHead11.getCell(0).setCellStyle(cellStyle);
			String[] str11 = { enquiryItems.getCommentOfTour() };
			rowHead11 = setCellOfValue(rowHead11, str11);

			// 第13行
			HSSFRow rowHead12 = sh.createRow(10);
			rowHead12 = setCell(rowHead12);
			rowHead12.getCell(0).setCellStyle(titleStyle);
			String[] str12 = { "备注信息" };
			rowHead12 = setCellOfValue(rowHead12, str12);

			// 第14行
			HSSFRow rowHead13 = sh.createRow(11);
			rowHead13.setHeight((short) 2000);
			rowHead13 = setCell(rowHead13);
			// 合并单元格  9-13行 ，0-4行
			sh.addMergedRegion(new CellRangeAddress(11,11, 0, 3));
			rowHead13.getCell(0).setCellStyle(cellStyle);
			String[] str13 = { enquiryItems.getRemarks() };
			rowHead13 = setCellOfValue(rowHead13, str13);

			// 第15行
			HSSFRow rowHead14 = sh.createRow(12);
			rowHead14 = setCell(rowHead14);
			rowHead14.getCell(0).setCellStyle(titleStyle);
			String[] str14 = { "自主路线具体行程" };
			rowHead14 = setCellOfValue(rowHead14, str14);

			// 第16行
			HSSFRow rowHead15 = sh.createRow(13);
			rowHead15.setHeight((short) 2000);
			rowHead15 = setCell(rowHead15);
			// 合并单元格  9-13行 ，0-4行
			rowHead15.getCell(0).setCellStyle(cellStyle);
			sh.addMergedRegion(new CellRangeAddress(13, 13, 0, 3));
			String[] str15 = { enquiryItems.getPrivateTravelDetails() };
			rowHead15 = setCellOfValue(rowHead15, str15);*/

			//EnquiryItemsExcel.createCustomer(wb, os);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static HSSFRow setCell(HSSFRow rowHead) {
		rowHead.createCell(0);
		rowHead.createCell(1);
		rowHead.createCell(2);
		rowHead.createCell(3);
		return rowHead;
	}

	public static HSSFRow setCellStyleColor(HSSFRow rowHead, int cell,
			HSSFCellStyle cellStyle) {
		rowHead.getCell(cell).setCellStyle(cellStyle);
		return rowHead;
	}

	public static HSSFRow setCellOfValue(HSSFRow rowHead, String[] str) {
		for (int i = 0; i < str.length; i++) {
			rowHead.getCell(i).setCellValue(str[i]);
		}
		return rowHead;
	}

	public static HSSFSheet setColumnWidthForOneRow(HSSFSheet sh) {
		sh.setColumnWidth(0, (int) 60 * 110);
		sh.setColumnWidth(1, (int) 70* 110);
		sh.setColumnWidth(2, (int) 60 * 110);
		sh.setColumnWidth(3, (int) 70* 110);
		return sh;
	}

	public static void createCustomer(Document document,OutputStream os) {
		try {
			EnquiryItemsExcel.save(document, os);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void leftTitle(HSSFWorkbook wb, HSSFSheet sh, int rows,
			String title) {

		HSSFRow rowHead2 = sh.createRow(rows);
		sh.setColumnWidth(0, (int) 35.7 * 100);
		sh.setColumnWidth(1, (int) 35.7 * 110);
		sh.setColumnWidth(2, (int) 35.7 * 110);
		sh.setColumnWidth(3, (int) 35.7 * 110);
		sh.setColumnWidth(4, (int) 35.7 * 110);
		sh.setColumnWidth(5, (int) 35.7 * 110);
		sh.setColumnWidth(6, (int) 35.7 * 110);
		sh.setColumnWidth(7, (int) 35.7 * 110);

		HSSFCell celHd1 = rowHead2.createCell(0);
		HSSFCell celHd2 = rowHead2.createCell(1);
		HSSFCell celHd3 = rowHead2.createCell(2);
		HSSFCell celHd4 = rowHead2.createCell(3);
		HSSFCell celHd5 = rowHead2.createCell(4);
		HSSFCell celHd6 = rowHead2.createCell(5);
		HSSFCell celHd7 = rowHead2.createCell(6);

		celHd1.setCellValue(title);
		celHd2.setCellValue("");
		celHd3.setCellValue("");
		celHd4.setCellValue("");
		celHd5.setCellValue("");
		celHd6.setCellValue("");
		celHd7.setCellValue("");

		CellStyle cel2 = wb.createCellStyle();
		cel2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		celHd1.setCellStyle(cel2);
	}

	/*public static void save(HSSFWorkbook Wb, OutputStream os) {
		try {
			Wb.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/

	public static void save(Document document, OutputStream os) {
		try {
			os.flush();
			os.close();
			
			/**
			 * 功能:将数据库中的数据导出word
			 * 日期:2008-2-29
			 * @return 
			 */
				/*InputStream ins = ServletActionContext.getServletContext().getResourceAsStream("/empty.doc");
				byte[] b = new byte[ins.available()];
				ins.read(b);
				ins.close();
				String newFileName = ServletActionContext.getServletContext().getRealPath("")+ "/"+filename;
				os = new FileOutputStream(newFileName);
				os.write(b);
				os.close();
				return newFileName;*/
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getWeekOfDate(Date dt) {
		String[] weekDays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);

		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0)
			w = 0;

		return weekDays[w];
	}

	
	public static void word(Enquirys enquirys, OutputStream os) {
		Document document = new Document(PageSize.A4);// 创建word文档,并设置纸张的大小
		try {
			RtfWriter2.getInstance(document, os);
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
			document.open();
			/*
			 * 关于rtf格式的文件: RTF格式是许多软件都能够识别的文件格式。比如Word、WPS
			 * Office、Excel等都可以打开RTF格式的文件，这说明这种格式是较为通用的。
			 * 
			 * RTF是Rich Text
			 * Format的缩写，意即多文本格式。这是一种类似DOC格式（Word文档）的文件，有很好的兼容性，使用Windows
			 * “附件”中的“写字板
			 * ”就能打开并进行编辑。使用“写字板”打开一个RTF格式文件时，将看到文件的内容；如果要查看TRF格式文件的源代码
			 * ，只要使用“记事本”将它打开就行了。这就是说，你完全可以像编辑HTML文件一样，使用“记事本”来编辑RTF格式文件。
			 * 
			 * 对普通用户而言，RTF格式是一个很好的文件格式转换工具，用于在不同应用程序之间进行格式化文本文档的传送。
			 * 
			 * 通用兼容性应该是RTF的最大有点，但同时也就具有它的缺点，比如文件一般相对较大（可能因为嵌入了兼容各种应用程序的控制符号吧）、
			 * WORD等应用软件特有的格式可能无法正常保存等。
			 */
			// 设置中文字体
			// BaseFont bfFont =
			// BaseFont.createFont("STSongStd-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
			// Font chinaFont = new Font();
			/*
			 * 创建有三列的表格
			 */
			Table table = new Table(2);
			table.setBorderWidth(0);
			float[] widths = {0.1f,0.3f};
			table.setWidths(widths);
			table.setBorderColor(Color.RED);
			table.setPadding(1);
			table.setSpacing(1);
			/*
			 * 添加表头的元素
			 */
			/*Cell cell = new Cell(enquiryItems.getEnquiryItemsNo());// 单元格
			cell.setHeader(true);
			cell.setColspan(2);// 设置表格为三列
			cell.setRowspan(1);// 设置表格为三行
			table.addCell(cell);
			table.endHeaders();// 表头结束
*/			
			Cell cell = new Cell("Arrival Date: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell(enquirys.getArriveDate()==null?"":dt.format(enquirys.getArriveDate()));
			cell = new Cell("State: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell( enquirys.getStateId());
			cell = new Cell("Hotel: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell( enquirys.getHotelStandard());
			cell = new Cell("Race: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell(enquirys.getHumanRaceId());
			cell = new Cell("Language: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell( enquirys.getLanguageId());
			cell = new Cell("Nationality:  " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell( enquirys.getCountryId());
			if (enquirys.getShoppingOption().equals("1")) {
				cell = new Cell("Shopping: " );
				cell.setBackgroundColor(Color.CYAN );
				table.addCell(cell);
				table.addCell("Yes" );
				
			}else {
				cell = new Cell("Shopping: " );
				cell.setBackgroundColor(Color.CYAN );
				table.addCell(cell);
				table.addCell("No" );
			}
			
			cell = new Cell("Adult: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell( Integer.toString(enquirys.getAmountOfAdult()));
			cell = new Cell("Child: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell(Integer.toString(enquirys.getAmountBelow12()));
			cell = new Cell("No Shopping(Under 21): " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell( Integer.toString(enquirys.getAmountBelow21()));
			cell = new Cell("Brand: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell(enquirys.getBrand());
			cell = new Cell("Type: " );
			cell.setBackgroundColor(Color.CYAN );
			table.addCell(cell);
			table.addCell(enquirys.getTourTypeId());
			
			
			// 表格的主体
			cell = new Cell("Requirement:");
			cell.setBackgroundColor(Color.CYAN );
			cell.setColspan(2);// 当前单元格占两行,纵向跨度
			table.addCell(cell);
			cell = new Cell(enquirys.getSpecialRequirment());
			cell.setColspan(2);// 当前单元格占两行,纵向跨度
			table.addCell(cell);
			
			cell = new Cell("Note:");
			cell.setBackgroundColor(Color.CYAN );
			cell.setColspan(2);
			table.addCell(cell);
			cell = new Cell(enquirys.getCommentOfTour());
			cell.setColspan(2);// 当前单元格占两行,纵向跨度
			table.addCell(cell);
			
			cell = new Cell("Remark:");
			cell.setBackgroundColor(Color.CYAN );
			cell.setColspan(2);
			table.addCell(cell);
			cell = new Cell(enquirys.getRemarks());
			cell.setColspan(2);// 当前单元格占两行,纵向跨度
			table.addCell(cell);
			
			cell = new Cell("Itinerary:");
			cell.setBackgroundColor(Color.CYAN );
			cell.setColspan(2);
			table.addCell(cell);
			cell = new Cell(enquirys.getPrivateTravelDetails());
			cell.setColspan(2);// 当前单元格占两行,纵向跨度
			table.addCell(cell);
			
			document.add(table);
			document.close();
			EnquiryItemsExcel.createCustomer(document, os);
			
		}  catch (DocumentException e) {
			e.printStackTrace();
		} 
	}
	
}
