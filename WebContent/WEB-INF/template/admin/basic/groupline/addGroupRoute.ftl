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
            <h2>Product</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Product-Itinerary</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
           <div class="content">
          		<form action="saveGroupRoute.jhtml" method="post" class="form-horizontal group-border-dashed">
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
	                      <option name="num" value="1" selected="true">第1天</option>
	                      <option name="num" value="2">第2天</option>
	                      <option name="num" value="3">第3天</option>
	                      <option name="num" value="4">第4天</option>
	                      <option name="num" value="5">第5天</option>
	                      <option name="num" value="6">第6天</option>
	                      <option name="num" value="7">第7天</option>
	                      <option name="num" value="8">第8天</option>
	                      <option name="num" value="9">第9天</option>
	                      <option name="num" value="10">第10天</option>
	                      <option name="num" value="11">第11天</option>
	                      <option name="num" value="12">第12天</option>
	                      <option name="num" value="13">第13天</option>
	                      <option name="num" value="14">第14天</option>
	                      <option name="num" value="15">第15天</option>
	                      <option name="num" value="16">第16天</option>
	                      <option name="num" value="17">第17天</option>
	                      <option name="num" value="18">第18天</option>
	                      <option name="num" value="19">第19天</option>
	                      <option name="num" value="20">第20天</option>
	                       <option name="num" value="21">第21天</option>
	                      <option name="num" value="22">第22天</option>
	                      <option name="num" value="23">第23天</option>
	                      <option name="num" value="24">第24天</option>
	                      <option name="num" value="25">第25天</option>
	                      <option name="num" value="26">第26天</option>
	                      <option name="num" value="27">第27天</option>
	                      <option name="num" value="28">第28天</option>
	                      <option name="num" value="29">第29天</option>
	                      <option name="num" value="30">第30天</option>
	                 </select>
              	</div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Description(English)</label>
                <div class="col-sm-6">
                  <textarea name="routeDescribeForEn" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Description(Chinese)</label>
                <div class="col-sm-6">
                  <textarea name="routeDescribeForUs" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
                  <input type="hidden" name="groupLineId" value="${groupLineId}" />
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
    			num[i].selected='selected';
    		}else{
    			num[0].selected='selected';
    		}
    	}
    });
</script>
</body>
</html>
