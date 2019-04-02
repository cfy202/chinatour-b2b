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

                    <p>Data will be permanently deleted?</p>
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
            <h2>Group</h2>
            <div class="new"><button class="btn btn-success btn-flat" onclick="location.href='add.jhtml'" type="button">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Settings</a></li>
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
							<div class="options" style="padding:10px;">
								<div  class="nav-panel">
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Search</span>:
										</div>
										<div  class="block-body default-2-line">
											<div  class="params-cont">
												<input type="text" size="14" id="search_name"  placeholder="name..." />
												<input type="text" size="14" id="search_dept"  placeholder="dept..." />
											</div>
										</div>
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
                                        <th>Group</th>
                                        <th>Description</th>
                                        <th>Dept</th>
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
<!-- Nifty Modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
	<div class="md-content">
		<div class="modal-header">
			<h3>New</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/smallGroup/save.jhtml'/]">
			<div class="modal-body form">
				<div class="form-group">
					<label>Group Name</label> <input type="name" name="name" class="form-control" placeholder="">
				</div>
				<div class="form-group">
					<label>Remark</label> <input type="name" name="remark" class="form-control" placeholder="">
				</div>
				<div class="row">
					<div class="form-group col-md-12 no-margin">
						<label>Select Team Member</label>
					</div>
				</div>
				<div class="row no-margin-y" id="checkboxId">
				</div>
			</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal">Proceed</button>
			</div>
		</form>	
	</div>
</div>
<!-- Nifty Modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-edit">
	<div class="md-content">
		<div class="modal-header">
			<h3>New</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/smallGroup/save.jhtml'/]">
			<div class="modal-body form">
				<div class="form-group">
					<label>Group Name</label> <input type="name" name="name" id="groupName" class="form-control" placeholder="">
				</div>
				<div class="form-group">
					<label>Remark</label> <input type="name" name="remark" id="remarkId" class="form-control" placeholder="">
				</div>
				<div class="row">
					<div class="form-group col-md-12 no-margin">
						<label>Select Team Member</label>
					</div>
				</div>
				<div class="row no-margin-y" id="checkboxId">
				</div>
			</div>
			<div class="modal-footer">
				<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal">Proceed</button>
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
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/smallGroup/list.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.name = $("#search_name").val();
					data.deptName = $("#search_dept").val();
				}
            },
            "columns": [
                { "data": "groupId","visible":false },
                { "data": "name" },
                { "data": "remark" },
                { "data": "deptName" },
                { "data": "groupId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
						return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">操作</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="edit.jhtml?id='+data+'"  ><i class="fa fa-pencil"></i>Edit</a></li><li class="divider"></li><li><a data-href="del.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
                 },
				"targets" : 4
		  }]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
    });
    /*添加小组*/
    function addForm(){
    	$("#checkboxId").empty();
		$.ajax({
			type: "POST",
			url: "add.jhtml",
			success: function(msg){	
				var html='<div class="col-sm-12">';
				var number=0;
				$.each(msg,function(key,values){
					number++;
					html+='<label class="checkbox-inline"> <input type="checkbox" name="adminId" value="'+key+'" class="icheck"> '+values+'</label>';
					if(number%6==0){
						html+='</div><div class="col-sm-12">';
					}
				});
				html+="</div>";
				$("#checkboxId").append(html);
				$("#checkboxId").find('.icheck').iCheck({
					checkboxClass: 'icheckbox_square-blue checkbox',
					radioClass: 'iradio_square-blue'
				});
			}
		}); 
	}
	/*修改小组*/
    function edit(data){
		$.ajax({
			type: "POST",
			url: "edit.jhtml",
			data:"id="+data,
			success: function(msg){
			alert(msg.groupId);
			alert(msg['groupId']);
			$("#groupName").val(msg.name);
			$("#remarkId").val(msg.remark);
				$.each(msg.adminGroup,function(index,values){
					alert(values);
				});
			}
		}); 
	}
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
		
		$("input[id^='search_']").on( 'keyup blur change', function () {
			$('#datatable2').DataTable().draw();
		} );
</script>
</body>
</html>
