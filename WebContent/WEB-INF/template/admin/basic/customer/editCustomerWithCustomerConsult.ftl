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
        <div class="block-flat" style="height:600px;">
          <div class="tab-container">
			<ul class="nav nav-tabs">
			  <li><a href="editCustomerWithBasicInfo.jhtml?id=${customerId}">General</a></li>
			  <li class="active"><a href="#profile">Service Records</a></li>
			  <li><a href="editCustomerWithOrderInfo.jhtml?id=${customerId}">Tour Info</a></li>
			</ul>
				<div class="tab-content">
				 <div class="tab-pane active cont" id="profile">
					 <div style="width:65%;float:left;">
					  	<table style="border-bottom:1px solid #ccc;" id="customerConsultList">
				 		[#list customerConsultList as customerConsult]
					  		<tr>
					  			<td style="width:60%;font-size:12px;">${customerConsult.consultContent}</td>
					  			<td style="width:30%;margin-left:10%;text-align:right;">
					  				<p style="height:20px;margin:0px;padding:0px;">${customerConsult.consultMethod}</p>
					  				<p style="height:20px;margin:0px;padding:0px;">${customerConsult.userName}</p>
					  				<p style="height:20px;margin:0px;padding:0px;">${customerConsult.createDate?string("yyyy-MM-dd")}</p>
					  			</td>
					  		</tr>
				 		[/#list]
					  	</table>
					  </div>
					<form action="" method="post" id="customerConsulationForm">
						<input type="hidden" name="customerId" value="${customerId}">
						<div style="width:30%;float:right;border:1px solid #ccc;height:360px;background-color:#fce6d4;">
							<div class="form-group" style="margin-left:18px;width:83%;">
				              <label></label>
				              <select name="consultMethod" class="select2" >
				              	<option value="phone" selected="selected">phone</option>
				              	<option value="face to face">face to face</option>
				              </select> 
				            </div>
				            <div class="form-group" style="margin-left:18px;">
				              <p>Content</p>
				              <textarea rows="8" cols="30" name="consultContent" id="consultContent"  style="width:89%;"></textarea>
				            </div>
				            <div class="form-group" style="margin-left:18px;">
				            	<button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
					    		<button type="button" class="btn btn-default" style="margin-left:100px;" id="saveCustomerConsulationButton">Save</button>
				            </div>
						<div>
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
    
    $("#saveCustomerConsulationButton").click(function(){
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
    });
</script>
</body>
</html>
