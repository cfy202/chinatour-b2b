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
            <h2>Edit</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Passengers</li>
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
              <input type="hidden" name="customerId" value="${customer.customerId}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
               <div class="form-group">
                <label class="col-sm-3 control-label">lastName</label>
                <div class="col-sm-6">
                  <input type="text" name="lastName" value="${customer.lastName}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">middleName</label>
                <div class="col-sm-6">
                  <input type="text" name="middleName" value="${customer.middleName}" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">firstName</label>
                <div class="col-sm-6">
                  <input type="text" name="firstName" value="${customer.firstName}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
       		  <div class="form-group">
                <label class="col-sm-3 control-label">Date Of Birth</label>
                <div class="col-sm-6">
                   <div class="input-group date datetime col-md-5 col-xs-7" data-min-view="2" data-date-format="yyyy-mm-dd">
                    <input  name="dateOfBirth" class="form-control" size="16" type="text"[#if (customer.dateOfBirth)??] value="${customer.dateOfBirth?string('yyyy-MM-dd')}" [/#if] readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
                </div>
              </div>
              <div class="form-group">
               <label class="col-sm-3 control-label">Gender</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" [#if "${customer.sex == 1}"] checked="checked" [/#if] name="sex" value="1" class="icheck"> Female</label> 
                  <label class="radio-inline"> <input type="radio" [#if "${customer.sex == 2}"] checked="checked" [/#if] name="sex" value="2" class="icheck"> Male</label> 
                </div>
              </div>
   			 <div class="form-group">
                <label class="col-sm-3 control-label">Remark</label>
                <div class="col-sm-6">
                  <input type="text" name="memoOfCustomer" value="${customer.memoOfCustomer}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Nationality</label>
                <div class="col-sm-6">
                  <input type="text" name="nationalityOfPassport" value="${customer.nationalityOfPassport}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Passport No.</label>
                <div class="col-sm-6">
                  <input type="text" name="passportNo" value="${customer.passportNo}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Expiry Date</label>
          	   <div class="col-sm-6">
            	 <div class="input-group date datetime col-md-5 col-xs-7" data-min-view="2" data-date-format="yyyy-mm-dd">
                    <input  name="expireDateOfPassport" class="form-control" size="16" type="text"  [#if (customer.expireDateOfPassport)??] value="${customer.expireDateOfPassport?string('yyyy-MM-dd')}" [/#if] readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
                 </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Address</label>
                <div class="col-sm-6">
                  <input type="text" name="streetAddress" value="${customer.streetAddress}" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tel</label>
                <div class="col-sm-6">
                  <input type="text" name="tel" value="${customer.tel}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
   			  <div class="form-group">
                <label class="col-sm-3 control-label">Mobile</label>
                <div class="col-sm-6">
                  <input type="text" name="mobile" value="${customer.mobile}" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="email" name="email" value="${customer.email}" class="form-control" required parsley-type="email"  placeholder="Max 6 chars." />
                </div>
              </div>
     		  <div class="form-group">
                <label class="col-sm-3 control-label">Notification Status</label>
                <div class="col-sm-6">
                 <select type="text" name="advertised" id="advertisedId" class="form-control">
                        <option value="1">Yes</option>
                        <option value="2">No</option>
               		</select>
                </div>
              </div>
           	  <div class="form-group">
                <label class="col-sm-3 control-label">Booking Remark</label>
                <div class="col-sm-6">
                  <input type="text" name="otherInfo" value="${customer.otherInfo}" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Language</label>
                <div class="col-sm-6">
                  <select id="sellanguage" name="languageId" class="select2" >
					<option value="">Select</option>
					[#list languageList as language]
						<option value="${language.languageId}" [#if customer.LanguageId==(language.id)] selected="selected"[/#if]>${language.language}</option>
					[/#list]
				</select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Related Booking</label>
                <div class="col-sm-6">
                 <select type="text" name="customerSource" id="customerSourceId" class="form-control">
                        <option value="1">Join-in Tour</option>
                        <option value="2">Hotel Booking</option>
                        <option value="3">Flight Booking</option>
               		</select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Flight Booking Type</label>
                <div class="col-sm-6">
               		<select type="text" name="Planticket" id="PlanticketId" class="form-control">
                        <option value="1">Booked by Agent</option>
                        <option value="2">Booked by OP</option>
                        <option value="3">Booked by Agent & OP</option>
               		</select>
                </div>
              </div>
         	  <div class="form-group">
                <label class="col-sm-3 control-label">Remark</label>
                <div class="col-sm-6">
                  <input type="text" name="payHistoryInfo" value="${customer.payHistoryInfo}" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Country</label>
                <div class="col-sm-6">
				<select id="selCountry" name="countryId" class="select2" >
					<option value="">Select</option>
					[#list countryList as country]
						<option value="${country.id}" [#if customer.countryId==(country.id)] selected="selected"[/#if]>${country.countryName}</option>
					[/#list]
				</select>               
                </div>
              </div>
          	   <div class="form-group">
                <label class="col-sm-3 control-label">State</label>
                <div class="col-sm-6">
				<select id="selState" name="stateId" class="select2" >
					<option value="">Select</option>
					[#list stateList as state]
						<option value="${state.id}" [#if customer.stateId==(state.id)] selected="selected"[/#if]>${state.stateName}</option>
					[/#list]
				</select>               
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">City</label>
                <div class="col-sm-6">
				<select id="selCity" name="cityId" class="select2" >
					<option value="">Select</option>
					[#list cityList as city]
						<option value="${city.id}" [#if customer.cityId==(city.id)] selected="selected"[/#if]>${city.cityName}</option>
					[/#list]
				</select>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="submit" style="margin-left:336px;" class="btn btn-primary">update</button>
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
       $("#customerSourceId option[value='${customer.customerSource}']").attr("selected",true);
       $("#PlanticketId option[value='${customer.planticket}']").attr("selected",true);
       $("#advertisedId option[value='${customer.advertised}']").attr("selected",true);
    });
</script>
</body>
</html>
