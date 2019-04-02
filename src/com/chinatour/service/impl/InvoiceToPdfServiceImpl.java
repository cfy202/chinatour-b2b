package com.chinatour.service.impl;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.jfree.util.Log;
import org.jfree.util.TableOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;

import com.chinatour.Constant;
import com.chinatour.Setting;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AirticketItems;
import com.chinatour.entity.City;
import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Dept;
import com.chinatour.entity.Discount;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderFeeItems;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.Payment;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.State;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.persistence.CountryMapper;
import com.chinatour.persistence.CurrencyTypeMapper;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.DiscountMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.persistence.LanguageMapper;
import com.chinatour.persistence.OrderFeeItemsMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.PaymentMapper;
import com.chinatour.persistence.PeerUserMapper;
import com.chinatour.persistence.ReceivableInfoOfOrderMapper;
import com.chinatour.persistence.SOrderReceiveItemMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.AirticketItemsService;
import com.chinatour.service.CityService;
import com.chinatour.service.InvoiceToPdfService;
import com.chinatour.service.StateService;
import com.chinatour.service.SupplierPriceForOrderService;
import com.chinatour.util.FreemarkerUtils;
import com.chinatour.util.SettingUtils;
import com.lowagie.text.Chunk;
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

@Service("InvoiceToPdfServiceImpl")
public class InvoiceToPdfServiceImpl extends BaseServiceImpl<OrdersTotal,String> implements InvoiceToPdfService,ServletContextAware {
	
	private ServletContext servletContext;

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
	
	@Autowired
	private LanguageMapper languageMapper;
	
	@Autowired
	private CurrencyTypeMapper currencyTypeMapper;
	
	
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
	
	@Autowired
	private OrderFeeItemsMapper orderFeeItemsMapper;
	@Autowired
	private PeerUserMapper peerUserMapper;
	@Resource(name = "supplierPriceForOrderServiceImpl")
	private SupplierPriceForOrderService supplierPriceForOrderService;
	@Resource(name = "airticketItemsServiceImpl")
	private AirticketItemsService airticketItemsService;
	@Autowired
	private CityService cityService;
	@Autowired
	private StateService stateService;
	@Autowired
	public void setBaseMapper(OrdersTotalMapper ordersTotalMapper) {
		super.setBaseMapper(ordersTotalMapper);
	}
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Override
	public String createInvoicePdf(String ordersTotalId,String logo) {
		//获取该id对应的订单
		OrdersTotal ordersTotal = ordersTotalMapper.findById(ordersTotalId);
		String orderNumber = ordersTotal.getOrderNumber();
		//获取该总订单下的所有子订单
		List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
		//判断订单是否为自组（给Cynthia Su特定）
		int isSelfOrganize = orders.get(0).getIsSelfOrganize();
		//标头显示的信息
		String addressString = "";
	    String telString = "";
	    String mailString = "";
	    String agentString = "";
	    String Company="";
	    String cityAndState="";
	    String venderId = ordersTotal.getCompanyId();
	    Vender vender = null;
	    if(venderId!=null&&venderId.length()!=0){
	        vender = venderMapper.findById(venderId);
	      }
        if(ordersTotal.getWr().equals("wholeSale")){
          if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
        	  cityAndState=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
            Company=vender.getName();
          }else{
        	  Company="";
          }
        }
	    Admin agen = adminService.findById(ordersTotal.getUserId());
    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
    	addressString = deptForAgent.getAddress();
    	telString = deptForAgent.getTel();
    	if(agen.getEmail().equals("")){
        	mailString = deptForAgent.getEmail();
    	}else{
    		mailString = agen.getEmail();
    	}
    	agentString = adminService.findById(ordersTotal.getUserId()).getUsername();
    	
