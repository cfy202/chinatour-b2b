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
            <h3>Booking Clients</h3>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">statistical</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
			 <div class="block-flat">
						<div class="tab-container">
						<div class="tab-content">
							<div style="height:30px; width:100%">
								<label> Year:</label>
								<label>
					            	<select id="yearChange" class="select2"  name="time" onchange="yearsChange();" style="height:32px;margin-left:20px;" >
								       [#list constant.BRAND_YEAR as val]
											<option value="${val}">${val}</option>
										[/#list]
									 </select>
									 <input id="year" type="hidden" value="${date}"/>
									 <input id="role" type="hidden" value="${role}"/>
									 <input id="type" type="hidden" value="${type}"/>
									 <input id="menuId" type="hidden" value="${menuId}"/>
								</label>
								<label>
					            	<select  class="select" id="isSelfOrganize" onChange="yearsChange()" style="height:32px;margin-left:20px;" >
										<option value="">Select Type</option>
										<option value="1" [#if "${statistical.isSelfOrganize=1}"]selected="selected"[/#if]>OutBound</option>
										<option value="2" [#if "${statistical.isSelfOrganize=2}"]selected="selected"[/#if]>Inbound</option>
									</select>
								</label>
							</div>
							<div id="tbodyContent" style="margin-top:30px;">
							[#list statisticalList as acc]
								<div id="" class="content">
									<table id="dataTable2" class="ompTable">
										<thead>
											<tr style="background-color:#F1F1F1">
												<th width="5%" style="font-weight:bold">Time</th>
												<th width="7%" style="font-weight:bold">Jan</th>
												<th width="7%" style="font-weight:bold">Feb</th>
												<th width="7%" style="font-weight:bold">Mar</th>
												<th width="7%" style="font-weight:bold">Apr</th>
												<th width="7%" style="font-weight:bold">May</th>
												<th width="7%" style="font-weight:bold">June</th>
												<th width="7%" style="font-weight:bold">Jul</th>
												<th width="7%" style="font-weight:bold">Aug</th>
												<th width="7%" style="font-weight:bold">Sep</th>
												<th width="7%" style="font-weight:bold">Oct</th>
												<th width="7%" style="font-weight:bold">Nov</th>
												<th width="7%" style="font-weight:bold">Dec</th>
												<th width="7%" style="font-weight:bold">Subtotal</th>
											</tr>
										</thead>
										<tbody class="no-border">
											<tr>
												<td>${date}</td>
												<td >${acc.jan}&nbsp;</td>
												<td>${acc.feb}&nbsp;</td>
												<td>${acc.mar}&nbsp;</td>
												<td>${acc.apr}&nbsp;</td>
												<td>${acc.may}&nbsp;</td>
												<td>${acc.jun}&nbsp;</td>
												<td>${acc.jul}&nbsp;</td>
												<td>${acc.aug}&nbsp;</td>
												<td>${acc.sep}&nbsp;</td>
												<td>${acc.oct}&nbsp;</td>
												<td>${acc.nov}&nbsp;</td>
												<td>${acc.dec}&nbsp;</td>
												<td>${acc.total}&nbsp;</td>
											</tr>		
										<!--<tr>
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
										</tr>-->
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
<form action="jxlExcelForIcm.jhtml" id="exportCondition" method="post">
    <input id="deptIdForExport" type="hidden" name="deptId"/>
    <input id="yearForExport" type="hidden" name="year"/>
</form>
</div>
[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
       $("#datatable2").attr("width","100%");
        var date = new Date();
    	now = date.getFullYear();
    	$("#s2id_yearChange .select2-choice .select2-chosen").html(now);
    	var date=$("#year").val();
    	$("#yearChange").get(0).value = date;
    	$(".select2-chosen").text(date);
    });
   function yearsChange(){
   		var isSelfOrganize=$("#isSelfOrganize").val();
   		if($("#type").val()=="Arrival"){
   			location.href="${base}/admin/statistical/arrivalStatistical.jhtml?role="+$("#role").val()+"&time="+$("#yearChange").val()+"&menuId="+$("#menuId").val()+"&isSelfOrganize="+isSelfOrganize;
   		}else{
   			location.href="${base}/admin/statistical/bookingStatistical.jhtml?role="+$("#role").val()+"&time="+$("#yearChange").val()+"&menuId="+$("#menuId").val()+"&isSelfOrganize="+isSelfOrganize;
   		}
   }
</script>
</html>
