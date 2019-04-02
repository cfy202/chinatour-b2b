[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
	<style type="text/css" media="screen">
		a{cursor:pointer;}
	</style>
    <title>${message("admin.main.title")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>
<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i> Warning !</h4>

                    <p>Data will be permanently deleted ?</p>
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
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Checking Accounts</h3>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertEditButton" data-modal="form-primary1">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
            </ol>
        </div>
        <form action="saveBusinessFlow.jhtml" method="post" id="formId">
       <div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="pull-right option-left">
		            	<div><input id="month" style="height:34px; border:solid 1px #ccc; text-align:center;" type="text" name="businessFlow.accountDate"><a id="submitId" class="btn btn-flat md-trigger" type="button"> &nbsp;&nbsp; Confirm &nbsp;&nbsp;</a></div>
		            	<input name="businessFlow.subjectType" value="2" type="hidden">
		            </div>
					<div class="tab-container">
							<ul class="nav nav-tabs">
							  <li><a href="javascript:;" onclick="javascript:window.location.href='addAccountForSalesIncome.jhtml'" data-toggle="tab">Sales Income</a></li>
							  <li class="active"><a href="javascript:;" onclick="javascript:window.location.href='addAccountForTourCost.jhtml'" data-toggle="tab">Tour Cost</a></li>
							  <li><a href="javascript:;" onclick="javascript:window.location.href='addAccountForIncome.jhtml'" data-toggle="tab">Gross Profit</a></li>
							  <li><a href="javascript:;" onclick="javascript:window.location.href='addAccountForCost.jhtml'" data-toggle="tab">Expense&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
							</ul>
                     </div>
                     [#assign a=0?number]
					<div class="tab-content block-flat">
						<table>
							<tbody>
								[#list accountSubjectList as accountSubject]
									[#if accountSubject.level==1 && accountSubject.subjectType==4]
											<tr>
												<td  style="background:#DCEFF7;font-weight:bold;width:5%;text-align:right;" align="left">${accountSubject.subjectCode}</td>
												<td  colspan="3" align="left">${accountSubject.subjectName}</td>
												<td>
													[#if accountSubject.hasChild==0]
														<input name="businessFlowList[${a}].accountsSum" type="text" value="0">
														<input name="businessFlowList[${a}].accountSubjectId" type="hidden" value="${accountSubject.accountSubjectId}">
														[#assign a=(a+1)?number]
													[/#if]
												</td>
											</tr>
										[#list accountSubjectList as accountSubjectForChild]
											[#if accountSubjectForChild.parentSubjectId==accountSubject.accountSubjectId && accountSubjectForChild.level==2]
												<tr>
													<td></td>
													<td  style="background:#DCEFF7;font-weight:bold;width:8%;text-align:right;" align="left">${accountSubjectForChild.subjectCode}</td>
													<td  colspan="2" align="left">${accountSubjectForChild.subjectName}</td>
													<td>
													[#if accountSubjectForChild.hasChild==0]
														<input name="businessFlowList[${a}].accountsSum" type="text" value="0">
														<input name="businessFlowList[${a}].accountSubjectId" type="hidden" value="${accountSubjectForChild.accountSubjectId}">
														[#assign a=(a+1)?number]
													[/#if]
												</td>
												</tr>
												[#list accountSubjectList as accountSubjectForCh]
													[#if accountSubjectForCh.parentSubjectId==accountSubjectForChild.accountSubjectId && accountSubjectForCh.level==3]
														<tr>
															<td></td>
															<td></td>
															<td  style="background:#DCEFF7;font-weight:bold;width:10%;text-align:right;" align="left">${accountSubjectForCh.subjectCode}</td>
															<td align="left">${accountSubjectForCh.subjectName}</td>
															<td>
																[#if accountSubjectForCh.hasChild==0]
																	<input name="businessFlowList[${a}].accountsSum" type="text" value="0">
																	<input name="businessFlowList[${a}].accountSubjectId" type="hidden" value="${accountSubjectForCh.accountSubjectId}">
																	[#assign a=(a+1)?number]
																[/#if]
															</td>
														</tr>
														
													[/#if]
												[/#list]
											[/#if]
										[/#list]
									[/#if]	
								[/#list]
							</tbody>
						</table>
					</div>
				</div>
	    	</div>
		</div>
		</form>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
    });
   
   $("#submitId").click(function(){
   		$("#formId").submit();
   });
   
   $("#month").datepicker({dateFormat: 'yy-mm',changeYear: true,changeMonth: true });
</script>
</body>
</html>
