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
							<div class="options" style="margin:10px; padding:5px 0;">
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Type</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" >
														<span  class="unchecked"  name="typeSpan" checked="false" onclick="change(this,0);">Agent</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="typeSpan" checked="false" onclick="change(this,1);" >Retail</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" >
														<span  class="unchecked"  name="typeSpan" checked="false" onclick="change(this,2);">Wholesale</span> 
													</a>
													<input type="hidden" id="typeSpan"/>
												</div>
											</div>
										</div>
									<!--	<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Complete Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="statusSpan" checked="false" onclick="change(this,0);">Uncompleted</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,2);" >Completed</span> 
													</a> 
												</div>
											</div>
										</div>-->
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,0);" >NEW</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,1);" >Approved(Agent)</span> 
													</a> 
													<input type="hidden" id="statusSpan"/>
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
													<input type="text" size="14" id="search_invoiceNum" placeholder="No..." />
													<input type="text" size="14" id="search_userName" placeholder="Op..." />
													<input type="text" size="14" id="search_agentName" placeholder="Agent..." />
													<input type="text" size="14" id="search_invoiceNo" placeholder="Invoice No..." />													
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
	                                    	<th>Date</th>
		                                  	<th>No.</th>
		                                  	<th>Invoice No.</th>
		                                  	<th>AirLine</th>
											<th>PNR</th>
											<th>OrderNo</th>
											<th>Status</th>
											<th>remark</th>
											<th>Action</th>
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
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var remark = aData.remark;
           
            if(remark==null){
            	remark = "";
            }
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-bottom: 1px solid #dadada;width:10%;">Remark:</td><td style="border-bottom: 1px solid #dadada;">'+remark+'</td></tr>';
            sOut += '</table>';
            return sOut;
        };
        $("#datatable2").attr("width","100%");
        
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
        
        var peerId = "${venderId}";
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/supplierPrice/ticketAgentCheckList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
                	data.invoiceNo = $("#search_invoiceNo").val();
					data.userName = $("#search_userName").val();
					data.agentName = $("#search_agentName").val();
					data.beginningDate = $("#booking_beginningDate").val();
					data.endingDate = $("#booking_endingDate").val();
					data.type = $("#typeSpan").val();
					data.approveStatus = $("#statusSpan").val();
					data.invoiceNum = $("#search_invoiceNum").val();
				}
            },
            "columns": [
          		{ "data": "supplierPriceForOrderId"},
            	{ "data": "date"},
            	{ "data": "InvoiceNum"},
                { "data": "invoiceNo"},
                { "data": "airline"},
                { "data": "flightPnr"},
                { "data": "tempValue03"},
                { "data": "approveStatus",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'NEW';
					  		case 1 : return 'Approved(Agent)';
					  		default: return ''; 
					  	}
					}
                },
                { "data": "tempValue03" },
                { "data": "supplierPriceForOrderId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					html= '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
					+'<ul role="menu" class="dropdown-menu pull-right">'
					if(row.type==0){
						html+='<li><a href="agentTicketCheck.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Approve</a></li>'
					}
					html+='<li></ul></div>';
					return html;
                 },
				"targets" :9
		  }],
		"fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
           }
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
</script>
</script>
</body>
</html>
