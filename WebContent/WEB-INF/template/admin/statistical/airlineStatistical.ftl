[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
            <h3>Statistics</h3>
            <div class="new">
	        	<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	        </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Statistics</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
					<div class="block-flat">
						<div class="tab-container">
							<div class="tab-content">
								<input type="hidden" value="${so.time}${so.year}" id="time"/>
								<input type="hidden" value="${role}" id="role"/>
								<input type="hidden" value="${so.agentId}" id="agentId"/>
								<!--<label>
					            	<select  class="select2" id="year" onChange="bookingPeerYear()">
										[#list constant.BRAND_YEAR as val]
											<option value="${val}"[#if "${year==val}"]selected="selected"[/#if]>${val}</option>
										[/#list]
									</select>
								</label>
								<label>
					            	<select  class="select2" id="deptId" onChange="sear()">
										<option value="">Select Office</option>
										[#list dept as dept]
											<option value="${dept.deptId}" [#if "${dept.deptId=so.deptId}"]selected="selected"[/#if]>${dept.deptName}</option>
										[/#list]
									</select>
								</label>
								-->
								<!--	<label>
									<input name="companyId" type="hidden" id="userSelect" style="width:100%" doName="4808" required="" onChange="sear()"/>
										<input name="company" type="hidden">
								</label>
								-->
								
								<label>Departure Date:
									<input type="text" id="arrival_beginningDate" size="14"  placeholder="Beginning Date." value="${so.arrivalBeginningDate?string("yyyy-MM-dd")}" />
								</label>
								<label>to:
									<input type="text" id="arrival_endingDate" size="14"  placeholder="Ending Date." value="${so.arrivalEndingDate?string("yyyy-MM-dd")}" />
								</label>
								<input id="tlsum" value="${statisticalList?size}" type="hidden"/>
								<input class="submit-btn"  type="submit" value="Search" onClick="sear()">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                     <tr>
                                 	   <th>Office</th>
	                                    <th>Qty</th>
	                                    <th>Total Profit</th>
	                                    <th>Airline</th>
	                                    <th>BI</th>
	                                    <th>BD</th>
	                                    <th>PI</th>
	                                    <th>PD</th>
	                                    <th>EI</th>
	                                    <th>ED</th>
	                                    <th>Ticket Total</th>
	                                    <th>Net</th>
	                                    <th>Total</th>
	                                    <th>Profit</th>
	                                </tr>
	                                </thead>
	                                <tbody>
                                	 [#list statisticalList as st]
	                                    <tr [#if st_index%2==1] style="background-color:#fff"[/#if][#if st_index%2==0] style="background-color:#EFF8FE"[/#if]>
	                                        <td rowspan="${st.flightList.size()+1}" style="text-align:center;vertical-align:middle">${st.deptName}</td>
	                                        <td rowspan="${st.flightList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${st_index}">${st.sum} [#assign QtySum = (st.sum)?number/]</td>
	                                        <td rowspan="${st.flightList.size()+1}" style="text-align:center;vertical-align:middle" id="sumb${st_index}">${st.profit} [#assign TotalProfitSum = (st.profit)?number/]</td>
	                                        <input id="zlsum${st_index}" value="${st.flightList?size}" type="hidden"/>
	                                    </tr>
	                                   [#list st.flightList as flight]
	                                   	<tr>
	                                        <!-- <td><a href="javascript:;" onclick="viewInfor('${flight.airline}','${flight.deptId}')">${flight.airline}</a></td> -->
	                                        <td>${flight.airline}</td>
	                                        <td>${flight.BI} [#assign BISum = (BISum+flight.BI)?number/]</td>
	                                        <td>${flight.BD} [#assign BDSum = (BDSum+flight.BD)?number/]</td>
	                                        <td>${flight.PI} [#assign PISum = (PISum+flight.PI)?number/]</td>
	                                        <td>${flight.PD} [#assign PDSum = (PDSum+flight.PD)?number/]</td>
	                                        <td>${flight.EI} [#assign EISum = (EISum+flight.EI)?number/]</td>
	                                        <td>${flight.ED} [#assign EDSum = (EDSum+flight.ED)?number/]</td>
	                                        <td> [#assign TicketSum = (flight.BI+flight.BD+flight.PI+flight.PD+flight.EI+flight.ED)?number/] ${TicketSum}</td>
	                                        <td>${flight.net} [#assign NetSum = (NetSum+flight.net)?number/]</td>
	                                        <td>${flight.operatorFee} [#assign TotalFeeSum = (TotalFeeSum+flight.operatorFee)?number/]</td>
	                                        <td>${flight.amount-flight.operatorFee} [#assign ProfitSum = (ProfitSum+(flight.amount-flight.operatorFee))?number/]</td>
	                                    </tr>
	                                   [/#list]
	                                [/#list]
                                    </tbody>
                                    <tfoot style="font-size:14px;font-weight:bold;">
                                    	<tr>
	                                 	   <td>Total:</td>
		                                    <td>${QtySum}</td>
		                                    <td>${TotalProfitSum}</td>
		                                    <td></td>
		                                    <td>${BISum}</td>
		                                    <td>${BDSum}</td>
		                                    <td>${PISum}</td>
		                                    <td>${PDSum}</td>
		                                    <td>${EISum}</td>
		                                    <td>${EDSum}</td>
		                                    <td>${QtySum}</td>
		                                    <td>${NetSum}</td>
		                                    <td>${TotalFeeSum}</td>
		                                    <td>${ProfitSum}</td>
	                                	</tr>
                                    </tfoot>
                                </table>
						</div>
		</div>
    </div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        $("#arrival_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#arrival_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
    });
    function sear() {
			var role=$("#role").val();
        	var arrivalBeginningDate=$("#arrival_beginningDate").val();
        	var arrivalEndingDate=$("#arrival_endingDate").val();
        	
        	location.href="${base}/admin/statistical/airlineStatistical.jhtml?arrivalBeginningDate="+arrivalBeginningDate+"&arrivalEndingDate="+arrivalEndingDate;
		}
		
		//查看详情
		function viewInfor(a){
			var role=$("#role").val();
        	var arrivalBeginningDate=$("#arrival_beginningDate").val();
        	var arrivalEndingDate=$("#arrival_endingDate").val();
        	var airline=a;
    		location.href="${base}/admin/statistical/ticketList.jhtml?airline="+airline+"&arrivalBeginningDate="+arrivalBeginningDate+"&arrivalEndingDate="+arrivalEndingDate;
		}
		//获取两位小数点
	function changeTwoDecimal(x){
			var f_x = parseFloat(x);
			if (isNaN(f_x))
			{
				//alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x*100)/100;
		
			return f_x;
		}
</script>
</body>
</html>
