package com.chinatour.service.impl;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Invoice;
import com.chinatour.entity.ItineraryInfo;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.TourTypeOfDept;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.CountryMapper;
import com.chinatour.persistence.CustomerFlightMapper;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.GroupLineHotelRelMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.persistence.ItineraryInfoMapper;
import com.chinatour.persistence.LanguageMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.PeerUserMapper;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.persistence.TourTypeOfDeptMapper;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.ItineraryInfoService;
import com.chinatour.service.OrderToPdfService;
import com.chinatour.util.FreemarkerUtils;
import com.chinatour.util.RemoveSpaceHtmlTag;
import com.chinatour.util.SettingUtils;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfCell;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfTable;
import com.lowagie.text.pdf.PdfWriter;

@Service("OderToPdfServiceImpl")
public class OderToPdfServiceImpl implements OrderToPdfService,ServletContextAware {
	
	@Resource(name="customerOrderRelMapper")
	private CustomerOrderRelMapper customerOrderRelMapper;
	
	@Resource(name="itineraryInfoMapper")
	private ItineraryInfoMapper itineraryInfoMapper;
	
	@Resource(name="orderMapper")
	private OrderMapper orderMapper;
	
	@Resource(name="customerMapper")
	private CustomerMapper customerMapper;
	
	@Resource(name="countryMapper")
	private CountryMapper countryMapper;
	
	@Resource(name="customerFlightMapper")
	private CustomerFlightMapper customerFlightMapper;
	
	@Resource(name="tourInfoForOrderMapper")
	private TourInfoForOrderMapper tourInfoForOrderMapper;
	
	@Resource(name="groupLineMapper")
	private GroupLineMapper groupLineMapper;
	
	@Resource(name="tourMapper")
	private TourMapper tourMapper;
	
	@Resource(name="groupRouteMapper")
	private GroupRouteMapper groupRouteMapper;
	
	@Resource(name="groupLineHotelRelMapper")
	private GroupLineHotelRelMapper groupLineHotelRelMapper;
	
	@Resource(name="ordersTotalMapper")
	private OrdersTotalMapper ordersTotalMapper;
	
	@Resource(name="venderMapper")
	private VenderMapper venderMapper;
	
	@Resource(name="deptMapper")
	private DeptMapper deptMapper;
	
	@Resource(name="languageMapper")
	private LanguageMapper languageMapper;
	
	@Resource(name="tourTypeOfDeptMapper")
	private TourTypeOfDeptMapper tourTypeOfDeptMapper;
	
