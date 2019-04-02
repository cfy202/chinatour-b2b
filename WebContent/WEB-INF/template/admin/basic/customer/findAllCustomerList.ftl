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
            <h2>Customer</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Customers</a></li>
                <li class="active">Customers</li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                    <tr>
                                     	<th></th>
                                        <th>LastName</th>
                                        <th>MiddleName</th>
                                        <th>FristName</th>
                                        <th>Pax No.</th>
                                        <th>Add</th>
                                        <th>Tel</th>
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
            "bFilter":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/customer/findAllCustomerList.jhtml?customerInfo=${customerInfo}'/]",
                type: "POST",
                "data": function ( data ) {
					data.customerCode = $("#search_customerCode").val();
					data.lastName = $("#search_lastName").val();
					data.middleName = $("#search_middleName").val();
					data.firstName = $("#search_firstName").val();
					data.passportNo = $("#search_passportNo").val();
					data.brand = $("#search_brand").val();
					data.beginDateForBook = $("#search_beginningDate").val();
					data.endDateForBook = $("#search_endingDate").val();
				}
            },
            "columns": [
         	    { "data": null },
				{ "data": "lastName" },
				{ "data": "middleName" },
				{ "data": "firstName" },
				{ "data": "passportNo" },
				{ "data": "streetAddress" },
				{ "data": "tel" },
				{ "data": "customerId" }
            ],
			"columnDefs" : [ {
				"render" : function(data, type, row) {
					html = '<a href="${base}/admin/customer/editCustomerWithBasicInfo?id='+data+'&isNew=1"><i class="fa fa-pencil"></i>Edit</a>'
					return html;
			     },
				"targets" : 7
			}],
		    "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
            }
        });
         /* Formating function for row details*/
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td>Remark:</td><td>'+aData.memoOfCustomer+'</td></tr>';
            sOut += '<tr><td>Nationality:</td><td>'+aData.nationalityOfPassport+'</td></tr>';
            sOut += '<tr><td>Passport No.:</td><td>'+aData.passportNo+'</td></tr>';
            sOut += '<tr><td>Date of Birth:</td><td>'+aData.dateOfBirth+'</td></tr>';
            if(aData.sex==1){
             sOut += '<tr><td>Gender:</td><td>Female</td></tr>';
            }else{
             sOut += '<tr><td>Gender:</td><td>Male</td></tr>';
            }
            sOut += '<tr><td>Expiry Date:</td><td>'+aData.expireDateOfPassport+'</td></tr>';
            sOut += '<tr><td>Email:</td><td>'+aData.email+'</td></tr>';
            sOut += '<tr><td>Language:</td><td>';
            if(aData.language!=null){
           		sOut += aData.language.language
            }
            sOut +='</td></tr>';
            if(aData.customerSource==1){
           		sOut += '<tr><td>Related Booking:</td><td>Join-in Tour</td></tr>';
            }else if(aData.customerSource==2){
             	sOut += '<tr><td>Related Booking:</td><td>Hotel Booking</td></tr>';
            }else if(aData.customerSource==3){
             	sOut += '<tr><td>Related Booking:</td><td>Flight</td></tr>';
            }
            if(aData.planticket==1){
            	sOut += '<tr><td>Flight Booking:</td><td>Booked by OP</td></tr>';
            }else if(aData.planticket==2){
             	sOut += '<tr><td>Flight Booking:</td><td>Hotel/Flight/Cruise Booking</td></tr>';
            }else if(aData.planticket==3){
             	sOut += '<tr><td>Flight Booking:</td><td>Booked by both Op & Agent</td></tr>';
            }
            if(aData.advertised==1){
             	sOut += '<tr><td> Notification Status:</td><td>Yes</td></tr>';
            }else{
             	sOut += '<tr><td> Notification Status:</td><td>No</td></tr>';
            }
            sOut += '<tr><td>Remark:</td><td>'+aData.payHistoryInfo+'</td></tr>';
            sOut += '</table>';
            return sOut;
        } 
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
        
        $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
		$('.dataTables_length select').addClass('form-control');
		
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
       $("div.options").hide();//默认隐藏 筛选 div
		
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-angle-up"){
				_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
			}
		});
		
		$("#subId").on( 'click', function () {
			$("#customerCodeForExport").attr("value",$("#search_customerCode").val());
			$("#lastNameForExport").attr("value",$("#search_lastName").val());
			$("#middleNameForExport").attr("value",$("#search_middleName").val());
			$("#firstNameForExport").attr("value",$("#search_firstName").val());
			$("#passportNoForExport").attr("value",$("#search_passportNo").val());
			$("#brand").attr("value",$("#search_brand").val());
			$("#beginDateForBook").attr("value",$("#search_beginningDate").val());
			$("#endDateForBook").attr("value",$("#search_endingDate").val());
			$('#datatable2').DataTable().draw();
		} );
    });
    
    $("#export").click(function(){
    	$("#exportCustomnerForm").submit();
    });
    
     	$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
			$("#search_endingDate").val('');
		});
	
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
</script>
</body>
</html>
