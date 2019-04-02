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
            <h2>Edit Booking</h2>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking</a></li>
            </ol>
        </div>
			<div class="cl-mcont">		
				<div class="row wizard-row">
					<div class="col-sm-12 col-md-12">
						<div class="block-flat">
							<div class="tab-container">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#home" data-toggle="tab">Booking Info</a></li>
									<li><a href="#customer" data-toggle="tab">Passenger Info</a></li>
									<li><a href="#profile" data-toggle="tab">Flight Info</a></li>
									<li><a href="#messages" data-toggle="tab">Fee Info</a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active cont" id="home">
									<input type="hidden" name="ordersTotalId" value="${productVO.ordersTotalId}"/>
					                <div style="width:auto;height:auto;margin:20px 0 0 0;border:0px none solid;padding:8px;">
										<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
											<tbody>
												<tr>
													<td width="13%">
														<span>
															Tour Type:
														</span>
													</td>
													<td width="37%">
													[#list tourTypeList as tourType]
														[#if tourType.tourTypeId == productVO.tourTypeId]
															${tourType.typeName}
														[/#if]
													[/#list]
													</td>
													<td width="13%">
														Product
													</td>
													<td width="37%">
														${groupLine.tourCode}
													</td>
												</tr>
												<tr>
													<td>
														Arrival Date:
													</td>
													<td> 
														<input type="hidden" name="tourInfoForOrder.id" value="${productVO.tourInfoForOrder.id}"/>
														<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" style="float:left" data-min-view="2">
															<input type="text" class="form-control" readOnly="readOnly" name="tourInfoForOrder.scheduleOfArriveTime" value="[#if (productVO.tourInfoForOrder.scheduleOfArriveTime)??]${productVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]">
															<span class="input-group-addon btn btn-primary">
																<span class="glyphicon glyphicon-th">
																</span>
															</span>
														</div>
														<font size="3px" color="red">
														    &nbsp;*
														</font>
													</td>
												</tr>
												<tr>
													<td width="13%">
														Requirement:
													</td>
													<td width="37%">
														<textarea name="tourInfoForOrder.specialRequirements" cols="30" rows="4" class="form-control input-group1">${productVO.tourInfoForOrder.specialRequirements}</textarea>
													</td>
													<td width="13%">
														Remark:
													</td>
													<td width="37%">
														<textarea name="tourInfoForOrder.tourInfo" cols="30" rows="4" class="form-control input-group1">${productVO.tourInfoForOrder.tourInfo}</textarea>
													</td>
												</tr>
												<tr>
													<td width="13%">
														Tour Voucher Remarks:
													</td>
													<td width="37%">
														<textarea name="tourInfoForOrder.voucherRemarks" cols="30" rows="4" class="form-control input-group1">${productVO.tourInfoForOrder.voucherRemarks}</textarea>
													</td>
													<td width="13%"></td>
													<td width="37%"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="tab-pane cont" id="customer">
									[#list customerList as customer]
										<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">No.${customer_index+1}</div>
										<div class="customerFlight_div">
											<table style="border: 0px none">
												<tbody>
													<tr>
														<td style="font-weight:bold;">
															<span>
																LastName:
															</span>
														</td>
														<td>
															${customer.lastName}
														</td>
														<td style="font-weight:bold;">
															<span>
																FirstName:
															</span>
														</td>
														<td>
															${customer.firstName}
														</td>
													</tr>
													<tr>
														<td style="font-weight:bold;">
															<span>MiddleName:</span>
														</td>
														<td>
															${customer.middleName}
														</td>
														<td>
															<span>Date of Birth	:</span>
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
																<label  class="radio-inline">
																	<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																		<input class="icheck" type="radio"  name="customerList[${customer_index}].sex" value="1" [#if customer.sex==1]checked=""[/#if] style="position: absolute; opacity: 0;">
																			<ins class="iCheck-helper"
																				style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																			</ins>
																	</div>
																	Female
																</label>
																<label  class="radio-inline">
																	<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																		<input class="icheck" type="radio" name="customerList[${customer_index}].sex" value="2" [#if customer.sex==2]checked=""[/#if] style="position: absolute; opacity: 0;">
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
														${customer.language.language}
														</td>
													</tr>
													<tr>
														<td>
															<span> Address: </span>
														</td>
														<td>
															${customer.streetAddress}
														</td>
														<td width="13%">
															<span> Phone: </span>
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
														</td>
														<td>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									[/#list]
								</div>
								<div class="tab-pane cont" id="profile">
									[#list productVO.customerFlights as cor]
										<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">No.${cor_index+1}</div>
										<div class="customerFlight_div">
											<input type="hidden" name="customerFlights[${cor_index}].id" value="${cor.id}"/>
											<table style="border: 0px none">
												<tbody>
													<tr>
														<td style="font-weight:bold;">
															<span>
																Passenger:
															</span>
														</td>
														<td>
																[#list customerList as customer]
																	[#if customer.customerId == cor.customerId]
																		${customer.firstName} ${customer.lastName}
																	[/#if]
																[/#list]
														</td>
														<td colspan="2">
														</td>
													</tr>
													<tr style="font-weight:bold;">
														<td colspan="4">
															Arrival Flight:
														</td>
													</tr>
													<tr>
														<td>
															<span>
																Airline:
															</span>
														</td>
														<td>
															${cor.customerFlightList[0].flightCode}
														</td>
														<td>
															<span>
																Flight No.:
															</span>
														</td>
														<td>
															${cor.customerFlightList[0].flightNumber}
														</td>
													</tr>
													<tr>
														<td>
															<span>
																Arrival Date:
															</span>
														</td>
														<td>
															<div>
																<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
																	<input type="text" class="form-control" readOnly="readOnly" name="customerFlights[${cor_index}].customerFlightList[0].arriveDate" value="[#if (cor.customerFlightList[0].arriveDate)??]${cor.customerFlightList[0].arriveDate?string('yyyy-MM-dd')}[/#if]">
																	<span class="input-group-addon btn btn-primary">
																		<span class="glyphicon glyphicon-th">
																		</span>
																	</span>
																</div>
															</div>			
														</td>
														<td>
															<span>
																Arrival Time:
															</span>
														</td>
														<td>
															${cor.customerFlightList[0].arriveTime}
														</td>
													</tr>
													<tr>
														<td>
															<span>
																Pick-up:
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
															<span>Deviation: </span>
														</td>
														<td>
															${cor.customerFlightList[0].remark}
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
															${cor.customerFlightList[1].flightCode}
														</td>
														<td>
															<span>
																Flight No.:
															</span>
														</td>
														<td>
															${cor.customerFlightList[1].flightNumber}
														</td>
													</tr>
													<tr>
														<td>
															<span>
																Departure Date:
															</span>
														</td>
														<td>
															<div>
																<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
																	<input type="text" class="form-control" readOnly="readOnly" name="customerFlights[${cor_index}].customerFlightList[1].arriveDate" value="[#if (cor.customerFlightList[1].arriveDate)??]${cor.customerFlightList[1].arriveDate?string('yyyy-MM-dd')}[/#if]">
																	<span class="input-group-addon btn btn-primary">
																		<span class="glyphicon glyphicon-th">
																		</span>
																	</span>
																</div>
															</div>	
														</td>
														<td>
															<span>
																Departure Time:
															</span>
														</td>
														<td>
															${cor.customerFlightList[1].arriveTime}
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
															<span>Deviation: </span>
														</td>
														<td>
															${customerFlights[1].remark}
														</td>
													</tr>
													<tr>
														<td style="display:none">
															<br/>
														</td>
														<td style="display:none">
														</td>
														<td style="display:none">
														</td>
														<td style="display:none">
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									[/#list]
							    </div>		
								<div class="tab-pane" id="messages">
									<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
										<tbody id="feeTbody">
											<tr class="commonTourFee">
												<td width="10%">
													Adult Tour Price:
												</td>
												<td width="40%">
													${productVO.adultItem.itemFee}
												</td>
												<td width="10%">
													Number:
												</td>
												<td width="40%">
													${productVO.adultItem.itemFeeNum}
												</td>
												<input type="hidden" name="adultItem.id" value="${productVO.adultItem.id}"/>
												<input type="hidden" name="adultItem.type" value="1">
												<input type="hidden" name="adultItem.num" value="101">
											</tr>
											<tr class="commonTourFee">
												<td>
													Child Tour Price:
												</td>
												<td> 
													${productVO.childrenItem.itemFee}
												</td>
												<td>
													Number:
												</td>
												<td>
													${productVO.childrenItem.itemFeeNum}
												</td>
												<input type="hidden" name="childrenItem.id" value="${productVO.childrenItem.id}"/>
												<input type="hidden" name="childrenItem.type" value="1">
												<input type="hidden" name="childrenItem.num" value="102">
											</tr>
											<tr class="totalCommonTourFee">
												<td>
													<strong>
														<b>
															Total Tour Price:
														</b>
													</strong>
												</td>
												<td>
													${productVO.receivableInfoOfOrder.totalCommonTourFee}
												</td>
												<td>
							                                &nbsp;
												</td>
												<td>
							                                &nbsp;
												</td>
											</tr>
											<tr class="totalOtherFee">
												<td>
													<strong>
														<b>
															Other Charge:
														</b>
													</strong>
												</td>
												<td>
													${productVO.receivableInfoOfOrder.totalFeeOfOthers}
												</td>
												<td>
							                                &nbsp;
												</td>
												<td>
							                                &nbsp;
												</td>
											</tr>
											[#list productVO.otherFeeList as otherFee]
											<tr class="1">
												<td>
													Other Charge：
												</td>
												<td>
													${otherFee.itemFee}
												</td>
												<td>
													Remark:
												</td>
												<td>
													${otherFee.remark}
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
															Other Discount:
														</b>
													</strong>
												</td>
												<td>
												0
												</td>
												<td>
							                                &nbsp;
												</td>
												<td>
							                                &nbsp;
												</td>
											</tr>
											[#list productVO.discountList as discount]
											<tr class="2">
												<td>
													Other Discount：
												</td>
												<td>
													${discount.itemFee}
												</td>
												<td>
													Remark:
												</td>
												<td>
													${discount.remark}
												</td>
												<input type="hidden" name="discountList[feeIndex].id" value="${discount.id}"/>
												<input class="num" type="hidden" name="discountList[feeIndex].num">
												<input type="hidden" name="discountList[feeIndex].type" value="3">
											</tr>
											[/#list]
											<tr class="sumFee">
												<td>
													<strong>
														<b>
															Total Amount：
														</b>
													</strong>
												</td>
												<td>
													${productVO.receivableInfoOfOrder.sumFee}
												</td>
												<td>
							                                &nbsp;
												</td>
												<td>
							                                &nbsp;
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
</div>
<table id="feeTemplate" style="display:none">
	<tr class="1">
		<td>
			Other Charge：
		</td>
		<td>
			<input class="form-control input-group1" name="otherFeeList[feeIndex].itemFee" onkeyup="showFeeTotal(1)" value="0" type="text" placeholder="其他费用">
		</td>
		<td>
			Remark:
		</td>
		<td>
			<input name="otherFeeList[feeIndex].remark" maxlength="100" size="30" value="" class="remarkCss form-control input-group1" type="text">
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this,1);">
		</td>
		<input type="hidden" class="num" name="otherFeeList[feeIndex].num">
		<input type="hidden" name="otherFeeList[feeIndex].type" value="2">
	</tr>
	<tr class="2">
		<td>
			Other Discount：
		</td>
		<td>
			<input class="form-control input-group1" name="discountList[feeIndex].itemFee" onkeyup="showFeeTotal(2);" value="0" type="text" placeholder="其他特殊折扣">
		</td>
		<td>
			Remark:
		</td>
		<td>
			<input name="discountList[feeIndex].remark" value="" class="remarkCss form-control input-group1" type="text">
		    &nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this,2);"></a>
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
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script><!-- -->
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script><!-- -->
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
		App.wizard();
		$("form select.select2").select2({
			width: '60%'
		});
		$("form div.datetime").datetimepicker({autoclose: true});
		$("#formSubmit").click(function(){
			submit();
		});
		initValue();
    });
    
    /* 初始化  */
    function initValue(){
	[#list productVO.customerFlights as cor]
		$("#ifPickUp_${cor_index}_${cor.customerFlightList[0].ifPickUp}").click();
		$("#ifSendUp_${cor_index}_${cor.customerFlightList[1].ifSendUp}").click();
		changeOption($("select.customerSelect").eq(${cor_index})[0]);
	[/#list]
		showFeeTotal(2);
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
    
    /* 增加费用或折扣  */
    function addFee(classNo){
    	var $newHtml = $("#feeTemplate").find("." + classNo).clone(true);
    	if(classNo == 1){
    		$("#feeTbody").find(".totalDiscountFee").before($newHtml);
    	}else{
    		$("#feeTbody").find(".sumFee").before($newHtml);
    	}
    }
    
    /* 删除费用或折扣  */
    function removeFee(button,classNo){
        $(button).parent().parent().remove();
        showFeeTotal(classNo);
    }
    
    /* 异步删除费用和折扣  */
    function deleteFee(button,classNo,id){
    	$("form").append('<input type="hidden" name="deleteItemIds" value="' + id + '"/>');
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
    	$tbody.children(".sumFee").find("input:first").val(totalCommonTourFee + totalOtherFee - discountFee);
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
        $trs.each(function() {
            var fee = $(this).children("td").eq(1).find("input").eq(0).val();
            sum += fee * 1;
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
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>
