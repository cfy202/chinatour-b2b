[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>${message("admin.main.title")}</title>
[#include "/admin/peerUser/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/peerUser/include/navbar.ftl"]
<div id="cl-wrapper" class="bg">
    <div class="w1" id="pcont">
        <div class="">		
    <div>
      <div class="fuelux ">
        <div class="block-wizard tourinfo_buzhou">
          <div id="wizard1" class="wizard wizard-ux" style="font-weight:bold;background:#ffffff;">
            <ul>
              <li data-target="#step1" id="stepdiv1" class="active"><i class="fa fa-calendar"></i>&nbsp;Tour Info<span class="chevron"></span></li>
              <li data-target="#step2" id="stepdiv2" ><i class="fa fa-group"></i>&nbsp;Customer Info<span class="chevron"></span></li>
              <li data-target="#step3" id="stepdiv3" ><i class="fa fa-home"></i>&nbsp;Room Info<span class="chevron"></span></li>
              <li data-target="#step4" id="stepdiv4" ><i class="fa fa-plane"></i>&nbsp;Flight Info<span class="chevron"></span></li>
              <li data-target="#step5" id="stepdiv5" ><i class="fa fa-meh-o"></i>&nbsp;Pre/Post Tour Accommodation<span class="chevron"></span></li>
              <li data-target="#step6" id="stepdiv6" ><i class="fa fa-file-text"></i>&nbsp;Tour Remark<span class="chevron"></span></li>
            </ul>
            <div class="clear"></div>
          </div>
          <div class="step-content" style="margin-top:20px;">
            <form class="form-horizontal group-border-dashed" id="ww" action="tourOrderUpdate.jhtml" data-parsley-validate novalidate>
				<input type="hidden" name="productVO.ordersTotalId" id="ordersTotalId" value="${ordersTotal.ordersTotalId}">
				<input type="hidden" id="orderNumber" value="${ordersTotal.orderNumber}">
				<input type="hidden" name="productVO.order.orderId" value="${productVO.order.id}">
				<input type="hidden" name="productVO.tourInfoForOrder.id" value="${productVO.tourInfoForOrder.id}">
				<input type="hidden" name="productVO.tourInfoForOrder.groupLineId" id="groupId"  value="${groupLine.id}">
				<input type="hidden" name="productVO.order.peerUserFee" value="${productVO.order.peerUserFee}">
				<input type="hidden" name="productVO.receivableInfoOfOrder.totalCommonTourFee" value="${productVO.receivableInfoOfOrder.totalCommonTourFee}">
				<input type="hidden" name="productVO.order.profit" id="supplement" value="${ageOfPrice.supplement}">
            	<input type="hidden" name="productVO.order.peerUserName" value="${peerUser.peerUserName}"/> 
				<input type="hidden" id="singlePrice" value="${singleNum}">
				<input type="hidden" name="productVO.otherFeeList[0].itemFee" id="tipTotal" value="[#if productVO.otherFeeList[0].itemFee==null]0[#else]${productVO.otherFeeList[0].itemFee}[/#if]"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[0].remark" value="小费总额"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[0].type" value="2"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[0].num" value="201"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[1].itemFee" id="selfTotal" value="[#if productVO.otherFeeList[1].itemFee==null]0[#else]${productVO.otherFeeList[1].itemFee}[/#if]"><!--自费总额-->
				<input type="hidden" name="productVO.otherFeeList[1].remark" value="自费总额"><!--自费总额-->
				<input type="hidden" name="productVO.otherFeeList[1].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[1].num" value="202"><!--自费总额-->
				<input type="hidden" name="productVO.otherFeeList[2].itemFee" id="hotelTotal" value="[#if productVO.otherFeeList[2].itemFee==null]0[#else]${productVO.otherFeeList[2].itemFee}[/#if]"><!--酒店费用总额-->
				<input type="hidden" name="productVO.otherFeeList[2].remark" value="酒店费用总额"><!--酒店费用总额-->
				<input type="hidden" name="productVO.otherFeeList[2].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[2].num" value="203">
				<input type="hidden" name="productVO.otherFeeList[3].itemFee" id="ticketTotal" value="[#if productVO.otherFeeList[3].itemFee==null]0[#else]${productVO.otherFeeList[3].itemFee}[/#if]"><!--接送机费用总额-->
				<input type="hidden" name="productVO.otherFeeList[3].remark" value="接送机费用总额"><!--接送机费用总额-->
				<input type="hidden" name="productVO.otherFeeList[3].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[3].num" value="204">
				<input type="hidden" name="productVO.otherFeeList[4].itemFee" id="supTotal" value="[#if productVO.otherFeeList[4].itemFee==null]0[#else]${productVO.otherFeeList[4].itemFee}[/#if]"><!--单房差价格-->
				<input type="hidden" name="productVO.otherFeeList[4].remark" value="单房差价格"><!--接送机费用总额-->
				<input type="hidden" name="productVO.otherFeeList[4].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[4].num" value="205">
				<input type="hidden" id="supplement"><!--单房差价格-->
				<input type="hidden" id="totalSP" name="productVO.price" value="${productVO.order.cusPrice}"/><!--订单应收款-->
				<input type="hidden" name="" id="hotelPrice" value="${ageOfPrice.hotelPrice}"><!--酒店费用单价-->
				<input type="hidden" name="" id="pickSendPrice" value="${groupLine.pickSendPrice}"><!--接送机费用单价美元-->
				<input type="hidden" name="" id="lease" value="${groupLine.least}"><!--最少人数用单价-->
				<input name="wr" value="wholeSale" type="hidden">
				<input name="productVO.feeItems" id="feeItems" type="hidden">
				<div style="display:none;" id="cusback"></div>
				<div class="step-pane active" id="step1">
						<div class="tourinfo_leftbox fl">
		                    <div class="tourinfo_name">
				        		Product Code：${groupLine.tourCode}
				        		</br>
				        		${groupLine.tourName}
				        	</div>
				            <div class="tourinfo_box">
				            	<div class="tourinfo_titile_1">Product Info</div>
				                <div class="line"></div>
				                <div class="tourinfo_date">
				                	[#if groupLine.ticket==0 ]
					                	<div class="date_d fl">
					                    	<label style="width:200px">Date Arrive In Destination<b style="color:red;">*</b>:</label>
					                        <input  type="text" disabled="disabled" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] class="tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
					                        <input  type="hidden" name="productVO.tourInfoForOrder.departureDate" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] class="tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
					                    </div>
				                    [/#if]
				                    [#if groupLine.ticket==1 ]
				                    	<div class="date_d fl">
					                    	<label>Departure Date<b style="color:red;">*</b>:</label>
					                        <input  type="text" disabled="disabled" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] class="tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
					                        <input  type="hidden" name="productVO.tourInfoForOrder.departureDate" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if]/>
					                    </div>
					                    <div class="date_d fl">
					                    	<label style="width:200px">Date Arrive In Destination<b style="color:red;">*</b>:</label>
											<input class="form-control input-group1 JDATE tourDate_d" type="text" id="scheduleOfArriveTime" value="[#if (productVO.tourInfoForOrder.scheduleOfArriveTime)??]${productVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]" class="tourDate_d" disabled="disabled" required  placeholder="yyyy-mm-dd" />
											<input type="hidden" id="scheduleOfArriveTime" name="productVO.tourInfoForOrder.scheduleOfArriveTime" value="[#if (productVO.tourInfoForOrder.scheduleOfArriveTime)??]${productVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]"/>
					                    </div>
				                    [/#if]
				                    <div class="clear"></div>
				                </div>
				                <div class="line_s"></div>
				                <div class="tourinfo_titile_1">Contact Information</div>
				                <div class="line"></div>
				                <div class="tourinfo_date">
				                	<div class="date_d fl">
				                    	<label style="width:140px;">Consultant Name  <b style="color:red;">*</b>:</label>
				                        <input type="text" disabled="disabled" id="contactName" value="${ordersTotal.contactName}" class="tourDate_d">
				                        <input type="hidden"  name="productVO.ordersTotal.contactName" value="${ordersTotal.contactName}">
				                    </div>
				                    <div class="date_d fl" style="float:right">
				                    	<label style="width:80px;">REF NO :</label>
				                        <input type="text" class="tourDate_d" disabled="disabled" value="${productVO.order.refNo}">
				                        <input type="hidden" name="productVO.order.refNo" value="${productVO.order.refNo}">
				                    </div>
				                    <div class="clear"></div>
				                </div>
				            </div>
				            <div class="form-group tourinfo_fy_btn" align="right">
								<div class="col-sm-offset-2 col-sm-10 ">
									<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default fy_btn_1" style="width:62px">Cancel</button>
									<button  onclick="changeDiv(2);" class="btn btn-primary wizard-next fy_btn_2" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
								</div>
							</div>
				        </div>
					</div>
				<div class="step-pane" id="step2">
					<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
		        		<div style="margin:0px 0px 10px 18px !important;font-weight: bold; color:#0088cc;">${groupLine.level}</div>
			            <div class="tourinfo_box">
			            	<table cellpadding="0" cellspacing="0" id="table" class="customer_tab" width="100%">
			                	<tr class="customer_tab_1">
			                    	<td align="left"><b>Last/Frist Middle Name</b></td>
			                        <td><b>Gender</b></td>
			                        <td><b>Nationality</b></td>
			                        <td><b>PassportNo.</b></td>
			                        <td><b>Date Of Birth</b></td>
			                        <td><b>Type</b></td>
			                        <td><b>Remark</b></td>
			                    </tr>
			                    <tbody id="customerList" class="no-border-y">
			                    <input type="hidden" id="delOrl" name="delOrl">
			                    	[#list customerOrderRelList as customerOrderRel]
									<tr id="${customerOrderRel.id}">
										<td>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</td>
										<td>[#if customerOrderRel.customer.sex == 1]F[#else]M[/#if]</td>
										<td>${customerOrderRel.customer.nationalityOfPassport}</td>
										<td>${customerOrderRel.customer.passportNo}</td>
										<td>[#if customerOrderRel.customer.dateOfBirth??]${customerOrderRel.customer.dateOfBirth?string('yyyy-MM-dd')}[/#if]</td>
										<td align="center">[#if customerOrderRel.customer.type ==1]Infant[#elseif customerOrderRel.customer.type ==2]Child without Bed [#elseif customerOrderRel.customer.type ==3]Child with Bed[#elseif customerOrderRel.customer.type ==4]Adult[#else]<font color="red">No Type</font>[/#if]</td>
										<td>[#if customerOrderRel.customer.memoOfCustomer == 0] [#else]${customerOrderRel.customer.memoOfCustomer}[/#if]</td>
									</tr>
									[/#list]
								</tbody>
			                </table>
			            </div>
			            <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="changeDiv(1);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" id="customerFlightStep" onclick="changeDiv(3);" class="btn btn-primary wizard-next fy_btn_2" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
				 	</div>
			    </div>	
			    <div class="step-pane" id="step3">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
	                    <div class="tourinfo_box" id="PerList">
	                    	<div class="perbox">
			                	<div class="tourinfo_titile_1">Room Type</div>
			                    <div class="line"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Guest:</label>
			                            <select class="perlist" id="guestNum" onChange="setRoomType()">
			                            	<option value="">Select Guest</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Room:</label>
			                            <select class="perlist" id="roomType">
			                            	<option value="">
													select roomType
											</option>
			                            	[#list constant.GUEST_ROOM_TYPES as room]
												<option value="${room}" class="opsel">
													${room}
												</option>
											[/#list]
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:110px">Choose Room:</label>
			                            <select class="perlist" id="roomNum">
			                            	<option value="">Select No.</option>
			                            	<option value="1">NO.1</option>
			                            	<option value="2">NO.2</option>
			                            	<option value="3">NO.3</option>
			                            	<option value="4">NO.4</option>
			                            	<option value="5">NO.5</option>
			                            	<option value="6">NO.6</option>
			                            	<option value="7">NO.7</option>
			                            	<option value="8">NO.8</option>
			                            	<option value="9">NO.9</option>
			                            	<option value="10">NO.10</option>
			                            	<option value="11">NO.11</option>
			                            	<option value="12">NO.12</option>
			                            	<option value="13">NO.13</option>
			                            	<option value="14">NO.14</option>
			                            	<option value="15">NO.15</option>
			                            	<option value="16">NO.16</option>
			                            	<option value="17">NO.17</option>
			                            	<option value="18">NO.18</option>
			                            	<option value="19">NO.19</option>
			                            	<option value="20">NO.20</option>
			                            </select>
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="room" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%"><b>Room Type</b></td>
			                            <td width="10%"><b>Room Number</b></td>
			                        </tr>
			                           [#list customerOrderRelList as customerOrderRel]
										<tr class="${customerOrderRel.id}" id="room_${customerOrderRel.id}">
											<td>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</td>
											<td>${customerOrderRel.guestRoomType}</td>
											<td>NO.${customerOrderRel.roomNumber}</td>
										</tr>
										[/#list]
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                </div> 
			            <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="changeDiv(2);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="changeDiv(4);" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
	                </div>
			    </div>
          		<div class="step-pane" id="step4">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
	                    <input type="hidden" id="customerNumber" value="${productVO.customerFlights.size()}"/>
	                    <div class="tourinfo_box" id="tourinfo_box">
	                    	[#list productVO.customerFlights as cor]
	                    	<div class="flight_1" id="flight_${cor.customerFlightList[0].customerOrderRelId}">
	                    		 <input type="hidden" name="productVO.customerFlights[${cor_index}].customerId" value="${cor.customerList[0].customerId}">
								 <input type="hidden" name="productVO.customerFlights[${cor_index}].customerOrderRelId" value="${cor.customerFlightList[0].customerOrderRelId}">
								 <input type="hidden" name="productVO.customerFlights[${cor_index}].customerFlightList[0].id" value="${cor.customerFlightList[0].id}">
	                             <div class="flight_1_top">
	                                  <span class="flight_1_num fl">No.${cor_index+1}   
	                                	[#list customerList as customer]
											[#if customer.customerId == cor.customerId]${customer.lastName}/${customer.firstName}/${customer.middleName}[/#if]
										[/#list]
									  </span>
									  [#if cor_index!=0]
									  <a class="flight_1_btn r1" href="javascript:;"  onclick="theSameAsPrevious(${cor_index});">As Above</a>
									  [/#if]
									  <div class="clear"></div>
	                             </div>
	                             <div class="clear"></div>
	                             <div class="flight_1_down">
	                                 <div class="flight_1_down_main">
		                                 <div class="tourinfo_date_an fl" style="margin:10px 0px;color:#0081cc;width:100%"><i class="fa  fa-hand-o-right"></i><b>Arrival Info</b></div>
	                                     <div class="tourinfo_date_an fl">
	                                         <div class="date_d_an fl">
	                                             <label>Airline:</label>
	                                             <input class="tourDate_d_an" name="productVO.customerFlights[${cor_index}].customerFlightList[0].flightCode" value="${cor.customerFlightList[0].flightCode}" type="text"  placeholder="Airline">
	                                         </div>
	                                         <div class="date_d_an fl">
	                                             <label>Flight No.:</label>
	                                             <input class="tourDate_d_an" name="productVO.customerFlights[${cor_index}].customerFlightList[0].flightNumber" value="${cor.customerFlightList[0].flightNumber}" type="text"  placeholder="Flight No.">
	                                         </div>
	                                         <div class="date_d_an fl">
	                                             <label>Arrival Date:</label>
	                                             <input type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[0].arriveDate" id="arriveDate${cor_index}" value="[#if (cor.customerFlightList[0].arriveDate)??]${cor.customerFlightList[0].arriveDate?string('yyyy-MM-dd')}[/#if]" class="tourDate_d_an" placeholder="yyyy-mm-dd" />
	                                         </div>
	                                         <div class="date_d_an fl">
	                                             <label>Arrival Time:</label>
	                                             <input class="tourDate_d_an" type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[0].arriveTime" value="${cor.customerFlightList[0].arriveTime}" placeholder="hh:mm"/>
	                                         </div>
	                                         <div class="date_d_an fl" style="display:none;">
	                                             <span>Pick-up:</span>
	                                             <input type="radio" name="productVO.customerFlights[${cor_index}].customerFlightList[0].ifPickUp" value="1" style="width: 30px;" [#if cor.customerFlightList[0].ifPickUp==1]checked="checked"[/#if] id="ifPickUp" >Yes
	                                             <input type="radio" name="productVO.customerFlights[${cor_index}].customerFlightList[0].ifPickUp" value="2" style="width: 30px;" [#if cor.customerFlightList[0].ifPickUp==2]checked="checked"[/#if] >No
	                                         	 <input class="hasDatepicker" name="productVO.customerFlights[${cor_index}].customerFlightList[0].outOrEnter" value="1" type="hidden"></div>
	                                         <div class="clear"></div>
	                                     </div>
	                                     <div class="clear"></div>
	                                     <div class="line_las"></div>
	                                     <div class="tourinfo_date_an fl" style="margin:10px 0px;color:#0081cc;width: 100%;"><i class="fa  fa-hand-o-right"></i><b>Departure Info</b></div>
	                                     <div class="tourinfo_date_an fl">
	                                         <div class="date_d_an fl">
	                                         	 <input type="hidden" name="productVO.customerFlights[${cor_index}].customerFlightList[1].id" value="${cor.customerFlightList[1].id}">
	                                             <label>Airline:</label>
	                                             <input class="tourDate_d_an" name="productVO.customerFlights[${cor_index}].customerFlightList[1].flightCode" value="${cor.customerFlightList[1].flightCode}" type="text" placeholder="Airline">
	                                         </div>
	                                         <div class="date_d_an fl">
	                                             <label>Flight No.:</label>
	                                             <input class="tourDate_d_an" name="productVO.customerFlights[${cor_index}].customerFlightList[1].flightNumber" value="${cor.customerFlightList[1].flightNumber}" type="text" placeholder="Flight No.">
	                                         </div>
	                                         <div class="date_d_an fl">
	                                             <label>Departure Date:</label>
	                                             <input type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[1].arriveDate" id="departure${cor_index}" value="[#if (cor.customerFlightList[1].arriveDate)??]${cor.customerFlightList[1].arriveDate?string('yyyy-MM-dd')}[/#if]" class="tourDate_d_an"  placeholder="yyyy-mm-dd" />
	                                         </div>
	                                         <div class="date_d_an fl">
	                                             <label>Departure Time:</label>
	                                             <input class="tourDate_d_an"  type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[1].arriveTime"  value="${cor.customerFlightList[1].arriveTime}"  placeholder="hh:mm"/>
	                                         </div>
	                                         <div class="date_d_an fl" style="display:none;">
	                                             <span>Drop-off:</span>
	                                             <input type="radio" name="productVO.customerFlights[${cor_index}].customerFlightList[1].ifSendUp" [#if cor.customerFlightList[1].ifSendUp==1]checked="checked"[/#if] value="1"  id="ifSendUp" style="width:30px">Yes
	                                             <input type="radio" name="productVO.customerFlights[${cor_index}].customerFlightList[1].ifSendUp" [#if cor.customerFlightList[1].ifSendUp==2]checked="checked"[/#if] value="2"  style="width:30px">No
	                                             <input class="hasDatepicker" name="productVO.customerFlights[${cor_index}].customerFlightList[1].outOrEnter" value="2" type="hidden"></div>
	                                         <div class="clear"></div>
	                                     </div>
	                                   <div class="clear"></div>
	                                </div>
	                             </div>
	                         </div>
                       [/#list]
	                    </div>
	                    <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="changeDiv(3);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="changeDiv(5);" id="stepHave" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
			    </div>
			    <div class="step-pane" id="step5">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
	                     <div class="tourinfo_box" id="PerList">
	                     	<div class="tourinfo_box" id="PerList">
	                    	<input type="hidden" id="perTrNum" value="0">
	                    	<input type="hidden" id="postTrNumt" value="0">
	                    	<div id="pDiv">
				               <span ><i class="fa  fa-hand-o-right"></i>  <b>Pre Tour Accommodation?</b></span>
				               <span style="margin:0px 10px">
				               		<b><input type="checkbox"  name="preBox" disabled="disabled" [#if productVO.otherFeeList[2].itemFee==0]disabled=disabled[#else][#if prePostList!=null]checked="checked"[/#if][/#if] id="divP" onclick="haveFee(1)"/>Yes</b>
				               </span>
			            	</div>
	                    	<div class="perbox" id="perDiv" style="display:none;">
			                	<div class="tourinfo_titile_1">Pre Accommodation</div>
			                    <div class="line"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Guest:</label>
			                            <select class="perlist" id="percus">
			                            	[#list customerOrderRelList as customerOrderRel]
		                            			<option id="per_${customerOrderRel.id}">${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</option>
											[/#list]
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Room:</label>
			                            <select class="perlist" id="perroom" style="width:120px">
			                            	<option value="Twin Bed">Twin Bed</option>
											<option value="King Bed">King Bed</option>
											<option value="Single">Single</option>
											<option value="Extra Bed">Extra Bed</option>
											<option value="Sharing Existing Bed">Sharing Existing Bed</option>
			                            </select>
			                        </div>
			                         <div class="date_d fl">
			                            <label class="per_label" style="width:45px">No.:</label>
			                            <select class="perlist" id="roomNumt" style="width:70px">
			                            	<option value="1">NO.1</option>
			                            	<option value="2">NO.2</option>
			                            	<option value="3">NO.3</option>
			                            	<option value="4">NO.4</option>
			                            	<option value="5">NO.5</option>
			                            	<option value="6">NO.6</option>
			                            	<option value="7">NO.7</option>
			                            	<option value="8">NO.8</option>
			                            	<option value="9">NO.9</option>
			                            	<option value="10">NO.10</option>
			                            	<option value="11">NO.11</option>
			                            	<option value="12">NO.12</option>
			                            	<option value="13">NO.13</option>
			                            	<option value="14">NO.14</option>
			                            	<option value="15">NO.15</option>
			                            	<option value="16">NO.16</option>
			                            	<option value="17">NO.17</option>
			                            	<option value="18">NO.18</option>
			                            	<option value="19">NO.19</option>
			                            	<option value="20">NO.20</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label_day">Nights:</label>
			                            <input type="text" id="pre" value="0" class="per_day" style="height:33px !important; line-height:33px !important;">
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="pertr" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%"><b>Room Type</b></td>
			                            <td width="10%"><b>Room NO.</b></td>
			                            <td width="10%"><b>Nights</b></td>
			                        </tr>
			                         [#if prePostList!=null]
						                [#list prePostList as proInfo]
						                	[#if proInfo.type==0]
						                    <tr height="50" align="center" id="perInfo${inf_index+1}">
						                    	<td>${proInfo.guest}</td>
						                    	<td>${proInfo.roomType}</td>
						                    	<td>NO.${proInfo.roomNo}</td>
						                    	<td>${proInfo.nights}</td>
						                    </tr>
					                		[/#if]
						                [/#list]
					                [/#if]
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                </div> 
			                <div id="poDiv">
				               <span ><i class="fa  fa-hand-o-right"></i>  <b>Post Tour Accommodation?</b></span>
				               <span style="margin:0px 10px">
				               		<b><input type="checkbox"  name="postBox" disabled="disabled" [#if productVO.otherFeeList[2].itemFee==0]disabled=disabled[#else][#if prePostList!=null]checked="checked"[/#if][/#if] onclick="haveFee(2)"/>Yes</b>
				               </span>
			            	</div>
			                <div class="perbox" id="postDiv" style="display:none;">
			                	<div class="tourinfo_titile_1">Post Accommodation</div>
			                    <div class="line"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Guest:</label>
			                            <select class="perlist" id="postcus">
			                            	[#list customerOrderRelList as customerOrderRel]
		                            			<option id="per_${customerOrderRel.id}">${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</option>
											[/#list]
			                            </select>
			                        </div>
			                         <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Room:</label>
			                            <select class="perlist" id="postroom" style="width:120px">
			                            	<option value="Twin Bed">Twin Bed</option>
											<option value="King Bed">King Bed</option>
											<option value="Single">Single</option>
											<option value="Extra Bed">Extra Bed</option>
											<option value="Sharing Existing Bed">Sharing Existing Bed</option>
			                            </select>
			                        </div>
			                       	<div class="date_d fl">
			                            <label class="per_label" style="width:45px">No.:</label>
			                            <select class="perlist" id="roomNump" style="width:70px">
			                            	<option value="1">NO.1</option>
			                            	<option value="2">NO.2</option>
			                            	<option value="3">NO.3</option>
			                            	<option value="4">NO.4</option>
			                            	<option value="5">NO.5</option>
			                            	<option value="6">NO.6</option>
			                            	<option value="7">NO.7</option>
			                            	<option value="8">NO.8</option>
			                            	<option value="9">NO.9</option>
			                            	<option value="10">NO.10</option>
			                            	<option value="11">NO.11</option>
			                            	<option value="12">NO.12</option>
			                            	<option value="13">NO.13</option>
			                            	<option value="14">NO.14</option>
			                            	<option value="15">NO.15</option>
			                            	<option value="16">NO.16</option>
			                            	<option value="17">NO.17</option>
			                            	<option value="18">NO.18</option>
			                            	<option value="19">NO.19</option>
			                            	<option value="20">NO.20</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label_day">Nights:</label>
			                            <input type="text" id="post" value="0" class="per_day"  style="height:33px !important; line-height:33px !important;">
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="posttr" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%"><b>Room Type</b></td>
			                            <td width="10%"><b>Room NO.</b></td>
			                            <td width="10%"><b>Nights</b></td>
			                        </tr>
			                         [#if prePostList!=null]
						                [#list prePostList as proInfo]
						                	[#if proInfo.type==1]
						                    <tr height="50" align="center" id="perInfo${inf_index+1}">
						                    	<td>${proInfo.guest}</td>
						                    	<td>${proInfo.roomType}</td>
						                    	<td>NO.${proInfo.roomNo}</td>
						                    	<td>${proInfo.nights}</td>
						                    </tr>
					                		[/#if]
						                [/#list]
					                [/#if]
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                    <input type="hidden" id="days" value="${night}" >
			                    <input type="hidden" id="roomNoPax" value="0" >
			                    <input type="hidden" id="helfDays" value="${nightH}" >
			                    <input type="hidden" id="helfPax" value="0" >
			                </div> 
	                    </div> 
	                    </div>
	                    <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="changeDiv(4);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="changeDiv(6);" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
			    </div>
			    <div class="step-pane" id="step6">
			    	<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
			            <div class="tourinfo_box">
			            	<div class="flight_1">
			                	<div class="flight_1_top">
			                    	<span class="flight_1_num fl">Requirement:</span>
			                        <div class="clear"></div>
			                    </div>
			                    <div class="flight_1_down">
			                    	<div class="flight_1_down_main">
			                    		<textarea name="productVO.tourInfoForOrder.specialRequirements" class="textarea">${productVO.tourInfoForOrder.specialRequirements}</textarea>
			                        </div>
			                    </div>
			                    
			                </div>
			                <div class="flight_1">
			                	<div class="flight_1_top">
			                    	<span class="flight_1_num fl">Remark:</span>
			                        <div class="clear"></div>
			                    </div>
			                    <div class="flight_1_down">
			                    	<div class="flight_1_down_main">
			                    	<textarea name="productVO.tourInfoForOrder.tourInfo" id="remarkes" class="textarea">${productVO.tourInfoForOrder.tourInfo}</textarea>
			                    	<textarea name="productVO.orderRemark.updateRemark" id="recodsRemark" class="textarea" style="display:none;"></textarea>
			                        </div>
			                    </div>
			                </div>
			                <div class="flight_1">
			                	<div class="flight_1_top">
			                    	<span class="flight_1_num fl">Tour Vorcher Remark:</span>
			                        <div class="clear"></div>
			                    </div>
			                    <div class="flight_1_down">
			                    	<div class="flight_1_down_main">
			                    	<textarea name="productVO.tourInfoForOrder.voucherRemarks" id="voucherRemarks" class="textarea">${productVO.tourInfoForOrder.voucherRemarks}</textarea>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="tourinfo_fy_btn">
			                <button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="changeDiv(5);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
							<button type="button" onclick="subOk();" data-wizard="#wizard1" class="btn btn-success wizard-next fy_btn_3" style="width:90px"><i class="fa fa-check"></i> Save </button>
			            </div>
			        </div>
          		</div>
          <!--右侧层-->
          <div class="tourinfo_summary r1">
        	<div class="summary_tit"><span>SUMMARY</span></div>
            <div class="summary_box">
            	<table class="sum_table">
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Departure Date:</span></td>
            			<td style="text-align:right;width:100px"><span id="dated">[#if productVO.tourInfoForOrder.departureDate??]${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}[/#if]</span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">End Date:</span></td>
            			<td style="text-align:right;width:100px"><span id="offTime"></span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Total Number:</span><input type="hidden" value="${ordersTotal.totalPeople}" id="totalPeople" name="totalPeople" readonly /></td>
            			<td style="text-align:right"><span id="totalPeople1">${ordersTotal.totalPeople}</span>&nbsp;&nbsp;&nbsp;Pax</td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Adult:</span></td>
            			<td style="text-align:right"><span id="adult">${ageOfPrice.adult}</span>/<span id="adultNum">[#list pax as p][#if p_index==0]${p}[/#if][/#list]</span><span>Pax</span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Child with Bed:</span></td>
            			<td style="text-align:right"><span id="bed">${ageOfPrice.bed}</span>/<span id="bedNum">[#list pax as p][#if p_index==1]${p}[/#if][/#list]</span><span>Pax</span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Child without Bed:</span></td>
            			<td style="text-align:right"><span  id="notBed">${ageOfPrice.notBed}</span>/<span id="notBedNum">[#list pax as p][#if p_index==2]${p}[/#if][/#list]</span><span>Pax</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Infant:</span></td>
            			<td style="text-align:right"><span id="baby">${ageOfPrice.baby}</span>/<span id="babyNum">[#list pax as p][#if p_index==3]${p}[/#if][/#list]</span><span>Pax</span></td>
            		</tr>
            		<tr>
            			<td class="lineTd summary_box2"><span style="margin-right:10px;">Selling Price:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right"><span style="color:#ed6f42;">${currency.currencyEng}</span>  <span style="color:#ed6f42;" id="totalS">${productVO.order.cusPrice}</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Single Supplement :</span></td>
            			<td style="text-align:right"><span>${currency.currencyEng}</span> <span id="sup">${productVO.otherFeeList[4].itemFee}</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Pre/Post:</span></td>
            			<td style="text-align:right"><span>${currency.currencyEng}</span>  <span id="pp">${productVO.otherFeeList[2].itemFee}</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Pick/Send:</span></td>
            			<td  style="text-align:right"><span>${currency.currencyEng}</span>  <span id="ps">${productVO.otherFeeList[3].itemFee}</span></td>
            		</tr>
            		<tr>
            			<td>
	            			<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
	            				<span style="display: inline-block;color:#0081cc;"><input type="checkbox" id="tipBox" name="tipBox" [#if productVO.otherFeeList[0].itemFee!=0]checked="checked"[/#if] onclick="tipSum();" style="width:14px"/>Service Fee:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">USD ${groupLine.tip}/Pax</p>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">${currency.currencyEng} <span id="tipPrice"></span>/Pax</p>
            				</span>
            				<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
            					<span style="display: inline-block;color:#0081cc;">Service Fee:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">EUR 188/Pax</p>
            				</span>
            			</td>
            			<td style="text-align:right">
	            			<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
	            				<span>${currency.currencyEng}</span>  <span id="tipDiv" style="display:none">${productVO.otherFeeList[0].itemFee}</span><span id="tPrice">0</span> x <span id="tipPaxs">0</span> Pax
			                	<input type="hidden" id="tip"value="${groupLine.tip}"/>
			                	<input type="hidden" id="rate" value="${productVO.order.peerUserRate}"/>
		                	</span>
		                	<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
			                	<span>EUR</span>  <span  style="display:none">0</span><span>0</span> x <span>0</span> Pax
		                	</span>
            			</td>
            		</tr>
            		<tr>
            			<td>
            				<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
	            				<span style="display: inline-block;color:#0081cc;"><input type="checkbox" id="expenseBox"  name="expenseBox" [#if productVO.otherFeeList[1].itemFee!=0]checked="checked"[/#if] onclick="selfSum();" style="width:14px"/>Compulsory Programs:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">USD ${groupLine.selfExpense}/Pax</p>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">${currency.currencyEng}  <span id="selfPrice"></span>/Pax</p>
            				</span>
            				<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
	            				<span style="display: inline-block;color:#0081cc;">Compulsory Programs:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">EUR 0/Pax</p>
            				</span>
            			</td>
            			<td style="text-align:right">
            				<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
	            				<span>${currency.currencyEng}</span> <span id="selfDiv" style="display:none">${productVO.otherFeeList[1].itemFee}</span><span id="sPrice">0</span> x <span id="selfPaxs">0</span> Pax
	                			<input type="hidden" id="self" value="${groupLine.selfExpense}"/>
                			</span>
                			<span [#if groupLine.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLine.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
	            				<span>EUR</span>  <span  style="display:none">0</span><span >0</span> x <span >0</span> Pax
                			</span>
            			</td>
            		</tr>
            		<tr style="display:none;">
            			<td><span style="margin-right:10px;">Discount:</span></td>
            			<td style="text-align:right">
            				<input type="text"  style="text-align:right" id="dis" disabled="disabled" onchange="disPrice()" class="summary_zhekou" value="[#if discount!=null]${discount.discountPrice}[#else]0[/#if]">
            				<input type="hidden" name="productVO.discount.discountPrice" value="[#if discount!=null]${discount.discountPrice}[#else]0[/#if]">
            			</td>
            		</tr>
            		<tr >
            			<td class="lineTd summary_box2"><span style="margin-right:10px;">Other Surcharge:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right"><span style="color:#ed6f42;">${currency.currencyEng}</span> <span style="color:#ed6f42;" id="otherPrice">0</span></td>
            		</tr>
            		<tr>
            			<td ><span style="margin-right:10px;width: 115px;display: inline-block;">Adult Commission:</span></td>
            			<td  style="text-align:right">
            				<span id="compax" style="color:#ed6f42;">${ageOfPrice.commission}</span><font style="color:#ed6f42;">/</font><span id="compaxdiv" style="color:#ed6f42;">0</span>  <span style="color:#ed6f42;">Pax</span>
                			<input type="hidden" id="comm" value=""/>
            			</td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Child Commission:</span></td>
            			<td style="text-align:right">
            				<span id="childcompax" style="color:#ed6f42;">${ageOfPrice.childComm}</span><font style="color:#ed6f42;">/</font><span id="childcompaxdiv" style="color:#ed6f42;">0</span>  <span style="color:#ed6f42;">Pax</span>
                			<input type="hidden" id="childcomm" value=""/>
            			</td>
            		</tr>
            		<tr>
            			<td class="lineTd summary_box2"><span style="margin-right:10px;width: 115px;display: inline-block;">Commission:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right">
            				<span style="color:#ed6f42;">${currency.currencyEng}</span>  <span style="color:#ed6f42;" id="totalComm">${productVO.order.peerUserFee}</span></span>
            			</td>
            		</tr>
            		
            		<tr style="display:none">
            			<td class="summary_box2"><span style="margin-right:10px;">Final Amount:</span></td>
            			<td class="summary_box2" style="text-align:right"><span style="color:#ed6f42;">${currency.currencyEng}</span> <span style="color:#ed6f42;" id="totalPrice">[#if discount!=null]${productVO.receivableInfoOfOrder.totalFeeOfOthers+productVO.order.cusPrice-discount.discountPrice}[#else]${productVO.receivableInfoOfOrder.totalFeeOfOthers+productVO.order.cusPrice}[/#if]</span></td>
            		</tr>
            	</table>
            	<table width="100%">
            		<tr><td>Selling Price</td><td></td><td align="right"><span id="sumFee">0</span></td></tr>
            		<tr><td>&nbsp;&nbsp;</td><td>+</td><td>&nbsp;&nbsp;</td></tr>
            		<tr><td>Other Surcharge</td><td></td><td align="right"><span id="otherFee">0</span></td></tr>
            		<tr><td>&nbsp;&nbsp;</td><td>-</td><td>&nbsp;&nbsp;</td></tr>
            		<tr><td>Commission</td><td></td><td align="right"><span id="comFee">0</span></td></tr>
            		<tr><td>&nbsp;&nbsp;</td><td>=</td><td>&nbsp;&nbsp;</td></tr>
            		<tr><td width="77%" class="summary_box2">Total Payable/Receivable</td><td></td><td align="right"><span id="disFee">0</span></td></tr>
            		<tr>
            			<td class="summary_box2" colspan="2">
            				<span style="color:#0081cc;display: inline-block;">The above amount is subject to final approval, please refer to the final invoice.(以上結算價格僅供參考，請以經審核的最終單據為準)</span>
            			</td>
            		</tr>
            	</table>
            </div>
            
        </div>        
          </form>
          <div class="clear"></div>
        </div>
      </div>
    </div>
    </div>
    </div>
    <div class="clear"></div>
</div>

<div class="popup_formRemark">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Order Modify Record</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
    <div class="popup_from_down">
    	<div class="perbox">
        	<div class="tourinfo_titile_1">Modify Record</div>
            <div class="line"></div>
            <div class="tourinfo_date">
                <div class="">
					<textarea id="recordRemark" class="form-control input-group1" style="width:100%"></textarea>
                </div>
                <div class="clear"></div>
        	</div>
        	</div>
    </div>
    <div class="popup_from_footer" style="background-color:#f3f3f3;">
        <button type="reset" class="popup_from_Cancel" data-dismiss="modal">Cancel</button>
        <button type="button" onclick="sub();" class="popup_from_Save" data-dismiss="modal">Modify</button>
    </div>
    </form>
</div>
</div>
<div class="popup_from_mask"></div>

[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript">
/*************************悬浮层js****************************/
jQuery(document).ready(function($) {
	$('.popup_close').click(function(){
		$('.popup_from_mask').fadeOut(300);
		$('.popup_formRemark').slideUp(400);
	})
	$('.popup_from_Cancel').click(function(){
		$('.popup_from_mask').fadeOut(300)
		$('.popup_formRemark').slideUp(400);
	})

})

$(document).ready(function(){
	$('input[name="radio-btn"]').wrap('<div class="radio-btn"><i></i></div>');
	$(".radio-btn").on("click", function () {
    	var _this = $(this),
        block = _this.parent().parent();
    	block.find("input:radio").attr("checked", false);
    	block.find(".radio-btn").removeClass("checkedRadio");
    	_this.addClass("checkedRadio");
    	_this.find("input:radio").attr("checked", true);
});

});

$(".from_choice span").click(function(){
        if($(this).parent().find(".brand_op").css("display")==="none"){
            $(this).parent().find(".brand_op").fadeIn(300);
        }else{
            $(this).parent().find(".brand_op").fadeOut(300);
        }
    })
    $(".from_choice").blur(function(){
        $(this).find(".brand_op").fadeOut(300);
    });
    $(".brand_op li").click(function(){
         $(".from_choice span").text($(this).text());
		 $(".brand_op").fadeOut(300);
    })
/*************************************************/
   $(document).ready(function(){
    	$("#departureDateInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay: available, numberOfMonths: 1, minDate: 1 });
    	$("#scheduleOfArriveTimeInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#dateOfBirthInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange:'-100:+0'});
    	$("#dateOfBirth").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange:'-100:+0'});
    	/*$("#dateOfBirth").datetimepicker({showSecond: true,showMillisec: true,timeFormat: 'hh:mm:ss:l' });*/
    	$("#arriveDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#expireDateOfPassportInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#expireDateOfPassport").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	var pax=$("#totalPeople").val();
    	for(var n=0;n<pax;n++){
    		$("#arriveDate"+n).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    		$("#departure"+n).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	}
    	var self=changeTwoDecimal(Number($("#self").val())*Number($("#rate").val()));
    	$("#selfPrice").text(self);
    	$("#sPrice").text(self);
    	$("#selfPax").text(self);
    	var tip=changeTwoDecimal(Number($("#tip").val())*Number($("#rate").val()));
    	$("#tipPrice").text(tip);
    	$("#tPrice").text(tip);
    	$("#tipPax").text(tip);
    	$(".tip").show();
    	$(".self").hide();
    	price();
    	//初始化酒店提前入住和续住
    	if($("input:checkbox[name='preBox']:checked").size()){//选中
		   $("#perDiv").show();
		}else{
			$("#perDiv").hide();
		}
		if($("input:checkbox[name='postBox']:checked").size()){//选中
		   $("#postDiv").show();
		}else{
			$("#postDiv").hide();
		}
		for(var pre=0;pre<$("#perTrNum").val();pre++){
			var num=pre+1;
			var nights=$("#nights"+num).val();
			$("#hrefP"+num).attr("onclick","delInfo('"+num+"','per','"+nights+"')");
		}
		for(var post=0;post<$("#postTrNumt").val();post++){
			var num=post+1;
			var nights=$("#nightsPo"+num).val();
			$("#hrefPo"+num).attr("onclick","delInfo('"+num+"','post','"+nights+"')");
		}
		//佣金人数
		var paxNumber=Number($("#bedNum").text())+Number($("#notBedNum").text());
		var autNumber=$("#adultNum").text();
		$("#compaxdiv").text(autNumber);//佣金人数
		$("#childcompaxdiv").text(paxNumber);//小孩佣金人数
		//自费小费人数显示
		var peopleNum=Number(paxNumber)+Number(autNumber);
		if($("#tipTotal").val()!=0){
			$("#tipPaxs").text(peopleNum);
		}
		if($("#selfTotal").val()!=0){
			$("#selfPaxs").text(peopleNum);
		}
		//离团时间
		var departureTime=$("#dated").text();
		var year=departureTime.substring(0,4);
		var month=departureTime.substring(5,7);
		var day=departureTime.substring(8,10);
		var days=Number(day)+Number(${groupLine.remark})-1;
		var offDate=0;
		if(month==02){
			if(days>29){
				var d=Number(days)-29;
				var m=Number(month)+1;
				if(d<10){
					d=0+''+d;
				}
				if(m<10){
					m=0+''+m;
				}
				offDate=year+'-'+m+'-'+d;
			}else{
				offDate=year+'-'+month+'-'+days;
			}
		}else if(month==01||month==03||month==05||month==07||month==08||month==10||month==12){
			if(days>31){
				var d=Number(days)-31;
				var m=Number(month)+1;
				if(d<10){
					d=0+''+d;
				}
				if(m<10){
					m=0+''+m;
				}
				offDate=year+'-'+m+'-'+d;
			}else{
				offDate=year+'-'+month+'-'+days;
			}
		}else{
			if(days>30){
				var d=Number(days)-30;
				var m=Number(month)+1;
				if(d<10){
					d=0+''+d;
				}
				if(m<10){
					m=0+''+m;
				}
				offDate=year+'-'+m+'-'+d;
			}else{
				offDate=year+'-'+month+'-'+days;
			}
		}
		$("#offTime").text(offDate);
		App.wizard();
    });
    function getCurrentTime() { $(".ui-datepicker-current").click(); }
    //获取两位小数点
	function changeTwoDecimal(x){
			var f_x = parseFloat(x);
			if (isNaN(f_x))
			{
				//alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x*100)/100;
		
			return f_x;
		}
    var dateArray = "${groupLine.departureDate}";
    var strs= new Array(); //定义一数组 
	availableDates=dateArray.split(","); //字符分割 
	function available(date) {
		var dmy = $.datepicker.formatDate('yy-mm-dd',date);
		if ($.inArray(dmy, availableDates) != -1) {
			return [true, "","Available"];
		} else {
			return [false,"","unAvailable"];
		}
	}
    function subOk(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_formRemark').slideDown(400);
    }
    function sub(){
    	var itemJson="Adult:1:"+$("#adult").text()+":"+$("#adultNum").text()+",Child with Bed:2:"+$("#bed").text()+":"+$("#bedNum").text()
        			+",Child without Bed:3:"+$("#notBed").text()+":"+$("#notBedNum").text()+",Infant:4:"+$("#baby").text()+":"+$("#babyNum").text()
        			+",Service Fee:5:"+$("#tPrice").text()+":"+$("#tipPaxs").text()+",Compulsory Programs:6:"+$("#sPrice").text()+":"+$("#selfPaxs").text()
        			+",Single Supplement:7:"+$("#sup").text()+":1"+",Pre/Post-Stay:8:"+$("#pp").text()+":1"
        			+",Extra Transfer:9:"+$("#ps").text()+":1"+",Adult Commission:10:"+$("#compax").text()+":"+$("#compaxdiv").text()
        			+",Child Commission:11:"+$("#childcompax").text()+":"+$("#childcompaxdiv").text();
        $("#feeItems").val(itemJson);
    	
    	var recordRemark=$("#recordRemark").val();
    	$("#recodsRemark").val(recordRemark);
    	if($.trim(recordRemark)!=''){
    		$.ajax({
                cache: true,
                type: "POST",
                url:"tourOrderUpdate.jhtml",
                data:$('#ww').serialize(),// 你的formid
                async: false,
                error: function(request) {
                   alert("Booking NO: "+$("#orderNumber").val()+" Modify Failure ");
                },
                success: function(data) {
                   alert("Booking NO: "+$("#orderNumber").val()+" Modification ");
                   $('.popup_from_mask').fadeOut(300);
				   $('.popup_formRemark').slideUp(400);
                   window.location.href="${base}/admin/peerUser/list.jhtml";
                }
            });
    	}else{
    		alert("Order modify record connot be null.");
    	}
    }
	   
    /* 将上一个客人的信息复制到本客人   */
    function theSameAsPrevious(n){
    	var number = n;
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].flightCode']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].flightCode']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].flightNumber']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].flightNumber']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].arriveDate']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].arriveDate']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].arriveTime']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].arriveTime']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].flightCode']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].flightCode']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].flightNumber']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].flightNumber']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].arriveDate']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].arriveDate']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].arriveTime']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].arriveTime']").val());
    }
    function changeDiv(num){
    	for(var c=1;c<7;c++){
    		if(c==num){
    			$("#stepdiv"+num).attr("class","active");
    			$("#step"+num).show();
    		}else{
    			if(c<num){
    				$("#stepdiv"+c).attr("class","complete");
	    			$("#step"+c).hide();
    			}else{
	    			$("#stepdiv"+c).attr("class","");
	    			$("#step"+c).hide();
    			}
    		}
    	}
    }
    /**页面费用计算**/
	function price(){
	     //团款
	     var tourFee=$("#totalSP").val();
	    //其他费用
		var oprice=changeTwoDecimal(Number($("#tipTotal").val())+Number($("#selfTotal").val())+Number($("#hotelTotal").val())+Number($("#ticketTotal").val())+Number($("#supTotal").val()));
		$("#otherPrice").text(oprice);/*其他总费用*/
		var totalPrice=changeTwoDecimal(Number(tourFee)+Number(oprice));//Final Amount
		$("#totalPrice").text(totalPrice);
		var com=$("#totalComm").text();
		//页面计算公式显示数据
		$("#sumFee").text(tourFee);
		$("#comFee").text(com);
		$("#otherFee").text(oprice);
		var disFee=changeTwoDecimal(Number(tourFee)-Number($("#totalComm").text())+Number(oprice));
		$("#disFee").text(disFee);
	}
</script>
<script type="text/javascript" src="[@spring.url '/resources/js/behaviour/general.js'/]"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>