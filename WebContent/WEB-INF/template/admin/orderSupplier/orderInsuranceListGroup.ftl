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
                    <h4><i class="fa fa-warning"></i> Warning !</h4>

                    <p>Data will be permanently deleted ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
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
            <h2>Billing(GROUP)</h2>
            <div class="new">[#if (supplierPrice.allCheck==0&&supplierPrice.accCheck==0)||supplierPrice==null]<button class="btn btn-success" type="button" id="New" onclick="location.href='${base}/admin/insurancePriceInfo/orderInsuranceAddGroup.jhtml?tourId=${tour.tourId}&tourCode=${tour.tourCode}'">&nbsp;&nbsp;New &nbsp;&nbsp;</button>[/#if]</div>
            <ol class="breadcrumb">
               <li><a href="#">Home</a></li>
			   <li><a href="#">Tour</a></li>
            </ol>
        </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
                            <h3>Detail Info</h3>
                            <a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
                        </div>
						<div class="content">
							<table class="">
								<thead class="no-border">
									<tr>
										<th>No.</th>
                                        <th class="text-center">Tour Code</th>
                                        <th class="text-center">Insurance</th>
                                        <th class="text-center">Price</th>
                                        <th class="text-center">Action</th>
									</tr>
								</thead>
								<tbody class="">
								[#if supPriceInfoRelList?size<=0]<tr><td>No Data</td></tr>[/#if]
								[#list supPriceInfoRelList as supInfo]
									<tr>
										<td style="width:30%;">${supInfo_index+1}</td>
										<td class="text-center">${tour.tourCode}</td>
										<td class="text-center">${supInfo.supplierName}</td>
										<td class="text-center">${supInfo.supplierPrice}</td>
										<td class="text-center">
											<a href="${base}/admin/insurancePriceInfo/updateInsuranceGroup.jhtml?supPriceInfoRelId=${supInfo.supPriceInfoRelId}&tourCode=${tour.tourCode}&tourId=${tour.tourId}">Edit</a>
											[#if supplierPrice.allCheck==0&&supplierPrice.accCheck==0]
												<a data-href="${base}/admin/supplierPrice/deleteGroup.jhtml?type=4&supPriceInfoRelId=${supInfo.supPriceInfoRelId}&tourCode=${tour.tourCode}&tourId=${tour.tourId}" data-toggle="modal" data-target="#confirm-delete">Delete</a>
											[/#if]
										</td>
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
    	App.init();
    	 $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
    });
</script>
</body>
</html>
