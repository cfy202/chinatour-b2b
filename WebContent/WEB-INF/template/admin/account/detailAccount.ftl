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
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Bill Details</h2>
           <div class="pull-right option-left">
	            <div class="new">
	            	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	             </div>
             </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
            </ol>
        </div>
    <div class="cl-mcont">    
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">
          	<div>
          		<label><h3>Office:${dept.deptName}&nbsp;&nbsp;&nbsp;&nbsp;Reconciliation Company：${toDept.deptName}</h3></label>
            </div>							
          </div>
          <div class="content">
          		<div style="height:25px; width:100%">
					<label style="width:10%;">          	
		            	<select name="years" id ="yearChange" class="select2"  onchange="yearsChange();" >
		            	<!--
						          <option value="2015-01">2015-01</option>
						          <option value="2015-02">2015-02</option>
						          <option value="2015-03">2015-03</option>
						          <option value="2015-04">2015-04</option>
						          <option value="2015-05">2015-05</option>
						          <option value="2015-06">2015-06</option>
						          <option value="2015-07">2015-07</option>
						          <option value="2015-08">2015-08</option>
						          <option value="2015-09">2015-09</option>
						          <option value="2015-10">2015-10</option>
						          <option value="2015-11">2015-11</option>
						          <option value="2015-12">2015-12</option>
						          <option value="2016-01">2016-01</option>
						          <option value="2016-02">2016-02</option>
						          <option value="2016-03">2016-03</option>
						          <option value="2016-04">2016-04</option>
						          <option value="2016-05">2016-05</option>
						          <option value="2016-06">2016-06</option>
						          <option value="2016-07">2016-07</option>
						          <option value="2016-08">2016-08</option>
						          <option value="2016-09">2016-09</option>
						          <option value="2016-10">2016-10</option>
						          <option value="2016-11">2016-11</option>
						          <option value="2016-12">2016-12</option> -->
						          <option value="2017-01">2017-01</option>
						          <option value="2017-02">2017-02</option>
						          <option value="2017-03">2017-03</option>
						          <option value="2017-04">2017-04</option>
						          <option value="2017-05">2017-05</option>
						          <option value="2017-06">2017-06</option>
						          <option value="2017-07">2017-07</option>
						          <option value="2017-08">2017-08</option>
						          <option value="2017-09">2017-09</option>
						          <option value="2017-10">2017-10</option>
						          <option value="2017-11">2017-11</option>
						          <option value="2017-12">2017-12</option>
						          <option value="2018-01">2018-01</option>
						          <option value="2018-02">2018-02</option>
						          <option value="2018-03">2018-03</option>
						          <option value="2018-04">2018-04</option>
						          <option value="2018-05">2018-05</option>
						          <option value="2018-06">2018-06</option>
						          <option value="2018-07">2018-07</option>
						          <option value="2018-08">2018-08</option>
						          <option value="2018-09">2018-09</option>
						          <option value="2018-10">2018-10</option>
						          <option value="2018-11">2018-11</option>
						          <option value="2018-12">2018-12</option>
						          <option value="2019-01">2019-01</option>
						          <option value="2019-02">2019-02</option>
						          <option value="2019-03">2019-03</option>
						          <option value="2019-04">2019-04</option>
						          <option value="2019-05">2019-05</option>
						          <option value="2019-06">2019-06</option>
						          <option value="2019-07">2019-07</option>
						          <option value="2019-08">2019-08</option>
						          <option value="2019-09">2019-09</option>
						          <option value="2019-10">2019-10</option>
						          <option value="2019-11">2019-11</option>
						          <option value="2019-12">2019-12</option>
						 </select>
				 	</label>
				</div>
          	<div class="pull-right"><label style="cursor:pointer;" ><i class="fa fa-share-square-o md-trigger" data-modal="form-primary" title="Export"></i> </label></div>	
             <div id="tbodyContent">
             <table id="datatables" class="table table-bordered">
		        <thead>
			         <tr style="font-weight:bold;">
						<th width="10%">Month</th>
						<th width="10%">No.</th>
						<th width="18%">Remarks</th>
						<th width="12%">TourCode</th>
						<th width="10%">Receivable Amount(${Symbol})</th>
						<th width="10%">Exchange Amount(${symbolTo})</th>
						<th width="10%">Receivable Dollar Amount($)</th>
					</tr>
		        </thead>
		        <tbody>
				        [#list listAccountRecordForShow as listStasticAccount]
						[#if listStasticAccount.isData==false]
						<tr style="background:#DCEFF7;font-weight:bold;">
							<td align="left">${listStasticAccount.label}</td>
							<td align="left"></td>
							<td align="left">${listStasticAccount.remarks}</td>
							<td align="left">${listStasticAccount.tourCode}</td>
							<td align="right">${listStasticAccount.receivableCurrency?string("0.##")}</td>
							<td align="right">${listStasticAccount.receivedAmount?string("0.##")}</td>
							<td align="right">${listStasticAccount.receivableAmount?string("0.##")}</td>
						</tr>	
						[/#if]
						[#if listStasticAccount.isData==true]
							<tr>
								<td align="left">${listStasticAccount.month}</td>
								<td align="left">${listStasticAccount.businessName}-${listStasticAccount.businessNo}</td>
								<td align="left">${listStasticAccount.remarks}</td>
								<td align="left">${listStasticAccount.tourCode}</td>
								<td align="right">${listStasticAccount.receivableCurrency?string("0.##")}</td>
								<td align="right">${listStasticAccount.receivedAmount?string("0.##")}</td>
								<td align="right">${listStasticAccount.receivableAmount?string("0.##")}</td>
							</tr>
						[/#if]	
					[/#list]
		        </tbody>
		     </table>
		     </div>
		     </div>
          </div>
        </div>
      </div>
    </div>
</div>
<div class="md-overlay"></div>
</div>
<form action="jxlExcelFordetailAccount.jhtml" id="exportCondition" method="post">
    	<input  type="hidden" name="deptId" value="${dept.deptId}"/>
    	<input  type="hidden" name="billToDeptId" value="${toDept.deptId}"/>
    	<input type="hidden" name="year"/>
</form>
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Select Month:</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form action="jxlExcelFordetailAccount.jhtml"  style="border-radius: 0px;" method="post" onsubmit="return check();">
	     	<input  type="hidden" name="deptId" value="${dept.deptId}"/>
	    	<input  type="hidden" name="billToDeptId" value="${toDept.deptId}"/>
	    	<input type="hidden" name="year" id="year"/>
	     <div class="modal-body form">
	     	<div class="form-group">
	    		<div class="input-group1">
	    			<table>
	    				<tr>
		    				<td style="width:40%">
								<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm" data-min-view="2">
									<input parsley-type="dateIso" type="text" class="form-control"  placeholder="YYYY-MM" id="startMonth" name="startMonth" style="width:200px">
									<span class="input-group-addon btn btn-primary">
										<span class="glyphicon glyphicon-th"></span>
									</span>
								</div>
							</td>
							<td style="width:20%;font-size:20px;">To</td>
							<td style="width:40%">
								<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm" data-min-view="2">
									<input parsley-type="dateIso" type="text" class="form-control"  placeholder="YYYY-MM" id="endMonth" name="endMonth" style="width:200px">
									<span class="input-group-addon btn btn-primary">
										<span class="glyphicon glyphicon-th"></span>
									 </span>
								</div>
							</td>
						</tr>
					</table>
			 </div>
    		</div>
	     </div>
	        <div class="modal-footer">
	        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
	        <button type="submit" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Export</button>
	      </div>
    </form>
   </div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        
         var oTable = $('#datatables').DataTable({
            "processing": true,
            "bSort":false,
            "filter": false,
            "bPaginate":false,
        });
        $("#currentYear").val($("#yearChange").find("option:selected").val());
	  
    	$("#exportButton").click(function(){
    		$("#exportCondition").submit();
    	});
    	
    	var date = new Date();
    	now = date.getFullYear();
    	$(".select2-chosen").html(now);
	});
   function yearsChange(){
	    	var deptId = "${dept.deptId}";
	    	var toDeptId = "${toDept.deptId}";
	    	var deptName = "${dept.deptName}"
	    	var year = $("#yearChange").val();
	    	$.ajax({
				type:"GET",
				url:"${base}/admin/invoiceAndCredit/detailAccountForYear.jhtml?toDeptId="+toDeptId+"&deptId="+deptId+"&year="+year,
				dataType:"json",
				success:function(map) {
					$("#tbodyContent").html("");
					var str = "";
					str += '<table id="datatables" class="table table-bordered">'+
				        '<thead>'+
					         '<tr style="font-weight:bold;">'+
								'<th width="10%">Month</th>'+
								'<th width="10%">No.</th>'+
								'<th width="18%">Remarks</th>'+
								'<th width="12%">TourCode</th>'+
								'<th width="10%">Receivable Amount('+map.symbol+')</th>'+
								'<th width="10%">Exchange Amount('+map.symbolTo+')</th>'+
								'<th width="10%">Receivable Dollar Amount($)</th>'+
							'</tr>'+
				        '</thead>'+
		        		'<tbody>';
					$.each( map.listAccountRecordForShow,function(index,accountRecord){
						if(accountRecord['isData']==false){
							str+='<tr style="background:#DCEFF7;font-weight:bold;">'+
							'<td align="left">'+accountRecord['label']+'</td>'+
							'<td align="left"></td>'+
							'<td align="left">'+accountRecord['remarks']+'</td>'+
							'<td align="left">'+accountRecord['tourCode']+'</td>'+
							'<td align="right">'+accountRecord['receivableCurrency']+'</td>'+
							'<td align="right">'+accountRecord['receivedAmount']+'</td>'+
							'<td align="right">'+accountRecord['receivableAmount']+'</td>'+
						'</tr>';
						}else if(accountRecord['isData']==true){
							str+='<tr>'+
							'<td align="left">'+accountRecord['month']+'</td>'+
							'<td align="left">'+deptName+'-'+accountRecord['businessNo']+'</td>'+
							'<td align="left">'+accountRecord['remarks']+'</td>'+
							'<td align="left">'+accountRecord['tourCode']+'</td>'+
							'<td align="right">'+accountRecord['receivableCurrency']+'</td>'+
							'<td align="right">'+accountRecord['receivedAmount']+'</td>'+
							'<td align="right">'+accountRecord['receivableAmount']+'</td>'+
						'</tr>';
						};
						});
						str+='</tbody>'+
						'</table>';
						$("#tbodyContent").append(str);
						$.each($("td"),function(){
							if($(this).html()=="null"){
								$(this).html("");
							}
						});
						//使用dataTable
        				[@flash_message /]
						var oTable = $('#datatables').DataTable({
				            "processing": true,
				            "bSort":false,
				            "filter": false,
				            "bPaginate":false,
				        });
				        var year = $("#yearChange").find("option:selected").val();
				        $("#currentYear").val(year);
				       	$("#yearForCondition").val(year);
				        
				},
			});  
    	};    
    	
function check(){
    var endMonth=$("#endMonth").val();
    var startMonth=$("#startMonth").val();
    if(startMonth!="" && endMonth!=""){
    	var year=startMonth.substr(0,4);
    	$("#year").val(year);
    	return true;
    }else{
      alert("Please fill in the start date and end date!")
      return false;
    }
}
</script>
</html>
