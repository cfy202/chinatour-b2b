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
			<h2>List</h2>
			<ol class="breadcrumb">
			<li><a href="#">Home</a></li>
			<li><a href="#">Inquiry</a></li>
			<li class="active">List</li>
			</ol>
		</div>
		<div class="cl-mcont">		
			<div class="row wizard-row">
				<div class="col-md-12 fuelux">
					<div class="block-wizard">
						<div class="step-content">
							<form class="form-horizontal group-border-dashed" method="post"
								 data-parsley-namespace="data-parsley-" data-parsley-validate novalidate>
								<div class="step-pane active" id="step1">
									<input type="hidden" name="enquiryId" value="${enquirys.enquiryId}">
									<input type="hidden" id="typeId" name="type" value="0">
									<table style="padding:10px;border: 0px none" width="100%">
										<tbody>
											<tr>
												<td width="13%">
													<span>
														FirstName:
													</span>
												</td>
												<td width="37%">
													<input type="text" name="firstName" value="${enquirys.firstName}" class="form-control input-group1 peer" placeholder="FirstName">
												</td>
												<td width="13%">
													<span>
														LastName:
													</span>
												</td>
												<td width="37%">
													<input type="text" name="lastName"  value="${enquirys.lastName}" class="form-control input-group1 peer" placeholder="lastName">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Phone：
													</span>
												</td>
												<td width="37%">
													<input type="text" name="contactPhone" value="${enquirys.contactPhone}" class="form-control input-group1 peer" placeholder="contactPhone">
												</td>
												<td width="13%">
													<span>
														Email：
													</span>
												</td>
												<td width="37%">
													<input type="text" name="email" value="${enquirys.email}" class="form-control input-group1 peer" placeholder="email">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Arrival Date
													</span>
												</td>
												<td width="37%">
													<div class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2" style="width:60%;">
														<input name="arriveDate" class="form-control"  [#if (enquirys.arriveDate)??]value="${enquirys.arriveDate?string('yyyy-MM-dd')}"[/#if] readonly="readonly" type="text" size="16">
														<span class="input-group-addon btn btn-primary">
															<span class="glyphicon glyphicon-th"></span>
														</span>
													</div>
												</td>
												<td width="13%">
													<span>
														Hotel：
													</span>
												</td>
												<td width="37%">
													<input type="text" name="hotelStandard" value="${enquirys.hotelStandard}" class="form-control input-group1 peer" placeholder="hotelStandard">
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														State
													</span>
												</td>
												<td width="37%">
													<select id="selState" name="stateId" class="select2 peer" >
														<option value="">Select</option>
														[#list stateList as state]
															<option value="${state.id}" [#if enquirys.stateId == state.id] selected="selected" [/#if]>${state.stateName}</option>
														[/#list]
													</select>
												</td>
												<td width="13%">
													<span>
														Race
													</span>
												</td>
												<td width="37%">
													<select id="selhumanrace" name="humanRaceId" class="select2 peer" >
														<option value="">Select</option>
														[#list humanraceList as humanrace]
															<option value="${humanrace.humanRaceId}" [#if enquirys.humanRaceId == humanrace.humanRaceId] selected="selected" [/#if]>${humanrace.humanRace}</option>
														[/#list]
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Language
													</span>
												</td>
												<td width="37%">
													<select id="sellanguage" name="languageId" class="select2 peer" >
														<option value="">Select</option>
														[#list languageList as language]
															<option value="${language.languageId}" [#if enquirys.languageId == language.languageId] selected="selected" [/#if]>${language.language}</option>
														[/#list]
													</select>
												</td>
												<td width="13%">
													<span>
														Nationality
													</span>
												</td>
												<td width="37%">
													<select id="selCountry" name="countryId" class="select2 peer" >
														<option value="">Select</option>
														[#list countryList as country]
															<option value="${country.id}" [#if enquirys.countryId == state.id] selected="selected" [/#if]>${country.countryName}</option>
														[/#list]
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Person(min-max)：
													</span>
												</td>
												<td width="37%">
													<select class=" select2 peer" name="teamPopulation">
														[#list constant.TEAM_POPULATION_STRINGS as val]
															<option value="${val}" [#if enquirys.teamPopulation == val] selected="selected" [/#if]>${val}</option>
														[/#list]
													</select>
												</td>
												<td width="13%">
													<span>
														Adult：
													</span>
												</td>
												<td width="37%">
													<select class="select2 peer" name="amountOfAdult">
														<option value="">Select</option>
														[#list 1..50 as val]
															<option value="${val}" [#if enquirys.amountOfAdult == val] selected="selected" [/#if]>${val}</option>
														[/#list]
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Child：
													</span>
												</td>
												<td width="37%">
													<select class="select2 peer" name="amountBelow12">
														<option value="">Select</option>
														[#list 1..50 as val]
															<option value="${val}" [#if enquirys.amountBelow12 == val] selected="selected" [/#if]>${val}</option>
														[/#list]
													</select>
												</td>
												<td width="13%">
													<span>
														No Shopping(Under 21)：
													</span>
												</td>
												<td width="37%">
													<select class="select2 peer" name="amountBelow21">
														<option value="">Select</option>
														[#list 1..50 as val]
															<option value="${val}" [#if enquirys.amountBelow21 == val] selected="selected" [/#if]>${val}</option>
														[/#list]
													</select>
												</td>
											</tr>
											<tr>
												<td width="13%">
													<span>
														Shopping
													</span>
												</td>
												<td width="87%" colspan="3">
													<div class="col-sm-6">
														<label class="radio-inline"> <input type="radio" [#if "${enquirys.shoppingOption == 1}"] checked="checked" [/#if] name="shoppingOption" class="icheck" value="1">Yes</label> 
														<label class="radio-inline"> <input type="radio" [#if "${enquirys.shoppingOption == 2}"] checked="checked" [/#if] name="shoppingOption" class="icheck" value="2"> No</label> 
													</div>
												</td>
											</tr>
											<td width="13%">
													<span>
														Brand
													</span>
												</td>
												<td width="37%">
													<select id="selectBrandId" class=" select2 peer" name="brand">
														<option value="${enquirys.brand}">${enquirys.brand}</option>
													</select>
												</td>
												<td width="13%">
													Type
												</td>
												<td width="37%">
													<select id="selectTypeId" class=" select2 peer" name="tourTypeId">
														[#list tourTypeList as val]
															[#if enquirys.tourTypeId == val.tourTypeId]
																<option value="${val.typeName}" selected="selected">${val.typeName}</option>
															[/#if]
														[/#list]
													</select>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<span>
														<br>Requirement:<br><br>
														<textarea name="specialRequirment" style="width:95%;height:200px">${enquirys.specialRequirment}</textarea>
													</span>
												</td>
												<td colspan="2">
													<br>Note:<br><br>
													<textarea name="commentOfTour" style="width:95%;height:200px">${enquirys.commentOfTour}</textarea>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<br>Itinerary:<br><br>
														<textarea name="privateTravelDetails" style="width:95%;height:200px">${enquirys.privateTravelDetails}</textarea>
												</td>
												<td colspan="2">
													<br>Remark:<br><br>
														<textarea name="remarks" style="width:95%;height:200px">${enquirys.remarks}</textarea>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="form-group" align="right">
										<div class="col-sm-12">
											<button type="button" onclick="javascript:history.go(-1);" class="btn btn-default">Cancel</button>
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
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/fuelux/loader.min.js'/]" type="text/javascript"></script><!-- -->
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script><!-- -->
<script type="text/javascript">
	$("#credit_slider").slider().on("slide",function(e){
	      $("#credits").html("$" + e.value);
	    });
	    $("#rate_slider").slider().on("slide",function(e){
	      $("#rate").html(e.value + "%");
	    });
	$(document).ready(function(){
		//initialize the javascript
		App.init();
		App.wizard();
		$("form select.select2").select2({
			width: '60%'
		});
	});
</script>
</body>
</html>