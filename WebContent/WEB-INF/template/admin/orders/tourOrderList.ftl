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
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:50%;">
    <div class="md-content">
      <div class="modal-header">
        <h3>Logo</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
	     <div class="modal-body form">
	      <form action="createInvoiceToPdf.jhtml" style="border-radius: 0px;" method="post">
	    		<div class="text-center">
	    			<div>
		    			<label>
							<div id="checked" class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" checked="checked" name="logo" value="resources/images/nexus-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:40px;" src="[@spring.url '/resources/images/nexus-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="logo" value="resources/images/chinatour-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:50px;height:50px;" src="[@spring.url '/resources/images/chinatour-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="logo" value="resources/images/echinatours-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:40px;" src="[@spring.url '/resources/images/echinatours-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						
					</div>
					<br>
					<div>	
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="logo" value="resources/images/wenjing-logo.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:50px;" src="[@spring.url '/resources/images/wenjing-logo.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="logo" value="resources/images/wenjing-logo-old.png"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:50px;" src="[@spring.url '/resources/images/wenjing-logo-old.png'/]"/> &nbsp;&nbsp;
						</label>
						<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="logo" value="resources/images/logo_vancouver.jpg"
									style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							<img style="width:100px;height:50px;" src="[@spring.url '/resources/images/logo_vancouver.jpg'/]"/> &nbsp;&nbsp;
						</label>
					</div>
					<input type="hidden" id="orderTotalId" name="totalId">
					<input type="hidden" id="menuId" name="menuId" value="302">
				</div>
				<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button type="submit" class="btn btn-primary btn-flat md-close" data-dismiss="modal">OK</button>
		    	</div>
	    	</form>
	    	</div>
   </div>
</div>
<div class="md-overlay"></div>
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Booking Info</h3>
            <div class="new" style="width:300px">
            	<a href='javascript:chbox();' class="btn btn-success" >Settlement</a>
            	<a href='javascript:approveList();' class="btn btn-success" >Apply to pay</a>
            	<a id="btnPrint" href='javascript:printOrder();' class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
            </div>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="">Booking</a></li>
                <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertFormButton" data-modal="form-primary">&nbsp;&nbsp;New &nbsp;&nbsp;</a></div>
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
									<input type="hidden" id="peerUserIdSpan" value="1"/>
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
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Settlement Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="taxSpan" checked="false" onclick="change(this,0);">Unsettled</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,3);" >Settling</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,4);" >Settled</span> 
													</a> 
													<input type="hidden" id="taxSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Accountant Auditing</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="payStateSpan" checked="false" onclick="change(this,0);">New</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="payStateSpan" checked="false" onclick="change(this,1);" >Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="payStateSpan" checked="false" onclick="change(this,2);" >DisApproved</span> 
													</a> 
													<input type="hidden" id="payStateSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Accountant View Changes</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="warnStateSpan" checked="false" onclick="change(this,0);">Unrevised</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="warnStateSpan" checked="false" onclick="change(this,1);" >Checked</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="warnStateSpan" checked="false" onclick="change(this,2);" >Unchecked</span> 
													</a> 
													<input type="hidden" id="warnStateSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Booking</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="isSelfOrganizeSpan" checked="false" onclick="change(this,0);">Tour Booking</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="isSelfOrganizeSpan" checked="false" onclick="change(this,2);" >Other Booking</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="isSelfOrganizeSpan" checked="false" onclick="change(this,3);">outbound</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="isSelfOrganizeSpan" checked="false" onclick="change(this,4);" >inbound</span> 
													</a> 
													<input type="hidden" id="isSelfOrganizeSpan"/>
												</div>
											</div>
										</div>
										<!--div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Source</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="peerUserIdSpan" checked="false" onclick="change(this,1);">ERP</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="peerUserIdSpan" checked="false" onclick="change(this,2);" >B2B</span> 
													</a> 
													<input type="hidden" id="peerUserIdSpan"/>
												</div>
											</div>
										</div-->
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
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Settlement Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_settlementDateBeg" size="14"  placeholder="Beginning Date." />
													<input type="text" id="search_settlementDateEnd" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate1" class="fa fa-rotate-left" title="Clear Date"></i>
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
													<input type="text" size="14" id="search_flightPnr" placeholder="PNR..." />
													<input type="text" size="14" id="search_contact" placeholder="contacts..." />
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
												<th>Booking No. </th>
												<th>Tour Code</th>
												<th>Arrival Date</th>
												<th>Booking Date</th>
												<th>Total Passenger</th>
												<th>Status</th>
												<th>Web No</th>
												<th><input id="check-all" type="checkbox" name="checkall"/>Settle Status</th>
												<!--<th>Acc. Auditing</th>-->
												<th>Product Name</th>
												<th>Acc. View Changes</th>
												<th>Income</th>
												<th>Cost</th>
												<th>Total Profit</th>
												<th>Total Amount</th>
												<th><input id="check-allid" type="checkbox" name="checkall"/>Payment status</th>
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
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Peer:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.peerName+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">PNR:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.flightPnr+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Contacts:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.contact+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Product Name:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.lineName+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Web Order No.:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.refNo+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Acc. View Changes:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
			if(aData.warnState==0){
				sOut +=  'Unrevised';
			}else if(aData.warnState==1){
				sOut +=  'Checked';
			}else if(aData.warnState==2){
				sOut +=  'Unchecked';
			}
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
					data.tourCode = $("#search_tourCode").val();
					data.orderNo = $("#search_orderNo").val();
					data.state = $("#stateSpan").val();
					data.tax = $("#taxSpan").val();
					data.payState = $("#payStateSpan").val();
					data.warnState = $("#warnStateSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.bookingBeginningDate = $("#booking_beginningDate").val();
					data.bookingEndingDate = $("#booking_endingDate").val();
					data.settlementDateBeg = $("#search_settlementDateBeg").val();
	                data.settlementDateEnd = $("#search_settlementDateEnd").val();
	                data.isSelfOrganize = $("#isSelfOrganizeSpan").val();
	                data.peerId = $("#search_peer").val();
	                data.flightPnr = $("#search_flightPnr").val();
	                data.contact = $("#search_contact").val();
	                data.sorceId = $("#peerUserIdSpan").val();
	                data.refNo=$("#search_webOrderNo").val();
				}
            },
            "columns": [
                { "data": "id"},
                { "data": "orderNo",
                	"render" : function(data, type, row) {
						if(row.orderNoIn==''){
							return row.orderNo;
						}else{
							return '<i title="From Web" class="fa fa-chain" style="display: inline"/>'+row.orderNo+'';
						}
					}
                },
                { "data": "tourCode" ,
                	"render" : function(data, type, row) {
						if(data==null){
							return '';
						}else{
							return '<a href="${base}/admin/payCostRecords/viewOrdersByTour.jhtml?tourId='+row.tourId+'&orderId='+row.id+'">'+data+'</a>';
						}
					}
                },
                { "data": "scheduleOfArriveTime" },
                { "data": "createDate" },
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
                { "data": "refNo" },
                { "data": "tax",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return '<div class="radio"><input type="checkbox"  name="ordersTotalIds" value="'+row.ordersTotalId+'" class="icheck"/><i title="Unsettled" class="fa fa-times"></i></div>';
					  		case 2 : return '<i title="Settled Not Sent 0.05Invoice" class="fa fa-check"></i>'; 
					  		case 3 : return '<i title="Settling" class="fa fa-clock-o"></i>';
					  		case 4 : return '<i title="Settled And Sent 0.05Invoice" class="fa fa-check"></i>'; 
					  		default: return ''; 
					  	}
					}
                },
               /* { "data": "payState",
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return 'New';
					  		case 1 : return 'Approved';
					  		case 2 : return 'Disapproved';
					  		default: return ''; 
					  	}
					}
                },*/
                { "data": "lineName","visible":false },
                { "data": "warnState","visible":false},
                { "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return data.payTotalSum
						}else{
							return '0';
						}
					}
				},
                { "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return data.costTotalSum
						}else{
							return '0';
						}
					}
				},
				{ "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return (data.payTotalSum-data.costTotalSum).toFixed(2)
						}else{
							return '0';
						}
					}
				},
                { "data": "sumFee"},
                { "data": "costState",
                "render":function(data, type, row) {
                	if(row.peerName==null){
							return '';
						}else{
							if(data==1){
								return '<div class="radio" id="'+row.id+'pay"><i title="Paying" class="fa fa-clock-o"></i></div>';
							}else if(data==2){
								return '<div class="radio" id="'+row.id+'pay"><i title="Paid" class="fa fa-check"></i></div>';
							}else{
								return '<div class="radios" id="'+row.id+'pay"><input type="checkbox"  name="ordersIds" value="'+row.id+'" class="icheck"/>New</div>';
							}
						}
					}
                },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
						html='<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span>'
						+'<span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">'
						+'<li><a style="cursor:pointer;" href="customers.jhtml?menuId=303&id='+data+'"><i class="fa fa-pencil"></i>Passenger Info</a></li>'
						+'<li><a style="cursor:pointer;" href="editPayCost.jhtml?menuId=303&id='+data+'&totalId=pay"><i class="fa fa-pencil"></i>Income/Cost</a></li>'
						+'<li><a style="cursor:pointer;" href="[@spring.url '/admin/payCostRecords/agentSettlementOrdersTotal.jhtml'/]?menuId=303&ordersTotalId='+row.ordersTotalId+'&userId='+row.userId+'"><i class="fa fa-pencil"></i>Settlement</a></li>';
						if(row.orderType==5){
							html+='<li><a style="cursor:pointer;" href="singleOrderEdit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>';
						}else{
							if((row.state == 6)||(row.state == 5)){
								[#list ["admin:Office"] as permission]
									[@shiro.hasPermission name = permission]
									html+='<li><a style="cursor:pointer;" href="tourOrderEdit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>';
									[/@shiro.hasPermission]
								[/#list]
							}else{
								html+='<li><a style="cursor:pointer;" href="tourOrderEdit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>';
							}
							/*if(row.orderType==2){
								html+='<li><a style="cursor:pointer;" href="javascript:;" onclick="changePUser(\''+data+'\')"><i class="fa fa-pencil"></i>To Agency Order</a></li>';
							}*/
						}
						if(row.peerName!=null){
							html+='<li><a id="'+data+'_button" style="cursor:pointer;"href="javascript:agencyPay(\''+data+'\',1);"><i class="fa fa-pencil"></i>Apply to pay</a></li>';
						}
						html+='<li><a href="invoiceForChild.jhtml?id='+data+'" target="_blank"><i class="fa fa-print"></i>Invoice</a></li>'
						html+='<li><a href="${base}/admin/payCostRecords/settlementOrdersTotal.jhtml?ordersTotalId='+row.ordersTotalId+'&userId='+row.userId+'" target="_blank"><i class="fa fa-print"></i>Print Settlement</a></li>'
						if((row.state == 6)||(row.state == 5)){
							html+='<li class="divider"></li><li><a id="'+data+'_button" style="cursor:pointer;" href="javascript:recoverOrder(\''+data+'_button\',\''+data+'\',\''+row.tourId+'\');"><i class="fa fa-mail-reply"></i>Recover</a></li></ul></div>';
						}else{
							if(row.orderType!=5){
								html+='<li><a style="cursor:pointer;" onclick="isChanged(\''+data+'\')"><i class="fa fa-eye"></i>Tour Voucher</a></li>';
							}if(row.itInfo == 1){
								html+='<li><a href="createOldPdfOfOpConfirm.jhtml?id='+data+'" target="_blank"><i class="fa fa-eye"></i>Final Voucher</a></li>';
							}
							html+='<li class="divider"></li><li><a id="'+data+'_button" style="cursor:pointer;"href="javascript:cancelOrder(\''+data+'_button\',\''+data+'\',\''+row.tourId+'\');"><i class="fa fa-times"></i>Cancel</a></li></ul></div>';
						}
						return html;
                 },
				"targets" : 16
		   }],
		   "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
           },
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.id==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(1)', nRow).html("");
					$('td:eq(14)', nRow).html("");
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
	/* 取消订单  */
	function cancelOrder(buttonId, orderId, tourId){
		$.post("asynchronousCancelOrder.jhtml",{"orderId" : orderId},function(result){
			if(result == 'success'){
				var $a = $("#" + buttonId);
				var $buttonLi = $a.parent();
				var $stateTd = $buttonLi.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev();
				if(tourId == ''){
				//如果订单未组团
					$a.attr("href","javascript:recoverOrder('"+ buttonId +"','"+ orderId +"','" + tourId +"');");
					$a.html("<i class='fa fa-mail-reply'></i>Recover");
					$stateTd.html("<span class='color-danger'>CANCELLED</span>");
					alert('Cancel Booking completed!');
				}else{
				//如果订单已组团
					$buttonLi.prev().remove();					
					$buttonLi.remove();
					$stateTd.html("<span class='color-warning'>CANCELLING</span>");
					alert('Cancelling Booking!');
				}
			}
		}); 
	}
	
	/* 恢复订单  */
	function recoverOrder(buttonId, orderId, tourId){
		$.post("asynchronousRecoverOrder.jhtml",{"orderId" : orderId},function(result){
			if(result == 'success'){
				var $a = $("#" + buttonId);
				var $buttonLi = $a.parent();
				var $stateTd = $buttonLi.parent().parent().parent().prev().prev().prev().prev().prev().prev().prev();
				if(tourId == ''){
				//如果订单未组团
					$a.attr("href","javascript:cancelOrder('"+ buttonId +"','"+ orderId +"','" + tourId +"');");
					$a.html("<i class='fa fa-times'></i>Cancel");
					$stateTd.html("<span class='color-warning'>NEW</span>");
					alert('Recoverd Booking completed!');
				}else{
				//如果订单已组团
					$buttonLi.prev().remove();					
					$buttonLi.remove();
					$stateTd.html("<span class='color-warning'>RECOVERING</span>");
					alert('Recovering Booking!');						
				}
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
	    if(isSelfOrganize==1&&tax==4){
	    	 var tax =2;
	    	 var url="?tourCode="+tourCode+"&orderNo="+orderNo+"&tax="+tax+"&state="+state+"&beginningDate="+beginningDate;
	   		 url+="&endingDate="+endingDate+"&settlementDateBeg="+settlementDateBeg+"&settlementDateEnd="+settlementDateEnd+"&isSelfOrganize="+isSelfOrganize;
	    	 url+="&bookingBeginningDate="+bookingBeginningDate+"&bookingEndingDate="+bookingEndingDate+"&payState="+payState+"&warnState="+warnState+"&flightPnr="+flightPnr+"&contact="+contact;
	    	window.open("[@spring.url '/admin/orders/findTourOrderListVOPrint.jhtml'/]"+url);
	    }else{
	    	window.open("[@spring.url '/admin/orders/findTourOrderListVOPrint.jhtml'/]"+url);
	    }
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
     /*同行申请支付*/
    function agencyPay(orderId,state){
    	$.post("agencyPay.jhtml",{"orderId" : orderId,"state":state},function(result){
			if(result == 'success'){
				$("#"+orderId+"pay").html('<i title="Approving" class="fa fa-clock-o"></i>');
	    		alert("success");
			}
		}); 
    }
    /*批量支付*/
      function approveList(){
		var length = $("input[name='ordersIds']:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}else{
			if(confirm("Whether apply to pay the selected orders？")){
			    $("input[name='ordersIds']:checked").each(function(){
					var orderId=$(this).val();
					$.post("agencyPay.jhtml",{"orderId" : orderId,"state":1},function(result){
						if(result == 'success'){
							$("#"+orderId+"pay").html('<i title="Approving" class="fa fa-clock-o"></i>');
						}
					});
				});
		   }
		}
	}
	function changePUser(id){
	 var com=prompt("Enter Commission","0");
		if(com>=0){
			$.post('changePUser.jhtml',{'orderId':id,'commission':com},function(result){
				if(result=='success'){
					location.reload();
				}else{
					alert('This order no peer users!');
				}
			});
		}
	}
	
	function alertForm(object){
    	$("#alertFormButton").click();
    	totalId = $(object).find("input").val();
    	$("#orderTotalId").attr("value",totalId);
    }
</script>
</body>
</html>
