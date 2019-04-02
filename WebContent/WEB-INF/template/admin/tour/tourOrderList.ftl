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
            <h2>Booking</h2>
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
							<a href="javascript:void(0);" class="md-trigger" data-modal="form-primary" id="triggerId"></a>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-caret-square-o-down fa-lg color-blue"></i>&nbsp;&nbsp;
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
														<span  class="unchecked"  name="stateSpan" checked="false" onclick="change(this,0);">NEW</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,2);" >Composed</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,3);" >Update</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,4);" >Cancelling by client</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,5);" >Cancelled</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="stateSpan" checked="false" onclick="change(this,6);" >Cacelling by Agent</span> 
													</a> 
													<input type="hidden" id="stateSpan"/>
												</div>
											</div>
										</div>
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Booking Time</span>:
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
													<input type="text" size="14" id="search_scheduleLineCode" placeholder="Product Code..." />
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
                            	<form action="group.jhtml" method="post">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
	                                    <tr>
	                                        <th><input id="allCheck" onclick="check(this);" type="checkbox" ></th>
	                                        <th>Booking　No.</th>
	                                        <th>Booking Time</th>
	                                        <th>Arrival Time</th>
	                                        <th>Total Passenger</th>
	                                        <th>Tour Code</th>
	                                        <th>Product Code</th>
	                                        <th>Product Name</th>
	                                        <th>Status</th>
	                                        <th>Agent</th>
	                                        <th>Office</th>
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
                url: "[@spring.url '/admin/tour/tourOrderList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNo").val();
					data.state = $("#stateSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.tourCode = $("#search_tourCode").val();
					data.scheduleLineCode = $("#search_scheduleLineCode").val();
				}
            },
            "columns": [
                { "data": "id",
                  "render": function (data, type, row) {
	                   if(row.state == 0) {
	                       return '<input class="orderCheckbox" name="orderIds" value="'+ data +'" type="checkbox">';
	                   } else {
	                   	   return '';
	                   }
                   }
                },
                { "data": "orderNo" ,
                   "render": function (data, type, row) {
	              		return "<a title='"+ row.itInfo +"' href='orderInfo.jhtml?menuId=401&id="+ row.id +"'>"+ data +"</a>";
                    }
                    },
                { "data": "createDate" },
                { "data": "arriveDateTime" },
                { "data": "totalPeople" },
                { "data": "tourCode" ,
                   "render": function (data, type, row) {
	              		return "<a href='exportCustomer.jhtml?menuId=402&tourId="+ row.tourId +"'>"+ data +"</a>";
                    }
                },
                { "data": "scheduleLineCode" },
                 { "data": "lineName" },
                { "data": "state",
					"render" : function(data, type, row) {
						if(data==0){
							return 'NEW';
						}else if(data==2){
							return 'Composed';
						}else if(data==3){
							return 'update';
						}else if(data==4){
							return 'Cancelling by client';
						}else if(data==5){
							return 'Cancelled';
						}else if(data==6){
							return 'Cacelling by Agent';
						}else{
							return '';
						}
					}
                },
                { "data": "userName" },
                { "data": "deptName" },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<a href="viewOrderCustomerList.jhtml?menuId=401&orderId='+data+'">Passenger Info</a>';
                 },
				"targets" : 11
		  }],
		  "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.id==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(1)', nRow).html("");
					$('td:eq(5)', nRow).html("");
					$('td:eq(11)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			}
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
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
    
    /* 级联选中或取消   */
    function check(check){
    	var $checks = $(".orderCheckbox");
    	if($(check).prop("checked")){
    		$checks.prop("checked",true); 
    	}else{
    		$checks.prop("checked",false);
    	}
    }
    
    /* 提交订单  */
    function submit(){
    	var length = $(".orderCheckbox:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}
		$("form").submit();
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
	$("#clearDate").click(function(){
		$("#search_beginningDate").val('');
		$("#search_endingDate").val('');
	});
	
	$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
	$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
	
	
	
	function  orderInfo(id){
    	var url="[@spring.url '/admin/tour/orderInfo.jhtml?&menuId=302&id='/]" +id;
    	window.open(url); 
    }
    
    function  test(id){
    	var url="[@spring.url '/admin/tour/orderInfo.jhtml?&frommenuId=302&id='/]" +id;
    	window.open(url); 
    }
</script>
</body>
</html>
