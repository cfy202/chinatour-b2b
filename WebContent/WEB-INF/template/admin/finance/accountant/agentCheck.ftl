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
		<h2>Billing</h2>
		<ol class="breadcrumb">
		<li><a href="#">Home</a></li>
		<li><a href="#">Accounting</a></li>
		<div class="new"><a id="btnPrint" href='${base}/admin/supplierPrice/printAgentCheck.jhtml?tourId=${tour.tourId}&tourCode=${tour.tourCode}' target="_blank" class="btn btn-primary" ><i class="fa fa-print"></i> Print</a><a class="btn pull-right " href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a></div>
		</ol>
	</div>
	<div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div class="header">							
						<h3>${tour.tourCode}</h3>
						[#list supplierCheckList as supplierCheck]
							[#if supplierCheck.checkOfAgent!=1&&supplierPrice.accCheck==1]
								<a class="btn btn-success md-trigger pull-right" data-href="${base}/admin/supplierPrice/agentCheck.jhtml?checkOfAgent=1&groupId=${tour.groupId}" data-toggle="modal" data-target="#confirm-primary" >Pass</a>
								<a class="btn btn-success md-trigger pull-right" data-href="${base}/admin/supplierPrice/agentCheck.jhtml?checkOfAgent=2&groupId=${tour.groupId}" data-toggle="modal" data-target="#confirm-primary" >Not Pass</a>
							[/#if]
						[/#list]
					</div>
					<div class="content">
						<table class="no-border">
							<thead class="no-border">
								<tr>
									<th style="width:20%;"></th>
									<th></th>
									[#list supplierCheckList as supplierCheck]
										<th>
											${supplierCheck.userNameOfAgent}(${supplierCheck.totalPeople})人
											(${rateOfCurrency.currencyId})
											[#assign totalFeeOfAgent =(supplierCheck.totalFeeOfAgent)?number ]
											[#assign totalRateFeeOfAgent =(supplierCheck.totalRateFeeOfAgent)?number ]
											[#assign totalUSARateFeeOfAgent =(supplierCheck.totalUSARateFeeOfAgent)?number ]
											[#assign rateUp =(supplierCheck.rateUp)?number ]
											[#assign rateDown =(supplierCheck.rateDown)?number ]
											[#assign USArate =(supplierCheck.exchangeUSARate)?number ]
										</th>
									[/#list]
								</tr>
							</thead>
							<tbody class="no-border-x">
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
								  		<a href="${base}/admin/supplierPrice/detailBill.jhtml?supPriceInfoRelId=${supPriceInfoRel.supPriceInfoRelId}&tourCode=${tour.tourCode}&tourId=${tour.tourId}"><font color="#A42DOO">${supPriceInfoRel.supplierName}</font></a>
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
					</div>
				</div>
			<!--备注栏
				<div>
						<input type="hidden" name="token" id="token" value ="${token }"/>
						<div style="text-align:left;" >
							[#list supplierCheckList as supplierCheck]
								 备注: <input type="text"  name="supplierCheck.remarkOfAgent" value="${supplierCheck.remarkOfAgent}" id='remarkOfAgentId' style="width:400px;" />	
								<input type="button" value="审核变更单" />
								<input type="button" name="printBtn" value="Print Page"/>
							[/#list]
						</div>
						
						[#list agentOfOrderList as agentOfOrder]
							<input type="hidden" value="${agentOfOrder.userId}" name="supplierCheck.userIdOfAgent" />
						[/#list]
						<input type="hidden" value="${tour.tourId}" name="tour.tourId" id="tourId"/>
				</div>
			//备注栏-->
				<div class="panel-group accordion accordion-semi" id="accordion3">
					<div class="panel panel-default">
							<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;cursor:pointer;">
								<i class="fa fa-bars"></i>
								<span class="customerNumber">Revised Bill</span>
								<div class="pull-right">
					               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
					           </div>
					        </h4>
						<div id="ac3-1" class="panel-collapse collapse">
							<div class="panel-body">
								<form id="formId" action="${base}/admin/supplierPrice/agentAuditBillChange.jhtml" method="post">
										<div class="header">
										<button id="butId" class="btn btn-success md-trigger pull-right"  data-modal="md-flipV" type="button">&nbsp;&nbsp;Approve &nbsp;&nbsp;</button>
											<h4>Cost</h4>
										</div>
										<div class="content">
											<table>
												<thead>
													<tr>
														<th style="width:10%;">Tour Code</th>
														<th>Date</th>
														<th>Content</th>
														<th>Original Amount </th>
														<th>Revised Amount</th>
														<th>Increase or Decrease Amount</th>
														<th class="text-right">Change Reason</th>
													</tr>
												</thead>
												<tbody>
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
												</tbody>
											</table>
											<input type="hidden" value="${tour.tourId}" name="tourId" id="tourId"/>
											<input type="hidden" value="1" name="sprCheck" id="tourId"/>
										</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="confirm-primary" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <form action="" id="agentCheckId"  method="post">
				<div class="modal-body">
					<div class="text-center">
						<div class="i-circle primary"><i class="fa fa-check"></i></div>
						<h4>Awesome!</h4>
						<p>Changes has been saved successfully!</p>
						Remarks
						[#list supplierCheckList as supplierCheck]
							<input type="text"  name="remarkOfAgent" style="width:400px;" value="${supplierCheck.remarkOfAgent }"/>
						[/#list]
						<input type="hidden" value="${admin.id}" name="checkUserId" />
						<input type="hidden" value="${tour.tourId}" name="tourId" id="tourId" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-primary btn-flat">Proceed</button>
				</div>
			</form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!--审核弹出框-->
<div class="md-modal md-effect-9" id="md-flipV">
	<div class="md-content">
		<div class="modal-header">
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<div class="modal-body">
			<div class="text-center">
				<div class="i-circle primary"><i class="fa fa-check"></i></div>
					<h4>Awesome!</h4>
					<p>Changes has been saved successfully!</p>
				</div>
			</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			<button type="button" class="btn btn-primary btn-flat" onclick="formSumDal();">Proceed</button>
		</div>
	</div>
</div>
<!--/审核弹出框-->
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
      $(document).ready(function(){
        //initialize the javascript
        App.init();
        //判断是否有变更单未审核 否 隐藏审核按钮
 		var temp='${temp}';
     	if(temp!=1){
     		$("#butId").hide();
     	}
      });
	$('#confirm-primary').on('show.bs.modal', function (e) {
		$(this).find('#agentCheckId').attr('action', $(e.relatedTarget).data('href'));
	});
		//提交变更单
	function formSumDal(){
		$("#formId").submit();
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
</script>
</body>
</html>
