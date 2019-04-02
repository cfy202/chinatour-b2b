[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"]/]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>Edit Booking</title>
    [#include "/admin/peerUser/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="w1">
	<div class="panel-group accordion accordion-semi" id="accordion3" style="margin-top:20px;">
		<div class="tab-container" style="margin-top:10px;">
			<ul class="">
				<li class="active"><a href="#passengerInfo" data-toggle="tab"><b>Passenger Info</b></a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active cont" id="passengerInfo" align="right">
					<table class="table no-border hover">
						<thead class="no-border">
							<tr>
								<th style="width:20%;"><strong>Last/First Middle Name</strong></th>
								<th style="width:11%;"><strong>Gender</strong></th>	
								<th style="width:11%;"><strong>Nationality</strong></th>
								<th style="width:11%;"><strong>Birthday</strong></th>
								<th style="width:11%;"><strong>PassportNo</strong></th>
								<th style="width:11%;"><strong>PassportExpirationDate</strong></th>
								<th style="width:11%;"><strong>RoomType</strong></th>
							</tr>
						</thead>
						<tbody id="customerList" class="no-border-y">
							[#list customerOrderRelList as customerOrderRel]
							<tr id="${customerOrderRel.id}">
								<td>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</td>
								<td>[#if customerOrderRel.customer.sex == 1]F[#else]M[/#if]</td>
								<td>${customerOrderRel.customer.nationalityOfPassport}</td>
								<td>[#if (customerOrderRel.customer.dateOfBirth)??]${customerOrderRel.customer.dateOfBirth?string("yyyy-MM-dd")}[/#if]</td>
								<td>${customerOrderRel.customer.passportNo}</td>
								<td>[#if (customerOrderRel.customer.expireDateOfPassport)??]${customerOrderRel.customer.expireDateOfPassport?string("yyyy-MM-dd")}[/#if]</td>
								<td>${customerOrderRel.guestRoomType}</td>
								<td><span class='color-danger'>[#if customerOrderRel.contactFlag == 1]Cancelled[/#if]</span></td>
							</tr>
							[/#list]
						</tbody>
					</table>	
				</div>
			</div>
		</div>		
	</div>
</div>
<div class="md-modal md-effect-1" id="customerAddForm">
    <div class="md-content" style="background-color:#fff">
      <div class="modal-header">
      	<span>Add Customer</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="customerForm">
      <div class="modal-body">
        <div class="text-center">
			<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td width="13%">
							<span>
								LastName:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.lastName" onblur="customerListen();" id="lastNameId" required type="text">
						</td>
						<td width="13%">
							<span>
								FirstName:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.firstName" onblur="customerListen();" id="firstNameId" required type="text">
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								MiddleName:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.middleName" required type="text">
						</td>
						<td>
							<span>
								Gender:
							</span>
						</td>
						<td>
							<label class="radio-inline" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" id="addCustomerGender" type="radio" name="customer.sex" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Female&nbsp;&nbsp;
							</label>
							<label class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.sex" value="2" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Male
							</label>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Date Of Birth:
							</span>
						</td>
						<td>
							<input class="form-control date" name="customer.dateOfBirth" placeholder="YYYY-MM-DD" required="" parsley-type="dateIso" type="text" size="14"/>
						</td>
						<td>
							<span>
								Nationality:
							</span>
						</td>
						<td>
							<input class="form-control" name="customer.nationalityOfPassport" type="text">
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Passport No.:
							</span>
						</td>
						<td>
							<input class="form-control" name="customer.passportNo" onblur="customerListen();" id="passportNoId" type="text">
						</td>
						<td>
							<span>
								Expiry Date:
							</span>
						</td>
						<td>
							<input class="form-control date" name="customer.expireDateOfPassport" type="text" size="14"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Language:
							</span>
						</td>
						<td>
							<select id="languageSelect" name="customer.languageId" class="select2" style="width:140px">
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
						<td>
							<span>
								Remark:
							</span>
						</td>
						<td>
							<select id="remarkSelect" name="customer.memoOfCustomer" class="select2" style="width:140px;">
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
					</tr>
					<tr>
						<td>
							<span>
								Room Type:
							</span>
						</td>
						<td>
							<select id="guestRoomTypeAddSelect" name="guestRoomType" class="select2 guestRoomType" onchange="getRoommate(this.value,$('#roomNumberAddSelect'));" style="width:140px">
								[#list constant.GUEST_ROOM_TYPES as room]
								<option value="${room}">
									${room}
								</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Choose Room:
							</span>
						</td>
						<td>
							<select id="roomNumberAddSelect" name="roomNumber" class="select2" style="width:140px">
								<option value="0">
									New Room
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Phone:
							</span>
						</td>
						<td width="37%">
							<input class="form-control" name="customer.mobile" type="text">
						</td>
						<td>
							<span>
								Email:
							</span>
						</td>
						<td>
							<input class="form-control" name="customer.email" type="text">
						</td>
					</tr>
					<tr>
						<td>
							Ticket Type:	
						</td>
						<td>
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
						<td>
							Address:
						</td>
						<td>
							<input class="form-control" name="customer.streetAddress" type="text">
						</td>
					</tr>
				</tbody>
			</table>
        </div>
      </div>
      <div class="modal-footer">
      	<span class='pull-left' id="modalId" style="color:red"></span>
		<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		<button type="reset" onclick="initCustomerForm();" class="btn btn-default">Reset</button>
		<button type="button" onclick="saveCustomer(this);" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
	  </div>
	</form>
    </div>
</div>
<div class="md-modal md-effect-1" id="customerEditForm">
    <div class="md-content" style="background-color:#fff">
      <div class="modal-header">
      	<span>Edit Passenger Info</span>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form>
      <div class="modal-body">
        <div class="text-center">
			<input id="idInput" name="id" type="hidden" />
			<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" id="ordersTotalId" />
			<table style="padding:10px;border: 0px none" width="100%">
				<tbody>
					<tr>
						<td width="13%">
							<span>
								LastName:
							</span>
						</td>
						<td width="37%"> <!--没有修改客人 权限 只有office有权限-->
							<input id="lastNameInput" class="form-control" name="customer.lastName" required type="text">
						</td>
						<td width="13%">
							<span>
								FirstName:
							</span>
						</td>
						<td width="37%">
							<input id="firstNameInput" class="form-control" name="customer.firstName" required type="text">
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								MiddleName:
							</span>
						</td>
						<td width="37%">
							<input id="middleNameInput" class="form-control" name="customer.middleName" required type="text">
						</td>
						<td>
							<span>
								Gender:
							</span>
						</td>
						<td>
							<label class="radio-inline" id="sexRadio1" style="padding-left:0px;">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.sex" value="1"
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Female&nbsp;&nbsp;
							</label>
							<label style="padding-left:0px;" id="sexRadio2" class="radio-inline">
								<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
									<input class="icheck" type="radio" name="customer.sex" value="2" 
										style="position: absolute; opacity: 0;">
										<ins class="iCheck-helper"
											style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
										</ins>
								</div>
								Male
							</label>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Date Of Birth:
							</span>
						</td>
						<td>
							<input id="dateOfBirthInput" class="form-control date" name="customer.dateOfBirth" 
							 placeholder="YYYY-MM-DD" required="" parsley-type="dateIso" type="text" size="14"/>
						</td>
						<td>
							<span>
								Nationality:
							</span>
						</td>
						<td>
							<input id="nationalityOfPassportInput" class="form-control" name="customer.nationalityOfPassport" type="text">
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Passport No.:
							</span>
						</td>
						<td>
							<input id="passportNoInput" class="form-control" name="customer.passportNo" type="text">
						</td>
						<td>
							<span>
								Expiry Date:
							</span>
						</td>
						<td>
							<input id="expireDateOfPassportInput" class="form-control date" name="customer.expireDateOfPassport" type="text" size="14"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								Language:
							</span>
						</td>
						<td>
							<select id="languageIdSelect" name="customer.languageId" class="select2" style="width:140px">
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
						<td>
							<span>
								Remark:
							</span>
						</td>
						<td>
							<select id="memoOfCustomerSelect" name="customer.memoOfCustomer" class="select2" style="width:140px;">
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
					</tr>
					<tr>
						<td>
							<span>
								Room Type:
							</span>
						</td>
						<td>
							<select id="guestRoomTypeSelect" name="guestRoomType" class="select2 guestRoomType" onchange="getEditRoommate(this.value);" style="width:140px">
								[#list constant.GUEST_ROOM_TYPES as room]
								<option value="${room}">
									${room}
								</option>
								[/#list]
							</select>
						</td>
						<td>
							<span>
								Choose Room:
							</span>
						</td>
						<td>
							<select id="roomNumberEditSelect" name="roomNumber" class="select2" style="width:140px">
								<option value="0">
									New Room
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width="13%">
							<span>
								Phone:
							</span>
						</td>
						<td width="37%">
							<input id="mobileInput" class="form-control" name="customer.mobile" type="text">
						</td>
						<td>
							<span>
								Email:
							</span>
						</td>
						<td>
							<input id="emailInput" class="form-control" name="customer.email" type="text">
						</td>
					</tr>
					<tr>
						<td>
							Ticket Type:	
						</td>
						<td>
							<select id="ticketTypeSelect" name="ticketType" class="select2" style="width:140px">
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
						<td>
							Address:
						</td>
						<td>
							<input id="streetAddressInput" class="form-control" name="customer.streetAddress" type="text">
						</td>
					</tr>
				</tbody>
			</table>
        </div>
      </div>
      <div class="modal-footer">
		<button type="reset" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		<button type="button" onclick="updateCustomer(this);" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Modify</button>
	  </div>
	  </form>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="confirm-delete-customer" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Client Info will be cancelled?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- Modal -->
<div class="modal fade" id="confirm-delete-order" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Booking will be cancelled?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript">
	$("#credit_slider").slider().on("slide", function(e) {
		$("#credits").html("$" + e.value);
	});
	$("#rate_slider").slider().on("slide", function(e) {
		$("#rate").html(e.value + "%");
	});
</script>
<script type="text/javascript">
    var twinBed = '${constant.GUEST_ROOM_TYPES[0]}';
    var kingBed = '${constant.GUEST_ROOM_TYPES[1]}';
    var single = '${constant.GUEST_ROOM_TYPES[2]}';
    var extraBed = '${constant.GUEST_ROOM_TYPES[3]}';
    var suite = '${constant.GUEST_ROOM_TYPES[4]}';
    var sharingExistingBed = '${constant.GUEST_ROOM_TYPES[5]}';
    var roomMatching = '${constant.GUEST_ROOM_TYPES[6]}';
    
    $(document).ready(function(){
    	$("#dateOfBirthInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	$("#dateOfBirth").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	$("#expireDateOfPassportInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	$("#expireDateOfPassport").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	
    	App.init();
    	
    	[@flash_message /]
    	
    	$("#form select.select2").select2({
			width: '60%'
		});
		
		$("#customerForm select.select2").select2({
			width: '100%'
		});
		
		$("form div.datetime").datetimepicker({autoclose: true});
		
		
		$('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
    });
    
    /* 新增客人时初始化房型和房号以及reset时reset所有的select */
    function initCustomerForm(){
    	$('#addCustomerGender').iCheck('check');
    	var $selects = $("#languageSelect,#remarkSelect");
    	$selects.val('0');
    	$selects.select2({width:'100%'});
    	var $roomSelect = $("#guestRoomTypeAddSelect");
    	$roomSelect.val($roomSelect.find("option").eq(0).val());
    	$roomSelect.select2({width:'100%'});
    	getRoommate($roomSelect.val(),$('#roomNumberAddSelect'));
    }
    
	/*  保存客人信息   */
	function saveCustomer(saveButton){
		var guestRoomType = $("#guestRoomTypeAddSelect").val();
		var roomNumber = $("#roomNumberAddSelect").val();
		if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
			alert('Extra bed can not exist without any roommate.');
			return;
		}
		var $customerForm = $(saveButton).parent().parent();
		var checkedName = false;
		$.ajax({
			url:'${base}/admin/orders/checkCustomerName.jhtml',
			data: $customerForm.serialize(),
			type:"POST",
			success:function(result){
				if(result == 'exist'){
					checkedName = confirm('该客人名称已存在，要继续保存吗?')
				}else{
					checkedName = true;
				}
				if(checkedName == true){
					$.ajax({
						url:'${base}/admin/orders/addCustomer.jhtml',
						data: $customerForm.serialize(),
						type:"POST",
						beforeSend:function(){
						},
						success:function(result){
							if(result == 'noOrder'){
								alert('There is no order in the total order.');
								$(saveButton).prev().click();
								return;
							}
							addCustomerList($customerForm,result);
							$(saveButton).prev().click();
							alert("New Client Added！");
						}
					});
				}
			}
		});
	} 
	
	/*  更新客人信息   */
	function updateCustomer(updateButton){
		var guestRoomType = $("#guestRoomTypeSelect").val();
		var roomNumber = $("#roomNumberEditSelect").val();
		if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
			alert('Extra bed can not exist without any roommate.');
			return;
		}	
		var $customerForm = $(updateButton).parent().parent();
		$.ajax({
			url:'${base}/admin/orders/updateCustomer.jhtml',
			data: $customerForm.serialize(),
			type:"POST",
			beforeSend:function(){
			},
			success:function(){
				updateCustomerList($customerForm);
				$(updateButton).prev().click();
				alert("Client Info. Updated！");
			}
		});
	}
	
	/* 向客人列表增加一条记录  */
	function addCustomerList($customerForm,customerOrderRelId){
		var $customerListTr = $("#customerListTemplate").clone(true).removeAttr("id").attr("id",customerOrderRelId);
		setValue($customerListTr,$customerForm,customerOrderRelId,1);
		$("#customerList").append($customerListTr);
	}
	
	/* 对客人列表更新客人变更后的值   */
	function updateCustomerList($customerForm){
		var customerOrderRelId = $('#idInput').val();
		setValue($("#" + customerOrderRelId),$customerForm,customerOrderRelId,0);
	}
	
	/* 给列表设置值  */
	function setValue($customerListTr,$customerForm,customerOrderRelId,isAddCustomer){
		var $tds = $customerListTr.find("td");
		$tds.eq(0).html($customerForm.find("input[name='customer.lastName']").val() + '/' + $customerForm.find("input[name='customer.firstName']").val()+ ' ' + $customerForm.find("input[name='customer.middleName']").val());
		$tds.eq(1).html($customerForm.find("input[name='customer.sex']:checked").val() == '1' ? 'F':'M');
		$tds.eq(2).html($customerForm.find("input[name='customer.nationalityOfPassport']").val());
		$tds.eq(3).html($customerForm.find("input[name='customer.dateOfBirth']").val());
		$tds.eq(4).html($customerForm.find("input[name='customer.passportNo']").val());
		$tds.eq(5).html($customerForm.find("input[name='customer.expireDateOfPassport']").val());
		$tds.eq(6).html($customerForm.find("select[name='guestRoomType']").val());
		if(isAddCustomer == 1){
			$tds.eq(7).html('');
		}
		var $a = $tds.eq(8).find("a");
		$a.eq(0).attr("href","javascript:${base}/admin/orders/editCustomer('" + customerOrderRelId + "');");
		$a.eq(1).attr("href","javascript:${base}/admin/orders/deleteCustomer('" + customerOrderRelId + "_Button','" + customerOrderRelId + "');");
		$a.eq(1).attr("id",customerOrderRelId + "_Button");
	}
	
	/* 编辑客人信息  */
	function editCustomer(customerOrderRelId){
		$.post("${base}/admin/orders/loadCustomer.jhtml",{"id":customerOrderRelId},function(customerOrderRel){
			$("#idInput").val(customerOrderRelId);
			$("#lastNameInput").val(customerOrderRel.customer.lastName);	
			$("#firstNameInput").val(customerOrderRel.customer.firstName);
			$("#middleNameInput").val(customerOrderRel.customer.middleName);	
			$("#dateOfBirthInput").val(customerOrderRel.customer.dateOfBirth);	
			$("#sexRadio" + customerOrderRel.customer.sex).click();
			$("#nationalityOfPassportInput").val(customerOrderRel.customer.nationalityOfPassport);	
			$("#passportNoInput").val(customerOrderRel.customer.passportNo);	
			$("#expireDateOfPassportInput").val(customerOrderRel.customer.expireDateOfPassport);	
			$("#languageIdSelect").val(customerOrderRel.customer.languageId).select2({
				width:'100%'
			});	
			$("#memoOfCustomerSelect").val(customerOrderRel.customer.memoOfCustomer).select2({
				width:'100%'
			});	
			$("#mobileInput").val(customerOrderRel.customer.mobile);	
			$("#emailInput").val(customerOrderRel.customer.email);
			$("#ticketTypeSelect").val(customerOrderRel.ticketType).select2({
				width:'100%'
			});	
			$("#streetAddressInput").val(customerOrderRel.customer.streetAddress);
			$("#guestRoomTypeSelect").val(customerOrderRel.guestRoomType).select2({
				width:'100%'
			});
			getRoomNumberOptionsAndSetValue(customerOrderRel);
		});
	}
	
	/*  异步获取可选的客人,并根据值显示选中  */
	function getRoomNumberOptionsAndSetValue(customerOrderRel){
		var $roomNumberSelect = $("#roomNumberEditSelect");
		var roomNum = customerOrderRel.roomNumber;
		var roomType = customerOrderRel.guestRoomType;
		$roomNumberSelect.find("option").remove();
		
		if(roomType == single || roomType == sharingExistingBed || roomType == roomMatching){
		//如果客人的房型是单间或不占床以及拼房
			/* 显示New Room或No Room,并将选项值设置为房间号  */
			if(roomType == sharingExistingBed){
				$roomNumberSelect.append("<option value='" + roomNum + "'>No Room</option>");
			}else{
				$roomNumberSelect.append("<option value='" + roomNum + "'>New Room</option>");
			}
			$roomNumberSelect.val(roomNum).select2({ width:'100%' });
		}else if(roomType == twinBed || roomType == kingBed){
		//如果客人的房型是标间或大床房
			if(customerOrderRel.roomIsFull == 0){
				$roomNumberSelect.append("<option value='"+ roomNum +"'>New Room</option>");
			}else{
				$roomNumberSelect.append("<option value='0'>New Room</option>");
			}
			var append;
			$.post("${base}/admin/orders/getRoommatesWithRoomNumber.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}","roomNumber":roomNum},function(result){
				$.each(result,function(i,cusorel){
					if(cusorel.id != customerOrderRel.id){
						append = '<option value="' + cusorel.roomNumber + '">' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName + '</option>';
						$roomNumberSelect.append(append);
					}
				});
				$roomNumberSelect.val(roomNum).select2({ width:'100%' });
			});
		}else{
		//如果客人的房型是加床或套房
			if(roomType == suite){
				$roomNumberSelect.append("<option value='0'>New Room</option>");
			}
			var roomNumbers = new Array();
			var index = 0;
			$.post("${base}/admin/orders/getRoommatesWithRoomNumber.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}","roomNumber":roomNum},function(result){
				$.each(result,function(i,cusorel){
					if(cusorel.id != customerOrderRel.id){
						if(roomNumbers.contains(cusorel.roomNumber)){
							var $existOption = $roomNumberSelect.find("option[value="+ cusorel.roomNumber +"]");
							$existOption.html($existOption.html() + '/' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName);
						}else{
							roomNumbers[index++] = cusorel.roomNumber;
							append = '<option value="' + cusorel.roomNumber + '">' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName + '</option>';
						 	$roomNumberSelect.append(append);
						}
					}
				});
				if($roomNumberSelect.find("option[value="+ roomNum +"]").size() == 0){
					$roomNumberSelect.find("option[value='0']").val(roomNum);
				}
				$roomNumberSelect.val(roomNum).select2({ width:'100%' });
			});
		}
		$roomNumberSelect.attr("first","true");
		$roomNumberSelect.attr("roomType",roomType);
		$roomNumberSelect.attr("roomNumber",roomNum);
		$("#optionCache").find("option").remove();
	}
	
	
	/* 删除客人  */
	function deleteCustomer(buttonId, customerOrderRelId){
		$.post("${base}/admin/orders/deleteCustomer.jhtml",{"customerOrderRelId" : customerOrderRelId},function(result){
			if(result == 'success' || result == 'all'){
				var $a = $("#" + buttonId);
				$a.attr("href","javascript:recoverCustomer('"+ buttonId +"','"+ customerOrderRelId +"');");
				$a.parent().prev().html('<span class="color-danger">Cancelled</span>');
				$a.find("i").removeClass("fa fa-times").addClass("fa fa-mail-reply");
				alert('Client Info. Cancelled！');
				if(result == 'all'){
					window.location.reload(true);   
				}
			}
		}); 
	}
	
	/* 恢复客人  */
	function recoverCustomer(buttonId, customerOrderRelId){
		$.post("${base}/admin/orders/recoverCustomer.jhtml",{"customerOrderRelId" : customerOrderRelId},function(result){
			if(result == 'success' || result == 'all'){
				var $a = $("#" + buttonId);
				$a.attr("href","javascript:deleteCustomer('"+ buttonId +"','"+ customerOrderRelId +"');");
				$a.parent().prev().html('');
				$a.find("i").removeClass("fa fa-mail-reply").addClass("fa fa-times"); 
				alert('Client Info. Recoverd！');
				if(result == 'all'){
					window.location.reload(true);   
				}
			}
		}); 
	}
	
	
    $("#submitButton").click(function(){
    	var str = $('input[name="radio"]:checked').val();
    	$("#logo").attr("value",str);
    	//alert(str);
    });
    $("#selectCustomerForAddButton").click(function(){
    	var length = $(".customerCheckbox:checked").size();
		if(length == 0){
			alert("Select Customer");
			return;
		}
    	$("#selectCustomerForm").submit();
    });
    
    $("#importCustomerForAddButton").click(function(){
    	$("#importCustomerForm").submit();
    });
    function customerListen(){
    	var lastName=$("#lastNameId").val().trim();
		var firstName=$("#firstNameId").val();
		var passportNo=$("#passportNoId").val();
		$.ajax({
			type: "POST",
			url: "[@spring.url '/admin/customer/findCustomerTourInfo.jhtml'/]",
			data:"lastName="+lastName+"&firstName="+firstName+"&passportNo="+passportNo,
			success: function(msg){
				 $("#modalId").html("");
				 if(msg!=null&&msg.customer!=null&&msg.customer.customerId!=null){
				 	 html="<span class='pull-left' >The Passenger Repetition <a href='${base}/admin/customer/orderByCusId?id="+msg.customer.customerId+"' >&nbsp;&nbsp;&nbsp;Detail</a></span>"
	  				 $("#modalId").html(html); 
				}
			 }
		});
    }
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
