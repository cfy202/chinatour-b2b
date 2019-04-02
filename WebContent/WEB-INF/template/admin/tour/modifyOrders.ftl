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
                    <h4><i class="fa fa-warning"></i>Waring !</h4>
                    <p>Are you sure you want to cancel this?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalId" type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style=" width: 60%; max-height: 550px;">
	<div class="md-content">
		<div class="modal-header">
			<h3>Passenger Info</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<div class="modal-body form">
			<div class="table-responsive">
				<table class="table table-bordered" id="datatable2">
					<thead>
						<tr>
							<th>Del</th>
							<th>No.</th>
							<th>Tour Code</th>
							<th>Booking No.</th>
							<th>LastName</th>
							<th>FirstName</th>
							<th>MiddleName</th>
							<th>Nationality</th>
							<th>Passport No.</th>
							<th>Agent</th>
						</tr>
					</thead>
					<tbody id="tbodyId">
					</tbody>
				</table>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			<button type="button" class="btn btn-primary btn-flat md-close" data-dismiss="modal" data-target="#mod-warning">Proceed</button>
		</div>
	</div>
</div>
<div class="md-overlay"></div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
       <div class="page-head">
            <h2>Tour List</h2>
            <div class="new">
            </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
                <a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right"><i class="fa fa-mail-reply" title="back"></i></a>
                <a href='javascript:void(0);' onclick='javascript:delOrderForTour();' class="btn btn-primary pull-right">删除</a>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>Tour Composed List</h3>
                            <!--模拟点击弹出框按钮-->
                            <a href="javascript:void(0);" class="md-trigger" data-modal="form-primary" id="triggerId"></a>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                            	<form action="" method="post">
                            		<input type="hidden" id="tourCode" value="${tourCode}">
                            		<input type="hidden" id="tourId" value="${tourId}">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
		                                    	<th>NEW</th>
		                                        <th>Tour Code</th>
		                                        <th>Booking No.</th>
		                                        <th>Status</th>
		                                        <th>Passenger Info</th>
		                                        <th>Agent</th>
		                                        <th>Action</th>
		                                    </tr>
	                                    </thead>
	                                    <tbody>
											[#list orderList as order]
												<tr>
													<td>
														[#if order.noticeState==1]
															<a href="javascript:;" onclick="comvar('${order.id}','${order.tourId}')"><font color='red'>NEW</font></a>
														[/#if]
													</td>
													<td>${order.tourCode}</td>
													<td>
													<input type="checkbox" name="check2" class="icheck"  value="${order.id}">
														[#if menuId=510]
															<a href="[@spring.url '/admin/orders/edit.jhtml?menuId=510&ordersTotalId=${order.ordersTotalId}'/]">${order.orderNo}</a>
														[#else]
															<a href='orderInfo.jhtml?menuId=402&id=${order.id}'>${order.orderNo}</a>
														[/#if]
													</td>
													<td id="${order.id}">
													[#if order.state==0]
														NEW
													[#elseif order.state==2]
														Composed
													[#elseif order.state==3]
														Update
													[#elseif order.state==4]
														<a data-href="javascript:updateOrderState('${order.id}','${order.ordersTotalId}');" data-toggle="modal" data-target="#confirm-delete">Cacelling by Agent</a>
													[#elseif order.state==5]
														<font color='red'>Cancelled</font>
													[#elseif order.state==6]
														<font color='red'>Cancelled</font>
													[#elseif order.state==7]
														<a data-href="javascript:recoverCustomer('${order.id}','${order.ordersTotalId}');" data-toggle="modal" data-target="#confirm-delete">Recovering</a>
													[/#if]
														</td>
													<td>${order.totalPeople}</td>
													<td>${order.userName}</td>
													<td><div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="viewOrderCustomerList.jhtml?menuId=402&orderId=${order.id}"><i class="fa fa-pencil"></i>Passenger Info</a></li><li class="divider"></li><li><a href="${base}/admin/orders/invoiceForChild.jhtml?id=${order.id}" target="_blank"><i class="fa fa-print"></i>Invoice</a></li></td>
												</tr>
											[/#list]
										</tbody>
	                                </table>
                                </form>
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
       
		$('#confirm-delete').on('show.bs.modal', function (e) {
			$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
		});
       /* $("#datatable2").attr("width","100%");
       
         * Initialse DataTables, with no sorting on the 'details' column
        
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bSort":false,
            "ajax": {
                url: "[@spring.url '/admin/tour/orderList.jhtml?tourCode='+tourCode /]",
                type: "POST"
            },
            "columns": [
                { "data": "id",
                  "render": function (data, type, row) {
	                   return '<input class="orderCheckbox" name="orderIds" value="'+ data +'" type="checkbox">';
                   }
                },
                { "data": "tourCode" },
                { "data": "orderNo" },
                { "data": "state",
                   "render": function (data, type, row) {
	                   switch(data){
		                   case 2 : return 'Composed';
		                   case 4 : return 'Cancelling';
		                   case 5 : return 'Cancelled';  
		                   default : return '';                  
		               }
                   }
                },
                { "data": "totalPeople" },
                { "data": "userId" },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<a href="orderCustomerList.jhtml?orderId='+ data +'">Passenger Info</a>';
                 },
				"targets" : 6
		  }]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        }); */
    });
    
    /* 级联选中   */
    function check(check){
    	var $checks = $(".orderCheckbox");
    	if($(check).prop("checked")){
    		$checks.prop("checked",true); 
    	}else{
    		$checks.prop("checked",false);
    	}
    }
    
    /*  提交订单   */
    function submit(num){
    	var length = $(".orderCheckbox:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}
		var $form = $("form");
		if(num == 1){
			$form.attr("action","exportCustomer.jhtml");
		}else if(num == 2){
			$form.attr("action","changeTour.jhtml");
		}else{
			$form.attr("action","removeOrdersFromTour.jhtml");
		}
		$form.submit();
	}

	/*
		异步查询客人
	*/
	function addForm(orderId){
		$.ajax({
			type: "POST",
			url: "orderCustomerList.jhtml",
			data:"orderId="+orderId,
			success: function(msg){
				var html='';
				$.each(msg.tourVOList,function(index,entry){
				var middleName='';
				if(entry.middleName!=null){
					middleName=entry.middleName;
				}
				html+='<tr>';
					if(entry.isDel == 0){
                  	  	html +="<td></td>";
                  	  }else if(entry.isDel == 1){
                  	  	html +="<td><span class='color-danger'>Cancelled</span></td>";
                  	  }else{
                  	  	html +="<td><span class='color-warning'>Cancelling</span></td>";
                  	  }
					html +='<td>'+entry.customerOrderNo+'</td>'+
							'<td>'+entry.tourCode+'</td>'+
							'<td><a href="orderInfo.jhtml?id='+orderId+'">'+entry.orderNo+'</a></td>'+
							'<td>'+entry.lastName+'</td>'+
							'<td>'+entry.firstName+'</td>'+
							'<td>'+middleName+'</td>'+
							'<td>'+entry.nationalityOfPassport+'</td>'+
							'<td>'+entry.passportNo+'</td>'+
							'<td>'+entry.agent+'</td>'+
						'</tr>';
				});
				$("#tbodyId").empty();
				$("#tbodyId").append(html);
				$("#triggerId").trigger("click");
			}
		});
	}
	
	//修改订单状态
	function updateOrderState(orderId,ordersTotalId){
		$("#modalId").trigger("click");
		$.ajax({
			url:'updateOrderState.jhtml',
			data:'id='+orderId+'&tourId=${tourId}'+'&ordersTotalId='+ordersTotalId,
			type:"POST",
			success:function(result){
				if(result=="SUCCESS"){
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+orderId).html("Cancelled");
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
	//恢复客人
	function recoverCustomer(orderId,ordersTotalId){
		$("#modalId").trigger("click");
		$.ajax({
			url:'recoverCustomer.jhtml',
			data:'id='+orderId+'&tourId=${tourId}'+'&ordersTotalId='+ordersTotalId,
			type:"POST",
			success:function(result){
				if(result=="SUCCESS"){
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+orderId).html("Composed");
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
	
	//团下删除订单
	function delOrderForTour(){
		 var tourId=$("#tourId").val();
		 var orderIds="";
		 $("[name = check2]:checkbox").each(function (i) {
                    if ($(this).is(":checked")) {
                    	/*orderIds[i]=""+$(this).val()+"";*/
                    	orderIds=orderIds+""+$(this).val()+",";
                    }
                });
               $.ajax({
				type:"POST",
				url:"${base}/admin/tour/removeOrdersFromTour.jhtml?orderIds="+orderIds+"&tourId="+tourId,
				dataType:"json",
				success:function(map) {
					alert(map.Ok);
					window.location.reload();
				}
			});
	}
	function comvar(oid,tid){
		if (window.confirm("Are you sure to modify state ？")) {
            location.href="updateState.jhtml?tourId="+tid+"&orderId="+oid+"&type=order";
        }
	}
</script>
</body>
</html>
