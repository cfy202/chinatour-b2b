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
            <h2>New</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Supplier/Agencies</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/vender/save.jhtml">
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Trading Name<font color="red">*</font></label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="name" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Business Registration Number</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="registrationNo" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tel<font color="red">*</font></label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="tel" required parsley-type="number"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="email"  parsley-type="email" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Billing Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="billEmail"  parsley-type="email" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">B2B Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="b2bEmail"  parsley-type="email" />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Fax</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="fax"  />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Main Contact Person</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="contactor"  />
                </div>
              </div>
                <div class="form-group">
                <label class="col-sm-3 control-label">Street Address</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="address"  />
                </div>
              </div>
           	<div class="form-group">
                <label class="col-sm-3 control-label">Suburb / City</label>
                <div class="col-sm-6">
                <input type="text" class="form-control" name="cityId"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">State / Province / Region</label>
                <div class="col-sm-6">
                	 <input type="text" class="form-control" name="stateId"  />
                </div>
              </div>
           <div class="form-group">
                <label class="col-sm-3 control-label">Country<font color="red">*</font></label>
                <div class="col-sm-6">
				<select id="selCountry" name="countryId"  class="select2" required>
					<option value="">Select</option>
					[#list countryList as country]
						<option value="${country.id}">${country.countryName}</option>
					[/#list]
				</select>               
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Post Code / ZipCode</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="zipCode" maxlength="36" />
                </div>
              </div>
              
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Bank Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="bankName"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Business Identifier Code / SWIFT</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="businessCode" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Branch Number / BSB</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="branchNo"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Bank Account Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="accountName"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Bank Account Number</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="accountNumber"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Agency Type</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="peerType" value="1" checked="" class="icheck">CH Wholesale</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="2" class="icheck"> EN Wholesale</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="3" class="icheck"> US Inbound</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="4" class="icheck"> School</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="5" class="icheck"> Business</label> 
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Type</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="type" value="2" checked="" class="icheck"> Supplier</label> 
                  <label class="radio-inline"> <input type="radio" name="type" value="1" class="icheck"> Agency</label> 
                  <label class="radio-inline"> <input type="radio" name="type" value="3" class="icheck"> Supplier/Agencies</label> 
                </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                  <!--<button type="button" onclick="redirect(2)" class="btn btn-default">Save and New</button>-->
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
