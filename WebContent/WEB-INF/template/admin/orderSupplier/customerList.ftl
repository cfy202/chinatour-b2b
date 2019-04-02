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
		<h2>Bill/Settlement</h2>
		<div class="pull-right">
			[#if isShowForSettle==1]<button  id="settleOP" class="btn btn-success" type="button">&nbsp;&nbsp;Settlement &nbsp;&nbsp;</button>[/#if]
		</div>
		<div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertEditButton" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
		<a class="btn pull-right" href="#" onclick="goback();"><i class="fa fa-reply" title="Back"></i></a>
		<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li><a href="#">Tour</a></li>
		</ol>
	</div>
	<div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div style="width:100%;">
						<form action="saveEuropecustomerFee.jhtml" method="post" id="saveForm">
								<table>
									<thead>
										<tr style="background-color:#ccc;">
											<th style="font-size:14px;font-weight:bold; width:5%; vertical-align: bottom;">OrderNo</th>
											<th style="font-size:14px;font-weight:bold; width:5%; vertical-align: bottom;">No.</th>
											<th style="font-size:14px;font-weight:bold; width:17%; vertical-align: bottom;">Last Name</th>
											<th style="font-size:14px;font-weight:bold; width:17%; vertical-align: bottom;">First Name</th>
											<th style="font-size:14px;font-weight:bold; width:17%; vertical-align: bottom;">Middle Name</th>
											<th style="font-size:14px;font-weight:bold; width:10%; vertical-align: bottom;">Amount</th>
											<th style="font-size:14px;font-weight:bold; width:27%; vertical-align: bottom;">Remark</th>
											<th style="font-size:14px;font-weight:bold; width:7%; vertical-align: bottom;">Action</th>
										<tr>
									</thead>
									<tbody>
												<input type="hidden" name="europeTourPrice.userIdForOrder" value="${userIdForOrder}">
												<input type="hidden" name="europeTourPrice.userIdForTour" value="${userIdForTour}">
												<input type="hidden" name="europeTourPrice.deptIdForOrder" value="${deptIdForOrder}">
												<input type="hidden" name="europeTourPrice.deptIdForTour" value="${deptIdForTour}">
												<input type="hidden" name="europeTourPrice.rateOfCurrencyId" value="${rateOfCurrencyId}">
												<input type="hidden" name="europeTourPrice.orderId" value="${orderId}">
												<input type="hidden" name="europeTourPrice.orderNo" value="${orderNo}">
												<input type="hidden" name="europeTourPrice.tourId" value="${tourId}">
												<input type="hidden" name="europeTourPrice.tourCode" value="${tourCode}">
										[#list europecustomerFeeList as europecustomerFee]
											<tr>
												<input type="hidden" name="europeCustomerFeeList[${europecustomerFee_index}].orderId" value="${orderId}">
												<input type="hidden" name="europeCustomerFeeList[${europecustomerFee_index}].rateOfCurrencyId" value="${rateOfCurrencyId}">
												<input type="hidden" name="europeCustomerFeeList[${europecustomerFee_index}].customerOrderRelId" value="${europecustomerFee.customerOrderRelId}">
												<td>${orderNo}</td>
												<td>${europecustomerFee.customerOrderNo}</td>
												<td>${europecustomerFee.lastName}</td>
												<td>${europecustomerFee.firstName}</td>
												<td>${europecustomerFee.middleName}</td>
												<td><input type="text" name="europeCustomerFeeList[${europecustomerFee_index}].enterCurrency" [#if europecustomerFee.state>0]disabled="disabled"[/#if] class="form-control" value="${europecustomerFee.enterCurrency}"></td>
												<td><input type="text" name="europeCustomerFeeList[${europecustomerFee_index}].remark" class="form-control" [#if europecustomerFee.state>0]disabled="disabled"[/#if] value="${europecustomerFee.remark}"></td>
												<td>
													[#if europecustomerFee.state==1]<a style="cursor:pointer" onclick="updateEuropeCustomerFee('${europecustomerFee.europeCustomerFeeId}',this)" class="label label-default md-trigger" class="editEurope"><i class="fa fa-pencil"></i></a>[/#if]
												</td>
											<tr>
										[/#list]
									</tbody>
								</table>
						</form>
						[#if flag=0]<div class="new"><button style="margin-left:90%;margin-top:30px;" id="saveButton" class="btn btn-success" type="button">&nbsp;&nbsp;Save &nbsp;&nbsp;</button></div>[/#if]
					</div>
					<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff; cursor:pointer;margin-top:30px;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber"> Revised Bill</span>
				        </h4>
					<div style="width:100%;">
						<form action="saveBillChangeForEurope.jhtml" method="post" id="saveBillChangeForm">
							<table>
								<thead>
									<tr style="background-color:#ccc;">
										<th style="font-size:14px;font-weight:bold; width:5%; vertical-align: bottom;">OrderNo</th>
										<th style="font-size:14px;font-weight:bold; width:10%; vertical-align: bottom;">Revised Amount</th>
										<th style="font-size:14px;font-weight:bold; width:27%; vertical-align: bottom;">Change Reason</th>
										<th style="font-size:14px;font-weight:bold; width:7%; vertical-align: bottom;">Action</th>
									<tr>
									<tr>
										<td>${orderNo}</td>
										<td><input type="text" name="receivableAmount" class="form-control"></td>
										<td><input type="text" name="remark" class="form-control"></td>
										<td><a style="cursor:pointer;font-size:14px;" id="saveBillChange">save</a></td>
									</tr>
									[#list billChangeList as billChange]
										<tr>
											<td>${billChange.orderNo}</td>
											<td>${billChange.receivableAmount}</td>
											<td>${billChange.remark}</td>
											<td></td>
										</tr>
									[/#list]
								</thead>
							</table>
							<input type="hidden" name="userIdForOrder" value="${userIdForOrder}">
							<input type="hidden" name="userIdForTour" value="${userIdForTour}">
							<input type="hidden" name="deptIdForOrder" value="${deptIdForOrder}">
							<input type="hidden" name="deptIdForTour" value="${deptIdForTour}">
							<input type="hidden" name="rateOfCurrencyId" value="${rateOfCurrencyId}">
							<input type="hidden" name="orderId" value="${orderId}">
							<input type="hidden" name="orderNo" value="${orderNo}">
							<input type="hidden" name="tourId" value="${tourId}">
							<input type="hidden" name="tourCode" value="${tourCode}">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4>Edit</h4>
      </div>
	     <div class="modal-body form">
	      <form action="updateEuropeCustomerFee.jhtml" id="updateEuropeFeeForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			<table>
	    				<tr>
	    					<td>Amount</td>
	    					<td><input name="enterCurrency" type="text" class="form-control" id="updateEnterCurrency"></td>
	    				</tr>
	    				<tr>
	    					<td>Remark:</td>
	    					<td id="remark">
	    						<input name="remark" type="text" class="form-control" id="updateRemark">
	    					</td>
	    				</tr>
	    				<input id="europeCustomerFeeId" type="hidden" name="europeCustomerFeeId">
	    			</table>
	    		</div>
	     </form>
	    		<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button class="btn btn-default btn-flat md-close" data-dismiss="modal" onclick="updateEuropeFee()">OK</button>
		    	</div>
	     
	    </div>
   </div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
<script type="text/javascript">
	$("#saveButton").click(function(){
		$("#saveForm").submit();
	});
	
	function customerList(id){
		window.location.href="${base}/admin/supplierPrice/customerList.jhtml?orderId="+id;
	}
	
	function updateEuropeCustomerFee(europeCustomerFeeId,t){
		updateRemark = $(t).parent().prev().find("input").val();
		updateEnterCurrency = $(t).parent().prev().prev().find("input").val();
		$("#updateRemark").attr("value",updateRemark);
		$("#updateEnterCurrency").attr("value",updateEnterCurrency);
		$("#europeCustomerFeeId").attr("value",europeCustomerFeeId);
		$("#alertEditButton").click();
	}
	
	function updateEuropeFee(){
		$("#updateEuropeFeeForm").submit();
	}
	
	function goback(){
		id = "${tourId}";
		window.location.href="${base}/admin/supplierPrice/settleForOPPage.jhtml?id="+id;
	}
	
	$("#saveBillChange").click(function(){
		$("#saveBillChangeForm").submit();
	});
	
	//op结算变更单
	$("#settleOP").click(function(orderId){
		orderId = "${orderId}";
		location.href="${base}/admin/supplierPrice/settleBillChangeForAccOPPass.jhtml?orderId="+orderId;
	});
</script>
</body>
</html>
