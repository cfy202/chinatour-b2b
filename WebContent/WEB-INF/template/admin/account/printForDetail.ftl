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
    <style type="text/css" media="screen">
		body{
			margin:0px;
			padding:0px;
			color:black;
		}
		.form-control {
		    font-size: 14px;
		    padding: 6px 8px;
		}
		span {
			font-size:16px;
		}
		.detailForTable{
			font-size:14px;
		}
		.tableForHeard td{
			font-size:16px;
			font-weight: bold;
		}
		.tableForTd tr td{
			text-align:center;
		}
		#container{
			width:960px;margin:0 auto;
		}
	</style>
</head>
<body>
<div id="container">
	<div id="printBox">
	<h3>${invoiceAndCredit.prefix}-${invoiceAndCredit.businessNo}</h3>
	<div>
		<table>
			<tr>
				<td width="13%">
					<span>BillTo:</span>
				</td>
				<td width="37%">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.billToReceiver}"> 
				</td>
				<td width="13%">
					<span>Recored Type:</span>
				</td>
				<td width="37%">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.recordType}">
				</td>
			</tr>
			<tr>
				<td style="width:13%;">
					<span>TourCode:</span>
				</td>
				<td style="width:37%;">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.tourCode}"> 
				</td>
				<td style="width:13%;">
					<span>DATE:</span>
				</td>
				<td style="width:37%;">
					<input style="width:240px;" class="form-control" type="text" value="[#if invoiceAndCredit.month??]${invoiceAndCredit.month?string("yyyy-MM-dd")}[/#if]">
				</td>
			</tr>
			<tr>
				<td style="width:13%;">
					<span>Email:</span>
				</td>
				<td style="width:37%;">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.emailTo}"> 
				</td>
				<td style="width:13%;">
					<span>Remarks:</span>
				</td>
				<td style="width:13%;">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.remarks}">
				</td>
			</tr>
			<tr>
				<td style="width:13%;">
					<span>Auditing Status:</span>
				</td>
				<td style="width:37%;">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.confirmStatus}"> 
				</td>
				<td style="width:13%;">
					<span>Auditing Remark:</span>
				</td>
				<td style="width:37%;">
					<input style="width:240px;" class="form-control" type="text" value="${invoiceAndCredit.confirmRemarks}">
				</td>
			</tr>
		</table>
	</div>
		<h3>Checking Details</h3>
		<div>
			<table class="tableForTd">
					<tr class="tableForHeard" style="font-size:14px;">
						<td width="20%">Remark</td>
						<td width="30%">Description</td>
						<td width="15%">Amount</td>
						<td width="15%">Exchange Amount</td>
						<td width="15%">USD</td>
					</tr>
					[#list invoiceAndCreditItemsList as invoiceAndCreditItemsList]
						<tr class="detailForTable">
							<td id="remarks" style="width:35%;">${invoiceAndCreditItemsList.remarks}</td>
							<td width="20%">${invoiceAndCreditItemsList.description}</td>
							<td width="15%"><input style="width:80px;" class="form-control" type="text" value="${invoiceAndCreditItemsList.amount}"></td>
							<td width="15%"><input style="width:80px;" class="form-control" type="text" value="${invoiceAndCreditItemsList.afteramount}"></td>
							<td width="15%"><input style="width:80px;" class="form-control" type="text" value="${invoiceAndCreditItemsList.dollarAmount}"></td>
						</tr>
					[/#list]
					<tr style="font-size:14px; height:50px;">
						<td width="20%">ROE($)</td>
						<td width="30%">${rateOfCurrency.rateDown}/${rateOfCurrency.rateUp}</td>
						<td width="15%"><span id="allAmount">${invoiceAndCredit.enterCurrency}</span></td>
						<td width="15%"><span id="allAfterAmount">${exchangeDoller}</span></td>
						<td width="15%"><span id="allDollarAmount">$${invoiceAndCredit.dollar}</span></td>
					</tr>
			</table>
		</div>
	</div>
<div>
</div>
<div style="position: fixed; top: 5px; right: 50px;">
	<input type="button" name="printBtn"  id="printBtn" value="Print Page" onclick="printPage()"/>
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
