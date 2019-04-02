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
			<h2>
				Booking
			</h2>
			<ol class="breadcrumb">
				<li>
					<a style="cursor:pointer;" href="../../">
						Home
					</a>
				</li>
				<li>
					<a style="cursor:pointer;" href="">
						Booking
					</a>
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
									Agency Info
									<span class="chevron">
									</span>
								</li>
								<li data-target="#step2">
									Passenger Info
									<span class="chevron">
									</span>
								</li>
								<li data-target="#step3">
									Product 1
									<span class="chevron">
									</span>
								</li>
								<li data-target="#step4" style="display:none">
									Product 2
									<span class="chevron">
									</span>
								</li>
								<li data-target="#step5" style="display:none">
									Product 3
									<span class="chevron">
									</span>
								</li>
							</ul>
							<div class="actions">
							    <!--
								<button type="button" class="btn btn-xs btn-prev btn-default">
									<i class="icon-arrow-left">
									</i>
									Prev
								</button>
								<button type="button" class="btn btn-xs btn-next btn-default" data-last="Finish">
									Next
									<i class="icon-arrow-right">
									</i>
								</button>
								-->
							</div>
						</div>
						<div class="step-content">
							<form class="form-horizontal group-border-dashed" id="form" action="${base}/admin/orders/save.jhtml" method="POST" data-parsley-namespace="data-parsley-"
								data-parsley-validate novalidate>
								<div class="step-pane active" id="step1">
									<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
										<i class="fa fa-sitemap"></i>
										<span>Agency Info</span>
							        </h4>
									<div class="form-group">
						                <label class="col-sm-3 control-label">Agency Name：</label>
						                <div class="col-sm-6">
							                <select name="vender.venderId" onchange="getVender(this.value);" class="select2"/>
  												<option value="0">--Select--</option>
												[#list venderList as vender]
												<option value="${vender.venderId}">${vender.name}</option>
												[/#list]
							                </select>
						                </div>
						            </div>
									<div class="form-group">
						                <label class="col-sm-3 control-label">Tel：</label>
						                <div class="col-sm-6">
						                  <input type="text" id="venderTel" readOnly="readonly" class="form-control input-group1"/>
						                </div>
						            </div>
									<div class="form-group">
						                <label class="col-sm-3 control-label">Add.：</label>
						                <div class="col-sm-6">
						                  <input type="text" id="venderAddress" readOnly="readOnly" class="form-control input-group1"/>
						                </div>
						            </div>
									<div class="form-group">
						                <label class="col-sm-3 control-label">Fax：</label>
						                <div class="col-sm-6">
						                  <input type="text" id="venderFax" readOnly="readOnly" class="form-control input-group1"/>
						                </div>
						            </div>
									<div class="form-group">
						                <label class="col-sm-3 control-label">Email：</label>
						                <div class="col-sm-6">
						                  <input type="text" id="venderEmail" readOnly="readOnly" class="form-control input-group1"/>
						                </div>
						            </div>
									<div class="form-group">
						                <label class="col-sm-3 control-label">Contacts：</label>
						                <div class="col-sm-6">
						                  <input type="text" id="venderContactor" readOnly="readOnly" class="form-control input-group1"/>
						                </div>
						            </div>
									<div class="form-group" align="right">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="button" class="btn btn-default" onclick="cancel();">
												Cancel
											</button>
											<button data-wizard="#wizard1" class="btn btn-primary wizard-next">
												Next Step
												<i class="fa fa-caret-right">
												</i>
											</button>
										</div>
									</div>
								</div>
								<div class="step-pane" id="step2">
									<div class="form-group no-padding">
										<div class="col-sm-7">
											<h3 class="hthin">
												Passenger Info
											</h3>
										</div>
									</div>
									
									<div id="addButton" class="new" style="text-align:right"><button class="btn btn-success" type="button" onclick="addCustomer();">&nbsp;&nbsp;And New Customer &nbsp;&nbsp;</button></div>
									
									<h4 style="background:#FDA445;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
										<i class="fa fa-mobile"></i>
										<span >Contacts Way</span>
							        </h4>
									<div style="width:auto;height:auto;margin:20px 0 0 0;border:0px none solid;padding:8px;">
										<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
											<tbody>
												<tr>
													<td width="13%">
														<span>
															Tel:
														</span>
													</td>
													<td width="37%">
										                <div class="col-sm">
										                  <input type="text" name="shareCustomer.tel" class="form-control input-group1"/>
										                </div>
													</td>
													<td>
														<span>
															Zip Code:
														</span>
													</td>
													<td>
													  	<div class="col-sm">
										                  <input type="text" name="shareCustomer.zip" class="form-control input-group1"/>
										                </div>
													</td>
												</tr>
												<tr>
													<td>
														<span>
															Country:
														</span>
													</td>
													<td>
														<select name="shareCustomer.countryId" onchange="generalStateSelect(this);" class="select2" style="width:148px;">
															<option value="0">
																--Select--
															</option>
															[#list countryList as country]
															<option value="${country.id}">
																${country.countryName}
															</option>
															[/#list]
														</select>
													</td>
													<td>
														<span>
															State:
														</span>
													</td>
													<td colspan="3">
														<select name="shareCustomer.stateId" class="select2" style="width:148px;">
															<option value="0">
																--Select--
															</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>
														<span>
															City:
														</span>
													</td>
													<td>
														<select name="shareCustomer.cityId" id="cityname" class="select2" style="width:148px;">
															<option value="0">
																--Select--
															</option>
															[#list cityList as city]
															<option value="${city.id}">
																${city.cityName}
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
										<div style="margin:20px 0 0 0;border-width: 80%;">
											<table style="border: 0px none" width="100%">
												<tbody>
													<tr>
														<td>
															<span>
																Domestic Flight:
															</span>
															<label class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="shareCustomer.planticket" value="1" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																		</ins>
																</div>
																Booked by Agent &nbsp;&nbsp;
															</label>
															<label class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="shareCustomer.planticket" value="2" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																		</ins>
																</div>
																Booked by Op &nbsp;&nbsp;
															</label>
															<label class="radio-inline">
																<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
																	<input class="icheck" type="radio" name="shareCustomer.planticket" value="3" checked="" style="position: absolute; opacity: 0;">
																		<ins class="iCheck-helper"
																			style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
																		</ins>
																</div>
																Booked by both Op & Agent
															</label>
														</td>
													</tr>
													<tr>
														<td>
															If the flight is booked by Agent，Please enter the flight info:
														</td>
													</tr>
													<tr>
														<td>
															<textarea cols="5" class="form-control input-group1" rows="4" name="shareCustomer.otherInfo" id="notesId" style="width:70%"></textarea>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="form-group" align="right">
										<div class="col-sm-offset-2 col-sm-10">
											<button data-wizard="#wizard1" class="btn btn-default wizard-previous">
												<i class="fa fa-caret-left">
												</i>
												Previous
											</button>
											<button data-wizard="#wizard1" class="btn btn-primary wizard-next">
												Next Step
												<i class="fa fa-caret-right">
												</i>
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
<div id="customerInputTemplate" class="customer_tab" style="display:none">
	<div class="customerInfo">
		<div name="slide_customerIndex">
			<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
				<i class="fa fa-bars"></i>
				<span class="customerNumber"></span>
				<div class="pull-right">
	               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
	           </div>
	        </h4>
		</div>
		<div style="#ccc;margin:0 0 8px 0;"></div>
		<div name="slideDiv_customerIndex" >
		<table style="padding:10px;border: 0px none" width="100%">
			<tbody>
				<tr>
					<td width="13%">
						<span>
							LastName:
						</span>
					</td>
					<td width="37%">
						<input class="form-control input-group1" name="customerList[customerIndex].lastName" type="text">
					</td>
					<td width="13%">
						<span>
							FirstName:
						</span>
					</td>
					<td width="37%">
						<input class="form-control input-group1" name="customerList[customerIndex].firstName" type="text">
					</td>
				</tr>
				<tr>
					<td>
						<span>
							MiddleName:
						</span>
					</td>
					<td>
						<input class="form-control input-group1" name="customerList[customerIndex].middleName" type="text">
					</td>
					<td>
						<span>
							Date of Birth:
						</span>
					</td>
					<td>
						<div>
							<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
								<input type="text" readonly="readonly" class="form-control" name="customerList[customerIndex].dateOfBirth">
								<span class="input-group-addon btn btn-primary">
									<span class="glyphicon glyphicon-th">
									</span>
								</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span>
							Nationality:
						</span>
					</td>
					<td>
						<input class="form-control input-group1" name="customerList[customerIndex].nationalityOfPassport" type="text">
					</td>
					<td>
						<span>
							Passport No.:
						</span>
					</td>
					<td>
						<input class="form-control input-group1" name="customerList[customerIndex].passportNo" type="text">
						<div></div>
					</td>
				</tr>
				<tr>
					<td>
						<span>
							Expiry Date:
						</span>
					</td>
					<td>
						<div>
							<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
								<input type="text" readonly="readonly" class="form-control" name="customerList[customerIndex].expireDateOfPassport">
								<span class="input-group-addon btn btn-primary">
									<span class="glyphicon glyphicon-th">
									</span>
								</span>
							</div>
						</div>
					</td>
					<td>
						<span>
							Gender :
						</span>
					</td>
					<td>
						<div>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customerList[customerIndex].sex" value="1" checked="" style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Female
							</label>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customerList[customerIndex].sex" value="2" checked="" style="position: absolute; opacity: 0;">
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
						<span>
							Remark:
						</span>
					</td>
					<td>
						<select name="customerList[customerIndex].memoOfCustomer" class="select2" style="width:140px;">
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
						<span>
							Language:
						</span>
					</td>
					<td>
						<select name="customerList[customerIndex].languageId" class="select2" style="width:140px">
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
				</tr>
				<tr>
					<td>
						<span>
							Room:
						</span>
					</td>
					<td>
						<select name="customerList[customerIndex].guestRoomType" class="select2" style="width:140px">
							<option value="0">
								--Select--
							</option>
							[#list constant.GUEST_ROOM_TYPES as room]
							<option value="${room}">
								${room}
							</option>
							[/#list]
						</select>
					</td>
					<td width="13%">
						<span>
							Phone:
						</span>
					</td>
					<td width="37%">
						<input class="form-control input-group1" name="customerList[customerIndex].mobile" type="text">
					</td>
				</tr>
				<tr>
					<td>
						<span>
							Emial:
						</span>
					</td>
					<td>
						<input class="form-control input-group1" name="customerList[customerIndex].email" type="text">
					</td>
					<td>
						<span>
							Address:
						</span>
					</td>
					<td>
						<input class="form-control input-group1" name="customerList[customerIndex].streetAddress" type="text">
					</td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
</div>
<div id="groupLineInputTemplate" class="step-pane" style="display:none">
	<div style="width: auto; height: auto; margin: 10px 0px 0px;">
		<div class="tourInformationTopic">
			<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
				<i class="fa fa-user"></i>
				<span>Tour Info</span>
				<div class="pull-right">
	               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
	           </div>
	        </h4>
	    </div>
		<div>
			<table style="border: 0px none">
				<tbody>
					<tr>
						<td style="width:10%">
							Tour Type
						</td>
						<td style="width:25%">
							<select name="eachGroupLineOrderList[groupLineIndex].order.tourTypeId" class="select2" onchange="generalGroupLineSelect(this);" style="width:150px;">
								<option value="0">
									--Select--
								</option>
								[#list tourTypeList as tourType]
								<option value="${tourType.tourTypeId}">
									${tourType.typeName}
								</option>
								[/#list]
							</select>
						</td>
						<td style="width:10%">
							Booking Type
						</td>
						<td style="width:25%">
							<select name="eachGroupLineOrderList[groupLineIndex].order.orderTourType" class="select2" style="width:150px;">
								<option value="Join-in Tour">
									Join-in Tour
								</option>
								<option value="Flight Booking">
									Flight
								</option>
								<option value="Hotel Booking">
									Hotel
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<div style="display: block;">
								Product Code:
							</div>
						</td>
						<td>
							<select name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.groupLineId" onchange="groupLineSelectChange(this);"
								readonly="readonly" type="text" class="select2" length="12">
								<option value="0">
									--Select--
								</option>
							</select>
							<font size="3px" color="red">*</font>
							<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.scheduleLineCode" />
							
						</td>
						<td>
							<div style="display: block;">
								Product Name:
							</div>
						</td>
						<td>
							<div style="display: block;" class="input-group1">
								<div class="col-sm">
									<input type="text" name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.lineName" class="form-control"/>
								</div>
							</div>
							<font size="3px" color="red">&nbsp;*</font>
						</td>
					</tr>
					<tr>
						<td>
							Arrival Date:
						</td>
						<td> 
							<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" style="float:left" data-min-view="2">
								<input type="text" class="form-control" name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.scheduleOfArriveTime">
								<span class="input-group-addon btn btn-primary">
									<span class="glyphicon glyphicon-th">
									</span>
								</span>
							</div>
							<font size="3px" color="red">
							    &nbsp;*
							</font>
						</td>
						<td>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div>
								<br>
									Requirement:
									<br>
										<br>
											<textarea name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.specialRequirements" cols="40" rows="8" class="form-control"></textarea>
							</div>
						</td>
						<td colspan="2">
							<div>
								<br>
									Remark:
									<br>
										<br>
											<textarea name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.tourInfo" cols="40" rows="8" class="form-control"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div>
								<br>
									Itinerary:
									<br>
										<br>
											<textarea name="eachGroupLineOrderList[groupLineIndex].tourInfoForOrder.personalRoute" cols="40" rows="8" class="form-control"></textarea>
							</div>
						</td>
						<td colspan="2">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="customerFlightInformationTopic">
			<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
				<i class="fa fa-plane"></i>
				<span>Flight Info</span>
				<div class="pull-right">
	               <i class="fa fa-angle-down"></i>&nbsp;&nbsp;
	           </div>
	        </h4>
        </div>
        <div style="display:none">
        </div>
        <div class="feeInformationTopic">
			<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
				<i class="fa fa-square"></i>
				<span>Tour Info</span>
				<div class="pull-right">
	               <i class="fa fa-angle-down"></i>&nbsp;&nbsp;
	           </div>
	        </h4>
        </div>
        <div class="feeInformation" style="display:none">
			<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
				<tbody>
					<tr class="commonTourFee">
						<td width="10%">
							Adult Tour Price:
						</td>
						<td width="40%">
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[0].itemFee" onkeyup="showRegularTourTotalFee(this);" maxlength="100" size="30" value="0" type="text">
						</td>
						<td width="10%">
							Number:
						</td>
						<td width="40%">
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[0].itemFeeNum" onkeyup="showRegularTourTotalFee(this);"
								maxlength="100" size="30" value="0" type="text" placeholder="Number">
								<div class="none">
								</div>
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[0].num" value="101">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[0].type" value="1">
					</tr>
					<tr class="commonTourFee">
						<td>
							Child Tour Price:
						</td>
						<td> 
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[1].itemFee" onkeyup="showRegularTourTotalFee(this);"
								maxlength="100" size="30" value="0" type="text" placeholder="Child Tour Price">
						</td>
						<td>
							Number:
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[1].itemFeeNum" onkeyup="showRegularTourTotalFee(this);"
								maxlength="100" size="30" value="0" type="text">
								<div class="none">
								</div>
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[1].num" value="102">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[1].type" value="1">
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
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].receivableInfoOfOrder.totalCommonTourFee" style="background-color:#dddddd;"
								value="0" readonly="readonly" type="text" placeholder="常规团费总额">
						</td>
						<td>
	                                &nbsp;
						</td>
						<td>
	                                &nbsp;
						</td>
					</tr>
					<tr class="otherFee">
						<td>
							成人佣金金额
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[2].itemFee" onkeyup="showOtherFeeTotal(this);" maxlength="100"
								size="30" value="0" type="text" placeholder="成人佣金金额">
						</td>
						<td>
							成人数量
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[2].itemFeeNum" onkeyup="showOtherFeeTotal(this);" maxlength="100"
								size="30" value="0" type="text" placeholder="成人数量">
								<div class="none">
								</div>
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[2].num" value="201">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[2].type" value="2">
					</tr>
					<tr class="otherFee">
						<td>
							小孩佣金金额
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[3].itemFee" onkeyup="showOtherFeeTotal(this);" value="0" type="text"
								placeholder="小孩佣金金额">
						</td>
						<td>
							小孩数量
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[3].itemFeeNum" onkeyup="showOtherFeeTotal(this);" size="30"
								value="0" type="text" placeholder="小孩数量">
								<div class="none">
								</div>
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[3].num" value="202">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[3].type" value="2">
					</tr>
					<tr>
						<td>
							小费金额
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[4].itemFee" onkeyup="showTotal(this);" maxlength="100"
								size="30" value="0" type="text" placeholder="小费金额">
						</td>
						<td>
							小费人数
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[4].itemFeeNum" onkeyup="showTotal(this);" maxlength="100"
								size="30" value="0" type="text" placeholder="小费人数">
								<div class="none">
								</div>
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[4].num" value="203">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[4].type" value="2">
					</tr>
					<tr class="totalTip">
						<td>
							小费总额：
						</td>
						<td>
							<input class="form-control input-group1" readonly="readonly" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[5].itemFee"
								style="background-color:#dddddd;" value="0" type="text" placeholder="小费总额">
						</td>
						<td>
							备注:
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[5].remark" value="" class="remarkCss form-control input-group1" type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[5].num" value="204">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[5].type" value="2">
					</tr>
					<tr>
						<td>
							自费金额
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[6].itemFee" onkeyup="showTotal(this);"
								maxlength="100" size="30" value="0" type="text" placeholder="自费金额">
						</td>
						<td>
							自费人数
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[6].itemFeeNum" onkeyup="showTotal(this);"
								maxlength="100" size="30" value="0" type="text" placeholder="自费人数">
								<div class="none">
								</div>
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[6].num" value="205">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[6].type" value="2">
					</tr>
					<tr class="totalSelfPay">
						<td>
							自费总额：
						</td>
						<td>
							<input class="form-control input-group1" readonly="readonly" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[7].itemFee" style="background-color:#dddddd;"
								value="0" type="text">
						</td>
						<td>
							备注:
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[7].remark" value="" class="remarkCss form-control input-group1" type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[7].num" value="206">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[7].type" value="2">
					</tr>
					<tr class="otherFeeRemark">
						<td>
							代订酒店费用：
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[8].itemFee" onkeyup="showOtherFeeTotal(this);"
								maxlength="100" size="30" value="0" type="text" placeholder="代订酒店费用">
						</td>
						<td>
							备注：
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[8].remark" value="" class="remarkCss form-control input-group1" type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[8].num" value="207">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[8].type" value="2">
					</tr>
					<tr class="otherFeeRemark">
						<td>
							单房差费用：
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[9].itemFee" onkeyup="showOtherFeeTotal(this);" maxlength="100"
								size="30" value="0" type="text" placeholder="单房差费用">
						</td>
						<td>
							备注：
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[9].remark" maxlength="100" size="30" value="" class="remarkCss form-control input-group1"
								type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[9].num" value="208">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[9].type" value="2">
					</tr>
					<tr class="otherFeeRemark">
						<td>
							签证费用：
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[10].itemFee" onkeyup="showOtherFeeTotal(this);" maxlength="100"
								size="30" value="0" type="text" placeholder="签证费用">
						</td>
						<td>
							备注
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[10].remark" maxlength="100" size="30" class="remarkCss form-control input-group1"
								type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[10].num" value="209">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[10].type" value="2">
					</tr>
					<tr class="otherFeeRemark">
						<td>
							保险费用：
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[11].itemFee" onkeyup="showOtherFeeTotal(this);"
								maxlength="100" size="30" value="0" type="text" placeholder="保险费用">
						</td>
						<td>
							备注
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[11].remark" value="" class="remarkCss form-control input-group1"
								type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[11].num" value="210">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[11].type" value="2">
					</tr>
					<tr class="otherFeeRemark">
						<td>
							机票：
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[12].itemFee" onkeyup="showOtherFeeTotal(this);" value="0"
								type="text" placeholder="机票">
						</td>
						<td>
							备注:
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[12].remark" value="" class="remarkCss form-control input-group1"
								type="text">
						</td>
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[12].num" value="211">
					    <input type="hidden" name="eachGroupLineOrderList[groupLineIndex].orderReceiveItemList[12].type" value="2">
					</tr>
					<tr class="1 otherFeeRemark">
						<td>
							其他费用：
						</td>
						<td>
							<input class="form-control input-group1 fee" name="eachGroupLineOrderList[groupLineIndex].otherFeeList[].itemFee" onkeyup="showOtherFeeTotal(this);"
								value="0" type="text" placeholder="其他费用">
						</td>
						<td>
							备注:
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].otherFeeList[].remark" maxlength="100" size="30" value=""
								class="remarkCss form-control remark input-group1" type="text">
								&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,1);"></a>
						</td>
						<input type="hidden" class="num" name="eachGroupLineOrderList[groupLineIndex].otherFeeList[].num">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].otherFeeList[].type" value="2">
					</tr>
					<tr class="totalOtherFee">
						<td>
							<strong>
								<b>
									其他费用总额:
								</b>
							</strong>
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].receivableInfoOfOrder.totalFeeOfOthers" style="background-color:#dddddd;"
								value="0" readonly="readonly" type="text" placeholder="其他费用总额">
						</td>
						<td>
	                                &nbsp;
						</td>
						<td>
	                                &nbsp;
						</td>
					</tr>
					<tr class="2 discountFee">
						<td>
							其他特殊折扣：
						</td>
						<td>
							<input class="form-control input-group1 fee" name="eachGroupLineOrderList[groupLineIndex].discountList[].itemFee" onkeyup="showSumFee(this);" value="0"
								type="text" placeholder="其他特殊折扣">
						</td>
						<td>
							备注:
						</td>
						<td>
							<input name="eachGroupLineOrderList[groupLineIndex].discountList[].remark" value="" class="remarkCss form-control input-group1 remark" type="text">
								&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee(this,2);"></a>
						</td>
						<input class="num" type="hidden" name="eachGroupLineOrderList[groupLineIndex].discountList[].num">
						<input type="hidden" name="eachGroupLineOrderList[groupLineIndex].discountList[].type" value="3">
					</tr>
					<tr class="sumFee">
						<td>
							<strong>
								<b>
									共计应收团款：
								</b>
							</strong>
						</td>
						<td>
							<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].receivableInfoOfOrder.sumFee" style="background-color:#dddddd;"
								value="0" readonly="readonly" type="text" placeholder="共计应收团款">
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
	<div class="form-group" align="right">
		<div class="col-sm-12">
			<button data-wizard="#wizard1" class="btn btn-default wizard-previous">
				<i class="fa fa-caret-left">
				</i>
				Previous
			</button>
			<button data-wizard="#wizard1" onclick="addGroup(this);" class="btn btn-primary wizard-next">
				Add Product
				<i class="fa fa-caret-right">
				</i>
			</button>
			<button type="submit" onclick="submit();" data-wizard="#wizard1" class="btn btn-success wizard-next">
				<i class="fa fa-check">
				</i>
				Save
			</button>
		</div>
	</div>
</div>
<div id="customerFlightInputTemplate" class="customerFlight_div" style="display:none">
		<h4 class="customerNumber">
		</h4>
		<table style="border: 0px none">
		<tbody>
			<tr>
				<td colspan="4">
							入境航班:
				</td>
			</tr>
			<div style="border:solid 1px #ccc;margin:0 0 8px 0;"></div>
			<tr>
				<td>
					<span>
						航空公司代码:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].flightCode" type="text">
				</td>
				<td>
					<span>
						航班号:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].flightNumber" type="text">
				</td>
			</tr>
			<tr>
				<td>
					<span>
						抵达日期:
					</span>
				</td>
				<td>
					<div>
						<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
							<input type="text" class="form-control" readOnly="readOnly" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].arriveDate">
							<span class="input-group-addon btn btn-primary">
								<span class="glyphicon glyphicon-th">
								</span>
							</span>
						</div>
					</div>			
				</td>
				<td>
					<span>
						抵达时间:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" size="16" type="text" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].arriveTime" />
				</td>
			</tr>
			<tr>
				<td>
					<span>
						接机:
					</span>
				</td>
				<td>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].ifPickUp" value="1" checked=""
								style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						是 &nbsp;&nbsp;
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].ifPickUp" value="2" checked=""
								style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						否
					</label>
				</td>
				<td style="display:none">
					<span>
						航班类型:
					</span>
				</td>
				<td style="display:none">
					<!-- 出入境 ，入境 -->
					<input class="hasDatepicker" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][0].outOrEnter" value="1" type="hidden">
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<br>
						<div>
							出境航班:
						</div>
				</td>
			</tr>
			<tr>
				<td colspan="">
					<span>
						航空公司代码:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].flightCode" type="text">
				</td>
				<td>
					<span>
						航班号:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].flightNumber" type="text">
				</td>
			</tr>
			<tr>
				<td>
					<span>
						出境日期:
					</span>
				</td>
				<td>
					<div>
						<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
							<input type="text" class="form-control" readOnly="readOnly" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].arriveDate">
							<span class="input-group-addon btn btn-primary">
								<span class="glyphicon glyphicon-th">
								</span>
							</span>
						</div>
					</div>	
				</td>
				<td>
					<span>
						起飞时间:
					</span>
				</td>
				<td>
					<input class="form-control input-group1" size="16" type="text" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].arriveTime" />
				</td>
			</tr>
			<tr>
				<td>
					<span>
						送机:
					</span>
				</td>
				<td>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].ifSendUp" value="1"
								style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						是 &nbsp;&nbsp;
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].ifSendUp" value="2" checked=""
								style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						否
					</label>
				</td>
				<td>
				</td>
				<td>
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
					<!-- 出入境 ，入境 -->
					<input class="hasDatepicker" name="eachGroupLineOrderList[groupLineIndex].customerFlightList[customerIndex][1].outOrEnter" value="2" type="hidden">
				</td>
			</tr>
		</tbody>
	</table>
