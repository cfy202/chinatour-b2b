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
		<h2>
			Bill
		</h2>
		<div class="pull-right">
			<a href='${base}/admin/payCostRecords/viewOrdersByTourPrint.jhtml?tourId=${orders.tourId}&orderId=${orders.id}'  target="_blank" class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
		</div>
		<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Accounting</a></li>
		</ol>
	</div>
	<div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div class="header text-center">
						<h3 class="filter-bar">${orders.tourCode}-Bill</h3>
						<a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right" title="Back"><i class="fa fa-reply"></i></a>
					</div>
					<div class="row content" style="padding:0 30px;">
						<form action="[@spring.url '/admin/payCostRecords/checkOrderOfTourTax.jhtml'/]" id="formId" method="post">
								<div class="col-md-2 col-sm-1" style="border: 1px solid #dadada;padding:0 20px 20px 20px;margin-left:20px;width:25%;">
									
										<div class="header color-warning">
											<h4>Invoice No. | Settlement Status</h4>
										</div>
										[#list ordList as ord]
											${ord.orderNo} |
											[#if ord.tax==4]
												Settled
											[#elseif ord.tax==3]
												Settling		
											[#elseif ord.tax==2]
												Settled
											[#else]
												Unsettled
											[/#if]
											<br/>
										[/#list]
								</div>
								<div class="col-md-2 col-sm-1 pull-right" style="border: 1px solid #dadada;padding:20px 5px;text-align:right;margin-right:20px;height:100px;">
									<span class="color-warning">Total Income:</span>&nbsp;&nbsp;${order.payTotalSum?default(0.00)?string("0.##")}<br/>
									<span class="color-warning">Total Cost :</span>&nbsp;&nbsp;${order.costTotalSum?default(0.00)?string("0.##")}<br/>
									<span class="color-warning">Total Profit:</span>&nbsp;&nbsp;${order.profit?default(0.00)?string("0.##")}<br/>
								</div>
								<div class="col-md-12 col-sm-12">
									<div class="header" style="text-align:center;">
										<h4>Income Details</h4>
									</div>
									<div class="content">
										<table class="no-border">
											<thead class="no-border">
												<tr>
													<th width="10%">Booking No.</th>
													<th width="10%">Tour Code</th>
													<th width="10%">Date</th>
													<th width="10%">Amount </th>
													<th width="10%">Payment</th>
													<th width="10%">Check No.</th>
													<th width="20%">Remark</th>
													<th width="10%">Status</th>
													<th width="10%">Audit Remark</th>
												</tr>
											</thead>
											<tbody class="no-border-x">
											[#list orderList as order]
												[#list order.payCostRecords as payCostRecords]
													[#if payCostRecords.payOrCost==1&&payCostRecords.type!=9]
														<tr>
															<td>${order.orderNo}</td>
															<td>${order.tourCode}</td>
															<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy-MM-dd')}[/#if]</td>
															<td>${payCostRecords.sum}</td>
															<td>${payCostRecords.item}</td>
															<td>${payCostRecords.code}</td>
															<td>${payCostRecords.remark}</td>
															<td>
																[#if payCostRecords.status==0||payCostRecords.status==2]
																	[#assign flag =1 ]Disapproved
																[/#if]
																[#if payCostRecords.status==1]
																	[#assign status =1 ]Approved
																[/#if]
															</td>
															<td>${payCostRecords.confirmRemark}</td>
														</tr>
													[/#if]
												[/#list]
											[/#list]
													<tr>
														<td colspan="9" class="text-right" style="font-weight:bold;">
															Income Total : ${order.payTotalSum}
														</td>
													</tr>
											</tbody>
										</table>
									</div>
									<div class="header" style="text-align:center;">
										<h4>Cost Details</h4>
									</div>
									<div class="content">
										<table class="no-border">
											<thead class="no-border">
												<tr>
													<th width="10%">Booking No.</th>
													<th width="10%">Tour Code</th>
													<th width="10%">Date</th>
													<th width="10%">Amount</th>
													<th width="10%">Payment </th>
													<th width="10%">Check No.</th>
													<th width="10%">Supplier</th>
													<th width="20%">Remark</th>
													<th width="10%">Status</th>
													<th width="10%">Audit Remark</th>
												</tr>
											</thead>
											<tbody class="no-border-x">
											[#list orderList as order]
												[#list order.payCostRecords as payCostRecords]
													[#if payCostRecords.payOrCost==2&&payCostRecords.type!=9]
													<tr>
														<td>${order.orderNo}</td>
														<td>${order.tourCode}</td>
														<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy-MM-dd')}[/#if]</td>
														<td>${payCostRecords.sum}</td>
														<td>${payCostRecords.item}</td>
														<td>${payCostRecords.code}</td>
														<td>${payCostRecords.venderString}</td>
														<td>${payCostRecords.remark}</td>
														<td>
															[#if payCostRecords.status==0||payCostRecords.status==2]
																[#assign flag =1 ]Disapproved
															[/#if]
															[#if payCostRecords.status==1]
																[#assign status =1 ]Approved
															[/#if]
															[#if payCostRecords.status==4]
																[#assign status =1 ]System Auditing
															[/#if]
														</td>
														<td>${payCostRecords.confirmRemark}</td>
													</tr>
												[/#if]
												[/#list]
											[/#list]
											</tbody>
										</table>
									</div>
									<div class="header" style="text-align:center;">
										<h4>Revised Bill</h4>
									</div>
									<div class="content">
										<table class="no-border">
											<thead class="no-border">
												<tr>
													<th>Tour Code</th>
													<th>Date</th>
													<th>Amount </th>
													<th>Content</th>
													<th>Reason</th>
												</tr>
											</thead>
											<tbody class="no-border-x">
													[#list supplierPriceRemarkList as supplierPriceRemark]
														[#if (supplierPriceRemark.sprCheck==1)||(supplierPriceRemark.sprCheck==5)]
															<tr>
																<td><input type="hidden" value="${supplierPriceRemark.supplierPriceRemarkId}" name="supplierPriceRemarkIds"/>${supplierPriceRemark.tourCode}</td>
																<td>[#if (supplierPriceRemark.insertTime)??]${supplierPriceRemark.insertTime?string('yyyy-MM-dd')}[/#if]</td>
																<td>${supplierPriceRemark.differenceSum}</td>
																<td>${supplierPriceRemark.supplierName}</td>
																<td>${supplierPriceRemark.reason}</td>
															</tr>
														[/#if]
													[/#list]
													<tr>
														<td colspan="8" class="text-right" style="font-weight:bold;">
																Cost Total : ${order.costTotalSum}
														</td>
													</tr>
											</tbody>
										</table>
									</div>
									<!-- <div><span class="color-warning">总利润:</span>&nbsp;&nbsp;${order.profit?default(0.00)?string("0.##")}<br/><span class="color-warning">${dept.deptName}利润:</span>&nbsp;&nbsp;${order.agentProfit?default(0.00)?string("0.##")}<br/><span class="color-warning">${deptName}利润:</span>&nbsp;&nbsp;${order.opProfit?default(0.00)?string("0.##")}</div> -->
								</div>
						</form>
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
		init();
	});
	function submitForm(){
		$("#formId").submit();
	}
	function agentUpdateOrderTotalTaxState(){
		[#if order.payTotalSum!=order.commonTourFee]
			alert("Income 与 订单应收款不相等，不能结算！");
		[#else]
		window.location.href="${base}/admin/payCostRecords/agentUpdateOrderTotalTaxState.jhtml?ordersTotalId=${ordersTotal.ordersTotalId}";
		[/#if]
	}
	function init(){
		[#if flag==1]
			$("#contentId").append('<p style="color:red;"> New Income, please inform accountant to audit !</p>');
			$("#agentCheckId").hide();
		[/#if]
		[#if tour.accCheck==2]
			$("#contentId").append('<p style="color:red;">New Bill !</p>');
			$("#agentCheckId").hide();
		[/#if]
		[#if ordersTotal.tax==3]
			$("#contentId").append('<p style="color:red;">Bill Settling !</p>');
			$("#agentCheckId").hide();
		[/#if]
	}
</script>
</body>
</html>