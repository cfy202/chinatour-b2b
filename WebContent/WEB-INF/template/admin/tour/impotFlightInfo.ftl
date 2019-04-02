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
		.kalendae .k-days span.closed {
			background:red;
		}
	</style>
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
            <h2>Passenger List</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li class="active"><a href="#">Tour</a></li>
            </ol>
        </div>
    <div class="cl-mcont">    
		<div class="row">
	      <div class="col-md-12">
	      
	        <div class="block-flat">
	          <div class="header">							
	            <h3>Flight Information</h3>
	          </div>
	          <div class="content">
	              <form class="form-horizontal group-border-dashed" id="formId" action="saveFlightInfo.jhtml" method="post">
	              	<input type="hidden" name="customerOrderRelIds" value="${order.customerOrderRelId}">
	              	<input type="hidden" name="tourId" value="${order.tourId}">
	              	<input type="hidden" name="tourCode" value="${order.tourCode}">
	              <table style="border: 0px none" id="flightInfo">
						<tbody>
							<tr>
								<td style="width:10%">
									Ticket Type
								</td>
								<td style="width:25%">
									<select name="ticketType" class="select2" style="width:140px">
										[#list constant.TICKET_TYPES as type]
										[#if type != '']
										<option value="${type}">
											${type}
										</option>
										[#else]
										<option value="">
											NONE
										</option>
										[/#if]
										[/#list]
									</select>
								</td>
								<td colspan="2">
								</td>
							</tr>
							<tr>
								<td colspan="4">
										<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Arrival Flight</div>
								</td>
							</tr>
							<tr>
								<td width="13%">
									<span>
										Airline:
									</span>
								</td>
								<td width="37%">
									<input class="form-control input-group1" name="customerFlightList[0].flightCode" type="text">
								</td>
								<td width="13%">
									<span>
										Flight No.:
									</span>
								</td>
								<td width="37%">
									<input class="form-control input-group1" name="customerFlightList[0].flightNumber" type="text">
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Arrival Date:
									</span>
								</td>
								<td>
									<input id="arriveDate" type="text" name="customerFlightList[0].arriveDate" value="" class="form-control input-group1 JDATE" placeholder="yyyy-mm-dd" />
								</td>
								<td>
									<span>
										Arrival Time:
									</span>
								</td>
								<td>
									<input class="form-control input-group1" size="16" type="text" name="customerFlightList[0].arriveTime" /><font size="2px" color="red"></font>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Pick-up:
									</span>
								</td>
								<td>
									<label class="radio-inline">
										<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
											<input class="icheck" type="radio" name="customerFlightList[0].ifPickUp" value="1"
												style="position: absolute; opacity: 0;">
												<ins class="iCheck-helper"
													style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
												</ins>
										</div>
										Yes &nbsp;&nbsp;
									</label>
									<label class="radio-inline">
										<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
											<input class="icheck" type="radio" name="customerFlightList[0].ifPickUp" value="2" checked=""
												style="position: absolute; opacity: 0;">
												<ins class="iCheck-helper"
													style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
												</ins>
										</div>
										No
									</label>
								</td>
								<td>
									<span>
										Remark:
									</span>
								</td>
								<td>
									<!-- 出入境 ，入境 -->
									<input class="form-control input-group1" size="16" type="hidden" name="customerFlightList[0].outOrEnter" value="1" />
									<input class="form-control input-group1" size="16" type="text" name="customerFlightList[0].remark" />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div style="background:#52AEFF;height:30px;line-height:30px;padding:0 5px;color:#ffffff;margin:15px 0;font-weight:bold;">Departure Flight</div>
								</td>
							</tr>
							<tr>
								<td colspan="">
									<span>
										Airline:
									</span>
								</td>
								<td>
									<input class="form-control input-group1" name="customerFlightList[1].flightCode" type="text">
								</td>
								<td>
									<span>
										Flight No.:
									</span>
								</td>
								<td>
									<input class="form-control input-group1" name="customerFlightList[1].flightNumber" type="text">
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Departure Date:
									</span>
								</td>
								<td>
									<input id="departureDate" type="text" name="customerFlightList[1].arriveDate" value="" class="form-control input-group1 JDATE"  placeholder="yyyy-mm-dd" />
								</td>
								<td>
									<span>
										Departure Time:
									</span>
								</td>
								<td>
									<input class="form-control input-group1" size="16"  type="text" name="customerFlightList[1].arriveTime" /><font size="2px" color="red"></font>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Drop-off:
									</span>
								</td>
								<td>
									<label class="radio-inline">
										<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
											<input class="icheck" type="radio" name="customerFlightList[1].ifSendUp" value="1"
												style="position: absolute; opacity: 0;">
												<ins class="iCheck-helper"
													style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
												</ins>
										</div>
										Yes &nbsp;&nbsp;
									</label>
									<label class="radio-inline">
										<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
											<input class="icheck" type="radio" name="customerFlightList[1].ifSendUp" value="2" checked=""
												style="position: absolute; opacity: 0;">
												<ins class="iCheck-helper"
													style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
												</ins>
										</div>
										No
									</label>
								</td>
								<td>
									<span>
										Remark:
									</span>
								</td>
								<td>
									<!-- 出入境 ，入境 -->
									<input class="form-control input-group1" size="16" type="hidden" name="customerFlightList[1].outOrEnter" value="2" />
									<input class="form-control input-group1" size="16" type="text" name="customerFlightList[1].remark" />
								</td>
							</tr>
							
						</tbody>
					</table>
					<button  class="btn btn-primary" style="margin-left:75%;margin-top:30px;">Save</button>
	            </form>
	          </div>
	        </div>
	        
	      </div>
	    </div>
	</div>
</div>

[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/date/kalendae.standalone.js'/]" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("#arriveDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
    	$("#departureDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
    });
    
    
</script>
</body>
</html>
