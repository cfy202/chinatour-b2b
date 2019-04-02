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
		a{cursor:pointer;}
		.rounded-rectangular {
			width:100%;
			height:50px;
			border:1.5px solid #ccc;
			border-radius: 25px;
		}
		
		td a{
			color:#000;
		}
		
		td{
			border-left:1.5px solid #ccc;
			border-right:1.5px solid #ccc;
		}
		th{border-bottom:1.5px solid #ccc;}
		table{
			border:1.5px solid #ccc;
		}
	</style>
    <title>${message("admin.main.title")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>
<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>View Report</h3>
            <div class="new"><a class="btn btn-success btn-flat md-trigger" type="hidden" onclick="print();" data-modal="form-primary">&nbsp;&nbsp; Print &nbsp;&nbsp;</a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Financial Reports</a></li>
            </ol>
        </div>
       <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
					<div class="tab-content block-flat">
					<div class="rounded-rectangular"  style="margin-bottom:30px;">
						<div style="float:left; padding-left;20px;">
						
							<span style="line-height:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year:
								<label>
									<select name="years" id ="yearChange" class="select2">
											  <option value="2019">2019</option>
											  <option value="2018">2018</option>
											  <option value="2017">2017</option>
											  <option value="2016">2016</option>
									          <option value="2015">2015</option>
									          <option value="2014">2014</option>
									          <option value="2013">2013</option>
									          <option value="2012">2012</option>
									          <option value="2011">2011</option>
								 	</select>
							 	</label>
						 	</span>&nbsp;&nbsp;&nbsp;&nbsp;
						 	<span style="line-height:40px;">Currency:USD($)</span>
						</div>
						<div class="pull-right">
							<ul style="line-height:40px;">
								<li style="float:left; list-style-type:none;margin-left:10px;">Sales Income:<span style="width:10px;height:10px;background:#F0FFF0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:left; list-style-type:none;margin-left:10px;">Tour Cost:<span style="width:10px;height:10px;background:#FFF8DC;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:left; list-style-type:none;margin-left:10px;">Gross Profit:<span style="width:10px;height:10px;background:#F0FFF0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:left; list-style-type:none;margin-left:10px;">Expense:<span style="width:10px;height:10px;background:#FFF8DC;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
								<li style="float:left; list-style-type:none;margin-left:10px; padding-right:20px;">Net Profit:<span style="width:10px;height:10px;background:#E6E6FA;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
							</ul>
						</div>
					</div>
                                <table class="table table-bordered" id="datatable2" cellspacing="1" cellpadding="4">
                                    <thead>
	                                    <tr>
	                                        <th>Office</th>
	                                        <th>Jan.</th>
	                                        <th>Feb.</th>
	                                        <th>Mar.</th>
	                                        <th>Apr.</th>
	                                        <th>May.</th>
	                                        <th>June.</th>
	                                        <th>Jul.</th>
	                                        <th>Aug.</th>
	                                        <th>Sep.</th>
	                                        <th>Oct.</th>
	                                        <th>Nov.</th>
	                                        <th>Dec.</th>
	                                        <th>Subtotal($).</th>
	                                    </tr>
                                    </thead>
                                    <tbody id="tbodyContent">
	                                    [#list statisticalProfitList as statisticalProfit]
	                                    [#if statisticalProfit.total.profit!=0]
	                                    	<tr>
	                                    		<td style="align:center; vertical-align:middle;" rowspan="5"; colspan="1";><a onclick="showDetails('${statisticalProfit.deptId}');" style="color:#3A5FCD";">${statisticalProfit.deptName}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.jan.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.feb.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.mar.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.apr.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.may.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.jun.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.jul.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.aug.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.sep.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.oct.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.nov.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.dec.salesIncome}</a></td>
	                                    		<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.total.salesIncome}</a></td>
	                                    	</tr>
	                                    	<tr style="background:#FFF8DC;">
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.jan.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.feb.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.mar.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.apr.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.may.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.jun.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.jul.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.aug.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.sep.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.oct.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.nov.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.dec.tourCost}</a></td>
	                                    		<td><a onclick="showTourCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.total.tourCost}</a></td>
	                                    	</tr>
	                                    	<tr style="background:#F0FFF0;">
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.jan.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.feb.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.mar.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.apr.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.may.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.jun.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.jul.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.aug.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.sep.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.oct.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.nov.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.dec.income}</a></td>
	                                    		<td><a onclick="showIncomeDetails('${statisticalProfit.deptId}');">${statisticalProfit.total.income}</a></td>
	                                    	</tr>
	                                    	<tr style="background:#FFF8DC;">
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.jan.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.feb.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.mar.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.apr.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.may.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.jun.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.jul.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.aug.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.sep.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.oct.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.nov.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.dec.cost}</a></td>
	                                    		<td><a onclick="showCostDetails('${statisticalProfit.deptId}');">${statisticalProfit.total.cost}</a></td>
	                                    	</tr>
	                                    	<tr style="background:#E6E6FA;">
	                                    		<td>${statisticalProfit.jan.profit}</td>
	                                    		<td>${statisticalProfit.feb.profit}</td>
	                                    		<td>${statisticalProfit.mar.profit}</td>
	                                    		<td>${statisticalProfit.apr.profit}</td>
	                                    		<td>${statisticalProfit.may.profit}</td>
	                                    		<td>${statisticalProfit.jun.profit}</td>
	                                    		<td>${statisticalProfit.jul.profit}</td>
	                                    		<td>${statisticalProfit.aug.profit}</td>
	                                    		<td>${statisticalProfit.sep.profit}</td>
	                                    		<td>${statisticalProfit.oct.profit}</td>
	                                    		<td>${statisticalProfit.nov.profit}</td>
	                                    		<td>${statisticalProfit.dec.profit}</td>
	                                    		<td>${statisticalProfit.total.profit}</td>
	                                    	</tr>
	                                    	<tr><td colspan="14" style="height:20px;background:#fff;"></td></tr>
	                                    	[/#if]
	                                    [/#list]
                                    </tbody>
                              </table>
						</div>
					</div>
				</div>
    		</div>
		</div>
		
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
         valueTotal();
         valueProfitTotal();
    });
    $("#yearChange").change(function(){
    	year = $("#yearChange").val();
    	$.ajax({
				url:'searchInfoAjax.jhtml?year='+year,
				type:"GET",
				success:function(map){
  					$("#tbodyContent").html("");
  					//statisticalProfitList = map.statisticalProfitList;
  					//deptId = statisticalProfit['deptId'];
  					//year = staticalProfit['time']; map.listStasticAccount,function(index,accountRecord
  					str="";
  					$.each(map.statisticalProfitList,function(index,statisticalProfit){
  					if(statisticalProfit.total.profit!=0){
	  					str+='<tr>'+
								'<td style="align:center; vertical-align:middle;" rowspan="5" colspan="1"><a onclick="showDetails(\''+statisticalProfit.deptId+'\');" style="color:#3A5FCD">'+statisticalProfit['deptName']+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jan.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.feb.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.mar.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.apr.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.may.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jun.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jul.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.aug.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.sep.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.oct.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.nov.salesIncome+'</a></td>'+
								'<td style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.dec.salesIncome+'</a></td>'+
								'<td class="subTotal" style="background:#F0FFF0;"><a onclick="showSalesIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.total.salesIncome+'</a></td>'+
							'</tr>'+
							'<tr style="background:#FFF8DC;">'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jan.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.feb.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.mar.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.apr.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.may.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jun.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jul.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.aug.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.sep.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.oct.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.nov.tourCost+'</a></td>'+
								'<td><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.dec.tourCost+'</a></td>'+
								'<td class="subTotal"><a onclick="showTourCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.total.tourCost+'</a></td>'+
							'</tr>'+
	  						'<tr style="background:#F0FFF0;">'+
								'<td ><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jan.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.feb.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.mar.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.apr.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.may.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jun.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jul.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.aug.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.sep.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.oct.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.nov.income+'</a></td>'+
								'<td><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.dec.income+'</a></td>'+
								'<td class="subTotal"><a onclick="showIncomeDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.total.income+'</a></td>'+
							'</tr>'+
							'<tr style="background:#FFF8DC;">'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jan.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.feb.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.mar.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.apr.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.may.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jun.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.jul.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.aug.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.sep.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.oct.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.nov.cost+'</a></td>'+
								'<td><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.dec.cost+'</a></td>'+
								'<td class="subTotal"><a onclick="showCostDetails(\''+statisticalProfit.deptId+'\');">'+statisticalProfit.total.cost+'</a></td>'+
							'</tr>'+
							'<tr style="background:#E6E6FA;">'+
								'<td>'+statisticalProfit.jan.profit+'</td>'+
								'<td>'+statisticalProfit.feb.profit+'</td>'+
								'<td>'+statisticalProfit.mar.profit+'</td>'+
								'<td>'+statisticalProfit.apr.profit+'</td>'+
								'<td>'+statisticalProfit.may.profit+'</td>'+
								'<td>'+statisticalProfit.jun.profit+'</td>'+
								'<td>'+statisticalProfit.jul.profit+'</td>'+
								'<td>'+statisticalProfit.aug.profit+'</td>'+
								'<td>'+statisticalProfit.sep.profit+'</td>'+
								'<td>'+statisticalProfit.oct.profit+'</td>'+
								'<td>'+statisticalProfit.nov.profit+'</td>'+
								'<td>'+statisticalProfit.dec.profit+'</td>'+
								'<td  class="subTotalPro">'+statisticalProfit.total.profit+'</td>'+
							'</tr>'+
							'<tr><td colspan="14" style="height:20px;background:#fff;"></td></tr>';
							};
						});
					$("#tbodyContent").append(str);
				}
			});
			 valueTotal();
			 valueProfitTotal();
    });
    
    //全部
     function showDetails(deptId){
    	year = $("#yearChange").val();
    	if(deptId==""){
    		window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?year="+year;
    	}else{
    		window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?deptId="+deptId+"&year="+year;
    	}
    }
    //salesincome
     function showSalesIncomeDetails(deptId){
    	year = $("#yearChange").val();
    	window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?deptId="+deptId+"&year="+year+"&subjectType=3";
    }
    
    //tourcost
     function showTourCostDetails(deptId){
    	year = $("#yearChange").val();
    	window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?deptId="+deptId+"&year="+year+"&subjectType=4";
    }
    
    //income
     function showIncomeDetails(deptId){
    	year = $("#yearChange").val();
    	window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?deptId="+deptId+"&year="+year+"&subjectType=1";
    }
    
    //cost
    function showCostDetails(deptId){
    	year = $("#yearChange").val();
    	window.location.href="${base}/admin/accountSubject/businessFlowOfGlobal.jhtml?deptId="+deptId+"&year="+year+"&subjectType=2";
    }
    
    //打印
    function print(){
    	year = $("#yearChange").val();
    	window.location.href="${base}/admin/accountSubject/printSubject.jhtml?year="+year+"&flag=2";
    }
</script>
</body>
</html>
