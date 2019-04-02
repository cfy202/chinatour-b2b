[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"]/]
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
			<h2>Edit</h2>
			<ol class="breadcrumb">
				<li>
					<a style="cursor:pointer;" href="../../">Home</a>
				</li>
				<li>
					<a style="cursor:pointer;" href="">Booking</a>
				</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row wizard-row">
				<div class="col-md-12 fuelux">
					<div class="block-wizard">
						<div id="wizard1" class="wizard wizard-ux">
							<ul class="steps">
								<li data-target="#step1" class="active">
									客人信息
									<span class="chevron"></span>
								</li>
								<li data-target="#step2">
									费用信息
									<span class="chevron"></span>
								</li>
								<li data-target="#step3">
									参团信息
									<span class="chevron"></span>
								</li>
							</ul>
							<div class="actions">
								<button type="button" class="btn btn-xs btn-prev btn-default">
									<i class="icon-arrow-left"></i>
									Prev
								</button>
								<button type="button" class="btn btn-xs btn-next btn-default" data-last="Finish">
									Next
									<i class="icon-arrow-right"></i>
								</button>
							</div>
						</div>
						<div class="step-content">
							<form class="form-horizontal group-border-dashed" action="${base}/admin/orders/update.jhtml" method="POST"
								data-parsley-namespace="data-parsley-" data-parsley-validate novalidate>
								<div class="step-pane active" id="step1">
									<div class="bars">
										<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
											<i class="fa fa-bars">客人信息</i>
											<span></span>
											<div class="pull-right">
								               <i class="fa fa-angle-down"></i>&nbsp;&nbsp;
								           </div>
								        </h4>
									</div>
									<div style="display:none">
									    [#list tourOrdersVO.customerList as customer]
										<div class="customerInfo">
											<div>
												<h5>No.${customer_index + 1}</h5>
											</div>
											<div style="border: solid 1px #ccc; margin: 0 0 8px 0;"></div>
											<table width="100%">
												<tbody>
													<tr>
														<td width="13%">
															<span>LastName:</span>
														</td>
														<td width="37%">
															<input class="form-control input-group1" name="customerList[${customer_index}].lastName" value="${customer.lastName}" type="text">
														</td>
														<td width="13%">
															<span>FirstName:</span>
														</td>
														<td width="37%">
															<input class="form-control input-group1" name="customerList[${customer_index}].firstName" value="${customer.firstName}" type="text">
														</td>
													</tr>
													<tr>
														<td>
															<span>MiddleName:</span>
														</td>
														<td>
														    <input class="form-control input-group1" name="customerList[${customer_index}].middleName" value="${customer.middleName}" type="text">
														</td>
														<td>
															<span>出生日期:</span>
														</td>
														<td>
															<span>
																<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
																	<input type="text" readonly="readonly" class="form-control" name="customerList[${customer_index}].dateOfBirth" 
																	[#if (customer.dateOfBirth)??]value="${customer.dateOfBirth?string('yyyy-MM-dd')}"[/#if]>
																	<span class="input-group-addon btn btn-primary">
																		<span class="glyphicon glyphicon-th">
																		</span>
																	</span>
																</div>
															</span>
														</td>
													</tr>
													<tr>
														<td>
															<span>护照国籍:</span>
														</td>
														<td>
															<input class="form-control input-group1" name="customerList[${customer_index}].nationalityOfPassport" value="${customer.nationalityOfPassport}" type="text">
														</td>
														<td>
															<span>护照号码:</span>
														</td>
														<td>
															<input class="form-control input-group1" name="customerList[${customer_index}].passportNo" value="${customer.passportNo}" type="text">
														</td>
													</tr>
													<tr>
														<td>
															<span>护照有效期:</span>
														</td>
														<td>
															<span>
																<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
																	<input type="text" readonly="readonly" class="form-control" name="customerList[${customer_index}].expireDateOfPassport"
																	[#if (customer.expireDateOfPassport)??]value="${customer.expireDateOfPassport?string('yyyy-MM-dd')}"[/#if]>
																	<span class="input-group-addon btn btn-primary">
																		<span class="glyphicon glyphicon-th">
																		</span>
																	</span>
																</div> 
															</span>
														</td>
														<td>
															<span>性别:</span>
														</td>
														<td>
															<div>
																<label id="sex_${customer_index}_1" class="radio-inline">
																	<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																		<input class="icheck" type="radio" name="customerList[${customer_index}].sex" value="1" checked="" style="position: absolute; opacity: 0;">
																			<ins class="iCheck-helper"
																				style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																			</ins>
																	</div>
																	男
																</label>
																<label id="sex_${customer_index}_2" class="radio-inline">
																	<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																		<input class="icheck" type="radio" name="customerList[${customer_index}].sex" value="2" checked="" style="position: absolute; opacity: 0;">
																			<ins class="iCheck-helper"
																				style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																			</ins>
																	</div>
																	女
																</label>
															</div>
														</td>
													</tr>
													<tr>
														<td>
															<span> 客人备注: </span>
														</td>
														<td>
															<select name="customerList[${customer_index}].memoOfCustomer" class="select2" style="width:140px;">
																<option value="0">
																	--请选择--
																</option>
																[#list constant.CUSTOMER_MEMOS as memoOfCustomer]
																<option value="${memoOfCustomer}" [#if memoOfCustomer == customer.memoOfCustomer]selected="selected"[/#if]>
																	${memoOfCustomer}
																</option>
																[/#list]
															</select>
														</td>
														<td>
															<span>语种:</span>
														</td>
														<td>
															<select name="customerList[${customer_index}].languageId" class="select2" style="width:140px">
																<option value="0">
																	--请选择--
																</option>
																[#list languageList as language]
																<option value="${language.languageId}" [#if customer.languageId==language.languageId]selected="selected"[/#if]>
																	${language.language}
																</option>
																[/#list]
															</select>
														</td>
													</tr>
													<tr>
														<td>
															<span>房型:</span>
														</td>
														<td>
															<span> 
																<select name="customerList[${customer_index}].guestRoomType" class="select2" style="width:140px">
																	<option value="0">
																		--请选择--
																	</option>
																	[#list constant.GUEST_ROOM_TYPES as room]
																	<option value="${room}" [#if customer.guestRoomType==room]selected="selected"[/#if]>
																		${room}
																	</option>
																	[/#list]
																</select>
															</span>
														</td>
														<td width="13%">
															<span> 手机号码: </span>
														</td>
														<td width="37%">
															<input class="form-control input-group1" name="customerList[${customer_index}].mobile" value="${customer.mobile}" type="text">
														</td>
													</tr>
													<tr>
														<td>
															<span> 邮箱: </span>
														</td>
														<td>
															<input class="form-control input-group1" name="customerList[${customer_index}].email" value="${customer.email}" type="text">
														</td>
														<td>
															<span> 联系地址: </span>
														</td>
														<td>
															<input class="form-control input-group1" name="customerList[${customer_index}].streetAddress" value="${customer.streetAddress}" type="text">
														</td>
													</tr>
													[#assign customerFlights = tourOrdersVO.eachGroupLineOrderList[0].customerFlightList[customer_index]]
													<tr>
														<td colspan="4">
															<div><h6>入境航班:</h6></div>
														</td>
													</tr>
													<tr>
														<td>
															<span> 航空公司代码: </span>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].flightCode"
																value="${customerFlights[0].flightCode}" type="text">
														</td>
														<td>
															<span>航班号:</span>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].flightNumber"
																value="${customerFlights[0].flightNumber}" type="text">
														</td>
													</tr>
													<tr>
														<td>
															<span> 抵达日期: </span>
														</td>
														<td>
															<div>
																<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
																	<input type="text" readonly="readonly" class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].arriveDate" 
																	[#if (customerFlights[0].arriveDate)??]value="${customerFlights[0].arriveDate?string('yyyy-MM-dd')}"[/#if] size="16">
																	<span class="input-group-addon btn btn-primary">
																		<span class="glyphicon glyphicon-th"></span>
																	</span>
															    </div>
															</div>
														</td>
														<td>
															<span> 抵达时间: </span>
														</td>
														<td>
										                    <input class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].arriveTime" size="16" type="text" 
																value="${customerFlights[0].arriveTime}"/>
														</td>
													</tr>
													<tr>
														<td>
															<span>接机:</span>
														</td>
														<td>
															<label class="radio-inline">
																<div id="ifPickUp_${customer_index}_1" class="iradio_square-blue"
																	style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].ifPickUp"
																		value="1" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																是 &nbsp; &nbsp;
															</label>
															<label class="radio-inline">
																<div id="ifPickUp_${customer_index}_2" class="iradio_square-blue"
																	style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].ifPickUp"
																		value="2" checked="" style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																否
															</label>
														</td>
														<td style="display: none"></td>
														<td style="display: none"></td>
														<input type="hidden" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].id" value="${customerFlights[0].id}">
													</tr>
													<tr>
														<td colspan="4">
															<div><h6>出境航班:</h6></div>
														</td>
													</tr>
													<tr>
														<td colspan="">
															<span> 航空公司代码: </span>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].flightCode"
																value="${customerFlights[1].flightCode}" type="text">
														</td>
														<td>
															<span> 航班号: </span>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].flightNumber"
																value="${customerFlights[1].flightNumber}" type="text">
														</td>
													</tr>
													<tr>
														<td>
															<span>出境日期:</span>
														</td>
														<td>
															<div>
																<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
																	<input type="text" readonly="readonly" class="form-control" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].arriveDate" 
																	[#if (customerFlights[1].arriveDate)??]value="${customerFlights[1].arriveDate?string('yyyy-MM-dd')}"[/#if] size="16">
																	<span class="input-group-addon btn btn-primary">
																		<span class="glyphicon glyphicon-th"></span>
																	</span>
																</div>
															</div>
														</td>
														<td>
															<span> 起飞时间: </span>
														</td>
														<td>
										                    <input class="form-control input-group1" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].arriveTime" size="16" type="text" 
														    value="${customerFlights[1].arriveTime}" />
														</td>
													</tr>
													<tr>
														<td>
															<span> 送机: </span>
														</td>
														<td>
															<label id="ifSendUp_${customer_index}_1" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].ifSendUp"
																		value="1" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																是 &nbsp; &nbsp;
															</label>
															<label id="ifSendUp_${customer_index}_2" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].ifSendUp"
																		value="2" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																否
															</label>
														</td>
														<td></td>
														<td></td>
														<input type="hidden" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].id" value="${customerFlights[1].id}">
													</tr>
													<tr>
														<td style="display: none"></td>
														<td style="display: none"></td>
														<td style="display: none"></td>
														<td style="display: none"></td>
													</tr>
												</tbody>
											</table>
											<input name="customerList[${customer_index}].customerId" type="hidden" value="${customer.customerId}">
										</div>
										[/#list]
									</div>
									<h4 style="background:#FDA445;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
										<i class="fa fa-mobile"></i>
										<span >联系方式</span>
							        </h4>
									<div style="width: auto; height: auto; margin: 20px 0 0 0; padding: 8px;">
										<table style="word-break: break-all; white-space: nowrap;" width="100%">
											<tbody>
												<tr>
													<td width="13%">
														<span>电话:</span>
													</td>
													<td width="37%">
										                <div class="col-sm">
										                  <input type="text" name="shareCustomer.tel" value="${tourOrdersVO.customerList[0].tel}" class="form-control input-group1"/>
										                </div>
													</td>
													<td>
														<span>邮编:</span>
													</td>
													<td>
													  	<div class="col-sm">
										                  <input type="text" name="shareCustomer.zip" value="${tourOrdersVO.customerList[0].zip}" class="form-control input-group1"/>
										                </div>
													</td>
												</tr>
												<tr>
													<td>
														<span>国家: </span>
													</td>
													<td>
														<select name="shareCustomer.countryId" id="country" onchange="generalStateSelect(this);" class="select2" style="width: 148px;">
															<option value="0">--请选择--</option>
															[#list countryList as country]
																<option value="${country.id}" [#if tourOrdersVO.customerList[0].countryId==country.id]selected="selected"[/#if]>${country.countryName}</option>
															[/#list]
														</select>
													</td>
													<td>
														<span>州:</span>
													</td>
													<td colspan="3">
														<select name="shareCustomer.stateId" id="state" class="select2" style="width: 148px;">
															<option value="0">--请选择--</option>
															[#list stateList as state]
																<option value="${state.id}" [#if tourOrdersVO.customerList[0].stateId==state.id] selected="selected"[/#if]>${state.stateName}</option>
															[/#list]
														</select>
													</td>
												</tr>
												<tr>
													<td>
														<span>城市:</span>
													</td>
													<td>
														<select name="shareCustomer.cityId" id="cityname" class="select2" style="width: 148px;">
															<option value="0">--请选择--</option>
															[#list cityList as city]
																<option value="${city.id}" [#if tourOrdersVO.customerList[0].cityId==city.id]selected="selected" [/#if]>${city.cityName}</option>
															[/#list]
														</select>
													</td>
													<td></td>
													<td></td>
												</tr>
											</tbody>
										</table>
										<div style="margin: 20px 0 0 0; border-width: 80%;">
											<table width="100%">
												<tbody>
													<tr>
														<td>
															<span>国内机票:</span>
															<label id="planticketRadio_1" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="shareCustomer.planticket" value="1" checked=""
																		style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																自订 &nbsp; &nbsp;
															</label>
															<label id="planticketRadio_2" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="shareCustomer.planticket" value="2" checked=""
																		style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																代订 &nbsp; &nbsp;
															</label>
															<label id="planticketRadio_3" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="shareCustomer.planticket" value="3" checked=""
																		style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
																</div>
																两者兼有
															</label>
														</td>
													</tr>
													<tr>
													    <td>
															如有agent自订，请输入航班信息备注:
														</td>
													</tr>
													<tr>
														<td>
															<textarea cols="5" class="form-control input-group1" rows="4" name="shareCustomer.otherInfo" id="notesId"
																style="width: 70%">${tourOrdersVO.customerList[0].otherInfo}</textarea>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="form-group" style="float:right">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="button" class="btn btn-default" onclick="cancel();">Cancel</button>
											<button data-wizard="#wizard1" class="btn btn-primary wizard-next">
												Next Step
												<i class="fa fa-caret-right"></i>
											</button>
										</div>
									</div>
								</div>
								<!--step1结束 -->
								<div class="step-pane" id="step2">
									<div class="ui-tabs-panel ui-widget-content ui-corner-bottom" style="width: auto; height: auto; margin: 10px 0px 0px;">
										<div>
											<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
												<i class="fa fa-square"></i>
												<span>费用信息</span>
									        </h4>
								        </div>
								        <div>
											[#assign itemList = tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList]
											<table style="word-break: break-all; white-space: nowrap;" width="100%">
												<tbody id="payList">
													<tr class="commonTourFee">
														<td width="10%">大人应收单人团款:</td>
														<td width="40%">
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[0].itemFee"
															onkeyup="showRegularTourTotalFee(this);" maxlength="100" size="30" value="${itemList[0].itemFee}" type="text">
														</td>
														<td width="10%">大人数量:</td>
														<td width="40%">
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[0].itemFeeNum" onkeyup="showRegularTourTotalFee(this);"
																maxlength="100" size="30" value="${itemList[0].itemFeeNum}" type="text" placeholder="大人数量">
																<div class="none" id="adultCountTip"></div>
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[0].id" value="${itemList[0].id}">
													</tr>
													<tr class="commonTourFee">
														<td>小孩应收单人团款:</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[1].itemFee"
																onkeyup="showRegularTourTotalFee(this);" maxlength="100" size="30"
																value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[1].itemFee}" type="text" placeholder="小孩应收单人团款">
														</td>
														<td>小孩数量:</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[1].itemFeeNum" 
															   onkeyup="showRegularTourTotalFee(this);" maxlength="100" size="30" 
															   value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[1].itemFeeNum}" type="text">
															<div class="none" id="childCountTip"></div>
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[1].id" value="${itemList[1].id}">
													</tr>
													<tr class="totalCommonTourFee">
														<td>
															<strong>
																<b> 常规团费总额: </b>
															</strong>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].receivableInfoOfOrder.totalCommonTourFee" id="AllTourPrice"
																style="background-color: #dddddd;" value="${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.totalCommonTourFee}"
																readonly="readonly" type="text" placeholder="常规团费总额">
														</td>
														<td> &nbsp;
														</td>
														<td> &nbsp;
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].receivableInfoOfOrder.id" value="${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.id}">
													</tr>
													<tr class="otherFee">
														<td>成人佣金金额</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[2].itemFee" onkeyup="showOtherFeeTotal(this);" 
															maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[2].itemFee}"
															type="text" placeholder="成人佣金金额">
														</td>
														<td>成人数量</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[2].itemFeeNum" onkeyup="showOtherFeeTotal(this);"
															maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[2].itemFeeNum}" type="text" placeholder="成人数量">
															<div class="none" id="adultCount3Tip"></div>
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[2].id" value="${itemList[2].id}">
													</tr>
													<tr class="otherFee">
														<td>小孩佣金金额</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[3].itemFee"
																onkeyup="showOtherFeeTotal(this);" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[3].itemFee}" type="text"
																placeholder="小孩佣金金额">
														</td>
														<td>小孩数量</td>
														<td>
															<input class="form-control input-group1"
																name="eachGroupLineOrderList[0].orderReceiveItemList[3].itemFeeNum" onkeyup="showOtherFeeTotal(this);"
																size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[3].itemFeeNum}" type="text" placeholder="小孩数量">
																<div class="none" id="visaFeeMemo1Tip"></div>
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[3].id" value="${itemList[3].id}">
													</tr>
													<tr>
														<td>小费金额</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[4].itemFee"
																onkeyup="showTotal(this);" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[4].itemFee}" maxlength="100" size="30" value="0" type="text" placeholder="小费金额">
														</td>
														<td>小费人数</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[4].itemFeeNum" onkeyup="showTotal(this);"
																maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[4].itemFeeNum}" type="text" placeholder="小费人数">
																<div class="none"></div>
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[4].id" value="${itemList[4].id}">
													</tr>
													<tr class="totalTip"> 
														<td>小费总额：</td>
														<td>
															<input class="form-control input-group1" readonly="readonly"
																name="eachGroupLineOrderList[0].orderReceiveItemList[5].itemFee" id="tip"
																style="background-color: #dddddd;" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[5].itemFee}" type="text" placeholder="小费总额">
														</td>
														<td>备注:</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[5].remark"
																value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[5].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[5].id" value="${itemList[5].id}">
													</tr>
													<tr>
														<td>自费金额</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[6].itemFee"
																onkeyup="showTotal(this);" maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[6].itemFee}" type="text" placeholder="自费金额">
														</td>
														<td>自费人数</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[6].itemFeeNum" onkeyup="showTotal(this);"
																maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[6].itemFeeNum}" type="text" placeholder="自费人数">
																<div class="none" id="adultCount2Tip"></div>
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[6].id" value="${itemList[6].id}">
													</tr>
													<tr class="totalSelfPay">
														<td>自费总额：</td>
														<td>
															<input class="form-control input-group1" readonly="readonly"
																name="eachGroupLineOrderList[0].orderReceiveItemList[7].itemFee" style="background-color: #dddddd;"
																id="expense" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[7].itemFee}" type="text">
														</td>
														<td>备注:</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[7].remark"
																value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[7].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[7].id" value="${itemList[7].id}">
													</tr>
													<tr class="otherFeeRemark">
														<td>代订酒店费用：</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[8].itemFee"
																id="HotelCost" onkeyup="showOtherFeeTotal(this);" maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[8].itemFee}" type="text" placeholder="代订酒店费用">
														</td>
														<td>备注：</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[8].remark"
																value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[8].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[8].id" value="${itemList[8].id}">
													</tr>
													<tr class="otherFeeRemark">
														<td>单房差费用：</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[9].itemFee"
																onkeyup="showOtherFeeTotal(this);" maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[9].itemFee}" type="text" placeholder="单房差费用">
														</td>
														<td>备注：</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[9].remark"
																maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[9].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[9].id" value="${itemList[9].id}">
													</tr>
													<tr class="otherFeeRemark">
														<td>签证费用：</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[10].itemFee"
																onkeyup="showOtherFeeTotal(this);" maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[10].itemFee}" type="text" placeholder="签证费用">
														</td>
														<td>备注</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[10].remark"
																maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[10].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[10].id" value="${itemList[10].id}">
													</tr>
													<tr class="otherFeeRemark">
														<td>保险费用：</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[11].itemFee"
																id="InsureCost" onkeyup="showOtherFeeTotal(this);" maxlength="100" size="30" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[11].itemFee}" type="text" placeholder="保险费用">
														</td>
														<td>备注</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[11].remark"
																id="InsureCostRemark" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[11].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[11].id" value="${itemList[11].id}">
													</tr>
													<tr class="otherFeeRemark">
														<td>机票：</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].orderReceiveItemList[12].itemFee"
																onkeyup="showOtherFeeTotal(this);" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[12].itemFee}" type="text" placeholder="机票">
														</td>
														<td>备注:</td>
														<td>
															<input name="eachGroupLineOrderList[0].orderReceiveItemList[12].remark"
																id="ticketRemark" value="${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[12].remark}" class="remarkCss form-control input-group1" type="text">
														</td>
														<input type="hidden" name="eachGroupLineOrderList[0].orderReceiveItemList[12].id" value="${itemList[12].id}">
													</tr>
													[#if (tourOrdersVO.eachGroupLineOrderList[0].otherFeeList?size>0)]
														[#list tourOrdersVO.eachGroupLineOrderList[0].otherFeeList as otherFee]
														<tr class="1 otherFeeRemark modify">
															<td>
																其他费用：
															</td>
															<td>
																<input class="form-control input-group1 fee" name="eachGroupLineOrderList[0].otherFeeList[].itemFee" onkeyup="showOtherFeeTotal(this);"
																	value="${otherFee.itemFee}" type="text" placeholder="其他费用">
															</td>
															<td>
																备注:
															</td>
															<td>
																<input name="eachGroupLineOrderList[0].otherFeeList[].remark" maxlength="100" size="30" value="${otherFee.remark}"
																	class="remarkCss form-control input-group1 remark" type="text">
																	[#if otherFee_index == 0]
																	&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${otherFee.id}',1);"></a>
																	&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,1);"></a>
																	[#else]
																	&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${otherFee.id}');"></a>
																	[/#if]
															</td> 
															<input type="hidden" name="eachGroupLineOrderList[0].otherFeeList[].id" value="${otherFee.id}">
														</tr>
														[/#list]
													[#else]
														<tr class="1 otherFeeRemark">
															<td>
																其他费用：
															</td>
															<td>
																<input class="form-control input-group1 fee" name="eachGroupLineOrderList[0].otherFeeList[].itemFee" onkeyup="showOtherFeeTotal(this);"
																	value="0" type="text" placeholder="其他费用">
															</td>
															<td>
																备注:
															</td>
															<td>
																<input name="eachGroupLineOrderList[0].otherFeeList[].remark" maxlength="100" size="30" value=""
																	class="remarkCss form-control input-group1 remark" type="text">
																	&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,1);"></a>
															</td>
															<input type="hidden" name="eachGroupLineOrderList[0].otherFeeList[].type" value="2">
														</tr>
													[/#if]
													<tr class="totalOtherFee">
														<td>
															<strong>
																<b> 其他费用总额: </b>
															</strong>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].receivableInfoOfOrder.totalFeeOfOthers"
																style="background-color: #dddddd;" value="${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.totalFeeOfOthers}" readonly="readonly" type="text" placeholder="其他费用总额">
														</td>
														<td> &nbsp;
														</td>
														<td> &nbsp;
														</td>
													</tr>
													[#if (tourOrdersVO.eachGroupLineOrderList[0].discountList?size>0)]
														[#list tourOrdersVO.eachGroupLineOrderList[0].discountList as discount]
														<tr class="2 discountFee modify">
															<td>
																其他特殊折扣：
															</td>
															<td>
																<input class="form-control input-group1 fee" name="eachGroupLineOrderList[0].discountList[].itemFee" onkeyup="showSumFee(this);" value="${discount.itemFee}"
																	type="text" placeholder="其他特殊折扣">
															</td>
															<td>
																备注:
															</td>
															<td>
																<input name="eachGroupLineOrderList[0].discountList[].remark" value="${discount.remark}" class="remarkCss form-control input-group1 remark" type="text">
																[#if discount_index == 0]
																&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${discount.id}',2);"></a>
																&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,2);"></a>
																[#else]
																&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${discount.id}');"></a>
																[/#if]
															</td>
															<input type="hidden" name="eachGroupLineOrderList[0].discountList[].id" value="${discount.id}">
														</tr>
														[/#list]
													[#else]
														<tr class="2 discountFee">
															<td>
																其他特殊折扣：
															</td>
															<td>
																<input class="form-control input-group1 fee" name="eachGroupLineOrderList[0].discountList[].itemFee" onkeyup="showSumFee(this);" value="0"
																	type="text" placeholder="其他特殊折扣">
															</td>
															<td>
																备注:
															</td>
															<td>
																<input name="eachGroupLineOrderList[0].discountList[].remark" value="" class="remarkCss form-control input-group1 remark" type="text">
																&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,2);"></a>
															</td>
															<input type="hidden" name="eachGroupLineOrderList[0].discountList[].type" value="3">
														</tr>
													[/#if]
													<tr class="sumFee">
														<td>
															<strong>
																<b>共计应收团款：</b>
															</strong>
														</td>
														<td>
															<input class="form-control input-group1" name="eachGroupLineOrderList[0].receivableInfoOfOrder.sumFee"
																id="AllSum" style="background-color: #dddddd;" value="${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.sumFee}" readonly="readonly" type="text" placeholder="共计应收团款">
														</td>
														<td> &nbsp;
														</td>
														<td> &nbsp;
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="form-group" style="float:right">
										<div class="col-sm-12">
											<button data-wizard="#wizard1" class="btn btn-default wizard-previous">
												<i class="fa fa-caret-left"></i>
												Previous
											</button>
											<button data-wizard="#wizard1" class="btn btn-primary wizard-next">
												Next Step
												<i class="fa fa-caret-right"></i>
											</button>
										</div>
									</div>
								</div>
								<!--step2结束 -->

								<div class="step-pane" id="step3">
									<div>
										<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
											<i class="fa fa-user"></i>
											<span>参团信息</span>
								        </h4>
								    </div>
									<div>
										<table>
											<tbody>
												<tr>
													<td style="width: 10%">
														<strong>团队类型</strong> <!-- 线路代码 -->
														<input type="hidden" name="eachGroupLineOrderList[0].order.id" value="${tourOrdersVO.eachGroupLineOrderList[0].order.id}">
													</td>
													<td style="width: 25%">
														<select class="tourTypeSelect select2" name="eachGroupLineOrderList[0].order.tourTypeId"
															style="width: 150px;" onchange="generalGroupLineSelect(this);">
															<option value="0">--请选择--</option>
															[#list tourTypeList as tourType]
																<option value="${tourType.tourTypeId}" [#if tourOrdersVO.eachGroupLineOrderList[0].order.tourTypeId==tourType.tourTypeId] selected="selected"[/#if]>${tourType.typeName}
															</option>
															[/#list]
														</select>
													</td>
													<td style="width: 10%">
														<strong>订单类型</strong> <!-- 线路代码 -->
													</td>
													<td style="width: 25%">
														<select id="orderTypeSelect" name="eachGroupLineOrderList[0].order.orderTourType" class="select2"
															style="width: 150px;">
															<option value="参团">参团</option>
															<option value="单订机票">单订机票</option>
															<option value="单订酒店">单订酒店</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>
														<div style="display: block;">系列线路代码:</div>
													</td>
													<td>
														<select id="groupLineSelect" name="eachGroupLineOrderList[0].tourInfoForOrder.groupLineId"
															onchange="groupLineSelectChange(this);" class="select2" readonly="readonly" type="text" length="12">
															<option value="0">--请选择--</option>
														</select>
														<input type="hidden" name="eachGroupLineOrderList[0].tourInfoForOrder.scheduleLineCode" />
														<font size="3px" color="red">*</font>
													</td>
													<td>
														<div style="display: block;">系列线路名称:</div>
													</td>
													<td>
														<div style="display: block;">
															<input id="lineNameInput" class="form-control input-group1" 
																name="eachGroupLineOrderList[0].tourInfoForOrder.lineName" type="text">
																<font size="3px" color="red">&nbsp;*</font>
														</div>
													</td>
													<input type="hidden" name="eachGroupLineOrderList[0].tourInfoForOrder.id" value="${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.id}">
												</tr>
												<tr id="ArrTimeAId">
													<td>团队正常抵达日期:</td>
													<td>
														<div class="input-group input-group1 date datetime col-md-5 col-xs-7" style="float:left" data-date-format="yyyy-mm-dd" data-min-view="2" data-show-meridian="true">
															<input type="text" readonly="readonly" name="eachGroupLineOrderList[0].tourInfoForOrder.scheduleOfArriveTime" 
															    value="${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}"
																class="form-control" size="16">
																<span class="input-group-addon btn btn-primary">
																	<span class="glyphicon glyphicon-th"></span>
																</span>
														</div>
														<font size="3px" color="red">&nbsp;*</font>
													</td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td colspan="2">
														<div>
															<br>
																客人特殊要求:
																<br>
																	<br>
																		<textarea name="eachGroupLineOrderList[0].tourInfoForOrder.specialRequirements" cols="40" rows="8" class="form-control">${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.specialRequirements}</textarea>
														</div>
													</td>
													<td colspan="2">
														<div>
															<br>
																团队注意事项和备注:
																<br>
																	<br>
																		<textarea name="eachGroupLineOrderList[0].tourInfoForOrder.tourInfo" cols="40" rows="8" class="form-control">${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.tourInfo}</textarea>
														</div>
													</td>
												</tr>
												<tr>
													<td colspan="2">
														<div>
															<br>
																自主线路具体行程:
																<br>
																	<br>
																		<textarea name="eachGroupLineOrderList[0].tourInfoForOrder.personalRoute" cols="40" rows="8" class="form-control">${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.personalRoute}</textarea>
														</div>
													</td>
													<td colspan="2">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="form-group" style="float:right">
										<div class="col-sm-12">
											<button data-wizard="#wizard1" class="btn btn-default wizard-previous">
												<i class="fa fa-caret-left"></i>
												Previous
											</button>
											<button id="formSubmit" data-wizard="#wizard1" class="btn btn-success wizard-next">
												<i class="fa fa-check"></i>
												Save
											</button>
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
<table>
	<tr class="1 otherFeeRemark" visible="hidden" id="feeTemplate_1">
		<td>
			其他费用：
		</td>
		<td>
			<input class="form-control input-group1 fee" name="eachGroupLineOrderList[0].otherFeeList[].itemFee" onkeyup="showOtherFeeTotal(this);"
				value="0" type="text" placeholder="其他费用">
		</td>
		<td>
			备注:
		</td>
		<td>
			<input name="eachGroupLineOrderList[0].otherFeeList[].remark" maxlength="100" size="30" value=""
				class="remarkCss form-control input-group1 remark" type="text">
				&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this);"></a>
		</td>
		<input type="hidden" name="eachGroupLineOrderList[0].otherFeeList[].type" value="2">
	</tr>	
	<tr class="2 discountFee" visible="hidden" id="feeTemplate_2">
		<td>
			其他特殊折扣：
		</td>
		<td>
			<input class="form-control input-group1 fee" name="eachGroupLineOrderList[0].discountList[].itemFee" onkeyup="showSumFee(this);" value="0"
				type="text" placeholder="其他特殊折扣">
		</td>
		<td>
			备注:
		</td>
		<td>
			<input name="eachGroupLineOrderList[0].discountList[].remark" value="" class="remarkCss form-control input-group1 remark" type="text">
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this);"></a>
		</td>
		<input type="hidden" name="eachGroupLineOrderList[0].discountList[].type" value="3">
	</tr>
<table>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
	$("#credit_slider").slider().on("slide",function(e){
    	$("#credits").html("$" + e.value);
    });
	$("#rate_slider").slider().on("slide",function(e){
    	$("#rate").html(e.value + "%");
    });
</script>
<script type="text/javascript">
	$(document).ready(function(){
	  //initialize the javascript
		App.init();
		[@flash_message /]
		App.wizard();
		$("div.datetime").datetimepicker({autoclose: true});
		$("form select.select2").select2({
        	width: '60%'
        });
		setValue();
	});

    $(".bars").click(function(){
		$(this).next().slideToggle("slow");
		var _slide=$(this).find("i:last");
		if(_slide.attr('class')=="fa fa-angle-up")
		{
		_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
		}
		else
		{
		_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
		} 
	});
	
	var groupLineMap;
	
	/* 根据传来的参数回显页面  */
    function setValue(){
        $("#planticketRadio_${tourOrdersVO.customerList[0].planticket}").click(); 
    	$("#orderTypeSelect").val("${tourOrdersVO.eachGroupLineOrderList[0].order.orderTourType}");
    	getOptionsAndSetValue("${tourOrdersVO.eachGroupLineOrderList[0].order.tourTypeId}", "${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.groupLineId}");
    	$("#lineNameInput").val("${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.lineName}");
    	[#list tourOrdersVO.customerList as customer]
    		$("#sex_${customer_index}_${customer.sex}").click();
    	[/#list]
    	[#list tourOrdersVO.eachGroupLineOrderList[0].customerFlightList as customerFlights]
    		$("#ifPickUp_${customerFlights_index}_${customerFlights[0].ifPickUp}").click();
    		$("#ifSendUp_${customerFlights_index}_${customerFlights[1].ifSendUp}").click();
    	[/#list]
    }
    
    /* 根据团队类型的值生成线路SELECT,并利用线路id选中它  */
	function getOptionsAndSetValue(tourTypeId, value){
	    $groupLineSelect = $("#groupLineSelect");
        $groupLineSelect.children("option").remove();
        $groupLineSelect.append("<option value='0'>--请选择--</option>");
       
        if(tourTypeId != "0"){
        	$.post("groupLines.jhtml", {"tourTypeId":tourTypeId}, function(result){
        		groupLineMap = result;
	        	$.each(result, function(groupLineId, groupLine) {
	        		if(value == groupLineId){
                		$groupLineSelect.append("<option selected='true' value='" + groupLineId + "'>" + groupLine.tourCode + "</option>"); 
	        		}else{
	        			$groupLineSelect.append("<option value='" + groupLineId + "'>" + groupLine.tourCode + "</option>"); 
	        		}
            	});
            	$groupLineSelect.select2({
		        	width: '60%'
		        });
            	$groupLineSelect.next().val(groupLineMap[value].tourCode);
			});
        }
	}
	    
    /* 取消的动作 */
    function cancel(){
    	window.location.href="list.jhtml";
    }
    
    /* 根据国家动态加载州  */
    function generalStateSelect(countrySelect) {
        var $stateSelect = $(countrySelect).parent().next().next().find("select");
        var countryId = $(countrySelect).val();

        $stateSelect.children("option").remove();
        $stateSelect.append("<option value='0'>--请选择--</option>");
        $stateSelect.val("0");
        $stateSelect.select2({
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
	
	/* 计算常规团费总额  */
    function showRegularTourTotalFee(input) {
    	var $groupLine = $(input).parent().parent().parent();
    	var $commonTourTrs = $groupLine.children(".commonTourFee");
        var totalCommonTourFee = getSumWithFeeAndFeeNum($commonTourTrs);
        $groupLine.children(".totalCommonTourFee").find("input:first").val(totalCommonTourFee);
        showSumFee(input);
    }
    
    /* 计算其他费用总额  */
    function showOtherFeeTotal(input) {
    	var totalOtherFee = 0;
    	var $groupLine = $(input).parent().parent().parent();
    	var $otherFeeTrs = $groupLine.children(".otherFee");
    	var $otherFeeRemarkTrs = $groupLine.children(".otherFeeRemark"); 
    	totalOtherFee += getSumWithFeeAndFeeNum($otherFeeTrs);
    	totalOtherFee += $groupLine.children(".totalTip").find("input:first").val() * 1;
    	totalOtherFee += $groupLine.children(".totalSelfPay").find("input:first").val() * 1;
    	totalOtherFee += getSumWithFee($otherFeeRemarkTrs);
        $groupLine.children(".totalOtherFee").find("input:first").val(totalOtherFee);
        showSumFee(input);
    }

	/* 计算小费总额和自费总额  */
    function showTotal(input) {
        var $feeTr = $(input).parent().parent();
        var total = getSumWithFeeAndFeeNum($feeTr);
        $feeTr.next().find("input:first").val(total);
        showOtherFeeTotal(input);
    }
    	
	/* 计算共计应收团款  */
    function showSumFee(input) {
    	var $groupLine = $(input).parent().parent().parent();
    	var discountFee = getSumWithFee($groupLine.children(".discountFee"));
    	var totalCommonTourFee = $groupLine.children(".totalCommonTourFee").find("input:first").val() * 1;
    	var totalOtherFee = $groupLine.children(".totalOtherFee").find("input:first").val() * 1;
    	$groupLine.children(".sumFee").find("input:first").val(totalCommonTourFee + totalOtherFee - discountFee);
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
            sum += fee * 1;
        });
        return sum;
    }
    
    /* 增加费用或折扣  */
    function addFee(addButton, classNo){
    	var $newHtml = $("#feeTemplate_" + classNo).clone(true).removeAttr("id").removeAttr("visible");
    	var $position = $(addButton).parent().parent().parent().find("." + classNo + ":last");
    	$position.after($newHtml);
    }
    
    /* 删除费用或折扣  */
    function removeFee(button) {
        var $fee = $(button).parent().parent();
        var $input = $fee.parent().find("input");
        $fee.remove();
        showOtherFeeTotal($input[0]);
    }
    
    /* 根据款项ID删除款项  */
    function deleteFee(button,itemId){
    	$("form").append('<input type="hidden" name="deleteItemIds" value="' + itemId + '">');
        var $fee = $(button).parent().parent();
        var $input = $fee.parent().find("input");
        $fee.remove();
        showOtherFeeTotal($input[0]);
    }
    
    /* 根据款项ID删除款项 (第一条记录) */
    function deleteFirstFee(button,itemId,classNo){
     	$("form").append('<input type="hidden" name="deleteItemIds" value="' + itemId + '">');
        var $fee = $(button).parent().parent();
	    var $next = $fee.next();
	    
	    /* 如果其他费用和折扣的输入框数目大于1个  */
	    if($next.hasClass(classNo)){
	    	var $button = $next.find("a");
	    	
	    	/* 如果第一个输入框下面是需要修改的值  */
		    if($next.hasClass("modify")){
		    	var event = $button.attr("onclick").replace("deleteFee","deleteFirstFee").replace(");",","+ classNo +");");
		    	$button.attr("onclick",event);
		    	$button.after('&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,'+ classNo +');"></a>');
		    }else{
				$button.attr("onclick","addFee(this,"+ classNo +");").removeClass("fa fa-minus").addClass("fa fa-plus");	    
		    }
	    }else{
	    	var $newHtml = $("#feeTemplate_" + classNo).clone(true).removeAttr("id").removeAttr("visible");
	    	$newHtml.find("a").attr("onclick","addFee(this,"+ classNo +");").removeClass("fa fa-minus").addClass("fa fa-plus");
	    	$fee.after($newHtml);
	    } 
	    $fee.remove();
	    showOtherFeeTotal($next.find("input:first")[0]);
    }
    
	/* 根据团队类型加载线路  */
    function generalGroupLineSelect(tourTypeSelect) {
        var $groupLineTr = $(tourTypeSelect).parent().parent().next();
        var $groupLineSelect = $groupLineTr.find("select");
        var $groupLineNameInput = $groupLineTr.children("td").eq(3).find("input");

        var tourTypeId = $(tourTypeSelect).val();
        $groupLineNameInput.val("");
        $groupLineNameInput.removeAttr("readonly");

        $groupLineSelect.children("option").remove();
        $groupLineSelect.append("<option value='0'>--请选择--</option>");
		$groupLineSelect.val('0');
		$groupLineSelect.select2({
        	width: '60%'
        });
        if (tourTypeId != '0') {
            $.post("groupLines.jhtml", {
                "tourTypeId": tourTypeId
            },
            function(result) {
                groupLineMap = result;
                $.each(result,
                function(groupLineId, groupLine) {
                    $groupLineSelect.append("<option value='" + groupLineId + "'>" + groupLine.tourCode + "</option>");
                });
            });
        }
    }
	
	/* 根据线路选项显示线路名称  */
    function groupLineSelectChange(groupLineSelect) {
        var $groupLineNameInput = $(groupLineSelect).parent().next().next().find("input");
        var groupLineId = $(groupLineSelect).val();

        if (groupLineId != '0') {
            $(groupLineSelect).next().val(groupLineMap[groupLineId].tourCode);
            $groupLineNameInput.attr("readonly", "readonly");
            $groupLineNameInput.val(groupLineMap[groupLineId].tourName);
        } else {
            $(groupLineSelect).next().val("");
            $groupLineNameInput.removeAttr("readonly");
            $groupLineNameInput.val('');
        }
    }
    
    /* 提交表单 */
    $("#formSubmit").click(function() {
    	$payList = $("#payList");
		
		/* 遍历每个其他费用  */
		$payList.find(".1").each(function(index){
			$(this).find("input").each(function(){
                addFeeOrDiscountIndex($(this),index);
			});
		});
		
		/* 遍历每个其他特殊折扣  */
		$payList.find(".2").each(function(index){
			$(this).find("input").each(function(){
                addFeeOrDiscountIndex($(this),index);
			});
		});
    	$("form").submit();
    });
    
	/* 给其他费用以及折扣生成list下标  */
	function addFeeOrDiscountIndex($input,index){
		var name = $input.attr("name");
		var position = name.lastIndexOf("]");
		name = name.substring(0,position) + index + name.substring(position,name.length);
		$input.attr("name",name);
	}
</script>
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
