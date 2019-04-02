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
            <h2>Edit</h2>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking</a></li>
                <li><a style="cursor:pointer;" href="list">Other Booking</a></li>
            </ol>
        </div>
        <div class="cl-mcont">		
    <div class="row wizard-row">
      <div class="col-md-12 fuelux">
        <div class="block-wizard">
          <div id="wizard1" class="wizard wizard-ux">
            <ul class="steps">
             <li data-target="#step1" class="active">Passenger Info<span class="chevron"></span></li>
              <li data-target="#step2">Charge Info<span class="chevron"></span></li>
            </ul>
          </div>
          <div class="step-content">
            <form class="form-horizontal group-border-dashed" action="update.jhtml" method="post" data-parsley-namespace="data-parsley-" data-parsley-validate novalidate> 
				<input type="hidden" name="tourInfoForOrder.id" value="${singleOrdersVO.tourInfoForOrder.id}">
				<input type="hidden" name="receivableInfoOfOrder.id" value="${singleOrdersVO.receivableInfoOfOrder.id}">
				<input type="hidden" name="order.id" value="${singleOrdersVO.order.id}">
				<input type="hidden" name="customer.customerId" value="${singleOrdersVO.customer.customerId}">
				<div class="step-pane active" id="step1">
					<div class="form-group no-padding">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
							<i class="fa fa-bars"></i>
							<span>Passenger Info</span>
				        </h4>
					</div>
	                <div style="width:auto;height:auto;margin:20px 0 0 0;border:0px none solid;padding:8px;">
						<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
							<tbody>
								<tr>
									<td width="13%">
										<span>
											LastName:
										</span>
									</td>
									<td width="37%">
										<input type="text" name="customer.lastName" value="${singleOrdersVO.customer.lastName}" class="form-control input-group1" placeholder="">
									</td>
									<td>
										<span>
											FirstName:
										</span>
									</td>
									<td>
										<input type="text" name="customer.firstName" value="${singleOrdersVO.customer.firstName}" class="form-control input-group1" placeholder="">
									</td>
								</tr>
								<tr>
									<td>
										<span>
											MiddleName:
										</span>
									</td>
									<td>
										<input type="text" name="customer.middleName" value="${singleOrdersVO.customer.middleName}" class="form-control input-group1" placeholder="">
									</td>
									<td>
										<span>
											Date of Birth:
										</span>
									</td>
									<td>
										<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
											<input name="customer.dateOfBirth" [#if (singleOrdersVO.customer.dateOfBirth)??]value="${singleOrdersVO.customer.dateOfBirth?string('yyyy-MM-dd')}"[/#if] class="form-control input-group1" readonly="readonly" type="text" size="16">
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th"></span>
											</span>
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
										<select type="text" name="customer.countryId" onchange="generalStateSelect(this);" class="select2">
											<option value="0">--Select--</option>
											[#list countrys as country]
												<option value="${country.id}" [#if country.id == singleOrdersVO.customer.countryId]selected="true"[/#if]>${country.countryName}</option>
											[/#list]
										</select>
									</td>
									<td>
										<span>
											State:
										</span>
									</td>
									<td>
										<select type="text" name="customer.stateId" class="select2">
											<option value="0">--Select--</option>
											[#list states as state]
												<option value="${state.id}" [#if state.id == singleOrdersVO.customer.stateId]selected="true"[/#if]>${state.stateName}</option>
											[/#list]
										</select>
									</td>
								</tr>
								<tr>	
									<td>
										<span>
											Nationality:
										</span>
									</td>
									<td>
										<input type="text" name="customer.nationalityOfPassport" value="${singleOrdersVO.customer.nationalityOfPassport}" class="form-control input-group1" placeholder="">
									</td>
									<td>
										<span>
											Passport No.:
										</span>
									</td>
									<td>
										<input type="text" name="customer.passportNo" value="${singleOrdersVO.customer.passportNo}" class="form-control input-group1" placeholder="">
									</td>
								</tr>
								<tr>	
									<td>
										<span>
											Expiry Date:
										</span>
									</td>
									<td>
										<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
											<input name="customer.expireDateOfPassport" [#if (singleOrdersVO.customer.expireDateOfPassport)??]value="${singleOrdersVO.customer.expireDateOfPassport?string('yyyy-MM-dd')}"[/#if] class="form-control input-group1" readonly="readonly" type="text" size="16">
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th"></span>
											</span>
										</div>
									</td>
									<td>
										<span>
											Gender:
										</span>
									</td>
									<td>
										<div>
											<label id="sex_1" class="radio-inline">
												<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
													<input class="icheck" type="radio" name="customer.sex" value="1" checked="" style="position: absolute; opacity: 0;">
														<ins class="iCheck-helper"
															style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
														</ins>
												</div>
												Female
											</label>
											<label id="sex_2" class="radio-inline">
												<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
													<input class="icheck" type="radio" name="customer.sex" value="2" checked="" style="position: absolute; opacity: 0;">
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
										<select class="select2" name="customer.memoOfCustomer">
											<option value="0">--Select--</option>
											[#list constant.CUSTOMER_MEMOS as val]
												<option value="${val}" [#if val == singleOrdersVO.customer.memoOfCustomer]selected="true"[/#if]>${val}</option>
											[/#list]
										</select>
									</td>
									<td>
										<span>
											Language:
										</span>
									</td>
									<td>
										<select class="select2" name="customer.languageId">
											<option value="0">--Select--</option>
											[#list  languages as language]
												<option value="${language.languageId}" [#if language.languageId ==  singleOrdersVO.customer.languageId]selected="true"[/#if]>${language.language}</option>
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
										<select class="select2" name="customer.guestRoomType">
											<option value="0">--Select--</option>
											[#list constant.GUEST_ROOM_TYPES as val]
												<option value="${val}" [#if val == singleOrdersVO.customer.guestRoomType]selected="true"[/#if]>${val}</option>
											[/#list]
										</select>
									</td>
									<td>
										<span>
											Phone:
										</span>
									</td>
									<td>
										<input type="text" name="customer.tel" value="${singleOrdersVO.customer.tel}" class="form-control input-group1" placeholder="">
									</td>
								</tr>
								<tr>	
									<td>
										<span>
											Email:
										</span>
									</td>
									<td>
										<input type="text" name="customer.email" value="${singleOrdersVO.customer.email}" class="form-control input-group1" placeholder="">
									</td>
									<td>
										<span>
											Address:
										</span>
									</td>
									<td>
										<input type="text" name="customer.streetAddress" value="${singleOrdersVO.customer.streetAddress}" class="form-control input-group1" placeholder="">
									</td>
								</tr>
								<tr>	
									<td>
										<span>
											Persons:
										</span>
									</td>
									<td>
										<input type="text" name="order.totalPeople" value="${singleOrdersVO.order.totalPeople}" class="form-control input-group1" placeholder="">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="form-group " align="right">
						<div class="col-sm-offset-2 col-sm-10">
							<button class="btn btn-default">Cancel</button>
							<button data-wizard="#wizard1" class="btn btn-primary wizard-next">Next Step <i class="fa fa-caret-right"></i></button>
						</div>
					</div>
				</div>
				<div class="step-pane" id="step2">
						<div class="form-group no-padding">
							<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
								<i class="fa fa-bars"></i>
								<span>Charge</span>
					        </h4>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<label style="display: inline-flex;" class="checkbox-inline">Type:</label>
								<label style="display: inline-flex;" class="checkbox-inline"><input id="visaId" name="order.nonGroupType" value="1" type="checkbox" class="icheck"> Visa </label>
								<label style="display: inline-flex;" class="checkbox-inline"><input id="flightTicketId" name="order.nonGroupType" value="2" type="checkbox" class="icheck"> Flight ticket </label>
								<label style="display: inline-flex;" class="checkbox-inline"><input id="hotelId" name="order.nonGroupType" value="3" type="checkbox" class="icheck"> Hotel </label>
								<label style="display: inline-flex;" class="checkbox-inline"><input id="ticketId" name="order.nonGroupType" value="4" type="checkbox" class="icheck"> Ticket </label>
								<label style="display: inline-flex;" class="checkbox-inline"><input id="insuranceId" name="order.nonGroupType" value="5" type="checkbox" class="icheck"> Insurance </label>
								<label style="display: inline-flex;" class="checkbox-inline"><input id="otherId" name="order.nonGroupType" value="6" type="checkbox" class="icheck"> Other </label>
							</div>
						</div>

						<div>
							<table id="feeTable" class="no-border">
								<tbody id="visa"sum="0">
								</tbody>
								<tbody id="flightTicket" sum="0">
								</tbody>
								<tbody id="hotel" sum="0">
								</tbody>
								<tbody id="ticket" sum="0">
								</tbody>
								<tbody id="insurance" sum="0">
								</tbody>
								<tbody id="other" sum="0">
								</tbody>
							</table>
						</div>

						<div style="margin:10px 0 15px 0;">
							<div style="text-align: right; ">
								Total Tour Accounts Receivable： <input class="form-control input-group1" name="receivableInfoOfOrder.sumFee" id="AllSum" style=" width:120px;float:right;" value="${singleOrdersVO.receivableInfoOfOrder.sumFee}" readonly="readonly" type="text">
							</div>
						</div>
					
						<div style="width: auto; height: auto; margin: 10px 0px 0px;">
							<div class="tourInformationTopic">
								<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
									<span>Remark</span>
								</h4>
							</div>
							<table style="border: 0px none">
								<tbody>
									<tr>
										<td>
											<div style="display: block;">
												Contacts:
											</div>
										</td>
										<td>
											<input class="form-control input-group1" name="order.contact" value="${singleOrdersVO.order.contact}" type="text">
										</td>
									</tr>
						            <tr>
						            	<td colspan="2">
						              		<br>Remarks:<br><br>
						                    <textarea name="tourInfoForOrder.specialRequirements" style="width:95%;height:200px">${singleOrdersVO.tourInfoForOrder.specialRequirements}</textarea>
						                </td>
										<td colspan="2">
									    	<br>Itinerary:<br><br>
									        <textarea name="tourInfoForOrder.personalRoute" style="width:95%;height:200px">${singleOrdersVO.tourInfoForOrder.personalRoute}</textarea>
									    </td>
									 </tr>
								</tbody>
							</table>
				        </div>
				        <br>
		  				<div class="form-group" align="right">
		                  <div class="col-sm-12">
		                    <button data-wizard="#wizard1" class="btn btn-default wizard-previous"><i class="fa fa-caret-left"></i> Previous</button>
		                    <button type="button" id="formSubmit" data-wizard="#wizard1" class="btn btn-success wizard-next"><i class="fa fa-check"></i> Save </button>
		                  </div>
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
<table style="display:none">
	<tbody id="template">
		<tr class="visaInput" subtotal="0">
			<td style="width:10% ;" rowspan="10">Visa</td>
			<td style="width:8% ;">Visa Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="visaFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"> </div></td>
			<td style="width:8% ;">Passports</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="visaFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars"  value="0" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="visaFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('visa');"></a></td>
			<input type="hidden" class="num" name="visaFeeList[].num">
			<input type="hidden" name="visaFeeList[].type" value="1">
		</tr>
		<tr class="flightTicketInput" subtotal="0">
			<td rowspan="10" style="width:10%;"> Flight ticket </td>
			<td style="width:8% ;">Departure Flight Date<font color="red">*</font></td>
			<td style="width:32% ;" colspan="3">
			  	<div class="input-group date datetime" style=" margin-bottom: 0;" data-date-format="yyyy-mm-dd" data-min-view="2">
	               <input id="arriveDate" class="form-control" name="order.arriveDate" readonly="readonly" type="text">
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
			        </span></div></td>
			<td style="width:8% ;">PNR<font color="red"> *</font></td>
			<td  colspan="3"> <input class="form-control" name="order.flightPnr" type="text"></td>
		</tr>
		<tr class="flightTicketInput flightTicketFeeInput" subtotal="0">
		    <td>Airfare</td>
		    <td class="itemFee"><input class="form-control" name="flightTicketFeeList[].itemFee" onkeyup="showSubTotal(this);"  value="0" type="text"></td>
		    <td>Tickes</td>
		    <td class="itemFeeNum"><input class="form-control" name="flightTicketFeeList[].itemFeeNum" onkeyup="showSubTotal(this);"  maxlength="2" required placeholder="Max 2 chars" value="0" type="text"></td>
		    <td>Subtotal</td>
		    <td  class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
		    <td>Remark</td>
		    <td><input class="form-control" style="float:left;width:90%;" name="flightTicketFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('flightTicket');"></a></td>
		    <input type="hidden" class="num" name="flightTicketFeeList[].num">
			<input type="hidden" name="flightTicketFeeList[].type" value="2">
		</tr>
		<tr class="hotelInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Hotel</td>
			<td style="width:8% ;">Room Rate</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="hotelFeeList[].itemFee" onkeyup="showSubTotal(this);"  value="0" type="text"></td>
			<td style="width:8% ;">Rooms</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="hotelFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" value="0" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;"  class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="hotelFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('hotel');"></a></td>
			<input type="hidden" class="num" name="hotelFeeList[].num">
			<input type="hidden" name="hotelFeeList[].type" value="3">
		</tr>
		<tr class="ticketInput" subtotal="0">
			<td style="width:10% ;" rowspan="10"> Ticket </td>
			<td style="width:8% ;">Addmission Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="ticketFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td style="width:8% ;">Entrance Tickets</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="ticketFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" value="0" maxlength="2" required onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="ticketFeeList[].remark" id="hotelExplain" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('ticket');"></a></td>
			<input type="hidden" class="num" name="ticketFeeList[].num">
			<input type="hidden" name="ticketFeeList[].type" value="4">
		</tr>
		<tr class="insuranceInput" subtotal="0">
			<td rowspan="5" style="width:10%;">Insurance</td>
			<td style="width:8% ;">Gold plan Insurance Charge</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="insuranceFeeList[0].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Plans</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="insuranceFeeList[0].itemFeeNum"  onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[0].remark" type="text"></td>
			<input type="hidden" class="num" name="insuranceFeeList[0].num" value="501">
			<input type="hidden" name="insuranceFeeList[0].type" value="5">
		</tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Silver plan Insurance Charge</td>
			<td class="itemFee"><input class="form-control" name="insuranceFeeList[1].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td>Plans</td>
			<td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[1].itemFeeNum"  onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[1].remark" type="text"></td>
			<input type="hidden" class="num" name="insuranceFeeList[1].num" value="502">
			<input type="hidden" name="insuranceFeeList[1].type" value="5">
		</tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Cancel for any reason Insurance Charge</td>
			<td class="itemFee"><input class="form-control" name="insuranceFeeList[2].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td>Plans</td>
		    <td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[2].itemFeeNum" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[2].remark" type="text"></td>
			<input type="hidden" class="num" name="insuranceFeeList[2].num" value="503">
			<input type="hidden" name="insuranceFeeList[2].type" value="5">
		</tr>
		<tr class="insuranceInput" subtotal="0"><td colspan="4">Tour Info</td></tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Arrival Date<font color="red" size="3px">*</font></td>
			<td colspan="3">
			<div style=" margin-bottom: 0;" class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
                <input id="departureDate" class="form-control" name="tourInfoForOrder.departureDate" readonly="readonly" type="text">
				<span class="input-group-addon btn btn-primary">
			    <span class="glyphicon glyphicon-th"></span>
		        </span>
			</div>
			</td>
			<td>Days<font color="red" size="3px">*</font></td>
			<td colspan="3"><input class="form-control" name="tourInfoForOrder.dayNum" value="0" type="text"></td>
		</tr>
		<tr class="otherInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Other</td>
			<td style="width:8% ;">Other Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="otherFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="otherFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="0"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="otherFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('other');"></a></td>
			<input type="hidden" class="num" name="otherFeeList[].num">
			<input type="hidden" name="otherFeeList[].type" value="6">
		</tr>
		<tr class="1">
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<div class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
				    <input class="form-control" name="payRecordsList[].time" readonly="readonly" type="text" size="20">
					<span class="input-group-addon btn btn-primary">
					     <span class="glyphicon glyphicon-th"></span>
				    </span>
				</div>
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<input name="payRecordsList[].sum" value="0" class="form-control" size="15" type="text">
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<select name="payRecordsList[].item" class="select2">
			    [#list constant.PAYMENT_ITEMS as val]
					<option value="${val}">${val}</option>
				[/#list]
				</select>
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<select name="payRecordsList[].way" class="select2">
				[#list constant.PAYMENT_WAYS as val]
					<option value="${val}">${val}</option>
				[/#list]
				</select>
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			    <input class="form-control" name="payRecordsList[].code" size="20" type="text">
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<input class="form-control" name="payRecordsList[].remark" size="20" type="text">
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			    <a style="cursor:pointer;" class="fa fa-minus" onclick="removeTr(this);">
			</td>
			<input type="hidden" name="payRecordsList[].payOrCost" value="1">
		</tr>
		<tr class="2">
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<div class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
		            <input class="form-control" name="costRecordsList[].time" readonly="readonly" type="text" size="20">
					<span class="input-group-addon btn btn-primary">
					     <span class="glyphicon glyphicon-th"></span>
			        </span>
		       </div>
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<input name="costRecordsList[].sum" value="0" class="form-control" type="text" size="15">
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<select name="costRecordsList[].item" class="select2">
			    [#list constant.COST_ITEMS as val]
					<option value="${val}">${val}</option>
				[/#list]	
				</select>
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			    <input class="form-control" name="costRecordsList[].code" type="text" size="18">
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<select class="select2" name="costRecordsList[].venderId" onkeyup="" style="width:13" type="text">
					<option value="0">--Select--</option>
				[#list venderList as vender]	
					<option value="${vender.venderId}">${vender.name}</option>
				[/#list]	
				</select>
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
				<input class="form-control" name="costRecordsList[].remark" type="text" size="18">
			</td>
			<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			    <a style="cursor:pointer;" class="fa fa-minus" onclick="removeTr(this);">
			</td>
			<input type="hidden" name="costRecordsList[].payOrCost" value="2">
		</tr>
	</tbody>
	<tbody id="cache">
	[#if (singleOrdersVO.visaFeeList?size>0)]
		[#list singleOrdersVO.visaFeeList as visaFee]
		<tr class="visaInput modify" subtotal="${visaFee.itemFee * visaFee.itemFeeNum}">
			<td style="width:10% ;" rowspan="10">Visa</td>
			<td style="width:8% ;">Visa Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="visaFeeList[].itemFee" value="${visaFee.itemFee}" onkeyup="showSubTotal(this);" type="text"> </div></td>
			<td style="width:8% ;">Passports</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="visaFeeList[].itemFeeNum" value="${visaFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${visaFee.itemFee * visaFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="visaFeeList[].remark" value="${visaFee.remark}" type="text">
			[#if visaFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${visaFee.id}','visa');"></a>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('visa');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${visaFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" name="visaFeeList[].type" value="1">
			<input type="hidden" name="visaFeeList[].id" value="${visaFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.flightTicketFeeList?size>0)]
		<tr class="flightTicketInput modify" subtotal="0">
			<td rowspan="10" style="width:10%;"> Flight ticket </td>
			<td style="width:8% ;">Departure Flight Date<font color="red">*</font></td>
			<td style="width:32% ;" colspan="3">
			  	<div class="input-group date datetime" style=" margin-bottom: 0;" data-date-format="yyyy-mm-dd" data-min-view="2">
	               <input id="arriveDate" class="form-control" name="order.arriveDate" [#if (singleOrdersVO.order.arriveDate)??]value="${singleOrdersVO.order.arriveDate?string('yyyy-MM-dd')}"[/#if]readonly="readonly" type="text">
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
			        </span></div></td>
			<td style="width:8% ;">PNR<font color="red"> *</font></td>
			<td  colspan="3"> <input class="form-control" name="order.flightPnr" value="${singleOrdersVO.order.flightPnr}" type="text"></td>
		</tr>
		[#list singleOrdersVO.flightTicketFeeList as flightTicketFee]
		<tr class="flightTicketInput flightTicketFeeInput modify" subtotal="${flightTicketFee.itemFee * flightTicketFee.itemFeeNum}">
		    <td>Airfare</td>
		    <td class="itemFee"><input class="form-control" name="flightTicketFeeList[].itemFee" value="${flightTicketFee.itemFee}" onkeyup="showSubTotal(this);"  type="text"></td>
		    <td>Tickes</td>
		    <td class="itemFeeNum"><input class="form-control" name="flightTicketFeeList[].itemFeeNum" value="${flightTicketFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" type="text"></td>
		    <td>Subtotal</td>
		    <td  class="subTotal"><input class="form-control" readOnly="readOnly" value="${flightTicketFee.itemFee * flightTicketFee.itemFeeNum}" type="text"></td>
		    <td>Remark</td>
		    <td><input class="form-control" style="float:left;width:90%;" name="flightTicketFeeList[].remark" value="${flightTicketFee.remark}" type="text">
			[#if flightTicketFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${flightTicketFee.id}','flightTicket');"></a>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('flightTicket');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${flightTicketFee.id}');"></a>
			[/#if]
		    </td>
		    <input type="hidden" name="flightTicketFeeList[].type" value="2">
		    <input type="hidden" name="flightTicketFeeList[].id" value="${flightTicketFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.hotelFeeList?size>0)]
		[#list singleOrdersVO.hotelFeeList as hotelFee]
		<tr class="hotelInput modify" subtotal="${hotelFee.itemFee * hotelFee.itemFeeNum}">
			<td style="width:10%;" rowspan="10">Hotel</td>
			<td style="width:8% ;">Room Rate</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="hotelFeeList[].itemFee" value="${hotelFee.itemFee}" onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Rooms</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="hotelFeeList[].itemFeeNum" value="${hotelFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;"  class="subTotal"><input class="form-control" readOnly="readOnly" value="${hotelFee.itemFee * hotelFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="hotelFeeList[].remark" value="${hotelFee.remark}" type="text">
			[#if hotelFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${hotelFee.id}','hotel');"></a>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('hotel');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${hotelFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" name="hotelFeeList[].type" value="3">
			<input type="hidden" name="hotelFeeList[].id" value="${hotelFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.ticketFeeList?size>0)]
		[#list singleOrdersVO.ticketFeeList as ticketFee]
		<tr class="ticketInput modify" subtotal="${ticketFee.itemFee * ticketFee.itemFeeNum}">
			<td style="width:10% ;" rowspan="10"> Ticket </td>
			<td style="width:8% ;">Addmission Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="ticketFeeList[].itemFee" value="${ticketFee.itemFee}" onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Entrance Tickets</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="ticketFeeList[].itemFeeNum" value="${ticketFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${ticketFee.itemFee * ticketFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="ticketFeeList[].remark" value="${ticketFee.remark}" type="text">
			[#if ticketFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${hotelFee.id}','ticket');"></a>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('ticket');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${ticketFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" name="ticketFeeList[].type" value="4">
			<input type="hidden" name="ticketFeeList[].id" value="${ticketFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.insuranceFeeList?size>0)]
		[#assign insuranceList = singleOrdersVO.insuranceFeeList]
		<tr class="insuranceInput" subtotal="${insuranceList[0].itemFee * insuranceList[0].itemFeeNum}">
			<td rowspan="5" style="width:10%;">Insurance</td>
			<td style="width:8% ;">Gold plan Insurance Charge</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="insuranceFeeList[0].itemFee" value="${insuranceList[0].itemFee}" onkeyup="showSubTotal(this);" type="text"></td>
		    <td style="width:8% ;">Plans</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="insuranceFeeList[0].itemFeeNum" value="${insuranceList[0].itemFeeNum}" onkeyup="showSubTotal(this);" type="text"></td>
		    <td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="${insuranceList[0].itemFee * insuranceList[0].itemFeeNum}" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[0].remark" value="${insuranceList[0].remark}" type="text"></td>
			<input type="hidden" name="insuranceFeeList[0].type" value="5">
			<input type="hidden" name="insuranceFeeList[0].id" value="${insuranceList[0].id}">
		</tr>
		<tr class="insuranceInput" subtotal="${insuranceList[1].itemFee * insuranceList[1].itemFeeNum}">
			<td>Silver plan Insurance Charge</td>
			<td class="itemFee"><input class="form-control" name="insuranceFeeList[1].itemFee" onkeyup="showSubTotal(this);" value="${insuranceList[1].itemFee}" type="text"></td>
			<td>Plans</td>
			<td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[1].itemFeeNum"  onkeyup="showSubTotal(this);" value="${insuranceList[1].itemFeeNum}" type="text"></td>
			<td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="${insuranceList[1].itemFee * insuranceList[1].itemFeeNum}" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[1].remark" value="${insuranceList[1].remark}" type="text"></td>
			<input type="hidden" name="insuranceFeeList[1].type" value="5">
			<input type="hidden" name="insuranceFeeList[1].id" value="${insuranceList[1].id}">
		</tr>
		<tr class="insuranceInput" subtotal="${insuranceList[2].itemFee * insuranceList[2].itemFeeNum}">
			<td>Cancel for any reason Insurance Charge</td>
			<td class="itemFee"><input class="form-control" name="insuranceFeeList[2].itemFee" onkeyup="showSubTotal(this);" value="${insuranceList[2].itemFee}" type="text"></td>
			<td>Plans</td>
		    <td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[2].itemFeeNum" onkeyup="showSubTotal(this);" value="${insuranceList[2].itemFeeNum}" type="text"></td>
		    <td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="${insuranceList[2].itemFee * insuranceList[2].itemFeeNum}" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[2].remark" value="${insuranceList[2].remark}" type="text"></td>
			<input type="hidden" name="insuranceFeeList[2].type" value="5">
			<input type="hidden" name="insuranceFeeList[2].id" value="${insuranceList[2].id}">
		</tr>
		<tr class="insuranceInput" subtotal="0"><td colspan="4">Tour Info</td></tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Arrival Date<font color="red" size="3px">*</font></td>
			<td colspan="3">
			<div style=" margin-bottom: 0;" class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
	            <input id="departureDate" class="form-control" name="tourInfoForOrder.departureDate" [#if (singleOrdersVO.tourInfoForOrder.departureDate)??]value="${singleOrdersVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if]readonly="readonly" type="text">
				<span class="input-group-addon btn btn-primary">
			    <span class="glyphicon glyphicon-th"></span>
		        </span>
			</div>
			</td>
			<td>Days<font color="red" size="3px">*</font></td>
			<td colspan="3"><input class="form-control" name="tourInfoForOrder.dayNum" value="${singleOrdersVO.tourInfoForOrder.dayNum}" type="text"></td>
		</tr>
	[/#if]
	[#if (singleOrdersVO.otherFeeList?size>0)]
		[#list singleOrdersVO.otherFeeList as otherFee]
		<tr class="otherInput modify" subtotal="${otherFee.itemFee * otherFee.itemFeeNum}">
			<td style="width:10%;" rowspan="10">Other</td>
			<td style="width:8% ;">Other Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="otherFeeList[].itemFee" onkeyup="showSubTotal(this);" value="${otherFee.itemFee}" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="otherFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="${otherFee.itemFeeNum}"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${otherFee.itemFee * otherFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="otherFeeList[].remark" type="text">
			[#if otherFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${otherFee.id}','other');"></a>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('other');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${otherFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" name="otherFeeList[].type" value="6">
			<input type="hidden" name="otherFeeList[].id" value="${otherFee.id}">
		</tr>
		[/#list]
	[/#if]
	</tbody>
</table>
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
		initFeeType();
		initPayCost();
		initValues();
		$("#formSubmit").click(function(){
			submit();
		});
    });
    
    /* 初始化各种费用的checkbox */
    function initFeeType(){
	    addCheckAction('visa');
		addCheckAction('flightTicket');
		addCheckAction('hotel');
		addCheckAction('ticket');
	    addCheckAction('insurance');
		addCheckAction('other');
    }
    
    /* 初始化收入支出的输入框 */
    function initPayCost(){
    	var $newHtml = $("#template .1,#template .2").clone(true);
    	$newHtml.find("a").remove();
    	$newHtml.find("div.datetime").datetimepicker({autoclose: true});
    	$newHtml.find("select.select2").select2({
        	width: '100%'
        });
    	$("#incomeTbody").append($newHtml.eq(0));
    	$("#costTbody").append($newHtml.eq(1));
    }
    
    /* 根据传来的参数回显页面  */
    function initValues(){
    	$("#sex_${singleOrdersVO.customer.sex}").click();
    	switch(${singleOrdersVO.order.nonGroupType}){
    		case 1 : $("#visaId").parent().click(); break;
    		case 2 : $("#flightTicketId").parent().click(); break;
    		case 3 : $("#hotelId").parent().click(); break;
    		case 4 : $("#ticketId").parent().click(); break;
    		case 5 : $("#insuranceId").parent().click(); break;
    		case 6 : $("#otherId").parent().click();
    	}
    	
    }
    
    /* 给多选框添加事件,根据多选框的选中与否显示或隐藏输入区域  */
    function addCheckAction(inputType){
    	$("#" + inputType + "Id").on('ifChanged',function(){
			/* 选项框是否为选中 */
			if($(this).prop('checked') == true){
				/* 若缓存存在该种输入,就直接显示,若不存在通过模板生成作显示 */
				var $append = $("#cache ." + inputType + "Input");
				if($append.size() == 0){
					$append = $("#template ." + inputType + "Input").clone(true);
					$append.find("div.datetime").datetimepicker({autoclose: true});
				}
				$("#" + inputType).append($append);
				calculateAllSubTotal($("#" + inputType));
		    }else{
		    	$("#" + inputType + " tr").appendTo($("#cache"));
		    	$("#" + inputType ).attr("sum", 0);
		    	showSum();
		    } 	
		});
    }
    
	/* 根据国家动态加载州  */
    function generalStateSelect(countrySelect) {
        var $stateSelect = $(countrySelect).parent().next().next().find("select");
        var countryId = $(countrySelect).val();

        $stateSelect.children("option").remove();
        $stateSelect.append("<option value='0'>--Select--</option>");
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
    
    /* 根据款项ID删除款项  */
    function deleteFee(button,itemId){
    	$("form").append('<input type="hidden" name="deleteItemIds" value="' + itemId + '">');
        var $fee = $(button).parent().parent();
    	var $tbody = $fee.parent();
        $fee.remove();
        calculateAllSubTotal($tbody);
    }
    
    /* 根据款项ID删除款项 (第一条记录) */
    function deleteFirstFee(button,itemId,inputType){
     	$("form").append('<input type="hidden" name="deleteItemIds" value="' + itemId + '">');
        var $fee = $(button).parent().parent();
	    var $next = $fee.next();
	    
	    /* 如果费用输入框数目大于1个  */
	    if($next.html() != undefined){
	    	var $button = $next.find("a");
	    	
	    	/* 如果第一个输入框下面是需要修改的值  */
		    if($next.hasClass("modify")){
		    	var event = $button.attr("onclick").replace("deleteFee","deleteFirstFee").replace(");",  ","+ inputType +");");
		    	$button.attr("onclick",event);
		    	$button.after('&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('+ inputType +');"></a>');
		    }else{
				$button.attr("onclick","feeAdd("+ inputType +");").removeClass("fa fa-minus").addClass("fa fa-plus");	    
		    }
	    }else{
	    	var $add;
	    	if(inputType != 'flightTicket'){
	    		$add = $("#template ." + inputType + "Input").clone(true);
	    	}else{
	    		$add = $("#template ." + inputType + "FeeInput").clone(true);
	    	}
			$("#" + inputType).append($add);
	    } 
	    var $tbody = $fee.parent();
	    $fee.remove();
	   	calculateAllSubTotal($tbody);
    }
    
    /* 添加费用input */
    function feeAdd(inputType){
    	var $add;
    	if(inputType != 'flightTicket'){
    		$add = $("#template ." + inputType + "Input").clone(true);
    		$add.children("td:first").remove();
    	}else{
    		$add = $("#template ." + inputType + "FeeInput").clone(true);
    	}
    	$add.children("td:last").children("a").removeClass("fa fa-plus").addClass("fa fa-minus").attr("onclick","removeTr(this);");
		$("#" + inputType).append($add);
    }
    
    /* 增加收入或支出  */
    function add(addButton, classNo){
    	var $newHtml = $("#template ." + classNo).clone(true);
    	$newHtml.find("div.datetime").datetimepicker({autoclose: true});
    	$newHtml.find("select.select2").select2({
        	width: '100%'
        });
    	var $tbody = $(addButton).parent().parent().parent().next();
    	$tbody.append($newHtml);
    }

    /* 删除费用或收入支出  */ 
    function removeTr(button){
    	var $tr = $(button).parent().parent();
    	var $tbody = $tr.parent();
        $tr.remove();
        calculateAllSubTotal($tbody);
    }

	/* 计算每条费用的Subtotal */        
    function showSubTotal(input){
    	var $tr = $(input).parent().parent();
    	var itemFee = $tr.children(".itemFee").children("input").val() * 1;
    	var itemFeeNum = $tr.children(".itemFeeNum").children("input").val() * 1;
    	$tr.children(".subTotal").children("input").val(itemFee * itemFeeNum);
    	$tr.attr("subtotal","" + (itemFee * itemFeeNum));
    	calculateAllSubTotal($tr.parent());
    }
    
    /* 把该类型费用所有Subtotal总和放入该类型tbody的sum属性中  */
    function calculateAllSubTotal($tbody){
    	var sum = 0;
    	$tbody.children("tr").each(function(){
    		sum += $(this).attr("subtotal") * 1;
    	});
    	$tbody.attr("sum",sum);
    	showSum();
    }
    
    /* 显示费用总和  */
    function showSum(){
    	var sum = 0;
    	$("#feeTable").children("tbody").each(function(){
    		sum += $(this).attr("sum") * 1;
    	});
    	$("#AllSum").val(sum);
    }
    
    /* 提交 */
    function submit(){
    	$("#visa").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(100 + index);
    			}
    		});
    	});
    	$("#flightTicket").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(200 + index);
    			}
    		});
    	});
    	$("#hotel").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(300 + index);
    			}
    		});
    	});
    	$("#ticket").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(400 + index);
    			}
    		});
    	});
    	$("#other").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(600 + index);
    			}
    		});
    	});
    	$("#incomeTbody").children("tr").each(function(index){
    		$(this).find("input,select").each(function(){
    			addIndex($(this),index);
    		});
    	});
    	$("#costTbody").children("tr").each(function(index){
    		$(this).find("input,select").each(function(){
    			addIndex($(this),index);
    		});
    	});
    	$("form").submit();
    }
    
	/* 给费用以及收入支出生成list下标  */
	function addIndex($input,index){
		var name = $input.attr("name");
		if(name == undefined){
			return;
		}
		var position = name.lastIndexOf("]");
		if(position != '-1'){
			name = name.substring(0,position) + index + name.substring(position,name.length);
			$input.attr("name",name);
		}
	}
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
