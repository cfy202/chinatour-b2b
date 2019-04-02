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
           <h2>Product List</h2>
            <div class="new">
				<button type="button" onclick="getTourType();" data-modal="groupLineForm" class="btn btn-success btn-flat md-trigger" >AND NEW</button>&nbsp;&nbsp;
            	<a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
            </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Booking</a></li>
            </ol>
	    </div>
	    <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
						<ul class="nav nav-tabs">
							<li class="active"><a data-toggle="tab">chinatour</a></li>
							<li><a onclick="javascript:window.location.href='groupLine.jhtml?brand=中国美&ordersTotalId=${ordersTotalId}'" data-toggle="tab">中国美</a></li>
							<li><a onclick="javascript:window.location.href='groupLine.jhtml?brand=文景假期&ordersTotalId=${ordersTotalId}'" data-toggle="tab">文景假期</a></li>
							<li><a onclick="javascript:window.location.href='groupLine.jhtml?brand=InterTrips&ordersTotalId=${ordersTotalId}'" data-toggle="tab">InterTrips</a></li>
							<li><a onclick="javascript:window.location.href='groupLine.jhtml?brand=inbound&ordersTotalId=${ordersTotalId}'" data-toggle="tab">inbound</a></li>
						</ul>
				        <div class="params-cont" style="text-align: right;"> 
				        	<!--<select id="tourTypeSelect" name="tourTypeId" onchange="changeGroupline(this);">
				        		[#list tourTypeList as tourType]
				        			<option value="${tourType.tourTypeId}" type="${tourType.type}">${tourType.typeName}</option>
				        		[/#list]
				        		<option value="other">Other</option>
				        	</select>-->
				        	<select id="operaterSelect" name="tourTypeId" onchange="changeOperater(this);">
				        		[#list operaterList as operater]
				        			<option value="${operater}" type="${operater}">${operater}</option>
				        		[/#list]
				        	</select>
				        	<select id="sourceSelect" name="tourTypeId" onchange="changeSource(this);">
				        		[#list venderList as source]
				        			<option value="${source}" type="${source}">${source}</option>
				        		[/#list]
				        		<option value="other">Other</option>
				        	</select>
				        	<input type="text" size="14" id="search_tourCode" placeholder="Search TourCode..." />
				            <input type="text" size="14" id="search_tourName" placeholder="Search TourName..." />
				            <input type="text" size="14" id="search_number" placeholder="Search TourNo...." />
				        </div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
	                                    <tr>
	                                        <th>Product Code</th>
	                                        <th>Product Name</th>	
											<th>Product NO.</th>	
	                                        <th>Booking</th>
	                                    </tr>
                                    </thead>
                                </table>
                                <div style="display:none" id="indeTable" margin="20px,auto">
	                                <table class="table table-bordered" style="margin-top:50px">
	                                	<thead class="no-border">
											<tr>
												<th style="width:16%;"><strong>Product Code</strong></th>
												<th style="width:12%;"><strong>Product Name</strong></th>
												<th style="width:12%;"><strong>Brand</strong></th>
												<th style="width:12%;"><strong>Product Description</strong></th>
												<th style="width:12%;" class="text-center"><strong>Action</strong></th>
											</tr>
										</thead>
										<tbody id="productList" class="no-border-y">
											<!--此处放添加的独立团产品-->
										</tbody>
	                                </table>
                                </div>
                                <table class="table table-bordered" style="display:none" id="otherTable">
							        <thead>
							            <tr>
							                <th>Booking Type</th>
							                <th>Booking</th>
							            </tr>
							            <tr>
							                <th>Flight</th>
							                <th><a href="bookProduct.jhtml?ordersTotalId=${ordersTotalId}&brand=chinatour&singleType=flight">book</a></th>
							            </tr>
							            <tr>
							                <th>Hotel</th>
							                <th><a href="bookProduct.jhtml?ordersTotalId=${ordersTotalId}&brand=chinatour&singleType=hotel">book</a></th>
							            </tr>
							            <tr>
							                <th>Cruise</th>
							                <th><a href="bookProduct.jhtml?ordersTotalId=${ordersTotalId}&brand=chinatour&singleType=cruise">book</a></th>
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
<div class="md-modal md-effect-1" id="groupLineForm">
    <div class="md-content">
      <div class="modal-header">
      	<span>New Product</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="newGroupLineForm">
	      <div class="modal-body">
	        <div class="text-center">
				<table style="padding:10px;border: 0px none" width="100%">
					<tbody>
						<tr>
							<td width="13%">
								<span>
									Product Code:
								</span>
							</td>
							<td width="37%">
								<input id="tourCodeInput" class="form-control" name="tourCode" type="text">
							</td>
							<td width="13%">
								<span>
									Product Name:
								</span>
							</td>
							<td width="37%">
								<input id="tourNameInput" class="form-control" name="tourName" type="text">
							</td>
						</tr>
						<tr>
							<td>
								<span>
									Product Description:
								</span>
							</td>
							<td>
								<input id="tripDescInput" class="form-control" name="tripDesc" type="text">
							</td>
							<td>
								<span>
									Brand:
								</span>
							</td>
							<td>
								<input class="form-control" name="brand" value="chinatour" readOnly="readOnly" type="text">
							</td>
						</tr>
						<tr>
							<td>
								<span>
									Product Type:
								</span>
							</td>
							<td>
								<select id="addProductTourType" name="tourTypeId" class="select2">
									[#list tourType as tourType]
					        			<option value="${tourType.tourTypeId}" type="${tourType.type}">${tourType.typeName}</option>
					        		[/#list]
				        		</select>							
				        	</td>
							<td>
								<span>
									Departure Date:
								</span>
							</td>
							<td>
								<input id="arrivalDateInput" name="departureDate" class="form-control" type="text" size="14"  placeholder="Departure Date" />
							</td>
						</tr>
					</tbody>
				</table>
	        </div>
	      </div>
	      <div class="modal-footer">
			<button type="reset" onclick="resetSelect(this);" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			<button type="reset" onclick="resetSelect(this);" class="btn btn-default">Reset</button>
			<button type="button" onclick="saveIndependentProduct(this);" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
		  </div>
		</form>
    </div>
</div>
<div class="md-overlay">
</div>
<table style="display:none">
	<tr id="productTemplate">
		<td></td>
		<td></td>	
		<td></td>
		<td></td>
		<td class="text-center"></td> 
	</tr>
</table>
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
            "ajax": {
                url: "[@spring.url '/admin/orders/groupLineList.jhtml?brand=chinatour&isSystem=1'/]",
                type: "POST",
                "data": function ( d ) {
                	d.source = $("#sourceSelect").val();
                	d.operater = $("#operaterSelect").val();
	                d.tourCode = $("#search_tourCode").val();
	                d.tourName = $("#search_tourName").val();
	                d.tourNo = $("#search_number").val();
            	}
            },
            "columns": [
                { "data": "tourCode" },
                { "data": "tourName" },
                { "data": "tourNo" },
                { "data": "id","class": "text-center" }
            ],
            "columnDefs" : [{
				"render" : function(data, type, row) {
					return '<a href="bookProduct.jhtml?ordersTotalId=${ordersTotalId}&brand=chinatour&groupLineId='+ data +'">book</a>';
                 },
				"targets" : 3
		   }]
		});
		
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        		
		$("input[id^='search_']").on( 'keyup blur change', function () {
        	$('#datatable2').DataTable().draw();
    	});
    	
    	changeOperater($("#operaterSelect")[0]);
    	changeSource($("#sourceSelect")[0]);
    });
    
   	/*  根据Operater选择产品      */
    function changeOperater(operater){
    	var $option = $(operater).find("option:selected");
    	if($option.attr("value") == 'other'){
    		$("#datatable2").parent().hide();
    		$("#indeTable").hide();
    		$("#otherTable").show();
    	}else if($option.attr("type") == 0){	
    		$("#datatable2").parent().hide();
    		$("#indeTable").show();
    		$("#otherTable").hide();		
    	}else{
    		var $datatable = $("#datatable2");
    		$("#otherTable").hide();
    		$("#indeTable").hide();
    		$("#sourceSelect").empty();
    		$.post('venderList.jhtml',{'brand':'chinatour','operater':$option.attr("value")},function(map){
    			var html='';
    			for(var i=0;i<map.venderList.length;i++){
    				html+='<option value="'+map.venderList[i]+'" type="'+map.venderList[i]+'">'+map.venderList[i]+'</option>'
    			}
    			html+='<option value="other">Other</option>'
    			$("#sourceSelect").append(html);
    			$datatable.parent().show();
    			$datatable.DataTable().draw();
    		});
    	}
    }
    /*  根据Source选择产品      */
    function changeSource(source){
    	var $option = $(source).find("option:selected");
    	if($option.attr("value") == 'other'){
    		$("#datatable2").parent().hide();
    		$("#indeTable").hide();
    		$("#otherTable").show();
    	}else if($option.attr("type") == 0){	
    		$("#datatable2").parent().hide();
    		$("#indeTable").show();
    		$("#otherTable").hide();		
    	}else{
    		var $datatable = $("#datatable2");
    		$("#otherTable").hide();
    		$("#indeTable").hide();
    		$datatable.parent().show();
    		$datatable.DataTable().draw();
    	}
    }
    
    /* 在添加新的产品时动态加载TourType */
    function getTourType(){
    	var $addProductTourType = $("#addProductTourType")
    	$addProductTourType.select2({
			width: '100%'
	    });
    }
    
    /* 保存独立团的新产品  */
    function saveIndependentProduct(){
		$.ajax({
			url:'saveIndependentProduct.jhtml',
			data: $("#newGroupLineForm").serialize(),
			type:"POST",
			beforeSend:function(){
			},
			success:function(groupLineId){
				$("#datatable2").parent().hide();
	    		$("#indeTable").show();
	    		$("#otherTable").hide();	
				var $newProduct = $("#productTemplate").clone(true).removeAttr("id");
				var $tds = $newProduct.find("td");
				$tds.eq(0).html($("#tourCodeInput").val());
				$tds.eq(1).html($("#tourNameInput").val());
				$tds.eq(2).html("chinatour");
				$tds.eq(3).html($("#tripDescInput").val());
				$tds.eq(4).html('<a href="bookProduct.jhtml?ordersTotalId=${ordersTotalId}&brand=chinatour&groupLineId='+ groupLineId +'">booking</a>');
				$("#productList").append($newProduct);
			}
		});   	
    }
    
    $("#arrivalDateInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
</script>
</body>
</html>
