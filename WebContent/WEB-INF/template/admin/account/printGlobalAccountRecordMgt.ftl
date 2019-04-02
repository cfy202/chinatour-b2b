[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>${message("admin.main.title")}</title>
</head>
<body style="font-size:12px;">
	<button  style="margin-left:90%;margin-top:20px;width:90px;height:35px; border: 3px solid #dedede;-moz-border-radius: 15px;-webkit-border-radius: 8px;border-radius:8px;font-zize:14px;font-weight:bold;cursor:pointer;" onclick="printPage();">Print</button>
	<div id="printBox"  style=" width:1200px;;text-align:center; margin-left:auto; margin-right:auto;" >
	<h2>Account Current&nbsp;&nbsp;(${dept})</h2>
	<div>
		<div style="float:left"><h3> ${years}</h3></div>
		<div style="float:right"><h3 >Currency $(USD)</h3></div>
	</div>
	<div style="clear:both;"></div>
	[#list listStasticAccount as stastic]
			<table cellpadding="0" cellspacing="0" style="border:2px solid #ccc;border-left:1px solid #ccc;border-bottom:1px solid #ccc;">
					<tr style="height:50px;">
						<td style="border:1px solid #ccc;border-right:0px;font-size:16px;font-weight:bold;" width="5%" style="border-left:1px solid #ccc;">Office</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;" width="7%">Beg</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Jan</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Feb</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Mar</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Apr</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">May</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">June</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Jul</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Aug</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Sep</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Oct</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Nov</td>
						<td style="border:1px solid #ccc;border-right:0px;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Dec</td>
						<td style="border:1px solid #ccc;border-left:0px;font-size:16px;font-weight:bold;"  width="7%">Subtotal</td>
					</tr>
				[#list stastic.listMonth as acc]
					<tr>
						<td style="border:1px solid #ccc;height:30px;" align="left">
							${acc.billToReceiver}
						</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.beginningValue}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.jan}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.feb}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.mar}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.apr}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.may}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.june}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.july}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.aug}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.sept}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.oct}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.nov}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.dec}&nbsp;</td>
						<td style="border:1px solid #ccc;height:30px;" align="right">${acc.subtotal}&nbsp;</td>
					</tr>		
				[/#list]
				<tr>
					<td style="border:1px solid #ccc;height:30px;" align="left">GrandTotal($):</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.beginningValueSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.janSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.febSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.marSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.aprSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.maySub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.juneSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.julySub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.augSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.septSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.octSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.novSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.decSub}&nbsp;</td>
					<td style="border:1px solid #ccc;height:30px;" align="right">${stastic.grandTotal}&nbsp;</td>
				</tr>
			</table>
		</div>
	[/#list]
	</div>
	<div style="margin-left:80%;margin-top:20px;">
		<h4>制&nbsp;&nbsp;表&nbsp;&nbsp;人：${userName}</h4>
		<h4>制表时间：${date}</h4>
	</div>
</body>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
function printPage(){	
			$("#printBox").printArea();	
		}
</script>
</html>
