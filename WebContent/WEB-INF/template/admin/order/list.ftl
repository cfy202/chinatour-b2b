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
                    <h4><i class="fa fa-warning"></i>Warning !</h4>

                    <p>The Booking will be deleted?</p>
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

                    <p>The Booking will be Recoverd?</p>
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
<!--结算弹出框-->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
	<div class="md-content">
		<div class="modal-header">
			<h3>Form Modal</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<form action="[@spring.url '/admin/orderFinance/updateOrderOfTourTaxState.jhtml'/]" id="formId" method="post"></form>
		</div>
		<div class="col-sm-2 col-md-2">
			<h4 class="spacer-bottom-sm"></h4>
			<div class="block-flat no-padding">
				<div class="content">
					<table class="no-border blue">
						<thead>
							<tr>
								<th>Invoice No. </th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td id="numberId">Booking No.<br/></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-sm-10 col-md-10" id="profit"></div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			<button type="button" class="btn btn-primary btn-flat md-close" onclick="submitForm();">Proceed</button>
		</div>
	</div>
</div>
<!--/结算弹出框-->
<div class="md-overlay"></div>
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Tour Booking Info.</h3>
            <div class="new"><a style="cursor:pointer;" href="javascript:void(0);" id="penId" class="md-trigger" data-modal="form-primary"></a><button class="btn btn-success" type="button" id="New" onclick="location.href='add.jhtml'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
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
                                <i id="filter" class="fa fa-angle-down"></i>&nbsp;&nbsp;
                            </div>
                            
                            <div class="options" style="margin:10px;">
                            
                            	<div  class="nav-panel">
								    <div  class="nav-block">
								      <div  class="block-head">
								        <span  class="nav-title">Settlement Status</span>:
								      </div>
								      <div  class="block-body default-2-line">
								        <div  class="params-cont"> 
								        	<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
								            	<span  class="unchecked" name="colorSpan" checked="false" onclick="change(this);" >Unsettled</span> 
								            </a> 
								            <a style="cursor:pointer;"  target="_self"  class=" param-item" > 
								            	<span  class="unchecked"  name="colorSpan" checked="false" onclick="change(this);">Settled</span> 
								            </a> 
								        </div>
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
								        	<input type="text" size="14"  placeholder="Search tourCode..." />
								            <input type="text" size="14"  placeholder="Search orderNo..." />
								        </div>
								      </div>
								    </div>
								    
								  </div>
								  <div  class="nav-panel">
								     <div class="btn-cont">
								     	<input class="submit-btn"  type="submit" value="Search">
								        <input class="submit-btn" type="submit" value="CANCLE">
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
											<th>Booking No. </th>
											<th>Tour Code</th>
											<th>Arrival Date</th>
											<th>Total Passenger</th>
											<th>Status</th>
											<th>Settlement Status</th>
											<th>Acc. Auditing</th>
											<th>Acc. View Changes</th>
											<th>Product Name</th>
											<th>Booking Date </th>
											<th>Total Amount</th>
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
        
        $("div.options").hide();//默认隐藏div，或者在样式表中添加.text{display:none}，推荐使用后者
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-angle-up"){
				_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
			}
		});
		
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
         
        /* Formating function for row details */
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Product Name:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.lineName+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Booking Date:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.createDate+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Total Amount:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.sumFee+'</td></tr>';
            sOut += '</table>';
            return sOut;
        }
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                url: "[@spring.url '/admin/orders/list.jhtml'/]",
                type: "POST"
            },
            "columns": [
                { "data": "id"},
                { "data": "orderNo" },
                { "data": "tourCode" },
                { "data": "scheduleOfArriveTime" },
                { "data": "totalPeople" },
                { "data": "state" },
                { "data": "tax",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return '<i title="Unsettled" class="fa fa-times"></i>';
					  		case 2 : return '<i title="Settled Not Sent 0.05Invoice" class="fa fa-check"></i>'; 
					  		case 3 : return '<i title="Settling" class="fa fa-clock-o"></i>';
					  		case 4 : return '<i title="Settled  Sent0.05Invoice" class="fa fa-check"></i>'; 
					  	}
					}
                },
                { "data": "payState",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'New';
					  		case 1 : return 'Approved';
					  		case 2 : return 'Disapproved';
					  		default: return 'No Information'; 
					  	}
					}
                },
                { "data": "warnState", 
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'Unrevised';
					  		case 1 : return 'Checked';
					  		case 2 : return 'Unchecked'; 			
					  	}
					}
                },
                { "data": "lineName","visible":false },
                { "data": "createDate","visible":false},
                { "data": "sumFee","visible":false },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					if(row.state == 'Cancell Booking'){
						return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span>'
						+'<span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">'
						+'<li><a style="cursor:pointer;" href="customers.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Passenger Info</a></li>'
						+'<li><a style="cursor:pointer;" href="editPayCost.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Income/Cost</a></li>'
						+'<li><a style="cursor:pointer;" href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>'
						+'<li><a style="cursor:pointer;" href="checkOrderOfTourPofit.jhtml?menuId=301&tourId='+row.tourId+'"><i class="fa fa-pencil"></i>Confirm Settlement</a></li>'
						+'<li class="divider"></li><li><a style="cursor:pointer;" data-href="recoverOrder.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-recover"><i class="fa fa-reply-all"></i>Recover Booking</a></li></ul></div>';
					}else{
						return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span>'
						+'<span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">'
						+'<li><a style="cursor:pointer;" href="customers.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Passenger Info</a></li>'
						+'<li><a style="cursor:pointer;" href="editPayCost.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Income/Cost</a></li>'
						+'<li><a style="cursor:pointer;" href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>'
						+'<li><a style="cursor:pointer;" href="[@spring.url '/admin/orderFinance/checkOrderOfTourPofit.jhtml'/]?menuId=301&tourId='+row.tourId+'&userId='+row.userId+'"><i class="fa fa-pencil"></i>Confirm Settlement</a></li>'
						+'<li><a style="cursor:pointer;" href="orderReview.jhtml?id='+data+'"><i class="fa fa-eye"></i>View Booking Confirmation</a></li>'
						+'<li class="divider"></li><li><a style="cursor:pointer;" data-href="cencelOrder.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Cancell Booking</a></li></ul></div>';
					}
                 },
				"targets" : 12
		   }],
		   "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
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
    
