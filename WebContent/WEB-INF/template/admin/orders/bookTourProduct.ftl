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
            <h2>Add Booking</h2>
            <div class="new">
	        	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	        </div>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="list">Booking</a></li>
				<li class="active">Add Booking - ${ordersTotal.orderNumber}</li>
            </ol>    
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
            	<!--
            	<h4>
            	<div class="col-md-2 col-sm-4">ContactName:&nbsp; ${ordersTotal.contactName}</div>
            	<div class="col-md-2 col-sm-4">Tel:&nbsp; ${ordersTotal.tel}</div>
            	<div class="col-md-8 col-sm-4">Wholesale/Retail:&nbsp; ${ordersTotal.wr}</div>
            	</h4>-->
				<!--<div title="Filter" class="pull-right pull-cursor">
					<i class="fa fa-caret-square-o-down fa-lg color-blue" id="filter"></i>&nbsp;&nbsp;
				</div>
				<div style="margin:26px; padding: 5px 0px; display: none;" class="options">
					<div class="nav-panel">
						<div class="nav-block">
							<div class="block-head">
								<span class="nav-title">ContactName</span>:
							</div>
							<div class="block-body default-4-line pull-cursor">
								<div class="params-cont">
									${ordersTotal.contactName}
								</div>
							</div>
						</div>
						<div class="nav-block">
							<div class="block-head">
								<span class="nav-title">Tel</span>:
							</div>
							<div class="block-body default-4-line pull-cursor">
								<div class="params-cont">
									${ordersTotal.tel}
								</div>
							</div>
						</div>
						<div class="nav-block">
							<div class="block-head">
								<span class="nav-title">Wholesale/Retail</span>:
							</div>
							<div class="block-body default-4-line pull-cursor">
								<div class="params-cont">
									${ordersTotal.wr}
								</div>
							</div>
						</div>
						<div class="nav-block">
							<div class="block-head">
								<span class="nav-title">Tel</span>:
							</div>
							<div class="block-body default-4-line pull-cursor">
								<div class="params-cont">
									${ordersTotal.tel}
								</div>
							</div>
						</div>
					</div>
				</div>-->
			</div>
	     </div>
        <div class="block-wizard">
          <div id="wizard1" class="wizard wizard-ux" style="font-weight:bold;">
            <ul class="steps">
             <li data-target="#step1" class="active"><i class="fa fa-group"></i>&nbsp;Tour Info<span class="chevron"></span></li>
              <li data-target="#step2"><i class="fa fa-plane"></i>&nbsp;Flight Info<span class="chevron"></span></li>
              <li data-target="#step3"><i class="fa fa-money"></i>&nbsp;Price Info<span class="chevron"></span></li>
            </ul>
          </div>
          <div class="step-content">
            <form class="form-horizontal group-border-dashed" action="addProduct.jhtml" method="post" data-parsley-validate novalidate> 
				<input type="hidden" name="ordersTotalId" value="${ordersTotalId}">
				[#-- groupline存在，则非单订     --]
				[#if groupLine??]
					<input type="hidden" name="tourInfoForOrder.groupLineId" value="${groupLine.id}">
					<input type="hidden" name="tourInfoForOrder.scheduleLineCode" value="${groupLine.tourCode}">
					<input type="hidden" name="tourInfoForOrder.lineName" value="${groupLine.tourName}">
					<input type="hidden" name="isSelfOrganize" value="${isSelfOrganize}">
				[#else]
				[#-- groupline不存在，则单订     --]
					<input type="hidden" name="tourInfoForOrder.lineName" value="${singleType}">
					<input type="hidden" name="order.orderTourType" value="${singleType}">
				[/#if]
				<input type="hidden" name="order.brand" value="${brand}">
				<div class="step-pane active" id="step1">
	                <div style="width:auto;height:auto;margin:20px 0 0 0;border:0px none solid;padding:8px;">
						<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
							<tbody>
								<tr>
									<td width="13%">
										Departure Date:
									</td>
									<td width="37%">
										<input id="departureDateInput" type="text" readonly="readonly" name="tourInfoForOrder.departureDate" value="${departureDate}" class="form-control input-group1" placeholder="yyyy-mm-dd"/>
										<font size="2px" color="red">
											&nbsp;The departure dates are same as 
											<br/>&nbsp;the website listed.
										</font>
									</td>
									<td width="13%">
									[#-- 单订情况下  --]
									[#if tourTypeList??]
										Tour Type:
									[/#if]
									[#if brand=='inbound']
										Tour Type:
									[/#if]
									</td>
									<td width="37%">
									[#if tourTypeList??]
										<select name="order.tourTypeId" class="select2">
											[#list tourTypeList as tourType]
											<option value="${tourType.tourTypeId}">${tourType.typeName}</option>
											[/#list]
										</select>
									[#else]
										[#-- 非订单情况下，给order储存TourTypeId --]
										<input name="order.tourTypeId" type="hidden" value="${groupLine.tourTypeId}">
									[/#if]
									[#if brand=='inbound']
										<select name="tourInfoForOrder.tourType" class="select2">
											<option value="">Select Source</option>
											<option value="家庭团">家庭团</option>
											<option value="散拼团">散拼团</option>
											<option value="学生团">学生团</option>
											<option value="商务团">商务团</option>
											<option value="会展团">会展团</option>
											<option value="其他">其他</option>
										</select>
									[/#if]
									</td>
								</tr>
								<tr>
									[#if brand != '中国美']
										<td width="13%">
											Arrive Date:
										</td>
										<td width="37%"> 
											<input id="scheduleOfArriveTimeInput" type="text" name="tourInfoForOrder.scheduleOfArriveTime" class="form-control input-group1" required placeholder="yyyy-mm-dd"/>
											<font size="2px" color="red">
											    &nbsp;*
											</font>
										</td>
									[/#if]
									<td width="13%">
										Departure city:
									</td>
									<td width="37%">
										<input type="text" name="tourInfoForOrder.specialRequirements" value="" class="form-control input-group1"/>
										<!--<textarea name="tourInfoForOrder.specialRequirements" cols="30" rows="4" class="form-control input-group1"></textarea>
						                 -->
									</td>
								</tr>
								<tr>
									<td width="13%">
										Due Date:
									</td>
									<td width="37%"> 
										<input id="dueDate" type="text" name="tourInfoForOrder.dueDate" class="form-control input-group1" required placeholder="yyyy-mm-dd"/>
										<font size="2px" color="red">
										    &nbsp;*
										</font>
									</td>
									<td width="13%">
										
									</td>
									<td width="37%">
										
									</td>
								</tr>
								<tr>
									<td width="13%">
										Remark:
									</td>
									<td width="37%">
										<textarea name="tourInfoForOrder.tourInfo" cols="30" rows="8" class="form-control input-group"></textarea>
									</td>
									<td width="13%">
										Tour Voucher Remarks:
									</td>
									<td width="37%">
										<textarea name="tourInfoForOrder.voucherRemarks" cols="30" rows="8" class="form-control input-group"></textarea>
									</td>
									<td width="13%"></td>
									<td width="37%"></td>
								</tr>
								<tr>
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
					<div id="afterFlightsInformation" class="new" style="text-align:right"><button class="btn btn-success" type="button" onclick="addFlightInformation();">&nbsp;&nbsp;And New Customer &nbsp;&nbsp;</button></div>
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
												<input class="icheck" type="radio" name="order.planticket" value="1" 
													style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Booked by Agent &nbsp;&nbsp;
										</label>
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="order.planticket" value="2"
													style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Booked by OP &nbsp;&nbsp;
										</label>
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="order.planticket" value="0" checked=""
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
										<textarea name="order.otherInfo" cols="30" rows="4" class="form-control input-group1"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="form-group" align="right">
						<div class="col-sm-12">
							<button data-wizard="#wizard1" class="btn btn-default wizard-previous"><i class="fa fa-caret-left"></i> Previous</button>
							<button data-wizard="#wizard1" id="customerFlightStep" onclick="verifyFlight();" class="btn btn-primary wizard-next">Next Step <i class="fa fa-caret-right"></i></button>
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
									<input  class="form-control input-group1" required="" id="adultPriceId" name="adultItem.itemFee" onkeyup="showRegularTourTotalFee();" maxlength="100" size="30" value="0" type="text">
									<font size="2px" color="red">
										    &nbsp;*
									</font>
								</td>
								<td width="10%">
									Qty:
								</td>
								<td width="20%">
								
									<input class="form-control input-group1" name="adultItem.itemFeeNum" onkeyup="showRegularTourTotalFee();"
										maxlength="2" size="30" value="1" type="text" placeholder="Number">
										<div class="none">
										</div>
								</td>
								<td width="10%">
									Remark:
								</td>
								<td width="30%">
									<input class="form-control" name="adultItem.remark" type="text">
								</td>
								<input type="hidden" name="adultItem.type" value="1">
								<input type="hidden" name="adultItem.num" value="101">
							</tr>
							<tr class="commonTourFee">
								<td>
									Child Tour Price:
								</td>
								<td> 
									<input class="form-control input-group1" name="childrenItem.itemFee" onkeyup="showRegularTourTotalFee();"
										maxlength="100" size="30" value="0" type="text" placeholder="Child Tour Price">
								</td>
								<td>
									Qty:
								</td>
								<td>
									<input class="form-control input-group1" name="childrenItem.itemFeeNum" onkeyup="showRegularTourTotalFee();"
										maxlength="2" size="30" value="1" type="text">
										<div class="none">
										</div>
								</td>
								<td>
									Remark:
								</td>
								<td>
									<input class="form-control" name="childrenItem.remark" type="text">
								</td>
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
									<input class="form-control input-group1" name="receivableInfoOfOrder.totalCommonTourFee" style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Total Tour Price">
								</td>
								<td colspan="4">
			                                &nbsp;
								</td>
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
									<input class="form-control input-group1" name="receivableInfoOfOrder.totalFeeOfOthers" style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Other Charge">&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(1);"></a>
								</td>
								<td colspan="4">
			                                &nbsp;
								</td>
							</tr>
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
							<tr class="sumFee">
								<td>
									<strong>
										<b>
											Total Amount：
										</b>
									</strong>
								</td>
								<td>
									<input class="form-control input-group1" name="receivableInfoOfOrder.sumFee" style="background-color:#dddddd;"
										value="0" readonly="readonly" type="text" placeholder="Total Amount">
								</td>
								<td>
									<strong>
										<b>
											Tax:
										</b>
									</strong>
								</td>
								<td>
									<input id="rateInput" class="form-control input-group1" name="order.rate"
										value="0" type="text" placeholder="">%
								</td>
								<td colspan="2">
			                      &nbsp;
								</td>
							</tr>
						</tbody>
					</table>
	                <div class="form-group" align="right">
						<div class="col-sm-12">
							<button data-wizard="#wizard1" class="btn btn-default wizard-previous"><i class="fa fa-caret-left"></i> Previous</button>
							<button type="button" id="formSubmit" data-wizard="#wizard1" class="btn btn-success wizard-next"><i class="fa fa-check"></i> Save </button>
						</div>
	                </div>	
                </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    </div>
    </div>
</div>
<div id="customerFlightInputTemplate" class="customerFlight_div" style="display:none">
	<div id="customer_[customerIndex]" style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;"></div>
	<table style="border: 0px none" id="flightInfo">
		<tbody>
			<tr>
				<td style="font-weight:bold;">
					<span>
						Select Customer:
					</span>
				</td>
				<td>
					<select name="customerFlights[customerIndex].customerId" beforeId="0" onchange="changeOption(this);" class="select2 customerSelect">
						<option value="0">Select Customer</option>
						[#list customerList as customer]
						<option value="${customer.customerId}">${customer.lastName}/${customer.firstName} ${customer.middleName}</option>
						[/#list]
					</select>
				</td>
				<td>
					<div class="copyPrevious" style="text-align:right"><button class="btn" type="button" onclick="theSameAsPrevious(this);">&nbsp;&nbsp;The Same As Previous Customer &nbsp;&nbsp;</button></div>
				</td>
				<td>
				</td>
			</tr>
			<tr style="font-weight:">
				<td colspan="4">
							Arrival Flight:
				</td>
			</tr>
			<tr>
				<td width="13%">
					<span>
						Airline:
					</span>
				</td>
				<td width="37%">
					<input class="form-control input-group1" name="customerFlights[customerIndex].customerFlightList[0].flightCode" type="text">
				</td>
				<td width="13%">
					<span>
						Flight No.:
					</span>
				</td>
				<td width="37%">
					<input class="form-control input-group1" name="customerFlights[customerIndex].customerFlightList[0].flightNumber" type="text">
				</td>
			</tr>
			<tr>
				<td>
					<span>
						Arrival Date:
					</span>
				</td>
				<td>
					<input type="text" name="customerFlights[customerIndex].customerFlightList[0].arriveDate" value="" class="form-control input-group1 JDATE" placeholder="yyyy-mm-dd" />
				</td>
				<td>
					<span>
						Arrival Time:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" size="16" type="text" name="customerFlights[customerIndex].customerFlightList[0].arriveTime" /><font size="2px" color="red"></font>
				</td>
			</tr>
			<tr>
				<td>
					<span>
						Pick-up:
					</span>
				</td>
				<td>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="customerFlights[customerIndex].customerFlightList[0].ifPickUp" value="1"
								style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes &nbsp;&nbsp;
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="customerFlights[customerIndex].customerFlightList[0].ifPickUp" value="2" checked=""
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
					<input class="form-control input-group1" name="customerFlights[customerIndex].customerFlightList[0].remark" type="text">
					<!-- 出入境 ，入境 -->
					<input class="hasDatepicker" name="customerFlights[customerIndex].customerFlightList[0].outOrEnter" value="1" type="hidden">
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
				<td colspan="">
					<span>
						Airline:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" name="customerFlights[customerIndex].customerFlightList[1].flightCode" type="text">
				</td>
				<td>
					<span>
						Flight No.:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" name="customerFlights[customerIndex].customerFlightList[1].flightNumber" type="text">
				</td>
			</tr>
			<tr>
				<td>
					<span>
						Departure Date:
					</span>
				</td>
				<td>
					<input type="text" name="customerFlights[customerIndex].customerFlightList[1].arriveDate" value="" class="form-control input-group1 JDATE"  placeholder="yyyy-mm-dd" />
				</td>
				<td>
					<span>
						Departure Time:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" size="16"  type="text" name="customerFlights[customerIndex].customerFlightList[1].arriveTime" /><font size="2px" color="red"></font>
				</td>
			</tr>
			<tr>
				<td>
					<span>
						Drop-off:
					</span>
				</td>
				<td>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="customerFlights[customerIndex].customerFlightList[1].ifSendUp" value="1"
								style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes &nbsp;&nbsp;
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="customerFlights[customerIndex].customerFlightList[1].ifSendUp" value="2" checked=""
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
					<input class="form-control input-group1" name="customerFlights[customerIndex].customerFlightList[1].remark" type="text">
					<!-- 出入境 ，入境 -->
					<input  class="hasDatepicker" name="customerFlights[customerIndex].customerFlightList[1].outOrEnter" value="2" type="hidden">
				</td>
			</tr>
		</tbody>
	</table>
</div>
<table id="feeTemplate" style="display:none">
	<tr class="1">
		<td>
			Other Charge：
		</td>
		<td>
			<input class="form-control input-group1" name="otherFeeList[feeIndex].itemFee" onkeyup="showFeeTotal(1)" value="0" type="text" placeholder="Other Fee">
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
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this,1);"></a>&nbsp;&nbsp;&nbsp;

		</td>
		<td>
			<!--自选项-->
			<select type="text" id="optionals" name="otherFeeList[feeIndex].optionalId" style="width:300px;" onchange="optional(this);" class="select2">
					<option value="">Select Optional</option>
					[#list optionalist as optional]
						<option value="${optional.id}">${optional.name}</option>
					[/#list]
			</select>
		</td>
		<!--自选项
		<td>
			
			<select type="text" name="otherFeeList[feeIndex].customerId" style="width:50px;">
					[#list customerList as customer]
						<option value="${customer.customerId}">${customer.lastName}/${customer.firstName} ${customer.middleName}</option>
					[/#list]
			</select>
		</td>
		-->
		<input type="hidden" class="num" name="otherFeeList[feeIndex].num">
		<input type="hidden" name="otherFeeList[feeIndex].type" value="2">
	</tr>
	<tr class="2">
		<td>
			Other Discount：
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
		</td>
		<input class="num" type="hidden" name="discountList[feeIndex].num">
		<input type="hidden" name="discountList[feeIndex].type" value="3">
	</tr>
</table>
<select id="customerOptionCache">
	[#list customerList as customer]
	<option value="${customer.customerId}">${customer.firstName} ${customer.lastName}</option>
	[/#list]
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
    $(document).ready(function(){
    	$("#departureDateInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay: available, numberOfMonths: 1, minDate: 1 });
    	$("#scheduleOfArriveTimeInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
		$("#dueDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
		App.init();
		App.wizard();
		$("form select.select2").select2({
			width: '60%'
		});
		
		$("#formSubmit").click(function(){
			submit();
		});
		addFlightInformation();
    });
    
    /*  添加航班输入  */
    function addFlightInformation(){
        var customerFlightIndex = $("form .customerFlight_div").size();
    	var $customerFlight = generalCustomerFlightInputHtml(customerFlightIndex);
    	initFlight($customerFlight);
    	$("#afterFlightsInformation").before($customerFlight);
    	if(customerFlightIndex == ${customerList?size} -1){
        	$("#afterFlightsInformation").remove();
        }
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
    
    function initFlight($html){
        $html.find("select.select2").select2({
    		width: '60%'
    	});
    	$html.find('.icheck').iCheck({
          checkboxClass: 'icheckbox_square-blue checkbox',
          radioClass: 'iradio_square-blue'
        });
        $html.find("select.customerSelect").append($("#customerOptionContainer").children("option").clone(true));
        $html.find("input.JDATE").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    }
    
    /* 随客人的选择变动航班的客人选项   */
    function changeOption(customerSelect){
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
    
    /* 验证客人航班信息是否录入完全   */
    function verifyFlight(){
    	var errorMsg = '';
    	if($("form .customerFlight_div").size() < ${customerList?size}){
    		errorMsg = 'Please select flights for the rest traveller.';
    	}else{
    	    var $customerSelect = $("form select.customerSelect");
    	    var isError = 0;
    	    $customerSelect.each(function(index){
    	    	if($(this).val() == '0'){
    	    		errorMsg = 'Please select customer for No.' + (index + 1) + ' flights';
    	    		isError = 1;
    	    		return false;
    	    	}
    	    })
    	    if(isError == 0){
    	    	errorMsg = '';
    	    }
    	}
    	if(errorMsg != ''){
    		alert(errorMsg); 
    	}
    }
    
    /* 增加费用或折扣  */
    function addFee(classNo){
    	var $newHtml = $("#feeTemplate").find("." + classNo).clone(true);
    	if(classNo == 1){
    		$("#feeTbody").find(".totalDiscountFee").before($newHtml);
    	}else{
    		$("#feeTbody").find(".sumFee").before($newHtml);
    	}
    	$("#optionals").select2({});
    }
    
    /* 删除费用或折扣  */
    function removeFee(button,classNo) {
        $(button).parent().parent().remove();
        showFeeTotal(classNo);
    }
   
    /* 计算常规团费总额  */
    function showRegularTourTotalFee() {
    	var $tbody = $("#feeTbody");
    	var $commonTourTrs = $tbody.children(".commonTourFee");
        var totalCommonTourFee = getSumWithFeeAndFeeNum($commonTourTrs);
        $tbody.children(".totalCommonTourFee").find("input:first").val(totalCommonTourFee);
        showSumFee();
    }
    
	/* 计算共计应收团款  */
    function showSumFee() {
    	var $tbody = $("#feeTbody");
    	var totalCommonTourFee = $tbody.children(".totalCommonTourFee").find("input:first").val() * 1;
    	var totalOtherFee = $tbody.children(".totalOtherFee").find("input:first").val() * 1;
    	var discountFee = $tbody.children(".totalDiscountFee").find("input:first").val() * 1;
    	$tbody.children(".sumFee").find("input:first").val(totalCommonTourFee + totalOtherFee - discountFee);
    }
    
    /* 用费用的款项和数量计算出总值  */
    function getSumWithFeeAndFeeNum($trs) {
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
    function getSumWithFee($trs) {
        var sum = 0;
        $trs.each(function() {
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
    	}else{
    		$feeTbody.find(".totalDiscountFee").find("input:first").val(sum);
    	}
        showSumFee();
    }
    
    /* 提交  */
    function submit(){
    	var rate = $("#rateInput").val();
    	var reg = /^\d+(\.\d+)?$/;
    	if(!rate.match(reg) || rate < 0){
    		alert('Please enter a number greater than zero.');	
    	}
    	$("#feeTbody").find(".1").each(function(index){
    		$(this).find("input[name^='otherFeeList[feeIndex]']").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
				if($(this).hasClass("num")){
					$(this).val(201 + index);
				}
    		});
    		$(this).find("select").each(function(){
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
    	if($("#scheduleOfArriveTimeInput").val() == ''){
    		alert("Please fill the arrival date.");
    		return;
    	}else if($("#adultPriceId").val() == 0){
    		alert("Adult Tour Price cannot be zero.");
    		return;
    	}else{
    		$("form").submit(); 
    	}
    }
    
    /* 根据模板生成customerFlight输入的html */
    function generalCustomerFlightInputHtml(customerIndex) {
    	var $customerFlightInput = $("#customerFlightInputTemplate").clone(true).removeAttr("id").removeAttr("style");
    	$customerFlightInput.find("input,select").each(function(){
			var name = $(this).attr("name");
			if(name != undefined){
				$(this).attr("name",name.replace("customerIndex",customerIndex));
			}
		});
		$customerFlightInput.find("div[id^=customer_]").each(function(){
			var htm = $(this).html();
			if(htm != undefined){
				$(this).html("No."+(customerIndex+1));
			}
		});
		if(customerIndex == 0){
			$customerFlightInput.find("div.copyPrevious").remove();
		}
		return $customerFlightInput;
    };
    
    function requiredContent(object){
    	var str = $(object).val();
    	var message = "&nbsp;This value is required";
    	if(str==""||str==null){
    		$(object).next().html(message);
    	}
    	if(str!=""){
    		$(object).next().html("");
    	}
    };
    //$("div.options").hide();//默认隐藏 筛选 div
	$("#filter").click(function(){
		$("div.options").slideToggle("slow");
		var _slide=$("#filter");
		if(_slide.attr('class')=="fa fa-caret-square-o-up fa-lg color-blue"){
			_slide.removeClass("fa fa-caret-square-o-up fa-lg color-blue").addClass("fa fa-caret-square-o-down fa-lg color-blue");
		}else{
			_slide.removeClass("fa fa-caret-square-o-down fa-lg color-blue").addClass("fa fa-caret-square-o-up fa-lg color-blue");
		}
	});
	function optional(x){
		var $tt=$(x[0]).parent();
		$tt.parent().prev().find("input").val($(x[0]).parent().find('option:selected').text());
		//alert($(x[0]).parent().find('option:selected').text());
	}
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>
