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
				[#if payorcost=="pay"]
					Booking Receivable(Income)
				[#elseif payorcost=="cost"]
					Booking Receivable(Cost)
				[/#if]:
			</div>
			
			<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">

				<tr>
					<td width="10%" style="text-align: center;">No.</td>
					<td width="10%" style="text-align: center;">Booking No.</td>
					<td width="10%" style="text-align: center;">Tour Code</td>
					<td width="10%" style="text-align: center;">Arrival Date</td>
					<td width="10%" style="text-align: center;">Agent</td>
					<td width="10%" style="text-align: center;">Ref. No.</td>
					<td width="10%" style="text-align: center;">Time</td>
					<td width="10%" style="text-align: center;">Amount</td>
					<td width="10%" style="text-align: center;">Agency</td>
					<td width="10%" style="text-align: center;">Status</td>
				</tr>
				[#list ordersList as orders]
					<tr >
					 <td width="10%" align="center">${orders_index+1}</td>
					 <td width="10%" align="center">${orders.orderNo}</td>
					 <td width="10%" align="center">${orders.tourCode}</td>
					 <td width="10%" align="center">${orders.scheduleOfArriveTime}</td>
					 <td width="10%" align="center">${orders.userName}</td>
					 <td width="10%" align="center">${orders.code}</td>
					 <td width="10%" align="center">[#if (orders.time)??]${orders.time?string('yyyy-MM-dd')}[/#if]</td>
					 <td width="10%" align="center">${orders.sum}</td>
					 <td width="10%" align="center">${orders.venderString}</td>
					 <td width="10%" align="center">
					 	[#if orders.status==0]
					 		未审核
					 	[#elseif orders.status==1]
					 		通   过
					 	[#elseif orders.status==2]
					 		不通过
					 	[#elseif orders.status==3]
					 		已入账
					 	[#elseif orders.status==4]
					 		系统审核
					 	[/#if]
					 </td>
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