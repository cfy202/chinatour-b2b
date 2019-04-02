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
            <h3>Statistics</h3>
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
								<input type="hidden" value="${so.time}${so.year}" id="time"/>
								<input type="hidden" value="${role}" id="role"/>
								<input type="hidden" value="${so.agentId}" id="agentId"/>
								<label>
					            	<select  class="select2" id="year" onChange="bookingPeerYear()">
										[#list constant.BRAND_YEAR as val]
											<option value="${val}"[#if "${year==val}"]selected="selected"[/#if]>${val}</option>
										[/#list]
									</select>
								</label>
								<!--<label>
					            	<select  class="select2" id="deptId" onChange="sear()">
										<option value="">Select Office</option>
										[#list dept as dept]
											<option value="${dept.deptId}" [#if "${dept.deptId=so.deptId}"]selected="selected"[/#if]>${dept.deptName}</option>
										[/#list]
									</select>
								</label>
								-->
								<!--	<label>
									<input name="companyId" type="hidden" id="userSelect" style="width:100%" doName="4808" required="" onChange="sear()"/>
										<input name="company" type="hidden">
								</label>
								-->
								<input id="tlsum" value="${statisticalList?size}" type="hidden"/>
						<div class="tab-container">
							<ul class="nav nav-tabs">
							  <li style="width:7%" id="01"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-01')" data-toggle="tab">Jan</a></li>
							  <li style="width:7%" id="02"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-02')" data-toggle="tab">Feb</a></li>
							  <li style="width:7%" id="03"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-03')" data-toggle="tab">Mar</a></li>
							  <li style="width:7%" id="04"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-04')" data-toggle="tab">Apr</a></li>
							  <li style="width:7%" id="05"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-05')" data-toggle="tab">May</a></li>
							  <li style="width:7%" id="06"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-06')" data-toggle="tab">Jun</a></li>
							  <li style="width:7%" id="07"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-07')" data-toggle="tab">Jul</a></li>
							  <li style="width:7%" id="08"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-08')" data-toggle="tab">Aug</a></li>
							  <li style="width:7%" id="09"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-09')" data-toggle="tab">Sep</a></li>
							  <li style="width:7%" id="10"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-10')" data-toggle="tab">Oct</a></li>
							  <li style="width:7%" id="11"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-11')" data-toggle="tab">Nov</a></li>
							  <li style="width:7%" id="12"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-12')" data-toggle="tab">Dec</a></li>
							  <li style="width:7%" id="${year}"><a href="javascript:;" onclick="bookingPeerYear()" data-toggle="tab">Total</a></li>
							</ul>
                        </div>
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
	                                     <tr>
                                     	   <th>Office</th>
		                                    <th>Qty</th>
		                                    <th>Total Profit</th>
		                                    <th>Agency</th>
		                                    <th>Qty</th>
		                                    <th>ARC</th>
		                                    <th>Bill/Credit</th>
		                                    <th>Profit</th>
		                                    <th>Percentage</th>
		                                </tr>
	                                	 [#list statisticalList as st]
		                                    <tr [#if st_index%2==1] style="background-color:#fff"[/#if][#if st_index%2==0] style="background-color:#EFF8FE"[/#if]>
		                                        <td rowspan="${st.flightList.size()+1}" style="text-align:center;vertical-align:middle">${st.deptName}</td>
		                                        <td rowspan="${st.flightList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${st_index}">${st.sum}</td>
		                                        <td rowspan="${st.flightList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${st_index}">${st.profit}</td>
		                                        <input id="zlsum${st_index}" value="${st.flightList?size}" type="hidden"/>
		                                    </tr>
		                                   [#list st.flightList as flight]
		                                   	<tr>
		                                        <td><a href="javascript:;" onclick="viewInfor('${flight.venderId}','${flight.deptId}')">${flight.venderName}</a></td>
		                                        <td id="s${st_index}_${flight_index}">${flight.quantity}</td>
		                                        <td>${flight.tempValue06}</td>
		                                        <td>${flight.amount-flight.charge}</td>
		                                        <td>${flight.amount-flight.operatorFee}</td>
		                                        <td id="p${st_index}_${flight_index}"></td>
		                                    </tr>
		                                   [/#list]
		                                [/#list]
	                                    </thead>
	                                </table>
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
        	var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	if(time==year){
        		$("#"+time).addClass("active");//total选项卡选中
        		//其他未选中
        		for(var a=1;a<=9;a++){
        			$("#0"+a).removeClass("active");
        		}
        		for(var a=10;a<=12;a++){
        			$("#"+a).removeClass("active");
        		}
        	}else{
        	//月份判断选中选项
        	var mon=time.substr(5,7);
        		$("#"+year).removeClass("active");//total选项卡未选中
        		for(var a=1;a<=9;a++){
        			if(mon=="0"+a){
        				$("#0"+a).addClass("active");
        			}else{
        				$("#0"+a).removeClass("active");
        			}
        		}
        		for(var a=10;a<=12;a++){
        			if(mon==a){
        				$("#"+a).addClass("active");
        			}else{
        				$("#"+a).removeClass("active");
        			}
        		}
        		
        	}
        	//添加百分比
        	/*var zo=$("#tlsum").val();
        	var cl=0;
        	var m=0;
        	for(var a=0;a<zo;a++){
        		 cl=cl+parseInt($("#sumq"+a).html());
    		}
    		for(var a=0;a<zo;a++){
        		 q=$("#sumq"+a).html();
        		var p=changeTwoDecimal(q/cl*100);
    			$("#p"+a).html(p+"%");
    		}*/
    		  	//添加百分比
        	var zo=$("#tlsum").val();
        	for(var a=0;a<zo;a++){
        		var cl=$("#zlsum"+a).val();
        		var m=$("#sumb"+a).html();
        		for(var b=0;b<cl;b++){
        		var z=$("#s"+a+"_"+b).html();
        		var p=changeTwoDecimal(z/m*100);
        		$("#p"+a+"_"+b).html(p+"%");
        		}
        	}
    		
    });
    function bookingPeer(a,b){
    	location.href="${base}/admin/statistical/venderStatistical.jhtml?time="+b;
    }
    function bookingPeerYear(){
		var role=$("#role").val();
    	var year=$("#year").val();
    	var time=$("#time").val();
    	location.href="${base}/admin/statistical/venderStatistical.jhtml?year="+year;
    }
    function sear() {
			var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	var deptId=$("#deptId").val();
        	if(time.indexOf('-')<0){
        		location.href="${base}/admin/statistical/venderStatistical.jhtml?year="+time+"&deptId="+deptId;
        	}else{
    			location.href="${base}/admin/statistical/venderStatistical.jhtml?time="+time+"&deptId="+deptId;
    			}
		}
		
		//查看详情
		function viewInfor(a){
			var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	var vender=a;
        	if(time.indexOf('-')<0){
    			location.href="${base}/admin/statistical/ticketList.jhtml?year="+time+"&venderId="+vender;
    		}else{
    			location.href="${base}/admin/statistical/ticketList.jhtml?time="+time+"&venderId="+vender;
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
</body>
</html>
