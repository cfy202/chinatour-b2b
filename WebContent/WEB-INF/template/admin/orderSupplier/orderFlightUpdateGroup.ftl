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
		<h2>Billing(GROUP)</h2>
		<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Tour</a></li>
		</ol>
	</div>
	<div class="cl-mcont">
	<div class="row">
		<div class="col-md-12">
			<div class="block-flat">
				<form action="updateGroup.jhtml" name="form1" id="form1" method="post"  onsubmit="return submitCheck();">
					<div class="header">
						<h3>${tour.tourCode}Flight Bill Audit</h3>
						<a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a>
					</div>
					<div class="form-group">
						Airline：<input type="text" class="inputWidth80" name="supplierName" value="${supPriceInfoRel.supplierName}" style="width:150px;">
						Operator Fee：<input type="text" class="inputWidth80" name="supplierCost" value="${supPriceInfoRel.supplierCost}" id="hotelCost">
						Amount：<input type="text" class="inputWidth80" name="supplierPrice" value="${supPriceInfoRel.supplierPrice}" id="tourSumFee">
						Booking No.：<input type="text" class="inputWidth80" name="numbering" value="${supPriceInfoRel.numbering}" id="oddNuberId">
						Remark(Leg)：<input type="text" class="inputWidth80" name="remark" value="${supPriceInfoRel.remark}" >
						<input name="tourCode" type="hidden" id="tourCode" value="${tour.tourCode}"/>
						<input name="tourId"  type="hidden" id="tourId"value="${tour.tourId}" />
						<input type="hidden"  name="supPriceInfoRelId" value="${supPriceInfoRel.supPriceInfoRelId}"/>
			            <input type="hidden"  name="supplierPriceId"  value="${supplierPrice.supplierPriceId}"/>
					</div>
					<div class="content">
						<table class="table table-bordered dataTable no-footer">
							<thead>
								<tr>
									<th>﻿Booking No.</th>
									<th class="text-center">No.</th>
									<th class="text-center">LastName</th>
									<th class="text-center">FirstName</th>
									<!-- <th class="text-center">MiddleName</th> -->
									<th class="text-center">Agent</th>
									<th width="10%" class="text-center">Amount</th>
									<th class="text-center">Count <input id="check-all" checked="checked" type="checkbox" name="checkall" /></th>
								</tr>
							</thead>
							<tbody class="">
							[#list flightList as flight]
								<tr id="trCss_${flight.state}_${flight_index}" class="tr_[#if flight.isCalculate==0]1[/#if]">
									<td style="width:5%;">${flight.orderNo}</td>
									<td class="text-center">${flight.customerNo}</td>
									<td class="text-center">${flight.lastName}</td>
									<td class="text-center">${flight.firstName}</td>
									<!-- <td class="text-center">${customer.middleName}</td> -->
									<td class="text-center">${flight.agent}</td>
									<td class="text-right"><input type="text" class="form-control" name="flightPriceInfoList[${flight_index}].flyReceivable" id="save_${flight_index}" value="${(flight.flyReceivable)!0}"/></td>
									<td class="text-center">
										<div class="item">
											<div>
												<input type="checkbox" [#if flight.isCalculate==1]checked="checked"[/#if] class="icheck" id="planning_update_${flight_index}" name="${flight_index}" />
											</div>
										</div>
										<input type="hidden" value="${(flight.isCalculate)!1}" name="flightPriceInfoList[${flight_index}].isCalculate" id="planning_IsCalculate_${flight_index}">
										<input type="hidden" value="${flight.userId}" name="flightPriceInfoList[${flight_index}].userId" />
										<input type="hidden" value="${flight.customerId}" name="flightPriceInfoList[${flight_index}].customerId" />
										<input type="hidden" value="0" name="flightPriceInfoList[${flight_index}].isDel" />
										<input type="hidden" value="${flight.orderNo}" name="flightPriceInfoList[${flight_index}].orderNo" />
										<input type="hidden" value="${flight.orderId}" name="flightPriceInfoList[${flight_index}].orderId" />
										<input type="hidden" value="${flight.flightPriceInfoId}" name="flightPriceInfoList[${flight_index}].flightPriceInfoId" />
									</td>
								</tr>
							[/#list]
							</tbody>
						</table>
					</div>
					<div class="spacer2 text-center">
						[#if (supplierPrice.allCheck==0&&supplierPrice.accCheck==0)||(supplierPrice.allCheck==2&&supplierPrice.accCheck==1)]
							<button type="submit" class="btn btn-primary btn-flat ">Update</button>
						[/#if]
						<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default">Cancel</button>
					</div>
				</from>
			</div>
			
		</div>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/basic/sumSupplierPrice.js'/]"></script>
</body>
</html>
