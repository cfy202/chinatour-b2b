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
            <h2>Product</h2>
            <div class="new">
            	<button class="btn btn-success" type="button" id="New" onclick="location.href='addforAdmin.jhtml'">&nbsp;&nbsp;New &nbsp;&nbsp;</button>
            </div>
            [#if size!=0]
            <div class="new">
            	<button class="btn btn-success" type="button" id="New" onclick="location.href='webList.jhtml'">&nbsp;&nbsp;New Product&nbsp;&nbsp;<font color="red">${size}</font></button>
            </div>
            [/#if]
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Product</li>
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
								        	<input type="text" size="14" id="search_tourCode"  placeholder="Product Code..." />
								            <input type="text" size="14" id="search_tourName" placeholder="Product Name..." />
								            <input type="text" size="14" id="search_source"  placeholder="Provider..." />
								            <input type="text" size="14" id="search_tourNo"  placeholder="Provider Code..." />
								            <input type="text" size="14" id="search_brand" placeholder="Brand..." />
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
                                    	<th></th>
                                        <th width="15%">Product Code</th>
                                        <th width="25%">Product Name</th>
                                        <th width="15%">Provider</th>
                                        <th width="20%">Provider Code</th>
                                        <th width="10%">Brand</th>
                                        <th>Product Description</th>
                                        <!-- <th>Status</th> -->
                                        <th width="15%" style="color:#FF8C00;">Action</th>
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
        
         function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var specificItems = aData.specificItems;
           
            if(specificItems==null){
            	specificItems = "";
            }
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-bottom: 1px solid #dadada;width:10%;">SpecificItems:</td><td style="border-bottom: 1px solid #dadada;">'+specificItems+'</td></tr>';
            sOut += '</table>';
            return sOut;
        };
        
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
                url: "[@spring.url '/admin/groupline/list.jhtml'/]",
                type: "POST",
                "data": function ( d ) {
	                d.tourCode = $("#search_tourCode").val();
	                d.tourName = $("#search_tourName").val();
	                d.brand = $("#search_brand").val();
	                d.isSystem =5;
	                d.source = $("#search_source").val();
	                d.tourNo = $("#search_tourNo").val();
            	}
            },
            
            "columns": [
            	{ "data": "id"},
                { "data": "tourCode" },
                { "data": "tourName" },
                { "data": "source" },
                { "data": "tourNo" },
                { "data": "brand" },
                { "data": "tripDesc","visible":false},
                /*
                { "data": "isAvailable" ,"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'Yes';
					  		case 1 : return 'No';
					  	}
					}},*/
                { "data": "id" }
                
                
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-default dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="editforAdmin.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li><a href="setGroupRoute.jhtml?groupLineId='+data+'"><i class="fa fa-pencil"></i>Itinerary</a></li><li><a href="setHotel.jhtml?groupLineId='+data+'"><i class="fa fa-pencil"></i>Hotel</a></li><li><a href="toFdf.jhtml?groupLineId='+data+'"><i class="fa fa-eye"  data-toggle="modal" data-modal="form-primary" ></i>View</a></li><li><a data-href="del.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
                 },
				"targets" : 7
		  	}],
		  	"fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
           }
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $("div.options").hide();
        <!--默认隐藏div，或者在样式表中添加.text{display:none}，推荐使用后者-->
		
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-angle-up"){
				_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
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
		
		$("input[id^='search_']").on( 'keyup blur change', function () {
        	$('#datatable2').DataTable().draw();
    	} );
    });
</script>
</body>
</html>