    	if(venderId!=null&&venderId.length()!=0){
    		vender = venderMapper.findById(venderId);
    	}
		Setting setting = SettingUtils.get();
		String uploadPath = setting.getTempPDFPath();
		String destPath = null;
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			String path = FreemarkerUtils.process(uploadPath, model);
			destPath = path + "invoice-"+orderNumber+".pdf";
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			
			// 创建一个Document对象
			Document document = new Document(PageSize.A4, 36, 36, 24, 36);
			try {
				// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
				
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
				String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
				BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
				BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				//中文斜体(大号)
				Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
				//中文斜体(小号)
				Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
				Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
						Color.BLACK);
				//中文超大号
				Font  chineseFontBig = new Font(bfChinese, 12,  Font.BOLD,Color.BLACK);
				Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
						Color.BLACK);
				
				document.open();
				
				/*     Invoice 顶部的地址栏信息和Logo开始           */
				
				PdfPTable tableTitleSpace = new PdfPTable(3); //表格两列
				tableTitleSpace.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tableTitleSpace.setWidthPercentage(100);//表格的宽度为100%
				float[] wid11 ={0.45f,0.25f,0.30f};
				tableTitleSpace.setWidths(wid11);
				
				
				PdfPCell cell21_11 = new PdfPCell(new Paragraph("",chineseFontBig));
				cell21_11.setBorder(0);
				cell21_11.setPaddingBottom(10f);
				cell21_11.setMinimumHeight(10f);
				tableTitleSpace.addCell(cell21_11);
				
				PdfPCell cell21_21 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell21_21.setBorder(0);
				cell21_21.setPaddingBottom(10f);
				cell21_21.setMinimumHeight(10f);
				tableTitleSpace.addCell(cell21_21);
				
				PdfPCell cell261 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell261.setBorder(0);
				cell261.setMinimumHeight(10f);
				cell261.setPaddingBottom(10f);
				tableTitleSpace.addCell(cell261);
				
				document.add(tableTitleSpace);
				
				// 添加抬头图片
				PdfPTable table1 = new PdfPTable(3); //表格两列
				table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table1.setWidthPercentage(100);//表格的宽度为100%
				int l = 0;
				
				PdfPTable table13 = new PdfPTable(1);
				table13.getDefaultCell().setBorderWidth(0);
				PdfPCell cell2 = new PdfPCell(table13);
				cell2.setBorder(0);
				cell2.setPaddingBottom(5f);
				table1.addCell(cell2);
				
				//Logo文字标识
				String logoInDentifying="";
				if(logo.equals(Constant.LOGO_PATH[0])){
					logoInDentifying="中国美";
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					logoInDentifying="Chinatour.com";
				}else if(logo.equals(Constant.LOGO_PATH[2]) || logo.equals(Constant.LOGO_PATH[4]) || logo.equals(Constant.LOGO_PATH[5])){
					logoInDentifying="Intertrips";
				}else{
					logoInDentifying="文景假期";
				}
				PdfPCell cellHead = new PdfPCell(new Paragraph(logoInDentifying,chineseFontBig));
				cellHead.setBorder(0);
				cellHead.setMinimumHeight(10f);
				table13.addCell(cellHead);
				
				PdfPCell cell20 = new PdfPCell(new Paragraph("Agent Name:"+agen.getUsername(),littleChineseFont));
				cell20.setBorder(0);
				cell20.setMinimumHeight(10f);
				table13.addCell(cell20);
				
				PdfPCell cell21 = new PdfPCell(new Paragraph("Address:"+agen.getAddress(),littleChineseFont));
				cell21.setBorder(0);
				cell21.setMinimumHeight(10f);
				table13.addCell(cell21);
				
				PdfPCell cell21_1 = new PdfPCell(new Paragraph("Tel:"+agen.getTel(),littleChineseFont));
				cell21_1.setBorder(0);
				cell21_1.setMinimumHeight(10f);
				table13.addCell(cell21_1);
				
				PdfPCell cell21_2 = new PdfPCell(new Paragraph("Fax:"+agen.getFax(),littleChineseFont));
				cell21_2.setBorder(0);
				cell21_2.setMinimumHeight(10f);
				table13.addCell(cell21_2);
				
				PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailString,littleChineseFont));
				cell26.setBorder(0);
				cell26.setMinimumHeight(10f);
				table13.addCell(cell26);
				
				if(ordersTotal.getDeptId().equals(Constant.VANCOUVER)){
					PdfPCell cell27 = new PdfPCell(new Paragraph("LICENSE:"+Constant.VANCOUVER_LICENSE,littleChineseFont));
					cell27.setBorder(0);
					cell27.setMinimumHeight(10f);
					table13.addCell(cell27);
				}
				
				PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
				cell1.setBorder(0);
				table1.addCell(cell1);
				
				 //两列宽度的比例
				if(logo.equals(Constant.LOGO_PATH[3])){
					float[] wid1 ={0.30f,0.30f,0.40f};
					table1.setWidths(wid1);
					l=4;
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					float[] wid1 ={0.30f,0.45f,0.25f};
					table1.setWidths(wid1);
					l=2;
				}else if(logo.equals(Constant.LOGO_PATH[0])){
					float[] wid1 ={0.30f,0.35f,0.35f};
					table1.setWidths(wid1);
					l=1;
				}else if(logo.equals(Constant.LOGO_PATH[2]) || logo.equals(Constant.LOGO_PATH[4]) || logo.equals(Constant.LOGO_PATH[5])){
					float[] wid1 ={0.50f,0.05f,0.45f};
					table1.setWidths(wid1);
					l=3;
				}
				 
				table1.getDefaultCell().setBorderWidth(0); //不显示边框
				PdfPTable table11 = new PdfPTable(1);
				table11.getDefaultCell().setBorder(0);
				Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
				jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
				jpeg.setAlignment(Image.ALIGN_TOP);
				jpeg.setBorder(0);
				table11.addCell(jpeg);
				table11.getDefaultCell().setBorderWidth(0);
				PdfPCell cell0 = new PdfPCell(table11);
				cell0.setBorder(0);
				table11.setWidthPercentage(60);
				table1.addCell(cell0);
				cell0.setBorder(0);

				document.add(table1);
				
				PdfContentByte cb=writer.getDirectContent();
				cb.setLineWidth(0.3f);
				/*cb.moveTo(38f, 700f);
				cb.lineTo(562f, 700f);
				cb.setColorStroke(Color.GRAY);
				cb.stroke();*/
				
				/*BILL TO信息添加*/
				PdfPTable tabalOrder_2 = new PdfPTable(2);
				float[] widOrder4 ={0.52f,0.48f};
				tabalOrder_2.setWidths(widOrder4);
				tabalOrder_2.setWidthPercentage(100);
				tabalOrder_2.getDefaultCell().setBorderWidthTop(0);
				tabalOrder_2.setSpacingBefore(10f);
				
				PdfPCell tableOrderCell = new PdfPCell();
				tableOrderCell.setBorder(0);
				tableOrderCell.setBorderWidthTop(0.3f);
				tableOrderCell.setPaddingTop(20f);
				tableOrderCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableOrderCell.setPhrase(new Phrase("BILL TO",bold_fontEng));
				tabalOrder_2.addCell(tableOrderCell);
				tableOrderCell.setPhrase(new Phrase("Invoice No:"+ordersTotal.getOrderNumber(),norm_fontEng));
				tabalOrder_2.addCell(tableOrderCell);
				
				
				PdfPCell orderItems_2 = new PdfPCell(new Paragraph("Company:"+Company,norm_fontEng));
				orderItems_2.setBorder(0);
				orderItems_2.setMinimumHeight(10f);
				tabalOrder_2.addCell(orderItems_2);
				
				String tourCode = "";
				String tourName = "";
				String departureDate = "";
				String arriveDate = "";
				String dueDate="";
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				if(orders!=null&&orders.size()!=0){
					for(int i=0;i<orders.size();i++){
						TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orders.get(i).getId());
						if(i<orders.size()-1){
							if(orders.get(i).getTourCode().length()!=0&&orders.get(i).getTourCode()!=null){
								tourCode+=orders.get(i).getTourCode()+"/";
							}
							if(orders.get(i).getTourId()!=null&&orders.get(i).getTourId().length()!=0){
								tourName+=tourMapper.findById(orders.get(i).getTourId()).getLineName()+"/";
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDepartureDate()!=null){
								departureDate+= df.format(tourInfoForOrder.getDepartureDate())+",";
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDueDate()!=null){
								dueDate+= df.format(tourInfoForOrder.getDueDate())+",";
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
								arriveDate+= df.format(tourInfoForOrder.getScheduleOfArriveTime())+",";
							}
						}else{
							tourCode+=orders.get(i).getTourCode();
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDepartureDate()!=null){
								departureDate+= df.format(tourInfoForOrder.getDepartureDate());
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDueDate()!=null){
								dueDate+= df.format(tourInfoForOrder.getDueDate())+",";
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
								arriveDate+= df.format(tourInfoForOrder.getScheduleOfArriveTime());
							}
							String tourId = orders.get(i).getTourId();
							if(tourId!=null){
								Tour tour = tourMapper.findById(tourId);
								if(tour!=null){
									tourName+= tour.getLineName();
								}
							}
						}
					}
				}
				
				PdfPCell orderItems_1 = new PdfPCell(new Paragraph("Tour Code:"+tourCode,norm_fontEng));
				orderItems_1.setBorder(0);
				orderItems_1.setMinimumHeight(10f);
				tabalOrder_2.addCell(orderItems_1);
				
				PdfPCell cell014 = null;
				if(ordersTotal.getWr().equals("wholeSale")){
					if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
						cell014 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
					}else{
						cell014 = new PdfPCell(new Paragraph("Name:"+"",norm_fontEng));
					}
				}else{
					cell014 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
				}
				cell014.setBorder(0);
				cell014.setMinimumHeight(10f);
				tabalOrder_2.addCell(cell014);
				
				PdfPCell orderItems_3 = new PdfPCell(new Paragraph("Booking Date:"+df.format(ordersTotal.getBookingDate()),norm_fontEng));
				orderItems_3.setBorder(0);
				orderItems_3.setMinimumHeight(10f);
				tabalOrder_2.addCell(orderItems_3);
				
				
				PdfPCell tabalCell_2_2 = new PdfPCell(new Paragraph("Address:"+ordersTotal.getAddress()+" "+cityAndState,norm_fontEng));
				tabalCell_2_2.setBorder(0);
				tabalCell_2_2.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_2_2);
				
				PdfPCell tabalCell_space = new PdfPCell(new Paragraph("Departure Date:"+departureDate,norm_fontEng));
				tabalCell_space.setBorder(0);
				tabalCell_space.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_space);
				
				
				PdfPCell tabalCell_2_3 = new PdfPCell(new Paragraph("Phone:"+ordersTotal.getTel(),norm_fontEng));
				tabalCell_2_3.setBorder(0);
				tabalCell_2_3.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_2_3);
				
				PdfPCell tabalCell_space2 = new PdfPCell(new Paragraph("Arrival Date:"+arriveDate,norm_fontEng));
				tabalCell_space2.setBorder(0);
				tabalCell_space2.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_space2);
				
				
				PdfPCell tabalCellEamil = new PdfPCell(new Paragraph("Email:"+ordersTotal.getEmail(),norm_fontEng));
				tabalCellEamil.setBorder(0);
				tabalCellEamil.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCellEamil);
				
				PdfPCell tabalCell_space3 = new PdfPCell(new Paragraph("Due Date:"+dueDate,norm_fontEng));
				tabalCell_space3.setBorder(0);
				tabalCell_space3.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_space3);
				
				
				document.add(tabalOrder_2);
				
				BigDecimal totalFee = new BigDecimal(0);
				
				//获取每个子订单下的payment
				List<PayCostRecords> pCRecords = new ArrayList<PayCostRecords>(); //存放所有的
				for(Order order:orders){
					List<PayCostRecords> pays = payCostRecordsMapper.findByOrderId(order.getId());
					List<PayCostRecords> removePays = new ArrayList<PayCostRecords>();
					for(PayCostRecords payCostRecord:pays){
						if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
							removePays.add(payCostRecord);
						}
					}
					pays.removeAll(removePays);
					pCRecords.addAll(pays);
				}
				
					if(pCRecords!=null||pCRecords.size()!=0){
						for(int i=0;i<pCRecords.size();i++){
								totalFee = totalFee.add(pCRecords.get(i).getSum());
							}
					}
				
				//添加invoiceItems
				Paragraph invoiceItems = new Paragraph("INVOICE ITEMS",bold_fontEng);
				invoiceItems.setAlignment(Paragraph.ALIGN_LEFT);
				invoiceItems.setSpacingAfter(10f);
				invoiceItems.setSpacingBefore(10f);
				document.add(invoiceItems);
				
				PdfPTable itemsData = new PdfPTable(6);
				float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
				itemsData.setWidths(wid4);
				itemsData.setWidthPercentage(100);
				itemsData.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell tableHeaderForItem = new PdfPCell();
				tableHeaderForItem.setBorder(0);
				tableHeaderForItem.setBorderColorBottom(Color.GRAY);
				tableHeaderForItem.setBorderWidthBottom(0.3f);
				tableHeaderForItem.setBorderWidthTop(1.5f);
				tableHeaderForItem.setMinimumHeight(30f);
				tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeaderForItem.setMinimumHeight(20f);
				tableHeaderForItem.setBorderWidth(0.5f);
				tableHeaderForItem.setPhrase(new Phrase("#",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Service",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Price",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				BigDecimal totalCostFee = new BigDecimal(0);
				List<OrderReceiveItem> orderReceiveItems = new ArrayList<OrderReceiveItem>(); //保存所有条目
				if(orders!=null&&orders.size()!=0){
					for(Order order:orders){
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
							   orderReceiveItem.setTourInfoForOrder(tourInfoForOrderMapper.findByOrderId(order.getId()));
						   }
					   }
					   //List<OrderReceiveItem> sorderReceiveItems = sOrderReceiveItemMapper.findByReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
					   orderReceiveItems.addAll(torderReceiveItems);
					}
				}
					List<OrderReceiveItem> itemsForMove = new ArrayList<OrderReceiveItem>();
				if(orderReceiveItems!=null){
					for(int i=0;i<orderReceiveItems.size();i++){
						if(orderReceiveItems.get(i).getItemFee()==null||orderReceiveItems.get(i).getItemFee().toString().length()==0||(orderReceiveItems.get(i).getItemFee().intValue()==0&&orderReceiveItems.get(i).getRemark()==null)||(orderReceiveItems.get(i).getItemFee().intValue()==0&&orderReceiveItems.get(i).getRemark()=="")){
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
 								PdfPCell orderReceiveItemNo = new PdfPCell();
 								orderReceiveItemNo.setBorder(0);
 								orderReceiveItemNo.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
 								orderReceiveItemNo.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
 								orderReceiveItemNo.setMinimumHeight(20f);
 								orderReceiveItemNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
 								orderReceiveItemNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
 								itemsData.addCell(orderReceiveItemNo);
								
								PdfPCell serviceCell = new PdfPCell();
								serviceCell.setBorder(0);
								serviceCell.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								serviceCell.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								serviceCell.setMinimumHeight(20f);
								serviceCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								serviceCell.addElement(new Phrase(service,chineseFont));
								itemsData.addCell(serviceCell);
								
								PdfPCell description = new PdfPCell();
								description.setBorder(0);
								description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								description.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								description.setMinimumHeight(20f);
								description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								description.addElement(new Phrase(orderReceiveItems.get(i).getTourInfoForOrder()==null?"":orderReceiveItems.get(i).getTourInfoForOrder().getLineName()+" / "+(orderReceiveItems.get(i).getRemark()==null?"":orderReceiveItems.get(i).getRemark()),chineseFont));
								itemsData.addCell(description);
								
								PdfPCell price = new PdfPCell();
								price.setBorder(0);
								price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								price.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								price.setMinimumHeight(20f);
								price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								price.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
								BigDecimal pri = orderReceiveItems.get(i).getItemFee();
								if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
									pri = new BigDecimal(0).subtract(pri);
								}
								price.addElement(new Phrase(pri.toString(),chineseFont));
								itemsData.addCell(price);
								
								PdfPCell num = new PdfPCell();
								num.setBorder(0);
								num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								num.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								num.setMinimumHeight(20f);
								num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString(),chineseFont));
								itemsData.addCell(num);
								
								PdfPCell totalFe = new PdfPCell();
								totalFe.setBorder(0);
								totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								
								if(i==orderReceiveItems.size()-1){
									totalFe.setBorderColor(Color.BLACK);
									totalFe.setBorderWidthBottom(1.5f);
								}else{
									totalFe.setBorderColor(Color.GRAY);
									totalFe.setBorderWidthBottom(0.3f);
								}
								totalFe.setMinimumHeight(20f);
								totalFe.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								totalFe.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
								BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
								if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
									itemFee = new BigDecimal(0).subtract(itemFee);
								}
								Integer mount = orderReceiveItems.get(i).getItemFeeNum();
								BigDecimal toMount = new BigDecimal(mount);
								totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString(),chineseFont));
								itemsData.addCell(totalFe);
								totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
									}
								
								}
				document.add(itemsData);
				
				//客人信息
				List<Customer> customersForToatl = new ArrayList<Customer>();
				List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerTotalForInvoice(ordersTotalId);
					for(CustomerOrderRel customerOrderRel:customerOrderRelList){
						if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
							Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
							customersForToatl.add(customer);
						}
					}
				//用于存放客人名字信息
				List<String> pasData=new ArrayList<String>();		
				//添加客人名字信息
	              if(customersForToatl!=null){
	                  for(int i=0;i<customersForToatl.size();i++){
	                	pasData.add((i+1)+":"+customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName());
	                  }
	               }
					
				StringBuffer sBuffer=new StringBuffer();
				for(int a=0;a<pasData.size();a++){
					if(a==0){
						sBuffer.append(pasData.get(a));
					}else{
						sBuffer.append("  ,  "+pasData.get(a));
					}
				}

				PdfPTable tb = new PdfPTable(2);
				tb.getDefaultCell().setMinimumHeight(20f);
				float[] wid3 ={0.5f,0.5f};
				tb.setWidths(wid3);
				tb.setWidthPercentage(100);
				tb.getDefaultCell().setBorderWidth(0);
				//tb.getDefaultCell().setBorderWidthBottom(0);
				
				PdfPTable custable = new PdfPTable(1);
				float[] wid61 ={1f};
				custable.setWidths(wid61);
				custable.setWidthPercentage(100);
				custable.getDefaultCell().setBorderWidth(0);
				//custable.getDefaultCell().setBorderWidthBottom(0);
				
				PdfPCell cusinfo1 = new PdfPCell();
				cusinfo1.setBorder(0);
				cusinfo1.addElement(new Phrase("",norm_fontEng));
				custable.addCell(cusinfo1);
				
				PdfPCell cusinfo = new PdfPCell();
				cusinfo.setBorder(0);
				cusinfo.addElement(new Phrase("CUSTOMER INFO:\n"+sBuffer,norm_fontEng));
				custable.addCell(cusinfo);
				
				tb.addCell(custable);
				
				PdfPTable subTotalData = new PdfPTable(3);
				float[] wid6 ={0.3f,0.4f,0.3f};
				subTotalData.setWidths(wid6);
				subTotalData.setWidthPercentage(100);
				subTotalData.getDefaultCell().setBorderWidth(0);
				//subTotalData.getDefaultCell().setBorderWidthBottom(0);
				
				PdfPCell sub1 = new PdfPCell();
				sub1.setBorder(0);
				sub1.addElement(new Phrase("",norm_fontEng));
				subTotalData.addCell(sub1);
				
				PdfPCell sub2 = new PdfPCell();
				sub2.setBorder(0);
				sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				sub2.addElement(new Phrase("        SubTotal:",bold_fontEngForTableHead));
				subTotalData.addCell(sub2);
				
				PdfPCell sub3 = new PdfPCell();
				sub3.setBorder(0);
				sub3.addElement(new Phrase(totalCostFee.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(sub3);
				
				BigDecimal rate = new BigDecimal(0);
				if(orders!=null&&orders.size()!=0){
					rate = orders.get(0).getRate();
				}
				int r=rate.compareTo(BigDecimal.ZERO); //和0，Zero比较
				BigDecimal taxfee=new BigDecimal(0);
				if(r!=0){
					PdfPCell tax1 = new PdfPCell();
					tax1.setBorder(0);
					tax1.addElement(new Phrase("",norm_fontEng));
					subTotalData.addCell(tax1);
					
					PdfPCell tax2 = new PdfPCell();
					tax2.setBorder(0);
					tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					tax2.addElement(new Phrase("        			Tax:",bold_fontEngForTableHead));
					subTotalData.addCell(tax2);
					
					taxfee=totalCostFee.multiply(rate).divide(new BigDecimal(100.00)).setScale(2,BigDecimal.ROUND_HALF_UP);
					PdfPCell tax3 = new PdfPCell();
					tax3.setBorder(0);
					tax3.addElement(new Phrase(taxfee.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(tax3);
					
					PdfPCell grandTotal1 = new PdfPCell();
					grandTotal1.setBorder(0);
					grandTotal1.addElement(new Phrase("",norm_fontEng));
					subTotalData.addCell(grandTotal1);
					
					PdfPCell grandTotal2 = new PdfPCell();
					grandTotal2.setBorder(0);
					grandTotal2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					grandTotal2.addElement(new Phrase("        Grand Total:",bold_fontEngForTableHead));
					subTotalData.addCell(grandTotal2);
					
					PdfPCell grandTotal3 = new PdfPCell();
					grandTotal3.setBorder(0);
					grandTotal3.addElement(new Phrase(totalCostFee.add(taxfee).toString(),bold_fontEngForTableHead));
					subTotalData.addCell(grandTotal3);
				}
				
				if(orders.get(0).getPeerUserId()!=null&&orders.get(0).getPeerUserId().length()!=0){
					BigDecimal peerUserFee = new BigDecimal(0.00);
					if(orders.get(0).getPeerUserFee()!=null){
						peerUserFee = orders.get(0).getPeerUserFee();
					}
					PdfPCell userFee1 = new PdfPCell();
					userFee1.setBorder(0);
					userFee1.addElement(new Phrase("",norm_fontEng));
					subTotalData.addCell(userFee1);
					
					PdfPCell userFee2 = new PdfPCell();
					userFee2.setBorder(0);
					userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					userFee2.addElement(new Phrase("    Commission:",bold_fontEngForTableHead));
					subTotalData.addCell(userFee2);
					
					PdfPCell userFee3 = new PdfPCell();
					userFee3.setBorder(0);
					userFee3.addElement(new Phrase(peerUserFee.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(userFee3);
				}
				
				PdfPCell paid1 = new PdfPCell();
				paid1.setBorder(0);
				paid1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(paid1);
				
				PdfPCell paid2 = new PdfPCell();
				paid2.setBorder(0);
				paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				paid2.addElement(new Phrase("                 Paid:",bold_fontEngForTableHead));
				subTotalData.addCell(paid2);
				
				
				PdfPCell paid3 = new PdfPCell();
				paid3.setBorder(0);
				paid3.addElement(new Phrase(totalFee.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(paid3);
				
				PdfPCell balance1 = new PdfPCell();
				balance1.setBorder(0);
				balance1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(balance1);
				
				PdfPCell balance2 = new PdfPCell();
				balance2.setBorder(0);
				balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				balance2.addElement(new Phrase("           Balance:",bold_fontEngForTableHead));
				subTotalData.addCell(balance2);
				
				PdfPCell balance3 = new PdfPCell();
				balance3.setBorder(0);
				BigDecimal bal = totalCostFee.add(taxfee).subtract(totalFee);
				if(orders.get(0).getPeerUserId()!=null&&orders.get(0).getPeerUserId().length()!=0&&orders.get(0).getPeerUserFee()!=null){
					bal = bal.subtract(orders.get(0).getPeerUserFee());
				}
				balance3.addElement(new Phrase(bal.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(balance3);
				
				tb.addCell(subTotalData);
				
				/*BigDecimal rate = new BigDecimal(1.00);
				if(orders!=null&&orders.size()!=0){
					rate = orders.get(0).getRate();
				}
				
				
				PdfPCell tax1 = new PdfPCell();
				tax1.setBorder(0);
				tax1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(tax1);
				
				PdfPCell tax2 = new PdfPCell();
				tax2.setBorder(0);
				tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tax2.addElement(new Phrase("Exchange Rate:",bold_fontEngForTableHead));
				subTotalData.addCell(tax2);
				
				PdfPCell tax3 = new PdfPCell();
				tax3.setBorder(0);
				tax3.addElement(new Phrase(rate.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(tax3);
				
				PdfPCell toatl1 = new PdfPCell();
				toatl1.setBorder(0);
				toatl1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(toatl1);
				
				PdfPCell toatl2 = new PdfPCell();
				toatl2.setBorder(0);
				toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				toatl2.addElement(new Phrase("    Total Blance:",bold_fontEngForTableHead));
				subTotalData.addCell(toatl2);
				
				PdfPCell toatl3 = new PdfPCell();
				toatl3.setBorder(0);
				toatl3.addElement(new Phrase(bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),bold_fontEngForTableHead));
				subTotalData.addCell(toatl3);*/
				document.add(tb);
				
				if(!deptForAgent.getDeptId().equals(Constant.HEADOFFICE) || logoInDentifying!="Intertrips"){
					//添加payment
					Paragraph payment1 = new Paragraph("",bold_fontEng);
					payment1.setAlignment(Paragraph.ALIGN_CENTER);
					payment1.setSpacingAfter(5f);
					payment1.setSpacingBefore(5f);
					document.add(payment1);
					
					Paragraph payment = new Paragraph("PAYMENT METHODS",bold_fontEng);
					payment.setAlignment(Paragraph.ALIGN_LEFT);
					payment.setSpacingAfter(10f);
					payment.setSpacingBefore(10f);
					document.add(payment);
					
					PdfPTable paymentData = new PdfPTable(1);
					paymentData.getDefaultCell().setMinimumHeight(20f);
					float[] wid33 ={1f};
					paymentData.setWidths(wid33);
					paymentData.setWidthPercentage(100);
					
					PdfPCell depositinfo = new PdfPCell();
					depositinfo.setBorder(0);
					depositinfo.setPaddingBottom(10f);
					depositinfo.setBorderWidthTop(1.5f);
					depositinfo.setBorderColor(Color.GRAY);
					depositinfo.addElement(new Phrase(""+deptForAgent.getAccount(),norm_fontEng));
					paymentData.addCell(depositinfo);
					
					
					document.add(paymentData);
					
					
				}
				
				//加拿大添加
				if(deptForAgent.getDeptId().equals(Constant.VANCOUVER)){
					//添加备注以及条款
					Paragraph payment1 = new Paragraph("",bold_fontEng);
					payment1.setAlignment(Paragraph.ALIGN_CENTER);
					payment1.setSpacingAfter(5f);
					payment1.setSpacingBefore(5f);
					document.add(payment1);
					
					Paragraph payment = new Paragraph("REMARKS",bold_fontEng);
					payment.setAlignment(Paragraph.ALIGN_LEFT);
					payment.setSpacingAfter(10f);
					payment.setSpacingBefore(10f);
					document.add(payment);
					
					PdfPTable paymentData = new PdfPTable(1);
					paymentData.getDefaultCell().setMinimumHeight(20f);
					float[] wid33 ={1f};
					paymentData.setWidths(wid33);
					paymentData.setWidthPercentage(100);
					
					PdfPCell remarks = new PdfPCell();
					remarks.setBorder(0);
					remarks.setPaddingBottom(10f);
					remarks.setBorderWidthTop(1.5f);
					remarks.setBorderColor(Color.GRAY);
					remarks.addElement(new Phrase(""+Constant.VANCOUVER_TERMS[0],norm_fontEng));
					paymentData.addCell(remarks);
					
					PdfPCell depositinfo = new PdfPCell();
					depositinfo.setBorder(0);
					depositinfo.setPaddingBottom(10f);
					depositinfo.addElement(new Phrase(""+Constant.VANCOUVER_TERMS[1],norm_fontEng));
					paymentData.addCell(depositinfo);
					
					
					document.add(paymentData);
					
					
				}
				
				
				/*Paragraph total = new Paragraph("Total: "+totalFee,bold_fontEngForTableHead);
				total.setAlignment(2);
				document.add(total);*/
				Paragraph payment3 = new Paragraph("",bold_fontEng);
				payment3.setAlignment(Paragraph.ALIGN_CENTER);
				payment3.setSpacingAfter(5f);
				payment3.setSpacingBefore(5f);
				document.add(payment3);
				
				/**添加页面下方的信息*/
				PdfPTable footReamrk = new PdfPTable(1); //表格1列
				footReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				footReamrk.setWidthPercentage(100);//表格的宽度为100%
				footReamrk.getDefaultCell().setBorderWidth(0); //不显示边框
				footReamrk.getDefaultCell().setBorderColor(Color.GRAY);
				
				
				PdfPCell foot1 = new PdfPCell(new Paragraph("Please note that all travel documents will only be sent after you full balance has been received.",norm_fontEng));
				foot1.setBorder(0);
				foot1.setPaddingTop(5f);
				foot1.setMinimumHeight(1f);
				foot1.setBorderWidthTop(1.5f);
				foot1.setBorderColor(Color.GRAY);
				footReamrk.addCell(foot1);
				
				
				PdfPCell foot2 = new PdfPCell(new Paragraph("Please inspect this invoice carefully; our company will not be responsible for any errors after 2 business days.",norm_fontEng));
				foot2.setBorder(0);
				foot2.setMinimumHeight(1f);
				footReamrk.addCell(foot2);
				
				PdfPCell foot3 = new PdfPCell(new Paragraph("Please check our website for terms and conditions.",norm_fontEng));
				foot3.setBorder(0);
				foot3.setMinimumHeight(1f);
				footReamrk.addCell(foot3);
				
				document.add(footReamrk);
				
				Paragraph LogoSpace = new Paragraph("",bold_fontEng);
				LogoSpace.setAlignment(Paragraph.ALIGN_CENTER);
				LogoSpace.setSpacingAfter(10f);
				LogoSpace.setSpacingBefore(10f);
				document.add(LogoSpace);
				
				PdfPTable tablelogo = new PdfPTable(3); //表格两列
				if(l==4){
					float[] wid1 ={0.2f,0.25f,0.55f};
					tablelogo.setWidths(wid1);
				}else if(l==2||l==3){
					float[] wid1 ={0.2f,0.25f,0.55f};
					tablelogo.setWidths(wid1);
				}else if(l==1){
					float[] wid1 ={0.2f,0.25f,0.55f};
					tablelogo.setWidths(wid1);
				}
				tablelogo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tablelogo.setWidthPercentage(100);//表格的宽度为100%
	//			tablelogo.getDefaultCell().setBorderWidth(0); //不显示边框
				tablelogo.getDefaultCell().setBorderColor(Color.GRAY);
				
				
	
				
				
				PdfPCell Cell_logo2 = new PdfPCell(new Paragraph("")); //
				Cell_logo2.setBorder(0);
				Cell_logo2.setBorderColor(Color.GRAY);
				tablelogo.addCell(Cell_logo2);
				
				
				PdfPCell Cell_logo3 = new PdfPCell(new Paragraph("")); //
				Cell_logo3.setBorder(0);
				Cell_logo3.setBorderColor(Color.GRAY);
				tablelogo.addCell(Cell_logo3);
				
				
				PdfPTable tablelogo1 = new PdfPTable(2);
				float[] wid ={0.8f,0.2f};
				tablelogo1.setWidths(wid);
				tablelogo1.getDefaultCell().setBorderWidth(0);
				PdfPCell Cell_logo = new PdfPCell(tablelogo1);
				Cell_logo.setBorder(0);
				tablelogo.addCell(Cell_logo);
				
				PdfPCell Cell_logo1 = new PdfPCell(new Paragraph(" Thank you for choosing   ",norm_fontEng));
				Cell_logo1.setBorder(0);
				Cell_logo1.setVerticalAlignment(Element.ALIGN_MIDDLE);
				Cell_logo1.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tablelogo1.addCell(Cell_logo1);
				
				
				PdfPCell logoCell=new PdfPCell();
				logoCell.addElement(jpeg);
				logoCell.setBorder(0);
				logoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
				tablelogo1.addCell(logoCell);
				
				document.add(tablelogo);
					
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
//	B2BInvoice
	public String createInvoicePdfB(String ordersTotalId,String logo) {
		//获取该id对应的订单
		OrdersTotal ordersTotal = ordersTotalMapper.findById(ordersTotalId);
		String orderNumber = ordersTotal.getOrderNumber();
		//获取该总订单下的所有子订单
		List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
		//标头显示的信息
		String addressString = "";
	    String telString = "";
	    String mailString = "";
	    String agentString = "";
	    Admin agen = adminService.findById(ordersTotal.getUserId());
    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
    	CurrencyType currencyType=currencyTypeMapper.findById(deptForAgent.getCurrencyTypeId());
    	GroupLine groupLine=new GroupLine();
    	PeerUser peerUser=peerUserMapper.findById(orders.get(0).getPeerUserId());
    	addressString = deptForAgent.getAddress();
    	telString = deptForAgent.getTel();
    	if(agen.getEmail().equals("")){
        	mailString = deptForAgent.getEmail();
    	}else{
    		mailString = agen.getEmail();
    	}
    	agentString = adminService.findById(ordersTotal.getUserId()).getUsername();
    	String officeName=null,zcm=null,topAddress=null,topTel=null,topEmail=null;
    	if(deptForAgent.getDeptId().equals("08c5c6ce-c01d-11e5-8c86-00163e000490")){
    		officeName="InteTrips (AU/NZ) Pty Ltd";
    		zcm="A.C.N.609 406 386";
    	}
    	
    	String venderId = ordersTotal.getCompanyId();
    	Vender vender = null;
    	if(venderId!=null&&venderId.length()!=0){
    		vender = venderMapper.findById(venderId);
    	}
		Setting setting = SettingUtils.get();
		String uploadPath = setting.getTempPDFPath();
		String destPath = null;
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			String path = FreemarkerUtils.process(uploadPath, model);
			destPath = path + "invoice-"+orderNumber+".pdf";
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			
			// 创建一个Document对象
			Document document = new Document(PageSize.A4, 36, 36, 24, 36);
			try {
				// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
				
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
				String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
				BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
				BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				//中文斜体(大号)
				Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
				//中文斜体(小号)
				Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
				Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
						Color.BLACK);
				Font bold_fontTitle = new Font(bfEng, 15, Font.NORMAL,
						Color.BLACK);
				
				Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
						Color.BLACK);
				
				document.open();
				// 添加抬头图片
				PdfPTable table1 = new PdfPTable(3); //表格两列
				table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table1.setWidthPercentage(100);//表格的宽度为100%
				 //两列宽度的比例
				if(logo.equals(Constant.LOGO_PATH[3])){
					float[] wid1 ={0.45f,0.15f,0.40f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					float[] wid1 ={0.2f,0.40f,0.30f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[0])){
					float[] wid1 ={0.60f,0.10f,0.30f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[2])){
					float[] wid1 ={0.45f,0.25f,0.30f};
					table1.setWidths(wid1);
				}

				table1.getDefaultCell().setBorderWidth(0); //不显示边框
				PdfPTable table11 = new PdfPTable(1);
				table11.getDefaultCell().setBorder(0);
				Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
				jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
				jpeg.setAlignment(Image.ALIGN_TOP);
				jpeg.setBorder(0); 
				table11.addCell(jpeg);
				table11.getDefaultCell().setBorderWidth(0);
				
				PdfPTable table13 = new PdfPTable(1);
				table13.getDefaultCell().setBorderWidth(0);
				PdfPCell cell2 = new PdfPCell(table13);
				cell2.setBorder(0);
				table1.addCell(cell2);
				PdfPCell cell20 = new PdfPCell(new Paragraph(officeName,littleChineseFont));
				cell20.setBorder(0);
				cell20.setMinimumHeight(10f);
				table13.addCell(cell20);
				
				PdfPCell cell21 = new PdfPCell(new Paragraph(zcm,littleChineseFont));
				cell21.setBorder(0);
				cell21.setMinimumHeight(10f);
				table13.addCell(cell21);
				
				PdfPCell cell24 = new PdfPCell(new Paragraph(addressString,littleChineseFont));
				cell24.setBorder(0);
				cell24.setMinimumHeight(10f);
				table13.addCell(cell24);
				
				PdfPCell cell25 = new PdfPCell(new Paragraph("Tel:"+deptForAgent.getTel(),littleChineseFont));
				cell25.setBorder(0);
				cell25.setMinimumHeight(10f);
				table13.addCell(cell25);
				
				
				PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailString,littleChineseFont));
				cell26.setBorder(0);
				cell26.setMinimumHeight(10f);
				table13.addCell(cell26);
				
				PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
				cell1.setBorder(Rectangle.NO_BORDER);
				table1.addCell(cell1);
				
				
				PdfPCell cell0 = new PdfPCell(table11);
				cell0.setBorder(0);
				table11.setWidthPercentage(60);
				table1.addCell(cell0);
				cell0.setBorder(0);
				
				table1.addCell(cell1);
				document.add(table1);
				
				PdfContentByte cb=writer.getDirectContent();
				cb.setLineWidth(0.3f);
				
				//显示order基础信息

				SimpleDateFormat dFormat = new SimpleDateFormat("yyyy/MM/dd");
				String tourCode = "";
				String tourName = "";
				String tourNameEn = "";
				String departureDate = "";
				String arriveDate = "";
				SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");
				if(orders!=null&&orders.size()!=0){
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orders.get(0).getId());
					groupLine=groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
					tourCode=orders.get(0).getTourCode();
					tourName=groupLine.getTourName();
					tourNameEn=groupLine.getTourNameEn();
					departureDate=dFormat.format(tourInfoForOrder.getDepartureDate());
					arriveDate=dFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
				}
				//离团时间计算
				int year=Integer.parseInt(departureDate.substring(0,4));
				int month=Integer.parseInt(departureDate.substring(5,7));
				int day=Integer.parseInt(departureDate.substring(8,10));
				int days=day+Integer.parseInt(groupLine.getRemark())-1;
				String offDate="";
				if(month==02){
					if(days>29){
						int d=days-29;
						int m=month+1;
						String dy="";
						String mt="";
						if(d<10){
							dy=0+""+d;
						}else {
							dy=""+d;
						}
						if(m<10){
							mt=0+""+m;
						}else {
							mt=""+m;
						}
						offDate=year+"/"+mt+"/"+dy;
					}else{
						String dy="";
						String mt="";
						if(days<10){
							dy=0+""+days;
						}else{
							dy=""+days;
						}
						if(month<10){
							mt=0+""+month;
						}else{
							mt=""+month;
						}
						offDate=year+"/"+mt+"/"+dy;
					}
				}else if(month==01||month==03||month==05||month==07||month==10||month==12){
					if(days>31){
						int d=days-31;
						int m=month+1;
						String dy="";
						String mt="";
						if(d<10){
							dy=0+""+d;
						}else{
							dy=""+d;
						}
						if(m<10){
							mt=0+""+m;
						}else{
							mt=""+m;
						}
						offDate=year+"/"+mt+"/"+dy;
					}else{
						String dy="";
						String mt="";
						if(days<10){
							dy=0+""+days;
						}else{
							dy=""+days;
						}
						if(month<10){
							mt=0+""+month;
						}else{
							mt=""+month;
						}
						offDate=year+"/"+mt+"/"+dy;
					}
				}else{
					if(days>30){
						int d=days-30;
						int m=month+1;
						String dy="";
						String mt="";
						if(d<10){
							dy=0+""+d;
						}else{
							dy=""+d;
						}
						if(m<10){
							mt=0+""+m;
						}else{
							mt=""+m;
						}
						offDate=year+"/"+mt+"/"+dy;
					}else{
						String dy="";
						String mt="";
						if(days<10){
							dy=0+""+days;
						}else {
							dy=days+"";
						}
						if(month<10){
							mt=0+""+month;
						}else{
							mt=""+month;
						}
						offDate=year+"/"+mt+"/"+dy;
					}
				}
				
				Chunk lineChunk=new Chunk("Payable / Receivable Invoice",littleChineseFont);
				lineChunk.setUnderline(0.1f,0.1f);
				
				PdfPTable tableline = new PdfPTable(1);
				tableline.getDefaultCell().setBorder(0);
				tableline.setWidthPercentage(35);//表格的宽度为100%
				PdfPCell cellq1 = new PdfPCell(new Paragraph(lineChunk+"",bold_fontTitle));
				cellq1.setMinimumHeight(10f);
				cellq1.setHorizontalAlignment(Element.ALIGN_CENTER);
				cellq1.setBorder(0);
				cellq1.setBorderWidthBottom(0.5f);
				cellq1.setBorderColor(Color.GRAY);
				tableline.addCell(cellq1);
				document.add(tableline);
				
				PdfPTable table3 = new PdfPTable(4); //表格两列
				table3.setSpacingBefore(10f);
				table3.setSpacingAfter(5f);
				table3.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table3.setWidthPercentage(100);//表格的宽度为100%
				float[] wid2 ={0.2f,0.3f,0.2f,0.3f}; //两列宽度的比例
				table3.setWidths(wid2); 
				table3.getDefaultCell().setBorderWidth(0); //不显示边框
				
				PdfPCell cell111 = new PdfPCell(new Paragraph("Booking Date:      ",littleChineseFont));
				cell111.setMinimumHeight(10f);
				cell111.setBorder(0);
				cell111.setBorderColor(Color.GRAY);
				table3.addCell(cell111);
				PdfPCell cell112 = new PdfPCell(new Paragraph(dFormat.format(orders.get(0).getCreateDate()),littleChineseFont));
				cell112.setMinimumHeight(10f);
				cell112.setBorder(0);
				cell112.setBorderColor(Color.GRAY);
				table3.addCell(cell112);
				PdfPCell cell113 = new PdfPCell(new Paragraph("Billing To:      ",littleChineseFont));
				cell113.setMinimumHeight(10f);
				cell113.setBorder(0);
				cell113.setBorderColor(Color.GRAY);
				table3.addCell(cell113);
				PdfPCell cell114 = new PdfPCell(new Paragraph(vender.getName(),littleChineseFont));
				cell114.setMinimumHeight(10f);
				cell114.setBorder(0);
				cell114.setBorderColor(Color.GRAY);
				table3.addCell(cell114);
				
				PdfPCell cell211 = new PdfPCell(new Paragraph("Invoice No:      ",littleChineseFont));
				cell211.setMinimumHeight(10f);
				cell211.setBorder(0);
				cell211.setBorderColor(Color.GRAY);
				table3.addCell(cell211);
				PdfPCell cell212 = new PdfPCell(new Paragraph(ordersTotal.getOrderNumber(),littleChineseFont));
				cell212.setMinimumHeight(10f);
				cell212.setBorder(0);
				cell212.setBorderColor(Color.GRAY);
				table3.addCell(cell212);
				PdfPCell cell213 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell213.setMinimumHeight(10f);
				cell213.setBorder(0);
				cell213.setBorderColor(Color.GRAY);
				table3.addCell(cell213);
				PdfPCell cell214 = new PdfPCell(new Paragraph(vender.getRegistrationNo(),littleChineseFont));
				cell214.setMinimumHeight(10f);
				cell214.setBorder(0);
				cell214.setBorderColor(Color.GRAY);
				table3.addCell(cell214);
				
				PdfPCell cell311 = new PdfPCell(new Paragraph("Tour Code:",littleChineseFont));
				cell311.setMinimumHeight(10f);
				cell311.setBorder(0);
				cell311.setBorderColor(Color.GRAY);
				table3.addCell(cell311);
				PdfPCell cell312 = new PdfPCell(new Paragraph(tourCode,littleChineseFont));
				cell312.setMinimumHeight(10f);
				cell312.setBorder(0);
				cell312.setBorderColor(Color.GRAY);
				table3.addCell(cell312);
				PdfPCell cell313 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell313.setMinimumHeight(10f);
				cell313.setBorder(0);
				cell313.setBorderColor(Color.GRAY);
				table3.addCell(cell313);
				PdfPCell cell314 = new PdfPCell(new Paragraph(vender.getAddress(),littleChineseFont));
				cell314.setMinimumHeight(10f);
				cell314.setBorder(0);
				cell314.setBorderColor(Color.GRAY);
				table3.addCell(cell314);
				
				PdfPCell cell411 = new PdfPCell(new Paragraph("Product:",littleChineseFont));
				cell411.setMinimumHeight(10f);
				cell411.setBorder(0);
				cell411.setBorderColor(Color.GRAY);
				table3.addCell(cell411);
				PdfPCell cell412 = new PdfPCell(new Paragraph(tourName,littleChineseFont));
				cell412.setMinimumHeight(10f);
				cell412.setBorder(0);
				cell412.setBorderColor(Color.GRAY);
				table3.addCell(cell412);
				PdfPCell cell413 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell413.setMinimumHeight(10f);
				cell413.setBorder(0);
				cell413.setBorderColor(Color.GRAY);
				table3.addCell(cell413);
				PdfPCell cell414 = new PdfPCell(new Paragraph(vender.getCityId()+"  "+vender.getStateId()+"  "+vender.getZipCode()+" "+countryMapper.findById(vender.getCountryId()).getCountryName(),littleChineseFont));
				cell414.setMinimumHeight(10f);
				cell414.setBorder(0);
				cell414.setBorderColor(Color.GRAY);
				table3.addCell(cell414);
				
				PdfPCell cell911 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell911.setMinimumHeight(10f);
				cell911.setBorder(0);
				cell911.setBorderColor(Color.GRAY);
				table3.addCell(cell911);
				PdfPCell cell912 = new PdfPCell(new Paragraph(tourNameEn,littleChineseFont));
				cell912.setMinimumHeight(10f);
				cell912.setBorder(0);
				cell912.setBorderColor(Color.GRAY);
				table3.addCell(cell912);
				PdfPCell cell913 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell913.setMinimumHeight(10f);
				cell913.setBorder(0);
				cell913.setBorderColor(Color.GRAY);
				table3.addCell(cell913);
				PdfPCell cell914 = new PdfPCell(new Paragraph(""+vender.getTel(),littleChineseFont));
				cell914.setMinimumHeight(10f);
				cell914.setBorder(0);
				cell914.setBorderColor(Color.GRAY);
				table3.addCell(cell914);
				
				PdfPCell cell511 = new PdfPCell(new Paragraph("No. of Travellers:",littleChineseFont));
				cell511.setMinimumHeight(10f);
				cell511.setBorder(0);
				cell511.setBorderColor(Color.GRAY);
				table3.addCell(cell511);
				PdfPCell cell512 = new PdfPCell(new Paragraph(ordersTotal.getTotalPeople()+"",littleChineseFont));
				cell512.setMinimumHeight(10f);
				cell512.setBorder(0);
				cell512.setBorderColor(Color.GRAY);
				table3.addCell(cell512);
				PdfPCell cell513 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell513.setMinimumHeight(10f);
				cell513.setBorder(0);
				cell513.setBorderColor(Color.GRAY);
				table3.addCell(cell513);
				PdfPCell cell514 = new PdfPCell(new Paragraph(""+vender.getBillEmail(),littleChineseFont));
				cell514.setMinimumHeight(10f);
				cell514.setBorder(0);
				cell514.setBorderColor(Color.GRAY);
				table3.addCell(cell514);
				
				PdfPCell cell611 = new PdfPCell(new Paragraph("Beginning Date:",littleChineseFont));
				cell611.setMinimumHeight(10f);
				cell611.setBorder(0);
				cell611.setBorderColor(Color.GRAY);
				table3.addCell(cell611);
				PdfPCell cell612 = new PdfPCell(new Paragraph(arriveDate,littleChineseFont));
				cell612.setMinimumHeight(10f);
				cell612.setBorder(0);
				cell612.setBorderColor(Color.GRAY);
				table3.addCell(cell612);
				PdfPCell cell613 = new PdfPCell(new Paragraph("Consultant:",littleChineseFont));
				cell613.setMinimumHeight(10f);
				cell613.setBorder(0);
				cell613.setBorderColor(Color.GRAY);
				table3.addCell(cell613);
				PdfPCell cell614 = new PdfPCell(new Paragraph(ordersTotal.getContactName(),littleChineseFont));
				cell614.setMinimumHeight(10f);
				cell614.setBorder(0);
				cell614.setBorderColor(Color.GRAY);
				table3.addCell(cell614);
				
				PdfPCell cell711 = new PdfPCell(new Paragraph("Ending Date:",littleChineseFont));
				cell711.setMinimumHeight(10f);
				cell711.setBorder(0);
				cell711.setBorderColor(Color.GRAY);
				table3.addCell(cell711);
				PdfPCell cell712 = new PdfPCell(new Paragraph(offDate,littleChineseFont));
				cell712.setMinimumHeight(10f);
				cell712.setBorder(0);
				cell712.setBorderColor(Color.GRAY);
				table3.addCell(cell712);
				PdfPCell cell713 = new PdfPCell(new Paragraph("Consultant REF:",littleChineseFont));
				cell713.setMinimumHeight(10f);
				cell713.setBorder(0);
				cell713.setBorderColor(Color.GRAY);
				table3.addCell(cell713);
				PdfPCell cell714 = new PdfPCell(new Paragraph(orders.get(0).getRefNo(),littleChineseFont));
				cell714.setMinimumHeight(10f);
				cell714.setBorder(0);
				cell714.setBorderColor(Color.GRAY);
				table3.addCell(cell714);
				
				document.add(table3);
				//}

				BigDecimal totalFee = new BigDecimal(0);
				
				//获取每个子订单下的payment
				List<PayCostRecords> pCRecords = new ArrayList<PayCostRecords>(); //存放所有的
				for(Order order:orders){
					List<PayCostRecords> pays = payCostRecordsMapper.findByOrderId(order.getId());
					List<PayCostRecords> removePays = new ArrayList<PayCostRecords>();
					for(PayCostRecords payCostRecord:pays){
						if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
							removePays.add(payCostRecord);
						}
					}
					pays.removeAll(removePays);
					pCRecords.addAll(pays);
				}
				
					if(pCRecords!=null||pCRecords.size()!=0){
						for(int i=0;i<pCRecords.size();i++){
								totalFee = totalFee.add(pCRecords.get(i).getSum());
							}
					}
					//客人信息
					List<Customer> customersForToatl = new ArrayList<Customer>();
					List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerTotalForInvoice(ordersTotalId);
						for(CustomerOrderRel customerOrderRel:customerOrderRelList){
							if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
								Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
								customersForToatl.add(customer);
							}
						}
				
				Paragraph cus = new Paragraph("Customer Information",bold_fontEng);
				cus.setAlignment(Paragraph.ALIGN_CENTER);
				cus.setSpacingAfter(10f);
				cus.setSpacingBefore(10f);
				document.add(cus);
				
				PdfPTable cusData = new PdfPTable(8);
				float[] wid5 ={0.02f,0.18f,0.15f,0.08f,0.12f,0.18f,0.15f,0.15f};
				cusData.setWidths(wid5);
				cusData.setWidthPercentage(100);
				cusData.getDefaultCell().setBorderWidthBottom(0);
				
				PdfPCell tableHeaderForCus = new PdfPCell();
				tableHeaderForCus.setBorder(0);
				tableHeaderForCus.setBorderColorBottom(Color.GRAY);
				tableHeaderForCus.setBorderColorLeft(Color.GRAY);
				tableHeaderForCus.setBorderColorRight(Color.GRAY);
				tableHeaderForCus.setBorderWidthLeft(0.3f);
				tableHeaderForCus.setBorderWidthRight(0.3f);
				tableHeaderForCus.setBorderWidthBottom(0.3f);
				tableHeaderForCus.setBorderWidthTop(1.5f);
				tableHeaderForCus.setMinimumHeight(30f);
				tableHeaderForCus.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeaderForCus.setMinimumHeight(20f);
				tableHeaderForCus.setBorderWidth(0.5f);
				tableHeaderForCus.setPhrase(new Phrase("#",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Category",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Date of Birth",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Language",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				tableHeaderForCus.setPhrase(new Phrase("Residency",bold_fontEngForTableHead));
				cusData.addCell(tableHeaderForCus);
				if(customersForToatl!=null){
				for(int i=0;i<customersForToatl.size();i++){
					//判断客人的年龄类型
					String customerType="";
					if(customersForToatl.get(i).getType()==4){
						customerType="Adult";
					}else if(customersForToatl.get(i).getType()==3){
						customerType="Child with Bed";
					}else if(customersForToatl.get(i).getType()==2){
						customerType="Child without Bed";
					}else{
						customerType="Infant";
					}
					//语言
					String lange="";
					if(customersForToatl.get(i).getLanguageId()!=""){
						lange=languageMapper.findById(customersForToatl.get(i).getLanguageId()).getLanguage();
					}
					PdfPCell cusNo = new PdfPCell();
					cusNo.setBorder(0);
					cusNo.setBorderColor(Color.GRAY);
					cusNo.setBorderWidthBottom(0.3f);
					cusNo.setBorderWidthLeft(0.3f);
					cusNo.setMinimumHeight(20f);
					cusNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					cusNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
					cusData.addCell(cusNo);
					
					PdfPCell category = new PdfPCell();
					category.setBorder(0);
					category.setBorderColor(Color.GRAY);
					category.setBorderWidthBottom(0.3f);
					category.setMinimumHeight(20f);
					category.setBorderWidthLeft(0.3f);
					category.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					category.addElement(new Phrase(customerType,chineseFont));
					cusData.addCell(category);
					
					PdfPCell cusName = new PdfPCell();
					cusName.setBorder(0);
					cusName.setBorderColor(Color.GRAY);
					cusName.setBorderWidthBottom(0.3f);
					cusName.setMinimumHeight(20f);
					cusName.setBorderWidthLeft(0.3f);
					cusName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName(),chineseFont));
					cusData.addCell(cusName);
					
					PdfPCell cusGender = new PdfPCell();
					cusGender.setBorder(0);
					cusGender.setBorderColor(Color.GRAY);
					cusGender.setBorderWidthBottom(0.3f);
					cusGender.setMinimumHeight(20f);
					cusGender.setBorderWidthLeft(0.3f);
					cusGender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					String sexForString = "";
					if(customersForToatl.get(i).getSex()==1){
						sexForString = "FEMALE";
					}else if(customersForToatl.get(i).getSex()==2){
						sexForString = "MALE";
					}
					cusGender.addElement(new Phrase(sexForString,chineseFont));
					cusData.addCell(cusGender);
					
					PdfPCell birth = new PdfPCell();
					birth.setBorder(0);
					birth.setBorderColor(Color.GRAY);
					birth.setBorderWidthBottom(0.3f);
					birth.setMinimumHeight(20f);
					birth.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					birth.setBorderWidthLeft(0.3f);
					SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd");
					birth.addElement(new Phrase(customersForToatl.get(i).getDateOfBirth()==null?"":simpleDateFormat.format(customersForToatl.get(i).getDateOfBirth()),chineseFont));
					cusData.addCell(birth);
					
					PdfPCell language = new PdfPCell();
					language.setBorder(0);
					language.setBorderColor(Color.GRAY);
					language.setBorderWidthBottom(0.3f);
					language.setMinimumHeight(20f);
					language.setBorderWidthLeft(0.3f);
					language.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					language.addElement(new Phrase(lange,chineseFont));
					cusData.addCell(language);
					
					
					PdfPCell cusNationality = new PdfPCell();
					cusNationality.setBorder(0);
					cusNationality.setBorderColor(Color.GRAY);
					cusNationality.setBorderWidthBottom(0.3f);
					cusNationality.setMinimumHeight(20f);
					cusNationality.setBorderWidthLeft(0.3f);
					cusNationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					String countryName = "";
					if(customersForToatl.get(i)!=null){
							countryName = customersForToatl.get(i).getNationalityOfPassport();
					}
					cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName,chineseFont));
					cusData.addCell(cusNationality);
					
					PdfPCell residency = new PdfPCell();
					residency.setBorder(0);
					residency.setBorderColor(Color.GRAY);
					residency.setBorderWidthBottom(0.3f);
					residency.setMinimumHeight(20f);
					residency.setBorderWidthLeft(0.3f);
					residency.setBorderWidthRight(0.3f);
					residency.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					residency.addElement(new Phrase(customersForToatl.get(i).getResidency(),chineseFont));
					cusData.addCell(residency);
					
				}
				}
				document.add(cusData);
				
				//添加费用明细
				Paragraph invoiceItems = new Paragraph("Order Calculation",bold_fontEng);
				invoiceItems.setAlignment(Paragraph.ALIGN_CENTER);
				invoiceItems.setSpacingAfter(10f);
				invoiceItems.setSpacingBefore(10f);
				document.add(invoiceItems);
				
				PdfPTable itemsData = new PdfPTable(6);
				float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
				itemsData.setWidths(wid4);
				itemsData.setWidthPercentage(100);
				itemsData.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell tableHeaderForItem = new PdfPCell();
				tableHeaderForItem.setBorder(0);
				tableHeaderForItem.setBorderColorBottom(Color.GRAY);
				tableHeaderForItem.setBorderColorLeft(Color.GRAY);
				tableHeaderForItem.setBorderColorRight(Color.GRAY);
				tableHeaderForItem.setBorderWidthLeft(0.3f);
				tableHeaderForItem.setBorderWidthRight(0.3f);
				tableHeaderForItem.setBorderWidthBottom(0.3f);
				tableHeaderForItem.setBorderWidthTop(1.5f);
				tableHeaderForItem.setMinimumHeight(30f);
				tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeaderForItem.setMinimumHeight(20f);
				tableHeaderForItem.setBorderWidth(0.5f);
				tableHeaderForItem.setPhrase(new Phrase("#",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Category",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Item",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Price ("+currencyType.getCurrencyEng()+")",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Sum",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				List<OrderFeeItems> orderFeeItemsList =orderFeeItemsMapper.findByOrderId(orders.get(0).getId()); //保存所有条目
				double alotherPrice=0;//其他费用总和（本部门币种）
				double tsRatePrice=0;//小费自费转换后的金额
				if(orderFeeItemsList!=null){
				  int numb=0;
				  double prices=0;
				  for(int i=0;i<orderFeeItemsList.size();i++){
					  OrderFeeItems item=orderFeeItemsList.get(i);
					  if(item.getNum()==1){
						if(item.getPax()!=0){
					      //成人价格
						  PdfPCell num = new PdfPCell();
						  num.setBorder(0);
						  num.setBorderColor(Color.GRAY);
						  num.setBorderWidthBottom(0.3f);
						  num.setBorderWidthLeft(0.3f);
						  num.setMinimumHeight(20f);
						  num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  num.addElement(new Phrase(1+"",chineseFont));
						  itemsData.addCell(num);
						  
						  PdfPCell fee = new PdfPCell();
						  fee.setBorder(0);
						  fee.setBorderColor(Color.GRAY);
						  fee.setBorderWidthBottom(0.3f);
						  fee.setBorderWidthLeft(0.3f);
						  fee.setMinimumHeight(20f);
						  fee.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  fee.addElement(new Phrase("Tour Fee",chineseFont));
						  itemsData.addCell(fee);
						  
						  PdfPCell cType = new PdfPCell();
						  cType.setBorder(0);
						  cType.setBorderColor(Color.GRAY);
						  cType.setBorderWidthBottom(0.3f);
						  cType.setBorderWidthLeft(0.3f);
						  cType.setMinimumHeight(20f);
						  cType.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  cType.addElement(new Phrase(item.getFeeTitle(),chineseFont));
						  itemsData.addCell(cType);
						  
						  PdfPCell price = new PdfPCell();
						  price.setBorder(0);
						  price.setBorderColor(Color.GRAY);
						  price.setBorderWidthBottom(0.3f);
						  price.setBorderWidthLeft(0.3f);
						  price.setMinimumHeight(20f);
						  price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  price.addElement(new Phrase(item.getPrice().toString(),chineseFont));
						  itemsData.addCell(price);

						  PdfPCell qty = new PdfPCell();
						  qty.setBorder(0);
						  qty.setBorderColor(Color.GRAY);
						  qty.setBorderWidthBottom(0.3f);
						  qty.setBorderWidthLeft(0.3f);
						  qty.setMinimumHeight(20f);
						  qty.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  qty.addElement(new Phrase(item.getPax().toString(),chineseFont));
						  itemsData.addCell(qty);
						  
						  PdfPCell qtyTotal = new PdfPCell();
						  qtyTotal.setBorder(0);
						  qtyTotal.setBorderColor(Color.GRAY);
						  qtyTotal.setBorderWidthBottom(0.3f);
						  qtyTotal.setBorderWidthLeft(0.3f);
						  qtyTotal.setBorderWidthRight(0.3f);
						  qtyTotal.setMinimumHeight(20f);
						  qtyTotal.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  double total=item.getPrice().doubleValue()*item.getPax().doubleValue();
						  qtyTotal.addElement(new Phrase(total+"",chineseFont));
						  itemsData.addCell(qtyTotal);
						  //成人佣金
						  PdfPCell num1 = new PdfPCell();
						  num1.setBorder(0);
						  num1.setBorderColor(Color.GRAY);
						  num1.setBorderWidthBottom(0.3f);
						  num1.setBorderWidthLeft(0.3f);
						  num1.setMinimumHeight(20f);
						  num1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  num1.addElement(new Phrase(2+"",chineseFont));
						  itemsData.addCell(num1);
						  
						  PdfPCell feea = new PdfPCell();
						  feea.setBorder(0);
						  feea.setBorderColor(Color.GRAY);
						  feea.setBorderWidthBottom(0.3f);
						  feea.setBorderWidthLeft(0.3f);
						  feea.setMinimumHeight(20f);
						  feea.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  feea.addElement(new Phrase("Commission",chineseFont));
						  itemsData.addCell(feea);
						  
						  PdfPCell cTypea = new PdfPCell();
						  cTypea.setBorder(0);
						  cTypea.setBorderColor(Color.GRAY);
						  cTypea.setBorderWidthBottom(0.3f);
						  cTypea.setBorderWidthLeft(0.3f);
						  cTypea.setMinimumHeight(20f);
						  cTypea.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  cTypea.addElement(new Phrase("Adult",chineseFont));
						  itemsData.addCell(cTypea);
						  
						  PdfPCell pricea = new PdfPCell();
						  pricea.setBorder(0);
						  pricea.setBorderColor(Color.GRAY);
						  pricea.setBorderWidthBottom(0.3f);
						  pricea.setBorderWidthLeft(0.3f);
						  pricea.setMinimumHeight(20f);
						  pricea.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  pricea.addElement(new Phrase(orderFeeItemsList.get(9).getPrice().toString(),chineseFont));
						  itemsData.addCell(pricea);

						  PdfPCell qtya = new PdfPCell();
						  qtya.setBorder(0);
						  qtya.setBorderColor(Color.GRAY);
						  qtya.setBorderWidthBottom(0.3f);
						  qtya.setBorderWidthLeft(0.3f);
						  qtya.setMinimumHeight(20f);
						  qtya.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  qtya.addElement(new Phrase(orderFeeItemsList.get(9).getPax().toString(),chineseFont));
						  itemsData.addCell(qtya);
						  
						  PdfPCell qtyTotala = new PdfPCell();
						  qtyTotala.setBorder(0);
						  qtyTotala.setBorderColor(Color.GRAY);
						  qtyTotala.setBorderWidthBottom(0.3f);
						  qtyTotala.setBorderWidthLeft(0.3f);
						  qtyTotala.setBorderWidthRight(0.3f);
						  qtyTotala.setMinimumHeight(20f);
						  qtyTotala.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						  double totals=orderFeeItemsList.get(9).getPrice().doubleValue()*orderFeeItemsList.get(9).getPax().doubleValue();
						  qtyTotala.addElement(new Phrase("-"+totals+"",chineseFont));
						  itemsData.addCell(qtyTotala);
						  numb=2;
						  prices=total-totals;
						  }
						}else if(item.getNum()==2||item.getNum()==3||item.getNum()==4){
							if(item.getPax()!=0){
								numb+=1;
								//小孩价格
								  PdfPCell num = new PdfPCell();
								  num.setBorder(0);
								  num.setBorderColor(Color.GRAY);
								  num.setBorderWidthBottom(0.3f);
								  num.setBorderWidthLeft(0.3f);
								  num.setMinimumHeight(20f);
								  num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  num.addElement(new Phrase(numb+"",chineseFont));
								  itemsData.addCell(num);
								  
								  PdfPCell fee = new PdfPCell();
								  fee.setBorder(0);
								  fee.setBorderColor(Color.GRAY);
								  fee.setBorderWidthBottom(0.3f);
								  fee.setBorderWidthLeft(0.3f);
								  fee.setMinimumHeight(20f);
								  fee.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  fee.addElement(new Phrase("Tour Fee",chineseFont));
								  itemsData.addCell(fee);
								  
								  PdfPCell cType = new PdfPCell();
								  cType.setBorder(0);
								  cType.setBorderColor(Color.GRAY);
								  cType.setBorderWidthBottom(0.3f);
								  cType.setBorderWidthLeft(0.3f);
								  cType.setMinimumHeight(20f);
								  cType.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  cType.addElement(new Phrase(item.getFeeTitle(),chineseFont));
								  itemsData.addCell(cType);
								  
								  PdfPCell price = new PdfPCell();
								  price.setBorder(0);
								  price.setBorderColor(Color.GRAY);
								  price.setBorderWidthBottom(0.3f);
								  price.setBorderWidthLeft(0.3f);
								  price.setMinimumHeight(20f);
								  price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  price.addElement(new Phrase(item.getPrice().toString(),chineseFont));
								  itemsData.addCell(price);
	
								  PdfPCell qty = new PdfPCell();
								  qty.setBorder(0);
								  qty.setBorderColor(Color.GRAY);
								  qty.setBorderWidthBottom(0.3f);
								  qty.setBorderWidthLeft(0.3f);
								  qty.setMinimumHeight(20f);
								  qty.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  qty.addElement(new Phrase(item.getPax().toString(),chineseFont));
								  itemsData.addCell(qty);
								  
								  PdfPCell qtyTotal = new PdfPCell();
								  qtyTotal.setBorder(0);
								  qtyTotal.setBorderColor(Color.GRAY);
								  qtyTotal.setBorderWidthBottom(0.3f);
								  qtyTotal.setBorderWidthLeft(0.3f);
								  qtyTotal.setBorderWidthRight(0.3f);
								  qtyTotal.setMinimumHeight(20f);
								  qtyTotal.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  double total=item.getPrice().doubleValue()*item.getPax().doubleValue();
								  qtyTotal.addElement(new Phrase(total+"",chineseFont));
								  itemsData.addCell(qtyTotal);
								  prices=prices+total;
							}
							if(item.getNum()==4){
								if(orderFeeItemsList.get(10).getPax()!=0){
								  //小孩佣金
								  numb+=1;
								  PdfPCell num1 = new PdfPCell();
								  num1.setBorder(0);
								  num1.setBorderColor(Color.GRAY);
								  num1.setBorderWidthBottom(0.3f);
								  num1.setBorderWidthLeft(0.3f);
								  num1.setMinimumHeight(20f);
								  num1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  num1.addElement(new Phrase(numb+"",chineseFont));
								  itemsData.addCell(num1);
								  
								  PdfPCell feea = new PdfPCell();
								  feea.setBorder(0);
								  feea.setBorderColor(Color.GRAY);
								  feea.setBorderWidthBottom(0.3f);
								  feea.setBorderWidthLeft(0.3f);
								  feea.setMinimumHeight(20f);
								  feea.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  feea.addElement(new Phrase("Child Commission",chineseFont));
								  itemsData.addCell(feea);
								  
								  PdfPCell cTypea = new PdfPCell();
								  cTypea.setBorder(0);
								  cTypea.setBorderColor(Color.GRAY);
								  cTypea.setBorderWidthBottom(0.3f);
								  cTypea.setBorderWidthLeft(0.3f);
								  cTypea.setMinimumHeight(20f);
								  cTypea.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  cTypea.addElement(new Phrase("Child",chineseFont));
								  itemsData.addCell(cTypea);
								  
								  PdfPCell pricea = new PdfPCell();
								  pricea.setBorder(0);
								  pricea.setBorderColor(Color.GRAY);
								  pricea.setBorderWidthBottom(0.3f);
								  pricea.setBorderWidthLeft(0.3f);
								  pricea.setMinimumHeight(20f);
								  pricea.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  pricea.addElement(new Phrase(orderFeeItemsList.get(10).getPrice().toString(),chineseFont));
								  itemsData.addCell(pricea);
	
								  PdfPCell qtya = new PdfPCell();
								  qtya.setBorder(0);
								  qtya.setBorderColor(Color.GRAY);
								  qtya.setBorderWidthBottom(0.3f);
								  qtya.setBorderWidthLeft(0.3f);
								  qtya.setMinimumHeight(20f);
								  qtya.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  qtya.addElement(new Phrase(orderFeeItemsList.get(10).getPax().toString(),chineseFont));
								  itemsData.addCell(qtya);
								  
								  PdfPCell qtyTotala = new PdfPCell();
								  qtyTotala.setBorder(0);
								  qtyTotala.setBorderColor(Color.GRAY);
								  qtyTotala.setBorderWidthBottom(0.3f);
								  qtyTotala.setBorderWidthLeft(0.3f);
								  qtyTotala.setBorderWidthRight(0.3f);
								  qtyTotala.setMinimumHeight(20f);
								  qtyTotala.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  double totals=orderFeeItemsList.get(10).getPrice().doubleValue()*orderFeeItemsList.get(10).getPax().doubleValue();
								  qtyTotala.addElement(new Phrase("-"+totals+"",chineseFont));
								  itemsData.addCell(qtyTotala);
								  prices=prices-totals;
								}
							}
						}else if(item.getNum()>=7&&(item.getNum()!=10&&item.getNum()!=11)){
							if(item.getPrice().doubleValue()!=0){
							numb+=1;
							  //其他费用
							  PdfPCell num1 = new PdfPCell();
							  num1.setBorder(0);
							  num1.setBorderColor(Color.GRAY);
							  num1.setBorderWidthBottom(0.3f);
							  num1.setBorderWidthLeft(0.3f);
							  num1.setMinimumHeight(20f);
							  num1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							  num1.addElement(new Phrase(numb+"",chineseFont));
							  itemsData.addCell(num1);
							  PdfPCell fee = new PdfPCell();
							  fee.setBorder(0);
							  fee.setBorderColor(Color.GRAY);
							  fee.setBorderWidthBottom(0.3f);
							  fee.setBorderWidthLeft(0.3f);
							  fee.setMinimumHeight(20f);
							  fee.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							  fee.addElement(new Phrase("Tour Fee",chineseFont));
							  itemsData.addCell(fee);
							  
							  PdfPCell cType = new PdfPCell();
							  cType.setBorder(0);
							  cType.setBorderColor(Color.GRAY);
							  cType.setBorderWidthBottom(0.3f);
							  cType.setBorderWidthLeft(0.3f);
							  cType.setMinimumHeight(20f);
							  cType.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							  cType.addElement(new Phrase(item.getFeeTitle(),chineseFont));
							  itemsData.addCell(cType);
							  
							  PdfPCell price = new PdfPCell();
							  price.setBorder(0);
							  price.setBorderColor(Color.GRAY);
							  price.setBorderWidthBottom(0.3f);
							  price.setBorderWidthLeft(0.3f);
							  price.setMinimumHeight(20f);
							  price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							  price.addElement(new Phrase(item.getPrice().toString(),chineseFont));
							  itemsData.addCell(price);

							  PdfPCell qty = new PdfPCell();
							  qty.setBorder(0);
							  qty.setBorderColor(Color.GRAY);
							  qty.setBorderWidthBottom(0.3f);
							  qty.setBorderWidthLeft(0.3f);
							  qty.setMinimumHeight(20f);
							  qty.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							  qty.addElement(new Phrase(item.getPax().toString(),chineseFont));
							  itemsData.addCell(qty);
							  
							  PdfPCell qtyTotal = new PdfPCell();
							  qtyTotal.setBorder(0);
							  qtyTotal.setBorderColor(Color.GRAY);
							  qtyTotal.setBorderWidthBottom(0.3f);
							  qtyTotal.setBorderWidthLeft(0.3f);
							  qtyTotal.setBorderWidthRight(0.3f);
							  qtyTotal.setMinimumHeight(20f);
							  qtyTotal.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							  double total=item.getPrice().doubleValue()*item.getPax().doubleValue();
							  qtyTotal.addElement(new Phrase(""+total,chineseFont));
							  itemsData.addCell(qtyTotal);
							  prices=prices+total;
							}
						}else{
						}
				  }
				//最后计算费用
				  PdfPCell num1 = new PdfPCell();
				  num1.setBorder(0);
				  num1.setBorderColor(Color.GRAY);
				  num1.setBorderWidthBottom(0.3f);
				  num1.setBorderWidthLeft(0.3f);
				  num1.setMinimumHeight(20f);
				  num1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  num1.addElement(new Phrase("",chineseFont));
				  itemsData.addCell(num1);
				  PdfPCell fee = new PdfPCell();
				  fee.setBorder(0);
				  fee.setBorderColor(Color.GRAY);
				  fee.setBorderWidthBottom(0.3f);
				  fee.setBorderWidthLeft(0.3f);
				  fee.setMinimumHeight(20f);
				  fee.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  fee.addElement(new Phrase("",chineseFont));
				  itemsData.addCell(fee);
				  
				  Paragraph pA=new Paragraph("Sub Total Payable / Receivable A",chineseFont);
				  PdfPCell price = new PdfPCell(pA);
				  price.setPaddingTop(8f);
				  price.setBorder(0);
				  price.setBorderColor(Color.GRAY);
				  price.setBorderWidthBottom(0.3f);
				  price.setBorderWidthLeft(0.3f);
				  price.setMinimumHeight(20f);
				  price.setColspan(2);
				  price.setHorizontalAlignment(Element.ALIGN_RIGHT);
				  itemsData.addCell(price);

				  PdfPCell qty = new PdfPCell();
				  qty.setBorder(0);
				  qty.setBorderColor(Color.GRAY);
				  qty.setBorderWidthBottom(0.3f);
				  qty.setBorderWidthLeft(0.3f);
				  qty.setMinimumHeight(20f);
				  qty.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qty.addElement(new Phrase(currencyType.getCurrencyEng(),chineseFont));
				  itemsData.addCell(qty);
				  
				  PdfPCell qtyTotal = new PdfPCell();
				  qtyTotal.setBorder(0);
				  qtyTotal.setBorderColor(Color.GRAY);
				  qtyTotal.setBorderWidthBottom(0.3f);
				  qtyTotal.setBorderWidthLeft(0.3f);
				  qtyTotal.setBorderWidthRight(0.3f);
				  qtyTotal.setMinimumHeight(20f);
				  qtyTotal.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qtyTotal.addElement(new Phrase(prices+"",chineseFont));
				  itemsData.addCell(qtyTotal);
				  document.add(itemsData);
				  alotherPrice=prices;
				}
				
				
				//小费自费
				Paragraph tstitle = new Paragraph("Additional Order Calculation",bold_fontEng);
				tstitle.setAlignment(Paragraph.ALIGN_CENTER);
				tstitle.setSpacingAfter(10f);
				tstitle.setSpacingBefore(10f);
				document.add(tstitle);
				
				PdfPTable tsItemsData = new PdfPTable(6);
				float[] widss ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
				tsItemsData.setWidths(widss);
				tsItemsData.setWidthPercentage(100);
				tsItemsData.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell tableHeaderForItem1 = new PdfPCell();
				tableHeaderForItem1.setBorder(0);
				tableHeaderForItem1.setBorderColorBottom(Color.GRAY);
				tableHeaderForItem1.setBorderColorLeft(Color.GRAY);
				tableHeaderForItem1.setBorderColorRight(Color.GRAY);
				tableHeaderForItem1.setBorderWidthLeft(0.3f);
				tableHeaderForItem1.setBorderWidthRight(0.3f);
				tableHeaderForItem1.setBorderWidthBottom(0.3f);
				tableHeaderForItem1.setBorderWidthTop(1.5f);
				tableHeaderForItem1.setMinimumHeight(30f);
				tableHeaderForItem1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeaderForItem1.setMinimumHeight(20f);
				tableHeaderForItem1.setBorderWidth(0.5f);
				tableHeaderForItem1.setPhrase(new Phrase("#",bold_fontEngForTableHead));
				tsItemsData.addCell(tableHeaderForItem1);
				tableHeaderForItem1.setPhrase(new Phrase("Category",bold_fontEngForTableHead));
				tsItemsData.addCell(tableHeaderForItem1);
				tableHeaderForItem1.setPhrase(new Phrase("Item",bold_fontEngForTableHead));
				tsItemsData.addCell(tableHeaderForItem1);
				tableHeaderForItem1.setPhrase(new Phrase("Price (USD)",bold_fontEngForTableHead));
				tsItemsData.addCell(tableHeaderForItem1);
				tableHeaderForItem1.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
				tsItemsData.addCell(tableHeaderForItem1);
				tableHeaderForItem1.setPhrase(new Phrase("Sum",bold_fontEngForTableHead));
				tsItemsData.addCell(tableHeaderForItem1);
				
				
				if(orderFeeItemsList!=null){
					  int numb=0;
					  double prices=0;
					  for(int i=0;i<orderFeeItemsList.size();i++){
						  OrderFeeItems item=orderFeeItemsList.get(i);
						  if(item.getNum()==5||item.getNum()==6){
							  if(item.getPax()!=0){
								numb+=1;
								  //其他费用
								  PdfPCell num1 = new PdfPCell();
								  num1.setBorder(0);
								  num1.setBorderColor(Color.GRAY);
								  num1.setBorderWidthBottom(0.3f);
								  num1.setBorderWidthLeft(0.3f);
								  num1.setMinimumHeight(20f);
								  num1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  num1.addElement(new Phrase(numb+"",chineseFont));
								  tsItemsData.addCell(num1);
								  PdfPCell fee = new PdfPCell();
								  fee.setBorder(0);
								  fee.setBorderColor(Color.GRAY);
								  fee.setBorderWidthBottom(0.3f);
								  fee.setBorderWidthLeft(0.3f);
								  fee.setMinimumHeight(20f);
								  fee.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  fee.addElement(new Phrase("Pre-Paid",chineseFont));
								  tsItemsData.addCell(fee);
								  
								  PdfPCell cType = new PdfPCell();
								  cType.setBorder(0);
								  cType.setBorderColor(Color.GRAY);
								  cType.setBorderWidthBottom(0.3f);
								  cType.setBorderWidthLeft(0.3f);
								  cType.setMinimumHeight(20f);
								  cType.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  cType.addElement(new Phrase(item.getFeeTitle(),chineseFont));
								  tsItemsData.addCell(cType);
								  
								  PdfPCell price = new PdfPCell();
								  price.setBorder(0);
								  price.setBorderColor(Color.GRAY);
								  price.setBorderWidthBottom(0.3f);
								  price.setBorderWidthLeft(0.3f);
								  price.setMinimumHeight(20f);
								  price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  BigDecimal usFee=item.getPrice().divide(orders.get(0).getPeerUserRate(),2).setScale(2,BigDecimal.ROUND_DOWN);
								  price.addElement(new Phrase(usFee.toString(),chineseFont));
								  tsItemsData.addCell(price);

								  PdfPCell qty = new PdfPCell();
								  qty.setBorder(0);
								  qty.setBorderColor(Color.GRAY);
								  qty.setBorderWidthBottom(0.3f);
								  qty.setBorderWidthLeft(0.3f);
								  qty.setMinimumHeight(20f);
								  qty.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  qty.addElement(new Phrase(item.getPax().toString(),chineseFont));
								  tsItemsData.addCell(qty);
								  
								  PdfPCell qtyTotal = new PdfPCell();
								  qtyTotal.setBorder(0);
								  qtyTotal.setBorderColor(Color.GRAY);
								  qtyTotal.setBorderWidthBottom(0.3f);
								  qtyTotal.setBorderWidthLeft(0.3f);
								  qtyTotal.setBorderWidthRight(0.3f);
								  qtyTotal.setMinimumHeight(20f);
								  qtyTotal.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								  double total=usFee.doubleValue()*item.getPax().doubleValue();
								  qtyTotal.addElement(new Phrase(total+"",chineseFont));
								  tsItemsData.addCell(qtyTotal);
								  prices=prices+total;
							  }
					  }
					
					}
				  //最后计算费用
				  PdfPCell num1 = new PdfPCell();
				  num1.setBorder(0);
				  num1.setBorderColor(Color.GRAY);
				  num1.setBorderWidthBottom(0.3f);
				  num1.setBorderWidthLeft(0.3f);
				  num1.setMinimumHeight(20f);
				  num1.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(num1);
				  PdfPCell fee = new PdfPCell();
				  fee.setBorder(0);
				  fee.setBorderColor(Color.GRAY);
				  fee.setBorderWidthBottom(0.3f);
				  fee.setBorderWidthLeft(0.3f);
				  fee.setMinimumHeight(20f);
				  fee.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(fee);
				  
				  Paragraph pri=new Paragraph("Additional Sub Total Payable / Receivable B",chineseFont);
				  PdfPCell price = new PdfPCell(pri);
				  price.setPaddingTop(8f);
				  price.setBorder(0);
				  price.setBorderColor(Color.GRAY);
				  price.setBorderWidthBottom(0.3f);
				  price.setBorderWidthLeft(0.3f);
				  price.setMinimumHeight(20f);
				  price.setColspan(2);
				  price.setHorizontalAlignment(Element.ALIGN_RIGHT);
				  tsItemsData.addCell(price);

				  PdfPCell qty = new PdfPCell();
				  qty.setBorder(0);
				  qty.setBorderColor(Color.GRAY);
				  qty.setBorderWidthBottom(0.3f);
				  qty.setBorderWidthLeft(0.3f);
				  qty.setMinimumHeight(20f);
				  qty.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qty.addElement(new Phrase("USD",chineseFont));
				  tsItemsData.addCell(qty);
				  
				  PdfPCell qtyTotal = new PdfPCell();
				  qtyTotal.setBorder(0);
				  qtyTotal.setBorderColor(Color.GRAY);
				  qtyTotal.setBorderWidthBottom(0.3f);
				  qtyTotal.setBorderWidthLeft(0.3f);
				  qtyTotal.setBorderWidthRight(0.3f);
				  qtyTotal.setMinimumHeight(20f);
				  qtyTotal.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qtyTotal.addElement(new Phrase(prices+"",chineseFont));
				  tsItemsData.addCell(qtyTotal);
				  
				  PdfPCell num11 = new PdfPCell();
				  num11.setBorder(0);
				  num11.setBorderColor(Color.GRAY);
				  num11.setBorderWidthBottom(0.3f);
				  num11.setBorderWidthLeft(0.3f);
				  num11.setMinimumHeight(20f);
				  num11.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(num11);
				  PdfPCell fee1 = new PdfPCell();
				  fee1.setBorder(0);
				  fee1.setBorderColor(Color.GRAY);
				  fee1.setBorderWidthBottom(0.3f);
				  fee1.setBorderWidthLeft(0.3f);
				  fee1.setMinimumHeight(20f);
				  fee1.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(fee1);
				  
				  Paragraph pri1=new Paragraph("Exchange Rate",chineseFont);
				  PdfPCell price1 = new PdfPCell(pri1);
				  price1.setPaddingTop(8f);
				  price1.setBorder(0);
				  price1.setBorderColor(Color.GRAY);
				  price1.setBorderWidthBottom(0.3f);
				  price1.setBorderWidthLeft(0.3f);
				  price1.setMinimumHeight(20f);
				  price1.setColspan(2);
				  price1.setHorizontalAlignment(Element.ALIGN_RIGHT);
				  tsItemsData.addCell(price1);

				  PdfPCell qty1 = new PdfPCell();
				  qty1.setBorder(0);
				  qty1.setBorderColor(Color.GRAY);
				  qty1.setBorderWidthBottom(0.3f);
				  qty1.setBorderWidthLeft(0.3f);
				  qty1.setMinimumHeight(20f);
				  qty1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qty1.addElement(new Phrase(orders.get(0).getPeerUserRate().toString(),chineseFont));
				  tsItemsData.addCell(qty1);
				  
				  PdfPCell qtyTotal1 = new PdfPCell();
				  qtyTotal1.setBorder(0);
				  qtyTotal1.setBorderColor(Color.GRAY);
				  qtyTotal1.setBorderWidthBottom(0.3f);
				  qtyTotal1.setBorderWidthLeft(0.3f);
				  qtyTotal1.setBorderWidthRight(0.3f);
				  qtyTotal1.setMinimumHeight(20f);
				  qtyTotal1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qtyTotal1.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(qtyTotal1);
				  
				  PdfPCell num12 = new PdfPCell();
				  num12.setBorder(0);
				  num12.setBorderColor(Color.GRAY);
				  num12.setBorderWidthBottom(0.3f);
				  num12.setBorderWidthLeft(0.3f);
				  num12.setMinimumHeight(20f);
				  num12.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  num12.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(num12);
				  PdfPCell fee2 = new PdfPCell();
				  fee2.setBorder(0);
				  fee2.setBorderColor(Color.GRAY);
				  fee2.setBorderWidthBottom(0.3f);
				  fee2.setBorderWidthLeft(0.3f);
				  fee2.setMinimumHeight(20f);
				  fee2.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  fee2.addElement(new Phrase("",chineseFont));
				  tsItemsData.addCell(fee2);
				  
				  Paragraph pri2=new Paragraph("Additional Sub Total Payable / Receivable B",chineseFont);
				  PdfPCell price2 = new PdfPCell(pri2);
				  price2.setPaddingTop(8f);
				  price2.setBorder(0);
				  price2.setBorderColor(Color.GRAY);
				  price2.setBorderWidthBottom(0.3f);
				  price2.setBorderWidthLeft(0.3f);
				  price2.setMinimumHeight(20f);
				  price2.setColspan(2);
				  price2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				  tsItemsData.addCell(price2);

				  PdfPCell qty2 = new PdfPCell();
				  qty2.setBorder(0);
				  qty2.setBorderColor(Color.GRAY);
				  qty2.setBorderWidthBottom(0.3f);
				  qty2.setBorderWidthLeft(0.3f);
				  qty2.setMinimumHeight(20f);
				  qty2.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  qty2.addElement(new Phrase(currencyType.getCurrencyEng(),chineseFont));
				  tsItemsData.addCell(qty2);
				  
				  PdfPCell qtyTotal2 = new PdfPCell();
				  qtyTotal2.setBorder(0);
				  qtyTotal2.setBorderColor(Color.GRAY);
				  qtyTotal2.setBorderWidthBottom(0.3f);
				  qtyTotal2.setBorderWidthLeft(0.3f);
				  qtyTotal2.setBorderWidthRight(0.3f);
				  qtyTotal2.setMinimumHeight(20f);
				  qtyTotal2.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				  BigDecimal ratep=new BigDecimal(prices).multiply(orders.get(0).getPeerUserRate()).setScale(2,BigDecimal.ROUND_HALF_UP);//转换后金额
				  qtyTotal2.addElement(new Phrase(ratep+"",chineseFont));
				  tsItemsData.addCell(qtyTotal2);
				  document.add(tsItemsData);
				  tsRatePrice=ratep.doubleValue();
				}
				//费用之和
				Paragraph allFee = new Paragraph("Order Summary",bold_fontEng);
				allFee.setAlignment(Paragraph.ALIGN_CENTER);
				allFee.setSpacingAfter(10f);
				allFee.setSpacingBefore(10f);
				document.add(allFee);
				
				PdfPTable feeData = new PdfPTable(5);
				float[] wid7 ={0.05f,0.15f,0.35f,0.15f,0.15f};
				feeData.setWidths(wid7);
				feeData.setWidthPercentage(100);
				feeData.getDefaultCell().setBorderWidthBottom(0);
				
				PdfPCell cell = new PdfPCell();
				cell.setBorder(0);
				cell.setBorderColorTop(Color.WHITE);
				cell.setBorderColorBottom(Color.BLACK);
				cell.setBorderWidthBottom(1.5f);
				cell.setBorderWidthTop(0);
				cell.setMinimumHeight(0);
				cell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				cell.setMinimumHeight(0);
				cell.setBorderWidth(0);
				cell.setPhrase(new Phrase("",bold_fontEngForTableHead));
				feeData.addCell(cell);
				cell.setPhrase(new Phrase("",bold_fontEngForTableHead));
				feeData.addCell(cell);
				cell.setPhrase(new Phrase("",bold_fontEngForTableHead));
				feeData.addCell(cell);
				cell.setPhrase(new Phrase("",bold_fontEngForTableHead));
				feeData.addCell(cell);
				cell.setPhrase(new Phrase("",bold_fontEngForTableHead));
				feeData.addCell(cell);

				PdfPCell num11 = new PdfPCell();
			    num11.setBorder(0);
			    num11.setBorderColor(Color.GRAY);
			    num11.setBorderWidthBottom(0.3f);
				num11.setBorderWidthLeft(0.3f);
			    num11.setMinimumHeight(20f);
			    num11.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num11.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num11);
			    PdfPCell num12 = new PdfPCell();
			    num12.setBorder(0);
			    num12.setBorderColor(Color.GRAY);
			    num12.setBorderWidthBottom(0.3f);
				num12.setBorderWidthLeft(0.3f);
			    num12.setMinimumHeight(20f);
			    num12.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num12.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num12);
			    
			    Paragraph p=new Paragraph("Total Payable or Receivable (A+B)",chineseFont);
			    PdfPCell num13 = new PdfPCell(p);
			    num13.setPaddingTop(8f);
			    num13.setBorder(0);
			    num13.setBorderColor(Color.GRAY);
			    num13.setBorderWidthBottom(0.3f);
				num13.setBorderWidthLeft(0.3f);
			    num13.setMinimumHeight(20f);
			    num13.setHorizontalAlignment(Element.ALIGN_RIGHT);
			    feeData.addCell(num13);
			  
			    PdfPCell num14 = new PdfPCell();
			    num14.setBorder(0);
			    num14.setBorderColor(Color.GRAY);
			    num14.setBorderWidthBottom(0.3f);
				num14.setBorderWidthLeft(0.3f);
			    num14.setMinimumHeight(20f);
			    num14.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num14.addElement(new Phrase(currencyType.getCurrencyEng(),chineseFont));
			    feeData.addCell(num14);

			    PdfPCell num15 = new PdfPCell();
			    num15.setBorder(0);
			    num15.setBorderColor(Color.GRAY);
			    num15.setBorderWidthBottom(0.3f);
				num15.setBorderWidthLeft(0.3f);
				num15.setBorderWidthRight(0.3f);
			    num15.setMinimumHeight(20f);
			    num15.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    BigDecimal sumPrices=new BigDecimal(alotherPrice).add(new BigDecimal(tsRatePrice)).setScale(2,BigDecimal.ROUND_HALF_UP);
			    num15.addElement(new Phrase(sumPrices+"",chineseFont));
			    feeData.addCell(num15);
			    
			    PdfPCell num21 = new PdfPCell();
			    num21.setBorder(0);
			    num21.setBorderColor(Color.GRAY);
			    num21.setBorderWidthBottom(0.3f);
				num21.setBorderWidthLeft(0.3f);
			    num21.setMinimumHeight(20f);
			    num21.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num21);
			    PdfPCell num22 = new PdfPCell();
			    num22.setBorder(0);
			    num22.setBorderColor(Color.GRAY);
			    num22.setBorderWidthBottom(0.3f);
				num22.setBorderWidthLeft(0.3f);
			    num22.setMinimumHeight(20f);
			    num22.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num22);
			    
			    Paragraph p23=new Paragraph("GST Amount Inclusive",chineseFont);
			    PdfPCell num23 = new PdfPCell(p23);
			    num23.setPaddingTop(8f);
			    num23.setBorder(0);
			    num23.setBorderColor(Color.GRAY);
			    num23.setBorderWidthBottom(0.3f);
				num23.setBorderWidthLeft(0.3f);
			    num23.setMinimumHeight(20f);
			    num23.setHorizontalAlignment(Element.ALIGN_RIGHT);
			    feeData.addCell(num23);
			  
			    PdfPCell num24 = new PdfPCell();
			    num24.setBorder(0);
			    num24.setBorderColor(Color.GRAY);
			    num24.setBorderWidthBottom(0.3f);
				num24.setBorderWidthLeft(0.3f);
			    num24.setMinimumHeight(20f);
			    num24.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num24.addElement(new Phrase(currencyType.getCurrencyEng(),chineseFont));
			    feeData.addCell(num24);

			    PdfPCell num25 = new PdfPCell();
			    num25.setBorder(0);
			    num25.setBorderColor(Color.GRAY);
			    num25.setBorderWidthBottom(0.3f);
				num25.setBorderWidthLeft(0.3f);
				num25.setBorderWidthRight(0.3f);
			    num25.setMinimumHeight(20f);
			    num25.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num25.addElement(new Phrase("0",chineseFont));
			    feeData.addCell(num25);
			    
			    PdfPCell num31 = new PdfPCell();
			    num31.setBorder(0);
			    num31.setBorderColor(Color.GRAY);
			    num31.setBorderWidthBottom(0.3f);
				num31.setBorderWidthLeft(0.3f);
			    num31.setMinimumHeight(20f);
			    num31.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num31);
			    PdfPCell num32 = new PdfPCell();
			    num32.setBorder(0);
			    num32.setBorderColor(Color.GRAY);
			    num32.setBorderWidthBottom(0.3f);
				num32.setBorderWidthLeft(0.3f);
			    num32.setMinimumHeight(20f);
			    num32.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num32);
			  
			    Paragraph p33=new Paragraph("Settlement",chineseFont);
			    PdfPCell num33 = new PdfPCell(p33);
			    num33.setPaddingTop(8f);
			    num33.setBorder(0);
			    num33.setBorderColor(Color.GRAY);
			    num33.setBorderWidthBottom(0.3f);
				num33.setBorderWidthLeft(0.3f);
			    num33.setMinimumHeight(20f);
			    num33.setHorizontalAlignment(Element.ALIGN_RIGHT);
			    feeData.addCell(num33);
			  
			    PdfPCell num34 = new PdfPCell();
			    num34.setBorder(0);
			    num34.setBorderColor(Color.GRAY);
			    num34.setBorderWidthBottom(0.3f);
				num34.setBorderWidthLeft(0.3f);
			    num34.setMinimumHeight(20f);
			    num34.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num34.addElement(new Phrase(currencyType.getCurrencyEng(),chineseFont));
			    feeData.addCell(num34);

			    PdfPCell num35 = new PdfPCell();
			    num35.setBorder(0);
			    num35.setBorderColor(Color.GRAY);
			    num35.setBorderWidthBottom(0.3f);
				num35.setBorderWidthLeft(0.3f);
				num35.setBorderWidthRight(0.3f);
			    num35.setMinimumHeight(20f);
			    num35.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num35.addElement(new Phrase(orders.get(0).getCostState()==2?sumPrices+"":"0",chineseFont));
			    feeData.addCell(num35);
			    
			    PdfPCell num41 = new PdfPCell();
			    num41.setBorder(0);
			    num41.setBorderColor(Color.GRAY);
			    num41.setBorderWidthBottom(0.3f);
				num41.setBorderWidthLeft(0.3f);
			    num41.setMinimumHeight(20f);
			    num41.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num41);
			    PdfPCell num42 = new PdfPCell();
			    num42.setBorder(0);
			    num42.setBorderColor(Color.GRAY);
			    num42.setBorderWidthBottom(0.3f);
				num42.setBorderWidthLeft(0.3f);
			    num42.setMinimumHeight(20f);
			    num42.addElement(new Phrase("",chineseFont));
			    feeData.addCell(num42);
			  
			    Paragraph p43=new Paragraph("Balance",chineseFont);
			    PdfPCell num43 = new PdfPCell(p43);
			    num43.setPaddingTop(8f);
			    num43.setBorder(0);
			    num43.setBorderColor(Color.GRAY);
			    num43.setBorderWidthBottom(0.3f);
				num43.setBorderWidthLeft(0.3f);
			    num43.setMinimumHeight(20f);
			    num43.setHorizontalAlignment(Element.ALIGN_RIGHT);
			    feeData.addCell(num43);
			  
			    PdfPCell num44 = new PdfPCell();
			    num44.setBorder(0);
			    num44.setBorderColor(Color.GRAY);
			    num44.setBorderWidthBottom(0.3f);
			    num44.setMinimumHeight(20f);
				num44.setBorderWidthLeft(0.3f);
			    num44.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num44.addElement(new Phrase(currencyType.getCurrencyEng(),chineseFont));
			    feeData.addCell(num44);

			    PdfPCell num45 = new PdfPCell();
			    num45.setBorder(0);
			    num45.setBorderColor(Color.GRAY);
			    num45.setBorderWidthBottom(0.3f);
				num45.setBorderWidthLeft(0.3f);
				num45.setBorderWidthRight(0.3f);
			    num45.setMinimumHeight(20f);
			    num45.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
			    num45.addElement(new Phrase(orders.get(0).getCostState()==2?"0":sumPrices+"",chineseFont));
			    feeData.addCell(num45);
			    document.add(feeData);
			    //费用历史记录
			    Paragraph historytitle = new Paragraph("Settlement History",bold_fontEng);
			    historytitle.setAlignment(Paragraph.ALIGN_CENTER);
			    historytitle.setSpacingAfter(10f);
			    historytitle.setSpacingBefore(10f);
				document.add(historytitle);
				
				PdfPTable historyFee = new PdfPTable(4);
				float[] wid8 ={0.05f,0.15f,0.35f,0.15f};
				historyFee.setWidths(wid8);
				historyFee.setWidthPercentage(100);
				historyFee.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell feetitle = new PdfPCell();
				feetitle.setBorder(0);
				feetitle.setBorderColorBottom(Color.GRAY);
				feetitle.setBorderColorLeft(Color.GRAY);
				feetitle.setBorderColorRight(Color.GRAY);
				feetitle.setBorderWidthLeft(0.3f);
				feetitle.setBorderWidthRight(0.3f);
				feetitle.setBorderWidthBottom(0.3f);
				feetitle.setBorderWidthTop(1.5f);
				feetitle.setMinimumHeight(30f);
				feetitle.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				feetitle.setMinimumHeight(20f);
				feetitle.setBorderWidth(0.5f);
				feetitle.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
				historyFee.addCell(feetitle);
				feetitle.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
				historyFee.addCell(feetitle);
				feetitle.setPhrase(new Phrase(currencyType.getCurrencyEng(),bold_fontEngForTableHead));
				historyFee.addCell(feetitle);
				feetitle.setPhrase(new Phrase("Amount",bold_fontEngForTableHead));
				historyFee.addCell(feetitle);
				document.add(historyFee);
				
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
	
	
	/**
	 * 生成机票Invoice
	 * @param InvoiceNum
	 * @return
	 */
	@Override
	public String CreateInvoicePdfForTicket(String id) {
		SupplierPriceForOrder supplierPriceForOrder =supplierPriceForOrderService.findById(id);
		//查找录机票账单人员信息
		Admin ticketPer=adminService.findById(supplierPriceForOrder.getUserId());
		Admin agen=new Admin();
		String billTo="";
		String address="";
	    String phone="";
	    String emailAgent="";
	    String company="";
		if(supplierPriceForOrder.getAgentId()!=""){
			agen=adminService.findById(supplierPriceForOrder.getAgentId());
			billTo=agen.getUsername();
			address="";
			phone=agen.getTel();
			emailAgent=agen.getEmail();
			company=deptMapper.findById(agen.getDeptId()).getDeptName();
		}else{
			billTo=supplierPriceForOrder.getTempValue01();
		}
		List<AirticketItems> airticketItems=airticketItemsService.findByOrderId(id);
		//此处打印机票费用详情
		BigDecimal Chargeinfo=new BigDecimal(0.00);
		BigDecimal Sellinginfo=new BigDecimal(0.00);
		BigDecimal Netinfo=new BigDecimal(0.00);
		BigDecimal Charge=new BigDecimal(0.00);
		BigDecimal Selling =new BigDecimal(0.00);
		BigDecimal Credit =new BigDecimal(0.00);
		for(AirticketItems airticketItem:airticketItems){
			Charge=Charge.add(airticketItem.getCharge());
			Selling=Selling.add(airticketItem.getSelling());
		}
		Credit=Selling.subtract(Charge).setScale(2,BigDecimal.ROUND_HALF_UP);//转换后金额
		//标头显示的信息
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				String InvoiceNum=supplierPriceForOrder.getInvoiceNum();
				String ticketPer_Name=supplierPriceForOrder.getUserName();
				String ticketPer_address="";
			    String ticketPer_Tel = "";
			    String ticketPer_Fax="";
			    String ticketPer_Email="";
			    String invoiceRemark="";
			    if(ticketPer!=null){
			    	if(ticketPer.getAddress()!=null||ticketPer.getAddress()!=""){
			    		ticketPer_address=ticketPer.getAddress();
			    	}
			    	if(ticketPer.getTel()!=null||ticketPer.getTel()!=""){
			    		ticketPer_Tel=ticketPer.getTel();
			    	}
			    	if(ticketPer.getFax()!=null||ticketPer.getFax()!=""){
			    		ticketPer_Fax=ticketPer.getFax();
			    	}
			    	if(ticketPer.getEmail()!=null||ticketPer.getEmail()!=""){
			    		ticketPer_Email=ticketPer.getEmail();
			    	}
			    	if(ticketPer.getAddress()!=null||ticketPer.getAddress()!=""){
			    		ticketPer_address=ticketPer.getAddress();
			    	}
			    	if(supplierPriceForOrder.getInvoiceRemark()!=null){
			    		invoiceRemark=supplierPriceForOrder.getInvoiceRemark();
			    	}
			    }
			    Vender vender=new Vender();
		    	if(supplierPriceForOrder.getAgency()!=""){
		    		vender=venderMapper.findById(supplierPriceForOrder.getAgency());
		    		company=vender.getName();
		    		address=vender.getAddress();
		    		phone=vender.getTel();
		    	}
		    	
		Setting setting = SettingUtils.get();
		String uploadPath = setting.getTempPDFPath();
		String destPath = null;
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			String path = FreemarkerUtils.process(uploadPath, model);
			destPath = path + "invoice-"+InvoiceNum+".pdf";
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			
			// 创建一个Document对象
			Document document = new Document(PageSize.A4, 36, 36, 24, 36);
			try {
				// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
				
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
				String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
				BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
				BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
						Color.BLACK);
				
				Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
						Color.BLACK);
				//中文超大号
				Font  chineseFontBig = new Font(bfChinese, 12,  Font.BOLD,Color.BLACK);
				
				//中文斜体(大号)
				Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
				//中文斜体(小号)
				Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
				
				document.open();
				// 添加抬头图片
				PdfPTable table1 = new PdfPTable(3); //表格两列
				table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table1.setWidthPercentage(100);//表格的宽度为100%
				table1.getDefaultCell().setBorderWidth(0); //不显示边框
				 //两列宽度的比例并设置logo
				String logo = "";
					logo = Constant.LOGO_PATH[1];
				if(logo.equals(Constant.LOGO_PATH[1])){
						float[] wid1 ={0.30f,0.45f,0.25f};
						table1.setWidths(wid1);
				}
				
				
				PdfPTable table13 = new PdfPTable(1);
				table13.getDefaultCell().setBorderWidth(0);
				PdfPCell cell2 = new PdfPCell(table13);
				cell2.setBorder(0);
				table1.addCell(cell2);
					
					PdfPCell cellTitle = new PdfPCell(new Paragraph("chinatour.com",chineseFontBig));
					cellTitle.setBorder(0);
					cellTitle.setMinimumHeight(10f);
					table13.addCell(cellTitle);
				
					PdfPCell cell21 = new PdfPCell(new Paragraph("Agent Name:"+ticketPer_Name,littleChineseFont));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell celladdress = new PdfPCell(new Paragraph("Address:"+ticketPer_address,littleChineseFont));
					celladdress.setBorder(0);
					celladdress.setMinimumHeight(10f);
					table13.addCell(celladdress);
					
					PdfPCell cell24 = new PdfPCell(new Paragraph("Tel:"+ticketPer_Tel,littleChineseFont));
					cell24.setBorder(0);
					cell24.setMinimumHeight(10f);
					table13.addCell(cell24);
					
					PdfPCell cell25 = new PdfPCell(new Paragraph("Fax:"+ticketPer_Fax,littleChineseFont));
					cell25.setBorder(0);
					cell25.setMinimumHeight(10f);
					table13.addCell(cell25);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+ticketPer_Email,littleChineseFont));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					table13.addCell(cell26);
				
				PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
				cell1.setBorder(Rectangle.NO_BORDER);
				table1.addCell(cell1);
					
				
				
				PdfPTable table11 = new PdfPTable(1);
				table11.getDefaultCell().setBorder(0);
				Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
				jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
				jpeg.setAlignment(Image.ALIGN_MIDDLE);
				jpeg.setBorder(0);
				table11.addCell(jpeg);
				table11.getDefaultCell().setBorderWidth(0);
				PdfPCell cell0 = new PdfPCell(table11);
				cell0.setBorder(0);
				table11.setWidthPercentage(50);
				table1.addCell(cell0);
				cell0.setBorder(0);
				
				document.add(table1);
				
				PdfContentByte cb=writer.getDirectContent();
				cb.setLineWidth(0.3f);
				
				
				/*BILL TO信息添加*/
				PdfPTable tableFight = new PdfPTable(2);
				float[] widOrder4 ={0.5f,0.5f};
				tableFight.setWidths(widOrder4);
				tableFight.setWidthPercentage(100);
				tableFight.getDefaultCell().setBorderWidthTop(0);
				tableFight.setSpacingBefore(10f);
				
				PdfPCell tableFightCell = new PdfPCell();
				tableFightCell.setBorder(0);
				tableFightCell.setBorderWidthTop(0.3f);
				tableFightCell.setPaddingTop(10f);
				tableFightCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableFightCell.setPhrase(new Phrase("BILL TO:"+billTo,bold_fontEng));
				tableFight.addCell(tableFightCell);
				tableFightCell.setPhrase(new Phrase("Invoice No:"+supplierPriceForOrder.getInvoiceNum(),norm_fontEng));
				tableFight.addCell(tableFightCell);
				
				
				PdfPCell orderItems_0 = new PdfPCell(new Paragraph("Company:"+company,norm_fontEng));
				orderItems_0.setBorder(0);
				orderItems_0.setMinimumHeight(10f);
				tableFight.addCell(orderItems_0);
				
				PdfPCell orderItems_1 = new PdfPCell(new Paragraph("PNR:"+supplierPriceForOrder.getFlightPnr(),norm_fontEng));
				orderItems_1.setBorder(0);
				orderItems_1.setMinimumHeight(10f);
				tableFight.addCell(orderItems_1);
				
				PdfPCell orderItems_2 = new PdfPCell(new Paragraph("Address:"+address,norm_fontEng));
				orderItems_2.setBorder(0);
				orderItems_2.setMinimumHeight(10f);
				tableFight.addCell(orderItems_2);
				
				PdfPCell orderItemsSpace3 = new PdfPCell(new Paragraph("Booking Date:"+df.format(supplierPriceForOrder.getCreateDate()),norm_fontEng));
				orderItemsSpace3.setBorder(0);
				orderItemsSpace3.setMinimumHeight(10f);
				tableFight.addCell(orderItemsSpace3);
				
				
				PdfPCell tabalCell_2_3 = new PdfPCell(new Paragraph("Phone:"+phone,norm_fontEng));
				tabalCell_2_3.setBorder(0);
				tabalCell_2_3.setMinimumHeight(10f);
				tableFight.addCell(tabalCell_2_3);
				
				PdfPCell orderItems_3 = new PdfPCell(new Paragraph("",norm_fontEng));
				orderItems_3.setBorder(0);
				orderItems_3.setMinimumHeight(10f);
				tableFight.addCell(orderItems_3);
				
				
				PdfPCell tabalCell_space2 = new PdfPCell(new Paragraph("Email:"+emailAgent,norm_fontEng));
				tabalCell_space2.setBorder(0);
				tabalCell_space2.setMinimumHeight(10f);
				tableFight.addCell(tabalCell_space2);
				
				PdfPCell orderItemsSpace6 = new PdfPCell(new Paragraph("",norm_fontEng));
				orderItemsSpace6.setBorder(0);
				orderItemsSpace6.setMinimumHeight(10f);
				tableFight.addCell(orderItemsSpace6);
				
				document.add(tableFight);
				
				
				Paragraph TicketInfoTittle = new Paragraph("The Ticket Item Information",bold_fontEng);
				TicketInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
				TicketInfoTittle.setSpacingAfter(10f);
				TicketInfoTittle.setSpacingBefore(10f);
				document.add(TicketInfoTittle);
				
				PdfPTable ticketData = new PdfPTable(4);
				float[] ticketWith ={0.3f,0.3f,0.2f,0.2f};
				ticketData.setWidths(ticketWith);
				ticketData.setWidthPercentage(100);
				ticketData.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell tableHeader = new PdfPCell();
				tableHeader.setBorder(0);
				tableHeader.setBorderColorBottom(Color.GRAY);
				tableHeader.setBorderWidthBottom(0.3f);
				tableHeader.setBorderWidthTop(1.5f);
				tableHeader.setMinimumHeight(30f);
				tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeader.setMinimumHeight(25f);
				tableHeader.setBorderWidth(0.5f);
				tableHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
				ticketData.addCell(tableHeader);
				tableHeader.setPhrase(new Phrase("TicketNo",bold_fontEngForTableHead));
				ticketData.addCell(tableHeader);
				tableHeader.setPhrase(new Phrase("Charge",bold_fontEngForTableHead));
				ticketData.addCell(tableHeader);
