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
            <h3>Edit</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" method="POST"   action="${base}/admin/supplier/update.jhtml">
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Operators Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="supplierName" value="${supplier.supplierName}"  />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Abbr</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="supplierShortName"  value="${supplier.supplierShortName}"   />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Mobile</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="mobile" required parsley-type="number" value="${supplier.mobile}" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Tel</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="tel"  value="${supplier.tel}" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="email" class="form-control" name="email" required parsley-type="email"  value="${supplier.email}"  />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Address</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="address"  value="${supplier.address}" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Fax</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="fax"  value="${supplier.fax}"  />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Contacts</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="contactPerson"   value="${supplier.contactPerson}"/>
                </div>
              </div>
              
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Zip Code</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="zipCode"  value="${supplier.zipCode}" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">City</label>
                <div class="col-sm-6">
				<select id="selCity" onchange="setVal()" required  class="select2" >
					<option value="">Select</option>
					[#list cityListt as city]
							<option value="${city.id}" [#if supplier.cityId==(city.id)] selected="selected"[/#if]>${city.cityName}</option>
					[/#list]
				</select>               
                </div>
              </div>
              
              
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <input id="cityId" name="cityId" type="hidden" value="${supplier.cityId}" />
                  <input id="supplierId" name="supplierId" type="hidden"  value="${supplier.supplierId}">
                  <input id="cityName" name="city" type="hidden" value="${supplier.city}">
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
