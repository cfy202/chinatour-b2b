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
                <li><a style="cursor:pointer;" href="#">Booking - ${ordersTotal.orderNumber}</a></li>
            </ol>
        </div>
        <div class="cl-mcont">	
    	  <div class="row">
            <div class="col-md-12">
                <div class="block-flat">
        				<ul class="nav nav-tabs">
							<li><a onclick="javascript:window.location.href='supplierBooking.jhtml?ordersTotalId=${ordersTotalId}'" data-toggle="tab">文景假期</a></li>
							<li class="active"><a data-toggle="tab">Other</a></li>
						</ul>
          <div class="step-content">
            <form id="nonGroupTypeForm" class="form-horizontal group-border-dashed" action="addSingleProduct.jhtml" method="post" data-parsley-namespace="data-parsley-" data-parsley-validate novalidate> 
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
						<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Remark</div>
						<table style="width:100%;">
					  		<tr>
					  			<td>
									Arrival Date: 
								</td>
								<td>
									<input type="text" id="scheduleOfArriveTime" class="form-control input-group1 JQ-date" name="tourInfoForOrder.scheduleOfArriveTime" />
								</td>
								<td>
									Reference: 
								</td>
								<!--没有admin:outboundItem权限的用户-->
								[@shiro.lacksPermission name = "admin:outboundItem"]
									<td>
										<input type="text" class="form-control input-group1" name="order.reference" />
									</td>
										<td colspan="6">
									</td>
								[/@shiro.lacksPermission]
								<!--有admin:outboundItem权限的用户-->
								[@shiro.hasPermission name = "admin:outboundItem"]
									<td colspan="2">
										<input type="text" class="form-control input-group1" name="order.reference" />
									</td>
									 <td>Tracking No.</td>
									<td colspan="4">
										<input type="text" class="form-control input-group1" name="tourInfoForOrder.trackingNo" />
									</td>
								[/@shiro.hasPermission]
							</tr>
				            <tr>
				            	<td>Notice:</td>
				            	<td colspan="2">
				                   <textarea class="form-control input-group1" name="tourInfoForOrder.specialRequirements" style="height:120px"></textarea>
				                </td>
				                <td>Itinerary:</td>
								<td colspan="4">
							       <textarea class="form-control" name="tourInfoForOrder.personalRoute" style="height:120px"></textarea>
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
				<input type="hidden" name="ordersTotalId" value="${ordersTotal.ordersTotalId}"/>
            </form>
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
<table style="display:none">
	<tr id="productTemplate">
		<td></td>
		<td></td>	
		<td></td>
		<td class="text-center"></td> 
	</tr>
