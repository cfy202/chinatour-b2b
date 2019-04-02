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
<style type="text/css">
*{margin:0;padding:10px;}
.over{cursor: pointer;background:red;}

.invPriTable{width:770px;height:auto;}
.invPriTable,.invPriTable td{padding:5px;border:1px #000 solid;border-collapse:collapse;}
#printBox{width:800px;height:auto;margin:0 auto 0;}
</style>
<body>
<div style="float:right">
	<input type="button" value="Print Page" onclick="printPage()">
</div>
	<div id="printBox">
		<div align="center" id="printContent">
			<div align="left" style="margin:10px;height: auto; font-size: 16px; font-family: 'Arial'; font-weight: bold;">
				Agent Print Booking Statistics Details:
			</div>
			
			<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
				<tr>
					<td colspan="14" style="text-align:center;font-family:'Arial';color:#001144;font-size:18px;font-weight:bold;line-height:25px;padding:2px 5px 2px 5px;">
							Agent Booking Statistics Details(Booking [#if (ordersTime.settlementDateBeg)??]${(ordersTime.settlementDateBeg)?string('yyyy-MM-dd')}[/#if][#if (ordersTime.settlementDateEnd)??]——${(ordersTime.settlementDateEnd)?string('yyyy-MM-dd')}[/#if])
					</td>
				</tr>
				<tr>
					  <td colspan="14" style="text-align:right;font-family:'Arial';color:#001144;font-size:14px;font-weight:bold;line-height:25px;padding:2px 5px 2px 5px;">
						Total:&nbsp;&nbsp;
						Pax:[#if (order.totalPeople)??]${order.totalPeople}[#else]0[/#if],&nbsp;&nbsp;
						Tour Accounts receivable: [#if (order.commonTourFee)??] ${(order.commonTourFee)?string(",##0.00")}[#else]0.00[/#if] ,
						Income:
							[#if (order.payTotalSum)??]${order.payTotalSum?string(",##0.00")}[#else]0.00[/#if] ,
						Cost:
							[#if (order.costTotalSum)??]${order.costTotalSum?string(",##0.00")}[#else]0.00[/#if] ,
						Profit : 
							[#if (order.payTotalSum)??||(order.costTotalSum)??]${(order.payTotalSum-order.costTotalSum)?string(",##0.00")}[#else]0.00[/#if]
					    <!--,
					    5% Profit: 
					       <span id='spanId'>0</span>-->
							<!--[#if (order.payTotalSum)??||(order.costTotalSum)??]${((order.payTotalSum-order.costTotalSum)*0.05)?string(",##0.00")}[#else]0.00[/#if]-->
					  	<!--Retained Profits:-->
							<!--[#if (order.payTotalSum)??||(order.costTotalSum)??]${((order.payTotalSum-order.costTotalSum)*0.95)?string(",##0.00")}[#else]0.00[/#if]-->
							<!--<span id='totalSumId'>0</span>-->
					  </td>
				</tr>
				<tr>
					<td width="10%" style="text-align: center;">Tour Code</td>
					<td width="10%" style="text-align: center;">Grand Total</td>
					<td width="10%" style="text-align: center;">Booking No.</td>
					<td width="10%" style="text-align: center;">Supplier</td>
					<td width="10%" style="text-align: center;">Settlement Date</td>
					<td width="10%" style="text-align: center;">Agent</td>
					<td width="10%" style="text-align: center;">totalPeople</td>
					<td width="10%" style="text-align: center;">Settlement Status</td>
					<td width="10%" style="text-align: center;">Total Amount</td>
					<td width="6%" style="text-align: center;">Income</td>
					<td width="6%" style="text-align: center;">Cost</td>
					<td width="6%" style="text-align: center;">Total Profit</td>
					<!--<td width="6%" style="text-align: center;">5% Profit</td>-->
					<!--<td width="6%" style="text-align: center;">Profit</td>-->
				</tr>
				[#list ordersList as ordersTotal]
					<tr >
					 [#if ordersList[ordersTotal_index].tourCode!=ordersList[ordersTotal_index-1].tourCode]
						<td width="10%" align="center"
						[#if ordersList[ordersTotal_index].tourCode==ordersList[ordersTotal_index+1].tourCode]
							style="border-bottom-width: 0px;"
						 [/#if]
						 >${ordersTotal.tourCode}</td>
						[#if ordersList[ordersTotal_index].tourCode==ordersList[ordersTotal_index+1].tourCode]
							<td width="10%" align="center" style="border-bottom-width: 0px;" id="su_${ordersTotal.tourId}"></td>
						 [#else]
						 	<td width="10%" align="center">
						 		[#if (ordersTotal.payCost)??]
								[#if (ordersTotal.priceExpression)??&&(ordersTotal.orderType!=5)&&(ordersTotal.state!=5)&&(ordersTotal.state!=6)]
									<!--${((ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)*(1-ordersTotal.priceExpression))?string(",##0.00")}-->
									${(ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)?string(",##0.00")}
								[#else]
									${(ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)?string(",##0.00")}
								[/#if]
							[#else]
								0
							[/#if]
						 	</td>
						 [/#if]
						
						[#else]
						<td style=" border-top-width: 0px;  border-bottom: #ff0000 0px solid;"></td>
						<td style=" border-top-width: 0px;  border-bottom: #ff0000 0px solid;"></td>
						[/#if]
						<td width="10%" align="center">${ordersTotal.orderNo}</td>
						<td width="10%" align="center">${ordersTotal.peerId}</td>
						<td width="10%" align="center">[#if (ordersTotal.checkTime)??]${ordersTotal.checkTime?string('yyyy-MM-dd')}[/#if]</td>
						<td width="10%" align="center">${ordersTotal.userName}</td>
						<td width="15%" align="center">${ordersTotal.totalPeople}</td>
						<td width="10%" align="right">
							[#if ordersTotal.tax==3]
							 	Settling
							[#elseif (ordersTotal.tax==2)||(ordersTotal.tax==4)]
								Settled
							[#elseif ordersTotal.tax==0]
								Unsettled
							[/#if]
						</td>
						<td width="10%" align="center" >${(ordersTotal.commonTourFee)?string(",##0.00")}</td>
						<td width="6%" align="center">
							[#if (ordersTotal.payCost)??]
								${(ordersTotal.payCost.payTotalSum)?string(",##0.00")}
							[#else]
								0
							[/#if]
						</td>
						<td width="6%" align="center">
							[#if (ordersTotal.payCost)??]
								${(ordersTotal.payCost.costTotalSum)?string(",##0.00")}
							[#else]
								0
							[/#if]
						</td>
						<td width="6%" align="center">
							[#if (ordersTotal.payCost)??]
								${(ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)?string(",##0.00")}
							[#else]
								0
							[/#if]
						</td>
						
						<!--<td width="6%" align="center">-->
						
							[#if (ordersTotal.payCost)??&&(ordersTotal.priceExpression)??&&(ordersTotal.orderType!=5)&&(ordersTotal.state!=5)&&(ordersTotal.state!=6)]
								<!--${((ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)*ordersTotal.priceExpression)?string(",##0.00")}-->
								[#assign profitSum=(((ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)*ordersTotal.priceExpression)+profitSum)?number]
							[#else]
								<!--0-->
							[/#if]
						<!--</td>-->
						<!--<td width="6%" align="center">-->
							[#if (ordersTotal.payCost)??]
								[#if (ordersTotal.priceExpression)??&&(ordersTotal.orderType!=5)&&(ordersTotal.state!=5)&&(ordersTotal.state!=6)]
									<!--<input type="hidden" class="su_${ordersTotal.tourId}" value="${(ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)*(1-ordersTotal.priceExpression)}" />-->
									<input type="hidden" class="su_${ordersTotal.tourId}" value="${(ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)}" />
									<!--${((ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)*(1-ordersTotal.priceExpression))?string(",##0.00")}-->
									[#assign totalProfitSum=((ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)*(1-ordersTotal.priceExpression)+totalProfitSum)?number]
								[#else]
									<!--${(ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)?string(",##0.00")}-->
									<input type="hidden" class="su_${ordersTotal.tourId}" value="${ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum}" />
									[#assign totalProfitSum=((ordersTotal.payCost.payTotalSum-ordersTotal.payCost.costTotalSum)+totalProfitSum)?number]
								[/#if]
							[#else]
								<input type="hidden" class="su_${ordersTotal.tourId}" value="0" />
								<!--0-->
							[/#if]
						<!--</td>-->
					</tr>
				[/#list]
			</table>
				
			<div align="right"
				style="height: auto; font-size: 13px; font-family: 'Arial'; margin: 10px;">
				Tabulation Office：${deptName}&nbsp;&nbsp;&nbsp;
				Tabulator：[@shiro.principal /]</div>
		</div>
	</div>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
	$(document).ready(function () {
    	sumTotal();
    	<!--$("#spanId").html(${profitSum});-->
    	<!--$("#totalSumId").html(${totalProfitSum});-->
    });
 	 //打印     
	function printPage(){	
		$("#printBox").printArea();	
	}
	 //打印     
	function sumTotal(){	
		$("td[id^='su_']").each(function(){
		 var id=$(this).attr("id");
		 sum=0;
		  $("."+id).each(function(){
		    sum+=parseFloat($(this).val());
		  });
		  $(this).html(sum.toFixed(2));
		});
	}
</script>
</body>
</html>