</div>
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
    $(document).ready(function() {
        //initialize the javascript
        App.init();
        App.wizard();
        generalHtml();
        
        $("div[name^='slide_']").click(function(){
			var name=$(this).attr("name");
			var space=name.indexOf("_", 0)+1;
			var num=name.substring(space);
			
			$("div[name='slideDiv_"+num+"']").slideToggle("slow");
			
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
		
		
		$(".tourInformationTopic,.customerFlightInformationTopic,.feeInformationTopic").click(function(){
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
    });
	
	/* 初始化页面  */
    function generalHtml(){
        $("form select.select2").select2({
        	width: '60%'
        });
    	addCustomer();
	    initAddHtml(generalGroupLineInputHtml(0).appendTo($("#form")));
    }
	    
    /* 添加客人  */
    function addCustomer(number) {
    	var customerIndex = $(".customer_tab").size() - 2;
    	var $addButton = $("#addButton");
    	var $feeInformation = $(".feeInformation");
		initAddHtml(generalCustomerInputHtml(++customerIndex).insertBefore($addButton));
		$feeInformation.each(function(){
			var name = $(this).find("input:first").attr("name");
			var groupLineIndex = name.substring(name.indexOf("[") + 1, name.indexOf("]"));
			var $addHtml = generalCustomerFlightInputHtml(groupLineIndex, customerIndex).appendTo($(this).prev().prev());
			if(groupLineIndex != 'groupLineIndex') {
				initAddHtml($addHtml);
			}
		});
    }
    
    /* 删除客人  */
    function deleteCustomer(number) {
    	var $step = $("#step2"); 
    	var $stepPane = $(".step-pane");
        for(var i=0; i<number; i++){
	    	$step.find(".customer_tab:last").remove();
	    	$stepPane.find(".customerFlight_div:last").remove();
        }
    }
    
    /* 添加一条线路  */
    function addGroup(addButton) {
        $(".steps li:hidden:first").removeAttr("style");
        var groupLineIndex = $(".step-pane").size() - 3;
        var $addHtml = initAddHtml(generalGroupLineInputHtml(groupLineIndex).appendTo($("form")));
        if(groupLineIndex == 2){
        	$addHtml.find("button:last").remove();
        }
        $(addButton).prev().remove();
        $(addButton).html('Next Step <i class="fa fa-caret-right"></i>').removeAttr("onclick");
    }
    
    /* 初始化添加的元素  */
    function initAddHtml($addHtml){
        $addHtml.find("div.datetime").datetimepicker({autoclose: true});
    	$addHtml.find('.icheck').iCheck({
          checkboxClass: 'icheckbox_square-blue checkbox',
          radioClass: 'iradio_square-blue'
        });
        $addHtml.find("select.select2").select2({
        	width: '60%'
        }); 
        return $addHtml;
    }
	    
    /* 根据同行Id获得同行信息  */
    function getVender(venderId){
    	if(venderId == 0){
    		$("#venderTel").val('');
    		$("#venderAddress").val('');
    		$("#venderFax").val('');
    		$("#venderEmail").val('');
    		$("#venderContactor").val('');
    		return;
    	}
    	$.post("getVender.jhtml",{'venderId':venderId},function(vender){
    		$("#venderTel").val(vender.tel);
    		$("#venderAddress").val(vender.address);
    		$("#venderFax").val(vender.fax);
    		$("#venderEmail").val(vender.email);
    		$("#venderContactor").val(vender.contactor);
    	});
    }

    /* 根据 totalPeople 动态增减 customer 输入的div */
    function changeCustomerNumber(customerNumberSelect) {
        var totalPeople = $(customerNumberSelect).val() * 1;
        var len = $(".customer_tab").size() - 1;
        if (totalPeople == len) {
            return;
        }
        if (totalPeople < len) {
            deleteCustomer(len - totalPeople);
        } else {
			addCustomer(totalPeople - len);
        }
    }
	
    /* 删除一个客人 */	
    function removeCustomer() {
        var $customerSelect = $("#customerNumberSelect");
        var numberOfCustomer = $customerSelect.val() * 1;
        if (numberOfCustomer == 1) {
            alert("只剩一个客人，不能删除！");
            return;
        }
        $customerSelect.val(numberOfCustomer - 1);
        deleteCustomer(1);
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
	
	var groupLineMap;
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
            $(groupLineSelect).next().val($(groupLineSelect).find("option:selected").text());
            $groupLineNameInput.attr("readonly", "readonly");
            $groupLineNameInput.val(groupLineMap[groupLineId].tourName);
        } else {
            $(groupLineSelect).next().val("");
            $groupLineNameInput.removeAttr("readonly");
            $groupLineNameInput.val('');
        }
    }
    
    /* 增加费用或折扣  */
    function addFee(addButton, classNo){
    	var $template = $(addButton).parent().parent().parent().find("." + classNo + ":last");
    	var $newHtml = $template.clone(true);
    	$newHtml.find("input").each(function(){
	    	if($(this).hasClass("fee")){
	    		$(this).val('0');
	    	}else if($(this).hasClass("remark")){
	    		$(this).val('');
	    	}
    	});
    	$newHtml.find("a").attr("onclick","removeFee(this);").removeClass("fa fa-plus").addClass("fa fa-minus");
    	$template.after($newHtml);
    }
    
    /* 删除费用或折扣  */
    function removeFee(button) {
        var $fee = $(button).parent().parent();
        var $input = $fee.parent().find("input");
        $fee.remove();
        showOtherFeeTotal($input[0]);
    }
    
    /* 取消的动作 */
    function cancel(){
    	window.location.href="list.jhtml";
    }
	
	/* 提交表单 */
    function submit() {
    	/* 遍历每条线路 */
    	$("form .feeInformation").each(function(index){
    		/* 遍历每个其他费用  */
    		$(this).find(".1").each(function(index){
    			$(this).find("input").each(function(){
                    addFeeOrDiscountIndex($(this),index);
    				if($(this).hasClass("num")){
    					$(this).val(220 + index);
    				}
    			});
    		});
    		
    		/* 遍历每个其他特殊折扣  */
    		$(this).find(".2").each(function(index){
    			$(this).find("input").each(function(){
                    addFeeOrDiscountIndex($(this),index);
    				if($(this).hasClass("num")){
    					$(this).val(300 + index);
    				}
    			});
    		});
    	});
    	$("form").submit();
    }
	
	/* 给其他费用以及折扣生成list下标  */
	function addFeeOrDiscountIndex($input,index){
		var name = $input.attr("name");
		var position = name.lastIndexOf("]");
		name = name.substring(0,position) + index + name.substring(position,name.length);
		$input.attr("name",name);
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

	/* 根据模板生成customer输入的html */
    function generalCustomerInputHtml(customerIndex) {
		$customerInput = $("#customerInputTemplate").clone(true).removeAttr("id").removeAttr("style");
		$customerInput.find(".customerNumber").text("No."+(customerIndex+1));
		$customerInput.find("input,select,div").each(function(){
			var name = $(this).attr("name");
			if(name != undefined){
				$(this).attr("name",name.replace("customerIndex",customerIndex));
			}
		});
		return $customerInput;
    } 
    
    /* 根据模板生成线路输入的html */
    function generalGroupLineInputHtml(groupLineIndex) {
    	$groupLineInput = $("#groupLineInputTemplate").clone(true).attr("id","step" + (groupLineIndex + 3)).removeAttr("style");
    	$groupLineInput.find("input,select,textarea").each(function(){
			var name = $(this).attr("name");
			if(name != undefined){
				$(this).attr("name",name.replace("groupLineIndex",groupLineIndex));
			}
		});
		return $groupLineInput;
    } 

	/* 根据模板生成customerFlight输入的html */
    function generalCustomerFlightInputHtml(groupLineIndex, customerIndex) {
    	$customerFlightInput = $("#customerFlightInputTemplate").clone(true).removeAttr("id").removeAttr("style");
    	$customerFlightInput.find(".customerNumber").text("No."+(customerIndex+1));
    	$customerFlightInput.find("input").each(function(){
			var name = $(this).attr("name");
			if(name != undefined){
				$(this).attr("name",name.replace("groupLineIndex",groupLineIndex).replace("customerIndex",customerIndex));
			}
		});
		return $customerFlightInput;
    }
</script>
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
