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
			<div id="contentId"></div>
			[#if ordersTotal.tax==3]
				<button id="accCheckId" class="btn btn-primary" type="button"  onclick="accUpdateOrderTotalTaxState();">&nbsp;&nbsp;Settlement&nbsp;&nbsp;</button>
			[/#if]
			<button class="btn btn-primary" type="button" style="display:none;" id="remarkId" onclick="submitForm();">&nbsp;&nbsp;Settlement Revised Bill&nbsp;&nbsp;</button>
			<a href='${base}/admin/payCostRecords/settlementOrdersTotal.jhtml?ordersTotalId=${ordersTotal.ordersTotalId}&userId=${ordersTotal.userId}'  target="_blank" class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
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
						<h3  style="font-weight:bold;">${ordersTotal.orderNumber}-Bill</h3>
						<a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right" title="Back"><i class="fa fa-reply"></i></a>
					</div>
					<div class="row content" style="padding:0 30px;">
								<div class="col-md-2 col-sm-1" style="border: 1px solid #dadada;padding:0 20px 20px 20px;margin-left:20px;width:22%;">
									
										<div class="header color-warning">
											<h4>Invoice No. | ${ordersTotal.agent} </h4>
										</div>
										[#list ordList as ord]
											${ord.orderNo}|${ord.tourCode}<br/>
										[/#list]
								</div>
								<div class="col-md-2 col-sm-1 pull-right" style="border: 1px solid #dadada;padding:20px 5px;text-align:right;margin-right:20px;">
									<span class="color-warning">Total Profit:</span>&nbsp;&nbsp;${(order.profit+order.singleProfit)?default(0.00)?string("0.##")}<br/>
									<span class="color-warning">${dept.deptName} Profit:</span>&nbsp;&nbsp;${order.agentProfit?default(0.00)?string("0.##")}<br/>
									[#list deptList as dept]
										<span class="color-warning">${dept.deptName} Profit:</span>&nbsp;&nbsp;${order.opProfit?default(0.00)?string("0.##")}<br/>
									[/#list]
								</div>
								<div class="col-md-2 col-sm-1 pull-right" style="border: 1px solid #dadada;padding:20px 5px;text-align:right;margin-right:20px;">
									<span class="color-warning">Tour Booking Profit:</span>&nbsp;&nbsp;${order.profit?default(0.00)?string("0.##")}<br/>
									<span class="color-warning">Other Booking Profit:</span>&nbsp;&nbsp;${order.singleProfit?default(0.00)?string("0.##")}<br/>
									<span class="color-warning"></span>&nbsp;&nbsp;<br/>
									<span class="color-warning"></span>&nbsp;&nbsp;<br/>
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
													<th width="10%">Supplier</th>
													<th width="20%">Remark</th>
													<th width="10%">Status</th>
													<th width="10%">Audit Remark</th>
												</tr>
											</thead>
											<tbody class="no-border-x">
											[#list payCostRecordsList as payCostRecords]
												[#if payCostRecords.payOrCost==1&&payCostRecords.type!=9]
													<tr>
														<td>${payCostRecords.orderNo}</td>
														<td>${payCostRecords.tourCode}</td>
														<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy-MM-dd')}[/#if]</td>
														<td>${payCostRecords.sum}</td>
														<td>${payCostRecords.item}</td>
														<td>${payCostRecords.code}</td>
														<td>${ordersTotal.company}</td>
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
											[#list payCostRecordsList as payCostRecords]
												[#if payCostRecords.payOrCost==2&&payCostRecords.type!=9]
													<tr>
														<td>${payCostRecords.orderNo}</td>
														<td>${payCostRecords.tourCode}</td>
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
											</tbody>
										</table>
									</div>
									<div class="header" style="text-align:center;">
										<h4>Revised Bill</h4>
									</div>
									<div class="content">
										<form action="[@spring.url '/admin/payCostRecords/accBillOrderTotal.jhtml'/]" id="supplierPriceRemarForm" method="post">
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
																	<td><input type="hidden" value="${supplierPriceRemark.orderId}" name="orderIds"/>${supplierPriceRemark.tourCode}</td>
																	<td>[#if (supplierPriceRemark.insertTime)??]${supplierPriceRemark.insertTime?string('yyyy-MM-dd')}[/#if]</td>
																	<td>${supplierPriceRemark.differenceSum}</td>
																	<td>${supplierPriceRemark.supplierName}</td>
																	<td>${supplierPriceRemark.reason}</td>
																	[#if supplierPriceRemark.sprCheck==1]
																		[#assign flagSP =1]
																	[/#if]
																</tr>
															[/#if]
														[/#list]
														<tr>
															<td colspan="8" class="text-right" style="font-weight:bold;">
																	Cost Total : ${order.costTotalSum}
																	<input type="hidden" value="${supplierCheck.toRateOfCurrencyId}" name="toRateOfCurrencyId"/>
															</td>
														</tr>
												</tbody>
											</table>
										</form>
									</div>
									<!-- <div><span class="color-warning">总利润:</span>&nbsp;&nbsp;${order.profit?default(0.00)?string("0.##")}<br/><span class="color-warning">${dept.deptName}利润:</span>&nbsp;&nbsp;${order.agentProfit?default(0.00)?string("0.##")}<br/><span class="color-warning">${deptName}利润:</span>&nbsp;&nbsp;${order.opProfit?default(0.00)?string("0.##")}</div> -->
								</div>
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
	function accUpdateOrderTotalTaxState(){
		window.location.href="${base}/admin/payCostRecords/accUpdateOrderTotalTaxState.jhtml?ordersTotalId=${ordersTotal.ordersTotalId}&userId=${ordersTotal.userId}&orderNumber=${ordersTotal.orderNumber}";
	}
	function init(){
		[#if flag==1||orderS.tax==0]
			$("#contentId").append('<p style="color:red;">New Income, please inform accountant to audit !</p>');
			$("#accCheckId").hide();
		[/#if]
		[#if flagSP==1]
			$("#remarkId").show();
		[/#if]
	}
	function submitForm(){
		$("#supplierPriceRemarForm").submit();
	}
</script>
</body>
</html>
