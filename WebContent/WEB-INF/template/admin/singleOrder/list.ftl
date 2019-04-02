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
					 <p>Booking will be Cancel ?</p>
                </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="modal fade" id="confirm-recover" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>

                    <p>Booking will be Recover ?</p>
                </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- Modal -->
<div class="modal fade" id="confirm-order" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Cancell Booking!</h4>
					<div class="col-sm-6">
	                  <label class="radio-inline"> <input type="radio" checked="" name="tax" class="icheck" value="1">Unsettled</label> 
	                  <label class="radio-inline"> <input type="radio" name="tax" class="icheck" value="2">Settled</label> 
	                </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger" >Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Other Booking</h3>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="location.href='add.jhtml'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Booking</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>Booking Info</h3>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Booking No.</th>
                                        <th>Tour Code</th>
										<th>Booking Date</th>
										<th>Total Passenger</th>
										<th>Status</th>
										<th>Total Amount</th>
                                        <th>Contacts</th>
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
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/sinord/list.jhtml'/]",
                type: "POST"
            },
            "columns": [
                { "data": "id","visible":false },
                { "data": "orderNo" },
                { "data": "tourCode" },
                { "data": "createDate" },
                { "data": "totalPeople" },
                { "data": "state",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return "NEW";
							case 2 : return "Composed";
							case 3 : return "Update";
							case 4 : return "Cancelling by client";
							case 5 : return "Cancelled";
							case 6 : return "Cacelling by Agent";
							default : return "";
					  	}
					}
                },
                { "data": "commonTourFee" },
                { "data": "contact" },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					if(row.state == 6){
						return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button">'
						+'<span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">'
						+'<li><a style="cursor:pointer;" href="customers.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Passenger Info</a></li>'
						+'<li><a style="cursor:pointer;" href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>'
						+'<li><a style="cursor:pointer;" href="editPayCost.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Income/Cost</a></li>'
						+'<li class="divider"></li><li><a style="cursor:pointer;" data-href="recoverOrder.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-recover"><i class="fa fa-reply-all"></i>Recover Booking</a></li></ul></div>';
					}else{
						return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button">'
						+'<span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">'
						+'<li><a style="cursor:pointer;" href="customers.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Passenger Info</a></li>'
						+'<li><a style="cursor:pointer;" href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>'
						+'<li><a style="cursor:pointer;" href="editPayCost.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Income/Cost</a></li>'
						+'<li class="divider"></li><li><a style="cursor:pointer;" data-href="cencelOrder.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Cancell Booking</a></li></ul></div>';
					}
                 },
				"targets" : 8
		  }]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
      	$('#confirm-recover').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $('#confirm-order').on('show.bs.modal', function (e) {
        	var tax=$("input[name='tax']:checked").val();
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href')+"?tex="+tax);
        });
    });
</script>
</body>
</html>
