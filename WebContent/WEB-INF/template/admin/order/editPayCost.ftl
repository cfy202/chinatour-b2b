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
          	<h3>Book NO.	:${order.orderNo}</h3>						
          </div>
          <div class="content">
				[#if (payCostRecords.payOrCost==1)]
				<form class="form-horizontal group-border-dashed" action="updatePayCost.jhtml" method="post" id="form1" parsley-validate novalidate>            
				<input type="hidden" name="orderId" value="${payCostRecords.orderId}">
				<input type="hidden" name="totalId" value="${totalId}">
				<table class="ompTable" align="center" width="100%" id="pay">
					<thead>
						<tr align="center">
							<th style="text-align:center;width:14%;">Income Date</th>
							<th style="text-align:center;width:14%;">﻿Amount</th>
							<th style="text-align:center;width:14%;">Payment</th>
							<th style="text-align:center;width:14%;">Payment Method</th>
							<th style="text-align:center;width:14%;">Booking No.</th>
							<th style="text-align:center;width:25%;">Remark</th>
						</tr>
					</thead>
					<tbody id="incomeTbody">
						<tr class="1 modify">
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div id="payTime" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2" style="margin-bottom:0px;">
								    <input class="form-control" name="payRecordsList[].time" [#if (payCostRecords.time)??] value="${payCostRecords.time?string('yyyy-MM-dd')}"[/#if]readonly="readonly" type="text" size="20">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
								    </span>
								</div>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="payRecordsList[].sum" [#if (payCostRecords.sum)??]value="${payCostRecords.sum}"[#else]value="0"[/#if] class="form-control" size="15" type="text">
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].item" class="select2">
							    [#list constant.PAYMENT_ITEMS as val]
									<option value="${val}" [#if payCostRecords.item == val]selected="selected"[/#if]>${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="payRecordsList[].way" class="select2">
								[#list constant.PAYMENT_WAYS as val]
									<option value="${val}" [#if payCostRecords.way == val]selected="selected"[/#if]>${val}</option>
								[/#list]
								</select>
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="payRecordsList[].code" value="${payCostRecords.code}" size="20" type="text">
							</td>
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="payRecordsList[].remark" value="${payCostRecords.remark}" size="20" type="text">
							</td>
							<input type="hidden" name="payRecordsList[].id" value="${payCostRecords.id}">
					</tbody>
				</table>
				<div class="form-group" id="but">
                <div class="col-sm-offset-2 col-sm-10" align="center">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="button" id="formSubmit1"  class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              	</div>
            </form>
            [/#if]
            [#if (payCostRecords.payOrCost==2)]
            <form class="form-horizontal group-border-dashed" role="form" action="updatePayCost.jhtml" id="form2" method="post" parsley-validate>            
				<input type="hidden" name="orderId" value="${payCostRecords.orderId}">
				<input type="hidden" name="totalId" value="${totalId}">
				<table class="ompTable" align="center" width="100%" id="cost">
					<thead>
						<tr class="priInTaTr1">
							<th style="text:center;width:14%;">DUE DATE</th>
							<th style="text:center;width:14%;">Amount</th>
							<th style="text:center;width:14%;">Payment</th>
							<th style="text:center;width:14%;">Booking No.</th>
							<th style="text:center;width:18%;">Suppliers</th>
							<th style="text:center;width:21%;">Remark</th>
						</tr>
					</thead>
					<tbody id="costTbody">
						<tr class="2 modify">
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<div  id="costTime" class="input-group date datetime col_in" data-date-format="yyyy-mm-dd" data-min-view="2" style="margin-bottom:0px;">
					                <input class="form-control" name="costRecordsList[].time" [#if (payCostRecords.time)??]value="${payCostRecords.time?string('yyyy-MM-dd')}"[/#if]readonly="readonly" type="text" size="20">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
						       </div>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input name="costRecordsList[].sum" [#if (payCostRecords.sum)??]value="${payCostRecords.sum}"[#else]value="0"[/#if] class="form-control" type="text" size="15">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="costRecordsList[].item" class="select2">
							    [#list constant.COST_ITEMS as val]
									<option value="${val}" [#if payCostRecords.item == val]selected="selected"[/#if]>${val}</option>
								[/#list]	
								</select>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
							    <input class="form-control" name="costRecordsList[].code" value="${payCostRecords.code}" type="text" size="18">
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<!--
								<select class="select2" name="costRecordsList[].venderId" onkeyup="" style="width:13" type="text">
									<option value="0">--请选择--</option>
								[#list venderList as vender]	
									<option value="${vender.venderId}" [#if costRecord.venderId == vender.venderId]selected="selected"[/#if]>${vender.name}</option>
								[/#list]	
								</select>
								-->
								<input name="costRecordsList[].venderId" type="text" id="userSelect" style="width:13" value="${payCostRecords.venderId}" doName="4808" requred=""/>
							</td>
							<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<input class="form-control" name="costRecordsList[].remark" value="${payCostRecords.remark}" type="text" size="18">
							</td>
							<input type="hidden" name="costRecordsList[].id" value="${payCostRecords.id}">
						</tr>
					</tbody>
				</table>
				<div class="form-group" id="but">
                <div class="col-sm-offset-2 col-sm-10" align="center">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="button" id="formSubmit2"  class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              	</div>
            </form>
            [/#if]
      </div>
    </div>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
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
				url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
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
    function deletePayCost(button,id){
    alert(1);
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
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
