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
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/js/bootstrap.wysihtml5/src/bootstrap-wysihtml5.css'/]"></link>
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Confirmation</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/itinerary/save.jhtml">
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Code</label>
                <div class="col-sm-6">
                  <select type="text" name="tourCode" class="select2">
                    [#list groupLines as groupLine]
                        <option name="${groupLine.tourName}" value="${groupLine.tourCode}">${groupLine.tourCode}</option>
                    [/#list]
                   </select>
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="tourName" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Description</label></br>
                <div class="col-sm-6">
				  <textarea style="height:150px;" class="form-control a" name="itineraryDescribe"></textarea>
				</div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Hotel Info</label>
                <div class="col-sm-6">
                  <textarea style="height:150px;" class="form-control a" name="hotelInfo"></textarea>
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Contact Way</label>
                <div class="col-sm-6">
                  <textarea style="height:150px;" class="form-control a" name="contact"></textarea>
                </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
				  <button type="button" id="cancel" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                  <button type="button" id="san" onclick="redirect(2)" class="btn btn-default">Save and New</button>
                </div>
              </div>
            </form>
          </div>
        </div>
        
      </div>
    </div>

</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/lib/js/wysihtml5-0.3.0.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/src/bootstrap-wysihtml5.js'/]"></script>
<script type="text/javascript">
$(document).ready(function () {
	App.init();
	$('.a').wysihtml5();
	$("input[name='tourName']").attr("value",$("select[name='tourCode']").find("option:selected").attr("name"));
	
	$("select[name='tourCode']").change(function () {
     	var name = $("select[name='tourCode']").find("option:selected").attr("name");
     	$("input[name='tourName']").attr("value",name);
 	});
});
    
</script>
</body>
</html>
