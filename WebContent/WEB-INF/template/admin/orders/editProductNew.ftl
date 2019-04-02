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
	[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
    <div class="container-fluid" id="pcont">
        <div class="page-head">
           <h2>
				Edit Booking
			</h2>
            <div class="new">
            	<button id="selectCustomerButton" type="button" data-modal="customerSelectForm" class="btn btn-success btn-flat md-trigger">Customer Info</button>
            	<a class="btn pull-right" href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
            </div>
			<ol class="breadcrumb">
				<li>
					<a style="cursor:pointer;" href="../../">
						Home
					</a>
				</li>
				<li>
					<a style="cursor:pointer;" href="list.jhtml">
						Booking - ${ordersTotal.orderNumber}
					</a>
				</li>
        </div>
        <div class="cl-mcont">		
    <div class="row wizard-row">
      <div class="col-md-12 fuelux">
      <div class="block-flat">
            <div class="header">
          		 <h4 class="filter-bar">
            	<div class="col-md-3 col-sm-4">Code:&nbsp; ${groupLine.tourCode}</div>
            	<div class="col-md-8 col-sm-4">Name:&nbsp; ${groupLine.tourName}</div>
            	</h4>
          </div>
	   </div>
        <div class="block-wizard">
          <div id="wizard1" class="wizard wizard-ux" style="font-weight:bold;">
            <ul class="steps">
             <li data-target="#step1" class="active"><i class="fa fa-group"></i>&nbsp;Tour Info<span class="chevron"></span></li>
              <li data-target="#step2"><i class="fa fa-plane"></i>&nbsp;Flight Info<span class="chevron"></span></li>
              <li data-target="#step3"><i class="fa fa-money"></i>&nbsp;Fee Info<span class="chevron"></span></li>
            </ul>
          </div>
          <div class="step-content">
            <form id="form" class="form-horizontal group-border-dashed" action="tourOrderUpdateNew.jhtml" method="post" data-parsley-namespace="data-parsley-" data-parsley-validate novalidate> 
				<div class="step-pane active" id="step1">
					<input type="hidden" name="ordersTotalId" value="${productVO.ordersTotalId}"/>
	                <div style="width:auto;height:auto;margin:20px 0 0 0;border:0px none solid;padding:8px;">
						<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
							<tbody>
								[#if groupLine??]
								<tr id="tourInformationTr">
									<td width="13%">
										Tour Type:
									</td>
									<td width="37%"> 
										<select id="tourTypeSelect" name="order.tourTypeId" onchange="tourTypeSelectChange(this);" class="select2">
										[#list tourTypeList as tourType]
											<option value="${tourType.tourTypeId}" type="${tourType.type}" [#if tourType.tourTypeId == productVO.order.tourTypeId]selected="selected" original="true"[#else]original="false"[/#if]>${tourType.typeName}</option>
										[/#list]
										</select>
										<font size="3px" color="red">
											*
										</font>
									</td>
									<td width="13%">   
										Product
									</td>
									<td width="37%">
										<select id="groupLineSelect" name="tourInfoForOrder.groupLineId" class="select2">
										[#list groupLineList as groupLine]
											<option value="${groupLine.id}" [#if groupLine.id == productVO.tourInfoForOrder.groupLineId]selected="selected"[/#if]>${groupLine.tourCode}</option>
										[/#list]
										</select>
									</td>
								</tr>
								[#if productVO.order.brand=='inbound']
								<tr>
									<td width="13%">
										 Type:
									</td>
									<td width="37%">
										<select name="tourInfoForOrder.tourType" class="select2" id='tempId'>
											<option value="">Select Source</option>
											<option value="家庭团">家庭团</option>
											<option value="散拼团">散拼团</option>
											<option value="学生团">学生团</option>
											<option value="商务团">商务团</option>
											<option value="会展团">会展团</option>
											<option value="其他">其他</option>
										</select>
									
									</td>
									<td width="13%">
									</td>
									<td width="37%">
									</td>
								</tr>
								[/#if]
									[#if (tourType.type == 0) || (tourType.type == 4)]
									<tr class="groupLineEdit">
										<td width="13%">
											<span>
												Product Code:
											</span>
										</td>
										<td width="37%">
											<input id="tourCodeInput" class="form-control input-group1" name="groupLine.tourCode" value="${groupLine.tourCode}" type="text">
										</td>
										<td width="13%">
											<span>
												Product Name: 
											</span>
										</td>
										<td width="37%">
											<input id="tourNameInput" class="form-control input-group1" name="groupLine.tourName" value="${groupLine.tourName}" type="text">
										</td>
									</tr>
									<tr class="groupLineEdit">
										<td width="13%">
											<span>
												Product Description:
											</span>
										</td>
										<td width="37%">
											<input id="tripDescInput" class="form-control input-group1" name="groupLine.tripDesc" value="${groupLine.tripDesc}" type="text">
										</td>
										<td width="13%">
										</td>
										<td width="37%">
											<input name="groupLine.departureDate" class="form-control input-group1 groupLineDepartureDate" type="hidden" value="${groupLine.departureDate}" />
											<input name="groupLine.id" type="hidden" value="${groupLine.id}"/>
										</td>
								    </tr>
								    [/#if]
								[/#if]
								<tr>
									<td width="13%">
										Departure Date:
									</td>
									<td width="37%">
										<input id="departureDateInput" type="text" name="tourInfoForOrder.departureDate" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] class="form-control input-group1" placeholder="yyyy-mm-dd"/>
										<font size="2px" color="red">
											&nbsp;The departure dates are same as 
											<br/>&nbsp;the website listed.
										</font>
									</td>
									[#if groupLine??]
									<td width="13%">
									</td>
									<td id="editItineraryTd" width="37%">
										<button class="btn" type="button" onclick="window.open('../groupline/setGroupRoute.jhtml?groupLineId=${groupLine.id}');">&nbsp;&nbsp; Edit Itinerary &nbsp;&nbsp;</button>
										<button class="btn" type="button" onclick="window.open('../groupline/setHotel.jhtml?groupLineId=${groupLine.id}');">&nbsp;&nbsp; Edit Hotel &nbsp;&nbsp;</button>
									</td>
									[#else]
									<td width="13%">
										Tour Type:
									</td>
									<td width="37%">
										<select name="order.tourTypeId" class="select2">
										[#list tourTypeList as tourType]
										<option value="${tourType.tourTypeId}" [#if productVO.order.tourTypeId == tourType.tourTypeId]selected="selected"[/#if]>${tourType.typeName}</option>
										[/#list]
										</select>	
									</td>
									[/#if]
								</tr>
								<tr>
									<td width="13%">
										Arrive Date:
									</td>
									<td width="37%"> 
										<input type="hidden" name="tourInfoForOrder.id" value="${productVO.tourInfoForOrder.id}"/>
										[#if groupLine.tourNameEn=="OtherBooking"]
												<input id="scheduleOfArriveTimeInput" type="text" name="tourInfoForOrder.scheduleOfArriveTime" class="form-control input-group1" value="[#if (productVO.tourInfoForOrder.scheduleOfArriveTime)??]${productVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]"  placeholder="yyyy-mm-dd"/>
										[#else]
											<input id="scheduleOfArriveTimeInput" type="text" name="tourInfoForOrder.scheduleOfArriveTime" class="form-control input-group1" value="[#if (productVO.tourInfoForOrder.scheduleOfArriveTime)??]${productVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]" required placeholder="yyyy-mm-dd"/>
											<font size="2px" color="red">
										    	&nbsp;*
											</font>
										[/#if]
									</td>
									<td width="13%">
										Requirement:
									</td>
									<td width="37%">
										<textarea name="tourInfoForOrder.specialRequirements" cols="30" rows="4" class="form-control input-group1">${productVO.tourInfoForOrder.specialRequirements}</textarea>
									</td>

								</tr>
								<tr>
									<td width="13%">
										Remark:
									</td>
									<td width="37%">
										<textarea name="tourInfoForOrder.tourInfo" cols="30" rows="8" class="form-control">${productVO.tourInfoForOrder.tourInfo}</textarea>
									</td>
									<td width="13%">
										Tour Voucher Remarks:
									</td>
									<td width="37%">
										<textarea name="tourInfoForOrder.voucherRemarks" cols="30" rows="8" class="form-control">${productVO.tourInfoForOrder.voucherRemarks}</textarea>
									</td>
								</tr>
								<tr>
									<td width="13%">
										Invoice Remarks:
									</td>
									<td width="37%">
										<textarea name="tourInfoForOrder.InvoiceRemarks" cols="30" rows="8" class="form-control">${productVO.tourInfoForOrder.invoiceRemarks}</textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="form-group " align="right">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default">Cancel</button>
							<button data-wizard="#wizard1" class="btn btn-primary wizard-next">Next Step <i class="fa fa-caret-right"></i></button>
						</div>
					</div>
			    </div>
				<div class="step-pane" id="step2">
					[#list productVO.customerFlights as cor]
						<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">No.${cor_index+1}</div>
						<div class="customerFlight_div">
							<input type="hidden" name="customerFlights[${cor_index}].id" value="${cor.id}"/>
							<table style="border: 0px none">
								<tbody>
									<tr>
										<td width="13%" style="font-weight:bold;">
											<span>
												Select Customer:
											</span>
										</td>
										<td width="37%">
											<select name="customerFlights[${cor_index}].customerId" beforeId="0" onchange="changeOption(this);" class="select2 customerSelect">
												<option value="0">Select Customer</option>
												[#list customerList as customer]
												<option value="${customer.customerId}" [#if customer.customerId == cor.customerId]selected="selected"[/#if]>${customer.lastName}/${customer.firstName} ${customer.middleName}</option>
												[/#list]
											</select>
										</td>
										<td>
											[#if cor_index != 0]
											<div class="copyPrevious" style="text-align:right"><button class="btn" type="button" onclick="theSameAsPrevious(this);">&nbsp;&nbsp;The Same As Previous Customer &nbsp;&nbsp;</button></div>
											[/#if]
										</td>
										<td>
										</td>
									</tr>
									<tr  style="font-weight:bold;">
										<td colspan="4">
													Arrival Flight:
										</td>
									</tr>
									<tr>
										<input type="hidden" name="customerFlights[${cor_index}].customerFlightList[0].id" value="${cor.customerFlightList[0].id}">
										<td width="13%">
											<span>
												Airline:
											</span>
										</td>
										<td width="37%">
											<input class="form-control input-group1" name="customerFlights[${cor_index}].customerFlightList[0].flightCode" value="${cor.customerFlightList[0].flightCode}" type="text">
										</td>
										<td width="13%">
											<span>
												Flight No.:
											</span>
										</td>
										<td width="37%">
											<input class="form-control input-group1" name="customerFlights[${cor_index}].customerFlightList[0].flightNumber" value="${cor.customerFlightList[0].flightNumber}" type="text">
										</td>
									</tr>
									<tr>
										<td>
											<span>
												Arrival Date:
											</span>
										</td>
										<td>
											<input type="text" class="form-control input-group1 JDATE" name="customerFlights[${cor_index}].customerFlightList[0].arriveDate" value="[#if (cor.customerFlightList[0].arriveDate)??]${cor.customerFlightList[0].arriveDate?string('yyyy-MM-dd')}[/#if]" placeholder="yyyy-MM-dd">
										</td>
										<td>
											<span>
												Arrival Time:
											</span>
										</td>
										<td>
											<input class="form-control input-group1" size="16" type="text" name="customerFlights[${cor_index}].customerFlightList[0].arriveTime" value="${cor.customerFlightList[0].arriveTime}"/>
										</td>
									</tr>
									<tr>
										<td>
											<span>
												Pick-Up:
											</span>
										</td>
										<td>
											<label id="ifPickUp_${cor_index}_1" class="radio-inline">
												<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
													<input class="icheck" type="radio" name="customerFlights[${cor_index}].customerFlightList[0].ifPickUp" value="1"
														style="position: absolute; opacity: 0;">
														<ins class="iCheck-helper"
															style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
														</ins>
												</div>
												Yes &nbsp;&nbsp;
											</label>
											<label id="ifPickUp_${cor_index}_2" class="radio-inline">
												<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
													<input class="icheck" type="radio" name="customerFlights[${cor_index}].customerFlightList[0].ifPickUp" value="2" checked=""
														style="position: absolute; opacity: 0;">
														<ins class="iCheck-helper"
															style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
														</ins>
												</div>
												No
											</label>
										</td>
										<td>
											<span>
												Deviation:
											</span>
										</td>
										<td>
											<input class="form-control input-group1" name="customerFlights[${cor_index}].customerFlightList[0].remark" type="text" value="${cor.customerFlightList[0].remark}">
											<!-- 出入境 ，入境 -->
											<input class="hasDatepicker" name="customerFlights[${cor_index}].customerFlightList[0].outOrEnter" value="1" type="hidden">
										</td>
									</tr>
									<tr style="font-weight:bold;">
										<td colspan="4">
											<br>
												<div>
													Departure Flight:
												</div>
										</td>
									</tr>
									<tr>
									    <input type="hidden" name="customerFlights[${cor_index}].customerFlightList[1].id" value="${cor.customerFlightList[1].id}">
										<td colspan="">
											<span>
												Ariline:
											</span>
										</td>
										<td>
											<input class="form-control input-group1" name="customerFlights[${cor_index}].customerFlightList[1].flightCode" value="${cor.customerFlightList[1].flightCode}" type="text">
										</td>
										<td>
											<span>
												Flight No.:
											</span>
										</td>
										<td>
											<input class="form-control input-group1" name="customerFlights[${cor_index}].customerFlightList[1].flightNumber" value="${cor.customerFlightList[1].flightNumber}" type="text">
										</td>
									</tr>
									<tr>
										<td>
											<span>
												Departure Date:
											</span>
										</td>
										<td>
											<input type="text" class="form-control input-group1 JDATE" name="customerFlights[${cor_index}].customerFlightList[1].arriveDate" value="[#if (cor.customerFlightList[1].arriveDate)??]${cor.customerFlightList[1].arriveDate?string('yyyy-MM-dd')}[/#if]">
										</td>
										<td>
											<span>
												Departure Time:
											</span>
										</td>
										<td>
											<input class="form-control input-group1" size="16" type="text" name="customerFlights[${cor_index}].customerFlightList[1].arriveTime" value="${cor.customerFlightList[1].arriveTime}"/>
										</td>
									</tr>
									<tr>
										<td>
											<span>
												Drop-off:
											</span>
										</td>
										<td>
											<label id="ifSendUp_${cor_index}_1" class="radio-inline">
												<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
													<input class="icheck" type="radio" name="customerFlights[${cor_index}].customerFlightList[1].ifSendUp" value="1"
														style="position: absolute; opacity: 0;">
														<ins class="iCheck-helper"
															style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
														</ins>
												</div>
												Yes &nbsp;&nbsp;
											</label>
											<label id="ifSendUp_${cor_index}_2" class="radio-inline">
												<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
													<input class="icheck" type="radio" name="customerFlights[${cor_index}].customerFlightList[1].ifSendUp" value="2" checked=""
														style="position: absolute; opacity: 0;">
														<ins class="iCheck-helper"
															style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
														</ins>
												</div>
												No
											</label>
										</td>
										<td>
											<span>
												Deviation:
											</span>
										</td>
										<td>
											<input class="form-control input-group1" size="16" type="text" name="customerFlights[${cor_index}].customerFlightList[1].remark" value="${cor.customerFlightList[1].remark}"/>
											<!-- 出入境 ，入境 -->
											<input class="hasDatepicker" name="customerFlights[${cor_index}].customerFlightList[1].outOrEnter" value="2" type="hidden">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					[/#list]
					<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Additional Information</div>
					<div>
						<table style="border: 0px none">
							<tbody>
								<tr>
								<td width="13%">
										<span>
											Domestic Tickets:
										</span>
									</td>
									<td width="37%" colspan="3">
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="order.planticket" value="1" [#if "${productVO.order.planticket == 1}"] checked="checked" [/#if]
													style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Booked by Agent &nbsp;&nbsp;
										</label>
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="order.planticket" value="2" [#if "${productVO.order.planticket == 2}"] checked="checked" [/#if]
													style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Booked by OP &nbsp;&nbsp;
										</label>
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="order.planticket" value="0" [#if "${productVO.order.planticket == 0}"] checked="checked" [/#if]
													style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Booked by Agent or OP
										</label>
									</td>
								</tr>
								<tr>
									<td width="13%">
										<span>
											For flights booked by agent, please enter the info.
										</span>
									</td>
									<td width="37%" colspan="3">
										<textarea name="order.otherInfo" cols="30" rows="4" class="form-control input-group1">${productVO.order.otherInfo}</textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="form-group" align="right">
						<div class="col-sm-12">
							<button data-wizard="#wizard1" class="btn btn-default wizard-previous"><i class="fa fa-caret-left"></i> Previous</button>
							<button data-wizard="#wizard1" id="customerFlightStep" class="btn btn-primary wizard-next">Next Step <i class="fa fa-caret-right"></i></button>
						</div>
					</div>	
			    </div>		
                <div class="step-pane" id="step3">
					<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
						<tbody id="feeTbody">
							<tr class="commonTourFee">
								<td width="10%">
									Adult Tour Price:
								</td>
								<td width="25%">
									<input class="form-control input-group1" required="" id="adultPriceId" name="adultItem.itemFee" value="${productVO.adultItem.itemFee}" onkeyup="showRegularTourTotalFee();" maxlength="100" size="30" value="0" type="text">
									<font size="2px" color="red">
										    &nbsp;*
									</font>
								</td>
								<td width="10%">
									Qty:
								</td>
								<td width="20%">
									<input class="form-control input-group1" name="adultItem.itemFeeNum" value="${productVO.adultItem.itemFeeNum}" onkeyup="showRegularTourTotalFee();"
										maxlength="100" size="30" type="text" placeholder="Number">
										<div class="none">
										</div>
								</td>
								<td width="10%">
									Remark:
								</td>
								<td width="30%">
									<input class="form-control input-group1" name="adultItem.remark" type="text" value="${productVO.adultItem.remark}">
								</td>
								<input type="hidden" name="adultItem.id" value="${productVO.adultItem.id}"/>
								<input type="hidden" name="adultItem.type" value="1">
								<input type="hidden" name="adultItem.num" value="101">
							</tr>
							<tr class="commonTourFee">
								<td>
									Child Tour Price:
								</td>
								<td> 
									<input class="form-control input-group1" name="childrenItem.itemFee" value="${productVO.childrenItem.itemFee}" onkeyup="showRegularTourTotalFee();"
										maxlength="100" size="30" value="0" type="text" placeholder="Child Tour Price">
								</td>
								<td>
									Qty:
								</td>
								<td>
									<input class="form-control input-group1" name="childrenItem.itemFeeNum" value="${productVO.childrenItem.itemFeeNum}" onkeyup="showRegularTourTotalFee();"
										maxlength="100" size="30" type="text">
										<div class="none">
										</div>
								</td>
								<td>
									Remark:
								</td>
								<td>
									<input class="form-control input-group1" name="childrenItem.remark" type="text" value="${productVO.childrenItem.remark}">
								</td>
								<input type="hidden" name="childrenItem.id" value="${productVO.childrenItem.id}"/>
								<input type="hidden" name="childrenItem.type" value="1">
								<input type="hidden" name="childrenItem.num" value="102">
							</tr>
							<tr class="totalCommonTourFee">
								<td>
									<strong>
										<b>
											Total Tour Price:
										</b>
									</strong>
								</td>
								<td>
									<input class="form-control input-group1" name="receivableInfoOfOrder.totalCommonTourFee" value="${productVO.receivableInfoOfOrder.totalCommonTourFee}" style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Total Tour Price">
								</td>
								<td colspan="4">
			                                &nbsp;
								</td>
								<input type="hidden" name="receivableInfoOfOrder.id" value="${productVO.receivableInfoOfOrder.id}"/>
							</tr>
							<tr class="totalOtherFee">
								<td>
									<strong>
										<b>
											Total Charge:
										</b>
									</strong>
								</td>
								<td>
									<input class="form-control input-group1" name="receivableInfoOfOrder.totalFeeOfOthers" value="${productVO.receivableInfoOfOrder.totalFeeOfOthers}" style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Other Charge">&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(1);"></a>
								</td>
								<td colspan="4">
			                                &nbsp;
								</td>
							</tr>
							[#list productVO.otherFeeList as otherFee]
							<tr class="1">
								<td>
									Other Charge：
								</td>
								<td>
									<input class="form-control input-group1" name="otherFeeList[feeIndex].itemFee" onkeyup="showFeeTotal(1)" value="${otherFee.itemFee}" type="text" placeholder="其他费用">
								</td>
								<td>
										Qty:
								</td>
								<td>
									<input class="form-control input-group1" name="otherFeeList[feeIndex].itemFeeNum" value="${otherFee.itemFeeNum}" onkeyup="showFeeTotal(1);"
										maxlength="2" size="30" value="1" type="text">
								</td>
								<td>
									Remark:
								</td>
								<td>
									<input name="otherFeeList[feeIndex].remark" maxlength="100" size="30" value="${otherFee.remark}" class="remarkCss form-control input-group1" type="text">
									&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,1,'${otherFee.id}');">
								</td>
								<td colspan="2">
			                                &nbsp;
								</td>
								<input type="hidden" name="otherFeeList[feeIndex].id" value="${otherFee.id}"/>
								<input type="hidden" class="num" name="otherFeeList[feeIndex].num">
								<input type="hidden" name="otherFeeList[feeIndex].type" value="2">
							</tr>
							[/#list]
							<tr class="totalDiscountFee">
								<td>
									<strong>
										<b>
											Total Discount:
										</b>
									</strong>
								</td>
								<td>
									<input class="form-control input-group1"  style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Other Discount">&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(2);"></a>
								</td>
								<td colspan="4">
			                                &nbsp;
								</td>
							</tr>
							[#list productVO.discountList as discount]
							<tr class="2">
								<td>
									Other Discount：
								</td>
								<td>
									<input class="form-control input-group1" name="discountList[feeIndex].itemFee" value="${discount.itemFee}" onkeyup="showFeeTotal(2);" value="0" type="text" placeholder="其他特殊折扣">
								</td>
								<td>
									Qty:
								</td>
								<td>
									<input class="form-control input-group1" name="discountList[feeIndex].itemFeeNum" value="${discount.itemFeeNum}" onkeyup="showFeeTotal(2);"
										maxlength="2" size="30" value="1" type="text">
								</td>
								<td>
									Remark:
								</td>
								<td>
									<input name="discountList[feeIndex].remark" value="${discount.remark}" class="remarkCss form-control input-group1" type="text">
								    &nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,2,'${discount.id}');"></a>
								</td>
								<td colspan="2">
			                                &nbsp;
								</td>
								<input type="hidden" name="discountList[feeIndex].id" value="${discount.id}"/>
								<input class="num" type="hidden" name="discountList[feeIndex].num">
								<input type="hidden" name="discountList[feeIndex].type" value="3">
							</tr>
							[/#list]
							[#if productVO.order.peerUserId!=""]
							<tr class="peerUserFee">
								<td >
			                      <strong>
										<b>
											Commission：
										</b>
									</strong>
								</td>
								<td>
									<input id="peerUserFee" class="form-control input-group1" name="order.peerUserFee" onchange="showSumFee()" value="${productVO.order.peerUserFee}" type="text" placeholder="">
								</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
								<td >&nbsp;</td>
							</tr>
							[#list orderFeeItemsList as orderFeeItems]
								[#if orderFeeItems.num==10]
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<tr class="3">
										<td>Adult Commission:</td>
										<td><input type="text" id="adultComPrice" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" onkeyup="showFeeTotal(3);" class="form-control input-group1"></td>
										<td>Qty: </td>
										<td><input type="text" id="adultComPriceNum" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" onkeyup="showFeeTotal(3);" class="form-control input-group1"></td>
										<td >&nbsp;</td>
										<td >&nbsp;</td>
									</tr>
								[/#if]
								[#if orderFeeItems.num==11]
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<tr class="3">
										<td>Child Commission:</td>
										<td><input type="text" id="childComPrice" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" onkeyup="showFeeTotal(3);" class="form-control input-group1"></td>
										<td>Qty: </td>
										<td><input type="text" id="childComPriceNum" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" onkeyup="showFeeTotal(3);" class="form-control input-group1"></td>
										<td >&nbsp;</td>
										<td >&nbsp;</td>
									</tr>
							    [/#if]
						    [/#list]
							[/#if]
							<tr class="sumFee">
								<td>
									<strong>
										<b>
											Total Amount：
										</b>
									</strong>
								</td>
								<td>
									<input class="form-control input-group1" name="receivableInfoOfOrder.sumFee" value="${productVO.receivableInfoOfOrder.sumFee}" style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Total Amount">
								</td>
								<td>
									<strong>
										<b>
											Ex.Rate:
										</b>
									</strong>
								</td>
								<td>
									<input id="rateInput" class="form-control input-group1" name="order.rate"
										value="${productVO.order.rate}" type="text" placeholder="">
								</td>
								<td>&nbsp;</td>
								<td>[#if orderFeeItemsList.size()==0]&nbsp;[#else]<a href="javascript:;" onClick="show();">B2B Invoice Fee Information</a>[/#if]</td>
							</tr>
						</tbody>
					</table>
					[#if orderFeeItemsList.size()!=0]
					<table style="word-break:break-all;white-space:nowrap;border: 0px none;display:none;" width="100%" id="b2bFeeTable">
						<tr style="background-color:#52AEFF;color:#fff;height:30px;"><th colspan="6">B2B Invoice Fee Information(只有B2B订单可见，如果只审核，请勿更改里面任何信息，请保持B2B费用的同步，对其他费用没有任何影响)</th></tr>
						<tbody >
						  [#list orderFeeItemsList as orderFeeItems]
						  	[#if orderFeeItems.num==1]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Adult Price:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==2]	
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Children with Bed Price:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==3]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Children without Bed Price:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==4]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Infant Price:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==5]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Service Fee:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==6]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Compulsory Programs:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==7]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Single Supplement:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==8]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Pre/Post-Stay:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#elseif orderFeeItems.num==9]
							  	<tr>
									<input type="hidden" name="orderFeeItems[${orderFeeItems.num-1}].id" value="${orderFeeItems.id}">
									<td>Extra Transfer:</td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].price" value="${orderFeeItems.price}" class="form-control input-group1"></td>
									<td>Qty: </td>
									<td><input type="text" name="orderFeeItems[${orderFeeItems.num-1}].pax" value="${orderFeeItems.pax}" class="form-control input-group1"></td>
									<td >&nbsp;</td>
									<td >&nbsp;</td>
								</tr>
							[#else]
							[/#if]
						  [/#list]
						</tbody>
					</table>
					[/#if]
					<table style="word-break:break-all;white-space:nowrap;border: 0px none;margin-top:50px;" width="100%">
						<tr style="background-color:#52AEFF;color:#fff;height:30px;">
							<th>Modify Time</th>
							<th>Modify Remark</th>
						</tr>
						<tbody id="feeTbody">
						[#list orderRemark as remark]
							<tr>
								<td>
								 [#if remark.modifyDate??]
									${remark.modifyDate?string("yyyy-MM-dd")}
						         [/#if]
						        </td>
								<td>${remark.updateRemark}</td>
							</tr>
						[/#list]
						</tbody>
					</table>
	                <div class="form-group" align="right">
						<div class="col-sm-12">
							<button data-wizard="#wizard1" class="btn btn-default wizard-previous"><i class="fa fa-caret-left"></i> Previous</button>
							<button type="button" id="formSubmit" data-wizard="#wizard1" class="btn btn-success wizard-next"><i class="fa fa-check"></i> Save </button>
							<button type="button" id="orderRemark" data-modal="modifyRemarkInput" class="label label-default md-trigger" style="display:none"/> 
						</div>
	                </div>	
                </div>
                <input id="peerUserId" type="hidden" value="${productVO.order.peerUserId}"/>
                <input id="updateRemark" type="hidden" name="orderRemark.updateRemark"/>
                <input id="newState" type="hidden" name="newState"/>
                <input id="warnState" type="hidden" name="warnState"/>
                <input id="peerUserRemark" type="hidden" name="orderAgencyRemark.updateRemark"/>
                <input id="reviewState" type="hidden" name="order.reviewState"/>
            </form>
          </div>
        </div>
      </div>
    </div>
    </div>
    </div>
</div>

<!--放在此处为了触发该事件时，将其他的页面覆盖-->
<div class="md-modal colored-header custom-width md-effect-9" id="customerSelectForm" style="width:80%;">
			    <div class="md-content" >
			      <div class="modal-header">
			      	<h3>Customer Info</h3>
			        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
			      </div>
			      
			      <div class="modal-body" width="100%">
				      	
						<form id="selectCustomerForm" method="post">
							 <table  class="table table-bordered dataTable no-footer" id="datatable" style="margin-top:20px;">
					              <thead>
					                  <tr>
					                       <th style="width:12%;"><strong>Last/First Middle Name</th></strong></th>
					                       <th width="10%">Gender</th>
					                       <th width="12%">Birthday</th>
					                       <th width="10%">Type</th>
					                       <th width="10%">Nationality</th>
					                       <th width="12%">residency</th>
					                       <th width="12%">PassportNo</th>
					                       <th width="12%">RoomType</th>
					                    </tr>
					               </thead>
					               				<tbody id="customerList" class="no-border-xy">
													[#list customerOrderRelList as customerOrderRel]
													<tr>
														<td>${customerOrderRel.customer.lastName }/${customerOrderRel.customer.firstName } ${customerOrderRel.customer.middleName } </td>
														<td>[#if customerOrderRel.customer.sex == 1]F[#elseif customerOrderRel.customer.sex == 2]M [#else][/#if] </td>
														<td>[#if (customerOrderRel.customer.dateOfBirth)??]${customerOrderRel.customer.dateOfBirth?string("yyyy-MM-dd")}[/#if]</td>
														<td>[#if customerOrderRel.customer.type == 1]Infant [#elseif customerOrderRel.customer.type ==2 ]Child without Bed[#elseif customerOrderRel.customer.type ==3 ]Child with Bed[#elseif customerOrderRel.customer.type ==4 ]Adult[#else][/#if]</td>
														<td>${customerOrderRel.customer.nationalityOfPassport}</td>
														<td>${customerOrderRel.customer.residency}</td>
														<td>${customerOrderRel.customer.passportNo}</td>
														<td>${customerOrderRel.guestRoomType}</td>
													</tr>
													[/#list]
												</tbody>
					          </table>
				        </form>
			      </div>
      <div class="modal-footer">
		   <!--<button class="btn btn-default btn-flat md-close" data-dismiss="modal" type="button">Cancel</button>-->
		   <button class="btn btn-primary btn-flat md-close" data-dismiss="modal" type="button" id="selectCustomerForAddButton">Ok</button>
	  </div>
    </div>
</div>
<div class="md-modal md-effect-1" id="modifyRemarkInput">
    <div class="md-content">
      <div class="modal-header">
      	<span>Order Modify Record</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="updateRecord">
      <div class="modal-body">
        <div class="text-center">
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td width="40%">
							<span>
								Modify Record:
							</span>
						</td>
						<td width="60%">
							<textarea id="remark" class="form-control input-group1"></textarea>
						</td>
					</tr>
					
					<tr>
						<td width="40%">
							<span>
								Notice OP:
							</span>
						</td>
						<td width="60%"  class="text-left">
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="newState" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Yes &nbsp;&nbsp;
							</label>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="newState" value="0" checked=""
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								No
							</label>
						</td>
					</tr>
					<tr>
						<td width="40%">
							<span>
								Notice Accountant:
							</span>
						</td>
						<td width="60%"  class="text-left">
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="warnState" value="2"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Yes &nbsp;&nbsp;
							</label>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="warnState" value="0" checked=""
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								No
							</label>
						</td>
					</tr>
					[#if productVO.order.peerUserId!=null]
					<tr>
						<td width="40%">
							<span>
								Agency Remark:
							</span>
						</td>
						<td width="60%">
							<textarea id="peerUserRemarks" class="form-control input-group1"></textarea>
						</td>
					</tr>
					<tr>
						<td width="40%">
							<span>
								Approval Status:
							</span>
						</td>
						<td width="60%"  class="text-left">
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="reviewStateId" value="2"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Yes &nbsp;&nbsp;
							</label>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="reviewStateId" value="3" checked=""
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								No
							</label>
						</td>
					</tr>
					[/#if]
				</tbody>
			</table>
        </div>
      </div>
      <div class="modal-footer">
		<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		<button type="reset" class="btn btn-default">Reset</button>
		<button type="button" onclick="updateOrder()" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Confirm</button>
	  </div>
	  </form>
    </div>
</div>
<div class="md-overlay">
</div>
<table id="feeTemplate" style="display:none">
	<tr class="1">
		<td>
			Other Charge:
		</td>
		<td>
			<input class="form-control input-group1" name="otherFeeList[feeIndex].itemFee" onkeyup="showFeeTotal(1)" value="0" type="text">
		</td>
		<td>
			Qty:
		</td>
		<td>
			<input class="form-control input-group1" name="otherFeeList[feeIndex].itemFeeNum" onkeyup="showFeeTotal(1);"
				maxlength="2" size="30" value="1" type="text">
		</td>
		<td>
			Remark:
		</td>
		<td>
			<input name="otherFeeList[feeIndex].remark" maxlength="100" size="30" value="" class="remarkCss form-control input-group1" type="text">
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this,1);">
		</td>
		<td colspan="2">
                    &nbsp;
		</td>
		<input type="hidden" class="num" name="otherFeeList[feeIndex].num">
		<input type="hidden" name="otherFeeList[feeIndex].type" value="2">
	</tr>
	<tr class="2">
		<td>
			Other Discount:
		</td>
		<td>
			<input class="form-control input-group1" name="discountList[feeIndex].itemFee" onkeyup="showFeeTotal(2);" value="0" type="text">
		</td>
		<td>
			Qty:
		</td>
		<td>
			<input class="form-control input-group1" name="discountList[feeIndex].itemFeeNum" onkeyup="showFeeTotal(2);"
				maxlength="2" size="30" value="1" type="text">
		</td>
		<td>
			Remark:
		</td>
		<td>
			<input name="discountList[feeIndex].remark" value="" class="remarkCss form-control input-group1" type="text">
		    &nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this,2);"></a>
		</td>
		<td colspan="2">
                    &nbsp;
		</td>
		<input class="num" type="hidden" name="discountList[feeIndex].num">
		<input type="hidden" name="discountList[feeIndex].type" value="3">
	</tr>
</table>
<table id="singleGroupLineEdit" style="display:none">
</table>
<table id="singleGroupLineAdd" style="display:none">
	<tr class="groupLineAdd">
		<td width="13%">
			<span>
				Product Code:
			</span>
		</td>
		<td width="37%">
			<input class="form-control input-group1" name="groupLine.tourCode" type="text">
		</td>
		<td width="13%">
			<span>
				Product Name:
			</span>
		</td>
		<td width="37%">
			<input class="form-control input-group1" name="groupLine.tourName" type="text">
		</td>
	</tr>
	<tr class="groupLineAdd">
		<td width="13%">
			<span>
				Product Description:
			</span>
		</td>
		<td width="37%">
			<input class="form-control input-group1" name="groupLine.tripDesc" type="text">
		</td>
		<td width="13%">
		</td>
		<td width="37%">
			<input name="groupLine.departureDate" class="form-control input-group1 groupLineDepartureDate" type="hidden"/>
			<input name="groupLine.brand" value="inbound" type="hidden"/>
		</td>
	</tr>	
</table>
<select id="customerOptionCache" style="display:none">
	[#list customerList as customer]
	<option value="${customer.customerId}">${customer.lastName}/${customer.firstName} ${customer.middleName}</option>
	[/#list]
</select>
<select id="optionCache" style="display:none">
</select>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
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
	
  	var type = $("#tourTypeSelect").find("option:selected").attr("type");
    $(document).ready(function(){
      	$("#departureDateInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay: available, numberOfMonths: 1, minDate: 1 });
      	$("input.JDATE").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
		App.init();
		App.wizard();
		$("#form select.select2").select2({
			width: '60%'
		});
		$("#formSubmit").click(function(){
			submit();
		});
	    initValue();
	  
    });
       $("#tempId option[value='${productVO.tourInfoForOrder.tourType}']").attr("selected",true);
    /* 初始化  */
    function initValue(){
    	[#if groupLine??]
      	if(type == 0 || type == 4){
	      	$("#groupLineSelect option:not(:selected)").remove();
      	}else{
      		$("#editItineraryTd").css("display","none");
      	}
      	[/#if]
	[#list productVO.customerFlights as cor]
		$("#ifPickUp_${cor_index}_${cor.customerFlightList[0].ifPickUp}").click();
		$("#ifSendUp_${cor_index}_${cor.customerFlightList[1].ifSendUp}").click();
		changeOption($("select.customerSelect").eq(${cor_index})[0]);
	[/#list]
    	var $feeTbody = $("#feeTbody");
    	var sum = getSumWithFee($feeTbody.find(".2"));
		$feeTbody.find(".totalDiscountFee").find("input:first").val(sum);
    }
    
    /* 团队类型改变  */
    function tourTypeSelectChange(select){
    	var $selectedOption = $(select).find("option:selected");
    	var isOriginal = $selectedOption.attr("original");
    	var $body = $(select).parent().parent().parent();
    	var $groupLineSelect = $("#groupLineSelect");
    	var $groupLineEditInput = $body.find("tr.groupLineEdit");
		var $groupLineAddInput = $body.find("tr.groupLineAdd");
		var $cacheOptions = $("#optionCache").find("option");
    	
    	/* 原来是自录入团 */
    	if(type == 0 || type == 4){
    		if(isOriginal == "true"){
    		/* 转为初始自录入团  */
    			$("#editItineraryTd").css("display","block");
    			/* 删除产品原有选项，将缓存中的初始值加载出来  */
				$groupLineSelect.find("option").remove();
				$groupLineSelect.append($cacheOptions);  
				$groupLineSelect.select2({width:'60%'}); 
				
				/* 删除groupline新增的输入框，并将缓存中的原始编辑输入框取出来  */ 			
    			$groupLineAddInput.remove(); //如果是其他自录入团转为初始自录入团，删除掉产品输入框
    			$("#tourInformationTr").after($("#singleGroupLineEdit").find("tr"));
    		}else if($selectedOption.attr("type") == 0 || $selectedOption.attr("type") == 4){
    		/* 转为其他自录入团  */
    			$("#editItineraryTd").css("display","none");
				if($groupLineEditInput.size() == 0){
				
					if($groupLineAddInput.size() == 0){
					/* 系统录入团转为其他自录入团*/	
						changeGroupLineOptionsToNewAndGroupLineAddHtml($groupLineSelect);
					}else{
					/* 其他自录入团转为其他自录入团，什么都不改变 */	
					}
				}else{
				/* 初始自录入团转为其他自录入团 */
					$groupLineSelect.find("option").appendTo($("#optionCache"));
					$groupLineEditInput.appendTo($("#singleGroupLineEdit"));
					changeGroupLineOptionsToNewAndGroupLineAddHtml($groupLineSelect);
				}
			}else{
			/* 转为系统录入团 */
				$("#editItineraryTd").css("display","none");
				if($groupLineEditInput.size() == 0){
				/*  系统系统录入团或其他自录入团转为系统录入团  */
					$groupLineSelect.find("option").remove();
					$groupLineAddInput.remove();
				}else{
				/* 	初始自录入团转为系统录入团  */
					$groupLineSelect.find("option").appendTo($("#optionCache"));
					$groupLineEditInput.appendTo($("#singleGroupLineEdit"));
				}
				asynchronousGetGroupLinesByTourType($(select).val()); 
			}
    	}else{
    	/* 原来是系统录入团  */ 
    		if(isOriginal == "true"){
    		/* 转为初始系统录入团  */
    			$groupLineSelect.find("option").remove();
    			$groupLineSelect.append($cacheOptions);
    			$groupLineSelect.val($cacheOptions.filter("[selected=selected]").val());
				$groupLineSelect.select2({width:'60%'}); 
				$groupLineAddInput.remove();
    		}else if($selectedOption.attr("type") == 0 || $selectedOption.attr("type") == 4){
    		/* 转为自录入团 */
    			if($groupLineAddInput.size() == 0){
					if($cacheOptions.size() == 0){
	    			/* 原始系统录入团转为自录入团  */
	    				$("#optionCache").append($groupLineSelect.find("option"));	
	    				$groupLineSelect.append("<option>NEW</option>");
	    				$groupLineSelect.select2({width:'60%'}); 
	    			}else{
	    			/* 其他系统录入团转为自录入团 */
	    				$groupLineSelect.find("option").remove();
	    				$groupLineSelect.append("<option>NEW</option>");
	    				$groupLineSelect.select2({width:'60%'}); 
	    			}
	    			$("#tourInformationTr").after($("#singleGroupLineAdd").find("tr").clone(true));	
    			}
    		}else{
    		/* 转为其他系统录入团 */
    			if($groupLineAddInput.size() == 0){
					if($cacheOptions.size() == 0){
	    			/* 原始系统录入团转为其他系统录入团  */
	    				$groupLineSelect.find("option").appendTo($("#optionCache"));
	    			}else{
	    			/* 其他系统录入团转为其他系统录入团 */
	    				$groupLineSelect.find("option").remove();			
	    			}	
    			}else{
    			/* 自录入团转为其他系统录入团 */
    				$groupLineSelect.find("option").remove();		
    				$groupLineAddInput.remove();		
    			}
    			asynchronousGetGroupLinesByTourType($(select).val());
    		}
    	}
    }
    
    /* 产品SELECT被置为NEW，添加产品新增输入框  */
    function changeGroupLineOptionsToNewAndGroupLineAddHtml($groupLineSelect){
		$groupLineSelect.find("option").remove();
		$groupLineSelect.append("<option>NEW</option>");
		$groupLineSelect.select2({width:'60%'}); 
		$("#tourInformationTr").after($("#singleGroupLineAdd").find("tr").clone(true));
    }
    
    /* 根据团队类型异步获取产品列表 */
    function asynchronousGetGroupLinesByTourType(tourTypeId){
    	$.post("loadGroupLineForOptions.jhtml", { "tourTypeId" : tourTypeId}, function(groupLines) {
    		var $groupLineSelect = $("#groupLineSelect");
    		$.each(groupLines,function(index,groupLine){
    			$groupLineSelect.append("<option value='"+ groupLine.id +"'>"+ groupLine.tourCode +"</option>");
    		});
    		$groupLineSelect.select2({width:'60%'});
    	});
    }
    
    /* 随客人的选择变动航班的客人选项   */
    function changeOption(customerSelect){
		
    	/* select之前选中的值，用于给其他的select做添加  */
    	var beforeId = $(customerSelect).attr("beforeId");
    	$(customerSelect).addClass("selected");
    	
    	if(beforeId == '0'){
	    	$("select.customerSelect:not(.selected)").find("option[value=" + $(customerSelect).val() + "]").remove();
    	}else{
    		var $addOption = $("#customerOptionCache").find("option[value=" + beforeId + "]").clone(true);
    		if($(customerSelect).val() == '0'){
    			$("select.customerSelect:not(.selected)").append($addOption);
    		}else{
    			$("select.customerSelect:not(.selected)").append($addOption).find("option[value=" + $(customerSelect).val() + "]").remove();
    		}
    	}
    	$(customerSelect).removeClass("selected");
    	$(customerSelect).attr("beforeId",$(customerSelect).val());
    }
    
   	/* 将上一个客人的信息复制到本客人   */
    function theSameAsPrevious(copyButton){
    	var currentName = $(copyButton).parent().parent().prev().find("select").attr("name");
    	var number = currentName.substring(currentName.indexOf('[') + 1, currentName.indexOf(']'));
    	
    	$("input[name='customerFlights[" + number + "].customerFlightList[0].flightCode']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[0].flightCode']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[0].flightNumber']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[0].flightNumber']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[0].arriveDate']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[0].arriveDate']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[0].arriveTime']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[0].arriveTime']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[0].remark']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[0].remark']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[1].flightCode']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[1].flightCode']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[1].flightNumber']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[1].flightNumber']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[1].arriveDate']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[1].arriveDate']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[1].arriveTime']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[1].arriveTime']").val());
    	$("input[name='customerFlights[" + number + "].customerFlightList[1].remark']").val($("input[name='customerFlights[" + (number - 1) + "].customerFlightList[1].remark']").val());
    	var ifPickUp = $("input[name='customerFlights[" + (number - 1) + "].customerFlightList[0].ifPickUp']:checked").val();
    	var ifSendUp = $("input[name='customerFlights[" + (number - 1) + "].customerFlightList[1].ifSendUp']:checked").val();
    	$("input[name='customerFlights[" + number + "].customerFlightList[0].ifPickUp']").parent().parent().eq(ifPickUp - 1).click();
		$("input[name='customerFlights[" + number + "].customerFlightList[1].ifSendUp']").parent().parent().eq(ifSendUp - 1).click();  	
    }
    
    /* 增加费用或折扣  */
    function addFee(classNo){
    	var $newHtml = $("#feeTemplate").find("." + classNo).clone(true);
    	if(classNo == 1){
    		$("#feeTbody").find(".totalDiscountFee").before($newHtml);
    	}else{
    		var $peerUserFee = $("#feeTbody").find(".peerUserFee");
    		if($peerUserFee.size() > 0){
    			$peerUserFee.before($newHtml);
    		}else{
    			$("#feeTbody").find(".sumFee").before($newHtml);
    		}
    	}
    }
    /* 删除费用或折扣  */
    function removeFee(button,classNo){
        $(button).parent().parent().remove();
        showFeeTotal(classNo);
    }
    
    /* 异步删除费用和折扣  */
    function deleteFee(button,classNo,id){
    	$("#form").append('<input type="hidden" name="deleteItemIds" value="' + id + '"/>');
        $(button).parent().parent().remove();
        showFeeTotal(classNo);
    }
   
    /* 计算常规团费总额  */
    function showRegularTourTotalFee(){
    	var $tbody = $("#feeTbody");
    	var $commonTourTrs = $tbody.children(".commonTourFee");
        var totalCommonTourFee = getSumWithFeeAndFeeNum($commonTourTrs);
        $tbody.children(".totalCommonTourFee").find("input:first").val(totalCommonTourFee);
        showSumFee();
    }
    
	/* 计算共计应收团款  */
    function showSumFee(){
    	var $tbody = $("#feeTbody");
    	var totalCommonTourFee = $tbody.children(".totalCommonTourFee").find("input:first").val() * 1;
    	var totalOtherFee = $tbody.children(".totalOtherFee").find("input:first").val() * 1;
    	var discountFee = $tbody.children(".totalDiscountFee").find("input:first").val() * 1;
    	var peerUserFee = $("#peerUserFee").val();
    	if(typeof(peerUserFee) == 'undefined'){
    		peerUserFee = 0;
    	}
    	$tbody.children(".sumFee").find("input:first").val(totalCommonTourFee + totalOtherFee - discountFee - peerUserFee);
    }
    
    /* 用费用的款项和数量计算出总值  */
    function getSumWithFeeAndFeeNum($trs){
        var sum = 0;
        $trs.each(function() {
            var $tds = $(this).children("td");
            var fee = $tds.eq(1).children("input").eq(0).val();
            var feeNum = $tds.eq(3).children("input").eq(0).val();
            sum += fee * feeNum;
        });
        return sum;
    }
    
	/* 用费用的款项计算出总值  */
    function getSumWithFee($trs){
        var sum = 0;
        $trs.each(function(){
            var fee = $(this).children("td").eq(1).find("input").eq(0).val();
            var feeNum = $(this).children("td").eq(3).find("input").eq(0).val();
            sum += fee * feeNum;
        });
        return sum;
    }
    
    /* 计算费用和折扣总额  */
    function showFeeTotal(classNo) {
    	var totalOtherFee = 0;
    	var $feeTbody = $("#feeTbody");
    	var sum = getSumWithFee($feeTbody.find("." + classNo));
    	if(classNo == 1){
    		$feeTbody.find(".totalOtherFee").find("input:first").val(sum);
    	}else if(classNo == 3){
    		$feeTbody.find(".peerUserFee").find("input:first").val(sum);
    	}else{
    		$feeTbody.find(".totalDiscountFee").find("input:first").val(sum);
    	}
        showSumFee();
    }
    
    /* 计算佣金  */
    function showCommTotal() {
    	var sum = getSumWithFee($feeTbody.find("." + classNo));
    	if(classNo == 1){
    		$feeTbody.find(".totalOtherFee").find("input:first").val(sum);
    	}else{
    		$feeTbody.find(".totalDiscountFee").find("input:first").val(sum);
    	}
        showSumFee();
    }
    
    /* 提交  */
    function submit(){
    	var rate = $("#rateInput").val();
    	var peerUserId=$("#peerUserId").val();/*判断是否是同行订单，是同行自组订单也出现备注框*/
    	var reg = /^\d+(\.\d+)?$/;
		[#list ["admin:Office"] as permission]
			[@shiro.lacksPermission name = permission]
				if(!rate.match(reg) || rate < 0){
		    		alert('Please enter a number greater than zero.');	
		    	}
		    	if($("#adultPriceId").val() == 0){
					alert("Adult Tour Price cannot be zero.");
					return;
				}
			[/@shiro.lacksPermission]
		[/#list]
    	var errorMsg = '';
    	$("#feeTbody").find(".1").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
				if($(this).hasClass("num")){
					$(this).val(201 + index);
				}
    		});
    	});
    	$("#feeTbody").find(".2").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
				if($(this).hasClass("num")){
					$(this).val(301 + index);
				}
    		});
    	});
	    var $customerSelect = $("#form select.customerSelect");
	    var isError = 0;
	    $customerSelect.each(function(index){
	    	if($(this).val() == '0'){
	    		errorMsg = 'Please select customer for No.' + (index + 1) + ' flights';
	    		isError = 1;
	    		return false;
	    	}
	    })
	    if(isError == 0){
	    	if('${productVO.order.isSelfOrganize}' == '0'){
	    		$("#orderRemark").click();
	    	}else if('${productVO.order.isSelfOrganize}' == '1'&&peerUserId){
	    		$("#orderRemark").click();
	    	}else{
	    		$("input.groupLineDepartureDate").val($("#arrivalDateInput").val());
	    		$("#form").submit(); 
	    	}
	    }else{
	    	alert(errorMsg);
	    }
    }
    
    function updateOrder(){
    	var $recordForm = $("#updateRecord");
    	$("#updateRemark").val($("#remark").val());
    	var newState = $recordForm.find("input[name='newState']:checked").val();
    	$("#newState").val(newState);
    	var warnState = $recordForm.find("input[name='warnState']:checked").val();
    	$("#warnState").val(warnState);
    	$("input.groupLineDepartureDate").val($("#arrivalDateInput").val());
    	var reviewState=$recordForm.find("input[name='reviewStateId']:checked").val();
    	$("#reviewState").val(reviewState);
    	$("#peerUserRemark").val($("#peerUserRemarks").val());
    	$("#form").submit(); 
    }
    /**查看B2B费用详情信息**/
    function show(){
    	$("#b2bFeeTable").toggle();
    }
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>
