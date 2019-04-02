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
			<h2>Booking Detail</h2>
			<div class="new"><button type="button" onclick="javascript:history.go(-1)" class="btn btn-default">Cancel</button></div>
			<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Booking</a></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="tab-container">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#home" data-toggle="tab">Passenger Info</a></li>
							<li><a href="#profile" data-toggle="tab">Flight Info</a></li>
							<li><a href="#messages" data-toggle="tab">Tour Info</a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active cont" id="home">
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
														${customer.lastName}
													</td>
													<td width="13%">
														<span>FirstName:</span>
													</td>
													<td width="37%">
														${customer.firstName}
													</td>
												</tr>
												<tr>
													<td>
														<span>MiddleName:</span>
													</td>
													<td>
														${customer.middleName}
													</td>
													<td>
														<span>Date of Birth:</span>
													</td>
													<td>
														<span>
															[#if (customer.dateOfBirth)??]${customer.dateOfBirth?string('yyyy-MM-dd')}[/#if]
														</span>
													</td>
												</tr>
												<tr>
													<td>
														<span>Nationality:</span>
													</td>
													<td>
														${customer.nationalityOfPassport}
													</td>
													<td>
														<span>Passport No.:</span>
													</td>
													<td>
														${customer.passportNo}
													</td>
												</tr>
												<tr>
													<td>
														<span>Expiry Date:</span>
													</td>
													<td>
														<span>
															[#if (customer.expireDateOfPassport)??]${customer.expireDateOfPassport?string('yyyy-MM-dd')}[/#if]
														</span>
													</td>
													<td>
														<span>Gender:</span>
													</td>
													<td>
														<div>
															<label id="sex_${customer_index}_1" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio"  name="customerList[${customer_index}].sex" value="1" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																		</ins>
																</div>
																Female
															</label>
															<label id="sex_${customer_index}_2" class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="customerList[${customer_index}].sex" value="2" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																		</ins>
																</div>
																Male
															</label>
														</div>
													</td>
												</tr>
												<tr>
													<td>
														<span> Remark: </span>
													</td>
													<td>
														${customer.memoOfCustomer}
													</td>
													<td>
														<span>Language:</span>
													</td>
													<td>
													${language.language}
													</td>
												</tr>
												<tr>
													<td>
														<span>Room:</span>
													</td>
													<td>${room}</td>
													<td width="13%">
														<span> Phone : </span>
													</td>
													<td width="37%">
														${customer.mobile}
													</td>
												</tr>
												<tr>
													<td>
														<span> Email: </span>
													</td>
													<td>${customer.email}</td>
													<td>
														<span> Address: </span>
													</td>
													<td>
														${customer.streetAddress}
													</td>
												</tr>
												[#assign customerFlights = tourOrdersVO.eachGroupLineOrderList[0].customerFlightList[customer_index]]
												<tr>
													<td colspan="4">
														<div><h6>Arrival Flight:</h6></div>
													</td>
												</tr>
												<tr>
													<td>
														<span> Airline : </span>
													</td>
													<td>
														${customerFlights[0].flightCode}
													</td>
													<td>
														<span>Flight No.:</span>
													</td>
													<td>
													${customerFlights[0].flightNumber}
													</td>
												</tr>
												<tr>
													<td>
														<span> Arrival Date: </span>
													</td>
													<td>
													[#if (customerFlights[0].arriveDate)??]${customerFlights[0].arriveDate?string('yyyy-MM-dd')}[/#if]
													</td>
													<td>
														<span> Arrival Time: </span>
													</td>
													<td>
									                    ${customerFlights[0].arriveTime}
													</td>
												</tr>
												<tr>
													<td>
														<span>Pick-up:</span>
													</td>
													<td>
														<label class="radio-inline">
															<div id="ifPickUp_${customer_index}_1" class="iradio_square-blue"
																style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].ifPickUp"
																	value="1" checked="" style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
															Yes &nbsp; &nbsp;
														</label>
														<label class="radio-inline">
															<div id="ifPickUp_${customer_index}_2" class="iradio_square-blue"
																style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][0].ifPickUp"
																	value="2" checked="" style="position: absolute; opacity: 0;">
																<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
															No
														</label>
													</td>
													<td>
														<span>Deviation: </span>
													</td>
													<td>
														${customerFlights[0].remark}
													</td>
												</tr>
												<tr>
													<td colspan="4">
														<div><h6>Departure Flight:</h6></div>
													</td>
												</tr>
												<tr>
													<td colspan="">
														<span> Airline : </span>
													</td>
													<td>
														${customerFlights[1].flightCode}
													</td>
													<td>
														<span>Flight No.: </span>
													</td>
													<td>
														${customerFlights[1].flightNumber}
													</td>
												</tr>
												<tr>
													<td>
														<span>Departure Date:</span>
													</td>
													<td>
														[#if (customerFlights[1].arriveDate)??]${customerFlights[1].arriveDate?string('yyyy-MM-dd')}[/#if]
													</td>
													<td>
														<span> Departure Time: </span>
													</td>
													<td>
														${customerFlights[1].arriveTime}
													</td>
												</tr>
												<tr>
													<td>
														<span> Drop-off: </span>
													</td>
													<td>
														<label id="ifSendUp_${customer_index}_1" class="radio-inline">
															<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].ifSendUp"
																	value="1" style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
															Yes &nbsp; &nbsp;
														</label>
														<label id="ifSendUp_${customer_index}_2" class="radio-inline">
															<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="eachGroupLineOrderList[0].customerFlightList[${customer_index}][1].ifSendUp"
																	value="2" checked="" style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
														No
														</label>
													</td>
													<td>
														<span>Deviation: </span>
													</td>
													<td>
														${customerFlights[1].remark}
													</td>
												</tr>
												<tr>
													<td style="display: none"></td>
													<td style="display: none"></td>
													<td style="display: none"></td>
													<td style="display: none"></td>
												</tr>
											</tbody>
										</table>
									</div>
								[/#list]
								<h4 style="background:#FDA445;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
										<i class="fa fa-mobile"></i>
										<span >Contacts Way</span>
								</h4>
								<div style="width: auto; height: auto; margin: 20px 0 0 0; padding: 8px;">
									<table style="word-break: break-all; white-space: nowrap;" width="100%">
										<tbody>
											<tr>
												<td width="13%">
													<span>Tel:</span>
												</td>
												<td width="37%">
												<div class="col-sm">
													${tourOrdersVO.customerList[0].tel}
												</div>
												</td>
												<td>
													<span>Zop Code:</span>
												</td>
												<td>
												  	<div class="col-sm">
												  		${tourOrdersVO.customerList[0].zip}
									                </div>
												</td>
											</tr>
											<tr>
												<td>
													<span>Country: </span>
												</td>
												<td>
													${country.countryName}
												</td>
												<td>
													<span>State:</span>
												</td>
												<td colspan="3">
													${state.stateName}
												</td>
											</tr>
											<tr>
												<td>
													<span>City:</span>
												</td>
												<td>
													${city.cityName}
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
														<span>Domestic air ticket:</span>
														<label id="planticketRadio_1" class="radio-inline">
															<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="shareCustomer.planticket" value="1" checked=""
																	style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper"
																		style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
															Booked by Agent &nbsp; &nbsp;
														</label>
														<label id="planticketRadio_2" class="radio-inline">
															<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="shareCustomer.planticket" value="2" checked=""
																	style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper"
																		style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
															Booked by OP &nbsp; &nbsp;
														</label>
														<label id="planticketRadio_3" class="radio-inline">
															<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																<input class="icheck" type="radio" name="shareCustomer.planticket" value="3" checked=""
																	style="position: absolute; opacity: 0;">
																	<ins class="iCheck-helper"
																		style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
															</div>
															Booked by Agent & OP
														</label>
													</td>
												</tr>
												<tr>
												    <td>
														Booked by Agent，Flight Remark:
													</td>
												</tr>
												<tr>
													<td>
														${tourOrdersVO.customerList[0].otherInfo}
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="tab-pane cont" id="profile">
								[#assign itemList = tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList]
								<table style="word-break: break-all; white-space: nowrap;" width="100%">
									<tbody id="payList">
										<tr class="commonTourFee">
											<td width="10%">大人应收单人团款:</td>
											<td width="40%">${itemList[0].itemFee}</td>
											<td width="10%">大人数量:</td>
											<td width="40%">${itemList[0].itemFeeNum}</td>
										</tr>
										<tr class="commonTourFee">
											<td>小孩应收单人团款:</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[1].itemFee}</td>
											<td>小孩数量:</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[1].itemFeeNum}</td>
										</tr>
										<tr class="totalCommonTourFee">
											<td>
												<strong>
													<b> 常规团费总额: </b>
												</strong>
											</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.totalCommonTourFee}</td>
											<td> &nbsp;
											</td>
											<td> &nbsp;
											</td>
										</tr>
										<tr class="otherFee">
											<td>成人佣金金额</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[2].itemFee}
											</td>
											<td>成人数量</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[2].itemFeeNum}
											</td>
										</tr>
										<tr class="otherFee">
											<td>小孩佣金金额</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[3].itemFee}
											</td>
											<td>小孩数量</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[3].itemFeeNum}
											</td>
										</tr>
										<tr>
											<td>小费金额</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[4].itemFee}</td>
											<td>小费人数</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[4].itemFeeNum}
											</td>
										</tr>
										<tr class="totalTip"> 
											<td>小费总额：</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[5].itemFee}</td>
											<td>备注:</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[5].remark}</td>
										</tr>
										<tr>
											<td>自费金额</td>
											<td>${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[6].itemFee}</td>
											<td>自费人数</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[6].itemFeeNum}
											</td>
										</tr>
										<tr class="totalSelfPay">
											<td>自费总额：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[7].itemFee}
											</td>
											<td>备注:</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[7].remark}
											</td>
										</tr>
										<tr class="otherFeeRemark">
											<td>代订酒店费用：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[8].itemFee}
											</td>
											<td>备注：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[8].remark}
											</td>
										</tr>
										<tr class="otherFeeRemark">
											<td>单房差费用：</td>
											<td>
											${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[9].itemFee}
											</td>
											<td>备注：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[9].remark}
											</td>
										</tr>
										<tr class="otherFeeRemark">
											<td>签证费用：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[10].itemFee}
											</td>
											<td>备注</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[10].remark}
											</td>
										</tr>
										<tr class="otherFeeRemark">
											<td>保险费用：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[11].itemFee}
											</td>
											<td>备注</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[11].remark}
											</td>
										</tr>
										<tr class="otherFeeRemark">
											<td>机票：</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[12].itemFee}
											</td>
											<td>备注:</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].orderReceiveItemList[12].remark}
											</td>
										</tr>
										[#if (tourOrdersVO.eachGroupLineOrderList[0].otherFeeList?size>0)]
											[#list tourOrdersVO.eachGroupLineOrderList[0].otherFeeList as otherFee]
											<tr class="1 otherFeeRemark modify">
												<td>
													其他费用：
												</td>
												<td>
													${otherFee.itemFee}
												</td>
												<td>
													备注:
												</td>
												<td>
													${otherFee.remark}
												</td> 
											</tr>
											[/#list]
										[#else]
											<tr class="1 otherFeeRemark">
												<td>
													其他费用：
												</td>
												<td>
													0
												</td>
												<td>
													备注:
												</td>
												<td>
												</td>
											</tr>
										[/#if]
										<tr class="totalOtherFee">
											<td>
												<strong>
													<b> 其他费用总额: </b>
												</strong>
											</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.totalFeeOfOthers}
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
													${discount.itemFee}
												</td>
												<td>
													备注:
												</td>
												<td>
													${discount.remark}
												</td>
											</tr>
											[/#list]
										[#else]
											<tr class="2 discountFee">
												<td>
													其他特殊折扣：
												</td>
												<td>
													0
												</td>
												<td>
													备注:
												</td>
												<td>
													
												</td>
											</tr>
										[/#if]
										<tr class="sumFee">
											<td>
												<strong>
													<b>共计应收团款：</b>
												</strong>
											</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].receivableInfoOfOrder.sumFee}
											</td>
											<td> &nbsp;
											</td>
											<td> &nbsp;
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="tab-pane" id="messages">
								<table>
									<tbody>
										<tr>
											<td style="width: 10%">
												<strong>团队类型</strong> <!-- 线路代码 -->
											</td>
											<td style="width: 25%">
												${tourType.typeName}
											</td>
											<td style="width: 10%">
												<strong>订单类型</strong> <!-- 线路代码 -->
											</td>
											<td style="width: 25%">
												${tourOrdersVO.eachGroupLineOrderList[0].order.orderTourType}
											</td>
										</tr>
										<tr>
											<td>
												<div style="display: block;">系列线路代码:</div>
											</td>
											<td>
											</td>
											<td>
												<div style="display: block;">系列线路名称:</div>
											</td>
											<td>
												${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.lineName}
											</td>
										</tr>
										<tr id="ArrTimeAId">
											<td>团队正常抵达日期:</td>
											<td>
												[#if (tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.scheduleOfArriveTime)??]
													${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}
												[/#if]
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
															${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.specialRequirements}
												</div>
											</td>
											<td colspan="2">
												<div>
													<br>
														团队注意事项和备注:
														<br>
															<br>
															${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.tourInfo}
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
															${tourOrdersVO.eachGroupLineOrderList[0].tourInfoForOrder.personalRoute}
												</div>
											</td>
											<td colspan="2">
											</td>
										</tr>
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

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
     $(document).ready(function () {
        //initialize the javascript
        App.init();
        setValue();
     });
     	/* 根据传来的参数回显页面  */
    function setValue(){
    	[#list tourOrdersVO.customerList as customer]
    		$("#sex_${customer_index}_${customer.sex}").click();
    	[/#list]
    	[#list tourOrdersVO.eachGroupLineOrderList[0].customerFlightList as customerFlights]
    		$("#ifPickUp_${customerFlights_index}_${customerFlights[0].ifPickUp}").click();
    		$("#ifSendUp_${customerFlights_index}_${customerFlights[1].ifSendUp}").click();
    	[/#list]
    }
</script>
</body>
</html>
