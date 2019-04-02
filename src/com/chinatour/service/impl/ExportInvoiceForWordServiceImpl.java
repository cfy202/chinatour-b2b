package com.chinatour.service.impl;

import java.awt.Color;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import com.chinatour.Constant;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.TourTypeOfDept;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.persistence.CountryMapper;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.DiscountMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.PaymentMapper;
import com.chinatour.persistence.ReceivableInfoOfOrderMapper;
import com.chinatour.persistence.SOrderReceiveItemMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.persistence.TourTypeOfDeptMapper;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.ExportInvoiceForWordService;
import com.chinatour.service.ExportVoucherForWordService;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;


@Service("ExportInvoiceForWordServiceImpl")
public class ExportInvoiceForWordServiceImpl implements  ExportInvoiceForWordService{
	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	
	@Resource(name = "orderMapper")
	private OrderMapper orderMapper;
	
	@Resource(name = "groupRouteMapper")
	private GroupRouteMapper groupRouteMapper;
	
	@Resource(name = "payCostRecordsMapper")
	private PayCostRecordsMapper payCostRecordsMapper;
	
	@Resource(name = "customerOrderRelMapper")
	private CustomerOrderRelMapper customerOrderRelMapper;
	
	@Resource(name = "receivableInfoOfOrderMapper")
	private ReceivableInfoOfOrderMapper receivableInfoOfOrderMapper;
	
	@Resource(name = "customerMapper")
	private CustomerMapper customerMapper;
	
	@Resource(name = "adminMapper")
	private AdminMapper adminMapper;
	
	@Resource(name = "tourMapper")
	private TourMapper tourMapper;
	
	@Autowired
	private TOrderReceiveItemMapper tOrderReceiveItemMapper;
	
	@Autowired
	private SOrderReceiveItemMapper sOrderReceiveItemMapper;
	
	@Autowired
	private TourInfoForOrderMapper tourInfoForOrderMapper;
	
	
	@Resource(name = "countryMapper")
	private CountryMapper countryMapper;
	
	@Resource(name = "ordersTotalMapper")
	private OrdersTotalMapper ordersTotalMapper;
	
	@Resource(name = "venderMapper")
	private VenderMapper venderMapper;
	
	@Resource(name = "deptMapper")
	private DeptMapper deptMapper;
	
