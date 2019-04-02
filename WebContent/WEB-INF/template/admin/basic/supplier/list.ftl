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
            <h2>Operators</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="location.href='add.jhtml'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Operators</li>
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
												<input type="text" size="14" id="search_supplierName"  placeholder="Search Name..." />
												<input type="text" size="14" id="search_supplierShortName" placeholder="Search ShortName..." />
												<input type="text" size="14" id="search_contactPerson" placeholder="Search contactPerson..." />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                  <tr>
                                  	<th>No.</th>
									<th>Name</th>
									<th>Abbr </th>
									<th>Tel </th>
									<th>Fax</th>
									<th>Contacts</th>
									<th>Mobile</th>
									<th>City</th>
									<th width="11%">Action</th>
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

                    <p> Data will be permanently deleted ?</p>
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
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
     $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
       
        $("#datatable2").attr("width","100%");
        
      function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td>Fax:</td><td>'+aData.email+'</td></tr>';
            sOut += '<tr><td>Address:</td><td>'+aData.address+'</td></tr>';
            sOut += '<tr><td>ZipCode:</td><td>'+aData.zipCode+'</td></tr>';
            sOut += '</table>';
            return sOut;
        }
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bautoWidth":true,
            "bFilter":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/supplier/list.jhtml'/]",
                type: "POST",
				"data": function ( data ) {
					data.supplierName = $("#search_supplierName").val();
					data.supplierShortName = $("#search_supplierShortName").val();
					data.contactPerson = $("#search_contactPerson").val();
				}
            },
           "columns": [
                { "data": "supplierId"},
                { "data": "supplierName" },
                { "data": "supplierShortName" },
                { "data": "tel" },
                { "data": "fax" },
                { "data": "contactPerson" },
                { "data": "mobile" },
                { "data": "city" },
                { "data": "supplierId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="${base}/admin/supplier/edit?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li class="divider"></li><li><a data-href="${base}/admin/supplier/del?id='+data+'"data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
                 },
				"targets" : 8
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
        } );
         
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
		
		$("input[id^='search_']").on( 'keyup blur change', function () {
			$('#datatable2').DataTable().draw();
		} );
});
</script>
</body>
</html>
