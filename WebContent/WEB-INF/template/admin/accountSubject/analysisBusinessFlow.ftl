[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <link rel="stylesheet" type="text/css" href="[@spring.url '/resources/js/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css'/]" />
    <style type="text/css" media="screen">
		a{cursor:pointer;}
		
		.noBorder{
			border:0px;
		}
	</style>
    <title>${message("admin.main.title")}</title>
</head>
<body>
<div>
	<div id="tittleContent" style="width:100%;height:60px;border:1px solid #ccc;overflow-y:auto;border-radius: 6px;margin-bottom:10px;font-size:10px;">
					<div class="rounded-rectangular"  style="margin-bottom:30px;">
						<div style="float:left; padding-left;20px;">
						
							<span style="line-height:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year:
								<label>
									<select name="years" id ="yearChange" class="select2">
											  <option value="2019"[#if year==2019] selected = "selected"[/#if]>2019</option>
											  <option value="2018"[#if year==2018] selected = "selected"[/#if]>2018</option>
											  <option value="2017"[#if year==2017] selected = "selected"[/#if]>2017</option>
											  <option value="2016"[#if year==2016] selected = "selected"[/#if]>2016</option>
									          <option value="2015"[#if year==2015] selected = "selected"[/#if]>2015</option>
									          <option value="2014"[#if year==2014] selected = "selected"[/#if]>2014</option>
									          <option value="2013"[#if year==2013] selected = "selected"[/#if]>2013</option>
									          <option value="2012"[#if year==2012] selected = "selected"[/#if]>2012</option>
								 	</select>
							 	</label>
						 	</span>&nbsp;&nbsp;&nbsp;&nbsp;
						 	<span style="line-height:40px;">Currency:USD($)</span>
						</div>
						<div class="pull-right">
							<ul style="line-height:40px;">
								<li style="float:left; list-style-type:none;margin-left:10px;">Income:<span style="width:10px;height:10px;background:#F0FFF0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:left; list-style-type:none;margin-left:10px;">Cost & Expense:<span style="width:10px;height:10px;background:#FFF8DC;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:left; list-style-type:none;margin-left:10px; padding-right:20px;">Profit:<span style="width:10px;height:10px;background:#E6E6FA;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:right; list-style-type:none;margin-left:10px; padding-right:20px;"><button id="exportButton">export</button></li>
								<li style="float:right; list-style-type:none;margin-left:3px; padding-right:20px;"><button onclick="printPage();">print</button></li>
							</ul>
						</div>
					</div>
	</div>
<div id="content" style="border-bottom:1px solid #ccc;border-left:1px solid #ccc;border-right:1px solid #ccc;border-radius: 10px;">
	<div id="table_content">
		<table cellspacing="0" cellpadding="0" width="100%">
			<thead>
				<tr>
					<th width="5%" rowspan="1" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Office</th>
					<th width="7%" colspan="1" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Jan.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Feb.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Mar.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Apr.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">May.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">June</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Jul.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Aug</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Sep.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Oct.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Nov.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">Dec.</th>
					<th width="7%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;border-radius: 10px 12px 0px 0px;font-size:12px;">SubTotal($)</th>
				</tr>
				</thead>
				<tbody>
					[#list listStatisticalProfit as statisticalProfit]
						<tr style="background:#E6E6FA;border-bottom:1.25px solid #ccc;font-size:12px;">
                    		<td style="align:center; vertical-align:middle;" rowspan="5"; colspan="1";><a onclick="showDetails('${statisticalProfit.childAccDept}');" style="color:#3A5FCD";">${statisticalProfit.childAccDeptName}</a>[#if statisticalProfit.childAccDept==100]GrandTotal($)[/#if]</td>
                    		<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jan.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.feb.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.mar.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.apr.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.may.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jun.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jul.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.aug.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.sep.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.oct.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.nov.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.dec.salesIncome}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.total.salesIncome}</td>
						</tr>
                    	<tr style="background:#FFF8DC;border-bottom:1.25px solid #ccc;">
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jan.tourCost}
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.feb.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.mar.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.apr.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.may.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jun.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jul.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.aug.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.sep.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.oct.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.nov.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.dec.tourCost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.total.tourCost}</td>
						</tr>
						<tr style="background:#E6E6FA;border-bottom:1.25px solid #ccc;">
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jan.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.feb.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.mar.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.apr.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.may.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jun.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jul.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.aug.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.sep.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.oct.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.nov.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.dec.income}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.total.income}</td>
						</tr>
						<tr style="background:#FFF8DC;border-bottom:1.25px solid #ccc;">
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jan.cost}
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.feb.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.mar.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.apr.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.may.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jun.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jul.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.aug.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.sep.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.oct.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.nov.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.dec.cost}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.total.cost}</td>
						</tr>
						<tr style="background:#E6E6FA;border-bottom:1.25px solid #ccc;">
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jan.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.feb.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.mar.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.apr.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.may.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jun.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.jul.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.aug.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.sep.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.oct.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.nov.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.dec.profit}</td>
							<td align="right" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;">${statisticalProfit.total.profit}</td>
						</tr>
						<tr style="border-bottom:1.25px solid #ccc;">
							<td colspan="14" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:30px;line-height:30px;margin:1px;"></td>
						</tr>
					[/#list]
			    </tbody>
		</table>
		</div>
	</div>
	<form id="formId" method="post">
		<input name="deptId" type="hidden" value="${deptId}"> 
		<input name="accountDateStr" type="hidden" id="accountDateStr">
	</form>
</div>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/admin/js/common.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
	$(document).ready(function () {
    });
    
    function showDetails(childAccDept){
    	deptId = "${deptId}";
    	year = $("#yearChange").val();
    	window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?deptId="+deptId+"&year="+year+"&childAccDept="+childAccDept;
    }
    
    $("#yearChange").change(function(){
    	year = $("#yearChange").val();
    	$("#accountDateStr").attr("value",year);
    	$("#formId").attr("action","analysisBusinessFlow.jhtml");
    	$("#formId").submit();
    });
    
    function printPage(){	
			$("#content").printArea();	
		}
		
	$("#exportButton").click(function(){
		year = $("#yearChange").val();
    	$("#accountDateStr").attr("value",year);
    	$("#formId").attr("action","exportAnalysisBusinessFlow.jhtml");
    	$("#formId").submit();
	});
</script>
</body>
</html>
