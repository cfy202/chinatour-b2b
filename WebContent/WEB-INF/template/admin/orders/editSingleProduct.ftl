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
            <h2>Other Booking</h2>
            <div class="new">
	        	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	        </div>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking - ${singleOrdersVO.ordersTotalId}</a></li>
            </ol>
        </div>
        <div class="cl-mcont">	
          <div class="step-content">
            <form class="form-horizontal group-border-dashed" action="singleOrderUpdate.jhtml" method="post" data-parsley-namespace="data-parsley-" data-parsley-validate novalidate> 
				<div class="step-pane active" id="step1">
						<div class="form-group no-padding">
						</div>
	                    <div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Fee Information</div>
						<div class="form-group">
							<div class="col-sm-12">
								<label style="display: inline-flex;" class="checkbox-inline">Type :</label>
								<label id="chooseType_1" style="display: inline-flex;" class="checkbox-inline"><input id="visaId" name="nonGroupType" value="1" type="checkbox" class="icheck"> Visa </label>
								<label id="chooseType_2" style="display: inline-flex;" class="checkbox-inline"><input id="flightTicketId" name="nonGroupType" value="2" type="checkbox" class="icheck"> Flight ticket </label>
								<label id="chooseType_3" style="display: inline-flex;" class="checkbox-inline"><input id="hotelId" name="nonGroupType" value="3" type="checkbox" class="icheck"> Hotel </label>
								<label id="chooseType_4" style="display: inline-flex;" class="checkbox-inline"><input id="ticketId" name="nonGroupType" value="4" type="checkbox" class="icheck"> Ticket </label>
								<label id="chooseType_5" style="display: inline-flex;" class="checkbox-inline"><input id="insuranceId" name="nonGroupType" value="5" type="checkbox" class="icheck"> Insurance </label>
								<label id="chooseType_6" style="display: inline-flex;" class="checkbox-inline"><input id="busTourId" name="nonGroupType" value="6" type="checkbox" class="icheck"> Bus Tour </label>
								<label id="chooseType_7" style="display: inline-flex;" class="checkbox-inline"><input id="cruiseId" name="nonGroupType" value="7" type="checkbox" class="icheck"> Cruise </label>
								<label id="chooseType_8" style="display: inline-flex;" class="checkbox-inline"><input id="otherId" name="nonGroupType" value="8" type="checkbox" class="icheck"> Other </label>
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
								<tbody id="busTour" sum="0">
								</tbody>
								<tbody id="cruise" sum="0">
								</tbody>
								<tbody id="other" sum="0">
								</tbody>
							</table>
						</div>
						<div style="margin:10px 0 15px 0;">
							<div style="text-align: right; ">
								Total Tour Accounts Receivable： <input class="form-control input-group1" name="receivableInfoOfOrder.sumFee" value="${singleOrdersVO.receivableInfoOfOrder.sumFee}" id="AllSum" style=" width:120px;float:right;" value="0" readonly="readonly" type="text">
							</div>
						</div>
						<input type="hidden" name="tourInfoForOrder.id" value="${singleOrdersVO.tourInfoForOrder.id}"/>
						<input type="hidden" name="order.id" value="${singleOrdersVO.order.id}"/>
						<input type="hidden" name="ordersTotalId" value="${singleOrdersVO.order.ordersTotalId}"/>
						<input type="hidden" name="receivableInfoOfOrder.id" value="${singleOrdersVO.receivableInfoOfOrder.id}"/>
						
						<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Remark</div>
						<table style="width:100%;">
					  		<tr>
					  			<td>
									Arrival Date: 
								</td>
								<td>
									<input type="text" id="scheduleOfArriveTime" class="form-control input-group1 JQ-date" name="tourInfoForOrder.scheduleOfArriveTime" [#if (singleOrdersVO.tourInfoForOrder.scheduleOfArriveTime)??]value="${singleOrdersVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}"[/#if]"/>
								</td>
								<td>
									Reference: 
								</td>
								<!--没有admin:outboundItem权限的用户-->
								[@shiro.lacksPermission name = "admin:outboundItem"]
									<td>
										<input type="text" class="form-control input-group1" name="order.reference" value="${singleOrdersVO.order.reference}" />
									</td>
										<td colspan="6">
									</td>
								[/@shiro.lacksPermission]
								<!--有admin:outboundItem权限的用户-->
								[@shiro.hasPermission name = "admin:outboundItem"]
									<td colspan="2">
										<input type="text" class="form-control input-group1" name="order.reference" value="${singleOrdersVO.order.reference}" />
									</td>
									 <td>tracking No.</td>
									<td colspan="4">
										<input type="text" class="form-control input-group1" name="tourInfoForOrder.trackingNo" value="${singleOrdersVO.tourInfoForOrder.trackingNo}" />
									</td>
								[/@shiro.hasPermission]
							</tr>
				            <tr>
				            	<td>Notice:</td>
				            	<td colspan="2">
				                   <textarea class="form-control input-group1" name="tourInfoForOrder.specialRequirements" style="height:120px">${singleOrdersVO.tourInfoForOrder.specialRequirements}</textarea>
				                </td>
				                <td>Itinerary:</td>
								<td colspan="4">
							       <textarea class="form-control" name="tourInfoForOrder.personalRoute" style="height:120px">${singleOrdersVO.tourInfoForOrder.personalRoute}</textarea>
							    </td>
				            </tr>
						</table>
				        <br>
					<div class="form-group" align="right">
	                  <div class="col-sm-12">
	                    <button type="button" onclick="javascript:history.go(-1);" data-wizard="#wizard1" class="btn btn-default"> Cancel</button>
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
<table style="display:none">
	<tbody id="template">
		<tr class="visaInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Visa</td>
				<!--有admin:outboundItem权限的用户-->
			[@shiro.hasPermission name = "admin:outboundItem"]
				<td style="width:8% ;">Departure Date<font color="red">*</font></td>
				<td >
					<div class="input-group date datetime" style=" margin-bottom: 0;" data-date-format="yyyy-mm-dd" data-min-view="2">
	               <input id="arriveDate" class="form-control" name="tourInfoForOrder.departureDate" readonly="readonly" type="text">
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
			        </span></div>
				</td>
				<td style="width:8% ;">Type<font color="red"> *</font></td>
				<td> 
					<select id="tourTypeId" class="form-control" name="tourInfoForOrder.tourType" >
	        			 [#list constant.VISA_TYPE as val]
							<option value="${val}" >${val}</option>
						[/#list]
	        		</select>
				</td>
				<td colspan="4"> </td>
			</tr>
			<tr class="visaInput visaFeeInput" subtotal="0">
			[/@shiro.hasPermission]
			<td style="width:8%;">Visa Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="visaFeeList[].itemFee" value="0" onkeyup="showSubTotal(this);" value="0" type="text"> </div></td>
			<td style="width:8%;">Passports</td>
			<td style="width:12%;" class="itemFeeNum"><input class="form-control" name="visaFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars"  value="1" type="text"></td>
			<td style="width:8%;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8%;">Remark</td>
			<td style="width:12%"><input class="form-control" style="float:left;width:90%;" name="visaFeeList[].remark" type="text"></td>
			<td style="width:5%"><a class="fa fa-plus" onclick="feeAdd('visa');"></a></td>
			<input type="hidden" class="num" name="visaFeeList[].num"> 
			<input type="hidden" name="visaFeeList[].type" value="1">
		</tr>
		<tr class="flightTicketInput" subtotal="0">
			<td rowspan="10" style="width:10%;"> Flight ticket </td>
			<td style="width:8%;">Departure Flight Date<font color="red">*</font></td>
			<td style="width:12%;">
			  	<div class="input-group date datetime" style=" margin-bottom: 0;" data-date-format="yyyy-mm-dd" data-min-view="2">
	               <input id="arriveDate" class="form-control" name="order.arriveDate" readonly="readonly" type="text">
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
			        </span></div></td>
			<td style="width:8%;">PNR<font color="red"> *</font></td>
			<td style="width:12%;"><input class="form-control" name="order.flightPnr" type="text"></td>
			<td colspan="5">
		</tr>
		<tr class="flightTicketInput flightTicketFeeInput" subtotal="0">
		    <td style="width:10%;">Airfare</td>
		    <td style="width:8%;" class="itemFee"><input class="form-control" name="flightTicketFeeList[].itemFee" onkeyup="showSubTotal(this);"  value="0" type="text"></td>
		    <td style="width:12%;">Tickes</td>
		    <td style="width:8%;" class="itemFeeNum"><input class="form-control" name="flightTicketFeeList[].itemFeeNum" onkeyup="showSubTotal(this);"  maxlength="2" required placeholder="Max 2 chars" value="0" type="text"></td>
		    <td style="width:12%;">Subtotal</td>
		    <td style="width:8%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
		    <td style="width:12%;" >Remark</td>
		    <td style="width:8%;"><input class="form-control" style="float:left;width:80%;" name="flightTicketFeeList[].remark" type="text"></td>
		    <td><a class="fa fa-plus" onclick="feeAdd('flightTicket');"></a></td>
		    <input type="hidden" class="num" name="flightTicketFeeList[].num">
			<input type="hidden" name="flightTicketFeeList[].type" value="2">
		</tr>
		<tr class="hotelInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Hotel</td>
			<td style="width:8% ;">Room Rate</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="hotelFeeList[].itemFee" onkeyup="showSubTotal(this);"  value="0" type="text"></td>
			<td style="width:8% ;">Rooms</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="hotelFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" value="1" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;"  class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="hotelFeeList[].remark" type="text"></td>
			<td><a class="fa fa-plus" onclick="feeAdd('hotel');"></a></td>
			<input type="hidden" class="num" name="hotelFeeList[].num">
			<input type="hidden" name="hotelFeeList[].type" value="3">
		</tr>
		<tr class="ticketInput" subtotal="0">
			<td style="width:10% ;" rowspan="10"> Ticket </td>
			<td style="width:8% ;">Addmission Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="ticketFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td style="width:8% ;">Entrance Tickets</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="ticketFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" value="1" maxlength="2" required onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="ticketFeeList[].remark" id="hotelExplain" type="text"></td>
			<td><a class="fa fa-plus" onclick="feeAdd('ticket');"></a></td>
			<input type="hidden" class="num" name="ticketFeeList[].num">
			<input type="hidden" name="ticketFeeList[].type" value="4">
		</tr>
		<tr class="insuranceInput" subtotal="0">
			<td rowspan="5" style="width:10%;">Insurance</td>
			<td style="width:8% ;">Gold plan Insurance Charge</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="insuranceFeeList[0].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Plans</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="insuranceFeeList[0].itemFeeNum"  onkeyup="showSubTotal(this);" value="1" type="text"></td>
		    <td>SubTotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[0].remark" type="text"></td>
			<td></td>
			<input type="hidden" class="num" name="insuranceFeeList[0].num" value="501">
			<input type="hidden" name="insuranceFeeList[0].type" value="5">
		</tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Silver plan Insurance Charge</td>
			<td class="itemFee"><input class="form-control" name="insuranceFeeList[1].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td>Plans</td>
			<td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[1].itemFeeNum"  onkeyup="showSubTotal(this);" value="1" type="text"></td>
			<td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[1].remark" type="text"></td>
			<td></td>
			<input type="hidden" class="num" name="insuranceFeeList[1].num" value="502">
			<input type="hidden" name="insuranceFeeList[1].type" value="5">
		</tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Cancel for any reason Insurance Charge</td>
			<td class="itemFee"><input class="form-control" name="insuranceFeeList[2].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
			<td>Plans</td>
		    <td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[2].itemFeeNum" onkeyup="showSubTotal(this);" value="1" type="text"></td>
		    <td>Subtotal</td>
			<td class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td>Remark</td>
			<td><input class="form-control"  name="insuranceFeeList[2].remark" type="text"></td>
			<td></td>
			<input type="hidden" class="num" name="insuranceFeeList[2].num" value="503">
			<input type="hidden" name="insuranceFeeList[2].type" value="5">
		</tr>
		<tr class="insuranceInput" subtotal="0"><td colspan="4">Tour Info</td></tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Arrival Date<font color="red" size="3px">*</font></td>
			<td >
				<div style=" margin-bottom: 0;" class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
	                <input id="departureDate" class="form-control" name="tourInfoForOrder.departureDate" type="text">
					<span class="input-group-addon btn btn-primary">
				    <span class="glyphicon glyphicon-th"></span>
			        </span>
				</div>
			</td>
			<td>Days<font color="red" size="3px">*</font></td>
			<td ><input class="form-control" name="tourInfoForOrder.dayNum" value="0" type="text"></td>
			<td colspan="6">
		</tr>
		<tr class="busTourInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Bus Tour</td>
			<td style="width:8% ;">Amount</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="busTourFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="busTourFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="1"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="busTourFeeList[].remark" type="text"></td>
			<td><a class="fa fa-plus" onclick="feeAdd('busTour');"></a></td>
			<input type="hidden" class="num" name="busTourFeeList[].num">
			<input type="hidden" name="busTourFeeList[].type" value="6">
		</tr>
		<tr class="cruiseInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Cruise</td>
			<td style="width:8% ;">cruise Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="cruiseFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="cruiseFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="1"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="cruiseFeeList[].remark" type="text"></td>
			<td><a class="fa fa-plus" onclick="feeAdd('cruise');"></a></td>
			<input type="hidden" class="num" name="cruiseFeeList[].num">
			<input type="hidden" name="cruiseFeeList[].type" value="7">
		</tr>
		<tr class="otherInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Other</td>
			<td style="width:8% ;">Other Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="otherFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="otherFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="1"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="otherFeeList[].remark" type="text"></td>
			<td><a class="fa fa-plus" onclick="feeAdd('other');"></a></td>
			<input type="hidden" class="num" name="otherFeeList[].num">
			<input type="hidden" name="otherFeeList[].type" value="8">
		</tr>
	</tbody>
	<tbody id="cache">
	[#if (singleOrdersVO.visaFeeList)?? && (singleOrdersVO.visaFeeList?size>0)]
		[#list singleOrdersVO.visaFeeList as visaFee]
		<tr class="visaInput modify" subtotal="${visaFee.itemFee * visaFee.itemFeeNum}">
			[#if visaFee_index == 0]
			<td style="width:10% ;" rowspan="10">Visa</td>
				<!--有admin:outboundItem权限的用户-->
			[@shiro.hasPermission name = "admin:outboundItem"]
				<td style="width:8% ;">Departure Date<font color="red">*</font></td>
				<td >
					<div class="input-group date datetime" style=" margin-bottom: 0;" data-date-format="yyyy-mm-dd" data-min-view="2">
	               <input id="arriveDate" class="form-control" name="tourInfoForOrder.departureDate" [#if (singleOrdersVO.tourInfoForOrder.departureDate)??]value="${singleOrdersVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if]  type="text">
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
			        </span></div>
				</td>
				<td style="width:8% ;">Type<font color="red"> *</font></td>
				<td>
					<select id="tourTypeId" class="form-control" name="tourInfoForOrder.tourType" >
	        			 [#list constant.VISA_TYPE as val]
							<option value="${val}" >${val}</option>
						[/#list]
	        		</select>
				</td>
				<td colspan="4"> </td>
			</tr>
			<tr class="visaInput visaFeeInput" subtotal="0">
			[/@shiro.hasPermission]
			[/#if]
			<td style="width:8% ;">Visa Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="visaFeeList[].itemFee" value="${visaFee.itemFee}" onkeyup="showSubTotal(this);" type="text"> </div></td>
			<td style="width:8% ;">Passports</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="visaFeeList[].itemFeeNum" value="${visaFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${visaFee.itemFee * visaFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="visaFeeList[].remark" value="${visaFee.remark}" type="text"></td>
			<td>
			[#if visaFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${visaFee.id}','visa');"></a><br/>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('visa');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${visaFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" class="num" name="visaFeeList[].num"> 
			<input type="hidden" name="visaFeeList[].type" value="1">
			<input type="hidden" name="visaFeeList[].id" value="${visaFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.flightTicketFeeList)?? && (singleOrdersVO.flightTicketFeeList?size>0)]
		<tr class="flightTicketInput modify" subtotal="0">
			<td rowspan="10" style="width:10%;"> Flight ticket </td>
			<td style="width:8% ;">Departure Flight Date<font color="red">*</font></td>
			<td >
			  	<div class="input-group date datetime" style=" margin-bottom: 0;" data-date-format="yyyy-mm-dd" data-min-view="2">
	               <input id="arriveDate" class="form-control" name="order.arriveDate" [#if (singleOrdersVO.order.arriveDate)??]value="${singleOrdersVO.order.arriveDate?string('yyyy-MM-dd')}"[/#if] type="text">
					<span class="input-group-addon btn btn-primary">
					<span class="glyphicon glyphicon-th"></span>
			        </span></div></td>
			<td style="width:8% ;">PNR<font color="red"> *</font></td>
			<td> <input class="form-control" name="order.flightPnr" value="${singleOrdersVO.order.flightPnr}" type="text"></td>
			<td colspan="5"></td>
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
		    <td><input class="form-control" style="float:left;width:90%;" name="flightTicketFeeList[].remark" value="${flightTicketFee.remark}" type="text"></td>
		    <td>
			[#if flightTicketFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${flightTicketFee.id}','flightTicket');"></a><br/>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('flightTicket');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${flightTicketFee.id}');"></a>
			[/#if]
		    </td>
		    <input type="hidden" class="num" name="flightTicketFeeList[].num"> 
		    <input type="hidden" name="flightTicketFeeList[].type" value="2">
		    <input type="hidden" name="flightTicketFeeList[].id" value="${flightTicketFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.hotelFeeList)?? && (singleOrdersVO.hotelFeeList?size>0)]
		[#list singleOrdersVO.hotelFeeList as hotelFee]
		<tr class="hotelInput modify" subtotal="${hotelFee.itemFee * hotelFee.itemFeeNum}">
			[#if hotelFee_index == 0]
			<td style="width:10%;" rowspan="10">Hotel</td>
			[/#if]
			<td style="width:8% ;">Room Rate</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="hotelFeeList[].itemFee" value="${hotelFee.itemFee}" onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Rooms</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="hotelFeeList[].itemFeeNum" value="${hotelFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;"  class="subTotal"><input class="form-control" readOnly="readOnly" value="${hotelFee.itemFee * hotelFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="hotelFeeList[].remark" value="${hotelFee.remark}" type="text"></td>
			<td>
			[#if hotelFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${hotelFee.id}','hotel');"></a><br/>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('hotel');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${hotelFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" class="num" name="hotelFeeList[].num"> 
			<input type="hidden" name="hotelFeeList[].type" value="3">
			<input type="hidden" name="hotelFeeList[].id" value="${hotelFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.ticketFeeList)?? && (singleOrdersVO.ticketFeeList?size>0)]
		[#list singleOrdersVO.ticketFeeList as ticketFee]
		<tr class="ticketInput modify" subtotal="${ticketFee.itemFee * ticketFee.itemFeeNum}">
			[#if ticketFee_index == 0]
			<td style="width:10% ;" rowspan="10"> Ticket </td>
			[/#if]
			<td style="width:8% ;">Addmission Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="ticketFeeList[].itemFee" value="${ticketFee.itemFee}" onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Entrance Tickets</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="ticketFeeList[].itemFeeNum" value="${ticketFee.itemFeeNum}" onkeyup="showSubTotal(this);" maxlength="2" required onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12%;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${ticketFee.itemFee * ticketFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="ticketFeeList[].remark" value="${ticketFee.remark}" type="text"></td>
			<td>
			[#if ticketFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${hotelFee.id}','ticket');"></a><br/>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('ticket');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${ticketFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" class="num" name="ticketFeeList[].num"> 
			<input type="hidden" name="ticketFeeList[].type" value="4">
			<input type="hidden" name="ticketFeeList[].id" value="${ticketFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.insuranceFeeList)?? && (singleOrdersVO.insuranceFeeList?size>0)]
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
			<td></td>
			<input type="hidden" class="num" name="insuranceFeeList[0].num" value="501">
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
			<td></td>
			<input type="hidden" class="num" name="insuranceFeeList[1].num" value="502">
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
			<td></td>
			<input type="hidden" class="num" name="insuranceFeeList[2].num" value="503">
			<input type="hidden" name="insuranceFeeList[2].type" value="5">
			<input type="hidden" name="insuranceFeeList[2].id" value="${insuranceList[2].id}">
		</tr>
		<tr class="insuranceInput" subtotal="0"><td colspan="4">Tour Info</td></tr>
		<tr class="insuranceInput" subtotal="0">
			<td>Arrival Date<font color="red" size="3px">*</font></td>
			<td>
			<div style="margin-bottom: 0;" class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
	            <input id="departureDate" class="form-control" name="tourInfoForOrder.departureDate" [#if (singleOrdersVO.tourInfoForOrder.departureDate)??]value="${singleOrdersVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] type="text">
				<span class="input-group-addon btn btn-primary">
			    <span class="glyphicon glyphicon-th"></span>
		        </span>
			</div>
			</td>
			<td>Days<font color="red" size="3px">*</font></td>
			<td ><input class="form-control" name="tourInfoForOrder.dayNum" value="${singleOrdersVO.tourInfoForOrder.dayNum}" type="text"></td>
			<td colspan="6"></td>
		</tr>
	[/#if]
	[#if (singleOrdersVO.busTourFeeList)?? && (singleOrdersVO.busTourFeeList?size>0)]
		[#list singleOrdersVO.busTourFeeList as busTour]
		<tr class="busTourInput modify" subtotal="${busTour.itemFee * busTour.itemFeeNum}">
			[#if busTour_index == 0]
			<td style="width:10%;" rowspan="10">Bus Tour</td>
			[/#if]
			<td style="width:8% ;">Amount</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="busTourFeeList[].itemFee" value="${busTour.itemFee}" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="busTourFeeList[].itemFeeNum" maxlength="2" required placeholder="Max 2 chars" value="${busTour.itemFeeNum}"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${busTour.itemFee * busTour.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="busTourFeeList[].remark" value="${busTour.remark}" type="text"></td>
			<td>
			[#if busTour_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${busTour.id}','busTour');"></a><br/>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('busTour');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${busTour.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" class="num" name="busTourFeeList[].num">
			<input type="hidden" name="busTourFeeList[].type" value="6">
			<input type="hidden" name="busTourFeeList[].id" value="${busTourFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.cruiseFeeList)?? && (singleOrdersVO.cruiseFeeList?size>0)]
		[#list singleOrdersVO.cruiseFeeList as cruiseFee]
		<tr class="cruiseInput modify" subtotal="${cruiseFee.itemFee * cruiseFee.itemFeeNum}">	
			[#if cruiseFee_index == 0]
			<td style="width:10%;" rowspan="10">Cruise</td>
			[/#if]
			<td style="width:8% ;">Cruise Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="cruiseFeeList[].itemFee" onkeyup="showSubTotal(this);" value="${cruiseFee.itemFee}" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="cruiseFeeList[].itemFeeNum" maxlength="2" required placeholder="Max 2 chars" value="${cruiseFee.itemFeeNum}"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${cruiseFee.itemFee * cruiseFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="cruiseFeeList[].remark" value="${cruiseFee.remark}" type="text"></td>
			<td>
			[#if cruiseFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${cruiseFee.id}','cruise');"></a><br/>
			&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('cruise');"></a>	
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${cruiseFee.id}');"></a>	
			[/#if]
			</td>
			<input type="hidden" class="num" name="cruiseFeeList[].num">
			<input type="hidden" name="cruiseFeeList[].type" value="7">
			<input type="hidden" name="cruiseFeeList[].type" value="${cruiseFee.id}">
		</tr>
		[/#list]
	[/#if]
	[#if (singleOrdersVO.otherFeeList)?? && (singleOrdersVO.otherFeeList?size>0)]
		[#list singleOrdersVO.otherFeeList as otherFee]
		<tr class="otherInput modify" subtotal="${otherFee.itemFee * otherFee.itemFeeNum}">
			[#if otherFee_index == 0]
			<td style="width:10%;" rowspan="10">Other</td>
			[/#if]
			<td style="width:8% ;">Other Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="otherFeeList[].itemFee" onkeyup="showSubTotal(this);" value="${otherFee.itemFee}" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="otherFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="${otherFee.itemFeeNum}"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="${otherFee.itemFee * otherFee.itemFeeNum}" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="otherFeeList[].remark" value="${otherFee.remark}" type="text"></td>
			<td>
			[#if otherFee_index == 0]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstFee(this,'${otherFee.id}','other');"></a><br/>
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="feeAdd('other');"></a>
			[#else]
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFee(this,'${otherFee.id}');"></a>
			[/#if]
			</td>
			<input type="hidden" class="num" name="otherFeeList[].num">
			<input type="hidden" name="otherFeeList[].type" value="8">
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
		initFeeType();
		$("#formSubmit").click(function(){
			submit();
		});
		init();
		$("form div.datetime").datetimepicker({autoclose: true});
		$("#tourTypeId option[value='${singleOrdersVO.tourInfoForOrder.tourType}']").attr("selected",true);
    });
    
    /*  */
    function init(){
	[#list singleOrdersVO.nonGroupTypeSet as groupType]
		$("#chooseType_${groupType}").click();
	[/#list]
    }
    
    /* 初始化各种费用的checkbox */
    function initFeeType(){
	    addCheckAction('visa');
		addCheckAction('flightTicket');
		addCheckAction('hotel');
		addCheckAction('ticket');
	    addCheckAction('insurance');
		addCheckAction('other');
		addCheckAction('busTour');
		addCheckAction('cruise');
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
    
    <!--没有admin:outboundItem权限的用户-->
	[@shiro.lacksPermission name = "admin:outboundItem"]
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
    
	[/@shiro.lacksPermission]
	<!--有admin:outboundItem权限的用户-->
	[@shiro.hasPermission name = "admin:outboundItem"]
		/* 添加费用input */
    function feeAdd(inputType){
    	var $add;
    	if((inputType != 'flightTicket') && (inputType != 'visa')){
    		$add = $("#template ." + inputType + "Input").clone(true);
    		$add.children("td:first").remove();
    		
    	}else{
    		$add = $("#template ." + inputType + "FeeInput").clone(true);
    	}
    	$add.children("td:last").children("a").removeClass("fa fa-plus").addClass("fa fa-minus").attr("onclick","removeTr(this);");
		$("#" + inputType).append($add);
    }
    
	[/@shiro.hasPermission]
    
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
     	<!--没有admin:outboundItem权限的用户-->
		[@shiro.lacksPermission name = "admin:outboundItem"]
			$("#visa").children("tr").each(function(index){
				$(this).find("input").each(function(){
					addIndex($(this),index);
					if($(this).hasClass("num")){
						$(this).val(100 + index);
					}
				});
	    	});
		[/@shiro.lacksPermission]
		<!--有admin:outboundItem权限的用户-->
		[@shiro.hasPermission name = "admin:outboundItem"]
			$("#visa").children("tr:gt(0)").each(function(index){
				$(this).find("input").each(function(){
					addIndex($(this),index);
					if($(this).hasClass("num")){
						$(this).val(100 + index);
					}
				});
	    	});
		[/@shiro.hasPermission]
    	$("#flightTicket").children("tr:gt(0)").each(function(index){
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
    	$("#busTour").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(600 + index);
    			}
    		});
    	});
    	$("#cruise").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(700 + index);
    			}
    		});
    	});
    	$("#other").children("tr").each(function(index){
    		$(this).find("input").each(function(){
    			addIndex($(this),index);
    			if($(this).hasClass("num")){
    				$(this).val(800 + index);
    			}
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
