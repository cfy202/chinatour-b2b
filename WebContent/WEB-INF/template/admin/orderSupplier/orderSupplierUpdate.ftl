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
			<div class="block-flat">
				<form action="update.jhtml" name="form1" id="form1" method="post"  onsubmit="return submitCheck();">
					<div class="header">
						<h3>${tour.tourCode}Supplier Bill Audit</h3>
						 <a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
                    </div>
					<div class="content">
						<div class="form-group">
							Operator：<input type="hidden" id="supplierName" name="supId" value="${supPriceInfoRel.supId}" style="width:15%;"/>
							Operator Fee：<input type="text" class="inputWidth80" name="supplierCost" value="${supPriceInfoRel.supplierCost}" id="hotelCost">
							Amount：<input type="text" class="inputWidth80" name="supplierPrice" value="${supPriceInfoRel.supplierPrice}" id="tourSumFee">
							Remark：<input type="text" class="inputWidth80" name="remark" value="${supPriceInfoRel.remark}" >
							<input name="tourCode" type="hidden" id="tourCode" value="${tour.tourCode}"/>
							<input name="tourId"  type="hidden" id="tourId"value="${tour.tourId}" />
							<input type="hidden"  name="supPriceInfoRelId" value="${supPriceInfoRel.supPriceInfoRelId}"/>
				            <input type="hidden"  name="supplierPriceId"  value="${supplierPrice.supplierPriceId}"/>
		        			<input name="supplierName" id="supplierShortNameId" type="hidden" value="${supPriceInfoRel.supplierName}"  />
						</div>
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
							[#list supplierList as supplier]
								<tr id="trCss_${supplier.state}_${supplier_index}"  class="tr_[#if supplier.isCalculate==0]1[/#if]">
									<td style="width:5%;">${supplier.orderNo}</td>
									<td class="text-center">${supplier.customerNo}</td>
									<td class="text-center">${supplier.lastName}</td>
									<td class="text-center">${supplier.firstName}</td>
									<!-- <td class="text-center">${supplier.middleName}</td> -->
									<td class="text-center">${supplier.agent}</td>
									<td  width="10%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].tourPrice" id="save_${supplier_index}" id="save_${supplier_index}" value="${supplier.tourPrice}" value="0" class="form-control"/>
				                    </td>
									<td  width="10%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].singlePrice" id="update_${supplier_index}_singlePrice"  value="${supplier.singlePrice}" class="form-control"/>
				                    </td>
				                    <td width="10%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].flyPrice" id="update_${supplier_index}_flyPrice"  value="${supplier.flyPrice}" class="form-control"/>
				                    </td>
				                    <td width="10%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].childrenPrice" id="update_${supplier_index}_childrenPrice"  value="${supplier.childrenPrice}" class="form-control"/>
				                    </td>
				                    <td width="7%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].preferentialPrice" id="update_${supplier_index}_preferentialPrice" value="${supplier.preferentialPrice}" class="form-control"/>
				                    </td>
				                    <td width="7%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].delayPrice" id="update_${supplier_index}_delayPrice" value="${supplier.delayPrice}" class="form-control"/>
				                    </td>
				                    <td width="7%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].specialPrice" id="update_${supplier_index}_specialPrice" value="${supplier.specialPrice}" class="form-control"/>
				                    </td>
				                     <td width="7%" align="center">
				                    	<input type="text" name="supplierPriceInfoList[${supplier_index}].bedPrice" id="update_${supplier_index}_bedPrice" value="${supplier.bedPrice}" class="form-control"/>
				                    </td>
									<td class="text-center">
										<div class="item">
											<div>
												<input type="checkbox" [#if supplier.isCalculate==1]checked="checked"[/#if] class="icheck" id="planning_update_${supplier_index}" name="${supplier_index}" />
											</div>
										</div>
										<input type="hidden" value="${(supplier.isCalculate)!1}" name="supplierPriceInfoList[${supplier_index}].isCalculate" id="planning_IsCalculate_${supplier_index}"/>
										<input type="hidden" value="${supplier.userId}" name="supplierPriceInfoList[${supplier_index}].userId" />
										<input type="hidden" value="${supplier.customerId}" name="supplierPriceInfoList[${supplier_index}].customerId" />
										<input type="hidden" value="0" name="supplierPriceInfoList[${supplier_index}].isDel" />
										<input type="hidden" value="${supplier.orderNo}" name="supplierPriceInfoList[${supplier_index}].orderNo" />
										<input type="hidden" value="${supplier.orderId}" name="supplierPriceInfoList[${supplier_index}].orderId" />
										<input type="hidden" value="${supplier.supplierPriceInfoId}" name="supplierPriceInfoList[${supplier_index}].supplierPriceInfoId" />
									</td>	
								</tr>
							[/#list]
							</tbody>
						</table>
					</div>
					<div class="spacer2 text-center">
						[#if (supplierPrice.allCheck==0&&supplierPrice.accCheck==0)||(supplierPrice.allCheck==2&&supplierPrice.accCheck==1)||(supplierPrice.allCheck==0&&supplierPrice.accCheck==2)||(supplierPrice.allCheck==2&&supplierPrice.accCheck==2)]
							<button type="submit" class="btn btn-primary btn-flat ">Update</button>
						[/#if]
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
