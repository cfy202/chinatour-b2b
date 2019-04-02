[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta charset="utf-8">
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
            <h3>Edit</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" action="${base}/admin/itinerary/update.jhtml" method="post" parsley-validate novalidate>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Code</label>
                <div class="col-sm-6">
                	<select type="text" name="tourCode" class="select2">
                    [#list groupLines as groupLine]
                        <option name="${groupLine.tourName}" value="${groupLine.tourCode}"
                        [#if "${groupLine.tourCode==itinerary.tourCode}"] selected="selected" [/#if]>
                        ${groupLine.tourCode}
                        </option>
                    [/#list]
                   </select>
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="tourName" value="${itinerary.tourName}" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Description</label></br>
                <div class="col-sm-6">
				  <textarea style="height:150px;" class="form-control a" name="itineraryDescribe">${itinerary.itineraryDescribe}</textarea>
				</div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Hotel Info</label>
                <div class="col-sm-6">
                  <textarea style="height:150px;" class="form-control a" name="hotelInfo">${itinerary.hotelInfo}</textarea>
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Contact Way</label>
                <div class="col-sm-6">
                  <textarea style="height:150px;" class="form-control a" name="contact">${itinerary.contact}</textarea>
                </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                <input type="hidden" name="itineraryInfoId" value="${itinerary.itineraryInfoId}">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="button" style="margin-left:336px;" id="preview" class="btn btn-primary" data-modal="form-primary">Preview</button>
                  <button type="submit" class="btn btn-primary">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
        
      </div>
    </div>
</div>

<div class="md-modal colored-header md-effect-9" id="form-primary" style="left:45%">
      <iframe src="showBody?id=${itinerary.itineraryInfoId}" id="test" width="980" height="500" frameborder="0"></iframe> 
</div>
<div class="md-overlay" class="close md-close" aria-hidden="true"></div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/lib/js/wysihtml5-0.3.0.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/src/bootstrap-wysihtml5.js'/]"></script>
<script type="text/javascript">
   $(document).ready(function () {
    	App.init();
    	$('.a').wysihtml5();
    	$('#preview').modalEffects();
    $("select[name='tourCode']").change(function () {
     	var name = $("select[name='tourCode']").find("option:selected").attr("name");
     	$("input[name='tourName']").attr("value",name);
 	});
   });
</script>
</body>
</html>
