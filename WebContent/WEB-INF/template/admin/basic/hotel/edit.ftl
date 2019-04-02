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
            <h2>Hotel</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Hotel</li>
            </ol>
        </div>
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
          <div class="content">
            <form class="form-horizontal group-border-dashed" action="update.jhtml" method="post">
              <input type="hidden" name="id" class="form-control" value="${hotel.id}" required parsley-maxlength="6" placeholder="Max 6 chars." />
              <div class="form-group">
                <label class="col-sm-3 control-label">Hotel Name</label>
                <div class="col-sm-6">
                  <input type="text" name="hotelName" class="form-control" value="${hotel.hotelName}" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Start</label>
                <div class="col-sm-6">
                  <select type="text" name="standard" class="select2">
                    [#list standards as standard]
                        <option value="${standard}" [#if "${standard==hotel.standard}"] selected="selected" [/#if]>${standard}</option>
                    [/#list]
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Address</label>
                <div class="col-sm-6">
                  <input type="text" name="address" class="form-control" value="${hotel.address}" parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">City</label>
                <div class="col-sm-6">
                 <select type="text" name="cityId" class="select2">
                    [#list citys as city]
                      <option value="${city.id}" 
                      [#if "${city.id==hotel.cityId}"] selected="selected" [/#if]>
                      ${city.cityName}</option>
                    [/#list]
                 </select>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Tel</label>
                <div class="col-sm-6">
                  <input type="text" name="tel" class="form-control" value="${hotel.tel}"  parsley-maxlength="6" placeholder="Max 6 chars." />
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
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
       App.init();
    });
</script>
</body>
</html>
