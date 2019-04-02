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
		<h2>Billing(GROUP)</h2>
		<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Tour</a></li>
		</ol>
	</div>
	<div class="cl-mcont">
	<div class="row">
		<div class="col-md-12">
			<div class="block-flat">
				<form action="updateGroup.jhtml" name="form1" id="form1" method="post"  onsubmit="return submitCheck();">
					<div class="header">
						<h3>${tour.tourCode}Hotel Bill Audit</h3>
						 <a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
                    </div>
					<div class="form-group">
						Hotel：<input type="hidden" id="hotelName" name="supId" value="${supPriceInfoRel.supId}" style="width:15%;"/>
						Operator Fee：<input type="text" class="inputWidth80" name="supplierCost" value="${supPriceInfoRel.supplierCost}" id="hotelCost">
						Amount：<input type="text" class="inputWidth80" name="supplierPrice" value="${supPriceInfoRel.supplierPrice}" id="tourSumFee">
						Remark：<input type="text" class="inputWidth80" name="remark" value="${supPriceInfoRel.remark}" >
						<input name="tourCode" type="hidden" id="tourCode" value="${tour.tourCode}"/>
						<input name="tourId"  type="hidden" id="tourId"value="${tour.tourId}" />
						<input type="hidden"  name="supPriceInfoRelId" value="${supPriceInfoRel.supPriceInfoRelId}"/>
			            <input type="hidden"  name="supplierPriceId"  value="${supplierPrice.supplierPriceId}"/>
						<input name="supplierName" id="supplierShortNameId" type="hidden" value="${supPriceInfoRel.supplierName}" />
					</div>
					<div class="content">
						<table class="table table-bordered dataTable no-footer">
							<thead>
								<tr>
									<th>﻿Booking No.</th>
									<th class="text-center">No.</th>
									<th class="text-center">LastName</th>
									<th class="text-center">FirstName</th>
									<!-- <th class="text-center">MiddleName</th> -->
									<th class="text-center">Agent</th>
									<th class="text-center">Room Rate</th>
									<th class="text-center">Extra Bed</th>
									<th class="text-center">Without Bed</th>
									<th class="text-center">Extra Breakfast</th>
									<th class="text-center">Single Supplement</th>
									<th class="text-center">Count <input id="check-all" type="checkbox" name="checkall" /></th>
								</tr>
							</thead>
							<tbody class="">
							[#list hotelList as hotel]
								<tr id="trCss_${hotel.state}_${hotel_index}"  class="tr_[#if hotel.isCalculate==0]1[/#if]">
									<td style="width:5%;">${hotel.orderNo}</td>
									<td class="text-center">${hotel.customerNo}</td>
									<td class="text-center">${hotel.lastName}</td>
									<td class="text-center">${hotel.firstName}</td>
									<!-- <td class="text-center">${hotel.middleName}</td> -->
									<td class="text-center">${hotel.agent}</td>
									<td class="text-center">
										<input type="text" name="hotelPriceInfoList[${hotel_index}].roomPrice" id="save_${hotel_index}" value="${hotel.roomPrice}" class="form-control"/>
									</td>
									<td class="text-center">
				                    	<input type="text" name="hotelPriceInfoList[${hotel_index}].withBed" id="update_${hotel_index}_withBed_"  value="${hotel.withBed}" class="form-control"/>
				                    </td>
				                    <td class="text-center">
				                    	<input type="text" name="hotelPriceInfoList[${hotel_index}].withOutBed" id="update_${hotel_index}_withOutBed"  value="${hotel.withOutBed}" class="form-control"/>
				                    </td>
				                    <td class="text-center">
				                    	<input type="text" name="hotelPriceInfoList[${hotel_index}].withBreakFirstPrice" id="update_${hotel_index}_withBreakFirstPrice" value="${hotel.withBreakFirstPrice}" class="form-control"/>
				                    </td>
				                    <td class="text-center">
				                    	<input type="text" name="hotelPriceInfoList[${hotel_index}].singlePrice" id="update_${hotel_index}_singlePrice" value="${hotel.singlePrice}" class="form-control"/>
				                    </td>
									<td class="text-center">
										<div class="item">
											<div>
												<input type="checkbox" [#if hotel.isCalculate==1]checked="checked"[/#if] class="icheck" id="planning_update_${hotel_index}" name="${hotel_index}" />
											</div>
										</div>
										<input type="hidden" value="${(hotel.isCalculate)!1}" name="hotelPriceInfoList[${hotel_index}].isCalculate" id="planning_IsCalculate_${hotel_index}">
										<input type="hidden" value="${hotel.userId}" name="hotelPriceInfoList[${hotel_index}].userId" />
										<input type="hidden" value="${hotel.customerId}" name="hotelPriceInfoList[${hotel_index}].customerId" />
										<input type="hidden" value="0" name="hotelPriceInfoList[${hotel_index}].isDel" />
										<input type="hidden" value="${hotel.orderNo}" name="hotelPriceInfoList[${hotel_index}].orderNo" />
										<input type="hidden" value="${hotel.orderId}" name="hotelPriceInfoList[${hotel_index}].orderId" />
										<input type="hidden" value="${hotel.hotelPriceInfoId}" name="hotelPriceInfoList[${hotel_index}].hotelPriceInfoId" />
									</td>
								</tr>
							[/#list]
							</tbody>
						</table>
					</div>
					<div class="spacer2 text-center">
						[#if (supplierPrice.allCheck==0&&supplierPrice.accCheck==0)||(supplierPrice.allCheck==2&&supplierPrice.accCheck==1)]
							<button type="submit" class="btn btn-primary btn-flat ">Update</button>
						[/#if]
						<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default">Cancel</button>
					</div>
				</from>
			</div>
			
		</div>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
		$("#hotelName").select2({
			placeholder:"Search Hotel",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'[@spring.url '/admin/hotel/listSelect.jhtml'/]',	//地址
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
	                return {  
	                     hotelName: term   //联动查询的字符  
	                 }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.hotelList.length;i++){
						var hotel = dataStr.hotelList[i];
						 dataA.push({id: hotel.id, text: hotel.hotelName});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/hotel/listSelect.jhtml?id='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		if(data.hotelList[0]==undefined){
				    			callback({id:"",text:"Search Hotel"});
				    		}else{
				    			callback({id:data.hotelList[0].id,text:data.hotelList[0].hotelName});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) {
				//保存酒店名称
				$("#supplierShortNameId").val(m);
				return m; 
			}
		});
	    
	    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
		function formatAsText(item){
		     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>";
		     return itemFmt;
		}
	});
</script>
</body>
</html>
