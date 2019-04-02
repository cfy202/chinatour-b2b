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
            <h2>New</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
                <li class="active">Car</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="updateCar.jhtml" method="post">
              <input type="hidden" name="carId" value="${car.carId}">
              <input type="hidden" name="tourId" value="${car.tourId}">           
              <div class="form-group">
                <label class="col-sm-3 control-label">Car Name</label>
                <div class="col-sm-6">
                  <input type="text" name="carName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." value="${car.carName}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Seating</label>
                <div class="col-sm-6">
                  <input type="text" name="seats" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." value="${car.seats}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Remark</label>
                 <div class="col-sm-6">
                  <input type="text" name="carRemark" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." value="${car.carRemark}"/>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
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
