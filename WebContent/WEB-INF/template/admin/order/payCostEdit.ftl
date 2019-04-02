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
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeId">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Are you confirmation?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalId" type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Booking Receivable</h2>
            <div class="new"><a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a></div>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="#">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking</a></li>
            </ol>
        </div>
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">	
          	<h3>Book NO.	:${order.orderNo} </h3>	
          	[#if order.tax==2 || order.tax==4]
          	[#else]
				<button id="addPay"  class="btn pull-right btn-success" title="ADD INCOME"><i class="fa fa-plus"></i></button>
				<button id="addCost" class="btn pull-right btn-warning" title="ADD　COST"><i class="fa fa-plus"></i></button>
			[/#if]
			
		</div>
          <div class="content">
				<form class="form-horizontal group-border-dashed" action="updatePayCost.jhtml" method="post" id="form1" parsley-validate novalidate>            
				<input type="hidden" name="orderId" value="${payCost.orderId}">
				<input type="hidden" name="totalId" value="${totalId}">
				<table class="ompTable" align="center" width="100%" id="pay">
					<thead>
						<tr align="center">
							<th style="text-align:center;width:14%;">Income Date</th>
							<th style="text-align:center;width:14%;">﻿Amount</th>
							<th style="text-align:center;width:14%;">Payment</th>
							<th style="text-align:center;width:14%;">Payment Method</th>
							<th style="text-align:center;width:14%;">Reference No.</th>
							<th style="text-align:center;width:25%;">Remark</th>
						</tr>
					</thead>
					<tbody id="incomeTbody">
						<tr class="1 modify">
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div id="payTime_${payRecord_index}" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2" style="margin-bottom:0px;">
								    <input class="form-control" name="payRecordsList[].time" type="text" size="20" readonly="readonly" placeholder="YYYY-MM-DD">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
								    </span>
								</div>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="payRecordsList[].sum" value="0" class="form-control" size="15" type="text">
								<input type="hidden" name="payRecordsList[].payOrCost" value="1">
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].item" class="select2">
							    [#list constant.PAYMENT_ITEMS as val]
									<option value="${val}" >${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].way" class="select2">
								[#list constant.PAYMENT_WAYS as val]
									<option value="${val}">${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="payRecordsList[].code" required size="20" type="text">
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="payRecordsList[].remark" size="20" type="text">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="form-group" id="but">
                <div class="col-sm-offset-2 col-sm-10" align="center">
                  <button type="button" id="addPayC" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="button" id="formSubmit1"  class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              	</div>
            </form>
            <form class="form-horizontal group-border-dashed" action="updatePayCost.jhtml" id="form2" method="post" parsley-validate novalidate>            
				<input type="hidden" name="orderId" value="${payCost.orderId}">
				<input type="hidden" name="totalId" value="${totalId}">
				<table class="ompTable" align="center" width="100%" id="cost">
					<thead>
						<tr class="priInTaTr1">
							<th style="text-align:center;width:14%;">DUE DATE</th>
							<th style="text-align:center;width:14%;">Amount</th>
							<th style="text-align:center;width:14%;">Payment</th>
							<th style="text-align:center;width:14%;">Payment Method</th>
							<th style="text-align:center;width:14%;">Reference No.</th>
							<th style="text-align:center;width:18%;">Suppliers</th>
							<th style="text-align:center;width:21%;">Remark</th>
						</tr>
					</thead>
					<tbody id="costTbody">
						<tr class="2 modify">
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div  id="costTime_${costRecord_index}" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2" style="margin-bottom:0px;">
					                <input class="form-control" name="costRecordsList[].time" type="text" size="20" readonly="readonly"  placeholder="YYYY-MM-DD">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
						       </div>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="costRecordsList[].sum" value="0" class="form-control" type="text" size="15">
								<input type="hidden" name="costRecordsList[].payOrCost" value="2">
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="costRecordsList[].item" class="select2">
							    [#list constant.COST_ITEMS as val]
									<option value="${val}">${val}</option>
								[/#list]	
								</select>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="costRecordsList[].way" class="select2">
								[#list constant.COST_WAYS as val]
									<option value="${val}">${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="costRecordsList[].code" required type="text" size="18" required="">
							    <!--<font size="3px" color="red">&nbsp;*</font>-->
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<!--
								<select class="select2" name="costRecordsList[].venderId" onkeyup="" style="width:13" type="text">
									<option value="0">--请选择--</option>
								[#list venderList as vender]	
									<option value="${vender.venderId}" [#if costRecord.venderId == vender.venderId]selected="selected"[/#if]>${vender.name}</option>
								[/#list]	
								</select>
								-->
								<input name="costRecordsList[].venderId" type="text" id="userSelect" style="width:13" value="${costRecord.venderId}" doName="4808" required=""/>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="costRecordsList[].remark" value="${costRecord.remark}" type="text" size="18">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="form-group" id="but">
                <div class="col-sm-offset-2 col-sm-10" align="center">
                  <button type="button" id="addCostC" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="button" id="formSubmit2"  class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              	</div>
            </form>
	            		<h4 style="background:#60C060;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
							<i class="fa fa-bar-chart-o"></i>
							<span>Income</span>
				        </h4>
						<table class="no-border">
							<thead class="no-border">
								<tr>
									<th style="width:10%;font-weight:bold;" >Income Date</th>
									<th style="font-weight:bold;">Amount</th>
									<th style="font-weight:bold;">Payment</th>
									<th style="font-weight:bold;">Payment Method</th>
									<th style="font-weight:bold;">Invoice No.</th>
									<th style="font-weight:bold;">Remark</th>
									<th style="font-weight:bold;">Action</th>
								</tr>
							</thead>
							<tbody class="no-border-x"  id="addContent">
								[#if (payCost.payRecordsList?size>0)]
									[#list payCost.payRecordsList as payRecord]
									<tr id="${payRecord.id}">
										<td>
											 [#if payRecord.time??]
											 	${payRecord.time?string('yyyy-MM-dd')}
									         [/#if]
										</td>
										<td>${payRecord.sum}</td>
										<td>${payRecord.item}</td>
										<td>${payRecord.way}</td>
										<td>${payRecord.code}</td>
										<td>${payRecord.remark}</td>
										<td>
											[#if (payRecord.status==0)||(payRecord.status==2)]
											<a class="label label-default"  href="${base}/admin/orders/editPayCostRecords.jhtml?id=${payRecord.id}&totalId=pay" title="Modify"><i class="fa fa-pencil"></i></a>
											<!--<a class="label label-danger" href="javascript:;" onclick="deletePayCost(this,'${costRecord.id}');" title="Delect"><i class="fa fa-times"></i></a>-->
											<a class="label label-danger" data-href="javascript:deletePayCost('${payRecord.id}');" data-toggle="modal" data-target="#confirm-delete" title="Delete"><i class="fa fa-times"></i></a>
											[#else]
											<a class="label label-default" title="Inoperable"><i class="fa fa-pencil"></i></a>
											<a class="label label-danger" title="Inoperable"><i class="fa fa-times"></i></a>
											[/#if]
										</td>
									</tr>
									[/#list]
								[/#if]
							</tbody>
						</table>
						<div style="margin-top:50px;">
						<h4 style="background:#E38800;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
							<i class="fa fa-bar-chart-o"></i>
							<span>Cost</span>
				        </h4>
						<table class="no-border" >
							<thead class="no-border">
								<tr>
									<th style="font-weight:bold;">DUE DATE</th>
									<th style="font-weight:bold;">Amount</th>
									<th style="font-weight:bold;">Payment</th>
									<th style="font-weight:bold;">Invoice No.</th>
									<th style="font-weight:bold;">Suppliers</th>
									<th style="font-weight:bold;">Remarks</th>
									<th style="font-weight:bold;">Action</th>
								</tr>
							</thead>
							<tbody class="no-border-x"  id="addContent">
							[#if (payCost.costRecordsList?size>0)]
								[#list payCost.costRecordsList as costRecord]
								<tr id="${costRecord.id}">
									<td>
										[#if costRecord.time??]
										 	${costRecord.time?string("yyyy-MM-dd")}
								         [/#if]
										
									</td>
									<td>${costRecord.sum}</td>
									<td>${costRecord.item}</td>
									<td>${costRecord.code}</td>
									<td>${costRecord.venderString}</td>
									<td>${costRecord.remark}</td>
									<td >
										[#if (costRecord.status==0)||(costRecord.status==2)]
										<a class="label label-default md-trigger" data-modal="customerEditForm" href="${base}/admin/orders/editPayCostRecords.jhtml?id=${costRecord.id}&totalId=pay" title="Modify"><i class="fa fa-pencil"></i></a>
										<!--<a class="label label-danger" href="javascript:;" onclick="deletePayCost(this,'${costRecord.id}');" title="Delect"><i class="fa fa-times"></i></a>-->
										<a class="label label-danger" data-href="javascript:deletePayCost('${costRecord.id}');" data-toggle="modal" data-target="#confirm-delete" title="Delete"><i class="fa fa-times"></i></a>
										[#else]
										<a class="label label-default" title="Inoperable"><i class="fa fa-pencil"></i></a>
										<a class="label label-danger" title="Inoperable"><i class="fa fa-times"></i></a>
										[/#if]
									</td>
								</tr>
								[/#list]
							[/#if]
							</tbody>
						</table>
					</div>
      	</div>
    </div>
    <div class="btn-Nright">
	    <button onclick="backToEdit();" data-wizard="#wizard1" class="btn btn-default wizard-previous">
			Back To Edit 			
		</button>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("#form1").hide();
    	$("#form2").hide();
    	 /**添加成本，收入**/
    	 $("#addPay").click(function(){
    	 	$("#form1").toggle();
    	 });
    	 $("#addCost").click(function(){
    	 	$("#form2").toggle();
    	 });
    	 $("#addPayC").click(function(){
    	 	$("#form1").toggle();
    	 });
    	 $("#addCostC").click(function(){
    	 	$("#form2").toggle();
    	 });
  		$("form div.datetime").datetimepicker({autoclose: true});
  		$("form select.select2").select2({
        	width: '100%'
        });
    	$("#formSubmit1").click(function(){
	    	$("#incomeTbody tr").each(function(index){
	    		$(this).find("input,select").each(function(){
	    			addIndexToInputs($(this),index);
	    		});
	    	});
	    	
	    	$("#costTbody tr").each(function(index){
	    		$(this).find("input,select").each(function(){
	    			addIndexToInputs($(this),index);
	    		});
	    	});
    		$("#form1").submit();
    	});
    	$("#formSubmit2").click(function(){
	    	$("#incomeTbody tr").each(function(index){
	    		$(this).find("input,select").each(function(){
	    			addIndexToInputs($(this),index);
	    		});
	    	});
	    	
	    	$("#costTbody tr").each(function(index){
	    		$(this).find("input,select").each(function(){
	    			addIndexToInputs($(this),index);
	    		});
	    	});
    		$("#form2").submit();
    	});
    	
    	$("#userSelect").select2({
			placeholder:"Search Vender",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				//url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
				url:'${base}/admin/vender/listSelect.jhtml?type=1',	//地址(type=1同行，查找type!=1)
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
    });
    
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
    
    /* 增加收入或支出
    function add(addButton, classNo){
    	var $newHtml = $("#payCostTemplate_" + classNo).clone(true).removeAttr("id");
    	$newHtml.find("div.datetime").datetimepicker({autoclose: true});
    	$newHtml.find("select.select2").select2({
        	width: '100%'
        });
    	var $position = $(addButton).parent().parent().parent().next().find("." + classNo + ":last");
    	$position.after($newHtml);
    }  */
    
    /* 根据ID删除收入支出 (第一条记录) */
    function deleteFirstPayCost(button,id,classNo){
		$.post("deletePayCost.jhtml",{"id":id},function(result){
    		if(result != 'OK'){
    			return;
    		}
    	}); 
        var $fee = $(button).parent().parent();
	    var $next = $fee.next();
	    
	    /* 如果其他费用和折扣的输入框数目大于1个  */
	    if($next.hasClass(classNo)){
	    	var $button = $next.find("button");
	    	
	    	/* 如果第一个输入框下面是需要修改的值  */
		    if($next.hasClass("modify")){
		    	var event = $button.attr("onclick").replace("deletePayCost","deleteFirstPayCost").replace(");",","+ classNo +");");
		    	$button.attr("onclick",event);
		    	$button.after('<button type="button" onclick="add(this,'+ classNo +');">+</button>');
		    }else{
				$button.attr("onclick","add(this,"+ classNo +");").html("+");	    
		    }
	    }else{
	    	var $newHtml = $("#payCostTemplate_" + classNo).clone(true).removeAttr("id");
	    	$newHtml.find("div.datetime").datetimepicker({autoclose: true});
	    	$newHtml.find("select.select2").select2({
	        	width: '100%'
	        });
	    	$newHtml.find("button").attr("onclick","add(this,"+ classNo +");").html("+");
	    	$fee.after($newHtml);
	    } 
	    $fee.remove();
    }
        
    /* 根据ID删除收入支出  */
    function deletePayCost(id){
    	$.post("deletePayCost.jhtml",{"id":id},function(result){
    		if(result != 'OK'){
    			return;
    		}
    	});
    	$("#closeId").trigger("click");
    	$("#"+id).remove();
      	//$(button).parent().parent().remove();
    }
    
    /* 删除收入费用输入框  */
    function removeTr(button){
    	$(button).parent().parent().remove();
    }
    
    /* 给list的name添加下标  */
    function addIndexToInputs($inputs,index){
		var name = $inputs.attr("name");
		if(name != undefined){
			var position = name.lastIndexOf("]");
			name = name.substring(0, position) + index + name.substring(position, name.length);
			$inputs.attr("name",name);
		}
    }
    
    /* 返回总订单编辑页面 */
    function backToEdit(){
    	window.location.href = "edit.jhtml?ordersTotalId=${order.ordersTotalId}";
    }
    
    $('#confirm-delete').on('show.bs.modal', function (e) {
		$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
	});
</script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
