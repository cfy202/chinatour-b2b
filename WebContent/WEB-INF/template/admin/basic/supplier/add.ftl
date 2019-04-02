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
            <h2>Operators</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Operators</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/supplier/save.jhtml">
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Operators Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="supplierName"  placeholder="" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Abbr</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="supplierShortName"   placeholder="" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Mobil</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="mobile" required parsley-type="number" placeholder="" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Tele</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="tel"  placeholder="" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="email" class="form-control" required parsley-type="email" name="email" placeholder="" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Address</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="address" placeholder="" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Fax</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="fax" placeholder="" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Contacts</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="contactPerson" placeholder="" />
                </div>
              </div>
              
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Zip Code</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="zipCode" placeholder="" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">City</label>
                <div class="col-sm-6">
				<select id="selCity" onchange="setVal()" required name="cityValue" class="select2" >
					<option value="">Select</option>
					[#list cityListt as city]
							<option value="${city.id}">${city.cityName}</option>
					[/#list]
				</select>               
                </div>
              </div>
              
              
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <input id="cityId" name="cityId" type="hidden" value="" />
                  <input id="cityName" name="city" type="hidden" value="">
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

//给input set City Id,Name
function setVal(){

	$("#cityId").attr("value",$("#selCity").val());
	var cityName=$("#selCity").find("option:selected").text();
	$("#cityName").attr("value",cityName);
}   
</script>
</body>
</html>
