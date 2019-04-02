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
            <h3>Air Ticket</h3>
            <div class="new">
            	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
                <a id="btnPrint" href='javascript:printOrder();' class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
	            <a class="btn pull-right " href="javascript:explorBill();" title="Export Bill"><i class="fa fa-share-square-o" ></i></a>
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
	                    	<input type="hidden" id="time" value="${so.time}"/>
	                    	<input type="hidden" id="year" value="${so.year}"/>
							<input type="hidden" id="deptId" value="${so.deptId}"/>
							<input type="hidden" id="agentId" value="${so.agentId}"/>
							<input type="hidden" id="tempValue01" value="${so.tempValue01}"/>
							<input type="hidden" id="agency" value="${so.agency}"/>
							<input type="hidden" id="venderId" value="${so.venderId}"/>
						</div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
	                                    <tr>
	                                    	<th>Date</th>
		                                  	<th>No.</th>
		                                  	<th>Qty.</th>
		                                  	<th>AirLine</th>
		                                  	<th>ARC</th>
		                                  	<th>Charge</th>
	                                  		<th>Profit</th>
	                                  		<th>Class</th>
	                                  		<th>DES</th>
											<th>PNR</th>
											<!--<th>Type</th>-->
											<th>Status</th>
											<th>Agent</th>
											<th>Dept</th>
	                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="th-box" style="margin-top:-5px;">
							<div class="th-box-t">
								<span style="font-family:'Arial';color:#001144;font-size:20px;font-weight:bold;">Summary</span>
							</div>
							<div class="th-box-b">
								<table style="font-family:'Arial';width:95%;margin:0 auto 0;">
									<tbody>
										<tr>
											<td style="height:20px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Qty：${sf.quantity}</td>
											<td style="height:20px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">ARC：${sf.tempValue06}</td>
											<td style="height:20px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Bill/Credit：${((sf.amount)!0)-((sf.charge)!0)}</td>
											<td style="height:20px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Profit：${((sf.amount)!0)-((sf.operatorFee)!0)}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="confirm-upload" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	Upload File
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" enctype="multipart/form-data"   action="upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file"  placeholder="Upload File" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary" style="margin-left:206px;">Upload</button>
						</div>
					</div>
				</form>
			</div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
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

                    <p>Tour will be permanently deleted ?</p>
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
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Verify</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="verifyFormId" action="" style="border-radius: 0px;" method="post">
      	  <div id="checkId"></div>
	      <div class="modal-body form" >
	      	 <div class="form-group" style="height:80px;">
                <label class="col-sm-3 control-label">Auditing Status</label>
                <div class="col-sm-6">
				  <input class="icheck" id="pass" type="radio" name="isPass" value="1" checked="" style="position: absolute; opacity: 0;">审核不通过
                  <input class="icheck" id="pass" type="radio" name="ispass" value="2" checked="" style="position: absolute; opacity: 0;">审核通过
                </div>
              </div>   
	      	 <div class="form-group" style="height:100px;">
                <label class="col-sm-3 control-label">Auditing Remark</label>
                <div class="col-sm-6">
                  <textarea class="form-control" name="accRemarkOfOp" id="rem"> </textarea>
                </div>
              </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		        <button type="button" class="btn btn-primary btn-flat md-close" data-dismiss="modal" id="OKButton">Save</button>
		      </div>
	      </div>
      </form>
  	</div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        
        $("#datatable2").attr("width","100%");
        
        
        var peerId = "${venderId}";
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/statistical/ticketListPage.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
            	 	 data.time = $("#time").val();
	                data.year = $("#year").val();
	                data.deptId = $("#deptId").val();
	                data.agentId = $("#agentId").val();
	                 data.tempValue01 = $("#tempValue01").val();
	                 data.agency = $("#agency").val();
	                 data.venderId= $("#venderId").val();
				}
            },
            "columns": [
            	{ "data": "date"},
                { "data": "InvoiceNum"},
                { "data": "quantity"},
                { "data": "airline"},
                { "data": "tempValue06"},
           		/*{ "data": "supplierPriceForOrderId",
					"render":function(data, type, row) {
						return (row.operatorFee-row.charge).toFixed(2)
					}
				},*/
				{ "data": "charge"},
				{ "data": "supplierPriceForOrderId",
					"render":function(data, type, row) {
						return (row.amount-row.operatorFee).toFixed(2)
					}
				},
				{ "data": "tempValue04"},
				{ "data": "tempValue05"},
                { "data": "flightPnr"},
                /*{ "data": "type",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'Agent';
					  		case 1 : return 'Retail';
					  		case 2 : return 'Wholesale'; 
					  		default: return ''; 
					  	}
					}
                },*/
                { "data": "approveStatus",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'NEW';
					  		case 1 : return 'Approved';
					  		default: return ''; 
					  	}
					}
                },
                { "data": "tempValue01" },
                { "data": "deptName" }
            ]
        });
        
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
    });
    
		//支付
		 function pay(){
	    	$("#approve").attr("data-modal",false);
	    	var length = $("input[type=checkbox]:checked").length;
	    	if(length<=0){
	    		alert("Please select the order for payment");
	    	}else if(length>0){
				$("input[type=checkbox]:checked").each(function(index,element){
					orderIndex = index;
					$(this).attr("name","orderList["+index+"].orderId");
					$(this).parent().siblings().each(function(index,element){
						if($(this).has("input").length>0){
							$(this).find("input").removeAttr("disabled");
							str = $(this).find("input").attr("name");
							name = "orderList["+orderIndex+"]."+str;
							$(this).find("input").attr("name",name);
						}
					});
				});
				
				$("#formId").submit();
		      }
		      
	    };
	    
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
         $('#confirm-upload').on('show.bs.modal', function (e) {
            $(this).find('#formId').attr('action', $(e.relatedTarget).data('href'));
        });
         $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
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
		
		function alertApproveForm(){
			$("#alertForm").click();
		}
	function explorBill(){
		var time = $("#time").val();
		var year = $("#year").val();
		var deptId = $("#deptId").val();
		var agentId = $("#agentId").val();
		var tempValue01 = $("#tempValue01").val();
		var agency = $("#agency").val();
		if(time.indexOf("-")<0){
			location.href="${base}/admin/statistical/excelForAirItem.jhtml?year="+year+"&deptId="+deptId+"&agentId="+agentId+"&tempValue01="+tempValue01+"&agency="+agency;
		}else{
			location.href="${base}/admin/statistical/excelForAirItem.jhtml?time="+time+"&deptId="+deptId+"&agentId="+agentId+"&tempValue01="+tempValue01+"&agency="+agency;
		}
	}
	
	function printOrder(){
		var time = $("#time").val();
        var year = $("#year").val();
        var deptId = $("#deptId").val();
        var agentId = $("#agentId").val();
     	var tempValue01 = $("#tempValue01").val();
     	var agency = $("#agency").val();
        if(time.indexOf("-")<0){
        	location.href="${base}/admin/statistical/ticketStatisticalPrint.jhtml?year="+year+"&deptId="+deptId+"&agentId="+agentId+"&tempValue01="+tempValue01+"&agency="+agency;
        }else{
        	location.href="${base}/admin/statistical/ticketStatisticalPrint.jhtml?time="+time+"&deptId="+deptId+"&agentId="+agentId+"&tempValue01="+tempValue01+"&agency="+agency;
        }
    }
</script>
</script>
</body>
</html>
