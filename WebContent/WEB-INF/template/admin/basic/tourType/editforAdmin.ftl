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
            <h3>Edit</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" method="POST"   action="${base}/admin/tourType/updateforAdmin.jhtml">
              <!--
              <div class="form-group">
                <label class="col-sm-3 control-label">Code</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="code" value="${tourType.code}"  />
                </div>
              </div>
              -->
              <div class="form-group">
                <label class="col-sm-3 control-label">Type Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="typeName"  value="${tourType.typeName}"/>
                </div>
              </div>
              <!--
               <div class="form-group">
                <label class="col-sm-3 control-label">Price Expression(Percent)</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="priceExpression" value="${tourType.priceExpression}" required placeholder=""/>
                </div>
              </div>
              -->
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
					<select type="text" name="brand" class="select2">
	                    [#list brandList as brand]
	                      <option value="${brand.brandName}" [#if "${brand.brandName==tourType.brand}"] selected="selected" [/#if]> ${brand.brandName}</option>
	                    [/#list]
	                </select>
				</div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Type</label>
                <div class="col-sm-6">
                    <select type="text" name="type" class="select2">
	                        <!--<option value="${type}" [#if "${tourType.type==0}"] selected="selected" [/#if]>Custom Group</option>-->
	                        <option value="${type}" [#if "${tourType.type==1}"] selected="selected" [/#if]>Series Tour(Tour Booking)</option>
	                        <option value="${type}" [#if "${tourType.type==15}"] selected="selected" [/#if]>Other Tour(Other Booking)</option>
                 	</select>
                </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <input name="tourTypeId" type="hidden"  value="${tourType.tourTypeId}">
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

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
$(document).ready(function () {
App.init();    
});   
//给input set City Id,Name
function setVal(){

	$("#cityId").attr("value",$("#selCity").val());
	var cityName=$("#selCity").find("option:selected").text();
	$("#cityName").attr("value",cityName);
}   

</script>
</body>
</html>
