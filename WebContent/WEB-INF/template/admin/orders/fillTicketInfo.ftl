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
       	<h2>
			View Booking
		</h2>
        <div class="new"><a class="btn pull-right" href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a></div>
		<ol class="breadcrumb"> 
			<li>
				<a style="cursor:pointer;" href="../../">
					Home
				</a>
			</li>
			<li>
				<a style="cursor:pointer;" href="list.jhtml">
					Booking - ${productVO.order.orderNo}
				</a>
			</li>
    </div>
    <div class="cl-mcont">		
	<div class="row wizard-row">
      <div class="col-md-12 fuelux">
        <div class="block-wizard">
          <div class="step-content">
          	<form action="submitTicketInfo.jhtml" method="post">
				<table style="word-break:break-all;white-space:nowrap;border: 0px none" width="100%">
					<tbody>
						<tr>
							<td width="13%">
								Booking No.:
							</td>
							<td width="37%"> 
								${productVO.order.orderNo}
							</td>
							<td width="13%">
								<span>
									Brand:
								</span>
							</td>
							<td width="37%">
								${productVO.groupLine.brand}
							</td>
						</tr>
						<tr>
							<td width="13%">   
								Product Code:
							</td>
							<td width="37%">
								${productVO.groupLine.tourCode}
							</td>
							<td width="13%">
								<span>
									Product Name: 
								</span>
							</td>
							<td width="37%">
								${productVO.groupLine.tourName}
							</td>
						</tr>
						<tr>
							<td>
								出签日期:
							</td>
							<td>
								<input name="checkOutDate" class="date form-control input-group1" [#if (productVO.order.checkOutDate)??]value="${(productVO.order.checkOutDate)?string('yyyy-MM-dd')}"[/#if]>
							</td>
							<td>
								送签日期:
							</td>
							<td>
								<input name="sendingDate" class="date form-control input-group1" [#if (productVO.order.sendingDate)??]value="${(productVO.order.sendingDate)?string('yyyy-MM-dd')}"[/#if]>
							</td>
					    </tr>
						<tr>
							<td>
								销签日期:
							</td>
							<td>
								<input name="pinSigningDate" class="date form-control input-group1" [#if (productVO.order.pinSigningDate)??]value="${(productVO.order.pinSigningDate)?string('yyyy-MM-dd')}"[/#if]>
							</td>
							<td>
							   Tour Code
							</td>
							<td>
								<input name="tourCode" class="date form-control input-group1" value="${productVO.order.tourCode}">
							</td>
					    </tr>
					</tbody>
				</table>
				<button style="float:right" type="submit" data-wizard="#wizard1" class="btn btn-primary" style="margin-right:40px;">
			  		submit 
				</button>
				<input name="reference" type="hidden" value="${productVO.order.reference}">
				<input name="id" type="hidden" value="${productVO.order.id}">
			</form>
          </div>
        </div>
      </div>
    </div>
	</div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
	$(function(){
		App.init();
		App.wizard();
	});
	$('input.date').datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '1930:2050' });
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>