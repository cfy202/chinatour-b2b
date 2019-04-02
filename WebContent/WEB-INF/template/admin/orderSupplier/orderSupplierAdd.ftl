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
		<h2>Billing</h2>
		<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Tour</a></li>
		</ol>
	</div>
	<div class="cl-mcont">
	<div class="row">
		<div class="col-md-12">
			<div class="block-flat">
				<form action="save.jhtml" name="form1" id="form1" method="post"  onsubmit="return submitCheck();">
					<div class="header">
						<h3>${tour.tourCode}Supplier Bill Audit</h3>
						 <a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
                    </div>
					<div class="form-group">
						Operator：<input type="hidden" id="supplierName" name="supId" style="width:15%;"/>
						Operator Fee：<input type="text" name="supplierCost" id="hotelCost">
						Amount：<input type="text" name="supplierPrice" id="tourSumFee">
						Remark：<input type="text" name="remark">
						<input name="tourCode" type="hidden" id="tourCode" value="${tour.tourCode}"/>
						<input name="tourId"  type="hidden" id="tourId"value="${tour.tourId}" />
						<input name="supplierName" id="supplierShortNameId" type="hidden" />
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
									<th class="text-center">Tour Charge</th>
									<th class="text-center">Single Supplement</th>
									<th class="text-center">Pick-up Service</th>
									<th class="text-center">Child Fare</th>
									<th class="text-center">Discount</th>
									<th class="text-center">Extended Staying</th>
									<th class="text-center">Special</th>
									<th class="text-center">Extra Bed</th>
									<th class="text-center">Count<input id="check-all" checked="checked" type="checkbox" name="checkall" /></th>
								</tr>
							</thead>
							<tbody class="">
							[#list customerList as customer]
								<tr id="trCss_${customer.state}_${customer_index}"  class="tr_${customer.isDel}">
									<td style="width:5%;">${customer.orderNo}</td>
									<td class="text-center">${customer.customerCode}</td>
									<td class="text-center">${customer.lastName}</td>
									<td class="text-center">${customer.firstName}</td>
									<!-- <td class="text-center">${hotel.middleName}</td> -->
									<td class="text-center">${customer.agent}</td>
									<td  width="10%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].tourPrice" id="save_${customer_index}"  value="0" />
				                    </td>
									<td  width="10%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].singlePrice" id="update_${customer_index}_singlePrice"  value="0"/>
				                    </td>
				                    <td width="10%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].flyPrice" id="update_${customer_index}_flyPrice"  value="0"/>
				                    </td>
				                    <td width="10%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].childrenPrice" id="update_${customer_index}_childrenPrice"  value="0"/>
				                    </td>
				                    <td width="7%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].preferentialPrice" id="update_${customer_index}_preferentialPrice" value="0"/>
				                    </td>
				                    <td width="7%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].delayPrice" id="update_${customer_index}_delayPrice" value="0"/>
				                    </td>
				                    <td width="7%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].specialPrice" id="update_${customer_index}_specialPrice" value="0"/>
				                    </td>
				                     <td width="7%" align="center">
				                    	<input type="name" class="form-control" name="supplierPriceInfoList[${customer_index}].bedPrice" id="update_${customer_index}_bedPrice" value="0"/>
				                    </td>
									<td class="text-center">
										<div class="item">
											<div>
												<input type="checkbox"[#if (customer.state==5)||(customer.state==6)||(customer.isDel==1)][#else] checked="checked"[/#if] class="icheck" id="planning_update_${customer_index}" name="${customer_index}" />
											</div>
										</div>
										<input type="hidden" value="[#if (customer.state!=5)||(customer.state!=6)]0[#else]1[/#if]" name="supplierPriceInfoList[${customer_index}].isCalculate" id="planning_IsCalculate_${customer_index}">
										<input type="hidden" value="${customer.userId}" name="supplierPriceInfoList[${customer_index}].userId">
										<input type="hidden" value="${customer.customerId}" name="supplierPriceInfoList[${customer_index}].customerId">
										<input type="hidden" value="[#if (customer.state!=5)||(customer.state!=6)]0[#else]1[/#if]" name="supplierPriceInfoList[${customer_index}].isDel">
										<input type="hidden" value="${customer.orderId}" name="supplierPriceInfoList[${customer_index}].orderId">
										<input type="hidden" value="${customer.customerCode}" name="supplierPriceInfoList[${customer_index}].customerNo" />
									</td>
									</tr>
							[/#list]
							</tbody>
						</table>
					</div>
					<div class="spacer2 text-center">
						<button type="submit" class="btn btn-primary btn-flat ">Submit</button>
						<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default">Cancel</button>
					</div>
				</form>
			</div>
			
		</div>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	$("#supplierName").select2({
			placeholder:"Search Supplier",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'[@spring.url '/admin/supplier/listSelect.jhtml'/]',	//地址
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
	                return {  
	                     supplierName: term   //联动查询的字符  
	                 }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.supplierList.length;i++){
						var supplier = dataStr.supplierList[i];
						 dataA.push({id: supplier.supplierId, text: supplier.supplierName});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/supplier/listSelect.jhtml?supplierId='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		if(data.supplierList[0]==undefined){
				    			callback({id:"",text:"Search Supplier"});
				    		}else{
				    			callback({id:data.supplierList[0].supplierId,text:data.supplierList[0].supplierName});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) {
				//保存地接社名称
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
