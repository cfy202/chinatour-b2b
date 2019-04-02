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
        <div class="block-flat" style="height:600px;">
          <div class="tab-container">
			<ul class="nav nav-tabs">
			  <li><a href="editCustomerWithBasicInfo.jhtml?id=${customerId}&isNew=1">General</a></li>
			  [#if isShow==1]<li><a href="editDetailedInfo.jhtml?id=${customerId}">Detailed Info</a></li>[/#if]
			  <li class="active"><a href="#messages" data-toggle="tab">Tour Info</a></li>
			</ul>
				<div class="tab-content">
				  <div class="tab-pane active cont" id="messages">
				  		 <table class="table table-bordered" id="datatable2">
                            <thead>
                            <tr>
                                <th>Booking No.</th>
                                <th>Reference No.</th>
                                <th>Tour Code</th>
                                <th>Agent</th>
                            </tr>
                            </thead>
                            <tbody>
                            [#list orderList as order]
                            <tr>
                            <td>
								<!--是agent跳转修改页面
								[@shiro.hasPermission name = "admin:addBooking"]
									<a href="${base}/admin/orders/edit.jhtml?menuId=302&ordersTotalId=${order.ordersTotalId}">${order.orderNo}</a>
								[/@shiro.hasPermission]
								-->
								<!--不是agent跳转查看页面
								[@shiro.lacksPermission name = "admin:addBooking"]
									<a href='${base}/admin/tour/orderInfo.jhtml?menuId=810&id=${order.id}'>${order.orderNo}</a>
								[/@shiro.lacksPermission]
								-->
								[#if order.userName==admin.username ]
									<a href="${base}/admin/orders/edit.jhtml?menuId=302&ordersTotalId=${order.ordersTotalId}">${order.orderNo}</a>
								[#else]
									<a href='${base}/admin/tour/orderInfo.jhtml?menuId=810&id=${order.id}'>${order.orderNo}</a>
								[/#if]
										
							</td>
								<td>${order.refNo}</td>
                            	<td>${order.tourCode}</td>
                            	<td>${order.userName}</td>
                            </tr>
                            [/#list]
                            </tbody>
                        </table>
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
					  			'<td style="width:70%;font-size:12px;">'+customerConsult.consultContent+'</td>'+
					  			'<td style="width:20%;margin-left:10%;text-align:right;">'+
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
