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
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Are you confirmation?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalId" type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>Passenger Info</h2>
			<a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
			<ol class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li><a href="#">Tour</a></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="content">
							<table class="table table-bordered" id="datatable2">
								<thead>
									<tr>
										<th>Del</th>
										<th>No.</th>
										<th>Tour Code</th>
										<th>Booking No.</th>
										<th>LastName</th>
										<th>FirstName</th>
										<th>Nationality</th>
										<th>Passport No.</th>
										<th>Ticket Type</th>
										<th>Voucher</th>
										<th>Agent</th>
									</tr>
								</thead>
								<tbody>
									[#list tourVOList as tourVo]
										<tr>
											[#if tourVo.isDel==0]
												<td></td>
											[#elseif tourVo.isDel==1]
												<td><span class='color-danger'>Cancelled</span></td>
											[#elseif tourVo.isDel==3]
												<td id="${tourVo.customerOrderRelId}"><a data-href="javascript:recoverCustomerRel('${order.id}','${tourVo.customerOrderRelId}','${order.ordersTotalId}');" data-toggle="modal" data-target="#confirm-delete"><span class='color-danger'>Recovering</span></a></td>
											[#elseif tourVo.isDel==5]
												<td id="${tourVo.customerOrderRelId}"><a data-href="javascript:updateCustomerRel('${order.id}','${tourVo.customerOrderRelId}','${order.ordersTotalId}');" data-toggle="modal" data-target="#confirm-delete"><span class='color-warning'>Cancelling</span></a></td>
											[/#if]
											<td>${tourVo.customerOrderNo}</td>
											<td>${tourVo.tourCode}</td>
											<td><a href="orderInfo.jhtml?menuId=${menuId}&id=${order.id}">${tourVo.orderNo}</a></td>
											<td>${tourVo.lastName}</td>
											<td>${tourVo.firstName}</td>
											<td>${tourVo.nationalityOfPassport}</td>
											<td>${tourVo.passportNo}</td>
											<td>${tourVo.ticketType}</td>
											<td>${tourVo.voucherStr}</td>
											<td>${tourVo.agent}</td>
										</tr>
									[/#list]
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        
    	 $('#confirm-delete').on('show.bs.modal', function (e) {
			$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
		});
    });
    // 取消客人  修改客人状态
	function updateCustomerRel(orderId,customerOrderRelId,ordersTotalId){
		$("#modalId").trigger("click");
		$.ajax({
			url:'updateCustomerRel.jhtml',
			data:'id='+customerOrderRelId+'&tourId=${order.tourId}&orderId='+orderId+'&ordersTotalId='+ordersTotalId,
			type:"POST",
			success:function(result){
				if(result=="SUCCESS"){
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+customerOrderRelId).html("<span class='color-danger'>Cancelled</span>");
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
	 //恢复客人
	function recoverCustomerRel(orderId,customerOrderRelId,ordersTotalId){
		$("#modalId").trigger("click");
		$.ajax({
			url:'recoverCustomerRel.jhtml',
			data:'id='+customerOrderRelId+'&tourId=${order.tourId}&orderId='+orderId+'&ordersTotalId='+ordersTotalId,
			type:"POST",
			success:function(result){
				
				if(result=="SUCCESS"){
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+customerOrderRelId).html("");
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
</script>
</body>
</html>
