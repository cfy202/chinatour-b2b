
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
            <h2>BooKing Settlement</h2>
            <div class="new"><button class="btn btn-success" type="button" data-toggle="modal" data-target="#mod-warning" >&nbsp;&nbsp;批量审核 &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Booking</a></li>
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
														<span  class="nav-title">Settlement Status</span>:
													</div>
													<div  class="block-body default-4-line">
														<div  class="params-cont"> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
																<span  class="unchecked"  name="taxSpan" checked="false" onclick="change(this,3);">Settling</span> 
															</a>
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,2);" >Settled</span> 
															</a> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,0);" >Unsettled</span> 
															</a> 
															<input type="hidden" id="taxSpan"/>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Revised Bill Settlement Status</span>:
													</div>
													<div  class="block-body default-4-line">
														<div  class="params-cont"> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
																<span  class="unchecked"  name="sprCheckSpan" checked="false" onclick="change(this,1);">Unsettled</span> 
															</a>
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="sprCheckSpan" checked="false" onclick="change(this,5);" >Settled</span> 
															</a> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="sprCheckSpan" checked="false" onclick="change(this,3);" >New(Agent)</span> 
															</a> 
															<input type="hidden" id="sprCheckSpan"/>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Others</span>:
													</div>
													<div  class="block-body default-2-line">
														<div  class="params-cont"> 
															<input type="text" size="14" id="search_orderNo" placeholder="orderNo..." />
															<input type="text" size="14" id="search_userName" placeholder="agent..." />
															<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
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
							<form action="[@spring.url '/admin/payCostRecords/checkOrderOfTourTax.jhtml'/]" id="checkFromId" method="post">
								<div class="table-responsive">
									<table class="table table-bordered" id="datatable2">
										<thead>
											<tr>
												<th></th>
												<th>Booking No.</th>
												<th>Booking Date </th>
												<th>Agent</th>
												<th>Tour Code</th>
												<th>Arrival Date </th>
												<th>Revised Status</th>
												<th><input id="check-all" type="checkbox" name="checkall" />Settlement Status</th>
												<th>Revised Settlement Status </th>
												<th>Action</th>
											</tr>
										</thead>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="mod-warning" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<div class="text-center">
					<div class="i-circle warning"><i class="fa fa-warning"></i></div>
					<h4>Warning !</h4>
					<p>Audit all selected bookings ?</p>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-warning" onclick="checkAllOrders();" data-dismiss="modal">OK</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
     $(document).ready(function () {
        //initialize the javascript
        App.init();
        $('.md-trigger').modalEffects();
        [@flash_message /]
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
      $('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	        radioClass: 'iradio_square-blue'
      });
        $("#datatable2").attr("width","100%");
         
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "autoWidth":true,
            "bFilter":false,
            "bSort":false,
            "ajax": {
                url: "[@spring.url '/admin/payCostRecords/findOrderTaxList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNo").val();
					data.tourCode = $("#search_tourCode").val();
					data.userName = $("#search_userName").val();
					data.tax = $("#taxSpan").val();
					data.sprCheck = $("#sprCheckSpan").val();
				}
            },
           "columns": [
                { "data": "id","visible":false},
                { "data": "orderNo" },
                { "data": "createDate" },
                { "data": "userName" },
                { "data": "tourCode" },
                { "data": "arriveDateTime" },
                { "data": "warnState",
					"render":function(data, type, row) {
						if(data == 0){
							return 'Don't Notice';
						}else if(data == 1){
							return 'Approved(Accountant)';
						}else if(data == 2){
							return 'Notice ';
						}else{
							return '';
						}
					}
				},
                { "data": "tax" },
                { "data": "sprCheck",
					"render":function(data, type, row) {
						if(data == 0){
							return 'New';
						}else if(data == 1){
							return 'Auditing Approved';
						}else if(data == 2){
							return 'Disapproved(Agent)';
						}else if(data == 3){
							return 'Approved(Accountant)';
						}else if(data == 4){
							return 'Disapproved(Accountant)';
						}else if(data == 5){
							return 'Revised Bill Settled ';
						}else{
							return '';
						}
					}
				},
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					var html='<a href="checkOrderOfTourPofit.jhtml?menuId=505&tourId='+row.tourId+'&userId='+row.userId+'">';
					if(row.tax==3){
						html+='<i class="fa fa-pencil"></i>Settlement';
					}else{
						html+='<i class="fa fa-eye"></i>View';
					}
					html+="</a>";
					return html;
                 },
				"targets" : 9
		  }],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		    	  var str='';
                 		if(aData.tax==3){
                 			str+='<div class="radio"><input type="checkbox"  name="orderIds" value="'+aData.id+'" class="icheck"/>Settling</div>';
                 		}else if(aData.tax==2 || aData.tax==4){
                 			str+='<input type="checkbox" class="icheck" disabled="disabled"/>Settled';
                 		}else if(aData.tax==0){
                 			str+='<input type="checkbox" class="icheck" disabled="disabled"/>Unsettled';
                 		}
		        $('td:eq(6)', nRow).html(str);
		    },
			"fnDrawCallback": function() {
				initAddHtml($("#datatable2"));
		    }
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
    //全选或不全选
    $("#check-all").on('ifChanged',function(){
        var checkboxes = $(".radio").find(':checkbox');
        if($(this).is(':checked')) {
            checkboxes.iCheck('check');
        } else {
            checkboxes.iCheck('uncheck');
        }
      });
	/* 初始化添加的元素  */
	function initAddHtml($addHtml){
		$addHtml.find('.icheck').iCheck({
			checkboxClass: 'icheckbox_square-blue checkbox',
			radioClass: 'iradio_square-blue'
		});
		return $addHtml;
	}
	
	function submitForm(){
		$("#formId").submit();
	}
	//批量结算
	function checkAllOrders(){
			var length = $(".icheck:checked").size();
			if(length == 0){
				alert("Select Booking");
				return;
			}
		$("#checkFromId").submit();
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
