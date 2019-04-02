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
            <h2>Itinerary</h2>
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
          		<form action="updateGroupRoute.jhtml" method="post" class="form-horizontal group-border-dashed">
	          			<form class="form-horizontal group-border-dashed" action="update.jhtml" method="post" parsley-validate novalidate>
              <input type="hidden" name="id" value="${groupRoute.id}" class="form-control" required placeholder="Min 6 chars." />
              <div class="form-group">
                <label class="col-sm-3 control-label">Name</label>
                <div class="col-sm-6">
                  <input type="text" name="routeName" value="${groupRoute.routeName}" class="form-control" required parsley-minlength="6" placeholder="Min 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Date</label>
                <div class="col-sm-6">
	                <select type="text" name="dayNum" class="select2">
	                      <option name="dayNum" value="1">第1天</option>
	                      <option name="dayNum" value="2">第2天</option>
	                      <option name="dayNum" value="3">第3天</option>
	                      <option name="dayNum" value="4">第4天</option>
	                      <option name="dayNum" value="5">第5天</option>
	                      <option name="dayNum" value="6">第6天</option>
	                      <option name="dayNum" value="7">第7天</option>
	                      <option name="dayNum" value="8">第8天</option>
	                      <option name="dayNum" value="9">第9天</option>
	                      <option name="dayNum" value="10">第10天</option>
	                      <option name="dayNum" value="11">第11天</option>
	                      <option name="dayNum" value="12">第12天</option>
	                      <option name="dayNum" value="13">第13天</option>
	                      <option name="dayNum" value="14">第14天</option>
	                      <option name="dayNum" value="15">第15天</option>
	                      <option name="dayNum" value="16">第16天</option>
	                      <option name="dayNum" value="17">第17天</option>
	                      <option name="dayNum" value="18">第18天</option>
	                      <option name="dayNum" value="19">第19天</option>
	                      <option name="dayNum" value="20">第20天</option>
	                       <option name="dayNum" value="11">第21天</option>
	                      <option name="dayNum" value="12">第22天</option>
	                      <option name="dayNum" value="13">第23天</option>
	                      <option name="dayNum" value="14">第24天</option>
	                      <option name="dayNum" value="15">第25天</option>
	                      <option name="dayNum" value="16">第26天</option>
	                      <option name="dayNum" value="17">第27天</option>
	                      <option name="dayNum" value="18">第28天</option>
	                      <option name="dayNum" value="19">第29天</option>
	                      <option name="dayNum" value="20">第30天</option>
	                 </select>
              	</div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Description(English)</label>
                <div class="col-sm-6">
                  <textarea name="routeDescribeForEn" rows="6" style="width:100%;">${groupRoute.routeDescribeForEn}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Description(Chinese)</label>
                <div class="col-sm-6">
                  <textarea name="routeDescribeForUs" rows="6" style="width:100%;">${groupRoute.routeDescribeForUs}</textarea>
                </div>
              </div>
                  <input type="hidden" name="groupLineId" value="${groupRoute.groupLineId}" class="form-control" required parsley-min="6" placeholder="Min 6 chars." />
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

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("select[name='dayNum']").val('${groupRoute.dayNum}');
    	var avi="${groupRoute.dayNum}";
    	var num = document.getElementsByName("num");
    	for(var i=0;i<num.length;i++){
    		if(num[i].value==avi){
    			num[i].checked='checked';
    		}
    	}
    });
</script>
</body>
</html>
