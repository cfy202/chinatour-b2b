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
<body style="background-color:#E7E7E7;">
<div style="float:right">
	<input type="button" value="Print Page" onclick="printPage()">
</div>
<div id="printBox" style="width:80%; text-align:center; margin:0 auto;background-color:#fff;">
	<p style="width:95%; text-align:center; margin:0 auto;height:30px;line-height:30px;font-size:16px;font-weight:bold;">${tour.tourCode}-Bill</p>
	<hr style="width:95%;height:1px;border:none;border-top:1px solid #ccc;">	
	<div style="border:1px solid #ccc;width:200px;margin-left:75%;">
			<p style="margin-left:20px;height:20px;line-height:15px;" id="profit"></p>
	</div>
	<h4 style="width:95%; text-align:center; margin:0 auto;">Income Details</h4>
	<table style="width:95%; text-align:center; margin:0 auto;"  cellspacing="0px">
			<tr style="height:30px;background-color:#ccc;">
				<td style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">OrderNo</td>
				<td style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">Amount</td>
				<td style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">Agent</td>
				<td style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">Dept</td>
				<td style="font-size:14px;font-weight:bold; width:20%; vertical-align: bottom;">State</td>
			</tr>
			[#list europeTourPriceList as europeTourPrice]
				[#if europeTourPrice.payOrCost==0]
					<tr style="font-size:12px;color:#3E3E3E;height:25px;line-height:25px;">
						<td style="width:33%; vertical-align: bottom;border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.orderNo}</td>
						<td style="width:33%; vertical-align: bottom;border-bottom:1px solid #ccc;border-left:1px solid #ccc;" class="income">${europeTourPrice.receivableAmount}</td>
						<td style="width:33%; vertical-align: bottom;border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.userName}</td>
						<td style="width:33%; vertical-align: bottom;border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.deptName}</td>
						<td style="width:33%; vertical-align: bottom;border-bottom:1px solid #ccc;border-left:1px solid #ccc;border-right:1px solid #ccc;">
						[#if europeTourPrice.completeState==1]
							New
						[#elseif  europeTourPrice.completeState==2]
							Approved(AccOP)
						[#elseif  europeTourPrice.completeState==3]
							Approved(Agent)
						[#elseif  europeTourPrice.completeState==4]
							Settled(OP)
						[#elseif  europeTourPrice.completeState==5]
							Settled(AccOP)
						[/#if]
						</td>
					</tr>
				[/#if]
			[/#list]
			<tr style="font-size:12px;color:#3E3E3E;height:25px;line-height:25px;">
				<td style="width:33%; vertical-align: bottom;"></td>
				<td style="width:33%; vertical-align: bottom;"></td>
				<td style="width:33%; vertical-align: bottom;">
					<p style="margin-left:20px;height:20px;line-height:15px;" id="totalIncome"></p>
				</td>
			</tr>
	</table>
	<h4 style="width:95%; text-align:center; margin:0 auto;margin-top:30px;">Cost Details</h4>
	<table style="width:95%; text-align:center; margin:0 auto;"  cellspacing="0px">
			<tr style="background-color:#ccc;height:30px;">
				<td style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">TourCode</td>
				<td style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Supplier</td>
				<td style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">InvoiceNo</td>
				<td style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Amount</td>
				<td style="font-size:14px;font-weight:bold; width:18%;vertical-align: bottom;">Remark</td>
				<td style="font-size:14px;font-weight:bold; width:10%;vertical-align: bottom;">State</td>
			</tr>
			[#list europeTourPriceList as europeTourPrice]
				[#if europeTourPrice.payOrCost==1]
					<tr style="font-size:12px;color:#3E3E3E;height:25px;line-height:25px;">
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.tourCode}</td>
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.venderName}</td>
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.invoiceNo}</td>
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;" class="cost">${europeTourPrice.receivableAmount}</td>
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.remark}</td>
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;border-right:1px solid #ccc;">
							[#if europeTourPrice.completeState==1]
								New
							[#elseif  europeTourPrice.completeState==2]
								Approved(AccOP)
							[#elseif  europeTourPrice.completeState==3]
								Approved(Agent)
							[#elseif  europeTourPrice.completeState==4]
								Settled(OP)
							[#elseif  europeTourPrice.completeState==5]
								Settled(AccOP)
							[/#if]
						</td>
					</tr>
				[/#if]
			[/#list]
			<tr style="font-size:12px;color:#3E3E3E;height:25px;line-height:25px;">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>
					<p style="margin-left:20px;height:20px;line-height:15px;" id="totalCost"></p>
				</td>
			</tr>
	</table>
	<h4 style="width:95%; text-align:center; margin:0 auto;margin-top:30px;">Revised Bill</h4>
	<table style="width:95%; text-align:center; margin:0 auto;"  cellspacing="0px">
			<tr style="background-color:#ccc;height:30px;">
				<td style="font-size:14px;font-weight:bold; width:40%;vertical-align: bottom;">OrderNo</td>
				<td style="font-size:14px;font-weight:bold; width:30%;vertical-align: bottom;">Amount</td>
				<td style="font-size:14px;font-weight:bold; width:30%;vertical-align: bottom;">State</td>
			</tr>
			[#list europeTourPriceList as europeTourPrice]
				[#if europeTourPrice.payOrCost==3]
					<tr style="font-size:12px;color:#3E3E3E;height:25px;line-height:25px;">
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;">${europeTourPrice.orderNo}</td>
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;" class="income">${europeTourPrice.receivableAmount}</td>
						<!--td>${europeTourPrice.remark}</td-->
						<td style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;border-right:1px solid #ccc;">
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
			<tr style="font-size:12px;color:#3E3E3E;height:25px;line-height:25px;">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>
					<p style="margin-left:20px;height:20px;line-height:15px;"></p>
				</td>
			</tr>
	</table>
</div>
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
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
    	$("#totalIncome").html('<span style="font-size:14px;font-weight:bold;">Income:&nbsp;&nbsp;'+sign+totalIncome+'</span>');
    	$("#totalCost").html('<span style="font-size:14px;font-weight:bold;">Cost:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+sign+totalCost+'</span>');
    	$("#profit").html('<span style="font-size:14px;font-weight:bold;">Profit:&nbsp;&nbsp;&nbsp;&nbsp;'+sign+profit+'</span>');
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
	
	function printPage(){	
		$("#printBox").printArea();	
	}
</script>
</body>
</html>
