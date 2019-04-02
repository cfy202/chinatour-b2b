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
	<div align="center">
		<div align="center" style="margin:10px;height: auto; font-size: 16px; font-family: 'Arial'; font-weight: bold;">				
			<h3>${tour.tourCode}</h3>
		</div>
		<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
			<tr>
				<td style="width:20%;"></td>
				<td></td>
				[#list supplierCheckList as supplierCheck]
					<td>
						${supplierCheck.userNameOfAgent}(${supplierCheck.totalPeople})人
						(${rateOfCurrency.currencyId})
						[#assign totalFeeOfAgent =(supplierCheck.totalFeeOfAgent)?number ]
						[#assign totalRateFeeOfAgent =(supplierCheck.totalRateFeeOfAgent)?number ]
						[#assign totalUSARateFeeOfAgent =(supplierCheck.totalUSARateFeeOfAgent)?number ]
						[#assign rateUp =(supplierCheck.rateUp)?number ]
						[#assign rateDown =(supplierCheck.rateDown)?number ]
						[#assign USArate =(supplierCheck.exchangeUSARate)?number ]
					</td>
				[/#list]
			</tr>
				[#list supPriceInfoRelList as supPriceInfoRel]
				  <tr>
				  	<td>
				  	
				  		[#if supPriceInfoRel.type==1]
				  			Operator 
				  		[#elseif supPriceInfoRel.type==2]
				  			Hotel 
				  		[#elseif supPriceInfoRel.type==3]
				  			Flight 
				  		[#else]
				  			Insurance  
				  		[/#if]
						
					 </td>
				  	<td>
				  		${supPriceInfoRel.supplierName}
				  	</td>
				    [#list supPriceInfoRel.supplierOfAgentList as supplierOfAgent]
				    	<td>
				    		${rateOfCurrency.currencyId}
				    		${supplierOfAgent.sum}
				    	</td>
				    [/#list]	
				  </tr>
				[/#list]
				<tr>
					<td>Total</td>
					<td></td>
					<td>${rateOfCurrency.currencyId}${totalFeeOfAgent}</td>
				</tr>
				<tr>
					<td>Total Amount(Exchange Rate${rateUp}/${rateDown})</td>
					<td></td>
					<td>${rateOfCurrency.toCurrencyId}${totalRateFeeOfAgent}</td>
				</tr>
				<tr>
					<td>USD (Exchange Rate${USArate})</td>
					<td></td>
					<td>$ ${totalUSARateFeeOfAgent}</td>
				</tr>
			</tbody>
		</table>
		[#if (supplierPriceRemarkCheckList?size>0)]
			<div align="center" style="margin:10px;height: auto; font-size: 16px; font-family: 'Arial'; font-weight: bold;">				
				<h3>Revised Bill(Cost)</h3>
			</div>
			<table width="800" class="invPriTable" cellspacing="0" cellpadding="0" border="1">
				<tr>
					<td style="width:10%;">Tour Code</td>
					<td>Date</td>
					<td>Content</td>
					<td>Original Amount </td>
					<td>Revised Amount</td>
					<td>Increase or Decrease Amount</td>
					<td class="text-right">Change Reason</td>
				</tr>
				[#list supplierPriceRemarkCheckList as supplierPriceRemark]
						<tr>	
							<td style="width:10%;">
								${supplierPriceRemark.tourCode }
								<!-- 会计未审核记录Id -->
								[#if supplierPriceRemark.sprCheck==3||supplierPriceRemark.sprCheck==2]
									<input type="hidden" value="${supplierPriceRemark.supplierPriceRemarkId}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].supplierPriceRemarkId" />
									[#assign temp =1 /]
								[/#if]
							</td>
							<td>
							<input type="hidden" value="${supplierPriceRemark.supplierCheckId}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].supplierCheckId" />
							<input type="hidden" value="${supplierPriceRemark.differenceSum}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].differenceSum" />
							<input type="hidden" value="${supplierPriceRemark.userName}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].userName" />
							<input type="hidden" value="${supplierPriceRemark.insertTime?string('yyyy-MM-dd')}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].insertTime" />
								${supplierPriceRemark.eidtTime?string("yyyy-MM-dd HH:mm:ss")}
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
								${supplierPriceRemark.differenceSum }
								[#assign costProfitFSum = (receiveProfitFSum+supplierPriceRemark.differenceSum)?number/]
							</td>
							<td class="text-right">
								${supplierPriceRemark.reason }
							</td>
						</tr>
				[/#list]
			</table>
		[/#if]
	</div>
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
