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
			  <li class="active"><a href="#home" data-toggle="tab">General</a></li>
			  [#if isShow==1]<li><a href="editDetailedInfo.jhtml?id=${customer.customerId}">Detailed Info</a></li>[/#if]
			  <li><a href="editCustomerWithOrderInfo.jhtml?id=${customer.customerId}">Order Info</a></li>
			</ul>
			<form action="updateCustomerWithBasicInfo.jhtml" method="post">
				<input name="customerId" value="${customer.customerId}" type="hidden">
				<div class="tab-content">
				  <div class="tab-pane active cont" id="home">
				  	<div>
				  		<table style="width:100%;">
	  						<tr style="width:100%;">
	  							<td><label class="col-sm-3 control-label">Last Name</label></td>
	  							<td><input type="text" name="lastName" class="form-control" required value="${customer.lastName}"/></td>
	  							<td><label class="col-sm-3 control-label">First Name</label></td>
	  							<td><input type="text" name="firstName" class="form-control" required value="${customer.firstName}"/></td>
	  							<td><label class="col-sm-3 control-label">Gender</label></td>
	  							<td>
	  								 <label class="radio-inline"> <input type="radio" checked="" name="sex" class="icheck" value="1" [#if customer.sex==1]checked="checked"[/#if]> Female</label> 
      								 <label class="radio-inline"> <input type="radio" name="sex" class="icheck" value="2" [#if customer.sex==2]checked="checked"[/#if]> Male</label> 
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td><label class="col-sm-3 control-label">Phone1</label></td>
	  							<td><input type="text" name="tel" class="form-control" required value="${customer.tel}"/></td>
	  							<td><label class="col-sm-3 control-label">Language</label></td>
	  							<td>
	  								 <select id="sellanguage" name="languageId" class="select2" >
										<option value="">Select</option>
										[#list languageList as language]
											<option value="${language.languageId}" [#if customer.languageId==language.languageId]selected="selected"[/#if]>${language.language}</option>
										[/#list]
									</select>
	  							</td>
	  							<td style="width:15%;"><label class="col-sm-3 control-label">Source</label></td>
	  							<td>
	  								<select id="sellanguage" name="customerSource" class="select2" >
										<option value="">Select</option>
										[#list customerSourceList as customerSource]
											<option value="${customerSource.customerSourceId}" [#if customer.customerSource==customerSource.customerSourceId]selected="selected"[/#if]>${customerSource.sourceName}</option>
										[/#list]
									</select>
	  							</td>
	  						</tr>
	  						<tr style="width:100%;">
	  							<td><label class="col-sm-3 control-label">Email</label></td>
	  							<td>
					                 <input type="email" name="email" class="form-control" parsley-type="email"  value="${customer.email}"/>
	  							</td>
	  							<td></td>
	  							<td></td>
	  							<td></td>
	  							<td></td>
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
				<input name="flag" type="hidden" value="0">
				<input name="isNew" type="hidden" value="${isNew}">
				</form>
				<div style="width:100%;height:30px;background-color:#2BBCA0;margin-top:20px;"></div>
				<div>
					<div style="width:100%;">
					<div>
					<form action="" method="post" id="customerConsulationForm">
						<input type="hidden" name="customerId" value="${customer.customerId}" id="customerIdForConsulation">
						<div style="width:100%;border:1px solid #2BBCA0;">
						<div style="width:100%; background-color:#ccc;"></div>
				            <table>
				            	<tr>
				            		<td colspan="2" style="width:40%;">
				            			<select name="consultMethod" class="select2" >
							              	<option value="Phone" selected="selected">Phone</option>
							              	<option value="Walk in">Walk in</option>
							              </select>
				            		</td>
				            		<td style="width:10%;margin-left:20%;text-align:right;">Remind Days</td>
				            		<td style="width:30%;">
				            			<input type="text" name="endDateForString" class="form-control" id="endDateForString"  placeholder="Remind me about this call after theses days">
				            		</td>
				            	</tr>
				            	<tr>
				            		<td colspan="2" style="width:40%;">
				            			<textarea rows="8" cols="30" name="consultContent" id="consultContent"  style="width:100%;"></textarea>
				            		</td>
				            		<td style="width:10%;margin-left:20%;"></td>
				            		<td style="width:30%;text-align:right;">
				            			<button  type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
					    				<button style="margin-right:15px;" type="button" class="btn btn-default" id="saveCustomerConsulationButton">Save</button>
				            		</td>
				            	</tr>
				            </table>
						<div>
						<input name="isNew" type="hidden" value="${isNew}">
					</form>
					</div>
					 <table id="customerConsultList" style="margin-top:30px;">
					 		[#list consulationList as customerConsult]
						  		<tr>
						  			<td style="width:55%;font-size:12px;margin-left:5%;">${customerConsult.consultContent}</td>
						  			<td style="width:10%;font-size:12px;">
						  				${customerConsult.consultMethod}
						  			</td>
						  			<td style="width:10%;font-size:12px;">
						  				${customerConsult.userName}
						  			</td>
						  			<td style="width:10%;font-size:12px;">
						  				${customerConsult.createDate?string("yyyy-MM-dd HH:mm:ss")}
						  			</td>
						  		</tr>
					 		[/#list]
					  	</table>
					  </div>
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
    	
    $("#saveCustomerConsulationButton").click(function(){
    	customerIdForConsulation = $("#customerIdForConsulation").val();
    	if(customerIdForConsulation.length!=0){
    	if($("#consultContent").val()==""){
    		alert("请输入咨询内容！");
    	}else{
    		var z= /^[0-9]*$/;
    		var endDateForString = $("#endDateForString").val();
    		if(z.test(endDateForString.trim())){
	    	$.ajax({
				type: "POST",
				data: $("#customerConsulationForm").serialize(),
				url: "${base}/admin/customer/saveCustomerConsulation.jhtml",
				success: function(map){
					customerConsult = map.customerConsult;
					str="";
				 		str+='<tr>'+
					  			'<td style="width:60%;font-size:12px;">'+customerConsult.consultContent+'</td>'+
				  				'<td style="width:10%;font-size:12px;">'+customerConsult.consultMethod+'</td>'+
				  				'<td style="width:10%;font-size:12px;">'+customerConsult.userName+'</td>'+
				  				'<td style="width:10%;font-size:12px;">'+customerConsult.createDateStr+'</td>'+
						  	  '</tr>';
				 		$("#customerConsultList").append(str);
				 		$("#consultContent").val("");
				 		$("#consultMethod").val("");
				}
			})
			}else{
				alert("Please enter a number for Remind Days");
			}
		}
		}else{
			alert("请保存客人信息！");
		}
    });
    });
    
</script>
</body>
</html>
