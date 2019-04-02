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
			[@shiro.hasPermission name = "admin:booking"]Tour Settlement[/@shiro.hasPermission]
			[@shiro.hasPermission name = "admin:closeOrd"]Tour Settlement[/@shiro.hasPermission]
		</h2>
		<div class="pull-right">
			[#if supplierPrice.accCheck==1&&supplierPrice.allCheck==1]
				<button id="agentCheckId" class="btn btn-primary" type="button"  onclick="submitForm();">&nbsp;&nbsp;Settling&nbsp;&nbsp;</button>
			[/#if]
				<button id="checkId" class="btn btn-primary" type="button"  onclick="submitForm();">&nbsp;&nbsp;Settlement&nbsp;&nbsp;</button>
				<button class="btn btn-primary" type="button" id="New" onclick="submitForm();">&nbsp;&nbsp;Revised Bill Settlement &nbsp;&nbsp;</button> 
				<a id="btnPrint" href='${base}/admin/payCostRecords/checkOrderOfTourPofit.jhtml?menuId=303&tourId=${tour.tourId}&userId=${userId}&print=5'  target="_blank" class="btn" >打印</a>
		</div>
		<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Accouting</a></li>
			<li class="active">
				[@shiro.hasPermission name = "admin:booking"]Tour Settlement[/@shiro.hasPermission]
				[@shiro.hasPermission name = "admin:closeOrd"]Tour Settlement[/@shiro.hasPermission]
			</li>
		</ol>
	</div>
	<div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div class="header text-center">
						<h3 class="filter-bar"> Booking Bill</h3>
						<a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right" title="Back"><i class="fa fa-reply"></i></a>
					</div>
					<div class="row content" style="padding:0 30px;">
						<form action="[@spring.url '/admin/payCostRecords/checkOrderOfTourTax.jhtml'/]" id="formId" method="post">
								<div class="col-md-2 col-sm-1" style="border: 1px solid #dadada;padding:0 20px 20px 20px;margin-left:20px;">
									
										<div class="header color-warning">
											<h4>Invoice No.</h4>
										</div>
										[#list orderList as order]
											[#if order.tax==3]
												[#assign flag =1 ]
											[#elseif order.tax==0]
												[#assign temp =2 ]
											[/#if]
											<input type="hidden" value="${order.id}" name="orderIds"/>
											${order.orderNo}<br/>
										[/#list]
								</div>
								<div class="col-md-2 col-sm-1 pull-right" style="border: 1px solid #dadada;padding:20px 5px;text-align:right;margin-right:20px;">
									
										<span class="color-warning">Total Profit:</span>&nbsp;&nbsp;${order.profit?default(0.00)?string("0.##")}<br/>
										<span class="color-warning">${dept.deptName}Profit:</span>&nbsp;&nbsp;${order.agentProfit?default(0.00)?string("0.##")}<br/>
										<span class="color-warning">${deptName}Profit:</span>&nbsp;&nbsp;${order.opProfit?default(0.00)?string("0.##")}
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
											[#list payCostRecordsList as payCostRecords]
												[#if payCostRecords.payOrCost==1&&payCostRecords.type!=9]
													<tr>
														<td>${payCostRecords.orderNo}</td>
														<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy-MM-dd')}[/#if]</td>
														<td>${payCostRecords.sum}</td>
														<td>${payCostRecords.item}</td>
														<td>${payCostRecords.code}</td>
														<td>${payCostRecords.remark}</td>
														<td>
															[#if payCostRecords.status==0||payCostRecords.status==2]
																
																[#assign flag =0 ]Disapproved
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
														<td colspan="8" class="text-right" style="font-weight:bold;">
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
														<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy-MM-dd')}[/#if]</td>
														<td>${payCostRecords.sum}</td>
														<td>${payCostRecords.item}</td>
														<td>${payCostRecords.code}</td>
														<td>${payCostRecords.venderString}</td>
														<td>${payCostRecords.remark}</td>
														<td>
															[#if payCostRecords.status==0||payCostRecords.status==2]
																[#assign flag =0 ]Disapproved
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
															<tr>
																<td><input type="hidden" value="${supplierPriceRemark.supplierPriceRemarkId}" name="supplierPriceRemarkIds"/>${supplierPriceRemark.tourCode}</td>
																<td>[#if (supplierPriceRemark.insertTime)??]${supplierPriceRemark.insertTime?string('yyyy-MM-dd')}[/#if]</td>
																<td>${supplierPriceRemark.differenceSum}</td>
																<td>${supplierPriceRemark.supplierName}</td>
																<td>${supplierPriceRemark.reason}</td>
																[#if supplierPriceRemark.sprCheck==1]
																	[#assign flagSP =1]
																[/#if]
																
															</tr>
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
	function init(){
		var flag='${flag}';//财务结算
		var temp='${temp}';//申请结算
		var status='${status}'//审核状态
		//财务结算
		[@shiro.hasPermission name = "admin:closeOrd"]
			//判断是否有未结算变更单
			var flagSP='${flagSP}';
			if(flagSP!=1){
				$("#New").hide();
			}else{
				$("#formId").attr("action","[@spring.url '/admin/payCostRecords/checkOrderOfTourTax.jhtml'/]");
			}
			//财务结算
			$("#agentCheckId").hide();
			var allCheck='${tour.allCheck}';
			if((allCheck==1&&flag==0)||(allCheck==2&&flag==0)){
				$("#checkId").hide();
			}
		[/@shiro.hasPermission]
		
		//agent结算
		[@shiro.hasPermission name = "admin:booking"]
			$("#checkId").hide();
			$("#New").hide();
			
			if(status==1&&temp==2){
				$("#formId").attr("action","[@spring.url '/admin/payCostRecords/updateOrderOfTourTaxState.jhtml'/]");
			}else{
				$("#agentCheckId").hide();
			}
		[#if flag==1]
			$("#contentId").append('<p style="color:red;">New Income, please inform accountant to audit !</p>');
		[/#if]
		[#if tour.allCheck!=1&&actionBean.tour.allCheck!=3]
			$("#contentId").append('<p style="color:red;"> New bill, Don't Settlement!!</p>');
		[/#if]
		[/@shiro.hasPermission]
		
	}
</script>
</body>
</html>
