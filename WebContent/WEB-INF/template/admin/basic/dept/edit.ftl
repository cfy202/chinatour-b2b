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
                <li><a href="[@spring.url '/admin'/]">Home</a></li>
                <li><a href="#">SettingS</a></li>
                <li class="active">Office</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" method="POST"   action="${base}/admin/dept/update.jhtml">
              <div class="form-group">
                <label class="col-sm-3 control-label">Office Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"    name="deptName" value="${dept.deptName}"  placeholder="Please enter the Office Name" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Tel</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="tel"  value="${dept.tel}" placeholder="Please enter the Tel" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Mobile</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="mobile" value="${dept.mobile}" placeholder="Please enter the Mobile" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="email" value="${dept.email}" placeholder="Please enter the Email" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Address</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="address" value="${dept.address}" placeholder="Please enter the Address" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Fax</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="fax" value="${dept.fax}" placeholder="Please enter the Fax" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">ZipCode</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="zipCode"  value="${dept.zipCode}" placeholder="Please enter the ZipCode" />
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Country</label>
                <div class="col-sm-6">
                	<select type="text" name="countryId" class="select2">
                    [#list countrys as country]
                      <option value="${country.id}" 
                      [#if "${country.id==dept.countryId}"] selected="selected" [/#if]>
                      ${country.countryName}</option>
                    [/#list]
                 </select>
                </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">City</label>
                <div class="col-sm-6">
                	<select type="text" name="cityId" class="select2">
                    [#list citys as city]
                      <option value="${city.id}" 
                      [#if "${city.id==dept.cityId}"] selected="selected" [/#if]>
                      ${city.cityName}</option>
                    [/#list]
                 </select>
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Currency Type</label>
                <div class="col-sm-6">
                  <select type="text" name="currencyTypeId" class="select2">
                    [#list currencys as currency]
                      <option value="${currency.id}" 
                      [#if "${currency.id==dept.currencyTypeId}"] selected="selected" [/#if]>
                      ${currency.currencyChs}</option>
                    [/#list]
                   </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Description</label>
                <div class="col-sm-6">
                	<textarea class="form-control" name="explains" value="${dept.explains}"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Active</label>
                <div class="col-sm-6">
                 	<div class="radio"> 
                    	<label> <input type="radio"  name="isDel" value="0" class="icheck"  [#if "${dept.isDel==0}"] checked="checked" [/#if]>Yes</label> 
                    	&nbsp;&nbsp;&nbsp;&nbsp;
                    	<label> <input type="radio"  name="isDel" value="1" class="icheck"  [#if "${dept.isDel==1}"] checked="checked" [/#if]>No</label> 
                  	</div>
                </div>
              </div>
              <div class="form-group">
                  <label class="col-sm-3 control-label">StartTime</label>
                  <div class="col-sm-6">
					<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
						<input type="text" readonly="readonly" class="form-control" name="startTime" size="10"
						[#if (tourTypeOfDeptS[0].startTime)??]
								value="${tourTypeOfDeptS[0].startTime?string("yyyy-MM-dd")}"
						[/#if]
						>
						<span class="input-group-addon btn btn-primary">
						     <span class="glyphicon glyphicon-th"></span>
				        </span>
				    </div>
				  </div>
			  </div>
              <div class="form-group">
                  <label class="col-sm-3 control-label">EndTime</label>
                  <div class="col-sm-6">
					<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
						<input type="text" readonly="readonly" class="form-control" name="endTime" size="10"
						[#if (tourTypeOfDeptS[0].endTime)??]
								value="${tourTypeOfDeptS[0].endTime?string("yyyy-MM-dd")}"
						[/#if]
						>
						<span class="input-group-addon btn btn-primary">
						     <span class="glyphicon glyphicon-th"></span>
				        </span>
				    </div>
				  </div>
			  </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                <input type="hidden"name="deptId" value="${dept.deptId}"/>
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
    });
</script>
</body>
</html>
