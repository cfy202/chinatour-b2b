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
                    <h4><i class="fa fa-warning"></i> Warning!</h4>

                    <p>Data will be permanently deleted ?</p>
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
    <div class="container-fluid" id="pcont">
        <div class="page-head">
             <h2>Bill Audit(Accountant)</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
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
												<span  class="nav-title">Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="allSpan" checked="false" onclick="change(this,0);">With Unaudited</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="allSpan" checked="false" onclick="change(this,1);" >All Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="allSpan" checked="false" onclick="change(this,2);">With Disapproved</span> 
													</a>
													<input type="hidden" id="allSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Accountant Auditing Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="accSpan" checked="false" onclick="change(this,0);">New</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="accSpan" checked="false" onclick="change(this,1);" >Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="accSpan" checked="false" onclick="change(this,2);">Disapproved</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="accSpan" checked="false" onclick="change(this,3);">Revise Auditing</span> 
													</a>
													<input type="hidden" id="accSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Revised Bill Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,1);">Auditing Approved</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="sprSpan" checked="false" onclick="change(this,2);" >Disapproved(Agent)</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,3);">Approved(Accountant)</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,4);">Disapproved(Accountant)</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,5);">Revised Bill Settled</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="sprSpan" checked="false" onclick="change(this,0);">New</span> 
													</a>
													<input type="hidden" id="sprSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">invoice</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="invSpan" checked="false" onclick="change(this,1);">Sent</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="invSpan" checked="false" onclick="change(this,0);" >Sending</span> 
													</a> 
													<input type="hidden" id="invSpan"/>
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
														<span  class="unchecked"  name="taxSpan" checked="false" onclick="change(this,0);">Settled </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,1);" >Unsettled</span> 
													</a> 
													<input type="hidden" id="taxSpan"/>
												</div>
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
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_userName" placeholder="op..." />
												</div>
											</div>
										</div>
									</div>
									<div  class="nav-panel">
										<div class="btn-cont">
											<input class="submit-btn"  type="submit" id="subId" value="OK">
										</div>
									</div>
							</div>
						</div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                    <tr>
										<th>Tour Code</th>
										<th>Arriva lDate</th>
										<th>Total Pax</th>
										<th>Accountant Auditing</th>
										<th>Status</th>
										<th>Invoice</th>
										<th>Revised Status</th>
										<th>Settlement Status</th>
										<th>OP</th>
										<th>Days</th>
										<th>Amount Receivable</th>
										<th>Amount Payable</th>
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
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
       
       $("#datatable2").attr("width","100%");
       
        /* Formating function for row details */
		function fnFormatDetails ( oTable, nTr )
		{	
			var aData = oTable.fnGetData(nTr);
			var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Days:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.dayNum+'</td></tr>';
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Amount Receivable:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.supplierPrice+'</td></tr>';
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Amount Payable:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.supplierCost+'</td></tr>';
			sOut += '</table>';
		    return sOut;
		}
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
             "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/supplierPrice/accGroupTourList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.userName = $("#search_userName").val();
					data.allCheck = $("#allSpan").val();
					data.accCheck = $("#accSpan").val();
					data.sprCheck = $("#sprSpan").val();
					data.invoiceState = $("#invSpan").val();
					data.tax = $("#taxSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
				}
            },
            "columns": [
                { "data": "tourCode" },  
                { "data": "arriveDateTime" },
                { "data": "totalPeople"},
                { "data": "accCheck" ,
                	"render": function (data, type, row) {
                		var html="recording";
                		if(data==0){
                			html="New";
                		}else if(data==1){
                			html="Approved";
                		}else if(data==2){
                			html="Disapproved";
                		}
	              			return html;
                    }
                },
                 { "data": "allCheck" ,
                	"render": function (data, type, row) {
                		var html="";
                		if(data==2){
                			html="With Disapproved";
                		}else if(data==0){
                			html="With Unaudited";
                		}else if(data==1){
                			html="All Approved";
                		}
	              			return html;
                    }
                },
                { "data": "invoiceState" ,
                	"render": function (data, type, row) {
                		var html="";
                		if(data==1){
                			html="Sent";
                		}else{
                			html="Sending";
                		}
	              			return html;
                    }
                },
         		{ "data": "sprCheck" ,
                	"render": function (data, type, row) {
                		var html="";
                			if (data==null){return html}
                		if(data.indexOf("5")>=0){
                			html="Settled";
                		}else if(data.indexOf("1")>=0){
                			html="Auditing Approved";
                		}else if(data.indexOf("3")>=0){
                			html="Approved(Accountant)";
                		}else if(data.indexOf("0")>=0){
                			html="Settled";
                		}
	              			return html;
                    }
                },
                { "data": "tax" ,
                	"render": function (data, type, row) {
                		var html="";
                		if (data==null){return html}
                		if(data.indexOf("0")>=0||data.indexOf("3")>=0){
                			html="Unsettled";
                		}else if(data.indexOf("4")>=0||data.indexOf("2")>=0){
                			html="Settled";
                		}
	              			return html;
                    }
                },
                { "data": "userName" },
                { "data": "dayNum","visible":false},
                { "data": "supplierPrice","visible":false},
                { "data": "supplierCost","visible":false},
                { "data": "supplierPriceId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="opTotalCheck.jhtml?accCheck=502&tourId='+row.tourId+'&tourCode='+row.tourCode+'"><i class="fa fa-pencil"></i>Bill Auditing Details</a></li><li><a href="accCheckAppend.jhtml?tourId='+row.tourId+'&tourCode='+row.tourCode+'"><i class="fa fa-pencil"></i>Approve</a></li><li class="divider"></li><li><a data-href="del.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
                 },
				"targets" : 12
		  }]
		  /*"fnCreatedRow": function( nRow, supplierPrice, iDataIndex ) {
				$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
				html='<div class="row icon-show" style="margin:0px;">'
								+'	<div class="fa-hover col-md-3 col-sm-4"><h4>Summary:</h4></div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Total Pax:'+supplierPrice.totalPeople+'</div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Total Income:'+supplierPrice.supplierPrice+'</div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Total Cost:'+supplierPrice.supplierCost+'</div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Profit:'+(supplierPrice.supplierPrice-supplierPrice.supplierCost)+'</div>'
						+'</div>'
						+'<div class="row icon-show" style="margin:0px;">'
								+'	<div class="fa-hover col-md-3 col-sm-4"><h4>Revised Summary:</h4></div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Total Income:'+supplierPrice.supplierDifPrice+'</div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Total Cost:'+supplierPrice.supplierDifCost+'</div>'
								+'	<div class="fa-hover col-md-2 col-sm-4">Profit:'+(supplierPrice.supplierDifPrice-supplierPrice.supplierDifCost)+'</div>'
						+'</div>';
				$('#fo-box').html(html);
		    },
			"fnDrawCallback": function() {
		    }*/
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
</script>
</body>
</html>
