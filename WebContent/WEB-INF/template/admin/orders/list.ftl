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
            <h2>Booking Receivable</h2>
            <div class="new"></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Booking</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
    			<div class="col-md-12">
    			<div class="tab-container">
						<ul class="nav nav-tabs">
						  <li class="active"><a href="javascript:void(0);" onclick="local('payCostList.jhtml')" data-toggle="tab">Income</a></li>
						  <li><a href="javascript:void(0);" onclick="local('payList.jhtml')" data-toggle="tab">Cost</a></li>
						</ul>
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
														<span  class="nav-title">Auditing Status</span>:
													</div>
													<div  class="block-body default-4-line">
														<div  class="params-cont"> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
																<span  class="unchecked"  name="statusSpan" checked="false" onclick="change(this,0);">New</span> 
															</a>
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,1);" >Approved</span> 
															</a> 
															<input type="hidden" id="statusSpan"/>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Others</span>:
													</div>
													<div  class="block-body default-2-line">
														<div  class="params-cont"> 
															<input type="text" size="14" id="search_orderNo" placeholder="orderNo..." [#if pay.orderNo??]value="${pay.orderNo}"[/#if]/>
															<input type="text" size="14" id="search_userName" placeholder="agent..." [#if pay.userName??]value="${pay.userName}"[/#if] />
															<input type="text" size="14" id="search_sum" placeholder="sum..." [#if pay.sum??]value="${pay.sum}"[/#if] />
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
					                          		<th></th>
													<th>Booking No.</th>
													<th>Tour Code</th>
													<th>Arrival Date</th>
													<th>agent</th>
													<th><!--Revenue/Expenditure-->Time</th>
													<th><!--Revenue/Expenditure-->Amount</th>
													<th>Auditing Status</th>
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
</div>


<!-- Modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
	<div class="md-content">
		<div class="modal-header">
			<h3>Booking Income Auditing</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/payCostRecords/edit.jhtml'/]">
			<div class="modal-body form">
				<div class="row no-margin-y">
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Income Type:<input type="name" class="form-control"  id="itemId">
					</div>
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Description:<input type="name" class="form-control" id="remarkId">
					</div>
				</div>
				<div class="row no-margin-y">
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Amount:<input type="name" class="form-control" id="sumId">
					</div>
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Payment Method:<input type="name" class="form-control" id="wayId">
					</div>
				</div>
				<div class="text-center">
					<h4>Are you sure to confirm?</h4>
					<p>please type verify remarks below.</p>
					<div class="text-center"id="centerId">
						<textarea name="confirmRemark" style="width:95%;height:60px"></textarea>
						<input type="hidden" value="504" name="munId"/>
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
<div class="modal fade" id="mod-warning" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<form method="post" action="[@spring.url '/admin/payCostRecords/edit.jhtml'/]">
				<div class="modal-body">
					<div class="text-center">
						<div class="i-circle warning"><i class="fa fa-warning"></i></div>
						<h4>Are you sure to confirm?</h4>
						<p>please type verify remarks below.</p>
						<div class="text-center"id="fromCentId">
							<textarea name="confirmRemark" style="width:95%;height:60px"></textarea>
							<input type="hidden" value="504" name="munId"/>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Regect</button>
					<button type="submit" class="btn btn-warning">Confirm</button>
					<div style="display:none;"><button type="button" id="butwar" data-toggle="modal" data-target="#mod-warning"></button></div>
				</div>
			</form>
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
         
           function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Payment Description:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.item+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Payment Method:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.way+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Remark:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.remark+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Auditing. Remark:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.confirmRemark+'</td></tr>';
            sOut += '</table>';
            return sOut;
        }
        
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "autoWidth":true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/orders/payCostList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNo").val();
					data.userName = $("#search_userName").val();
					data.status = $("#statusSpan").val();
					data.sum = $("#search_sum").val();
				}
            },
           "columns": [
                { "data":null},
                { "data": "id","visible":false},
                { "data": "orderNo" },
                { "data": "tourCode" },
                { "data": "scheduleOfArriveTime" },
                { "data": "userName" },
                { "data": "time" },
                { "data": "sum" },
                { "data": "status" }
            ],
            "columnDefs" : [ {
				"targets" : 8
		  }],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		 		 $('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' ); 
		    	  var str='';
                 		if(aData.status==0){
                 			str+='<i class="fa fa-eye"></i>';
                 		}else{
                 			str+='<i class="fa fa-check"></i>';
                 		}
		        $('td:eq(7)', nRow).html(str);
		    },
			"fnDrawCallback": function() {
				initAddHtml($("#datatable2"));
		    }
        });
        
         $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
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
      
	function confirmUp(data){
		$.ajax({
			   type: "POST",
			   url: "find.jhtml",
	           data:"id="+data,
			   success: function(msg){	
			   		var obj=eval(msg);
						$("#itemId").val(obj['item']);
						$("#sumId").val(obj['sum']);
						$("#remarkId").val(obj['remark']);
						$("#wayId").val(obj['way']);
						$('input[name="recordString"]').remove();//删除旧数据
						$('input[name="orderNo"]').remove();//删除旧数据
						$('input[name="tourCode"]').remove();//删除旧数据
						$('input[name="userName"]').remove();//删除旧数据
						$('input[name="status"]').remove();//删除旧数据
						$('input[name="sum"]').remove();//删除旧数据
						$("#centerId").append('<input type="hidden" value="'+data+'" name="recordString"/>');
						var orderNo = $("#search_orderNo").val();
						var tourCode = $("#search_tourCode").val();
						var userName = $("#search_userName").val();
						var status = $("#statusSpan").val();
						var sum = $("#search_sum").val();
						$("#centerId").append('<input type="hidden" value="'+orderNo+'" name="orderNo"/>');
						$("#centerId").append('<input type="hidden" value="'+tourCode+'" name="tourCode"/>');
						$("#centerId").append('<input type="hidden" value="'+userName+'" name="userName"/>');
						$("#centerId").append('<input type="hidden" value="'+status+'" name="status"/>');
						$("#centerId").append('<input type="hidden" value="'+sum+'" name="sum"/>');
						$("#btn").trigger("click");
						
			   }
			}); 
	}
	//循环选中值 放进表单
	function chbox(){
		var length = $(".icheck:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}
		$('input[name="recordsId"]').remove();//删除旧数据
		$('input[name="orderNo"]').remove();//删除旧数据
		$('input[name="tourCode"]').remove();//删除旧数据
		$('input[name="userName"]').remove();//删除旧数据
		$('input[name="status"]').remove();//删除旧数据
		$('input[name="sum"]').remove();//删除旧数据
		$('input[name="records"]:checked').each(function(){
            var sfruit=$(this).val();
        	$("#fromCentId").append('<input type="hidden" value="'+sfruit+'" name="recordsId"/>');
        });
        var orderNo = $("#search_orderNo").val();
		var tourCode = $("#search_tourCode").val();
		var userName = $("#search_userName").val();
		var status = $("#statusSpan").val();
		var sum = $("#search_sum").val();
		$("#fromCentId").append('<input type="hidden" value="'+orderNo+'" name="orderNo"/>');
		$("#fromCentId").append('<input type="hidden" value="'+tourCode+'" name="tourCode"/>');
		$("#fromCentId").append('<input type="hidden" value="'+userName+'" name="userName"/>');
		$("#fromCentId").append('<input type="hidden" value="'+status+'" name="status"/>');
		$("#fromCentId").append('<input type="hidden" value="'+sum+'" name="sum"/>');
        $("#butwar").trigger("click");
	}
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
		function local(value){
			var orderNo = $("#search_orderNo").val();
			var tourCode = $("#search_tourCode").val();
			var userName = $("#search_userName").val();
			var status = $("#statusSpan").val();
			var sum = $("#search_sum").val();
			window.location.href=value+"?orderNo="+orderNo+"&tourCode="+tourCode+"&userName="+userName+"&status="+status+"&sum="+sum;
		}
</script>
</body>
</html>
