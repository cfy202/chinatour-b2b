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
                    <h4><i class="fa fa-warning"></i> Warning!</h4>

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
             <h2>Bill Audit(Agent)</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accountion</a></li>
            </ol>
        </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="tab-container">
							<ul class="nav nav-tabs">
							  <li  class="active"><a href="javascript:;" onclick="javascript:window.location.href='agentTourList.jhtml'" data-toggle="tab">Common Tour</a></li>
							  <!--<li><a href="javascript:;" onclick="javascript:window.location.href='approveForAgent.jhtml'" data-toggle="tab">Europe Tour&nbsp;&nbsp;&nbsp;<span class="bubble">${sumForAgent}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>-->
							</ul>
                        </div>
					<div class="tab-content block-flat">
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
														<span  class="unchecked"  name="allSpan" checked="false" onclick="change(this,0);">With Unaudited</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="allSpan" checked="false" onclick="change(this,1);" >All Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="allSpan" checked="false" onclick="change(this,2);">With Disapproved</span> 
													</a>
													<input type="hidden" id="allSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Auditing Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="agentSpan" checked="false" onclick="change(this,0);">New </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="agentSpan" checked="false" onclick="change(this,1);" >Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="agentSpan" checked="false" onclick="change(this,2);">DisApproved </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="agentSpan" checked="false" onclick="change(this,3);">Revise Auditing </span> 
													</a>
													<input type="hidden" id="agentSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Accountant Auditing Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="accSpan" checked="false" onclick="change(this,0);">New </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="accSpan" checked="false" onclick="change(this,1);" >Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="accSpan" checked="false" onclick="change(this,2);">DisApproved</span> 
													</a>
													<input type="hidden" id="accSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Revised Bill Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,1);">Auditing Approved </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="sprSpan" checked="false" onclick="change(this,2);" >Disapproved(Agent)</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,3);">Approved(Accountant) </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,4);">Disapproved(Accountant)</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,5);">Revised Bill Settled </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,0);">New</span> 
													</a>
													<input type="hidden" id="sprSpan"/>
												</div>
											</div>
										</div>
									</div>
									<div class="nav-block">
										<div class="block-head">
											<span class="nav-title">Arrival Date</span>:
										</div>
										<div class="block-body default-4-line pull-cursor">
											<div class="params-cont">
												<input type="text" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
												<input type="text" id="search_endingDate" size="14"  placeholder="Ending Date." />
												&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
											</div>
										</div>
									</div>
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_lineName" placeholder="lineName..." />
													<input type="text" size="14" id="search_userName" placeholder="op..." />
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
											<th><input id="check-all" type="checkbox" name="checkall" /></th>
											<th>Tour Code</th>
											<th>Product Name</th>
											<th>Arrival Date</th>
											<!--<th>Tour Type</th>-->
											<th>Status</th>
											<th>op</th>
											<th>Auditing Status</th>
											<th>Acc. Status</th>
											<th>Revised Status</th>
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
		$('input').iCheck({
			checkboxClass: 'icheckbox_square-blue checkbox',
			radioClass: 'iradio_square-blue'
		});
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
                url: "[@spring.url '/admin/supplierPrice/agentTourList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.lineName = $("#search_lineName").val();
					data.userName = $("#search_userName").val();
					data.checkOfAgent = $("#agentSpan").val();
					data.accCheck = $("#accSpan").val();
					data.sprCheck = $("#sprSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.allCheck = $("#allSpan").val();
				}
                
            },
            
            "columns": [
                { "data": "supplierPriceId"},
                { "data": "tourCode" },  
                { "data": "lineName" },
                { "data": "arriveDateTime" },
                /*{ "data": "typeName" },*/
                { "data": "allCheck" ,
                	"render": function (data, type, row) {
                		var html="";
                		if(data==2){
                			html="With Disapproved";
                		}else if(data==0){
                			html="With Unaudited";
                		}else if(data==1){
                			html="All Approved";
                		}
	              			return html;
                    }
                },
                { "data": "userName" },
				{ "data": "checkOfAgent",
					"render":function(data, type, row) {
						if(data == 1){
							return 'Approved';
						}else if(data == 2){
							return 'Disapproved';
						}else{
							return 'New';
						}
					}
				},
                { "data": "accCheck",
					"render":function(data, type, row) {
						if(data == 1){
							return 'Approved';
						}else if(data == 2){
							return 'Diaapproved';
						}else if(data == 3){
							return 'Revise Auditing';
						}else{
							return 'New';
						}
					}
				},
                { "data": "sprCheck",
					"render":function(data, type, row) {
						if(data == 0){
							return 'New';
						}else if(data == 1){
							return 'Auditing Approved';
						}else if(data == 2){
							return 'Disapproved(Agent)';
						}else if(data == 3){
							return 'Approved(Accountant)';
						}else if(data == 4){
							return 'Disapproved(Accountant)';
						}else if(data == 5){
							return 'Revised Bill Settled';
						}else{
							return '';
						}
					}
				},
                { "data": "supplierPriceId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="agentOrderCheck.jhtml?tourId='+row.tourId+'&tourCode='+row.tourCode+'"><i class="fa fa-pencil"></i>Auditing</a></li><li class="divider"></li><li><a data-href="del.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
                 },
				"targets" : 9
		  }],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		    	var str='';
				if(aData.checkOfAgent!=1&&aData.accCheck==1){
					str+='<div class="item"><input type="checkbox"  name="records" value="'+aData.id+'" class="icheck"/></div>';
				}else{
					str+='<input type="checkbox"  name="records" value="'+aData.id+'" class="icheck" disabled="disabled"/>';
				}
		        $('td:eq(0)', nRow).html(str);
		    },
			"fnDrawCallback": function() {
				initAddHtml($("#datatable2"));
		    }
        });
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
		
		//全选或不全选
		$("#check-all").on('ifChanged',function(){
			var checkboxes = $(".item").find(':checkbox');
				if($(this).is(':checked')) {
					checkboxes.iCheck('check');
				} else {
					checkboxes.iCheck('uncheck');
				}
			});
		});
		/* 初始化添加的元素  */
		function initAddHtml($addHtml){
			$addHtml.find('.icheck').iCheck({
				checkboxClass: 'icheckbox_square-blue checkbox',
				radioClass: 'iradio_square-blue'
			});
			return $addHtml;
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
		
		$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
 			$("#search_endingDate").val('');
		});
		
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
</script>
</body>
</html>
