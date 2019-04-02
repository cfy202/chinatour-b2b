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
		<li><a href="#">Accounting</a></li>
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
				               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
				           </div>
				        </h4>
						<div class="infotab" id="ac3-1" class="panel-collapse collapse in">
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
										</ul>
										<div class="tab-content">
											<div class="tab-pane active cont" id="home">
												<table id="billTableId">
													<thead>
														<tr>
															<th style="width:15%;"></th>
															<th></th>
															[#list supplierCheckList as supplierCheck]
																<th>${supplierCheck.userNameOfAgent}(${supplierCheck.totalPeople}人)</th>
															[/#list]
															<th class="text-right">Item Total</th>
														</tr>
													</thead>
													<tbody>
														[#list supPriceInfoRelList as supPriceInfoRel]
															[#if supPriceInfoRel.type!=4]
																<tr>
																	<td style="width:15%;">
																	[#switch supPriceInfoRel.type]
															           [#case 1]
																			Operator 
															           [#case 2]
															             	 Hotel
														               [#case 3]
															              	Flight 
															        [/#switch]
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
															[#assign totalFeeOfTour =(totalSum+totalFeeOfInsurance)?number ]
														</tr>
														<tr >
															<td style="width:10%;">Remark</td>
															<td colspan="${(supplierCheckList?size)?number+2}"><pre>${supplierPrice.remark}</pre></td>
														</tr>
														[#list supplierCheckList as supplierCheck]
														  <tr>
														  		<td>
																	${supplierCheck.deptName}(${supplierCheck.rateUp}/${supplierCheck.rateDown})
																</td>
																<td colspan="${supplierCheckList.size()+2}" width="500px">
																	No. ${supplierCheck.customerNos} traveller is from ${supplierCheck.userNameOfAgent} booking 
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
															<td>
																Tabulator
															</td>
															<td>
																${tour.userName}
															</td>
															<td>
																Auditor ${admin.username}
															</td>
															<td colspan="${supplierCheckList?size}">
																Date${supplierPrice.createTime?string("yyyy-MM-dd")}</td>
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
																	<th class="text-right">Remarks</th>
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
								<!--打印栏-->
											<!--<div style="text-align:left;" >
												<input type="button" value="打印变更单" id="billChange" onclick="print()"/>
												<input type="button" name="printBtn"   value="Print Page" onclick="jprintPage()"/>
											</div>-->
											[#if supplierPrice.accCheck!=1 || supplierPrice.accCheck==3]
												<a class="btn btn-success md-trigger pull-right" data-href="${base}/admin/supplierPrice/accCheck.jhtml?accCheck=1" data-toggle="modal" data-target="#confirm-primary" >Pass</a>
												<a class="btn btn-success md-trigger pull-right" data-href="${base}/admin/supplierPrice/accCheck.jhtml?accCheck=2" data-toggle="modal" data-target="#confirm-primary" >Not Pass</a>
											[/#if]
											
								<!--/打印栏-->
							</div>
						</div>
					</div>
					<!--/总账单-->
					<!--查看变更单-->
					<div class="panel panel-default">
						<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;cursor:pointer;">
							<i class="fa fa-bars"></i>
							<span class="customerNumber">Revised Bill</span>
							<div class="pull-right">
				               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
				           </div>
				        </h4>
						<div class="infotab" id="ac3-2" class="panel-collapse collapse" style="display:none;">
							<div class="panel-body">
								<form id="formId" action="${base}/admin/supplierPrice/accAuditBillChange.jhtml" method="post">
									<div class="block-flat">
										<div class="header">
											<h3>Revised Bill</h3>
												<button id="butId" class="btn btn-success md-trigger pull-right"  data-modal="md-flipV" type="button">&nbsp;&nbsp;Audition &nbsp;&nbsp;</button><a id="btnPrint" href='${base}/admin/supplierPrice/printTotalBill.jhtml?did=3&tourId=${tour.tourId}&tourCode=${tour.tourCode}' target="_blank" class="btn btn-primary pull-right" ><i class="fa fa-print"></i> Print</a>
											<input type="hidden" name="sprCheck" value="3"/><!--3 保存为会计审核-->
										</div>
										<div class="header">
											<h4>Income</h4>
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
														[#if supplierPriceRemark.type==1]
															<tr>	
																<td style="width:10%;">
																	${supplierPriceRemark.tourCode }
																<!-- 会计未审核记录Id -->
																[#if supplierPriceRemark.sprCheck==0]
																	<input type="hidden" value="${supplierPriceRemark.supplierPriceRemarkId}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].supplierPriceRemarkId" />
																	[#assign temp =1 /]
																[/#if]
																</td>
																<td>
																	${supplierPriceRemark.eidtTime?string("yyyy-MM-dd HH:mm:ss")}
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
																	${supplierPriceRemark.differenceSum }
																	[#assign receiveProfitFSum = (receiveProfitFSum+supplierPriceRemark.differenceSum)?number/]
																</td>
																<td class="text-right">
																	${supplierPriceRemark.reason }
																</td>
															</tr>
														[/#if]
													[/#list]
													<tr style="line-height:25px;">	
														<td colspan="2">
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
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="block-flat">
										<div class="header">							
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
														[#if supplierPriceRemark.type==2]
															<tr>	
																<td style="width:10%;">
																	${supplierPriceRemark.tourCode }
																	<!-- 会计未审核记录Id -->
																	[#if supplierPriceRemark.sprCheck==0]
																		<input type="hidden" value="${supplierPriceRemark.supplierPriceRemarkId}" name="supplierPriceRemarkList[${supplierPriceRemark_index}].supplierPriceRemarkId" />
																		[#assign temp =1 /]
																	[/#if]
																</td>
																<td>
																	${supplierPriceRemark.eidtTime?string("yyyy-MM-dd HH:mm:ss")}
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
																	${supplierPriceRemark.differenceSum }
																	[#assign costProfitFSum = (costProfitFSum+supplierPriceRemark.differenceSum)?number/]
																</td>
																<td class="text-right">
																	${supplierPriceRemark.reason }
																</td>
															</tr>
														[/#if]
													[/#list]
													<tr style="line-height:25px;">	
														<td colspan="2">
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
													</tr>
													<tr style="line-height:25px;">	
														<td colspan="2">
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
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div><!--/查看变更单-->
				</div>
			</div>
		</div>
	</div>
</div>

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
<!-- Modal -->
<div class="modal fade" id="confirm-primary" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <form action="" id="accCheckId"  method="post">
				<div class="modal-body">
					<div class="text-center">
						<div class="i-circle primary"><i class="fa fa-check"></i></div>
						<h4>Awesome!</h4>
						<p>Changes has been saved successfully!</p>
						Remarks
						<input type="text"  name="checkRemark" style="width:400px;" value="${supplierPrice.checkRemark }"/>
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
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
		$('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	  		 radioClass: 'iradio_square-blue'
     	});
     	//判断是否有变更单未审核 否 隐藏审核按钮
     	var temp='${temp}';
     	if(temp!=1){
     		$("#butId").hide();
     	}
	});
	
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
	//提交变更单
	function formSumDal(){
		$("#formId").submit();
	}
	$('#confirm-primary').on('show.bs.modal', function (e) {
		$(this).find('#accCheckId').attr('action', $(e.relatedTarget).data('href'));
	});
	
	$("h4").each(function(){
		$(this).click(function(){
			$(this).next().slideToggle("slow");
		});
	});
		//判断打印应收账单还是 团小结账单
	function ProfitForm(did){
		$("#btnPrint").attr("href","${base}/admin/supplierPrice/printTotalBill.jhtml?did="+did+"&tourId=${tour.tourId}&tourCode=${tour.tourCode}");
	}
</script>
</body>
</html>
