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
<!-- Modal -->
<div class="modal fade" id="confirm-upload" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	Upload File
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" enctype="multipart/form-data"   action="upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file"  placeholder="Upload File" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary" style="margin-left:206px;">Upload</button>
						</div>
					</div>
				</form>
			</div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
       <div class="page-head">
            <h2>Tour List</h2>
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
                            <h3>Tour List</h3>
                            <div class="new"></div>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
	                                    <tr>
	                                        <th>Tour Code</th>
	                                        <th>NEW</th>
	                                        <th>Booking No.</th>
	                                        <th>Status</th>
	                                        <th>Total Passenger</th>
	                                        <th>Amount</th>
	                                        <th>Agent</th>
	                                        <th>Action</th>
	                                    </tr>
                                    </thead>
                                </table>
                            </div>
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
        [@flash_message /]
       
       $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bSort":false,
            "ajax": {
                url: "[@spring.url '/admin/tour/tourList.jhtml'/]",
                type: "POST"
            },
            "columns": [
                { "data": "tourCode" },
                { "data": "lineName" },
                { "data": "arriveDateTime" },
                { "data": "type" },
                { "data": "userId" },
                { "data": "totalPeople" },
                { "data": "tourId" },
                { "data": "tourId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li><a href="modifyOrders.jhtml?tourCode='+ row.tourCode +'"><i></i>View Booking</a></li><li><a href="tourCustomerList.jhtml?tourId='+ data +'"><i></i>Passenger Info</a></li></div>';
                 },
				"targets" : 7
		  }],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		    	  var str='<div><a data-href="${base}/admin/tour/upload?tourId='+aData.tourId+'" style="cursor: pointer;" id="upload" data-toggle="modal"  data-target="#confirm-upload"><i class="fa fa-upload"></i>Upload</a><a href="${base}/admin/tour/download?id='+aData.tourId+'" ><i class="fa fa-download"></i>Download</a></div>';
		        $('td:eq(6)', nRow).html(str);
		    } 
		  
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
         $('#confirm-upload').on('show.bs.modal', function (e) {
            $(this).find('#formId').attr('action', $('#upload').data('href'));
        });
        
    });
</script>
</body>
</html>
