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
            <h2>News</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="location.href='add.jhtml'">&nbsp;&nbsp;New &nbsp;&nbsp;</button><a href="[@spring.url '/admin/weblogout.jsp'/]">&nbsp;&nbsp;同行首页 &nbsp;&nbsp;</a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">News</li>
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
								        	<input type="text" size="14" id="search_title"  placeholder="Title..." />
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
                                        <th width="20%">Title</th>
                                        <th width="40%">Image</th>
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
                url: "[@spring.url '/admin/news/list.jhtml'/]",
                type: "POST",
                "data": function ( d ) {
            		d.title = $("#search_title").val();
            	}
            },
            
            "columns": [
                { "data": "title" },
                { "data": "image" ,
                	"render" : function(data, type, row) {
					  	
					  	return '<img class="newsImage" src="[@spring.url'\'+data+\''/]"  width="60" height="60"/>';
					  	
					  	
					  	//<img src="[@spring.url '${groupLine.image}'/]">
					}
					},
                { "data": "newsId" }
                
                
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-default dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li></ul></div>';
					/*<li><a data-href="del.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li>*/
                 },
				"targets" : 2
		  	}]
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
		
		
		$("input[id^='search_']").on( 'keyup blur change', function () {
        	$('#datatable2').DataTable().draw();
    	} );
    });
    
</script>
</body>
</html>