</table>
<table style="display:none">
	<tbody id="template">
		<tr class="visaInput" subtotal="0">
			<td style="width:10% ;" rowspan="10">Visa</td>
			<!--有admin:outboundItem权限的用户-->
			[@shiro.hasPermission name = "admin:outboundItem"]
				<td style="width:8% ;">Departure Date<font color="red">*</font></td>
				<td >
					<input class="form-control JQ-date" name="tourInfoForOrder.departureDate" type="text" />
				</td>
				<td style="width:8% ;">Type<font color="red"> *</font></td>
				<td>
				<select  name="tourInfoForOrder.tourType" class="form-control" >
        			 [#list constant.VISA_TYPE as val]
						<option value="${val}" >${val}</option>
					[/#list]
	        	</select>
				</td>
				<td colspan="4"> </td>
			</tr>
			<tr class="visaInput visaFeeInput" subtotal="0">
			[/@shiro.hasPermission]
			<td style="width:8% ;">Visa Fee</td>
			<td style="width:12% ;" class="itemFee"><input class="form-control" name="visaFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></div></td>
			<td style="width:8% ;">Passports</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="visaFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars"  value="1" type="text"></td>
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
			<td >
				<input class="form-control JQ-date" name="order.arriveDate" type="text" />
			</td>
			<td style="width:8% ;">PNR<font color="red"> *</font></td>
			<td> <input class="form-control" name="order.flightPnr" type="text"></td>
			<td colspan="4"> </td>
		</tr>
		<tr class="flightTicketInput flightTicketFeeInput" subtotal="0">
		    <td>Airfare</td>
		    <td class="itemFee"><input class="form-control" name="flightTicketFeeList[].itemFee" onkeyup="showSubTotal(this);"  value="0" type="text"></td>
		    <td>Tickes</td>
		    <td class="itemFeeNum"><input class="form-control" name="flightTicketFeeList[].itemFeeNum" onkeyup="showSubTotal(this);"  maxlength="2" required placeholder="Max 2 chars" value="1" type="text"></td>
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
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="hotelFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" maxlength="2" required placeholder="Max 2 chars" value="1" type="text"></td>
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
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="ticketFeeList[].itemFeeNum" onkeyup="showSubTotal(this);" value="1" maxlength="2" required onkeyup="showSubTotal(this);" type="text"></td>
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
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="insuranceFeeList[0].itemFeeNum"  onkeyup="showSubTotal(this);" value="1" type="text"></td>
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
			<td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[1].itemFeeNum"  onkeyup="showSubTotal(this);" value="1" type="text"></td>
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
		    <td class="itemFeeNum"><input class="form-control" name="insuranceFeeList[2].itemFeeNum" onkeyup="showSubTotal(this);" value="1" type="text"></td>
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
			<td>
				<input name="tourInfoForOrder.departureDate" class="form-control JQ-date" />
			</td>
			<td>Days<font color="red" size="3px">*</font></td>
			<td><input class="form-control" name="tourInfoForOrder.dayNum" value="0" type="text"></td>
			<td colspan="8"></td>
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
			<td><input class="form-control" style="float:left;width:90%;" name="busTourFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('busTour');"></a></td>
			<input type="hidden" class="num" name="busTourFeeList[].num">
			<input type="hidden" name="busTourFeeList[].type" value="6">
		</tr>
		<tr class="cruiseInput" subtotal="0">
			<td style="width:10%;" rowspan="10">Cruise</td>
			<td style="width:8% ;">Cruise Fee</td>
			<td style="width:12%;" class="itemFee"><input class="form-control" name="cruiseFeeList[].itemFee" onkeyup="showSubTotal(this);" value="0" type="text"></td>
		    <td style="width:8% ;">Number</td>
			<td style="width:12% ;" class="itemFeeNum"><input class="form-control" name="cruiseFeeList[].itemFeeNum"  maxlength="2" required placeholder="Max 2 chars" value="1"  onkeyup="showSubTotal(this);" type="text"></td>
			<td style="width:8% ;">Subtotal</td>
			<td style="width:12% ;" class="subTotal"><input class="form-control" readOnly="readOnly" value="0" type="text"></td>
			<td style="width:8% ;">Remark</td>
			<td><input class="form-control" style="float:left;width:90%;" name="cruiseFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('cruise');"></a></td>
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
			<td><input class="form-control" style="float:left;width:90%;" name="otherFeeList[].remark" type="text">&nbsp;&nbsp;<a class="fa fa-plus" onclick="feeAdd('other');"></a></td>
			<input type="hidden" class="num" name="otherFeeList[].num">
			<input type="hidden" name="otherFeeList[].type" value="8">
		</tr>
	</tbody>
	<tbody id="cache">
	</tbody>
</table>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $("#scheduleOfArriveTime").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
        [@flash_message /]
        initFeeType();
        $("#formSubmit").click(function(){
        	formSubmit();
        })
    });
    
    /* 给多选框添加事件,根据多选框的选中与否显示或隐藏输入区域  */
    function addCheckAction(inputType){
    	$("#" + inputType + "Id").on('ifChanged',function(){
			
			/* 选项框是否为选中 */
			if($(this).prop('checked') == true){
				/* 若缓存存在该种输入,就直接显示,若不存在通过模板生成作显示 */
				var $append = $("#cache ." + inputType + "Input");
				if($append.size() == 0){
					$append = $("#template ." + inputType + "Input").clone(true);
					$append.find("input.JQ-date").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
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
    
    /* 删除费用或收入支出  */ 
    function removeTr(button){
    	var $tr = $(button).parent().parent();
    	var $tbody = $tr.parent();
        $tr.remove();
        calculateAllSubTotal($tbody);
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
    
    /* 把该类型费用所有Subtotal总和放入该类型tbody的sum属性中  */
    function calculateAllSubTotal($tbody){
    	var sum = 0;
    	$tbody.children("tr").each(function(){
    		sum += $(this).attr("subtotal") * 1;
    	});
    	$tbody.attr("sum",sum);
    	showSum();
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
    
    /* 显示费用总和  */
    function showSum(){
    	var sum = 0;
    	$("#feeTable").children("tbody").each(function(){
    		sum += $(this).attr("sum") * 1;
    	});
    	$("#AllSum").val(sum);
    }
    
    function formSubmit(){
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
    	$("#nonGroupTypeForm").submit();
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
</body>
</html>
