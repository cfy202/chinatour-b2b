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
            <h2>Drafts</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Inquiry</a></li>
                <li class="active">Drafts</li>
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
							<div class="options" style="margin:10px; padding:5px 0;">
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="enSpan" checked="false" onclick="change(this,0);">NEW </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="enSpan" checked="false" onclick="change(this,1);" >Processed</span> 
													</a> 
													<input type="hidden" id="enSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Other</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_enquiryNo" placeholder="enquiryNo..." />
													<input type="text" size="14" id="search_lastName" placeholder="lastName..." />
													<input type="text" size="14" id="search_firstName" placeholder="firstName..." />
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
											<th>No.</th>
											<th>Time</th>
											<th>LastName</th>
											<th>FirstName</th>
											<th>Agent</th>
											<th>Office</th>
											<th>Status</th>
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
            "autoWidth":true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/enquirys/draftList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.enquiryNo = $("#search_enquiryNo").val();
					data.lastName = $("#search_lastName").val();
					data.firstName = $("#search_firstName").val();
					data.enState = $("#enSpan").val();
				}
            },
           "columns": [
                { "data": "enquiryId","visible":false},
                { "data": "enquiryNo" },
                { "data": "createDate" },
                { "data": "lastName" },
                { "data": "firstName" },
                { "data": "admin",
					"render" : function(data, type, row) {
					  	if(data!=null){
					  		return data.username;
					  	}else{
					  		return "";
					  	}
					
					}
                },
                { "data": "dept",
					"render" : function(data, type, row) {
					  	if(data!=null){
					  		return data.deptName;
					  	}else{
					  		return "";
					  	}
					
					}
                },
               	{ "data": "enState",
					"render" : function(data, type, row) {
					  	switch(data){
							case 0 : return "NEW";
							case 1 : return "Processed";
							default : return "";
					  	}
					}
                },
                { "data": "enquiryId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group">'
								+'<button class="btn btn-default btn-xs" type="button">Action</button>'
								+'<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button">'
									+'<span class="caret"></span><span class="sr-only">Toggle Dropdown</span>'
								+'</button>'
								+'<ul role="menu" class="dropdown-menu pull-right">'
									+'<li><a href="${base}/admin/enquirys/edit?temp=1&id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>'
									+'<li class="divider"></li>'
									+'<li><a data-href="${base}/admin/enquirys/del?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li>'
								+'</ul>'
							+'</div>';
                 },
				"targets" : 8
		  }]
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
		
		$("#subId").on( 'click', function () {
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
		  	}else{
		  		obj[$(span).attr('name')]=span.innerHTML;
			    span.className="checked";
			    span.checked=true;
			    $("#"+$(span).attr('name')+"").val(value);
		  	}
		}
</script>
</body>
</html>
