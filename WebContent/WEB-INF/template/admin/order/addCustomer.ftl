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
            <h2>New</h2>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="#">Booking</a></li>
                <li><a style="cursor:pointer;" href="list">Tour Booking</a></li>
                <li><a style="cursor:pointer;" href="customers?id=${orderId}">Passenger Info</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="addCustomer.jhtml" method="post" parsley-validate novalidate>            
					<input type="hidden" name="orderId" value="${orderId}">
					<div name="slide_customerIndex">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
							<i class="fa fa-bars"></i>
							<span >Passenger Info</span>
				        </h4>
					</div>
					<table style="padding:10px;" width="100%">
						<tbody>
							<tr>
								<td width="13%">
									<span>
										LastName:
									</span>
								</td>
								<td width="37%">
									<input name="customer.lastName" class="form-control input-group1" type="text">
								</td>
								<td width="13%">
									<span>
										FirstName:
									</span>
								</td>
								<td width="37%">
									<input name="customer.firstName" class="form-control input-group1" type="text">
								</td>
							</tr>
							<tr>
								<td>
									<span>
										MiddleName:
									</span>
								</td>
								<td>
									<input name="customer.middleName" class="form-control input-group1" type="text">
								</td>
								<td>
									<span>
										Date of Birth:
									</span>
								</td>
								<td>
									<div>
										<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
											<input type="text" readonly="readonly" class="form-control" name="customer.dateOfBirth">
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th">
												</span>
											</span>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Nationality:
									</span>
								</td>
								<td>
									<input name="customer.nationalityOfPassport" class="form-control input-group1" type="text">
								</td>
								<td>
									<span>
										Passport No.:
									</span>
								</td>
								<td>
									<input name="customer.passportNo" class="form-control input-group1" type="text">
									<div></div>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Expiry Date:
									</span>
								</td>
								<td>
									<div>
										<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
											<input type="text" readonly="readonly" class="form-control" name="customer.expireDateOfPassport">
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th">
												</span>
											</span>
										</div>
									</div>
								</td>
								<td>
									<span>
										Gender:
									</span>
								</td>
								<td>
									<div>
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="customer.sex" value="1" checked="" style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Female
										</label>
										<label class="radio-inline">
											<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
												<input class="icheck" type="radio" name="customer.sex" value="2" checked="" style="position: absolute; opacity: 0;">
													<ins class="iCheck-helper"
														style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
													</ins>
											</div>
											Male
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Remark:
									</span>
								</td>
								<td>
									<select name="customer.memoOfCustomer" class="select2" style="width:140px;">
										<option value="0">
											--Select--
										</option>
										[#list constant.CUSTOMER_MEMOS as memoOfCustomer]
										<option value="${memoOfCustomer}">
											${memoOfCustomer}
										</option>
										[/#list]
									</select>
								</td>
								<td>
									<span>
										Language:
									</span>
								</td>
								<td>
									<select name="customer.languageId" class="select2" style="width:140px">
										<option value="0">
											--Select--
										</option>
										[#list languageList as language]
										<option value="${language.languageId}">
											${language.language}
										</option>
										[/#list]
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Room:
									</span>
								</td>
								<td>
									<select name="guestRoomType" class="select2" style="width:140px">
										<option value="0">
											--Select--
										</option>
										[#list constant.GUEST_ROOM_TYPES as room]
										<option value="${room}">
											${room}
										</option>
										[/#list]
									</select>
								</td>
								<td width="13%">
									<span>
										Phone:
									</span>
								</td>
								<td width="37%">
									<input class="form-control input-group1" name="customer.mobile" type="text">
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Email:
									</span>
								</td>
								<td>
									<input class="form-control input-group1" name="customer.email" type="text">
								</td>
								<td>
									<span>
										Address:
									</span>
								</td>
								<td>
									<input class="form-control input-group1" name="customer.streetAddress" type="text">
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<b>
							<br/>
							Flight Info
						</b>
					</div>
					<table>
						<tbody>
							<tr>
								<td colspan="4">
									<br>
										<div>
											Arrival Flight:
										</div>
								</td>
							</tr>
							<tr>
								<td>
									<span>
										Airline :
									</span>
								</td>
								<td>
									<input class="form-control input-group1" name="customerFlightList[0].flightCode" type="text">
								</td>
								<td>
									<span>
										Flight No.:
									</span>
								</td>
								<td>
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
									<div>
										<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
											<input type="text" class="form-control" readOnly="readOnly" name="customerFlightList[0].arriveDate">
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th">
												</span>
											</span>
										</div>
									</div>			
								</td>
								<td>
									<span>
										Arrival Time:
									</span>
								</td>
								<td>
									<div>
										<input type="text"class="form-control input-group1" name="customerFlightList[0].arriveTime">
									</div>
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
											<input class="icheck" type="radio" name="customerFlightList[0].ifPickUp" value="1" checked=""
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
								<td style="display:none">
									<span>
										Flight Type:
									</span>
								</td>
								<td style="display:none">
									<!-- 出入境 ，入境 -->
									<input class="hasDatepicker" name="customerFlightList[0].outOrEnter" value="1" type="hidden">
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<br>
										<div>
											Departure Flight:
										</div>
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
									<div>
										<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
											<input type="text" class="form-control" readOnly="readOnly" name="customerFlightList[1].arriveDate">
											<span class="input-group-addon btn btn-primary">
												<span class="glyphicon glyphicon-th">
												</span>
											</span>
										</div>
									</div>	
								</td>
								<td>
									<span>
										Departure Time:
									</span>
								</td>
								<td>
									<div>
										<input type="text" class="form-control input-group1" name="customerFlightList[1].arriveTime">
									</div>			
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
										Deviation:
									</span>
								</td>
								<td>
									<input type="text" class="form-control input-group1" name="customerFlightList[1].remark">
								</td>
							</tr>
							<tr>
								<td style="display:none">
								</td>
								<td style="display:none">
								</td>
								<td style="display:none">
								</td>
								<td style="display:none">
									<!-- 出入境 ，入境 -->
									<input class="hasDatepicker" name="customerFlightList[1].outOrEnter" value="2" type="hidden">
								</td>
							</tr>
						</tbody>
					</table>
	              <div class="form-group">
	                <div class="col-sm-offset-2 col-sm-10" align="right">
	                  <button type="button" onclick="cancel();" class="btn btn-default">Cancel</button>
	                  <button type="reset" class="btn btn-default">Reset</button>
	                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
	                  <button type="button" onclick="saveAndNew();" class="btn btn-default">Save and New</button>
	                </div>
	              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("form select.select2").select2({
        	width: '60%'
        });
        $("div.datetime").datetimepicker({autoclose: true});
    	$('.icheck').iCheck({
          checkboxClass: 'icheckbox_square-blue checkbox',
          radioClass: 'iradio_square-blue'
        });
    });
    
    function cancel(){
		window.location.href = "customers.jhtml?id=${orderId}";
	} 
	
	function saveAndNew(){
		var formData = $("#formId").serialize();
		$.ajax({
			   type:"POST",
		       url: "addCustomer.jhtml",
		       data:formData,
		       dataType: "text",
			   success: function (data) {
			       location.href="addCustomer.jhtml?orderId=${orderId}";
			   }
		});
	}
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
