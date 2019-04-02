[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
	<style type="text/css" media="screen">
		
		td{
			border:1px solid #000;height:30px;
		}
		table{
			border:2px solid #000;
		}
		body{
			font-size:14px;
		}
	</style>
    <title>${message("admin.main.title")}</title>
</head>
<body>
<!-- Fixed navbar -->
<button  style="margin-left:85%;margin-top:20px;width:80px;height:30px;" onclick="printPage();">Print</button>
			<div>
					<div id="printBox" style=" width:900px;;text-align:center; margin-left:auto; margin-right:auto;" >
                                <table width="100%" style="border:2px solid #000;" cellspacing=0 cellpadding=0>
	                                    <tr>
	                                        <td>Office</td>
	                                        <td>Jan.</td>
	                                        <td>Feb.</td>
	                                        <td>Mar.</td>
	                                        <td>Apr.</td>
	                                        <td>May.</td>
	                                        <td>June.</td>
	                                        <td>Jul.</td>
	                                        <td>Aug.</td>
	                                        <td>Sep.</td>
	                                        <td>Oct.</td>
	                                        <td>Nov.</td>
	                                        <td>Dec.</td>
	                                        <td>Subtotal($).</td>
	                                    </tr>
	                                    [#list statisticalProfitList as statisticalProfit]
	                                    	[#if statisticalProfit.total.profit!=0]
		                                    	<tr>
		                                    		<td style="align:center; vertical-align:middle;border:1px solid #000;height:30px;" rowspan="3"; colspan="1";>${statisticalProfit.deptName}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jan.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.feb.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.mar.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.apr.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.may.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jun.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jul.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.aug.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.sep.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.oct.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.nov.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.dec.income}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.total.income}</td>
		                                    	</tr>
		                                    	<tr style="background:#FFF8DC;">
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jan.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.feb.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.mar.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.apr.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.may.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jun.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jul.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.aug.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.sep.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.oct.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.nov.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.dec.cost}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.total.cost}</td>
		                                    	</tr>
		                                    	<tr style="background:#E6E6FA;">
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jan.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.feb.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.mar.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.apr.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.may.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jun.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.jul.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.aug.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.sep.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.oct.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.nov.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.dec.profit}</td>
		                                    		<td style="border:1px solid #000;height:30px;">${statisticalProfit.total.profit}</td>
		                                    	</tr>
		                                    	<tr><td colspan="14" style="height:20px;background:#fff;"></td></tr>
	                                    	[/#if]
	                                    [/#list]
                              </table>
						</div>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
    	function printPage(){	
			$("#printBox").printArea();	
		}
   
</script>
</body>
</html>
