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
							<form class="form-horizontal group-border-dashed" action="[@spring.url '/admin/admin/updatePassword.jhtml'/]" style="border-radius: 0px;" method="post" parsley-validate novalidate>
								<input type="hidden" name="id" value="${admin.id}"/>
								<div class="form-group">
									<label class="col-sm-3 control-label">${message("Admin.username")}:</label>
									<div class="col-sm-6">
										${admin.username}
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">${message("Admin.password")}:</label>
									<div class="col-sm-6">
										<input id="password" name="password" type="password" placeholder="Password" required class="form-control" maxlength="20">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">${message("admin.admin.rePassword")}:</label>
									<div class="col-sm-6">
										<input type="password" parsley-equalto="#password" name="rePassword" required placeholder="Password" class="form-control" maxlength="20">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label"></label>
									<div class="col-sm-6 col-md-offset-3">
										<input type="submit" class="btn btn-primary" value="${message("admin.common.submit")}" />
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
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
    });
</script>
</body>
</html>