var obj={
 colorSpan:"",
};
function change(span)
{
    $('span[name="'+$(span).attr('name')+'"]').each(function(){
             if(this.checked&&this!=span)
          {
                this.className="unchecked";
                this.checked=false;
          }               
    });
    obj[$(span).attr('name')]=span.innerHTML;
    span.className="checked";
    span.checked=true;
    select();
}
function printProfit(tourId){
	$.ajax({
		type: "POST",
		url: "[@spring.url '/admin/orderFinance/mergerSettlement.jhtml'/]",
		data:"tourId="+tourId,
		success: function(msg){
			$("#numberId").empty();
			$("#profit").empty();
			var str='';
			$.each(msg.orderList,function(index,entry){
				str+='<input type="hidden" value="'+entry['id']+'" name="orderIds"/>';
				$("#numberId").append(entry['orderNo']);
			});
			$("#formId").append(str);
			var html='<h4 class="spacer-bottom-sm">Tour Code:'+msg.tour.tourCode+'业务代表'+msg.userName+'</h4>'+
					'<div class="no-padding">'+
						'<div class="content">'+
							'<table class="no-border blue">'+
								'<thead>'+
									'<tr>'+
										'<th>Booking No.</th>'+
										'<th>Date</th>'+
										'<th>Amount </th>'+
										'<th>Payment</th>'+
										'<th>Check No. </th>'+
										'<th>Remark</th>'+
										'<th>Status</th>'+
										'<th>Audit Remark</th>'+
									'</tr>'+
								'</thead>'+
								'<tbody>';
								$.each(msg.payCostRecordsList,function(index,entry){
									if(entry['payOrCost']==1&&entry['type']!=9){
									html+='<tr>'+
											'<td>'+entry['orderId']+'</td>'+
											'<td>'+entry['time']+'</td>'+
											'<td>'+entry['sum']+'</td>'+
											'<td>'+entry['item']+'</td>'+
											'<td>'+entry['code']+'</td>'+
											'<td>'+entry['remark']+'</td>'+
											'<td>'+entry['status']+'</td>'+
											'<td>'+entry['confirmRemark']+'</td>'+
										'</tr>';
									}
								});
						html+='</tbody>'+
							'</table>'+
						'</div>'+
					'</div>'+
					'<h4 class="spacer-bottom-sm">Cost Details</h4>'+
					'<div class="no-padding">'+
						'<div class="content">'+
							'<table class="no-border blue">'+
							'<thead>'+
								'<tr>'+
									'<th>Booking No.</th>'+
									'<th>Date</th>'+
									'<th>Amount </th>'+
									'<th>Paymnet</th>'+
									'<th>Check No.</th>'+
									'<th>Remark</th>'+
									'<th>Status</th>'+
									'<th>Audit Remark</th>'+
								'</tr>'+
							'</thead>'+
							'<tbody>';
							$.each(msg.payCostRecordsList,function(index,entry){
								if(entry['payOrCost']==2){
								html+='<tr>'+
										'<td>'+entry['code']+'</td>'+
										'<td>'+entry['time']+'</td>'+
										'<td>'+entry['sum']+'</td>'+
										'<td>'+entry['item']+'</td>'+
										'<td>'+entry['code']+'</td>'+
										'<td>'+entry['remark']+'</td>'+
										'<td>'+entry['status']+'</td>'+
										'<td>'+entry['confirmRemark']+'</td>'+
									'</tr>';
								}
							});
						html+='</tbody>'+
						'</table>'+
					'</div>'+
					'</div>'+
				'<h4 class="spacer-bottom-sm">Revised Bill</h4>'+
					'<div class="no-padding">'+
						'<div class="content">'+
							'<table class="no-border blue">'+
							'<thead>'+
								'<tr>'+
									'<th>Tour Code</th>'+
									'<th>Date</th>'+
									'<th>Amount</th>'+
									'<th>Content </th>'+
									'<th>Reason</th>'+
								'</tr>'+
							'</thead>'+
							'<tbody>';
							$.each(msg.payCostRecordsList,function(index,entry){
								if(entry['type']==9){
								html+='<tr>'+
										'<td>'+entry['code']+'</td>'+
										'<td>'+entry['time']+'</td>'+
										'<td>'+entry['sum']+'</td>'+
										'<td>'+entry['item']+'</td>'+
										'<td>'+entry['code']+'</td>'+
										'<td>'+entry['remark']+'</td>'+
										'<td>'+entry['status']+'</td>'+
										'<td>'+entry['confirmRemark']+'</td>'+
									'</tr>';
								}
							});
					html+='</tbody>'+
						'</table>'+
					'</div>'+
					'</div>'+
					'<div>'+msg.deptName+"Profit:"+msg.order.opProfit+"<br/>"+msg.dept.deptName+"Profit:"+msg.order.agentProfit+'</div>';
			$("#profit").append(html);
			$("#penId").trigger("click");
		}
	});
}
function submitForm(){
	$("#formId").submit();
}
</script>
</body>
</html>
