[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
                    <h4><i class="fa fa-warning"></i> Warning!</h4>
                    <p> Data will be permanently deleted ?</p>
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
    <div class="container-fluid" id="pcont">
        <div class="page-head">
        	<div class="new"><button class="btn btn-success" type="button" onclick="alertApproveForm();">&nbsp;&nbsp;Approve &nbsp;&nbsp;</button></div>
        	<div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertInfoButton" data-modal="form-primary">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <h3>Bill</h3>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
            </ol>
        </div>
       <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
						<div class="tab-container">
							<ul class="nav nav-tabs">
							  <li class="active"><a href="javascript:;" onclick="javascript:window.location.href='approveIncomeForOP.jhtml'" data-toggle="tab">Income&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
							  <li><a href="javascript:;" onclick="javascript:window.location.href='approveCostForOP.jhtml'" data-toggle="tab">Cost</a></li>
							  <li><a href="javascript:;" onclick="javascript:window.location.href='approveRevisedForOP.jhtml'" data-toggle="tab">Revised Bill(Europe Tour)</a></li>
							</ul>
                        </div>
					<div class="tab-content block-flat">
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
													<input type="text" size="14" id="search_orderNo" placeholder="orderNo..." />
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_lineName" placeholder="lineName..." />
													<input type="text" size="14" id="search_op" placeholder="op..." />
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
                                    	<th width="5%"></th>
                                    	<th>OrderNo</th>
                                    	<th>Agent</th>
                                        <th>Tour Code</th>
                                        <th>Product Name</th>
                                        <th>Arrival Date</th>
                                        <th>Amount</th>
                                        <!--th>Remark</th-->
                                        <th>State</th>
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
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Verify</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="verifyFormId" action="approveIncomePassForOP.jhtml" style="border-radius: 0px;" method="post">
      	   <div id="checkId"></div>
	      <div class="modal-body form" >
	      	 <div class="form-group" style="height:80px;">
                <label class="col-sm-3 control-label">Auditing Status</label>
                <div class="col-sm-6">
				  <input class="icheck" id="pass" type="radio" name="pass" value="1" checked="" style="position: absolute; opacity: 0;">审核不通过
                  <input class="icheck" id="pass" type="radio" name="pass" value="2" checked="" style="position: absolute; opacity: 0;">审核通过
                </div>
              </div>   
	      	 <div class="form-group" style="height:100px;">
                <label class="col-sm-3 control-label">Auditing Remark</label>
                <div class="col-sm-6">
                  <textarea class="form-control" name="approveRemarkOPAcc"> </textarea>
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
                url: "[@spring.url '/admin/supplierPrice/approveIncomeForOP.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.payOrCost = 0;
					data.orderNo = $("#search_orderNo").val();
					data.tourCode = $("#search_tourCode").val();
					data.lineName = $("#search_lineName").val();
					data.userName = $("#search_op").val();
					data.code = $("#typeSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
				}
            },
            "columns": [
            	{ "data": "europeTourPriceId",
                  "render": function (data, type, row) {
                  		if(row.completeState==2){
	                     	return '<div class="radio"><input name="render" value="'+ data +'" type="checkbox"></div>';
	                     }else{
	                     	return '';
	                     }
                   }
                },
            	{ "data": "orderNo"},
            	{ "data": "agentInfo"},
                { "data": "tourCode"},
                { "data": "lineName" },
                { "data": "arriveDateTime" },
                { "data": "receivableAmount" },
                //{ "data": "remark" },
                { "data": "completeState",
                	"render" : function(data, type, row) {
					  	if(data<=2){
					  		return '<i title="New" class="fa fa-clock-o"></i>';
					  	}else{
					  		return '<i title="Approved" class="fa fa-check"></i>';
					  	}
					}},
                { "data": "europeTourPriceId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					if(row.completeState==2){
						return '<a href="approveInfoForAcc.jhtml?id='+data+'&flag=1" style="cursor:pointer">Approve</a>';
					}else{
						return '';
					}
                 },
				"targets" : 8
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
		
		function alertForm(tourId,tourCode,completeState){
			$.ajax({
				url:'billOrderListForEurope.jhtml?tourId='+tourId+'&completeState='+completeState,
				type:"GET",
				success:function(map){
					var tourFee = map.europeTourPriceList[0].actualCostForTour;
					$("#tourFee").html(tourFee);
					$("h4").html("Bill-"+tourCode);
					var str = "";
					$.each(map.europeTourPriceList,function(index,europeTourPrice){
						str+='<tr>'
									+'<td>'+europeTourPrice.orderNo+'</td>'
									+'<td>'+europeTourPrice.receivableAmount+'</td>'
									+'<td>'+europeTourPrice.remark+'<input type="hidden" name="europeTourPriceList['+index+'].europeTourPriceId" value='+europeTourPrice.europeTourPriceId+'>'
									+'<inpu>'
							+'</td></tr>';
					});
					$("#orderList").html(str);
					$("#alertBillButton").click();
				}
		});
		};
		
		function approve(){
			$("#approveForm").submit();
		}
		
		function alertApproveForm(id){
			var	length = $("input[type=checkbox][name=render]:checked").length;
	    	if(length<=0){
	    		alert("Please select the bill for auditing");
	    	}else {
				$("input[type=checkbox][name=render]:checked").each(function(){
					$("#checkId").append('<input type="hidden" name="europeTourPriceId" value="'+$(this).val()+'"/> ');
				});
				$("#europeTourPriceId").attr("value",id);
				$("#alertInfoButton").click();
			}
		}
		
		$("#OKButton").click(function(){
			$("#verifyFormId").submit();
		});
</script>
</body>
</html>
