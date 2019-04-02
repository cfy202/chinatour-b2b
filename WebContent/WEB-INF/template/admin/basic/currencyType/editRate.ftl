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
            <h2>Rate Edit</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Currency</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
          <div class="content">
          		<form class="form-horizontal group-border-dashed" action="updateRate.jhtml" method="post" parsley-validate novalidate>
			      	<div class="form-group">
			          <label class="col-sm-3 control-label">Currency</label> 
			          <div class="col-sm-6">
				          <select id="selDept" name="currencyId" class="select2" disabled>
								<option value="">Select</option>
								[#list currencyTypeList as currencyTypes]
									<option value="${currencyTypes.id}" [#if currencyTypes.id==(rateOfCurrency.currencyId)] selected="selected"[/#if]>${currencyTypes.currencyChs}</option>
								[/#list]
						 </select>
					  </div>
			        </div>
			        <div class="form-group">
			          <label class="col-sm-3 control-label">Currency Conversion</label> 
			          <div class="col-sm-6">
				          <select id="selDept" name="toCurrencyId" class="select2" >
								<option value="">Select</option>
								[#list currencyTypeList as currencyType]
									<option value="${currencyType.id}" [#if currencyType.id==(rateOfCurrency.toCurrencyId)] selected="selected"[/#if]>${currencyType.currencyChs}</option>
								[/#list]
						 </select>
					   </div>
			        </div>
			        <div class="form-group">
			            <label class="col-sm-3 control-label">Rate:</label>
			            <div class="col-sm-6">
			            	 <input type="text" name="rateUp" placeholder="rateUp" value="${rateOfCurrency.rateUp}" size="8">/
			            	<input type="text" name="rateDown" placeholder="rateDown" value="${rateOfCurrency.rateDown}" size="8">
			            	&nbsp;
			            	<input type="text" name="usRate" placeholder="USD Rate" value="${rateOfCurrency.usRate}" size="8">
			          	</div>
			        </div>
			        
			      <div class="form-group">
	                <div class="col-sm-offset-2 col-sm-10">
	                  <input type="hidden" name="id" value="${rateOfCurrency.id}"/>
	                  <input type="hidden" name="currencyId" value="${rateOfCurrency.currencyId}"/>
	                  <button type="button" onclick="location.href='setRate?currencyId=${rateOfCurrency.currencyId}'" class="btn btn-default">Cancel</button>
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
