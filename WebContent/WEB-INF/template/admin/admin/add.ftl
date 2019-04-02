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
                <li><a href="#">Settings</a></li>
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
                            <form class="form-horizontal group-border-dashed" action="[@spring.url '/admin/admin/save.jhtml'/]" style="border-radius: 0px;" method="post">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("Admin.username")}:</label>

                                    <div class="col-sm-6">
                                        <input type="text" name="username" class="form-control" value="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("Admin.password")}:</label>

                                    <div class="col-sm-6">
                                        <input id="password" name="password" type="password" class="form-control" maxlength="20">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("admin.admin.rePassword")}:</label>

                                    <div class="col-sm-6">
                                        <input type="password" name="rePassword" class="form-control" maxlength="20">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("Admin.email")}:</label>

                                    <div class="col-sm-6">
                                        <input type="text" name="email" class="form-control" value="" maxlength="200"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("Admin.roles")}:</label>

                                    <div class="col-sm-6">
                                    [#list roles as role]
                                        <div class="radio">
                                            <label><input type="checkbox" name="roleIds" value="${role.id}"/>${role.name}</label>
                                        </div>
                                    [/#list]
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("admin.common.setting")}:</label>

                                    <div class="col-sm-6">
                                        <div class="radio">
                                            <label>
                                                <input type="checkbox" name="isEnabled" value="true"/>${message("Admin.isEnabled")}
                                                <input type="hidden" name="_isEnabled" value="false"/>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("Admin.department")}:</label>
                                    <div class="col-sm-6">
                                        <select id="selDept" name="deptId" class="select2" >
											<option value="">Select</option>
												[#list deptList as dept]
													<option value="${dept.deptId}">${dept.deptName}</option>
												[/#list]
										</select>
									</div>
								</div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">${message("Admin.name")}:</label>

                                    <div class="col-sm-6">
                                        <input type="text" name="name" class="form-control" value="${admin.name}" maxlength="200"/>
                                    </div>
                                    
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"></label>

                                    <div class="col-sm-6 col-md-offset-3">
                                        <input type="submit" class="btn btn-primary" value="${message("admin.common.submit")}"/>
                                        <input type="button" class="btn btn-default" value="${message("admin.common.back")}" id="back"/>
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
        App.init();
        $("#back").click(function () {
            location.href = '[@spring.url '/admin/admin/list.jhtml'/]';
        });
    });
</script>
</body>
</html>
