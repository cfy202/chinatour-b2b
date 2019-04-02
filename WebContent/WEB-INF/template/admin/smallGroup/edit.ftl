[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">

    <title>${message("admin.admin.list")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>${message("admin.admin.list")}</h2>
            <ol class="breadcrumb">
                <li><a href="#">${message("admin.path.index")}</a></li>
                <li><a href="#">Role</a></li>
                <li class="active">${message("admin.admin.list")}</li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>${message("admin.admin.edit")}</h3>
                        </div>
                        <div class="content">
                        	<form class="form-horizontal group-border-dashed" action="[@spring.url '/admin/smallGroup/update.jhtml'/]" style="border-radius: 0px;" method="post">
                                <input type="hidden" name="groupId" value="${smallGroup.groupId}"/>
                        		<div class="form-group">
					                <label class="col-sm-1 control-label">DeptName</label>
					                <div class="col-sm-6">
					                  <select id="sellanguage"  class="select2" >
											<option >${smallGroup.deptName}</option>
									</select>
					                </div>
					              </div>
								<div class="form-group">
									<label  class="col-sm-1 control-label">Group Name</label> <div class="col-sm-6"><input type="name" name="name" value="${smallGroup.name}" class="form-control" placeholder=""></div>
								</div>
								<div class="form-group">
									<label  class="col-sm-1 control-label">Remark</label><div class="col-sm-6"> <input type="name" name="remark" value="${smallGroup.remark}" class="form-control" placeholder=""></div>
								</div>
								<div class="form-group">
									<label  class="col-sm-3 control-label">Select Team Member</label>
									<div class="row no-margin-y" id="checkboxId">
										<div class="col-sm-12">
											[#list adminList as admin]
												<label class="checkbox-inline"> <input type="checkbox" name="adminId" value="${admin.id}" class="icheck"> ${admin.username}</label>
						        				[#if (admin_index+1) % 6==0]
						        					</div><div class="col-sm-12">
						        				[/#if]
						       				[/#list]
						       			</div>	
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
										<button type="submit" style="margin-left:336px;" class="btn btn-primary">Save</button>
									</div>
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
        [#list smallGroup.adminGroup as group]
        	$("[name = adminId][value = '${group.admin.id}']:checkbox").attr("checked", true);
        [/#list]
        App.init();
    });
</script>
</body>
</html>
