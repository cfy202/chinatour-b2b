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
            <h2>Tour List</h2>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertBillButton" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
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
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-caret-square-o-down fa-lg color-blue"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="margin:10px; padding:5px 0;">
									<div  class="nav-panel">
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
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_lineName" placeholder="lineName..." />
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
                                        <th>Tour Code</th>
                                        <th>Product Name</th>
                                        <th>Arrival Date</th>
                                       	<th>State(bill)</th>
                                       	<th>State(settlement-OP)</th>
                                       	<th>State(settlement-Acc)</th>
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


<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:50%;">
    <div class="md-content">
      <div class="modal-header">
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 id="billHead">Bill</h4>
      </div>
	     <div class="modal-body form">
	      <form action="saveEuropeTourPrice.jhtml" id="saveEuropeTourPriceForm" style="border-radius: 0px;" method="post">
	    		<div   id="orderList">
	    		</div>
	     </form>
	    		<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button id="submitButtonForAddAcc" class="btn btn-default btn-flat md-close" data-dismiss="modal" onclick="saveEuropeTourPrice()">Save</button>
			        <button id="submitButtonForAddAcc" class="btn btn-default btn-flat md-close" data-dismiss="modal" onclick="completeEuropeTourPrice()">Complete</button>
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
       
       $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bSort":false,
            "bFilter":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/supplierPrice/billListForEurope.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.lineName = $("#search_lineName").val();
					data.userName = $("#search_op").val();
					data.code = $("#typeSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
				}
            },
            "columns": [
                { "data": "tourCode"},
                { "data": "lineName" },
                { "data": "arriveDateTime" },
                { "data": "state",
                	"render" : function(data, type, row) {
					  		if(data==1){
					  			return '<i title="Billed" class="fa fa-check"></i>';
					  		}else{
					  			return '<i title="New" class="fa fa-clock-o"></i>';
					  		}
					}},
				{ "data": "completeState",
                	"render" : function(data, type, row) {
					  		if(data==4){
					  			return '<i title="Settled" class="fa fa-check"></i>';
					  		}else{
					  			return '<i title="Unsettle" class="fa fa-clock-o"></i>';
					  		}
					}},
				{ "data": "completeState",
                	"render" : function(data, type, row) {
					  		if(data==5){
					  			return '<i title="Settled" class="fa fa-check"></i>';
					  		}else{
					  			return '<i title="Unsettle" class="fa fa-clock-o"></i>';
					  		}
					}},
                { "data": "tourId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<a href="settleForOPPage.jhtml?id='+data+'">Income/Cost</a>';
                 },
				"targets" : 6
		  }],
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
         $('#confirm-upload').on('show.bs.modal', function (e) {
            $(this).find('#formId').attr('action', $('#upload').data('href'));
        });
        $("div.options").hide();//默认隐藏 筛选 div
		
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-caret-square-o-up fa-lg color-blue"){
				_slide.removeClass("fa fa-caret-square-o-up fa-lg color-blue").addClass("fa fa-caret-square-o-down fa-lg color-blue");
			}else{
				_slide.removeClass("fa fa-caret-square-o-down fa-lg color-blue").addClass("fa fa-caret-square-o-up fa-lg color-blue");
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
		
		function alertIncomeForm(tourId,tourCode,completeState){
			if(completeState=="null"){
				completeState=0;
			}
			$.ajax({
				url:'billOrderListForEurope.jhtml?tourId='+tourId+'&completeState='+completeState+'&payOrCost=0',
				type:"GET",
				success:function(map){
					$("#billHead").html("Bill-"+tourCode);
					var str = "";
					str+=		'<table style="margin-top:20px;">'
					    				+'<thead>'
						    				+'<tr>'
						    					+'<th style="width:20%;font-size:14px;font-weight:bold;" >OrderNo</th>'
						    					+'<th style="width:20%;text-align:center;font-size:14px;font-weight:bold;" >Income</th>'
						    					+'<th style="width:40%;text-align:center;font-size:14px;font-weight:bold;" >Remark</th>'
						    				+'</tr>'
					    				+'</thead>'
					    				+'<tbody>';
					$.each(map.orderList,function(index,order){
									str+='<tr>'
									+'<td>'+order.orderNo+'</td>'
									+'<td><input class="form-control" type="text" name="europeTourPriceList['+index+'].receivableAmount" value="0"></td>'
									+'<td><input class="form-control" type="text" name="europeTourPriceList['+index+'].remark">'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].orderId" value='+order.id+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].deptIdForOrder" value='+order.deptId+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].userIdForOrder" value='+order.userId+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].userIdForTour" value='+map.tour.userId+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].deptIdForTour" value='+map.tour.deptId+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].payOrCost" value="0">'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].tourCode" value='+map.tour.tourCode+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].orderNo" value='+order.orderNo+'>'
									+'<input class="form-control" type="hidden" name="europeTourPriceList['+index+'].tourId" value='+map.tour.tourId+'>'
							+'</td></tr>';
							
					});
					str+='</tbody>'
	    			+'</table>';
					$("#orderList").html(str);
					$("#alertBillButton").click();
				}
		});
		};
		
		function saveEuropeTourPrice(){
			$("#saveEuropeTourPriceForm").submit();
		}
		
		function completeEuropeTourPrice(){
			$("#saveEuropeTourPriceForm").attr("action","saveEuropeTourCost.jhtml");
			$("#saveEuropeTourPriceForm").submit();
		}
		
		//审核花费
		function alertCostForm(tourId,tourCode,completeState){
			if(completeState=="null"){
				completeState=0;
			}
			str = '<table><tr><td style="width:10%;">Cost:</td><td style="width:40%;"><input class="form-control" type="text" name="receivableAmount"><input type="hidden" name="tourId" value='+tourId+'><input type="hidden" name="tourCode" value='+tourCode+'></td><td style="width:10%;">remark:</td><td style="width:40%;"><input class="form-control" type="text" name="remark"></td></tr></table>'
							
			$("#billHead").html("Bill-"+tourCode);
			$("#orderList").html(str);
			$("#alertBillButton").click();
		};
</script>
</body>
</html>