	@Resource(name = "groupLineMapper")
	private GroupLineMapper groupLineMapper;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name = "paymentMapper")
	private PaymentMapper paymentMapper;
	
	@Resource(name = "discountMapper")
	private DiscountMapper discountMapper;
			
	@Resource(name="servletContext")
	private ServletContext servletContext;
	
	@Override
	public InputStream getWordFile(String orderId) throws Exception {
		Order order = orderMapper.findById(orderId);
		String orderNumber = order.getOrderNo();
		//获取该子订单对应的总订单
		OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
		
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orderId);
		GroupLine groupLine = groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
		
		String companyId = ordersTotal.getCompanyId();
    	Vender vender = venderMapper.findById(companyId);
    	
		Document doc=new Document(PageSize.A4);//创建DOC
		ByteArrayOutputStream byteArrayOut=new ByteArrayOutputStream();//创建新字节输出流
		RtfWriter2.getInstance(doc, byteArrayOut);//建立一个书写器与doc对象关联，通过书写器可以将文档写入到输出流中
		doc.open();//打开文档
		RtfFont titleFontForBold=new RtfFont("宋体", 16, Font.BOLD, Color.BLACK);//标题字体()
		RtfFont titleFontForBoldForRemark=new RtfFont("宋体", 16, Font.BOLD, Color.RED);//备注信息标题文字
		RtfFont contextFontForTableHead=new RtfFont("宋体", 14, Font.BOLD, Color.BLACK);//内容标头字体
		RtfFont contextFont=new RtfFont("宋体", 11, Font.NORMAL, Color.BLACK);//内容字体
		RtfFont contextFontForTittle=new RtfFont("宋体", 12, Font.BOLD, Color.BLACK);//内容字体(基础信息的头部分)
		RtfFont contextFontForRemark=new RtfFont("宋体", 12, Font.NORMAL, Color.RED);//内容字体
		String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
		BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
		
		//内容
		Table table1=new Table(3);
		String logoPath = "";
		//String brand = groupLine.getBrand(); 
		if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
			logoPath = Constant.LOGO_PATH[0];
		}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
			logoPath = Constant.LOGO_PATH[1];
		}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
			logoPath = Constant.LOGO_PATH[2];
		}else{
			logoPath = Constant.LOGO_PATH[3];
		}
		
		
		float[] widths={0.4f,0.2f,0.4f};
		if(logoPath.equals(Constant.LOGO_PATH[3])){
			float[] wid1 ={0.45f,0.25f,0.30f};
			table1.setWidths(wid1);
		}else if(logoPath.equals(Constant.LOGO_PATH[1])||logoPath.equals(Constant.LOGO_PATH[2])){
			float[] wid1 ={0.2f,0.40f,0.30f};
			table1.setWidths(wid1);
		}else if(logoPath.equals(Constant.LOGO_PATH[0])){
			float[] wid1 ={0.25f,0.45f,0.30f};
			table1.setWidths(wid1);
		}
		

		//标头显示的信息
		//无论是否为同行右上方都显示本部门信息
		//如果为同行，则基础信息显示billTo为同行公司名称，agent为联系人信息，加上同行公司的地址，邮箱，电话
		//本部门信息
		String addressForDept = "";
	    String telForDept = "";
	    String mailForDept = "";
	    Admin agen = adminService.findById(ordersTotal.getUserId());
    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
    	addressForDept = deptForAgent.getAddress();
    	telForDept = deptForAgent.getTel();
    	mailForDept = deptForAgent.getEmail();
		//设置页头内容
		
		Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logoPath);
		jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
		jpeg.setAlignment(Image.ALIGN_TOP);
		//设定没列宽度
		table1.setWidths(widths);
		table1.setWidth(100);//设置表格所在word宽度
		table1.setAlignment(Element.ALIGN_CENTER);//设置表格字体居中
		table1.setAutoFillEmptyCells(true);//设置表格自动填满
		table1.setBorderWidth(0);
		table1.getDefaultCell().setBorderWidth(0);
		Cell cell11 = new Cell(jpeg);
		cell11.setBorder(0);
		
		Cell cell12 = new Cell();
		cell12.setBorder(0);
		
		Table table13 = new Table(1);
		Cell cell21 = new Cell(new Paragraph(addressForDept));
		cell21.setBorder(0);
		table13.addCell(cell21);
		
		Cell cell24 = new Cell(new Paragraph(""));
		cell24.setBorder(0);
		table13.addCell(cell24);
		
		Cell cell25 = new Cell(new Paragraph("Tel:"+telForDept));
		cell25.setBorder(0);
		table13.addCell(cell25);
		
		Cell cell26 = new Cell(new Paragraph("Email:"+mailForDept));
		cell26.setBorder(0);
		table13.addCell(cell26);
		
		Cell cell13 = new Cell(table13);
		table1.addCell(cell11);
		table1.addCell(cell12);
		table1.addCell(cell13);
		doc.add(table1);
		
		//添加线路基本信息
		
		Table table3 = new Table(4);
		table3.setPadding(4f);
		table3.setWidth(100);
		float[] wid2 ={0.15f,0.35f,0.15f,0.35f}; //两列宽度的比例
		table3.setWidths(wid2); 
		table3.getDefaultCell().setBorderWidth(0); //不显示边框
		
		
		Cell cell011 = new Cell(new Paragraph("Invoice No:      "));
		cell011.setBorder(0);
		cell011.setBorderWidthTop(0.3f);
		cell011.setBorderColor(Color.GRAY);
		table3.addCell(cell011);
		
		Cell cell012 = new Cell(new Paragraph(order.getOrderNo()));
		cell012.setBorder(0);
		cell012.setBorderWidthTop(0.3f);
		cell012.setBorderColor(Color.GRAY);
		table3.addCell(cell012);
		
		Cell cell013 = new Cell(new Paragraph("Agent:              "));
		cell013.setBorder(0);
		cell013.setBorderColor(Color.GRAY);
		cell013.setBorderWidthTop(0.3f);
		table3.addCell(cell013);
		//如果为同行则显示同行联系人
		Cell cell014 = null;
		if(ordersTotal.getWr().equals("wholeSale")){
			if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
				cell014 = new Cell(new Paragraph(ordersTotal.getContactName()));
			}else{
				cell014 = new Cell(new Paragraph(""));
			}
		}else{
			cell014 = new Cell(new Paragraph(ordersTotal.getAgent()));
		}
		cell014.setBorder(0);
		cell014.setBorderColor(Color.GRAY);
		cell014.setBorderWidthTop(0.3f);
		table3.addCell(cell014);
		
		Cell cell021 = new Cell(new Paragraph("Tour Code:       "));
		cell021.setBorder(0);
		cell021.setBorderColor(Color.GRAY);
		table3.addCell(cell021);
		String tourCode = "";
		String departureDate = "";
		String tourName = "";
		if(order.getTourId()!=null&&order.getTourId()!=""){
			tourCode = order.getTourCode();
			String tourId = order.getTourId();
			Tour tour = tourMapper.findById(tourId);
			if(tour!=null){
				tourName = tour.getLineName();
			}
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
				departureDate = df.format(tourInfoForOrder.getScheduleOfArriveTime());
			}
		}
		Cell cell022 = new Cell(new Paragraph(tourCode));
		cell022.setBorder(0);
		table3.addCell(cell022);
		
		Cell cell023 = new Cell(new Paragraph("Tour Name:     "));
		cell023.setBorder(0);
		table3.addCell(cell023);
		
		Cell cell024 = new Cell(new Paragraph(tourName));
		cell024.setBorder(0);
		table3.addCell(cell024);
		
		Cell cell031 = new Cell(new Paragraph("Bill To:                 "));
		cell031.setBorder(0);
		table3.addCell(cell031);
		//如果为同行，则显示同行公司名称
		Cell cell032 = null;
		if(ordersTotal.getWr().equals("wholeSale")){
			if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
				cell032 = new Cell(new Paragraph(vender.getName())); 
			}else{
				cell032 = new Cell(new Paragraph(""));
			}
		}else{
			cell032 = new Cell(new Paragraph(ordersTotal.getContactName()));
		}
		cell032.setBorder(0);
		table3.addCell(cell032);
		
		Cell cell034 = null;
		Cell cell042 = null;
		Cell cell044 = null;
		Cell cell033 = new Cell(new Paragraph("Address:              "));
			cell033.setBorder(0);
			table3.addCell(cell033);
			
			cell034 = new Cell(new Paragraph(ordersTotal.getAddress()));
			cell034.setBorder(0);
			table3.addCell(cell034);
			
			Cell cell041 = new Cell(new Paragraph("Tel:                     "));
			cell041.setBorder(0);
			table3.addCell(cell041);
			
			cell042 = new Cell(new Paragraph(ordersTotal.getTel()));
			cell042.setBorder(0);
			table3.addCell(cell042);
			
			Cell cell043 = new Cell(new Paragraph("Email:               "));
			cell043.setBorder(0);
			table3.addCell(cell043);
			
			cell044 = new Cell(new Paragraph(ordersTotal.getEmail()));
			cell044.setBorder(0);
			table3.addCell(cell044);
			Cell cell051 = new Cell(new Paragraph("Person(s):         "));
		cell051.setBorder(0);
		table3.addCell(cell051);
		
		Cell cell052 = new Cell(new Paragraph(order.getTotalPeople().toString()));
		cell052.setBorder(0);
		table3.addCell(cell052);
		
		Cell cell053 = new Cell(new Paragraph("Departure Date:       "));
		cell053.setBorder(0);
		table3.addCell(cell053);
		
		Cell cell054 = new Cell(new Paragraph(departureDate));
		cell054.setBorder(0);
		table3.addCell(cell054);
		
		doc.add(table3);
		
		//添加payment
		Paragraph payment = new Paragraph("PAYMENT HISTORY",titleFontForBold);
		payment.setAlignment(Paragraph.ALIGN_CENTER);
		payment.setSpacingAfter(10f);
		payment.setSpacingBefore(10f);
		doc.add(payment);
		
		Table paymentData = new Table(5);
		paymentData.setPadding(4f);
		paymentData.setWidth(100);
		paymentData.getDefaultCell().setBorderWidth(0); //不显示边框
		float[] wid3 ={0.1f,0.2f,0.3f,0.3f,0.10f};
		paymentData.setWidths(wid3);
		paymentData.getDefaultCell().setBorderWidthBottom(0);
		
		Cell tableHeader = new Cell();
		tableHeader.setBorder(0);
		tableHeader.setBorderColorBottom(Color.GRAY);
		tableHeader.setBorderWidthBottom(0.3f);
		tableHeader.setBorderWidthTop(1.5f);
		tableHeader.setBorderWidth(0.5f);
		tableHeader=new Cell(new Paragraph("#",contextFontForTableHead));
		paymentData.addCell(tableHeader);
		tableHeader=new Cell(new Paragraph("Date",contextFontForTableHead));
		paymentData.addCell(tableHeader);
		tableHeader=new Cell(new Paragraph("Description",contextFontForTableHead));
		paymentData.addCell(tableHeader);
		tableHeader=new Cell(new Paragraph("Remark",contextFontForTableHead));
		paymentData.addCell(tableHeader);
		tableHeader=new Cell(new Paragraph("Amount",contextFontForTableHead));
		paymentData.addCell(tableHeader);
		
		 
		//获取每个子订单下的payment
		List<PayCostRecords> payCostRecords = new ArrayList<PayCostRecords>(); //存放所有的
			List<PayCostRecords> pays = payCostRecordsMapper.findByOrderId(order.getId());
			List<PayCostRecords> removePays = new ArrayList<PayCostRecords>();
			for(PayCostRecords payCostRecord:pays){
				if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
					removePays.add(payCostRecord);
				}
			}
			pays.removeAll(removePays);
			payCostRecords.addAll(pays);
		
		
		
		BigDecimal totalFee = new BigDecimal(0);
			if(payCostRecords!=null||payCostRecords.size()!=0){
				for(int i=0;i<payCostRecords.size();i++){
						totalFee = totalFee.add(payCostRecords.get(i).getSum());
							Cell payNo = new Cell();
						payNo.setBorder(0);
						payNo.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
						payNo.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
						payNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						payNo.addElement(new Phrase(Integer.toString(i+1)));
						paymentData.addCell(payNo);
						
						Cell date = new Cell();
						date.setBorder(0);
						date.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
						date.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
						date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
						date.addElement(new Phrase(payCostRecords.get(i).getTime()==null?"":simpleDateFormat.format(payCostRecords.get(i).getTime())));
						paymentData.addCell(date);
						
						Cell description = new Cell();
						description.setBorder(0);
						description.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
						description.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
						description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						description.addElement(new Phrase(payCostRecords.get(i).getItem()));
						paymentData.addCell(description);
						
						Cell remark = new Cell();
						remark.setBorder(0);
						remark.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
						remark.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
						remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						remark.addElement(new Phrase(payCostRecords.get(i).getRemark()));
						paymentData.addCell(remark);
						
						Cell amount = new Cell();
						amount.setBorder(0);
						amount.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
						amount.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
						amount.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						amount.addElement(new Phrase(payCostRecords.get(i).getSum().toString()));
						paymentData.addCell(amount);
					}
			}
		doc.add(paymentData);
		Paragraph total = new Paragraph("Total: "+totalFee,contextFontForTableHead);
		total.setAlignment(2);
		doc.add(total);
		
		//添加invoiceItems
		Paragraph invoiceItems = new Paragraph("INVOICE ITEMS",titleFontForBold);
		invoiceItems.setAlignment(Paragraph.ALIGN_CENTER);
		invoiceItems.setSpacingAfter(10f);
		invoiceItems.setSpacingBefore(10f);
		doc.add(invoiceItems);
		
		Table itemsData = new Table(6);
		itemsData.setPadding(4f);
		itemsData.setWidth(100);
		itemsData.getDefaultCell().setBorderWidth(0); //不显示边框
		float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
		itemsData.setWidths(wid4);
		itemsData.getDefaultCell().setBorderWidthBottom(0);
		
		Cell tableHeaderForItem = new Cell();
		tableHeaderForItem.setBorder(0);
		tableHeaderForItem.setBorderColorBottom(Color.GRAY);
		tableHeaderForItem.setBorderWidthBottom(0.3f);
		tableHeaderForItem.setBorderWidthTop(1.5f);
		tableHeaderForItem.setVerticalAlignment(Cell.ALIGN_MIDDLE);
		tableHeaderForItem.setBorderWidth(0.5f);
		tableHeader=new Cell(new Paragraph("#",contextFontForTableHead));
		paymentData.addCell(tableHeader);
		tableHeaderForItem=new Cell(new Paragraph("#",contextFontForTableHead));
		itemsData.addCell(tableHeaderForItem);
		tableHeaderForItem=new Cell(new Paragraph("Service",contextFontForTableHead));
		itemsData.addCell(tableHeaderForItem);
		tableHeaderForItem=new Cell(new Paragraph("Description",contextFontForTableHead));
		itemsData.addCell(tableHeaderForItem);
		tableHeaderForItem=new Cell(new Paragraph("Price",contextFontForTableHead));
		itemsData.addCell(tableHeaderForItem);
		tableHeaderForItem=new Cell(new Paragraph("Qty",contextFontForTableHead));
		itemsData.addCell(tableHeaderForItem);
		tableHeaderForItem=new Cell(new Paragraph("Total",contextFontForTableHead));
		itemsData.addCell(tableHeaderForItem);
		BigDecimal totalCostFee = new BigDecimal(0);
		List<OrderReceiveItem> orderReceiveItems = new ArrayList<OrderReceiveItem>(); //保存所有条目
			   ReceivableInfoOfOrder receivableInfoOfOrder = receivableInfoOfOrderMapper.findByOrderId(order.getId());
			   List<OrderReceiveItem> torderReceiveItems = new ArrayList<OrderReceiveItem>();
			   if(order.getOrderType()==5){//非团订单
				   torderReceiveItems = sOrderReceiveItemMapper.findByReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				   for(OrderReceiveItem orderReceiveItem:torderReceiveItems){
					   orderReceiveItem.setOrderType(order.getOrderType());
				   }
			   }else{//团订单、同行订单
				   torderReceiveItems = tOrderReceiveItemMapper.findByReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				   for(OrderReceiveItem orderReceiveItem:torderReceiveItems){
					   orderReceiveItem.setOrderType(order.getOrderType());
				   }
			   }
			   //List<OrderReceiveItem> sorderReceiveItems = sOrderReceiveItemMapper.findByReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
			   orderReceiveItems.addAll(torderReceiveItems);
			
			   List<OrderReceiveItem> itemsForMove = new ArrayList<OrderReceiveItem>();
				if(orderReceiveItems!=null){
					for(int i=0;i<orderReceiveItems.size();i++){
						if(orderReceiveItems.get(i).getItemFee()==null||orderReceiveItems.get(i).getItemFee().toString().length()==0||orderReceiveItems.get(i).getItemFee().intValue()==0){
							//orderReceiveItems.remove(orderReceiveItems.get(i));
							itemsForMove.add(orderReceiveItems.get(i));
						}
					}
					orderReceiveItems.removeAll(itemsForMove);
			
			for(int i=0;i<orderReceiveItems.size();i++){//1:visa 2:flight ticket 3:hotel 4:ticket 5:insurance 6:busTour 7:cruise 8:other 
				String service = "";
				if(orderReceiveItems.get(i).getOrderType()==5){ //非团订单
					int type = orderReceiveItems.get(i).getType();
					switch(type){
						case 1:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[0];
						break;
						case 2:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[1];
						break;
						case 3:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[2];
						break;
						case 4:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[3];
						break;
						case 5:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[4];
						break;
						case 6:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[5];
						break;
						case 7:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[6];
						break;
						case 8:
							service = Constant.SORDERRECEIVEITEMSOFTYPE[7];
						break;
						
					}
					
				}else{
					if(orderReceiveItems.get(i).getType()==1){
						service = Constant.TORDERRECEIVEITEMSOFTYPE[0];
					}else if(orderReceiveItems.get(i).getType()==2){
						service = Constant.TORDERRECEIVEITEMSOFTYPE[1];
					}else if(orderReceiveItems.get(i).getType()==3){
						service = Constant.TORDERRECEIVEITEMSOFTYPE[2];
					};
				}
							Cell orderReceiveItemNo = new Cell();
							orderReceiveItemNo.setBorder(0);
							orderReceiveItemNo.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
							orderReceiveItemNo.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
							orderReceiveItemNo.setVerticalAlignment(Cell.ALIGN_MIDDLE);
							orderReceiveItemNo.addElement(new Phrase(Integer.toString(i+1)));
							itemsData.addCell(orderReceiveItemNo);
						
						Cell serviceCell = new Cell();
						serviceCell.setBorder(0);
						serviceCell.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
						serviceCell.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
						serviceCell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
						serviceCell.addElement(new Phrase(service));
						itemsData.addCell(serviceCell);
						
						Cell description = new Cell();
						description.setBorder(0);
						description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
						description.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
						description.setVerticalAlignment(Cell.ALIGN_MIDDLE);
						description.addElement(new Phrase(orderReceiveItems.get(i).getRemark()));
						itemsData.addCell(description);
						
						Cell price = new Cell();
						price.setBorder(0);
						price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
						price.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
						price.setVerticalAlignment(Cell.ALIGN_MIDDLE);
						BigDecimal pri = orderReceiveItems.get(i).getItemFee();
						if(orderReceiveItems.get(i).getType()==3){
							pri = new BigDecimal(0).subtract(pri);
						}
						price.addElement(new Phrase(pri.toString()));
						itemsData.addCell(price);
						
						Cell num = new Cell();
						num.setBorder(0);
						num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
						num.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
						num.setVerticalAlignment(Cell.ALIGN_MIDDLE);
						num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString()));
						itemsData.addCell(num);
						
						Cell totalFe = new Cell();
						totalFe.setBorder(0);
						totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
						
						if(i==orderReceiveItems.size()-1){
							totalFe.setBorderColor(Color.BLACK);
							totalFe.setBorderWidthBottom(1.5f);
						}else{
							totalFe.setBorderColor(Color.GRAY);
							totalFe.setBorderWidthBottom(0.3f);
						}
						totalFe.setVerticalAlignment(Cell.ALIGN_MIDDLE);
						BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
						if(orderReceiveItems.get(i).getType()==3){
							itemFee = new BigDecimal(0).subtract(itemFee);
						}
						Integer mount = orderReceiveItems.get(i).getItemFeeNum();
						BigDecimal toMount = new BigDecimal(mount);
						totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString()));
						itemsData.addCell(totalFe);
						totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
							}
						
						}
			
		doc.add(itemsData);
		//小计
		Table subTotalData = new Table(3);
		subTotalData.setPadding(4f);
		subTotalData.setWidth(100);
		subTotalData.getDefaultCell().setBorderWidth(0); //不显示边框
		float[] wid6 ={0.72f,0.18f,0.1f};
		subTotalData.setWidths(wid6);
		
		Cell sub1 = new Cell();
		sub1.setBorder(0);
		sub1.addElement(new Phrase(""));
		subTotalData.addCell(sub1);
		
		Cell sub2 = new Cell();
		sub2.setBorder(0);
		sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		sub2.addElement(new Phrase("SubTotal:",contextFontForTableHead));
		subTotalData.addCell(sub2);
		
		Cell sub3 = new Cell();
		sub3.setBorder(0);
		sub3.addElement(new Phrase(totalCostFee.toString(),contextFontForTableHead));
		subTotalData.addCell(sub3);
		
		if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0){
			BigDecimal peerUserFee = new BigDecimal(0.00);
			if(order.getPeerUserFee()!=null){
				peerUserFee = order.getPeerUserFee();
			}
			Cell userFee1 = new Cell();
			userFee1.setBorder(0);
			userFee1.addElement(new Phrase(""));
			subTotalData.addCell(userFee1);
			
			Cell userFee2 = new Cell();
			userFee2.setBorder(0);
			userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			userFee2.addElement(new Phrase(" Commission:",contextFontForTableHead));
			subTotalData.addCell(userFee2);
			
			Cell userFee3 = new Cell();
			userFee3.setBorder(0);
			userFee3.addElement(new Phrase(peerUserFee.toString(),contextFontForTableHead));
			subTotalData.addCell(userFee3);
		}
		
		Cell paid1 = new Cell();
		paid1.setBorder(0);
		paid1.addElement(new Phrase("",contextFontForTableHead));
		subTotalData.addCell(paid1);
		
		Cell paid2 = new Cell();
		paid2.setBorder(0);
		paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		paid2.addElement(new Phrase("         Paid:",contextFontForTableHead));
		subTotalData.addCell(paid2);
		
		
		Cell paid3 = new Cell();
		paid3.setBorder(0);
		paid3.addElement(new Phrase(totalFee.toString(),contextFontForTableHead));
		subTotalData.addCell(paid3);
		
		Cell balance1 = new Cell();
		balance1.setBorder(0);
		balance1.addElement(new Phrase("",contextFontForTableHead));
		subTotalData.addCell(balance1);
		
		Cell balance2 = new Cell();
		balance2.setBorder(0);
		balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		balance2.addElement(new Phrase("   Balance:",contextFontForTableHead));
		subTotalData.addCell(balance2);
		
		Cell balance3 = new Cell();
		balance3.setBorder(0);
		BigDecimal bal = totalCostFee.subtract(totalFee);
		if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0&&order.getPeerUserFee()!=null){
			bal = bal.subtract(order.getPeerUserFee());
		}
		balance3.addElement(new Phrase(bal.toString(),contextFontForTableHead));
		subTotalData.addCell(balance3);
		
		BigDecimal rate = new BigDecimal(1.00);
			rate = order.getRate();
		
		
		Cell tax1 = new Cell();
		tax1.setBorder(0);
		tax1.addElement(new Phrase("",contextFontForTableHead));
		subTotalData.addCell(tax1);
		
		Cell tax2 = new Cell();
		tax2.setBorder(0);
		tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		tax2.addElement(new Phrase("Exchange Rate:",contextFontForTableHead));
		subTotalData.addCell(tax2);
		
		Cell tax3 = new Cell();
		tax3.setBorder(0);
		tax3.addElement(new Phrase(rate.toString(),contextFontForTableHead));
		subTotalData.addCell(tax3);
		
		Cell toatl1 = new Cell();
		toatl1.setBorder(0);
		toatl1.addElement(new Phrase("",contextFontForTableHead));
		subTotalData.addCell(toatl1);
		
		Cell toatl2 = new Cell();
		toatl2.setBorder(0);
		toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
		toatl2.addElement(new Phrase("Total Blance:",contextFontForTableHead));
		subTotalData.addCell(toatl2);
		
		Cell toatl3 = new Cell();
		toatl3.setBorder(0);
		toatl3.addElement(new Phrase(bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),contextFontForTableHead));
		subTotalData.addCell(toatl3);
		doc.add(subTotalData);
		
		//客人信息
		List<Customer> customersForToatl = new ArrayList<Customer>();
		List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerByOrderId(orderId);
		for(CustomerOrderRel customerOrderRel:customerOrderRelList){
			if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
				Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
				customersForToatl.add(customer);
			}
		}
	
	
		Paragraph cus = new Paragraph("CUSTOMER INFORMATION",titleFontForBold);
		cus.setAlignment(Paragraph.ALIGN_CENTER);
		cus.setSpacingAfter(10f);
		cus.setSpacingBefore(10f);
		doc.add(cus);
		
		Table cusData = new Table(4);
		cusData.setPadding(4f);
		cusData.setWidth(100);
		cusData.getDefaultCell().setBorderWidth(0); //不显示边框
		float[] wid5 ={0.1f,0.4f,0.3f,0.20f};
		cusData.setWidths(wid5);
		cusData.getDefaultCell().setBorderWidthBottom(0);
		
		Cell tableHeaderForCus = new Cell();
		tableHeaderForCus.setBorder(0);
		tableHeaderForCus.setBorderColorBottom(Color.GRAY);
		tableHeaderForCus.setBorderWidthBottom(0.3f);
		tableHeaderForCus.setBorderWidthTop(1.5f);
		tableHeaderForCus.setVerticalAlignment(Cell.ALIGN_MIDDLE);
		tableHeaderForCus.setBorderWidth(0.5f);
		tableHeaderForCus=new Cell(new Paragraph("#",contextFontForTableHead));
		cusData.addCell(tableHeaderForCus);
		tableHeaderForCus=new Cell(new Paragraph("Name",contextFontForTableHead));
		cusData.addCell(tableHeaderForCus);
		tableHeaderForCus=new Cell(new Paragraph("Gender",contextFontForTableHead));
		cusData.addCell(tableHeaderForCus);
		tableHeaderForCus=new Cell(new Paragraph("Nationality",contextFontForTableHead));
		cusData.addCell(tableHeaderForCus);
		if(customersForToatl!=null){
		for(int i=0;i<customersForToatl.size();i++){
			Cell cusNo = new Cell();
			cusNo.setBorder(0);
			cusNo.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
			cusNo.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
			cusNo.setVerticalAlignment(Cell.ALIGN_MIDDLE);
			cusNo.addElement(new Phrase(Integer.toString(i+1)));
			cusData.addCell(cusNo);
			
			Cell cusName = new Cell();
			cusName.setBorder(0);
			cusName.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
			cusName.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
			cusName.setVerticalAlignment(Cell.ALIGN_MIDDLE);
			cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName()));
			cusData.addCell(cusName);
			
			Cell cusGender = new Cell();
			cusGender.setBorder(0);
			cusGender.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
			cusGender.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
			cusGender.setVerticalAlignment(Cell.ALIGN_MIDDLE);
			String sexForString = "";
			if(customersForToatl.get(i).getSex()==1){
				sexForString = "FEMALE";
			}else if(customersForToatl.get(i).getSex()==2){
				sexForString = "MALE";
			}
			cusGender.addElement(new Phrase(sexForString));
			cusData.addCell(cusGender);
			
			Cell cusNationality = new Cell();
			cusNationality.setBorder(0);
			cusNationality.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
			cusNationality.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
			cusNationality.setVerticalAlignment(Cell.ALIGN_MIDDLE);
			String countryName = "";
			if(customersForToatl.get(i)!=null){
					countryName = customersForToatl.get(i).getNationalityOfPassport();
			}
			cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName));
			cusData.addCell(cusNationality);
			
		}
		}
		doc.add(cusData);
		
		//添加账户信息
		Admin agent = adminService.findById(ordersTotal.getUserId());
    	Dept dept = deptMapper.findById(agent.getDeptId());
		if(dept.getAccount()!=null){
			Paragraph account = new Paragraph("ACCOUNT",titleFontForBold);
			doc.add(account);
			Paragraph accountContent = new Paragraph(dept.getAccount());
			doc.add(accountContent);
		}
		
		//添加notice信息
		if(order.getOrderType()==5&&tourInfoForOrder.getSpecialRequirements()!=null){
			Paragraph account = new Paragraph("NOTICE INFORMATION",titleFontForBold);
			doc.add(account);
			Paragraph accountContent = new Paragraph(tourInfoForOrder.getSpecialRequirements());
			doc.add(accountContent);
		}
	
		doc.close();
		ByteArrayInputStream byteArray=new ByteArrayInputStream(byteArrayOut.toByteArray());
		byteArray.available();
		byteArrayOut.close();
		return byteArray;
	}
		
}
