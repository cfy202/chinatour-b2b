package com.chinatour.service.impl;

import java.awt.Color;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

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
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.TourTypeOfDept;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.persistence.TourTypeOfDeptMapper;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
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
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;


@Service("ExportVoucherForWordServiceImpl")
public class ExportVoucherForWordServiceImpl implements  ExportVoucherForWordService{
	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	
	@Resource(name = "orderMapper")
	private OrderMapper orderMapper;
	
	@Resource(name = "ordersTotalMapper")
	private OrdersTotalMapper ordersTotalMapper;
	
	@Resource(name = "venderMapper")
	private VenderMapper venderMapper;
	
	@Resource(name = "tourInfoForOrderMapper")
	private TourInfoForOrderMapper tourInfoForOrderMapper;
	
	@Resource(name = "groupLineMapper")
	private GroupLineMapper groupLineMapper;
	
	@Resource(name = "deptMapper")
	private DeptMapper deptMapper;
	
	@Resource(name = "groupRouteMapper")
	private GroupRouteMapper groupRouteMapper;
	
	@Resource(name = "tourTypeOfDeptMapper")
	private TourTypeOfDeptMapper tourTypeOfDeptMapper;
	
	@Resource(name="servletContext")
	private ServletContext servletContext;
	
	@Resource(name="adminServiceImpl")
	private AdminService adminService;
		
