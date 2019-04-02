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
            <h3>Arrival Statistics</h3>
            <div class="new">
	        	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	        </div>
            <!--div class="pull-right option-left">
            	<div class="btn-group">
					  <ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" id="exportButton">Export</a></li>
						<li><a href="javascript:void(0)" id="printButton">Print</a></li>
					  </ul>
				</div>
				
            </div-->
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
								<input type="hidden" value="${order.time}${order.year}" id="time"/>
								<input type="hidden" value="${role}" id="role"/>
								<input type="hidden" value="${menuId}" id="menuId"/>
								<input type="hidden" value="2" id="orderType"/>
								<label>
					            	<select  class="select2" id="year" onChange="bookingPeerYear()">
										[#list constant.BRAND_YEAR as val]
											<option value="${val}"[#if "${year==val}"]selected="selected"[/#if]>${val}</option>
										[/#list]
									</select>
								</label>
								<label>
					            	<select  class="select2" id="deptId" onChange="sear()">
										<option value="">Select Office</option>
										[#list dept as dept]
											<option value="${dept.deptId}" [#if "${dept.deptId=order.deptId}"]selected="selected"[/#if]>${dept.deptName}</option>
										[/#list]
									</select>
								</label>
								<label>
					            	<select  class="select2" id="isSelfOrganize" onChange="sear()">
										<option value="">Select Type</option>
										<option value="5" [#if "${order.isSelfOrganize=5}"]selected="selected"[/#if]>Tour Booking</option>
										<option value="2" [#if "${order.isSelfOrganize=2}"]selected="selected"[/#if]>Other Booking</option>
									</select>
								</label>
								<label>
									<input type="text" id="userName" size="14" style="height:35px;vertical-align:sub;" onChange="sear()" value="${order.userName}" placeholder="Agent" />
								</label>
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
			                                    <th>Passenger Info</th>
			                                    <th>Total Amount</th>
			                                    <th>Total Profit</th>
			                                    <th>Agent</th>
			                                    <th>Passenger Info</th>
			                                    <th>Amount</th>
			                                    <th>Income</th>
			                                    <th>Cost</th>
			                                    <th>Profit</th>
			                                    <th>Percentage</th>
			                                </tr>
	                                    </thead>
	                                    [#list statisticalList as acc]
		                                    <tr  [#if acc_index%2==1]  style="background-color:#EFF8FE"[/#if] [#if acc_index%2==0]  style="background-color:#FFF"[/#if]>
		                                        <td rowspan="${acc.orderList.size()+1}" style="text-align:center;vertical-align:middle">${acc.deptName}</td>
		                                        <td rowspan="${acc.orderList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${acc_index}">${acc.sum}</td>
		                                        <td rowspan="${acc.orderList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${acc_index}">${acc.commonTourFee}</td>
		                                        <td rowspan="${acc.orderList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${acc_index}">${acc.profit}</td>
		                                        <input id="zlsum${acc_index}" value="${acc.orderList?size}" type="hidden"/>
		                                    </tr>
			                                  [#list acc.orderList as order]
			                                   	<tr [#if acc_index%2==1]  style="background-color:#EFF8FE"[/#if] [#if acc_index%2==0]  style="background-color:#FFF"[/#if]>
			                                        <td><a href="javascript:;" onclick="viewInfor('${order.userId}')">${order.userName}</a></td>
			                                        <td id="s${acc_index}_${order_index}">${order.totalPeople}</td>
			                                        <td>${order.commonTourFee}</td>
			                                        <td>${order.pay}</td>
			                                        <td>${order.cost}</td>
			                                        <td>${order.pay-order.cost}</td>
			                                        <td id="p${acc_index}_${order_index}"></td>
			                                    </tr>
		                                      [/#list]
	                                    [/#list]
                                    <tr class="tfoot">
	                                    <th style="text-align:center;vertical-align:middle">Total</th>
	                                    <th style="text-align:center;vertical-align:middle">${statistical.sum}</th>
	                                    <th style="text-align:center;vertical-align:middle">${statistical.commonTourFee}</th>
	                                    <th style="text-align:center;vertical-align:middle">${statistical.totalPay-statistical.totalCost}</th>
	                                    <th></th>
	                                    <th>${statistical.sum}</th>
	                                    <th>${statistical.commonTourFee}</th>
	                                    <th>${statistical.totalPay}</th>
	                                    <th>${statistical.totalCost}</th>
	                                    <th>${statistical.totalPay-statistical.totalCost}</th>
	                                    <th></th>
                          			  </tr>
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
        $("#userSelect").select2({
			placeholder:"Search Vender",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				//url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
				url:'${base}/admin/vender/listSelect.jhtml?type=2&role='+$("#role").val(),	//地址(type=2供应商，查找type!=2)
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term); 
                    return {  
                         name: term   //联动查询的字符  
                     }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.venderList.length;i++){
						var vender = dataStr.venderList[i];
						 dataA.push({id: vender.venderId, text: vender.name});
					}
					
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		   
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/vender/listSelect.jhtml?venderId='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		//alert(JSON.stringify(data));
				    		//alert(JSON.stringify(data.venderList[0].venderId));
				    		if(data.venderList[0]==undefined){
				    			callback({id:"",text:"Search Vender"});
				    		}else{
				    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) { return m; }
		});
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
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
    	var menuId=$("#menuId").val();
    	location.href="${base}/admin/statistical/peerBookStatistical.jhtml?role="+a+"&menuId="+menuId+"&time="+b;
    }
    function bookingPeerYear(){
		var role=$("#role").val();
    	var year=$("#year").val();
    	var time=$("#time").val();
    	var menuId=$("#menuId").val();
    	location.href="${base}/admin/statistical/peerBookStatistical.jhtml?role="+role+"&menuId="+menuId+"&year="+year;
    }
    function sear() {
			var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	var menuId=$("#menuId").val();
        	var deptId=$("#deptId").val();
        	var userName=$("#userName").val();
        	var isSelfOrganize=$("#isSelfOrganize").val();
        	if(time.indexOf('-')<0){
        		location.href="${base}/admin/statistical/peerBookStatistical.jhtml?role="+role+"&menuId="+menuId+"&year="+time+"&deptId="+deptId+"&userName="+userName+"&isSelfOrganize="+isSelfOrganize;
        	}else{
    			location.href="${base}/admin/statistical/peerBookStatistical.jhtml?role="+role+"&menuId="+menuId+"&time="+time+"&deptId="+deptId+"&userName="+userName+"&isSelfOrganize="+isSelfOrganize;
    			}
		}
		//查看详情
		function viewInfor(a){
			var role=$("#role").val();
        	var year=$("#year").val();
        	var time=$("#time").val();
        	var menuId=$("#menuId").val();
        	var deptId=$("#deptId").val();
        	var orderType=$("#orderType").val();
        	var isSelfOrganize=$("#isSelfOrganize").val();
        	if(time.indexOf('-')<0){
    			location.href="${base}/admin/statistical/orderDetailsPage.jhtml?role="+role+"&menuId="+menuId+"&year="+time+"&deptId="+deptId+"&userId="+a+"&orderType="+orderType+"&isSelfOrganize="+isSelfOrganize;
    		}else{
    			location.href="${base}/admin/statistical/orderDetailsPage.jhtml?role="+role+"&menuId="+menuId+"&time="+time+"&deptId="+deptId+"&userId="+a+"&orderType="+orderType+"&isSelfOrganize="+isSelfOrganize;
    		}
		}
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
