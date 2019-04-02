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
		<h2>Air Ticket</h2>
		<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li><a href="#">Accounting</a></li>
		<div class="new"><a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a></div>
		</ol>
	</div>
	<div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div class="header">							
						<h3>${supplierPriceForOrder.invoiceNo}</h3>
					</div>
					<div class="content">
						<table class="no-border">
							<thead class="no-border">
								<tr>
									<th style="width:20%;"></th>
									<th></th>
										<th>
											${supplierPriceForOrder.agentName}—${supplierPriceForOrder.deptName}(${supplierPriceForOrder.quantity})
											(${rateOfCurrency.currencyId})
										</th>
								</tr>
							</thead>
							<tbody class="no-border-x">
								<tr>
									<td>
										Ticket:
									</td>
									<td></td>
									<td>
										${supplierPriceForOrder.ticketNo}
									</td>
								</tr>
								<tr>
									<td>
										Airline:
									</td>
									<td></td>
									<td>
										${supplierPriceForOrder.airline}
									</td>
								</tr>
								<tr>
									<td>
										PNR:
									</td>
									<td></td>
									<td>
										${supplierPriceForOrder.flightPnr}
									</td>
								</tr>
								<tr>
									<td>
										Charge:
									</td>
									<td></td>
									<td>
										${rateOfCurrency.currencyId}
										${supplierPriceForOrder.charge}
									</td>
								</tr>
								<tr>
									<td>
										Selling:
									</td>
									<td></td>
									<td>
										${rateOfCurrency.currencyId}
										${supplierPriceForOrder.amount}
									</td>
								</tr>
								<tr>
									<td>
										Net:
									</td>
									<td></td>
									<td>
										${rateOfCurrency.currencyId}
										${supplierPriceForOrder.operatorFee}
									</td>
								</tr>
								<tr>
									<td>
										ARC:
									</td>
									<td></td>
									<td>
										${rateOfCurrency.currencyId}
										${supplierPriceForOrder.tempValue06}
										[#assign arc =(supplierPriceForOrder.tempValue06)?number ]
									</td>
								</tr>
								<tr>
									<td>
										Bill/Credit:
									</td>
									<td></td>
									<td>
										${rateOfCurrency.currencyId}
										${supplierPriceForOrder.amount-supplierPriceForOrder.charge}
										[#assign billProfit =(supplierPriceForOrder.amount-supplierPriceForOrder.charge)?number ]
									</td>
								</tr>
								<tr>
									<td>
										Profit(Exchange Rate${rateOfCurrency.rateUp}/${rateOfCurrency.rateDown}):
									</td>
									<td></td>
									<td>
										${rateOfCurrency.currencyId}
										${supplierPriceForOrder.amount-supplierPriceForOrder.operatorFee}
									</td>
								</tr>
							</tbody>
						</table>						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="confirm-primary" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <form action="" id="agentCheckId"  method="post">
				<div class="modal-body">
					<div class="text-center">
						<div class="i-circle primary"><i class="fa fa-check"></i></div>
						<h4>Awesome!</h4>
						<p>Changes has been saved successfully!</p>
						Remarks
						[#list supplierCheckList as supplierCheck]
							<input type="text"  name="remarkOfAgent" style="width:400px;" value="${supplierCheck.remarkOfAgent }"/>
						[/#list]
						<input type="hidden" value="${admin.id}" name="checkUserId" />
						<input type="hidden" value="${tour.tourId}" name="tourId" id="tourId" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-primary btn-flat">Proceed</button>
				</div>
			</form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!--审核弹出框-->
<div class="md-modal md-effect-9" id="md-flipV">
	<div class="md-content">
		<div class="modal-header">
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<div class="modal-body">
			<div class="text-center">
				<div class="i-circle primary"><i class="fa fa-check"></i></div>
					<h4>Awesome!</h4>
					<p>Changes has been saved successfully!</p>
				</div>
			</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			<button type="button" class="btn btn-primary btn-flat" onclick="formSumDal();">Proceed</button>
		</div>
	</div>
</div>
<!--/审核弹出框-->
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
      $(document).ready(function(){
        //initialize the javascript
        App.init();
      });
	$('#confirm-primary').on('show.bs.modal', function (e) {
		$(this).find('#agentCheckId').attr('action', $(e.relatedTarget).data('href'));
	});
</script>
</body>
</html>
