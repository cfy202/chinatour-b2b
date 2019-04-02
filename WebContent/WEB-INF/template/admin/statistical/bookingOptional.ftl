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
            <div class="pull-right option-left">
            	<div class="btn-group">
					  <ul class="dropdown-menu" role="menu">
						<!--li><a href="javascript:void(0)" id="exportButton">Export</a></li-->
						<li><a href="javascript:void(0)" id="printButton">Print</a></li>
					  </ul>
				</div>
				
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
						<input type="hidden" value="${optional.time}${optional.departureDate}" id="time"/>
						<!--<input type="hidden" value="${year}" id="year"/>-->
						<input type="hidden" value="${role}" id="role"/>
						<input type="hidden" value="${menuId}" id="menuId"/>
						<input type="hidden" value="${optional.userId}" id="userId"/>
						<label>
			            	<select  class="select2" id="year" onChange="bookingPeerYear()" style="height:32px">
								[#list constant.BRAND_YEAR as val]
									<option value="${val}"[#if "${year==val}"]selected="selected"[/#if]>${val}</option>
								[/#list]
							</select>
						</label>
						<label>
			            	<select  class="select2" id="brand" style="height:32px" onChange="sear()">
								<option value="">Select Brand</option>
								[#list constant.BRAND_ITEMS as val]
									<option value="${val}"[#if "${optional.brand==val}"]selected="selected"[/#if]>${val}</option>
								[/#list]
							</select>
						</label>
						<label>
			            	<select  class="select2" id="deptId" style="height:32px"  onChange="sear()">
								<option value="">Select Office</option>
								[#list dept as dept]
									<option value="${dept.deptId}" [#if "${dept.deptId=optional.deptId}"]selected="selected"[/#if]>${dept.deptName}</option>
								[/#list]
							</select>
						</label>
						<label>
			            	<select  class="select2" id="tripDesc" style="height:32px" onChange="sear()">
								<option value="">Select</option>
								<option value="retail"[#if "${optional.tripDesc=='retail'}"]selected="selected"[/#if]>retail</option>
								<option value="wholeSale"[#if "${optional.tripDesc=='wholeSale'}"]selected="selected"[/#if]>wholeSale</option>
							</select>
						</label>
						<label>
			            	<input type="text"  id="code" size="14" style="height:35px;vertical-align:sub;" onChange="sear()" value="${groupLine.tourCode}" placeholder="Product Code" />
						</label>
						<div class="tab-container" style="margin-top:50px;">
							<ul class="nav nav-tabs">
							  <li style="width:7%" id="01"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-01')" data-toggle="tab">Jan</a></li>
							  <li style="width:7%"id="02"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-02')" data-toggle="tab">Feb</a></li>
							  <li style="width:7%"id="03"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-03')" data-toggle="tab">Mar</a></li>
							  <li style="width:7%"id="04"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-04')" data-toggle="tab">Apr</a></li>
							  <li style="width:7%"id="05"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-05')" data-toggle="tab">May</a></li>
							  <li style="width:7%"id="06"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-06')" data-toggle="tab">Jun</a></li>
							  <li style="width:7%"id="07"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-07')" data-toggle="tab">Jul</a></li>
							  <li style="width:7%"id="08"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-08')" data-toggle="tab">Aug</a></li>
							  <li style="width:7%"id="09"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-09')" data-toggle="tab">Sep</a></li>
							  <li style="width:7%"id="10"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-10')" data-toggle="tab">Oct</a></li>
							  <li style="width:7%"id="11"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-11')" data-toggle="tab">Nov</a></li>
							  <li style="width:7%"id="12"><a href="javascript:;" onclick="bookingPeer('${role}','${year}-12')" data-toggle="tab">Dec</a></li>
							  <li style="width:7%"id="${year}"><a href="javascript:;" onclick="bookingPeerYear('${role}','${year}')" data-toggle="tab">Total</a></li>
							</ul>
                        </div>
                            <table class="table table-bordered" id="datatable2">
                                <thead>
                                <tr>
                                    <th>Office</th>
                                    <th>Passenger Info</th>
                                    <th>Total Amount</th>
                                    <th>Total Profit</th>
                                    <th>Optional Code</th>
                                    <th>Optional Name</th>
                                    <th>Passenger Info</th>
                                    <th>Amount</th>
                                    <th>Income</th>
                                    <th>Cost</th>
                                    <th>Profit</th>
                                    <th>Open Balance</th>
		                            <th>Percentage</th>
                                </tr>
                                [#list statisticalList as acc]
                                    <tr>
                                        <td rowspan="${acc.optionalExcuritions.size()+1}" style="text-align:center;vertical-align:middle">${acc.deptName}</td>
                                        <td rowspan="${acc.optionalExcuritions.size()+1}" style="text-align:center;vertical-align:middle" id="sumb">${acc.sum}</td>
                                        <td rowspan="${acc.optionalExcuritions.size()+1}" style="text-align:center;vertical-align:middle" id="sumb">${acc.commonTourFee}</td>
                                        <td rowspan="${acc.optionalExcuritions.size()+1}" style="text-align:center;vertical-align:middle" id="sumb">${acc.profit}</td>
                                        <input type="hidden" id="bsum" value="${acc.optionalExcuritions?size}" />
                                    </tr>
                                   [#list acc.optionalExcuritions as optional]
                                   	<tr>
                                        <td><a href="javascript:;" onclick="viewInfor('${optional.id}')">${optional.type}</a></td>
		                                <td><a href="javascript:;" onclick="viewInfor('${optional.id}')">${optional.name}</a></td>
                                        <td id="s_${optional_index}">${optional.sum}</td>
                                        <td>${optional.commonTourFee}</td>
                                        <td>${optional.pay}</td>
                                        <td>${optional.cost}</td>
                                        <td>${optional.pay-optional.cost}</td>
                                        <td>${optional.commonTourFee-optional.pay}</td>
		                                <td id="p_${optional_index}"></td>
                                    </tr>
                                   [/#list]
                                [/#list]
                                </thead>
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
        	var m=$("#sumb").html();
        	var bsum=$("#bsum").val();
    		for(var b=0;b<bsum;b++){
    			var z=$("#s_"+b).html();
    			var v=changeTwoDecimal(z/m*100);
    			$("#p_"+b).html(v+"%");
    		}
    });
    //月份方法跳转
    function bookingPeer(a,b){
        var menuId=$("#menuId").val();
    	location.href="${base}/admin/statistical/bookingForOptional.jhtml?role="+a+"&menuId="+menuId+"&time="+b;
    }
    //年方法跳转
    function bookingPeerYear(){
		var role=$("#role").val();
    	var year=$("#year").val();
    	var time=$("#time").val();
        var menuId=$("#menuId").val();
    	location.href="${base}/admin/statistical/bookingForOptional.jhtml?role="+role+"&menuId="+menuId+"&departureDate="+year;
    }
   function sear() {
			var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	var brand=$("#brand").val();
        	var deptId=$("#deptId").val();
       		var menuId=$("#menuId").val();
       		var tripDesc=$("#tripDesc").val();
       		var code=$("#code").val();
        	if(time.indexOf("-")<0){
        		location.href="${base}/admin/statistical/bookingForOptional.jhtml?role="+role+"&menuId="+menuId+"&departureDate="+time+"&brand="+brand+"&deptId="+deptId+"&tripDesc="+tripDesc+"&tourCode="+code;
        	}else{
        		location.href="${base}/admin/statistical/bookingForOptional.jhtml?role="+role+"&menuId="+menuId+"&time="+time+"&brand="+brand+"&deptId="+deptId+"&tripDesc="+tripDesc+"&tourCode="+code;
        	}
		}
	
		//查看详情
		function viewInfor(a){
			var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	var menuId=$("#menuId").val();
        	var deptId=$("#deptId").val()
        	var brand=$("#brand").val()
        	var wr=$("#tripDesc").val();
        	var userId=$("#userId").val();
        	if(time.indexOf('-')<0){
    			location.href="${base}/admin/statistical/orderDetailsOptional.jhtml?role="+role+"&menuId="+menuId+"&year="+time+"&deptId="+deptId+"&optionalId="+a+"&wr="+wr+"&brand="+brand+"&ticketType=booking&userId="+userId;
    		}else{
    			location.href="${base}/admin/statistical/orderDetailsOptional.jhtml?role="+role+"&menuId="+menuId+"&time="+time+"&deptId="+deptId+"&optionalId="+a+"&wr="+wr+"&brand="+brand+"&ticketType=booking&userId="+userId;
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
