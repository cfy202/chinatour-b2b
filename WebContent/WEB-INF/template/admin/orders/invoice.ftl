[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"]/]
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
			<h2>
				New
			</h2>
			<ol class="breadcrumb">
				<li>
					<a style="cursor:pointer;" href="../../">
						Home
					</a>
				</li>
				<li>
					<a style="cursor:pointer;" href="">
						Booking
					</a>
				</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row wizard-row">
				<div class="col-md-12 fuelux">
					<div class="block-wizard">
						<div id="wizard1" class="wizard wizard-ux">
							<ul class="steps">
								<li data-target="#step1" class="active">
									Booking Info
									<span class="chevron">
									</span>
								</li>
								<li data-target="#step2">
									Passenger Info
									<span class="chevron">
									</span>
								</li>
							</ul>
							<div class="actions">
							</div>
						</div>
						<div class="step-content">
							<form class="form-horizontal group-border-dashed" id="form" action="save.jhtml" method="POST" 
								data-parsley-validate novalidate>
								<div class="step-pane active" id="step1">
									<table style="padding:10px;border: 0px none" width="100%">
										<tbody>
											<tr>
												<td width="13%">
													<span>
														Order No.:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1" disabled="true" value="NEW" type="text">
												</td>
												<td width="13%">
													<span>
														Tel:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1" name="customer.tel" type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														BookingDate:
													</span>
												</td>
												<td width="37%">
													<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
														<input name="ordersTotal.bookingDate" class="form-control input-group1" readonly="readonly" type="text" size="16">
														<span class="input-group-addon btn btn-primary">
															<span class="glyphicon glyphicon-th"></span>
														</span>
													</div>
												</td>
												<td>
													<span>
														Email:
													</span>
												</td>
												<td>
													<input class="form-control input-group1" name="ordersTotal.email" type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														W/R:
													</span>
												</td>
												<td width="37%">
													<select class="input-group1 select2" name="ordersTotal.wr" onchange="retailOrWholeSale(this.value);" type="text">
														<option value="0">Retail/WholeSale</option>
														<option value="retail">Retail</option>
														<option value="wholeSale">WholeSale</option>
													</select>
												</td>
												<td width="13%">
													<span>
														Address:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1 " name="ordersTotal.address" type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Company:
													</span>
												</td>
												<td width="37%"> 
													<select id="companySelect" class="select2" disabled="true" onchange="setCompanyId(this);" type="text">
														<option value="0">Select Peer</option>
													[#list venderList as vender]
														<option value="${vender.venderId}">${vender.name}</option>
													[/#list]
													</select>
													<input name="ordersTotal.company" type="hidden" >
												</td>
												<td width="13%">
													<span>
														PostCode:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1" name="customer.zip" type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														ContactName:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1" name="ordersTotal.contactName" type="text">
												</td>
												<td width="13%">
													<span>
														Country:
													</span>
												</td>
												<td width="37%">
													<select class="input-group1 select2" name="customer.countryId" onchange="generalStateSelect(this);" type="text">
														<option value="0">Select Country</option>
													[#list countryList as country]
														<option value="${country.id}">${country.countryName}</option>
													[/#list]	
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														DepartDate:
													</span>
												</td>
												<td width="37%">
													<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
														<input name="ordersTotal.departDate" class="form-control input-group1" readonly="readonly" type="text" size="16">
														<span class="input-group-addon btn btn-primary">
															<span class="glyphicon glyphicon-th"></span>
														</span>
													</div>
												</td>
												<td width="13%">
													<span>
														State:
													</span>
												</td>
												<td width="37%">
													<select id="stateSelect" class="input-group1 select2" name="customer.stateId" type="text">
														<option value="0">Select State</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Persons:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1" name="ordersTotal.totalPeople" type="text">
												</td>
												<td width="13%">
													<span>
														City:
													</span>
												</td>
												<td width="37%">
													<select class="input-group1 select2" name="customer.cityId" type="text">
														<option value="0">Select City</option>
													[#list cityList as city]
														<option value="${city.id}">${city.cityName}</option>
													[/#list]	
													</select>
												</td>
											</tr>
									     </tbody>
									</table>
									<div class="form-group" align="right">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="button" class="btn btn-default" onclick="cancel();">
												Cancel
											</button>
											<button data-wizard="#wizard1" class="btn btn-primary wizard-next">
												Next Step
												<i class="fa fa-caret-right">
												</i>
											</button>
										</div>
									</div>
								</div>
								<div class="step-pane" id="step2">
									<div class="form-group no-padding">
										<div class="col-sm-7">
											<h3 class="hthin">
												Customer Info
											</h3>
										</div>
									</div>
									
									<div id="addButton" class="new" style="text-align:right"><button class="btn btn-success" type="button" onclick="addCustomer();">&nbsp;&nbsp;And New Customer &nbsp;&nbsp;</button></div>
									
									<div class="form-group" align="right">
										<div class="col-sm-12">
											<button data-wizard="#wizard1" class="btn btn-default wizard-previous">
												<i class="fa fa-caret-left">
												</i>
												Previous
											</button>
											<button type="button" onclick="generateInvoice();" data-wizard="#wizard1" class="btn btn-success">
												Generate Invoice
											</button>
											<button type="button" onclick="addInboundTours();" data-wizard="#wizard1" class="btn btn-success">
												Add Inbound Tours
											</button>
											<button type="button" onclick="addOutboundTours();" data-wizard="#wizard1" class="btn btn-success">
												Add Outbound Tours
											</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="customerInputTemplate" class="customer_tab" style="display:none">
	<div class="customerInfo">
		<div class="customerBar">
			<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">
				<i class="fa fa-bars"></i>
				<span class="customerNumber"></span>
				<div class="pull-right">
	               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
	           </div>
	        </h4>
		</div>
		<div style="#ccc;margin:0 0 8px 0;"></div>
		<div>
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td width="13%">
							<span>
								LastName:
							</span>
						</td>
						<td width="37%">
							<input class="form-control input-group1" name="customerArray[customerIndex].lastName" type="text">
						</td>
						<td width="13%">
							<span>
								FirstName:
							</span>
						</td>
						<td width="37%">
							<input class="form-control input-group1" name="customerArray[customerIndex].firstName" type="text">
						</td>
					</tr>
					<tr>
						<td>
							<span>
								MiddleName:
							</span>
						</td>
						<td>
							<input class="form-control input-group1" name="customerArray[customerIndex].middleName" type="text">
						</td>
						<td>
							<span>
								Date Of Birth:
							</span>
						</td>
						<td>
							<div>
								<div class="input-group input-group1 date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
									<input type="text" readonly="readonly" class="form-control" name="customerArray[customerIndex].dateOfBirth">
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
							<input class="form-control input-group1" name="customerArray[customerIndex].nationalityOfPassport" type="text">
						</td>
						<td>
							<span>
								Passport No.:
							</span>
						</td>
						<td>
							<input class="form-control input-group1" name="customerArray[customerIndex].passportNo" type="text">
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
									<input type="text" readonly="readonly" class="form-control" name="customerArray[customerIndex].expireDateOfPassport">
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
										<input class="icheck" type="radio" name="customerArray[customerIndex].sex" value="1" checked="" style="position: absolute; opacity: 0;">
											<ins class="iCheck-helper"
												style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
											</ins>
									</div>
									Female
								</label>
								<label class="radio-inline">
									<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
										<input class="icheck" type="radio" name="customerArray[customerIndex].sex" value="2" checked="" style="position: absolute; opacity: 0;">
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
							<select name="customerArray[customerIndex].memoOfCustomer" class="select2" style="width:140px;">
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
							<select name="customerArray[customerIndex].languageId" class="select2" style="width:140px">
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
							<select name="customerArray[customerIndex].guestRoomType" class="select2" style="width:140px">
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
							<input class="form-control input-group1" name="customerArray[customerIndex].mobile" type="text">
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Email:
							</span>
						</td>
						<td>
							<input class="form-control input-group1" name="customerArray[customerIndex].email" type="text">
						</td>
						<td>
							<span>
								Address:
							</span>
						</td>
						<td>
							<input class="form-control input-group1" name="customerArray[customerIndex].streetAddress" type="text">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
	$("#credit_slider").slider().on("slide", function(e) {
		$("#credits").html("$" + e.value);
	});
	$("#rate_slider").slider().on("slide", function(e) {
		$("#rate").html(e.value + "%");
	});
</script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	App.wizard();
    	$("form select.select2").select2({
			width: '60%'
		});
		
		$("form div.datetime").datetimepicker({autoclose: true});
		
		$("#customerInputTemplate div.customerBar").click(function(){
			$(this).next().next().slideToggle("slow");
			var _slide = $(this).find("i:last");
			
			if(_slide.attr('class')=="fa fa-angle-up"){
				_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
			}
		});
		
		addCustomer();
    });
    
    /* 根据retail或wholesale选择是否选同行  */
    function retailOrWholeSale(value){
    	var $companySelect = $("#companySelect");
    	if(value != 'wholeSale'){
    		$companySelect.removeAttr("name");
    		$companySelect.attr("disabled",true);
    		$companySelect.val("0");
    		$companySelect.select2({
    			width: '60%'
    		});
    	}else{
    		$companySelect.attr("name","ordersTotal.companyId");
    		$companySelect.removeAttr("disabled");
    	}
    }
    
    /* 取消的动作 */
    function cancel(){
    	window.location.href="list.jhtml";
    }
    
    /* 给同行ID赋值  */
    function setCompanyId(companySelect){
		$(companySelect).next().val($(companySelect).find("option:selected").text());
    }
    
	/* 根据国家动态加载州  */
    function generalStateSelect(countrySelect) {
        var $stateSelect = $("#stateSelect");
        var countryId = $(countrySelect).val();

        $stateSelect.children("option").remove();
        $stateSelect.append("<option value='0'>Select State</option>");
        $stateSelect.val("0");
        $stateSelect.select2({
        	width: '60%'
        });
        if (countryId != '0') {
            $.post("states.jhtml", {
                "countryId": countryId
            },
            function(result) {
                $.each(result,
                function(key, value) {
                    $stateSelect.append("<option value='" + key + "'>" + value + "</option>");
                });
            });
        }
    }
    
    /* 添加客人  */
    function addCustomer() {
    	var customerIndex = $(".customer_tab").size() - 1;
    	var $addButton = $("#addButton");
		initAddHtml(generalCustomerInputHtml(customerIndex).insertBefore($addButton));
    }
    
    /* 初始化添加的元素  */
    function initAddHtml($addHtml){
        $addHtml.find("div.datetime").datetimepicker({autoclose: true});
    	$addHtml.find('.icheck').iCheck({
          checkboxClass: 'icheckbox_square-blue checkbox',
          radioClass: 'iradio_square-blue'
        });
        $addHtml.find("select.select2").select2({
        	width: '60%'
        }); 
        return $addHtml;
    }
    
	/* 根据模板生成customer输入的html */
    function generalCustomerInputHtml(customerIndex) {
		$customerInput = $("#customerInputTemplate").clone(true).removeAttr("id").removeAttr("style");
		$customerInput.find(".customerNumber").text("No."+(customerIndex+1));
		$customerInput.find("input,select").each(function(){
			var name = $(this).attr("name");
			if(name != undefined){
				$(this).attr("name",name.replace("customerIndex",customerIndex));
			}
		});
		return $customerInput;
    }
    
    /* 生成Invoice */
    function generateInvoice(){
    	var $form = $("#form");
    	$form.attr("action","generateInvoice.jhtml");
    	$form.submit();
    }
    
    /* 增加团订单  */
    function addOutboundTours(){
    	var $form = $("#form");
    	$form.attr("action","addOutboundTours.jhtml");
    	$form.submit();
    }
    
    /* 增加非团订单  */
    function addInboundTours(){
    	var $form = $("#form");
    	$form.attr("action","addInboundTours.jhtml");
    	$form.submit();
    }
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>
