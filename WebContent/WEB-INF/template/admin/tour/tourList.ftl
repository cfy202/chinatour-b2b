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

                    <p>Tour will be permanently deleted ?</p>
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
<!-- Modal -->
<div class="modal fade" id="confirm-upload" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	Upload File
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" enctype="multipart/form-data"   action="upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file"  placeholder="Upload File" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary" style="margin-left:206px;">Upload</button>
						</div>
					</div>
				</form>
			</div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
       <div class="page-head">
            <h2>Tour List</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-caret-square-o-down fa-lg color-blue"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="margin:10px; padding:5px 0;">
								<div  class="nav-panel">
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Guarantee Departure</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="departureSpan" checked="false" onclick="change(this,0);">Yes</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="departureSpan" checked="false" onclick="change(this,1);" >No</span> 
													</a> 
													<input type="hidden" id="departureSpan"/>
												</div>
											</div>
										</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Arrival Date：</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="search_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_lineName"  placeholder="lineName..." />
													<input type="text" size="14" id="search_op" value="${userName}" placeholder="op..." />
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
                                    	<th>NEW</th>
                                        <th>Tour Code</th>
                                        <th width="20%">Product Name</th>
                                        <th>Arrival Date</th>
                                        <th>Tour Type</th>
                                        <th>Guarantee Departure</th>
                                        <th>OP</th>
                                        <th>Total Passenger</th>
                                        <th width="13%">Tour Plan</th>
                                        <th width="10%">Action</th>
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
            "bSort":false,
            "bFilter":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/tour/tourList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.lineName = $("#search_lineName").val();
					data.userName = $("#search_op").val();
					data.code = $("#typeSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.isDeparture = $("#departureSpan").val();
				}
            },
            "columns": [
            	{ "data": "newState" ,
                   "render": function (data, type, row) {
                   		if(data==1){
	              			return "<a href='javascript:;' onclick='comvar(\""+ row.tourId +"\")'><font color='red'>NEW</font></a>";
	              		}else{
	              			return "";
	              		}
                    }
                },
                { "data": "tourCode" ,
                   "render": function (data, type, row) {
	              		return "<a href='exportCustomer.jhtml?menuId=402&tourId="+ row.tourId +"'>"+ data +"</a>";
                    }
                },
                { "data": "lineName" },
                { "data": "arriveDateTime" },
                { "data": "typeName" },
                 { "data": "isDeparture",
					"render" : function(data, type, row) {
						if(data==0){
							return 'Yes';
						}else{
							return 'No';
						}
					}
                },
                { "data": "userName" },
                { "data": "totalPeople",
                	 "render": function (data, type, row) {
                	 if(row.tourId!=null){
                	 	return "<a href='exportCustomer.jhtml?menuId=402&tourId="+ row.tourId +"'>"+ data +"</a>";
                	 }else{
                	 	return data;
                	 }
	              		
                    } 
                },
                { "data": "tourId" },
                { "data": "tourId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="edit.jhtml?menuId=402&id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li><a href="modifyOrders.jhtml?menuId=402&tourId='+ row.tourId +'"><i class="fa fa-pencil"></i>View Booking</a></li><li><a href="viewTourOptional.jhtml?menuId=402&tourId='+ row.tourId +'"><i class="fa fa-pencil"></i>Optional Excursion</a></li><li><a href="tourCustomerList.jhtml?menuId=402&tourId='+ data +'"><i class="fa fa-pencil"></i>Passenger Info</a></li><li><a href="neworderReview.jhtml?menuId=402&tourId='+ row.tourId +'&isChanged='+ row.isChanged +'"><i class="fa fa-pencil"></i>View Confirmation</a></li><li><a href="carList.jhtml?tourId='+ data +'"><i class="fa fa-pencil"></i>Car Management</a></li><li><a data-href="delete.jhtml?menuId=402&tourId='+ data +'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Cancelled Tour</a></li></div>';
                 },
				"targets" : 9
		  }],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		    	var str='<div><a data-href="${base}/admin/tour/upload?menuId=402&tourId='+aData.tourId+'" style="cursor: pointer;"  data-toggle="modal"  data-target="#confirm-upload"><i class="fa fa-upload"></i></a>';
		    	if(aData.tourQuoteUrl!=null&&aData.tourQuoteUrl.length>0){
		    		str+='<a href="${base}/admin/tour/download?id='+aData.tourId+'" ><i class="fa fa-download"></i></a>';
		    	}else{
		    		str+='<i class="fa fa-download"></i>';
	    		}
		    	  str+='</div>';
		        $('td:eq(8)', nRow).html(str);
		    },
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.tourId==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(1)', nRow).html("");
					$('td:eq(5)', nRow).html("");
					$('td:eq(8)', nRow).html("");
					$('td:eq(9)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			}
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
         $('#confirm-upload').on('show.bs.modal', function (e) {
            $(this).find('#formId').attr('action', $(e.relatedTarget).data('href'));
        });
        
        //$("div.options").hide();//默认隐藏 筛选 div
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-caret-square-o-up fa-lg color-blue"){
				_slide.removeClass("fa fa-caret-square-o-up fa-lg color-blue").addClass("fa fa-caret-square-o-down fa-lg color-blue");
			}else{
				_slide.removeClass("fa fa-caret-square-o-down fa-lg color-blue").addClass("fa fa-caret-square-o-up fa-lg color-blue");
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
		};
	$("#clearDate").click(function(){
		$("#search_beginningDate").val('');
		$("#search_endingDate").val('');
	});
	
	function comvar(tid){
		if (window.confirm("Are you sure to modify state ？")) {
            location.href="updateState.jhtml?tourId="+tid+"&type=tour";
        }
	}
	
	$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
	$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
</script>
</body>
</html>