//				tableHeader.setPhrase(new Phrase("Net",bold_fontEngForTableHead));
//				ticketData.addCell(tableHeader);
				tableHeader.setPhrase(new Phrase("Selling",bold_fontEngForTableHead));
				ticketData.addCell(tableHeader);
				if(airticketItems!=null){
					for(AirticketItems airItems:airticketItems){
						
						PdfPCell AirLine = new PdfPCell();
						AirLine.setBorder(0);
						AirLine.setBorderColorBottom(Color.GRAY);
						AirLine.setBorderWidthBottom(0.3f);
						AirLine.setMinimumHeight(36f);
						AirLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						AirLine.addElement(new Phrase(supplierPriceForOrder.getAirline(),norm_fontEng));
						ticketData.addCell(AirLine);
						
						Chargeinfo=airItems.getCharge();
						Sellinginfo=airItems.getSelling();
						Netinfo=airItems.getNet();
						PdfPCell ticketNo = new PdfPCell();
						ticketNo.setBorder(0);
						ticketNo.setBorderColorBottom(Color.GRAY);
						ticketNo.setBorderWidthBottom(0.3f);
						ticketNo.setMinimumHeight(36f);
						ticketNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						ticketNo.addElement(new Phrase(airItems.getTicketNo(),norm_fontEng));
						ticketData.addCell(ticketNo);
						
						PdfPCell ChargeinfoCell = new PdfPCell();
						ChargeinfoCell.setBorder(0);
						ChargeinfoCell.setBorderColorBottom(Color.GRAY);
						ChargeinfoCell.setBorderWidthBottom(0.3f);
						ChargeinfoCell.setMinimumHeight(36f);
						ChargeinfoCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						ChargeinfoCell.addElement(new Phrase(Chargeinfo+"",norm_fontEng));
						ticketData.addCell(ChargeinfoCell);
						
						
						PdfPCell SellinginfoCell = new PdfPCell();
						SellinginfoCell.setBorder(0);
						SellinginfoCell.setBorderColorBottom(Color.GRAY);
						SellinginfoCell.setBorderWidthBottom(0.3f);
						SellinginfoCell.setMinimumHeight(36f);
						SellinginfoCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						SellinginfoCell.addElement(new Phrase(Sellinginfo+"",norm_fontEng));
						ticketData.addCell(SellinginfoCell);
						
					}
				}
				
				document.add(ticketData);
				
				PdfPTable tableReamrk = new PdfPTable(1); //表格两列
				tableReamrk.setSpacingBefore(15f);
				tableReamrk.setSpacingAfter(10f);
				tableReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tableReamrk.setWidthPercentage(100);//表格的宽度为100%
				
				
				PdfPCell CellReamrk_2 = new PdfPCell(new Paragraph("Remarks:\n  "+invoiceRemark,chineseFont));
				CellReamrk_2.setBorderWidth(0.2f);
				CellReamrk_2.setBorderColor(Color.DARK_GRAY);
				CellReamrk_2.setPaddingBottom(2f);
				tableReamrk.addCell(CellReamrk_2);
				document.add(tableReamrk);
				
				
				PdfPTable tableInfo = new PdfPTable(3); //表格两列
				tableInfo.setSpacingBefore(3f);
				tableInfo.setSpacingAfter(5f);
				float[] Reamrk ={0.5f,0.2f,0.3f};
				tableInfo.setWidths(Reamrk);
				tableInfo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tableInfo.setWidthPercentage(100);//表格的宽度为100%
				tableInfo.getDefaultCell().setBorderWidth(0); //不显示边框
				tableInfo.getDefaultCell().setBorderColor(Color.GRAY);
				
				PdfPTable tableInfo_1 = new PdfPTable(1);
				tableInfo_1.getDefaultCell().setBorderWidth(0);
				PdfPCell CellInfo_1 = new PdfPCell(tableInfo_1);
				CellInfo_1.setBorder(0);
				tableInfo.addCell(CellInfo_1);
				
				PdfPCell CellInfo_2 = new PdfPCell(new Paragraph("Contact Name:             "+supplierPriceForOrder.getTempValue01(),norm_fontEng));
				CellInfo_2.setBorder(0);
				CellInfo_2.setPaddingTop(5f);
				CellInfo_2.setPaddingBottom(7f);
				tableInfo_1.addCell(CellInfo_2);
				
				PdfPCell CellInfo_3 = new PdfPCell(new Paragraph("Payment Method:       "+supplierPriceForOrder.getCard(),norm_fontEng));
				CellInfo_3.setBorder(0);
				CellInfo_3.setPaddingBottom(5f);
				tableInfo_1.addCell(CellInfo_3);
				
				PdfPCell CellInfo_4 = new PdfPCell(new Paragraph("")); //
				CellInfo_4.setBorder(0);
				CellInfo_4.setBorderColor(Color.GRAY);
				tableInfo.addCell(CellInfo_4);
				
				PdfPTable tableInfo_2 = new PdfPTable(1);
				PdfPCell CellInfo_5 = new PdfPCell(tableInfo_2);
				CellInfo_5.setBorder(0);
				tableInfo.addCell(CellInfo_5);
				
				
				PdfPCell CellInfo_6 = new PdfPCell(new Paragraph("Charge Amount:    "+Charge,norm_fontEng));
				CellInfo_6.setBorder(0);
				CellInfo_6.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableInfo_2.addCell(CellInfo_6);
				
				PdfPCell CellInfo_7 = new PdfPCell(new Paragraph("Selling Amount:     "+Selling,norm_fontEng));
				CellInfo_7.setBorder(0);
				CellInfo_7.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableInfo_2.addCell(CellInfo_7);
				
				PdfPCell CellInfo_8 = new PdfPCell(new Paragraph("Balance                 "+Credit,bold_fontEng));
				CellInfo_8.setBorder(0);
				CellInfo_8.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableInfo_2.addCell(CellInfo_8);
				
				document.add(tableInfo);
				
				
				PdfPTable tableInfoRemark = new PdfPTable(1); 
				tableInfoRemark.setSpacingBefore(8f);
				tableInfoRemark.setSpacingAfter(1f);
				tableInfoRemark.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tableInfoRemark.setWidthPercentage(100);//表格的宽度为100%
				tableInfoRemark.getDefaultCell().setBorderWidth(0);
				
				Paragraph LogoSpace = new Paragraph("Please  inspect  this  invoice  carefully  ;  our  company  will  not  be  responsible  for  any  errors  after  2  business  days.",norm_fontEng);
				PdfPCell CellInfoRemark = new PdfPCell();
				CellInfoRemark.setBorder(0);
				CellInfoRemark.setPaddingTop(1f);
				CellInfoRemark.setBorderWidthTop(1f);
				CellInfoRemark.addElement(LogoSpace);
				CellInfoRemark.setHorizontalAlignment(Element.ALIGN_LEFT);
				tableInfoRemark.addCell(CellInfoRemark);
				
				document.add(tableInfoRemark);
				
				PdfPTable tablelogo = new PdfPTable(3); //表格两列
				float[] wid1 ={0.2f,0.25f,0.55f};
				tablelogo.setWidths(wid1);
				tablelogo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tablelogo.setWidthPercentage(100);//表格的宽度为100%
