[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <style type="text/css" media="screen">
		a{cursor:pointer;}
		
		.noBorder{
			border:0px;font-size:12px;
		}
	</style>
    <title>${message("admin.main.title")}</title>
</head>
<body>
<div>
	<div id="tittleContent" style="width:100%;height:40px;border:1.5px solid #ccc;overflow-y:auto;border-radius: 6px;margin-bottom:10px;">
		<form id="formId" method="post">
			 <table>
			 	<tr>
			 		<td class="noBorder">Into Account Status
			 			<select id="ifClose" class="select2" name="ifClose"" >
					         <option value="">All</option>
					         <option value="0">No Into Account</option>
					         <option value="1">Has Taken Account</option>
					     </select>
			 		</td>
			 		<td class="noBorder">Data Status
			 			<select id="isAvailable" class="select2" name="isAvailable"" >
					         <option value="">All</option>
					         <option value="0">Effective</option>
					         <option value="1">Invalid</option>
					     </select>
			 		</td>
			 		<td class="noBorder">Year
			 			<select id="accountDateStr" class="select2" name="accountDateStr" >
			 				 <option value="2019"[#if year==2019] selected = "selected"[/#if]>2019</option>
			 				 <option value="2018"[#if year==2018] selected = "selected"[/#if]>2018</option>
			 				 <option value="2017"[#if year==2017] selected = "selected"[/#if]>2017</option>
			 				 <option value="2016"[#if year==2016] selected = "selected"[/#if]>2016</option>
					         <option value="2015"[#if year==2015] selected = "selected"[/#if]>2015</option>
					         <option value="2014"[#if year==2014] selected = "selected"[/#if]>2014</option>
					         <option value="2013"[#if year==2013] selected = "selected"[/#if]>2013</option>
					         <option value="2012"[#if year==2012] selected = "selected"[/#if]>2012</option>
					     </select>
			 		</td>
			 		<td class="noBorder">
			 			<button id="searchButton">Search</button>
			 		</td>
			 		<td class="noBorder">
			 			<button id="analyButton">Report Analysis</button>
			 		</td>
			 		<td class="noBorder">
			 			<button id="exportButton">Export</button>
			 		</td>
			 		<!--td class="noBorder">
			 			<input id="printButton" type="button" value="Print">
			 		</td-->
			 		<input name="deptId" type="hidden" value="${deptId}"> 
			 		<input name="childAccDept" type="hidden" value="${childAccDept}"> 
			 	</tr>
			 </table>
		 </form>
	</div>
<div id="content" style="border:1px solid #ccc;border-radius: 10px;">
	<h4 style="text-align:center;">CTS - ${deptName} Monthly Profit & Loss 文景假期月报表 </h4>
	<div id="table_content">
		<table cellspacing="0" cellpadding="0" width="100%">
			[#if flag==3||flag==""]
			<h5 style="text-align:center;magin-bottom:20px;">${year}- Sales Income Summary ( Jan.- Dec. )</h5>
				<thead>
					<tr>
						<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
						<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
						<th width="10%" colspan="2" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Sales Income</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jan</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Feb</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Mar</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Apr</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">May</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jun</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jul</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Aug</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Sep</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Oct</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Nov</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Dec</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Total</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Percent</th>
					</tr>
					</thead>
					<tbody>
						[#list  accountSubjectList as accountSubject]
							[#if accountSubject.subjectType==3]
								[#if accountSubject.hasChild==1]
									<tr id="traSum" style="background:#E6E6FA;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
										[#if accountSubject.level>1]
											[#list 1..(accountSubject.level-1) as index]
												<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
											[/#list]
										[/#if]
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
											${accountSubject.subjectCode}
											<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
											<input type="hidden" value="${accountSubject.level}" id="level"/>
										</td>
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
										[#list 1..12 as index]
											<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForSalesIncome">
												[#list businessFlowList as businessFlow]
													[#if businessFlow.accountDateStr==index]
														[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
															${businessFlow.accountsSum}
															<input type="hidden" value="${businessFlow.accountsSum}" name="sumAmount"/>
														[/#if]
													[/#if]
												[/#list]
											</td>
										[/#list]
										<td class="trtotalSumForIncome" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
											<span class="spantrtotalSum"></span><!--Grand Total  -->
											<input class="iptrtotalSum" type="hidden" value=""/>
											<input class="ifHasChild" type="hidden" value="${accountSubject.hasChild}"/>
										</td>
										<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
									</tr>
								[/#if]
								[#if accountSubject.hasChild==0]
									<tr>
									[#if accountSubject.level>1]
										[#list 1..(accountSubject.level-1) as index]
												<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
										[/#list]
									[/#if]
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
											${accountSubject.subjectCode}
											<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
											<input type="hidden" value="${accountSubject.level}" id="level"/>
										</td>
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
										[#list 1..12 as index]
											<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForSalesIncome">
												[#list businessFlowList as businessFlow]
													[#if businessFlow.accountDateStr==index]
														[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
															${businessFlow.accountsSum}
															<input type="hidden" value="${businessFlow.accountsSum}" id="${businessFlow_index}_accountsSum" name="sumAmount"/>
														[/#if]
													[/#if]
												[/#list]
											</td>
										[/#list]
										<td class="trtotalSumForSalesIncome" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
											<span class="spantrtotalSum"></span><!--Grand Total  -->
											<input class="iptrtotalSum" type="hidden" value=""/>
										</td>
										<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
									</tr>
								[/#if]
							[/#if]
						[/#list]
						<tr id="traSum" style="background-color:#E6E6FA;text-align: right" >
							<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="3">
								<input type="hidden" value="true" id="hasChild"/>
							</td>
							<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >Total</td>
							[#list 1..12 as index ]
								<td class="${index}totalMonthlyForSalesIncome" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
									<span id="${ads}_spantdtotalSum_Cost"></span>
									<input id="${ads}_iptdtotalSum_Cost" type="hidden" value=""/>
								</td>
							[/#list]
							<td id="totalSum_SalesIncome" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
							<td style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">100%</td> <!--修改过的地方  -->
						</tr>
					[/#if]
					
					[#if flag==4||flag==""]
				<thead>
					<tr>
						<td colspan="17">
							<h5 style="text-align:center;magin-bottom:20px;">${year}- Tour Cost Summary ( Jan.- Dec. )</h5>
						</tr>
					</tr>
					<tr>
						<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
						<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
						<th width="10%" colspan="2" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Tour Cost</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jan</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Feb</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Mar</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Apr</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">May</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jun</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jul</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Aug</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Sep</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Oct</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Nov</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Dec</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Total</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Percent</th>
					</tr>
					</thead>
					<tbody>
						[#list  accountSubjectList as accountSubject]
							[#if accountSubject.subjectType==4]
								[#if accountSubject.hasChild==1]
									<tr id="traSum" style="background:#E6E6FA;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
										[#if accountSubject.level>1]
											[#list 1..(accountSubject.level-1) as index]
												<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
											[/#list]
										[/#if]
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
											${accountSubject.subjectCode}
											<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
											<input type="hidden" value="${accountSubject.level}" id="level"/>
										</td>
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
										[#list 1..12 as index]
											<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyTourCost">
												[#list businessFlowList as businessFlow]
													[#if businessFlow.accountDateStr==index]
														[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
															${businessFlow.accountsSum}
															<input type="hidden" value="${businessFlow.accountsSum}" name="sumAmount"/>
														[/#if]
													[/#if]
												[/#list]
											</td>
										[/#list]
										<td class="trtotalSumForTourCost" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
											<span class="spantrtotalSum"></span><!--Grand Total  -->
											<input class="iptrtotalSum" type="hidden" value=""/>
											<input class="ifHasChild" type="hidden" value="${accountSubject.hasChild}"/>
										</td>
										<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
									</tr>
								[/#if]
								[#if accountSubject.hasChild==0]
									<tr>
									[#if accountSubject.level>1]
										[#list 1..(accountSubject.level-1) as index]
												<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
										[/#list]
									[/#if]
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
											${accountSubject.subjectCode}
											<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
											<input type="hidden" value="${accountSubject.level}" id="level"/>
										</td>
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
										[#list 1..12 as index]
											<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForTourCost">
												[#list businessFlowList as businessFlow]
													[#if businessFlow.accountDateStr==index]
														[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
															${businessFlow.accountsSum}
															<input type="hidden" value="${businessFlow.accountsSum}" id="${businessFlow_index}_accountsSum" name="sumAmount"/>
														[/#if]
													[/#if]
												[/#list]
											</td>
										[/#list]
										<td class="trtotalSumForTourCost" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
											<span class="spantrtotalSum"></span><!--Grand Total  -->
											<input class="iptrtotalSum" type="hidden" value=""/>
										</td>
										<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
									</tr>
								[/#if]
							[/#if]
						[/#list]
						<tr id="traSum" style="background-color:#E6E6FA;text-align: right" >
							<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="3">
								<input type="hidden" value="true" id="hasChild"/>
							</td>
							<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >Total</td>
							[#list 1..12 as index ]
								<td class="${index}totalMonthlyForTourCost" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
									<span id="${ads}_spantdtotalSum_Cost"></span>
									<input id="${ads}_iptdtotalSum_Cost" type="hidden" value=""/>
								</td>
							[/#list]
							<td id="totalSum_TourCost" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
							<td style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">100%</td> <!--修改过的地方  -->
						</tr>
					[/#if]
					
			[#if flag==1||flag==""]
				<thead>
					<tr>
						<td colspan="17">
							<h5 style="text-align:center;magin-bottom:20px;">${year}- Gross Profit Summary ( Jan.- Dec. )</h5>
						</tr>
					</tr>
					<tr>
						<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
						<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
						<th width="10%" colspan="2" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Gross Profit</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jan</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Feb</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Mar</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Apr</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">May</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jun</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jul</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Aug</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Sep</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Oct</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Nov</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Dec</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Total</th>
						<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Percent</th>
					</tr>
					</thead>
					<tbody>
						[#list  accountSubjectList as accountSubject]
							[#if accountSubject.subjectType==1]
								[#if accountSubject.hasChild==1]
									<tr id="traSum" style="background:#E6E6FA;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
										[#if accountSubject.level>1]
											[#list 1..(accountSubject.level-1) as index]
												<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
											[/#list]
										[/#if]
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
											${accountSubject.subjectCode}
											<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
											<input type="hidden" value="${accountSubject.level}" id="level"/>
										</td>
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
										[#list 1..12 as index]
											<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForIncome">
												[#list businessFlowList as businessFlow]
													[#if businessFlow.accountDateStr==index]
														[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
															${businessFlow.accountsSum}
															<input type="hidden" value="${businessFlow.accountsSum}" name="sumAmount"/>
														[/#if]
													[/#if]
												[/#list]
											</td>
										[/#list]
										<td class="trtotalSumForIncome" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
											<span class="spantrtotalSum"></span><!--Grand Total  -->
											<input class="iptrtotalSum" type="hidden" value=""/>
											<input class="ifHasChild" type="hidden" value="${accountSubject.hasChild}"/>
										</td>
										<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
									</tr>
								[/#if]
								[#if accountSubject.hasChild==0]
									<tr>
									[#if accountSubject.level>1]
										[#list 1..(accountSubject.level-1) as index]
												<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
										[/#list]
									[/#if]
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
											${accountSubject.subjectCode}
											<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
											<input type="hidden" value="${accountSubject.level}" id="level"/>
										</td>
										<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
										[#list 1..12 as index]
											<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForIncome">
												[#list businessFlowList as businessFlow]
													[#if businessFlow.accountDateStr==index]
														[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
															${businessFlow.accountsSum}
															<input type="hidden" value="${businessFlow.accountsSum}" id="${businessFlow_index}_accountsSum" name="sumAmount"/>
														[/#if]
													[/#if]
												[/#list]
											</td>
										[/#list]
										<td class="trtotalSumForIncome" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
											<span class="spantrtotalSum"></span><!--Grand Total  -->
											<input class="iptrtotalSum" type="hidden" value=""/>
										</td>
										<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
									</tr>
								[/#if]
							[/#if]
						[/#list]
						<tr id="traSum" style="background-color:#E6E6FA;text-align: right" >
							<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="3">
								<input type="hidden" value="true" id="hasChild"/>
							</td>
							<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >Total</td>
							[#list 1..12 as index ]
								<td class="${index}totalMonthlyForIncome" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
									<span id="${ads}_spantdtotalSum_Cost"></span>
									<input id="${ads}_iptdtotalSum_Cost" type="hidden" value=""/>
								</td>
							[/#list]
							<td id="totalSum_Income" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
							<td style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">100%</td> <!--修改过的地方  -->
						</tr>
					[/#if]
					[#if flag==2||flag==""]
					<thead>
						<tr>
							<td colspan="17">
								<h5 style="text-align:center;magin-bottom:20px;">${year}- Expense Summary ( Jan.- Dec. )</h5>
							</tr>
						</tr>
						<tr>
							<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
							<th width="3%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;"></th>
							<th width="10%" colspan="2" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Expense</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jan</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Feb</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Mar</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Apr</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">May</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jun</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Jul</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Aug</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Sep</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Oct</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Nov</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Dec</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Total</th>
							<th width="6%" style="border-bottom:1px solid #ccc;height:40px;background:#99ccff;font-size:12px;">Percent</th>
						</tr>
				</thead>
					[#list  accountSubjectList as accountSubject]
						[#if accountSubject.subjectType==2]
							[#if accountSubject.hasChild==1]
								<tr id="traSum" style="background:#E6E6FA;">
									[#if accountSubject.level>1]
										[#list 1..(accountSubject.level-1) as index]
											<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
										[/#list]
									[/#if]
									<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" class="ifHasChild">
										${accountSubject.subjectCode}
										<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
										<input type="hidden" value="${accountSubject.level}" id="level"/>
									</td>
									<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
									[#list 1..12 as index]
										<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForCost">
											[#list businessFlowList as businessFlow]
												[#if businessFlow.accountDateStr==index]
													[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
														${businessFlow.accountsSum}
														<input type="hidden" value="${businessFlow.accountsSum}" class="preAmount" name="sumAmount"/>
													[/#if]	
												[/#if]
											[/#list]
										</td>
									[/#list]
									<td class="trtotalSumForCost" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
										<span class="spantrtotalSum"></span><!--Grand Total  -->
										<input class="iptrtotalSum" type="hidden" value=""/>
										<input name="ifHasChild" type="hidden" value="1">
									</td>
									<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
								</tr>
							[/#if]
							[#if accountSubject.hasChild==0]
								<tr>
								[#if accountSubject.level>1]
									[#list 1..(accountSubject.level-1) as index]
											<td style="width:2%;text-align: left;" ></td>
									[/#list]
								[/#if]
									<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="ifHasChild">
										${accountSubject.subjectCode}
										<input type="hidden" value="${accountSubject.hasChild}" id="hasChild"/>
										<input type="hidden" value="${accountSubject.level}" id="level"/>
									</td>
									<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  colspan="${4-accountSubject.level}">${accountSubject.subjectName}</td>
									[#list 1..12 as index]
										<td style="text-align:right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"  class="${index}monthlyForCost">
											[#list businessFlowList as businessFlow]
												[#if businessFlow.accountDateStr==index]
													[#if accountSubject.accountSubjectId==businessFlow.accountSubjectId]
														${businessFlow.accountsSum}
														<input type="hidden" value="${businessFlow.accountsSum}" id="${businessFlow_index}_accountsSum" class="preAmount" name="sumAmount"/>
													[/#if]
												[/#if]
											[/#list]
										</td>
									[/#list]
									<td class="trtotalSumForCost" style="background-color:#E6E6FA;text-align: right;font-weight:3px;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >
										<span class="spantrtotalSum"></span><!--Grand Total  -->
										<input class="iptrtotalSum" type="hidden" value=""/>
										<input name="ifHasChild" type="hidden" value="0">
									</td>
									<td id="" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;"></td>
								</tr>
							[/#if]
						[/#if]
					[/#list]
					<tr id="traSum" style="background-color:#E6E6FA;text-align: right" >
						<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="3">
							<input type="hidden" value="true" id="hasChild"/>
						</td>
						<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >Total</td>
						[#list 1..12 as index ]
							<td class="${index}totalMonthlyForCost" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
								<span id="${ads}_spantdtotalSum_Cost"></span>
								<input id="${ads}_iptdtotalSum_Cost" type="hidden" value=""/>
							</td>
						[/#list]
						<td id="totalSum_Cost" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
						<td style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">100%</td> <!--修改过的地方  -->
					</tr>
					[#if flag==""]
					<tr id="traSum" style="background-color:#E6E6FA;text-align: right" >
						<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" colspan="3">
							<input type="hidden" value="true" id="hasChild"/>
						</td>
						<td style="width:2%;text-align: left;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" >Profit</td>
						[#list 1..12 as index ]
							<td class="${index}totalMonthlyForProfit" style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">
								<span id="${ads}_spantdtotalSum_Profit"></span>
								<input id="${ads}_iptdtotalSum_Profit" type="hidden" value=""/>
							</td>
						[/#list]
						<td id="totalSum_Profit" style="background-color:#E6E6FA;text-align: right;border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;" ></td>
						<td style="border-left:1.25px solid #ccc;border-bottom:1.25px solid #ccc;font-size:10px;height:20px;line-height:20px;">100%</td> <!--修改过的地方  -->
					</tr>
					[/#if]
					[/#if]
			    </tbody>
		</table>
		</div>
	</div>
</div>
<script src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/admin/js/common.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
	$(document).ready(function () {
    	sumCostTotalForRow();
    	sumIncomeTotalForRow();
    	sumIncomeTotalForCol();
    	sumCostTotalForCol();
    	sumSalesIncomeTotalForCol();
    	sumTourCostTotalForCol();
    	getProfit();
    	
    	$(".trtotalSumForCost").each(function(){
    		var hasChild = $(this).siblings(".ifHasChild").find("input[id='hasChild']").val();
    		if($(this).html()=="0.00"&&hasChild!=1){
    			$(this).parent().remove();
    		}else if($(this).html()=="0.00"&&hasChild==1){
    			$(this).html("");
    			$(this).next().html("");
    		}
    	});
    	
    	$(".trtotalSumForIncome").each(function(){
    		var hasChild = $(this).siblings(".ifHasChild").find("input[id='hasChild']").val();
    		if($(this).html()=="0.00"&&hasChild!=1){
    			$(this).parent().remove();
    		}else if($(this).html()=="0.00"&&hasChild==1){
    			$(this).html("");
    			$(this).next().html("");
    		}
    	});
    	
    	$(".trtotalSumForTourCost").each(function(){
    		var hasChild = $(this).siblings(".ifHasChild").find("input[id='hasChild']").val();
    		if($(this).html()=="0.00"&&hasChild!=1){
    			$(this).parent().remove();
    		}else if($(this).html()=="0.00"&&hasChild==1){
    			$(this).html("");
    			$(this).next().html("");
    		}
    	});
    	
    	$(".trtotalSumForSalesIncome").each(function(){
    		var hasChild = $(this).siblings(".ifHasChild").find("input[id='hasChild']").val();
    		if($(this).html()=="0.00"&&hasChild!=1){
    			$(this).parent().remove();
    		}else if($(this).html()=="0.00"&&hasChild==1){
    			$(this).html("");
    			$(this).next().html("");
    		}
    	});
    });
    
    //行合计(income)
    function sumCostTotalForRow(){
	    $(".trtotalSumForIncome").each(function(){
	    	var total = 0;
	    	$(this).siblings().each(function(){
	    		if($(this).find("input").length!=0){
	    			if($(this).find("input").attr("name")=="sumAmount"){
		    			var valueMonthly = parseFloat($(this).find("input").val());
		    			total+=valueMonthly;
	    			}
	    		}
	    	});
	    	$(this).html(total.toFixed(2));
	    });
	    
	    $(".trtotalSumForSalesIncome").each(function(){
	    	var total = 0;
	    	$(this).siblings().each(function(){
	    		if($(this).find("input").length!=0){
	    			if($(this).find("input").attr("name")=="sumAmount"){
		    			var valueMonthly = parseFloat($(this).find("input").val());
		    			total+=valueMonthly;
	    			}
	    		}
	    	});
	    	$(this).html(total.toFixed(2));
	    });
	    
    }
    
    //行合计(cost)
    function sumIncomeTotalForRow(){
	    $(".trtotalSumForCost").each(function(){
	    	var total = 0;
	    	$(this).siblings().each(function(){
	    		if($(this).find("input").length!=0){
	    			if($(this).find("input").attr("name")=="sumAmount"){
		    			var valueMonthly = parseFloat($(this).find("input").val());
		    			total+=valueMonthly;
	    			}
	    		}
	    	});
	    	$(this).html(total.toFixed(2));
	    });
	    
	    $(".trtotalSumForTourCost").each(function(){
	    	var total = 0;
	    	$(this).siblings().each(function(){
	    		if($(this).find("input").length!=0){
	    			if($(this).find("input").attr("name")=="sumAmount"){
		    			var valueMonthly = parseFloat($(this).find("input").val());
		    			total+=valueMonthly;
	    			}
	    		}
	    	});
	    	$(this).html(total.toFixed(2));
	    });
    }
    
    //列合计(salesincome)
    function sumSalesIncomeTotalForCol(){
    	//income
    	$("td[class$='totalMonthlyForSalesIncome']").each(function(){
    		str = $(this).attr("class");
    		if(str.length==27){
    			str = str.substring(0,1);
    		}else if(str.length==28){
    			str = str.substring(0,2);
    		}
    		var classStr=str+"monthlyForSalesIncome";
    		totalMonth = 0;
    		$("."+classStr).each(function(){
    			if($(this).find("input").length!=0){
	    			monthlyValue = parseFloat($(this).find("input").val());
	    			totalMonth+=monthlyValue;
    			}
    		});
    		$(this).html(totalMonth.toFixed(2));
    	});
    	
    	//计算总和及百分比(income)
    	var totalYearlyForIncome = 0;
    	$(".trtotalSumForSalesIncome").each(function(){
    		str = $(this).html();
    		totalYearlyForIncome+=parseFloat(str);
    	});
    	$("#totalSum_SalesIncome").html(totalYearlyForIncome.toFixed(2));
    	
    	$(".trtotalSumForSalesIncome").each(function(){
    		onceValue = parseFloat($(this).html());
    		str = parseFloat($("#totalSum_SalesIncome").html());
    		if(str!=0.00){
	    		percent = ((onceValue/str)*100).toFixed(2)+"%";
	    		$(this).next().html(percent);
    		}
    	});
    	
    }
    
    //列合计(income)
    function sumIncomeTotalForCol(){
    	//income
    	$("td[class$='totalMonthlyForIncome']").each(function(){
    		str = $(this).attr("class");
    		if(str.length==22){
    			str = str.substring(0,1);
    		}else if(str.length==23){
    			str = str.substring(0,2);
    		}
    		var classStr=str+"monthlyForIncome";
    		totalMonth = 0;
    		$("."+classStr).each(function(){
    			if($(this).find("input").length!=0){
	    			monthlyValue = parseFloat($(this).find("input").val());
	    			totalMonth+=monthlyValue;
    			}
    		});
    		$(this).html(totalMonth.toFixed(2));
    	});
    	
    	//计算总和及百分比(income)
    	var totalYearlyForIncome = 0;
    	$(".trtotalSumForIncome").each(function(){
    		str = $(this).html();
    		totalYearlyForIncome+=parseFloat(str);
    	});
    	$("#totalSum_Income").html(totalYearlyForIncome.toFixed(2));
    	
    	$(".trtotalSumForIncome").each(function(){
    		onceValue = parseFloat($(this).html());
    		str = parseFloat($("#totalSum_Income").html());
    		if(str!=0.00){
	    		percent = ((onceValue/str)*100).toFixed(2)+"%";
	    		$(this).next().html(percent);
    		}
    	});
    	
    }
    
     //列合计(tourcost)
    function sumTourCostTotalForCol(){
    	//income
    	$("td[class$='totalMonthlyForTourCost']").each(function(){
    		str = $(this).attr("class");
    		if(str.length==24){
    			str = str.substring(0,1);
    		}else if(str.length==25){
    			str = str.substring(0,2);
    		}
    		var classStr=str+"monthlyForTourCost";
    		totalMonth = 0;
    		$("."+classStr).each(function(){
    			if($(this).find("input").length!=0){
	    			monthlyValue = parseFloat($(this).find("input").val());
	    			totalMonth+=monthlyValue;
    			}
    		});
    		$(this).html(totalMonth.toFixed(2));
    	});
    	
    	//计算总和及百分比(income)
    	var totalYearlyForCost = 0;
    	$(".trtotalSumForTourCost").each(function(){
    		str = $(this).html();
    		totalYearlyForCost+=parseFloat(str);
    	});
    	$("#totalSum_TourCost").html(totalYearlyForCost.toFixed(2));
    	
    	$(".trtotalSumForTourCost").each(function(){
    		onceValue = parseFloat($(this).html());
    		str = parseFloat($("#totalSum_TourCost").html());
    		if(str!=0.00){
	    		percent = ((onceValue/str)*100).toFixed(2)+"%";
	    		$(this).next().html(percent);
    		}
    	});
    	
    };
    
     //列合计(cost)
    function sumCostTotalForCol(){
    	//income
    	$("td[class$='totalMonthlyForCost']").each(function(){
    		str = $(this).attr("class");
    		if(str.length==20){
    			str = str.substring(0,1);
    		}else if(str.length==21){
    			str = str.substring(0,2);
    		}
    		var classStr=str+"monthlyForCost";
    		totalMonth = 0;
    		$("."+classStr).each(function(){
    			if($(this).find("input").length!=0){
	    			monthlyValue = parseFloat($(this).find("input").val());
	    			totalMonth+=monthlyValue;
    			}
    		});
    		$(this).html(totalMonth.toFixed(2));
    	});
    	
    	//计算总和及百分比(income)
    	var totalYearlyForCost = 0;
    	$(".trtotalSumForCost").each(function(){
    		str = $(this).html();
    		totalYearlyForCost+=parseFloat(str);
    	});
    	$("#totalSum_Cost").html(totalYearlyForCost.toFixed(2));
    	
    	$(".trtotalSumForCost").each(function(){
    		onceValue = parseFloat($(this).html());
    		str = parseFloat($("#totalSum_Cost").html());
    		if(str!=0.00){
	    		percent = ((onceValue/str)*100).toFixed(2)+"%";
	    		$(this).next().html(percent);
    		}
    	});
    	
    };
    
    //计算利润
    function getProfit(){
    	for(var i=1;i<13;i++){
    		incomeClass = "."+i+"totalMonthlyForIncome";
    		income = parseFloat($(incomeClass).html());
    		costClass = "."+i+"totalMonthlyForCost";
    		cost = parseFloat($(costClass).html());
    		profit = (income-cost).toFixed(2);
    		profitClass = "."+i+"totalMonthlyForProfit";
    		$(profitClass).html(profit);
    	}
    	$("#totalSum_Profit").html((parseFloat($("#totalSum_Income").html())-parseFloat($("#totalSum_Cost").html())).toFixed(2));
    }
    
    
    $("#analyButton").click(function(){
    	$("#formId").attr("action","analysisBusinessFlow.jhtml");
    	$("#formId").submit();
    });
    
    $("#searchButton").click(function(){
    	$("#formId").attr("action","searchbusinessFlowOfGlobal.jhtml");
    	$("#formId").submit();
    })
    
    $("#exportButton").click(function(){
    	$("#formId").attr("action","exportBusinessFlowOfGlobal.jhtml");
    	$("#formId").submit();
    });
    
		$("#printButton").click(function(){
			$("#content").printArea();	
		});
</script>
</body>
</html>
