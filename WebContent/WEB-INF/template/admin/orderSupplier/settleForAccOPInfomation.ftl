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
								<li style="float:left; list-style-type:none;margin-left:10px;" id="totalCost"></li>
								<li style="float:left; list-style-type:none;margin-left:10px;" id="profit"></li>
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
											<th style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">OrderNo</th>
											<th style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">Amount</th>
											<th style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">Agent</th>
											<th style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">Dept</th>
											<!--th style="font-size:14px;font-weight:bold; width:25%; vertical-align: bottom;">Remark</th-->
											<th style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">State</th>
										<tr>
									</thead>
									<tbody>
									[#assign a=(0)?number]
									[#list orderList as order]
										<tr>
											<input name="europeTourPriceList[${a}].orderId" type="hidden" value="${order.id}">
											<input name="europeTourPriceList[${a}].payOrCost" type="hidden" value="0">
											<input name="europeTourPriceList[${a}].orderNo" type="hidden" value="${order.orderNo}">
											<input name="europeTourPriceList[${a}].deptIdForOrder" type="hidden" value="${order.deptId}">
											<input name="europeTourPriceList[${a}].userIdForOrder" type="hidden" value="${order.userId}">
											<td>${order.orderNo}</td>
											<td><input type="text" name="europeTourPriceList[${a}].receivableAmount" class="form-control"></td>
											<!--td><input type="text" name="europeTourPriceList[${a}].remark" class="form-control"></td-->
											<td></td>
										</tr>
										[#assign a=(a+1)?number]
									[/#list]
									[#list europeTourPriceList as europeTourPrice]
										[#if europeTourPrice.payOrCost==0]
											<tr>
												<input type="hidden" name="europeTourPriceList[${a}].europeTourPriceId" value="${europeTourPrice.europeTourPriceId}">
												<td>${europeTourPrice.orderNo}</td>
												<td class="income">${europeTourPrice.receivableAmount}</td>
												<td>${europeTourPrice.userName}</td>
												<td>${europeTourPrice.deptName}</td>
												<!--td>${europeTourPrice.remark}</td-->
												<td>[#if europeTourPrice.completeState==5]Settled[#else]UnSettled[/#if]</td>
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
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">InvoiceNo</th>
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Amount</th>
											<th style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Remark</th>
											<th style="font-size:14px;font-weight:bold; width:10%;vertical-align: bottom;">State</th>
										<tr>
									</thead>
									<tbody id="costList">
									[#list europeTourPriceList as europeTourPrice]
										[#if europeTourPrice.payOrCost==1]
											<tr>
												<td>${europeTourPrice.tourCode}</td>
												<td>${europeTourPrice.venderName}</td>
												<td>${europeTourPrice.invoiceNo}</td>
												<td class="cost">${europeTourPrice.receivableAmount}</td>
												<td>${europeTourPrice.remark}</td>
												<td>[#if europeTourPrice.completeState==5]Settled[#else]Unsettled[/#if]</td>
											</tr>
										[/#if]
									[/#list]
									</tbody>
								</table>
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
					<div class="new"> [#if settleFlag==0]<button style="margin-left:85%;" id="saveButton" class="btn btn-success" type="button">&nbsp;&nbsp;Save &nbsp;&nbsp;</button>[/#if]</div>
				</div>
			</div>
		</div>
	</div>
</div>
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
				'<td><input type="text" name="europeTourPriceList['+index+'].receivableAmount" class="form-control"></td>'+
				'<td><input type="text" name="europeTourPriceList['+index+'].remark" class="form-control"><input type="hidden" name="europeTourPriceList['+index+'].payOrCost" value="1"></td>'+
				'<td></td>'+
				'<tr>';
		
		$("#costList").append(str);
	});
	
	$("#saveButton").click(function(){
		$("#saveForm").submit();
	});
	
	$("#settleOP").click(function(tourId){
		tourId = "${tour.tourId}";
		location.href="${base}/admin/supplierPrice/settleForAccOPPass.jhtml?tourId="+tourId;
	});
</script>
</body>
</html>
