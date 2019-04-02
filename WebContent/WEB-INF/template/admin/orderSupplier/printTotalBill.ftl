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
</head>
<body>
<div id="printBox" title="Print Record">
	[#list supplierCheckList as supplierCheck]
		[#assign totalPeople=(supplierCheck.totalPeople+totalPeople)?number]
	[/#list]
	[#if did==1]
		<div align="center">
			<div align="center" style="margin:10px;height: auto; font-size: 16px; font-family: 'Arial'; font-weight: bold;">
				${tour.tourCode}Bill for Agent
				${totalPeople}
			</div>
			
			<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
				<tr>
					<td width="6%" style="text-align: center;"></td>
					<td width="10%" style="text-align: center;"></td>
					[#list supplierCheckList as supplierCheck]
						<td width="5%" style="text-align: center;">${supplierCheck.userNameOfAgent}(${supplierCheck.totalPeople} Person)</td>
					[/#list]
					<td width="5%">Item Total</td>
				</tr>
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
					<td>Subtotal</td>
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
					<td>Total</td>
					[#list supplierCheckList as supplierCheck]
						<td>${supplierCheck.totalFeeOfAgent}</td>
					[/#list]
					<td class="text-right">${totalSum+totalFeeOfInsurance}</td>
					[#if (totalSum??)||(totalFeeOfInsurance??)]
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
						<td colspan="${supplierCheckList.size()+2}" width="500px" style="word-wrap:break-word;word-break:break-all;">
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
							<input type="hidden" value="${supplierCheck.totalFeeOfAgent}" id="totalFeeOfAgent_${m.count}" style="border:0px;"/>
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
			</table>
		</div>
	[#elseif did=2]
	
		[#list supPriceInfoRelList as supPriceInfoRel]
			[#if supPriceInfoRel.type!=4]
				[#assign totalSum =(totalSum+supPriceInfoRel.supplierPrice)?number ]
			[#else]
				[#assign totalFeeOfInsurance =(totalFeeOfInsurance+supPriceInfoRel.supplierPrice)?number ] 
			[/#if]
		[/#list]

		[#if (totalSum??)||(totalFeeOfInsurance??)]
			[#assign totalFeeOfTour =(totalSum+totalFeeOfInsurance)?number ]
		[/#if]
		<div align="center">
			<h3>${tour.tourCode}Summary Sheet</h3>
			<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
				
					<tr>
						<td style="width:15%;">Operator Name</td>
						<td>
						[#if actionBean.supplierPrice.deptId=='328479cb-99dc-11e3-bd69-94de800aa3f8' ]
							苏州公司
						[#else]
							文景假期
						[/#if]
						</td>
						<td colspan="3"></td>
						<td>Operation Office</td>
						<td class="text-right">${supplierPrice.tourDept}</td>
						<td></td>
					</tr>
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
						National Guide
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
			</table>
			<div align="center" style="margin:10px;height: auto; font-size: 16px; font-family: 'Arial'; font-weight: bold;">
				${tour.tourCode}Profit Bill
			</div>
			<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
				<tbody>
					<tr>
						<td></td>
						<td>Tour Price</td>
						<td>Tour Cost</td>
						<td>Gross Profit</td>
						<td>Remark</td>
					</tr>
					<tr>
						<td style="width:30%;">Total</td>
						<td>${(totalFeeOfTour)!0}</td>
						<td>${(totalFee)!0}</td>
						<td>${(totalFeeOfTour-totalFee)!0}</td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div style="position: fixed; right: 50px;font-weight:bold;">
				Tabulator: ${admin.username}
		</div>		
	[#else]
	<div align="center">
		<div class="header">
			<h3>${tour.tourCode} Revised Bill</h3>
		</div>
		<div class="panel-body block-flat">
			<div class="content header">
				<h3 ></h3>
				<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
						<tr><td colspan="10"><h3>Income:</h3><td></tr>
						<tr>
							<td style="width:5%;font-weight:bold;" >Type</td>
							<td style="font-weight:bold;">Agent</td>
							<td style="font-weight:bold;width:10%">Booking No.</td>
							<td style="font-weight:bold;">Content</td>
							<td style="font-weight:bold;">Original Amount</td>
							<td style="font-weight:bold;">Revised Amount</td>
							<td style="font-weight:bold;">Increase or Decrease Amount</td>
							<td style="font-weight:bold;">Change Reason</td>
							<td style="font-weight:bold;">Audit Status</td>
							<td style="font-weight:bold;">Action</td>
						</tr>
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
									${supplierPriceRemark.deptName } (${supplierPriceRemark.userName})<br/>
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
										Delete
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
						<tr><td colspan="10"><h3>Cost:</h3><td></tr>
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
									[#assign costNextSum = (costSum+supplierPriceRemark.nextSum)?number/]
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
										Delete
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
				</table>
			</div>
		</div>
	</div>
		<div style="position: fixed; right: 50px;font-weight:bold;">
				Tabulator: ${admin.username}
		</div>				
	[/#if]
</div>
<div style="position: fixed; top: 5px; right: 50px;">
	<input type="button" name="printBtn"  id="printBtn" value="Print Page" onclick="printPage()"/>
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