//				tablelogo.getDefaultCell().setBorderWidth(0); //不显示边框
				tablelogo.getDefaultCell().setBorderColor(Color.GRAY);
				
				

				
				
				PdfPCell Cell_logo2 = new PdfPCell(new Paragraph("")); //
				Cell_logo2.setBorder(0);
				Cell_logo2.setBorderColor(Color.GRAY);
				tablelogo.addCell(Cell_logo2);
				
				
				PdfPCell Cell_logo3 = new PdfPCell(new Paragraph("")); //
				Cell_logo3.setBorder(0);
				Cell_logo3.setBorderColor(Color.GRAY);
				tablelogo.addCell(Cell_logo3);
				
				
				PdfPTable tablelogo1 = new PdfPTable(2);
				float[] wid ={0.8f,0.2f};
				tablelogo1.setWidths(wid);
				tablelogo1.getDefaultCell().setBorderWidth(0);
				PdfPCell Cell_logo = new PdfPCell(tablelogo1);
				Cell_logo.setBorder(0);
				tablelogo.addCell(Cell_logo);
				
				PdfPCell Cell_logo1 = new PdfPCell(new Paragraph(" Thank you for choosing   ",norm_fontEng));
				Cell_logo1.setBorder(0);
				Cell_logo1.setVerticalAlignment(Element.ALIGN_MIDDLE);
				Cell_logo1.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tablelogo1.addCell(Cell_logo1);
				
				
				PdfPCell logoCell=new PdfPCell();
				logoCell.addElement(jpeg);
				logoCell.setBorder(0);
				logoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
				tablelogo1.addCell(logoCell);
				
				document.add(tablelogo);

					
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
	
	
	//子单invoice
	@Override
	public String createInvoicePdfForChild(String orderId) {
		Order order = orderMapper.findById(orderId);
		String orderNumber = order.getOrderNo();
		//获取该子订单对应的总订单
		OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
		
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orderId);
		GroupLine groupLine = groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
		//String brand = groupLine.getBrand();
	
		//获取该总订单下的所有子订单
		//List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
		
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
		    	if(agen.getEmail().equals("")){
		    		mailForDept = deptForAgent.getEmail();
		    	}else{
		    		mailForDept = agen.getEmail();
		    	}
		    	
		    	String companyId = ordersTotal.getCompanyId();
		    	Vender vender = venderMapper.findById(companyId);
		Setting setting = SettingUtils.get();
		String uploadPath = setting.getTempPDFPath();
		String destPath = null;
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			String path = FreemarkerUtils.process(uploadPath, model);
			destPath = path + "invoice-"+orderNumber+".pdf";
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			
			// 创建一个Document对象
			Document document = new Document(PageSize.A4, 36, 36, 24, 36);
			try {
				// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
				
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
				String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
				BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
				BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
						Color.BLACK);
				
				Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
						Color.BLACK);
				
				//中文斜体(大号)
				Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
				//中文斜体(小号)
				Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
				
				document.open();
				// 添加抬头图片
				PdfPTable table1 = new PdfPTable(3); //表格两列
				table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table1.setWidthPercentage(100);//表格的宽度为100%
				 //两列宽度的比例并设置logo
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
				
				if(logo.equals(Constant.LOGO_PATH[3])){
					float[] wid1 ={0.45f,0.25f,0.30f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					float[] wid1 ={0.2f,0.40f,0.30f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[0])){
					float[] wid1 ={0.25f,0.45f,0.30f};
					table1.setWidths(wid1);
				}else if(logo.equals(Constant.LOGO_PATH[2])){
					float[] wid1 ={0.45f,0.25f,0.30f};
					table1.setWidths(wid1);
				}
				 
				table1.getDefaultCell().setBorderWidth(0); //不显示边框
				PdfPTable table11 = new PdfPTable(1);
				table11.getDefaultCell().setBorder(0);
				Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
				jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
				jpeg.setAlignment(Image.ALIGN_TOP);
				jpeg.setBorder(0);
				table11.addCell(jpeg);
				table11.getDefaultCell().setBorderWidth(0);
				PdfPCell cell0 = new PdfPCell(table11);
				cell0.setBorder(0);
				table11.setWidthPercentage(60);
				table1.addCell(cell0);
				cell0.setBorder(0);
				PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
				cell1.setBorder(Rectangle.NO_BORDER);
				table1.addCell(cell1);
				
				PdfPTable table13 = new PdfPTable(1);
				table13.getDefaultCell().setBorderWidth(0);
				PdfPCell cell2 = new PdfPCell(table13);
				cell2.setBorder(0);
				table1.addCell(cell2);
				
				PdfPCell cell21 = new PdfPCell(new Paragraph(addressForDept,littleChineseFont));
				cell21.setBorder(0);
				cell21.setMinimumHeight(10f);
				table13.addCell(cell21);
				
				PdfPCell cell24 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell24.setBorder(0);
				cell24.setMinimumHeight(10f);
				table13.addCell(cell24);
				
				/*PdfPCell cell25 = new PdfPCell(new Paragraph("Tel:"+telForDept,littleChineseFont));
				cell25.setBorder(0);
				cell25.setMinimumHeight(10f);
				table13.addCell(cell25);*/
				
				PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailForDept,littleChineseFont));
				cell26.setBorder(0);
				cell26.setMinimumHeight(10f);
				table13.addCell(cell26);
				
				table1.addCell(cell1);
				document.add(table1);
				
				PdfContentByte cb=writer.getDirectContent();
				cb.setLineWidth(0.3f);
				
				//显示order基础信息
				PdfPTable table3 = new PdfPTable(4); //表格两列
				table3.setSpacingBefore(10f);
				table3.setSpacingAfter(5f);
				table3.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table3.setWidthPercentage(100);//表格的宽度为100%
				float[] wid2 ={0.15f,0.35f,0.15f,0.35f}; //两列宽度的比例
				table3.setWidths(wid2); 
				table3.getDefaultCell().setBorderWidth(0); //不显示边框
				
				PdfPCell cell011 = new PdfPCell(new Paragraph("Invoice No:      ",littleChineseFont));
				cell011.setMinimumHeight(10f);
				cell011.setBorder(0);
				cell011.setBorderWidthTop(0.3f);
				cell011.setBorderColor(Color.GRAY);
				table3.addCell(cell011);
				
				PdfPCell cell012 = new PdfPCell(new Paragraph(order.getOrderNo(),littleChineseFont));
				cell012.setMinimumHeight(10f);
				cell012.setBorder(0);
				cell012.setBorderWidthTop(0.3f);
				cell012.setBorderColor(Color.GRAY);
				table3.addCell(cell012);
				
				PdfPCell cell013 = new PdfPCell(new Paragraph("Agent:              ",littleChineseFont));
				cell013.setBorder(0);
				cell013.setMinimumHeight(10f);
				cell013.setBorderColor(Color.GRAY);
				cell013.setBorderWidthTop(0.3f);
				table3.addCell(cell013);
				//如果为同行则显示同行联系人
				PdfPCell cell014 = null;
				if(ordersTotal.getWr().equals("wholeSale")){
					if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
						cell014 = new PdfPCell(new Paragraph(ordersTotal.getContactName(),littleChineseFont));
					}else{
						cell014 = new PdfPCell(new Paragraph("",littleChineseFont));
					}
				}else{
					cell014 = new PdfPCell(new Paragraph(ordersTotal.getAgent(),littleChineseFont));
				}
				cell014.setBorder(0);
				cell014.setMinimumHeight(10f);
				cell014.setBorderColor(Color.GRAY);
				cell014.setBorderWidthTop(0.3f);
				table3.addCell(cell014);
				
				PdfPCell cell021 = new PdfPCell(new Paragraph("Tour Code:       ",littleChineseFont));
				cell021.setBorder(0);
				cell021.setMinimumHeight(10f);
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
					if(tourInfoForOrder!=null&&tourInfoForOrder.getDepartureDate()!=null){
						departureDate = df.format(tourInfoForOrder.getDepartureDate());
					}
				}
				PdfPCell cell022 = new PdfPCell(new Paragraph(tourCode,littleChineseFont));
				cell022.setBorder(0);
				cell022.setMinimumHeight(10f);
				table3.addCell(cell022);
				
				PdfPCell cell023 = new PdfPCell(new Paragraph("Tour Name:     ",littleChineseFont));
				cell023.setBorder(0);
				cell023.setMinimumHeight(10f);
				table3.addCell(cell023);
				
				PdfPCell cell024 = new PdfPCell(new Paragraph(tourName,littleChineseFont));
				cell024.setBorder(0);
				cell024.setMinimumHeight(10f);
				table3.addCell(cell024);
				
				PdfPCell cell031 = new PdfPCell(new Paragraph("Bill To:                 ",littleChineseFont));
				cell031.setBorder(0);
				cell031.setMinimumHeight(10f);
				table3.addCell(cell031);
				//如果为同行，则显示同行公司名称
				PdfPCell cell032 = null;
				if(ordersTotal.getWr().equals("wholeSale")){
					if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
						cell032 = new PdfPCell(new Paragraph(vender.getName(),littleChineseFont)); 
					}else{
						cell032 = new PdfPCell(new Paragraph("",littleChineseFont));
					}
				}else{
					cell032 = new PdfPCell(new Paragraph(ordersTotal.getContactName(),littleChineseFont));
				}
				cell032.setBorder(0);
				cell032.setMinimumHeight(10f);
				table3.addCell(cell032);
				
				PdfPCell cell034 = null;
				PdfPCell cell042 = null;
				PdfPCell cell044 = null;
					PdfPCell cell033 = new PdfPCell(new Paragraph("Address:              ",littleChineseFont));
					cell033.setBorder(0);
					cell033.setMinimumHeight(10f);
					table3.addCell(cell033);
					
					cell034 = new PdfPCell(new Paragraph(ordersTotal.getAddress(),littleChineseFont));
					cell034.setBorder(0);
					cell034.setMinimumHeight(10f);
					table3.addCell(cell034);
					
					PdfPCell cell041 = new PdfPCell(new Paragraph("Tel:                     ",littleChineseFont));
					cell041.setBorder(0);
					cell041.setMinimumHeight(10f);
					table3.addCell(cell041);
					
					cell042 = new PdfPCell(new Paragraph(ordersTotal.getTel(),littleChineseFont));
					cell042.setBorder(0);
					cell042.setMinimumHeight(10f);
					table3.addCell(cell042);
					
					PdfPCell cell043 = new PdfPCell(new Paragraph("Email:               ",littleChineseFont));
					cell043.setBorder(0);
					cell043.setMinimumHeight(10f);
					table3.addCell(cell043);
					
					cell044 = new PdfPCell(new Paragraph(ordersTotal.getEmail(),littleChineseFont));
					cell044.setBorder(0);
					cell044.setMinimumHeight(10f);
					table3.addCell(cell044);
				PdfPCell cell051 = new PdfPCell(new Paragraph("Person(s):         ",littleChineseFont));
				cell051.setBorder(0);
				cell051.setMinimumHeight(10f);
				table3.addCell(cell051);
				
				PdfPCell cell052 = new PdfPCell(new Paragraph(order.getTotalPeople().toString(),littleChineseFont));
				cell052.setBorder(0);
				cell052.setMinimumHeight(10f);
				table3.addCell(cell052);
				
				PdfPCell cell053 = new PdfPCell(new Paragraph("Departure Date:       ",littleChineseFont));
				cell053.setBorder(0);
				cell053.setMinimumHeight(10f);
				table3.addCell(cell053);
				
				PdfPCell cell054 = new PdfPCell(new Paragraph(departureDate,littleChineseFont));
				cell054.setBorder(0);
				cell054.setMinimumHeight(10f);
				table3.addCell(cell054);
				document.add(table3);
				
				List<PayCostRecords> pRecords = new ArrayList<PayCostRecords>(); //存放所有的
				List<PayCostRecords> pay = payCostRecordsMapper.findByOrderId(order.getId());
				List<PayCostRecords> removePay = new ArrayList<PayCostRecords>();
				for(PayCostRecords payCostRecord:pay){
					if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
						removePay.add(payCostRecord);
					}
				}
				pay.removeAll(removePay);
				pRecords.addAll(pay);
			
				BigDecimal totalFee = new BigDecimal(0);
				if(pRecords!=null||pRecords.size()!=0){
					for(int i=0;i<pRecords.size();i++){
							totalFee = totalFee.add(pRecords.get(i).getSum());
						}
				}
				
				//添加invoiceItems
				Paragraph invoiceItems = new Paragraph("INVOICE ITEMS",bold_fontEng);
				invoiceItems.setAlignment(Paragraph.ALIGN_CENTER);
				invoiceItems.setSpacingAfter(10f);
				invoiceItems.setSpacingBefore(10f);
				document.add(invoiceItems);
				
				PdfPTable itemsData = new PdfPTable(6);
				float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
				itemsData.setWidths(wid4);
				itemsData.setWidthPercentage(100);
				itemsData.getDefaultCell().setBorderWidthBottom(0);
				
				PdfPCell tableHeaderForItem = new PdfPCell();
				tableHeaderForItem.setBorder(0);
				tableHeaderForItem.setBorderColorBottom(Color.GRAY);
				tableHeaderForItem.setBorderWidthBottom(0.3f);
				tableHeaderForItem.setBorderWidthTop(1.5f);
				tableHeaderForItem.setMinimumHeight(30f);
				tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeaderForItem.setMinimumHeight(20f);
				tableHeaderForItem.setBorderWidth(0.5f);
				tableHeaderForItem.setPhrase(new Phrase("#",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Service",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Price",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
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
 								PdfPCell orderReceiveItemNo = new PdfPCell();
 								orderReceiveItemNo.setBorder(0);
 								orderReceiveItemNo.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
 								orderReceiveItemNo.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
 								orderReceiveItemNo.setMinimumHeight(20f);
 								orderReceiveItemNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
 								orderReceiveItemNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
 								itemsData.addCell(orderReceiveItemNo);
								
								PdfPCell serviceCell = new PdfPCell();
								serviceCell.setBorder(0);
								serviceCell.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								serviceCell.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								serviceCell.setMinimumHeight(20f);
								serviceCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								serviceCell.addElement(new Phrase(service,chineseFont));
								itemsData.addCell(serviceCell);
								
								PdfPCell description = new PdfPCell();
								description.setBorder(0);
								description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								description.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								description.setMinimumHeight(20f);
								description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								description.addElement(new Phrase(orderReceiveItems.get(i).getRemark(),chineseFont));
								itemsData.addCell(description);
								
								PdfPCell price = new PdfPCell();
								price.setBorder(0);
								price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								price.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								price.setMinimumHeight(20f);
								price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								BigDecimal pri = orderReceiveItems.get(i).getItemFee();
								if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
									pri = new BigDecimal(0).subtract(pri);
								}
								price.addElement(new Phrase(pri.toString(),chineseFont));
								itemsData.addCell(price);
								
								PdfPCell num = new PdfPCell();
								num.setBorder(0);
								num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								num.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								num.setMinimumHeight(20f);
								num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString(),chineseFont));
								itemsData.addCell(num);
								
								PdfPCell totalFe = new PdfPCell();
								totalFe.setBorder(0);
								totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								
								if(i==orderReceiveItems.size()-1){
									totalFe.setBorderColor(Color.BLACK);
									totalFe.setBorderWidthBottom(1.5f);
								}else{
									totalFe.setBorderColor(Color.GRAY);
									totalFe.setBorderWidthBottom(0.3f);
								}
								totalFe.setMinimumHeight(20f);
								totalFe.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
								if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
									itemFee = new BigDecimal(0).subtract(itemFee);
								}
								Integer mount = orderReceiveItems.get(i).getItemFeeNum();
								BigDecimal toMount = new BigDecimal(mount);
								totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString(),chineseFont));
								itemsData.addCell(totalFe);
								totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
									}
								
								}
					
				document.add(itemsData);
				PdfPTable subTotalData = new PdfPTable(3);
				float[] wid6 ={0.72f,0.18f,0.1f};
				subTotalData.setWidths(wid6);
				subTotalData.setWidthPercentage(100);
				//subTotalData.getDefaultCell().setBorderWidthBottom(0);
				subTotalData.getDefaultCell().setMinimumHeight(20f);
				
				PdfPCell sub1 = new PdfPCell();
				sub1.setBorder(0);
				sub1.addElement(new Phrase("",norm_fontEng));
				subTotalData.addCell(sub1);
				
				PdfPCell sub2 = new PdfPCell();
				sub2.setBorder(0);
				sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				sub2.addElement(new Phrase("SubTotal:",bold_fontEngForTableHead));
				subTotalData.addCell(sub2);
				
				PdfPCell sub3 = new PdfPCell();
				sub3.setBorder(0);
				sub3.addElement(new Phrase(totalCostFee.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(sub3);
				
				if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0){
					BigDecimal peerUserFee = new BigDecimal(0.00);
					if(order.getPeerUserFee()!=null){
						peerUserFee = order.getPeerUserFee();
					}
					PdfPCell userFee1 = new PdfPCell();
					userFee1.setBorder(0);
					userFee1.addElement(new Phrase("",norm_fontEng));
					subTotalData.addCell(userFee1);
					
					PdfPCell userFee2 = new PdfPCell();
					userFee2.setBorder(0);
					userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					userFee2.addElement(new Phrase(" Commission:",bold_fontEngForTableHead));
					subTotalData.addCell(userFee2);
					
					PdfPCell userFee3 = new PdfPCell();
					userFee3.setBorder(0);
					userFee3.addElement(new Phrase(peerUserFee.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(userFee3);
				}
				
				PdfPCell paid1 = new PdfPCell();
				paid1.setBorder(0);
				paid1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(paid1);
				
				PdfPCell paid2 = new PdfPCell();
				paid2.setBorder(0);
				paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				paid2.addElement(new Phrase("         Paid:",bold_fontEngForTableHead));
				subTotalData.addCell(paid2);
				
				
				PdfPCell paid3 = new PdfPCell();
				paid3.setBorder(0);
				paid3.addElement(new Phrase(totalFee.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(paid3);
				
				PdfPCell balance1 = new PdfPCell();
				balance1.setBorder(0);
				balance1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(balance1);
				
				PdfPCell balance2 = new PdfPCell();
				balance2.setBorder(0);
				balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				balance2.addElement(new Phrase("   Balance:",bold_fontEngForTableHead));
				subTotalData.addCell(balance2);
				
				PdfPCell balance3 = new PdfPCell();
				balance3.setBorder(0);
				BigDecimal bal = totalCostFee.subtract(totalFee);
				if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0&&order.getPeerUserFee()!=null){
					bal = bal.subtract(order.getPeerUserFee());
				}
				balance3.addElement(new Phrase(bal.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(balance3);
				
				/*BigDecimal rate = new BigDecimal(1.00);
					rate = order.getRate();
				
				
				PdfPCell tax1 = new PdfPCell();
				tax1.setBorder(0);
				tax1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(tax1);
				
				PdfPCell tax2 = new PdfPCell();
				tax2.setBorder(0);
				tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tax2.addElement(new Phrase("Exchange Rate:",bold_fontEngForTableHead));
				subTotalData.addCell(tax2);
				
				PdfPCell tax3 = new PdfPCell();
				tax3.setBorder(0);
				tax3.addElement(new Phrase(rate.toString(),bold_fontEngForTableHead));
				subTotalData.addCell(tax3);
				
				PdfPCell toatl1 = new PdfPCell();
				toatl1.setBorder(0);
				toatl1.addElement(new Phrase("",bold_fontEngForTableHead));
				subTotalData.addCell(toatl1);
				
				PdfPCell toatl2 = new PdfPCell();
				toatl2.setBorder(0);
				toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				toatl2.addElement(new Phrase("Total Blance:",bold_fontEngForTableHead));
				subTotalData.addCell(toatl2);
				
				PdfPCell toatl3 = new PdfPCell();
				toatl3.setBorder(0);
				toatl3.addElement(new Phrase(bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),bold_fontEngForTableHead));
				subTotalData.addCell(toatl3);*/
				document.add(subTotalData);
				//客人信息
						List<Customer> customersForToatl = new ArrayList<Customer>();
						List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerByOrderId(orderId);
						for(CustomerOrderRel customerOrderRel:customerOrderRelList){
							if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
								Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
								customersForToatl.add(customer);
							}
						}
					
					
					Paragraph cus = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					cus.setAlignment(Paragraph.ALIGN_CENTER);
					cus.setSpacingAfter(10f);
					cus.setSpacingBefore(10f);
					document.add(cus);
					
					PdfPTable cusData = new PdfPTable(4);
					float[] wid5 ={0.1f,0.4f,0.3f,0.20f};
					cusData.setWidths(wid5);
					cusData.setWidthPercentage(100);
					cusData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeaderForCus = new PdfPCell();
					tableHeaderForCus.setBorder(0);
					tableHeaderForCus.setBorderColorBottom(Color.GRAY);
					tableHeaderForCus.setBorderWidthBottom(0.3f);
					tableHeaderForCus.setBorderWidthTop(1.5f);
					tableHeaderForCus.setMinimumHeight(30f);
					tableHeaderForCus.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeaderForCus.setMinimumHeight(20f);
					tableHeaderForCus.setBorderWidth(0.5f);
					tableHeaderForCus.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					if(customersForToatl!=null){
					for(int i=0;i<customersForToatl.size();i++){
						PdfPCell cusNo = new PdfPCell();
						cusNo.setBorder(0);
						cusNo.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusNo.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusNo.setMinimumHeight(20f);
						cusNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						cusNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
						cusData.addCell(cusNo);
						
						PdfPCell cusName = new PdfPCell();
						cusName.setBorder(0);
						cusName.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusName.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusName.setMinimumHeight(20f);
						cusName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName(),chineseFont));
						cusData.addCell(cusName);
						
						PdfPCell cusGender = new PdfPCell();
						cusGender.setBorder(0);
						cusGender.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusGender.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusGender.setMinimumHeight(20f);
						cusGender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String sexForString = "";
						if(customersForToatl.get(i).getSex()==1){
							sexForString = "FEMALE";
						}else if(customersForToatl.get(i).getSex()==2){
							sexForString = "MALE";
						}
						cusGender.addElement(new Phrase(sexForString,chineseFont));
						cusData.addCell(cusGender);
						
						PdfPCell cusNationality = new PdfPCell();
						cusNationality.setBorder(0);
						cusNationality.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusNationality.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusNationality.setMinimumHeight(20f);
						cusNationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String countryName = "";
						if(customersForToatl.get(i)!=null){
								countryName = customersForToatl.get(i).getNationalityOfPassport();
						}
						cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName,chineseFont));
						cusData.addCell(cusNationality);
						
					}
					}
					document.add(cusData);
					//添加payment
					Paragraph payment = new Paragraph("PAYMENT HISTORY",bold_fontEng);
					payment.setAlignment(Paragraph.ALIGN_CENTER);
					payment.setSpacingAfter(10f);
					payment.setSpacingBefore(10f);
					document.add(payment);
					
					PdfPTable paymentData = new PdfPTable(5);
					float[] wid3 ={0.1f,0.2f,0.3f,0.3f,0.10f};
					paymentData.setWidths(wid3);
					paymentData.setWidthPercentage(100);
					paymentData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeader = new PdfPCell();
					tableHeader.setBorder(0);
					tableHeader.setBorderColorBottom(Color.GRAY);
					tableHeader.setBorderWidthBottom(0.3f);
					tableHeader.setBorderWidthTop(1.5f);
					tableHeader.setMinimumHeight(30f);
					tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeader.setMinimumHeight(20f);
					tableHeader.setBorderWidth(0.5f);
					tableHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Amount",bold_fontEngForTableHead));
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
					
					
					
						if(payCostRecords!=null||payCostRecords.size()!=0){
							for(int i=0;i<payCostRecords.size();i++){
	 								PdfPCell payNo = new PdfPCell();
									payNo.setBorder(0);
									payNo.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									payNo.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									payNo.setMinimumHeight(20f);
									payNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									payNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
									paymentData.addCell(payNo);
									
									PdfPCell date = new PdfPCell();
									date.setBorder(0);
									date.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									date.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									date.setMinimumHeight(20f);
									date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
									date.addElement(new Phrase(payCostRecords.get(i).getTime()==null?"":simpleDateFormat.format(payCostRecords.get(i).getTime()),chineseFont));
									paymentData.addCell(date);
									
									PdfPCell description = new PdfPCell();
									description.setBorder(0);
									description.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									description.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									description.setMinimumHeight(20f);
									description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									description.addElement(new Phrase(payCostRecords.get(i).getItem(),chineseFont));
									paymentData.addCell(description);
									
									PdfPCell remark = new PdfPCell();
									remark.setBorder(0);
									remark.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									remark.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									remark.setMinimumHeight(20f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									remark.addElement(new Phrase(payCostRecords.get(i).getRemark(),chineseFont));
									paymentData.addCell(remark);
									
									PdfPCell amount = new PdfPCell();
									amount.setBorder(0);
									amount.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									amount.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									amount.setMinimumHeight(20f);
									amount.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									amount.addElement(new Phrase(payCostRecords.get(i).getSum().toString(),chineseFont));
									paymentData.addCell(amount);
								}
						}
					document.add(paymentData);
					Paragraph total = new Paragraph("Total: "+totalFee,bold_fontEngForTableHead);
					total.setAlignment(2);
					document.add(total);
					//添加账户信息
					Admin agent = adminService.findById(ordersTotal.getUserId());
			    	Dept dept = deptMapper.findById(agent.getDeptId());
					if(dept.getAccount()!=null){
						Paragraph account = new Paragraph("ACCOUNT",bold_fontEngForTableHead);
						account.setSpacingBefore(15f);
						document.add(account);
						Paragraph accountContent = new Paragraph(dept.getAccount(),littleChineseFont);
						document.add(accountContent);
					}
					
					//添加notice信息
					if(order.getOrderType()==5&&tourInfoForOrder.getSpecialRequirements()!=null){
						Paragraph account = new Paragraph("NOTICE INFORMATION",bold_fontEngForTableHead);
						account.setSpacingBefore(15f);
						document.add(account);
						Paragraph accountContent = new Paragraph(tourInfoForOrder.getSpecialRequirements(),littleChineseFont);
						document.add(accountContent);
					}
					
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
	
	
	@Override
	public String createInvoiceForSelf(String ordersTotalId,String logo) {
		//获取该id对应的订单
		OrdersTotal ordersTotal = ordersTotalMapper.findById(ordersTotalId);
		String orderNumber = ordersTotal.getOrderNumber();
		//获取该总订单下的所有子订单
		List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
		//判断订单是否为自组（给Cynthia Su特定）
		//标头显示的信息
	    String agentString = "";
	    String mailForDept = "";
	    String addressForDept = "";
	    String Company="";
	    String cityAndState="";
	      String venderId = ordersTotal.getCompanyId();
	      Vender vender = null;
	      if(venderId!=null&&venderId.length()!=0){
	        vender = venderMapper.findById(venderId);
	      }
        if(ordersTotal.getWr().equals("wholeSale")){
            if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
          	  cityAndState=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
              Company=vender.getName();
            }else{
          	  Company="";
            }
          }
    	agentString = adminService.findById(ordersTotal.getUserId()).getUsername();
    	Admin agen = adminService.findById(ordersTotal.getUserId());
    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
    	addressForDept = deptForAgent.getAddress();
    	if(agen.getEmail().equals("")){
    		mailForDept = deptForAgent.getEmail();
    	}else{
    		mailForDept = agen.getEmail();
    	}
    	if(venderId!=null&&venderId.length()!=0){
    		vender = venderMapper.findById(venderId);
    	}
	    
		Setting setting = SettingUtils.get();
		String uploadPath = setting.getTempPDFPath();
		String destPath = null;
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			String path = FreemarkerUtils.process(uploadPath, model);
			destPath = path + "invoice-"+orderNumber+".pdf";
			File destFile = new File(servletContext.getRealPath(destPath));
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			
			// 创建一个Document对象
			Document document = new Document(PageSize.A4, 36, 36, 24, 36);
			try {
				// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
				
				PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
				String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
				BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
				BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				//中文斜体(大号)
				Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
				Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
				//中文超大号
				Font  chineseFontBig = new Font(bfChinese, 12,  Font.BOLD,Color.BLACK);
				//中文斜体(小号)
				Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
						Color.BLACK);
				
				Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
						Color.BLACK);
				
				document.open();
				
				PdfPTable tableTitleSpace = new PdfPTable(3); //表格两列
				tableTitleSpace.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				tableTitleSpace.setWidthPercentage(100);//表格的宽度为100%
				float[] wid11 ={0.45f,0.25f,0.30f};
				tableTitleSpace.setWidths(wid11);
				
				PdfPCell cell21_11 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell21_11.setBorder(0);
				cell21_11.setPaddingBottom(10f);
				cell21_11.setMinimumHeight(10f);
				tableTitleSpace.addCell(cell21_11);
				
				PdfPCell cell21_21 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell21_21.setBorder(0);
				cell21_21.setPaddingBottom(10f);
				cell21_21.setMinimumHeight(10f);
				tableTitleSpace.addCell(cell21_21);
				
				PdfPCell cell261 = new PdfPCell(new Paragraph("",littleChineseFont));
				cell261.setBorder(0);
				cell261.setMinimumHeight(10f);
				cell261.setPaddingBottom(10f);
				tableTitleSpace.addCell(cell261);
				
				document.add(tableTitleSpace);
				
				// 添加抬头图片
				PdfPTable table1 = new PdfPTable(3); //表格两列
				table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
				table1.setWidthPercentage(100);//表格的宽度为100%
				int l = 0;
				 //两列宽度的比例
				
				PdfPTable table13 = new PdfPTable(1);
				table13.getDefaultCell().setBorderWidth(0);
				PdfPCell cell2 = new PdfPCell(table13);
				cell2.setBorder(0);
				cell2.setPaddingBottom(5f);
				table1.addCell(cell2);
				
				//Logo文字标识
				String logoInDentifying="";
				if(logo.equals(Constant.LOGO_PATH[0])){
					logoInDentifying="中国美";
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					logoInDentifying="Chinatour.com";
				}else if(logo.equals(Constant.LOGO_PATH[2]) || logo.equals(Constant.LOGO_PATH[4])){
					logoInDentifying="Intertrips";
				}else{
					logoInDentifying="文景假期";
				}
				PdfPCell cellHead = new PdfPCell(new Paragraph(logoInDentifying,chineseFontBig));
				cellHead.setBorder(0);
				cellHead.setMinimumHeight(10f);
				table13.addCell(cellHead);
				
				PdfPCell cell20 = new PdfPCell(new Paragraph("Agent Name:"+agen.getName(),littleChineseFont));
				cell20.setBorder(0);
				cell20.setMinimumHeight(10f);
				table13.addCell(cell20);
				
				PdfPCell cell21 = new PdfPCell(new Paragraph("Address:"+agen.getAddress(),littleChineseFont));
				cell21.setBorder(0);
				cell21.setMinimumHeight(10f);
				table13.addCell(cell21);
				
				PdfPCell cell21_1 = new PdfPCell(new Paragraph("Tel:"+agen.getTel(),littleChineseFont));
				cell21_1.setBorder(0);
				cell21_1.setMinimumHeight(10f);
				table13.addCell(cell21_1);
				
				PdfPCell cell21_2 = new PdfPCell(new Paragraph("Fax:"+agen.getFax(),littleChineseFont));
				cell21_2.setBorder(0);
				cell21_2.setMinimumHeight(10f);
				table13.addCell(cell21_2);
				
				PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailForDept,littleChineseFont));
				cell26.setBorder(0);
				cell26.setMinimumHeight(10f);
				table13.addCell(cell26);
				
				PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
				cell1.setBorder(Rectangle.NO_BORDER);
				table1.addCell(cell1);
				
				if(logo.equals(Constant.LOGO_PATH[3])){
					float[] wid1 ={0.30f,0.30f,0.40f};
					table1.setWidths(wid1);
					l=4;
				}else if(logo.equals(Constant.LOGO_PATH[1])){
					float[] wid1 ={0.30f,0.45f,0.25f};
					table1.setWidths(wid1);
					l=2;
				}else if(logo.equals(Constant.LOGO_PATH[0])){
					float[] wid1 ={0.30f,0.35f,0.35f};
					table1.setWidths(wid1);
					l=1;
				}else if(logo.equals(Constant.LOGO_PATH[2]) || logo.equals(Constant.LOGO_PATH[4])){
					float[] wid1 ={0.30f,0.25f,0.45f};
					table1.setWidths(wid1);
					l=3;
				}
				 
				table1.getDefaultCell().setBorderWidth(0); //不显示边框
				PdfPTable table11 = new PdfPTable(1);
				table11.getDefaultCell().setBorder(0);
				Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
				jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
				jpeg.setAlignment(Image.ALIGN_TOP);
				jpeg.setBorder(0);
				table11.addCell(jpeg);
				table11.getDefaultCell().setBorderWidth(0);
				PdfPCell cell0 = new PdfPCell(table11);
				cell0.setBorder(0);
				table11.setWidthPercentage(60);
				table1.addCell(cell0);
				cell0.setBorder(0);

				
				document.add(table1);
				
				PdfContentByte cb=writer.getDirectContent();
				cb.setLineWidth(0.3f);
				/*cb.moveTo(38f, 700f);
				cb.lineTo(562f, 700f);
				cb.setColorStroke(Color.GRAY);
				cb.stroke();*/
				
				/*BILL TO信息添加*/
				PdfPTable tabalOrder_2 = new PdfPTable(2);
				float[] widOrder4 ={0.52f,0.48f};
				tabalOrder_2.setWidths(widOrder4);
				tabalOrder_2.setWidthPercentage(100);
				tabalOrder_2.getDefaultCell().setBorderWidthTop(0);
				tabalOrder_2.setSpacingBefore(10f);
				
				PdfPCell tableOrderCell = new PdfPCell();
				tableOrderCell.setBorder(0);
				tableOrderCell.setBorderWidthTop(0.3f);
				tableOrderCell.setPaddingTop(10f);
				tableOrderCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableOrderCell.setPhrase(new Phrase("BILL TO",bold_fontEng));
				tabalOrder_2.addCell(tableOrderCell);
				tableOrderCell.setPhrase(new Phrase("Invoice No:"+ordersTotal.getOrderNumber(),norm_fontEng));
				tabalOrder_2.addCell(tableOrderCell);
				
				PdfPCell orderItems_2 = new PdfPCell(new Paragraph("Company:"+Company,norm_fontEng));
				orderItems_2.setBorder(0);
				orderItems_2.setMinimumHeight(10f);
				tabalOrder_2.addCell(orderItems_2);
				
				String tourCode = "";
				String tourName = "";
				String departureDate = "";
				String dueDate="";
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				if(orders!=null&&orders.size()!=0){
					for(int i=0;i<orders.size();i++){
						if(i<orders.size()-1){
							if(orders.get(i).getTourCode().length()!=0&&orders.get(i).getTourCode()!=null){
								tourCode+=orders.get(i).getTourCode()+"/";
							}
							if(orders.get(i).getTourId()!=null&&orders.get(i).getTourId().length()!=0){
								tourName+=tourMapper.findById(orders.get(i).getTourId()).getLineName()+"/";
							}
							TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orders.get(i).getId());
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDepartureDate()!=null){
								departureDate+= df.format(tourInfoForOrder.getDepartureDate())+",";
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDueDate()!=null){
								dueDate+= df.format(tourInfoForOrder.getDueDate())+",";
							}
						}else{
							tourCode+=orders.get(i).getTourCode();
							TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orders.get(i).getId());
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDepartureDate()!=null){
								departureDate+= df.format(tourInfoForOrder.getDepartureDate());
							}
							if(tourInfoForOrder!=null&&tourInfoForOrder.getDueDate()!=null){
								dueDate+= df.format(tourInfoForOrder.getDueDate())+",";
							}
							String tourId = orders.get(i).getTourId();
							if(tourId!=null){
								Tour tour = tourMapper.findById(tourId);
								if(tour!=null){
									tourName+= tour.getLineName();
								}
							}
						}
					}
				}
				
				
				PdfPCell orderItems_1 = new PdfPCell(new Paragraph("Tour Code:"+tourCode,norm_fontEng));
				orderItems_1.setBorder(0);
				orderItems_1.setMinimumHeight(10f);
				tabalOrder_2.addCell(orderItems_1);
				
				PdfPCell cell014 = null;
				if(ordersTotal.getWr().equals("wholeSale")){
					if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
						cell014 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
					}else{
						cell014 = new PdfPCell(new Paragraph("Name:"+"",norm_fontEng));
					}
				}else{
					cell014 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
				}
				
				cell014.setBorder(0);
				cell014.setMinimumHeight(10f);
				tabalOrder_2.addCell(cell014);
				
				PdfPCell orderItems_3 = new PdfPCell(new Paragraph("Booking Date:"+df.format(ordersTotal.getBookingDate()),norm_fontEng));
				orderItems_3.setBorder(0);
				orderItems_3.setMinimumHeight(10f);
				tabalOrder_2.addCell(orderItems_3);
				
				PdfPCell tabalCell_2_2 = new PdfPCell(new Paragraph("Address:"+ordersTotal.getAddress()+" "+cityAndState,norm_fontEng));
				tabalCell_2_2.setBorder(0);
				tabalCell_2_2.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_2_2);
				
				PdfPCell tabalCell_space = new PdfPCell(new Paragraph("Departure Date:"+departureDate,norm_fontEng));
				tabalCell_space.setBorder(0);
				tabalCell_space.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_space);
				
				PdfPCell tabalCell_2_3 = new PdfPCell(new Paragraph("Phone:"+ordersTotal.getTel(),norm_fontEng));
				tabalCell_2_3.setBorder(0);
				tabalCell_2_3.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_2_3);
				
				PdfPCell tabalCell_space2 = new PdfPCell(new Paragraph("",norm_fontEng));
				tabalCell_space2.setBorder(0);
				tabalCell_space2.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_space2);
				
				
				PdfPCell tabalCellEamil = new PdfPCell(new Paragraph("Email:"+ordersTotal.getEmail(),norm_fontEng));
				tabalCellEamil.setBorder(0);
				tabalCellEamil.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCellEamil);
				
				PdfPCell tabalCell_space3 = new PdfPCell(new Paragraph("Due Date:"+dueDate,norm_fontEng));
				tabalCell_space3.setBorder(0);
				tabalCell_space3.setMinimumHeight(10f);
				tabalOrder_2.addCell(tabalCell_space3);
				

				document.add(tabalOrder_2);
				//}
				/*cb.setLineWidth(0.3f);
				cb.moveTo(38f, 590f);
				cb.lineTo(562f, 590f);
				cb.setColorStroke(Color.GRAY);
				cb.stroke();*/
				BigDecimal totalFee = new BigDecimal(0);
				List<PayCostRecords> pCRecords = new ArrayList<PayCostRecords>(); //存放所有的
				for(Order order:orders){
					List<PayCostRecords> pays = payCostRecordsMapper.findByOrderId(order.getId());
					List<PayCostRecords> removePays = new ArrayList<PayCostRecords>();
					for(PayCostRecords payCostRecord:pays){
						if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
							removePays.add(payCostRecord);
						}
					}
					pays.removeAll(removePays);
					pCRecords.addAll(pays);
				}
				if(pCRecords!=null||pCRecords.size()!=0){
					for(int i=0;i<pCRecords.size();i++){
							totalFee = totalFee.add(pCRecords.get(i).getSum());
						}
				}
				
				//添加invoiceItems
				//添加invoiceItems
				Paragraph invoiceItems = new Paragraph("INVOICE ITEMS",bold_fontEng);
				invoiceItems.setAlignment(Paragraph.ALIGN_CENTER);
				invoiceItems.setSpacingAfter(5f);
				invoiceItems.setSpacingBefore(10f);
				document.add(invoiceItems);
				
				PdfPTable itemsData = new PdfPTable(6);
				float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
				itemsData.setWidths(wid4);
				itemsData.setWidthPercentage(100);
				itemsData.getDefaultCell().setBorderWidthBottom(0);
				PdfPCell tableHeaderForItem = new PdfPCell();
				tableHeaderForItem.setBorder(0);
				tableHeaderForItem.setBorderColorBottom(Color.GRAY);
				tableHeaderForItem.setBorderWidthBottom(0.3f);
				tableHeaderForItem.setBorderWidthTop(1.5f);
				tableHeaderForItem.setMinimumHeight(30f);
				tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
				tableHeaderForItem.setMinimumHeight(20f);
				tableHeaderForItem.setBorderWidth(0.5f);
				tableHeaderForItem.setPhrase(new Phrase("#",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Service",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Price",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				tableHeaderForItem.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
				itemsData.addCell(tableHeaderForItem);
				BigDecimal totalCostFee = new BigDecimal(0);
				List<OrderReceiveItem> orderReceiveItems = new ArrayList<OrderReceiveItem>(); //保存所有条目
				if(orders!=null&&orders.size()!=0){
					for(Order order:orders){
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
					}
				}
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
 								PdfPCell orderReceiveItemNo = new PdfPCell();
 								orderReceiveItemNo.setBorder(0);
 								orderReceiveItemNo.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
 								orderReceiveItemNo.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
 								orderReceiveItemNo.setMinimumHeight(20f);
 								orderReceiveItemNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
 								orderReceiveItemNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
 								itemsData.addCell(orderReceiveItemNo);
								
								PdfPCell serviceCell = new PdfPCell();
								serviceCell.setBorder(0);
								serviceCell.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								serviceCell.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								serviceCell.setMinimumHeight(20f);
								serviceCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								serviceCell.addElement(new Phrase(service,chineseFont));
								itemsData.addCell(serviceCell);
								
								PdfPCell description = new PdfPCell();
								description.setBorder(0);
								description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								description.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								description.setMinimumHeight(20f);
								description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								description.addElement(new Phrase(orderReceiveItems.get(i).getRemark(),chineseFont));
								itemsData.addCell(description);
								
								PdfPCell price = new PdfPCell();
								price.setBorder(0);
								price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								price.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								price.setMinimumHeight(20f);
								price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								price.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
								BigDecimal pri = orderReceiveItems.get(i).getItemFee();
								if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
									pri = new BigDecimal(0).subtract(pri);
								}
								price.addElement(new Phrase(pri.toString(),chineseFont));
								itemsData.addCell(price);
								
								PdfPCell num = new PdfPCell();
								num.setBorder(0);
								num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
								num.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								num.setMinimumHeight(20f);
								num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString(),chineseFont));
								itemsData.addCell(num);
								
								PdfPCell totalFe = new PdfPCell();
								totalFe.setBorder(0);
								totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
								
								if(i==orderReceiveItems.size()-1){
									totalFe.setBorderColor(Color.BLACK);
									totalFe.setBorderWidthBottom(1.5f);
								}else{
									totalFe.setBorderColor(Color.GRAY);
									totalFe.setBorderWidthBottom(0.3f);
								}
								totalFe.setMinimumHeight(20f);
								totalFe.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								totalFe.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
								BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
								if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
									itemFee = new BigDecimal(0).subtract(itemFee);
								}
								Integer mount = orderReceiveItems.get(i).getItemFeeNum();
								BigDecimal toMount = new BigDecimal(mount);
								totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString(),chineseFont));
								itemsData.addCell(totalFe);
								totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
									}
								
								}
					
				document.add(itemsData);
				PdfPTable subTotalData = new PdfPTable(3);
				float[] wid6 ={0.62f,0.18f,0.2f};
				subTotalData.setWidths(wid6);
				subTotalData.setWidthPercentage(100);
				//subTotalData.getDefaultCell().setBorderWidthBottom(0);
				PdfPTable tableForSeal = new PdfPTable(1);
				tableForSeal.getDefaultCell().setBorder(0);
				Image jpegForSeal = Image.getInstance(servletContext.getRealPath("/")+"resources/images/seal.jpg");
				jpegForSeal.setAlignment(Image.ALIGN_RIGHT);// 图片居左
				jpegForSeal.setAlignment(Image.ALIGN_TOP);
				jpegForSeal.setBorder(0);
				jpegForSeal.setWidthPercentage(30);
				jpegForSeal.setAbsolutePosition(250, 400);
				jpegForSeal.scaleAbsolute(125, 125);
				document.add(jpegForSeal);
				
				PdfPCell sub1 = new PdfPCell(new Phrase(""));
				sub1.setRowspan(5);
				sub1.setBorder(0);
				tableForSeal.setWidthPercentage(50);
				sub1.setVerticalAlignment(PdfPCell.ALIGN_TOP);
				subTotalData.addCell(sub1);
				
				
				PdfPCell sub2 = new PdfPCell();
				sub2.setBorder(0);
				sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				sub2.addElement(new Phrase("          SubTotal:",bold_fontEngForTableHead));
				subTotalData.addCell(sub2);
				
				PdfPCell sub3 = new PdfPCell();
				sub3.setBorder(0);
				sub3.addElement(new Phrase("$"+totalCostFee.toString(),chineseFont));
				subTotalData.addCell(sub3);
				
				if(orders.get(0).getPeerUserId()!=null&&orders.get(0).getPeerUserId().length()!=0){
					BigDecimal peerUserFee = new BigDecimal(0.00);
					if(orders.get(0).getPeerUserFee()!=null){
						peerUserFee = orders.get(0).getPeerUserFee();
					}
					PdfPCell userFee2 = new PdfPCell();
					userFee2.setBorder(0);
					userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					userFee2.addElement(new Phrase("    Commission:",bold_fontEngForTableHead));
					subTotalData.addCell(userFee2);
					
					PdfPCell userFee3 = new PdfPCell();
					userFee3.setBorder(0);
					userFee3.addElement(new Phrase(peerUserFee.toString(),chineseFont));
					subTotalData.addCell(userFee3);
				}
				
				PdfPCell paid2 = new PdfPCell();
				paid2.setBorder(0);
				paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				paid2.addElement(new Phrase("                 Paid:",bold_fontEngForTableHead));
				subTotalData.addCell(paid2);
				
				
				PdfPCell paid3 = new PdfPCell();
				paid3.setBorder(0);
				paid3.addElement(new Phrase("$"+totalFee.toString(),chineseFont));
				subTotalData.addCell(paid3);
				
				PdfPCell balance2 = new PdfPCell();
				balance2.setBorder(0);
				balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				balance2.addElement(new Phrase("           Balance:",bold_fontEngForTableHead));
				subTotalData.addCell(balance2);
				
				PdfPCell balance3 = new PdfPCell();
				balance3.setBorder(0);
				BigDecimal bal = totalCostFee.subtract(totalFee);
				if(orders.get(0).getPeerUserId()!=null&&orders.get(0).getPeerUserId().length()!=0&&orders.get(0).getPeerUserFee()!=null){
					bal = bal.subtract(orders.get(0).getPeerUserFee());
				}
				balance3.addElement(new Phrase("$"+bal.toString(),chineseFont));
				subTotalData.addCell(balance3);
				
				/*BigDecimal rate = new BigDecimal(1.00);
				if(orders!=null&&orders.size()!=0){
					rate = orders.get(0).getRate();
				}
				
				PdfPCell tax2 = new PdfPCell();
				tax2.setBorder(0);
				tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				tax2.addElement(new Phrase("Exchange Rate:",bold_fontEngForTableHead));
				subTotalData.addCell(tax2);
				
				PdfPCell tax3 = new PdfPCell();
				tax3.setBorder(0);
				tax3.addElement(new Phrase(rate.toString(),chineseFont));
				subTotalData.addCell(tax3);
				
				PdfPCell toatl2 = new PdfPCell();
				toatl2.setBorder(0);
				toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
				toatl2.addElement(new Phrase("Total Blance:",bold_fontEngForTableHead));
				subTotalData.addCell(toatl2);
				
				PdfPCell toatl3 = new PdfPCell();
				toatl3.setBorder(0);
				toatl3.addElement(new Phrase("￥"+bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),chineseFont));
				subTotalData.addCell(toatl3);*/
				document.add(subTotalData);
				//客人信息
						List<Customer> customersForToatl = new ArrayList<Customer>();
						List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findWithCustomerByOrdersTotalId(ordersTotalId);
							for(CustomerOrderRel customerOrderRel:customerOrderRelList){
								if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
									Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
									customersForToatl.add(customer);
								}
							}
					
					Paragraph cus = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					cus.setAlignment(Paragraph.ALIGN_CENTER);
					cus.setSpacingAfter(10f);
					cus.setSpacingBefore(10f);
					document.add(cus);
					
					PdfPTable cusData = new PdfPTable(4);
					float[] wid5 ={0.1f,0.4f,0.3f,0.20f};
					cusData.setWidths(wid5);
					cusData.setWidthPercentage(100);
					cusData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeaderForCus = new PdfPCell();
					tableHeaderForCus.setBorder(0);
					tableHeaderForCus.setBorderColorBottom(Color.GRAY);
					tableHeaderForCus.setBorderWidthBottom(0.3f);
					tableHeaderForCus.setBorderWidthTop(1.5f);
					tableHeaderForCus.setMinimumHeight(30f);
					tableHeaderForCus.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeaderForCus.setMinimumHeight(20f);
					tableHeaderForCus.setBorderWidth(0.5f);
					tableHeaderForCus.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					if(customersForToatl!=null){
					for(int i=0;i<customersForToatl.size();i++){
						PdfPCell cusNo = new PdfPCell();
						cusNo.setBorder(0);
						cusNo.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusNo.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusNo.setMinimumHeight(20f);
						cusNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						cusNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
						cusData.addCell(cusNo);
						
						PdfPCell cusName = new PdfPCell();
						cusName.setBorder(0);
						cusName.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusName.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusName.setMinimumHeight(20f);
						cusName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName(),chineseFont));
						cusData.addCell(cusName);
						
						PdfPCell cusGender = new PdfPCell();
						cusGender.setBorder(0);
						cusGender.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusGender.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusGender.setMinimumHeight(20f);
						cusGender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String sexForString = "";
						if(customersForToatl.get(i).getSex()==1){
							sexForString = "FEMALE";
						}else if(customersForToatl.get(i).getSex()==2){
							sexForString = "MALE";
						}
						cusGender.addElement(new Phrase(sexForString,chineseFont));
						cusData.addCell(cusGender);
						
						PdfPCell cusNationality = new PdfPCell();
						cusNationality.setBorder(0);
						cusNationality.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusNationality.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusNationality.setMinimumHeight(20f);
						cusNationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String countryName = "";
						if(customersForToatl.get(i)!=null){
								countryName = customersForToatl.get(i).getNationalityOfPassport();
						}
						cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName,chineseFont));
						cusData.addCell(cusNationality);
						
					}
					}
					document.add(cusData);
					//添加payment
					Paragraph payment = new Paragraph("PAYMENT HISTORY",bold_fontEng);
					payment.setAlignment(Paragraph.ALIGN_CENTER);
					payment.setSpacingAfter(10f);
					payment.setSpacingBefore(10f);
					document.add(payment);
					
					PdfPTable paymentData = new PdfPTable(5);
					paymentData.getDefaultCell().setMinimumHeight(20f);
					float[] wid3 ={0.1f,0.2f,0.3f,0.3f,0.10f};
					paymentData.setWidths(wid3);
					paymentData.setWidthPercentage(100);
					paymentData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell tableHeader = new PdfPCell();
					tableHeader.setBorder(0);
					tableHeader.setBorderColorBottom(Color.GRAY);
					tableHeader.setBorderWidthBottom(0.3f);
					tableHeader.setBorderWidthTop(1.5f);
					tableHeader.setMinimumHeight(30f);
					tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeader.setMinimumHeight(20f);
					tableHeader.setBorderWidth(0.5f);
					tableHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Amount",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					
					 
					//获取每个子订单下的payment
					List<PayCostRecords> payCostRecords = new ArrayList<PayCostRecords>(); //存放所有的
					for(Order order:orders){
						List<PayCostRecords> pays = payCostRecordsMapper.findByOrderId(order.getId());
						List<PayCostRecords> removePays = new ArrayList<PayCostRecords>();
						for(PayCostRecords payCostRecord:pays){
							if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
								removePays.add(payCostRecord);
							}
						}
						pays.removeAll(removePays);
						payCostRecords.addAll(pays);
					}
					
						if(payCostRecords!=null||payCostRecords.size()!=0){
							for(int i=0;i<payCostRecords.size();i++){
	 								PdfPCell payNo = new PdfPCell();
									payNo.setBorder(0);
									payNo.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									payNo.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									payNo.setMinimumHeight(20f);
									payNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									payNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
									paymentData.addCell(payNo);
									
									PdfPCell date = new PdfPCell();
									date.setBorder(0);
									date.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									date.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									date.setMinimumHeight(20f);
									date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									SimpleDateFormat simpleDateFormat=new SimpleDateFormat("MM/dd/yyyy");
									date.addElement(new Phrase(payCostRecords.get(i).getTime()==null?"":simpleDateFormat.format(payCostRecords.get(i).getTime()),chineseFont));
									paymentData.addCell(date);
									PdfPCell description = new PdfPCell();
									description.setBorder(0);
									description.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									description.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									description.setMinimumHeight(20f);
									description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									description.addElement(new Phrase(payCostRecords.get(i).getItem(),chineseFont));
									paymentData.addCell(description);
									
									PdfPCell remark = new PdfPCell();
									remark.setBorder(0);
									remark.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									remark.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									remark.setMinimumHeight(20f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									remark.addElement(new Phrase(payCostRecords.get(i).getRemark(),chineseFont));
									paymentData.addCell(remark);
									
									PdfPCell amount = new PdfPCell();
									amount.setBorder(0);
									amount.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									amount.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									amount.setMinimumHeight(20f);
									amount.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									amount.setHorizontalAlignment(PdfPCell.ALIGN_RIGHT);
									amount.addElement(new Phrase(payCostRecords.get(i).getSum().toString(),chineseFont));
									paymentData.addCell(amount);
								}
						}
					document.add(paymentData);
					Paragraph total = new Paragraph("Total: "+totalFee,bold_fontEngForTableHead);
					total.setAlignment(2);
					document.add(total);
					PdfPTable footReamrk = new PdfPTable(1); //表格两列
					footReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					footReamrk.setWidthPercentage(100);//表格的宽度为100%
					footReamrk.getDefaultCell().setBorderWidth(0); //不显示边框
					footReamrk.getDefaultCell().setBorderColor(Color.GRAY);
					
					
					PdfPCell foot1 = new PdfPCell(new Paragraph("Please note that all travel documents will only be sent after you full balance has been received.",norm_fontEng));
					foot1.setBorder(0);
					foot1.setPaddingTop(5f);
					foot1.setMinimumHeight(1f);
					footReamrk.addCell(foot1);
					
					
					PdfPCell foot2 = new PdfPCell(new Paragraph("Please inspect this invoice carefully; our company will not be responsible for any errors after 2 business days.",norm_fontEng));
					foot2.setBorder(0);
					foot2.setMinimumHeight(1f);
					footReamrk.addCell(foot2);
					
					PdfPCell foot3 = new PdfPCell(new Paragraph("Please check our website for terms and conditions.",norm_fontEng));
					foot3.setBorder(0);
					foot3.setMinimumHeight(1f);
					footReamrk.addCell(foot3);
					
					document.add(footReamrk);
					
					Paragraph LogoSpace = new Paragraph("",bold_fontEng);
					LogoSpace.setAlignment(Paragraph.ALIGN_CENTER);
					LogoSpace.setSpacingAfter(10f);
					LogoSpace.setSpacingBefore(10f);
					document.add(LogoSpace);
					
					PdfPTable tablelogo = new PdfPTable(3); //表格两列
					if(l==4){
						float[] wid1 ={0.2f,0.25f,0.55f};
						tablelogo.setWidths(wid1);
					}else if(l==2||l==3){
						float[] wid1 ={0.2f,0.25f,0.55f};
						tablelogo.setWidths(wid1);
					}else if(l==1){
						float[] wid1 ={0.2f,0.25f,0.55f};
						tablelogo.setWidths(wid1);
					}
					tablelogo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					tablelogo.setWidthPercentage(100);//表格的宽度为100%
		//			tablelogo.getDefaultCell().setBorderWidth(0); //不显示边框
					tablelogo.getDefaultCell().setBorderColor(Color.GRAY);
					
					
		
					
					
					PdfPCell Cell_logo2 = new PdfPCell(new Paragraph("")); //
					Cell_logo2.setBorder(0);
					Cell_logo2.setBorderColor(Color.GRAY);
					tablelogo.addCell(Cell_logo2);
					
					
					PdfPCell Cell_logo3 = new PdfPCell(new Paragraph("")); //
					Cell_logo3.setBorder(0);
					Cell_logo3.setBorderColor(Color.GRAY);
					tablelogo.addCell(Cell_logo3);
					
					
					PdfPTable tablelogo1 = new PdfPTable(2);
					float[] wid ={0.8f,0.2f};
					tablelogo1.setWidths(wid);
					tablelogo1.getDefaultCell().setBorderWidth(0);
					PdfPCell Cell_logo = new PdfPCell(tablelogo1);
					Cell_logo.setBorder(0);
					tablelogo.addCell(Cell_logo);
					
					PdfPCell Cell_logo1 = new PdfPCell(new Paragraph(" Thank you for choosing   ",norm_fontEng));
					Cell_logo1.setBorder(0);
					Cell_logo1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					Cell_logo1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					tablelogo1.addCell(Cell_logo1);
					
					
					PdfPCell logoCell=new PdfPCell();
					logoCell.addElement(jpeg);
					logoCell.setBorder(0);
					logoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
					tablelogo1.addCell(logoCell);
					
					document.add(tablelogo);
					
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
	
	//子单invoice
		@Override
		public String createSelfInvoicePdfForChild(String orderId) {
			Order order = orderMapper.findById(orderId);
			String orderNumber = order.getOrderNo();
			//获取该子订单对应的总订单
			OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
			
			TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orderId);
			GroupLine groupLine = groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
			//String brand = groupLine.getBrand();
		
			//获取该总订单下的所有子订单
			//List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
			
			Setting setting = SettingUtils.get();
			String uploadPath = setting.getTempPDFPath();
			String destPath = null;
			String addressForDept = "";
		    String Company="";
		    String cityAndState="";
		      String venderId = ordersTotal.getCompanyId();
		      Vender vender = null;
		      if(venderId!=null&&venderId.length()!=0){
		        vender = venderMapper.findById(venderId);
		      }
	          if(ordersTotal.getWr().equals("wholeSale")){
	              if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
	            	  cityAndState=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
	                  Company=vender.getName();
	              }else{
	            	  Company="";
	              }
	            }else{
	            	Company=ordersTotal.getContactName();
	            }
            String bookingDate="";
            SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
              if(order!=null&&order.getCreateDate()!=null){
                bookingDate=df1.format(order.getCreateDate());
            }
			String arriveDate = "";
			if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
				arriveDate=df1.format(tourInfoForOrder.getScheduleOfArriveTime());
			}
			String mailForDept = "";
		    Admin agen = adminService.findById(ordersTotal.getUserId());
	    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
	    	addressForDept = deptForAgent.getAddress();
	    	if(agen.getEmail().equals("")){
	    		mailForDept = deptForAgent.getEmail();
	    	}else{
	    		mailForDept = agen.getEmail();
	    	}
			try {
				Map<String, Object> model = new HashMap<String, Object>();
				String path = FreemarkerUtils.process(uploadPath, model);
				destPath = path + "invoice-"+orderNumber+".pdf";
				File destFile = new File(servletContext.getRealPath(destPath));
				if (!destFile.getParentFile().exists()) {
					destFile.getParentFile().mkdirs();
				}
				
				// 创建一个Document对象
				Document document = new Document(PageSize.A4, 36, 36, 24, 36);
				try {
					// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
					
					PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
					String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
					BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
					BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
					Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
							Color.BLACK);
					
					Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
							Color.BLACK);
					//中文超大号
					Font  chineseFontBig = new Font(bfChinese, 12,  Font.BOLD,Color.BLACK);
					//中文斜体(大号)
					Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
					//中文斜体(小号)
					Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
					
					Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
					
					document.open();
					
					/*     Invoice 顶部的地址栏信息和Logo开始           */
					
					PdfPTable tableTitleSpace = new PdfPTable(3); //表格两列
					tableTitleSpace.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					tableTitleSpace.setWidthPercentage(100);//表格的宽度为100%
					float[] wid11 ={0.45f,0.25f,0.30f};
					tableTitleSpace.setWidths(wid11);
					
					
					PdfPCell cell21_11 = new PdfPCell(new Paragraph("",chineseFontBig));
					cell21_11.setBorder(0);
					cell21_11.setPaddingBottom(10f);
					cell21_11.setMinimumHeight(10f);
					tableTitleSpace.addCell(cell21_11);
					
					PdfPCell cell21_21 = new PdfPCell(new Paragraph("",littleChineseFont));
					cell21_21.setBorder(0);
					cell21_21.setPaddingBottom(10f);
					cell21_21.setMinimumHeight(10f);
					tableTitleSpace.addCell(cell21_21);
					
					PdfPCell cell261 = new PdfPCell(new Paragraph("",littleChineseFont));
					cell261.setBorder(0);
					cell261.setMinimumHeight(10f);
					cell261.setPaddingBottom(10f);
					tableTitleSpace.addCell(cell261);
					
					document.add(tableTitleSpace);
					
					// 添加抬头图片
					PdfPTable table1 = new PdfPTable(3); //表格两列
					table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					table1.setWidthPercentage(100);//表格的宽度为100%
					 //两列宽度的比例并设置logo
					String logo = "";
					int l;
					
					/**/
					PdfPTable table13 = new PdfPTable(1);
					table13.getDefaultCell().setBorderWidth(0);
					PdfPCell cell2 = new PdfPCell(table13);
					cell2.setBorder(0);
					cell2.setPaddingBottom(5f);
					table1.addCell(cell2);
					
					//Logo文字标识
					String logoInDentifying="";
					if(logo.equals(Constant.LOGO_PATH[0])){
						logoInDentifying="中国美";
					}else if(logo.equals(Constant.LOGO_PATH[1])){
						logoInDentifying="Chinatour.com";
					}else if(logo.equals(Constant.LOGO_PATH[2])){
						logoInDentifying="Intertrips";
					}else{
						logoInDentifying="文景假期";
					}
					PdfPCell cellHead = new PdfPCell(new Paragraph(logoInDentifying,chineseFontBig));
					cellHead.setBorder(0);
					cellHead.setMinimumHeight(10f);
					table13.addCell(cellHead);
					
					PdfPCell cell20 = new PdfPCell(new Paragraph("Agent Name:"+agen.getUsername(),littleChineseFont));
					cell20.setBorder(0);
					cell20.setMinimumHeight(10f);
					table13.addCell(cell20);
					
					PdfPCell cell21 = new PdfPCell(new Paragraph("Address:"+agen.getAddress(),littleChineseFont));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell cell21_1 = new PdfPCell(new Paragraph("Tel:"+agen.getTel(),littleChineseFont));
					cell21_1.setBorder(0);
					cell21_1.setMinimumHeight(10f);
					table13.addCell(cell21_1);
					
					PdfPCell cell21_2 = new PdfPCell(new Paragraph("Fax:"+agen.getFax(),littleChineseFont));
					cell21_2.setBorder(0);
					cell21_2.setMinimumHeight(10f);
					table13.addCell(cell21_2);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailForDept,littleChineseFont));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					table13.addCell(cell26);
					
					PdfPCell cell1 = new PdfPCell(new Paragraph("Departure city:"+tourInfoForOrder.getSpecialRequirements(),littleChineseFont)); //中间放以空白列
					cell1.setBorder(0);
					table1.addCell(cell1);
					
					if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
						logo = Constant.LOGO_PATH[0];
						l=1;
					}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
						logo = Constant.LOGO_PATH[1];
						l=2;
					}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
						logo = Constant.LOGO_PATH[2];
						l=3;
					}else{
						logo = Constant.LOGO_PATH[3];
						l=4;
					}
					
					if(logo.equals(Constant.LOGO_PATH[3])){
						float[] wid1 ={0.30f,0.25f,0.45f};
						table1.setWidths(wid1);
					}else if(logo.equals(Constant.LOGO_PATH[1])){
						float[] wid1 ={0.3f,0.45f,0.25f};
						table1.setWidths(wid1);
					}else if(logo.equals(Constant.LOGO_PATH[0])){
						float[] wid1 ={0.30f,0.45f,0.25f};
						table1.setWidths(wid1);
					}else if(logo.equals(Constant.LOGO_PATH[2])){
						float[] wid1 ={0.30f,0.25f,0.45f};
						table1.setWidths(wid1);
					}
					 
					table1.getDefaultCell().setBorderWidth(0); //不显示边框
					PdfPTable table11 = new PdfPTable(1);
					table11.getDefaultCell().setBorder(0);
					Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
					jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
					jpeg.setAlignment(Image.ALIGN_TOP);
					jpeg.setBorder(0);
					table11.addCell(jpeg);
					table11.getDefaultCell().setBorderWidth(0);
					PdfPCell cell0 = new PdfPCell(table11);
					cell0.setBorder(0);
					table11.setWidthPercentage(60);
					table1.addCell(cell0);
					cell0.setBorder(0);
					
					document.add(table1);
					
					PdfContentByte cb=writer.getDirectContent();
					cb.setLineWidth(0.3f);
					
					/*BILL TO信息添加*/
					PdfPTable tabalOrder_2 = new PdfPTable(2);
					float[] widOrder4 ={0.52f,0.48f};
					tabalOrder_2.setWidths(widOrder4);
					tabalOrder_2.setWidthPercentage(100);
					tabalOrder_2.getDefaultCell().setBorderWidthTop(0);
					tabalOrder_2.setSpacingBefore(10f);
					
					PdfPCell tableOrderCell = new PdfPCell();
					tableOrderCell.setBorder(0);
					tableOrderCell.setBorderWidthTop(0.3f);
					tableOrderCell.setPaddingTop(20f);
					tableOrderCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableOrderCell.setPhrase(new Phrase("BILL TO",bold_fontEng));
					tabalOrder_2.addCell(tableOrderCell);
					tableOrderCell.setPhrase(new Phrase("Invoice No:"+order.getOrderNo(),norm_fontEng));
					tabalOrder_2.addCell(tableOrderCell);
					
					
					PdfPCell orderItems_2 = new PdfPCell(new Paragraph("Company:"+Company,norm_fontEng));
					orderItems_2.setBorder(0);
					orderItems_2.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_2);
					
					String tourCode = "";
					String departureDate = "";
					if(order.getTourId()!=null&&order.getTourId()!=""){
						tourCode = order.getTourCode();
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
							departureDate = df.format(tourInfoForOrder.getScheduleOfArriveTime());
						}
					}
					
					PdfPCell orderItems_1 = new PdfPCell(new Paragraph("Tour Code:"+tourCode,norm_fontEng));
					orderItems_1.setBorder(0);
					orderItems_1.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_1);
					
					PdfPCell cell014 = null;
					if(ordersTotal.getWr().equals("wholeSale")){
						if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
							cell014 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
						}else{
							cell014 = new PdfPCell(new Paragraph("Name:"+"",norm_fontEng));
						}
					}else{
						cell014 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
					}
					
					cell014.setBorder(0);
					cell014.setMinimumHeight(10f);
					tabalOrder_2.addCell(cell014);
					
					PdfPCell orderItems_3 = new PdfPCell(new Paragraph("Booking Date:"+bookingDate,norm_fontEng));
					orderItems_3.setBorder(0);
					orderItems_3.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_3);
					
					
					PdfPCell tabalCell_2_2 = new PdfPCell(new Paragraph("Address:"+ordersTotal.getAddress()+" "+cityAndState,norm_fontEng));
					tabalCell_2_2.setBorder(0);
					tabalCell_2_2.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_2_2);
					
					PdfPCell tabalCell_space = new PdfPCell(new Paragraph("Departure Date:"+departureDate,norm_fontEng));
					tabalCell_space.setBorder(0);
					tabalCell_space.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_space);
					
					
					PdfPCell tabalCell_2_3 = new PdfPCell(new Paragraph("Phone:"+ordersTotal.getTel(),norm_fontEng));
					tabalCell_2_3.setBorder(0);
					tabalCell_2_3.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_2_3);
					
					PdfPCell tabalCell_space2 = new PdfPCell(new Paragraph("",norm_fontEng));
					tabalCell_space2.setBorder(0);
					tabalCell_space2.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_space2);
					
					
					PdfPCell tabalCellEamil = new PdfPCell(new Paragraph("Email:"+ordersTotal.getEmail(),norm_fontEng));
					tabalCellEamil.setBorder(0);
					tabalCellEamil.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCellEamil);
					
					PdfPCell tabalCell_space3 = new PdfPCell(new Paragraph("",norm_fontEng));
					tabalCell_space3.setBorder(0);
					tabalCell_space3.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_space3);
					
					document.add(tabalOrder_2);
					
					
					List<PayCostRecords> pRecords = new ArrayList<PayCostRecords>(); //存放所有的
					List<PayCostRecords> pay = payCostRecordsMapper.findByOrderId(order.getId());
					List<PayCostRecords> removePay = new ArrayList<PayCostRecords>();
					for(PayCostRecords payCostRecord:pay){
						if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
							removePay.add(payCostRecord);
						}
					}
					pay.removeAll(removePay);
					pRecords.addAll(pay);
				
					BigDecimal totalFee = new BigDecimal(0);
						if(pRecords!=null||pRecords.size()!=0){
							for(int i=0;i<pRecords.size();i++){
									totalFee = totalFee.add(pRecords.get(i).getSum());
								}
						}
					
					
					//添加invoiceItems
					Paragraph invoiceItems = new Paragraph("INVOICE ITEMS",bold_fontEng);
					invoiceItems.setAlignment(Paragraph.ALIGN_CENTER);
					invoiceItems.setSpacingAfter(10f);
					invoiceItems.setSpacingBefore(10f);
					document.add(invoiceItems);
					
					PdfPTable itemsData = new PdfPTable(6);
					float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
					itemsData.setWidths(wid4);
					itemsData.setWidthPercentage(100);
					itemsData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeaderForItem = new PdfPCell();
					tableHeaderForItem.setBorder(0);
					tableHeaderForItem.setBorderColorBottom(Color.GRAY);
					tableHeaderForItem.setBorderWidthBottom(0.3f);
					tableHeaderForItem.setBorderWidthTop(1.5f);
					tableHeaderForItem.setMinimumHeight(30f);
					tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeaderForItem.setMinimumHeight(20f);
					tableHeaderForItem.setBorderWidth(0.5f);
					tableHeaderForItem.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Service",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Price",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
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
	 								PdfPCell orderReceiveItemNo = new PdfPCell();
	 								orderReceiveItemNo.setBorder(0);
	 								orderReceiveItemNo.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
	 								orderReceiveItemNo.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
	 								orderReceiveItemNo.setMinimumHeight(20f);
	 								orderReceiveItemNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
	 								orderReceiveItemNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
	 								itemsData.addCell(orderReceiveItemNo);
									
									PdfPCell serviceCell = new PdfPCell();
									serviceCell.setBorder(0);
									serviceCell.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									serviceCell.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									serviceCell.setMinimumHeight(20f);
									serviceCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									serviceCell.addElement(new Phrase(service,chineseFont));
									itemsData.addCell(serviceCell);
									
									PdfPCell description = new PdfPCell();
									description.setBorder(0);
									description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									description.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									description.setMinimumHeight(20f);
									description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									description.addElement(new Phrase(orderReceiveItems.get(i).getRemark(),chineseFont));
									itemsData.addCell(description);
									
									PdfPCell price = new PdfPCell();
									price.setBorder(0);
									price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									price.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									price.setMinimumHeight(20f);
									price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									BigDecimal pri = orderReceiveItems.get(i).getItemFee();
									if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
										pri = new BigDecimal(0).subtract(pri);
									}
									price.addElement(new Phrase(pri.toString(),chineseFont));
									itemsData.addCell(price);
									
									PdfPCell num = new PdfPCell();
									num.setBorder(0);
									num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									num.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									num.setMinimumHeight(20f);
									num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString(),chineseFont));
									itemsData.addCell(num);
									
									PdfPCell totalFe = new PdfPCell();
									totalFe.setBorder(0);
									totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									
									if(i==orderReceiveItems.size()-1){
										totalFe.setBorderColor(Color.BLACK);
										totalFe.setBorderWidthBottom(1.5f);
									}else{
										totalFe.setBorderColor(Color.GRAY);
										totalFe.setBorderWidthBottom(0.3f);
									}
									totalFe.setMinimumHeight(20f);
									totalFe.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
									if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
										itemFee = new BigDecimal(0).subtract(itemFee);
									}
									Integer mount = orderReceiveItems.get(i).getItemFeeNum();
									BigDecimal toMount = new BigDecimal(mount);
									totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString(),chineseFont));
									itemsData.addCell(totalFe);
									totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
										}
									
									}
						
					document.add(itemsData);
					PdfPTable subTotalData = new PdfPTable(3);
					float[] wid6 ={0.62f,0.18f,0.2f};
					subTotalData.setWidths(wid6);
					subTotalData.setWidthPercentage(100);
					subTotalData.getDefaultCell().setMinimumHeight(20f);
					
					
					PdfPTable tableForSeal = new PdfPTable(1);
					tableForSeal.getDefaultCell().setBorder(0);
					Image jpegForSeal = Image.getInstance(servletContext.getRealPath("/")+"resources/images/seal.jpg");
					jpegForSeal.setAlignment(Image.ALIGN_RIGHT);// 图片居左
					jpegForSeal.setAlignment(Image.ALIGN_TOP);
					jpegForSeal.setBorder(0);
					jpegForSeal.setWidthPercentage(30);
					jpegForSeal.setAbsolutePosition(250, 400);
					jpegForSeal.scaleAbsolute(125, 125);
					document.add(jpegForSeal);
					PdfPCell sub1 = new PdfPCell(new Phrase(""));
					sub1.setRowspan(5);
					sub1.setBorder(0);
					tableForSeal.setWidthPercentage(50);
					sub1.setVerticalAlignment(PdfPCell.ALIGN_TOP);
					subTotalData.addCell(sub1);
					
					PdfPCell sub2 = new PdfPCell();
					sub2.setBorder(0);
					sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					sub2.addElement(new Phrase("          SubTotal:",bold_fontEngForTableHead));
					subTotalData.addCell(sub2);
					
					PdfPCell sub3 = new PdfPCell();
					sub3.setBorder(0);
					sub3.addElement(new Phrase("$"+totalCostFee.toString(),chineseFont));
					subTotalData.addCell(sub3);
					
				/*	PdfPCell paid1 = new PdfPCell();
					paid1.setBorder(0);
					paid1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(paid1);*/
					
					if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0){
						BigDecimal peerUserFee = new BigDecimal(0.00);
						if(order.getPeerUserFee()!=null){
							peerUserFee = order.getPeerUserFee();
						}
						PdfPCell userFee2 = new PdfPCell();
						userFee2.setBorder(0);
						userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
						userFee2.addElement(new Phrase("    Commission:",bold_fontEngForTableHead));
						subTotalData.addCell(userFee2);
						
						PdfPCell userFee3 = new PdfPCell();
						userFee3.setBorder(0);
						userFee3.addElement(new Phrase("$"+peerUserFee.toString(),chineseFont));
						subTotalData.addCell(userFee3);
					}
					
					PdfPCell paid2 = new PdfPCell();
					paid2.setBorder(0);
					paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					paid2.addElement(new Phrase("                 Paid:",bold_fontEngForTableHead));
					subTotalData.addCell(paid2);
					
					
					PdfPCell paid3 = new PdfPCell();
					paid3.setBorder(0);
					paid3.addElement(new Phrase("$"+totalFee.toString(),chineseFont));
					subTotalData.addCell(paid3);
					
				/*	PdfPCell balance1 = new PdfPCell();
					balance1.setBorder(0);
					balance1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(balance1);*/
					
					PdfPCell balance2 = new PdfPCell();
					balance2.setBorder(0);
					balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					balance2.addElement(new Phrase("           Balance:",bold_fontEngForTableHead));
					subTotalData.addCell(balance2);
					
					PdfPCell balance3 = new PdfPCell();
					balance3.setBorder(0);
					BigDecimal bal = totalCostFee.subtract(totalFee);
					if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0&&order.getPeerUserFee()!=null){
						bal = bal.subtract(order.getPeerUserFee());
					}
					balance3.addElement(new Phrase("$"+bal.toString(),chineseFont));
					subTotalData.addCell(balance3);
					
					/*BigDecimal rate = new BigDecimal(1.00);
						rate = order.getRate();
					
					
					PdfPCell tax1 = new PdfPCell();
					tax1.setBorder(0);
					tax1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(tax1);*/
					
					/*PdfPCell tax2 = new PdfPCell();
					tax2.setBorder(0);
					tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					tax2.addElement(new Phrase("Exchange Rate:",bold_fontEngForTableHead));
					subTotalData.addCell(tax2);
					
					PdfPCell tax3 = new PdfPCell();
					tax3.setBorder(0);
					tax3.addElement(new Phrase(rate.toString(),chineseFont));
					subTotalData.addCell(tax3);*/
					
				/*	PdfPCell toatl1 = new PdfPCell();
					toatl1.setBorder(0);
					toatl1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(toatl1);*/
					
					/*PdfPCell toatl2 = new PdfPCell();
					toatl2.setBorder(0);
					toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					toatl2.addElement(new Phrase("Total Blance:",bold_fontEngForTableHead));
					subTotalData.addCell(toatl2);
					
					PdfPCell toatl3 = new PdfPCell();
					toatl3.setBorder(0);
					toatl3.addElement(new Phrase("￥"+bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),chineseFont));
					subTotalData.addCell(toatl3);*/
					document.add(subTotalData);
					//客人信息
							List<Customer> customersForToatl = new ArrayList<Customer>();
							List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerByOrderId(orderId);
							for(CustomerOrderRel customerOrderRel:customerOrderRelList){
								if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
									Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
									customersForToatl.add(customer);
								}
							}
						
						
						Paragraph cus = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
						cus.setAlignment(Paragraph.ALIGN_CENTER);
						cus.setSpacingAfter(10f);
						cus.setSpacingBefore(10f);
						document.add(cus);
						
						PdfPTable cusData = new PdfPTable(4);
						float[] wid5 ={0.1f,0.4f,0.3f,0.20f};
						cusData.setWidths(wid5);
						cusData.setWidthPercentage(100);
						cusData.getDefaultCell().setBorderWidthBottom(0);
						
						PdfPCell tableHeaderForCus = new PdfPCell();
						tableHeaderForCus.setBorder(0);
						tableHeaderForCus.setBorderColorBottom(Color.GRAY);
						tableHeaderForCus.setBorderWidthBottom(0.3f);
						tableHeaderForCus.setBorderWidthTop(1.5f);
						tableHeaderForCus.setMinimumHeight(30f);
						tableHeaderForCus.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						tableHeaderForCus.setMinimumHeight(20f);
						tableHeaderForCus.setBorderWidth(0.5f);
						tableHeaderForCus.setPhrase(new Phrase("#",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						tableHeaderForCus.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						tableHeaderForCus.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						tableHeaderForCus.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						if(customersForToatl!=null){
						for(int i=0;i<customersForToatl.size();i++){
							PdfPCell cusNo = new PdfPCell();
							cusNo.setBorder(0);
							cusNo.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusNo.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusNo.setMinimumHeight(20f);
							cusNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							cusNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
							cusData.addCell(cusNo);
							
							PdfPCell cusName = new PdfPCell();
							cusName.setBorder(0);
							cusName.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusName.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusName.setMinimumHeight(20f);
							cusName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName(),chineseFont));
							cusData.addCell(cusName);
							
							PdfPCell cusGender = new PdfPCell();
							cusGender.setBorder(0);
							cusGender.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusGender.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusGender.setMinimumHeight(20f);
							cusGender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String sexForString = "";
							if(customersForToatl.get(i).getSex()==1){
								sexForString = "FEMALE";
							}else if(customersForToatl.get(i).getSex()==2){
								sexForString = "MALE";
							}
							cusGender.addElement(new Phrase(sexForString,chineseFont));
							cusData.addCell(cusGender);
							
							PdfPCell cusNationality = new PdfPCell();
							cusNationality.setBorder(0);
							cusNationality.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusNationality.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusNationality.setMinimumHeight(20f);
							cusNationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String countryName = "";
							if(customersForToatl.get(i)!=null){
									countryName = customersForToatl.get(i).getNationalityOfPassport();
							}
							cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName,chineseFont));
							cusData.addCell(cusNationality);
							
						}
						}
						document.add(cusData);
						//添加payment
						Paragraph payment = new Paragraph("PAYMENT HISTORY",bold_fontEng);
						payment.setAlignment(Paragraph.ALIGN_CENTER);
						payment.setSpacingAfter(10f);
						payment.setSpacingBefore(10f);
						document.add(payment);
						
						PdfPTable paymentData = new PdfPTable(4);
						float[] wid3 ={0.1f,0.2f,0.6f,0.10f};
						paymentData.setWidths(wid3);
						paymentData.setWidthPercentage(100);
						paymentData.getDefaultCell().setBorderWidthBottom(0);
						
						PdfPCell tableHeader = new PdfPCell();
						tableHeader.setBorder(0);
						tableHeader.setBorderColorBottom(Color.GRAY);
						tableHeader.setBorderWidthBottom(0.3f);
						tableHeader.setBorderWidthTop(1.5f);
						tableHeader.setMinimumHeight(30f);
						tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						tableHeader.setMinimumHeight(20f);
						tableHeader.setBorderWidth(0.5f);
						tableHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
						paymentData.addCell(tableHeader);
						tableHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
						paymentData.addCell(tableHeader);
						tableHeader.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
						paymentData.addCell(tableHeader);
						tableHeader.setPhrase(new Phrase("Amount",bold_fontEngForTableHead));
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
						
						
						
							if(payCostRecords!=null||payCostRecords.size()!=0){
								for(int i=0;i<payCostRecords.size();i++){
		 								PdfPCell payNo = new PdfPCell();
										payNo.setBorder(0);
										payNo.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
										payNo.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
										payNo.setMinimumHeight(20f);
										payNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
										payNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
										paymentData.addCell(payNo);
										
										PdfPCell date = new PdfPCell();
										date.setBorder(0);
										date.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
										date.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
										date.setMinimumHeight(20f);
										date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
										SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
										date.addElement(new Phrase(payCostRecords.get(i).getTime()==null?"":simpleDateFormat.format(payCostRecords.get(i).getTime()),chineseFont));
										paymentData.addCell(date);
										
										PdfPCell description = new PdfPCell();
										description.setBorder(0);
										description.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
										description.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
										description.setMinimumHeight(20f);
										description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
										description.addElement(new Phrase(payCostRecords.get(i).getItem(),chineseFont));
										paymentData.addCell(description);
										
										PdfPCell amount = new PdfPCell();
										amount.setBorder(0);
										amount.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
										amount.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
										amount.setMinimumHeight(20f);
										amount.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
										amount.addElement(new Phrase(payCostRecords.get(i).getSum().toString(),chineseFont));
										paymentData.addCell(amount);
									}
							}
						document.add(paymentData);
						Paragraph total = new Paragraph("Total: "+totalFee,bold_fontEngForTableHead);
						total.setAlignment(2);
						document.add(total);
						
						PdfPTable footReamrk = new PdfPTable(1); //表格1列
						footReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
						footReamrk.setWidthPercentage(100);//表格的宽度为100%
						footReamrk.getDefaultCell().setBorderWidth(0); //不显示边框
						footReamrk.getDefaultCell().setBorderColor(Color.GRAY);
						
						
						PdfPCell foot1 = new PdfPCell(new Paragraph("Please note that all travel documents will only be sent after you full balance has been received.",norm_fontEng));
						foot1.setBorder(0);
						foot1.setPaddingTop(5f);
						foot1.setMinimumHeight(1f);
						footReamrk.addCell(foot1);
						
						
						PdfPCell foot2 = new PdfPCell(new Paragraph("Please inspect this invoice carefully; our company will not be responsible for any errors after 2 business days.",norm_fontEng));
						foot2.setBorder(0);
						foot2.setMinimumHeight(1f);
						footReamrk.addCell(foot2);
						
						PdfPCell foot3 = new PdfPCell(new Paragraph("Please check our website for terms and conditions.",norm_fontEng));
						foot3.setBorder(0);
						foot3.setMinimumHeight(1f);
						footReamrk.addCell(foot3);
						
						document.add(footReamrk);
						
						
						Paragraph LogoSpace = new Paragraph("",bold_fontEng);
						LogoSpace.setAlignment(Paragraph.ALIGN_CENTER);
						LogoSpace.setSpacingAfter(10f);
						LogoSpace.setSpacingBefore(10f);
						document.add(LogoSpace);
						
						PdfPTable tablelogo = new PdfPTable(3); //表格两列
						if(l==4){
							float[] wid1 ={0.2f,0.25f,0.55f};
							tablelogo.setWidths(wid1);
						}else if(l==2||l==3){
							float[] wid1 ={0.2f,0.25f,0.55f};
							tablelogo.setWidths(wid1);
						}else if(l==1){
							float[] wid1 ={0.2f,0.25f,0.55f};
							tablelogo.setWidths(wid1);
						}
						tablelogo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
						tablelogo.setWidthPercentage(100);//表格的宽度为100%
			//			tablelogo.getDefaultCell().setBorderWidth(0); //不显示边框
						tablelogo.getDefaultCell().setBorderColor(Color.GRAY);
						
						
			
						
						
						PdfPCell Cell_logo2 = new PdfPCell(new Paragraph("")); //
						Cell_logo2.setBorder(0);
						Cell_logo2.setBorderColor(Color.GRAY);
						tablelogo.addCell(Cell_logo2);
						
						
						PdfPCell Cell_logo3 = new PdfPCell(new Paragraph("")); //
						Cell_logo3.setBorder(0);
						Cell_logo3.setBorderColor(Color.GRAY);
						tablelogo.addCell(Cell_logo3);
						
						
						PdfPTable tablelogo1 = new PdfPTable(2);
						float[] wid ={0.8f,0.2f};
						tablelogo1.setWidths(wid);
						tablelogo1.getDefaultCell().setBorderWidth(0);
						PdfPCell Cell_logo = new PdfPCell(tablelogo1);
						Cell_logo.setBorder(0);
						tablelogo.addCell(Cell_logo);
						
						PdfPCell Cell_logo1 = new PdfPCell(new Paragraph(" Thank you for choosing   ",norm_fontEng));
						Cell_logo1.setBorder(0);
						Cell_logo1.setVerticalAlignment(Element.ALIGN_MIDDLE);
						Cell_logo1.setHorizontalAlignment(Element.ALIGN_RIGHT);
						tablelogo1.addCell(Cell_logo1);
						
						
						PdfPCell logoCell=new PdfPCell();
						logoCell.addElement(jpeg);
						logoCell.setBorder(0);
						logoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
						tablelogo1.addCell(logoCell);
						
						document.add(tablelogo);
						
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
		//子单invoice
				@Override
				public String createInvoicePdfForVender(String orderId) {
					Order order = orderMapper.findById(orderId);
					String orderNumber = order.getOrderNo();
					//获取该子订单对应的总订单
					OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
					
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orderId);
					GroupLine groupLine = groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
							String addressForDept = "";
						    String telForDept = "";
						    String mailForDept = "";
						    Admin agen = adminService.findById(ordersTotal.getUserId());
					    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
					    	addressForDept = deptForAgent.getAddress();
					    	telForDept = deptForAgent.getTel();
					    	mailForDept = deptForAgent.getEmail();
					    	
					    	
					    	
					    	String companyId = ordersTotal.getCompanyId();
					    	Vender vender = venderMapper.findById(companyId);
					Setting setting = SettingUtils.get();
					String uploadPath = setting.getTempPDFPath();
					String destPath = null;
					try {
						Map<String, Object> model = new HashMap<String, Object>();
						String path = FreemarkerUtils.process(uploadPath, model);
						destPath = path + "invoice-"+orderNumber+".pdf";
						File destFile = new File(servletContext.getRealPath(destPath));
						if (!destFile.getParentFile().exists()) {
							destFile.getParentFile().mkdirs();
						}
						
						// 创建一个Document对象
						Document document = new Document(PageSize.A4, 36, 36, 24, 36);
						try {
							// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
							
							PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
							String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
							BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
							Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
							BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
							Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
									Color.BLACK);
							
							Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
									Color.BLACK);
							
							//中文斜体(大号)
							Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
							//中文斜体(小号)
							Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
							
							document.open();
							// 添加抬头图片
							PdfPTable table1 = new PdfPTable(3); //表格两列
							table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							table1.setWidthPercentage(100);//表格的宽度为100%
							 //两列宽度的比例并设置logo
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
							
							if(logo.equals(Constant.LOGO_PATH[3])){
								float[] wid1 ={0.45f,0.25f,0.30f};
								table1.setWidths(wid1);
							}else if(logo.equals(Constant.LOGO_PATH[1])){
								float[] wid1 ={0.2f,0.40f,0.30f};
								table1.setWidths(wid1);
							}else if(logo.equals(Constant.LOGO_PATH[0])){
								float[] wid1 ={0.25f,0.45f,0.30f};
								table1.setWidths(wid1);
							}else if(logo.equals(Constant.LOGO_PATH[2])){
								float[] wid1 ={0.45f,0.25f,0.30f};
								table1.setWidths(wid1);
							}
							 
							table1.getDefaultCell().setBorderWidth(0); //不显示边框
							PdfPTable table11 = new PdfPTable(1);
							table11.getDefaultCell().setBorder(0);
							Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
							jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居左
							jpeg.setAlignment(Image.ALIGN_TOP);
							jpeg.setBorder(0);
							table11.addCell(jpeg);
							table11.getDefaultCell().setBorderWidth(0);
							PdfPCell cell0 = new PdfPCell(table11);
							cell0.setBorder(0);
							table11.setWidthPercentage(60);
							table1.addCell(cell0);
							cell0.setBorder(0);
							PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
							cell1.setBorder(Rectangle.NO_BORDER);
							table1.addCell(cell1);
							
							PdfPTable table13 = new PdfPTable(1);
							table13.getDefaultCell().setBorderWidth(0);
							PdfPCell cell2 = new PdfPCell(table13);
							cell2.setBorder(0);
							table1.addCell(cell2);
							
							PdfPCell cell21 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell21.setBorder(0);
							cell21.setMinimumHeight(10f);
							table13.addCell(cell21);
							
							PdfPCell cell24 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell24.setBorder(0);
							cell24.setMinimumHeight(10f);
							table13.addCell(cell24);
							
							PdfPCell cell25 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell25.setBorder(0);
							cell25.setMinimumHeight(10f);
							table13.addCell(cell25);
							
							PdfPCell cell26 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell26.setBorder(0);
							cell26.setMinimumHeight(10f);
							table13.addCell(cell26);
							
							table1.addCell(cell1);
							document.add(table1);
							
							PdfContentByte cb=writer.getDirectContent();
							cb.setLineWidth(0.3f);
							
							//显示order基础信息
							PdfPTable table3 = new PdfPTable(4); //表格两列
							table3.setSpacingBefore(10f);
							table3.setSpacingAfter(5f);
							table3.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							table3.setWidthPercentage(100);//表格的宽度为100%
							float[] wid2 ={0.15f,0.35f,0.15f,0.35f}; //两列宽度的比例
							table3.setWidths(wid2); 
							table3.getDefaultCell().setBorderWidth(0); //不显示边框
							
							PdfPCell cell011 = new PdfPCell(new Paragraph("Invoice No:      ",littleChineseFont));
							cell011.setMinimumHeight(10f);
							cell011.setBorder(0);
							cell011.setBorderWidthTop(0.3f);
							cell011.setBorderColor(Color.GRAY);
							table3.addCell(cell011);
							
							PdfPCell cell012 = new PdfPCell(new Paragraph(order.getOrderNo().substring(0, 10),littleChineseFont));
							cell012.setMinimumHeight(10f);
							cell012.setBorder(0);
							cell012.setBorderWidthTop(0.3f);
							cell012.setBorderColor(Color.GRAY);
							table3.addCell(cell012);					
							
							PdfPCell cell053 = new PdfPCell(new Paragraph("Departure Date:       ",littleChineseFont));
							cell053.setBorder(0);
							cell053.setBorderWidthTop(0.3f);
							cell053.setMinimumHeight(10f);
							table3.addCell(cell053);
							
							SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
							PdfPCell cell054 = new PdfPCell(new Paragraph(simpleDateFormat.format(tourInfoForOrder.getScheduleOfArriveTime()),littleChineseFont));
							cell054.setBorder(0);
							cell054.setMinimumHeight(10f);
							cell054.setBorderWidthTop(0.3f);
							table3.addCell(cell054);
							document.add(table3);
							
							//显示order基础信息
							PdfPTable orderInfornation = new PdfPTable(2); //表格两列
							orderInfornation.setSpacingBefore(10f);
							orderInfornation.setSpacingAfter(5f);
							orderInfornation.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							orderInfornation.setWidthPercentage(100);//表格的宽度为100%
							float[] wids ={0.5f,0.5f}; //两列宽度的比例
							orderInfornation.setWidths(wids); 
							orderInfornation.getDefaultCell().setBorderWidth(0); //不显示边框
							
							PdfPCell orderLeft1 = new PdfPCell(new Paragraph("Billing Infomation",littleChineseFont));
							orderLeft1.setMinimumHeight(10f);
							orderLeft1.setBorder(0);					
							orderLeft1.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderLeft1);
							OrdersTotal ot = ordersTotalMapper.findById(order.getOrdersTotalId());
							PdfPCell orderright1 = new PdfPCell(new Paragraph("Order Summary",littleChineseFont));
							orderright1.setMinimumHeight(10f);
							orderright1.setBorder(0);
							orderright1.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderright1);
							
							PdfPCell orderLeft2 = new PdfPCell(new Paragraph(ot.getContactName(),littleChineseFont));
							orderLeft2.setMinimumHeight(10f);
							orderLeft2.setBorder(0);
							orderLeft2.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderLeft2);
							
							ReceivableInfoOfOrder receivable = receivableInfoOfOrderMapper.findByOrderId(order.getId());
							double cost=receivable.getTotalFeeOfOthers().doubleValue()+order.getPeerUserRate().doubleValue();
							PdfPCell orderright2 = new PdfPCell(new Paragraph("Cost:"+cost,littleChineseFont));
							orderright2.setMinimumHeight(10f);
							orderright2.setBorder(0);
							orderright1.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderright2);
							
							PdfPCell orderLeft3 = new PdfPCell(new Paragraph(ot.getPostCode(),littleChineseFont));
							orderLeft3.setMinimumHeight(10f);
							orderLeft3.setBorder(0);
							orderLeft3.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderLeft3);
							
							Discount discount = discountMapper.findByOrderId(order.getId());
							BigDecimal dis = new BigDecimal(0.00);
							if(discount!=null&&discount.getDiscountPrice()!=null){
								dis = discount.getDiscountPrice();
							}
							PdfPCell orderright3 = new PdfPCell(new Paragraph("Discount:"+dis,littleChineseFont));
							orderright3.setMinimumHeight(10f);
							orderright3.setBorder(0);
							orderright3.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderright3);
							
							PdfPCell orderLeft4 = new PdfPCell(new Paragraph(ot.getTel(),littleChineseFont));
							orderLeft4.setMinimumHeight(10f);
							orderLeft4.setBorder(0);
							orderLeft4.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderLeft4);
							double total=cost-dis.doubleValue();
							PdfPCell orderright4 = new PdfPCell(new Paragraph("Order Total:"+total,littleChineseFont));
							orderright4.setMinimumHeight(10f);
							orderright4.setBorder(0);
							orderright4.setBorderColor(Color.GRAY);
							orderInfornation.addCell(orderright4);
							document.add(orderInfornation);
							
							//产品信息
							PdfPTable productionInfo = new PdfPTable(4);
							float[] wid6 ={0.2f,0.4f,0.4f,0.2f};
							productionInfo.setWidths(wid6);
							productionInfo.setWidthPercentage(100);
							productionInfo.getDefaultCell().setBorderWidthBottom(0);
							
							PdfPCell productionInfoHead = new PdfPCell();
							productionInfoHead.setBorder(0);
							productionInfoHead.setBorderColorBottom(Color.GRAY);
							productionInfoHead.setBorderWidthBottom(0.3f);
							productionInfoHead.setBorderWidthTop(1.5f);
							productionInfoHead.setMinimumHeight(30f);
							productionInfoHead.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							productionInfoHead.setMinimumHeight(20f);
							productionInfoHead.setBorderWidth(0.5f);
							productionInfoHead.setPhrase(new Phrase("#",bold_fontEngForTableHead));
							productionInfo.addCell(productionInfoHead);
							productionInfoHead.setPhrase(new Phrase("Product",bold_fontEngForTableHead));
							productionInfo.addCell(productionInfoHead);
							productionInfoHead.setPhrase(new Phrase("Persons",bold_fontEngForTableHead));
							productionInfo.addCell(productionInfoHead);
							productionInfoHead.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
							productionInfo.addCell(productionInfoHead);
							PdfPCell productNo = new PdfPCell();
							productNo.setBorder(0);
							productNo.setMinimumHeight(20f);
							productNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							productNo.addElement(new Phrase(Integer.toString(1),chineseFont));
							productionInfo.addCell(productNo);
							
							PdfPCell productName = new PdfPCell();
							productName.setBorder(0);
							productName.setMinimumHeight(20f);
							productName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							productName.addElement(new Phrase(tourInfoForOrder.getLineName(),chineseFont));
							productionInfo.addCell(productName);
							
							PdfPCell sumPeople = new PdfPCell();
							sumPeople.setBorder(0);
							sumPeople.setMinimumHeight(20f);
							sumPeople.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							sumPeople.addElement(new Phrase(Integer.toString(order.getTotalPeople()),chineseFont));
							productionInfo.addCell(sumPeople);
							
							
							PdfPCell totalPrice = new PdfPCell();
							totalPrice.setBorder(0);
							totalPrice.setMinimumHeight(20f);
							totalPrice.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String tt="";
							tt=tt+total;
							totalPrice.addElement(new Phrase(tt,chineseFont));
							productionInfo.addCell(totalPrice);
							
							document.add(productionInfo);
							//客人信息
							List<Customer> customersForToatl = new ArrayList<Customer>();
							List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerByOrderId(orderId);
							for(CustomerOrderRel customerOrderRel:customerOrderRelList){
								if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
									Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
									customersForToatl.add(customer);
								}
							}
						
						
						Paragraph cus = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
						cus.setAlignment(Paragraph.ALIGN_CENTER);
						cus.setSpacingAfter(10f);
						cus.setSpacingBefore(10f);
						document.add(cus);
						
						PdfPTable cusData = new PdfPTable(4);
						float[] wid5 ={0.1f,0.4f,0.3f,0.20f};
						cusData.setWidths(wid5);
						cusData.setWidthPercentage(100);
						cusData.getDefaultCell().setBorderWidthBottom(0);
						
						PdfPCell tableHeaderForCus = new PdfPCell();
						tableHeaderForCus.setBorder(0);
						tableHeaderForCus.setBorderColorBottom(Color.GRAY);
						tableHeaderForCus.setBorderWidthBottom(0.3f);
						tableHeaderForCus.setBorderWidthTop(1.5f);
						tableHeaderForCus.setMinimumHeight(30f);
						tableHeaderForCus.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						tableHeaderForCus.setMinimumHeight(20f);
						tableHeaderForCus.setBorderWidth(0.5f);
						tableHeaderForCus.setPhrase(new Phrase("#",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						tableHeaderForCus.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						tableHeaderForCus.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						tableHeaderForCus.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
						cusData.addCell(tableHeaderForCus);
						if(customersForToatl!=null){
						for(int i=0;i<customersForToatl.size();i++){
							PdfPCell cusNo = new PdfPCell();
							cusNo.setBorder(0);
							cusNo.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusNo.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusNo.setMinimumHeight(20f);
							cusNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							cusNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
							cusData.addCell(cusNo);
							
							PdfPCell cusName = new PdfPCell();
							cusName.setBorder(0);
							cusName.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusName.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusName.setMinimumHeight(20f);
							cusName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName(),chineseFont));
							cusData.addCell(cusName);
							
							PdfPCell cusGender = new PdfPCell();
							cusGender.setBorder(0);
							cusGender.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusGender.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusGender.setMinimumHeight(20f);
							cusGender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String sexForString = "";
							if(customersForToatl.get(i).getSex()==1){
								sexForString = "FEMALE";
							}else if(customersForToatl.get(i).getSex()==2){
								sexForString = "MALE";
							}
							cusGender.addElement(new Phrase(sexForString,chineseFont));
							cusData.addCell(cusGender);
							
							PdfPCell cusNationality = new PdfPCell();
							cusNationality.setBorder(0);
							cusNationality.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
							cusNationality.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
							cusNationality.setMinimumHeight(20f);
							cusNationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String countryName = "";
							if(customersForToatl.get(i)!=null){
									countryName = customersForToatl.get(i).getNationalityOfPassport();
							}
							cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName,chineseFont));
							cusData.addCell(cusNationality);
							
						}
						}
						document.add(cusData);
							//添加payment
							Payment pay = new Payment();
							pay.setOrderId(orderId);
							List<Payment> payList = paymentMapper.find(pay);
							Paragraph payment = new Paragraph("PAYMENT HISTORY",bold_fontEng);
							payment.setAlignment(Paragraph.ALIGN_CENTER);
							payment.setSpacingAfter(10f);
							payment.setSpacingBefore(10f);
							document.add(payment);
							
							PdfPTable paymentData = new PdfPTable(5);
							float[] wid3 ={0.1f,0.2f,0.3f,0.3f,0.10f};
							paymentData.setWidths(wid3);
							paymentData.setWidthPercentage(100);
							paymentData.getDefaultCell().setBorderWidthBottom(0);
							
							PdfPCell tableHeader = new PdfPCell();
							tableHeader.setBorder(0);
							tableHeader.setBorderColorBottom(Color.GRAY);
							tableHeader.setBorderWidthBottom(0.3f);
							tableHeader.setBorderWidthTop(1.5f);
							tableHeader.setMinimumHeight(30f);
							tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							tableHeader.setMinimumHeight(20f);
							tableHeader.setBorderWidth(0.5f);
							tableHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
							paymentData.addCell(tableHeader);
							tableHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
							paymentData.addCell(tableHeader);
							tableHeader.setPhrase(new Phrase("PayType",bold_fontEngForTableHead));
							paymentData.addCell(tableHeader);
							tableHeader.setPhrase(new Phrase("PayInfo",bold_fontEngForTableHead));
							paymentData.addCell(tableHeader);
							tableHeader.setPhrase(new Phrase("Payment",bold_fontEngForTableHead));
							paymentData.addCell(tableHeader);				
												
							if(payList!=null&&payList.size()!=0){
									for(int i=0;i<payList.size();i++){
			 								PdfPCell payNo = new PdfPCell();
											payNo.setBorder(0);
											payNo.setBorderColor(i==payList.size()-1?Color.BLACK:Color.GRAY);
											payNo.setBorderWidthBottom(i==payList.size()-1?1.5f:0.3f);
											payNo.setMinimumHeight(20f);
											payNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											payNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
											paymentData.addCell(payNo);
											
											PdfPCell date = new PdfPCell();
											date.setBorder(0);
											date.setBorderColor(i==payList.size()-1?Color.BLACK:Color.GRAY);
											date.setBorderWidthBottom(i==payList.size()-1?1.5f:0.3f);
											date.setMinimumHeight(20f);
											date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											date.addElement(new Phrase(payList.get(i).getCreateDate()==null?"":simpleDateFormat.format(payList.get(i).getCreateDate()),chineseFont));
											paymentData.addCell(date);
											
											PdfPCell description = new PdfPCell();
											description.setBorder(0);
											description.setBorderColor(i==payList.size()-1?Color.BLACK:Color.GRAY);
											description.setBorderWidthBottom(i==payList.size()-1?1.5f:0.3f);
											description.setMinimumHeight(20f);
											description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											description.addElement(new Phrase(payList.get(i).getPayType(),chineseFont));
											paymentData.addCell(description);
											
											PdfPCell remark = new PdfPCell();
											remark.setBorder(0);
											remark.setBorderColor(i==payList.size()-1?Color.BLACK:Color.GRAY);
											remark.setBorderWidthBottom(i==payList.size()-1?1.5f:0.3f);
											remark.setMinimumHeight(20f);
											remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											remark.addElement(new Phrase(payList.get(i).getPayInfo(),chineseFont));
											paymentData.addCell(remark);
											
											PdfPCell amount = new PdfPCell();
											amount.setBorder(0);
											amount.setBorderColor(i==payList.size()-1?Color.BLACK:Color.GRAY);
											amount.setBorderWidthBottom(i==payList.size()-1?1.5f:0.3f);
											amount.setMinimumHeight(20f);
											amount.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											amount.addElement(new Phrase(payList.get(i).getPayment().toString(),chineseFont));
											paymentData.addCell(amount);
								}
							}
							document.add(paymentData);									
								
							//添加notice信息
								if(tourInfoForOrder.getSpecialRequirements()!=null){
									Paragraph account = new Paragraph("NOTICE INFORMATION",bold_fontEngForTableHead);
									account.setSpacingBefore(15f);
									document.add(account);
									Paragraph accountContent = new Paragraph(tourInfoForOrder.getSpecialRequirements(),littleChineseFont);
									document.add(accountContent);
								}
								
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
				//子单invoice(修订版本，原版未覆盖)
				//retail
				@Override
				public String CreateInvoicePdfForRevise(String orderId,Order order,OrdersTotal ordersTotal) {
//					Order order = orderMapper.findById(orderId);
					String orderNumber = order.getOrderNo();
					//获取该子订单对应的总订单
//					OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
					
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orderId);
					GroupLine groupLine;
					if(tourInfoForOrder!=null&&tourInfoForOrder.getGroupLineId()!=""){
						groupLine = groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
					}else{
						//非团设置intertrips的logo
						 groupLine=new GroupLine();
						groupLine.setBrand("文景假期");
					}
					
					//String brand = groupLine.getBrand();
				
					//获取该总订单下的所有子订单
					//List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
					
					//标头显示的信息
					//无论是否为同行右上方都显示本部门信息
					//如果为同行，则基础信息显示billTo为同行公司名称，agent为联系人信息，加上同行公司的地址，邮箱，电话
							//本部门信息
							String addressForDept = "";
						    String telForDept = "";
						    String mailForDept = "";
						    String InvoiceRemarks="";
						    String cityAndState="";
						    String Company="";
						      String venderId = ordersTotal.getCompanyId();
						      Vender vender = null;
						      if(venderId!=null&&venderId.length()!=0){
						        vender = venderMapper.findById(venderId);
						      }
					          if(ordersTotal.getWr().equals("wholeSale")){
					              if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
					            	  cityAndState=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
					                Company=vender.getName();
					              }else{
					            	  Company="";
					              }
					            }
						    Admin agen = adminService.findById(ordersTotal.getUserId());
					    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
					    	addressForDept = deptForAgent.getAddress();
					    	InvoiceRemarks=tourInfoForOrder.getInvoiceRemarks();
					    	if(InvoiceRemarks==null){
					    		InvoiceRemarks="";
					    	}
					    	telForDept = deptForAgent.getTel();
					    	if(agen.getEmail().equals("")){
					    		mailForDept = deptForAgent.getEmail();
					    	}else{
					    		mailForDept = agen.getEmail();
					    	}
				            String bookingDate="";
				            SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
				              if(order!=null&&order.getCreateDate()!=null){
				                bookingDate=df1.format(order.getCreateDate());
				            }
							String arriveDate = "";
							if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
								arriveDate=df1.format(tourInfoForOrder.getScheduleOfArriveTime());
							}
					Setting setting = SettingUtils.get();
					String uploadPath = setting.getTempPDFPath();
					String destPath = null;
					try {
						Map<String, Object> model = new HashMap<String, Object>();
						String path = FreemarkerUtils.process(uploadPath, model);
						destPath = path + "invoice-"+orderNumber+".pdf";
						File destFile = new File(servletContext.getRealPath(destPath));
						if (!destFile.getParentFile().exists()) {
							destFile.getParentFile().mkdirs();
						}
						
						// 创建一个Document对象
						Document document = new Document(PageSize.A4, 36, 36, 24, 36);
						try {
							// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
							
							PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
							String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
							BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
							Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
							BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
							Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
									Color.BLACK);
							
							Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
									Color.BLACK);
							//中文超大号
							Font  chineseFontBig = new Font(bfChinese, 12,  Font.BOLD,Color.BLACK);
							//中文斜体(大号)
							Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
							//中文斜体(小号)
							Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
							
							document.open();
							
						/*     Invoice 顶部的地址栏信息和Logo开始           */
							
							PdfPTable tableTitleSpace = new PdfPTable(3); //表格两列
							tableTitleSpace.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							tableTitleSpace.setWidthPercentage(100);//表格的宽度为100%
							float[] wid11 ={0.45f,0.25f,0.30f};
							tableTitleSpace.setWidths(wid11);
							
							
							PdfPCell cell21_11 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell21_11.setBorder(0);
							cell21_11.setPaddingBottom(30f);
							cell21_11.setMinimumHeight(10f);
							tableTitleSpace.addCell(cell21_11);
							
							PdfPCell cell21_21 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell21_21.setBorder(0);
							cell21_21.setPaddingBottom(30f);
							cell21_21.setMinimumHeight(10f);
							tableTitleSpace.addCell(cell21_21);
							
							PdfPCell cell261 = new PdfPCell(new Paragraph("",littleChineseFont));
							cell261.setBorder(0);
							cell261.setMinimumHeight(10f);
							cell261.setPaddingBottom(30f);
							tableTitleSpace.addCell(cell261);
							
							document.add(tableTitleSpace);
							
						/*     Invoice 顶部的地址栏信息和Logo开始           */
							
							PdfPTable table1 = new PdfPTable(4); //表格两列
							table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							table1.setWidthPercentage(100);//表格的宽度为100%
							 //两列宽度的比例并设置logo
							String logo = "";
							int l;
							if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
								logo = Constant.LOGO_PATH[0];
								l=1;
							}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
								logo = Constant.LOGO_PATH[1];
								l=2;
							}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
								logo = Constant.LOGO_PATH[2];
								l=3;
							}else{
								logo = Constant.LOGO_PATH[3];
								l=4;
								
							}
							
							if(order.getDeptId().equals(Constant.VANCOUVER)){
								logo = Constant.LOGO_PATH[5];
							}
							
							if(logo.equals(Constant.LOGO_PATH[3])||logo.equals(Constant.LOGO_PATH[2]) ||logo.equals(Constant.LOGO_PATH[5])){
								float[] wid1 ={0.03f,0.27f,0.3f,0.4f};
								table1.setWidths(wid1);
							}else if(logo.equals(Constant.LOGO_PATH[1])){
								float[] wid1 ={0.03f,0.27f,0.40f,0.2f};
								table1.setWidths(wid1);
							}else if(logo.equals(Constant.LOGO_PATH[1])){
								float[] wid1 ={0.03f,0.27f,0.40f,0.2f};
								table1.setWidths(wid1);
							}else if(logo.equals(Constant.LOGO_PATH[0])){
								float[] wid1 ={0.03f,0.27f,0.35f,0.35f};
								table1.setWidths(wid1);
							}
							
							PdfPCell cell21Space = new PdfPCell(new Paragraph("",littleChineseFont));
							cell21Space.setBorder(0);
							cell21Space.setMinimumHeight(10f);
							table1.addCell(cell21Space);
							/**/
							PdfPTable table13 = new PdfPTable(1);
							table13.getDefaultCell().setBorderWidth(0);
							PdfPCell cell2 = new PdfPCell(table13);
							cell2.setBorder(0);
							cell2.setPaddingBottom(5f);
							table1.addCell(cell2);
							
							//Logo文字标识
							String logoInDentifying="";
							if(logo.equals(Constant.LOGO_PATH[0])){
								logoInDentifying="中国美";
							}else if(logo.equals(Constant.LOGO_PATH[1])){
								logoInDentifying="Chinatour.com";
							}else if(logo.equals(Constant.LOGO_PATH[2])){
								logoInDentifying="Intertrips";
							}else{
								logoInDentifying="文景假期";
							}
							PdfPCell cellHead = new PdfPCell(new Paragraph(logoInDentifying,chineseFontBig));
							cellHead.setBorder(0);
							cellHead.setMinimumHeight(10f);
							table13.addCell(cellHead);
							
							PdfPCell cell20 = new PdfPCell(new Paragraph("Agent Name:"+agen.getUsername(),littleChineseFont));
							cell20.setBorder(0);
							cell20.setMinimumHeight(10f);
							table13.addCell(cell20);
							
							PdfPCell cell21 = new PdfPCell(new Paragraph("Address:"+agen.getAddress(),littleChineseFont));
							cell21.setBorder(0);
							cell21.setMinimumHeight(10f);
							table13.addCell(cell21);
							
							PdfPCell cell21_1 = new PdfPCell(new Paragraph("Tel:"+agen.getTel(),littleChineseFont));
							cell21_1.setBorder(0);
							cell21_1.setMinimumHeight(10f);
							table13.addCell(cell21_1);
							
							PdfPCell cell21_2 = new PdfPCell(new Paragraph("Fax:"+agen.getFax(),littleChineseFont));
							cell21_2.setBorder(0);
							cell21_2.setMinimumHeight(10f);
							table13.addCell(cell21_2);
							
							PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailForDept,littleChineseFont));
							cell26.setBorder(0);
							cell26.setMinimumHeight(10f);
							table13.addCell(cell26);
							
							if(order.getDeptId().equals(Constant.VANCOUVER)){
								PdfPCell cell27 = new PdfPCell(new Paragraph("LICENSE:"+Constant.VANCOUVER_LICENSE,littleChineseFont));
								cell27.setBorder(0);
								cell27.setMinimumHeight(10f);
								table13.addCell(cell27);
							}
							
							PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
							cell1.setBorder(0);
							table1.addCell(cell1);
							
							table1.getDefaultCell().setBorderWidth(0); //不显示边框
							PdfPTable table11 = new PdfPTable(1);
							table11.getDefaultCell().setBorder(0);
							Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
							jpeg.setAlignment(Image.ALIGN_RIGHT);
							jpeg.setAlignment(Image.ALIGN_MIDDLE);
							jpeg.setBorder(0);
							table11.addCell(jpeg);
							table11.getDefaultCell().setBorderWidth(0);
							PdfPCell cell0 = new PdfPCell(table11);
							cell0.setBorder(0);
							cell0.setBorderColor(Color.GRAY);
							cell0.setBorderWidthBottom(0f);
							cell0.setPaddingBottom(15f);
							table11.setWidthPercentage(60);
							table1.addCell(cell0);
							cell0.setBorder(0);
							
							document.add(table1);
						/*     Invoice 顶部的地址栏信息和Logo结束           */
							PdfContentByte cb=writer.getDirectContent();
							cb.setLineWidth(0.3f);
							
							
							/*BILL TO信息添加*/
							PdfPTable tabalOrder_2 = new PdfPTable(3);
							float[] widOrder4 ={0.03f,0.49f,0.48f};
							tabalOrder_2.setWidths(widOrder4);
							tabalOrder_2.setWidthPercentage(100);
							tabalOrder_2.getDefaultCell().setBorderWidthTop(0);
							tabalOrder_2.setSpacingBefore(10f);
							
							
							PdfPCell tableOrderCell = new PdfPCell();
							tableOrderCell.setBorder(0);
							tableOrderCell.setBorderWidthTop(0.3f);
							tableOrderCell.setPaddingTop(20f);
							tableOrderCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							tableOrderCell.setPhrase(new Phrase("",bold_fontEng));
							tabalOrder_2.addCell(tableOrderCell);
							tableOrderCell.setPhrase(new Phrase("BILL TO",bold_fontEng));
							tabalOrder_2.addCell(tableOrderCell);
							tableOrderCell.setPhrase(new Phrase("Invoice No:"+order.getOrderNo(),norm_fontEng));
							tabalOrder_2.addCell(tableOrderCell);
							
							PdfPCell orderItemsSpace = new PdfPCell(new Paragraph("",norm_fontEng));
							orderItemsSpace.setBorder(0);
							orderItemsSpace.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItemsSpace);
							
							PdfPCell orderItems_2 = new PdfPCell(new Paragraph("Company:"+Company,norm_fontEng));
							orderItems_2.setBorder(0);
							orderItems_2.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItems_2);
							
							PdfPCell orderItems_1 = new PdfPCell(new Paragraph("Tour Code:"+order.getTourCode(),norm_fontEng));
							orderItems_1.setBorder(0);
							orderItems_1.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItems_1);
							
							PdfPCell orderItemsSpace1 = new PdfPCell(new Paragraph("",norm_fontEng));
							orderItemsSpace1.setBorder(0);
							orderItemsSpace1.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItemsSpace1);
							
							PdfPCell orderItems_0 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
							orderItems_0.setBorder(0);
							orderItems_0.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItems_0);
							
							PdfPCell orderItems_3 = new PdfPCell(new Paragraph("Booking Date:"+bookingDate,norm_fontEng));
							orderItems_3.setBorder(0);
							orderItems_3.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItems_3);
							
							PdfPCell orderItemsSpace2 = new PdfPCell(new Paragraph("",norm_fontEng));
							orderItemsSpace2.setBorder(0);
							orderItemsSpace2.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItemsSpace2);
							
							PdfPCell tabalCell_2_2 = new PdfPCell(new Paragraph("Address:"+ordersTotal.getAddress()+" "+cityAndState,norm_fontEng));
							tabalCell_2_2.setBorder(0);
							tabalCell_2_2.setMinimumHeight(10f);
							tabalOrder_2.addCell(tabalCell_2_2);
							
							PdfPCell tabalCell_space = new PdfPCell(new Paragraph("Arrival Date:"+arriveDate,norm_fontEng));
							tabalCell_space.setBorder(0);
							tabalCell_space.setMinimumHeight(10f);
							tabalOrder_2.addCell(tabalCell_space);
							
