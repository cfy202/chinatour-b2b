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
</head>
<body style="background-color:#E7E7E7;font-size: 9px;color: #555;">
<div style="float:right">
	<input type="button" value="Print Page" onclick="printPage()">
</div>
	<div id="printBox" class="printBox" style="width:70%;height:70%;margin: 0 auto;background-color:#FFF;">
		<div class="header1" style="margin: 0 auto;border-bottom:1px solid #DADADA;width:95%;font-size: 9px;">
			<h1 style="text-align:center">${orders.tourCode}-Bill</h1>
		</div>
		<div style="padding:0 30px;font-size: 9px;">
			<form action="[@spring.url '/admin/payCostRecords/checkOrderOfTourTax.jhtml'/]" id="formId" method="post">
					<div style="border: 1px solid #dadada;padding:0 20px 20px 20px;margin:20px 20px 0 0 ;width:30%;">
							<div class="header" style="border-bottom:1px solid #DADADA;font-weight:bold;">
								<h4>Invoice No. |  Settlement Status </h4>
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
					<div style="border: 1px solid #dadada;padding:20px 5px;text-align:right;margin:-90px 0px 0 0;width:30%;float:right">
						<span class="color-warning">Total Income:</span>&nbsp;&nbsp;${order.payTotalSum?default(0.00)?string("0.##")}<br/>
						<span class="color-warning">Total Cost :</span>&nbsp;&nbsp;${order.costTotalSum?default(0.00)?string("0.##")}<br/>
						<span class="color-warning">Total Profit:</span>&nbsp;&nbsp;${order.profit?default(0.00)?string("0.##")}<br/>
					</div>
					<div >
						<div class="header" style="border-bottom:1px solid #DADADA;text-align:center;font-size: 9px;">
							<h4>Icome Details</h4>
						</div>
						<div>
							<table style="border-collapse: collapse;width: 100%;font-size: 9px;">
								<thead>
									<tr style="height:30px">
										<th width="10%" style="border-bottom:1px solid #DADADA;">Booking No.</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Date</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Amount </th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Payment</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Check No.</th>
										<th width="20%" style="border-bottom:1px solid #DADADA;">Remark</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Status</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Audit Remark</th>
									</tr>
								</thead>
								<tbody>
								[#list orderList as order]
									[#list order.payCostRecords as payCostRecords]
										[#if payCostRecords.payOrCost==1&&payCostRecords.type!=9]
											<tr>
												<td>${order.orderNo}</td>
												<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy/MM/dd')}[/#if]</td>
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
									<tr style="height:30px;">
										<td colspan="8" style="font-weight:bold;text-align:right">
											Income Total : ${order.payTotalSum}
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="header" style="border-bottom:1px solid #DADADA;text-align:center;font-size: 9px;">
							<h4>Cost Details</h4>
						</div>
						<div>
							<table  style="border-collapse: collapse;width: 100%;font-size: 9px;">
								<thead >
									<tr style="height:30px; font-size:9px">
										<th width="10%" style="border-bottom:1px solid #DADADA;">Booking No.</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Date</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Amount</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Payment </th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Check No.</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Supplier</th>
										<th width="20%" style="border-bottom:1px solid #DADADA;">Remark</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Status</th>
										<th width="10%" style="border-bottom:1px solid #DADADA;">Audit Remark</th>
									</tr>
								</thead>
								<tbody>
								[#list orderList as order]
									[#list order.payCostRecords as payCostRecords]
										[#if payCostRecords.payOrCost==2&&payCostRecords.type!=9]
											<tr>
												<td>${payCostRecords.orderNo}</td>
												<td>[#if (payCostRecords.time)??]${payCostRecords.time?string('yyyy/MM/dd')}[/#if]</td>
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
								[/#list]
								</tbody>
							</table>
						</div>
						<div class="header" style="border-bottom:1px solid #DADADA;text-align:center;font-size: 9px;">
							<h4>Revised Bill</h4>
						</div>
						<div>
							<table style="border-collapse: collapse;width: 100%;font-size: 9px;">
								<thead>
									<tr style="height:30px">
									
										<th style="border-bottom:1px solid #DADADA;">Tour Code</th>
										<th style="border-bottom:1px solid #DADADA;">Date</th>
										<th style="border-bottom:1px solid #DADADA;">Amount </th>
										<th style="border-bottom:1px solid #DADADA;">Content</th>
										<th style="border-bottom:1px solid #DADADA;">Reason</th>
									</tr>
								</thead>
								<tbody>
										[#list supplierPriceRemarkList as supplierPriceRemark]
											[#if supplierPriceRemark.sprCheck==1]
												<tr>
													<td><input type="hidden" value="${supplierPriceRemark.supplierPriceRemarkId}" name="supplierPriceRemarkIds"/>${supplierPriceRemark.tourCode}</td>
													<td>[#if (supplierPriceRemark.insertTime)??]${supplierPriceRemark.insertTime?string('yyyy/MM/dd')}[/#if]</td>
													<td>${supplierPriceRemark.differenceSum}</td>
													<td>${supplierPriceRemark.supplierName}</td>
													<td>${supplierPriceRemark.reason}</td>
													[#if supplierPriceRemark.sprCheck==1]
														[#assign flagSP =1]
													[/#if]
												</tr>
											[/#if]
										[/#list]
										<tr style="height:30px;font-size: 9px;">
											<td colspan="8" style="font-weight:bold;text-align:right">
													Cost Total : ${order.costTotalSum}
											</td>
										</tr>
								</tbody>
							</table>
						</div>
					</div>
			</form>
		</div>
	</div>

<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
 	 //打印     
	function printPage(){	
		$("#printBox").printArea();	
	}
</script>
</body>
</html>
