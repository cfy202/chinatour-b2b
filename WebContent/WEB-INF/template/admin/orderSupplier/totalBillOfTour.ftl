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
		<h2>Bill</h2>
		<div class="new"><a id="btnPrint" href='${base}/admin/supplierPrice/printTotalBill.jhtml?did=1&tourId=${tour.tourId}&tourCode=${tour.tourCode}' target="_blank" class="btn btn-primary" ><i class="fa fa-print"></i> Print</a><a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a></div>
		<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li><a href="#">Bill</a></li>
		</ol>
		
	</div>
	<div class="row">
			<div class="block-flat"><!--最大的框-->
				<div class="panel-group accordion accordion-semi" id="accordion3">
					<!--总账单-->
					<div class="panel panel-default">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff; cursor:pointer;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber">Bill</span>
							<div class="pull-right">
				               <i class="fa fa-angle-down"></i>&nbsp;&nbsp;
				           </div>
				        </h4>
						<div class="infotab" id="ac3-2" class="panel-collapse collapse">
							<div class="panel-body">
								<div class="col-sm-12 col-md-12 col-lg-12">
									<div class="tab-container">
										<ul class="nav nav-tabs">
											<li class="active">
											<a href="#home" data-toggle="tab" onclick="ProfitForm(1);">
												${tour.tourCode}Bill for Agent
												[#list supplierCheckList as supplierCheck]
													[#assign totalPeople=(supplierCheck.totalPeople+totalPeople)?number]
												[/#list]
												${totalPeople}
											</a>
											</li>
											<li><a href="#profile" data-toggle="tab" onclick="ProfitForm(2);">${tour.tourCode}Summary Sheet</a></li>
											<!-- <button class="btn btn-success md-trigger pull-right" data-modal="form-primary" type="button">修改</button> -->
										</ul>
										<div class="tab-content">
											<div class="tab-pane active cont" id="home">
												<table id="billTableId">
													<thead>
														<tr>
															<th style="width:15%;"></th>
															<th></th>
															[#list supplierCheckList as supplierCheck]
																<th>${supplierCheck.userNameOfAgent}(${supplierCheck.totalPeople} Person)</th>
															[/#list]
															<th class="text-right">Item Total</th>
														</tr>
													</thead>
													<tbody>
														[#list supPriceInfoRelList as supPriceInfoRel]
															[#if supPriceInfoRel.type!=4]
																<tr>
																	<td style="width:15%;">
															        [#if supPriceInfoRel.type==1]
															  			Operator
															  		[#elseif supPriceInfoRel.type==2]
															  			Hotel
															  		[#elseif supPriceInfoRel.type==3]
															  			Flight
															  		[/#if]
																	</td>
																	<td>${supPriceInfoRel.supplierName}</td>
																	[#list supplierCheckList as supplierCheck]
																		[#list supPriceInfoRel.supplierOfAgentList as supplierOfAgent]
																			[#if supplierOfAgent.userId==supplierCheck.userIdOfAgent]
										    									<td>${supplierOfAgent.sum}</td>
									    									[/#if]
																		[/#list]
																	[/#list]
																	<td class="text-right">${supPriceInfoRel.supplierPrice}</td>
																	[#assign totalSum =(totalSum+supPriceInfoRel.supplierPrice)?number ]
																</tr>
															[#else]
																[#assign totalFeeOfInsurance =(totalFeeOfInsurance+supPriceInfoRel.supplierPrice)?number ] 
															[/#if]
														[/#list]
														<tr>
															<td style="width:10%;"></td>
															<td>SubTotal</td>
															[#list supplierCheckList as supplierCheck]
																<td>${supplierCheck.subtotalOfAgent}</td>
															[/#list]
															<td class="text-right">${totalSum}</td>
														</tr>
														<tr>
															<td style="width:10%;"></td>
															<td>Insurance</td>
															[#list supplierCheckList as supplierCheck]
																<td>${supplierCheck.totalFeeOfInsurance}</td>
															[/#list]
															<td class="text-right">${totalFeeOfInsurance}</td>
														</tr>
														<tr>
															<td style="width:10%;"></td>
															<td>In Total</td>
															[#list supplierCheckList as supplierCheck]
																<td>${supplierCheck.totalFeeOfAgent}</td>
															[/#list]
															<td class="text-right">${totalSum+totalFeeOfInsurance}</td>
																[#if totalSum??||totalFeeOfInsurance??]
																	[#assign totalFeeOfTour =(totalSum+totalFeeOfInsurance)?number ]
																[/#if]
														</tr>
														<tr >
															<td style="width:10%;">Remark</td>
															<td colspan="[#if supplierCheckList??]${(supplierCheckList?size)?number+2}[/#if]"><pre>${supplierPrice.remark}</pre></td>
														</tr>
														[#list supplierCheckList as supplierCheck]
														  <tr>
														  		<td>
																	${supplierCheck.deptName}(${supplierCheck.rateUp}/${supplierCheck.rateDown})
																</td>
																<td colspan="${supplierCheckList.size()+2}" width="500px"  style="word-wrap:break-word;word-break:break-all;">
																	No.${supplierCheck.customerNos} traveller is from  ${supplierCheck.userNameOfAgent} booking 
																</td>
															</tr>
														  	<tr>
																<td>
																	Receivable ${supplierCheck.deptName} 
																</td>
																<td>
																	${supplierCheck.userNameOfAgent} (${supplierCheck.totalPeople}人)Total
																</td>
																<td>
																	${Symbol}${supplierCheck.totalFeeOfAgent}
																</td>
																<td colspan="${supplierCheckList?size}">
																	${supplierCheck.currencyType}
																	<input type="hidden" value="${supplierCheck.totalFeeOfAgent}"  style="border:0px;"/>
																	${supplierCheck.totalRateFeeOfAgent}
																</td>
															</tr>
														[/#list]
														
														<tr>
															<td  style="font-weight:bold;">
																Tabulator
															</td>
															<td>
																${admin.username}
															</td>
															<td  style="font-weight:bold;">
																Auditor
															</td>
															<td  style="font-weight:bold;" colspan="[#if supplierCheckList??]${supplierCheckList?size}[/#if]">
																Date &nbsp;[#if supplierPrice.createTime??]${supplierPrice.createTime?string("yyyy-MM-dd")}[/#if]</td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane cont" id="profile">
												<table id="payTableId">
													<thead>
														<tr>
															<th style="width:15%;">Operator Name</th>
															<th>
															[#if actionBean.supplierPrice.deptId=='328479cb-99dc-11e3-bd69-94de800aa3f8' ]
																苏州公司
															[#else]
																文景假期
															[/#if]
															</th>
															<th colspan="3"></th>
															<th>Operation Office</th>
															<th class="text-right">${supplierPrice.tourDept}</th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<tr>
														  	<td>
														  		Nationality
															 </td>
														  	<td>
														  		${supplierPrice.nationality}
														  	</td>	
														    <td>
																Persons
															</td>
															<td>
																${totalPeople}
															</td>
															<td>
																Days
															</td>
															<td>
																${supplierPrice.dayNum}
															</td>
															<td>
																NationalGuide
															</td>
															<td class="text-right">
																${supplierPrice.accompany}
															</td>
														</tr>
														[#list supPriceInfoRelList as supPriceInfoRel]
															[#assign  totalFee=(totalFee+supPriceInfoRel.supplierCost)?number/]
															[#if supPriceInfoRel.type==4]
																[#assign  totalInsureFee=(totalInsureFee+supPriceInfoRel.supplierCost)?number/]
															[#else]
																<tr>
																	<td>
																		[#if supPriceInfoRel.type==1]
																			Operator
																		[#elseif supPriceInfoRel.type==2]
																			Hotel
																		[#else]
																			Flight
																		[/#if]
																	</td>
																	<td>
																		${supPriceInfoRel.supplierName}
																	</td>
																	<td colspan="5">
																		[#if supPriceInfoRel.type==3]${supPriceInfoRel.remark}[/#if]
																	</td>	
																	<td class="text-right">
																		${supPriceInfoRel.supplierCost}
																	</td>
																</tr>
															[/#if]	
														[/#list]
														<tr>
															<td>Insurance</td>
															<td colspan="6"></td>
															<td class="text-right">${totalInsureFee}</td>
														</tr>
														<tr>
															<td>Total</td>
															<td colspan="6"></td>
															<td class="text-right">${totalFee}</td>
														</tr>
														<tr>
															<td>Remark</td>
															<td colspan="6"></td>
															<td class="text-right">${supplierPrice.subRemark}</td>
														</tr>
													</tbody>
												</table>
												<div class="block-flat">
													<div class="header">							
														<h3>${tour.tourCode} Profit Bill</h3>
													</div>
													<div class="content">
														<table class="no-border">
															<thead class="no-border">
																<tr>
																	<th style="width:30%;"></th>
																	<th>Tour Price</th>
																	<th>Tour Cost</th>
																	<th>Gross Profit</th>
																	<th class="text-right">Remark</th>
																</tr>
															</thead>
															<tbody class="no-border-y">
																<tr>
																	<td style="width:30%;">Total</td>
																	<td>${(totalFeeOfTour)!0}</td>
																	<td>${(totalFee)!0}</td>
																	<td>${(totalFeeOfTour-totalFee)!0}</td>
																	<td class="text-right"></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/总账单-->
					<!--修改变更单-->
					<div class="panel panel-default">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;cursor:pointer;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber">Revised Bill</span>
							<div class="pull-right">
				               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
				           </div>
				        </h4>
						<div id="ac3-2" class="infotab block-flat" class="panel-collapse collapse in" style="display:none;">
									<div class="header">
										<h3>${tour.tourCode} <label style="cursor:pointer;font-size:50px; margin-left:3%;"></h3>
										<button id="add" class="btn pull-right"><i class="fa fa-plus" title="Add"></i></button><a id="btnPrint" href='${base}/admin/supplierPrice/printTotalBill.jhtml?did=3&tourId=${tour.tourId}&tourCode=${tour.tourCode}' target="_blank" class="btn btn-primary pull-right" ><i class="fa fa-print"></i> Print</a>
									</div>
									<div class="content" id="addContent" style="display:none;">
										<form id="supplierPriceRemarkForm" method="post" action="${base}/admin/supplierPrice/saveBillChange.jhtml" parsley-validate novalidate>
											<table class="no-border" id="changesTableId">
												<thead class="no-border">
													<tr>
														<th style="width:5%" >Type</th>
														<th>Agent</th>
														<th style="width:10%">Booking No.</th>
														<th style="width:25%">Content(Income:Sales Office & Agent;Cost：Operator & Hotel Name)</th>
														<th style="width:10%">Original Amount</th>
														<th style="width:10%">Revised Amount</th>
														<th style="width:10%">Increase or Decrease Amount</th>
														<th style="width:25%">Change Reason(Indicate Operator, Hotel name)</th>
														<th>Hotel/Operator</th>
														<!--<th style="width:3%">&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-plus" data-toggle="tooltip" data-original-title="增加" onclick="addRows();"></a></th>-->
													</tr>
												</thead>
												<tbody class="no-border-x">
													<tr style="height:50px;">
														<td>
															<input name="supplierPriceRemarkList[0].type" value="1" type="hidden" style="border:0px;"/>收入
														</td>
														<td>
															<select name="supplierPriceRemarkList[0].supplierCheckId" id="supplierCheckId_0" class="select2">
																[#list supplierCheckList as supplierCheck]
																	<option value="${supplierCheck.supplierCheckId}">${supplierCheck.userNameOfAgent}</option>
																[/#list]
															</select>
														</td>
														<td>
															<select name="supplierPriceRemarkList[0].orderId" id="supfrRemark_0" required class="select2">
																<option value="">Select</option>
															</select>
														</td>
														<td>
															<input type="text" id="supplierName_0" name="supplierPriceRemarkList[0].supplierName" style="width:100%;"/>
															<input type="hidden" name="supplierPriceRemarkList[0].supId" id="supId_0"/>
															<input type="hidden" name="supplierPriceRemarkList[0].tourCode" value="${tour.tourCode}"/>
															<input type="hidden" name="supplierPriceRemarkList[0].tourId" value="${tour.tourId}" />
															<input type="hidden" name="supplierPriceRemarkList[0].isDel" value="0" />
														</td>
														<td>
															<input type="text" name="supplierPriceRemarkList[0].preSum" class="form-control" id="preSum_0" value="0" />
														</td>
														<td>
															<input type="text" name="supplierPriceRemarkList[0].nextSum" class="form-control"  id="nextSum_0" value="0" />
														</td>
														<td style="word-break: keep-all;white-space:nowrap;">
															<input type="text" name="supplierPriceRemarkList[0].differenceSum" class="form-control" readonly="readonly" style="border:0px" id="differenceSum_0" value="0" />
														</td>
														<td>
															<input type="text" name="supplierPriceRemarkList[0].reason" class="form-control" />
														</td>
														<td>
															<select name="supplierPriceRemarkList[0].supfrType" id="supfrType_0" class="select2">
																<option value="1">Operator</option>
																<option value="2">Hotel</option>
																<option value="3">Flight</option>
																<option value="4">Insurance</option>
															</select>
														</td>
													</tr>
													<tr style="height:50px;">
														<td>
															<input name="supplierPriceRemarkList[1].type" value="2" type="hidden" style="border:0px;"/>支出
														</td>
														<td>
															<select name="supplierPriceRemarkList[1].supplierCheckId" id="supplierCheckId_1" class="select2">
																[#list supplierCheckList as supplierCheck]
																	<option value="${supplierCheck.supplierCheckId}">${supplierCheck.userNameOfAgent}</option>
																[/#list]
															</select>
														</td>
														<td>
															<select name="supplierPriceRemarkList[1].orderId" id="supfrRemark_1" required class="select2">
																<option value="">Select</option>
															</select>
														</td>
														<td>
															<input type="text" id="supplierName_1" name="supplierPriceRemarkList[1].supplierName" style="width:100%;"/>
															<input type="hidden" name="supplierPriceRemarkList[1].supId" id="supId_1"/>
															
															<input type="hidden" name="supplierPriceRemarkList[1].tourCode" value="${tour.tourCode}"/>
															<input type="hidden" name="supplierPriceRemarkList[1].tourId" value="${tour.tourId}" />
															<input type="hidden" name="supplierPriceRemarkList[1].isDel" value="0" />
														</td>
														<td>
															<input type="text" name="supplierPriceRemarkList[1].preSum" class="form-control" id="preSum_1" value="0"/>
														</td>
														<td>
															<input type="text" name="supplierPriceRemarkList[1].nextSum" class="form-control" value="0" id="nextSum_1" />
														</td>
														<td style="word-break: keep-all;white-space:nowrap;">
															<input type="text" name="supplierPriceRemarkList[1].differenceSum" class="form-control" style="border:0px;" readonly="readonly" value="0" id="differenceSum_1" />
														</td>
														<td>
															<input type="text" name="supplierPriceRemarkList[1].reason" class="form-control" />
														</td>
														<td>
															<select name="supplierPriceRemarkList[1].supfrType" id="supfrType_1" class="select2">
																<option value="1">Operator</option>
																<option value="2">Hotel</option>
																<option value="3">Flight</option>
																<option value="4">Insurance</option>
															</select>
														</td>
													</tr>
												</tbody>
											</table>
											<input type="hidden" name="tourCode" value="${tour.tourCode}"/>
											<input type="hidden" name="tourId" value="${tour.tourId}" />
											<div style="text-align:right;width:98%;margin-top:20px;"><button type="submit" class="btn btn-primary btn-flat ">Proceed</button></div>
										</form>
									</div>
								<div class="panel-body block-flat">
									<div class="content header">
										<h3>Income:</h3>
										<table class="no-border">
											<thead class="no-border">
												<tr>
													<th style="width:5%;font-weight:bold;" >Type</th>
													<th style="font-weight:bold;">Agent</th>
													<th style="width:10%">Booking No.</th>
													<th style="font-weight:bold;">Content</th>
													<th style="font-weight:bold;">Original Amount</th>
													<th style="font-weight:bold;">Revised Amount</th>
													<th style="font-weight:bold;">Increase or Decrease Amount</th>
													<th style="font-weight:bold;">Change Reason</th>
													<th style="font-weight:bold;">Audit Status</th>
													<th style="font-weight:bold;">Action</th>
												</tr>
											</thead>
											<tbody class="no-border-x"  id="addContent">
												[#list supplierPriceRemarkList as supplierPriceRemark]
													[#if supplierPriceRemark.type==1]
													<tr id="${supplierPriceRemark.supplierPriceRemarkId}">
														<td>
															[#if supplierPriceRemark.supfrType==1]
																Opertaor
															[#elseif supplierPriceRemark.supfrType==2]	
																Hotel
															[#elseif supplierPriceRemark.supfrType==3]	
																Flight	
															[#else]	
																Insurance	
															[/#if]
														</td>
														<td>
															[#list supplierCheckList as supplierCheck]
																[#if supplierPriceRemark.supplierCheckId==supplierCheck.supplierCheckId]
																	${supplierCheck.userNameOfAgent}
																[/#if]
															[/#list]
														</td>
														<td>
															[#list orderListS as order]
																[#if order.id==supplierPriceRemark.orderId]
																	${order.orderNo}
																[/#if]
															[/#list]
														</td>
														<td>
															${supplierPriceRemark.supplierName }
														</td>
														<td>
															${supplierPriceRemark.preSum }
															[#assign receivePreSum = (receivePreSum+supplierPriceRemark.preSum)?number/]
														</td>
														<td>
															${supplierPriceRemark.nextSum }
															[#assign receiveNextSum = (receiveNextSum+supplierPriceRemark.nextSum)?number/]
														</td>
														<td>
															${supplierPriceRemark.differenceSum}
															[#assign receiveProfitFSum = (receiveProfitFSum+supplierPriceRemark.differenceSum)?number/]
														</td>
														<td>
															${supplierPriceRemark.reason }
														</td>
														<td>
															[#if supplierPriceRemark.sprCheck==0]
																New
															[#elseif supplierPriceRemark.sprCheck==1]
																Auditing Approved
															[#elseif supplierPriceRemark.sprCheck==2]
																Disapproved(Agent)
															[#elseif supplierPriceRemark.sprCheck==3]
																Approved(Accountant)
															[#elseif supplierPriceRemark.sprCheck==4]
																Disapproved(Accountant)
															[#else]
																Settled
															[/#if]
														</td>
														<td>
															[#if supplierPriceRemark.sprCheck==0 || supplierPriceRemark.sprCheck==4 || supplierPriceRemark.sprCheck==2]
																<a style="color:red;" data-href="javascript:deleteBillChange('${supplierPriceRemark.supplierPriceRemarkId}');" data-toggle="modal" data-target="#confirm-delete">Delete</a>
															[/#if]
														</td>
													</tr>
													[/#if]
												[/#list]
												<tr style="line-height:25px;">	
													<td colspan="3">
													</td>
													<td>
														Total
													</td>
													<td>
														${receivePreSum}
													</td>
													<td>
														 ${receiveNextSum}
													</td>
													<td>
														${receiveProfitFSum}
													</td>
													<td>
													</td>
													<td>
													</td>
													<td>
													</td>
												</tr>
												<tr><td colspan="8"><h3 style="margin-top:10px;">Cost:</h3><td></tr>
												<tr style="font-weight:bold;">
													<td>Type</td>
													<td>Agent</td>
													<td style="width:10%">Booking No.</td>
													<td>Content</td>
													<td>Original Amount</td>
													<td>Revised Amount</td>
													<td>Increase or Decrease Amount</td>
													<td>Change Reason</td>
													<td>Audit Status</td>
													<td>Action</td>
												</tr>
												[#list supplierPriceRemarkList as supplierPriceRemark]
													[#if supplierPriceRemark.type==2]
													<tr id="${supplierPriceRemark.supplierPriceRemarkId}">
														<td>
															[#if supplierPriceRemark.supfrType==1]
																Operator
															[#elseif supplierPriceRemark.supfrType==2]	
																Hotel
															[#elseif supplierPriceRemark.supfrType==3]	
																Flight	
															[#else]	
																Insurance	
															[/#if]
														</td>
														<td>
															[#list supplierCheckList as supplierCheck]
																[#if supplierPriceRemark.supplierCheckId==supplierCheck.supplierCheckId]
																	${supplierCheck.userNameOfAgent}
																[/#if]
															[/#list]
														</td>
														<td>
															[#list orderListS as order]
																[#if order.id==supplierPriceRemark.orderId]
																	${order.orderNo}
																[/#if]
															[/#list]
														</td>
														<td>
															${supplierPriceRemark.supplierName }
														</td>
														<td>
															${supplierPriceRemark.preSum }
															[#assign costPreSum = (costPreSum+supplierPriceRemark.preSum)?number/]
														</td>
														<td>
															${supplierPriceRemark.nextSum }
															[#assign costNextSum = (costNextSum+supplierPriceRemark.nextSum)?number/]
														</td>
														<td>
															${supplierPriceRemark.differenceSum}
															[#assign costProfitFSum = (costProfitFSum+supplierPriceRemark.differenceSum)?number/]
														</td>
														<td>
															${supplierPriceRemark.reason }
														</td>
														<td>
															[#if supplierPriceRemark.sprCheck==0]
																New
															[#elseif supplierPriceRemark.sprCheck==1]
																Auditing Approved
															[#elseif supplierPriceRemark.sprCheck==2]
																Disapproved(Agent)
															[#elseif supplierPriceRemark.sprCheck==3]
																Approved(Accountant)
															[#elseif supplierPriceRemark.sprCheck==4]
																Disapproved(Accountant)
															[#else]
																Settled
															[/#if]
														</td>
														<td>
															[#if supplierPriceRemark.sprCheck==0 || supplierPriceRemark.sprCheck==4 || supplierPriceRemark.sprCheck==2]
																<a style="color:red;" data-href="javascript:deleteBillChange('${supplierPriceRemark.supplierPriceRemarkId}');" data-toggle="modal" data-target="#confirm-delete">Delete</a>
															[/#if]
														</td>
													</tr>
													[/#if]
												[/#list]
												<tr style="line-height:25px;">	
													<td colspan="3">
													</td>
													<td>
														Total
													</td>
													<td>
														${costPreSum!0}
													</td>
													<td>
														 ${costNextSum!0}
													</td>
													<td>
														${costProfitFSum!0}
													</td>
													<td>
													</td>
													<td>
													</td>
													<td>
													</td>
												</tr>
												<tr style="line-height:25px;">	
													<td colspan="3">
													</td>
													<td>
														Gross Profit
													</td>
													<td>
														${((receivePreSum)!0)-((costPreSum)!0)}
													</td>
													<td>
														${((receiveNextSum)!0)-((costNextSum)!0)}
													</td>
													<td>
														${((receiveProfitFSum)!0)-((costProfitFSum)!0)}
													</td>
													<td>
													</td>
													<td>
													</td>
													<td>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
						</div>
					<!--/修改变更单-->
					<!--查看变更单-->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>

                    <p>Data will be permanently deleted ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalId" type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--修改弹出框-->
<!-- 
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style=" width: 50%; max-height: 550px;">
	<div class="md-content">
		<div class="modal-header">
			<h3>修改</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form action="${base}/admin/supplierPrice/modifyProfit.jhtml" id="modifyProfitId" method="post">
			<div class="modal-body form">
				<div class="form-group">
					<div class="row no-margin-y">
						<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
							组织部门：<input type="name" class="form-control" value="${supplierPrice.tourDept}" name="tourDept" placeholder="DD">
						</div>
						<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
							全陪：<input type="name" class="form-control" value="${supplierPrice.accompany}" name="accompany" placeholder="MM">
						</div>
						<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
							天数：<input type="name" class="form-control" value="${supplierPrice.dayNum}" name="dayNum" id="dayNumId"  placeholder="YYYY">
						</div>
						<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
							Nationality：
							<select type="text" name="nationality" id="nationality" class="select2">
								<option value="美国">美国</option>
								<option value="加拿大">加拿大</option>
								<option value="澳大利亚">澳大利亚</option>
								<option value="新西兰">新西兰</option>
								<option value="英国">英国</option>
								<option value="法国">法国</option>
								<option value="德国">德国</option>
								<option value="意大利">意大利</option>
								<option value="瑞士">瑞士</option>
								<option value="瑞典">瑞典</option>
								<option value="俄罗斯">俄罗斯</option>
								<option value="西班牙">西班牙</option>
								<option value="日本">日本</option>
								<option value="韩国">韩国</option>
								<option value="蒙古">蒙古</option>
								<option value="印度尼西亚">印度尼西亚</option>
								<option value="马来西亚">马来西亚</option>
								<option value="菲律宾">菲律宾</option>
								<option value="新加坡">新加坡</option>
								<option value="泰国">泰国</option>
								<option value="印度">印度</option>
								<option value="越南">越南</option>
								<option value="缅甸">缅甸</option>
								<option value="朝鲜">朝鲜</option>
								<option value="巴基斯坦">巴基斯坦</option>
								<option value="其他">其他</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label>备注</label>
						<textarea class="form-control" name="remark">${supplierPrice.remark}</textarea>
				</div>
				<div class="form-group">
					<label>小结单备注</label>
						<textarea class="form-control" name="subRemark">${supplierPrice.subRemark}</textarea>
				</div>
				<input type="hidden" value="${admin.id}" name="checkUserId" />
				<input type="hidden" value="${tour.tourId}" name="tourId" id="tourId" />
				<input type="hidden" value="${tour.tourCode}" name="tourCode" id="tourCode"/>
				
				<div class="form-group">
						<label>是否完成：</label>
						<label class="radio-inline"> <input type="radio"  name="completeState" [#if supplierPrice.completeState==0]checked=""[/#if]class="icheck" value="0">未完成</label> 
						<label class="radio-inline"> <input type="radio" name="completeState" [#if supplierPrice.completeState==1]checked=""[/#if] class="icheck" value="1">完成</label> 
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary btn-flat" >Proceed</button>
			</div>
		</form>
	</div>
</div>
-->
<!--/修改弹出框-->
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	[@flash_message /]
    	$("select[id^='supfrType_']").trigger("change");
    	$("#s2id_supplierCheckId_0").attr("style","width:120px");
    	$("#s2id_supplierCheckId_1").attr("style","width:120px");
    	$("#s2id_supfrType_0").attr("style","width:120px");
    	$("#s2id_supfrType_1").attr("style","width:120px");
    	$("#s2id_type_0").attr("style","width:120px");
    	$("#s2id_type_1").attr("style","width:120px");
		$('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	  		 radioClass: 'iradio_square-blue'
     	});
     	$("select[id^='supplierCheckId_']").trigger('click');
	});
	function addRows(){
		 var dgTable=$("#changesTableId").children('tbody').children('tr');//tb为table的ID,
		 dgTable=parseInt(dgTable.length);
		var str='<tr style="height:50px;">'
					+ '<td>'
						+ '	<select name="supplierPriceRemarkList['+dgTable+'].type" class="select2" id="type_'+dgTable+'">'
						+ '		<option value="2">Cost</option>'
						+ '		<option value="1">Income</option>'
						+ '	</select>'
					+ '</td>'
					+ '	 <td>'
					+ '	 	<select name="supplierPriceRemarkList['+dgTable+'].supplierCheckId" class="select2" id="supplierCheckId_'+dgTable+'">'
					+ '	 			[#list supplierCheckList as supplierCheck]'
					+ '					<option value="${supplierCheck.supplierCheckId}">${supplierCheck.userNameOfAgent}</option>'
					+ '				[/#list]'
					+ '	 	</select>'
					+ '	 </td>'
					+ '	 <td>'
					+ '	 	<input type="text" id="supplierName_0" name="supplierPriceRemarkList['+dgTable+'].supplierName" class="form-control"/>'
					+ '	 	<input type="hidden" name="supplierPriceRemarkList['+dgTable+'].supId" id="supId_'+dgTable+'"/>'
					+ '	 	<input type="hidden" name="supplierPriceRemarkList['+dgTable+'].tourCode" value="${tour.tourCode}" readonly="readonly"/>'
					+ '	 	<input type="hidden" name="supplierPriceRemarkList['+dgTable+'].tourId" value="${tour.tourId}" />'
					+ '	 	<input type="hidden" name="supplierPriceRemarkList['+dgTable+'].isDel" value="0" />'
					+ '	 </td>'
					+ '<td>'
					+ '	<input type="text" name="supplierPriceRemarkList['+dgTable+'].preSum" value="0" class="form-control" id="preSum_'+dgTable+'" />'
					+ '</td>'
					+ '<td>'
					+ '		<input type="text" name="supplierPriceRemarkList['+dgTable+'].nextSum" value="0" class="form-control" id="nextSum_'+dgTable+'" />'
					+ '</td>'
					+ '<td style="word-break: keep-all;white-space:nowrap;">'
					+ '		<input type="text" name="supplierPriceRemarkList['+dgTable+'].differenceSum" value="0" style="border:0px;" class="form-control" id="differenceSum_'+dgTable+'" />'
					+ '</td>'
					+ '<td>'
					+ '		<input type="text" name="supplierPriceRemarkList['+dgTable+'].reason" class="form-control"/>'
					+ '</td>'
					+ '<td>'
					+ '		<select name="supplierPriceRemarkList['+dgTable+'].supfrType" class="select2" id="supfrType_'+dgTable+'">'
					+ '	 		<option value="1">Operator</option>'
					+ '	 		<option value="2">Hotel</option>'
					+ '	 		<option value="3">Flight</option>'
					+ '	 		<option value="4">Insurance</option>'
					+ '	 	</select>'
					+ '</td>'
					+ '<td>&nbsp;&nbsp;<a style="cursor:pointer;" class="fa fa-minus" onclick="removeFee(this);"></td>'
				  + '</tr>';
		$("#changesTableId").append(str);
		$("#changesTableId").find("select.select2").select2({
        	width: '100%'
        });
		$("input[id^='preSum_']").blur(function(){
			 sum();
	   }); 
		
		$("input[id^='nextSum_']").blur(function(){
			 sum();
	   }); 
		$("input[type='text']").addClass("input-text");
	}
	function sum(){
		var differenceSumIdo=parseFloat($("#nextSumIdo").val())-parseFloat($("#preSumIdo").val());
		var differenceSumId=parseFloat($("#nextSumId").val())-parseFloat($("#preSumId").val());
		$("#differenceSumIdo").val(differenceSumIdo);
		$("#differenceSumId").val(differenceSumId);
		
		$("input[id^='nextSum_']").each(function(){
			 var id=$(this).attr("id");
			var space=id.indexOf("_", 0)+1;
			var selectId=id.substring(space);
			var pre=$("#preSum_"+selectId).val();
			var next=$("#nextSum_"+selectId).val();
			var difference=parseFloat(next)-parseFloat(pre);
			$("#differenceSum_"+selectId).val(difference);
	   });
	}
	table_rowspan('#billTableId','1') ;
	table_rowspan('#payTableId','1') ;	
	//函数说明：合并指定表格（表格id为_w_table_id）指定列（列数为_w_table_colnum）的相同文本的相邻单元格  
	//参数说明：_w_table_id 为需要进行合并单元格的表格的id。如在HTMl中指定表格 id="data" ，此参数应为 #data
	//参数说明：_w_table_colnum 为需要合并单元格的所在列。为数字，从最左边第一列为1开始算起。  
	function  table_rowspan(_w_table_id,_w_table_colnum) {
	    _w_table_firsttd="";
	    _w_table_currenttd="";
	    _w_table_SpanNum=0;
	    _w_table_Obj=$(_w_table_id+" tr td:nth-child("+_w_table_colnum+")");
	    _w_table_Obj.each(function (i) {
	        if (i==0) {
	            _w_table_firsttd=$(this);
	            _w_table_SpanNum=1;
	        } else {
	            _w_table_currenttd=$(this);
	            if (_w_table_firsttd.text() ==_w_table_currenttd.text()) {
	                _w_table_SpanNum++;
	                _w_table_currenttd.hide(); //remove();  
	                _w_table_firsttd.attr("rowSpan",_w_table_SpanNum);
	            } else {
	                _w_table_firsttd=$(this);
	                _w_table_SpanNum=1;
	            }
	        }
	    });
}
	$("h4").each(function(){
		$(this).click(function(){
			$(this).next().slideToggle("slow");
			if($(this).children("div").children("i").hasClass("fa fa-angle-up")){
				$(this).children("div").children("i").removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				$(this).children("div").children("i").removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
			}
		});
	});
	
	$("#add").click(function(){
		$("#addContent").slideToggle();
		var _className=$(this).children().attr("class");
		if(_className=="fa fa-plus"){
			$(this).children().attr("class","fa fa-minus");
		}else{
			$(this).children().attr("class","fa fa-plus");
		}
	});
	
	$("#nextSum_0").keyup(function(){
		differenceSumPrice(0);
	});
	$("#preSum_0").keyup(function(){
		differenceSumPrice(0);
	});
	$("#nextSum_1").keyup(function(){
		differenceSumPrice(1);
	});
	$("#preSum_1").keyup(function(){
		differenceSumPrice(1);
	});
	function differenceSumPrice(id){
		$("#differenceSum_"+id).val($("#nextSum_"+id).val()-$("#preSum_"+id).val()) ;
	}
	 /* 删除 动态添加的收入支出  */
    function removeFee(button) {
        $(button).parent().parent().remove();
    }
    
	
    
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	
	$("select[id^='supfrType_']").change(function(){
		if($(this).val()==2){
			$(this).parent().parent().find("input[id^='supplierName_']").attr("class","");
			$(this).parent().parent().find("input[id^='supplierName_']").select2({
				placeholder:"Search Hotel",//文本框的提示信息
				minimumInputLength:1,	//至少输入n个字符，才去加载数据
				allowClear: false,	//是否允许用户清除文本信息
				ajax:{
					url:'[@spring.url '/admin/hotel/listSelect.jhtml'/]',	//地址
					dataType:'text',	//接收的数据类型
					type: "POST",
					//contentType:'application/json',
					data: function (term, pageNo) {		//在查询时向服务器端传输的数据
						term = $.trim(term);  
		                return {  
		                     hotelName: term   //联动查询的字符  
		                 }  
					},
					results:function(data,pageNo){
						var dataA = [];
						var dataStr=$.parseJSON(data);
						for(var i=0;i<dataStr.hotelList.length;i++){
							var hotel = dataStr.hotelList[i];
							 dataA.push({id: hotel.hotelName, text: hotel.hotelName});
						}
						
						return {results:dataA};
					}
				},
				initSelection: function(element, callback) {
			    	var id = $(element).val();
				    if (id !== "") {
					    $.ajax("[@spring.url '/admin/hotel/listSelect.jhtml?id='/]" + id, {
					    	dataType: "json",
					    	type: "POST"
					    	}).done(function(data) { 
					    		if(data.hotelList[0]==undefined){
					    			callback({id:"",text:"Search Supplier"});
					    		}else{
					    			callback({id:data.hotelList[0].hotelName,text:data.hotelList[0].hotelName});
					    		}
					    	});
				    }
			    },
				formatResult: formatAsText,	//渲染查询结果项
				escapeMarkup: function (m) { return m; }
			});
		}else if($(this).val()==1){
			$(this).parent().parent().find("input[id^='supplierName_']").attr("class","");
			$(this).parent().parent().find("input[id^='supplierName_']").select2({
				placeholder:"Search Supplier",//文本框的提示信息
				minimumInputLength:1,	//至少输入n个字符，才去加载数据
				allowClear: false,	//是否允许用户清除文本信息
				ajax:{
					url:'[@spring.url '/admin/supplier/listSelect.jhtml'/]',	//地址
					dataType:'text',	//接收的数据类型
					type: "POST",
					//contentType:'application/json',
					data: function (term, pageNo) {		//在查询时向服务器端传输的数据
						term = $.trim(term);  
		                return {  
		                     supplierName: term   //联动查询的字符  
		                 }  
					},
					results:function(data,pageNo){
						var dataA = [];
						var dataStr=$.parseJSON(data);
						for(var i=0;i<dataStr.supplierList.length;i++){
							var supplier = dataStr.supplierList[i];
							 dataA.push({id: supplier.supplierName, text: supplier.supplierName});
						}
						
						return {results:dataA};
					}
				},
				initSelection: function(element, callback) {
			    	var id = $(element).val();
				    if (id !== "") {
					    $.ajax("[@spring.url '/admin/supplier/listSelect.jhtml?id='/]" + id, {
					    	dataType: "json",
					    	type: "POST"
					    	}).done(function(data) { 
					    		if(data.supplierList[0]==undefined){
					    			callback({id:"",text:"Search hotel"});
					    		}else{
					    			callback({id:data.supplierList[0].supplierName,text:data.supplierList[0].supplierName});
					    		}
					    	});
				    }
			    },
				formatResult: formatAsText,	//渲染查询结果项
				escapeMarkup: function (m) { return m; }
			});
		}else{
			$(this).parent().parent().find("input[id^='supplierName_']").prev().remove();
			$(this).parent().parent().find("input[id^='supplierName_']").attr("class","form-control");
		}
	});
	
	//判断打印应收账单还是 团小结账单
	function ProfitForm(did){
		$("#btnPrint").attr("href","${base}/admin/supplierPrice/printTotalBill.jhtml?did="+did+"&tourId=${tour.tourId}&tourCode=${tour.tourCode}");
	}
	
	$('#confirm-delete').on('show.bs.modal', function (e) {
		$(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
	});

	//异步删除变更单
	function deleteBillChange(supplierPriceRemarkId){
		$.ajax({
			url:'deleteBillChange.jhtml',
			data:'supplierPriceRemarkId='+supplierPriceRemarkId,
			type:"POST",
			success:function(result){
				if(result=="SUCCESS"){
					$("#modalId").trigger("click");
					$.gritter.add({title: 'Action Details',text: 'SUCCESS',class_name: 'success'});
					$("#"+supplierPriceRemarkId).remove();
				}else{
					$.gritter.add({title: 'Action Details',text: 'ERROR',class_name: 'danger'});
				}
			}
		});
	}
	[#if orderList??]
	//agent 订单联动
	$("select[id^='supplierCheckId_']").click(function(){
		var orderList=${orderList};
		var supplierCheckId=$(this).val();
		var agentId=$(this).find("option:selected").text();
		var html='<option value="">Select</option>';
		$.each(orderList,function(index,order){
			if(agentId==order.userName){
				html+='<option value="'+order.id+'">'+order.orderNo+'</option>';
			}
		});
		$(this).parent().parent().find("select[id^='supfrRemark_']").select2("val","");
		$(this).parent().parent().find("select[id^='supfrRemark_']").empty();
		$(this).parent().parent().find("select[id^='supfrRemark_']").append(html);
	});
	[/#if]
</script>
</body>
</html>