//							if(cityAndState!=""){
//								
//								PdfPCell orderItemsSpace5 = new PdfPCell(new Paragraph("",norm_fontEng));
//								orderItemsSpace5.setBorder(0);
//								orderItemsSpace5.setMinimumHeight(10f);
//								tabalOrder_2.addCell(orderItemsSpace5);
//								
//								PdfPCell tabalCellState = new PdfPCell(new Paragraph(cityAndState,norm_fontEng));
//								tabalCellState.setBorder(0);
//								tabalCellState.setMinimumHeight(10f);
//								tabalOrder_2.addCell(tabalCellState);
//								
//								PdfPCell tabalCell_space6 = new PdfPCell(new Paragraph("",norm_fontEng));
//								tabalCell_space6.setBorder(0);
//								tabalCell_space6.setMinimumHeight(10f);
//								tabalOrder_2.addCell(tabalCell_space6);
//							}
							
							PdfPCell orderItemsSpace3 = new PdfPCell(new Paragraph("",norm_fontEng));
							orderItemsSpace3.setBorder(0);
							orderItemsSpace3.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItemsSpace3);
							
							PdfPCell tabalCell_2_3 = new PdfPCell(new Paragraph("Phone:"+ordersTotal.getTel(),norm_fontEng));
							tabalCell_2_3.setBorder(0);
							tabalCell_2_3.setMinimumHeight(10f);
							tabalOrder_2.addCell(tabalCell_2_3);
							
							PdfPCell tabalCell_space2 = new PdfPCell(new Paragraph("",norm_fontEng));
							tabalCell_space2.setBorder(0);
							tabalCell_space2.setMinimumHeight(10f);
							tabalOrder_2.addCell(tabalCell_space2);
							
							PdfPCell orderItemsSpace4 = new PdfPCell(new Paragraph("",norm_fontEng));
							orderItemsSpace4.setBorder(0);
							orderItemsSpace4.setMinimumHeight(10f);
							tabalOrder_2.addCell(orderItemsSpace4);
							
							PdfPCell tabalCellEamil = new PdfPCell(new Paragraph("Email:"+ordersTotal.getEmail(),norm_fontEng));
							tabalCellEamil.setBorder(0);
							tabalCellEamil.setMinimumHeight(10f);
							tabalOrder_2.addCell(tabalCellEamil);
							
							PdfPCell tabalCell_space3 = new PdfPCell(new Paragraph("Departure city:"+tourInfoForOrder.getSpecialRequirements(),norm_fontEng));
							tabalCell_space3.setBorder(0);
							tabalCell_space3.setMinimumHeight(10f);
							tabalOrder_2.addCell(tabalCell_space3);
							
							
							document.add(tabalOrder_2);
							
							
							
							List<PayCostRecords> pRecords = new ArrayList<PayCostRecords>(); //存放所有的
							List<PayCostRecords> pay = payCostRecordsMapper.findByOrderId(order.getId());
							List<PayCostRecords> removePay = new ArrayList<PayCostRecords>();
							for(PayCostRecords payCostRecord:pay){
								if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
									removePay.add(payCostRecord);
								}
							}
							pay.removeAll(removePay);
							pRecords.addAll(pay);
						
							//用于存放客人名字信息
							List<String> pasData=new ArrayList<String>();
							
							BigDecimal totalFee = new BigDecimal(0);
							if(pRecords!=null||pRecords.size()!=0){
								for(int i=0;i<pRecords.size();i++){
										totalFee = totalFee.add(pRecords.get(i).getSum());
									}
							}
							PdfPTable itemsData = new PdfPTable(6);
							float[] wid4 ={0.03f,0.32f,0.17f,0.16f,0.16f,0.16f};
							itemsData.setWidths(wid4);
							itemsData.setWidthPercentage(100);
							itemsData.getDefaultCell().setBorderWidthBottom(0);
							
							PdfPCell tableHeaderForItem = new PdfPCell();
							tableHeaderForItem.setBorder(0);
							tableHeaderForItem.setBorderColorBottom(Color.GRAY);
							tableHeaderForItem.setBorderWidthTop(1.5f);
							tableHeaderForItem.setMinimumHeight(30f);
							tableHeaderForItem.setPaddingTop(15f);
							tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							tableHeaderForItem.setMinimumHeight(20f);
							tableHeaderForItem.setBorderWidth(0.5f);
							tableHeaderForItem.setPhrase(new Phrase("",bold_fontEngForTableHead));
							itemsData.addCell(tableHeaderForItem);	
							tableHeaderForItem.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
							itemsData.addCell(tableHeaderForItem);							
							tableHeaderForItem.setPhrase(new Phrase("",bold_fontEngForTableHead));
							itemsData.addCell(tableHeaderForItem);
							tableHeaderForItem.setPhrase(new Phrase("Price",bold_fontEngForTableHead));
							itemsData.addCell(tableHeaderForItem);
							tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
							itemsData.addCell(tableHeaderForItem);
							tableHeaderForItem.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
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
											if(orderReceiveItems.get(i).getItemFee()==null||orderReceiveItems.get(i).getItemFee().toString().length()==0||(orderReceiveItems.get(i).getItemFee().intValue()==0&&orderReceiveItems.get(i).getRemark()==null)||(orderReceiveItems.get(i).getItemFee().intValue()==0&&orderReceiveItems.get(i).getRemark()=="")){
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
											PdfPCell spaceForPrice = new PdfPCell();
											spaceForPrice.setBorder(0);
											spaceForPrice.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
											spaceForPrice.setBorderWidthBottom(i==orderReceiveItems.size()-1?0.3f:0f);
											spaceForPrice.setMinimumHeight(20f);
											spaceForPrice.setPaddingBottom(15f);
											spaceForPrice.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											spaceForPrice.addElement(new Phrase("",chineseFont));
											itemsData.addCell(spaceForPrice);
											
											PdfPCell description = new PdfPCell();
											description.setBorder(0);
											description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
											description.setBorderWidthBottom(i==orderReceiveItems.size()-1?0.3f:0f);
											description.setMinimumHeight(20f);
											description.setPaddingBottom(15f);
											description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											description.addElement(new Phrase(tourInfoForOrder.getLineName()+" / "+(orderReceiveItems.get(i).getRemark()==null?"":orderReceiveItems.get(i).getRemark()),chineseFont));
											itemsData.addCell(description);
											
											PdfPCell spaceForPrice1 = new PdfPCell();
											spaceForPrice1.setBorder(0);
											spaceForPrice1.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
											spaceForPrice1.setBorderWidthBottom(i==orderReceiveItems.size()-1?0.3f:0f);
											spaceForPrice1.setMinimumHeight(20f);
											spaceForPrice1.setPaddingBottom(5f);
											spaceForPrice1.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											spaceForPrice1.addElement(new Phrase("",chineseFont));
											itemsData.addCell(spaceForPrice1);
											
											PdfPCell price = new PdfPCell();
											price.setBorder(0);
											price.setPaddingBottom(15f);
											price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
											price.setBorderWidthBottom(i==orderReceiveItems.size()-1?0.3f:0f);
											price.setMinimumHeight(20f);
											price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											BigDecimal pri = orderReceiveItems.get(i).getItemFee();
											if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
												pri = new BigDecimal(0).subtract(pri);
											}
											price.addElement(new Phrase(pri.toString(),chineseFont));
											itemsData.addCell(price);
											
											PdfPCell num = new PdfPCell();
											num.setBorder(0);
											num.setPaddingBottom(15f);
											num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
											num.setBorderWidthBottom(i==orderReceiveItems.size()-1?0.3f:0f);
											num.setMinimumHeight(20f);
											num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString(),chineseFont));
											itemsData.addCell(num);
											
											PdfPCell totalFe = new PdfPCell();
											totalFe.setBorder(0);
											totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?0.3f:0f);
											totalFe.setPaddingBottom(15f);
											
											if(i==orderReceiveItems.size()-1){
												totalFe.setBorderColor(Color.BLACK);
												totalFe.setBorderWidthBottom(0.3f);
											}else{
												totalFe.setBorderColor(Color.GRAY);
												totalFe.setBorderWidthBottom(0f);
											}
											totalFe.setMinimumHeight(20f);
											totalFe.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
											BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
											if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
												itemFee = new BigDecimal(0).subtract(itemFee);
											}
											Integer mount = orderReceiveItems.get(i).getItemFeeNum();
											BigDecimal toMount = new BigDecimal(mount);
											totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString(),chineseFont));
											itemsData.addCell(totalFe);
											totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
												}
											
											}
								
							document.add(itemsData);
							
							PdfPTable subTotalData = new PdfPTable(3);
							float[] wid6 ={0.72f,0.18f,0.1f};
							subTotalData.setWidths(wid6);
							subTotalData.setWidthPercentage(100);
							//subTotalData.getDefaultCell().setBorderWidthBottom(0);
							subTotalData.getDefaultCell().setMinimumHeight(20f);
							
							PdfPCell sub1 = new PdfPCell();
							sub1.setBorder(0);
							sub1.addElement(new Phrase("",norm_fontEng));
							subTotalData.addCell(sub1);
							
							PdfPCell sub2 = new PdfPCell();
							sub2.setBorder(0);
							sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
							sub2.addElement(new Phrase("SubTotal:",bold_fontEngForTableHead));
							subTotalData.addCell(sub2);
							
							PdfPCell sub3 = new PdfPCell();
							sub3.setBorder(0);
							sub3.addElement(new Phrase(totalCostFee.toString(),bold_fontEngForTableHead));
							subTotalData.addCell(sub3);
							
							if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0){
								BigDecimal peerUserFee = new BigDecimal(0.00);
								if(order.getPeerUserFee()!=null){
									peerUserFee = order.getPeerUserFee();
								}
								PdfPCell userFee1 = new PdfPCell();
								userFee1.setBorder(0);
								userFee1.addElement(new Phrase("",norm_fontEng));
								subTotalData.addCell(userFee1);
								
								PdfPCell userFee2 = new PdfPCell();
								userFee2.setBorder(0);
								userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
								userFee2.addElement(new Phrase(" Commission:",bold_fontEngForTableHead));
								subTotalData.addCell(userFee2);
								
								PdfPCell userFee3 = new PdfPCell();
								userFee3.setBorder(0);
								userFee3.addElement(new Phrase(peerUserFee.toString(),bold_fontEngForTableHead));
								subTotalData.addCell(userFee3);
							}
							
							PdfPCell paid1 = new PdfPCell();
							paid1.setBorder(0);
							paid1.addElement(new Phrase("",bold_fontEngForTableHead));
							subTotalData.addCell(paid1);
							
							PdfPCell paid2 = new PdfPCell();
							paid2.setBorder(0);
							paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
							paid2.addElement(new Phrase("         Paid:",bold_fontEngForTableHead));
							subTotalData.addCell(paid2);
							
							
							PdfPCell paid3 = new PdfPCell();
							paid3.setBorder(0);
							paid3.addElement(new Phrase(totalFee.toString(),bold_fontEngForTableHead));
							subTotalData.addCell(paid3);
							
							PdfPCell balance1 = new PdfPCell();
							balance1.setBorder(0);
							balance1.addElement(new Phrase("",bold_fontEngForTableHead));
							subTotalData.addCell(balance1);
							
							PdfPCell balance2 = new PdfPCell();
							balance2.setBorder(0);
							balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
							balance2.addElement(new Phrase("   Balance:",bold_fontEngForTableHead));
							subTotalData.addCell(balance2);
							
							PdfPCell balance3 = new PdfPCell();
							balance3.setBorder(0);
							BigDecimal bal = totalCostFee.subtract(totalFee);
							if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0&&order.getPeerUserFee()!=null){
								bal = bal.subtract(order.getPeerUserFee());
							}
							balance3.addElement(new Phrase(bal.toString(),bold_fontEngForTableHead));
							subTotalData.addCell(balance3);
							
							BigDecimal rate = new BigDecimal(1.00);
								rate = order.getRate();
							
							
							PdfPCell tax1 = new PdfPCell();
							tax1.setBorder(0);
							tax1.addElement(new Phrase("",bold_fontEngForTableHead));
							subTotalData.addCell(tax1);
							
							PdfPCell tax2 = new PdfPCell();
							tax2.setBorder(0);
							tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
							tax2.addElement(new Phrase("Exchange Rate:",bold_fontEngForTableHead));
							subTotalData.addCell(tax2);
							
							PdfPCell tax3 = new PdfPCell();
							tax3.setBorder(0);
							tax3.addElement(new Phrase(rate.toString(),bold_fontEngForTableHead));
							subTotalData.addCell(tax3);
							
							PdfPCell toatl1 = new PdfPCell();
							toatl1.setBorder(0);
							toatl1.addElement(new Phrase("",bold_fontEngForTableHead));
							subTotalData.addCell(toatl1);
							
							PdfPCell toatl2 = new PdfPCell();
							toatl2.setBorder(0);
							toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
							toatl2.addElement(new Phrase("Total Blance:",bold_fontEngForTableHead));
							subTotalData.addCell(toatl2);
							
							PdfPCell toatl3 = new PdfPCell();
							toatl3.setBorder(0);
							toatl3.addElement(new Phrase(bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),bold_fontEngForTableHead));
							subTotalData.addCell(toatl3);
							//document.add(subTotalData);
							//客人信息
