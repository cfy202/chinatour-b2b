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
            <div class="new"><button type="button" id="printForDetail" onclick="location.href='add.jhtml'">&nbsp;&nbsp;Print &nbsp;&nbsp;</button></div>
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
            <h3>Edit-${invoiceAndCredit.businessNo}</h3>
          </div>
          <div class="content">
              <form class="form-horizontal" role="form" id="formId" action="update.jhtml" method="post">
              <input type="hidden" name="invoiceAndCreditId" value="${invoiceAndCredit.invoiceAndCreditId}"/>
              <input type="hidden" name="deptId" value="${invoiceAndCredit.deptId}"/>
              <input type="hidden" name="ifBeginningValue" value="${invoiceAndCredit.ifBeginningValue}"/>
              <input id="" type="hidden" name="businessNo" value="${invoiceAndCredit.businessNo}"/>
              <input id="billToReceiver" type="hidden" name="billToReceiver" value="${invoiceAndCredit.billToReceiver}">
              <table style="word-break:break-all;white-space:nowrap; " width="100%">
				 <tbody>
					<tr>
						<td width="13%">
							<span>BillTo:</span>
						</td>
						<td width="37%">
							<select id="deptId" class="select2" class="form-control" onChange="billToDeptChange();">
				                  	[#list listBillDept as listBillDept]
				              			<option value="${listBillDept.deptId}" [#if "${listBillDept.deptId==invoiceAndCredit.billToDeptId}"] selected="selected" [/#if]>${listBillDept.deptName}</option>
				                    [/#list]
				                    <input id="billToDeptId" type="hidden" name="billToDeptId" value="${listBillDept.deptId}">
							 </select>
						</td>
						<td width="13%">
							<span>Recored Type:</span>
						</td>
						<td width="37%">
							<select id="addRecordType" name="recordType" onchange="selectRecordType();" class="select2">
								<option value="INVOICE" [#if invoiceAndCredit.recordType=="INVOICE"]selected="selected"[/#if]>INVOICE</option>
								<option value="CREDIT MEMO" [#if invoiceAndCredit.recordType=="CREDIT MEMO"]selected="selected"[/#if]>CREDIT MEMO</option>
							</select> 
							<input id="recordType" type="hidden" name="type" value="${invoiceAndCredit.recordType}"/>
							<input id="confirmStatus" type="hidden" name="confirmStatus" value="${invoiceAndCredit.confirmStatus}"/>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>TourCode:</span>
						</td>
						<td width="37%">
							<input type="text"  id="tourCode" name="tourCode" value="${invoiceAndCredit.tourCode}" class="form-control" style="width:201px" />
							<input type="hidden"  id="tourId" name="tourId"/>			
						</td>
						<td>
							<span>DATE:</span>
						</td>
						<td width="37%">
							<div style="display: block;width:201px;" class="input-group1">
								<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
									<input parsley-type="dateIso" type="text" class="form-control" required placeholder="YYYY-MM-DD" name="month" value="${invoiceAndCredit.month?string("yyyy-MM-dd")}"  style="width:165px">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
							    </div>
							  </div>
							<font size="3px" color="red">&nbsp;*</font>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>Email:</span>
						</td>
						<td width="37%">
							<input type="email"  parsley-type="email" class="form-control" id="inputEmail3" placeholder="Email" name="emailTo" value="${invoiceAndCredit.emailTo}" style="width:201px" />
						</td>
						<td width="13%">
							<span>Remarks:</span>
						</td>
						<td width="37%">
							<input type="text"  id="remarks" name="remarks" value="${invoiceAndCredit.remarks}" class="form-control" style="width:201px" />	
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>Auditing Status:</span>
						</td>
						<td width="37%">
							<input type="text" value="${invoiceAndCredit.confirmStatus}" class="form-control" style="width:201px" />
						</td>
						<td width="13%">
							<span>Auditing Remark:</span>
						</td>
						<td width="37%">
							<input type="text" value="${invoiceAndCredit.confirmRemarks}" class="form-control" style="width:201px" />	
						</td>
					</tr>
				</tbody>
			</table>
				<div name="slide_customerIndex" id="slide_customerIndex">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff; cursor:pointer;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber">Checking Details</span>
							<div class="pull-right">
				               <i id="upOrDown" class="fa fa-angle-up"></i>&nbsp;&nbsp;
				           </div>
				        </h4>
				        <div id="infotab">
							<table id="tab">
		                		<tr>
		                			<td width="20%" align="center">Remark</td>
		                			<td width="20%" align="center">Description</td>
		                			<td width="20%" align="center">Amount</td>
		                			<td width="20%" align="center">Exchange Amount</td>
		                			<td width="20%" align="center">USD</td> 
		                			<td width="100px" align="center">Action</td>
		                		</tr>
		                		[#list listInvoiceAndCreditItems as invoiceAndCreditItems]
			                		<tr id="expenses${invoiceAndCreditItems_index}">
			                			<input id="invoiceAndCreditId${invoiceAndCreditItems_index}" type="hidden" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].invoiceAndCreditId" value="${invoiceAndCreditItems.invoiceAndCreditId}"/>
			                			<input id="businessNo${invoiceAndCreditItems_index}" type="hidden" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].businessNo" value="${invoiceAndCreditItems.businessNo}"/>
			                			<input id="itemsId${invoiceAndCreditItems_index}" type="hidden" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].itemsId" value="${invoiceAndCreditItems.itemsId}"/>
			                			<input id="billToDeptId${invoiceAndCreditItems_index}" type="hidden" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].billToDeptId" value="${invoiceAndCreditItems.billToDeptId}"/>
			                			<input id="deptId${invoiceAndCreditItems_index}" type="hidden" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].deptId" value="${invoiceAndCreditItems.deptId}"/>
			                			<td align="center"><input type="text"  id="tourCode" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].remarks" value="${invoiceAndCreditItems.remarks}" class="form-control" style="width:240px;"/></td>
			                			<td align="center"><input type="text"  id="description" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].description" value="${invoiceAndCreditItems.description}" class="form-control" style="width:100px;"/></td>
			                			<td align="center">
			                				<input type="text" onkeyup="return ValidateNumber(this,value)" id="amount${invoiceAndCreditItems_index}" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].amount" onChange="amountBlur(${invoiceAndCreditItems_index});" value="${invoiceAndCreditItems.amount}" class="form-control" style="width:100px;"/>
			                				<input type="hidden" id="amounts${invoiceAndCreditItems_index}" value="${invoiceAndCreditItems.amount}"/>
			                			</td>
			                			<td align="center">
			                				<input type="text" id="afterAmounts${invoiceAndCreditItems_index}" value="${invoiceAndCreditItems.afteramount}" readonly="readonly" class="form-control" style="width:100px;"/>
			                				<input type="hidden" id="afterAmounts${invoiceAndCreditItems_index}" value="${invoiceAndCreditItems.afteramount}"/>
			                			</td>
			                			<td align="center">
			                				<input type="text"  id="dollarAmount${invoiceAndCreditItems_index}" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].dollarAmount" readonly="readonly" value="${invoiceAndCreditItems.dollarAmount}" class="form-control" style="width:100px;"/>
			                				<input type="hidden" id="dollarAmountc${invoiceAndCreditItems_index}" value="${invoiceAndCreditItems.dollarAmount}"/>
			                			</td>
			                			<td align="center"><button type="button" onclick="removeTr(${invoiceAndCreditItems_index},'${invoiceAndCreditItems.itemsId}','${invoiceAndCreditItems.invoiceAndCreditId}')" id="removeButton" class="btn btn-default">REMOVE</button></td>
			                			[#if !invoiceAndCreditItems_has_next]
			                				<input id="numb" type="hidden" value="${invoiceAndCreditItems_index}"/>
			                			[/#if]
			                		</tr>
		                		[/#list]
		                		<tr id="lastTr" style="border-top:#2BBCA0 solid 5px;">
			                			<td align="center" width="20%">
			                				ROE($)
			                				<input type="hidden"  id="rateOfCurrencyId" name="rateOfCurrencyId" value="${invoiceAndCredit.rateOfCurrencyId}"/>
			                				<input type="hidden"  id="rateUp" value="${rateOfCurrency.rateUp}"/>
			                				<input type="hidden"  id="rateDown" value="${rateOfCurrency.rateDown}"/>
			                				<input type="hidden"  id="usRate" value="${rateOfCurrency.usRate}"/>
			                			</td align="center" width="20%">
			                			<td align="center" width="20%"><input type="text" id="changeRateInput" value="${rateOfCurrency.rateDown}/${rateOfCurrency.rateUp}" readonly="readonly" class="form-control" style="width:100px;"/></td>
			                			<td align="center" width="20%">
			                				<span id="allAmount" size="10px">${invoiceAndCredit.enterCurrency}</span>
			                				<input type="hidden"  id="enterCurrency" name="enterCurrency" value="${invoiceAndCredit.enterCurrency}"/>
			                			</td>
			                			<td align="center" width="20%"><span id="allAfterAmount" size="10px">0</span></td>
			                			<td align="center" width="20%">
			                				<span id="allDollarAmount" size="10px">$${invoiceAndCredit.dollar}</span>
			                				<input type="hidden"  id="dollar" name="dollar" value="${invoiceAndCredit.dollar}"/>
			                			</td>
			                			<td align="center" width="300px">
			                				<button type="button" id="addButton" onclick="addTr()" class="btn btn-default" size="25">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </button>
			                			</td>
			                		</tr>
		                	</table>
		                </div>
            	</div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button id="subButton" type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
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
    	$("#s2id_addRecordType").attr("style","width:201px");
    	$("#s2id_deptId").attr("style","width:201px");
    	var recordType = "${invoiceAndCredit.recordType}";
    	$("#s2id_addRecordType .select2-choice .select2-chosen").html(recordType);
    	
    	//总的转换后的值获取
    	var enterCurrency=$("#enterCurrency").val();
    	var rateUp=$("#rateUp").val();
		var rateDown=$("#rateDown").val();
		var afterAmount = changeTwoDecimal(parseFloat(enterCurrency)*parseFloat(rateUp)/parseFloat(rateDown));
		$("#allAfterAmount").html(afterAmount);
		//recordType初始选中
		//$("#addRecordType option[value='"+$("#recordType").val()+"']").attr("selected","selected");
		$("#addRecordType").attr("value",$("#recordType").val());
		//对方部门初始选中
		$("#billToDept option[value='"+$("#billToDeptId").val()+"']").attr("selected","selected");
		var confirmStatus=$("#confirmStatus").val();
		if(confirmStatus=="CONFIRMAUTO"||confirmStatus=="CONFIRMSEND"){
			$("#formId").find("input,select,#time,#removeButton,#addButton,#subButton").attr("disabled",true);
		}
    });
    //明细显示和隐藏
	$("h4").click(function(){
	  $("#infotab").slideToggle();
	  if($("#upOrDown").hasClass("fa fa-angle-up")){
	  	$("#upOrDown").removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
	  }else{
	  	$("#upOrDown").removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
	  }
	});
    function billToDeptChange(){
		var billToReceiver=$("#billToDeptId").val();
		$("#billToTd").attr("value",billToReceiver);
		var toDeptId = $("#deptId").val();
		$("#billToDeptId").attr("value",toDeptId);
		var billToReceiver = $("#deptId").find("option:selected").text();
		$("#billToReceiver").attr("value",billToReceiver);
		$.ajax({
			type:"POST",
			url:"${base}/admin/invoiceAndCredit/getRate.jhtml?toDeptId="+toDeptId,
			dataType:"json",
			success:function(map) {
				$("#changeRateInput").attr("value",map.rateUp+"/"+map.rateDown);
				$("#rateUp").attr("value",map.rateUp);
				$("#rateDown").attr("value",map.rateDown);
				$("#usRate").attr("value",map.usRate);
				$("#rateOfCurrencyId").attr("value",map.rateOfCurrencyId);
			}
	});
	
}
	
	function selectRecordType(){
		var recordType=$("#addRecordType").val();
		$("#recordType").attr("value",recordType);
	}
	function amountBlur(numb){
		removeTr(numb,"add","");	
		var enterCurrency=$("#enterCurrency").val();
		var dollar=$("#dollar").val();
		var allAfterAmount=$("#allAfterAmount").text();
		var amount=$("#amount"+numb).val();
		if(amount==null||amount==""){
			amount=0;
			$("#amount"+numb).val(0);
		}
		var rateUp=$("#rateUp").val();
		var rateDown=$("#rateDown").val();
		var usRate=$("#usRate").val();
		
		var afterAmount = changeTwoDecimal(parseFloat(amount)*parseFloat(rateUp)/parseFloat(rateDown));
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
	function addTr(){
		var n=$("#numb").val();
		var numb=parseFloat($("#numb").val())+1;
		$("#numb").attr("value",numb);
		var invoiceAndCreditId =$("#invoiceAndCreditId"+n).val();
		var businessNo =$("#businessNo"+n).val();
		var billToDeptId =$("#billToDeptId"+n).val();
		var deptId =$("#deptId"+n).val();
		 var data="<tr id='expenses"+numb+"'>"
		 			+"<input type='hidden'  value='"+numb+"' name='listInvoiceAndCreditItems["+numb+"].sortNo'/>"
		 			+"<input id='invoiceAndCreditId"+numb+"' type='hidden' name='listInvoiceAndCreditItems["+numb+"].invoiceAndCreditId' value='"+invoiceAndCreditId+"'/>"
	                +"<input id='businessNo"+numb+"' type='hidden' name='listInvoiceAndCreditItems["+numb+"].businessNo' value='"+businessNo+"'/>"
	                +"<input id='billToDeptId"+numb+"' type='hidden' name='listInvoiceAndCreditItems["+numb+"].billToDeptId' value='"+billToDeptId+"'/>"
	                +"<input id='deptId"+numb+"' type='hidden' name='listInvoiceAndCreditItems["+numb+"].deptId' value='"+deptId+"'/>"
			 		+"<td align='center'><input type='text'    id='remarks' name='listInvoiceAndCreditItems["+numb+"].remarks' class='form-control' style='width:240px;'/></td>"
			 		+"<td align='center'><input type='text'  id='description' name='listInvoiceAndCreditItems["+numb+"].description'  class='form-control' style='width:100px;'/></td>"
			 		+"<td align='center'>"
			 			+"<input type='text'placeholder='Number' value='0' id='amount"+numb+"' name='listInvoiceAndCreditItems["+numb+"].amount' onChange='amountBlur("+numb+");' class='form-control' style='width:100px;'/>"
			 			+"<input type='hidden' id='amounts"+numb+"' value='0'/>"
			 		+"</td>"
			 		+"<td align='center'>"
			 			+"<input type='text' id='afterAmounts"+numb+"' value='0' readonly='readonly' class='form-control' style='width:100px;'/>"
			 			+"<input type='hidden' id='afterAmounts"+numb+"' value='0'/>"
			 		+"</td>"
			 		+"<td align='center'>"
			 			+"<input type='text' id='dollarAmount"+numb+"' value='0' name='listInvoiceAndCreditItems["+numb+"].dollarAmount' readonly='readonly' class='form-control' style='width:100px;'/>"
			 			+"<input type='hidden' id='dollarAmountc"+numb+"' value='0'/>"
			 		+"</td>"
			 		+"<td align='center'><button type='button' onclick='removeTr("+numb+")' id='removeButton' class='btn btn-default'>REMOVE</button></td>"
		 		  +"</tr>"
		 		  $("#tab #lastTr").before(data);
		 		  $("#tab td input[id^='amount']").each(function(i){
		 				$("#amount"+i).attr("onkeyup","return ValidateNumber(this,value)");
		 		})
	}
	function removeTr(numb,add,id){
		var enterCurrency=$("#enterCurrency").val();
		var dollar=$("#dollar").val();
		var allAfterAmount=$("#allAfterAmount").text();
		var amount,dollarAmount,afterAmount,allAmount,allDollarAmount;
		if(add==null){//删除整行时的判断和计算
			if($("#tab tr[id^='expenses']").length==1){
		    		alert("Carefull, This is the last data！");
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
			if(add!="add"){//有id
				if(confirm("Data will be permanently deleted ？")){
					location.href="${base}/admin/invoiceAndCredit/delItems.jhtml?invoiceAndCreditItemsId="+add+"&invoiceAndCreditId="+id;
				}
				//$.ajax({
					//type:"POST",
					//url:"${base}/admin/invoiceAndCredit/delItems.jhtml?invoiceAndCreditItemsId="+add+"&invoiceAndCreditId="+id,
					//dataType:"json",
					//success:function(map) {
					//alert(1);
						//alert(map.data);
					//}
				//});
			}else{
				var amount=$("#amounts"+numb).val();
				var dollarAmount=$("#dollarAmountc"+numb).val();
				var afterAmount=$("#afterAmounts"+numb).val();
				if(amount!=""){//有数据时执行
					allAmount=changeTwoDecimal(parseFloat(enterCurrency)-parseFloat(amount));
					allDollarAmount=changeTwoDecimal(parseFloat(dollar)-parseFloat(dollarAmount));
					allAfterAmount=changeTwoDecimal(parseFloat(allAfterAmount)-parseFloat(afterAmount));
					$("#dollarAmount"+numb).attr("value","0");
					$("#afterAmounts"+numb).attr("value","0");
					$("#amounts"+numb).attr("value","0");
				}
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
		
		//判断是否是数字
		function ValidateNumber(e, pnumber){
		//if (!/^[-]?\d+[.]?\d*$/.test(pnumber)){
			//$(e).val(/^[-]?\d+[.]?\d*/.exec($(e).val()));
		//}
		return false;
	}
	
	$("#printForDetail").click(function(){
		window.location.href="printForDetail.jhtml?invoiceAndCreditId=${invoiceAndCredit.invoiceAndCreditId}";
	});

</script>
</body>
</html>
