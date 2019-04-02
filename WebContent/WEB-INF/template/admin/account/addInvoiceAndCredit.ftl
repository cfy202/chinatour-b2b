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
            <h2>Checking Accounts</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
            </ol>
        </div>
    <div class="cl-mcont">    
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New-${businessNoMax}</h3>
          </div>
          <div class="content">
              <form class="form-horizontal" role="form" id="formId" action="save.jhtml" method="post" parsley-validate novalidate>
	              <input id="" type="hidden" name="currencyTypeId" value="${dept.currencyTypeId}"/>
				  <input id="" type="hidden" name="businessNo" value="${businessNoMax}"/>
              <table style="word-break:break-all;white-space:nowrap; ">
				 <tbody>
					<tr>
						<td width="13%">
							<span>Selected Bill Type：</span>
						</td>
						<td width="37%">
							<input class="icheck" id="ifBeginningValue" type="radio" name="ifBeginningValue" value="2" checked="" style="position: absolute; opacity: 0;">&nbsp;Beginning
							<input class="icheck" id="ifBeginningValue" type="radio" name="ifBeginningValue" value="3" checked="" style="position: absolute; opacity: 0;">&nbsp;Adjust &nbsp;&nbsp;&nbsp;&nbsp;
							<input class="icheck" id="ifBeginningValue" type="radio" name="ifBeginningValue" value="1" checked="" style="position: absolute; opacity: 0;">&nbsp;Add &nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						<td>
							<span>Record Type:</span>
						</td>
						<td>
							<select id="addRecordType" name="recType" onchange="selectRecordType();" class="select2">
								<option value="INVOICE">INVOICE</option>
								<option value="CREDIT MEMO">CREDIT MEMO</option>
							</select> 
							<input id="recordType" type="hidden" name="recordType" value="INVOICE"/>
						</td>
					</tr>
					<tr>
						<td width="">
							<span>BillTo:</span>
						</td>
						<td>
							<div style="display: block;width:201px;" class="input-group1">
								<select id="billToDeptId" class="select2" style="width:201px" required  name="billToDeptId" onchange="billToDeptChange();">
									<option value="">----Select----</option>
			                  		[#list otherDepts as otherDepts]
			                        	<option value="${otherDepts.deptId}">${otherDepts.deptName}</option>
			                    	[/#list]
			                  	</select>
							</div>
							<font size="3px" color="red">&nbsp;*</font>
						</td>
						<td width="">
							<span>Record Month:</span>
						</td>
						<td>
							<div style="display: block;width:201px;" class="input-group1">
								<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
									<input type="text" class="form-control" name="month" style="width:165px" required placeholder="YYYY-MM-DD">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
							    </div>
							</div>
							<font size="3px" color="red">&nbsp;*</font>
						</td>
					</tr>
					<tr>
						<td>
							<span>Email:</span>
						</td>
						<td>
							<input  type="email"  class="form-control" id="inputEmail" name="emailTo"  style="width:201px" parsley-trigger="change"  placeholder="Enter email" />
						</td>
						<td>
							<span>TourCode:</span>
						</td>
						<td>
							<input type="text"  id="tourCode" name="tourCode" class="form-control" style="width:201px"  parsley-maxlength="36" placeholder="Max 36 chars." />
							<input type="hidden"  id="tourCodeT" name="tourId" style="width:201px"/>			
						</td>
					</tr>
					<tr>
						<td>
							<span>Remarks:</span>
						</td>
						<td>
							<input type="text"  id="remarks" name="remarks" class="form-control" style="width:201px" parsley-maxlength="60" placeholder="Max 60 chars." />	
						</td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
					<div name="slide_customerIndex" id="slide_customerIndex">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber"Checking Details</span>
							<div class="pull-right">
				               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
				           </div>
				        </h4>
				        <div id="infotab">
							<table id="tab">
		                		<tr>
		                			<td width="20%" align="center">Remark</td>
		                			<td width="20%" align="center">Description</td>
		                			<td width="15%" align="center">Amount</td>
		                			<td width="15%" align="center">Exchange Amount</td>
		                			<td width="15%" align="center">USD</td> 
		                			<td width="" align="center">Action</td>
		                		</tr>
		                		<tr id="expenses0">
		                			<input type="hidden" id="sortNo0" value="0" name="listInvoiceAndCreditItems[0].sortNo"/>
		                			<td align="center"><input type="text"  id="tourCode" name="listInvoiceAndCreditItems[0].remarks" class="form-control" style="width:100px"/></td>
		                			<td align="center"><input type="text"  id="description" name="listInvoiceAndCreditItems[0].description" class="form-control" style="width:100px"/></td>
		                			<td align="center">
		                				<input type="text"  placeholder="Number"  value="0" id="amount0" class="amountValue" onkeyup="return ValidateNumber(this,value)" name="listInvoiceAndCreditItems[0].amount" onChange="amountBlur(0);" class="form-control" style="width:100px"/>
		                				<input type="hidden" id="amounts0" value="0"/>
		                			</td>
		                			<td align="center">
		                				<input type="text" id="afterAmounts0" class="afterAmountValue" value="0" readonly="readonly" class="form-control"  style="width:100px;"/>
		                				<input type="hidden" id="afterAmounts0" value="0"/>
		                			</td>
		                			<td align="center">
		                				<input type="text" id="dollarAmount0" class="dollarAmountValue" value="0" name="listInvoiceAndCreditItems[0].dollarAmount" readonly="readonly" class="form-control" style="width:100px;"/>
		                				<input type="hidden" id="dollarAmountc0" value="0"/>
		                			</td>
		                			<td align="center"><button type="button" onclick="removeTr(0)" class="btn btn-default">REMOVE</button></td>
		                		</tr>
		                		<tr id="lastTr"  style="border-top:#2BBCA0 solid 5px;">
		                			<td align="center" width="20%">
		                				ROE($)
		                				<input type="hidden" id="usRate" value="1"/>
		                				<input type="hidden"  id="rateOfCurrencyId" name="rateOfCurrencyId"/>
		                				<input type="hidden"  id="rateUp" value="1"/>
		                				<input type="hidden"  id="rateDown" value="1"/>
		                			</td>
		                			<td align="center" width="20%"><input type="text" id="changeRateInput" value="1" readonly="readonly" class="form-control" style="width:100px;"/></td>
		                			<td align="center" width="15%">
		                				<span id="allAmount" size="10px">0</span>
		                				<input type="hidden"  id="enterCurrency" name="enterCurrency" value="0"/>
		                			</td>
		                			<td align="center" width="15%"><span id="allAfterAmount" size="10px">0</span></td>
		                			<td align="center" width="15%">
		                				<span id="allDollarAmount" size="10px">0</span>
		                				<input type="hidden"  id="dollar" name="dollar" value="0"/>
		                			</td>
		                			<td align="center" width="">
		                				<button type="button" onclick="addTr()" class="btn btn-default" size="25">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </button>
		                				<input id="numb" type="hidden" value="0"/>
		                			</td>
		                		</tr>
		                	</table>
		                	</div>
					</div>
					
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="redirect(1);" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
   </div>
</div>

[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("#s2id_tourCodeT").hide();
    	$("#s2id_billToDeptId").attr("style","width:201px");
    	$("#s2id_addRecordType").attr("style","width:201px");
    	
    	
    });
    //对账部门选择同时选择汇率
    function billToDeptChange(){
	var billToReceiver=$("#billToDeptId").val();
	$("#billToReceiver").attr("value",billToReceiver);
	$("#billToTd").attr("value",billToReceiver);
	var toDeptId = $("#billToDeptId").val();
	$.ajax({
		type:"POST",
		url:"${base}/admin/invoiceAndCredit/getRate.jhtml?toDeptId="+toDeptId,
		dataType:"json",
		success:function(map) {
			$("#changeRateInput").attr("value",map.rateDown+"/"+map.rateUp);
			$("#rateUp").attr("value",map.rateDown);
			$("#rateDown").attr("value",map.rateUp);
			$("#usRate").attr("value",map.usRate);
			$("#rateOfCurrencyId").attr("value",map.rateOfCurrencyId);
					}
	});
}
	function selectRecordType(){
		var recordType=$("#addRecordType").val();
		$("#recordType").attr("value",recordType);
	}
	
	function selectTour(){
		//按用户输入查询团
    	$("#tourCodeT").select2({
			placeholder:"Search TourCode",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'[@spring.url '/admin/invoiceAndCredit/listSelect.jhtml'/]',	//地址
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
	                return {  
	                     tourCode: term   //联动查询的字符  
	                 }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.tourList.length;i++){
						var tour = dataStr.tourList[i];
						 dataA.push({id: tour.tourCode, text: tour.tourCode});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/invoiceAndCredit/listSelect.jhtml?id='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		if(data.tourList[0]==undefined){
				    			callback({id:"",text:"Search TourCode"});
				    		}else{
				    			callback({id:data.tourList[0].tourId,text:data.tourList[0].tourCode});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) {
				//$("#supplierShortNameId").val(m);
				return m; 
			}
		});
	    
	    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
		function formatAsText(item){
		     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>";
		     return itemFmt;
		}
    	
	}
	//更改金额，更改其他变动的值
	/*function amountBlur(numb){
		if($("#rateOfCurrencyId").val()==""){
		 //alert("Selected Accounting  Department");
		 $("#amount"+numb).attr("value",0);
		}else{
			if($("#amount"+numb).val()==""){
				removeTr(numb,"add");	
				return false;
			}
			removeTr(numb,"add");	
			var enterCurrency=$("#enterCurrency").val();
			var dollar=$("#dollar").val();
			var allAfterAmount=$("#allAfterAmount").text();
			
			var amount=$("#amount"+numb).val();
			if(amount==""){
				amount=0;
			}
			var rateUp=$("#rateUp").val();
			var rateDown=$("#rateDown").val();
			var usRate=$("#usRate").val();
			alert(enterCurrency);
			var afterAmount = changeTwoDecimal(parseFloat(amount)*parseFloat(rateDown)/parseFloat(rateUp));
			var dollarAmount= changeTwoDecimal(parseFloat(amount)/parseFloat(usRate));
			var allAmount=changeTwoDecimal(parseFloat(amount)+parseFloat(enterCurrency));
			var allDollarAmount=changeTwoDecimal(parseFloat(dollarAmount)+parseFloat(dollar));
			allAfterAmount=changeTwoDecimal(parseFloat(afterAmount)+parseFloat(allAfterAmount));
			
			
			$("#amounts"+numb).attr("value",amount);
			$("#dollarAmountc"+numb).attr("value",dollarAmount);
			$("#afterAmounts"+numb).attr("value",afterAmount);
			
			$("#dollarAmount"+numb).attr("value",dollarAmount);
			//$("#dollarAmounts"+numb).html(dollarAmount);
			//$("#afterAmount"+numb).html(afterAmount);
			$("#allAmount").html(allAmount);
			$("#allAfterAmount").html(allAfterAmount);
			$("#allDollarAmount").html(allDollarAmount);
			$("#enterCurrency").attr("value",allAmount);
			$("#dollar").attr("value",allDollarAmount);
		}
		
	}*/
	//当录入金额更改时
	function amountBlur(numb){
		if($("#rateOfCurrencyId").val()==""){
		 //alert("Selected Accounting  Department");
		 $("#amount"+numb).attr("value",0);
		}else{
			//获取当前改变的值,如果值为空则设为0
			var amount = $("#amount"+numb).val();
			if(amount ==""){
				amount = 0;
				$("#amount"+numb).attr("value",0);
			}
			//获取汇率
			var rateUp=$("#rateUp").val();
			var rateDown=$("#rateDown").val();
			var usRate=$("#usRate").val();
			var afterAmount = changeTwoDecimal(parseFloat(amount)*parseFloat(rateDown)/parseFloat(rateUp));
			var dollarAmount= changeTwoDecimal(parseFloat(amount)/parseFloat(usRate));
			$("#amounts"+numb).attr("value",amount);
			$("#dollarAmountc"+numb).attr("value",dollarAmount);
			$("#afterAmounts"+numb).attr("value",afterAmount);
			$("#dollarAmount"+numb).attr("value",dollarAmount);
			var allAmount=0;
			//获取amount总和
			$("input[class='amountValue']").each(function(){
				amount = $(this).val();
				if(amount==""){
					amount=0;
					$(this).html("0");
				}
				allAmount=changeTwoDecimal(parseFloat(allAmount)+parseFloat(amount));
			})
			$("#allAmount").html(allAmount);
			$("#enterCurrency").attr("value",allAmount);
			var allAfterAmount = 0;
			$("input[class='afterAmountValue']").each(function(){
				allAfterAmount=changeTwoDecimal(parseFloat(allAfterAmount)+parseFloat($(this).val()));
			});
			
			$("#allAfterAmount").html(allAfterAmount);
			
			var allDollarAmount = 0;
			$("input[class='dollarAmountValue']").each(function(){
				allDollarAmount=changeTwoDecimal(parseFloat(allDollarAmount)+parseFloat($(this).val()));
			});
			
			$("#allDollarAmount").html(allDollarAmount);
			$("#dollar").attr("value",allDollarAmount);
		}
	}
	
	//添加录入金额的tr
	function addTr(){
		var numb=parseFloat($("#numb").val())+1;
		$("#numb").attr("value",numb);
		 var data="<tr id='expenses"+numb+"'>"
		 			+"<input type='hidden'  value='"+numb+"' name='listInvoiceAndCreditItems["+numb+"].sortNo'/>"
			 		+"<td align='center'><input type='text'  id='remarks' name='listInvoiceAndCreditItems["+numb+"].remarks' class='form-control' style='width:100px;'/></td>"
			 		+"<td align='center'><input type='text'  id='description' name='listInvoiceAndCreditItems["+numb+"].description' class='form-control' style='width:100px;'/></td>"
			 		+"<td align='center'>"
			 			+"<input  type='text' placeholder='Number' id='amount"+numb+"' class='amountValue' name='listInvoiceAndCreditItems["+numb+"].amount' onChange='amountBlur("+numb+");' value='0' class='form-control' style='width:100px;'/>"
			 			+"<input type='hidden' id='amounts"+numb+"' value='0'/>"
			 		+"</td>"
			 		+"<td align='center'>"
			 			+"<input type='text' id='afterAmounts"+numb+"'  class='afterAmountValue' value='0' readonly='readonly' class='form-control' style='width:100px;'/>"
			 			+"<input type='hidden' id='afterAmounts"+numb+"' value='0'/>"
			 		+"</td>"
			 		+"<td align='center'>"
			 			+"<input type='text' id='dollarAmount"+numb+"'   class='dollarAmountValue' value='0' name='listInvoiceAndCreditItems["+numb+"].dollarAmount' readonly='readonly' class='form-control' style='width:100px;'/>"
			 			+"<input type='hidden' id='dollarAmountc"+numb+"' value='0'/>"
			 		+"</td>"
			 		+"<td align='center'><button type='button' onclick='removeTr("+numb+")' class='btn btn-default'>REMOVE</button></td>"
		 		  +"</tr>"
		 		$("#tab #lastTr").before(data);
		 		$("#tab td input[id^='amount']").each(function(i){
		 				$("#amount"+i).attr("onkeyup","return ValidateNumber(this,value)");
		 		})
	}
	//删除tr
	function removeTr(numb,add){
			var enterCurrency=$("#enterCurrency").val();
			var dollar=$("#dollar").val();
			var allAfterAmount=$("#allAfterAmount").text();
			var amount,dollarAmount,afterAmount,allAmount,allDollarAmount;
			if(add==null){//删除整行时的判断和计算
				if($("#tab tr[id^='expenses']").length==1){
		    		alert("手下留情，就剩一条数据了！");
		    		return false;
		    	}else{
					amount=$("#amount"+numb).val();
					if(amount==""){
						amount=0;
					}
					dollarAmount=$("#dollarAmount"+numb).val();
					afterAmount=$("#afterAmounts"+numb).val();
					allAmount=changeTwoDecimal(parseFloat(enterCurrency)-parseFloat(amount));
					allDollarAmount=changeTwoDecimal(parseFloat(dollar)-parseFloat(dollarAmount));
					allAfterAmount=changeTwoDecimal(parseFloat(allAfterAmount)-parseFloat(afterAmount));
				}
			}else{//更改数据时的判断和计算
				var amount=$("#amounts"+numb).val();
				var dollarAmount=$("#dollarAmountc"+numb).val();
				var afterAmount=$("#afterAmounts"+numb).val();
				if(amount>0){//有数据时执行
					allAmount=changeTwoDecimal(parseFloat(enterCurrency)-parseFloat(amount));
					allDollarAmount=changeTwoDecimal(parseFloat(dollar)-parseFloat(dollarAmount));
					allAfterAmount=changeTwoDecimal(parseFloat(allAfterAmount)-parseFloat(afterAmount));
					$("#dollarAmount"+numb).attr("value","0");
					$("#afterAmounts"+numb).attr("value","0");
					$("#amounts"+numb).attr("value","0");
				}
				
			}
			$("#allAmount").html(allAmount);
			$("#allAfterAmount").html(allAfterAmount);
			$("#allDollarAmount").html(allDollarAmount);
			$("#enterCurrency").attr("value",allAmount);
			$("#dollar").attr("value",allDollarAmount);
			if(add==null){
				$("#expenses"+numb).remove();
			}
	}
