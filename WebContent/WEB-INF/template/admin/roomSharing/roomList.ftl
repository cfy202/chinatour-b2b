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
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
	<div class="md-content">
		<div class="modal-header">
			<h3>Add</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/roomSharing/addRoom.jhtml'/]">
			<div class="modal-body form">
				<div class="text-center">
					<h4>Are you sure to confirm?</h4>
					<p>please type verify remarks below.</p>
					<div class="text-center"id="centerId">
						<textarea name="description" style="width:95%;height:60px"></textarea>
						<input type="hidden"  name="roomSharingId" id="roomSharingId"/>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal"  data-toggle="modal">Proceed</button>
				<div style="display:none;"><button type="button" id="btn" class="btn btn-primary btn-flat md-trigger" data-toggle="modal" data-modal="form-primary"></button></div>
			</div>
		</form>
	</div>
</div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Room Sharing Request</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New" onclick="location.href='add.jhtml?roomOrTour=1'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
                <li class="active">Room Sharing request</li>
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
											<span  class="nav-title">Gender</span>:
										</div>
										<div  class="block-body default-4-line">
											<div  class="params-cont"> 
												<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
													<span  class="unchecked"  name="sexSpan" checked="false" onclick="change(this,1);">Female</span> 
												</a>
												<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
													<span  class="unchecked" name="sexSpan" checked="false" onclick="change(this,2);" >Male</span> 
												</a> 
												<input type="hidden" id="sexSpan"/>
											</div>
										</div>
									</div>
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Status</span>:
										</div>
										<div  class="block-body default-4-line">
											<div  class="params-cont"> 
												<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
													<span  class="unchecked"  name="statuSpan" checked="false" onclick="change(this,0);">Pending</span> 
												</a>
												<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
													<span  class="unchecked" name="statuSpan" checked="false" onclick="change(this,1);" >Close</span> 
												</a> 
												<input type="hidden" id="statuSpan"/>
											</div>
										</div>
									</div>
									<div class="nav-block">
										<div class="block-head">
											<span class="nav-title">Arrival Time</span>:
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
											<span  class="nav-title">Search</span>:
										</div>
										<div  class="block-body default-2-line">
											<div  class="params-cont">
												<input type="text" size="14" id="search_productCode"  placeholder="Product Code..." />
												<input type="text" size="14" id="search_productName"  placeholder="Product Name..." />
												<input type="text" size="14" id="search_tourType"  placeholder="Tour Type..." />
												<input type="text" size="14" id="search_roomType"  placeholder="Room Type..." />
												<input type="text" size="14" id="search_agent"  placeholder="Agent..." />
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
                                        <th>Product Code</th>
                                        <th>Product Name</th>
                                        <th>Arrival Date</th>
                                        <th>Tour Type</th>
                                        <th>Gender</th>
                                        <th>Room Type</th>
                                        <th>Agent</th>
                                        <th>Status</th>
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
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/roomSharing/roomList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.productCode = $("#search_productCode").val();
					data.productName = $("#search_productName").val();
					data.tourType = $("#search_tourType").val();
					data.roomType = $("#search_roomType").val();
					data.userName = $("#search_agent").val();
					data.status = $("#statuSpan").val();
					data.sex = $("#sexSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
				}
            },
            "columns": [
         	    { "data": null },
				{ "data": "productCode" },
				{ "data": "productName" },
				{ "data": "arrivalDate" },
				{ "data": "tourType" },
				 { "data": "sex",
					"render" : function(data, type, row) {
					  	switch(data){
							case 1 : return "Female";
							case 2 : return "Male";
							default : return "";
					  	}
					}
                },
				{ "data": "roomType" },
				{ "data": "userName" },
				 { "data": "status",
					"render" : function(data, type, row) {
					  	switch(data){
							case 0 : return "<span class='color-warning'>Pending</span>";
							case 1 : return "<span class='color-danger'>Closed</span>";
							default : return "";
					  	}
					}
                },
				{ "data": "roomSharingId" }
            ],
			"columnDefs" : [ {
				"render" : function(data, type, row) {
					html = '<div class="btn-group">'
						+'<button class="btn btn-default btn-xs" type="button">Action</button>'
						+'<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
						+'<ul role="menu" class="dropdown-menu pull-right">';
						var id='[@shiro.principal property="id"/]';
						if(row.userId==id){
							html+='<li><a href="${base}/admin/roomSharing/edit?roomSharingId='+data+'&roomOrTour='+row.roomOrTour+'"><i class="fa fa-pencil"></i>Edit</a></li>';
						}
						html+='<li><a href="${base}/admin/roomSharing/view?roomSharingId='+data+'&roomOrTour='+row.roomOrTour+'"><i class="fa fa-pencil"></i>view</a></li>'
						+'</ul>'
						+'</div>';
					return html;
			     },
				"targets" : 9
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
            sOut += '<tr><td>Remark:</td><td>'+aData.remark+'</td></tr>';
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
			$('#datatable2').DataTable().draw();
		} );
		$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
			$("#search_endingDate").val('');
		});
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
    });
	function add(roomSharingId){
		$("#btn").trigger("click");
		$("#roomSharingId").val(roomSharingId);
	}
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
