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
                    <p>Are you confirmation?</p>
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
    <div class="container-fluid" id="pcont">
       <div class="page-head">
            <h2>Passenger List</h2>
            <div class="new"><button class="btn btn-primary" type="button" onclick="location.href='exportCustomer.jhtml?menuId=${menuId}&tourId=${tourId}'">Export All Traveler Info.</button></div>
            <div class="new"><button id="importFlightButton" class="btn btn-success" type="button">Edit Flight Info.</button><button class="btn btn-success" type="button" id="importCarButton">Car</button></div>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertform" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
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
                            <h3>Passenger List</h3>
                            <a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right"><i class="fa fa-mail-reply" title="back"></i></a>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                            	<form id="formId" action="exportCustomer.jhtml" method="post">
                            		<input type="hidden" name="carId" id="carId">
                            		<input type="hidden" name="tourId" value="${tourId}">
									<input type="hidden" name="tourCode" value="${tourCode}">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
		                                    	<th style="display:none"></th>
		                                    	<th></th>
		                                    	<th><input id="firstCheckbox" type="checkbox"></th>
		                                        <th>Del</th>
		                                        <th>No.</th>
		                                        <th>Tour Code</th>
		                                        <th>Booking No.</th>
		                                        <th>LastName</th>
		                                        <th>FirstName</th>
		                                        <th>MiddleName</th>
		                                        <th>Phone</th>
												<th>Nationality</th>
												<th>Passport No.</th>
												<th>Ticket Type</th>
												<th>Voucher</th>
												<th>Departure City</th>
		                                        <th>Agent</th>
		                                    </tr>
	                                    </thead>
	                                    <tbody>
												[#list orderList as order]
													<tr id="trCss_${order.state}_${order_index}">
														<td style="display:none">${order.customerOrderRelId}</td>
														<td><img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" /></td>
														<td><input name="customerOrderRelId" value="${order.customerOrderRelId}" type="checkbox"></td>
														<td id="${order.customerOrderRelId}">
														[#if order.isDel==0]
															
														[#elseif order.isDel==1]
															<span class='color-danger'>Cancelled</span>
														[#elseif order.isDel==3]
															<a data-href="javascript:recoverCustomerRel('${order.id}','${order.customerOrderRelId}','${order.ordersTotalId}');" data-toggle="modal" data-target="#confirm-delete"><span class='color-danger'>Recovering</span></a>
														[#elseif order.isDel==5]
															<a data-href="javascript:updateCustomerRel('${order.id}','${order.customerOrderRelId}','${order.ordersTotalId}');" data-toggle="modal" data-target="#confirm-delete"><span class='color-warning'>Cancelling</span></a>
														[/#if]
														</td>
														<td>${order.customerTourNo}</td>
														<td>${order.tourCode}</td>
														<td>
														[#if menuId==410||menuId==510]
														<!--有admin:Agent 权限-->
															[@shiro.hasPermission name = "admin:Agent"]
																[#if admin.id=order.userId] 
																<a href="[@spring.url '/admin/orders/edit.jhtml?menuId=302&ordersTotalId=${order.ordersTotalId}'/]">${order.orderNo}</a>
																[#else]
																	${order.orderNo}
																[/#if]
															[/@shiro.hasPermission]
															<!--没有admin:Agent 权限-->
															[@shiro.lacksPermission name = "admin:Agent"]
																<a href='orderInfo.jhtml?menuId=402&id=${order.id}'>${order.orderNo}</a>
															[/@shiro.lacksPermission]
													    [#else]
															<a href='orderInfo.jhtml?menuId=402&id=${order.id}'>${order.orderNo}</a>
														[/#if]
														</td>
														<td>${order.customer.lastName}</td>
														<td>${order.customer.firstName}</td>
														<td>${order.customer.middleName}</td>
														<td>${order.customer.mobile}</td>
														<td>${order.customer.nationalityOfPassport}</td>
														<td>${order.customer.passportNo}</td>
														<td>${order.ticketType}</td>
														<td>${order.wr}</td>
														<td>${order.lineName}</td>
														<td>${order.userName}</td>
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

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4>Cars</h4>
      </div>
	     <div class="modal-body form">
	      <form action="addAccountSubject.jhtm" id="effectiveDataForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			<select id="changeCar" name="recType" onchange="selectRecordType();" class="select2">
						[#list carList as carList]
							<option value="${carList.carId}">${carList.carName}</option>
						[/#list]
					</select> 
	    		</div>
	     </form>
	    		<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button id="saveButtonForCar" class="btn btn-default btn-flat md-close" data-dismiss="modal">OK</button>
		    	</div>
	     
	    </div>
   </div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
       
  		 $('#confirm-delete').on('show.bs.modal', function (e) {
			$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
		});
		//取消客人标记
		$("tr[id^='trCss_5_']").css("background-color","#AAAAAA");
		$("tr[id^='trCss_6_']").css("background-color","#AAAAAA");
    });  
    
     function fnFormatDetails ( oTable, nTr,tdValue )
        {	
        	var sOut='';
			
			sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
			for(var i=0;i<tdValue.orderReceiveItemsList.length;i++){
				sOut += '<tr><td style="border-bottom: 1px solid #dadada;width:10%;">'+(i+1)+'</td><td style="border-bottom: 1px solid #dadada;">'+tdValue.orderReceiveItemsList[i].remark+'</td></tr>';
			}
			sOut += '</table>';
			return sOut;
            
        };
        var oTable = $('#datatable2').dataTable({
        		'ordering':false,
        		
        });
    
    $('#pcont').delegate('tbody td img','click', function () {
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
                var tdValue=$(this).parent().prev().text();
                $.ajax({
					url:'viewCustomerOptional.jhtml',
					data:'customerOrderRelId='+tdValue,
					type:"POST",
					success:function(result){
							tdValue=result;
							oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr,tdValue), 'details' );
					}
				});
				
            }
        });
        
        
    
    /*  级联选中  */
    function check(check){
    	var $checks = $(".customerCheckbox");
    	if($(check).prop("checked")){
    		$checks.prop("checked",true); 
    	}else{
    		$checks.prop("checked",false);
    	}
    }
    
    //修改客人状态
	function updateCustomerRel(orderId,customerOrderRelId,ordersTotalId){
		$("#modalId").trigger("click");
		$.ajax({
			url:'updateCustomerRel.jhtml',
			data:'id='+customerOrderRelId+'&tourId=${tourId}&orderId='+orderId+'&ordersTotalId='+ordersTotalId,
			type:"POST",
			success:function(result){
				if(result=="SUCCESS"){
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+customerOrderRelId).html("<span class='color-danger'>Cancelled</span>");
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
	 //恢复客人
	function recoverCustomerRel(orderId,customerOrderRelId,ordersTotalId){
		$("#modalId").trigger("click");
		$.ajax({
			url:'recoverCustomerRel.jhtml',
			data:'id='+customerOrderRelId+'&tourId=${tourId}&orderId='+orderId+'&ordersTotalId='+ordersTotalId,
			type:"POST",
			success:function(result){
				
				if(result=="SUCCESS"){
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+customerOrderRelId).html("");
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
	
	$("#importFlightButton").click(function(){
		if($("input[name='customerOrderRelId']:checked").length>0){
			$("#formId").attr("action","impotFlightInfo.jhtml");
			$("#formId").submit();
		}else{
			alert("请选择客人！");
		}
	});
	
	//复选框全选
	$("#firstCheckbox").click(function(){
		if($(this).prop("checked")==true){
			$("input[name='customerOrderRelId']").each(function(){
				$(this).prop("checked",true);
			});
		}else if($(this).prop("checked")==false){
			$("input[name='customerOrderRelId']").each(function(){
				$(this).prop("checked",false);
			});
		}
	});
	
	
	$("#importCarButton").click(function(){
		if($("input[name='customerOrderRelId']:checked").length<=0){
			alert("请选择客人！");
		}else{
			$("#alertform").click();
		}
	});
	
	 function alertForm(){
	   	$("#alertEditButton").click();
   }
   
   $("#saveButtonForCar").click(function(){
   		valueOfCar = $("#changeCar").val();
   		$("#carId").attr("value",valueOfCar);
   		$("#formId").attr("action","updateCarInfoForCustomer.jhtml");
		$("#formId").submit();
   });
   
</script>
</body>
</html>
