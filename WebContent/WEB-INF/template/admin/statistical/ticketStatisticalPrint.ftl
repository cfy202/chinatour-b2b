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
<body style="background-color:#E7E7E7;font-size: 12px;color: #555;">
	<div style="float:right">
		<input type="button" value="Print Page" onclick="printPage()">
	</div>
	<div id="printBox" class="printBox" style="width:70%;height:70%;margin: 0 auto;background-color:#FFF;text-align:center;font-family:'Arial';font-size:12px;line-height:25px;padding:2px 5px 2px 5px;">
		<div style="font-size:18px;text-align:center;font-weight:bold;">
			Statistics Sheet Print
		</div>
		<table border="1" border-color="#DADADA" cellpadding="0" cellspacing="0" align="center" style="text-align:center;font-size:12px;">
			<tr>
				<td colspan="18" style="font-size:15px;text-align:center;font-weight:bold;">
					${vender.name}&nbsp;&nbsp;air Ticket Detail
					(${so.time}${so.year})
				</td>
			</tr>
			<tr>
				<td colspan="18" style="text-align:right;border-bottom:1px solid #DADADA;font-weight:bold;">
					<span style="padding:0 0 0 15px;font-size:13px;">Total:</spna>
					<span style="padding:0 0 0 8px;">Qty ：${sf.quantity}</spna>
					<span style="padding:0 0 0 8px;">ARC：${sf.tempValue06}</spna>
					<span style="padding:0 0 0 8px;">Bill/Credit：${((air.amount)!0)-((air.charge)!0)}</span>
					<span style="padding:0 0 0 8px;">Charge：${sf.charge}</span>
					<span style="padding:0 0 0 8px;">Selling：${sf.amount}</span>
					<span style="padding:0 0 0 8px;">Net：${sf.operatorFee}</span>
					<span style="padding:0 0 0 8px;">Profit：${((sf.amount)!0)-((sf.operatorFee)!0)}</span>
				</td>
			</tr>
			<tr>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Date</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Invoice Number</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Ticket</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Air</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">ARC</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Bill/Credit</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Charge</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Selling</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Net</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Profit</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Remark</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Class</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">DES</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">PNR</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Agent</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Card</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Dept</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Agency</th>
			</tr>
			[#list airList as air]
			<tr>
				<td style="width:5px">[#if (air.date)??]${air.date?string('yyyy-MM-dd')}[/#if]</td>
				<td>${air.invoiceNo}</td>
				<td>${air.ticketNo}</td>
				<td>${air.airline}</td>
				[#if (air.tempValue06)?? && (air.tempValue06)==0 ]
					<td>0.00</td>
				[#else]
					<td>${((air.operatorFee)!0)-((air.charge)!0)}</td>
				[/#if]
				<td>${((air.amount)!0)-((air.charge)!0)}</td>
				<td>${air.charge}</td>
				<td>${air.amount}</td>
				<td>${air.operatorFee}</td>
				<td>${((air.amount)!0)-((air.operatorFee)!0)}</td>
				<td>${air.remark}</td>
				<td>${air.tempValue04}</td>
				<td>${air.tempValue05}</td>
				<td>${air.flightPnr}</td>
				<td>${air.tempValue01}</td>
				<td>${air.Card}</td>
				<td>${air.deptName}</td>
				<td>${air.venderName}</td>
			</tr>
			[/#list]
		</table>
		<div style="font-size:12px;text-align:right;font-weight:bold;">
			Tabulation Division:${deptName}&nbsp;&nbsp;&nbsp;&nbsp;Tabulator:${adminName}
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
