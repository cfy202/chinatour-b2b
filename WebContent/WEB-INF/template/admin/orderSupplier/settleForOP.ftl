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
		<h2>Bill/Settlement</h2>
		<div class="pull-right">
			[#if flag==1]<button  id="settleOP" class="btn btn-success" type="button">&nbsp;&nbsp;Settlement &nbsp;&nbsp;</button>[/#if]
			<a href='${base}/admin/supplierPrice/printSettlePage.jhtml?tourId=${tour.tourId}'  target="_blank" class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
			<div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertEditButton" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
			<a class="btn pull-right" href="#" onclick="goback();"><i class="fa fa-reply" title="Back"></i></a>
		</div>
		<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li><a href="#">Tour</a></li>
		</ol>
	</div>
	<div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div style="width:100%; height:30px;margin-bottom:30px;">
						<div>
							[#if settleFlag==0]<button id="addCost" class="btn pull-right btn-warning" title="ADD　COST"><i class="fa fa-plus"></i></button>[/#if]
							<ul>
								<li style="float:left; list-style-type:none;" id="totalIncome"></li>
								<li style="float:left; list-style-type:none; margin-left:10px;" id="totalCost"></li>
								<li style="float:left; list-style-type:none; margin-left:10px;" id="profit"></li>
							</ul>
						</div>
						
					</div>
					<div style="width:100%;">
						<form action="saveEurope.jhtml" method="post" id="saveForm">
								<input name="tourId" value="${tour.tourId}" type="hidden">
								<h4 style="background:#60C060;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
									<i class="fa fa-bar-chart-o"></i>
									<span>Income</span>
						        </h4>
								<table>
									<thead>
										<tr>
											<th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">OrderNo</th>
											<th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">Amount(${currencyType.symbol})</th>
											<!--th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">Remark</th-->
											<th style="font-size:14px;font-weight:bold; width:10%; vertical-align: bottom;">Status</th>
											<th style="font-size:14px;font-weight:bold; width:15%; vertical-align: bottom;">Action</th>
										<tr>
									</thead>
									<tbody>
									[#list orderList as order]
										<tr>
											<td>${order.orderNo}</td>
											<td>0.00</td>
											<!--td><input type="text" name="europeTourPriceList[${a}].remark" class="form-control"></td-->
											<td></td>
											<td>
												<a style="cursor:pointer" class="label label-default md-trigger" class="editEurope" onclick='customerList("${order.id}")'><i class="fa fa-pencil"></i></a>
											</td>
										</tr>
									[/#list]
									[#assign a=(0)?number]
									[#list europeTourPriceList as europeTourPrice]
										[#if europeTourPrice.payOrCost==0]
											<tr>
												<input type="hidden" name="europeTourPriceList[${a}].europeTourPriceId" value="${europeTourPrice.europeTourPriceId}">
												<td>${europeTourPrice.orderNo}</td>
												<td class="income">${europeTourPrice.receivableAmount}</td>
												<!--td><input type="text" name="" value="${europeTourPrice.remark}"  class="form-control" style="border:0px;"></td-->
												<td class="settleState">
													[#if europeTourPrice.completeState==1]
														New
													[#elseif  europeTourPrice.completeState==2]
														Approved(Agent)
													[#elseif  europeTourPrice.completeState==3]
														Approved(AccOP)
													[#elseif  europeTourPrice.completeState==4]
														Settled(OP)
													[#elseif  europeTourPrice.completeState==5]
														Settled(AccOP)
													[/#if]
												</td>
												<td>
													<a style="cursor:pointer" class="label label-default md-trigger" class="editEurope" onclick='customerList("${europeTourPrice.orderId}")'><i class="fa fa-pencil"></i></a>
												</td>
											</tr>
										[/#if]
									[/#list]
									</tbody>
								</table>
								<h4 style="background:#E38800;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
									<i class="fa fa-bar-chart-o"></i>
									<span>Cost</span>
						        </h4>
								<table>
									<thead>
										<tr>
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">TourCode</th>
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Supplier</th>
											<th style="font-size:14px;font-weight:bold; width:10%;vertical-align: bottom;">InvoiceNo</th>
											<th style="font-size:14px;font-weight:bold; width:10%;vertical-align: bottom;">Amount(${currencyType.symbol})</th>
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Remark</th>
											<th style="font-size:14px;font-weight:bold; width:8%;vertical-align: bottom;">Status</th>
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Action</th>
										<tr>
									</thead>
									<tbody id="costList">
									[#list europeTourPriceList as europeTourPrice]
										[#if europeTourPrice.payOrCost==1]
											<tr>
												<td>${europeTourPrice.tourCode}</td>
												<td>${europeTourPrice.venderName}<span id="venderId" style="display:none;">${europeTourPrice.venderId}</span></td>
												<td>${europeTourPrice.invoiceNo}</td>
												<td class="cost">${europeTourPrice.receivableAmount}</td>
												<td>${europeTourPrice.remark}</td>
												<td class="settleState">
													[#if europeTourPrice.completeState==1]
														New
													[#elseif  europeTourPrice.completeState==2]
														Approved(AccOP)
													[#elseif  europeTourPrice.completeState==4]
														Settled(OP)
													[#elseif  europeTourPrice.completeState==5]
														Settled(AccOP)
													[/#if]
												</td>
												<td>
													[#if europeTourPrice.completeState==1]<a style="cursor:pointer"  onclick='updateEuropeCustomerFee("${europeTourPrice.europeTourPriceId}",this)' class="label label-default md-trigger" class="editEurope"><i class="fa fa-pencil"></i></a> <a class="label label-danger" href="delEuropeTourPrice.jhtml?id=${europeTourPrice.europeTourPriceId}&tourId=${europeTourPrice.tourId}"><i class="fa fa-times"  style="cursor:pointer"></i></a>[/#if]
												</td>
											</tr>
										[/#if]
									[/#list]
									</tbody>
								</table>
								<div class="new"> [#if settleFlag==0]<button style="margin-left:85%;" id="saveButton" class="btn btn-success" type="button">&nbsp;&nbsp;Save &nbsp;&nbsp;</button>[/#if]</div>
								<h4 style="background:#ccc;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
									<i class="fa fa-bar-chart-o"></i>
									<span>Revised Bill</span>
						        </h4>
						        <table>
						        	<thead>
										<tr>
											<th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">OrderNo</th>
											<th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">Amount</th>
											<!--th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">Remark</th-->
											<th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">State</th>
										<tr>
									</thead>
									<tbody id="costList">
									[#list europeTourPriceList as europeTourPrice]
										[#if europeTourPrice.payOrCost==3]
											<tr>
												<input type="hidden" name="europeTourPriceList[${a}].europeTourPriceId" value="${europeTourPrice.europeTourPriceId}">
												<td>${europeTourPrice.orderNo}</td>
												<td class="income">${europeTourPrice.receivableAmount}</td>
												<!--td>${europeTourPrice.remark}</td-->
												<td>
												[#if europeTourPrice.completeState==1]
													New
												[#elseif  europeTourPrice.completeState==2]
													Approved(Agent)
												[#elseif  europeTourPrice.completeState==3]
													Approved(AccOP)
												[#elseif  europeTourPrice.completeState==4]
													Settled(OP)
												[#elseif  europeTourPrice.completeState==5]
													Settled(AccOP)
												[/#if]
												</td>
											</tr>
										[/#if]
									[/#list]
									</tbody>
						        </table>
								<input name="index" type="hidden" id="index" value="${a-1}">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4>Edit</h4>
      </div>
	     <div class="modal-body form">
	      <form action="updateEuropeTourPrice.jhtml" id="updateEuropeFeeForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			<table>
	    				<tr>
	    					<td>Supplier:</td>
	    					<td>
	    						<input name="venderId" type="text" class="supplierName" id="updateVenderId" width="100%;"/>
	    						<input name="venderName" id="supplierShortNameId" type="hidden" />
	    					</td>
	    				</tr>
	    				<tr>
	    					<td>InvoiceNo:</td>
	    					<td><input name="invoiceNo" type="text" class="form-control" id="updateInvoiceNo"></td>
	    				</tr>
	    				<tr>
	    					<td>Amount:</td>
	    					<td><input name="receivableAmount" type="text" class="form-control" id="updateReceivableAmount"></td>
	    				</tr>
	    				<tr>
	    					<td>Remark:</td>
	    					<td id="remark">
	    						<input name="remark" type="text" class="form-control" id="updateRemark">
	    						<input name="tourId" id="updateTourId" type="hidden">
	    					</td>
	    				</tr>
	    				<input id="europeTourPriceId" type="hidden" name="europeTourPriceId">
	    			</table>
	    		</div>
	     </form>
	    		<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button class="btn btn-default btn-flat md-close" data-dismiss="modal" onclick="updateEuropeFee()">OK</button>
		    	</div>
	     
	    </div>
   </div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	var totalCost = 0;
    	var totalIncome = 0;
    	var profit = 0;
    	$(".cost").each(function(){
    		str = $(this).html();
    		strInt = parseFloat(str);
    		totalCost+=strInt;
    	});
    	$(".income").each(function(){
    		str = $(this).html();
    		strInt = parseFloat(str);
    		totalIncome+=strInt;
    	});
    	totalIncome = totalIncome.toFixed(2);
    	totalCost = totalCost.toFixed(2);
    	profit = (totalIncome - totalCost).toFixed(2);
    	sign = "${currencyType.symbol}";
    	$("#totalIncome").html('<span style="font-size:16px;font-weight:bold;">Income:&nbsp;&nbsp;'+sign+totalIncome+'</span>');
    	$("#totalCost").html('<span style="font-size:16px;font-weight:bold;">Cost:&nbsp;&nbsp;'+sign+totalCost+'</span>');
    	$("#profit").html('<span style="font-size:16px;font-weight:bold;">Profit:&nbsp;&nbsp;'+sign+profit+'</span>');
	});
	
	$("#settleButton").click(function(){
		$("#settleForm").submit();
	});
	
	$("#addCost").click(function(){
		var index = $("#index").val();
		index=parseInt(index)+1;
		$("#index").attr("value",index);
		str ='<tr>'+
				'<td>${tour.tourCode}</td>'+
				'<td><input type="hidden" class="supplierName" name="europeTourPriceList['+index+'].venderId" style="width:100%;"/><input name="europeTourPriceList['+index+'].venderName" id="supplierShortNameId" type="hidden" /></td>'+
				'<td><input type="text" name="europeTourPriceList['+index+'].invoiceNo" style="width:100%;" class="form-control"/></td>'+
				'<td><input type="text" name="europeTourPriceList['+index+'].receivableAmount" class="form-control"></td>'+
				'<td><input type="text" name="europeTourPriceList['+index+'].remark" class="form-control"><input type="hidden" name="europeTourPriceList['+index+'].payOrCost" value="1"></td>'+
				'<td></td>'+
				'<tr>';
		
		$("#costList").append(str);
		selectInit();
	});
	
	$("#saveButton").click(function(){
		$("#saveForm").submit();
	});
	
	$("#settleOP").click(function(tourId){
		tourId = "${tour.tourId}";
		location.href="${base}/admin/supplierPrice/settleForOP.jhtml?tourId="+tourId;
	});
	
	$(".editEurope").each(function(){
		$(this).click(function(){
		});
	});
	
	$(".editEurope").click(function(){
	});
	
	function customerList(id){
		window.location.href="${base}/admin/supplierPrice/customerList.jhtml?orderId="+id;;
	}
	
	function selectInit(){
		$(".supplierName").select2({
			placeholder:"Search Agency", //文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				//url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
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
			escapeMarkup: function (m) {
				//保存酒店名称
				$("#supplierShortNameId").val(m);
				return m; 
			}
		});
		
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	};
	
	function updateEuropeCustomerFee(europeTourPriceId,t){
		tourId = "${tour.tourId}";
		$("#updateTourId").attr("value",tourId);
		$("#updateVenderId").attr("value",$(t).parent().children().eq(1).find("span").html());
		$("#updateSupplier").attr("value",$(t).parent().children().eq(1).html());
		$("#updateRemark").attr("value",$(t).parent().children().eq(4).html());
		$("#updateReceivableAmount").attr("value",$(t).parent().children().eq(3).html());
		$("#europeTourPriceId").attr("value",europeTourPriceId);
		$("#updateInvoiceNo").attr("value",$(t).parent().children().eq(2).html());
		selectInit();
		$("#alertEditButton").click();
	}
	
	function updateEuropeFee(){
		$("#updateEuropeFeeForm").submit();
	}
	
	function goback(){
		window.location.href="${base}/admin/supplierPrice/billListForEurope.jhtml";
	}
</script>
</body>
</html>