//									List<Customer> customersForToatl = new ArrayList<Customer>();
									List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerByOrderId(orderId);
									for(CustomerOrderRel customerOrderRel:customerOrderRelList){
										if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
//											Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
//											Customer customer = customerOrderRel.getCustomer();
//											customersForToatl.add(customer);
											pasData.add(customerOrderRel.getCustomer().getLastName()+"/"+customerOrderRel.getCustomer().getFirstName()+customerOrderRel.getCustomer().getMiddleName());
										}
									}
							
							
							Paragraph ReamrkTittle = new Paragraph("",bold_fontEng);
							ReamrkTittle.setAlignment(Paragraph.ALIGN_CENTER);
							ReamrkTittle.setSpacingAfter(5f);
							ReamrkTittle.setSpacingBefore(5f);
							document.add(ReamrkTittle);
							
							
							
							PdfPTable tabalReamrk = new PdfPTable(4); //表格两列
							float[] Reamrk ={0.03f,0.49f,0.16f,0.32f};
							tabalReamrk.setWidths(Reamrk);
							tabalReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							tabalReamrk.setWidthPercentage(100);//表格的宽度为100%
							tabalReamrk.getDefaultCell().setBorderWidthBottom(0f);
							tabalReamrk.getDefaultCell().setBorderColor(Color.GRAY);
							
							PdfPCell CellReamrkSpace = new PdfPCell(new Paragraph("")); //
							CellReamrkSpace.setBorder(0);
							CellReamrkSpace.setBorderWidthBottom(1.5f);
							CellReamrkSpace.setPaddingBottom(10f);
							tabalReamrk.addCell(CellReamrkSpace);
							
							PdfPTable tableItemFee = new PdfPTable(1);
							tableItemFee.getDefaultCell().setBorderWidth(0);
							PdfPCell CellItemFee = new PdfPCell(tableItemFee);
							CellItemFee.setBorder(0);
							tabalReamrk.addCell(CellItemFee);
							
							//添加客人名字信息
				             /* if(customersForToatl!=null){
				                  for(int i=0;i<customersForToatl.size();i++){
				                	pasData.add(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName());
				                  }
				               }*/
							
							StringBuffer sBuffer=new StringBuffer();
							for(int a=0;a<pasData.size();a++){
								if(a==0){
									sBuffer.append(pasData.get(a));
								}else{
									sBuffer.append(","+pasData.get(a));
								}
							}
							
							PdfPCell cellPas=new PdfPCell(new Paragraph("CUSTOMER INFO:\n    "+sBuffer,chineseFontBig));
							cellPas.setBorder(0);
							cellPas.setBorderWidthBottom(1.5f);
							cellPas.setPaddingBottom(10f);
							tableItemFee.addCell(cellPas);
							
							PdfPCell CellReamrk_3 = new PdfPCell(new Paragraph("")); //
							CellReamrk_3.setBorder(0);
							CellReamrk_3.setPaddingBottom(10f);
							CellReamrk_3.setBorderWidthBottom(1.5f);
							tabalReamrk.addCell(CellReamrk_3);
