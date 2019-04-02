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
<div class="md-overlay"></div>
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Booking Info</h3>
            <div class="new">
            	<a href='javascript:chbox();' class="btn btn-success">Payment</a>
            	<!--a id="btnPrint" href='javascript:printOrder();' class="btn btn-primary" ><i class="fa fa-print"></i> Print</a-->
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
									<input type="hidden" id="deptId" value="${deptId}"/>
									<input type="hidden" id="wr" value="WholeSale"/>
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Payment Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="cost" checked="false" onclick="change(this,1);" >UNPAID</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="cost" checked="false" onclick="change(this,2);" >PAID</span> 
													</a> 
													<input type="hidden" id="cost"/>
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
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_peer" placeholder="Peer..." />
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
												<th>Booking No. </th>
												<th>Tour Code</th>
												<th>Peer Name</th>
												<th>Total Amount</th>
												<th><input id="check-all" type="checkbox" name="checkall"/>Payment status</th>
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

 <div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
                    <div class="md-content">
                      <div class="modal-header">
                        <h3>Form Modal</h3>
                        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      </div>
                      <div class="modal-body form">
                        <div class="form-group">
                          <label>Email address</label> <input type="email" class="form-control" placeholder="username@example.com">
                        </div>
                        <div class="form-group">
                          <label>Your name</label> <input type="name" class="form-control" placeholder="John Doe">
                        </div>
                        <div class="row">
                          <div class="form-group col-md-12 no-margin">
                            <label>Your birth date</label>
                          </div>
                        </div>
                        <div class="row no-margin-y">
                          <div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
                            <input type="name" class="form-control" placeholder="DD">
                          </div>
                          <div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
                            <input type="name" class="form-control" placeholder="MM">
                          </div>
                          <div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
                            <input type="name" class="form-control" placeholder="YYYY">
                          </div>
                        </div>
                        <p class="spacer2"><input type="checkbox" name="c[]" checked />  Send me notifications about new products and services.</p>
                        
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary btn-flat md-close" data-dismiss="modal" data-target="#mod-warning">Proceed</button>
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
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/orders/agencyPayList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.orderNo = $("#search_orderNo").val();
					data.payStates = $("#payStateSpan").val();
					data.costState = $("#cost").val();
	                data.deptId = $("#deptId").val();
					data.wr = $("#wr").val();
				}
            },
            "columns": [
                { "data": "id"},
                { "data": "orderNo"},
                { "data": "tourCode" },
                { "data": "peerName"},
                { "data": "sumFee"},
                { "data": "costState",
                "render":function(data, type, row) {
							switch(data){
					  		case 1 : return '<div class="radio" id="'+row.id+'pay"><input type="checkbox"  name="ordersTotalIds" value="'+row.id+'" class="icheck"/><i title="Unsettled" class="fa fa-clock-o"></i></div>';
					  		case 2 : return '<i title="Approved" class="fa fa-check"></i>'; 
					  		case 3 : return '<i title="Settling" class="fa fa-times"></i>';
					  		default: return ''; 
					  	}
					}
                },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
						html='<a href="javascript:agencyPay(\''+data+'\',2);"><i class="fa fa-pencil"></i>Payment</a>'
						return html;
                 },
				"targets" : 6
		   }],
		   "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '' );
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
    	if(confirm("Whether to confirm the payment？")){
	    	$.post("agencyPay.jhtml",{"orderId" : orderId,"state":state},function(result){
				if(result == 'success'){
					$("#"+orderId+"pay").html('<i title="Approvd" class="fa fa-check"></i>');
				}
			}); 
		}
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
		}else{
			 if(confirm("Whether confirm to pay the selected orders？")){
			    $("input[name='ordersTotalIds']:checked").each(function(){
					var orderId=$(this).val();
					$.post("agencyPay.jhtml",{"orderId" : orderId,"state":2},function(result){
						if(result == 'success'){
							$("#"+orderId+"pay").html('<i title="Approvd" class="fa fa-check"></i>');
						}
					}); 
				});
			   }
		}
	}
</script>
</body>
</html>
