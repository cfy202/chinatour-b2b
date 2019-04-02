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
			<h2>Optional Excursion</h2>
			<a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
			<ol class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li><a href="#">Order</a></li>
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
										<th style="display:none"></th>
										<th></th>
										<th>No.</th>
										<th>Pax Name.</th>
										<th>Name</th>
										<th>Price</th>
										<th>Num</th>
									</tr>
								</thead>
								<tbody>
									[#if orderReceiveItemsList??]
										[#list orderReceiveItemsList as orderReceiveItems]
											<tr>
												<td style="display:none">${tourInfoForOrder.tourInfo}</td>
												<td><img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" onclick="showRemark(this)"/></td>
												<td>${orderReceiveItems.customerId}</td>
												<td>${orderReceiveItems.customerName}</td>
												<td>${orderReceiveItems.remark}</td>
												<td>${orderReceiveItems.itemFee}</td>
												<td>${orderReceiveItems.itemFeeNum}</td>
											</tr>
										[/#list]
									[/#if]
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
        $("#datatable2_filter").hide(); 
        $("#datatable2_length").hide();
        $(".pull-left").hide();
        $("#datatable2_paginate").hide();
    	 $('#confirm-delete').on('show.bs.modal', function (e) {
			$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
		});
    });
             function fnFormatDetails ( oTable, nTr,tdValue )
        {	
            var aData = oTable.fnGetData(nTr);
            var specificItems = aData.specificItems;
           
            if(specificItems==null){
            	specificItems = "";
            }
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-bottom: 1px solid #dadada;width:10%;">Remark:</td><td style="border-bottom: 1px solid #dadada;">'+tdValue+'</td></tr>';
            sOut += '</table>';
            return sOut;
        };
        var oTable = $('#datatable2').dataTable({});
    
    $('#pcont').delegate('tbody td img','click', function () {
            var nTr = $(this).parents('tr')[0];
            
            if ( oTable.fnIsOpen(nTr) )
            {
                /* This row is already open - close it */
                this.src = "[@spring.url '/resources/images/plus.png'/]";
                oTable.fnClose( nTr );
            }
            else
            {
                /* Open this row */
                this.src = "[@spring.url '/resources/images/minus.png'/]";
                oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr,$(this).parent().prev().text()), 'details' );
            }
        });
        function showRemark(x){
        	//alert($(x).parent().prev().text());
        }
</script>
</body>
</html>
