[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
            <h2>Op Center</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Op Center</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/tourType/saveforAdmin.jhtml">
              <!--
              <div class="form-group">
                <label class="col-sm-3 control-label">Code</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="code" required placeholder="" />
                </div>
              </div>
              -->
              <div class="form-group">
                <label class="col-sm-3 control-label">Type Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="typeName" required placeholder=""/>
                </div>
              </div>
              <!--
              <div class="form-group">
                <label class="col-sm-3 control-label">Price Expression(Percent)</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" value='0' name="priceExpression" required placeholder=""/>
                </div>
              </div>
              -->
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
					<select type="text" name="brand" class="select2">
	                    [#list brandList as brand]
	                        <option value="${brand.brandName}">${brand.brandName}</option>
	                    [/#list]
                 	</select>
				</div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Type</label>
                <div class="col-sm-6">
                  	<select type="text" name="type" class="select2">
	                        <!--<option value="0">Custom Group</option>-->
	                        <option value="1">Series Tour(Tour Booking)</option>
	                        <option value="15">Other Tour(Other Booking)</option>
                 	</select>
                </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                  <button type="button" onclick="redirect(2)" class="btn btn-default">Save and New</button>
                </div>
              </div>
            </form>
          </div>
        </div>
        
      </div>
    </div>

</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
$(document).ready(function () {
	App.init();
});
</script>
</body>
</html>
