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
		[#if flag==1]<div class="new"><button class="btn btn-success" type="button" onclick="alertApproveForm();">&nbsp;&nbsp;Approve &nbsp;&nbsp;</button></div>[/#if]
		<div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertInfoButton" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
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
											<th style="font-size:14px;font-weight:bold; width:5%; vertical-align: bottom;">No.</th>
											<th style="font-size:14px;font-weight:bold; width:5%; vertical-align: bottom;">OrderNo</th>
											<th style="font-size:14px;font-weight:bold; width:17%; vertical-align: bottom;">Last Name</th>
											<th style="font-size:14px;font-weight:bold; width:17%; vertical-align: bottom;">First Name</th>
											<th style="font-size:14px;font-weight:bold; width:17%; vertical-align: bottom;">Middle Name</th>
											<th style="font-size:14px;font-weight:bold; width:10%; vertical-align: bottom;">Amount</th>
											<th style="font-size:14px;font-weight:bold; width:27%; vertical-align: bottom;">Remark</th>
										<tr>
									</thead>
									<tbody>
										[#list europecustomerFeeList as europecustomerFee]
											<tr>
												<td>${europecustomerFee.customerOrderNo}</td>
												<td>${europeTourPrice.orderNo}</td>
												<td>${europecustomerFee.lastName}</td>
												<td>${europecustomerFee.firstName}</td>
												<td>${europecustomerFee.middleName}</td>
												<td>${europecustomerFee.enterCurrency}</td>
												<td>${europecustomerFee.remark}</td>
											<tr>
										[/#list]
										<td style="font-size:14px;font-weight:bold;vertical-align: bottom;">Total</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td style="font-size:14px;font-weight:bold;vertical-align: bottom;">${europeTourPrice.receivableAmount}</td>
										<td></td>
									</tbody>
								</table>
						</form>
						[#if flag=0]<div class="new"><button style="margin-left:90%;margin-top:30px;" id="saveButton" class="btn btn-success" type="button">&nbsp;&nbsp;Save &nbsp;&nbsp;</button></div>[/#if]
					</div>
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
      <form id="verifyFormId" action="approveIncomePassForOP.jhtml" style="border-radius: 0px;" method="post">
      	  <input id="europeTourPriceId" type="hidden" name="europeTourPriceId">
	      <div class="modal-body form" >
	      	 <div class="form-group" style="height:80px;">
                <label class="col-sm-3 control-label">Auditing Status</label>
                <div class="col-sm-6">
				  <input class="icheck" id="pass" type="radio" name="pass" value="1" checked="" style="position: absolute; opacity: 0;">审核不通过
                  <input class="icheck" id="pass" type="radio" name="pass" value="2" checked="" style="position: absolute; opacity: 0;">审核通过
                </div>
              </div>   
	      	 <div class="form-group" style="height:100px;">
                <label class="col-sm-3 control-label">Auditing Remark</label>
                <div class="col-sm-6">
                  <textarea class="form-control" name="approveRemarkAgent"> </textarea>
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
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
<script type="text/javascript">
	function alertApproveForm(){
			id="${europeTourPrice.europeTourPriceId}";
			$("#europeTourPriceId").attr("value",id);
			$("#alertInfoButton").click();
		}
</script>
</body>
</html>
