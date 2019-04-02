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
            <a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right"><i class="fa fa-mail-reply" title="back"></i></a>
	       	[@shiro.hasPermission name = "admin:showbtn"]
	        <button style="float:right" onclick="window.location.href='fillTicketInfo.jhtml?id=${order.id}'" data-wizard="#wizard1" class="btn btn-primary" style="margin-right:40px;">
			  		Edit Info 
			</button>
			[/@shiro.hasPermission]
			<ol class="breadcrumb">
				<li>
					<a style="cursor:pointer;" href="../../">
						Home
					</a>
				</li>
				<li>
					<a style="cursor:pointer;" href="list.jhtml">
						Booking
					</a>
				</li>
        </div>
 <div class="cl-mcont">		
    <div class="row">
     <div class="col-md-12">
       <div class="block-flat">
      		<div class="content" style = "margin-top:20px;">
            	<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Passenger Info:</div>
					<div class="content">
						<table class="table table-bordered dataTable no-footer">
							<thead>
								<tr>
									<th>No.</th>
									<th>LastName</th>
									<th>FirstName</th>
									<th>MiddleName</th>
									<th>Gender</th>
									<th>Date of Birth</th>
									<th>Nationality</th>
									<th>Passport No.</th>
									<th>Expiry Date</th>
									<th>Language</th>
									<th>Room</th>
									<th>Ticket Type</th>
									<th>Voucher</th>
								</tr>
							</thead>
							<tbody>
							[#list customerOrderRelList as cor]
								<tr>
									<td>${cor.customerOrderNo}</td>
									<td>${cor.customer.lastName}</td>
									<td>${cor.customer.firstName}</td>
									<td>${cor.customer.middleName}</td>
									<td>[#if customer.sex == 1]F[#elseif customer.sex == 2]M [#else][/#if]</td>
									<td>[#if (cor.customer.dateOfBirth)??]${cor.customer.dateOfBirth?string('yyyy-MM-dd')}[/#if]</td>
									<td>${cor.customer.nationalityOfPassport}</td>
									<td>${cor.customer.passportNo}</td>
									<td>[#if (cor.customer.expireDateOfPassport)??]${cor.customer.expireDateOfPassport?string('yyyy-MM-dd')}[/#if]</td>
									<td>${cor.customer.languageId}</td>
									<td>${cor.guestRoomType}</td>
									<td>${cor.ticketType}</td>
									<td>${cor.voucherStr}</td>
								</tr>
							[/#list]
							</tbody>
						</table>
					</div>
				</div>
				
		<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Booking Info:</div>
			<table width="100%">
				<tbody>
					<tr>
						<td width="20%">Domestic Tickets:</td>
						<td width="30%">
						</td>
						<td width="20%">
							Product Name:
						</td>
						<td width="30%">
							${tourInfoForOrder.lineName}
						</td>
					</tr>
					<tr>
						<td>Arrival Date:</td>
						<td>
							[#if (tourInfoForOrder.scheduleOfArriveTime)??]${tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]
						</td>
						<td>
							<span>
								Product Code:
							</span>
						</td>
						<td>
							${tourInfoForOrder.scheduleLineCode}
						</td>
					</tr>
					<tr>
						<td>Tour Type:</td>
						<td>
							${order.tourTypeId}
						</td>
						<td>
							<span>
								出签日期:
							</span>
						</td>
						<td>
							[#if (order.checkOutDate)??]${order.checkOutDate?string('yyyy-MM-dd')}[/#if]
						</td>
					</tr>
					<tr>
						<td>
							<span>
								送签日期:
							</span>
						</td>
						<td>
							[#if (order.sendingDate)??]${order.sendingDate?string('yyyy-MM-dd')}[/#if]
						</td>
						<td>
							<span>
								销签日期:
							</span>
						</td>
						<td>
							[#if (order.pinSigningDate)??]${order.pinSigningDate?string('yyyy-MM-dd')}[/#if]
						</td>	
					</tr>
					<tr>
						<td width="20%">
							Notice:
						</td>
						<td colspan="3" width="30%">
							${tourInfoForOrder.specialRequirements}
						</td>
					</tr>
					
				</tbody>
			</table>
			
		</div>
	</div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
   $(document).ready(function () {
        //initialize the javascript
        App.init();
    });
</script>
</body>
</html>
