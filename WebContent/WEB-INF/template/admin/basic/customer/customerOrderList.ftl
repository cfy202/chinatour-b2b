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
<!-- Modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Passengers</h2>
            <div class="new"><a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Passengers</li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                    <tr>
                                        <th>Booking No.</th>
                                        <th>Tour Code</th>
                                        <th>Agent</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    [#list orderList as order]
                                    <tr>
                                    <td>
										<!--是agent跳转修改页面-->
										[#if order.userName==admin.username ]
											<!--[@shiro.hasPermission name = "admin:addBooking"]
												<a href="${base}/admin/orders/edit.jhtml?menuId=302&ordersTotalId=${order.ordersTotalId}">${order.orderNo}</a>
											[/@shiro.hasPermission]
											-->
											<a href="${base}/admin/orders/edit.jhtml?menuId=302&ordersTotalId=${order.ordersTotalId}">${order.orderNo}</a>
										[#else]
											<a href='${base}/admin/tour/orderInfo.jhtml?menuId=810&id=${order.id}'>${order.orderNo}</a>
										[/#if]
										
										<!--不是agent跳转查看页面
										[@shiro.lacksPermission name = "admin:addBooking"]
											<a href='${base}/admin/tour/orderInfo.jhtml?menuId=810&id=${order.id}'>${order.orderNo}</a>
										[/@shiro.lacksPermission]
										-->
									</td>
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
    </div>

</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
    });
</script>
</body>
</html>
