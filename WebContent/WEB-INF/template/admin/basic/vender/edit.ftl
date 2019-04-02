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
            <h2>Edit</h2>
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
              <form class="form-horizontal group-border-dashed" method="POST"   action="${base}/admin/vender/update.jhtml">
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Trading Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="name" required value="${vender.name}" />
                </div>
              </div>
          	<div class="form-group">
                <label class="col-sm-3 control-label">Business Registration Number</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" value="${vender.registrationNo}" name="registrationNo" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tel</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="tel" required parsley-type="number" value="${vender.tel}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="email"  parsley-type="email" value="${vender.email}"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Billing Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="billEmail"  parsley-type="email" value="${vender.billEmail}"  />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">B2B Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="b2bEmail"  parsley-type="email" value="${vender.b2bEmail}"  />
                </div>
              </div>
          	 <div class="form-group">
                <label class="col-sm-3 control-label">Fax</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="fax"  value="${vender.fax}"  />
                </div>
              </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Main Contact Person</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="contactor"   value="${vender.contactor}"  />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Street Address</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="address"  value="${vender.address}"  />
                </div>
              </div>
          	<div class="form-group">
                <label class="col-sm-3 control-label">Suburb / City</label>
                <div class="col-sm-6">
                	 <input type="text" class="form-control" name="cityId" value="${vender.cityId}" />
                </div>
              </div>
        	  <div class="form-group">
                <label class="col-sm-3 control-label">State / Province / Region</label>
                <div class="col-sm-6">
                	 <input type="text" class="form-control" name="stateId" value="${vender.stateId}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Country</label>
                <div class="col-sm-6">
				<select id="selCountry" required class="select2" name="countryId" onchange="generalStateSelect(this);">
					<option value="">Select</option>
					[#list countryList as country]
							<option value="${country.id}" [#if vender.countryId==(country.id)] selected="selected"[/#if]>${country.countryName}</option>
					[/#list]
				</select>               
                </div>
              </div>
             
               <div class="form-group">
                <label class="col-sm-3 control-label">Post Code / ZipCode</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="zipCode" maxlength="36" value="${vender.zipCode}" />
                </div>
              </div>
         	 <div class="form-group">
                <label class="col-sm-3 control-label">Bank Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="bankName" value="${vender.bankName}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Business Identifier Code / SWIFT</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="businessCode" value="${vender.businessCode}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Branch Number / BSB</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="branchNo" value="${vender.branchNo}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Bank Account Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="accountName" value="${vender.accountName}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Bank Account Number</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="accountNumber" value="${vender.accountNumber}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Agency Type</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="peerType" value="1" [#if vender.peerType == 1] checked="checked"[/#if] class="icheck">CH Wholesale</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="2" [#if vender.peerType == 2] checked="checked"[/#if] class="icheck"> EN Wholesale</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="3" [#if vender.peerType == 3] checked="checked"[/#if] class="icheck"> US Inbound</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="4" [#if vender.peerType == 4] checked="checked"[/#if] class="icheck"> School</label> 
                  <label class="radio-inline"> <input type="radio" name="peerType" value="5" [#if vender.peerType == 5] checked="checked"[/#if] class="icheck"> Business</label> 
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Type</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="type" value="2" [#if vender.type == 2] checked="checked"[/#if] class="icheck"> Supplier</label> 
                  <label class="radio-inline"> <input type="radio" name="type" value="1" [#if vender.type == 1] checked="checked"[/#if] class="icheck"> Agency</label> 
                  <label class="radio-inline"> <input type="radio" name="type" value="3" [#if vender.type == 3] checked="checked"[/#if] class="icheck"> Supplier/Agencies</label> 
                </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <input name="venderId" type="hidden"  value="${vender.venderId}">
                  <input name="userId" type="hidden"  value="${vender.userId}">
                  <input name="deptId" type="hidden"  value="${vender.deptId}">
                  <input name="type" type="hidden"  value="${vender.type}">
                  
                  <!--此处传送搜索条件-->
              		<input type="hidden" name="codeS" [#if venderPage.code??]value="${venderPage.code}"[#else]value="0"[/#if] />
					<input type="hidden" name="nameS" [#if venderPage.name??]value="${venderPage.name}"[#else]value="0"[/#if] />
					<input type="hidden" name="telS" [#if venderPage.tel??]value="${venderPage.tel}"[#else]value="0"[/#if] />
					<input type="hidden" name="contactorS" [#if venderPage.contactor??]value="${venderPage.contactor}"[#else]value="0"[/#if] />
					<input type="hidden" name="cityIdS" [#if venderPage.cityId??]value="${venderPage.cityId}"[#else]value="0"[/#if] />
					<input type="hidden" name="stateIdS" [#if venderPage.stateId??]value="${venderPage.stateId}"[#else]value="0"[/#if] />
					<input type="hidden" name="countryNameS" [#if venderPage.countryName??]value="${venderPage.countryName}"[#else]value="0"[/#if] />
					<input type="hidden" name="zipcodeS" [#if venderPage.zipcode??]value="${venderPage.zipcode}"[#else]value="0"[/#if] />
					
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
