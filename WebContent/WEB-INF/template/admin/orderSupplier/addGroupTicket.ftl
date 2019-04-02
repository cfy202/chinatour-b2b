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
							<form class="form-horizontal group-border-dashed" action="saveGit.jhtml" method="post" 
										data-parsley-namespace="data-parsley-" data-parsley-validate novalidate>
								<div class="step-pane active" id="step1">
									<table style="border:1px solid #ccc;margin-bottom:40px;" width="100%">
										<tbody id="feeTbody">
											<tr>
												<td width="13%">
													<span>
													 No. <font color="red">*</font> 
													</span>
												</td>
												<td width="37%">
													<input type="text" name="invoiceNo" required class="form-control input-group1 peer">
												</td>
												<td width="13%">
												</td>
												<td width="37%">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Airline：
													</span>
												</td>
												<td width="37%">
													<input  name="airline" class="form-control input-group1 peer">
												</td>
												<td width="13%">
													<span>
														PNR
													</span>
												</td>
												<td width="37%">
													<input type="text" name="flightPnr" class="form-control input-group1 peer">
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
													<span>
														Date <font color="red">*</font>
													</span>
												</td>
												<td width="37%">
													<div class="input-group date datetime"  data-date-format="yyyy-mm-dd" data-min-view="2" style="width:60%;">
														<input name="date" class="form-control" readonly="readonly" type="text" required size="16">
														<span class="input-group-addon btn btn-primary">
															<span class="glyphicon glyphicon-th"></span>
														</span>
													</div>
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
													</select>
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
														Remark
													</span>
												</td>
												<td width="37%" colspan="3">
													<textarea name="remark" style="width:35%;height:100px"></textarea>
												</td>
												
											</tr>
											</table>
											<table style="margin-bottom:40px;background-color:#F1F1F1;">
											<tr>
												<td width="13%">
													<span>
														Tour Code <font color="red">*</font>
													</span>
												</td>
												<td width="37%" >
													<input type="text"  id="tourId" required="" name="remarkOfAgent" class="input-group1">
												</td>
												<td width="13%">
												
												</td>
												<td width="37%">
													
												</td>
											</tr>
											<tr class="ticketClass">
												<td width="13%">
													<span>
														Ticket <font color="red">*</font> ：
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" id="ticketId" onblur="setTicketNo();" value="1" name="ticketNo" class="form-control input-group1 peer">
												</td>
												<td width="13%">
													<span>
														Charge
													</span>
												</td>
												<td width="37%">
													<input  parsley-type="number" id="chargeId" onblur="sumPriceUpdate();" value="0.00" class="form-control input-group1 peer">
												</td>
											</tr>
											<tr class="netClass">
												<td width="13%">
													<span>
														Net
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" id="netId" onblur="sumPriceUpdate();" value="0.00"  class="form-control input-group1 peer">
												</td>
												<td width="13%">
													<span>
														Tax
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" id="taxId" onblur="sumPriceUpdate();" value="0.00" class="form-control input-group1 peer">
												</td>
											</tr>
											<tr class="netClass">
												<td width="13%">
													<span>
														Total
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" id="totalId" onblur="sumPriceUpdate();" value="0.00"  class="form-control input-group1 peer">
												</td>
												<td width="13%">
													<span>
														Selling：
													</span>
												</td>
												<td width="37%">
													<input type="text" parsley-type="number" id="sellingId" onblur="sumPriceUpdate();" value="0.00" class="form-control input-group1 peer">
													<!--&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" onclick="addFee();"></a>-->
												</td>
											</tr>
										</tbody>
									</table>
							<table class="table table-bordered dataTable no-footer">
							<thead>
								<tr>
									<th>﻿Booking No.</th>
									<th class="text-center">No.</th>
									<th class="text-center">FirstName</th>
									<th class="text-center">LastName</th>
									<th class="text-center">Agent</th>
									<th class="text-center">Ticket</th>
									<th class="text-center">Charge</th>
									<th class="text-center">Net</th>
									<th class="text-center">Tax</th>
									<th class="text-center">Total</th>
									<th class="text-center">Selling</th>
								</tr>
							</thead>
							<tbody id="tbodyId">
							</tbody>
						</table>
									<div class="form-group" align="right">
										<div class="col-sm-12">
											<button type="button" onclick="javascript:history.go(-1);" class="btn btn-default">Cancel</button>
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
			<input type="text" name="airticketItemsList[feeIndex].ticketNo" class="form-control input-group1 peer">
		</td>
		<td width="13%">
			<span>
				Charge
			</span>
		</td>
		<td width="37%">
			<input  name="airticketItemsList[feeIndex].charge" parsley-type="number"  value="0.00" class="form-control input-group1 peer">
		</td>
	</tr>
	<tr class="netClass">
		<td width="13%">
			<span>
				Net
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].net"  value="0.00" class="form-control input-group1 peer">
		</td>
		<td width="13%">
			<span>
				Tax
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].tax" value="0.00" class="form-control input-group1 peer">
		</td>
	</tr>
	<tr class="netClass">
		<td width="13%">
			<span>
				Total
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].total"  value="0.00" class="form-control input-group1 peer">
		</td>
		<td width="13%">
			<span>
				Selling：
			</span>
		</td>
		<td width="37%">
			<input type="text" parsley-type="number" name="airticketItemsList[feeIndex].selling" value="0.00" class="form-control input-group1 peer">
			&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this);">
		</td>
	</tr>
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
		$(document).ready(function(){
			//initialize the javascript
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
    	/**$("#feeTbody").find(".ticketClass").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
    		});
    	});
		$("#feeTbody").find(".netClass").each(function(index){
    		$(this).find("input").each(function(){
    			$(this).attr("name",$(this).attr("name").replace("feeIndex",index));
    		});
    	});**/
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
			$(".agentcyClass").hide();
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
    function addFee(){
    	var $Html = $("#feeTemplate").find(".ticketClass" ).clone(true);
		$("#feeTbody").find(".chargeFee").before($Html);
		var $Html = $("#feeTemplate").find(".netClass" ).clone(true);
		$("#feeTbody").find(".chargeFee").before($Html);
    }
    /* 删除航班或机票费用  */
    function removeFee(button) {
   		$(button).parent().parent().prev().prev().remove();
    	$(button).parent().parent().prev().remove();
        $(button).parent().parent().remove();
    }
	/* 总额平均  */
	function sumPriceUpdate(){
		var chargeSumFee=$("#chargeId").val();
		var name="charge";
		setSumValue(chargeSumFee,name);
		var netSumFee=$("#netId").val();
		var name="net";
		setSumValue(netSumFee,name);
		var taxSumFee=$("#taxId").val();
		var name="tax";
		setSumValue(taxSumFee,name);
		var totalSumFee=$("#totalId").val();
		var name="total";
		setSumValue(totalSumFee,name);
		var sellingSumFee=$("#sellingId").val();
		var name="selling";
		setSumValue(sellingSumFee,name);
	
		$("#chargeSumFee").html(chargeSumFee);
		$("#netSumFee").html(netSumFee);
		$("#taxSumFee").html(taxSumFee);
		$("#totalSumFee").html(totalSumFee);
		$("#sellingSumFee").html(sellingSumFee);
		$("#arcSumFee").html((totalSumFee-chargeSumFee).toFixed(2));
		$("#arcId").val((totalSumFee-chargeSumFee).toFixed(2));
		$("#billSumFee").html((sellingSumFee-chargeSumFee).toFixed(2));
		$("#profitSumFee").html((sellingSumFee-totalSumFee).toFixed(2));
	}
	function setSumValue($sumPrice,$name){
		 //总人数
		var customerCount=0;
		$("tr[id^='trCss_']").each(function(){
			customerCount=parseFloat(customerCount)+1;
		});
		//余数
		var remainder=parseFloat($sumPrice)%parseFloat(customerCount);
		//平局整数
		var integer=parseInt(parseFloat($sumPrice)/parseFloat(customerCount)) ;
		//将余数平摊到前几个人身上
		$("#tbodyId").find("input[name$="+$name+"]").each(function(){
			if(remainder>0||remainder==0){
				if(parseFloat(remainder)>0){
					$(this).val(parseFloat(integer)+1);
					remainder--;
				}else if(parseFloat(remainder)==0){
					$(this).val(integer);
				}
			}else{
				if(parseFloat(remainder)<0){
					$(this).val(parseFloat(integer)-1);
					remainder++;
				}else if(parseFloat(remainder)==0){
					$(this).val(integer);
				}
			}
		});
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
		
		$("#chargeId").val((chargeSumFee).toFixed(2));
		$("#netId").val((netSumFee).toFixed(2));
		$("#taxId").val((taxSumFee).toFixed(2));
		$("#totalId").val((totalSumFee).toFixed(2));
		$("#sellingId").val((sellingSumFee).toFixed(2));
		
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
			}
		 return m; }
	});
	$("#tourId").select2({
		placeholder:"Search",//文本框的提示信息
		minimumInputLength: 1,	//至少输入n个字符，才去加载数据
		allowClear: false,	//是否允许用户清除文本信息
		ajax:{
			url:'[@spring.url '/admin/tour/listSelect.jhtml'/]',	
			dataType:'text',	//接收的数据类型
			type: "POST",
			//contentType:'application/json',
			data: function (term, pageNo) {		//在查询时向服务器端传输的数据
				term = $.trim(term);  
                return {  
                     tourCode: term   //联动查询的字符  
                 }  
			},
			results:function(data,pageNo){
				var dataA = [];
				var dataStr=$.parseJSON(data);
				for(var i=0;i<dataStr.tourList.length;i++){
					var tour = dataStr.tourList[i];
					 dataA.push({id: tour.tourId, text: tour.tourCode});
				}
				return {results:dataA};
			}
		},
		initSelection: function(element, callback) {
	    	var id = $(element).val();
		    if (id !== "") {
			    $.ajax("[@spring.url '/admin/tour/listSelect.jhtml?id='/]" + id, {
			    	dataType: "json",
			    	type: "POST"
			    	}).done(function(data) { 
			    		if(data.tourList[0]==undefined){
			    			callback({id:"",text:"Search"});
			    		}else{
			    			callback({id:data.tourList[0].tourId,text:data.tourList[0].tourCode});
			    		}
			    	});
		    }
	    },
		formatResult: formatAsText,	//渲染查询结果项
		escapeMarkup: function (m) {
			if(m!="Search"){
				var tourId = $('#tourId').select2("val");
				 $.ajax("[@spring.url '/admin/supplierPrice/customerListSelect.jhtml?tourId='/]" + tourId, {
			    	dataType: "json",
			    	type: "POST"
			    	}).done(function(data) { 
			    		var str="";
			    		if(data.customerList.length==0){
			    			$("#tbodyId").empty();
			    			$("#tbodyId").append("<tr><td>No Data</td></tr>");
			    			return;
			    		}
			    		for(var i=0;i<data.customerList.length;i++){
							var customer = data.customerList[i];
							var number=$("#ticketId").val();
							number=parseFloat(number)+i;
							str+='<tr id="trCss_'+i+'">'+
									'<td style="width:5%;">'+customer['orderNo']+'</td>'+
									'<td class="text-center">'+customer['customerCode']+'</td>'+
									'<td class="text-center">'+customer['firstName']+'</td>'+
									'<td class="text-center">'+customer['lastName']+'</td>'+
									'<td class="text-center">'+customer['agent']+'</td>'+
									'<td  width="15%" align="center">'+
				                    	'<input type="name" class="form-control" name="airticketItemsList['+i+'].ticketNo"  value="'+number+'" />'+
				                    '</td>'+
									'<td  width="15%" align="center">'+
				                    	'<input type="name" class="form-control" onblur="sumPrice();" name="airticketItemsList['+i+'].charge"  value="0" />'+
				                    '</td>'+
									'<td  width="15%" align="center">'+
				                    	'<input type="name" class="form-control" onblur="sumPrice();" name="airticketItemsList['+i+'].net" value="0"/>'+
				                    '</td>'+
				                    '<td  width="15%" align="center">'+
				                    	'<input type="name" class="form-control" onblur="sumPrice();" name="airticketItemsList['+i+'].tax" value="0"/>'+
				                    '</td>'+
				                    '<td  width="15%" align="center">'+
				                    	'<input type="name" class="form-control" onblur="sumPrice();" name="airticketItemsList['+i+'].total" value="0"/>'+
				                    '</td>'+
				                    '<td width="15%" align="center">'+
				                    	'<input type="name" class="form-control" onblur="sumPrice();" name="airticketItemsList['+i+'].selling"   value="0"/>'+
				                    	'<input type="hidden" class="form-control" name="airticketItemsList['+i+'].orderId" value="'+customer['orderId']+'" />'+
				                    	'<input type="hidden" class="form-control" name="airticketItemsList['+i+'].orderNo" value="'+customer['orderNo']+'" />'+
				                    	'<input type="hidden" class="form-control" name="airticketItemsList['+i+'].userId" value="'+customer['userId']+'" />'+
				                    	'<input type="hidden" class="form-control" name="airticketItemsList['+i+'].userName" value="'+customer['agent']+'" />'+
				                    '</td>'+
								'</tr>';
						}
						$("#tbodyId").empty();
						$("#tbodyId").append(str);
			    	}); 
			}
		 return m; }
	});
	
	function setTicketNo(){
		var number=$("#ticketId").val();
		$("#tbodyId").find("input[name$='ticketNo']").each(function(){
			$(this).val(number);
			number++;
		});
	}
</script>
</body>
</html>
