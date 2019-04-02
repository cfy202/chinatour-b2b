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
				Add Booking
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
				<li class="active">
					Add Booking
				</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row wizard-row">
				<div class="col-md-12 fuelux">
					<div class="block-wizard">
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
													<input class="form-control input-group1 peer" name="tel" type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														BookingDate:
													</span>
												</td>
												<td width="37%">
													<input id="bookingDateInput" class="form-control input-group1" type="text" size="16">
												</td>
												<td>
													<span>
														Email:
													</span>
												</td>
												<td>
													<input class="form-control input-group1 peer" parsley-type="email" required placeholder="Enter a valid e-mail" name="email" type="email">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Wholesale/Retail :
													</span>
												</td>
												<td width="37%">
													<select id="retailWholeSale" class="input-group1 select2 wr" name="wr" onchange="retailOrWholeSale(this.value);" type="text">
														[#list ["admin:admin","order:retail"] as permission]
															[@shiro.hasPermission name = permission]
																<option value="retail">Retail</option>
																[#break /]
															[/@shiro.hasPermission]
														[/#list]
														[#list ["admin:admin","order:wholeSale"] as permission]
															[@shiro.hasPermission name = permission]
																<option value="wholeSale">WholeSale</option>
																[#break /]
															[/@shiro.hasPermission]
														[/#list]
													</select>
												</td>
												<td width="13%">
													<span>
														Address:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1 peer" name="address"  parsley-maxlength="64" placeholder="Max 64 chars." type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Agency:
													</span>
												</td>
												<td width="37%"> 
													<input name="companyId" type="hidden" id="userSelect" style="width:60%" doName="4808" required="" onchange="changeCompanyValue(this);"/>
													<!--<select id="companySelect" name="companyId" class="select2 peer" disabled="true" onchange="changeCompanyValue(this);" type="text">
														<option value="0">Select Peer</option>
													[#list venderList as vender]
														<option value="${vender.venderId}">${vender.name}</option>
													[/#list]
													</select>-->
													<input name="company" type="hidden">
												</td>
												<td width="13%">
													<span>
														PostCode:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1 peer" name="postCode"  parsley-maxlength="32" placeholder="Max 32 chars." type="text">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														ContactName:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1 peer" name="contactName" required parsley-maxlength="32" placeholder="Max 32 chars." type="text">
												</td>
												<td width="13%">
													<span>
														Country:
													</span>
												</td>
												<td width="37%">
													<select id="countrySelect" class="input-group1 select2 peer" name="countryId"  onchange="generalStateSelect(this);"  type="text">
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
														Number of Travelers:
													</span>
												</td>
												<td width="37%">
													<input class="form-control input-group1" name="totalPeople"  parsley-type="number" required placeholder="Enter only numbers" type="text">
												</td>
												<td width="13%">
													<span>
														State/Province:
													</span>
												</td>
												<td width="37%">
													<select id="stateSelect" class="input-group1 select2 peer" name="stateId" type="text">
														<option value="0">Select State/Province</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Customer Source:
													</span>
												</td>
												<td width="37%">
													<select name="customerSourceId" class="input-group1 select2" id="sheetId" >
														<option value="0">Select Source</option>
													[#list customerSourceList as customerSource]
														<option value="${customerSource.customerSourceId}">${customerSource.sourceName}</option>
													[/#list]
													</select>
												</td>
												<td width="13%">
													<span>
														City:
													</span>
												</td>
												<td width="37%">
													<select class="input-group1 select2" name="cityId" type="text">
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
										<div class="col-sm-12">
										    <button type="button" onclick="javascript:history.go(-1);" class="btn btn-default">Cancel</button>
                  							<button type="reset" onclick="resetSelect();" class="btn btn-default">Reset</button>
              								<button type="button" onclick="formSubmit();" class="btn btn-primary" style="margin-left:206px;">
              									<i class="fa fa-check">
												</i>
              									Save
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
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script>
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
    	
    	$("form select.select2").select2({
			width: '60%'
		});
		
		setBookingDate();
		
		$("#userSelect").select2({
			placeholder:"Search Agency",//文本框的提示信息
			minimumInputLength: 1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'${base}/admin/vender/listSelect.jhtml?type=2',	//地址(type=2供应商，查找type!=2)
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
                    return {  
                         name: term   //联动查询的字符  
                     }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.venderList.length;i++){
						var vender = dataStr.venderList[i];
						 dataA.push({id: vender.venderId, text: vender.name});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/vender/listSelect.jhtml?venderId='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		//alert(JSON.stringify(data));
				    		//alert(JSON.stringify(data.venderList[0].venderId));
				    		if(data.venderList[0]==undefined){
				    			callback({id:"",text:"Search Vender"});
				    		}else{
				    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) { return m; }
		});
		
		if($("#retailWholeSale").val() == 'retail'){
	    	var $userSelect = $("#userSelect");
	    	$userSelect.select2("val", ""); 
	    	$userSelect.select2("enable", false);
	    }
    });
    
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	
	    /* 设置订单的bookingDate */
    function setBookingDate(){
		var date = new Date();
		var vYear = date.getFullYear();
		var vMon = date.getMonth() + 1;
		var vDay = date.getDate();
		$("#bookingDateInput").val(vYear + "-" + vMon + "-" + vDay);
    }
    
    /* 根据retail或wholesale选择是否选同行  */
    function retailOrWholeSale(value){
    	var $companySelect = $("#userSelect");
		/* 如果选择不是同行  */
    	if(value != 'wholeSale'){
    		if($companySelect.val() != ''){
	    		clearCompanyInformation();
    		}  
	    	$companySelect.select2("val", ""); 
	    	$("#userSelect").select2("enable", false);
	    	$companySelect.next().val('');
    	}else{
    		$("#userSelect").select2("enable", true);
    	}
    }
    
    /* 根据同行下拉框的变动改变同行信息  */
    function changeCompanyValue(companySelect){
    	var companyId = $(companySelect).val();
    	if(companyId == '0'){
    		$(companySelect).next().val('');
			clearCompanyInformation();
    	}else{
    		setCompanyInformation(companyId);
    	}
    }
    
    /* 清空同行信息 */
    function clearCompanyInformation(){
	   	$("input.peer").val('');
		$("#countrySelect").removeAttr("disabled").val('0').select2({
			width: '60%'
		});
		var $stateSelect = $("#stateSelect");
		$stateSelect.val('0').select2({
			width: '60%'
		});
    	$stateSelect.children("option[value!='0']").remove();
    }
        
    /* 根据同行ID异步查找同行信息并显示  */
    function setCompanyInformation(companyId){
	    $.post("getVender.jhtml", {
            "companyId": companyId
        },
        function(company) {
        	$("input[name='company']").val(company.name);
        	$("input[name='contactName']").val(company.contactor);
        	$("input[name='tel']").val(company.tel);
        	$("input[name='email']").val(company.email);
        	$("input[name='address']").val(company.address);
        	$("input[name='postCode']").val(company.zipCode);
        	var $countrySelect = $("select[name='countryId']");
        	$countrySelect.val(company.countryId).select2({
				width: '60%'
			});
			generalStateSelect($countrySelect);
        });
    }

    /* 重置所有select下拉框  */
    function resetSelect(){
    	var $companySelect = $("#userSelect")
    	$companySelect.select2("val", ""); 
    	$companySelect.select2("enable", false);
    	$("#form").find("select:not(.wr)").each(function(){
    		$(this).val('0').select2({ width: '60%' });
    	});
    	$("#form select.wr").val('retail').select2({ width:'60%'});
    	$("#stateSelect").children("option[value!='0']").remove();
    	window.setTimeout(setBookingDate, 50); 
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
    
    function formSubmit(){
    	if($("#retailWholeSale").val() != 'retail'){
    		if($("#userSelect").val() == ''){
    			alert('Please select agency.');
    			return;
    		}
    	}else{
    		if($("#sheetId").val() == '0'){
    			alert('Please select Source.');
    			return;
    		}
    	}
    	$("#form").submit();
    }
</script>
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>
