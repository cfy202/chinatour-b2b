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
            <h2>Booking Cost</h2>
            <div class="new" style="width:300px">
            	<a id="btnPrint" href='javascript:printOrder();' class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
            	<a href='javascript:chbox();' class="btn btn-success" >&nbsp;&nbsp;Bunk Audit &nbsp;&nbsp;</a>
            </div>
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
							<li><a href="javascript:void(0);" onclick="local('list.jhtml')" data-toggle="tab">Income</a></li>
							<li class="active"><a href="javascript:void(0);" onclick="local('payList.jhtml')" data-toggle="tab">Cost</a></li>
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
												<div class="nav-block">
													<div class="block-head">
														<span class="nav-title">Due Time</span>:
													</div>
													<div class="block-body default-4-line pull-cursor">
														<div class="params-cont">
															<input type="text" id="search_beginningTime" size="14"  placeholder="Beginning Date." />
															<input type="text" id="search_endingTime" size="14"  placeholder="Ending Date." />
															&nbsp;<i id="clearTime" class="fa fa-rotate-left" title="Clear Date"></i>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Others</span>:
													</div>
													<div  class="block-body default-2-line">
														<div  class="params-cont"> 
															<input type="text" size="12" id="search_orderNo" placeholder="Order No." [#if pay.orderNo??]value="${pay.orderNo}"[/#if]/>
															<input type="text" size="12" id="search_tourCode" placeholder="TourCode" [#if pay.tourCode??]value="${pay.tourCode}"[/#if]/>
															<input type="text" size="12" id="search_userName" placeholder="Agent" [#if pay.userName??]value="${pay.userName}"[/#if] />
															<input type="text" size="12" id="search_sum" placeholder="Amount" [#if pay.sum??]value="${pay.sum}"[/#if] />
															<input type="text" size="12" id="search_remark" placeholder="Remark" [#if pay.remark??]value="${pay.remark}"[/#if] />
															<input type="text" size="12" id="search_vender" placeholder="Supplier" [#if pay.venderString??]value="${pay.venderString}"[/#if] />
															<input type="text" size="12" id="search_invoiceNo" placeholder="Reference No." [#if pay.code??]value="${p.code}"[/#if] />
															<input type="text" size="12" id="search_item" placeholder="Payment" [#if pay.item??]value="${pay.item}"[/#if] />
															<select type="text" id="search_way" >
																<option value="">Method</option>
																[#list constant.COST_WAYS as val]
																	<option value="${val}">${val}</option>
																[/#list]
										                 	</select>
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
													<th>No.</th>
													<th>Tour Code</th>
													<th>Arrival Date</th>
													<th>Agent</th>
													<th>Reference No.</th>
													<th>Supplier</th>
													<th>CreateDate</th>
													<th>Amount</th>
													<th><input id="check-all" type="checkbox" name="checkall" />Acc. Status</th>
													<th style="width:100px">Action</th>
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
			<h3>Booking Cost Auditing</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/payCostRecords/edit.jhtml'/]">
			<div class="modal-body form">
				<div class="row no-margin-y">
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Payment:<input type="name" readonly class="form-control"  id="itemId">
					</div>
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Payment Method:
							<td style="border: 1px solid #DADADA;border-bottom: 1px solid #dadada;" align="center">
								<select name="ways" id="ways" class="select2">
								[#list constant.COST_WAYS as val]
									<option value="${val}">${val}</option>
								[/#list]
								</select>
							</td>
					</div>
				</div>
				<div class="row no-margin-y">
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Amount:<input type="name" readonly class="form-control" id="sumId">
					</div>
					<div class="form-group col-md-6 col-sm-6  col-xs-6 no-margin">
						Reference NO:<input type="text" name="InvoiceNos" class="form-control" id="InvoceId">
					</div>
				</div>
				<div class="text-center">
					<h4>Are you sure to confirm?</h4>
					<p>please type verify remarks below.</p>
					<div class="text-center"id="centerId">
						<textarea name="confirmRemark" style="width:95%;height:60px"></textarea>
						<input type="hidden" value="504" name="munId"/>
						<input type="hidden" value="pay" name="temp"/>
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
							<input type="hidden" value="pay" name="temp"/>
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
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Desc.:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.item+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Method:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.way+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Remark:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.remark+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Acc. Remark:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.confirmRemark+'</td></tr>';
            sOut += '</table>';
            return sOut;
        }
        
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "autoWidth":true,
            "bFilter":false,
            "bSort":false,
            "ajax": {
                url: "[@spring.url '/admin/payCostRecords/payList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNo").val();
					data.tourCode = $("#search_tourCode").val();
					data.userName = $("#search_userName").val();
					data.status = $("#statusSpan").val();
					data.sum = $("#search_sum").val();
					data.remark = $("#search_remark").val();
					data.venderString = $("#search_vender").val();
					data.beginningDate = $("#search_beginningDate").val();
	                data.endingDate = $("#search_endingDate").val();
					data.beginningTime = $("#search_beginningTime").val();
	                data.endingTime = $("#search_endingTime").val();
	                data.code = $("#search_invoiceNo").val();
	                data.item = $("#search_item").val();
	                data.way = $("#search_way").val();
				}
            },
           "columns": [
                { "data":null},
                { "data": "id","visible":false},
                { "data": "orderNo" },
                { "data": "tourCode" },
                { "data": "scheduleOfArriveTime" },
                { "data": "userName" },
                { "data": "code" },
                { "data": "venderString" },
                { "data": "createDate" },
                { "data": "sum" },
                { "data": "status" },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					var html;
					if(row.status==0){
						html='<a href="javascript:confirmUp(\''+data+'\');"><i class="fa fa-pencil"></i>Approve</a>';
					}else{
						html='<i class="fa fa-pencil"></i>Approve';
					}
					return html;
                 },
				"targets" : 11
		  }],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		 		 $('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' ); 
		  		  var str='';
                 		if(aData.status==0){
                 			str+='<div class="radio"><input type="checkbox"  name="records" value="'+aData.id+'" class="icheck"/><i class="fa fa-eye"></i></div>';
                 		}else{
                 			str+='<input type="checkbox"  name="records" value="'+aData.id+'" class="icheck" disabled="disabled"/><i class="fa fa-check"></i>';
                 		}
		        $('td:eq(9)', nRow).html(str);
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
						$("#InvoceId").val(obj['code']);
						$("#wayId").val(obj['way']);
						var way=obj['way'];
						$("#ways").find("option[value='"+way+"']").attr("selected",true);
						$("#s2id_ways .select2-chosen").html(way);
						$('input[name="recordString"]').remove();//删除旧数据
						$('input[name="orderNo"]').remove();//删除旧数据
						$('input[name="tourCode"]').remove();//删除旧数据
						$('input[name="userName"]').remove();//删除旧数据
						$('input[name="status"]').remove();//删除旧数据
						$('input[name="sum"]').remove();//删除旧数据
						$('input[name="remark"]').remove();//删除旧数据
						$('input[name="code"]').remove();//删除旧数据
						$("#centerId").append('<input type="hidden" value="'+data+'" name="recordString"/>');
						var orderNo = $("#search_orderNo").val();
						var tourCode = $("#search_tourCode").val();
						var userName = $("#search_userName").val();
						var status = $("#statusSpan").val();
						var sum = $("#search_sum").val();
						var remark = $("#search_remark").val();
						var code = $("#search_invoiceNo").val();
						
						$("#centerId").append('<input type="hidden" value="'+orderNo+'" name="orderNo"/>');
						$("#centerId").append('<input type="hidden" value="'+tourCode+'" name="tourCode"/>');
						$("#centerId").append('<input type="hidden" value="'+userName+'" name="userName"/>');
						$("#centerId").append('<input type="hidden" value="'+status+'" name="status"/>');
						$("#centerId").append('<input type="hidden" value="'+sum+'" name="sum"/>');
						$("#centerId").append('<input type="hidden" value="'+remark+'" name="remark"/>');
						$("#centerId").append('<input type="hidden" value="'+code+'" name="code"/>');
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
		$('input[name="remark"]').remove();//删除旧数据
		$('input[name="code"]').remove();//删除旧数据
		$('input[name="venderString"]').remove();//删除旧数据
		$('input[name="records"]:checked').each(function(){
            var sfruit=$(this).val();
        	$("#fromCentId").append('<input type="hidden" value="'+sfruit+'" name="recordsId"/>');
        });
        var orderNo = $("#search_orderNo").val();
		var tourCode = $("#search_tourCode").val();
		var userName = $("#search_userName").val();
		var status = $("#statusSpan").val();
		var sum = $("#search_sum").val();
		var remark = $("#search_remark").val();
		var code = $("#search_invoiceNo").val();
		var venderString = $("#search_vender").val();
		$("#fromCentId").append('<input type="hidden" value="'+orderNo+'" name="orderNo"/>');
		$("#fromCentId").append('<input type="hidden" value="'+tourCode+'" name="tourCode"/>');
		$("#fromCentId").append('<input type="hidden" value="'+userName+'" name="userName"/>');
		$("#fromCentId").append('<input type="hidden" value="'+status+'" name="status"/>');
		$("#fromCentId").append('<input type="hidden" value="'+sum+'" name="sum"/>');
		$("#fromCentId").append('<input type="hidden" value="'+remark+'" name="remark"/>');
		$("#fromCentId").append('<input type="hidden" value="'+code+'" name="code"/>');
		$("#fromCentId").append('<input type="hidden" value="'+venderString+'" name="venderString"/>');
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
			var remark = $("#search_remark").val();
            var code = $("#search_invoiceNo").val();
			window.location.href=value+"?orderNo="+orderNo+"&tourCode="+tourCode+"&userName="+userName+"&status="+status+"&sum="+sum+"&remark="+remark+"&code="+code;
		}
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_beginningTime").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_endingTime").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		
		$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
 			$("#search_endingDate").val('');
		});
		$("#clearTime").click(function(){
			$("#search_beginningTime").val('');
 			$("#search_endingTime").val('');
		});
		function printOrder(){
			var orderNo = $("#search_orderNo").val();
			var tourCode = $("#search_tourCode").val();
			var userName = $("#search_userName").val();
			var status = $("#statusSpan").val();
			var sum = $("#search_sum").val();
			var remark = $("#search_remark").val();
			var beginningDate = $("#search_beginningDate").val();
            var endingDate = $("#search_endingDate").val();
			var beginningTime = $("#search_beginningTime").val();
            var endingTime = $("#search_endingTime").val();
            var code = $("#search_invoiceNo").val();
            var item = $("#search_item").val();
            var vender = $("#search_vender").val();
            var way = $("#search_way").val();
            var url="?orderNo="+orderNo+"&tourCode="+tourCode+"&userName="+userName+"&status="+status+"&sum="+sum;
            	url+="&remark="+remark+"&beginningDate="+beginningDate+"&endingDate="+endingDate+"&code="+code+"&item="+item+"&beginningTime="+beginningTime+"&endingTime="+endingTime+"&venderString="+vender+"&way="+way;
	    window.open("[@spring.url '/admin/payCostRecords/findOrderListVOPrintOfCost.jhtml'/]"+url);
	}	
</script>
</body>
</html>
