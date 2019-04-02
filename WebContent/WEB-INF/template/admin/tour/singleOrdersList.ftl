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
                    <h4><i class="fa fa-warning"></i> Warning !</h4>

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
            <h2>Tour Compose</h2>
            <div class="new"><button class="btn btn-success" type="button" onclick="submit();">Tour Compose</button></div>
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
							<!--模拟点击弹出框按钮-->
							<a href="javascript:void(0);" class="md-trigger" data-modal="form-info" id="triggerId"></a>
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
														<span  class="unchecked"  name="stateSpan" checked="false" onclick="change(this,2);">Composed </span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,4);" >Cancelling</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,5);" >Cancelled</span> 
													</a> 
													<input type="hidden" id="stateSpan"/>
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
                            	<form id="singleGroupForm" action="singleGroup.jhtml" method="post">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
	                                    <tr>
	                                        <th><input id="check-all" type="checkbox" name="checkall" /></th>
	                                        <th>Booking No.</th>
	                                        <th>Booking Time</th>
	                                        <th>Total Passenger</th>
	                                        <th>Tour Code</th>
	                                        <th>Status</th>
	                                        <th>Agent</th>
	                                        <th>Action</th>
	                                    </tr>
	                                    </thead>
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
<!-- modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-info" style=" width: 60%; max-height: 550px;">
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
<!-- /.modal -->
<div class="md-overlay"></div>
<!-- Modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
	<div class="md-content">
		<div class="modal-header">
			<h3>New Tour</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form class="form-horizontal group-border-dashed" id="formId" action="saveSingleTour.jhtml" method="post" parsley-validate novalidate>
			<div class="modal-body form">
				<input id="existTourId" type="hidden" name="existTourId">
				<div class="form-group">
					<label>Arrival Date:</label> 
					<div class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
						<input name="arriveDateTime" class="form-control" readonly="readonly" type="text" size="16">
						<span class="input-group-addon btn btn-primary">
							<span class="glyphicon glyphicon-th"></span>
						</span>
					</div>
				</div> 
				<div class="form-group">
					<label>Product Name</label> <input type="text" name="lineName" value="" class="form-control" placeholder="country of passport">
				</div>
				<div class="form-group">
					<label>Product Code</label> <input type="text" name="lineCode" value="" class="form-control" placeholder="country of passport">
				</div>
				<div class="form-group">
					<label>Tour Code</label> <input type="text" name="tourCode" value="" onkeyup="checkTourCode(this);" class="form-control" placeholder="country of passport">
				</div>
				<div class="row">
				<div class="form-group col-md-12 no-margin">
					<label>Tour Compose Type</label>
				</div>
				<div id="result" class="col-sm-6"></div>
			</div>
			<div style="display:none;" id="fromCentId"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal"  data-toggle="modal">Proceed</button>
				<div style="display:none;"><button type="button" id="btn" class="btn btn-primary btn-flat md-trigger" data-toggle="modal" data-modal="form-primary"></button></div>
			</div>
		</form>
	</div>
</div>
<!-- /.modal -->
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
                url: "[@spring.url '/admin/tour/singleOrdersList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNo").val();
					data.tourCode = $("#search_tourCode").val();
					data.state = $("#stateSpan").val();
				}
            },
            "columns": [
                { "data": "id",
                  "render": function (data, type, row) {
	                   if(row.state == 0) {
	                       return '<div class="item"><div><input type="checkbox" class="orderCheckbox" name="orderIds" value="'+ data +'"/></div></div>';
	                   } else {
	                   	   return '';
	                   }
                   }
                },
                { "data": "orderNo" },
                { "data": "createDate" },
                { "data": "totalPeople" },
                { "data": "tourCode" ,
                   "render": function (data, type, row) {
	              		return "<a href='tourCustomerList.jhtml?menuId=405&tourId="+ row.tourId +"'>"+ data +"</a>";
                    }
                },
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
                { "data": "userId" },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<a href="javascript:void(0);" data-modal="form-primary" onclick="addForm(\''+data+'\');">Passenger Info</a>';
                 },
				"targets" : 7
		  }]
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
    
    //全选或不全选
    $("#check-all").on('ifChanged',function(){
        var checkboxes = $(".item").find(':checkbox');
        if($(this).is(':checked')) {
            checkboxes.iCheck('check');
        } else {
            checkboxes.iCheck('uncheck');
        }
      });
    
    function submit(){
    	var length = $(".orderCheckbox:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}
		$("#singleGroupForm").submit();
    }
    
    function checkTourCode(tourCodeInput){
    	var tourCode = $(tourCodeInput).val();
    	var $groupType = $("#result");
    	var $form = $("form");
    	if(tourCode == ''){
    	    $groupType.empty();
    		$groupType.append("Available tour code, new compose ！");
    		$form.attr("action","saveSingleTour.jhtml");
    		return;
    	}
	    $.post("checkTourCode.jhtml", {"tourCode":tourCode}, function(tour){
	    	$groupType.empty();
	    	if(tour == ''){
	    		$groupType.append("Available tour code, new compose ！");
	    		$form.attr("action","saveSingleTour.jhtml");
	    	}else{
	    		$groupType.append("Existed tour code, please join in ！");
	    		$("#existTourId").val(tour.tourId);
	    		chooseType(tour.type);
	    		$("input[name='arriveDateTime']").val(tour.arriveDateTime);
	    		$("input[name='lineName']").val(tour.lineName);
	    		$("input[name='lineCode']").val(tour.lineCode);
	    		$("input[name='tourCode']").val(tour.tourCode);
	    		$form.attr("action","addOrders");
	    	}
		});
    }
    
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
                  	  	html +="<td>Cancelled</td>";
                  	  }else{
                  	  	html +="<td>Cancelling</td>";
                  	  }
					html +='<td>'+entry.customerOrderNo+'</td>'+
							'<td>'+entry.tourCode+'</td>'+
							'<td>'+entry.orderNo+'</td>'+
							'<td>'+entry.lastName+'</td>'+
							'<td>'+entry.firstName+'</td>'+
							'<td>'+middleName+'</td>'+
							'<td>'+entry.agent+'</td>'+
						'</tr>';
				});
				$("#tbodyId").empty();
				$("#tbodyId").append(html);
				$("#triggerId").trigger("click");
			}
		});
	}
</script>
</body>
</html>
