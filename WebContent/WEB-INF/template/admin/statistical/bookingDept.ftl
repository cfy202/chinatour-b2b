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
            <h3>Booking Statistics</h3>
            <div class="new">
	        	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	        </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Statistics</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
			 <div class="block-flat">
						<div class="tab-container">
						<div class="tab-content">
						<input type="hidden" value="${role}" id="role"/>
							<input type="hidden" value="${menuId}" id="menuId"/>
							<input type="hidden" value="${statistical.orderType}" id="orderType"/>
							<input type="hidden" value="${statistical.userId}" id="userId"/>
							<label>
				            	<select  class="select2" id="year" onChange="sear();" style="height:32px">
									[#list constant.BRAND_YEAR as val]
										<option value="${val}"[#if "${statistical.time==val}"]selected="selected"[/#if]>${val}</option>
									[/#list]
								</select>
							</label>
							<label>
								<select style="height:32px" id="isSelfOrganize" class="select2" onchange="sear()">
									<option value="">Select Type</option>
									<option value="0" [#if "${statistical.isSelfOrganize=0}"]selected="selected"[/#if]>Outbound</option>
									<option value="1" [#if "${statistical.isSelfOrganize=1}"]selected="selected"[/#if]>Inbound</option>
									<option value="5" [#if "${statistical.orderType=5}"]selected="selected"[/#if]>Other Booking</option>
								</select>
							</label>
							<input type="hidden" value="${statisticalList?size}" id="valSize"/>
							<div id="tbodyContent" style="margin-top:30px;">
								<div id="" class="content">
									<table id="dataTable2" class="ompTable">
										<thead>
											<tr style="background-color:#F1F1F1">
												<th width="5%" style="font-weight:bold">Office</th>
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
												<th width="7%" style="font-weight:bold">SubTotal</th>
												<th width="7%" style="font-weight:bold">Percentage</th>
											</tr>
										</thead>
										<tbody class="no-border">
											[#list statisticalList as acc]
											<tr>
												<td>${acc.deptName}</td>
												<td id="jan"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-01')">${acc.jan}</a></td>
												<td id="feb"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-02')">${acc.feb}</td>
												<td id="mar"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-03')">${acc.mar}</td>
												<td id="apr"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-04')">${acc.apr}</td>
												<td id="may"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-05')">${acc.may}</td>
												<td id="jun"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-06')">${acc.jun}</td>
												<td id="jul"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-07')">${acc.jul}</td>
												<td id="aug"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-08')">${acc.aug}</td>
												<td id="sep"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-09')">${acc.sep}</td>
												<td id="oct"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-10')">${acc.oct}</td>
												<td id="nov"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-11')">${acc.nov}</td>
												<td id="dec"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}-12')">${acc.dec}</td>
												<td id="total"><a href="javascript:;" onclick="viewInfor('${acc.deptId}','${statistical.time}')">${acc.total}</td>
												<td id="talP${acc_index}"></td>
												<input id="tal${acc_index}" type="hidden" value="${acc.total}"/>
											</tr>	
											[/#list]	
											<tr>
												<td style="font-weight:bold">GrandTotal</td>
												<td id="one" style="font-weight:bold"></td>
												<td id="two" style="font-weight:bold"></td>
												<td id="thr" style="font-weight:bold"></td>
												<td id="fou" style="font-weight:bold"></td>
												<td id="fiv" style="font-weight:bold"></td>
												<td id="six" style="font-weight:bold"></td>
												<td id="sev" style="font-weight:bold"></td>
												<td id="eig" style="font-weight:bold"></td>
												<td id="nin" style="font-weight:bold"></td>
												<td id="ten" style="font-weight:bold"></td>
												<td id="eve" style="font-weight:bold"></td>
												<td id="tew" style="font-weight:bold"></td>
												<td id="sub" style="font-weight:bold"></td>
												<td style="font-weight:bold">100%</td>
											</tr>	
										</tbody>
									</table>
								</div>
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
        //统计纵向总数
		var one=0,two=0,thr=0,fou=0,fiv=0,six=0,sev=0,eig=0,nin=0,ten=0,eve=0,tew=0,sub=0;        
        $("td[id^='jan']").each(function(i){
        	one += parseFloat($(this).text());
        })
        $("td[id^='feb']").each(function(i){
        	two += parseFloat($(this).text());
        })
        $("td[id^='mar']").each(function(i){
        	thr += parseFloat($(this).text());
        })
        $("td[id^='apr']").each(function(i){
        	fou += parseFloat($(this).text());
        })
        $("td[id^='may']").each(function(i){
        	fiv += parseFloat($(this).text());
        })
        $("td[id^='jun']").each(function(i){
        	six += parseFloat($(this).text());
        })
        $("td[id^='jul']").each(function(i){
        	sev += parseFloat($(this).text());
        })
        $("td[id^='aug']").each(function(i){
        	eig += parseFloat($(this).text());
        })
        $("td[id^='sep']").each(function(i){
        	nin += parseFloat($(this).text());
        })
        $("td[id^='oct']").each(function(i){
        	ten += parseFloat($(this).text());
        })
        $("td[id^='nov']").each(function(i){
        	eve += parseFloat($(this).text());
        })
        $("td[id^='dec']").each(function(i){
        	tew += parseFloat($(this).text());
        })
        $("td[id^='total']").each(function(i){
        	sub += parseFloat($(this).text());
        })
        $("#one").html(one); $("#two").html(two);$("#thr").html(thr);$("#fou").html(fou);$("#fiv").html(fiv);$("#six").html(six);
        $("#sev").html(sev);$("#eig").html(eig); $("#nin").html(nin);$("#ten").html(ten);$("#eve").html(eve);$("#tew").html(tew);
        $("#sub").html(sub);
         for(var a=0;a<$("#valSize").val();a++){
        	var vals=changeTwoDecimal(parseFloat($("#tal"+a).val())/sub*100);
        	$("#talP"+a).text(vals+"%");
        }
    });
     function sear() {
			var role=$("#role").val();
			var menuId=$("#menuId").val();
        	var year=$("#year").val();
        	var isSelfOrganize=$("#isSelfOrganize").val();
    		location.href="${base}/admin/statistical/bookingForDept.jhtml?role="+role+"&menuId="+menuId+"&time="+year+"&isSelfOrganize="+isSelfOrganize;
		}
		 //查看详情
		function viewInfor(a,b){
			var role=$("#role").val();
        	var menuId=$("#menuId").val();
        	var isSelfOrganize=$("#isSelfOrganize").val();
        	var orderType=$("#orderType").val();
        	var userId=$("#userId").val();
        	if(b.indexOf('-')<0){
    			location.href="${base}/admin/statistical/orderDetailsPage.jhtml?role="+role+"&menuId="+menuId+"&year="+b+"&deptId="+a+"&isSelfOrganize="+isSelfOrganize+"&ticketType=booking&orderType="+orderType+"&userId="+userId;
    		}else{
    			location.href="${base}/admin/statistical/orderDetailsPage.jhtml?role="+role+"&menuId="+menuId+"&time="+b+"&deptId="+a+"&isSelfOrganize="+isSelfOrganize+"&ticketType=booking&orderType="+orderType+"&userId="+userId;
    		}
		}
	//获取两位小数点
	function changeTwoDecimal(x){
			var f_x = parseFloat(x);
			if (isNaN(f_x))
			{
				//alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x*100)/100;
		
			return f_x;
		}
</script>
</html>
