/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;

import com.chinatour.Constant;
import com.chinatour.Setting;
import com.chinatour.entity.Admin;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.PeerUser;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.PDFService;
import com.chinatour.service.PeerUserService;
import com.chinatour.util.FreemarkerUtils;
import com.chinatour.util.SettingUtils;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

/**
 * Service - 文件
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("pDFServiceImpl")
public class PDFServiceImpl implements PDFService, ServletContextAware {

	/** servletContext */
	private ServletContext servletContext;

	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	
	@Resource(name = "groupLineMapper")
	private GroupLineMapper groupLineMapper;
	
	@Resource(name = "groupRouteMapper")
	private GroupRouteMapper groupRouteMapper;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private PeerUserService peerUserService;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}


	@Override
	public String createPdf(String id) {
		Admin admin = adminService.getCurrent();
		String adminId=null;
		if(admin!=null){
			adminId = admin.getId();
		}else{
			PeerUser peerUser=peerUserService.getCurrent();
			adminId=peerUser.getPeerUserId();
		}
		GroupLine groupLine = groupLineMapper.findHotelByGroupLineId(id);
		Setting setting = SettingUtils.get();
		String uploadPath = setting.getTempPDFPath();
		String destPath = null;
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			String path = FreemarkerUtils.process(uploadPath, model);
			 destPath = path + "GroupLine"+adminId+".pdf";
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			
			// 创建一个Document对象
			Document document = new Document(PageSize.A4, 36, 36, 24, 36);
			try {
				// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
				BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "UniGB-UCS2-H", false);  
		        Font fontChinese = new Font(bfChinese, 18, Font.NORMAL, Color.GRAY);   
		        Font fontChineseContent = new Font(bfChinese, 12, Font.BOLD, Color.GRAY);
		        Font fontChineseForTableHead = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
		        Font fontChineseContentForDes = new Font(bfChinese, 11, Font.NORMAL, Color.GRAY);
		        Font fontChineseContentForBold = new Font(bfChinese, 12, Font.NORMAL, Color.BLACK);
		        Font fontChineseForBold = new Font(bfChinese, 18, Font.NORMAL, Color.BLACK);
		        
				// 打开文档，将要写入内容
				document.open();
				// 添加抬头图片
				PdfPTable table1 = new PdfPTable(3); //表格两列
				table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table1.setWidthPercentage(100);//表格的宽度为100%
				float[] wid2 ={0.2f,0.40f,0.30f}; //两列宽度的比例
				table1.setWidths(wid2); 
				table1.getDefaultCell().setBorderWidth(0); //不显示边框
				
				String logo = "";
				if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
					logo = Constant.LOGO_PATH[0];
				}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
					logo = Constant.LOGO_PATH[1];
				}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
					logo = Constant.LOGO_PATH[2];
				}else{
					logo = Constant.LOGO_PATH[3];
				}
				
				if(logo.equals(Constant.LOGO_PATH[3])||logo.equals(Constant.LOGO_PATH[2])){
					float[] wid1 ={0.3f,0.3f,0.4f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					float[] wid1 ={0.3f,0.40f,0.2f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[0])){
					float[] wid1 ={0.3f,0.35f,0.35f};
					table1.setWidths(wid1);
				}
				Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
				jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
				table1.addCell(jpeg);
				PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
				cell1.setBorder(Rectangle.NO_BORDER);
				table1.addCell(cell1);
				
				//右侧嵌套一个表格
				PdfPTable table13 = new PdfPTable(1);
				table13.getDefaultCell().setBorderWidth(0);
				PdfPCell cell2 = new PdfPCell(table13);
				cell2.setBorder(0);
				table1.addCell(cell2);
				
				//Logo文字标识
				String logoInDentifying="";
				if(logo.equals(Constant.LOGO_PATH[0])){
					logoInDentifying="中国美";
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					logoInDentifying="Chinatour.com";
				}else if(logo.equals(Constant.LOGO_PATH[2])){
					logoInDentifying="文景假期";
				}else{
					logoInDentifying="InterTrips";
				}
				
				PdfPCell cell21 = new PdfPCell(new Paragraph(logoInDentifying,fontChinese));
				cell21.setBorder(0);
				cell21.setMinimumHeight(10f);
				table13.addCell(cell21);
				
				PdfPCell cell22 = new PdfPCell(new Paragraph(" ",fontChineseContent));
				cell22.setBorder(0);
				cell22.setMinimumHeight(10f);
				table13.addCell(cell22);
				
				PdfPCell cell24 = new PdfPCell(new Paragraph(" ",fontChineseContentForDes));
				cell24.setBorder(0);
				cell24.setMinimumHeight(10f);
				table13.addCell(cell24);
				
				PdfPCell cell23 = new PdfPCell(new Paragraph(" "+admin.getAddress(),fontChineseContentForDes));
				cell23.setBorder(0);
				cell23.setMinimumHeight(10f);
				table13.addCell(cell23);
				
				PdfPCell cell25 = new PdfPCell(new Paragraph(" "+admin.getTel(),fontChineseContentForDes));
				cell25.setBorder(0);
				cell25.setMinimumHeight(10f);
				table13.addCell(cell25);
				
				PdfPCell cell26 = new PdfPCell(new Paragraph(" "+admin.getEmail(),fontChineseContentForDes));
				cell26.setBorder(0);
				cell26.setMinimumHeight(10f);
				table13.addCell(cell26);
				
				table1.addCell(cell1);
				document.add(table1);
				
				PdfContentByte cb=writer.getDirectContent();
				cb.setLineWidth(0.3f);
				cb.moveTo(40f, 700f);
				cb.lineTo(560f, 700f);
				cb.setColorStroke(Color.GRAY);
				cb.stroke();
				//线路名称
				Paragraph lineTittle = new Paragraph(groupLine.getTourName(),fontChineseForBold);
				lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
				lineTittle.setSpacingAfter(10f);
				lineTittle.setSpacingBefore(10f);
				document.add(lineTittle);
				
				PdfPCell space = new PdfPCell(new Paragraph(" ",fontChineseContent));
				space.setBorder(0);
				cb.setLineWidth(0.3f);
				cb.moveTo(40f, 600f);
				cb.lineTo(560f, 600f);
				cb.setColorStroke(Color.GRAY);
				cb.stroke();
				
				//添加行程信息
				Paragraph groupRouteTittle = new Paragraph("TOUR 	ITINERARY",fontChineseForBold);
				groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
				groupRouteTittle.setSpacingAfter(10f);
				groupRouteTittle.setSpacingBefore(12f);
				document.add(groupRouteTittle);
				List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(id);
				for(GroupRoute groupRoute:groupRoutes){
					Paragraph dayNumAndRouteName = new Paragraph("Day"+groupRoute.getDayNum()+":	"+groupRoute.getRouteName(),fontChineseContentForBold);
					dayNumAndRouteName.setSpacingAfter(2f);
					document.add(dayNumAndRouteName);
					Paragraph routeDesc = new Paragraph(groupRoute.getRouteDescribeForEn(),fontChineseContentForDes);
					routeDesc.setSpacingAfter(10f);
					document.add(routeDesc);
				}
				
				//添加酒店信息
				Paragraph hotelInfoTittle = new Paragraph("HOTEL INFOMATION",fontChineseForBold);
				hotelInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
				hotelInfoTittle.setSpacingAfter(10f);
				hotelInfoTittle.setSpacingBefore(15f);
				document.add(hotelInfoTittle);
				
				PdfPTable hotelData = new PdfPTable(3);
				hotelData.setWidthPercentage(100);
				hotelData.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell tableHeader = new PdfPCell();
				tableHeader.setBorder(0);
				tableHeader.setBorderColorBottom(Color.GRAY);
				tableHeader.setBorderWidthBottom(0.3f);
				tableHeader.setBorderWidthTop(1.5f);
				tableHeader.setMinimumHeight(30f);
				tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeader.setMinimumHeight(25f);
				tableHeader.setBorderWidth(0.5f);
				tableHeader.setPhrase(new Phrase("Name",fontChineseForTableHead));
				hotelData.addCell(tableHeader);
				tableHeader.setPhrase(new Phrase("Tel",fontChineseForTableHead));
				hotelData.addCell(tableHeader);
				tableHeader.setPhrase(new Phrase("Address",fontChineseForTableHead));
				hotelData.addCell(tableHeader);
				List<GroupLineHotelRel> groupLineHotelRels = groupLine.getGroupLineHotelRel();
				for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
					
					PdfPCell hotelName = new PdfPCell();
					hotelName.setBorder(0);
					hotelName.setBorderColorBottom(Color.GRAY);
					hotelName.setBorderWidthBottom(0.3f);
					hotelName.setMinimumHeight(32f);
					hotelName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					hotelName.addElement(new Phrase(groupLineHotelRel.getHotel().getHotelName(),fontChineseContentForDes));
					hotelData.addCell(hotelName);
					
					PdfPCell tel = new PdfPCell();
					tel.setBorder(0);
					tel.setBorderColorBottom(Color.GRAY);
					tel.setBorderWidthBottom(0.3f);
					tel.setMinimumHeight(32f);
					tel.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tel.addElement(new Phrase(groupLineHotelRel.getHotel().getTel(),fontChineseContentForDes));
					hotelData.addCell(tel);
					
					PdfPCell address = new PdfPCell();
					address.setBorder(0);
					address.setBorderColorBottom(Color.GRAY);
					address.setBorderWidthBottom(0.3f);
					address.setMinimumHeight(32f);
					address.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					address.addElement(new Phrase(groupLineHotelRel.getHotel().getAddress(),fontChineseContentForDes));
					hotelData.addCell(address);
					
				}
				document.add(hotelData);
					
					//添加特殊条款
					Paragraph specificItems = new Paragraph("SPECIFICITEMS",fontChineseForBold);
					specificItems.setSpacingAfter(8f);
					specificItems.setSpacingBefore(10f);
					Paragraph specific = new Paragraph(groupLine.getSpecificItems(),fontChineseContentForDes);
					document.add(specificItems);
					document.add(specific);
					
					//溫馨提示
					/*Paragraph prompt = new Paragraph("*溫馨提示",new Font(bfChinese, 12, Font.BOLD, Color.red));
					document.add(prompt);
					Paragraph promptContent = new Paragraph(groupLine.getSpecificItems(),fontChineseContent);
					document.add(promptContent);*/
			} catch (DocumentException de) {
				System.err.println(de.getMessage());
			} catch (IOException ioe) {
				System.err.println(ioe.getMessage());
			}

			// 关闭打开的文档
			document.close();
			
			return destPath;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return destPath;
	}

}