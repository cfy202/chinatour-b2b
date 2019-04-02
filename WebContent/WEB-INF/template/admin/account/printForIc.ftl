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
<body>
<div>
<div>
	<input style="margin-left:94%;margin-bottom:10px;" type="button" name="printBtn"  id="printBtn" value="Print Page" onclick="printPage()"/>
</div>
<div id="printBox">
	<table cellspacing="0" cellpadding="0" border="1">
		<thead>
			<tr>
				<th width="10%">Business Code</th>
				<th width="8%">Rate</th>
				<th width="8%">Amount</th>
				<th width="8%">Dollar</th>
				<th width="8%">Record Month</th>
				<th width="10%">Record Type</th>
				<th width="10%">Tour Code</th>
				<th width="10%">BillTo</th>
				<th width="10%">Auditing Remark</th>
				<th width="10%">Record Remark</th>
				<th width="10%">Status</th>
			</tr>
		</thead>
		<tbody>
			[#list listInvoiceAndCredit as listInvoiceAndCredit]
				<tr>
					<td width="10%">${listInvoiceAndCredit.prefix}-${listInvoiceAndCredit.businessNo}</td>
					<td width="8%">${listInvoiceAndCredit.exchangeRate}</td>
					<td width="8%">${listInvoiceAndCredit.enterCurrency}</td>
					<td width="8%">${listInvoiceAndCredit.dollar}</td>
					<td width="8%">
						[#if listInvoiceAndCredit.month??]${listInvoiceAndCredit.month?string("yyyy-MM")}[/#if]
					</td>
					<td width="10%">${listInvoiceAndCredit.recordType}</td>
					<td width="10%">${listInvoiceAndCredit.tourCode}</td>
					<td width="10%">${listInvoiceAndCredit.deptName}</td>
					<td width="10%">${listInvoiceAndCredit.confirmRemarks}</td>
					<td width="10%">${listInvoiceAndCredit.remarks}</td>
					<td width="10%">${listInvoiceAndCredit.confirmStatus}</td>
				</tr>
			[/#list]
		</tbody>
	</table>
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