	@Resource(name="adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	
	private ServletContext servletContext;
	@Autowired
	private PeerUserMapper peerUserMapper;
	@Autowired
	private ItineraryInfoService itineraryInfoService;
	
		public void setServletContext(ServletContext servletContext) {
			this.servletContext = servletContext;
		}


		@Override
		public String createPdf(Invoice invoice) {  //op修改之后一个子单的确认单
			Order order = invoice.getOrder();
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
//		    	Dept dept = deptMapper.findById(agent.getDeptId());
		    	addressString = agent.getAddress();
		    	telString = agent.getTel();
		    	mailString = agent.getEmail();
		    	agentString = order.getUserName();
		    }
			Tour tour = tourMapper.findById(order.getTourId());
			ItineraryInfo itineraryInfo = itineraryInfoMapper.findByTourIdWhithDel(tour.getTourId());
			//通过id号查询到对应的订单
			List<CustomerOrderRel> customerOrderRels = customerOrderRelMapper.findByOrderId(order.getId());
			
			//获取该订单所包含的客人
			List<Customer> customers = new ArrayList<Customer>();
			for(CustomerOrderRel customerOrderRel:customerOrderRels){
				if(customerOrderRel.getIsDel()==0||customerOrderRel.getIsDel()==3){
					Customer customer = customerMapper.findById(customerOrderRel.getCustomerId());
					//保存航班信息
					List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
					customerFlights = customerFlightMapper.findByCustomerOrderRelId(customerOrderRel.getId());
					customer.setCustomerFlight(customerFlights);
					customer.setCustomerOrderNo(customerOrderRel.getCustomerOrderNo());
					customers.add(customer);
				}
			}
			//获取订单对应的线路信息
			TourInfoForOrder tourInfoOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
			//获取线路
			String groupLineId = tourInfoOrder.getGroupLineId();
			GroupLine groupLine = groupLineMapper.findById(groupLineId);
			GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
			
			Setting setting = SettingUtils.get();
			String uploadPath = setting.getTempPDFPath();
			String destPath = null;
			
			
			try {
				Map<String, Object> model = new HashMap<String, Object>();
				String path = FreemarkerUtils.process(uploadPath, model);
				 destPath = path + "voucher-"+orderNumber+".pdf";
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
					Font norm_fontChinese = new Font(bfChinese, 9, Font.NORMAL, Color.BLACK);
					Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
					Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
							Color.BLACK);
					Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
							Color.BLACK);
					Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
					Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分
					Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
							Color.RED);   //备注信息标题显示为红色
			        
					document.open();
					
					//根据品牌选择logo
					String logo = "";
					if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
						logo = Constant.LOGO_PATH[0];
					}else if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[1])){
						logo = Constant.LOGO_PATH[1];
					}else if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[2])){
						logo = Constant.LOGO_PATH[2];
					}else{
						logo = Constant.LOGO_PATH[3];
					}
					// 添加抬头图片
					PdfPTable table1 = new PdfPTable(3); //表格两列
					table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					table1.setWidthPercentage(100);//表格的宽度为100%
					table1.getDefaultCell().setBorderWidth(0); //不显示边框
					table1.getDefaultCell().setBorderWidthBottom(0.3f);
					table1.getDefaultCell().setBorderColor(Color.GRAY);
					if(logo.equals(Constant.LOGO_PATH[3])){
						float[] wid1 ={0.45f,0.25f,0.30f};
						table1.setWidths(wid1);
					}else if(logo.equals(Constant.LOGO_PATH[1])||logo.equals(Constant.LOGO_PATH[2])){
						float[] wid1 ={0.2f,0.40f,0.30f};
						table1.setWidths(wid1);
					}else if(logo.equals(Constant.LOGO_PATH[0])){
						float[] wid1 ={0.25f,0.45f,0.30f};
						table1.setWidths(wid1);
					}
					Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logo);
					jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
					table1.addCell(jpeg);
					PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
					cell1.setBorder(0);
					cell1.setBorderWidthBottom(0.3f);
					cell1.setBorderColor(Color.GRAY);
					table1.addCell(cell1);
					//右侧嵌套一个表格
					PdfPTable table13 = new PdfPTable(1);
					table13.getDefaultCell().setBorderWidth(0);
					table13.getDefaultCell().setBorderWidthBottom(0.3f);
					table13.getDefaultCell().setBorderColor(Color.GRAY);
					PdfPCell cell2 = new PdfPCell(table13);
					cell2.setBorder(0);
					table1.addCell(cell2);
					
					PdfPCell cell21 = new PdfPCell(new Paragraph(addressString,norm_fontEng));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell cell24 = new PdfPCell(new Paragraph("",norm_fontEng));
					cell24.setBorder(0);
					cell24.setMinimumHeight(10f);
					table13.addCell(cell24);
					
					PdfPCell cell25 = new PdfPCell(new Paragraph("Tel:"+telString,norm_fontEng));
					cell25.setBorder(0);
					cell25.setMinimumHeight(10f);
					table13.addCell(cell25);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailString,norm_fontEng));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					cell26.setBorder(0);
					cell26.setBorderWidthBottom(0.3f);
					cell26.setBorderColor(Color.GRAY);
					table13.addCell(cell26);
					
					table1.addCell(cell1);
					document.add(table1);
					
					PdfContentByte cb=writer.getDirectContent();//划线
					
					//添加线路信息
					Paragraph lineTittle = new Paragraph(groupLine.getTourName()==null?"":groupLine.getTourName(),norm_fontChineseForTittle);
					lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
					lineTittle.setSpacingAfter(10f);
					lineTittle.setSpacingBefore(10f);
					document.add(lineTittle);
					PdfPTable lineInfo = new PdfPTable(3);
					lineInfo.setWidthPercentage(100);//表格的宽度为100%
					float[] wid2 ={0.33f,0.33f,0.33f}; //两列宽度的比例
					lineInfo.setWidths(wid2); 
					lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
					lineInfo.getDefaultCell().setMinimumHeight(25f);
					
					PdfPCell tourCode = new PdfPCell(new Paragraph(	 "Tour Code:	"+order.getTourCode()==null?"":order.getTourCode(),norm_fontEng));
					tourCode.setBorder(0);
					lineInfo.addCell(tourCode);
					
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
					SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
					String arriveTime = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
					String[] dates = arriveTime.split("-");
					String str = dates[1];
				    SimpleDateFormat sdf = new SimpleDateFormat("MM");
				    Date date1 = sdf.parse(str);
				    sdf = new SimpleDateFormat("MMMMM",Locale.US);
				    arriveTime = dates[0]+" "+sdf.format(date1)+" "+dates[2];
					PdfPCell arriveDate = new PdfPCell(new Paragraph("Tour Date:	"+arriveTime,norm_fontEng));
					arriveDate.setBorder(0);
					lineInfo.addCell(arriveDate);
					
					PdfPCell invoiceId = new PdfPCell(new Paragraph("Invoice Id:	"+order.getOrderNo(),norm_fontEng));
					invoiceId.setBorder(0);
					lineInfo.addCell(invoiceId);
					
						PdfPCell agent = new PdfPCell(new Paragraph("Agent:			"+agentString,norm_fontEng));
						agent.setBorder(0);
						lineInfo.addCell(agent);
					
					
					PdfPCell subAgent = new PdfPCell(new Paragraph("",norm_fontEng));
					subAgent.setBorder(0);
					lineInfo.addCell(subAgent);
					
					PdfPCell space = new PdfPCell(new Paragraph(" ",norm_fontEng));
					space.setBorder(0);
					lineInfo.addCell(space);
					document.add(lineInfo);
					/*cb.setLineWidth(0.3f);
					cb.moveTo(40f, 600f);
					cb.lineTo(560f, 600f);
					cb.setColorStroke(Color.GRAY);
					cb.stroke();*/
					
					//客人信息
					Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					customerInfoTittle.setSpacingAfter(10f);
					customerInfoTittle.setSpacingBefore(15f);
					document.add(customerInfoTittle);
					
					PdfPTable customerData = new PdfPTable(4);
					customerData.setWidthPercentage(100);
					float[] wid ={0.1f,0.40f,0.25f,0.25f};
					customerData.setWidths(wid);
					customerData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell customerHeader = new PdfPCell();
					customerHeader.setBorder(0);
					customerHeader.setBorderColorBottom(Color.GRAY);
					customerHeader.setBorderWidthBottom(0.3f);
					customerHeader.setBorderWidthTop(1.5f);
					customerHeader.setMinimumHeight(30f);
					customerHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					customerHeader.setMinimumHeight(25f);
					customerHeader.setBorderWidth(0.5f);
					customerHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					for(int i=0;i<customers.size();i++){
						PdfPCell customerNum = new PdfPCell();
						customerNum.setBorder(0);
						customerNum.setBorderColorBottom(Color.GRAY);
						customerNum.setBorderWidthBottom(0.3f);
						customerNum.setMinimumHeight(36f);
						customerNum.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						customerNum.addElement(new Phrase(Integer.toString(customers.get(i).getCustomerOrderNo()),norm_fontEng));
						customerData.addCell(customerNum);
						
						PdfPCell customerName = new PdfPCell();
						customerName.setBorder(0);
						customerName.setBorderColorBottom(Color.GRAY);
						customerName.setBorderWidthBottom(0.3f);
						customerName.setMinimumHeight(36f);
						customerName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						customerName.addElement(new Phrase(customers.get(i).getFirstName(),norm_fontEng));
						customerData.addCell(customerName);
						
						PdfPCell gender = new PdfPCell();
						gender.setBorder(0);
						gender.setBorderColorBottom(Color.GRAY);
						gender.setBorderWidthBottom(0.3f);
						gender.setMinimumHeight(36f);
						gender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						String sexForString = "";
						if(customers.get(i).getSex()==1){
							sexForString="female";
						}else if(customers.get(i).getSex()==2){
							sexForString="male";
						}
						gender.addElement(new Phrase(sexForString,norm_fontEng));
						customerData.addCell(gender);
						
						PdfPCell nationality = new PdfPCell();
						nationality.setBorder(0);
						nationality.setBorderColorBottom(Color.GRAY);
						nationality.setBorderWidthBottom(0.3f);
						nationality.setMinimumHeight(36f);
						nationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						nationality.addElement(new Phrase(customers.get(i).getNationalityOfPassport(),norm_fontEng));
						customerData.addCell(nationality);
					}
					document.add(customerData);
					
					//航班信息
					Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",bold_fontEng);
					flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					flightInfoTittle.setSpacingAfter(10f);
					flightInfoTittle.setSpacingBefore(15f);
					document.add(flightInfoTittle);
					
					PdfPTable flightData = new PdfPTable(6);
					flightData.setWidthPercentage(100);
					flightData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell flightHeader = new PdfPCell();
					
					flightHeader.setBorder(0);
					flightHeader.setBorderColorBottom(Color.GRAY);
					flightHeader.setBorderWidthBottom(0.3f);
					flightHeader.setBorderWidthTop(1.5f);
					flightHeader.setMinimumHeight(30f);
					flightHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					flightHeader.setMinimumHeight(25f);
					flightHeader.setBorderWidth(0.5f);
					flightHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Dep.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Arr.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Cust No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					
					List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
					for(Customer customer:customers){
						customerFlights.addAll(customer.getCustomerFlight());
					}
					List<CustomerFlight> cfs = this.addList(customerFlights);
					
					for(CustomerFlight flight: cfs){
					 if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
						PdfPCell date = new PdfPCell();
						date.setBorder(0);
						date.setBorderColorBottom(Color.GRAY);
						date.setBorderWidthBottom(0.3f);
						date.setMinimumHeight(36f);
						date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("MM/dd/yy");
						date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),norm_fontEng));
						flightData.addCell(date);
						
						PdfPCell airLine = new PdfPCell();
						airLine.setBorder(0);
						airLine.setBorderColorBottom(Color.GRAY);
						airLine.setBorderWidthBottom(0.3f);
						airLine.setMinimumHeight(36f);
						airLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						airLine.addElement(new Phrase(flight.getFlightCode(),norm_fontEng));
						flightData.addCell(airLine);
						
						PdfPCell flightNo = new PdfPCell();
						flightNo.setBorder(0);
						flightNo.setBorderColorBottom(Color.GRAY);
						flightNo.setBorderWidthBottom(0.3f);
						flightNo.setMinimumHeight(36f);
						flightNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						flightNo.addElement(new Phrase(flight.getFlightNumber(),norm_fontEng));
						flightData.addCell(flightNo);
						PdfPCell remark = new PdfPCell();
						if(flight.getOutOrEnter()==1){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase("pick up",norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfPickUp()==1){
								remark.addElement(new Phrase("",norm_fontEng));
							}else if(flight.getIfPickUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}else if(flight.getOutOrEnter()==2){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase("drop off",norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfSendUp()==1){
								remark.addElement(new Phrase("",norm_fontEng));
							}else if(flight.getIfSendUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}
						
						
						PdfPCell customerNo = new PdfPCell();
						customerNo.setBorder(0);
						customerNo.setBorderColorBottom(Color.GRAY);
						customerNo.setBorderWidthBottom(0.3f);
						customerNo.setMinimumHeight(36f);
						customerNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						customerNo.addElement(new Phrase(flight.getCustomerNos(),norm_fontEng));
						flightData.addCell(customerNo);
						flightData.addCell(remark);
					}
					}
					
					document.add(flightData);
					
					
					//备注信息
					if(tourInfoOrder.getVoucherRemarks()!=null){
						Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",bold_fontEngForRemarks);
						voucherRemarksTittle.setSpacingBefore(12f);
						document.add(voucherRemarksTittle);
						Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks(),norm_fontChineseForRemarks);
						voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(voucherRemarks);
					}
					//添加行程信息
					Paragraph groupRouteTittle = new Paragraph("TOUR 	ITINERARY",bold_fontEng);
					groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
					groupRouteTittle.setSpacingAfter(10f);
					groupRouteTittle.setSpacingBefore(15f);
					document.add(groupRouteTittle);
					List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(groupLineId);
					for(GroupRoute groupRoute:groupRoutes){
						Paragraph dayNumAndRouteName = new Paragraph("Day"+groupRoute.getDayNum()+":	"+groupRoute.getRouteName(),norm_fontChineseForHead);
						document.add(dayNumAndRouteName);
						Paragraph routeDesc = new Paragraph(groupRoute.getRouteDescribeForEn(),norm_fontChinese);
						routeDesc.setSpacingAfter(20f);
						document.add(routeDesc);
					}
					//op修改之后的酒店信息itineraryInfo
					
					
					String hotelInfo = itineraryInfo.getHotelInfo();
					String[] hotelInfos = hotelInfo.split("#");
					List<Hotel> hotels = new ArrayList<Hotel>();
					for(String hos:hotelInfos){
						Hotel hotel = new Hotel();
						String[] ho = hos.split("%");
						for(int i=0;i<ho.length;i++){
							hotel.setDayNum(Integer.parseInt(ho[0]));
							hotel.setHotelName(ho[1]);
							hotel.setStandard(ho[2]);
							hotel.setCityName(ho[3]);
							hotel.setAddress(ho[4]);
							hotel.setTel(ho[5]);
						}
						hotels.add(hotel);
					}
					//添加酒店信息
					Paragraph hotelInfoTittle = new Paragraph("HOTEL INFORMATION OR EQUIVALENT",bold_fontEng);
					hotelInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					hotelInfoTittle.setSpacingAfter(10f);
					hotelInfoTittle.setSpacingBefore(15f);
					document.add(hotelInfoTittle);
					
					PdfPTable hotelData = new PdfPTable(4);
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
					tableHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Tel",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Address",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					for(Hotel hotel:hotels){
						
						PdfPCell hotelDate = new PdfPCell();
						hotelDate.setBorder(0);
						hotelDate.setBorderColorBottom(Color.GRAY);
						hotelDate.setBorderWidthBottom(0.3f);
						hotelDate.setMinimumHeight(36f);
						hotelDate.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						hotelDate.addElement(new Phrase("Day  "+hotel.getDayNum(),norm_fontEng));
						hotelData.addCell(hotelDate);
						
						PdfPCell hotelName = new PdfPCell();
						hotelName.setBorder(0);
						hotelName.setBorderColorBottom(Color.GRAY);
						hotelName.setBorderWidthBottom(0.3f);
						hotelName.setMinimumHeight(36f);
						hotelName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						hotelName.addElement(new Phrase(hotel.getHotelName()+"(或同级)",norm_fontEng));
						hotelData.addCell(hotelName);
						
						PdfPCell tel = new PdfPCell();
						tel.setBorder(0);
						tel.setBorderColorBottom(Color.GRAY);
						tel.setBorderWidthBottom(0.3f);
						tel.setMinimumHeight(36f);
						tel.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						tel.addElement(new Phrase(hotel.getTel(),norm_fontEng));
						hotelData.addCell(tel);
						
						PdfPCell address = new PdfPCell();
						address.setBorder(0);
						address.setBorderColorBottom(Color.GRAY);
						address.setBorderWidthBottom(0.3f);
						address.setMinimumHeight(36f);
						address.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						address.addElement(new Phrase(hotel.getAddress(),norm_fontEng));
						hotelData.addCell(address);
						
					}
					document.add(hotelData);
					
					
					
					//添加特殊条款
					if(groupLine.getSpecificItems()!=null){
						Paragraph specificItemsTittle = new Paragraph("SPECIFIC ITEMS",bold_fontEng);
						specificItemsTittle.setSpacingBefore(12f);
						document.add(specificItemsTittle);
						Paragraph specificItems = new Paragraph(groupLine.getSpecificItems()==null?"":groupLine.getSpecificItems(),norm_fontChinese);
						specificItems.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(specificItems);
					}
					
					/*TourTypeOfDept tourTypeOfDeptTemp = new TourTypeOfDept();
					tourTypeOfDeptTemp.setTourTypeId(groupLine.getTourTypeId());
					tourTypeOfDeptTemp.setOrderTime(order.getCreateDate());*/
					List<TourTypeOfDept> tourTypeOfDepts = tourTypeOfDeptMapper.findTourTypeIdByTourTypeId(order.getId()); 
					List<TourTypeOfDept> tourTypeOfDeptTemp = new ArrayList<TourTypeOfDept>();
					for(TourTypeOfDept tourTypeOfDept:tourTypeOfDepts){
						boolean flag = false;
						if(tourTypeOfDept.getStartTime()!=null){
							if(tourTypeOfDept.getStartTime().before(order.getCreateDate())){
								flag = true;
							}
						}
						
						if(tourTypeOfDept.getEndTime()!=null){
							if(tourTypeOfDept.getEndTime().after(order.getCreateDate())){
								flag = true;
							}
						}
						
						if(tourTypeOfDept.getStartTime()==null&&tourTypeOfDept.getEndTime()==null){
								flag = true;
						}
						
						if(flag==true){
							tourTypeOfDeptTemp.add(tourTypeOfDept);
						}
					}
					
					int contactForChange = 1;
					for(TourTypeOfDept tourTypeOfDe:tourTypeOfDeptTemp){
						String deptName = deptMapper.findById(tourTypeOfDe.getDeptId()).getDeptName();
						if(deptName.equals("SuZhou")){
							contactForChange = 2;
						}else if(deptName.equals("Australia")){
							contactForChange = 3;
						}
					}
					
					//联系人信息：按品牌（中国美属于苏州，其它属于西安）
					if(contactForChange==2){ //中国美属于苏州
						//String cntactInfo = groupLine.getContactor();
						//联系人信息
						if(tourTypeOfDepts.get(0).getCode().equals("WJ-01")){//文景假期欧洲团的联系人信息
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[2],norm_fontChinese);
							document.add(cntact);
						}else if(tourTypeOfDepts.get(0).getCode().contains("CN")){
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[0],norm_fontChinese);
							document.add(cntact);
							Paragraph cntact1 = new Paragraph(Constant.CONTACT[3],conSpe);
							document.add(cntact1);
						}
					}else if(contactForChange==1){//其它属于西安
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(Constant.CONTACT[1],norm_fontEng);
						document.add(cntact);
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
		public String createNewPdf(String itineraryInfoId,List<Hotel> hotels,String tourId,Order order) {
			// Order order = orderMapper.findCustomerForOrderId(orderId); //查找订单下的所有客人
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
//			    	Dept dept = deptMapper.findById(agent.getDeptId());
			    	addressString = agent.getAddress();
			    	telString = agent.getTel();
			    	mailString = agent.getEmail();
			    	agentString = order.getUserName();
			    }
			    List<Customer> customers = new ArrayList<Customer>();
				List<CustomerOrderRel> customerOrderRelList=order.getCustomerOrderRel();
				for(int j=0;j<customerOrderRelList.size();j++){
					if(customerOrderRelList.get(j).getIsDel()==0||customerOrderRelList.get(j).getIsDel()==3){
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
			TourInfoForOrder tourInfoOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
			//获取线路
			String groupLineId = tourInfoOrder.getGroupLineId();
			if(groupLineId==null ||groupLineId.equals("")){
				return "No";
			}
			GroupLine groupLine = groupLineMapper.findById(groupLineId);
			GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
			
			Setting setting = SettingUtils.get();
			String uploadPath = setting.getTempPDFPath();
			String destPath = null;
			try {
				Map<String, Object> model = new HashMap<String, Object>();
				String path = FreemarkerUtils.process(uploadPath, model);
				 destPath = path + "voucher-"+orderNumber+".pdf"; //文件名为
				File destFile = new File(servletContext.getRealPath(destPath));
				if (!destFile.getParentFile().exists()) {
					destFile.getParentFile().mkdirs();
				}
				
				// 创建一个Document对象
				Document document = new Document(PageSize.A4, 36, 36, 24, 36);
				try {
					// 建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中,生成名为 ***.pdf 的文档

					/**
					 * 新建一个字体,iText的方法 STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀
					 * UniGB-UCS2-H 是编码，在iTextAsian.jar 中以cmap为后缀 H 代表文字版式是 横版， 相应的 V
					 * 代表竖版
					 */
					PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(servletContext.getRealPath(destPath)));
					String utilPath = servletContext.getRealPath("/")+"resources/fonts/font-awesome-4/fonts/";
					BaseFont bfEng = BaseFont.createFont(utilPath + "calibriz.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
					Font norm_fontEng = new Font(bfEng, 11, Font.NORMAL, Color.BLACK);
					BaseFont bfChinese = BaseFont.createFont(utilPath+"SIMYOU.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
					Font norm_fontChinese = new Font(bfChinese, 9, Font.NORMAL, Color.BLACK);
					Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
					Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
							Color.BLACK);
					Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
							Color.BLACK);
					Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
					Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
							Color.RED);   //备注信息标题显示为红色
					Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分

			        
					document.open();
					// 添加抬头图片
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
					PdfPTable table1 = new PdfPTable(3); //表格两列
					table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					table1.setWidthPercentage(100);//表格的宽度为100%
					table1.getDefaultCell().setBorderWidth(0); //不显示边框
					table1.getDefaultCell().setBorderColor(Color.GRAY);
					if(logoPath.equals(Constant.LOGO_PATH[3])){
						float[] wid1 ={0.45f,0.25f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[1])){
						float[] wid1 ={0.2f,0.40f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[0])){
						float[] wid1 ={0.25f,0.45f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[2])){
						float[] wid1 ={0.45f,0.25f,0.30f};
						table1.setWidths(wid1);
					}
					Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logoPath);
					jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
					table1.addCell(jpeg);
					PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
					cell1.setBorder(0);
					cell1.setBorderColor(Color.GRAY);
					table1.addCell(cell1);
					//右侧嵌套一个表格
					PdfPTable table13 = new PdfPTable(1);
					table13.getDefaultCell().setBorderWidth(0);
					PdfPCell cell2 = new PdfPCell(table13);
					cell2.setBorder(0);
					table1.addCell(cell2);
					
					PdfPCell cell21 = new PdfPCell(new Paragraph(addressString,norm_fontEng));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell cell24 = new PdfPCell(new Paragraph("",norm_fontEng));
					cell24.setBorder(0);
					cell24.setMinimumHeight(10f);
					table13.addCell(cell24);
					
					PdfPCell cell25 = new PdfPCell(new Paragraph("Tel:"+telString,norm_fontEng));
					cell25.setBorder(0);
					cell25.setMinimumHeight(10f);
					table13.addCell(cell25);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailString,norm_fontEng));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					table13.addCell(cell26);
					
					table1.addCell(cell1);
					document.add(table1);
					
					PdfContentByte cb=writer.getDirectContent();
					//添加线路信息
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
					Paragraph lineTittle = new Paragraph(groupLine.getTourName(),norm_fontChineseForTittle);
					lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
					lineTittle.setSpacingAfter(10f);
					lineTittle.setSpacingBefore(10f);
					document.add(lineTittle);
					PdfPTable lineInfo = new PdfPTable(3);
					lineInfo.setWidthPercentage(100);//表格的宽度为100%
					float[] wid2 ={0.33f,0.33f,0.33f}; //两列宽度的比例
					lineInfo.setWidths(wid2); 
					lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
					lineInfo.getDefaultCell().setMinimumHeight(25f);
					
					PdfPCell tourCode = new PdfPCell(new Paragraph(	 "Tour Code:	"+tourInfoForOrder.getScheduleLineCode(),norm_fontEng));
					tourCode.setBorder(0);
					lineInfo.addCell(tourCode);
					
					
					SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
					String departureDate = dateFormat.format(tourInfoForOrder.getDepartureDate());
					String[] dates = departureDate.split("-");
					String str = dates[1];
				    SimpleDateFormat sdf = new SimpleDateFormat("MM");
				    Date date1 = sdf.parse(str);
				    sdf = new SimpleDateFormat("MMMMM",Locale.US);
				    departureDate = dates[0]+" "+sdf.format(date1)+" "+dates[2];
					PdfPCell arriveDate = new PdfPCell(new Paragraph("Departure Date:	"+departureDate,norm_fontEng));
					arriveDate.setBorder(0);
					lineInfo.addCell(arriveDate);
					
					PdfPCell invoiceId = new PdfPCell(new Paragraph("Invoice Id:	"+order.getOrderNo(),norm_fontEng));
					invoiceId.setBorder(0);
					lineInfo.addCell(invoiceId);
						PdfPCell agent = new PdfPCell(new Paragraph("Agent:			"+agentString,norm_fontEng));
						agent.setBorder(0);
						lineInfo.addCell(agent);
					
					PdfPCell subAgent = new PdfPCell(new Paragraph("",norm_fontEng));
					subAgent.setBorder(0);
					lineInfo.addCell(subAgent);
					
					PdfPCell space = new PdfPCell(new Paragraph(" ",norm_fontEng));
					space.setBorder(0);
					lineInfo.addCell(space);
					document.add(lineInfo);
					
					//客人信息
					Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					customerInfoTittle.setSpacingAfter(10f);
					customerInfoTittle.setSpacingBefore(15f);
					document.add(customerInfoTittle);
					
					PdfPTable customerData = new PdfPTable(4);
					customerData.setWidthPercentage(100);
					float[] wid ={0.1f,0.40f,0.25f,0.25f};
					customerData.setWidths(wid);
					customerData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell customerHeader = new PdfPCell();
					customerHeader.setBorder(0);
					customerHeader.setBorderColorBottom(Color.GRAY);
					customerHeader.setBorderWidthBottom(0.3f);
					customerHeader.setBorderWidthTop(1.5f);
					customerHeader.setMinimumHeight(30f);
					customerHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					customerHeader.setMinimumHeight(25f);
					customerHeader.setBorderWidth(0.5f);
					customerHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					for(int i=0;i<customers.size();i++){
							PdfPCell customerNum = new PdfPCell();
							customerNum.setBorder(0);
							customerNum.setBorderColorBottom(Color.GRAY);
							customerNum.setBorderWidthBottom(0.3f);
							customerNum.setMinimumHeight(36f);
							customerNum.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerNum.addElement(new Phrase(customers.get(i).getCustomerOrderNo().toString(),norm_fontEng));
							customerData.addCell(customerNum);
							
							PdfPCell customerName = new PdfPCell();
							customerName.setBorder(0);
							customerName.setBorderColorBottom(Color.GRAY);
							customerName.setBorderWidthBottom(0.3f);
							customerName.setMinimumHeight(36f);
							String middleName = customers.get(i).getMiddleName()+"/";
							if(customers.get(i).getMiddleName()==null||customers.get(i).getMiddleName()==""){
								middleName = "";
							}
							customerName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerName.addElement(new Phrase(customers.get(i).getLastName()+"/"+middleName+customers.get(i).getFirstName(),norm_fontChineseForContent));
							customerData.addCell(customerName);
							
							PdfPCell gender = new PdfPCell();
							gender.setBorder(0);
							gender.setBorderColorBottom(Color.GRAY);
							gender.setBorderWidthBottom(0.3f);
							gender.setMinimumHeight(36f);
							gender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String sexForString = "";
							if(customers.get(i).getSex()==1){
								sexForString="female";
							}else if(customers.get(i).getSex()==2){
								sexForString="male";
							}
							gender.addElement(new Phrase(sexForString,norm_fontEng));
							customerData.addCell(gender);
							
							PdfPCell nationality = new PdfPCell();
							nationality.setBorder(0);
							nationality.setBorderColorBottom(Color.GRAY);
							nationality.setBorderWidthBottom(0.3f);
							nationality.setMinimumHeight(36f);
							nationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							nationality.addElement(new Phrase(customers.get(i).getNationalityOfPassport(),norm_fontEng));
							customerData.addCell(nationality);
					}
					document.add(customerData);
					
					//航班信息
					Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",bold_fontEng);
					flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					flightInfoTittle.setSpacingAfter(10f);
					flightInfoTittle.setSpacingBefore(15f);
					document.add(flightInfoTittle);
					
					PdfPTable flightData = new PdfPTable(7);
					flightData.setWidthPercentage(100);
					flightData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell flightHeader = new PdfPCell();
					
					flightHeader.setBorder(0);
					flightHeader.setBorderColorBottom(Color.GRAY);
					flightHeader.setBorderWidthBottom(0.3f);
					flightHeader.setBorderWidthTop(1.5f);
					flightHeader.setMinimumHeight(30f);
					flightHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					flightHeader.setMinimumHeight(25f);
					flightHeader.setBorderWidth(0.5f);
					flightHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Dep.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Arr.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Cust No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					
					List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
					for(Customer customer:customers){
						customerFlights.addAll(customer.getCustomerFlight());
					}
					List<CustomerFlight> cfs = this.addList(customerFlights);
					
					for(CustomerFlight flight: cfs){
					 if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
						PdfPCell date = new PdfPCell();
						date.setBorder(0);
						date.setBorderColorBottom(Color.GRAY);
						date.setBorderWidthBottom(0.3f);
						date.setMinimumHeight(36f);
						date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("MM/dd/yy");
						date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),norm_fontEng));
						flightData.addCell(date);
						
						PdfPCell airLine = new PdfPCell();
						airLine.setBorder(0);
						airLine.setBorderColorBottom(Color.GRAY);
						airLine.setBorderWidthBottom(0.3f);
						airLine.setMinimumHeight(36f);
						airLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						airLine.addElement(new Phrase(flight.getFlightCode(),norm_fontEng));
						flightData.addCell(airLine);
						
						PdfPCell flightNo = new PdfPCell();
						flightNo.setBorder(0);
						flightNo.setBorderColorBottom(Color.GRAY);
						flightNo.setBorderWidthBottom(0.3f);
						flightNo.setMinimumHeight(36f);
						flightNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						flightNo.addElement(new Phrase(flight.getFlightNumber(),norm_fontEng));
						flightData.addCell(flightNo);
						PdfPCell remark = new PdfPCell();
						if(flight.getOutOrEnter()==1){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase("",norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfPickUp()==1){
								remark.addElement(new Phrase("pick up",norm_fontEng));
							}else if(flight.getIfPickUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}else if(flight.getOutOrEnter()==2){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase("",norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfSendUp()==1){
								remark.addElement(new Phrase("drop off",norm_fontEng));
							}else if(flight.getIfSendUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}
						
						
						PdfPCell customerNo = new PdfPCell();
						customerNo.setBorder(0);
						customerNo.setBorderColorBottom(Color.GRAY);
						customerNo.setBorderWidthBottom(0.3f);
						customerNo.setMinimumHeight(36f);
						customerNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						customerNo.addElement(new Phrase(flight.getCustomerNos(),norm_fontEng));
						flightData.addCell(customerNo);
						flightData.addCell(remark);
					}
					}
					
					document.add(flightData);
					
					//备注信息
					if(tourInfoOrder.getVoucherRemarks()!=null){
						Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",bold_fontEngForRemarks);
						voucherRemarksTittle.setSpacingBefore(12f);
						document.add(voucherRemarksTittle);
						Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks(),norm_fontChineseForRemarks);
						voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(voucherRemarks);
					}
					//添加行程信息
					Paragraph groupRouteTittle = new Paragraph("TOUR 	ITINERARY",bold_fontEng);
					groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
					groupRouteTittle.setSpacingAfter(10f);
					groupRouteTittle.setSpacingBefore(15f);
					document.add(groupRouteTittle);
					List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(groupLineId);
					for(GroupRoute groupRoute:groupRoutes){
						Paragraph dayNumAndRouteName = new Paragraph("Day"+groupRoute.getDayNum()+":	"+groupRoute.getRouteName(),norm_fontChineseForHead);
						document.add(dayNumAndRouteName);
						Paragraph routeDesc = new Paragraph(groupRoute.getRouteDescribeForEn(),norm_fontChinese);
						routeDesc.setSpacingAfter(20f);
						document.add(routeDesc);
					}
					
					
					//添加酒店信息
					Paragraph hotelInfoTittle = new Paragraph("HOTEL INFORMATION OR EQUIVALENT",bold_fontEng);
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
					tableHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Tel",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Address",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					List<GroupLineHotelRel> groupLineHotelRels = groupLineForHotel.getGroupLineHotelRel();
					List<Hotel> hotelList = new ArrayList<Hotel>();
					
					if(hotels.size()!=0){
						hotelList = hotels;
					}else{
						
						for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
							Hotel hotel = groupLineHotelRel.getHotel();
							hotelList.add(hotel);
						}
					}
					for(Hotel hotel:hotelList){
						PdfPCell hotelName = new PdfPCell();
						hotelName.setBorder(0);
						hotelName.setBorderColorBottom(Color.GRAY);
						hotelName.setBorderWidthBottom(0.3f);
						hotelName.setMinimumHeight(36f);
						hotelName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						hotelName.addElement(new Phrase(hotel.getHotelName()+"(或同级)",norm_fontChineseForContent));
						hotelData.addCell(hotelName);
						
						PdfPCell tel = new PdfPCell();
						tel.setBorder(0);
						tel.setBorderColorBottom(Color.GRAY);
						tel.setBorderWidthBottom(0.3f);
						tel.setMinimumHeight(36f);
						tel.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						tel.addElement(new Phrase(hotel.getTel(),norm_fontEng));
						hotelData.addCell(tel);
						
						PdfPCell address = new PdfPCell();
						address.setBorder(0);
						address.setBorderColorBottom(Color.GRAY);
						address.setBorderWidthBottom(0.3f);
						address.setMinimumHeight(36f);
						address.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						address.addElement(new Phrase(hotel.getAddress(),norm_fontChineseForContent));
						hotelData.addCell(address);
						
					}
					document.add(hotelData);
					
					
					//添加特殊条款
					//添加特殊条款
					if(groupLine.getSpecificItems()!=null){
						Paragraph specificItemsTittle = new Paragraph("SPECIFIC ITEMS",bold_fontEng);
						specificItemsTittle.setSpacingBefore(12f);
						document.add(specificItemsTittle);
						Paragraph specificItems = new Paragraph(groupLine.getSpecificItems()==null?"":groupLine.getSpecificItems(),norm_fontChinese);
						specificItems.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(specificItems);
					}
					if(groupLine.getContactor()!=null&&groupLine.getContactor()!=""){
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(groupLine.getContactor(),norm_fontChinese);
						document.add(cntact);
					}else{
					List<TourTypeOfDept> tourTypeOfDepts = tourTypeOfDeptMapper.findTourTypeIdByTourTypeId(order.getId()); 
					List<TourTypeOfDept> tourTypeOfDeptTemp = new ArrayList<TourTypeOfDept>();
					for(TourTypeOfDept tourTypeOfDept:tourTypeOfDepts){
						boolean flag = false;
						if(tourTypeOfDept.getStartTime()!=null){
							if(tourTypeOfDept.getStartTime().before(order.getCreateDate())){
								flag = true;
							}
						}
						
						if(tourTypeOfDept.getEndTime()!=null){
							if(tourTypeOfDept.getEndTime().after(order.getCreateDate())){
								flag = true;
							}
						}
						
						if(tourTypeOfDept.getStartTime()==null&&tourTypeOfDept.getEndTime()==null){
								flag = true;
						}
						
						if(flag==true){
							tourTypeOfDeptTemp.add(tourTypeOfDept);
						}
					}
					
					int contactForChange = 1;
					for(TourTypeOfDept tourTypeOfDe:tourTypeOfDeptTemp){
						String deptName = deptMapper.findById(tourTypeOfDe.getDeptId()).getDeptName();
						if(deptName.equals("SuZhou")){
							contactForChange = 2;
						}else if(deptName.equals("Australia")){
							contactForChange = 3;
						}
					}
					
					//联系人信息：按品牌（中国美属于苏州，其它属于西安）
					if(contactForChange==2){ //中国美属于苏州
						//String cntactInfo = groupLine.getContactor();
						//联系人信息
						if(tourTypeOfDepts.get(0).getCode().equals("WJ-01")){//文景假期欧洲团的联系人信息
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[2],norm_fontChinese);
							document.add(cntact);
						}else{
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[0],norm_fontChinese);
							document.add(cntact);
							Paragraph cntact1 = new Paragraph(Constant.CONTACT[3],conSpe);
							document.add(cntact1);
						}
					}else if(contactForChange==1){//其它属于西安
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(Constant.CONTACT[1],norm_fontEng);
						document.add(cntact);
					}
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

		
		//op修改之前一个子单的确认单
		@Override
		public String createOldPdf(String orderId) {
			    Order order = orderMapper.findCustomerForOrderId(orderId); //查找订单下的所有客人case 
			    String status="";
			    if(order.getReviewState()==1||order.getReviewState()==5){
			    	status="PENDING";
			    }else if(order.getReviewState()==2){
			    	status="CONFIRMED";
			    }else if(order.getReviewState()==3){
			    	status="DECLINE";
			    }else{
			    	status="PENDING";
			    }
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
//			    	Dept dept = deptMapper.findById(agent.getDeptId());
			    	addressString = agent.getAddress();
			    	telString = agent.getTel();
			    	mailString = agent.getEmail();
			    	agentString = order.getUserName();
			    }
			    List<Customer> customers = new ArrayList<Customer>();
				List<CustomerOrderRel> customerOrderRelList=order.getCustomerOrderRel();
				for(int j=0;j<customerOrderRelList.size();j++){
					if(customerOrderRelList.get(j).getIsDel()==0||customerOrderRelList.get(j).getIsDel()==3){
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
			if(groupLineId==null ||groupLineId.equals("")){
				return "No";
			}
			GroupLine groupLine = groupLineMapper.findById(groupLineId);
			if(groupLine.getSpecificItems()!=null && !groupLine.getSpecificItems().equals("")){
				groupLine.setSpecificItems(RemoveSpaceHtmlTag.RemoveSpaceHtmlTag(groupLine.getSpecificItems()));
			}
			
			GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
			
			Setting setting = SettingUtils.get();
			String uploadPath = setting.getTempPDFPath();
			String destPath = null;
			try {
				Map<String, Object> model = new HashMap<String, Object>();
				String path = FreemarkerUtils.process(uploadPath, model);
				destPath = path + "voucher-"+orderNumber+".pdf";
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
					Font norm_fontChinese = new Font(bfChinese, 10, Font.NORMAL, Color.BLACK);
					Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
					Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
					Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
							Color.BLACK);
					Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
							Color.RED);   //备注信息显示为红色
					Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
							Color.BLACK);
					Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分

					/**
					 * 新建一个字体,iText的方法 STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀
					 * UniGB-UCS2-H 是编码，在iTextAsian.jar 中以cmap为后缀 H 代表文字版式是 横版， 相应的 V
					 * 代表竖版
					 */
					
					document.open();
					// 添加抬头图片
					
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
					PdfPTable table1 = new PdfPTable(3); //表格两列
					table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					table1.setWidthPercentage(100);//表格的宽度为100%
					table1.getDefaultCell().setBorderWidth(0); //不显示边框
					table1.getDefaultCell().setBorderColor(Color.GRAY);
					if(logoPath.equals(Constant.LOGO_PATH[3])){
						float[] wid1 ={0.30f,0.40f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[1])){
						float[] wid1 ={0.2f,0.50f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[0])){
						float[] wid1 ={0.25f,0.45f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[2])){
						float[] wid1 ={0.3f,0.40f,0.30f};
						table1.setWidths(wid1);
					}
					Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logoPath);
					jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
					table1.addCell(jpeg);
					PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
					cell1.setBorder(0);
					cell1.setBorderColor(Color.GRAY);
					table1.addCell(cell1);
					//右侧嵌套一个表格
					PdfPTable table13 = new PdfPTable(1);
					table13.getDefaultCell().setBorderWidth(0);
					PdfPCell cell2 = new PdfPCell(table13);
					cell2.setBorder(0);
					table1.addCell(cell2);
					
					PdfPCell cell21 = new PdfPCell(new Paragraph(addressString,norm_fontEng));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell cell24 = new PdfPCell(new Paragraph("",norm_fontEng));
					cell24.setBorder(0);
					cell24.setMinimumHeight(10f);
					table13.addCell(cell24);
					
					PdfPCell cell25 = new PdfPCell(new Paragraph("Tel:"+telString,norm_fontEng));
					cell25.setBorder(0);
					cell25.setMinimumHeight(10f);
					table13.addCell(cell25);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailString,norm_fontEng));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					table13.addCell(cell26);
					
					table1.addCell(cell1);
					document.add(table1);
					
					PdfContentByte cb=writer.getDirectContent();
					
					//添加线路信息
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
					Paragraph lineTittle = new Paragraph(groupLine.getTourName(),norm_fontChineseForTittle);
					lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
					lineTittle.setSpacingAfter(10f);
					lineTittle.setSpacingBefore(10f);
					document.add(lineTittle);
					PdfPTable lineInfo = new PdfPTable(3);
					lineInfo.setWidthPercentage(100);//表格的宽度为100%
					float[] wid2 ={0.33f,0.33f,0.33f}; //两列宽度的比例
					lineInfo.setWidths(wid2); 
					lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
					lineInfo.getDefaultCell().setMinimumHeight(25f);
					
					PdfPCell tourCode = new PdfPCell(new Paragraph(	 "Tour Code:	"+tourInfoForOrder.getScheduleLineCode(),norm_fontEng));
					tourCode.setBorder(0);
					lineInfo.addCell(tourCode);
					
					
					SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
					String departureDate="";
					if(tourInfoForOrder.getScheduleOfArriveTime()!=null){
						departureDate = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
						String[] dates = departureDate.split("-");
						String str = dates[1];
					    SimpleDateFormat sdf = new SimpleDateFormat("MM");
					    Date date1 = sdf.parse(str);
					    sdf = new SimpleDateFormat("MMMMM",Locale.US);
					    departureDate = dates[0]+" "+sdf.format(date1)+" "+dates[2];
					}
					PdfPCell arriveDate = new PdfPCell(new Paragraph("Departure Date:	"+departureDate,norm_fontEng));
					arriveDate.setBorder(0);
					lineInfo.addCell(arriveDate);
					String noString=null;
					if(order.getReviewState()==0){
						noString=order.getOrderNo();
					}else{
						
						noString=order.getOrderNo().substring(0,order.getOrderNo().indexOf("-"))+"("+status+")";
					}
					PdfPCell invoiceId = new PdfPCell(new Paragraph("Booking NO:	"+noString,norm_fontEng));
					invoiceId.setBorder(0);
					lineInfo.addCell(invoiceId);
						PdfPCell agent = new PdfPCell(new Paragraph("Agent:			"+agentString,norm_fontEng));
						agent.setBorder(0);
						lineInfo.addCell(agent);
					
					PdfPCell subAgent = new PdfPCell(new Paragraph("",norm_fontEng));
					subAgent.setBorder(0);
					lineInfo.addCell(subAgent);
					
					PdfPCell space = new PdfPCell(new Paragraph(" ",norm_fontEng));
					space.setBorder(0);
					lineInfo.addCell(space);
					document.add(lineInfo);
					/*cb.setLineWidth(0.3f);
					cb.moveTo(40f, 600f);
					cb.lineTo(560f, 600f);
					cb.setColorStroke(Color.GRAY);
					cb.stroke();*/
					
					//String regEx = "[\\u4e00-\\u9fa5]"; 
					//Pattern p = Pattern.compile(regEx);
					
					
					//客人信息
					Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					customerInfoTittle.setSpacingAfter(10f);
					customerInfoTittle.setSpacingBefore(15f);
					document.add(customerInfoTittle);
					
					PdfPTable customerData = new PdfPTable(4);
					customerData.setWidthPercentage(100);
					float[] wid ={0.1f,0.40f,0.25f,0.25f};
					customerData.setWidths(wid);
					customerData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell customerHeader = new PdfPCell();
					customerHeader.setBorder(0);
					customerHeader.setBorderColorBottom(Color.GRAY);
					customerHeader.setBorderWidthBottom(0.3f);
					customerHeader.setBorderWidthTop(1.5f);
					customerHeader.setMinimumHeight(30f);
					customerHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					customerHeader.setMinimumHeight(25f);
					customerHeader.setBorderWidth(0.5f);
					customerHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					for(int i=0;i<customers.size();i++){
							PdfPCell customerNum = new PdfPCell();
							customerNum.setBorder(0);
							customerNum.setBorderColorBottom(Color.GRAY);
							customerNum.setBorderWidthBottom(0.3f);
							customerNum.setMinimumHeight(36f);
							customerNum.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerNum.addElement(new Phrase(customers.get(i).getCustomerOrderNo().toString(),norm_fontEng));
							customerData.addCell(customerNum);
							
							PdfPCell customerName = new PdfPCell();
							customerName.setBorder(0);
							customerName.setBorderColorBottom(Color.GRAY);
							customerName.setBorderWidthBottom(0.3f);
							customerName.setMinimumHeight(36f);
							customerName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerName.addElement(new Phrase(customers.get(i).getLastName()+"/"+customers.get(i).getFirstName()+customers.get(i).getMiddleName(),norm_fontChineseForContent));
							customerData.addCell(customerName);
							
							PdfPCell gender = new PdfPCell();
							gender.setBorder(0);
							gender.setBorderColorBottom(Color.GRAY);
							gender.setBorderWidthBottom(0.3f);
							gender.setMinimumHeight(36f);
							gender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String sexForString = "";
							if(customers.get(i).getSex()==1){
								sexForString="female";
							}else if(customers.get(i).getSex()==2){
								sexForString="male";
							}
							gender.addElement(new Phrase(sexForString,norm_fontEng));
							customerData.addCell(gender);
							
							PdfPCell nationality = new PdfPCell();
							nationality.setBorder(0);
							nationality.setBorderColorBottom(Color.GRAY);
							nationality.setBorderWidthBottom(0.3f);
							nationality.setMinimumHeight(36f);
							nationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							nationality.addElement(new Phrase(customers.get(i).getNationalityOfPassport(),norm_fontEng));
							customerData.addCell(nationality);
						}
					document.add(customerData);
					
					
					//航班信息
					Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",bold_fontEng);
					flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					flightInfoTittle.setSpacingAfter(10f);
					flightInfoTittle.setSpacingBefore(15f);
					document.add(flightInfoTittle);
					
					PdfPTable flightData = new PdfPTable(7);
					//float[] wid6 ={0.33f,0.33f,0.33f};
					flightData.setWidthPercentage(100);
					flightData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell flightHeader = new PdfPCell();
					
					flightHeader.setBorder(0);
					flightHeader.setBorderColorBottom(Color.GRAY);
					flightHeader.setBorderWidthBottom(0.3f);
					flightHeader.setBorderWidthTop(1.5f);
					flightHeader.setMinimumHeight(30f);
					flightHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					flightHeader.setMinimumHeight(25f);
					flightHeader.setBorderWidth(0.5f);
					flightHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Dep.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Arr.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Cust No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					
					List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
					for(Customer customer:customers){
							customerFlights.addAll(customer.getCustomerFlight());
					}
					
					List<CustomerFlight> cfs = this.addList(customerFlights);
					if(cfs!=null){
					for(CustomerFlight flight: cfs){
						if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
						PdfPCell date = new PdfPCell();
						date.setBorder(0);
						date.setBorderColorBottom(Color.GRAY);
						date.setBorderWidthBottom(0.3f);
						date.setMinimumHeight(36f);
						date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("MM/dd/yy");
						date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),norm_fontEng));
						flightData.addCell(date);
						
						PdfPCell airLine = new PdfPCell();
						airLine.setBorder(0);
						airLine.setBorderColorBottom(Color.GRAY);
						airLine.setBorderWidthBottom(0.3f);
						airLine.setMinimumHeight(36f);
						airLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						airLine.addElement(new Phrase(flight.getFlightCode(),norm_fontEng));
						flightData.addCell(airLine);
						
						PdfPCell flightNo = new PdfPCell();
						flightNo.setBorder(0);
						flightNo.setBorderColorBottom(Color.GRAY);
						flightNo.setBorderWidthBottom(0.3f);
						flightNo.setMinimumHeight(36f);
						flightNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						flightNo.addElement(new Phrase(flight.getFlightNumber(),norm_fontEng));
						flightData.addCell(flightNo);
						PdfPCell remark = new PdfPCell();
						if(flight.getOutOrEnter()==1){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase("",norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfPickUp()==1){
								remark.addElement(new Phrase("pick up",norm_fontEng));
							}else if(flight.getIfPickUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}else if(flight.getOutOrEnter()==2){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase("",norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfSendUp()==1){
								remark.addElement(new Phrase("drop off",norm_fontEng));
							}else if(flight.getIfSendUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}
						
						
						PdfPCell customerNo = new PdfPCell();
						customerNo.setBorder(0);
						customerNo.setBorderColorBottom(Color.GRAY);
						customerNo.setBorderWidthBottom(0.3f);
						customerNo.setMinimumHeight(36f);
						customerNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						customerNo.addElement(new Phrase(flight.getCustomerNos(),norm_fontEng));
						flightData.addCell(customerNo);
						flightData.addCell(remark);
						}
					}
					}
					document.add(flightData);
					
					//备注信息
					if(tourInfoOrder.getVoucherRemarks()!=null){
						Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",bold_fontEngForRemarks);
						voucherRemarksTittle.setSpacingBefore(12f);
						document.add(voucherRemarksTittle);
						Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks(),norm_fontChineseForRemarks);
						voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(voucherRemarks);
					}
					//添加行程信息
					Paragraph groupRouteTittle = new Paragraph("TOUR 	ITINERARY",bold_fontEng);
					groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
					groupRouteTittle.setSpacingAfter(10f);
					groupRouteTittle.setSpacingBefore(15f);
					document.add(groupRouteTittle);
					List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(groupLineId);
					for(GroupRoute groupRoute:groupRoutes){
						Paragraph dayNumAndRouteName = new Paragraph("Day"+groupRoute.getDayNum()+":	"+groupRoute.getRouteName(),norm_fontChineseForHead);
						document.add(dayNumAndRouteName);
						Paragraph routeDescForCh = new Paragraph(groupRoute.getRouteDescribeForEn(),norm_fontChinese);
						routeDescForCh.setSpacingBefore(10f);
						routeDescForCh.setSpacingAfter(20f);
						document.add(routeDescForCh);
					}
					
					
					//添加酒店信息
					Paragraph hotelInfoTittle = new Paragraph("HOTEL INFORMATION OR EQUIVALENT",bold_fontEng);
					hotelInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					hotelInfoTittle.setSpacingAfter(10f);
					hotelInfoTittle.setSpacingBefore(15f);
					document.add(hotelInfoTittle);
					
					PdfPTable hotelData = new PdfPTable(3);
					hotelData.setWidthPercentage(100);
					float[] wids ={0.5f,0.20f,0.3f};
					hotelData.setWidths(wids);
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
					tableHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Tel",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					tableHeader.setPhrase(new Phrase("Address",bold_fontEngForTableHead));
					hotelData.addCell(tableHeader);
					List<GroupLineHotelRel> groupLineHotelRels = groupLineForHotel.getGroupLineHotelRel();
					List<Hotel> hotelList = new ArrayList<Hotel>();
					
						for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
							Hotel hotel = groupLineHotelRel.getHotel();
							hotelList.add(hotel);
						}
					
					for(Hotel hotel:hotelList){
						PdfPCell hotelName = new PdfPCell();
						hotelName.setBorder(0);
						hotelName.setBorderColorBottom(Color.GRAY);
						hotelName.setBorderWidthBottom(0.3f);
						hotelName.setMinimumHeight(36f);
						hotelName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						hotelName.addElement(new Phrase(hotel.getHotelName()+"(或同级)",norm_fontChineseForContent));
						hotelData.addCell(hotelName);
						
						PdfPCell tel = new PdfPCell();
						tel.setBorder(0);
						tel.setBorderColorBottom(Color.GRAY);
						tel.setBorderWidthBottom(0.3f);
						tel.setMinimumHeight(36f);
						tel.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						tel.addElement(new Phrase(hotel.getTel(),norm_fontEng));
						hotelData.addCell(tel);
						
						PdfPCell address = new PdfPCell();
						address.setBorder(0);
						address.setBorderColorBottom(Color.GRAY);
						address.setBorderWidthBottom(0.3f);
						address.setMinimumHeight(36f);
						address.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						address.addElement(new Phrase(hotel.getAddress(),norm_fontChineseForContent));
						hotelData.addCell(address);
						
					}
					document.add(hotelData);
					
					
					//添加特殊条款
					if(groupLine.getSpecificItems()!=null){
						Paragraph specificItemsTittle = new Paragraph("SPECIFIC ITEMS",bold_fontEng);
						specificItemsTittle.setSpacingBefore(12f);
						document.add(specificItemsTittle);
						Paragraph specificItems = new Paragraph(groupLine.getSpecificItems()==null?"":groupLine.getSpecificItems(),norm_fontChinese);
						specificItems.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(specificItems);
					}
					
					if(groupLine.getContactor()!=null&&groupLine.getContactor()!=""){
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(groupLine.getContactor(),norm_fontChinese);
						document.add(cntact);
						
					}else{
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
						}else if(deptName.equals("Australia")){
							contactForChange = 3;
						}
					}
					
					//联系人信息：按品牌（中国美属于苏州，其它属于西安）
					if(contactForChange==2){ //中国美属于苏州
						//String cntactInfo = groupLine.getContactor();
						//联系人信息
						if(tourTypeOfDepts.get(0).getCode().equals("WJ-01")){//文景假期欧洲团的联系人信息
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[2],norm_fontChinese);
							document.add(cntact);
						}else{
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[0],norm_fontChinese);
							document.add(cntact);
							Paragraph cntact1 = new Paragraph(Constant.CONTACT[3],conSpe);
							document.add(cntact1);
						}
					}else if(contactForChange==1){//其它属于西安
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(Constant.CONTACT[1],norm_fontChinese);
						document.add(cntact);
					}
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
		//op修改之前一个子单的确认单
		@Override
		public String createOldPdfOfOpConfirm(String orderId) {
			    Order order = orderMapper.findCustomerForOrderId(orderId); //查找订单下的所有客人case 
			    String status="";
			    if(order.getReviewState()==1||order.getReviewState()==5){
			    	status="PENDING";
			    }else if(order.getReviewState()==2){
			    	status="CONFIRMED";
			    }else if(order.getReviewState()==3){
			    	status="DECLINE";
			    }else{
			    	status="PENDING";
			    }
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
//			    	Dept dept = deptMapper.findById(agent.getDeptId());
			    	addressString = agent.getAddress();
			    	telString = agent.getTel();
			    	mailString = agent.getEmail();
			    	agentString = order.getUserName();
			    }
			    List<Customer> customers = new ArrayList<Customer>();
				List<CustomerOrderRel> customerOrderRelList=order.getCustomerOrderRel();
				for(int j=0;j<customerOrderRelList.size();j++){
					if(customerOrderRelList.get(j).getIsDel()==0||customerOrderRelList.get(j).getIsDel()==3){
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
			if(groupLineId==null ||groupLineId.equals("")){
				return "No";
			}
			GroupLine groupLine = groupLineMapper.findById(groupLineId);
			GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
			
			Setting setting = SettingUtils.get();
			String uploadPath = setting.getTempPDFPath();
			String destPath = null;
			try {
				Map<String, Object> model = new HashMap<String, Object>();
				String path = FreemarkerUtils.process(uploadPath, model);
				destPath = path + "Final voucher-"+orderNumber+".pdf";
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
					Font norm_fontChinese = new Font(bfChinese, 10, Font.NORMAL, Color.BLACK);
					Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
					Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
					Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.NORMAL, Color.BLACK);
					Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
							Color.BLACK);
					Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
							Color.RED);   //备注信息显示为红色
					Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
							Color.BLACK);
					Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分

					/**
					 * 新建一个字体,iText的方法 STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀
					 * UniGB-UCS2-H 是编码，在iTextAsian.jar 中以cmap为后缀 H 代表文字版式是 横版， 相应的 V
					 * 代表竖版
					 */
					
					document.open();
					// 添加抬头图片
					
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
					PdfPTable table1 = new PdfPTable(3); //表格两列
					table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
					table1.setWidthPercentage(100);//表格的宽度为100%
					table1.getDefaultCell().setBorderWidth(0); //不显示边框
					table1.getDefaultCell().setBorderColor(Color.GRAY);
					if(logoPath.equals(Constant.LOGO_PATH[3])){
						float[] wid1 ={0.45f,0.25f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[1])){
						float[] wid1 ={0.2f,0.40f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[0])){
						float[] wid1 ={0.25f,0.45f,0.30f};
						table1.setWidths(wid1);
					}else if(logoPath.equals(Constant.LOGO_PATH[2])){
						float[] wid1 ={0.45f,0.25f,0.30f};
						table1.setWidths(wid1);
					}
					Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logoPath);
					jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
					table1.addCell(jpeg);
					PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
					cell1.setBorder(0);
					cell1.setBorderColor(Color.GRAY);
					table1.addCell(cell1);
					//右侧嵌套一个表格
					PdfPTable table13 = new PdfPTable(1);
					table13.getDefaultCell().setBorderWidth(0);
					PdfPCell cell2 = new PdfPCell(table13);
					cell2.setBorder(0);
					table1.addCell(cell2);
					
					PdfPCell cell21 = new PdfPCell(new Paragraph(addressString,norm_fontEng));
					cell21.setBorder(0);
					cell21.setMinimumHeight(10f);
					table13.addCell(cell21);
					
					PdfPCell cell24 = new PdfPCell(new Paragraph("",norm_fontEng));
					cell24.setBorder(0);
					cell24.setMinimumHeight(10f);
					table13.addCell(cell24);
					
					PdfPCell cell25 = new PdfPCell(new Paragraph("Tel:"+telString,norm_fontEng));
					cell25.setBorder(0);
					cell25.setMinimumHeight(10f);
					table13.addCell(cell25);
					
					PdfPCell cell26 = new PdfPCell(new Paragraph("Email:"+mailString,norm_fontEng));
					cell26.setBorder(0);
					cell26.setMinimumHeight(10f);
					table13.addCell(cell26);
					
					table1.addCell(cell1);
					document.add(table1);
					
					PdfContentByte cb=writer.getDirectContent();
					
					//添加线路信息
					TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
					Paragraph lineTittle = new Paragraph(groupLine.getTourName(),norm_fontChineseForTittle);
					lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
					lineTittle.setSpacingAfter(10f);
					lineTittle.setSpacingBefore(10f);
					document.add(lineTittle);
					PdfPTable lineInfo = new PdfPTable(3);
					lineInfo.setWidthPercentage(100);//表格的宽度为100%
					float[] wid2 ={0.33f,0.33f,0.33f}; //两列宽度的比例
					lineInfo.setWidths(wid2); 
					lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
					lineInfo.getDefaultCell().setMinimumHeight(25f);
					
					PdfPCell tourCode = new PdfPCell(new Paragraph(	 "Tour Code:	"+tourInfoForOrder.getScheduleLineCode(),norm_fontEng));
					tourCode.setBorder(0);
					lineInfo.addCell(tourCode);
					
					
					SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
					String departureDate = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
					String[] dates = departureDate.split("-");
					String str = dates[1];
				    SimpleDateFormat sdf = new SimpleDateFormat("MM");
				    Date date1 = sdf.parse(str);
				    sdf = new SimpleDateFormat("MMMMM",Locale.US);
				    departureDate = dates[0]+" "+sdf.format(date1)+" "+dates[2];
					PdfPCell arriveDate = new PdfPCell(new Paragraph("Departure Date:	"+departureDate,norm_fontEng));
					arriveDate.setBorder(0);
					lineInfo.addCell(arriveDate);
					String noString=null;
					if(order.getReviewState()==0){
						noString=order.getOrderNo();
					}else{
						
						noString=order.getOrderNo().substring(0,order.getOrderNo().indexOf("-"))+"("+status+")";
					}
					PdfPCell invoiceId = new PdfPCell(new Paragraph("Booking NO:	"+noString,norm_fontEng));
					invoiceId.setBorder(0);
					lineInfo.addCell(invoiceId);
						PdfPCell agent = new PdfPCell(new Paragraph("Agent:			"+agentString,norm_fontEng));
						agent.setBorder(0);
						lineInfo.addCell(agent);
					
					PdfPCell subAgent = new PdfPCell(new Paragraph("",norm_fontEng));
					subAgent.setBorder(0);
					lineInfo.addCell(subAgent);
					
					PdfPCell space = new PdfPCell(new Paragraph(" ",norm_fontEng));
					space.setBorder(0);
					lineInfo.addCell(space);
					document.add(lineInfo);
					/*cb.setLineWidth(0.3f);
					cb.moveTo(40f, 600f);
					cb.lineTo(560f, 600f);
					cb.setColorStroke(Color.GRAY);
					cb.stroke();*/
					
					//String regEx = "[\\u4e00-\\u9fa5]"; 
					//Pattern p = Pattern.compile(regEx);
					
					//添加Op添加导游，第一晚酒店信息
					Tour tour=new Tour();
					ItineraryInfo info=new ItineraryInfo();
					if(order.getTourId()!=""){
						tour=tourMapper.findById(order.getTourId());
						info=itineraryInfoMapper.findByTourId(tour.getTourId());
						
						if(info!=null){
							Paragraph FinalvoucherRemarks = new Paragraph("Final Voucher Remarks:",norm_fontChineseForHead);
							FinalvoucherRemarks.setSpacingBefore(8f);
							document.add(FinalvoucherRemarks);
							
							PdfPTable Finalvoucher = new PdfPTable(1); 
							Finalvoucher.setSpacingBefore(5f);
							Finalvoucher.setSpacingAfter(5f);
							Finalvoucher.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							Finalvoucher.setWidthPercentage(100);//表格的宽度为100%
							
							
							PdfPCell Finalvoucher_cell = new PdfPCell(new Paragraph(info.getHotelInfo(),norm_fontChineseForContent));
							Finalvoucher_cell.setBorder(0);
//							Finalvoucher_cell.setPaddingTop(5f);
//							Finalvoucher_cell.setPaddingBottom(7f);
							Finalvoucher_cell.setMinimumHeight(10f);
							Finalvoucher.addCell(Finalvoucher_cell);
							
							document.add(Finalvoucher);
							
							Paragraph OthervoucherRemarks = new Paragraph("Other  Remarks:",norm_fontChineseForHead);
							FinalvoucherRemarks.setSpacingBefore(8f);
							document.add(OthervoucherRemarks);
							
							PdfPTable Othervoucher_cell = new PdfPTable(1); 
							Othervoucher_cell.setSpacingBefore(5f);
							Othervoucher_cell.setSpacingAfter(5f);
							Othervoucher_cell.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							Othervoucher_cell.setWidthPercentage(100);//表格的宽度为100%
							
							
							PdfPCell CellInfo_2 = new PdfPCell(new Paragraph(info.getItineraryInfo(),norm_fontChineseForContent));
							CellInfo_2.setBorder(0);
//							CellInfo_2.setPaddingTop(5f);
//							CellInfo_2.setPaddingBottom(7f);
							CellInfo_2.setMinimumHeight(10f);
							Othervoucher_cell.addCell(CellInfo_2);
							
							document.add(Othervoucher_cell);
							
						}
					}
					
					//客人信息
					Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
					customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					customerInfoTittle.setSpacingAfter(10f);
					customerInfoTittle.setSpacingBefore(15f);
					document.add(customerInfoTittle);
					
					PdfPTable customerData = new PdfPTable(4);
					customerData.setWidthPercentage(100);
					float[] wid ={0.1f,0.40f,0.25f,0.25f};
					customerData.setWidths(wid);
					customerData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell customerHeader = new PdfPCell();
					customerHeader.setBorder(0);
					customerHeader.setBorderColorBottom(Color.GRAY);
					customerHeader.setBorderWidthBottom(0.3f);
					customerHeader.setBorderWidthTop(1.5f);
					customerHeader.setMinimumHeight(30f);
					customerHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					customerHeader.setMinimumHeight(25f);
					customerHeader.setBorderWidth(0.5f);
					customerHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					customerHeader.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
					customerData.addCell(customerHeader);
					for(int i=0;i<customers.size();i++){
							PdfPCell customerNum = new PdfPCell();
							customerNum.setBorder(0);
							customerNum.setBorderColorBottom(Color.GRAY);
							customerNum.setBorderWidthBottom(0.3f);
							customerNum.setMinimumHeight(36f);
							customerNum.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerNum.addElement(new Phrase(customers.get(i).getCustomerOrderNo().toString(),norm_fontEng));
							customerData.addCell(customerNum);
							
							PdfPCell customerName = new PdfPCell();
							customerName.setBorder(0);
							customerName.setBorderColorBottom(Color.GRAY);
							customerName.setBorderWidthBottom(0.3f);
							customerName.setMinimumHeight(36f);
							customerName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerName.addElement(new Phrase(customers.get(i).getLastName()+"/"+customers.get(i).getFirstName()+customers.get(i).getMiddleName(),norm_fontChineseForContent));
							customerData.addCell(customerName);
							
							PdfPCell gender = new PdfPCell();
							gender.setBorder(0);
							gender.setBorderColorBottom(Color.GRAY);
							gender.setBorderWidthBottom(0.3f);
							gender.setMinimumHeight(36f);
							gender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							String sexForString = "";
							if(customers.get(i).getSex()==1){
								sexForString="female";
							}else if(customers.get(i).getSex()==2){
								sexForString="male";
							}
							gender.addElement(new Phrase(sexForString,norm_fontEng));
							customerData.addCell(gender);
							
							PdfPCell nationality = new PdfPCell();
							nationality.setBorder(0);
							nationality.setBorderColorBottom(Color.GRAY);
							nationality.setBorderWidthBottom(0.3f);
							nationality.setMinimumHeight(36f);
							nationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							nationality.addElement(new Phrase(customers.get(i).getNationalityOfPassport(),norm_fontEng));
							customerData.addCell(nationality);
						}
					document.add(customerData);
					
					
					//航班信息
					Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",bold_fontEng);
					flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
					flightInfoTittle.setSpacingAfter(10f);
					flightInfoTittle.setSpacingBefore(15f);
					document.add(flightInfoTittle);
					
					PdfPTable flightData = new PdfPTable(7);
					//float[] wid6 ={0.33f,0.33f,0.33f};
					flightData.setWidthPercentage(100);
					flightData.getDefaultCell().setBorderWidthBottom(0);
					PdfPCell flightHeader = new PdfPCell();
					
					flightHeader.setBorder(0);
					flightHeader.setBorderColorBottom(Color.GRAY);
					flightHeader.setBorderWidthBottom(0.3f);
					flightHeader.setBorderWidthTop(1.5f);
					flightHeader.setMinimumHeight(30f);
					flightHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
					flightHeader.setMinimumHeight(25f);
					flightHeader.setBorderWidth(0.5f);
					flightHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Dep.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Arr.Time",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Cust No.",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					flightHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
					flightData.addCell(flightHeader);
					
					List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
					for(Customer customer:customers){
							customerFlights.addAll(customer.getCustomerFlight());
					}
					
					List<CustomerFlight> cfs = this.addList(customerFlights);
					if(cfs!=null){
					for(CustomerFlight flight: cfs){
						if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
						PdfPCell date = new PdfPCell();
						date.setBorder(0);
						date.setBorderColorBottom(Color.GRAY);
						date.setBorderWidthBottom(0.3f);
						date.setMinimumHeight(36f);
						date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("MM/dd/yy");
						date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),norm_fontEng));
						flightData.addCell(date);
						
						PdfPCell airLine = new PdfPCell();
						airLine.setBorder(0);
						airLine.setBorderColorBottom(Color.GRAY);
						airLine.setBorderWidthBottom(0.3f);
						airLine.setMinimumHeight(36f);
						airLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						airLine.addElement(new Phrase(flight.getFlightCode(),norm_fontEng));
						flightData.addCell(airLine);
						
						PdfPCell flightNo = new PdfPCell();
						flightNo.setBorder(0);
						flightNo.setBorderColorBottom(Color.GRAY);
						flightNo.setBorderWidthBottom(0.3f);
						flightNo.setMinimumHeight(36f);
						flightNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						flightNo.addElement(new Phrase(flight.getFlightNumber(),norm_fontEng));
						flightData.addCell(flightNo);
						PdfPCell remark = new PdfPCell();
						if(flight.getOutOrEnter()==1){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase("",norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfPickUp()==1){
								remark.addElement(new Phrase("pick up",norm_fontEng));
							}else if(flight.getIfPickUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}else if(flight.getOutOrEnter()==2){
							PdfPCell arrTime = new PdfPCell();
							arrTime.setBorder(0);
							arrTime.setBorderColorBottom(Color.GRAY);
							arrTime.setBorderWidthBottom(0.3f);
							arrTime.setMinimumHeight(36f);
							arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							arrTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
							flightData.addCell(arrTime);
							
							PdfPCell depTime = new PdfPCell();
							depTime.setBorder(0);
							depTime.setBorderColorBottom(Color.GRAY);
							depTime.setBorderWidthBottom(0.3f);
							depTime.setMinimumHeight(36f);
							depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							depTime.addElement(new Phrase("",norm_fontEng));
							flightData.addCell(depTime);
							
							remark.setBorder(0);
							remark.setBorderColorBottom(Color.GRAY);
							remark.setBorderWidthBottom(0.3f);
							remark.setMinimumHeight(36f);
							remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							if(flight.getIfSendUp()==1){
								remark.addElement(new Phrase("drop off",norm_fontEng));
							}else if(flight.getIfSendUp()==2){
								remark.addElement(new Phrase("",norm_fontEng));
							}
						}
						
						
						PdfPCell customerNo = new PdfPCell();
						customerNo.setBorder(0);
						customerNo.setBorderColorBottom(Color.GRAY);
						customerNo.setBorderWidthBottom(0.3f);
						customerNo.setMinimumHeight(36f);
						customerNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
						customerNo.addElement(new Phrase(flight.getCustomerNos(),norm_fontEng));
						flightData.addCell(customerNo);
						flightData.addCell(remark);
						}
					}
					}
					document.add(flightData);
					
					//备注信息
					if(tourInfoOrder.getVoucherRemarks()!=null){
						Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",bold_fontEngForRemarks);
						voucherRemarksTittle.setSpacingBefore(12f);
						document.add(voucherRemarksTittle);
						Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks(),norm_fontChineseForRemarks);
						voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
						document.add(voucherRemarks);
					}
					//添加紧急联系人
					if(groupLine.getContactor()!=null&&groupLine.getContactor()!=""){
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(groupLine.getContactor(),norm_fontChinese);
						document.add(cntact);
						
					}else{
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
						}else if(deptName.equals("Australia")){
							contactForChange = 3;
						}
					}
					
					//联系人信息：按品牌（中国美属于苏州，其它属于西安）
					if(contactForChange==2){ //中国美属于苏州
						//String cntactInfo = groupLine.getContactor();
						//联系人信息
						if(tourTypeOfDepts.get(0).getCode().equals("WJ-01")){//文景假期欧洲团的联系人信息
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[2],norm_fontChinese);
							document.add(cntact);
						}else{
							Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
							cntactTittle.setSpacingBefore(15f);
							document.add(cntactTittle);
							Paragraph cntact = new Paragraph(Constant.CONTACT[0],norm_fontChinese);
							document.add(cntact);
							Paragraph cntact1 = new Paragraph(Constant.CONTACT[3],conSpe);
							document.add(cntact1);
						}
					}else if(contactForChange==1){//其它属于西安
						Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
						cntactTittle.setSpacingBefore(15f);
						document.add(cntactTittle);
						Paragraph cntact = new Paragraph(Constant.CONTACT[1],norm_fontChinese);
						document.add(cntact);
						}
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
		
		//B2B
				@Override
				public String createBPdf(String orderId) {
					    Order order = orderMapper.findCustomerForOrderId(orderId); //查找订单下的所有客人case 
					    String status="";
					    if(order.getReviewState()==1||order.getReviewState()==5){
					    	status="PENDING";
					    }else if(order.getReviewState()==2){
					    	status="CONFIRMED";
					    }else if(order.getReviewState()==3){
					    	status="DECLINE";
					    }else{
					    	status="PENDING";
					    }
					    String orderNumber = order.getOrderNo();
					    OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
					    PeerUser peerUser = peerUserMapper.findById(ordersTotal.getPeerUserId());
					    String addressString = "";
					    String telString = "";
					    String mailString = "";
					    String agentString = "";
					    String subString = "";
					    String country="";
					    
					    if(ordersTotal.getWr().equals("wholeSale")){
					    	if((ordersTotal.getCompanyId()!=null)&&(ordersTotal.getCompanyId().length()!=0)){
						    	Vender vender = venderMapper.findById(ordersTotal.getCompanyId());
						    	addressString = vender.getAddress();
						    	telString = vender.getTel();
						    	mailString = vender.getB2bEmail();
						    	agentString = vender.getName();
						    	subString=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
						    	if(vender.getCountryId()!=null && !vender.getCountryId().equals("")){
						    		country=countryMapper.findById(vender.getCountryId()).getCountryName();
						    	}
					    	}
					    }else if(ordersTotal.getWr().equals("retail")){
					    	Admin agent = adminService.findById(ordersTotal.getUserId());
//					    	Dept dept = deptMapper.findById(agent.getDeptId());
					    	addressString = agent.getAddress();
					    	telString = agent.getTel();
					    	mailString = agent.getEmail();
					    	agentString = order.getUserName();
					    }
					    List<Customer> customers = new ArrayList<Customer>();
						List<CustomerOrderRel> customerOrderRelList=order.getCustomerOrderRel();
						for(int j=0;j<customerOrderRelList.size();j++){
							if(customerOrderRelList.get(j).getIsDel()==0||customerOrderRelList.get(j).getIsDel()==3){
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
					if(groupLineId==null ||groupLineId.equals("")){
						return "No";
					}
					GroupLine groupLine = groupLineMapper.findById(groupLineId);
					GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
					
					Setting setting = SettingUtils.get();
					String uploadPath = setting.getTempPDFPath();
					String destPath = null;
					try {
						Map<String, Object> model = new HashMap<String, Object>();
						String path = FreemarkerUtils.process(uploadPath, model);
						destPath = path + "voucher-"+orderNumber+".pdf";
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
							Font norm_fontChinese = new Font(bfChinese, 10, Font.NORMAL, Color.BLACK);
							Font norm_fontChineseGray = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
							Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
							Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
									Color.BLACK);
							Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
									Color.RED);   //备注信息显示为红色
							Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
									Color.BLACK);
							Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分

							/**
							 * 新建一个字体,iText的方法 STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀
							 * UniGB-UCS2-H 是编码，在iTextAsian.jar 中以cmap为后缀 H 代表文字版式是 横版， 相应的 V
							 * 代表竖版
							 */
							
							document.open();
							// 添加抬头图片
							
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
							PdfPTable table1 = new PdfPTable(3); //表格两列
							table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							table1.setWidthPercentage(100);//表格的宽度为100%
							table1.getDefaultCell().setBorderWidth(0); //不显示边框
							table1.getDefaultCell().setBorderColor(Color.GRAY);
							if(logoPath.equals(Constant.LOGO_PATH[3])){
								float[] wid1 ={0.45f,0.25f,0.30f};
								table1.setWidths(wid1);
							}else if(logoPath.equals(Constant.LOGO_PATH[1])){
								float[] wid1 ={0.2f,0.40f,0.30f};
								table1.setWidths(wid1);
							}else if(logoPath.equals(Constant.LOGO_PATH[0])){
								float[] wid1 ={0.25f,0.45f,0.30f};
								table1.setWidths(wid1);
							}else if(logoPath.equals(Constant.LOGO_PATH[2])){
								float[] wid1 ={0.45f,0.25f,0.30f};
								table1.setWidths(wid1);
							}
							Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logoPath);
							jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
							if(!peerUser.getLogoAddress().equals("")){
								Image jpegs = Image.getInstance(servletContext.getRealPath("/")+peerUser.getLogoAddress());
								jpegs.setAlignment(Image.ALIGN_LEFT);// 图片居中
								jpegs.scaleAbsolute(150f, 80f);
								
								PdfPCell cell1 = new PdfPCell(jpegs); //中间放以空白列
								cell1.setBorder(0);
								table1.addCell(cell1);
								
								PdfPCell cells = new PdfPCell(new Paragraph("")); //中间放以空白列
								cells.setBorder(0);
								cells.setBorderColor(Color.GRAY);
								table1.addCell(cells);
								
								table1.addCell(jpeg);
								
							}else{
								PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
								cell1.setBorder(0);
								cell1.setBorderColor(Color.GRAY);
								table1.addCell(cell1);
								
								PdfPCell cell2 = new PdfPCell(new Paragraph(""));
								cell2.setBorder(0);
								cell2.setBorderColor(Color.GRAY);
								table1.addCell(cell2);
								
								table1.addCell(jpeg);
							}
							document.add(table1);
							
							PdfPTable peerTable=new PdfPTable(1);

							peerTable.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							peerTable.setWidthPercentage(100);//表格的宽度为100%
							peerTable.getDefaultCell().setBorderWidth(0); //不显示边框
							peerTable.getDefaultCell().setBorderColor(Color.GRAY);
							PdfPCell pCell1=new PdfPCell(new Paragraph(agentString,norm_fontEng));
							pCell1.setBorder(0);
							pCell1.setBorderColor(Color.GRAY);
							PdfPCell pCell2=new PdfPCell(new Paragraph(addressString,norm_fontEng));
							pCell2.setBorder(0);
							pCell2.setBorderColor(Color.GRAY);
							PdfPCell pCell3=new PdfPCell(new Paragraph(subString,norm_fontEng));
							pCell3.setBorder(0);
							pCell3.setBorderColor(Color.GRAY);
							PdfPCell pCell4=new PdfPCell(new Paragraph(country,norm_fontEng));
							pCell4.setBorder(0);
							pCell4.setBorderColor(Color.GRAY);
							PdfPCell pCell5=new PdfPCell(new Paragraph("Tel:        "+telString,norm_fontEng));
							pCell5.setBorder(0);
							pCell5.setBorderColor(Color.GRAY);
							PdfPCell pCell6=new PdfPCell(new Paragraph("Email:    "+mailString,norm_fontEng));
							pCell6.setBorder(0);
							pCell6.setBorderColor(Color.GRAY);
							
							peerTable.addCell(pCell1);
							peerTable.addCell(pCell2);
							peerTable.addCell(pCell3);
							peerTable.addCell(pCell4);
							peerTable.addCell(pCell5);
							peerTable.addCell(pCell6);
							
							document.add(peerTable);
							
							
							
							PdfContentByte cb=writer.getDirectContent();
							
							//添加线路信息
							TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
							Paragraph lineTittle = new Paragraph(groupLine.getTourName(),norm_fontChineseForTittle);
							lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
							lineTittle.setSpacingAfter(10f);
							lineTittle.setSpacingBefore(10f);
							document.add(lineTittle);
							Paragraph lineEnTittle = new Paragraph(groupLine.getTourNameEn(),norm_fontChineseForTittle);
							lineEnTittle.setAlignment(Paragraph.ALIGN_CENTER);
							lineEnTittle.setSpacingAfter(10f);
							lineEnTittle.setSpacingBefore(10f);
							document.add(lineEnTittle);
							PdfPTable lineInfo = new PdfPTable(3);
							lineInfo.setWidthPercentage(100);//表格的宽度为100%
							float[] wid2 ={0.33f,0.30f,0.37f}; //两列宽度的比例
							lineInfo.setWidths(wid2); 
							lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
							lineInfo.getDefaultCell().setMinimumHeight(25f);
							
							PdfPCell tourCode = new PdfPCell(new Paragraph(	 "Tour Code:	"+tourInfoForOrder.getScheduleLineCode(),norm_fontEng));
							tourCode.setBorder(0);
							lineInfo.addCell(tourCode);
							
							
							SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
							String departureDate = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
							String[] dates = departureDate.split("-");
							String str = dates[1];
						    SimpleDateFormat sdf = new SimpleDateFormat("MM");
						    Date date1 = sdf.parse(str);
						    sdf = new SimpleDateFormat("MMMMM",Locale.US);
						    departureDate = dates[0]+" "+sdf.format(date1)+" "+dates[2];
							PdfPCell arriveDate = new PdfPCell(new Paragraph("Departure Date:	"+departureDate,norm_fontEng));
							arriveDate.setBorder(0);
							lineInfo.addCell(arriveDate);
							String noString=null;
							if(order.getReviewState()==0){
								noString=order.getOrderNo();
							}else{
								
								noString=order.getOrderNo().substring(0,order.getOrderNo().indexOf("-"))+"("+status+")";
							}
							PdfPCell invoiceId = new PdfPCell(new Paragraph("Booking NO:	"+noString,norm_fontEng));
							invoiceId.setBorder(0);
							lineInfo.addCell(invoiceId);
								PdfPCell agent = new PdfPCell(new Paragraph("",norm_fontEng));
								agent.setBorder(0);
								lineInfo.addCell(agent);
							
							PdfPCell subAgent = new PdfPCell(new Paragraph("",norm_fontEng));
							subAgent.setBorder(0);
							lineInfo.addCell(subAgent);
							
							PdfPCell space = new PdfPCell(new Paragraph(" ",norm_fontEng));
							space.setBorder(0);
							lineInfo.addCell(space);
							document.add(lineInfo);
							/*cb.setLineWidth(0.3f);
							cb.moveTo(40f, 600f);
							cb.lineTo(560f, 600f);
							cb.setColorStroke(Color.GRAY);
							cb.stroke();*/
							
							//String regEx = "[\\u4e00-\\u9fa5]"; 
							//Pattern p = Pattern.compile(regEx);
							
							
							//客人信息
							Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
							customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
							customerInfoTittle.setSpacingAfter(10f);
							customerInfoTittle.setSpacingBefore(15f);
							document.add(customerInfoTittle);
							
							PdfPTable customerData = new PdfPTable(8);
							customerData.setWidthPercentage(100);
							float[] wid ={0.05f,0.25f,0.3f,0.15f,0.25f,0.35f,0.25f,0.3f};
							customerData.setWidths(wid);
							customerData.getDefaultCell().setBorderWidthBottom(0);
							PdfPCell customerHeader = new PdfPCell();
							customerHeader.setBorder(0);
							customerHeader.setBorderColorBottom(Color.GRAY);
							customerHeader.setBorderWidthBottom(0.3f);
							customerHeader.setBorderWidthTop(1.5f);
							customerHeader.setMinimumHeight(30f);
							customerHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerHeader.setMinimumHeight(25f);
							customerHeader.setBorderWidth(0.5f);
							customerHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Category",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Date of Birth",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Language",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Residency",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							for(int i=0;i<customers.size();i++){
									//判断客人的年龄类型
									String customerType="";
									if(customers.get(i).getType()==4){
										customerType="Adult";
									}else if(customers.get(i).getType()==3){
										customerType="Child with Bed";
									}else if(customers.get(i).getType()==2){
										customerType="Child without Bed";
									}else{
										customerType="Infant";
									}
									//语言
									String lange="";
									if(!customers.get(i).getLanguageId().equals("0")){
										lange=languageMapper.findById(customers.get(i).getLanguageId()).getLanguage();
									}
									PdfPCell customerNum = new PdfPCell();
									customerNum.setBorder(0);
									customerNum.setBorderColorBottom(Color.GRAY);
									customerNum.setBorderWidthBottom(0.3f);
									customerNum.setMinimumHeight(36f);
									customerNum.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									customerNum.addElement(new Phrase(customers.get(i).getCustomerOrderNo().toString(),norm_fontEng));
									customerData.addCell(customerNum);
									
									PdfPCell category = new PdfPCell();
									category.setBorder(0);
									category.setBorderColorBottom(Color.GRAY);
									category.setBorderWidthBottom(0.3f);
									category.setMinimumHeight(36f);
									category.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									category.addElement(new Phrase(customerType,norm_fontChineseForContent));
									customerData.addCell(category);
									
									PdfPCell customerName = new PdfPCell();
									customerName.setBorder(0);
									customerName.setBorderColorBottom(Color.GRAY);
									customerName.setBorderWidthBottom(0.3f);
									customerName.setMinimumHeight(36f);
									customerName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									customerName.addElement(new Phrase(customers.get(i).getLastName()+"/"+customers.get(i).getFirstName()+customers.get(i).getMiddleName(),norm_fontChineseForContent));
									customerData.addCell(customerName);
									
									PdfPCell gender = new PdfPCell();
									gender.setBorder(0);
									gender.setBorderColorBottom(Color.GRAY);
									gender.setBorderWidthBottom(0.3f);
									gender.setMinimumHeight(36f);
									gender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									String sexForString = "";
									if(customers.get(i).getSex()==1){
										sexForString="female";
									}else if(customers.get(i).getSex()==2){
										sexForString="male";
									}
									gender.addElement(new Phrase(sexForString,norm_fontEng));
									customerData.addCell(gender);
									
									PdfPCell birth = new PdfPCell();
									birth.setBorder(0);
									birth.setBorderColorBottom(Color.GRAY);
									birth.setBorderWidthBottom(0.3f);
									birth.setMinimumHeight(36f);
									birth.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
									birth.addElement(new Phrase(customers.get(i).getDateOfBirth()==null?"":simpleDateFormat.format(customers.get(i).getDateOfBirth()),norm_fontEng));
									customerData.addCell(birth);
									
									PdfPCell language = new PdfPCell();
									language.setBorder(0);
									language.setBorderColorBottom(Color.GRAY);
									language.setBorderWidthBottom(0.3f);
									language.setMinimumHeight(36f);
									language.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									language.addElement(new Phrase(lange,norm_fontChineseGray));
									customerData.addCell(language);
									
									PdfPCell nationality = new PdfPCell();
									nationality.setBorder(0);
									nationality.setBorderColorBottom(Color.GRAY);
									nationality.setBorderWidthBottom(0.3f);
									nationality.setMinimumHeight(36f);
									nationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									String countryName = "";
									if(customers.get(i).getNationalityOfPassport()!=null){
											countryName = customers.get(i).getNationalityOfPassport();
									}
									nationality.addElement(new Phrase(customers.get(i).getCountryId()==null?"":countryName,norm_fontEng));
									customerData.addCell(nationality);
									
									PdfPCell residency = new PdfPCell();
									residency.setBorder(0);
									residency.setBorderColorBottom(Color.GRAY);
									residency.setBorderWidthBottom(0.3f);
									residency.setMinimumHeight(36f);
									residency.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									residency.addElement(new Phrase(customers.get(i).getResidency(),norm_fontEng));
									customerData.addCell(residency);
								}
							document.add(customerData);
							
							
							//航班信息
							Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",bold_fontEng);
							flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
							flightInfoTittle.setSpacingAfter(10f);
							flightInfoTittle.setSpacingBefore(15f);
							document.add(flightInfoTittle);
							
							PdfPTable flightData = new PdfPTable(7);
							//float[] wid6 ={0.33f,0.33f,0.33f};
							flightData.setWidthPercentage(100);
							flightData.getDefaultCell().setBorderWidthBottom(0);
							PdfPCell flightHeader = new PdfPCell();
							
							flightHeader.setBorder(0);
							flightHeader.setBorderColorBottom(Color.GRAY);
							flightHeader.setBorderWidthBottom(0.3f);
							flightHeader.setBorderWidthTop(1.5f);
							flightHeader.setMinimumHeight(30f);
							flightHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							flightHeader.setMinimumHeight(25f);
							flightHeader.setBorderWidth(0.5f);
							flightHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("No.",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Dep.Time",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Arr.Time",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Cust No.",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							
							List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
							for(Customer customer:customers){
									customerFlights.addAll(customer.getCustomerFlight());
							}
							
							List<CustomerFlight> cfs = this.addList(customerFlights);
							if(cfs!=null){
							for(CustomerFlight flight: cfs){
								if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
								PdfPCell date = new PdfPCell();
								date.setBorder(0);
								date.setBorderColorBottom(Color.GRAY);
								date.setBorderWidthBottom(0.3f);
								date.setMinimumHeight(36f);
								date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd");
								date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),norm_fontEng));
								flightData.addCell(date);
								
								PdfPCell airLine = new PdfPCell();
								airLine.setBorder(0);
								airLine.setBorderColorBottom(Color.GRAY);
								airLine.setBorderWidthBottom(0.3f);
								airLine.setMinimumHeight(36f);
								airLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								airLine.addElement(new Phrase(flight.getFlightCode(),norm_fontEng));
								flightData.addCell(airLine);
								
								PdfPCell flightNo = new PdfPCell();
								flightNo.setBorder(0);
								flightNo.setBorderColorBottom(Color.GRAY);
								flightNo.setBorderWidthBottom(0.3f);
								flightNo.setMinimumHeight(36f);
								flightNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								flightNo.addElement(new Phrase(flight.getFlightNumber(),norm_fontEng));
								flightData.addCell(flightNo);
								PdfPCell remark = new PdfPCell();
								if(flight.getOutOrEnter()==1){
									PdfPCell arrTime = new PdfPCell();
									arrTime.setBorder(0);
									arrTime.setBorderColorBottom(Color.GRAY);
									arrTime.setBorderWidthBottom(0.3f);
									arrTime.setMinimumHeight(36f);
									arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									arrTime.addElement(new Phrase("",norm_fontEng));
									flightData.addCell(arrTime);
									
									PdfPCell depTime = new PdfPCell();
									depTime.setBorder(0);
									depTime.setBorderColorBottom(Color.GRAY);
									depTime.setBorderWidthBottom(0.3f);
									depTime.setMinimumHeight(36f);
									depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									depTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
									flightData.addCell(depTime);
									
									remark.setBorder(0);
									remark.setBorderColorBottom(Color.GRAY);
									remark.setBorderWidthBottom(0.3f);
									remark.setMinimumHeight(36f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									if(flight.getIfPickUp()==1){
										remark.addElement(new Phrase("pick up",norm_fontEng));
									}else if(flight.getIfPickUp()==2){
										remark.addElement(new Phrase("",norm_fontEng));
									}
								}else if(flight.getOutOrEnter()==2){
									PdfPCell arrTime = new PdfPCell();
									arrTime.setBorder(0);
									arrTime.setBorderColorBottom(Color.GRAY);
									arrTime.setBorderWidthBottom(0.3f);
									arrTime.setMinimumHeight(36f);
									arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									arrTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
									flightData.addCell(arrTime);
									
									PdfPCell depTime = new PdfPCell();
									depTime.setBorder(0);
									depTime.setBorderColorBottom(Color.GRAY);
									depTime.setBorderWidthBottom(0.3f);
									depTime.setMinimumHeight(36f);
									depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									depTime.addElement(new Phrase("",norm_fontEng));
									flightData.addCell(depTime);
									
									remark.setBorder(0);
									remark.setBorderColorBottom(Color.GRAY);
									remark.setBorderWidthBottom(0.3f);
									remark.setMinimumHeight(36f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									if(flight.getIfSendUp()==1){
										remark.addElement(new Phrase("drop off",norm_fontEng));
									}else if(flight.getIfSendUp()==2){
										remark.addElement(new Phrase("",norm_fontEng));
									}
								}
								
								
								PdfPCell customerNo = new PdfPCell();
								customerNo.setBorder(0);
								customerNo.setBorderColorBottom(Color.GRAY);
								customerNo.setBorderWidthBottom(0.3f);
								customerNo.setMinimumHeight(36f);
								customerNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								customerNo.addElement(new Phrase(flight.getCustomerNos(),norm_fontEng));
								flightData.addCell(customerNo);
								flightData.addCell(remark);
								}
							}
							}
							document.add(flightData);
							
							//备注信息
							if(tourInfoOrder.getVoucherRemarks()!=null){
								Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",bold_fontEngForRemarks);
								voucherRemarksTittle.setSpacingBefore(12f);
								document.add(voucherRemarksTittle);
								Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks(),norm_fontChineseForRemarks);
								voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
								document.add(voucherRemarks);
							}
							//添加行程信息
							Paragraph groupRouteTittle = new Paragraph("TOUR 	ITINERARY",bold_fontEng);
							groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
							groupRouteTittle.setSpacingAfter(10f);
							groupRouteTittle.setSpacingBefore(15f);
							document.add(groupRouteTittle);
							List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(groupLineId);
							for(GroupRoute groupRoute:groupRoutes){
								Paragraph dayNumAndRouteName = new Paragraph("Day"+groupRoute.getDayNum()+":	"+groupRoute.getRouteName(),norm_fontChineseForHead);
								document.add(dayNumAndRouteName);
								Paragraph routeDescForCh = new Paragraph(groupRoute.getRouteDescribeForEn(),norm_fontChinese);
								routeDescForCh.setSpacingBefore(10f);
								routeDescForCh.setSpacingAfter(20f);
								document.add(routeDescForCh);
							}
							
							
							//添加酒店信息
							Paragraph hotelInfoTittle = new Paragraph("HOTEL INFORMATION OR EQUIVALENT",bold_fontEng);
							hotelInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
							hotelInfoTittle.setSpacingAfter(10f);
							hotelInfoTittle.setSpacingBefore(15f);
							document.add(hotelInfoTittle);
							
							PdfPTable hotelData = new PdfPTable(3);
							hotelData.setWidthPercentage(100);
							float[] wids ={0.5f,0.20f,0.3f};
							hotelData.setWidths(wids);
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
							tableHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
							hotelData.addCell(tableHeader);
							tableHeader.setPhrase(new Phrase("Tel",bold_fontEngForTableHead));
							hotelData.addCell(tableHeader);
							tableHeader.setPhrase(new Phrase("Address",bold_fontEngForTableHead));
							hotelData.addCell(tableHeader);
							List<GroupLineHotelRel> groupLineHotelRels = groupLineForHotel.getGroupLineHotelRel();
							List<Hotel> hotelList = new ArrayList<Hotel>();
							
								for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
									Hotel hotel = groupLineHotelRel.getHotel();
									hotelList.add(hotel);
								}
							
							for(Hotel hotel:hotelList){
								PdfPCell hotelName = new PdfPCell();
								hotelName.setBorder(0);
								hotelName.setBorderColorBottom(Color.GRAY);
								hotelName.setBorderWidthBottom(0.3f);
								hotelName.setMinimumHeight(36f);
								hotelName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								hotelName.addElement(new Phrase(hotel.getHotelName()+"(或同级)",norm_fontChineseForContent));
								hotelData.addCell(hotelName);
								
								PdfPCell tel = new PdfPCell();
								tel.setBorder(0);
								tel.setBorderColorBottom(Color.GRAY);
								tel.setBorderWidthBottom(0.3f);
								tel.setMinimumHeight(36f);
								tel.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								tel.addElement(new Phrase(hotel.getTel(),norm_fontEng));
								hotelData.addCell(tel);
								
								PdfPCell address = new PdfPCell();
								address.setBorder(0);
								address.setBorderColorBottom(Color.GRAY);
								address.setBorderWidthBottom(0.3f);
								address.setMinimumHeight(36f);
								address.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								address.addElement(new Phrase(hotel.getAddress(),norm_fontChineseForContent));
								hotelData.addCell(address);
								
							}
							document.add(hotelData);
							
							
							//添加特殊条款
							if(groupLine.getSpecificItems()!=null){
								Paragraph specificItemsTittle = new Paragraph("SPECIFIC ITEMS",bold_fontEng);
								specificItemsTittle.setSpacingBefore(12f);
								document.add(specificItemsTittle);
								Paragraph specificItems = new Paragraph(groupLine.getSpecificItems()==null?"":groupLine.getSpecificItems(),norm_fontChinese);
								specificItems.setAlignment(Paragraph.ALIGN_LEFT);
								document.add(specificItems);
							}
							
							if(groupLine.getContactor()!=null&&groupLine.getContactor()!=""){
								Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
								cntactTittle.setSpacingBefore(15f);
								document.add(cntactTittle);
								Paragraph cntact = new Paragraph(groupLine.getContactor(),norm_fontChinese);
								document.add(cntact);
								
							}else{
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
								}else if(deptName.equals("Australia")){
									contactForChange = 3;
								}
							}
							
							//联系人信息：按品牌（中国美属于苏州，其它属于西安）
							if(contactForChange==2){ //中国美属于苏州
								//String cntactInfo = groupLine.getContactor();
								//联系人信息
								if(tourTypeOfDepts.get(0).getCode().equals("WJ-01")){//文景假期欧洲团的联系人信息
									Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
									cntactTittle.setSpacingBefore(15f);
									document.add(cntactTittle);
									Paragraph cntact = new Paragraph(Constant.CONTACT[2],norm_fontChinese);
									document.add(cntact);
								}else{
									Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
									cntactTittle.setSpacingBefore(15f);
									document.add(cntactTittle);
									Paragraph cntact = new Paragraph(Constant.CONTACT[0],norm_fontChinese);
									document.add(cntact);
									Paragraph cntact1 = new Paragraph(Constant.CONTACT[3],conSpe);
									document.add(cntact1);
								}
							}else if(contactForChange==1){//其它属于西安
								Paragraph cntactTittle = new Paragraph("CONTACT INFORMATION",bold_fontEng);
								cntactTittle.setSpacingBefore(15f);
								document.add(cntactTittle);
								Paragraph cntact = new Paragraph(Constant.CONTACT[1],norm_fontChinese);
								document.add(cntact);
							}
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
				
				//B2B
				@Override
				public String createB2BPdf(String groupLineId) {
					    
					//获取线路
					if(groupLineId==null ||groupLineId.equals("")){
						return "No";
					}
					GroupLine groupLine = groupLineMapper.findById(groupLineId);
					
					Setting setting = SettingUtils.get();
					String uploadPath = setting.getTempPDFPath();
					String destPath = null;
					try {
						Map<String, Object> model = new HashMap<String, Object>();
						String path = FreemarkerUtils.process(uploadPath, model);
						destPath = path + "voucher-"+groupLine.getTourCode()+".pdf";
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
							Font norm_fontChinese = new Font(bfChinese, 10, Font.NORMAL, Color.BLACK);
							Font norm_fontChineseGray = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
							Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
							Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
									Color.BLACK);
							Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
									Color.RED);   //备注信息显示为红色
							Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
									Color.BLACK);
							Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分

							/**
							 * 新建一个字体,iText的方法 STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀
							 * UniGB-UCS2-H 是编码，在iTextAsian.jar 中以cmap为后缀 H 代表文字版式是 横版， 相应的 V
							 * 代表竖版
							 */
							
							document.open();
							// 添加抬头图片
							
							PdfPTable table1 = new PdfPTable(3); //表格两列
							table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							table1.setWidthPercentage(100);//表格的宽度为100%
							table1.setSpacingAfter(15f);
							table1.getDefaultCell().setBorderWidth(0); //不显示边框
							//table1.getDefaultCell().setBorderColor(Color.BLUE);
							//table1.getDefaultCell().setBorderWidthBottom(3f);
							
							float[] wid1 ={0.35f,0.3f,0.35f};
							table1.setWidths(wid1);
							
							Image jpeg1=null;
							Image jpeg2=null;
							if(groupLine.getBrand().equals(Constant.BRAND_ITEMS[0])){
								PdfPCell cell1 = new PdfPCell(new Paragraph(""));
								cell1.setBorder(0);
								table1.addCell(cell1);
								jpeg2 = Image.getInstance(servletContext.getRealPath("/")+"resources/peerUser/images/echinatours-logo.png");
								jpeg2.setAlignment(Image.ALIGN_LEFT);// 图片居中
								table1.addCell(jpeg2);
								PdfPCell cell2 = new PdfPCell(new Paragraph(""));
								cell2.setBorder(0);
								table1.addCell(cell2);
							}else{
								jpeg1 = Image.getInstance(servletContext.getRealPath("/")+"resources/peerUser/images/logo3.png");
								jpeg2 = Image.getInstance(servletContext.getRealPath("/")+"resources/peerUser/images/logo.png");
								jpeg1.setAlignment(Image.ALIGN_LEFT);// 图片居中
								jpeg2.setAlignment(Image.ALIGN_LEFT);// 图片居中
								table1.addCell(jpeg1);
								PdfPCell cell2 = new PdfPCell(new Paragraph(""));
								cell2.setBorder(0);
								table1.addCell(cell2);
								table1.addCell(jpeg2);
							}
							
							document.add(table1);
							
							PdfPTable Line = new PdfPTable(1);
							Line.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							Line.setWidthPercentage(100);//表格的宽度为100%
							Line.setSpacingAfter(15f);
							Line.getDefaultCell().setBorderWidth(0); //不显示边框
							Line.getDefaultCell().setBorderColor(Color.BLUE);
							Line.getDefaultCell().setBorderWidthBottom(1f);
							PdfPCell cell5 = new PdfPCell(new Paragraph(""));
							cell5.setBorder(0);
							cell5.setBorderColor(Color.BLUE);
							cell5.setBorderWidthBottom(1f);
							Line.addCell(cell5);
							document.add(Line);
							
							
							//添加行程信息
							Paragraph groupRouteTittle = new Paragraph(groupLine.getTourName(),norm_fontChineseForTittle);
							groupRouteTittle.setAlignment(Paragraph.ALIGN_CENTER);
							groupRouteTittle.setSpacingAfter(10f);
							groupRouteTittle.setSpacingBefore(15f);
							document.add(groupRouteTittle);
							List<GroupRoute> groupRoutes = groupRouteMapper.findGroupRouteByGroupLineId(groupLineId);
							for(GroupRoute groupRoute:groupRoutes){
								Paragraph dayNumAndRouteName = new Paragraph("第"+groupRoute.getDayNum()+"天"+":	   "+groupRoute.getRouteName(),norm_fontChineseForHead);
								document.add(dayNumAndRouteName);
								Paragraph routeDescForCh = new Paragraph(groupRoute.getRouteDescribeForEn(),norm_fontChinese);
								routeDescForCh.setSpacingBefore(10f);
								routeDescForCh.setSpacingAfter(20f);
								document.add(routeDescForCh);
							}
							
							
							//添加特殊条款
							if(groupLine.getSpecificItems()!=null){
								Paragraph specificItemsTittle = new Paragraph("SPECIFIC ITEMS",bold_fontEng);
								specificItemsTittle.setSpacingBefore(12f);
								document.add(specificItemsTittle);
								Paragraph specificItems = new Paragraph(groupLine.getSpecificItems()==null?"":groupLine.getSpecificItems(),norm_fontChinese);
								specificItems.setAlignment(Paragraph.ALIGN_LEFT);
								document.add(specificItems);
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
				
				//B2B
				@Override
				public String createBPdfforOpConfirm(String orderId) {
					    Order order = orderMapper.findCustomerForOrderId(orderId); //查找订单下的所有客人case 
					    String status="";
					    if(order.getReviewState()==1||order.getReviewState()==5){
					    	status="PENDING";
					    }else if(order.getReviewState()==2){
					    	status="CONFIRMED";
					    }else if(order.getReviewState()==3){
					    	status="DECLINE";
					    }else{
					    	status="PENDING";
					    }
					    String orderNumber = order.getOrderNo();
					    OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
					    PeerUser peerUser = peerUserMapper.findById(ordersTotal.getPeerUserId());
					    String addressString = "";
					    String telString = "";
					    String mailString = "";
					    String agentString = "";
					    String subString = "";
					    String country="";
					    
					    if(ordersTotal.getWr().equals("wholeSale")){
					    	if((ordersTotal.getCompanyId()!=null)&&(ordersTotal.getCompanyId().length()!=0)){
						    	Vender vender = venderMapper.findById(ordersTotal.getCompanyId());
						    	addressString = vender.getAddress();
						    	telString = vender.getTel();
						    	mailString = vender.getB2bEmail();
						    	agentString = vender.getName();
						    	subString=vender.getCityId()+" "+vender.getStateId()+" "+vender.getZipCode();
						    	if(vender.getCountryId()!=null && !vender.getCountryId().equals("")){
						    		country=countryMapper.findById(vender.getCountryId()).getCountryName();
						    	}
					    	}
					    }else if(ordersTotal.getWr().equals("retail")){
					    	Admin agent = adminService.findById(ordersTotal.getUserId());
//					    	Dept dept = deptMapper.findById(agent.getDeptId());
					    	addressString = agent.getAddress();
					    	telString = agent.getTel();
					    	mailString = agent.getEmail();
					    	agentString = order.getUserName();
					    }
					    List<Customer> customers = new ArrayList<Customer>();
						List<CustomerOrderRel> customerOrderRelList=order.getCustomerOrderRel();
						for(int j=0;j<customerOrderRelList.size();j++){
							if(customerOrderRelList.get(j).getIsDel()==0||customerOrderRelList.get(j).getIsDel()==3){
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
					if(groupLineId==null ||groupLineId.equals("")){
						return "No";
					}
					GroupLine groupLine = groupLineMapper.findById(groupLineId);
					GroupLine groupLineForHotel = groupLineMapper.findHotelByGroupLineId(groupLineId);
					
					Setting setting = SettingUtils.get();
					String uploadPath = setting.getTempPDFPath();
					String destPath = null;
					try {
						Map<String, Object> model = new HashMap<String, Object>();
						String path = FreemarkerUtils.process(uploadPath, model);
						destPath = path + "voucher-"+orderNumber+".pdf";
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
							Font norm_fontChinese = new Font(bfChinese, 10, Font.NORMAL, Color.BLACK);
							Font norm_fontChineseGray = new Font(bfChinese, 10, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForRemarks = new Font(bfChinese, 10, Font.NORMAL, Color.RED);  //备注详情显示为红色
							Font norm_fontChineseForTittle = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForHead = new Font(bfChinese, 11, Font.BOLD, Color.BLACK);
							Font norm_fontChineseForContent = new Font(bfChinese, 9, Font.BOLD, Color.BLACK);
							Font bold_fontEng = new Font(bfEng, 12, Font.NORMAL,
									Color.BLACK);
							Font bold_fontEngForRemarks = new Font(bfEng, 12, Font.NORMAL,
									Color.RED);   //备注信息显示为红色
							Font bold_fontEngForTableHead = new Font(bfEng, 11, Font.NORMAL,
									Color.BLACK);
							Font conSpe = new Font(bfChinese, 14, Font.NORMAL, Color.RED);  //苏州联系人红色标注部分

							/**
							 * 新建一个字体,iText的方法 STSongStd-Light 是字体，在iTextAsian.jar 中以property为后缀
							 * UniGB-UCS2-H 是编码，在iTextAsian.jar 中以cmap为后缀 H 代表文字版式是 横版， 相应的 V
							 * 代表竖版
							 */
							
							document.open();
							// 添加抬头图片
							
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
							PdfPTable table1 = new PdfPTable(3); //表格两列
							table1.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							table1.setWidthPercentage(100);//表格的宽度为100%
							table1.getDefaultCell().setBorderWidth(0); //不显示边框
							table1.getDefaultCell().setBorderColor(Color.GRAY);
							if(logoPath.equals(Constant.LOGO_PATH[3])){
								float[] wid1 ={0.45f,0.25f,0.30f};
								table1.setWidths(wid1);
							}else if(logoPath.equals(Constant.LOGO_PATH[1])){
								float[] wid1 ={0.2f,0.40f,0.30f};
								table1.setWidths(wid1);
							}else if(logoPath.equals(Constant.LOGO_PATH[0])){
								float[] wid1 ={0.25f,0.45f,0.30f};
								table1.setWidths(wid1);
							}else if(logoPath.equals(Constant.LOGO_PATH[2])){
								float[] wid1 ={0.45f,0.25f,0.30f};
								table1.setWidths(wid1);
							}
							Image jpeg = Image.getInstance(servletContext.getRealPath("/")+logoPath);
							jpeg.setAlignment(Image.ALIGN_LEFT);// 图片居中
							if(!peerUser.getLogoAddress().equals("")){
								Image jpegs = Image.getInstance(servletContext.getRealPath("/")+peerUser.getLogoAddress());
								jpegs.setAlignment(Image.ALIGN_LEFT);// 图片居中
								jpegs.scaleAbsolute(150f, 80f);
								
								PdfPCell cell1 = new PdfPCell(jpegs); //中间放以空白列
								cell1.setBorder(0);
								table1.addCell(cell1);
								
								PdfPCell cells = new PdfPCell(new Paragraph("")); //中间放以空白列
								cells.setBorder(0);
								cells.setBorderColor(Color.GRAY);
								table1.addCell(cells);
								
								table1.addCell(jpeg);
								
							}else{
								PdfPCell cell1 = new PdfPCell(new Paragraph("")); //中间放以空白列
								cell1.setBorder(0);
								cell1.setBorderColor(Color.GRAY);
								table1.addCell(cell1);
								
								PdfPCell cell2 = new PdfPCell(new Paragraph(""));
								cell2.setBorder(0);
								cell2.setBorderColor(Color.GRAY);
								table1.addCell(cell2);
								
								table1.addCell(jpeg);
							}
							document.add(table1);
							
							PdfPTable peerTable=new PdfPTable(1);

							peerTable.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
							peerTable.setWidthPercentage(100);//表格的宽度为100%
							peerTable.getDefaultCell().setBorderWidth(0); //不显示边框
							peerTable.getDefaultCell().setBorderColor(Color.GRAY);
							PdfPCell pCell1=new PdfPCell(new Paragraph(agentString,norm_fontEng));
							pCell1.setBorder(0);
							pCell1.setBorderColor(Color.GRAY);
							PdfPCell pCell2=new PdfPCell(new Paragraph(addressString,norm_fontEng));
							pCell2.setBorder(0);
							pCell2.setBorderColor(Color.GRAY);
							PdfPCell pCell3=new PdfPCell(new Paragraph(subString,norm_fontEng));
							pCell3.setBorder(0);
							pCell3.setBorderColor(Color.GRAY);
							PdfPCell pCell4=new PdfPCell(new Paragraph(country,norm_fontEng));
							pCell4.setBorder(0);
							pCell4.setBorderColor(Color.GRAY);
							PdfPCell pCell5=new PdfPCell(new Paragraph("Tel:        "+telString,norm_fontEng));
							pCell5.setBorder(0);
							pCell5.setBorderColor(Color.GRAY);
							PdfPCell pCell6=new PdfPCell(new Paragraph("Email:    "+mailString,norm_fontEng));
							pCell6.setBorder(0);
							pCell6.setBorderColor(Color.GRAY);
							
							peerTable.addCell(pCell1);
							peerTable.addCell(pCell2);
							peerTable.addCell(pCell3);
							peerTable.addCell(pCell4);
							peerTable.addCell(pCell5);
							peerTable.addCell(pCell6);
							
							document.add(peerTable);
							
							
							
							PdfContentByte cb=writer.getDirectContent();
							
							//添加线路信息
							TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(order.getId());
							Paragraph lineTittle = new Paragraph(groupLine.getTourName(),norm_fontChineseForTittle);
							lineTittle.setAlignment(Paragraph.ALIGN_CENTER);
							lineTittle.setSpacingAfter(7f);
							lineTittle.setSpacingBefore(7f);
							document.add(lineTittle);
							Paragraph lineEnTittle = new Paragraph(groupLine.getTourNameEn(),norm_fontChineseForTittle);
							lineEnTittle.setAlignment(Paragraph.ALIGN_CENTER);
							lineEnTittle.setSpacingAfter(7f);
							lineEnTittle.setSpacingBefore(7f);
							document.add(lineEnTittle);
							PdfPTable lineInfo = new PdfPTable(3);
							lineInfo.setWidthPercentage(100);//表格的宽度为100%
							float[] wid2 ={0.33f,0.30f,0.37f}; //两列宽度的比例
							lineInfo.setWidths(wid2); 
							lineInfo.getDefaultCell().setBorderWidth(0); //不显示边框
							lineInfo.getDefaultCell().setMinimumHeight(25f);
							
							PdfPCell tourCode = new PdfPCell(new Paragraph(	 "Tour Code:	"+tourInfoForOrder.getScheduleLineCode(),norm_fontEng));
							tourCode.setBorder(0);
							lineInfo.addCell(tourCode);
							
							
							SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
							String departureDate = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
							String[] dates = departureDate.split("-");
							String str = dates[1];
						    SimpleDateFormat sdf = new SimpleDateFormat("MM");
						    Date date1 = sdf.parse(str);
						    sdf = new SimpleDateFormat("MMMMM",Locale.US);
						    departureDate = dates[0]+" "+sdf.format(date1)+" "+dates[2];
							PdfPCell arriveDate = new PdfPCell(new Paragraph("Departure Date:	"+departureDate,norm_fontEng));
							arriveDate.setBorder(0);
							lineInfo.addCell(arriveDate);
							String noString=null;
							if(order.getReviewState()==0){
								noString=order.getOrderNo();
							}else{
								
								noString=order.getOrderNo().substring(0,order.getOrderNo().indexOf("-"))+"("+status+")";
							}
							PdfPCell invoiceId = new PdfPCell(new Paragraph("Booking NO:	"+noString,norm_fontEng));
							invoiceId.setBorder(0);
							lineInfo.addCell(invoiceId);
								PdfPCell agent = new PdfPCell(new Paragraph("",norm_fontEng));
								agent.setBorder(0);
								lineInfo.addCell(agent);
							
							PdfPCell subAgent = new PdfPCell(new Paragraph("",norm_fontEng));
							subAgent.setBorder(0);
							lineInfo.addCell(subAgent);
							
							PdfPCell space = new PdfPCell(new Paragraph(" ",norm_fontEng));
							space.setBorder(0);
							lineInfo.addCell(space);
							document.add(lineInfo);
							/*cb.setLineWidth(0.3f);
							cb.moveTo(40f, 600f);
							cb.lineTo(560f, 600f);
							cb.setColorStroke(Color.GRAY);
							cb.stroke();*/
							
							//String regEx = "[\\u4e00-\\u9fa5]"; 
							//Pattern p = Pattern.compile(regEx);
							
							//添加Op添加导游，第一晚酒店信息
							Tour tour=new Tour();
							ItineraryInfo info=new ItineraryInfo();
							if(order.getTourId()!=""){
								tour=tourMapper.findById(order.getTourId());
								info=itineraryInfoMapper.findByTourId(tour.getTourId());
								
								if(info!=null){
									Paragraph FinalvoucherRemarks = new Paragraph("Final Voucher Remarks:",norm_fontChineseForHead);
									FinalvoucherRemarks.setSpacingBefore(8f);
									document.add(FinalvoucherRemarks);
									
									PdfPTable Finalvoucher = new PdfPTable(1); 
									Finalvoucher.setSpacingBefore(5f);
									Finalvoucher.setSpacingAfter(5f);
									Finalvoucher.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
									Finalvoucher.setWidthPercentage(100);//表格的宽度为100%
									
									
									PdfPCell Finalvoucher_cell = new PdfPCell(new Paragraph(info.getHotelInfo(),norm_fontChinese));
									Finalvoucher_cell.setBorder(0);
//									Finalvoucher_cell.setPaddingTop(5f);
//									Finalvoucher_cell.setPaddingBottom(7f);
									Finalvoucher_cell.setMinimumHeight(10f);
									Finalvoucher.addCell(Finalvoucher_cell);
									
									document.add(Finalvoucher);
									
									Paragraph OthervoucherRemarks = new Paragraph("Other  Remarks:",norm_fontChineseForHead);
									FinalvoucherRemarks.setSpacingBefore(8f);
									document.add(OthervoucherRemarks);
									
									PdfPTable Othervoucher_cell = new PdfPTable(1); 
									Othervoucher_cell.setSpacingBefore(5f);
									Othervoucher_cell.setSpacingAfter(5f);
									Othervoucher_cell.setHorizontalAlignment(Element.ALIGN_CENTER); //垂直居中
									Othervoucher_cell.setWidthPercentage(100);//表格的宽度为100%
									
									
									PdfPCell CellInfo_2 = new PdfPCell(new Paragraph(info.getItineraryInfo(),norm_fontChinese));
									CellInfo_2.setBorder(0);
//									CellInfo_2.setPaddingTop(5f);
//									CellInfo_2.setPaddingBottom(7f);
									CellInfo_2.setMinimumHeight(10f);
									Othervoucher_cell.addCell(CellInfo_2);
									
									document.add(Othervoucher_cell);
									
								}
							}
							
							//客人信息
							Paragraph customerInfoTittle = new Paragraph("CUSTOMER INFORMATION",bold_fontEng);
							customerInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
							customerInfoTittle.setSpacingAfter(10f);
							customerInfoTittle.setSpacingBefore(10f);
							document.add(customerInfoTittle);
							
							PdfPTable customerData = new PdfPTable(8);
							customerData.setWidthPercentage(100);
							float[] wid ={0.05f,0.25f,0.3f,0.15f,0.25f,0.35f,0.25f,0.3f};
							customerData.setWidths(wid);
							customerData.getDefaultCell().setBorderWidthBottom(0);
							PdfPCell customerHeader = new PdfPCell();
							customerHeader.setBorder(0);
							customerHeader.setBorderColorBottom(Color.GRAY);
							customerHeader.setBorderWidthBottom(0.3f);
							customerHeader.setBorderWidthTop(1.5f);
							customerHeader.setMinimumHeight(30f);
							customerHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							customerHeader.setMinimumHeight(25f);
							customerHeader.setBorderWidth(0.5f);
							customerHeader.setPhrase(new Phrase("#",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Category",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Name",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Gender",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Date of Birth",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Language",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Nationality",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							customerHeader.setPhrase(new Phrase("Residency",bold_fontEngForTableHead));
							customerData.addCell(customerHeader);
							for(int i=0;i<customers.size();i++){
									//判断客人的年龄类型
									String customerType="";
									if(customers.get(i).getType()==4){
										customerType="Adult";
									}else if(customers.get(i).getType()==3){
										customerType="Child with Bed";
									}else if(customers.get(i).getType()==2){
										customerType="Child without Bed";
									}else{
										customerType="Infant";
									}
									//语言
									String lange="";
									if(!customers.get(i).getLanguageId().equals("0")){
										lange=languageMapper.findById(customers.get(i).getLanguageId()).getLanguage();
									}
									PdfPCell customerNum = new PdfPCell();
									customerNum.setBorder(0);
									customerNum.setBorderColorBottom(Color.GRAY);
									customerNum.setBorderWidthBottom(0.3f);
									customerNum.setMinimumHeight(36f);
									customerNum.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									customerNum.addElement(new Phrase(customers.get(i).getCustomerOrderNo().toString(),norm_fontEng));
									customerData.addCell(customerNum);
									
									PdfPCell category = new PdfPCell();
									category.setBorder(0);
									category.setBorderColorBottom(Color.GRAY);
									category.setBorderWidthBottom(0.3f);
									category.setMinimumHeight(36f);
									category.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									category.addElement(new Phrase(customerType,norm_fontChineseForContent));
									customerData.addCell(category);
									
									PdfPCell customerName = new PdfPCell();
									customerName.setBorder(0);
									customerName.setBorderColorBottom(Color.GRAY);
									customerName.setBorderWidthBottom(0.3f);
									customerName.setMinimumHeight(36f);
									customerName.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									customerName.addElement(new Phrase(customers.get(i).getLastName()+"/"+customers.get(i).getFirstName()+customers.get(i).getMiddleName(),norm_fontChineseForContent));
									customerData.addCell(customerName);
									
									PdfPCell gender = new PdfPCell();
									gender.setBorder(0);
									gender.setBorderColorBottom(Color.GRAY);
									gender.setBorderWidthBottom(0.3f);
									gender.setMinimumHeight(36f);
									gender.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									String sexForString = "";
									if(customers.get(i).getSex()==1){
										sexForString="female";
									}else if(customers.get(i).getSex()==2){
										sexForString="male";
									}
									gender.addElement(new Phrase(sexForString,norm_fontEng));
									customerData.addCell(gender);
									
									PdfPCell birth = new PdfPCell();
									birth.setBorder(0);
									birth.setBorderColorBottom(Color.GRAY);
									birth.setBorderWidthBottom(0.3f);
									birth.setMinimumHeight(36f);
									birth.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
									birth.addElement(new Phrase(customers.get(i).getDateOfBirth()==null?"":simpleDateFormat.format(customers.get(i).getDateOfBirth()),norm_fontEng));
									customerData.addCell(birth);
									
									PdfPCell language = new PdfPCell();
									language.setBorder(0);
									language.setBorderColorBottom(Color.GRAY);
									language.setBorderWidthBottom(0.3f);
									language.setMinimumHeight(36f);
									language.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									language.addElement(new Phrase(lange,norm_fontChineseGray));
									customerData.addCell(language);
									
									PdfPCell nationality = new PdfPCell();
									nationality.setBorder(0);
									nationality.setBorderColorBottom(Color.GRAY);
									nationality.setBorderWidthBottom(0.3f);
									nationality.setMinimumHeight(36f);
									nationality.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									String countryName = "";
									if(customers.get(i).getNationalityOfPassport()!=null){
											countryName = customers.get(i).getNationalityOfPassport();
									}
									nationality.addElement(new Phrase(customers.get(i).getCountryId()==null?"":countryName,norm_fontEng));
									customerData.addCell(nationality);
									
									PdfPCell residency = new PdfPCell();
									residency.setBorder(0);
									residency.setBorderColorBottom(Color.GRAY);
									residency.setBorderWidthBottom(0.3f);
									residency.setMinimumHeight(36f);
									residency.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									residency.addElement(new Phrase(customers.get(i).getResidency(),norm_fontEng));
									customerData.addCell(residency);
								}
							document.add(customerData);
							
							
							//航班信息
							Paragraph flightInfoTittle = new Paragraph("FLIGHT INFORMATION",bold_fontEng);
							flightInfoTittle.setAlignment(Paragraph.ALIGN_CENTER);
							flightInfoTittle.setSpacingAfter(10f);
							flightInfoTittle.setSpacingBefore(15f);
							document.add(flightInfoTittle);
							
							PdfPTable flightData = new PdfPTable(7);
							//float[] wid6 ={0.33f,0.33f,0.33f};
							flightData.setWidthPercentage(100);
							flightData.getDefaultCell().setBorderWidthBottom(0);
							PdfPCell flightHeader = new PdfPCell();
							
							flightHeader.setBorder(0);
							flightHeader.setBorderColorBottom(Color.GRAY);
							flightHeader.setBorderWidthBottom(0.3f);
							flightHeader.setBorderWidthTop(1.5f);
							flightHeader.setMinimumHeight(30f);
							flightHeader.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
							flightHeader.setMinimumHeight(25f);
							flightHeader.setBorderWidth(0.5f);
							flightHeader.setPhrase(new Phrase("Date",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Airline",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("No.",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Dep.Time",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Arr.Time",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Cust No.",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							flightHeader.setPhrase(new Phrase("Remark",bold_fontEngForTableHead));
							flightData.addCell(flightHeader);
							
							List<CustomerFlight> customerFlights = new ArrayList<CustomerFlight>();
							for(Customer customer:customers){
									customerFlights.addAll(customer.getCustomerFlight());
							}
							
							List<CustomerFlight> cfs = this.addList(customerFlights);
							if(cfs!=null){
							for(CustomerFlight flight: cfs){
								if(flight.getFlightNumber()!=null&&flight.getFlightNumber().length()!=0){
								PdfPCell date = new PdfPCell();
								date.setBorder(0);
								date.setBorderColorBottom(Color.GRAY);
								date.setBorderWidthBottom(0.3f);
								date.setMinimumHeight(36f);
								date.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd");
								date.addElement(new Phrase(flight.getArriveDate()==null?"":simpleDateFormat.format(flight.getArriveDate()),norm_fontEng));
								flightData.addCell(date);
								
								PdfPCell airLine = new PdfPCell();
								airLine.setBorder(0);
								airLine.setBorderColorBottom(Color.GRAY);
								airLine.setBorderWidthBottom(0.3f);
								airLine.setMinimumHeight(36f);
								airLine.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								airLine.addElement(new Phrase(flight.getFlightCode(),norm_fontEng));
								flightData.addCell(airLine);
								
								PdfPCell flightNo = new PdfPCell();
								flightNo.setBorder(0);
								flightNo.setBorderColorBottom(Color.GRAY);
								flightNo.setBorderWidthBottom(0.3f);
								flightNo.setMinimumHeight(36f);
								flightNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								flightNo.addElement(new Phrase(flight.getFlightNumber(),norm_fontEng));
								flightData.addCell(flightNo);
								PdfPCell remark = new PdfPCell();
								if(flight.getOutOrEnter()==1){
									PdfPCell arrTime = new PdfPCell();
									arrTime.setBorder(0);
									arrTime.setBorderColorBottom(Color.GRAY);
									arrTime.setBorderWidthBottom(0.3f);
									arrTime.setMinimumHeight(36f);
									arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									arrTime.addElement(new Phrase("",norm_fontEng));
									flightData.addCell(arrTime);
									
									PdfPCell depTime = new PdfPCell();
									depTime.setBorder(0);
									depTime.setBorderColorBottom(Color.GRAY);
									depTime.setBorderWidthBottom(0.3f);
									depTime.setMinimumHeight(36f);
									depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									depTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
									flightData.addCell(depTime);
									
									remark.setBorder(0);
									remark.setBorderColorBottom(Color.GRAY);
									remark.setBorderWidthBottom(0.3f);
									remark.setMinimumHeight(36f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									if(flight.getIfPickUp()==1){
										remark.addElement(new Phrase("pick up",norm_fontEng));
									}else if(flight.getIfPickUp()==2){
										remark.addElement(new Phrase("",norm_fontEng));
									}
								}else if(flight.getOutOrEnter()==2){
									PdfPCell arrTime = new PdfPCell();
									arrTime.setBorder(0);
									arrTime.setBorderColorBottom(Color.GRAY);
									arrTime.setBorderWidthBottom(0.3f);
									arrTime.setMinimumHeight(36f);
									arrTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									arrTime.addElement(new Phrase(flight.getArriveTime(),norm_fontEng));
									flightData.addCell(arrTime);
									
									PdfPCell depTime = new PdfPCell();
									depTime.setBorder(0);
									depTime.setBorderColorBottom(Color.GRAY);
									depTime.setBorderWidthBottom(0.3f);
									depTime.setMinimumHeight(36f);
									depTime.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									depTime.addElement(new Phrase("",norm_fontEng));
									flightData.addCell(depTime);
									
									remark.setBorder(0);
									remark.setBorderColorBottom(Color.GRAY);
									remark.setBorderWidthBottom(0.3f);
									remark.setMinimumHeight(36f);
									remark.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
									if(flight.getIfSendUp()==1){
										remark.addElement(new Phrase("drop off",norm_fontEng));
									}else if(flight.getIfSendUp()==2){
										remark.addElement(new Phrase("",norm_fontEng));
									}
								}
								
								
								PdfPCell customerNo = new PdfPCell();
								customerNo.setBorder(0);
								customerNo.setBorderColorBottom(Color.GRAY);
								customerNo.setBorderWidthBottom(0.3f);
								customerNo.setMinimumHeight(36f);
								customerNo.setVerticalAlignment(PdfPCell.ALIGN_MIDDLE);
								customerNo.addElement(new Phrase(flight.getCustomerNos(),norm_fontEng));
								flightData.addCell(customerNo);
								flightData.addCell(remark);
								}
							}
							}
							document.add(flightData);
							
							//备注信息
							if(tourInfoOrder.getVoucherRemarks()!=null){
								Paragraph voucherRemarksTittle = new Paragraph("Tour Voucher Remarks",bold_fontEngForRemarks);
								voucherRemarksTittle.setSpacingBefore(10f);
								document.add(voucherRemarksTittle);
								Paragraph voucherRemarks = new Paragraph(tourInfoOrder.getVoucherRemarks()==null?"":tourInfoOrder.getVoucherRemarks(),norm_fontChineseForRemarks);
								voucherRemarks.setAlignment(Paragraph.ALIGN_LEFT);
								document.add(voucherRemarks);
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
				//////////////////////////////////////////////////
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
