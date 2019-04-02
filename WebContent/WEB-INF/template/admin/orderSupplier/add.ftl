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
			<h2>NEW</h2>
			<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Inquiry</a></li>
			<li class="active">NEW</li>
			</ol>
		</div>
		<div class="cl-mcont">		
			<div class="row wizard-row">
				<div class="col-md-12 fuelux">
					<div class="block-wizard">
		        		<div class="step-content">
							<form class="form-horizontal group-border-dashed" action="save.jhtml" method="post" 
										data-parsley-namespace="data-parsley-" data-parsley-validate novalidate>
								<div class="step-pane active" id="step1">
									<table style="padding:10px;border: 0px none" width="100%">
										<tbody id="feeTbody">
											<tr>
												<td width="13%">
													<span>
														No. <font color="red">*</font> 
													</span>
												</td>
												<td width="37%">
													<input type="text" disabled="true" value="NEW" class="form-control input-group1 peer">
												</td>
												<!--<td width="13%">
													<span>
													 	Invoice No.
													</span>
												</td>
												<td width="37%">
													<input type="text" id="invoiceNum" name="invoiceNo" required class="form-control input-group1 peer">
													&nbsp;&nbsp;<a id="manner" style="cursor:pointer;" class=""></a>
												</td>-->
												<td width="13%">
													<span>
													 Name
													</span>
												</td>
												<td width="37%">
													<input type="text" name="accRemarkOfOp" class="form-control input-group1 peer">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
													 Departure Date
													</span>
												</td>
												<td width="37%">
													<input id="arriveDate" type="text" name="arriveDate" class="form-control input-group1" required placeholder="yyyy-mm-dd">
												</td>
												<td width="13%">
													<span>
														Qty 
													</span>
												</td>
												<td width="37%">
													<input type="text" name="quantity" parsley-type="number"  class="form-control input-group1 peer">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Airline：
													</span>
												</td>
												<td width="37%">
													<select id="airlinelist" class="select2 peer" name="airline">
														<option value="">--Select--</option>
													</select>
												</td>
												<td width="13%">
													<span>
														LOCATOR
													</span>
												</td>
												<td width="37%">
													<input type="text" name="locator" class="form-control input-group1 peer">
												</td>
												
											</tr>
											<tr>
												<td width="13%">
													<span>
														PNR
													</span>
												</td>
												<td width="37%">
													<input type="text" name="flightPnr" class="form-control input-group1 peer">
												</td>
												<td width="13%">
												</td>
												<td width="37%">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Payment 
													</span>
												</td>
												<td width="37%">
													<input type="text" name="card" class="form-control input-group1 peer">
												</td>
												<td width="13%">
													 Date:
												</td>
												<td width="37%"> 
												<input id="scheduleOfArriveTimeInput" type="text" name="date" class="form-control input-group1" required placeholder="yyyy-mm-dd"/>
													<font size="2px" color="red">
										  			  &nbsp;*
													</font>
												</td>
											</tr>
											<tr class="ticketClass">
												<td width="13%">
													<span>
														Ticket ：
													</span>
												</td>
												<td width="37%">
													<input type="text" name="airticketItemsList[0].ticketNo" id="Ticket" class="form-control input-group1 peer">
												</td>
												<td width="13%">
													<span>
														Charge
													</span>
												</td>
												<td width="37%">
													<input  name="airticketItemsList[0].charge" parsley-type="number" id="Charge" class="form-control input-group1 peer" value="0">
												</td>
											</tr>
											<tr class="netClass">
												<td width="13%">
													<span>
														Net
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" name="airticketItemsList[0].net" id="Net" class="form-control input-group1 peer" value="0">
												</td>
												<td width="13%">
													<span>
														Tax
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" name="airticketItemsList[0].tax" id="Tax" class="form-control input-group1 peer" value="0">
												</td>
											</tr>
											<tr class="netClass1">
												<td width="13%">
													<span>
														Total
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" name="airticketItemsList[0].total" id="Total" class="form-control input-group1 peer" value="0">
												</td>
												<td width="13%">
													<span>
														Selling
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" name="airticketItemsList[0].selling" id="Selling" class="form-control input-group1 peer" value="0">
													&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee();"></a>
												</td>
											</tr>
											<tr class="chargeFee">
												<td width="13%">
													<span>
														Type
													</span>
												</td>
												<td width="37%">
													<select id="selectTypeId" class=" select2 peer" name="type">
														<option value="0">Agent</option>
														<option value="2">Wholesale</option>
													</select>
												</td>
												<td width="13%" class="agentcyClass">
													ContactName
												</td>
												<td width="37%" class="agentcyClass">
													<input type="text" name="tempValue01" id="tempValueId" class="form-control input-group1 peer">
												</td>
											</tr>
											<tr>
												<td width="13%"  class="trClass">
													<span>
														Dept
													</span>
												</td>
												<td width="37%"  class="trClass">
													<select id="selectDeptId" class=" select2 peer">
														<option value="0">--Select--</option>
														[#list deptList as dept]
															<option value="${dept.deptId}">${dept.deptName}</option>
														[/#list]
													</select>
												</td>
												<td width="13%" class="trClass">
													Agent<font color="red">*</font>
												</td>
												<td width="37%" class="trClass">
													<select id="selectAgentId" class=" select2 peer" onchange="changeValue(this);"  name="agentId">
														<option value="">Select</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%"  class="contactClass" style="display:none;">
													<span>
														Agency <font color="red">*</font>
													</span>
												</td>
												<td width="37%"  class="contactClass" style="display:none;">
													<input type="text" id="agencyId" name="agency" onchange="changeCompanyValue(this);" class="input-group1">
												</td>
												<td width="13%" class="contactClass" style="display:none;">
													ContactName <font color="red">*</font>
												</td>
												<td width="37%" class="contactClass" style="display:none;">
													<input type="text" name="contactName" onblur="setValue(this)" class="form-control input-group1 peer">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Order No.
													</span>
												</td>
												<td width="37%" >
													<input type="text" name="tempValue02" id="orderId" class="input-group1">
													<input type="hidden" name="tempValue03" id="orderNoId">
												</td>
												<td width="13%">
													<span>
														Class
													</span>
												</td>
												<td width="37%">
													<select id="selectClassId" class=" select2 peer" name="tempValue04">
														<option value="">Select</option>
														<option value="P">Premium Class</option>
														<option value="E">Economy Class</option>
														<option value="B">Bussiness Class</option>
														<option value="F">First Class</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Destination
													</span>
												</td>
												<td width="37%">
													<select id="selectDesId" class=" select2 peer" name="tempValue05">
														<option value="">Select</option>
														<option value="I">International</option>
														<option value="D.">Domestic.</option>
													</select>
												</td>
												<td width="13%">
													ARC <font color="red">*</font>
												</td>
												<td width="37%">
													<input type="text" id="arcId" name="tempValue06" onblur="changeArcFee(this);" value="0.00" required class="form-control input-group1 peer">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Vender
													</span>
												</td>
												<td width="37%">
													<input type="text" id="venderId" name="venderId" class="input-group1" >
													<input type="hidden" id="supplierName" name="supplierName">
												</td>
												<td width="13%">
													Invoice No.
												</td>
												<td width="37%">
													<input type="text" name="code" class="form-control input-group1 peer">
												</td> 
											</tr>
											<tr>
												<td width="13%">
													<span>
														Method
													</span>
												</td>
												<td width="37%">
													<select id="TicketType" class=" select2 peer" name="TicketType">
														<option value="">Select</option>
														<option value="T">Ticketing</option>
														<option value="E">Exchange</option>
														<option value="R">Refund</option>
														<option value="V">Void</option>
														<option value="TC">TC</option>														
													</select>
												</td>
												<td width="13%">
													<span>
														System
													</span>
												</td>
												<td width="37%">
													<select id="System" class=" select2 peer" name="System">
														<option value="">Select</option>
														<option value="A">Amadeus</option>
														<option value="S">Sabre</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Remark
													</span>
												</td>
												<td width="37%" colspan="3">
													<textarea name="remark" style="width:904px;height:158px"></textarea>
												</td>
												
											</tr>
											<tr>
												<td width="13%">
													<span>
														Invoice Remark
													</span>
												</td>
												<td width="37%" colspan="3">
													<textarea name="invoiceRemark" style="width:904px;height:158px"></textarea>
												</td>
												
											</tr>
										</tbody>
									</table>
									<div class="form-group" align="right">
										<div class="col-sm-12">
											<button type="button" onclick="javascript:history.go(-1);" class="btn btn-default">Cancel</button>
											<button type="reset" onclick="resetSelect();" class="btn btn-default">Reset</button>
											<button type="button" id="formSubmit" class="btn btn-primary"><i class="fa fa-check"></i>Save</button>
										</div>
									</div>
								</div>
							</form>
							<div style="width:100%;height:120px; border:1px solid #5CADAD;margin-top:40px;font-size:14px;color:#000;border-radius:16px;">
								<h4 style="width:100%;height:30px;background-color: #5CADAD;padding:0px;margin:0px;border:1px solid #5CADAD;border-radius:16px 16px 0px 0px;">&nbsp;&nbsp;&nbsp;&nbsp;Summary</h4>
								<table>
									<thead>	
										<tr style="font-weight:bold;text-align">		
											<td style="width:16px; text-align:center;">Charge</td>
											<td style="width:16px; text-align:center;">Selling</td>
											<td style="width:16px; text-align:center;">Net</td>
											<td style="width:16px; text-align:center;">Tax</td>
											<td style="width:16px; text-align:center;">Total</td>
											<td style="width:16px; text-align:center;">ARC</td>
											<td style="width:16px; text-align:center;">Bill/Credit</td>
											<td style="width:16px; text-align:center;">Profit</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td style="width:16px; text-align:center;" id="chargeSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="sellingSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="netSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="taxSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="totalSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="arcSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="billSumFee">0.00</td>
											<td style="width:16px; text-align:center;" id="profitSumFee">0.00</td>
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
<table id="feeTemplate" style="display:none">
	<tr class="ticketClass">
		<td width="13%">
			<span>
				Ticket ：
			</span>
		</td>
		<td width="37%">
			<input type="text" name="airticketItemsList[feeIndex].ticketNo" id="TicketNum" class="form-control input-group1 peer">
		</td>
		<td width="13%">
			<span>
				Charge
			</span>
		</td>
		<td width="37%">
			<input  name="airticketItemsList[feeIndex].charge" parsley-type="number" id="ChargeMum" value="0.00" class="form-control input-group1 peer">
		</td>
	</tr>
	<tr class="netClass">
		<td width="13%">
			<span>
				Net
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].net" id="NetNum" value="0.00" class="form-control input-group1 peer">
		</td>
		<td width="13%">
			<span>
				Tax
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].tax" id="TaxNum" value="0.00" class="form-control input-group1 peer">
		</td>
	</tr>
	<tr class="netClass1">
		<td width="13%">
			<span>
				Total
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].total" id="TotalNum" value="0.00" class="form-control input-group1 peer">
		</td>
		<td width="13%">
			<span>
				Selling：
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].selling" id="SellingNum" value="0.00" class="form-control input-group1 peer">
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this);">
		</td>
	</tr>
