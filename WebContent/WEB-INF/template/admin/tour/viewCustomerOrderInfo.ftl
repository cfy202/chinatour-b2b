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
			<h2>Tour List</h2>
			<a class="btn pull-right " href="[@spring.url '/admin/tour/exportCustomerExcel.jhtml?tourId=${tourId}'/]" title="Export Bill"><i class="fa fa-share-square-o" ></i></a>
			<a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
			<ol class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li><a href="#">Tour</a></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="content">
							<table class="table table-bordered dataTable no-footer">
							<input name="tourId" id="tourId" type="hidden" value="${tourId}"/>
								<thead>
									<tr> 	 	 	 	 	 	 	 	 	 	
										<th>Pax</th>
										<th>No.</th>
										<th>Last/First &nbsp;Middle Name</th>
										<th>Gender</th>
										<th>Date of Birth</th>
										<!-- <th>Phone</th> -->
										<th>Nationality</th>
										<!-- <th>residency</th> -->
										<th>Passport No.</th>
										<th>Expiry Date</th>
										<th>Language</th>
										<th>Room</th>
										<th>Room No.</th>
										<th>Ticket Type</th>
										<th>Voucher</th>
										<th>Departure City</th>
									</tr>
								</thead>
								<tbody>
								[#list customerList as customer]
									<tr>
										<td>${customer_index+1}</td>
										<td>${customer.customerCode}</td>
										<td>${customer.lastName}/${customer.firstName}  ${customer.middleName}</td>
										<td>[#if customer.sex == 1]F[#elseif customer.sex == 2]M [#else][/#if]</td>
										<td>[#if (customer.dateOfBirth)??]${customer.dateOfBirth?string('yyyy-MM-dd')}[/#if]</td>
										<!-- <td>${customer.mobile}</td> -->
										<td>${customer.nationalityOfPassport}</td>
										<!-- <td>${customer.residency}</td> -->
										<td>${customer.passportNo}</td>
										<td>[#if (customer.expireDateOfPassport)??]${customer.expireDateOfPassport?string('yyyy-MM-dd')}[/#if]</td>
										<td>${customer.language.language}</td>
										<td>${customer.guestRoomType}</td>
										<td>${customer.getRoomNumber()+"/"+customer.getOrderNo()}</td>
										<td>${customer.ticketType}</td>
										<td>${customer.voucherStr}</td>
										<td>${customer.payHistoryInfo}</td>
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
						
						<div style="margin-top:50px;display:none">
							<table class="table table-bordered dataTable no-footer" id="datatable2">
								<thead>
									<tr>
										<th style="display:none"></th>
										<th></th>
										<th>No.</th>
										<th>Order</th>
										<th>Name</th>
										<th>Price</th>
										<th>Num</th>
									</tr>
								</thead>
								<tbody>
									[#list receivableInfoOfOrders as receivableInfoOfOrder]
										[#list receivableInfoOfOrder.orderReceiveItemList as orderReceiveItem]
											<tr>
												<td style="display:none">${receivableInfoOfOrder.tourInfoForOrder.tourInfo}</td>
												<td><img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" onclick="showRemark(this)"/></td>
												<td>${orderReceiveItem_index+1}</td>
												<td>${receivableInfoOfOrder.orderNo}</td>
												<td>${orderReceiveItem.remark}</td>
												<td>${orderReceiveItem.itemFee}</td>
												<td>${orderReceiveItem.itemFeeNum}</td>
											</tr>
										[/#list]
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

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $("#datatable2_filter").hide(); 
        $("#datatable2_length").hide();
        $(".pull-left").hide();
        $("#datatable2_paginate").hide();
    	 $('#confirm-delete').on('show.bs.modal', function (e) {
			$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
		});
    });
             function fnFormatDetails ( oTable, nTr,tdValue )
        {	
            var aData = oTable.fnGetData(nTr);
            var specificItems = aData.specificItems;
           
            if(specificItems==null){
            	specificItems = "";
            }
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-bottom: 1px solid #dadada;width:10%;">Remark:</td><td style="border-bottom: 1px solid #dadada;">'+tdValue+'</td></tr>';
            sOut += '</table>';
            return sOut;
        };
        var oTable = $('#datatable2').dataTable({});
    
    $('#pcont').delegate('tbody td img','click', function () {
            var nTr = $(this).parents('tr')[0];
            
            if ( oTable.fnIsOpen(nTr) )
            {
                /* This row is already open - close it */
                this.src = "[@spring.url '/resources/images/plus.png'/]";
                oTable.fnClose( nTr );
            }
            else
            {
                /* Open this row */
                this.src = "[@spring.url '/resources/images/minus.png'/]";
                oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr,$(this).parent().prev().text()), 'details' );
            }
        });
        function showRemark(x){
        	//alert($(x).parent().prev().text());
        }
</script>
</body>
</html>