$('input.icheck').on('ifChecked', function(event){
	var z=$(this).val();
 	 if(z==3){
			$("#s2id_tourCodeT").show();
			$("#tourCode").hide();
			$("#s2id_tourCodeT").attr('style','width:201px');
			selectTour();
			$("#tourCode").attr("name"," ");
			$("#tourCodeT").attr("name","tourCode");
			$("#s2id_tourCodeT").attr('style','width:201px');
		}else{
			$("#tourCode").show();
			$("#s2id_tourCodeT").hide();
			$("#tourCodeT").attr("name"," ")
			$("#tourCode").attr("name","tourCode");
			if(z==2){
				$.ajax({
					type:"GET",
					url:"${base}/admin/invoiceAndCredit/queryDeptForBegVal.jhtml?deptId=${deptId}",
					dataType:"json",
					success:function(map) {
						$("#billToDeptId").html("");
						str='<option value="">----Select----</option>';
						$.each( map.deptList,function(index,dept){
							str+='<option value='+dept['deptId']+'>'+dept['deptName']+'</option>';
						});
						$("#billToDeptId").append(str);
						
					}
				});
			}
		}
});

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
	//明细显示和隐藏
	$("h4").click(function(){
	  $("#infotab").slideToggle();
	});
	
	function ValidateNumber(e, pnumber){
		if($("#rateOfCurrencyId").val()==""){
			$("#amount0").val(0);
		 alert("Selected Accounting  Department");
		 
		}
		return false;
	}
	
</script>
</body>
</html>
