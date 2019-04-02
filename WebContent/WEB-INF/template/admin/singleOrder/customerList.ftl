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
                    <p>Are you sure your want to cancel the traveller's info ？</p>
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
                    <h4><i class="fa fa-warning"></i> Warning !</h4>
                    <p>Are you sure your want to recover the traveller's info ？</p>
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
    <div class="container-fluid" id="pcont">
       <div class="page-head">
            <h3>Booking List</h3>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="addCustomer();">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
           <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking</a></li>
                <li><a style="cursor:pointer;" href="list">Other Booking</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>Passenger Info</h3>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                            	<form action="#" method="post">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
		                                    	<th></th>
		                                        <th>Del</th>
		                                        <th>LastName</th>
		                                        <th>FirstName</th>
		                                        <th>MiddleName</th>
		                                        <th>Nationality</th>
		                                        <th>Passport No.</th>
		                                        <th>Expiry Date</th>
		                                        <th>Gender</th>
		                                        <th>Remark</th>
		                                        <th>Language</th>
		                                        <th>Date of Birth</th>
		                                        <th>Action</th>
		                                    </tr>
	                                    </thead>
	                                </table>
                                </form>
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
        
        /* Formating function for row details */
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Remark:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.payHistoryInfo+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Language:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.language.language+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Date of Birth:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.dateOfBirth+'</td></tr>';
            sOut += '</table>';
            return sOut;
        }
       
       $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/orders/customerList.jhtml?orderId=' + orderId/]",
                type: "POST"
                
            },
            "columns": [
            	{ "data": null },
                { "data": "isDel", 
                  "render": function (data, type, row) {
                  	  if(data == 0){
                  	  	return "";
                  	  }else if(data == 1){
                  	  	return "Cancelled";
                  	  }else{
                  	  	return "Cancelling";
                  	  }
                   }	
                }, 
                { "data": "lastName" },
                { "data": "firstName" },
                { "data": "middleName" },
                { "data": "nationalityOfPassport"},
                { "data": "passportNo" },
                { "data": "expireDateOfPassport" },
                { "data": "sex",
                  "render": function (data, type, row) {
                  	  if(data == 1){
                  	  	return "Female";
                  	  }else if(data == 2){
                  	  	return "Male";
                  	  }
                   }	
                },
                { "data": "payHistoryInfo","visible":false },
                { "data": "language.language","visible":false},
                { "data": "dateOfBirth","visible":false},
                { "data": "customerId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					if(row.isDel == 0){
						return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button>'
						+'<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
						+'<ul role="menu" class="dropdown-menu pull-right">'
						+'<li><a style="cursor:pointer;" data-href="cancelCustomer.jhtml?customerId='+data+'&orderId=${orderId}" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Cancell Traveller</a>'
						+'</li></ul></div>';
					}
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button>'
					+'<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
					+'<ul role="menu" class="dropdown-menu pull-right">'
					+'<li><a style="cursor:pointer;" data-href="recoverCustomer.jhtml?customerId='+data+'&orderId=${orderId}" data-toggle="modal" data-target="#confirm-recover"><i class="fa fa-reply-all"></i>Recover Traveller</a>'
					+'</li></ul></div>';
                 },
				"targets" : 12
			}],
			"fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
            }
        });
        
        $('#datatable2').delegate('tbody td img','click', function () {
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
                oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
            }
        });
        
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $('#confirm-recover').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
    });
    
    function addCustomer() {
    	window.location.href="addCustomer.jhtml?orderId=${orderId}"; 
    }
</script>
</body>
</html>
