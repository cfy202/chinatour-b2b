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
            <h2>Edit Information</h2>
            <ol class="breadcrumb">
                <li><a href="#">${message("admin.path.index")}</a></li>
                <li><a href="#">Settings</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>Information</h3>
                        </div>
						<div class="content">
							<form class="form-horizontal group-border-dashed" action="[@spring.url '/admin/admin/updateUser.jhtml'/]" style="border-radius: 0px;" method="post" parsley-validate novalidate>
								<input type="hidden" name="id" value="${admin.id}"/>
								<!-- 
								<div class="form-group">
									<label class="col-sm-3 control-label">${message("Admin.username")}:</label>
									<div class="col-sm-6">
										<input type="text" name="username" parsley-trigger="change" required class="form-control" onblur="checkUserName(this)" value="${admin.username}">
									</div>
								</div>
								-->
								<div class="form-group">
									<label class="col-sm-3 control-label">${message("Admin.email")}:</label>
									<div class="col-sm-6">
										<input type="email" name="email" class="form-control" parsley-trigger="change" required value="${admin.email}" maxlength="200" />
									</div>
								</div>
								<!--
								<div class="form-group">
									<label class="col-sm-3 control-label">${message("Admin.name")}:</label>
									<div class="col-sm-6">
										<input type="text" name="name" class="form-control" parsley-trigger="change" required value="${admin.name}" maxlength="200" />
									</div>
								</div>
								-->
								<div class="form-group">
									<label class="col-sm-3 control-label">Address:</label>
									<div class="col-sm-6">
										<input type="text" name="address" class="form-control" parsley-trigger="change" required value="${admin.address}" maxlength="200" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">Fax:</label>
									<div class="col-sm-6">
										<input type="text" name="fax" class="form-control" parsley-trigger="change" required value="${admin.fax}" maxlength="200" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">Tel:</label>
									<div class="col-sm-6">
										<input type="text" name="tel" class="form-control" parsley-trigger="change" required value="${admin.tel}" maxlength="200" />
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
    function checkUserName(i){
    	var rename='${admin.username}';
    	var name=$(i).val().trim();
    	//判断是否和旧的name相等
    	if(name!=''&&rename!=name){
    		$.ajax({
				type: "POST",
				url: "[@spring.url '/admin/admin/check_username.jhtml'/]",
				data:"username="+name,
				success: function(msg){
					if(msg){
						 i.setCustomValidity("");
					}else{
						i.setCustomValidity("The User Name Repetition");
					}
					
					}
				});
    	}
    	
    }
</script>
</body>
</html>
