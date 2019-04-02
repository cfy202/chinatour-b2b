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
            <h2>Training</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="location.href='add.jhtml'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Training</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>Row Details</h3>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                  <tr>
                                  	<th></th>
                                  	<th>Folder Name </th>
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
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning!</h4>

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
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bautoWidth":true,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/shareSpace/list.jhtml'/]",
                type: "POST"
            },
           "columns": [
                { "data": null,"visible":false},
                { "data": "typeName" },
                { "data": "shareTypeId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="${base}/admin/shareSpace/edit?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li><a href="${base}/admin/shareSpace/shareSpaceList?shareTypeId='+data+'"><i class="fa fa-search"></i>View</a></li><li class="divider"></li></ul></div>';
                 },
				"targets" : 2
		    }]
        });
        
       $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });  
        
      $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
      $('.dataTables_length select').addClass('form-control');    
        
    });
</script>
</body>
</html>
