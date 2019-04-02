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
            <div class="pull-right option-left"> <a style="cursor:pointer;" href="javascript:void(0);" class="md-trigger"></a><button  id="pay" class="btn btn-success" type="button" onclick="location.href='${base}/admin/supplierPrice/addBill.jhtml'">&nbsp;&nbsp; FIT Ticket&nbsp;&nbsp;</button><a style="cursor:pointer;" href="javascript:void(0);" class="md-trigger"></a><button  id="pay" class="btn btn-success" type="button" onclick="location.href='${base}/admin/supplierPrice/addGroupTicket.jhtml'">&nbsp;&nbsp; GIT Ticket&nbsp;&nbsp;</button>
            	<a href='javascript:chbox();' class="btn btn-success" >Ticket Adult</a>
            	<a class="btn" href="javascript:explorBill();" title="Export Bill"><i class="fa fa-share-square-o" ></i></a></div>
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
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Class</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" >
														<span  class="unchecked"  name="classSpan" checked="false" onclick="change(this,'E');">Economy</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="classSpan" checked="false" onclick="change(this,'B');" >Bussiness</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="classSpan" checked="false" onclick="change(this,'P');" >Premium</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" >
														<span  class="unchecked"  name="classSpan" checked="false" onclick="change(this,'F');">First Class</span> 
													</a>
													<input type="hidden" id="classSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,0);" >NEW</span> 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,1);" >Approved</span>
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,2);" >Completed</span>  
													</a> 
													<input type="hidden" id="statusSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">System</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="systemSpan" checked="false" onclick="change(this,'A');" >Amadeus</span> 
														<span  class="unchecked" name="systemSpan" checked="false" onclick="change(this,'S');" >Sabre</span> 
													</a> 
													<input type="hidden" id="systemSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Destination</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="desSpan" checked="false" onclick="change(this,'I');" >International</span> 
														<span  class="unchecked" name="desSpan" checked="false" onclick="change(this,'D.');" >Domestic.</span> 
													</a> 
													<input type="hidden" id="desSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Method</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="ticketType" checked="false" onclick="change(this,'T');" >Ticketing</span> 
														<span  class="unchecked" name="ticketType" checked="false" onclick="change(this,'E');" >Exchange</span> 
														<span  class="unchecked" name="ticketType" checked="false" onclick="change(this,'R');" >Refund</span>
														<span  class="unchecked" name="ticketType" checked="false" onclick="change(this,'V');" >Void</span>
														<span  class="unchecked" name="ticketType" checked="false" onclick="change(this,'TC');" >TC</span>
													</a> 
													<input type="hidden" id="ticketType"/>
												</div>
											</div>
										</div>
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="booking_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="booking_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate2" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Departure Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="arrival_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="arrival_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-3-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_InvoiceNum" placeholder="No..." />
													<input type="text" size="14" id="search_pnr" placeholder="PNR..." />
													<input type="text" size="14" id="search_agentName" placeholder="Agent..." />
													<input type="text" size="14" id="search_dept" placeholder="Dept..." />
													<input type="text" size="14" id="search_ticketNo" placeholder="TicketNo..." />
													<input type="text" size="14" id="search_airLine" placeholder="AirLine..." />
													<input type="text" size="14" id="search_userName" placeholder="User Name..." /><br/>
													<input type="text" size="14" id="search_Arc" placeholder="ARC..." />
													<input type="text" size="14" id="search_name" placeholder="Name" />
													<input type="text" size="14" id="search_card" placeholder="Card" />
													<input type="text" size="14" id="search_agency" placeholder="Agency" />
													<input type="text" size="14" id="search_invoiceNo" placeholder="Invoice No." />
													<input type="text" size="14" id="search_orderNo" placeholder="Order Number" />
													<input type="text" size="14" id="search_locator" placeholder="Locator" />
													
													<input type="hidden" size="14" id="search_charge" placeholder="Charge..." />
													<input type="hidden" size="14" id="search_amount" placeholder="Selling..." />
													<input type="hidden" size="14" id="search_operatorFee" placeholder="Net..." />
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
                        	<form method="post" id="AdultTicketId" action="[@spring.url '/admin/supplierPrice/AdultTicketAll.jhtml?menuId=303'/]">
	                            <div class="table-responsive">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
		                                    	<th></th>
		                                    	<th>No.</th>
		                                    	<th>Date</th>
			                                  	<th>Qty.</th>
			                                  	<th>AirLine</th>
			                                  	<!-- <th>PNR</th> -->
			                                  	<th>Net</th>
			                                  	<th>ARC</th>
			                                  	<th>Total</th>
			                                  	<th>Bill/Credit</th>
		                                  		<th>Profit</th>
		                                  		<th>Class</th>
		                                  		<th>DES</th>
		                                  		<th>Method</th>
												<th>Agent</th>
												<th>Dept</th>
												<th><input id="check-all" type="checkbox" name="checkall" value="" />Status</th>
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
        
        $('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	        radioClass: 'iradio_square-blue'
	      });
        
        $("#datatable2").attr("width","100%");
        var peerId = "${venderId}";
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/supplierPrice/ticketList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
                	data.invoiceNo = $("#search_invoiceNo").val();
                	data.tempValue03 = $("#search_orderNo").val();//订单号
					data.flightPnr = $("#search_pnr").val();   //pnr
					data.agentName = $("#search_agentName").val();
					data.beginningDate = $("#booking_beginningDate").val();
					data.endingDate = $("#booking_endingDate").val();
					data.arrivalBeginningDate = $("#arrival_beginningDate").val();
					data.arrivalEndingDate = $("#arrival_endingDate").val();
					data.type = $("#typeSpan").val();
					data.approveStatus = $("#statusSpan").val();
					data.system = $("#systemSpan").val();		//dateTable draw()重绘表格
					data.ticketNo = $("#search_ticketNo").val();
					data.airline = $("#search_airLine").val();
					data.tempValue04 = $("#classSpan").val();
					data.charge = $("#search_charge").val();
					data.amount = $("#search_amount").val();
					data.tempValue06 = $("#search_Arc").val();
					data.operatorFee = $("#search_operatorFee").val();
					data.tempValue05 = $("#desSpan").val();
					data.deptName = $("#search_dept").val();
					data.accRemarkOfOp = $("#search_name").val();
					data.card = $("#search_card").val();
					data.venderName = $("#search_agency").val();
					data.InvoiceNum=$("#search_InvoiceNum").val();
					data.TicketType=$("#ticketType").val();
					data.Locator=$("#search_locator").val();
					data.userName=$("#search_userName").val();
				}
            },
            "columns": [
            	{ "data": null },
            	{ "data": "InvoiceNum"},
            	{ "data": "date"},
                { "data": "quantity"},
                { "data": "airline"},
                /*{ "data": "flightPnr"},*/
                { "data": "net"},
                { "data": "tempValue06"},
                { "data": "operatorFee"},
                { "data": "supplierPriceForOrderId",
					"render":function(data, type, row) {
						return (row.amount-row.charge).toFixed(2)
					}
				},
           		/*{ "data": "supplierPriceForOrderId",
					"render":function(data, type, row) {
						return (row.operatorFee-row.charge).toFixed(2)
					}
				},*/
				{ "data": "supplierPriceForOrderId",
					"render":function(data, type, row) {
						return (row.amount-row.operatorFee).toFixed(2)
					}
				},
				{ "data": "tempValue04"},
				{ "data": "tempValue05"},
				{ "data": "TicketType",
					"render" : function(data, type, row) {
					  	if(data=="T"){
					  		return "T";
					  	}else if(data=="E"){
					  		return "E";
					  	}else if(data=="R"){
					  		return "R";
					  	}else if(data=="V"){
					  		return "V";
					  	}else if(data=="TC"){
					  		return "TC";
					  	}else{
					  		return "";
					  	}
					}
                },
                /*{ "data": "flightPnr"},*/
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
                { "data": "tempValue01" },
                { "data": "deptName" },
                { "data": "approveStatus",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return "<div class='radio'><input type='checkbox'  name='approveStatusId' value='"+row.supplierPriceForOrderId+"' class='icheck'/>NEW</div>";
					  		case 1 : return "<div class='radio'><input type='checkbox'  name='approveStatusId' value='"+row.supplierPriceForOrderId+"' class='icheck'/>Approved</div>";
					  		case 2 : return 'Completed';
					  		default: return ''; 
					  	}
					}
                },
                { "data": "supplierPriceForOrderId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					html= '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
					+'<ul role="menu" class="dropdown-menu pull-right">'
					+'<li><a href="editBill.jhtml?id='+data+'"></i><i class="fa fa-print"></i>edit</a></li><li class="divider"></li>'
					+'<li><a href="invoiceForTicket.jhtml?id='+data+'" target="_blank"><i class="fa fa-print"></i>Invoice</a></li>'
					+'<li><a data-href="del.jhtml?supplierPriceForOrderId='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
					return html;
                 },
				"targets" :16
		  }]
		  ,
		  "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.supplierPriceForOrderId==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(16)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			},
		    "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
            }
        });
          /* Formating function for row details*/
        function fnFormatDetails ( oTable, nTr )
        {	
          var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Name:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.accRemarkOfOp+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Card:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.card+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Departure Date:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.arriveDate+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Agency:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
            if(aData.venderName!=null){
            	sOut +=aData.venderName;
            }
            sOut += '</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Remark:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.remark+'</td></tr>';
            /*sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">System:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
            if(aData.System=="A"){
            	sOut +="Amadeus";
            }else if(aData.System=="S"){
            	sOut +="Sabre";
            }else{
            	sOut +="";
            }*/
            /*sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Invoice No.:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.invoiceNo+'</td></tr>';*/
            if(aData.tempValue03!="Search OrderNo"){
            	sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Order Number:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.tempValue03+'</td></tr>';
            }else{
            	sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Order Number:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;"></td></tr>';
            }
            sOut += '</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">User Name.:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.userName+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">LOCATOR:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.locator+'</td></tr>';
            sOut += '</table>';
            return sOut;
        } 
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
        
        $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
		$('.dataTables_length select').addClass('form-control');        
        
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
			$("#arrival_beginningDate").val('');
 			$("#arrival_endingDate").val('');
		});
		
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#arrival_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#arrival_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
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
	        var invoiceNo = $("#search_invoiceNo").val();
			var userName = $("#search_userName").val();
			var agentName = $("#search_agentName").val();
			var beginningDate = $("#booking_beginningDate").val();
			var endingDate = $("#booking_endingDate").val();
			var arrivalBeginningDate = $("#arrival_beginningDate").val();
			var arrivalEndingDate = $("#arrival_endingDate").val();
			var type = $("#typeSpan").val();
			var ticketType = $("#ticketType").val();
			var approveStatus = $("#statusSpan").val();
			var ticketNo = $("#search_ticketNo").val();
			var airline = $("#search_airLine").val();
			var tempValue04 = $("#classSpan").val();
			var charge = $("#search_charge").val();
			var amount = $("#search_amount").val();
			var operatorFee = $("#search_operatorFee").val();
			var tempValue05 = $("#desSpan").val();
			var deptName = $("#search_dept").val();
			var accRemarkOfOp = $("#search_name").val();
			var card = $("#search_card").val();
			var venderName = $("#search_agency").val();
			var InvoiceNum=$("#search_InvoiceNum").val();
			html="invoiceNo="+invoiceNo+"&userName="+userName+"&agentName="+agentName+"&beginningDate="+beginningDate+"&endingDate="+endingDate+"&tempValue05="+tempValue05+"&deptName="+deptName+"&accRemarkOfOp="+accRemarkOfOp+"&arrivalBeginningDate="+arrivalBeginningDate+"&arrivalEndingDate="+arrivalEndingDate;
			html+="&InvoiceNum="+InvoiceNum+"&type="+type+"&approveStatus="+approveStatus+"&ticketNo="+ticketNo+"&airline="+airline+"&tempValue04="+tempValue04+"&charge="+charge+"&amount="+amount+"&operatorFee="+operatorFee+"&card="+card+"&venderName="+venderName+"&ticketType="+ticketType;
    		location.href="${base}/admin/supplierPrice/excelForAirItem.jhtml?"+html;
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
			var length = $("input[name='approveStatusId']:checked").size();
			if(length == 0){
				alert("Select Ticket Bill");
				return;
			}
			$("#AdultTicketId").submit();
		}
</script>
</script>
</body>
</html>
