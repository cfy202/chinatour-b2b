[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <style type="text/css" media="screen">
		td,th{
			border:0px;
			height:30px;
			}
		tr{
			border:0px;
		}
		td{
			font-size:14px;
		}
		th{
			font-size:16px;
			font-weight:bold;
			background:#ccc;
		}	
		table{
			border:1px solid #ccc;
			border-radius: 6px;
		}
	</style>
    <title>${message("admin.main.title")}</title>
</head>
<body>
<div>
<div>
	<table style="border:0px;margin-left:88%;">
		<tr>
			<td>
				<button style="height:32px;" id="printBtn" onclick="printPage()">Print Page</button>
			</td>
		<tr>
	</table>
</div>
<div id="printBox" style="width:100%;" >
	[#if flag==1||flag=3]
	<div id="pickup">
		<h2 style="text-align:center; margin:0 auto;width:340px;margin-bottom:12px;"> FLIGHT INFORMATION(entry)</h2>
		 <table style="text-align:center; margin:0 auto;width:1000px;" cellspacing="0" cellpadding="0" border="1">
					<thead>
						<tr>
							<th width="10%">Arrival Date</th>
							<th width="8%">FLT #</th>
							<th width="8%">ETA</th>
							<th width="8%">#PAX</th>
							<th width="8%">Remark</th>
							<th width="10%">Last Name</th>
							<th width="10%">First Name</th>
							<th width="10%">Middle Name</th>
						</tr>
					</thead>
					<tbody>
						[#list flightWithCustomersList as flightWithCustomers]
								[#list flightWithCustomers.customerList as customer]
									[#if flightWithCustomers.customerFlight.outOrEnter==1]
										<tr>
											<td>
												[#if (customer_index==0) && (flightWithCustomers.customerFlight.arriveDate)??]
													${flightWithCustomers.customerFlight.arriveDate?string('yyyy-MM-dd')}
												[/#if]
											</td>
											<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.flightCode}  ${flightWithCustomers.customerFlight.flightNumber}[/#if]</td>
											<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.arriveTime}[/#if]</td>
											<td>[#if (customer_index==0)]${flightWithCustomers.customerSize}[/#if]</td>
											<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.remark}[/#if]</td>
											<td>${customer.lastName}</td>
											<td>${customer.firstName}</td>
											<td>${customer.middleName}</td>
										</tr>
								   [/#if]
								[/#list]
						[/#list]
					</tbody>
				</table>
			</div>
			[/#if]
			[#if flag=2||flag=3]
			<div id="seeOff">
				<h2 style="text-align:center; margin:0 auto;width:320px;margin-bottom:12px;">FLIGHT INFORMATION(exit)</h2>
				 <table style="text-align:center; margin:0 auto;width:1000px;" cellspacing="0" cellpadding="0" border="1">
							<thead>
								<tr>
									<th width="10%">Departrue Date</th>
									<th width="8%">FLT #</th>
									<th width="8%">ETA</th>
									<th width="8%">#PAX</th>
									<th width="8%">Remark</th>
									<th width="10%">Last Name</th>
									<th width="10%">First Name</th>
									<th width="10%">Middle Name</th>
								</tr>
							</thead>
							<tbody>
								[#list flightWithCustomersList as flightWithCustomers]
								[#list flightWithCustomers.customerList as customer]
								[#if flightWithCustomers.customerFlight.outOrEnter==2]
								<tr>
									<td>
										[#if (customer_index==0) && (flightWithCustomers.customerFlight.arriveDate)??]
											${flightWithCustomers.customerFlight.arriveDate?string('yyyy-MM-dd')}
										[/#if]
									</td>
									<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.flightCode}  ${flightWithCustomers.customerFlight.flightNumber}[/#if]</td>
									<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.arriveTime}[/#if]</td>
									<td>[#if (customer_index==0)]${flightWithCustomers.customerSize}[/#if]</td>
									<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.remark}[/#if]</td>
									<td>${customer.lastName}</td>
									<td>${customer.firstName}</td>
									<td>${customer.middleName}</td>
								</tr>
								[/#if]
								[/#list]
							[/#list]
							</tbody>
						</table>
					</div>
				[/#if]
	</div>
</div>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
 	 //打印     
	function printPage(){	
		$("#printBox").printArea();	
	}
	
</script>
</body>
</html>
