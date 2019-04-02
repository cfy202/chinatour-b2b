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
            <h2>Phone Records</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Customer</a></li>
                <li class="active">Phone Records</li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-angle-down"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="padding:10px;">
								<div  class="nav-panel">
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Search</span>:
										</div>
										<div  class="block-body default-2-line">
											<div  class="params-cont">
												<input type="text" size="14" id="search_userName"  placeholder="Agent..." />
												<input type="text" size="14" id="search_deptName"  placeholder="Office..." />
												<input type="text" size="14" id="search_customerSource"  placeholder="Customer Source..." />
												<input type="text" size="14" id="search_consultContent"  placeholder="Keywords..." />
												<input type="text" size="14" id="search_lastName"  placeholder="Last Name..." />
												<input type="text" size="14" id="search_firstName"  placeholder="First Name..." />
												<input type="text" size="14" id="search_tel"  placeholder="Tel..." />
												
											</div>
										</div>
									</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Create Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="search_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
									</div>
								</div>
								<div  class="nav-panel">
										<div class="btn-cont">
											<input class="submit-btn"  type="submit" id="subId" value="Search">
										</div>
								</div>
							</div>
						</div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                    <tr>
                                     	<th></th>
                                        <th>Date</th>
                                        <th>Last Name</th>
                                        <th>Middle Name</th>
                                        <th>Last Name</th>
                                        <th>Tel</th>
                                        <th>Agent</th>
                                        <th>Office</th>
                                        <th>Source</th>
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
                url: "[@spring.url '/admin/customer/customerConsultlistForOffice.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.userName = $("#search_userName").val();
					data.deptName = $("#search_deptName").val();
					data.customerSource = $("#search_customerSource").val();
					data.consultContent = $("#search_consultContent").val();
					data.lastName = $("#search_lastName").val();
					data.middleName = $("#search_middleName").val();
					data.firstName = $("#search_firstName").val();
					data.tel = $("#search_tel").val();
				}
            },
            "columns": [
         	    { "data": null },
				{ "data": "createDate" },
				{ "data": "lastName" },
				{ "data": "middleName" },
				{ "data": "firstName" },
				{ "data": "tel" },
				{ "data": "userName" },
				{ "data": "deptName" },
				{ "data": "customerSource" },
				{ "data": "customerId" }
            ],
			"columnDefs" : [ {
				"render" : function(data, type, row) {
				 if(row.customerConsultId==null){
						return '';
				  }else{
				  	   return '<a href="editCustomerWithBasicInfo.jhtml?id='+data+'&isNew=1" style="cursor:pointer"><i class="fa fa-pencil"></i>Edit</a>';
				  }
			     },
				"targets" : 9
			}],
		    "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
		    	if(aData.customerConsultId==null){
         			$('td:eq(0)', nRow).html( '' );
         		}else{
         			$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
         		}
            },
            "fnRowCallback": function( nRow, aData, iDisplayIndex ) { 
				if(aData.customerConsultId==null){
					$('td:eq(1)', nRow).html("Total");
					total = aData.customerSource;
					$('td:eq(8)', nRow).html(total);
					$(nRow).attr("class","tfoot");
				}
			}
        });
         /* Formating function for row details*/
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td>Consult content:</td><td>'+aData.consultContent+'</td></tr>';
            sOut +='</td></tr>';
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
		
    });
    
    
     	$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
			$("#search_endingDate").val('');
		});
	
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
		$("#subId").on( 'click', function () {
			$('#datatable2').DataTable().draw();
		} );
</script>
</body>
</html>
