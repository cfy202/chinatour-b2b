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
				<td colspan="14" style="font-size:15px;text-align:center;font-weight:bold;">
					[#if (order.orderType==2)]${venderName}-Agency Booking
					[#elseif (order.orderType==1)]Tour Booking
					[#elseif (order.orderType==5)]Other Booking
					[#elseif lineName??]${lineName}-Booking Detail
					[#else]Booking Detail
					[/#if]
					(${order.time}${order.year})
				</td>
			</tr>
			<tr>
				<td colspan="14" style="text-align:right;border-bottom:1px solid #DADADA;font-weight:bold;">
					<span style="padding:0 0 0 15px;font-size:13px;">Total:</spna>
					<span style="padding:0 0 0 8px;">Passenger：${orders.totalPeople}</spna>
					<span style="padding:0 0 0 8px;">Amount：${orders.commonTourFee}</span>
					<span style="padding:0 0 0 8px;">Income：${orders.pay}</span>
					<span style="padding:0 0 0 8px;">Cost：${orders.cost}</span>
					<span style="padding:0 0 0 8px;">Profit：${((orders.pay)!0)-((orders.cost)!0)}</span>
					<!--[#if (order.orderType!=5)]
					 5%Profit:<span style="padding:0 0 0 8px;" id='spanId'>0</span>
					 Retained Profits:<span style="padding:0 0 0 8px;"  id='totalSumId'>0</span>
					[/#if]-->
				</td>
			</tr>
			<tr>
				<th style="width:5px;border-bottom:1px solid #DADADA;">NO.</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Tour Code</th>
				[#if (order.orderType!=5)]
				<th style="width:5px;border-bottom:1px solid #DADADA;">Grand Total</th>
				[/#if]
				<th style="width:5px;border-bottom:1px solid #DADADA;">Booking No. </th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Agent</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Arrival Date</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Settlement Date</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Total Passenger</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Amount</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Income</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Cost</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Profit</th>
				<!--<th style="width:5px;border-bottom:1px solid #DADADA;">Balance</th>-->
				<!--[#if (order.orderType!=5)]
				<th style="width:5px;border-bottom:1px solid #DADADA;">5%Profit</th>
				<th style="width:5px;border-bottom:1px solid #DADADA;">Balance</th>
				[/#if]-->
			</tr>
			[#list orderList as orderlist]
			<tr>
				<td style="width:5px">${orderlist_index+1}</td>
		[#if (order.orderType!=5)]
			 [#if orderList[orderlist_index].tourCode!=orderList[orderlist_index-1].tourCode]
				<td 
				[#if orderList[orderlist_index].tourCode==orderList[orderlist_index+1].tourCode]
					style="border-bottom-width: 0px;"
				 [/#if]
				 >${orderlist.tourCode}</td>
				[#if orderList[orderlist_index].tourCode==orderList[orderlist_index+1].tourCode]
					<td style="border-bottom-width: 0px;" id="su_${orderlist.tourId}"></td>
				 [#else]
				 	<td id="su_${orderlist.tourId}"></td>
				 [/#if]
				
				[#else]
					 [#if orderlist.tourCode==null]
					 	<td></td>
						<td></td>
					 [#else]
						 <td style=" border-top-width: 0px;  border-bottom: #ff0000 0px solid;"></td>
						<td style=" border-top-width: 0px;  border-bottom: #ff0000 0px solid;"></td>
					 [/#if]
				[/#if]
			[#else]
				<td>${orderlist.tourCode}</td>
			[/#if]
				<td>${orderlist.orderNo}</td>
				<td>${orderlist.userName}</td>
				<td>[#if (orderlist.arriveDateTime)??]${orderlist.arriveDateTime?string('yyyy-MM-dd')}[/#if]</td>
				<td>[#if (orderlist.checkTime)??]${orderlist.checkTime?string('yyyy-MM-dd')}[/#if]</td>
				<td>${orderlist.totalPeople}</td>
				<td>${orderlist.commonTourFee?string("0.00")}</td>
				<td>${orderlist.pay?string("0.00")}</td>
				<td>${orderlist.cost?string("0.00")}</td>
				<td>${(orderlist.pay-orderlist.cost)?string("0.00")}</td>
				[#if (order.orderType!=5)]
					[#if (orderlist.state!=5)&&(orderlist.priceExpression)??]
						<!--<td>${((orderlist.pay-orderlist.cost)*orderlist.priceExpression)?string("0.00")}</td>-->
						<!--<td>${((orderlist.pay-orderlist.cost)-((orderlist.pay-orderlist.cost)*orderlist.priceExpression))?string("0.00")}</td>-->
						<input type="hidden" class="su_${orderlist.tourId}" value="${(orderlist.pay-orderlist.cost)-((orderlist.pay-orderlist.cost)*orderlist.priceExpression)}" />
						[#assign profitSum=(((orderlist.pay-orderlist.cost)*orderlist.priceExpression)+profitSum)?number]
						[#assign totalProfitSum=(((orderlist.pay-orderlist.cost)-((orderlist.pay-orderlist.cost)*orderlist.priceExpression))+totalProfitSum)?number]
					[#else]
						<!--<td>0.00</td>-->
						<!--<td>${(orderlist.pay-orderlist.cost)?string("0.00")}</td>-->
						<input type="hidden" class="su_${orderlist.tourId}" value="${(orderlist.pay-orderlist.cost)}" />
						[#assign totalProfitSum=((orderlist.pay-orderlist.cost)+totalProfitSum)?number]
					[/#if]
					
				[/#if]
				<!--<td>${(orderlist.pay-orderlist.cost)?string("0.00")}</td>-->
			</tr>
			[/#list]
		</table>
		<div style="font-size:12px;text-align:center;font-weight:bold;">
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
	$(document).ready(function () {
    	sumTotal();
    	<!--$("#spanId").html(${profitSum});-->
    	<!--$("#totalSumId").html(${totalProfitSum});-->
    });
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