//							
//							PdfPCell billInfo = new PdfPCell(new Paragraph("")); //
//							billInfo.setBorder(0);
//							billInfo.setBorderColor(Color.GRAY);
//							tabalReamrk.addCell(billInfo);
							
							PdfPTable tableBill = new PdfPTable(1);
							tableBill.getDefaultCell().setBorderWidth(0);
							PdfPCell CellBill = new PdfPCell(tableBill);
							CellBill.setBorder(0);
							CellBill.setPaddingBottom(10f);
							CellBill.setBorderWidthBottom(1.5f);
							tabalReamrk.addCell(CellBill);
							
							PdfPCell Celltotal = new PdfPCell(new Paragraph("Total:                        "+totalCostFee.toString(),norm_fontEng));
							Celltotal.setBorder(0);
							Celltotal.setHorizontalAlignment(Element.ALIGN_LEFT);
							tableBill.addCell(Celltotal);
							
							if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0){
								BigDecimal peerUserFee = new BigDecimal(0.00);
								if(order.getPeerUserFee()!=null){
									peerUserFee = order.getPeerUserFee();
								}
								PdfPCell userFee1 = new PdfPCell();
								userFee1.setBorder(0);
								userFee1.addElement(new Phrase("",norm_fontEng));
								tableBill.addCell(userFee1);
								
								PdfPCell userFee2 = new PdfPCell();
								userFee2.setBorder(0);
								userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
								userFee2.addElement(new Phrase("Commission:            "+peerUserFee.toString(),norm_fontEng));
								tableBill.addCell(userFee2);
							}
							
							PdfPCell Cellpaid = new PdfPCell();
							Cellpaid.setBorder(0);
							Cellpaid.setHorizontalAlignment(Element.ALIGN_RIGHT);
							Cellpaid.addElement(new Phrase("Paid:                         "+totalFee.toString(),norm_fontEng));
							tableBill.addCell(Cellpaid);
							
							PdfPCell CellBalance_1 = new PdfPCell();
							CellBalance_1.setBorder(0);
							CellBalance_1.setHorizontalAlignment(Element.ALIGN_RIGHT);
							CellBalance_1.addElement(new Phrase("Balance:                  "+bal.toString(),bold_fontEngForTableHead));
							tableBill.addCell(CellBalance_1);
							document.add(tabalReamrk);
							
//							Paragraph ReamrkTitle = new Paragraph("INVOICE REMARK",bold_fontEng);
//							ReamrkTitle.setAlignment(Paragraph.ALIGN_CENTER);
//							ReamrkTitle.setSpacingAfter(10f);
//							ReamrkTitle.setSpacingBefore(5f);
//							document.add(ReamrkTitle);
							
//							PdfPTable tableReamrk = new PdfPTable(1); //表格两列
//							tableReamrk.setSpacingBefore(10f);
//							tableReamrk.setSpacingAfter(5f);
//							tableReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
//							tableReamrk.setWidthPercentage(100);//表格的宽度为100%
//							tableReamrk.getDefaultCell().setBorderWidth(0); //不显示边框
//							tableReamrk.getDefaultCell().setBorderColor(Color.GRAY);
//							
//
//							
//							PdfPCell CellReamrk_2 = new PdfPCell(new Paragraph("    INVOICE REMARK:"+InvoiceRemarks,bold_fontEng));
//							CellReamrk_2.setBorder(0);
//							CellReamrk_2.setBackgroundColor(Color.GRAY);
//							CellReamrk_2.setPaddingBottom(5f);
//							tableReamrk.addCell(CellReamrk_2);
//							document.add(tableReamrk);
							
							//加拿大添加
							if(order.getDeptId().equals(Constant.VANCOUVER)){
								//添加备注以及条款
								Paragraph payment1 = new Paragraph("",bold_fontEng);
								payment1.setAlignment(Paragraph.ALIGN_CENTER);
								payment1.setSpacingAfter(5f);
								payment1.setSpacingBefore(5f);
								document.add(payment1);
								
								Paragraph remark = new Paragraph("REMARKS",bold_fontEng);
								remark.setAlignment(Paragraph.ALIGN_LEFT);
								remark.setSpacingAfter(10f);
								remark.setSpacingBefore(10f);
								document.add(remark);
								
								PdfPTable paymentData1 = new PdfPTable(1);
								paymentData1.getDefaultCell().setMinimumHeight(20f);
								float[] wid33 ={1f};
								paymentData1.setWidths(wid33);
								paymentData1.setWidthPercentage(100);
								
								PdfPCell remarks = new PdfPCell();
								remarks.setBorder(0);
								remarks.setPaddingBottom(10f);
								remarks.setBorderWidthTop(1.5f);
								remarks.setBorderColor(Color.GRAY);
								remarks.addElement(new Phrase(""+Constant.VANCOUVER_TERMS[0],norm_fontEng));
								paymentData1.addCell(remarks);
								
								PdfPCell depositinfo = new PdfPCell();
								depositinfo.setBorder(0);
								depositinfo.setPaddingBottom(10f);
								depositinfo.addElement(new Phrase(""+Constant.VANCOUVER_TERMS[1],norm_fontEng));
								paymentData1.addCell(depositinfo);
								
								
								document.add(paymentData1);
								
								
							}
							
							
							PdfPTable footReamrk = new PdfPTable(1); //表格两列
							footReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							footReamrk.setWidthPercentage(100);//表格的宽度为100%
							footReamrk.getDefaultCell().setBorderWidth(0); //不显示边框
							footReamrk.getDefaultCell().setBorderColor(Color.GRAY);
							
							
							PdfPCell foot1 = new PdfPCell(new Paragraph("Please note that all travel documents will only be sent after you full balance has been received.",norm_fontEng));
							foot1.setBorder(0);
							foot1.setPaddingTop(5f);
							foot1.setMinimumHeight(1f);
							footReamrk.addCell(foot1);
							
							
							PdfPCell foot2 = new PdfPCell(new Paragraph("Please inspect this invoice carefully; our company will not be responsible for any errors after 2 business days.",norm_fontEng));
							foot2.setBorder(0);
							foot2.setMinimumHeight(1f);
							footReamrk.addCell(foot2);
							
							PdfPCell foot3 = new PdfPCell(new Paragraph("Please check our website for terms and conditions.",norm_fontEng));
							foot3.setBorder(0);
							foot3.setMinimumHeight(1f);
							footReamrk.addCell(foot3);
							
							document.add(footReamrk);
							
							
							Paragraph LogoSpace = new Paragraph("",bold_fontEng);
							LogoSpace.setAlignment(Paragraph.ALIGN_CENTER);
							LogoSpace.setSpacingAfter(10f);
							LogoSpace.setSpacingBefore(10f);
							document.add(LogoSpace);
							
							PdfPTable tablelogo = new PdfPTable(3); //表格两列
							if(l==4){
								float[] wid1 ={0.2f,0.25f,0.55f};
								tablelogo.setWidths(wid1);
							}else if(l==2||l==3){
								float[] wid1 ={0.2f,0.25f,0.55f};
								tablelogo.setWidths(wid1);
							}else if(l==1){
								float[] wid1 ={0.2f,0.25f,0.55f};
								tablelogo.setWidths(wid1);
							}
							tablelogo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							tablelogo.setWidthPercentage(100);//表格的宽度为100%
