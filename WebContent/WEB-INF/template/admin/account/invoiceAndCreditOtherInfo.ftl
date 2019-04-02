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
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Bill Detailed-${invoiceAndCredit.businessNo}</h3>
          </div>
            <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="update.jhtml" method="post" parsley-validate novalidate>
	              <table style="word-break:break-all;white-space:nowrap; " width="100%">
					 <tbody>
						<tr>
							<td width="13%">
								<span>BillTo:</span>
							</td>
							<td width="37%">
								<input type="text"value="${dept.deptName}" class="form-control" style="width:201px" disabled/>
							</td>
							<td>
								<span>Record Type:</span>
							</td>
							<td>
								<select id="addRecordType" name="recType" onchange="selectRecordType();" class="select2" >
									<option value="INVOICE">INVOICE</option>
									<option value="CREDIT MEMO">CREDIT MEMO</option>
								</select> 
								<input id="recordType" type="hidden" name="recordType"  value="${invoiceAndCredit.recordType}"/>
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
							<td width="13%">
								<span>DATE:</span>
							</td>
							<td width="37%">
								<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
									<input type="text" readonly="readonly" class="form-control" name="createDate" value="${invoiceAndCredit.createDate?string("yyyy-MM-dd")}"  style="width:165px">
									<span class="input-group-addon btn btn-primary">
									     <span class="glyphicon glyphicon-th"></span>
							        </span>
							    </div>
							</td>
						</tr>
						<tr>
							<td width="13%">
								<span>Email:</span>
							</td>
							<td width="37%">
								<input type="email" name="emailTo" value="${invoiceAndCredit.emailTo}" class="form-control" style="width:201px" />
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
								<input type="text" id="confirmStatus" name="confirmStatus" value="${invoiceAndCredit.confirmStatus}" class="form-control" style="width:201px" />
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
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber">Checking Details</span>
							<div class="pull-right">
				               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
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
			                		<tr>
			                			<td align="center"><input type="text"  id="tourCode" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].remarks" value="${invoiceAndCreditItems.remarks}" class="form-control" style="width:230px;"/></td>
			                			<td align="center"><input type="text"  id="description" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].description" value="${invoiceAndCreditItems.description}" class="form-control" style="width:100px;"/></td>
			                			<td align="center">
			                				<input type="text"  id="amount${invoiceAndCreditItems_index}" name="listInvoiceAndCreditItems[${invoiceAndCreditItems_index}].amount" onChange="amountBlur(${invoiceAndCreditItems_index});" value="${invoiceAndCreditItems.amount}" class="form-control" style="width:100px;"/>
			                			</td>
			                			<td align="center">
			                				<input type="text" readonly="readonly" value="${invoiceAndCreditItems.afteramount}" class="form-control" style="width:100px;"/>
			                			</td>
			                			<td align="center">
			                				<input type="text" readonly="readonly" value="${invoiceAndCreditItems.dollarAmount}" class="form-control" style="width:100px;"/>
			                			</td>
			                			<td align="center"><button type="button" id="removeButton" class="btn btn-default">REMOVE</button></td>
			                		</tr>
		                		[/#list]
		                		<tr id="lastTr" style="border-top:#2BBCA0 solid 5px;">
			                			<td align="center" width="20%">
			                				ROE($)
			                				<input type="hidden"  id="rateOfCurrencyId" name="rateOfCurrencyId" value="${invoiceAndCredit.rateOfCurrencyId}"/>
			                				<input type="hidden"  id="rateUp" value="${rateOfCurrency.rateUp}"/>
			                				<input type="hidden"  id="rateDown" value="${rateOfCurrency.rateDown}"/>
			                				<input type="hidden"  id="usRate" value="${rateOfCurrency.usRate}"/>
			                			</td>
			                			<td align="center" width="20%"><input type="text" id="changeRateInput" value="${rateOfCurrency.rateDown}/${rateOfCurrency.rateUp}" readonly="readonly" class="form-control" style="width:100px;"/></td>
			                			<td align="center" width="20%">
			                				<span id="allAmount" size="10px">${invoiceAndCredit.enterCurrency}</span>
			                				<input type="hidden"  id="enterCurrency" name="enterCurrency" value="${invoiceAndCredit.enterCurrency}"/>
			                			</td>
			                			<td align="center" width="20%"><span id="allAfterAmount" size="10px">0</span></td>
			                			<td align="center" width="20%">
			                				<span id="allDollarAmount" size="10px">$${invoiceAndCredit.dollar}</span>
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
                  <button type="button" onclick="back('${invoiceAndCredit.deptId}')" class="btn btn-default">Cancel</button>
                  <button type="button" style="margin-left:206px;" class="btn btn-primary md-trigger" data-modal="form-primary" onclick="verify()" id="approveButton">Approve</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</div>

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Verify</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="verifyFormId" action="verifyDeptId.jhtml" style="border-radius: 0px;" method="post">
      	  <input id="invoiceAndCreditId" type="hidden" name="invoiceAndCreditId" value="${invoiceAndCredit.invoiceAndCreditId}"/>
      	  <div id="checkId"></div>
	      <div class="modal-body form" >
	      	 <div class="form-group" style="height:80px;">
                <label class="col-sm-3 control-label">Auditing Status</label>
                <div class="col-sm-6">
				  <div><input class="icheck" id="pass" type="radio" name="pass" value="1" checked="" style="position: absolute; opacity: 0;">Auditing Disapproved</div>
                   <div style="margin-top:10px;"><input class="icheck" id="pass" type="radio" name="pass" value="2" checked="" style="position: absolute; opacity: 0;">Auditing Approved</div>
                </div>
              </div>   
	      	 <div class="form-group" style="height:100px;">
                <label class="col-sm-3 control-label">Auditing Remark</label>
                <div class="col-sm-6">
                  <textarea class="form-control" name="rem" id="rem"> </textarea>
                </div>
              </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		        <button type="submit" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
		      </div>
	      </div>
      </form>
  	</div>
</div>
<div class="md-overlay"></div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("#s2id_addRecordType").attr("style","width:201px");
    	
    	var recordType = "${invoiceAndCredit.recordType}";
    	$(".select2-chosen").html(recordType);
    	//总的转换后的值获取
    	var enterCurrency=$("#enterCurrency").val();
    	var rateUp=$("#rateUp").val();
		var rateDown=$("#rateDown").val();
		var afterAmount = changeTwoDecimal(parseFloat(enterCurrency)*parseFloat(rateUp)/parseFloat(rateDown));
		$("#allAfterAmount").html(afterAmount);
		//recordType初始选中
		$("#addRecordType option[value='"+$("#recordType").val()+"']").attr("selected","selected");
		//对方部门初始选中
		$("#billToDept option[value='"+$("#billToDeptId").val()+"']").attr("selected","selected");
		$("#formId").find("input,select,#time,#removeButton,#addButton").attr("disabled",true);
		
		if($("#confirmStatus").val()=="CONFIRM"||$("#confirmStatus").val()=="CONFIRMAUTO"||$("#confirmStatus").val()=="CONFIRMSEND"){
			$("#approveButton").css("display","none");
		}
    });
	//获取两位小数点
	function changeTwoDecimal(x){
			var f_x = parseFloat(x);
			if (isNaN(f_x))
			{
				alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x*100)/100;
		
			return f_x;
		}
	//明细显示和隐藏
	$("h4").click(function(){
	  $("#infotab").slideToggle();
	});
	function back(deptId){
		location.href ="javascript:history.go(-2);";
	}
	
	$("#printForDetail").click(function(){
		window.location.href="printForDetail.jhtml?invoiceAndCreditId=${invoiceAndCredit.invoiceAndCreditId}";
	});
</script>
</body>
</html>