</table>
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
	<script type="text/javascript">
		var airline=["CA","MU","CZ","AA","DL","AS","UA","MF","CX","JL","HX","BR","HU","AC","SQ","NZ","QF","OZ","DI","MH","VN","CI","TG","BA","AZ","WS","KE","4O","TK","B6","3U","SQ","EK","CM","PR","NH","CM","US","VS","WN","EY","QR","AF","SU","MCO","LX","DY","VW","SB","AH","KC","BP","NX","SW","PX","GZ","HM","OY","IZ","KK","O6","0B","BW","5Z","WX","KB","BE","HX","MR","JY","RQ","TM","QV","2M","8M","UB","RA","NP","8P","PW","P0","BI","WB","SC","GQ","IE","SZ","2I","5U","DT","TB","TU","U6","UT","VJ","V7","EB","7W","SE","HA","KL","FJ","LA"];
		
		$("#credit_slider").slider().on("slide",function(e){
		      $("#credits").html("$" + e.value);
		    });
		    $("#rate_slider").slider().on("slide",function(e){
		      $("#rate").html(e.value + "%");
		    });
		$(document).ready(function(){
			for (var i=0;i<airline.length;i++){
				$("#airlinelist").append('<option value="'+airline[i]+'">'+airline[i]+'</option>');
			}
			//initialize the javascript
			$("#scheduleOfArriveTimeInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 0 });
			$("#arriveDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 0 });
			App.init();
			App.wizard();
			$("#selectBrandId").trigger('click');
	    	$("form select.select2").select2({
				width: '60%'
			});
			$("#formSubmit").click(function() {
				submit();
			});
			$("input[name$='charge']").each(function(){
				$(this).on("blur",function(){
					sumPrice();
				});
			});
			$("input[name$='net']").each(function(){
				$(this).on("blur",function(){
					sumPrice();
				});
			});
			$("input[name$='tax']").each(function(){
				$(this).on("blur",function(){
					sumPrice();
				});
			});
			$("input[name$='total']").each(function(){
				$(this).on("blur",function(){
					sumPrice();
				});
			});
			$("input[name$='selling']").each(function(){
				$(this).on("blur",function(){
					sumPrice();
			 	});
			});
			$("#orderId").select2({
				placeholder:"Search OrderNo",//文本框的提示信息
				minimumInputLength:1,	//至少输入n个字符，才去加载数据
				allowClear: false,	//是否允许用户清除文本信息
				ajax:{
					url:'[@spring.url '/admin/orders/listSelect.jhtml'/]',	//地址
					dataType:'text',	//接收的数据类型
					type: "POST",
					//contentType:'application/json',
					data: function (term, pageNo) {		//在查询时向服务器端传输的数据
						term = $.trim(term);  
		                return {  
		                     orderNo: term   //联动查询的字符  
		                 }  
					},
					results:function(data,pageNo){
						var dataA = [];
						var dataStr=$.parseJSON(data);
						for(var i=0;i<dataStr.orderList.length;i++){
							var order = dataStr.orderList[i];
							 dataA.push({id: order.id, text: order.orderNo});
						}
						
						return {results:dataA};
					}
				},
				initSelection: function(element, callback) {
			    	var id = $(element).val();
				    if (id !== "") {
					    $.ajax("[@spring.url '/admin/orders/listSelect.jhtml?id='/]" + id, {
					    	dataType: "json",
					    	type: "POST"
					    	}).done(function(data) { 
					    		if(data.orderList[0]==undefined){
					    			callback({id:"",text:"Search OrderNo"});
					    		}else{
					    			callback({id:data.orderList[0].id,text:data.orderList[0].orderNo});
					    		}
					    	});
				    }
			    },
				formatResult: formatAsText,	//渲染查询结果项
				escapeMarkup: function (m) {
					$("#orderNoId").val(m);
					return m;
				 }
			});
		});
		 /* 提交  */
    function submit(){
    	$("#feeTbody").find(".ticketClass").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
    		});
    	});
		$("#feeTbody").find(".netClass").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
    		});
    	});
    	$("#feeTbody").find(".netClass1").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
    		});
    	});
    	/* var deptId=$("#selectDeptId").val();
    	var agentId=$("#selectAgentId").val();
    	if(deptId!="0"&&agentId==""){
    		alert("Please select the sale's name!");
    		return;
    	}
    	if(deptId!="0"&&agentId!=""){
    	    if($("#orderId").val()==""){
    	        alert("Please enter the orderNo info!");
    	        return;
    	    }
    	} */
    	var estimate=$("#manner").hasClass('fa fa-times');
    	if(estimate){
    		alert("The Invoice No. already exists!");
    	}
		$("form").submit(); 
    }
	//级联选中
	$("#selectDeptId").click(function(){
		var deptId=$(this).val();
		var html='<option value="">Select</option>';
		$.ajax({
			url:'[@spring.url '/admin/admin/findByDepId.jhtml'/]',
			data:'deptId='+deptId,
			type:"POST",
			success:function(result){
				$.each(result,function(index,values){
					html+='<option value="'+values.id+'">'+values.username+'</option>';
				});
			$("#selectAgentId").select2("val","");
			$("#selectAgentId").empty();
			$("#selectAgentId").append(html);
			}
		});
	});
	//级联选中
	$("#selectTypeId").change(function(){
		var type=$(this).val();
		if(type=='0'){
			$(".trClass").show();
			$("#selectAgentId").select2("enable", true);
			$(".agentcyClass").show();
			$(".contactClass").hide();
			$("#agencyId").attr("disabled", true);
		}else if(type=='2'){
			$(".trClass").hide();
			$(".agentcyClass").hide();
			$(".contactClass").show();
			$("#selectAgentId").select2("enable", false);
			$("#agencyId").removeAttr("disabled");
			$("#agencyId").select2({
				placeholder:"Search Agency",//文本框的提示信息
				minimumInputLength: 1,	//至少输入n个字符，才去加载数据
				allowClear: false,	//是否允许用户清除文本信息
				ajax:{
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
					    		if(data.venderList[0]==undefined){
					    			callback({id:"",text:"Search Vender"});
					    		}else{
					    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
					    		}
					    	});
				    }
			    },
				formatResult: formatAsText,	//渲染查询结果项
				escapeMarkup: function (m) {
				 return m; }
			});
		}else{
			$(".trClass").hide();
			$("#selectAgentId").select2("enable", false);
			$(".agentcyClass").show();
			$(".contactClass").hide();
			$("#tempValueId").val("");
			$("#agencyId").removeAttr("disabled");
		}
	});
    /* 根据同行ID异步查找同行信息并显示  */
    function changeCompanyValue(companySelect){
    	var companyId = $(companySelect).val();
	    $.post("[@spring.url '/admin/orders/getVender.jhtml'/]", {
            "companyId": companyId
        },
        function(company) {
        	$("input[name='contactName']").val(company.contactor);
    		$("#tempValueId").val(company.contactor);
        });
    }
	
    /* 添加多个航班或机票费用  */
    var i=0;
    function addFee(){
   		i+=1;
    	var $Html = $("#feeTemplate").find(".ticketClass").clone(true);
    	var Ticket=$("#Ticket").val()*1;
    	$Html.find("#TicketNum").val(Ticket+i);
    	var Charge=$("#Charge").val()*1;
    	$Html.find("#ChargeMum").val(Charge);
		$("#feeTbody").find(".chargeFee").before($Html);
		
		var $Html = $("#feeTemplate").find(".netClass" ).clone(true);
		var Net=$("#Net").val();
		$Html.find("#NetNum").val(Net);
		var Tax=$("#Tax").val();
		$Html.find("#TaxNum").val(Tax);
		$("#feeTbody").find(".chargeFee").before($Html);
		
		var $Html1 = $("#feeTemplate").find(".netClass1" ).clone(true);
		var Total=$("#Total").val();
		$Html1.find("#TotalNum").val(Total);
		var Selling=$("#Selling").val();
		$Html1.find("#SellingNum").val(Selling);
		$("#feeTbody").find(".chargeFee").before($Html1);
		sumPrice();
    }
    /* 删除航班或机票费用  */
    function removeFee(button) {
    	$(button).parent().parent().prev().prev().remove();
    	$(button).parent().parent().prev().remove();
        $(button).parent().parent().remove();
    }
	/* 计算常总额  */
	function sumPrice(){
		chargeSumFee=0.00;
		$("input[name$='charge']").each(function(){
			sum=$(this).val();
			chargeSumFee=chargeSumFee+parseFloat(sum);
		});
		$("#chargeSumFee").html((chargeSumFee).toFixed(2));
		
		netSumFee=0.00;
		$("input[name$='net']").each(function(){
			sum=$(this).val();
			netSumFee=netSumFee+parseFloat(sum);
		});
		$("#netSumFee").html((netSumFee).toFixed(2));
		
		taxSumFee=0.00;
		$("input[name$='tax']").each(function(){
			sum=$(this).val();
			taxSumFee=taxSumFee+parseFloat(sum);
		});
		$("#taxSumFee").html((taxSumFee).toFixed(2));
		
		totalSumFee=0.00;
		$("input[name$='total']").each(function(){
			sum=$(this).val();
			totalSumFee=totalSumFee+parseFloat(sum);
		});
		$("#totalSumFee").html((totalSumFee).toFixed(2));
		 
		sellingSumFee=0.00;
		$("input[name$='selling']").each(function(){
			sum=$(this).val();
			sellingSumFee=sellingSumFee+parseFloat(sum);
		});
		$("#sellingSumFee").html((sellingSumFee).toFixed(2));
		$("#arcSumFee").html((totalSumFee-chargeSumFee).toFixed(2));
		$("#arcId").val((totalSumFee-chargeSumFee).toFixed(2));
		$("#billSumFee").html((sellingSumFee-chargeSumFee).toFixed(2));
		$("#profitSumFee").html((sellingSumFee-totalSumFee).toFixed(2));
	}
	function setValue(contactName){
		$("#tempValueId").val($(contactName).val());
	}
	function changeValue(agentName){
		$("#tempValueId").val($(agentName).find("option:selected").text());
	}
	function changeArcFee(arcValue){
		$("#arcSumFee").html($(arcValue).val());
	}
	//格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	$("#venderId").select2({
		placeholder:"Search",//文本框的提示信息
		minimumInputLength: 1,	//至少输入n个字符，才去加载数据
		allowClear: false,	//是否允许用户清除文本信息
		ajax:{
			url:'${base}/admin/vender/listSelect.jhtml?type=1',	//地址(type=2供应商，查找type!=2)
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
			    		if(data.venderList[0]==undefined){
			    			callback({id:"",text:"Search"});
			    		}else{
			    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
			    		}
			    	});
		    }
	    },
		formatResult: formatAsText,	//渲染查询结果项
		escapeMarkup: function (m) {
			if(m!="Search"){
				$("#supplierName").val(m);
				$("#arcId").val(0);
			}
		 return m; }
	});
	$("#invoiceNum").blur(function(){
		var invoiceNo=$("#invoiceNum").val();
		if(invoiceNo != ""){
			$.ajax({
				url:'[@spring.url '/admin/supplierPrice/findByInvoiceNum.jhtml'/]',	//地址
				data:'invoiceNo='+invoiceNo,
				type:"POST",
				success:function(result){
					if(result=="have"){
						$("#manner").removeClass("fa fa-check");
						$("#manner").addClass("fa fa-times");
					}else{
						$("#manner").removeClass("fa fa-times");
						$("#manner").addClass("fa fa-check");
					}
				},
				error:function(){
					alert("There have error,please try again!");
				}
			});
		}
	});
	
</script>
</body>
</html>