//							tablelogo.getDefaultCell().setBorderWidth(0); //不显示边框
							tablelogo.getDefaultCell().setBorderColor(Color.GRAY);
							
							

							
							
							PdfPCell Cell_logo2 = new PdfPCell(new Paragraph("")); //
							Cell_logo2.setBorder(0);
							Cell_logo2.setBorderColor(Color.GRAY);
							tablelogo.addCell(Cell_logo2);
							
							
							PdfPCell Cell_logo3 = new PdfPCell(new Paragraph("")); //
							Cell_logo3.setBorder(0);
							Cell_logo3.setBorderColor(Color.GRAY);
							tablelogo.addCell(Cell_logo3);
							
							
							PdfPTable tablelogo1 = new PdfPTable(2);
							float[] wid ={0.8f,0.2f};
							tablelogo1.setWidths(wid);
							tablelogo1.getDefaultCell().setBorderWidth(0);
							PdfPCell Cell_logo = new PdfPCell(tablelogo1);
							Cell_logo.setBorder(0);
							tablelogo.addCell(Cell_logo);
							
							PdfPCell Cell_logo1 = new PdfPCell(new Paragraph(" Thank you for choosing   ",norm_fontEng));
							Cell_logo1.setBorder(0);
							Cell_logo1.setVerticalAlignment(Element.ALIGN_MIDDLE);
							Cell_logo1.setHorizontalAlignment(Element.ALIGN_RIGHT);
							tablelogo1.addCell(Cell_logo1);
							
							
							PdfPCell logoCell=new PdfPCell();
							logoCell.addElement(jpeg);
							logoCell.setBorder(0);
							logoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
							tablelogo1.addCell(logoCell);
							
							document.add(tablelogo);

								
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
		//子单invoice(修订版本，原版未覆盖)
		//wholeSale
		@Override
		public String CreateInvoicePdfForReviseWholeSale(String orderId) {
			Order order = orderMapper.findById(orderId);
			String orderNumber = order.getOrderNo();
			//获取该子订单对应的总订单
			OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
			
			TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(orderId);
			GroupLine groupLine;
			if(tourInfoForOrder!=null&&tourInfoForOrder.getGroupLineId()!=""){
				groupLine = groupLineMapper.findById(tourInfoForOrder.getGroupLineId());
			}else{
				//非团设置intertrips的logo
				 groupLine=new GroupLine();
				groupLine.setBrand("文景假期");
			}
			//String brand = groupLine.getBrand();
		
			//获取该总订单下的所有子订单
			//List<Order> orders = orderMapper.findByTourIdForArr(ordersTotalId);
			
			//标头显示的信息
			//无论是否为同行右上方都显示本部门信息
			//如果为同行，则基础信息显示billTo为同行公司名称，agent为联系人信息，加上同行公司的地址，邮箱，电话
					//本部门信息
					String addressForDept = "";
				    String telForDept = "";
				    String mailForDept = "";
				    String InvoiceRemarks="";
				    String cityAndState="";
				    String Company="";
				      String venderId = ordersTotal.getCompanyId();
				      Vender vender = null;
				      if(venderId!=null&&venderId.length()!=0){
				        vender = venderMapper.findById(venderId);
				      }
			          if(ordersTotal.getWr().equals("wholeSale")){
			              if(ordersTotal.getCompanyId()!=null&&ordersTotal.getCompanyId().length()!=0){
			            	  cityAndState=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
			                Company=vender.getName();
			              }else{
			            	  Company="";
			              }
			            }
				    Admin agen = adminService.findById(ordersTotal.getUserId());
			    	Dept deptForAgent = deptMapper.findById(agen.getDeptId());
			    	addressForDept = deptForAgent.getAddress();
			    	InvoiceRemarks=tourInfoForOrder.getInvoiceRemarks();
			    	if(InvoiceRemarks==null){
			    		InvoiceRemarks="";
			    	}
			    	telForDept = deptForAgent.getTel();
			    	if(agen.getEmail().equals("")){
			    		mailForDept = deptForAgent.getEmail();
			    	}else{
			    		mailForDept = agen.getEmail();
			    	}
		            String bookingDate="";
		            SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
		              if(order!=null&&order.getCreateDate()!=null){
		                bookingDate=df1.format(order.getCreateDate());
		            }
					String arriveDate = "";
					if(tourInfoForOrder!=null&&tourInfoForOrder.getScheduleOfArriveTime()!=null){
						arriveDate=df1.format(tourInfoForOrder.getScheduleOfArriveTime());
					}
			Setting setting = SettingUtils.get();
			String uploadPath = setting.getTempPDFPath();
			String destPath = null;
			try {
				Map<String, Object> model = new HashMap<String, Object>();
				String path = FreemarkerUtils.process(uploadPath, model);
				destPath = path + "invoice-"+orderNumber+".pdf";
				File destFile = new File(servletContext.getRealPath(destPath));
				if (!destFile.getParentFile().exists()) {
					destFile.getParentFile().mkdirs();
				}
				
				// 创建一个Document对象
				Document document = new Document(PageSize.A4, 36, 36, 24, 36);
				try {
					// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档
					
					PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
					String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
					BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
					Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
					BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
					Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
							Color.BLACK);
					
					Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
							Color.BLACK);
					//中文超大号
					Font  chineseFontBig = new Font(bfChinese, 12,  Font.BOLD,Color.BLACK);
					//中文斜体(大号)
					Font  chineseFont = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
					//中文斜体(小号)
					Font  littleChineseFont = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
					
					document.open();
					
				/*     Invoice 顶部的地址栏信息和Logo开始           */
					
					PdfPTable tableTitleSpace = new PdfPTable(3); //表格两列
					tableTitleSpace.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					tableTitleSpace.setWidthPercentage(100);//表格的宽度为100%
					float[] wid11 ={0.45f,0.25f,0.30f};
					tableTitleSpace.setWidths(wid11);
					
					
					PdfPCell cell21_11 = new PdfPCell(new Paragraph("",chineseFontBig));
					cell21_11.setBorder(0);
					cell21_11.setPaddingBottom(10f);
					cell21_11.setMinimumHeight(10f);
					tableTitleSpace.addCell(cell21_11);
					
					PdfPCell cell21_21 = new PdfPCell(new Paragraph("",littleChineseFont));
					cell21_21.setBorder(0);
					cell21_21.setPaddingBottom(10f);
					cell21_21.setMinimumHeight(10f);
					tableTitleSpace.addCell(cell21_21);
					
					PdfPCell cell261 = new PdfPCell(new Paragraph("",littleChineseFont));
					cell261.setBorder(0);
					cell261.setMinimumHeight(10f);
					cell261.setPaddingBottom(10f);
					tableTitleSpace.addCell(cell261);
					
					document.add(tableTitleSpace);
					
				/*     Invoice 顶部的地址栏信息和Logo开始           */
					
					PdfPTable table1 = new PdfPTable(3); //表格两列
					table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					table1.setWidthPercentage(100);//表格的宽度为100%
					 //两列宽度的比例并设置logo
					String logo = "";
					int l;
					if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
						logo = Constant.LOGO_PATH[0];
						l=1;
					}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
						logo = Constant.LOGO_PATH[1];
						l=2;
					}else if(groupLine!=null&&groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
						logo = Constant.LOGO_PATH[2];
						l=3;
					}else{
						logo = Constant.LOGO_PATH[3];
						l=4;
						
					}
					
					if(order.getDeptId().equals(Constant.VANCOUVER)){
						logo = Constant.LOGO_PATH[5];
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
					}else{
						float[] wid1 ={0.5f,0.1f,0.4f};
						table1.setWidths(wid1);
					}
					/**/
					PdfPTable table13 = new PdfPTable(1);
					table13.getDefaultCell().setBorderWidth(0);
					PdfPCell cell2 = new PdfPCell(table13);
					cell2.setBorder(0);
					cell2.setPaddingBottom(5f);
					table1.addCell(cell2);
					
					//Logo文字标识
					String logoInDentifying="";
					if(logo.equals(Constant.LOGO_PATH[0])){
						logoInDentifying="中国美";
					}else if(logo.equals(Constant.LOGO_PATH[1])){
						logoInDentifying="Chinatour.com";
					}else if(logo.equals(Constant.LOGO_PATH[2])){
						logoInDentifying="Intertrips";
					}else{
						logoInDentifying="文景假期";
					}
					PdfPCell cellHead = new PdfPCell(new Paragraph(logoInDentifying,chineseFontBig));
					cellHead.setBorder(0);
					cellHead.setMinimumHeight(10f);
					table13.addCell(cellHead);
					
					PdfPCell cell20 = new PdfPCell(new Paragraph("Agent Name:"+agen.getUsername(),littleChineseFont));
					cell20.setBorder(0);
					cell20.setMinimumHeight(10f);
					table13.addCell(cell20);
					
					PdfPCell cell21 = new PdfPCell(new Paragraph("Address:"+agen.getAddress(),littleChineseFont));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell cell21_1 = new PdfPCell(new Paragraph("Tel:"+agen.getTel(),littleChineseFont));
					cell21_1.setBorder(0);
					cell21_1.setMinimumHeight(10f);
					table13.addCell(cell21_1);
					
					PdfPCell cell21_2 = new PdfPCell(new Paragraph("Fax:"+agen.getFax(),littleChineseFont));
					cell21_2.setBorder(0);
					cell21_2.setMinimumHeight(10f);
					table13.addCell(cell21_2);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailForDept,littleChineseFont));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					table13.addCell(cell26);
					
					if(order.getDeptId().equals(Constant.VANCOUVER)){
						PdfPCell cell27 = new PdfPCell(new Paragraph("LICENSE:"+Constant.VANCOUVER_LICENSE,littleChineseFont));
						cell27.setBorder(0);
						cell27.setMinimumHeight(10f);
						table13.addCell(cell27);
					}
					
					PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
					cell1.setBorder(0);
					table1.addCell(cell1);
					
					table1.getDefaultCell().setBorderWidth(0); //不显示边框
					PdfPTable table11 = new PdfPTable(1);
					table11.getDefaultCell().setBorder(0);
					Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
					jpeg.setAlignment(Image.ALIGN_RIGHT);
					jpeg.setAlignment(Image.ALIGN_MIDDLE);
					jpeg.setBorder(0);
					table11.addCell(jpeg);
					table11.getDefaultCell().setBorderWidth(0);
					PdfPCell cell0 = new PdfPCell(table11);
					cell0.setBorder(0);
					cell0.setBorderColor(Color.GRAY);
					cell0.setBorderWidthBottom(0f);
					cell0.setPaddingBottom(15f);
					table11.setWidthPercentage(60);
					table1.addCell(cell0);
					cell0.setBorder(0);
					
					document.add(table1);
				/*     Invoice 顶部的地址栏信息和Logo结束           */
					PdfContentByte cb=writer.getDirectContent();
					cb.setLineWidth(0.3f);
					
					
					/*BILL TO信息添加*/
					PdfPTable tabalOrder_2 = new PdfPTable(2);
					float[] widOrder4 ={0.52f,0.48f};
					tabalOrder_2.setWidths(widOrder4);
					tabalOrder_2.setWidthPercentage(100);
					tabalOrder_2.getDefaultCell().setBorderWidthTop(0);
					tabalOrder_2.setSpacingBefore(10f);
					
					PdfPCell tableOrderCell = new PdfPCell();
					tableOrderCell.setBorder(0);
					tableOrderCell.setBorderWidthTop(0.3f);
					tableOrderCell.setPaddingTop(20f);
					tableOrderCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableOrderCell.setPhrase(new Phrase("BILL TO",bold_fontEng));
					tabalOrder_2.addCell(tableOrderCell);
					tableOrderCell.setPhrase(new Phrase("Invoice No:"+order.getOrderNo(),norm_fontEng));
					tabalOrder_2.addCell(tableOrderCell);
					
					
					PdfPCell orderItems_2 = new PdfPCell(new Paragraph("Company:"+Company,norm_fontEng));
					orderItems_2.setBorder(0);
					orderItems_2.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_2);
					
					PdfPCell orderItems_1 = new PdfPCell(new Paragraph("Tour Code:"+order.getTourCode(),norm_fontEng));
					orderItems_1.setBorder(0);
					orderItems_1.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_1);
					
					
					PdfPCell orderItems_0 = new PdfPCell(new Paragraph("Name:"+ordersTotal.getContactName(),norm_fontEng));
					orderItems_0.setBorder(0);
					orderItems_0.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_0);
					
					PdfPCell orderItems_3 = new PdfPCell(new Paragraph("Booking Date:"+bookingDate,norm_fontEng));
					orderItems_3.setBorder(0);
					orderItems_3.setMinimumHeight(10f);
					tabalOrder_2.addCell(orderItems_3);
					
					
					PdfPCell tabalCell_2_2 = new PdfPCell(new Paragraph("Address:"+ordersTotal.getAddress()+" "+cityAndState,norm_fontEng));
					tabalCell_2_2.setBorder(0);
					tabalCell_2_2.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_2_2);
					
					PdfPCell tabalCell_space = new PdfPCell(new Paragraph("Arrival Date:"+arriveDate,norm_fontEng));
					tabalCell_space.setBorder(0);
					tabalCell_space.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_space);
					
					
					PdfPCell tabalCell_2_3 = new PdfPCell(new Paragraph("Phone:"+ordersTotal.getTel(),norm_fontEng));
					tabalCell_2_3.setBorder(0);
					tabalCell_2_3.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_2_3);
					
					PdfPCell tabalCell_space2 = new PdfPCell(new Paragraph("",norm_fontEng));
					tabalCell_space2.setBorder(0);
					tabalCell_space2.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_space2);
					
					
					PdfPCell tabalCellEamil = new PdfPCell(new Paragraph("Email:"+ordersTotal.getEmail(),norm_fontEng));
					tabalCellEamil.setBorder(0);
					tabalCellEamil.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCellEamil);
					
					PdfPCell tabalCell_space3 = new PdfPCell(new Paragraph("Departure city:"+tourInfoForOrder.getSpecialRequirements(),norm_fontEng));
					tabalCell_space3.setBorder(0);
					tabalCell_space3.setMinimumHeight(10f);
					tabalOrder_2.addCell(tabalCell_space3);
					
					
					document.add(tabalOrder_2);
					
					
					
					List<PayCostRecords> pRecords = new ArrayList<PayCostRecords>(); //存放所有的
					List<PayCostRecords> pay = payCostRecordsMapper.findByOrderId(order.getId());
					List<PayCostRecords> removePay = new ArrayList<PayCostRecords>();
					for(PayCostRecords payCostRecord:pay){
						if(payCostRecord.getPayOrCost()==2||payCostRecord.getSum()==null||payCostRecord.getSum().compareTo(BigDecimal.ZERO)==0){
							removePay.add(payCostRecord);
						}
					}
					pay.removeAll(removePay);
					pRecords.addAll(pay);
				
					//用于存放客人名字信息
					List<String> pasData=new ArrayList<String>();
					
					BigDecimal totalFee = new BigDecimal(0);
					if(pRecords!=null||pRecords.size()!=0){
						for(int i=0;i<pRecords.size();i++){
								totalFee = totalFee.add(pRecords.get(i).getSum());
							}
					}
					
					//添加invoiceItems
					Paragraph invoiceItems = new Paragraph("INVOICE ITEMS",bold_fontEng);
					invoiceItems.setAlignment(Paragraph.ALIGN_CENTER);
					invoiceItems.setSpacingAfter(5f);
					invoiceItems.setSpacingBefore(10f);
					document.add(invoiceItems);
					
					PdfPTable itemsData = new PdfPTable(6);
					float[] wid4 ={0.05f,0.15f,0.35f,0.15f,0.15f,0.15f};
					itemsData.setWidths(wid4);
					itemsData.setWidthPercentage(100);
					itemsData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeaderForItem = new PdfPCell();
					tableHeaderForItem.setBorder(0);
					tableHeaderForItem.setBorderColorBottom(Color.GRAY);
					tableHeaderForItem.setBorderWidthBottom(0.3f);
					tableHeaderForItem.setBorderWidthTop(1.5f);
					tableHeaderForItem.setMinimumHeight(30f);
					tableHeaderForItem.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeaderForItem.setMinimumHeight(20f);
					tableHeaderForItem.setBorderWidth(0.5f);
					tableHeaderForItem.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Service",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Price",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Qty",bold_fontEngForTableHead));
					itemsData.addCell(tableHeaderForItem);
					tableHeaderForItem.setPhrase(new Phrase("Total",bold_fontEngForTableHead));
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
									if(orderReceiveItems.get(i).getItemFee()==null||orderReceiveItems.get(i).getItemFee().toString().length()==0||(orderReceiveItems.get(i).getItemFee().intValue()==0&&orderReceiveItems.get(i).getRemark()==null)||(orderReceiveItems.get(i).getItemFee().intValue()==0&&orderReceiveItems.get(i).getRemark()=="")){
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
	 								PdfPCell orderReceiveItemNo = new PdfPCell();
	 								orderReceiveItemNo.setBorder(0);
	 								orderReceiveItemNo.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
	 								orderReceiveItemNo.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
	 								orderReceiveItemNo.setMinimumHeight(20f);
	 								orderReceiveItemNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
	 								orderReceiveItemNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
	 								itemsData.addCell(orderReceiveItemNo);
									
									PdfPCell serviceCell = new PdfPCell();
									serviceCell.setBorder(0);
									serviceCell.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									serviceCell.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									serviceCell.setMinimumHeight(20f);
									serviceCell.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									serviceCell.addElement(new Phrase(service,chineseFont));
									itemsData.addCell(serviceCell);
									
									PdfPCell description = new PdfPCell();
									description.setBorder(0);
									description.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									description.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									description.setMinimumHeight(20f);
									description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									description.addElement(new Phrase(tourInfoForOrder.getLineName()+" / "+(orderReceiveItems.get(i).getRemark()==null?"":orderReceiveItems.get(i).getRemark()),chineseFont));
									itemsData.addCell(description);
									
									PdfPCell price = new PdfPCell();
									price.setBorder(0);
									price.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									price.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									price.setMinimumHeight(20f);
									price.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									BigDecimal pri = orderReceiveItems.get(i).getItemFee();
									if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
										pri = new BigDecimal(0).subtract(pri);
									}
									price.addElement(new Phrase(pri.toString(),chineseFont));
									itemsData.addCell(price);
									
									PdfPCell num = new PdfPCell();
									num.setBorder(0);
									num.setBorderColor(i==orderReceiveItems.size()-1?Color.BLACK:Color.GRAY);
									num.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									num.setMinimumHeight(20f);
									num.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									num.addElement(new Phrase("*"+orderReceiveItems.get(i).getItemFeeNum().toString(),chineseFont));
									itemsData.addCell(num);
									
									PdfPCell totalFe = new PdfPCell();
									totalFe.setBorder(0);
									totalFe.setBorderWidthBottom(i==orderReceiveItems.size()-1?1.5f:0.3f);
									
									if(i==orderReceiveItems.size()-1){
										totalFe.setBorderColor(Color.BLACK);
										totalFe.setBorderWidthBottom(1.5f);
									}else{
										totalFe.setBorderColor(Color.GRAY);
										totalFe.setBorderWidthBottom(0.3f);
									}
									totalFe.setMinimumHeight(20f);
									totalFe.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									BigDecimal itemFee = orderReceiveItems.get(i).getItemFee();
									if(orderReceiveItems.get(i).getType()==3&&orderReceiveItems.get(i).getOrderType()!=5){
										itemFee = new BigDecimal(0).subtract(itemFee);
									}
									Integer mount = orderReceiveItems.get(i).getItemFeeNum();
									BigDecimal toMount = new BigDecimal(mount);
									totalFe.addElement(new Phrase(itemFee.multiply(toMount).toString(),chineseFont));
									itemsData.addCell(totalFe);
									totalCostFee = totalCostFee.add(itemFee.multiply(toMount));
										}
									
									}
						
					document.add(itemsData);
					
					PdfPTable subTotalData = new PdfPTable(3);
					float[] wid6 ={0.72f,0.18f,0.1f};
					subTotalData.setWidths(wid6);
					subTotalData.setWidthPercentage(100);
					//subTotalData.getDefaultCell().setBorderWidthBottom(0);
					subTotalData.getDefaultCell().setMinimumHeight(20f);
					
					PdfPCell sub1 = new PdfPCell();
					sub1.setBorder(0);
					sub1.addElement(new Phrase("",norm_fontEng));
					subTotalData.addCell(sub1);
					
					PdfPCell sub2 = new PdfPCell();
					sub2.setBorder(0);
					sub2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					sub2.addElement(new Phrase("SubTotal:",bold_fontEngForTableHead));
					subTotalData.addCell(sub2);
					
					PdfPCell sub3 = new PdfPCell();
					sub3.setBorder(0);
					sub3.addElement(new Phrase(totalCostFee.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(sub3);
					
					if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0){
						BigDecimal peerUserFee = new BigDecimal(0.00);
						if(order.getPeerUserFee()!=null){
							peerUserFee = order.getPeerUserFee();
						}
						PdfPCell userFee1 = new PdfPCell();
						userFee1.setBorder(0);
						userFee1.addElement(new Phrase("",norm_fontEng));
						subTotalData.addCell(userFee1);
						
						PdfPCell userFee2 = new PdfPCell();
						userFee2.setBorder(0);
						userFee2.setHorizontalAlignment(Element.ALIGN_RIGHT);
						userFee2.addElement(new Phrase(" Commission:",bold_fontEngForTableHead));
						subTotalData.addCell(userFee2);
						
						PdfPCell userFee3 = new PdfPCell();
						userFee3.setBorder(0);
						userFee3.addElement(new Phrase(peerUserFee.toString(),bold_fontEngForTableHead));
						subTotalData.addCell(userFee3);
					}
					
					PdfPCell paid1 = new PdfPCell();
					paid1.setBorder(0);
					paid1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(paid1);
					
					PdfPCell paid2 = new PdfPCell();
					paid2.setBorder(0);
					paid2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					paid2.addElement(new Phrase("         Paid:",bold_fontEngForTableHead));
					subTotalData.addCell(paid2);
					
					
					PdfPCell paid3 = new PdfPCell();
					paid3.setBorder(0);
					paid3.addElement(new Phrase(totalFee.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(paid3);
					
					PdfPCell balance1 = new PdfPCell();
					balance1.setBorder(0);
					balance1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(balance1);
					
					PdfPCell balance2 = new PdfPCell();
					balance2.setBorder(0);
					balance2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					balance2.addElement(new Phrase("   Balance:",bold_fontEngForTableHead));
					subTotalData.addCell(balance2);
					
					PdfPCell balance3 = new PdfPCell();
					balance3.setBorder(0);
					BigDecimal bal = totalCostFee.subtract(totalFee);
					if(order.getPeerUserId()!=null&&order.getPeerUserId().length()!=0&&order.getPeerUserFee()!=null){
						bal = bal.subtract(order.getPeerUserFee());
					}
					balance3.addElement(new Phrase(bal.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(balance3);
					
					/*BigDecimal rate = new BigDecimal(1.00);
						rate = order.getRate();
					
					
					PdfPCell tax1 = new PdfPCell();
					tax1.setBorder(0);
					tax1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(tax1);
					
					PdfPCell tax2 = new PdfPCell();
					tax2.setBorder(0);
					tax2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					tax2.addElement(new Phrase("Exchange Rate:",bold_fontEngForTableHead));
					subTotalData.addCell(tax2);
					
					PdfPCell tax3 = new PdfPCell();
					tax3.setBorder(0);
					tax3.addElement(new Phrase(rate.toString(),bold_fontEngForTableHead));
					subTotalData.addCell(tax3);
					
					PdfPCell toatl1 = new PdfPCell();
					toatl1.setBorder(0);
					toatl1.addElement(new Phrase("",bold_fontEngForTableHead));
					subTotalData.addCell(toatl1);
					
					PdfPCell toatl2 = new PdfPCell();
					toatl2.setBorder(0);
					toatl2.setHorizontalAlignment(Element.ALIGN_RIGHT);
					toatl2.addElement(new Phrase("Total Blance:",bold_fontEngForTableHead));
					subTotalData.addCell(toatl2);
					
					PdfPCell toatl3 = new PdfPCell();
					toatl3.setBorder(0);
					toatl3.addElement(new Phrase(bal.multiply(rate).setScale(2,BigDecimal.ROUND_HALF_UP).toString(),bold_fontEngForTableHead));
					subTotalData.addCell(toatl3);*/
					document.add(subTotalData);
					
					//客人信息
					List<Customer> customersForToatl = new ArrayList<Customer>();
					List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findCustomerByOrderId(orderId);
					for(CustomerOrderRel customerOrderRel:customerOrderRelList){
						if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
							Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
							customersForToatl.add(customer);
						}
					}
					
					Paragraph cus = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					cus.setAlignment(Paragraph.ALIGN_CENTER);
					cus.setSpacingAfter(5f);
					cus.setSpacingBefore(5f);
					document.add(cus);
					
					PdfPTable cusData = new PdfPTable(4);
					float[] wid5 ={0.1f,0.4f,0.3f,0.20f};
					cusData.setWidths(wid5);
					cusData.setWidthPercentage(100);
					cusData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeaderForCus = new PdfPCell();
					tableHeaderForCus.setBorder(0);
					tableHeaderForCus.setBorderColorBottom(Color.GRAY);
					tableHeaderForCus.setBorderWidthBottom(0.3f);
					tableHeaderForCus.setBorderWidthTop(1.5f);
					tableHeaderForCus.setMinimumHeight(30f);
					tableHeaderForCus.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeaderForCus.setMinimumHeight(20f);
					tableHeaderForCus.setBorderWidth(0.5f);
					tableHeaderForCus.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					tableHeaderForCus.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					cusData.addCell(tableHeaderForCus);
					if(customersForToatl!=null){
					for(int i=0;i<customersForToatl.size();i++){
						PdfPCell cusNo = new PdfPCell();
						cusNo.setBorder(0);
						cusNo.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusNo.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusNo.setMinimumHeight(20f);
						cusNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						cusNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
						cusData.addCell(cusNo);
						
						PdfPCell cusName = new PdfPCell();
						cusName.setBorder(0);
						cusName.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusName.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusName.setMinimumHeight(20f);
						cusName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						cusName.addElement(new Phrase(customersForToatl.get(i).getLastName()+"/"+customersForToatl.get(i).getFirstName()+customersForToatl.get(i).getMiddleName(),chineseFont));
						cusData.addCell(cusName);
						
						PdfPCell cusGender = new PdfPCell();
						cusGender.setBorder(0);
						cusGender.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusGender.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusGender.setMinimumHeight(20f);
						cusGender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String sexForString = "";
						if(customersForToatl.get(i).getSex()==1){
							sexForString = "FEMALE";
						}else if(customersForToatl.get(i).getSex()==2){
							sexForString = "MALE";
						}
						cusGender.addElement(new Phrase(sexForString,chineseFont));
						cusData.addCell(cusGender);
						
						PdfPCell cusNationality = new PdfPCell();
						cusNationality.setBorder(0);
						cusNationality.setBorderColor(i==customersForToatl.size()-1?Color.BLACK:Color.GRAY);
						cusNationality.setBorderWidthBottom(i==customersForToatl.size()-1?1.5f:0.3f);
						cusNationality.setMinimumHeight(20f);
						cusNationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String countryName = "";
						if(customersForToatl.get(i)!=null){
								countryName = customersForToatl.get(i).getNationalityOfPassport();
						}
						cusNationality.addElement(new Phrase(customersForToatl.get(i).getCountryId()==null?"":countryName,chineseFont));
						cusData.addCell(cusNationality);
						
					}
					}
					document.add(cusData);
					
					//添加payment
					Paragraph payment = new Paragraph("PAYMENT HISTORY",bold_fontEng);
					payment.setAlignment(Paragraph.ALIGN_CENTER);
					payment.setSpacingAfter(5f);
					payment.setSpacingBefore(10f);
					document.add(payment);
					
					PdfPTable paymentData = new PdfPTable(5);
					float[] wid3 ={0.1f,0.2f,0.3f,0.3f,0.10f};
					paymentData.setWidths(wid3);
					paymentData.setWidthPercentage(100);
					paymentData.getDefaultCell().setBorderWidthBottom(0);
					
					PdfPCell tableHeader = new PdfPCell();
					tableHeader.setBorder(0);
					tableHeader.setBorderColorBottom(Color.GRAY);
					tableHeader.setBorderWidthBottom(0.3f);
					tableHeader.setBorderWidthTop(1.5f);
					tableHeader.setMinimumHeight(30f);
					tableHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					tableHeader.setMinimumHeight(20f);
					tableHeader.setBorderWidth(0.5f);
					tableHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Description",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					paymentData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Amount",bold_fontEngForTableHead));
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
					
					
					
						if(payCostRecords!=null||payCostRecords.size()!=0){
							for(int i=0;i<payCostRecords.size();i++){
	 								PdfPCell payNo = new PdfPCell();
									payNo.setBorder(0);
									payNo.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									payNo.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									payNo.setMinimumHeight(20f);
									payNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									payNo.addElement(new Phrase(Integer.toString(i+1),chineseFont));
									paymentData.addCell(payNo);
									
									PdfPCell date = new PdfPCell();
									date.setBorder(0);
									date.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									date.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									date.setMinimumHeight(20f);
									date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
									date.addElement(new Phrase(payCostRecords.get(i).getTime()==null?"":simpleDateFormat.format(payCostRecords.get(i).getTime()),chineseFont));
									paymentData.addCell(date);
									
									PdfPCell description = new PdfPCell();
									description.setBorder(0);
									description.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									description.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									description.setMinimumHeight(20f);
									description.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									description.addElement(new Phrase(payCostRecords.get(i).getItem(),chineseFont));
									paymentData.addCell(description);
									
									PdfPCell remark = new PdfPCell();
									remark.setBorder(0);
									remark.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									remark.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									remark.setMinimumHeight(20f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									remark.addElement(new Phrase(payCostRecords.get(i).getRemark(),chineseFont));
									paymentData.addCell(remark);
									
									PdfPCell amount = new PdfPCell();
									amount.setBorder(0);
									amount.setBorderColor(i==payCostRecords.size()-1?Color.BLACK:Color.GRAY);
									amount.setBorderWidthBottom(i==payCostRecords.size()-1?1.5f:0.3f);
									amount.setMinimumHeight(20f);
									amount.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									amount.addElement(new Phrase(payCostRecords.get(i).getSum().toString(),chineseFont));
									paymentData.addCell(amount);
								}
						}
					document.add(paymentData);
					Paragraph total = new Paragraph("Total: "+totalFee,bold_fontEngForTableHead);
					total.setAlignment(2);
					document.add(total);
					
					//加拿大添加
					if(order.getDeptId().equals(Constant.VANCOUVER)){
						//添加备注以及条款
						Paragraph payment1 = new Paragraph("",bold_fontEng);
						payment1.setAlignment(Paragraph.ALIGN_CENTER);
						payment1.setSpacingAfter(5f);
						payment1.setSpacingBefore(5f);
						document.add(payment1);
						
						Paragraph remark = new Paragraph("REMARKS",bold_fontEng);
						remark.setAlignment(Paragraph.ALIGN_LEFT);
						remark.setSpacingAfter(10f);
						remark.setSpacingBefore(10f);
						document.add(remark);
						
						PdfPTable paymentData1 = new PdfPTable(1);
						paymentData1.getDefaultCell().setMinimumHeight(20f);
						float[] wid33 ={1f};
						paymentData1.setWidths(wid33);
						paymentData1.setWidthPercentage(100);
						
						PdfPCell remarks = new PdfPCell();
						remarks.setBorder(0);
						remarks.setPaddingBottom(10f);
						remarks.setBorderWidthTop(1.5f);
						remarks.setBorderColor(Color.GRAY);
						remarks.addElement(new Phrase(""+Constant.VANCOUVER_TERMS[0],norm_fontEng));
						paymentData1.addCell(remarks);
						
						PdfPCell depositinfo = new PdfPCell();
						depositinfo.setBorder(0);
						depositinfo.setPaddingBottom(10f);
						depositinfo.addElement(new Phrase(""+Constant.VANCOUVER_TERMS[1],norm_fontEng));
						paymentData1.addCell(depositinfo);
						
						
						document.add(paymentData1);
						
						
					}
					
					
					PdfPTable footReamrk = new PdfPTable(1); //表格两列
					footReamrk.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					footReamrk.setWidthPercentage(100);//表格的宽度为100%
					footReamrk.getDefaultCell().setBorderWidth(0); //不显示边框
					footReamrk.getDefaultCell().setBorderColor(Color.GRAY);
					
					
					PdfPCell foot1 = new PdfPCell(new Paragraph("Please note that all travel documents will only be sent after you full balance has been received.",norm_fontEng));
					foot1.setBorder(0);
					foot1.setPaddingTop(5f);
					foot1.setMinimumHeight(1f);
					footReamrk.addCell(foot1);
					
					
					PdfPCell foot2 = new PdfPCell(new Paragraph("Please inspect this invoice carefully; our company will not be responsible for any errors after 2 business days.",norm_fontEng));
					foot2.setBorder(0);
					foot2.setMinimumHeight(1f);
					footReamrk.addCell(foot2);
					
					PdfPCell foot3 = new PdfPCell(new Paragraph("Please check our website for terms and conditions.",norm_fontEng));
					foot3.setBorder(0);
					foot3.setMinimumHeight(1f);
					footReamrk.addCell(foot3);
					
					document.add(footReamrk);
					
					
					Paragraph LogoSpace = new Paragraph("",bold_fontEng);
					LogoSpace.setAlignment(Paragraph.ALIGN_CENTER);
					LogoSpace.setSpacingAfter(10f);
					LogoSpace.setSpacingBefore(10f);
					document.add(LogoSpace);
					
					PdfPTable tablelogo = new PdfPTable(3); //表格两列
					if(l==4){
						float[] wid1 ={0.2f,0.25f,0.55f};
						tablelogo.setWidths(wid1);
					}else if(l==2||l==3){
						float[] wid1 ={0.2f,0.25f,0.55f};
						tablelogo.setWidths(wid1);
					}else if(l==1){
						float[] wid1 ={0.2f,0.25f,0.55f};
						tablelogo.setWidths(wid1);
					}
					tablelogo.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					tablelogo.setWidthPercentage(100);//表格的宽度为100%
		//			tablelogo.getDefaultCell().setBorderWidth(0); //不显示边框
					tablelogo.getDefaultCell().setBorderColor(Color.GRAY);
					
					
		
					
					
					PdfPCell Cell_logo2 = new PdfPCell(new Paragraph("")); //
					Cell_logo2.setBorder(0);
					Cell_logo2.setBorderColor(Color.GRAY);
					tablelogo.addCell(Cell_logo2);
					
					
					PdfPCell Cell_logo3 = new PdfPCell(new Paragraph("")); //
					Cell_logo3.setBorder(0);
					Cell_logo3.setBorderColor(Color.GRAY);
					tablelogo.addCell(Cell_logo3);
					
					
					PdfPTable tablelogo1 = new PdfPTable(2);
					float[] wid ={0.8f,0.2f};
					tablelogo1.setWidths(wid);
					tablelogo1.getDefaultCell().setBorderWidth(0);
					PdfPCell Cell_logo = new PdfPCell(tablelogo1);
					Cell_logo.setBorder(0);
					tablelogo.addCell(Cell_logo);
					
					PdfPCell Cell_logo1 = new PdfPCell(new Paragraph(" Thank you for choosing   ",norm_fontEng));
					Cell_logo1.setBorder(0);
					Cell_logo1.setVerticalAlignment(Element.ALIGN_MIDDLE);
					Cell_logo1.setHorizontalAlignment(Element.ALIGN_RIGHT);
					tablelogo1.addCell(Cell_logo1);
					
					
					PdfPCell logoCell=new PdfPCell();
					logoCell.addElement(jpeg);
					logoCell.setBorder(0);
					logoCell.setHorizontalAlignment(Element.ALIGN_LEFT);
					tablelogo1.addCell(logoCell);
					
					document.add(tablelogo);
		
						
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