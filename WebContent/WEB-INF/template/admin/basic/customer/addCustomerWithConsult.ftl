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
                <li><a href="#">Information</a></li>
                <li class="active">Passengers</li>
            </ol>
        </div>
	<div class="row">
	<div class="col-md-12">
        <div class="block-flat" style="height:500px;">
          <div class="tab-container">
			<ul class="nav nav-tabs">
			  <li class="active"><a href="#home" data-toggle="tab">General</a></li>
			  <li><a href="#profile" data-toggle="tab">Consultation Info</a></li>
			</ul>
			
				<div class="tab-content">
				  <div class="tab-pane active cont" id="home">
				  	<form class="form-horizontal group-border-dashed" action="saveCustomerWithConsulation.jhtml" method="post"> 
				  	<div>
				  		<table style="width:60%;float:left;">
	  						<tr style="width:100%;">
	  							<td style="width:15%;"><label class="col-sm-3 control-label">lastName</label></td>
	  							<td style="width:35%;"><input type="text" name="lastName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." /></td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">middleName</label></td>
	  							<td style="width:35%;"><input type="text" name="middleName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." /></td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:15%;"><label class="col-sm-3 control-label">firstName</label></td>
	  							<td style="width:35%;"><input type="text" name="firstName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." /></td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Date of Birth</label></td>
	  							<td style="width:35%;">
	  								 <div class="input-group date datetime" data-min-view="2" data-date-format="yyyy-mm-dd">
					                    <input  name="dateOfBirth" class="form-control" size="16" type="text" value="" readonly>
					                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					                  </div>
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Gender</label></td>
	  							<td style="width:35%;">
	  								 <label class="radio-inline"> <input type="radio" checked="" name="sex" class="icheck" value="1"> Female</label> 
      								 <label class="radio-inline"> <input type="radio" name="sex" class="icheck" value="2"> Male</label> 
	  							</td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Nationality</label></td>
	  							<td style="width:35%;">
	  								<input type="text" name="nationalityOfPassport" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Passport No.</label></td>
	  							<td style="width:35%;">
	  								 <input type="text" name="passportNo" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." /> 
	  							</td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Expiry Date</label></td>
	  							<td style="width:35%;">
	  								<div class="input-group date datetime" data-min-view="2" data-date-format="yyyy-mm-dd">
		  								<input  name="dateOfBirth" class="form-control" size="16" type="text" value="" readonly>
            							<span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
        							</div>
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Language</label></td>
	  							<td style="width:35%;">
	  								 <select id="sellanguage" name="languageId" class="select2" >
										<option value="">Select</option>
										[#list languageList as language]
											<option value="${language.languageId}">${language.language}</option>
										[/#list]
									</select>
	  							</td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Country</label></td>
	  							<td style="width:35%;">
	  								<select id="selCountry" name="countryId" class="select2" >
										<option value="">Select</option>
										[#list countryList as country]
											<option value="${country.id}">${country.countryName}</option>
										[/#list]
									</select>
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:15%;"><label class="col-sm-3 control-label">State</label></td>
	  							<td style="width:35%;">
	  								 <select id="selState" name="stateId" class="select2" >
											<option value="">Select</option>
											[#list stateList as state]
												<option value="${state.id}">${state.stateName}</option>
											[/#list]
										</select> 
	  							</td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Customer Source</label></td>
	  							<td style="width:35%;">
	  								<select name="customerSourceId" class="input-group1 select2" id="sheetId" >
										<option value="0">Select Source</option>
										[#list customerSourceList as customerSource]
											<option value="${customerSource.customerSourceId}">${customerSource.sourceName}</option>
										[/#list]
									</select>
	  							</td>
	  						</tr>
	  					</table>
				  	</div>
				  	<div style="float:right;width:30%;">
				  		<div class="form-group">
			              <label>Address</label> <input type="text" name="streetAddress" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
			            </div>
			            <div class="form-group">
			              <label>Tel</label><input type="text" name="tel" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
			            </div>
			            <div class="form-group"> 
			              <label>Email</label><input type="email" name="email" required parsley-type="email" class="form-control" placeholder="Max 6 chars." />
			            </div> 
				  	</div>
				  	<div class="form-group" style="margin-top:20px;">
		                <div class="col-sm-offset-2 col-sm-10">
		                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
		                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
		                </div>
		              </div>
				  	</form>
				</div>
				 <div class="tab-pane cont" id="profile">
					 <form class="form-horizontal group-border-dashed" action="saveCustomerWithConsulation.jhtml" method="post">
							<div class="form-group" style="width:60%;">
				              <label>Consulting Method</label> <input type="text" name="customerConsultList[0].customerSource" class="form-control" />
				            </div>
				            <div class="form-group" style="width:60%;">
				              <label>Consulting Content</label>
				              <textarea rows="5" cols="80" name="customerConsultList[0].consultContent">
							  </textarea>
				            </div>
				             <div class="form-group">
				                <div class="col-sm-offset-2 col-sm-10">
				                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
				                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
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
    });
</script>
</body>
</html>
