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
            <div class="new"><button class="btn btn-success" type="button" onclick="submit();">导出所有客人信息</button></div>
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
                            <h3>Tour List</h3>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                            	<form action="#" method="post">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
		                                        <th><input id="allCheck" onclick="check(this);" type="checkbox" ></th>
		                                        <th>Tour Code</th>
		                                        <th>Booking No.</th>
		                                        <th>Status</th>
		                                        <th>Total Passenger</th>
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
            "ajax": {
                url: "[@spring.url '/admin/tour/orderList.jhtml?tourCode='+tourCode /]",
                type: "POST"
            },
            "columns": [
                { "data": "id",
                  "render": function (data, type, row) {
	                   return '<input class="orderCheckbox" name="orderIds" value="'+ data +'" type="checkbox">';
                   }
                },
                { "data": "tourCode" },
                { "data": "orderNo" },
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
                { "data": "totalPeople" },
                { "data": "userId" },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<a href="orderCustomerList.jhtml?orderId='+ data +'">Passenger Info</a>';
                 },
				"targets" : 6
		  }]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
    });
    
    /* 级联选中   */
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
</script>
</body>
</html>
