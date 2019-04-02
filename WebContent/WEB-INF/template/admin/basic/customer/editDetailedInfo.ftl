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
                <li><a href="#">Customer</a></li>
                <li class="active">Phone Records</li>
            </ol>
        </div>
	<div class="row">
	<div class="col-md-12">
        <div class="block-flat" style="height:800px;">
          <div class="tab-container">
			<ul class="nav nav-tabs">
			  <li><a href="editCustomerWithBasicInfo?id=${customer.customerId}&isNew=1">General</a></li>
			  <li class="active"><a href="#">Detailed Info</a></li>
			  <li><a href="editCustomerWithOrderInfo?id=${customer.customerId}">Order Info</a></li>
			</ul>
			<form action="updateCustomerWithBasicInfo.jhtml" method="post">
				<input name="customerId" value="${customer.customerId}" type="hidden">
				<div class="tab-content">
				  <div class="tab-pane active cont" id="home">
				  	<div>
				  		<table style="width:100%;">
	  						<tr style="width:100%;">
	  							<td style="width:10%"><label class="col-sm-3 control-label">Last Name</label></td>
	  							<td style="width:23%"><input type="text" name="lastName" class="form-control" required value="${customer.lastName}"/></td>
	  							<td style="width:10%"><label class="col-sm-3 control-label">First Name</label></td>
	  							<td style="width:23%"><input type="text" name="firstName" class="form-control" required value="${customer.firstName}"/></td>
	  							<td style="width:10%"><label class="col-sm-3 control-label">Gender</label></td>
	  							<td style="width:23%">
	  								 <label class="radio-inline"> <input type="radio" checked="" name="sex" class="icheck" value="1" [#if customer.sex==1]checked="checked"[/#if]> Female</label> 
      								 <label class="radio-inline"> <input type="radio" name="sex" class="icheck" value="2" [#if customer.sex==2]checked="checked"[/#if]> Male</label> 
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:10%"><label class="col-sm-3 control-label">Phone1</label></td>
	  							<td style="width:23%"><input type="text" name="tel" class="form-control" required value="${customer.tel}"/></td>
	  							<td style="width:10%"><label class="col-sm-3 control-label">Language</label></td>
	  							<td style="width:23%">
	  								 <select id="sellanguage" name="languageId" class="select2" >
										<option value="">Select</option>
										[#list languageList as language]
											<option value="${language.languageId}" [#if customer.languageId==language.languageId]selected="selected"[/#if]>${language.language}</option>
										[/#list]
									</select>
	  							</td>
	  							<td style="width:10%"><label class="col-sm-3 control-label">Source</label></td>
	  							<td style="width:23%">
	  								<select id="sellanguage" name="customerSource" class="select2" >
										<option value="">Select</option>
										[#list customerSourceList as customerSource]
											<option value="${customerSource.customerSourceId}" [#if customer.customerSource==customerSource.customerSourceId]selected="selected"[/#if]>${customerSource.sourceName}</option>
										[/#list]
									</select>
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:10%">
	  								<label class="col-sm-3 control-label">Middle Name</label>
	  							</td>
	  							<td style="width:23%">
					                 <input type="text" name="middleName" value="${customer.middleName}" class="form-control" />
	  							</td>
	  							<td style="width:10%"><label class="col-sm-3 control-label">Date of Birth</label></td>
					            <td style="width:23%">
					                <div class="input-group date datetime col-md-12 col-xs-7" data-min-view="2" data-date-format="yyyy-mm-dd">
					                    <input  name="dateOfBirth" class="form-control" size="16" type="text"[#if (customer.dateOfBirth)??] value="${customer.dateOfBirth?string('yyyy-MM-dd')}" [/#if] readonly>
					                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
					                </div>
					            </td>
					             <td style="width:10%">
					             	<label class="col-sm-3 control-label">Nationality</label>
					             </td>
					             <td style="width:23%">
					                  <input type="text" name="nationalityOfPassport" value="${customer.nationalityOfPassport}" class="form-control"/>
					             </td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:10%"><label class="col-sm-3 control-label">Passport No.</label></td>
					                <td style="width:23%">
					                  <input type="text" name="passportNo" value="${customer.passportNo}" class="form-control"/>
					                </td>
				                	<td style="width:10%"><label class="col-sm-3 control-label">Expiry Date</label></td>
					          	   <td style="width:23%">
					               		<div class="input-group date datetime col-md-12 col-xs-7" data-min-view="2" data-date-format="yyyy-mm-dd">
						                    <input  name="expireDateOfPassport" class="form-control" size="16" type="text"  [#if (customer.expireDateOfPassport)??] value="${customer.expireDateOfPassport?string('yyyy-MM-dd')}" [/#if] readonly>
						                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
						                  </div>
					               </td>
				                	<td style="width:10%">
				                		 <label class="col-sm-3 control-label">Address</label>
				                	</td>
				                	<td style="width:23%">
						                 <input type="text" name="streetAddress" value="${customer.streetAddress}" class="form-control" />
				                	</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td style="width:10%">
	  								<label class="col-sm-3 control-label">Phone2</label>
	  							</td>
	  							<td style="width:23%">
					                <input type="text" name="mobile" value="${customer.mobile}" class="form-control" />
	  							</td>
	  							<td style="width:10%">
	  								<label class="col-sm-3 control-label">Email</label>
	  							</td>
	  							<td style="width:23%">
					                 <input type="email" name="email" value="${customer.email}" class="form-control" parsley-type="email"  />
	  							</td>
	  							<td style="width:10%">
	  								<label class="col-sm-3 control-label">State</label>
	  							</td>
	  							<td style="width:23%">
									<select id="selState" name="stateId" class="select2" >
										<option value="">Select</option>
										[#list stateList as state]
											<option value="${state.id}" [#if customer.stateId==(state.id)] selected="selected"[/#if]>${state.stateName}</option>
										[/#list]
									</select>
	  							</td>
	  						</tr>
	  					</table>
	  						<div style="margin-top:30px;margin-left:80%;">
	  							<button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
					    		<button type="submit" class="btn btn-default" style="margin-left:50px;">Save</button>
	  						</div>
	  					<div>
	  					</div>
				  	</div>
				</div>
				<input type="hidden" name="flag" value="1">
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
    	
    $("#saveCustomerConsulationButton").click(function(){
    	customerIdForConsulation = $("#customerIdForConsulation").val();
    	if(customerIdForConsulation.length!=0){
    	if($("#consultContent").val()==""){
    		alert("请输入咨询内容！");
    	}else{
	    	$.ajax({
				type: "POST",
				data: $("#customerConsulationForm").serialize(),
				url: "${base}/admin/customer/saveCustomerConsulation.jhtml",
				success: function(map){
					customerConsult = map.customerConsult;
					str="";
				 		str+='<tr>'+
					  			'<td style="width:60%;font-size:12px;">'+customerConsult.consultContent+'</td>'+
					  			'<td style="width:30%;margin-left:10%;text-align:right;">'+
					  				'<p style="height:20px;margin:0px;padding:0px;">'+customerConsult.consultMethod+'</p>'+
					  				'<p style="height:20px;margin:0px;padding:0px;">'+customerConsult.userName+'</p>'+
					  				'<p style="height:20px;margin:0px;padding:0px;">'+customerConsult.createDateStr+'</p>'+
					  			'</td>'+
						  	  '</tr>';
				 		$("#customerConsultList").append(str);
				 		$("#consultContent").val("");
				 		$("#consultMethod").val("");
				}
			})
		}
		}else{
			alert("请保存客人信息！");
		}
    });
    });
    
</script>
</body>
</html>
