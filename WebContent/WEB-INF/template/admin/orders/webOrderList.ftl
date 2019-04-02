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
                    <p>Booking will be Cancel ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="modal fade" id="confirm-recover" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Booking will be Recover ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- Modal -->
<div class="modal fade" id="confirm-order" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Cancell Booking!</h4>
					<div class="col-sm-6">
	                  <label class="radio-inline"> <input type="radio" checked="" name="tax" class="icheck" value="1">Unsettled</label> 
	                  <label class="radio-inline"> <input type="radio" name="tax" class="icheck" value="2">Settled</label> 
	                </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger" >Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<div class="md-overlay"></div>
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Booking Info</h3>
            <div class="new" style="width:300px">
            	<button id="importCustomerButton" type="button" data-modal="customerImportForm" class="btn btn-success btn-flat md-trigger">Change Agent</button>
            </div>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="">Booking</a></li>
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
									<input type="hidden" id="orderNoIn" value="other"/>
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Booking Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="stateSpan" checked="false" onclick="change(this,0);">NEW</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,2);" >Composed</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,3);" >Update</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,4);" >Cancelling</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,5);" >Cancelled</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,6);" >Cacelling by Agent</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,7);" >Recovering</span> 
													</a> 
													<input type="hidden" id="stateSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-panel">
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Arrival Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_beginningDate" size="14" [#if (order.beginningDate)??]value="${order.beginningDate?string('yyyy-MM-dd')}"[/#if] placeholder="Beginning Date." />
													<input type="text" id="search_endingDate" size="14" [#if (order.endingDate)??]value="${order.endingDate?string('yyyy-MM-dd')}" [/#if] placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Booking Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="booking_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="booking_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate2" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_orderNo" placeholder="Order No..." />
													<input type="text" size="14" id="search_orderNoIn" placeholder="Source..." />
													<input type="text" size="14" id="search_peer" placeholder="Peer..." />
													<input type="text" size="14" id="search_contact" placeholder="Contacts..." />
													<input type="text" size="14" id="search_webOrderNo" placeholder="Web Order No..." />
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
                        	<form method="post" id="formId" action="[@spring.url '/admin/payCostRecords/agentSettlementAll.jhtml?menuId=303'/]">
	                            <div class="table-responsive">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
			                                  	<th></th>
												<th><input id="check-allid" type="checkbox" name="checkall"/>Booking No. </th>
												<th>Booking Date</th>
												<th>Arrival Date</th>
												<th>Total Passenger</th>
												<th>Status</th>
												<th>Product Name</th>
												<th>Web Order No.</th>
												<th>Total Amount</th>
												<th></th>
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
<div class="md-modal colored-header custom-width md-effect-9" id="customerImportForm" style="width:40%;">
    <div class="md-content" >
      <div class="modal-header">
      	<h3>Action</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <div class="text-center">
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td>
							<span>
								User Name:
							</span>
						</td>
						<td>
							<select id="agentId"  class="select2" style="width:140px">
								[#list agentList as agent]
									<option value="${agent.id}">${agent.username}---${agent.deptName}</option>
								[/#list]
							</select>
						</td>
				</tbody>
			</table>
        </div>
      <div class="modal-footer">
		   <button class="btn btn-default btn-flat md-close" data-dismiss="modal" type="button">Cancel</button>
		   <button class="btn btn-primary btn-flat md-close" type="button" onclick="changeUser()">Ok</button>
	  </div>
    </div>
</div>
<div class="md-overlay">
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        
	     $('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	        radioClass: 'iradio_square-blue'
	      });
        
        $("#datatable2").attr("width","100%");
        
        $("div.options").hide();//默认隐藏div，或者在样式表中添加.text{display:none}，推荐使用后者
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-caret-square-o-up fa-lg color-blue"){
				_slide.removeClass("fa fa-caret-square-o-up fa-lg color-blue").addClass("fa fa-caret-square-o-down fa-lg color-blue");
			}else{
				_slide.removeClass("fa fa-caret-square-o-down fa-lg color-blue").addClass("fa fa-caret-square-o-up fa-lg color-blue");
			}
		});
		
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
         
        /* Formating function for row details */
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var cost,pay,totals;
            if(aData.payCost==null){
            	pay=0;
            	cost=0;
            	totals=0;
            }else{
            	pay=aData.payCost.payTotalSum;
            	cost=aData.payCost.costTotalSum;
            	totals=(aData.payCost.payTotalSum-aData.payCost.costTotalSum).toFixed(2);
            }
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Peer:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.peerName+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Contacts:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.contact+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Product Name:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.lineName+'</td></tr>';
            sOut += '</td></tr></table>';
            return sOut;
        }
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/orders/tourList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNo").val();
					data.state = $("#stateSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.bookingBeginningDate = $("#booking_beginningDate").val();
					data.bookingEndingDate = $("#booking_endingDate").val();
	                data.peerId = $("#search_peer").val();
	                data.refNo = $("#search_webOrderNo").val();
	                data.contact = $("#search_contact").val();
	                if($("#search_orderNoIn").val()!=""){
	                	data.orderNoIn = $("#search_orderNoIn").val();
	                }else{
	                	data.orderNoIn = $("#orderNoIn").val();
	                }
				}
            },
            "columns": [
                { "data": "id"},
                { "data": "orderNo",
                	"render" : function(data, type, row) {
						return '<div class="radios" id="'+row.id+'pay"><input type="checkbox"  name="ordersIds" value="'+row.id+'" class="icheck"/>'+row.orderNo+'</div>';
					}
                },
                { "data": "createDate" },
                { "data": "scheduleOfArriveTime" },
                { "data": "totalPeople" },
                { "data": "state",
					"render" : function(data, type, row) {
						if(data==0){
							return '<span class="color-danger">NEW</span>';
						}else if(data==2){
							return '<span class="color-success">COMPOSED</span>';
						}else if(data==3){
							return '<span class="color-primary">UPDATE</span>';
						}else if(data==4){
							return '<span class="color-danger">CACELLING</span>';
						}else if(data==5){
							return '<span class="color-warning">CANCELLED</span>';
						}else if(data==6){
							return '<span class="color-warning">CANCELLED</span>';
						}else if(data==7){
							return '<span class="color-danger">RECOVERING</span>';
						}else{
							return '';
						}
					}
                },
                { "data": "lineName","visible":false },
                { "data": "refNo"},
                { "data": "sumFee"},
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
						return "";
                 },
				"targets" : 9
		   }],
		   "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
           },
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.id==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(1)', nRow).html("");
					$('td:eq(9)', nRow).html("");
					$('td:eq(8)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			},
			"fnDrawCallback": function() {
				initAddHtml($("#datatable2"));
		    },
		   "order": [[ 1, 'asc' ]]
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
        });
        
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $('#confirm-recover').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $('#confirm-order').on('show.bs.modal', function (e) {
        	var tax=$("input[name='tax']:checked").val();
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href')+"?tex="+tax);
        });
    });
    
		$("#subId").on( 'click', function () {
			$('#datatable2').DataTable().draw();
		} );
		
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
		
		$("#clearDate2").click(function(){
			$("#booking_beginningDate").val('');
 			$("#booking_endingDate").val('');
		});
		
		$("#booking_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#booking_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
		$("#clearDate1").click(function(){
			$("#search_settlementDateBeg").val('');
 			$("#search_settlementDateEnd").val('');
		});
		$("#search_settlementDateBeg").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_settlementDateEnd").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		
	 function isChanged(id){
    	$.post("isReview.jhtml",{'id':id},function(map){
    		if(map.ok=="ok"){
    			window.location.href="${base}/admin/orders/orderReview.jhtml?id="+id+"&menuId=303";
    		}else{
    			window.location.href="${base}/admin/orders/createOldPdf.jhtml?id="+id+"&menuId=303";
    		}
    	});
    }
    /*同行申请支付*/
    function agencyPay(orderId,state){
    	$.post("agencyPay.jhtml",{"orderId" : orderId,"state":state},function(result){
			if(result == 'success'){
				$("#"+orderId+"pay").html('<i title="Approving" class="fa fa-clock-o"></i>');
	    		alert("success");
			}
		}); 
    }
	
	/*打印*/
	function printOrder(){
		var tourCode = $("#search_tourCode").val();
		var orderNo = $("#search_orderNo").val();
		var state = $("#stateSpan").val();
		var tax = $("#taxSpan").val();
		var payState = $("#payStateSpan").val();
		var warnState = $("#warnStateSpan").val();
		var beginningDate = $("#search_beginningDate").val();
		var endingDate = $("#search_endingDate").val();
		var bookingBeginningDate = $("#booking_beginningDate").val();
		var bookingEndingDate = $("#booking_endingDate").val();
		var settlementDateBeg = $("#search_settlementDateBeg").val();
	    var settlementDateEnd = $("#search_settlementDateEnd").val();
	    var isSelfOrganize = $("#isSelfOrganizeSpan").val();
	    var flightPnr = $("#search_flightPnr").val();
	    var contact = $("#search_contact").val();
	    var url="?tourCode="+tourCode+"&orderNo="+orderNo+"&tax="+tax+"&state="+state+"&beginningDate="+beginningDate;
	    url+="&endingDate="+endingDate+"&settlementDateBeg="+settlementDateBeg+"&settlementDateEnd="+settlementDateEnd+"&isSelfOrganize="+isSelfOrganize;
	    url+="&bookingBeginningDate="+bookingBeginningDate+"&bookingEndingDate="+bookingEndingDate+"&payState="+payState+"&warnState="+warnState+"&flightPnr="+flightPnr+"&contact="+contact;
		window.open("[@spring.url '/admin/orders/findTourOrderListVOPrint.jhtml'/]"+url);
	}
	
  	/* 初始化添加的元素  */
	function initAddHtml($addHtml){
		$addHtml.find('.icheck').iCheck({
			checkboxClass: 'icheckbox_square-blue checkbox',
			radioClass: 'iradio_square-blue'
		});
		return $addHtml;
	}
	
    //全选或不全选
    $("#check-all").on('ifChanged',function(){
        var checkboxes = $(".radio").find(':checkbox');
        if($(this).is(':checked')) {
            checkboxes.iCheck('check');
        } else {
            checkboxes.iCheck('uncheck');
        }
      });
	//批量审核 提交表单
	function chbox(){
		var length = $("input[name='ordersTotalIds']:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}
		$("#formId").submit();
	}
	 //全选或不全选
    $("#check-allid").on('ifChanged',function(){
        var checkboxes = $(".radios").find(':checkbox');
        if($(this).is(':checked')) {
            checkboxes.iCheck('check');
        } else {
            checkboxes.iCheck('uncheck');
        }
      });
	//批量审核订单
	function changeUser(){
		var userId=$("#agentId").val();
		var length = $("input[name='ordersIds']:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}else{
		    $("input[name='ordersIds']:checked").each(function(i){
				var orderId=$(this).val();
				$.post("changeUser.jhtml",{"orderId" : orderId,"userId":userId},function(result){
					if(i==length-1){
						window.location.reload();
					}
				});
			});
		}
		
	}
</script>
</body>
</html>
