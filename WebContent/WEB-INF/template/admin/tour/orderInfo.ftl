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
            	<h3><b> Passenger Info:</b></h3>
					<div class="content">
						<table class="table table-bordered dataTable no-footer">
							<thead>
								<tr>
									<th>No.</th>
									<th>Last/First Middle Name</th>
									<!--<th>FirstName</th>
									<th>MiddleName</th>-->
									<th>Gender</th>
									<th>Date of Birth</th>
									<!-- <th>Phone</th> -->
									<th>Nationality</th>
									<th>Passport No.</th>
									<th>Expiry Date</th>
									<th>Language</th>
									<th>Room</th>
									<th>Room No.</th>
									<th>Ticket Type</th>
									<th>Voucher</th>
								</tr>
							</thead>
							<tbody>
							[#list customerList as customer]
								<tr>
									<td>${customer.customerCode}</td>
									<td>${customer.lastName}/${customer.firstName} ${customer.middleName}</td>
									<!--<td>${customer.firstName}</td>
									<td>${customer.middleName}</td>-->
									<td>[#if customer.sex == 1]F[#elseif customer.sex == 2]M [#else][/#if]</td>
									<td>[#if (customer.dateOfBirth)??]${customer.dateOfBirth?string('yyyy-MM-dd')}[/#if]</td>
									<!-- <td>${customer.mobile}</td> -->
									<td>${customer.nationalityOfPassport}</td>
									<td>${customer.passportNo}</td>
									<td>[#if (customer.expireDateOfPassport)??]${customer.expireDateOfPassport?string('yyyy-MM-dd')}[/#if]</td>
									<td>${customer.language.language}</td>
									<td>${customer.guestRoomType}</td>
									<td>${customer.getRoomNumber()+"/"+customer.getOrderNo()}</td>
									<td>${customer.ticketType}</td>
									<td>${customer.voucherStr}</td>
								</tr>
							[/#list]
							</tbody>
						</table>
					</div>
					
					<div style="margin-top:50px">
						<table class="table table-bordered dataTable no-footer">
							<thead>
								<tr>
									<th>No. </th>
									<th>Agent</th>
									<th>Airline</th>
									<th>Flight No.</th>
									<th>Arrival Time</th>
									<th>Arrival Date </th>
									<th>Arrival Flight</th>
									<th>Deviation</th>
								</tr>
							</thead>
							<tbody>
								[#list customerFlightList as customerFlight]
									[#if customerFlight.outOrEnter==1]
										<tr>
											<td>${customerFlight.customerNos}</td>
											<td>${customerFlight.userId}</td>
											<td>${customerFlight.flightCode}</td>
											<td>${customerFlight.flightNumber}</td>
											<td>[#if (customerFlight.arriveTime)??]${customerFlight.arriveTime}[/#if]</td>
											<td>[#if (customerFlight.arriveDate)??]${customerFlight.arriveDate?string('yyyy-MM-dd')}[/#if]</td>
											<td>Arrival Flight(
												[#if customerFlight.ifPickUp==1]
													Pick-up
												[/#if]
												[#if customerFlight.ifSendUp==1]
													/ Drop-off
												[/#if])
											</td>
											<td>${customerFlight.remark}</td>
										</tr>
									[/#if]
								[/#list]
							</tbody>
						</table>
					</div>
					
					<div style="margin-top:10px">
						<table class="table table-bordered dataTable no-footer">
							<thead >
								<tr>
									<th>No. </th>
									<th>Agent</th>
									<th>Airline</th>
									<th>Flight No.</th>
									<th>Departure Time</th>
									<th>Departure Date</th>
									<th>Departure Flight</th>
									<th>Deviation</th>
								</tr>
							</thead>
							<tbody>
								[#list customerFlightList as customerFlight]
									[#if customerFlight.outOrEnter==2]
										<tr>
											<td>${customerFlight.customerNos}</td>
											<td>${customerFlight.userId}</td>
											<td>${customerFlight.flightCode}</td>
											<td>${customerFlight.flightNumber}</td>
											<td>[#if (customerFlight.arriveTime)??]${customerFlight.arriveTime}[/#if]</td>
											<td>[#if (customerFlight.arriveDate)??]${customerFlight.arriveDate?string('yyyy-MM-dd')}[/#if]</td>
											<td>Departure Flight(
												[#if customerFlight.ifPickUp==1]
													Pick-up
												[/#if]
												[#if customerFlight.ifSendUp==1]
													/ Drop-off
												[/#if])
											</td>
											<td>${customerFlight.remark}</td>
										</tr>
									[/#if]
								[/#list]
							</tbody>
						</table>
					</div>
				</div>
		<h3><b> Booking Info:</b></h3>
			<table width="100%">
				<tbody>
					<tr>
						<td width="13%">Domestic Tickets:</td>
						<td>
							[#if order.planticket==1]
								Booked by Agent
							[#elseif order.planticket==2]
								Booked by OP
							[#else]
								Booked by Agent or OP
							[/#if]
						</td>
						<td width="13%">
							Remark:
						</td>
						<td width="37%">
							${order.otherInfo}
						</td>
					</tr>
					<tr>
						<td width="13%">Arrival Date:</td>
						<td width="37%">
							[#if (tourInfoForOrder.scheduleOfArriveTime)??]${tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]
						</td>
						<td width="13%">Tour Type:</td>
						<td width="37%">
							${order.tourTypeId}
						</td>
					</tr>
					<tr>
						<td width="13%">
							Product Name:
						</td>
						<td width="37%">
							${tourInfoForOrder.lineName}
						</td>
						<td width="13%">
							<span>
								Product Code:
							</span>
						</td>
						<td width="37%">
							${tourInfoForOrder.scheduleLineCode}
						</td>
					</tr>
					<tr>
						<td width="13%">
							Requirement:
						</td>
						<td width="300px;" colspan="3">
							<textarea class="form-control input-group1" rows="5" cols="30">
								${tourInfoForOrder.specialRequirements}
							</textarea>
						</td>
					</tr>
					<tr>
						<td width="13%">
							Tour Remark:
						</td>
						<td width="300px;" colspan="3">
							<textarea class="form-control input-group1" rows="5" cols="30">
								${tourInfoForOrder.tourInfo}
							</textarea>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Tour Voucher Remarks:
							</span>
						</td>
						<td width="37%" colspan="3">
							<textarea class="form-control input-group1" rows="5" cols="30">
								${tourInfoForOrder.voucherRemarks}
							</textarea>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Itinerary:
							</span>
						</td>
						<td width="37%" colspan="3">
							[#if groupRouteList??]
								[#list groupRouteList as groupRoute]
									${groupRoute.dayNum}.${groupRoute.routeName} <br>
									${groupRoute.routeDescribeForEn}<br>
								[/#list]
							[/#if]
						</td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-bordered dataTable no-footer" style="margin-top:30px;" width="100%">
				<thead >
					<tr>
						<th>Modify Time</th>
						<th>Modify Remark</th>
					</tr>
				</thead>
				<tbody>
				[#list orderRemark as remark]
					<tr>
						<td>
						 [#if remark.modifyDate??]
							${remark.modifyDate?string("yyyy-MM-dd")}
				         [/#if]
				        </td>
						<td>${remark.updateRemark}</td>
					</tr>
				[/#list]
				</tbody>
			</table>
			</div>
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