	@Override
	public InputStream getWordFile(String orderId) throws Exception {
			//Order order = orderMapper.findById(orderId);
		 	Order order = orderMapper.findCustomerForOrderId(orderId); //查找订单下的所有客人
		    String orderNumber = order.getOrderNo();
		    OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
		    String addressString = "";
		    String telString = "";
		    String mailString = "";
		    String agentString = "";
		    
		    if(ordersTotal.getWr().equals("wholeSale")){
		    	if((ordersTotal.getCompanyId()!=null)&&(ordersTotal.getCompanyId().length()!=0)){
			    	Vender vender = venderMapper.findById(ordersTotal.getCompanyId());
			    	addressString = vender.getAddress();
			    	telString = vender.getTel();
			    	mailString = vender.getEmail();
			    	agentString = vender.getName();
		    	}
		    }else if(ordersTotal.getWr().equals("retail")){
		    	Admin agent = adminService.findById(ordersTotal.getUserId());
		    	Dept dept = deptMapper.findById(agent.getDeptId());
		    	addressString = dept.getAddress();
		    	telString = dept.getTel();
		    	mailString = dept.getEmail();
		    	agentString = order.getUserName();
		    }
		    List<Customer> customers = new ArrayList<Customer>();
			List<CustomerOrderRel> customerOrderRelList=order.getCustomerOrderRel();
			for(int j=0;j<customerOrderRelList.size();j++){
				if(customerOrderRelList.get(j).getIsDel()!=1){
					CustomerOrderRel customerOrderRel=customerOrderRelList.get(j);
					List<CustomerFlight> customerFlightListST= customerOrderRel.getCustomerFlightList();
					for (int t = 0; t < customerFlightListST.size(); t++) {
						customerFlightListST.get(t).setUserId(customerOrderRel.getUserName());
						customerFlightListST.get(t).setCustomerNo(customerOrderRel.getCustomerOrderNo().toString());
					}
					//团下所有客人
					Customer customer = customerOrderRel.getCustomer();
					customer.setCustomerFlight(customerFlightListST);
					customer.setCustomerTourNo(customerOrderRel.getCustomerTourNo());
					customer.setCustomerOrderNo(customerOrderRel.getCustomerOrderNo());
					customers.add(customer);
				}
			}
		
			
		//获取团信息
		TourInfoForOrder tourInfoOrder = tourInfoForOrderMapper.findByOrderId(orderId);
		//获取线路
		String groupLineId = tourInfoOrder.getGroupLineId();
		GroupLine groupLine = groupLineMapper.findById(groupLineId);
		GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
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
			/*Font norm_fontEng = new Font(bfEng, 12, Font.NORMAL, Color.BLACK);
			BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
			Font norm_fontChinese = new Font(bfChinese, 12, Font.NORMAL, Color.BLACK);
			Font norm_fontChineseForTittle = new Font(bfChinese, 14, Font.BOLD, Color.BLACK);
			Font norm_fontChineseForHead = new Font(bfChinese, 14, Font.BOLD, Color.BLACK);
			Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.BOLD, Color.GRAY);
			Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
					Color.BLACK);
			Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
					Color.darkGray);*/
			
			Table table1=new Table(3);
			String logoPath = "";
			//String brand = groupLine.getBrand(); 
			if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
				logoPath = Constant.LOGO_PATH[0];
			}else if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
				logoPath = Constant.LOGO_PATH[1];
			}else if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
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
			Cell cell21 = new Cell(new Paragraph(addressString));
			cell21.setBorder(0);
			table13.addCell(cell21);
			
			Cell cell24 = new Cell(new Paragraph(""));
			cell24.setBorder(0);
			table13.addCell(cell24);
			
			Cell cell25 = new Cell(new Paragraph("Tel:"+telString));
			cell25.setBorder(0);
			table13.addCell(cell25);
			
			Cell cell26 = new Cell(new Paragraph("Email:"+mailString));
			cell26.setBorder(0);
			table13.addCell(cell26);
			
			Cell cell13 = new Cell(table13);
			table1.addCell(cell11);
			table1.addCell(cell12);
			table1.addCell(cell13);
			doc.add(table1);
			
			//添加线路基本信息
			TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
			Paragraph lineTittle = new Paragraph(groupLine.getTourName(),titleFontForBold);
			lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
			lineTittle.setSpacingBefore(15f);
			doc.add(lineTittle);
			Table lineInfo = new Table(3);
			lineInfo.setPadding(4f);
			lineInfo.setWidth(100);
			float[] wid2 ={0.33f,0.33f,0.33f}; //两列宽度的比例
			lineInfo.setWidths(wid2); 
			lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
			Cell tourCode = new Cell(new Paragraph(	 "Tour Code:	"+tourInfoForOrder.getScheduleLineCode(),contextFontForTittle));
			tourCode.setBorder(0);
			lineInfo.addCell(tourCode);
			SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
			String arriveTime = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
			String[] dates = arriveTime.split("-");
			String str = dates[1];
		    SimpleDateFormat sdf = new SimpleDateFormat("MM");
		    Date date1 = sdf.parse(str);
		    sdf = new SimpleDateFormat("MMMMM",Locale.US);
		    arriveTime = dates[0]+" "+sdf.format(date1)+" "+dates[2];
			Cell arriveDate = new Cell(new Paragraph("Tour Date:	"+arriveTime,contextFontForTittle));
			arriveDate.setBorder(0);
			lineInfo.addCell(arriveDate);
			
			Cell invoiceId = new Cell(new Paragraph("Invoice Id:	"+order.getOrderNo(),contextFontForTittle));
			invoiceId.setBorder(0);
			lineInfo.addCell(invoiceId);
				Cell agent = new Cell(new Paragraph("Agent:	 "+agentString,contextFontForTittle));
				agent.setBorder(0);
				lineInfo.addCell(agent);
			
			Cell subAgent = new Cell(new Paragraph(""));
			subAgent.setBorder(0);
			lineInfo.addCell(subAgent);
			
			Cell space = new Cell(new Paragraph(" "));
			space.setBorder(0);
			lineInfo.addCell(space);
			doc.add(lineInfo);
			
			//客人信息
			Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",titleFontForBold);
			customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
			customerInfoTittle.setSpacingBefore(15f);
			customerInfoTittle.setSpacingAfter(0f);
			doc.add(customerInfoTittle);
			
			Table customerData = new Table(4);
			customerData.setPadding(2f);
			customerData.setWidth(100);
			float[] wid ={0.1f,0.40f,0.25f,0.25f};
			customerData.setWidths(wid);
			customerData.getDefaultCell().setBorder(0);
			Cell customerHeader1 = new Cell(new Paragraph("#",contextFontForTableHead));
			customerHeader1.setBorderWidthTop(5f);
			Cell customerHeader2 = new Cell(new Paragraph("Name",contextFontForTableHead));
			customerHeader2.setBorderWidthTop(5f);
			Cell customerHeader3 = new Cell(new Paragraph("Gender",contextFontForTableHead));
			customerHeader3.setBorderWidthTop(5f);
			Cell customerHeader4 = new Cell(new Paragraph("Nationality",contextFontForTableHead));
			customerHeader4.setBorderWidthTop(5f);
			customerData.addCell(customerHeader1);
			customerData.addCell(customerHeader2);
			customerData.addCell(customerHeader3);
			customerData.addCell(customerHeader4);

			for(int i=0;i<customers.size();i++){
					Cell customerNum = new Cell();
					customerNum.setBorder(0);
					customerNum.setBorderColorBottom(Color.GRAY);
					customerNum.setBorderWidthBottom(0.3f);
					//customerNum.setMinimumHeight(36f);
					customerNum.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					customerNum.addElement(new Phrase(customers.get(i).getCustomerOrderNo().toString(),contextFont));
					customerData.addCell(customerNum);
					
					Cell customerName = new Cell();
					customerName.setBorder(0);
					customerName.setBorderColorBottom(Color.GRAY);
					customerName.setBorderWidthBottom(0.3f);
					//customerName.setMinimumHeight(36f);
					customerName.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					customerName.addElement(new Phrase(customers.get(i).getLastName()+"/"+customers.get(i).getFirstName()+customers.get(i).getMiddleName(),contextFont));
					customerData.addCell(customerName);
					
					Cell gender = new Cell();
					gender.setBorder(0);
					gender.setBorderColorBottom(Color.GRAY);
					gender.setBorderWidthBottom(0.3f);
					//gender.setMinimumHeight(36f);
					gender.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					gender.addElement(new Phrase(customers.get(i).getSex()==2?"male":"female",contextFont));
					customerData.addCell(gender);
					
					Cell nationality = new Cell();
					nationality.setBorder(0);
					nationality.setBorderColorBottom(Color.GRAY);
					nationality.setBorderWidthBottom(0.3f);
					//nationality.setMinimumHeight(36f);
					nationality.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					nationality.addElement(new Phrase(customers.get(i).getNationalityOfPassport(),contextFont));
					customerData.addCell(nationality);
			}
			doc.add(customerData);
			
			
			//航班信息
			Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",titleFontForBold);
			flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
			flightInfoTittle.setSpacingBefore(15f);
			doc.add(flightInfoTittle);
			
			Table flightData = new Table(7);
			//float[] wid6 ={0.33f,0.33f,0.33f};
			flightData.setWidth(100);
			flightData.setPadding(5f);
			flightData.getDefaultCell().setBorder(0);
			Cell flightHeader1 = new Cell(new Paragraph("Date",contextFontForTableHead));
			flightHeader1.setBorderWidthTop(5f);
			Cell flightHeader2 = new Cell(new Paragraph("Airline",contextFontForTableHead));
			flightHeader2.setBorderWidthTop(5f);
			Cell flightHeader3 = new Cell(new Paragraph("No.",contextFontForTableHead));
			flightHeader3.setBorderWidthTop(5f);
			Cell flightHeader4 = new Cell(new Paragraph("Dep.Time",contextFontForTableHead));
			flightHeader4.setBorderWidthTop(5f);
			Cell flightHeader5 = new Cell(new Paragraph("Arr.Time",contextFontForTableHead));
			flightHeader5.setBorderWidthTop(5f);
			Cell flightHeader6 = new Cell(new Paragraph("Cust No.",contextFontForTableHead));
			flightHeader6.setBorderWidthTop(5f);
			Cell flightHeader7 = new Cell(new Paragraph("Remark",contextFontForTableHead));
			flightHeader7.setBorderWidthTop(5f);
			
			
			flightData.addCell(flightHeader1);
			flightData.addCell(flightHeader2);
			flightData.addCell(flightHeader3);
			flightData.addCell(flightHeader4);
			flightData.addCell(flightHeader5);
			flightData.addCell(flightHeader6);
			flightData.addCell(flightHeader7);
			
			List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
			for(Customer customer:customers){
					customerFlights.addAll(customer.getCustomerFlight());
			}
			
			List<CustomerFlight> cfs = this.addList(customerFlights);
			if(cfs!=null){
			for(CustomerFlight flight: cfs){
				if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
				Cell date = new Cell();
				date.setBorder(0);
				date.setBorderColorBottom(Color.GRAY);
				date.setBorderWidthBottom(0.3f);
				//date.setMinimumHeight(36f);
				date.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				SimpleDateFormat simpleDateFormat=new SimpleDateFormat("MM/dd/yy");
				date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),contextFont));
				flightData.addCell(date);
				
				Cell airLine = new Cell();
				airLine.setBorder(0);
				airLine.setBorderColorBottom(Color.GRAY);
				airLine.setBorderWidthBottom(0.3f);
				//airLine.setMinimumHeight(36f);
				airLine.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				airLine.addElement(new Phrase(flight.getFlightCode(),contextFont));
				flightData.addCell(airLine);
				
				Cell flightNo = new Cell();
				flightNo.setBorder(0);
				flightNo.setBorderColorBottom(Color.GRAY);
				flightNo.setBorderWidthBottom(0.3f);
				//flightNo.setMinimumHeight(36f);
				flightNo.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				flightNo.addElement(new Phrase(flight.getFlightNumber(),contextFont));
				flightData.addCell(flightNo);
				Cell remark = new Cell();
				if(flight.getOutOrEnter()==1){
					Cell arrTime = new Cell();
					arrTime.setBorder(0);
					arrTime.setBorderColorBottom(Color.GRAY);
					arrTime.setBorderWidthBottom(0.3f);
					//arrTime.setMinimumHeight(36f);
					arrTime.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					arrTime.addElement(new Phrase(""));
					flightData.addCell(arrTime);
					
					Cell depTime = new Cell();
					depTime.setBorder(0);
					depTime.setBorderColorBottom(Color.GRAY);
					depTime.setBorderWidthBottom(0.3f);
					//depTime.setMinimumHeight(36f);
					depTime.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					depTime.addElement(new Phrase(flight.getArriveTime(),contextFont));
					flightData.addCell(depTime);
					
					remark.setBorder(0);
					remark.setBorderColorBottom(Color.GRAY);
					remark.setBorderWidthBottom(0.3f);
					//remark.setMinimumHeight(36f);
					remark.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					if(flight.getIfPickUp()==1){
						remark.addElement(new Phrase("pick up",contextFont));
					}else if(flight.getIfPickUp()==2){
						remark.addElement(new Phrase(""));
					}
				}else if(flight.getOutOrEnter()==2){
					Cell arrTime = new Cell();
					arrTime.setBorder(0);
					arrTime.setBorderColorBottom(Color.GRAY);
					arrTime.setBorderWidthBottom(0.3f);
					//arrTime.setMinimumHeight(36f);
					arrTime.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					arrTime.addElement(new Phrase(flight.getArriveTime(),contextFont));
					flightData.addCell(arrTime);
					
					Cell depTime = new Cell();
					depTime.setBorder(0);
					depTime.setBorderColorBottom(Color.GRAY);
					depTime.setBorderWidthBottom(0.3f);
					//depTime.setMinimumHeight(36f);
					depTime.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					depTime.addElement(new Phrase(""));
					flightData.addCell(depTime);
					
					remark.setBorder(0);
					remark.setBorderColorBottom(Color.GRAY);
					remark.setBorderWidthBottom(0.3f);
					//remark.setMinimumHeight(36f);
					remark.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					if(flight.getIfSendUp()==1){
						remark.addElement(new Phrase("drop off",contextFont));
					}else if(flight.getIfSendUp()==2){
						remark.addElement(new Phrase(""));
					}
				}
				
				
				Cell customerNo = new Cell();
				customerNo.setBorder(0);
				customerNo.setBorderColorBottom(Color.GRAY);
				customerNo.setBorderWidthBottom(0.3f);
				//customerNo.setMinimumHeight(36f);
				customerNo.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				customerNo.addElement(new Phrase(flight.getCustomerNos(),contextFont));
				flightData.addCell(customerNo);
				flightData.addCell(remark);
				}
			}
			}
			doc.add(flightData);
			
			//添加行程信息
			Paragraph groupRouteTittle = new Paragraph("TOUR ITINERARY",titleFontForBold);
			groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
			groupRouteTittle.setSpacingAfter(10f);
			groupRouteTittle.setSpacingBefore(15f);
			doc.add(groupRouteTittle);
			List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(groupLineId);
			for(GroupRoute groupRoute:groupRoutes){
				Paragraph dayNumAndRouteName = new Paragraph("Day"+groupRoute.getDayNum()+":	"+groupRoute.getRouteName(),contextFontForTittle);
				doc.add(dayNumAndRouteName);
				String routeDescribeForUs = "";
				if(groupRoute.getRouteDescribeForUs()!=null&&groupRoute.getRouteDescribeForUs().length()!=0){
					routeDescribeForUs = groupRoute.getRouteDescribeForUs().replaceAll("\r", "");
				}
				Paragraph routeDescForCh = new Paragraph(routeDescribeForUs,contextFont);
				routeDescForCh.setSpacingBefore(10f);
				routeDescForCh.setSpacingAfter(20f);
				doc.add(routeDescForCh);
			}
			
			//备注信息
			if(tourInfoOrder.getVoucherRemarks()!=null){
				Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",titleFontForBoldForRemark);
				voucherRemarksTittle.setSpacingBefore(12f);
				doc.add(voucherRemarksTittle);
				Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks().replaceAll("\r", ""),contextFontForRemark);
				voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
				doc.add(voucherRemarks);
			}
			
			//添加酒店信息
			Paragraph hotelInfoTittle = new Paragraph("HOTEL INFORMATION OR EQUIVALENT",titleFontForBold);
			hotelInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
			hotelInfoTittle.setSpacingBefore(15f);
			doc.add(hotelInfoTittle);
			
			Table hotelData = new Table(3);
			hotelData.setWidth(100);
			hotelData.setPadding(5f);
			float[] wids ={0.5f,0.20f,0.3f};
			hotelData.setWidths(wids);
			hotelData.getDefaultCell().setBorder(0);
			Cell tableHeader1= new Cell(new Paragraph("Name",contextFontForTableHead));
			tableHeader1.setBorderWidthTop(5f);
			Cell tableHeader2 = new Cell(new Paragraph("Tel",contextFontForTableHead));
			tableHeader2.setBorderWidthTop(5f);
			Cell tableHeader3 = new Cell(new Paragraph("Address",contextFontForTableHead));
			tableHeader3.setBorderWidthTop(5f);
			hotelData.addCell(tableHeader1);
			hotelData.addCell(tableHeader2);
			hotelData.addCell(tableHeader3);
			List<GroupLineHotelRel> groupLineHotelRels = groupLineForHotel.getGroupLineHotelRel();
			List<Hotel> hotelList = new ArrayList<Hotel>();
			
				for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
					Hotel hotel = groupLineHotelRel.getHotel();
					hotelList.add(hotel);
				}
			
			for(Hotel hotel:hotelList){
				Cell hotelName = new Cell();
				hotelName.setBorder(0);
				hotelName.setBorderColorBottom(Color.GRAY);
				hotelName.setBorderWidthBottom(0.3f);
				//hotelName.setMinimumHeight(36f);
				hotelName.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				hotelName.addElement(new Phrase(hotel.getHotelName(),contextFont));
				hotelData.addCell(hotelName);
				
				Cell tel = new Cell();
				tel.setBorder(0);
				tel.setBorderColorBottom(Color.GRAY);
				tel.setBorderWidthBottom(0.3f);
				//tel.setMinimumHeight(36f);
				tel.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				tel.addElement(new Phrase(hotel.getTel(),contextFont));
				hotelData.addCell(tel);
				
				Cell address = new Cell();
				address.setBorder(0);
				address.setBorderColorBottom(Color.GRAY);
				address.setBorderWidthBottom(0.3f);
				//address.setMinimumHeight(36f);
				address.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				address.addElement(new Phrase(hotel.getAddress(),contextFont));
				hotelData.addCell(address);
				
			}
			doc.add(hotelData);
			
			//添加特殊条款
			if(groupLine.getSpecificItems()!=null){
				Paragraph specificItemsTittle = new Paragraph("SPECIFIC ITEMS",titleFontForBold);
				specificItemsTittle.setSpacingBefore(12f);
				doc.add(specificItemsTittle);
				Paragraph specificItems = new Paragraph(groupLine.getSpecificItems()==null?"":groupLine.getSpecificItems().replaceAll("\r", ""),contextFont);
				specificItems.setAlignment(Paragraph.ALIGN_LEFT);
				doc.add(specificItems);
			}
			
			
			List<TourTypeOfDept> tourTypeOfDepts = tourTypeOfDeptMapper.findTourTypeIdByTourTypeId(groupLine.getTourTypeId()); 
			List<TourTypeOfDept> tourTypeOfDeptTemp = new ArrayList<TourTypeOfDept>();
			for(int i=0;i<tourTypeOfDepts.size();i++){
				int flag = 0;
				if(tourTypeOfDepts.get(i).getStartTime()!=null){
					if(tourTypeOfDepts.get(i).getStartTime().before(order.getCreateDate())){
						flag = 1;
					}
				}
				
				if(tourTypeOfDepts.get(i).getEndTime()!=null){
					if(tourTypeOfDepts.get(i).getEndTime().after(order.getCreateDate())){
						flag = 1;
					}
				}
				
				if(tourTypeOfDepts.get(i).getStartTime()==null&&tourTypeOfDepts.get(i).getEndTime()==null){
						flag = 1;
				}
				
				if(flag==1){
					tourTypeOfDeptTemp.add(tourTypeOfDepts.get(i));
				}
			}
			
			int contactForChange = 1;
			for(TourTypeOfDept tourTypeOfDe:tourTypeOfDeptTemp){
				String deptName = deptMapper.findById(tourTypeOfDe.getDeptId()).getDeptName();
				if(deptName.equals("SuZhou")){
					contactForChange = 2;
				}
			}
			if(contactForChange==2){ //中国美属于苏州
				//String cntactInfo = groupLine.getContactor();
				//联系人信息
				if(tourTypeOfDepts.get(0).getCode().equals("WJ-01")){
					Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",titleFontForBold);
					cntactTittle.setSpacingBefore(15f);
					doc.add(cntactTittle);
					Paragraph cntact = new Paragraph(Constant.CONTACT[2],titleFontForBold);
					doc.add(cntact);
				}else{
				Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",titleFontForBold);
				cntactTittle.setSpacingBefore(15f);
				doc.add(cntactTittle);
				Paragraph cntact = new Paragraph(Constant.CONTACT[0],contextFont);
				doc.add(cntact);
				}
			}else if(contactForChange==1){//其它属于西安
				Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",titleFontForBold);
				cntactTittle.setSpacingBefore(15f);
				doc.add(cntactTittle);
				Paragraph cntact = new Paragraph(Constant.CONTACT[1],contextFont);
				doc.add(cntact);
			}
			
			
			doc.close();
			        
			 ByteArrayInputStream byteArray=new ByteArrayInputStream(byteArrayOut.toByteArray());
			 byteArray.available();
			 byteArrayOut.close();
			return byteArray;
	}
	
	public  List<CustomerFlight> sortList(List<CustomerFlight> cfList){
    	List<CustomerFlight> list=new ArrayList<CustomerFlight>();
    	
    	for(CustomerFlight cf:cfList){
    		String strd=cf.getCustomerNos();
    		String[] cusNo=strd.split(",");
    		if(cusNo.length>0){
	    		int[] cusSortNo=sortStr(cusNo);
	    		String cusT=cusStrNo(cusSortNo);
	    		cf.setCustomerNos(cusT);
	    		list.add(cf);
    		}
    	}
    	
    	return list;
    }
    
    public  String cusStrNo(int[] str){
		String strs="";
		int c=1;
		int d=1;
		if(str.length==1){
			strs+=String.valueOf(str[0]);
		}
		for(int i=0;i<str.length-1;i++){
			int a=str[i];
			int b=str[i+1];
			if((b-a)==1){
				if(c==1){
					strs+=String.valueOf(a)+"-";
					c++;
				}
				
			}else if((b-a)==0){
				if(d==1){
					//strs+=String.valueOf(a)+",";
					d++;
				}
			}else{
				strs+=String.valueOf(a)+",";
				c=1;
				d=1;
			}
			if((i+2)==str.length){
				strs+=String.valueOf(b)+",";
			}

		}
		String s=strs.substring((strs.length()-1),strs.length());
		if(s.equals(",")){
			strs=strs.substring(0,strs.length()-1);
		}
		return strs;
    }
    
    public  int[] sortStr(String [] str){
		
		int[] strs=new int[str.length];
		
		for(int i=0;i<str.length;i++){
			if(!str[i].equals(""))
				strs[i]=Integer.parseInt(str[i]);
		}
		
		Arrays.sort(strs);
		return strs;
    }
    
    public List<CustomerFlight> addList(List<CustomerFlight> cList){
	 	List<CustomerFlight> list=new ArrayList<CustomerFlight>();
	 	List<CustomerFlight> lista=new ArrayList<CustomerFlight>();
	 	List<CustomerFlight> lists=new ArrayList<CustomerFlight>();
	 	
	 	lists.addAll(cList);
	 	for(int i=0;i<cList.size();i++){
	 		CustomerFlight cf=cList.get(i);
	 		String str="";
	 		int flag=0;
	 		for(int j=lists.size()-1;j>=0;j--){
	 			CustomerFlight cuf=lists.get(j);
	 			
	 			cuf.setFlightNumber(cuf.getFlightNumber()==null ?"":cuf.getFlightNumber());
	 			cf.setFlightNumber(cf.getFlightNumber()==null ?"":cf.getFlightNumber());
	 			cuf.setFlightCode(cuf.getFlightCode()==null ?"":cuf.getFlightCode());
	 			cf.setFlightCode(cf.getFlightCode()==null ?"":cf.getFlightCode());
				if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()!=null&& cuf.getUserId()!=null&& cf.getUserId().equals(cuf.getUserId())&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			} else if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()==null&& cuf.getUserId()==null&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}else if(cf.getArriveDate()==null&&cuf.getArriveDate()==null&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()!=null&& cuf.getUserId()!=null&& cf.getUserId().equals(cuf.getUserId())&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}else if(cf.getArriveDate()==null&&cuf.getArriveDate()==null&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()==null&& cuf.getUserId()==null&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}
	 		}
	
	 		if(str.length()>=1){
	 			str=str.substring(0,str.length()-1);
	 		}
	 		
	 		cf.setCustomerNos(str);
	 		if(flag==1){
	 			lista.add(cf);
	 		}
	 	}
	 	
	   	if(lista.size()==1){
	   		CustomerFlight cf=lista.get(0);
	   		cf.setCustomerNos(String.valueOf(cf.getCustomerNo()));
	   		lists.add(cf);
	 	}
 	
	   	list=sortList(lista);
	 	return list;
	 }
		
}
