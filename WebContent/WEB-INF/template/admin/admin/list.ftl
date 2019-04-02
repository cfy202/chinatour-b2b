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

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>User</h2>
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
                            <h3>Detailed Info</h3>
							<a href="javascript:void(0);" id="penId" class="md-trigger" data-modal="form-primary"></a>
							<a href="javascript:void(0);" id="regionId" class="md-trigger" data-modal="form-region"></a>
                            <div class="btn-group pull-right">
                                <a href="[@spring.url '/admin/admin/add.jhtml'/]" class="btn btn-default"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th><input type="text" id="col_1" data-column="1" placeholder="Search user"/></th>
                                        <th><input type="text" id="col_2" data-column="2" placeholder="Search email"/></th>
                                        <th>Name</th>
                                        <th width="20%"><input type="text" id="col_3" data-column="3" placeholder="Search location"/></th>
                                        <th width="20%">Action</th>
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
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>

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
<!-- Nifty Modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style="width:60%">
	<div class="md-content">
		<div class="modal-header">
			<h3>Select Role</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/admin/updateRole.jhtml'/]">
			<div class="modal-body form">
				<div class="row">
					<div class="form-group col-md-12 no-margin">
						<label>Select Role</label>
					</div>
				</div>
				<div class="row no-margin-y" id="checkboxId">
				
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal">Proceed</button>
			</div>
		</form>	
	</div>
</div>
<!-- Nifty Modal -->
<div class="md-modal colored-header custom-width md-effect-9" id="form-region" style="width:60%">
	<div class="md-content">
		<div class="modal-header">
			<h3>Regional Manager</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/admin/updateRegion.jhtml'/]">
			<div class="modal-body form">
				<div class="row">
					<div class="form-group col-md-12 no-margin">
						<label>Select Regional</label>
					</div>
				</div>
				<div class="row no-margin-y" id="dId">
				
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal">Proceed</button>
			</div>
		</form>	
	</div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/template" id="action-tmpl">
    <div class="btn-group">
        <button class="btn btn-default btn-xs" type="button">Action</button>
        <button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button">
            <span class="caret"></span>
            <span class="sr-only">Toggle Dropdown</span>
        </button>
        <ul role="menu" class="dropdown-menu pull-right">
            <li><a href="[@spring.url '/admin/admin/edit/{{id}}.jhtml'/]"><i class="fa fa-pencil"></i>Edit</a></li>
            <li><a href="#"><i class="fa fa-search"></i>View</a></li>
            <li><a href="javascript:editRole('{{id}}');"><i class="fa fa-search"></i>Role Setting</a></li>
             <li><a href="javascript:editRegion('{{id}}');"><i class="fa fa-search"></i>Region Setting</a></li>
            <li class="divider"></li>
            <li><a data-href="[@spring.url '/admin/admin/delete/{{id}}.jhtml'/]" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li>
        </ul>
    </div>

</script>
<script type="text/template" id="email-tmpl">
    <a href="mailto:{{email}}">{{email}}</a>
</script>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
    [@flash_message /]
    	 $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var action = Hogan.compile($("#action-tmpl").html());
        var email = Hogan.compile($("#email-tmpl").html());
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "ajax": {
                url: "[@spring.url '/admin/admin/list.jhtml'/]",
                type: "POST",
                "data": function ( d ) {
	                d.username = $("#col_1").val();
	                d.email = $("#col_2").val();
	                d.deptName = $("#col_3").val();
	                //alert(JSON.stringify(d));
            	}
            },
            "columns": [
                { "data": "id", "visible": false },
                { "data": "username" },
                {
                    "data": "email",
                    "render": function (data, type, row) {
                        return email.render({email: row.email});
                    }
                },
                { "data": "name" , "visible": false},
                { "data": "deptName"},
                {
                    "class": "text-center",
                    "targets": 5,
                    "render": function (data, type, row) {
                        return action.render({id: row.id});
                    }
                }
            ]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $("input[id^='col_']").on( 'keyup change', function () {
        	filterColumn( $(this).attr('data-column') );
    	} );
    	
    });
    
    function filterColumn ( i ) {
		    $('#datatable2').DataTable().column( i ).search(
		        $("input[id^='col_"+i+"']").val(),true,true
		    ).draw();
		}
	/*角色*/
	function editRole(id){
		$("#checkboxId").empty();
		$.ajax({
			type: "POST",
			url: "editRole.jhtml",
			data:"id="+id,
			success: function(msg){
				var html='<input type="hidden" name="id" value="'+msg.admin.id+'"/>';
				if(msg.admin.adminRoles.length>0){
					$.each(msg.roles,function(key,values){
						html+='<div class="form-group col-md-4 col-sm-3  col-xs-3 no-margin"><label class="checkbox-inline"> <input type="checkbox" name="roleIds" value="'+values.id+'"';
						$.each(msg.admin.adminRoles,function(keyS,adminRoles){
							if(adminRoles.role!=null&&adminRoles.role.name==values.name){
								html+='checked="checked"';
							}
						});
						html+='class="icheck"> '+values.name+'</div>';
						
					});
				}else{
					$.each(msg.roles,function(key,values){
						html+='<div class="form-group col-md-4 col-sm-3  col-xs-3 no-margin"><label class="checkbox-inline"> <input type="checkbox" name="roleIds" value="'+values.id+'" class="icheck"> '+values.name+'</label></div>';
					});
				}
				
				$("#checkboxId").append(html);
				$("#checkboxId").find('.icheck').iCheck({
					checkboxClass: 'icheckbox_square-blue checkbox',
					radioClass: 'iradio_square-blue'
				});
				$("#penId").trigger("click");
			}
		}); 
	}
	/*区域经理*/
	function editRegion(id){
		$("#dId").empty();
		$.ajax({
			type: "POST",
			url: "editRegion.jhtml",
			data:"id="+id,
			success: function(msg){
				var html='<input type="hidden" name="id" value="'+msg.admin.id+'"/>';
				if(msg.admin.adminRegions.length>0){
					$.each(msg.regions,function(key,values){
						html+='<div class="form-group col-md-4 col-sm-3  col-xs-3 no-margin"><label class="checkbox-inline"> <input type="checkbox" name="regions" value="'+values.id+'"';
						$.each(msg.admin.adminRegions,function(keyS,adminRegion){
							if(adminRegion.regionId!=null&&adminRegion.regionId==values.id){
								html+='checked="checked"';
							}
						});
						html+='class="icheck"> '+values.regionName+'</label></div>';
					});
				}else{
					$.each(msg.regions,function(key,values){
						html+='<div class="form-group col-md-4 col-sm-3  col-xs-3 no-margin"><label class="checkbox-inline"> <input type="checkbox" name="regions" value="'+values.id+'" class="icheck"> '+values.regionName+'</label></div>';
					});
				}
				$("#dId").append(html);
				$("#dId").find('.icheck').iCheck({
					checkboxClass: 'icheckbox_square-blue checkbox',
					radioClass: 'iradio_square-blue'
				});
				$("#regionId").trigger("click");
			}
		}); 
	}
</script>
</body>
</html>
