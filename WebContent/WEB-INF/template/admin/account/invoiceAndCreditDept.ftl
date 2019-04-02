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
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Account Current</h3>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
		<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="tab-container">
							<div class="tab-content">
							<div style="height:30px;">
								<label>
									<select id="yearChange" class="select2"  name="year" onchange="yearsChange();" style="height:32px" >
							             [#list years as years]
						          			<option value="${years}">${years}</option>
						    			 [/#list]
							 		</select>
						 		</label>
						 	</div>
						 	<div class="pull-right"> Currency  $ (USD) &nbsp;&nbsp; <i style="cursor:pointer;" id="exportButton" class="fa fa-share-square-o"></i>&nbsp;&nbsp;&nbsp;&nbsp;<i  style="cursor:pointer;" id="printButton" class="fa fa-print" title="Print"></i></div>
						 	<div id="tbodyContent" style="margin-top:20px;">	
							[#list listStasticAccount as stastic]
								<div id="${stastic.deptId}">
									<table class="table table-bordered dataTable no-footer" width="100%" cellspacing="0">
									<thead>
									<tr>
										<th width="5%">Office</th>
										<th width="7%">Beg</th>
										<th width="7%">Jan</th>
										<th width="7%">Feb</th>
										<th width="7%">Mar</th>
										<th width="7%">Apr</th>
										<th width="7%">May</th>
										<th width="7%">June</th>
										<th width="7%">Jul</th>
										<th width="7%">Aug</th>
										<th width="7%">Sep</th>
										<th width="7%">Oct</th>
										<th width="7%">Nov</th>
										<th width="7%">Dec</th>
										<th width="7%">SubTotal</th>
									</tr>
									</thead>
									<tbody>
									[#list stastic.listMonth as acc]
										<tr>
											<td align="left">
												<a href="[@spring.url '/admin/invoiceAndCredit/detailAccount.jhtml?deptId=${stastic.deptId}&toDeptId=${acc.billToDeptId}&year=${acc.year}&menuId=507'/]" style="color:#3A5FCD" onclick="showDetails('${stastic.deptId}','${acc.billToDeptId}');">${acc.billToReceiver}</a>
											</td>
											<td align="right">${acc.beginningValue}&nbsp;</td>
											<td align="right">${acc.jan}&nbsp;</td>
											<td align="right">${acc.feb}&nbsp;</td>
											<td align="right">${acc.mar}&nbsp;</td>
											<td align="right">${acc.apr}&nbsp;</td>
											<td align="right">${acc.may}&nbsp;</td>
											<td align="right">${acc.june}&nbsp;</td>
											<td align="right">${acc.july}&nbsp;</td>
											<td align="right">${acc.aug}&nbsp;</td>
											<td align="right">${acc.sept}&nbsp;</td>
											<td align="right">${acc.oct}&nbsp;</td>
											<td align="right">${acc.nov}&nbsp;</td>
											<td align="right">${acc.dec}&nbsp;</td>
											<td align="right">${acc.subtotal}&nbsp;</td>
										</tr>		
									[/#list]
									<tr>
										<td align="left">GrandTotal($):</td>
										<td align="right">${stastic.beginningValueSub}&nbsp;</td>
										<td align="right">${stastic.janSub}&nbsp;</td>
										<td align="right">${stastic.febSub}&nbsp;</td>
										<td align="right">${stastic.marSub}&nbsp;</td>
										<td align="right">${stastic.aprSub}&nbsp;</td>
										<td align="right">${stastic.maySub}&nbsp;</td>
										<td align="right">${stastic.juneSub}&nbsp;</td>
										<td align="right">${stastic.julySub}&nbsp;</td>
										<td align="right">${stastic.augSub}&nbsp;</td>
										<td align="right">${stastic.septSub}&nbsp;</td>
										<td align="right">${stastic.octSub}&nbsp;</td>
										<td align="right">${stastic.novSub}&nbsp;</td>
										<td align="right">${stastic.decSub}&nbsp;</td>
										<td align="right">${stastic.grandTotal}&nbsp;</td>
									</tr>
									</tbody>
									</table>
								</div>
							[/#list]
							</div>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
    </div>
<form action="jxlExcelForIcm.jhtml" id="exportCondition" method="post">
    <input id="deptIdForExport" type="hidden" name="deptId" value="${dept.deptId}"/>
</form>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        $("#exportButton").on('click',function(){
        	$("#exportCondition").submit();
        });
         $("#datatable2").attr("width","100%");
        var date = new Date();
    	now = date.getFullYear();
    	$(".select2-chosen").html(now);
    	
    });
    
    function yearsChange(){
	    	var year = $("#yearChange").val();
	    	var deptId = "${dept.deptId}";
	    	$.ajax({
				type:"GET",
				url:"${base}/admin/invoiceAndCredit/accountRecordMgtByYear?year="+year,
				dataType:"json",
				success:function(map) {
					$("#tbodyContent").html("");
					var str = "";
				$.each( map.listStasticAccount,function(index,accountRecord){
					str += '<table id="datatables" class="ompTable" width="100%" cellspacing="0">'+
				        '<thead>'+
					         '<tr>'+
								'<th width="5%">Office</th>'+
								'<th width="7%">Beg</th>'+
								'<th width="7%">Jan</th>'+
								'<th width="7%">Feb</th>'+
								'<th width="7%">Mar</th>'+
								'<th width="7%">Apr</th>'+
								'<th width="7%">May</th>'+
								'<th width="7%">June</th>'+
								'<th width="7%">Jul</th>'+
								'<th width="7%">Aug</th>'+
								'<th width="7%">Sept</th>'+
								'<th width="7%">Oct</th>'+
								'<th width="7%">Nov</th>'+
								'<th width="7%">Dec</th>'+
								'<th width="7%">SubTotal</th>'+
							'</tr>'+
				        '</thead>'+
		        		'<tbody>';
		        		$.each( accountRecord['listMonth'],function(index,MonthAccountRecord){	
							str+='<tr>'+
							'<td align="left">'+
							"<a href="+
							"${base}/admin/invoiceAndCredit/detailAccount.jhtml?deptId="+accountRecord['deptId']+
							'&year='+MonthAccountRecord['year']+
							'&toDeptId='+MonthAccountRecord['billToDeptId']+'>'+
							MonthAccountRecord['billToReceiver']+'</a>'+
							'</td>'+
							'<td align="right">'+MonthAccountRecord['beginningValue']+'</td>'+
							'<td align="right">'+MonthAccountRecord['jan']+'</td>'+
							'<td align="right">'+MonthAccountRecord['feb']+'</td>'+
							'<td align="right">'+MonthAccountRecord['mar']+'</td>'+
							'<td align="right">'+MonthAccountRecord['apr']+'</td>'+
							'<td align="right">'+MonthAccountRecord['may']+'</td>'+
							'<td align="right">'+MonthAccountRecord['june']+'</td>'+
							'<td align="right">'+MonthAccountRecord['july']+'</td>'+
							'<td align="right">'+MonthAccountRecord['aug']+'</td>'+
							'<td align="right">'+MonthAccountRecord['sept']+'</td>'+
							'<td align="right">'+MonthAccountRecord['oct']+'</td>'+
							'<td align="right">'+MonthAccountRecord['nov']+'</td>'+
							'<td align="right">'+MonthAccountRecord['dec']+'</td>'+
							'<td align="right">'+MonthAccountRecord['subtotal']+'</td>'+
						'</tr>';
						});
						str+='<tr>'+
							'<td align="left">GrandTotal($):</td>'+
							'<td align="right">'+accountRecord['beginningValueSub']+'</td>'+
							'<td align="right">'+accountRecord['janSub']+'</td>'+
							'<td align="right">'+accountRecord['febSub']+'</td>'+
							'<td align="right">'+accountRecord['marSub']+'</td>'+
							'<td align="right">'+accountRecord['aprSub']+'</td>'+
							'<td align="right">'+accountRecord['maySub']+'</td>'+
							'<td align="right">'+accountRecord['juneSub']+'</td>'+
							'<td align="right">'+accountRecord['julySub']+'</td>'+
							'<td align="right">'+accountRecord['augSub']+'</td>'+
							'<td align="right">'+accountRecord['septSub']+'</td>'+
							'<td align="right">'+accountRecord['octSub']+'</td>'+
							'<td align="right">'+accountRecord['novSub']+'</td>'+
							'<td align="right">'+accountRecord['decSub']+'</td>'+
							'<td align="right">'+accountRecord['grandTotal']+'</td>'+
						'</tr>';
						str+='</tbody>'+
						'</table>';
						});
						$("#tbodyContent").append(str);
						$.each($("td"),function(){
							if($(this).html()=="null"){
								$(this).html("");
							}
						});
						
				        var year = $("#yearChange").find("option:selected").val();
				        $("#currentYear").val(year);
				       	$("#yearForCondition").val(year);
				        $("#datatable2").attr("width","100%");
				        //默认有一个值被选中
   						 $("#tbodyContent").children("#"+$("#deptId").find("option:selected").val()).css({"display":"block"});
    					 $("#deptIdForExport").val($("#deptId").find("option:selected").val());
				},
			});  
    	}; 
    	
    	//打印
     $("#printButton").on("click",function(){
    	deptId = $("#deptId").val();
    	year = $("#yearChange").val();
    	$("#deptIdForExport").attr("value",deptId);
    	$("#yearForExport").attr("value",year);
    	$("#exportCondition").attr("action","printGlobalAccountRecordMgt.jhtml");
    	$("#exportCondition").submit();
    });
       
</script>
</body>
</html>
