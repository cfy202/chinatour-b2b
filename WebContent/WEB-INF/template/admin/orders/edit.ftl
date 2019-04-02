[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"]/]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>Edit Booking</title>
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
				<div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertFormButton" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
			</h2>
			<div class="new">
	        	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	        </div>
			<ol class="breadcrumb">
				<li>
					<a style="cursor:pointer;" href="../../">
						Home
					</a>
				</li>
				<li>
					<a style="cursor:pointer;" href="list.jhtml">
						Booking
					</a>
				</li>
				<li class="active">
					Edit Booking
				</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-wizard">
						<div class="step-content">
							<form class="form-horizontal group-border-dashed" id="form" action="save.jhtml" method="POST" 
								data-parsley-validate novalidate>
								<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden">
								<input name="peerUserId" value="${ordersTotal.peerUserId}" type="hidden">
								<div class="step-pane active" id="step1">
									<div class="col-md-9 col-sm-1">
										<table style="padding:10px;border: 0px none" width="100%">
											<tbody>
												<tr>
													<td width="13%">
														<span>
															Order No.:
														</span>
													</td>
													<td width="37%">
														<input class="form-control input-group1" disabled="true" value="${ordersTotal.orderNumber}" type="text">
													</td>
													<td width="13%">
														<span>
															Tel:
														</span>
													</td>
													<td width="37%">
														<input class="form-control input-group1 peer" name="tel" value="${ordersTotal.tel}" type="text">
													</td>
												</tr>
												<tr>
													<td width="13%">
														<span>
															Booking Date:
														</span>
													</td>
													<td width="37%">
														<input [#if (ordersTotal.bookingDate)??]value="${ordersTotal.bookingDate?string('yyyy-MM-dd')}"[/#if] class="form-control input-group1" type="text" size="16">
													</td>
													<td>
														<span>
															Email:
														</span>
													</td>
													<td>
														<input class="form-control input-group1 peer" name="email" value="${ordersTotal.email}" type="text">
													</td>
												</tr>
												<tr>
													<td width="13%">
														<span>
															Wholesale/Retail:
														</span>
													</td>
													<td width="37%">
														<select id="retailWholeSale" class="input-group1 select2" name="wr" onchange="retailOrWholeSale(this.value);" type="text">
															<option value="retail" [#if ordersTotal.wr == 'retail']selected="true"[/#if]>Retail</option>
															<option value="wholeSale" [#if ordersTotal.wr == 'wholeSale']selected="true"[/#if]>WholeSale</option>
														</select>
													</td>
													<td width="13%">
														<span>
															Address:
														</span>
													</td>
													<td width="37%">
														<input class="form-control input-group1 peer" name="address" value="${ordersTotal.address}" type="text">
													</td>
												</tr>
												<tr>
													<td width="13%">
														<span>
															Agency:
														</span>
													</td>
													<td width="37%"> 
														<input name="companyId" type="text" id="userSelect" style="width:60%"  value="${ordersTotal.companyId}" onchange="changeCompanyValue(this);" requred=""/>
														<input name="company" type="hidden" value="${ordersTotal.company}">
													</td>
													<td width="13%">
														<span>
															PostCode:
														</span>
													</td>
													<td width="37%">
														<input class="form-control input-group1 peer" name="postCode" value="${ordersTotal.postCode}" type="text">
													</td>
												</tr>
												<tr>
													<td width="13%">
														<span>
															ContactName:
														</span>
													</td>
													<td width="37%">
														<input class="form-control input-group1 peer contactName" name="contactName" value="${ordersTotal.contactName}" type="text">
													</td>
													<td width="13%">
														<span>
															Country:
														</span>
													</td>
													<td width="37%">
														<select id="countrySelect" class="input-group1 select2 peer" name="countryId" onchange="generalStateSelect(this);" type="text">
															<option value="0">Select Country</option>
														[#list countryList as country]
															<option value="${country.id}" [#if ordersTotal.countryId == country.id]selected="true"[/#if]>${country.countryName}</option>
														[/#list]	
														</select>
													</td>
												</tr>
												<tr>
													<td width="13%">
														<span>
															 Number of Traveler:
														</span>
													</td>
													<td width="37%">
														<input class="form-control input-group1" name="totalPeople" value="${ordersTotal.totalPeople}" type="text">
													</td>
													<td width="13%">
														<span>
															State:
														</span>
													</td>
													<td width="37%">
														<select id="stateSelect" class="input-group1 select2 peer" name="stateId" type="text">
															<option value="0">Select State</option>
															[#list stateList as state]
															<option value="${state.id}" [#if ordersTotal.stateId == state.id]selected="true"[/#if]>${state.stateName}</option>
															[/#list]
														</select>
													</td>
												</tr>
												<tr>
													<td width="13%">
														<span>
															Customer Source:
														</span>
													</td>
													<td width="37%">
														<select name="customerSourceId" class="input-group1 select2">
															<option value="">Select Source</option>
														[#list customerSourceList as customerSource]
															<option value="${customerSource.customerSourceId}" [#if ordersTotal.customerSourceId == customerSource.customerSourceId]selected="selected"[/#if]>${customerSource.sourceName}</option>
														[/#list]
													</select
													</td>
													<td width="13%">
														<span>
															City:
														</span>
													</td>
													<td width="37%">
														<select class="input-group1 select2" name="cityId" type="text">
															<option value="0">Select City</option>
														[#list cityList as city]
															<option value="${city.id}" [#if ordersTotal.cityId == city.id]selected="true"[/#if]>${city.cityName}</option>
														[/#list]	
														</select>
													</td>
												</tr>
										     </tbody>
										</table>
									</div>
									<div class="span3 costlist col-md-3 col-sm-1" style="border:1px solid #ddd;background:#fce6d4;">
										<div>
											<label style="text-align: left;padding:7px 0px;font-size:16px;font-weight:bold;">Summary : </label>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Agent: </label>
											<div class="controls">
												<input class="form-control" type="text" value="${ordersTotal.agent}" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Price: </label>
											<div class="controls">
												<input class="form-control" id="priceShow" type="text" value="" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Paid: </label>
											<div class="controls">
												<input class="form-control" type="text" value="${sumPay}" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Balance: </label>
											<div class="controls">
												<input class="form-control" id="balanceShow" type="text" value="" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Tax: </label>
											<div class="controls">
												<input class="form-control" type="text" id="rateInput" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Total: </label>
											<div class="controls">
												<input class="form-control" id="totalShow" type="text" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Cost: </label>
											<div class="controls">
												<input class="form-control" type="text" value="${sumCost}" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
										<div class="control-group">
											<label class="control-label" style="text-align: left;">Profit: </label>
											<div class="controls">
												<input class="form-control" type="text" value="${sumPay - sumCost}" class="input-small" style="background: #edf7f9;" disabled />
											</div>
										</div>
									</div>
									<div style="clear: both"></div>
									
									<div class="form-group" align="center">
										<div class="col-sm-12">
											<button type="button" onclick="updateOrdersTotal();" data-wizard="#wizard1" class="btn btn-default" style="margin-right:40px;">
												<i class="fa fa-check"> </i> Save
											</button>
											<!--没有联谊admin:nexusholidays权限的人-->
            								[@shiro.lacksPermission name = "admin:nexusholidays"]
												<button type="button" onclick="tourBooking();" data-wizard="#wizard1" class="btn btn-success">
													Tour Booking
												</button>
												<button type="button" onclick="otherBooking();" data-wizard="#wizard1" class="btn btn-success">
													Other Booking
												</button>
											[/@shiro.lacksPermission]
											<button type="button" onclick="generateInvoice();" data-wizard="#wizard1" class="btn btn-success">
												Generate Invoice
											</button>
											<button type="button" onclick="settlement();" data-wizard="#wizard1" class="btn btn-success">
												Settlement
											</button>
											<button type="button" onclick="tourBookingT();" data-wizard="#wizard1" class="btn btn-success" id="newBooking" style="display:none">
												New Booking
											</button>
											<input type="hidden" id="uId" value="[@shiro.principal /]">
										</div>
									</div>
								</div>
							</form>
							
							<div class="panel-group accordion accordion-semi" id="accordion3" style="border:1px solid #2BBCA0;">
								<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;cursor:pointer;margin:0px;">
									<i class="fa fa-bars"></i>
									<span class="customerNumber">Details</span>
									<!-- <div class="pull-right">
						               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
						           </div>
						           -->
						        </h4>
								<div class="tab-container" style="margin-top:10px;">
									<ul class="nav nav-tabs">
										<li class="active"><a href="#passengerInfo" data-toggle="tab">Passenger Info</a></li>
										<li><a href="#orderList" data-toggle="tab">Order List</a></li>
										<li><a href="#pay" data-toggle="tab">Income</a></li>
										<li><a href="#cost" data-toggle="tab">Cost</a></li>
									</ul>
									<div class="tab-content">
										<div class="tab-pane active cont" id="passengerInfo" align="right">
											<!--没有联谊admin:nexusholidays权限的人-->
            								[@shiro.lacksPermission name = "admin:nexusholidays"]
												<button id="importCustomerButton" type="button" data-modal="customerImportForm" class="btn btn-success btn-flat md-trigger">IMPORT CUSTOMER</button>
												<button id="selectCustomerButton" type="button" data-modal="customerSelectForm" class="btn btn-success btn-flat md-trigger">SELECT CUSTOMER</button>
												<button type="button" data-modal="customerAddForm" onclick="initCustomerForm();" class="btn btn-success btn-flat md-trigger">ADD NEW</button>
											[/@shiro.lacksPermission]
											<table class="table no-border hover">
												<thead class="no-border">
													<tr>
														<th style="width:15%;"><strong>Last/First Middle Name</strong></th>
														<th style="width:5%;"><strong>Gender</strong></th>	
														<th style="width:10%;"><strong>Nationality</strong></th>
														<th style="width:10%;"><strong>Residency</strong></th>
														<th style="width:10%;"><strong>Birthday</strong></th>
														<th style="width:10%;"><strong>PassportNo</strong></th>
														<th style="width:10%;"><strong>PassportExpirationDate</strong></th>
														<th style="width:10%;"><strong>RoomType</strong></th>
														<th style="width:10%;"><strong>Status</strong></th>
														<th style="width:10%;" class="text-center"><strong>Action</strong></th>
													</tr>
												</thead>
												<tbody id="customerList" class="no-border-y">
													[#list customerOrderRelList as customerOrderRel]
													<tr id="${customerOrderRel.id}" [#if customerOrderRel.contactFlag == 1]style="background-color:#DFDFDF"[/#if]>
														<td>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</td>
														<td>[#if customerOrderRel.customer.sex == 1]F[#elseif customerOrderRel.customer.sex == 2]M [#else][/#if]</td>
														<td>${customerOrderRel.customer.nationalityOfPassport}</td>
														<td>${customerOrderRel.customer.residency}</td>
														<td>[#if (customerOrderRel.customer.dateOfBirth)??]${customerOrderRel.customer.dateOfBirth?string("yyyy-MM-dd")}[/#if]</td>
														<td>${customerOrderRel.customer.passportNo}</td>
														<td>[#if (customerOrderRel.customer.expireDateOfPassport)??]${customerOrderRel.customer.expireDateOfPassport?string("yyyy-MM-dd")}[/#if]</td>
														<td>${customerOrderRel.guestRoomType}</td>
														<td><span class='color-danger'>[#if customerOrderRel.contactFlag == 1]Cancelled[/#if]</span></td>
														<td class="text-center">
														  <a class="label label-default md-trigger" data-modal="customerEditForm" href="javascript:editCustomer('${customerOrderRel.id}');"><i class="fa fa-pencil"></i></a>
														  <a id="${customerOrderRel.id}_Button" class="label label-danger" [#if customerOrderRel.contactFlag == 1]href="javascript:recoverCustomer('${customerOrderRel.id}_Button','${customerOrderRel.id}');"[#else]href="javascript:deleteCustomer('${customerOrderRel.id}_Button','${customerOrderRel.id}');"[/#if]><i [#if customerOrderRel.contactFlag == 1]class="fa fa-mail-reply"[#else]class="fa fa-times"[/#if]></i></a>
														</td>
													</tr>
													[/#list]
												</tbody>
											</table>	
										</div>
										<div class="tab-pane cont" id="orderList" align="right">
											<table class="table no-border hover" id="orderInfo">
												<thead class="no-border">
													<tr>
														<th style="width:6%;">Booking No. </th>
														<th style="width:13%;">Tour Code</th>
														<th style="width:8%;">Arrival Date</th>
														<th style="width:10%;">Status</th>
														<th style="width:5%;">Settlement Status</th>
														<th width="6%">Accountant Auditing</th>
														<th width="6%">Revised Status</th>
														<th width="15%">Product Name</th>
														<th width="8%">Booking Date</th>
														<th width="10%">Amount</th>
														<th width="13%">Action</th>
													</tr>
												</thead>
												<tbody id="customerList" class="no-border-y">
													[#list childOrderList as orderList]
														<tr id="${orderList.id}" [#if orderList.state == 6]style="background-color:#DFDFDF"[#elseif orderList.state == 5]style="background-color:#DFDFDF"[/#if]>
															<td>${orderList.orderNo}</td>
															<td>${orderList.tourCode}</td>
															<td>[#if (orderList.arriveDateTime)??]${orderList.arriveDateTime?string("yyyy-MM-dd")}[/#if]</td>
															<td>
																	[#if orderList.state == 0]
																		<span class='color-danger'>NEW</span>
																	[#elseif orderList.state == 2]
																		<span class='color-success'>COMPOSED</span>
																	[#elseif orderList.state == 3]
																		<span class='color-primary'>UPDATE</span>
																	[#elseif orderList.state == 4]
																		<span class='color-danger'>CANCELLING</span>
																	[#elseif orderList.state == 5]
																		<span class='color-warning'>CANCELLED</span>
																	[#elseif orderList.state == 6]
																		<span class='color-warning'>CANCELLED</span>
																	[#elseif orderList.state == 7]
																		<span class='color-danger'>RECOVERING</span>
																	[/#if]
															</td>
															<td>
																[#if orderList.tax == 0]
																	<span class='color-danger'>UNSETTLED</span>
																[/#if]
																[#if orderList.tax == 2]
																	<span class='color-success'>SETTLED</span>
																[/#if]
																[#if orderList.tax == 3]
																	<span class='color-warning'>SETTLING</span>
																[/#if]
																[#if orderList.tax == 4]
																	<span class='color-success'>SETTLED</span>
																[/#if]
															</td>
															<td>
																[#if orderList.payState == 0]
																	<span class='color-warning'>NEW</span>
																[/#if]
																[#if orderList.payState == 1]
																	<span class='color-success'>APPROVED</span>
																[/#if]
																[#if orderList.payState == 2]
																	<span class='color-danger'>DISAPPROVED</span>
																[/#if]
															</td>
															<td>
																[#if orderList.warnState == 0]
																	<span class='color-warning'>UNREVISED</span>
																[/#if]
																[#if orderList.warnState == 1]
																	<span class='color-success'>CHECKED</span>
																[/#if]
																[#if orderList.warnState == 2]
																	<span class='color-danger'>UNCHECKED</span>
																[/#if]
															</td>
															<td>${orderList.tourTypeId}</td>
															<td>[#if (orderList.createDate)??]${orderList.createDate?string("yyyy-MM-dd")}[/#if]</td>
															<td [#if orderList.state < 4 || orderList.state == 7] class="ordersCommonTourFee"[/#if]>${orderList.commonTourFee}</td>
															<td class="text-center">
																<div class="btn-group">
																	<button class="btn btn-default btn-xs" type="button">Action</button>
																	<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button">
																		<span class="caret" style="text-align:center;border-top:4px solid #fff"></span>
																		<span class="sr-only">Toggle Dropdown</span>
																	</button>
																	<ul role="menu" class="dropdown-menu pull-right" style="position:absolute;z-index:1112">
																		<li><a style="cursor:pointer;" href="editPayCost.jhtml?menuId=302&id=${orderList.id}&totalId=pay"><i class="fa fa-pencil"></i>Income/Cost</a></li>
																		[#if orderList.orderType == 5]
																			<li><a style="cursor:pointer;" href="singleOrderEdit.jhtml?id=${orderList.id}"><i class="fa fa-pencil"></i>Edit</a></li>
																			<li><a style="cursor:pointer;" href="tourOrderEditNew.jhtml?id=${orderList.id}"><i class="fa fa-pencil"></i>New Edit</a></li>
																		[#else]
																			[#if (orderList.state == 5)||(orderList.state == 6)]
																				[#list ["admin:Office"] as permission]
																					[@shiro.hasPermission name = permission]
																					<li><a style="cursor:pointer;" href="tourOrderEdit.jhtml?id=${orderList.id}"><i class="fa fa-pencil"></i>Edit</a></li>
																					[/@shiro.hasPermission]
																				[/#list]
																			[#else]
																				<li><a style="cursor:pointer;" href="tourOrderEdit.jhtml?id=${orderList.id}"><i class="fa fa-pencil"></i>Edit</a></li>
																			[/#if]
																		[/#if]
																		<li><a  style="cursor:pointer;" onclick="isChanged('${orderList.id}')"><i class="fa fa-eye"></i>Tour Voucher</a></li>
																		<li><a  style="cursor:pointer;" href="invoiceForChild.jhtml?id=${orderList.id}"><i class="fa fa-eye"></i>Invoice</a></li>
																		[#if orderList.state != 4 && orderList.state != 7]
																		<li class="divider"></li>
																		<li><a id="${orderList.id}_button" style="cursor:pointer;" [#if (orderList.state == 5)||(orderList.state == 6)]href="javascript:recoverOrder('${orderList.id}_button','${orderList.id}','${orderList.tourId}');"[#else]href="javascript:cancelOrder('${orderList.id}_button','${orderList.id}','${orderList.tourId}');"[/#if]>
																	 	 [#if (orderList.state == 5)||(orderList.state == 6)]<i class="fa fa-mail-reply"></i>Recover[#else]<i class="fa fa-times"></i>Cancel[/#if]</a>
																		</li>
																		[/#if]
																	</ul>
																</div>
															</td>
														</tr>
													[/#list]
												</tbody>
											</table>
										</div>
										<!--收入-->
										<div class="tab-pane cont" id="pay" align="right">
											<!--<button type="button" data-modal="incomeAddForm" class="btn btn-success btn-flat md-trigger" title="ADD INCOME"><i class="fa fa-plus"></i></button>-->
											<table class="no-border">
												<thead class="no-border">
													<tr>
														<th style="width:10%;font-weight:bold;" >Booking No.</th>
														<th style="width:10%;font-weight:bold;" >Date</th>
														<th style="font-weight:bold;">Amount</th>
														<th style="font-weight:bold;">Payment</th>
														<th style="font-weight:bold;">Payment Method</th>
														<td style="font-weight:bold;">Invoice No.</th>
														<th style="font-weight:bold;">Remark</th>
														<th style="font-weight:bold;">Action</th>
													</tr>
												</thead>
												<tbody class="no-border-x"  id="addContent">
												[#list payCostList as payCost]
													[#if (payCost.payRecordsList?size>0)]
														[#list payCost.payRecordsList as payRecord]
														<tr>
															<td>${payRecord.orderNo}</td>
															<td>[#if (payRecord.time)??]${payRecord.time?string('yyyy-MM-dd')}[/#if]</td>
															<td>${payRecord.sum}</td>
															<td>${payRecord.item}</td>
															<td>${payRecord.way}</td>
															<td>${payRecord.code}</td>
															<td>${payRecord.remark}</td>
															<td>
																[#if (payRecord.status==0)]
																<a class="label label-default" href="${base}/admin/orders/editPayCostRecords.jhtml?id=${payRecord.id}&totalId=${ordersTotal.ordersTotalId}" title="Modify"><i class="fa fa-pencil"></i></a>
																<a class="label label-danger" href="javascript:;" onclick="deletePayCost(this,'${payRecord.id}');" title="Delete"><i class="fa fa-times"></i></a>
																[#else]
																<a class="label label-default" title="Inoperable"><i class="fa fa-pencil"></i></a>
																<a class="label label-danger" title="Inoperable"><i class="fa fa-times"></i></a>
																[/#if]
															</td>
														</tr>
														[/#list]
													[/#if]
												[/#list]								
												</table>
										</div>
										<!--成本-->
										<div class="tab-pane cont" id="cost" align="right">
											<table class="no-border" >
												<thead class="no-border">
													<tr>
														<th style="font-weight:bold;">Booking No.</th>
														<th style="font-weight:bold;">DUE DATE</th>
														<th style="font-weight:bold;">Amount</th>
														<th style="font-weight:bold;">Payment</th>
														<th style="font-weight:bold;">Suppliers</th>
														<th style="font-weight:bold;">Invoice No.</th>
														<th style="font-weight:bold;">Remark</th>
														<th style="font-weight:bold;">Action</th>
													</tr>
												</thead>
												<tbody class="no-border-x"  id="addContent">
												[#list payCostList as payCost]
												[#if (payCost.costRecordsList?size>0)]
													[#list payCost.costRecordsList as costRecord]
													<tr>
														<td>${costRecord.orderNo}</td>
														<td>[#if (costRecord.time)??]${costRecord.time?string("yyyy-MM-dd")}[/#if]</td>
														<td>${costRecord.sum}</td>
														<td>${costRecord.item}</td>
														<td>${costRecord.venderString}</td>
														<td>${costRecord.code}</th>
														<td >${costRecord.remark}</td>
														<td >
															[#if (costRecord.status==0)]
															<a class="label label-default" href="${base}/admin/orders/editPayCostRecords.jhtml?id=${costRecord.id}&totalId=${ordersTotal.ordersTotalId}" title="Modify"><i class="fa fa-pencil"></i></a>
															<a class="label label-danger" href="javascript:;" onclick="deletePayCost(this,'${costRecord.id}');" title="Delete"><i class="fa fa-times"></i></a>
															[#else]
															<a class="label label-default" title="Inoperable"><i class="fa fa-pencil"></i></a>
															<a class="label label-danger" title="Inoperable"><i class="fa fa-times"></i></a>
															[/#if]
														</td>
													</tr>
													[/#list]
												[/#if]
												[/#list]
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>		
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="md-modal md-effect-1" id="customerAddForm">
    <div class="md-content">
      <div class="modal-header">
      	<span>Add Customer</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="customerForm">
      <div class="modal-body">
        <div class="text-center">
			<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td>
							<span>
								Type:
							</span>
						</td>
						<td colspan="3">
							<label  id="type0" style="padding-left:0px;display:none;" >
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="0"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
							</label>
				        	<label class="radio-inline" id="type1" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Infant
							</label>
							<label style="padding-left:0px;" id="type2" class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="2" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Child without Bed
							</label>
							<label class="radio-inline" id="type3" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="3"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Child with Bed
							</label>
							<label style="padding-left:0px;" id="type4" class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="4" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Adult
							</label>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Last Name:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.lastName" onblur="customerListen();" onkeyup="this.value = this.value.toUpperCase();" id="lastNameId" required type="text">
						</td>
						<td width="13%">
							<span>
								First Name:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.firstName" onblur="customerListen();" id="firstNameId" onkeyup="this.value = this.value.toUpperCase();" required type="text">
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Middle Name:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.middleName" onkeyup="this.value = this.value.toUpperCase();" required type="text" id="middleNameId">
						</td>
						<td>
							<span>
								Gender:
							</span>
						</td>
						<td>
							<label class="radio-inline" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" id="addCustomerGender" type="radio" name="customer.sex" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Female&nbsp;&nbsp;
							</label>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.sex" value="2" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Male
							</label>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Date Of Birth:
							</span>
						</td>
						<td>
							<input class="form-control date" name="customer.dateOfBirth" placeholder="YYYY-MM-DD" required="" parsley-type="dateIso" type="text" size="14"/>
						</td>
						<td>
							<span>
								Nationality:
							</span>
						</td>
						<td>
							<select id="nationalitySelect" name="customer.nationalityOfPassport" class="select2" style="width:140px">
								<option value="">--Select--</option>
								<option value="Australia">Australia</option>
			            		<option value="Canada">Canada</option>
			            		<option value="China">China</option>
			            		<option value="New Zealand">New Zealand</option>
			            		<option value="United States of America">United States of America</option>
								[#list nationality as nationa]
								<option value="${nationa.name}">
									${nationa.name}
								</option>
								[/#list]
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Passport No.:
							</span>
						</td>
						<td>
							<input class="form-control" name="customer.passportNo" onblur="customerListen();" id="passportNoId" type="text">
						</td>
						<td>
							<span>
								Expiry Date:
							</span>
						</td>
						<td>
							<input class="form-control date" name="customer.expireDateOfPassport" type="text" size="14"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Language:
							</span>
						</td>
						<td>
							<select id="languageSelect" name="customer.languageId" class="select2" style="width:140px">
								<option value="0">
									--Select--
								</option>
								[#list languageList as language]
								<option value="${language.languageId}">
									${language.language}
								</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Residency:
							</span>
						</td>
						<td>
			            	<select name="customer.residency" id="residencyAdd" class="select2">
			            			<option value="">--Select--</option>
									<option value="Same As Nationality">Same As Nationality</option>
									<option value="Australian PR">Australia PR</option>
									<option value="New Zelend PR">New Zelend PR</option>
									<option value="USA Green Card">USA Green Card</option>
									<option value="Canada Maple Card">Canada Maple Card</option>
									<option value="European Union PR">European Union PR</option>
									<option value="Others">Others</option>
			            	</select>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Room Type:
							</span>
						</td>
						<td>
							<select id="guestRoomTypeAddSelect" name="guestRoomType" class="select2 guestRoomType" onchange="getRoommate(this.value,$('#roomNumberAddSelect'));" style="width:140px">
								[#list constant.GUEST_ROOM_TYPES as room]
								<option value="${room}">
									${room}
								</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Choose Room:
							</span>
						</td>
						<td>
							<select id="roomNumberAddSelect" name="roomNumber" class="select2" style="width:140px">
								<option value="0">
									New Room
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Phone:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.mobile" type="text">
						</td>
						<td>
							<span>
								Email:
							</span>
						</td>
						<td>
							<input class="form-control" name="customer.email" type="text">
						</td>
					</tr>
					<tr>
						<td>
							Ticket Type:	
						</td>
						<td>
							<select name="ticketType" class="select2" style="width:140px">
								[#list constant.TICKET_TYPES as type]
								[#if type != '']
								<option value="${type}">
									${type}
								</option>
								[#else]
								<option value="">
									NONE
								</option>
								[/#if]
								[/#list]
							</select>	
						</td>
						<td>
							Voucher:
						</td>
						<td>
							<input class="form-control" name="voucherStr" type="text">
						</td>
					</tr>
					<tr>
						<td>
							Address:
						</td>
						<td>
							<input class="form-control" name="customer.streetAddress" type="text">
						</td>
						<td>
							Zip Code
						</td>
						<td>
							<input type="hidden" id="zipId" name="customer.zip" style="width:100%;"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Remark:
							</span>
						</td>
						<td>
							<select id="remarkSelect" name="customer.memoOfCustomer" class="select2" style="width:140px;">
								<option value="0">
									--Select--
								</option>
								[#list constant.CUSTOMER_MEMOS as memoOfCustomer]
								<option value="${memoOfCustomer}">
									${memoOfCustomer}
								</option>
								[/#list]
							</select>
						</td>
						<td>
						</td>
						<td>
						</td>
					</tr>
				</tbody>
			</table>
        </div>
      </div>
      <div class="modal-footer">
      	<span class='pull-left' id="modalId" style="color:red"></span>
		<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		<button type="reset" onclick="initCustomerForm();" class="btn btn-default">Reset</button>
		<button type="button" onclick="saveCustomer(this);" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
	  </div>
	</form>
    </div>
</div>
<div class="md-modal colored-header custom-width md-effect-9" id="customerSelectForm" style="width:80%;">
    <div class="md-content" >
      <div class="modal-header">
      	<h3>Selcet Customer</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      
      <div class="modal-body" width="100%">
      		<div style="border-bottom: 2px solid #ddd;margin:5 10px;">
		      	LastName:<input id="sea_lastName" name="customer.lastName"  type="text" size="14">
		      	FirstName:<input id="sea_firstName" name="customer.firstName"  type="text" size="14">
		      	MiddleName:<input id="sea_middleName" name="customer.middleName"  type="text" size="14">
		      	<button class="btn btn-primary" id="s_cus">Search</button>
	      	</div>
			<form id="selectCustomerForm" action="addCustomerForSelection.jhtml" method="post">
				 <table  class="table table-bordered dataTable no-footer" id="datatable" style="margin-top:20px;">
				 	<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
		              <thead>
		                  <tr>
		                  	   <th width="5%"><input id="allCheck" onclick="check(this);" type="checkbox" disabled="disabled"></th>
		                       <th width="15%">LastName</th>
		                       <th width="15%">FirstName</th>
		                       <th width="15%">MiddleName</th>
		                       <th width="15%">Birthday</th>
		                       <th width="15%">Nationality</th>
		                       <th width="15%">Pax No.</th>
		                    </tr>
		               </thead>
		          </table>
	        </form>
      </div>
      <div class="modal-footer">
		   <button class="btn btn-default btn-flat md-close" data-dismiss="modal" type="button">Cancel</button>
		   <button class="btn btn-primary btn-flat md-close" data-dismiss="modal" type="button" id="selectCustomerForAddButton">Ok</button>
	  </div>
    </div>
</div>
<!--导入客人-->

<div class="md-modal colored-header custom-width md-effect-9" id="customerImportForm" style="width:40%;">
    <div class="md-content" >
      <div class="modal-header">
      	<h3>Import Customer</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>&nbsp;&nbsp;
        <a href="download.jhtml" ><i class="fa fa-download"></i></a>
      </div>
      <div class="modal-body" width="100%">
			<form id="importCustomerForm" action="importCustomer.jhtml" enctype="multipart/form-data"  method="post">
				 <input type="hidden" name="ordersTotalId" value="${ordersTotal.ordersTotalId}"/>
				 <input id="file" type="file" name="file" />
	        </form>
      </div>
      <div class="modal-footer">
		   <button class="btn btn-default btn-flat md-close" data-dismiss="modal" type="button">Cancel</button>
		   <button class="btn btn-primary btn-flat md-close" type="button" id="importCustomerForAddButton">Ok</button>
	  </div>
    </div>
</div>
<div class="md-modal md-effect-1" id="customerEditForm">
    <div class="md-content">
      <div class="modal-header">
      	<span>Edit Passenger Info</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form>
      <div class="modal-body">
        <div class="text-center">
			<input id="idInput" name="id" type="hidden" />
			<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" id="ordersTotalId" />
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td>
							<span>
								Type:
							</span>
						</td>
						<td colspan="3">
							<label  id="types0" style="padding-left:0px;display:none;" >
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="0"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
							</label>
				        	<label class="radio-inline" id="types1" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Infant
							</label>
							<label style="padding-left:0px;" id="types2" class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="2" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Child without Bed
							</label>
							<label class="radio-inline" id="types3" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="3"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Child with Bed
							</label>
							<label style="padding-left:0px;" id="types4" class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.type" value="4" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Adult
							</label>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Last Name:
							</span>
						</td>
						<td width="37%"> <!--没有修改客人 权限 只有office有权限-->
							<input id="lastNameInput" class="form-control" name="customer.lastName" onkeyup="this.value = this.value.toUpperCase();" required type="text">
						</td>
						<td width="13%">
							<span>
								First Name:
							</span>
						</td>
						<td width="37%">
							<input id="firstNameInput" class="form-control" name="customer.firstName" onkeyup="this.value = this.value.toUpperCase();" required type="text">
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Middle Name:
							</span>
						</td>
						<td width="37%">
							<input id="middleNameInput" class="form-control" name="customer.middleName" onkeyup="this.value = this.value.toUpperCase();" required type="text">
						</td>
						<td>
							<span>
								Gender:
							</span>
						</td>
						<td>
							<label class="radio-inline" id="sexRadio1" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.sex" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Female&nbsp;&nbsp;
							</label>
							<label style="padding-left:0px;" id="sexRadio2" class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.sex" value="2" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Male
							</label>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Date Of Birth:
							</span>
						</td>
						<td>
							<input id="dateOfBirthInput" class="form-control date" name="customer.dateOfBirth" 
							 placeholder="YYYY-MM-DD" required="" parsley-type="dateIso" type="text" size="14"/>
						</td>
						<td>
							<span>
								Nationality:
							</span>
						</td>
						<td>
							<select id="nationalityOfPassportInput" name="customer.nationalityOfPassport" class="select2" style="width:140px">
								<option value="">--Select--</option>
								<option value="Australia">Australia</option>
			            		<option value="Canada">Canada</option>
			            		<option value="China">China</option>
			            		<option value="New Zealand">New Zealand</option>
			            		<option value="United States of America">United States of America</option>
								[#list nationality as nationa]
								<option value="${nationa.name}">
									${nationa.name}
								</option>
								[/#list]
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Passport No.:
							</span>
						</td>
						<td>
							<input id="passportNoInput" class="form-control" name="customer.passportNo" type="text">
						</td>
						<td>
							<span>
								Expiry Date:
							</span>
						</td>
						<td>
							<input id="expireDateOfPassportInput" class="form-control date" name="customer.expireDateOfPassport" type="text" size="14"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Language:
							</span>
						</td>
						<td>
							<select id="languageIdSelect" name="customer.languageId" class="select2" style="width:140px">
								<option value="0">
									--Select--
								</option>
								[#list languageList as language]
								<option value="${language.languageId}">
									${language.language}
								</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Residency:
							</span>
						</td>
						<td>
							<select id="residencyEdit" name="customer.residency" class="select2" style="width:140px;">
								<option value="Same As Nationality">Same As Nationality</option>
								<option value="Australian PR">Australia PR</option>
								<option value="New Zelend PR">New Zelend PR</option>
								<option value="USA Green Card">USA Green Card</option>
								<option value="Canada Maple Card">Canada Maple Card</option>
								<option value="European Union PR">European Union PR</option>
								<option value="Others">Others</option>
			            	</select>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Room Type:
							</span>
						</td>
						<td>
							<select id="guestRoomTypeSelect" name="guestRoomType" class="select2 guestRoomType" onchange="getEditRoommate(this.value);" style="width:140px">
								[#list constant.GUEST_ROOM_TYPES as room]
								<option value="${room}">
									${room}
								</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Choose Room:
							</span>
						</td>
						<td>
							<select id="roomNumberEditSelect" name="roomNumber" class="select2" style="width:140px">
								<option value="0">
									New Room
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Phone:
							</span>
						</td>
						<td width="37%">
							<input id="mobileInput" class="form-control" name="customer.mobile" type="text">
						</td>
						<td>
							<span>
								Email:
							</span>
						</td>
						<td>
							<input id="emailInput" class="form-control" name="customer.email" type="text">
						</td>
					</tr>
					<tr>
						<td>
							Ticket Type:	
						</td>
						<td>
							<select id="ticketTypeSelect" name="ticketType" class="select2" style="width:140px">
								[#list constant.TICKET_TYPES as type]
								[#if type != '']
								<option value="${type}">
									${type}
								</option>
								[#else]
								<option value="">
									NONE
								</option>
								[/#if]
								[/#list]
							</select>	
						</td>
						<td>
							Voucher:
						</td>
						<td>
							<input class="form-control" id="voucherStrInput" name="voucherStr" type="text">
						</td>
					</tr>
					<tr>
						<td>
							Address:
						</td>
						<td>
							<input id="streetAddressInput" class="form-control" name="customer.streetAddress" type="text">
						</td>
						<td>
							<span>
								Remark:
							</span>
						</td>
						<td>
							<select id="memoOfCustomerSelect" name="customer.memoOfCustomer" class="select2" style="width:140px;">
								<option value="0">
									--Select--
								</option>
								[#list constant.CUSTOMER_MEMOS as memoOfCustomer]
								<option value="${memoOfCustomer}">
									${memoOfCustomer}
								</option>
								[/#list]
							</select>
						</td>
						
					</tr>
				</tbody>
			</table>
        </div>
      </div>
      <div class="modal-footer">
		<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		<button type="button" onclick="updateCustomer(this);" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Modify</button>
	  </div>
	  </form>
    </div>
</div>

<div class="md-modal md-effect-1" id="incomeAddForm">
    <div class="md-content">
      <div class="modal-header">
      	<span>Add Income</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="incomeForm">
      <div class="modal-body">
        <div class="text-center">
			<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td width="13%">
							<span>
								Order No.
							</span>
						</td>
						<td width="37%">
							<select name="payRecordsList.orderId" class="select2">
								[#list childOrderList as order]
									<option value="${order.id}" >${order.orderNo}</option>
								[/#list]
							</select>
						</td>
						<td width="13%">
							<span>
								Booking No.
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="payRecordsList.code"  size="20" type="text">
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Income Date:
							</span>
						</td>
						<td>
							<div id="payTime_${payRecord_index}" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2" style="margin-bottom:0px;">
								<input class="form-control" name="payRecordsList.time" type="text" size="20" placeholder="YYYY-MM-DD">
								<span class="input-group-addon btn btn-primary">
									<span class="glyphicon glyphicon-th"></span>
								</span>
							</div>
						</td>
						<td>
							<span>
								Amount:
							</span>
						</td>
						<td>
							<input name="payRecordsList.sum" value="0" class="form-control" size="15" type="text">
							<input type="hidden" name="payRecordsList.payOrCost" value="1">
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Payment:
							</span>
						</td>
						<td>
							<select name="payRecordsList.item" class="select2">
								[#list constant.PAYMENT_ITEMS as val]
									<option value="${val}" >${val}</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Payment Method:
							</span>
						</td>
						<td>
							<select name="payRecordsList.way" class="select2">
								[#list constant.PAYMENT_WAYS as val]
									<option value="${val}">${val}</option>
								[/#list]
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Remark
							</span>
						</td>
						<td>
							<input class="form-control" name="payRecordsList.remark" size="20" type="text">
						</td>
						<td>
							<span>
							</span>
						</td>
						<td>
						</td>
					</tr>
				</tbody>
			</table>
        </div>
      </div>
      <div class="modal-footer">
		<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		<button type="reset" class="btn btn-default">Reset</button>
		<button type="button" onclick="savePayOrCost(this);" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
	  </div>
	</form>
    </div>
</div><!--/income-->
<div class="md-overlay">
</div>
<table style="display:none">
	<tr id="customerListTemplate">
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td class="text-center">
			<a class="label label-default md-trigger" title="Modify" data-modal="customerEditForm" href=""><i class="fa fa-pencil"></i></a>
		    <a title="Delete" class="label label-danger" href="#"><i class="fa fa-times"></i></a>
		</td>
	</tr>
<table>
<select id="optionCache" style="display:none">
</select>

<!-- Modal -->
<div class="modal fade" id="confirm-delete-customer" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Client Info will be cancelled?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!-- Modal -->
<div class="modal fade" id="confirm-delete-order" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Booking will be cancelled?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:50%">
    <div class="md-content">
      <div class="modal-header">
        <h3>Logo</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
	     <div class="modal-body form">
	      <form action="createInvoiceToPdf.jhtml" style="border-radius: 0px;" method="post" target="_blank">
	    		<div>
		    		<div>
		    			<label>
							<div id="checked" class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" checked="checked" name="radio" value="resources/images/nexus-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:40px;" src="[@spring.url '/resources/images/nexus-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="radio" value="resources/images/chinatour-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:50px;height:50px;" src="[@spring.url '/resources/images/chinatour-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="radio" value="resources/images/echinatours-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:40px;" src="[@spring.url '/resources/images/echinatours-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						
					</div>
					<br>
					<div>	
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="radio" value="resources/images/wenjing-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:50px;" src="[@spring.url '/resources/images/wenjing-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="radio" value="resources/images/wenjing-logo-old.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:50px;" src="[@spring.url '/resources/images/wenjing-logo-old.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="radio" value="resources/images/logo_vancouver.jpg"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:50px;" src="[@spring.url '/resources/images/logo_vancouver.jpg'/]"/> &nbsp;&nbsp;
						</label>
					</div>
					<input type="hidden" id="orderTotalId" name="totalId" value="${ordersTotal.ordersTotalId}">
					<input type="hidden" id="menuId" name="menuId" value="302">
					<input type="hidden" id="logo" name="logo">
				</div>
				<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button type="submit" id="submitButton" class="btn btn-primary btn-flat md-close" data-dismiss="modal">OK</button>
		    	</div>
	    	</form>
	    </div>
   </div>
</div>
<div class="md-overlay"></div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
	$("#credit_slider").slider().on("slide", function(e) {
		$("#credits").html("$" + e.value);
	});
	$("#rate_slider").slider().on("slide", function(e) {
		$("#rate").html(e.value + "%");
	});
</script>
<script type="text/javascript">
	Array.prototype.contains = function(element) {
	    for (var i = 0; i < this.length; i++) {
			if (this[i] === element) {
			    return true;
			}
	    }
	    return false;
	};
	
    var twinBed = '${constant.GUEST_ROOM_TYPES[0]}';
    var kingBed = '${constant.GUEST_ROOM_TYPES[1]}';
    var single = '${constant.GUEST_ROOM_TYPES[2]}';
    var extraBed = '${constant.GUEST_ROOM_TYPES[3]}';
    var suite = '${constant.GUEST_ROOM_TYPES[4]}';
    var sharingExistingBed = '${constant.GUEST_ROOM_TYPES[5]}';
    var roomMatching = '${constant.GUEST_ROOM_TYPES[6]}';
    
    $(document).ready(function(){
    	App.init();
    	if($("#uId").val()=="Yi Li"||$("#uId").val()=="yi li"){
    		$("#newBooking").show();
    	}
    	
    	[@flash_message /]
    	
    	$("#form select.select2").select2({
			width: '60%'
		});
		
		$("#customerForm select.select2").select2({
			width: '100%'
		});
		
		$("form div.datetime").datetimepicker({autoclose: true});
		
		
		$('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
   		$("#userSelect").select2({
			placeholder:"Search Agency", //文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				//url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
				url:'${base}/admin/vender/listSelect.jhtml?type=2',	//地址(type=2供应商，查找type!=2)
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
                    return {  
                         name: term   //联动查询的字符  
                     }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.venderList.length;i++){
						var vender = dataStr.venderList[i];
						 dataA.push({id: vender.venderId, text: vender.name});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/vender/listSelect.jhtml?venderId='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		//alert(JSON.stringify(data));
				    		//alert(JSON.stringify(data.venderList[0].venderId));
				    		if(data.venderList[0]==undefined){
				    			callback({id:"",text:"Search Vender"});
				    		}else{
				    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) { return m; }
		});
		
		$('#confirm-delete-customer').on('show.bs.modal', function (e) {
	        $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
	    });
	    if($("#retailWholeSale").val() == 'retail'){
	    	var $userSelect = $("#userSelect");
	    	$userSelect.select2("val", ""); 
	    	$userSelect.select2("enable", false);
	    }
	    fillSummary();

		$("#zipId").select2({
			placeholder:"Search Zip Code",//文本框的提示信息
			minimumInputLength:3,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'[@spring.url '/admin/customer/listSelect.jhtml'/]',	//地址
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
	                return {  
	                     code: term   //联动查询的字符  
	                 }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.zipList.length;i++){
						var zip = dataStr.zipList[i];
						 dataA.push({id: zip.code, text: zip.code+'<br/>'+zip.country+'  '+zip.state+'  '+zip.city});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/customer/listSelect.jhtml?id='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		if(data.zipList[0]==undefined){
				    			callback({id:"",text:"Search Zip Code"});
				    		}else{
				    			callback({id: zip.code, text: zip.code+'-'+zip.country+'-'+zip.state+'-'+zip.city});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) {
				return m; 
			}
		});
    });
    
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	
	/* 设置概要信息 */
	function fillSummary(){
		var price = 0;
		$("td.ordersCommonTourFee").each(function(){
			price += $(this).html() * 1;
		});
		$("#priceShow").val(price);
		var balance;
		if('${sumPay}' != ''){
			balance = price - ${sumPay};
		}else{
			balance = price;
		}		
		$("#balanceShow").val(balance);
		var tax=changeTwoDecimal(price*parseFloat('${childOrderList[0].rate}')/100);
		$("#rateInput").val(tax);
		$("#totalShow").val(balance + tax);
	}
    
    /* 根据retail或wholesale选择是否选同行  */
    function retailOrWholeSale(value){
    	var $companySelect = $("#userSelect");
    	
		/* 如果选择不是同行  */
    	if(value != 'wholeSale'){
    		if($companySelect.val() != ''){
	    		clearCompanyInformation();
    		}  
	    	$companySelect.select2("val", ""); 
	    	$companySelect.select2("enable", false);
	    	$(companySelect).next().val('');
    	}else{
    		$companySelect.select2("enable", true);
    	}
    }
    
    /* 根据同行下拉框的变动改变同行信息  */
    function changeCompanyValue(companySelect){
    	var companyId = $(companySelect).val();
    	if(companyId == '0'){
    		$(companySelect).next().val('');
			clearCompanyInformation();
    	}else{
    		setCompanyInformation(companyId);
    	}
    }
    
    /* 清空同行信息 */
    function clearCompanyInformation(){
	   	$("input.peer").val('');
		$("#countrySelect").removeAttr("disabled").val('0').select2({
			width: '60%'
		});
		var $stateSelect = $("#stateSelect");
		$stateSelect.val('0').select2({
			width: '60%'
		});
    	$stateSelect.children("option[value!='0']").remove();
    }
        
    /* 根据同行ID异步查找同行信息并显示  */
    function setCompanyInformation(companyId){
	    $.post("getVender.jhtml", {
            "companyId": companyId
        },
        function(company) {
        	$("input[name='company']").val(company.name);
        	$("input[name='contactName']").val(company.contactor);
        	$("input[name='tel']").val(company.tel);
        	$("input[name='email']").val(company.email);
        	$("input[name='address']").val(company.address);
        	$("input[name='postCode']").val(company.zipCode);
        	var $countrySelect = $("select[name='countryId']");
        	$countrySelect.val(company.countryId).select2({
				width: '60%'
			});
			generalStateSelect($countrySelect);
        });
    }
    
	/* 根据国家动态加载州  */
    function generalStateSelect(countrySelect) {
        var $stateSelect = $("#stateSelect");
        var countryId = $(countrySelect).val();

        $stateSelect.children("option").remove();
        $stateSelect.append("<option value='0'>Select State</option>").val("0").select2({
        	width: '60%'
        });
        if (countryId != '0') {
            $.post("states.jhtml", { 
                "countryId": countryId
            },
            function(result) {
                $.each(result,
                function(key, value) {
                    $stateSelect.append("<option value='" + key + "'>" + value + "</option>");
                });
            });
        }
    }
    
    /* 新增客人时初始化房型和房号以及reset时reset所有的select */
    function initCustomerForm(){
    	//$('#addCustomerGender').iCheck('check');
    	var $selects = $("#languageSelect,#remarkSelect");
    	$selects.val('0');
    	$selects.select2({width:'100%'});
    	var $roomSelect = $("#guestRoomTypeAddSelect");
    	$roomSelect.val($roomSelect.find("option").eq(0).val());
    	$roomSelect.select2({width:'100%'});
    	getRoommate($roomSelect.val(),$('#roomNumberAddSelect'));
    }
    
	/*  保存客人信息   */
	function saveCustomer(saveButton){
		var guestRoomType = $("#guestRoomTypeAddSelect").val();
		var roomNumber = $("#roomNumberAddSelect").val();
		if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
			alert('Extra bed can not exist without any roommate.');
			return;
		}
		var $customerForm = $(saveButton).parent().parent();
		var checkedName = false;
		if($("#languageSelect").val()=="0"){
			alert("Enter Language Please!");
			return;
		}
		$("#lastNameId").val($("#lastNameId").val().toUpperCase());
		$("#firstNameId").val($("#firstNameId").val().toUpperCase());
		$("#middleNameId").val($("#middleNameId").val().toUpperCase());
		$.ajax({
			url:'checkCustomerName.jhtml',
			data: $customerForm.serialize(),
			type:"POST",
			success:function(result){
				if(result == 'exist'){
					checkedName = confirm('该客人名称已存在，要继续保存吗?')
				}else{
					checkedName = true;
				}
				if(checkedName == true){
					$.ajax({
						url:'addCustomer.jhtml',
						data: $customerForm.serialize(),
						type:"POST",
						beforeSend:function(){
						},
						success:function(result){
							if(result == 'noOrder'){
								alert('There is no order in the total order.');
								$(saveButton).prev().click();
								return;
							}
							addCustomerList($customerForm,result);
							$(saveButton).prev().click();
							alert("New Client Added！");
						}
					});
				}
			}
		});
	} 
	
	/*  更新客人信息   */
	function updateCustomer(updateButton){
		var guestRoomType = $("#guestRoomTypeSelect").val();
		var roomNumber = $("#roomNumberEditSelect").val();
		if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
			alert('Extra bed can not exist without any roommate.');
			return;
		}	
		var $customerForm = $(updateButton).parent().parent();
		$.ajax({
			url:'updateCustomer.jhtml',
			data: $customerForm.serialize(),
			type:"POST",
			beforeSend:function(){
			},
			success:function(){
				updateCustomerList($customerForm);
				$(updateButton).prev().click();
				alert("Client Info. Updated！");
			}
		});
	}
	
	/* 向客人列表增加一条记录  */
	function addCustomerList($customerForm,customerOrderRelId){
		var $customerListTr = $("#customerListTemplate").clone(true).removeAttr("id").attr("id",customerOrderRelId);
		setValue($customerListTr,$customerForm,customerOrderRelId,1);
		$("#customerList").append($customerListTr);
	}
	
	/* 对客人列表更新客人变更后的值   */
	function updateCustomerList($customerForm){
		var customerOrderRelId = $('#idInput').val();
		setValue($("#" + customerOrderRelId),$customerForm,customerOrderRelId,0);
	}
	
	/* 给列表设置值  */
	function setValue($customerListTr,$customerForm,customerOrderRelId,isAddCustomer){
		var $tds = $customerListTr.find("td");
		$tds.eq(0).html($customerForm.find("input[name='customer.lastName']").val() + '/' + $customerForm.find("input[name='customer.firstName']").val()+ ' ' + $customerForm.find("input[name='customer.middleName']").val());
		sexStr='';
		if($customerForm.find("input[name='customer.sex']:checked").val()==1){
			sexStr='F';
		}else if($customerForm.find("input[name='customer.sex']:checked").val()==2){
			sexStr='M';
		}
		$tds.eq(1).html(sexStr);
		$tds.eq(2).html($customerForm.find("select[name='customer.nationalityOfPassport']").val());
		$tds.eq(3).html($customerForm.find("select[name='customer.residency']").val());
		$tds.eq(4).html($customerForm.find("input[name='customer.dateOfBirth']").val());
		$tds.eq(5).html($customerForm.find("input[name='customer.passportNo']").val());
		$tds.eq(6).html($customerForm.find("input[name='customer.expireDateOfPassport']").val());
		$tds.eq(7).html($customerForm.find("select[name='guestRoomType']").val());
		if(isAddCustomer == 1){
			$tds.eq(8).html('');
		}
		var $a = $tds.eq(9).find("a");
		$a.eq(0).attr("href","javascript:editCustomer('" + customerOrderRelId + "');");
		$a.eq(1).attr("href","javascript:deleteCustomer('" + customerOrderRelId + "_Button','" + customerOrderRelId + "');");
		$a.eq(1).attr("id",customerOrderRelId + "_Button");
	}
	
	/* 编辑客人信息  */
	function editCustomer(customerOrderRelId){
		$.post("loadCustomer.jhtml",{"id":customerOrderRelId},function(customerOrderRel){
			$("#idInput").val(customerOrderRelId);
			$("#lastNameInput").val(customerOrderRel.customer.lastName);	
			$("#firstNameInput").val(customerOrderRel.customer.firstName);
			$("#middleNameInput").val(customerOrderRel.customer.middleName);	
			$("#dateOfBirthInput").val(customerOrderRel.customer.dateOfBirth);	
			$("#sexRadio" + customerOrderRel.customer.sex).click();
			$("#types" + customerOrderRel.customer.type).click();
			$("#nationalityOfPassportInput").val(customerOrderRel.customer.nationalityOfPassport).select2({
				width:'100%'
			});		
			$("#passportNoInput").val(customerOrderRel.customer.passportNo);	
			$("#expireDateOfPassportInput").val(customerOrderRel.customer.expireDateOfPassport);	
			$("#languageIdSelect").val(customerOrderRel.customer.languageId).select2({
				width:'100%'
			});	
			$("#memoOfCustomerSelect").val(customerOrderRel.customer.memoOfCustomer).select2({
				width:'100%'
			});	
			$("#residencyEdit").val(customerOrderRel.customer.residency).select2({
				width:'100%'
			});	
			$("#mobileInput").val(customerOrderRel.customer.mobile);	
			$("#emailInput").val(customerOrderRel.customer.email);
			$("#ticketTypeSelect").val(customerOrderRel.ticketType).select2({
				width:'100%'
			});	
			$("#voucherStrInput").val(customerOrderRel.voucherStr);
			$("#streetAddressInput").val(customerOrderRel.customer.streetAddress);
			$("#guestRoomTypeSelect").val(customerOrderRel.guestRoomType).select2({
				width:'100%'
			});
			getRoomNumberOptionsAndSetValue(customerOrderRel);
		});
	}
	
	/*  异步获取可选的客人,并根据值显示选中  */
	function getRoomNumberOptionsAndSetValue(customerOrderRel){
		var $roomNumberSelect = $("#roomNumberEditSelect");
		var roomNum = customerOrderRel.roomNumber;
		var roomType = customerOrderRel.guestRoomType;
		$roomNumberSelect.find("option").remove();
		
		if(roomType == single || roomType == sharingExistingBed || roomType == roomMatching){
		//如果客人的房型是单间或不占床以及拼房
			/* 显示New Room或No Room,并将选项值设置为房间号  */
			if(roomType == sharingExistingBed){
				$roomNumberSelect.append("<option value='" + roomNum + "'>No Room</option>");
			}else{
				$roomNumberSelect.append("<option value='" + roomNum + "'>New Room</option>");
			}
			$roomNumberSelect.val(roomNum).select2({ width:'100%' });
		}else if(roomType == twinBed || roomType == kingBed){
		//如果客人的房型是标间或大床房
			if(customerOrderRel.roomIsFull == 0){
				$roomNumberSelect.append("<option value='"+ roomNum +"'>New Room</option>");
			}else{
				$roomNumberSelect.append("<option value='0'>New Room</option>");
			}
			var append;
			$.post("getRoommatesWithRoomNumber.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}","roomNumber":roomNum},function(result){
				$.each(result,function(i,cusorel){
					if(cusorel.id != customerOrderRel.id){
						append = '<option value="' + cusorel.roomNumber + '">' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName + '</option>';
						$roomNumberSelect.append(append);
					}
				});
				$roomNumberSelect.val(roomNum).select2({ width:'100%' });
			});
		}else{
		//如果客人的房型是加床或套房
			if(roomType == suite){
				$roomNumberSelect.append("<option value='0'>New Room</option>");
			}
			var roomNumbers = new Array();
			var index = 0;
			$.post("getRoommatesWithRoomNumber.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}","roomNumber":roomNum},function(result){
				$.each(result,function(i,cusorel){
					if(cusorel.id != customerOrderRel.id){
						if(roomNumbers.contains(cusorel.roomNumber)){
							var $existOption = $roomNumberSelect.find("option[value="+ cusorel.roomNumber +"]");
							$existOption.html($existOption.html() + '/' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName);
						}else{
							roomNumbers[index++] = cusorel.roomNumber;
							append = '<option value="' + cusorel.roomNumber + '">' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName + '</option>';
						 	$roomNumberSelect.append(append);
						}
					}
				});
				if($roomNumberSelect.find("option[value="+ roomNum +"]").size() == 0){
					$roomNumberSelect.find("option[value='0']").val(roomNum);
				}
				$roomNumberSelect.val(roomNum).select2({ width:'100%' });
			});
		}
		$roomNumberSelect.attr("first","true");
		$roomNumberSelect.attr("roomType",roomType);
		$roomNumberSelect.attr("roomNumber",roomNum);
		$("#optionCache").find("option").remove();
	}
	
	/* 修改客人时根据房型变更可选的房间  */
	function getEditRoommate(roomType){
		var $roomNumberSelect = $("#roomNumberEditSelect");
		
		if($roomNumberSelect.attr("first")){
		/* 如果是第一次变动，将options缓存起来  */
			$roomNumberSelect.removeAttr("first");
			$roomNumberSelect.find("option").appendTo($("#optionCache"));
			
			getRoommate(roomType,$roomNumberSelect);
		}else{
			if($roomNumberSelect.attr("roomType") == roomType){
			/* 如果返回原始自带的房型，从缓存中拿出，选择好  */
				$roomNumberSelect.find("option").remove();
				$roomNumberSelect.append($("#optionCache").find("option").clone(true));
				$roomNumberSelect.val($roomNumberSelect.attr("roomNumber")).select2({ width:'100%' });
			}else{
				getRoommate(roomType,$roomNumberSelect);
			}
		}
	}
	
	/* 新增客人时根据房型变更可选的房间  */
	function getRoommate(roomType,$roomNumberSelect){
		$roomNumberSelect.find("option").remove();
		if(roomType == sharingExistingBed){
			$roomNumberSelect.append('<option value="0">No Room</option>');
		}else{
			$roomNumberSelect.append('<option value="0">New Room</option>');
		}
		$roomNumberSelect.val('0').select2({ width: '100%'});
		getRoomNumberOptions($roomNumberSelect,roomType);
	}
	
	/* 在房型不是Sharing Existing Bed(不占床),Single(单人间)以及Room Matching(拼房)的情况下异步获取可以组的房间  */
	function getRoomNumberOptions($roomNumberSelect,roomType){
		if(roomType != single && roomType != roomMatching && roomType != sharingExistingBed){
			$.post("getRoommates.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}"},function(result){
				var append;
				var roomNumbers = new Array();
				var index = 0;
				$.each(result,function(i,customerOrderRel){
					if(roomType == extraBed && customerOrderRel.roomNumber == $roomNumberSelect.attr("roomNumber")){
						return ;
					}
					if(roomNumbers.contains(customerOrderRel.roomNumber)){
						var $existOption = $roomNumberSelect.find("option[value="+ customerOrderRel.roomNumber +"]");
						$existOption.html($existOption.html() + '/' + customerOrderRel.customer.lastName + ' ' + customerOrderRel.customer.firstName);
					}else{
						roomNumbers[index++] = customerOrderRel.roomNumber;
						append = '<option value="' + customerOrderRel.roomNumber + '">' + customerOrderRel.customer.lastName + ' ' + customerOrderRel.customer.firstName + '</option>';
					 	$roomNumberSelect.append(append);
					}
				});
			});
		}
	}
	
	/* 异步修改订单信息  */
	function updateOrdersTotal(){
		if($("#retailWholeSale").val() != 'retail'){
    		if($("#userSelect").val() == ''){
    			alert('Please select agency.');
    			return;
    		}
    	}
		$.ajax({
			url:'updateOrdersTotal.jhtml',
			data: $("#form").serialize(),
			type:"POST",
			beforeSend:function(){
			},
			success:function(result){
				if(result == 'success'){
					alert("Update completed");
				}
			}
		});
	}
	
	/* 删除客人  */
	function deleteCustomer(buttonId, customerOrderRelId){
		$.post("deleteCustomer.jhtml",{"customerOrderRelId" : customerOrderRelId},function(result){
			if(result == 'success' || result == 'all'){
				var $a = $("#" + buttonId);
				$a.attr("href","javascript:recoverCustomer('"+ buttonId +"','"+ customerOrderRelId +"');");
				$a.parent().parent().css('background-color','#DFDFDF');
				$a.parent().prev().html('<span class="color-danger">Cancelled</span>');
				$a.find("i").removeClass("fa fa-times").addClass("fa fa-mail-reply");
				alert('Client Info. Cancelled！');
				if(result == 'all'){
					window.location.reload(true);   
				}
			}
		}); 
	}
	
	/* 恢复客人  */
	function recoverCustomer(buttonId, customerOrderRelId){
		$.post("recoverCustomer.jhtml",{"customerOrderRelId" : customerOrderRelId},function(result){
			if(result == 'success' || result == 'all'){
				var $a = $("#" + buttonId);
				$a.attr("href","javascript:deleteCustomer('"+ buttonId +"','"+ customerOrderRelId +"');");
				$a.parent().prev().html('');
				$a.find("i").removeClass("fa fa-mail-reply").addClass("fa fa-times"); 
				alert('Client Info. Recoverd！');
				if(result == 'all'){
					window.location.reload(true);   
				}
			}
		}); 
	}
	
	/* 取消订单  */
	function cancelOrder(buttonId, orderId, tourId){
		$.post("asynchronousCancelOrder.jhtml",{"orderId" : orderId},function(result){
			if(result == 'success' || result == 'all'){
				var $a = $("#" + buttonId);
				var $buttonLi = $a.parent();
				var $stateTd = $buttonLi.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev();
				if(tourId == ''){
				//如果订单未组团
					$a.attr("href","javascript:recoverOrder('"+ buttonId +"','"+ orderId +"','" + tourId +"');");
					$a.html("<i class='fa fa-mail-reply'></i>Recover");
					$stateTd.html("<span class='color-danger'>CANCELLED</span>");
					alert('Cancel Booking completed!');
				}else{
				//如果订单已组团
					$buttonLi.prev().remove();					
					$buttonLi.remove();
					$stateTd.html("<span class='color-warning'>CANCELLING</span>");
					alert('Cancelling Booking!');
				}
				window.location.reload(true);  
			}
		}); 
	}
	
	/* 恢复订单  */
	function recoverOrder(buttonId, orderId, tourId){
		$.post("asynchronousRecoverOrder.jhtml",{"orderId" : orderId},function(result){
			if(result == 'success' || result == 'all'){
				var $a = $("#" + buttonId);
				var $buttonLi = $a.parent();
				var $stateTd = $buttonLi.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev();
				if(tourId == ''){
				//如果订单未组团
					$a.attr("href","javascript:cancelOrder('"+ buttonId +"','"+ orderId +"','" + tourId +"');");
					$a.html("<i class='fa fa-times'></i>Cancel");
					$stateTd.html("<span class='color-warning'>NEW</span>");
					alert('Recoverd Booking completed!');
				}else{
				//如果订单已组团
					$buttonLi.prev().remove();					
					$buttonLi.remove();
					$stateTd.html("<span class='color-warning'>RECOVERING</span>");
					alert('Recovering Booking!');						
				}
				window.location.reload(true);  
			}
		}); 
	}
	
	/* 添加非团产品  */
	function otherBooking(){
		var customerSize = $("#customerList tr").size();
		if(customerSize == 0){
			alert('Please add customer to order first.');
			return;
		}
		window.location.href="supplierBooking.jhtml?ordersTotalId=${ordersTotal.ordersTotalId}";
	}
	
	/* 添加团产品  */
	function tourBooking(){
		var customerSize = $("#customerList tr").size(); 
		if(customerSize == 0){
			alert('Please add customer to order first.');
			return;
		}
		window.location.href="tourBooking.jhtml?ordersTotalId=${ordersTotal.ordersTotalId}";
	}
	/* 添加团产品  */
	function tourBookingT(){
		var customerSize = $("#customerList tr").size(); 
		if(customerSize == 0){
			alert('Please add customer to order first.');
			return;
		}
		window.location.href="tourBookingT.jhtml?ordersTotalId=${ordersTotal.ordersTotalId}";
	}
	
	/* invoice */
	function generateInvoice(){
		$("#alertFormButton").click();
	}
	
	/*结算*/
	function settlement(){
		window.location.href="${base}/admin/payCostRecords/agentSettlementOrdersTotal.jhtml?menuId=307&ordersTotalId=${ordersTotal.ordersTotalId}&userId=${ordersTotal.userId}";
	}
	
	$('input.date').datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '1910:2050' });
	
	$("#subId").on( 'click', function () {
		$('#datatable2').DataTable().draw();
	});
		
	var obj={
	 	colorSpan:"",
	};
	
	function change(span,value)
	{
		//给所以span的属性初始化
	    $('span[name="'+$(span).attr('name')+'"]').each(function(){
	             if(this.checked&&this!=span)
	          {
	                this.className="unchecked";
	                this.checked=false;
	          }               
	    });
	    //判断是否有选中   是 初始化取消加粗   否加粗
	  	if(span.checked&&span.className=="checked"){
		    span.className="unchecked";
		    span.checked=false;
		    $("#"+$(span).attr('name')+"").val("");
	  	}else{
	  		obj[$(span).attr('name')]=span.innerHTML;
		    span.className="checked";
		    span.checked=true;
		    $("#"+$(span).attr('name')+"").val(value);
	  	}
	}
	
	/*    */
	function ulId(num){
		$("#ulId"+num).toggle();
	}
	
	//异步判断op是否已经修改invoice，如果修改则可查看

	function isChanged(id){
    	//var id = $("#valueOfOrderId").val();
    	$.post("isReview.jhtml?id="+id,function(map){
    		if(map.ok=="ok"){
    			window.location.href="${base}/admin/orders/orderReview.jhtml?id="+id+"&menuId=302";
    		}else{
    			window.location.href="${base}/admin/orders/createOldPdf.jhtml?id="+id+"&menuId=302";
    		}
    	});
    }
    
    $("#submitButton").click(function(){
    	var str = $('input[name="radio"]:checked').val();
    	$("#logo").attr("value",str);
    	//alert(str);
    });
    
	/*  保存收入/支出信息   */
	function savePayOrCost(saveButton){
		var $payOrCostForm = $(saveButton).parent().parent();
		$.ajax({
			url:'addCustomer.jhtml',
			data: $payOrCostForm.serialize(),
			type:"POST",
			beforeSend:function(){
			},
			success:function(customerOrderRelId){
				addCustomerList($customerForm,customerOrderRelId);
				$(saveButton).prev().click();
				alert("New Client Added！");
			}
		});
	} 
	
	/**
	function savePayOrCost(saveButton){
		var $payOrCostForm = $(saveButton).parent().parent();
		$.ajax({
			url:'addPayCost.jhtml',
			data: $payOrCostForm.serialize(),
			type:"POST",
			success:function(id){
				addPayOrCostList($payOrCostForm,customerOrderRelId);
				$(saveButton).prev().click();
				alert("New Client Added！");
			}
		});
	}
	 
	function addPayOrCostList($payOrCostForm,customerOrderRelId){
		var $payOrCostListTr = $("#payOrCostTemplate").clone(true).removeAttr("id").attr("id",id);
		setPayOrCost($payOrCostListTr,$payOrCostForm,id);
		$("#customerList").append($customerListTr);
	}
	
	function setPayOrCost($payOrCostListTr,$payOrCostForm,id){
		var $tds = $payOrCostListTr.find("td");
		$tds.eq(0).html($payOrCostForm.find("input[name='payRecordsList.orderId']:checked").text());
		$tds.eq(1).html($payOrCostForm.find("input[name='payRecordsList.code']:checked").val() == '1' ? 'F':'M');
		$tds.eq(2).html($payOrCostForm.find("input[name='customer.nationalityOfPassport']").val());
		$tds.eq(3).html($payOrCostForm.find("input[name='customer.dateOfBirth']").val());
		$tds.eq(4).html($payOrCostForm.find("input[name='customer.passportNo']").val());
		$tds.eq(5).html($payOrCostForm.find("input[name='customer.expireDateOfPassport']").val());
		$tds.eq(6).html($payOrCostForm.find("select[name='guestRoomType']").val());
	}
	
	$("#incomeForm select.select2").select2({
		width: '100%'
	});
	*/
	
	//备选客人列表
    $("#selectCustomerButton").click(function(){
	 $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "bLengthChange":false,
            "bDestroy":true,
            "aLengthMenu":[10,20,50,100],
            "ajax": {
                url: "[@spring.url '/admin/customer/list.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.lastName = $("#sea_lastName").val();
					data.middleName = $("#sea_middleName").val();
					data.firstName = $("#sea_firstName").val();
					//data.passportNo = $("#sea_passportNo").val();
				}
            },
            "columns": [
         	    { "data": "customerId",
                  "render": function (data, type, row) {
	                       return '<input class="customerCheckbox" name="customerIds" value="'+ data +'" type="checkbox">';
                   }
                 },
				{ "data": "lastName" },
				{ "data": "firstName" },
				{ "data": "middleName" },
				{ "data": "dateOfBirth" },
				{ "data": "nationalityOfPassport" },
				{ "data": "passportNo" }
            ]
        });
    })
    
    $("#s_cus").on( 'click', function () {
        $('#datatable').DataTable().draw();
    });
    
    $("#selectCustomerForAddButton").click(function(){
    	var length = $(".customerCheckbox:checked").size();
		if(length == 0){
			alert("Select Customer");
			return;
		}
    	$("#selectCustomerForm").submit();
    });
    
    $("#importCustomerForAddButton").click(function(){
    	$("#importCustomerForm").submit();
    });
    function customerListen(){
    	var lastName=$("#lastNameId").val().trim();
		var firstName=$("#firstNameId").val();
		var passportNo=$("#passportNoId").val();
		$.ajax({
			type: "POST",
			url: "[@spring.url '/admin/customer/findCustomerTourInfo.jhtml'/]",
			data:"lastName="+lastName+"&firstName="+firstName+"&passportNo="+passportNo,
			success: function(msg){
				 $("#modalId").html("");
				 if(msg!=null&&msg.customer!=null&&msg.customer.customerId!=null){
				 	 html="<span class='pull-left' >The Passenger Repetition <a href='${base}/admin/customer/orderByCusId?id="+msg.customer.customerId+"' >&nbsp;&nbsp;&nbsp;Detail</a></span>"
	  				 $("#modalId").html(html); 
				}
			 }
		});
    }
    /*同行申请支付*/
    function agencyPay(orderId,state){
    	$.post("agencyPay.jhtml",{"orderId" : orderId,"state":state},function(result){
			if(result == 'success'){
				$("#"+orderId+"pay").html('<i title="Approving" class="fa fa-clock-o"></i>');
	    		alert("success");
			}
		}); 
    }
    
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
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
