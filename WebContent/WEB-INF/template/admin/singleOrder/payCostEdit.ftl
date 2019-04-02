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
            <h2>Income/Cost</h2>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="#">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking</a></li>
                <li><a style="cursor:pointer;" href="list">Other Booking</a></li>
            </ol>
        </div>
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">	
          	<h3>Income/Cost</h3>						
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" action="updatePayCost.jhtml" method="post" parsley-validate novalidate>            
				<input type="hidden" name="orderId" value="${payCost.orderId}">
				<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
					<i class="fa fa-bar-chart-o"></i>
					<span>Income</span>
		        </h4>
				<table class="ompTable" align="center" width="100%">
					<thead>
						<tr align="center">
							<th style="text-align:center;width:14%;">Income Date</th>
							<th style="text-align:center;width:14%;">﻿Amount</th>
							<th style="text-align:center;width:14%;">Payment</th>
							<th style="text-align:center;width:14%;">Payment Method</th>
							<th style="text-align:center;width:14%;">Booking No.</th>
							<th style="text-align:center;width:25%;">Remark</th>
							<th style="text-align:center;width:5%;"><a style="cursor:pointer;" class="fa fa-plus" onclick="add(this,1);"></th>
						</tr>
					</thead>
					<tbody id="incomeTbody">
					[#if (payCost.payRecordsList?size>0)]
						[#list payCost.payRecordsList as payRecord]
						<tr class="1 modify">
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div id="payTime_${payRecord_index}" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
								    <input class="form-control" name="payRecordsList[].time" [#if (payRecord.time)??] value="${payRecord.time?string('yyyy-MM-dd')}"[/#if]readonly="readonly" type="text" size="20">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
								    </span>
								</div>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="payRecordsList[].sum" [#if (payRecord.sum)??]value="${payRecord.sum}"[#else]value="0"[/#if] class="form-control" size="15" type="text">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].item" class="select2">
							    [#list constant.PAYMENT_ITEMS as val]
									<option value="${val}" [#if payRecord.item == val]selected="selected"[/#if]>${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].way" class="select2">
								[#list constant.PAYMENT_WAYS as val]
									<option value="${val}" [#if payRecord.way == val]selected="selected"[/#if]>${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="payRecordsList[].code" value="${payRecord.code}" size="20" type="text">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="payRecordsList[].remark" value="${payRecord.remark}" size="20" type="text">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								[#if payRecord_index == 0]
								    <a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstPayCost(this,'${payRecord.id}',1);">
								[#else]
									<a style="cursor:pointer;" class="fa fa-minus" onclick="deletePayCost(this,'${payRecord.id}');">
								[/#if]
							</td>
							<input type="hidden" name="payRecordsList[].id" value="${payRecord.id}">
						</tr>
						[/#list]
					[#else]
						<tr class="1">
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
								    <input class="form-control" name="payRecordsList[].time" readonly="readonly" type="text" size="20">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
								    </span>
								</div>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="payRecordsList[].sum" value="0" class="form-control" size="15" type="text">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].item" class="select2">
							    [#list constant.PAYMENT_ITEMS as val]
									<option value="${val}">${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].way" class="select2">
								[#list constant.PAYMENT_WAYS as val]
									<option value="${val}">${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="payRecordsList[].code" size="20" type="text">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="payRecordsList[].remark" size="20" type="text">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							</td>
							<input type="hidden" name="payRecordsList[].payOrCost" value="1">
						</tr>
					[/#if]
					</tbody>
				</table>
				<br>
				<h4 style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
					<i class="fa fa-bar-chart-o"></i>
					<span>Cost</span>
		        </h4>
				<table class="ompTable" align="center" width="100%">
					<thead>
						<tr class="priInTaTr1">
							<th style="text-align:center;width:14%;">DUE DATE</th>
							<th style="text-align:center;width:14%;">Amount</th>
							<th style="text-align:center;width:14%;">Payment</th>
							<th style="text-align:center;width:14%;">Booking No.</th>
							<th style="text-align:center;width:18%;">Suppliers</th>
							<th style="text-align:center;width:21%;">Remark</th>
							<th style="text-align:center;width:5%;"><a style="cursor:pointer;" class="fa fa-plus" onclick="add(this,2);"></th>
						</tr>
					</thead>
					<tbody id="costTbody">
					[#if (payCost.costRecordsList?size>0)]
						[#list payCost.costRecordsList as costRecord]
						<tr class="2 modify">
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div  id="costTime_${costRecord_index}" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
					                <input class="form-control" name="costRecordsList[].time" [#if (costRecord.time)??]value="${costRecord.time?string('yyyy-MM-dd')}"[/#if]readonly="readonly" type="text" size="20">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
						       </div>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="costRecordsList[].sum" [#if (costRecord.sum)??]value="${costRecord.sum}"[#else]value="0"[/#if] class="form-control" type="text" size="15">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="costRecordsList[].item" class="select2">
							    [#list constant.COST_ITEMS as val]
									<option value="${val}" [#if costRecord.item == val]selected="selected"[/#if]>${val}</option>
								[/#list]	
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="costRecordsList[].code" value="${costRecord.code}" type="text" size="18">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select class="select2" name="costRecordsList[].venderId" onkeyup="" style="width:13" type="text">
									<option value="0">--Select--</option>
								[#list venderList as vender]	
									<option value="${vender.venderId}" [#if costRecord.venderId == vender.venderId]selected="selected"[/#if]>${vender.name}</option>
								[/#list]	
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="costRecordsList[].remark" value="${costRecord.remark}" type="text" size="18">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								[#if costRecord_index == 0]
								 	<a style="cursor:pointer;" class="fa fa-minus" onclick="deleteFirstPayCost(this,'${costRecord.id}',2);">
								[#else]
									<a style="cursor:pointer;" class="fa fa-minus" onclick="deletePayCost(this,'${costRecord.id}');">
								[/#if]
							</td>
							<input type="hidden" name="costRecordsList[].id" value="${costRecord.id}">
						</tr>
						[/#list]
					[#else]
						<tr class="2">
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
					                <input class="form-control" name="costRecordsList[].time" readonly="readonly" type="text" size="20">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
						       </div>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="costRecordsList[].sum" value="0" class="form-control" type="text" size="15">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="costRecordsList[].item" class="select2">
							    [#list constant.COST_ITEMS as val]
									<option value="${val}">${val}</option>
								[/#list]	
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="costRecordsList[].code" type="text" size="18">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select class="select2" name="costRecordsList[].venderId" onkeyup="" style="width:13" type="text">
									<option value="0">--Select--</option>
								[#list venderList as vender]	
									<option value="${vender.venderId}">${vender.name}</option>
								[/#list]	
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="costRecordsList[].remark" type="text" size="18">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							</td>
							<input type="hidden" name="costRecordsList[].payOrCost" value="2">
						</tr>
					[/#if]
					</tbody>
				</table>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10" align="right">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="button" id="formSubmit"  class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</div>
<table style="display:none">
	<tr id="payCostTemplate_1" class="1">
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<div class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
			    <input class="form-control" name="payRecordsList[].time" readonly="readonly" type="text" size="20">
				<span class="input-group-addon btn btn-primary">
				     <span class="glyphicon glyphicon-th"></span>
			    </span>
			</div>
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<input name="payRecordsList[].sum" value="0" class="form-control" size="15" type="text">
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<select name="payRecordsList[].item" class="select2">
		    [#list constant.PAYMENT_ITEMS as val]
				<option value="${val}">${val}</option>
			[/#list]
			</select>
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<select name="payRecordsList[].way" class="select2">
			[#list constant.PAYMENT_WAYS as val]
				<option value="${val}">${val}</option>
			[/#list]
			</select>
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
		    <input class="form-control" name="payRecordsList[].code" size="20" type="text">
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<input class="form-control" name="payRecordsList[].remark" size="20" type="text">
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
		    <a style="cursor:pointer;" class="fa fa-minus" onclick="removeTr(this);">
		</td>
		<input type="hidden" name="payRecordsList[].payOrCost" value="1">
	</tr>
	<tr id="payCostTemplate_2" class="2">
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<div class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2">
	            <input class="form-control" name="costRecordsList[].time" readonly="readonly" type="text" size="20">
				<span class="input-group-addon btn btn-primary">
				     <span class="glyphicon glyphicon-th"></span>
		        </span>
	       </div>
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<input name="costRecordsList[].sum" value="0" class="form-control" type="text" size="15">
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<select name="costRecordsList[].item" class="select2">
		    [#list constant.COST_ITEMS as val]
				<option value="${val}">${val}</option>
			[/#list]	
			</select>
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
		    <input class="form-control" name="costRecordsList[].code" type="text" size="18">
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<select class="select2" name="costRecordsList[].venderId" onkeyup="" style="width:13" type="text">
				<option value="0">--Select--</option>
			[#list venderList as vender]	
				<option value="${vender.venderId}">${vender.name}</option>
			[/#list]	
			</select>
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
			<input class="form-control" name="costRecordsList[].remark" type="text" size="18">
		</td>
		<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
		    <a style="cursor:pointer;" class="fa fa-minus" onclick="removeTr(this);">
		</td>
		<input type="hidden" name="costRecordsList[].payOrCost" value="2">
	</tr>
</table>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
  		$("form div.datetime").datetimepicker({autoclose: true});
  		$("form select.select2").select2({
        	width: '100%'
        });
    	$("#formSubmit").click(function(){
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
    		$("form").submit();
    	});
    });
    
    /* 增加收入或支出  */
    function add(addButton, classNo){
    	var $newHtml = $("#payCostTemplate_" + classNo).clone(true).removeAttr("id");
    	$newHtml.find("div.datetime").datetimepicker({autoclose: true});
    	$newHtml.find("select.select2").select2({
        	width: '100%'
        });
    	var $position = $(addButton).parent().parent().parent().next().find("." + classNo + ":last");
    	$position.after($newHtml);
    }
    
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
    function deletePayCost(button,id){
    	$.post("deletePayCost.jhtml",{"id":id},function(result){
    		if(result != 'OK'){
    			return;
    		}
    	});
      	$(button).parent().parent().remove();
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
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
