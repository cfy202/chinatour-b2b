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
		<h2>Tour Bill</h2>
		<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li><a href="#">Accounting</a></li>
		</ol>
	</div>
	<div class="row">
		<div class="col-md-12">
			
			<div class="block-flat">
						<div class="header">
							<h3>Tour Bill</h3>
							<a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
						</div>
						<div class="content">
							<table class="">
								<thead class="no-border">
									<tr>
										<th>Type</th>
										<th class="text-center">Audit Status</th>
										<th class="text-center">Audit Remark(Agent)</th>
										<th class="text-center">Settlement Status(Agent)</th>
										<th class="text-center">Accountant Audit Status</th>
										<th class="text-center">Auditing Remark(Accountant)</th>
									</tr>
								</thead>
								<tbody class="">
									<tr>
										<td style="width:30%;">Name</td>
										<td class="text-center"></td>
										<td class="text-center"></td>
										<td class="text-center"></td>
										<td class="text-center"></td>
										<td class="text-center"></td>
									</tr>
									[#list supplierCheckList as supplierCheck]
										<tr>
											<td style="width:30%;">${supplierCheck.userNameOfAgent}</td>
											<td class="text-center">
												[#if supplierCheck.checkOfAgent==2]
													Disapproved
												[#elseif supplierCheck.checkOfAgent==1]
													Approved
												[#else]
													New
												[/#if]
											</td>
											<td class="text-center">${supplierCheck.remarkOfAgent}</td>
											<td class="text-center">
												[#if supplierCheck.tax==0||supplierCheck.tax==3]
													Unsettled
												[#elseif supplierCheck.tax==2]
													Settled，Not Sent Invoice
												[#elseif supplierCheck.tax==4]
													Settled
												[#else]
												[/#if]
											</td>
											<td class="text-center">
												[#if supplierPrice.accCheck==2]
													Disapproved
												[#elseif supplierPrice.accCheck==1]
													Approved
												[#elseif supplierPrice.accCheck==0]
													New
												[#else]
												[/#if]
											</td>
											<td class="text-center">${supplierPrice.checkRemark}</td>
										</tr>
									[/#list]
									<tr>
										<td>Subtotal</td>
										<td class="text-center"></td>
										<td class="text-center"></td>
										<td class="text-center"></td>
										<td class="text-center"></td>
										<td class="text-center"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
			
		</div>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
		$('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	  		 radioClass: 'iradio_square-blue'
     	});
	});
</script>
</body>
</html>
