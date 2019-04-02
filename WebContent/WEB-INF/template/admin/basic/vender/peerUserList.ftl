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
            <h2>Supplier/Agencies</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="location.href='addPeerUser.jhtml?peerId=${peer.venderId}'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">New</li>
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
												<input type="hidden" id="search_peerId" value="${peer. venderId}"/>
												<input type="text" size="14" id="search_name"  placeholder="Search name..." />
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
                                  	<!-- <th>No.</th> -->
									<th>Agency UserName</th>
									<th>Agency</th>
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
        
         /* Formating function for row details */
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Address:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;"></td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">ZipCode:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;"></td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Email:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;"></td></tr>';
            sOut += '</table>';
            return sOut;
        }
         
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bautoWidth":true,
            "bSort":false,
            "bFilter":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/vender/peerUserList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.peerId = $("#search_peerId").val();
					data.name = $("#search_name").val();
				}
            },
           "columns": [
                { "data": null},
                { "data": "peerUserName" },
                { "data": "peerId", 
                	"render" : function(data, type, row) {
                		return '${peer.name}';
                	}
                },
                { "data": "peerUserId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					html='<div class="btn-group">'
						+'<button class="btn btn-default btn-xs" type="button">Action</button>'
						+'<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
						+'<ul role="menu" class="dropdown-menu pull-right">'
							+'<li><a href="${base}/admin/vender/editPeerUser?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li class="divider"></li>'
							+'<li><a data-href="${base}/admin/vender/delPeerUser?peerUserId='+data+'"data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li>'
						+'</ul>'
						+'</div>';
					return html;
                 },
				"targets" : 3
		    }],
		    "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
            }
        });
        
       $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });  
        
      $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
      $('.dataTables_length select').addClass('form-control');    
        
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
		var obj={
		 colorSpan:"",
		};
		function change(span,value)
		{
			//给所以span的属性初始化
		    $('span[name="'+$(span).attr('name')+'"]').each(function(){
		             if(this.checked&&this!=span)
		          {
		                this.className="unchecked";
		                this.checked=false;
		          }               
		    });
		    //判断是否有选中   是 初始化取消加粗   否加粗
		  	if(span.checked&&span.className=="checked"){
			    span.className="unchecked";
			    span.checked=false;
			    $("#"+$(span).attr('name')+"").val("");
			    $('#datatable2').DataTable().draw();
		  	}else{
		  		obj[$(span).attr('name')]=span.innerHTML;
			    span.className="checked";
			    span.checked=true;
			    $("#"+$(span).attr('name')+"").val(value);
			    $('#datatable2').DataTable().draw();
		  	}
		}
</script>
</body>
</html>
