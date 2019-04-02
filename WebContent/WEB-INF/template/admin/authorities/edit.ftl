[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">

    <title>${message("admin.admin.list")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>${message("admin.admin.list")}</h2>
            <ol class="breadcrumb">
                <li><a href="#">${message("admin.path.index")}</a></li>
                <li><a href="#">Role</a></li>
                <li class="active">${message("admin.admin.list")}</li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>${message("admin.admin.edit")}</h3>
                        </div>
                        <div class="content">
                        	<form class="form-horizontal group-border-dashed" action="[@spring.url '/admin/roles/update.jhtml'/]" style="border-radius: 0px;" method="post">
                                <input type="hidden" name="id" value="${role.id}"/>
                               <div class="form-group">
					                <label class="col-sm-3 control-label">Name:</label>
					                <div class="col-sm-6">
					                  	<input type="text" name="name" value="${role.name}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
					                </div>
              					</div>
              					 <div class="form-group">
					                <label class="col-sm-3 control-label">Description:</label>
					                <div class="col-sm-6">
					                  	<input type="text" name="description" value="${role.description}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
					                </div>
              					</div>
              					<!--
              					<div class="form-group">
	                                <label class="col-sm-3 control-label">设置:</label>
	                                <div class="col-sm-6">
                                       	<div class="radio">
                                            <label>
                                            	<input type="checkbox" name="isSystem" value="true" [#if role.isSystem] checked="checked"[/#if] class="icheck"/>是否内置
                                                <input type="hidden" name="isSystem" value="false" />
                                            </label>
                                        </div>
	                                </div>
	                            </div>
	                            -->
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Inquiry:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:enquirys" class="icheck"/>Inquiries(All)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:enquirysDraft" class="icheck"/>Draft(All)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:enquirysOp" class="icheck"/>Inquiry List(All)</label>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Booking:</label>
	                                <div class="col-sm-6">
	                                	<div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:addBooking" class="icheck"/>Add Booking(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:booking" class="icheck"/>Booking List(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:orders" class="icheck"/>Item List(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:agencyOrders" class="icheck"/>Item List(Agency)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:webBooking" class="icheck"/>Item List(Web)</label>
	                                    </div>
	                                    <!--<div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:sinord" class="icheck"/>非团订单管理</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:peerord" class="icheck"/>同行订单管理</label>
	                                    </div>
	                                    -->
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:ordGroup" class="icheck"/>View Booking(Group)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:ordOffice" class="icheck"/>View Booking(Office)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:ordRegion" class="icheck"/>View Booking(Region)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:ordCEO" class="icheck"/>View Booking(CEO)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupItem" class="icheck"/>Item List(Group)</label>
	                                    </div>
										<div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:officeItem" class="icheck"/>Item List(Office)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:regionItem" class="icheck"/>Item List(Region)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:CEOItem" class="icheck"/>Item List(CEO)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:outboundItem" class="icheck"/>Item List(outbound)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:agencyItem" class="icheck"/>Item List(Agency)</label>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Tour:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupTour" class="icheck"/>Booking(Booking-OP)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupNonTour" class="icheck"/>Booking(Other Booking-Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tour" class="icheck"/>Tour(OP)</label>
	                                    </div>
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:singleTour" class="icheck"/>Tour(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourAll" class="icheck"/>Tour List(All)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourAgent" class="icheck"/>Tour List(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourGroup" class="icheck"/>Tour List(Group)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourOffice" class="icheck"/>Tour List(Office)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourRegion" class="icheck"/>Tour List(Region)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourCEO" class="icheck"/>Tour List(CEO)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billEntry" class="icheck"/>Billing(OP)</label>
	                                    </div>
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billEurope" class="icheck"/>Billing(Europe)</label>
	                                    </div>
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billGroup" class="icheck"/>Billing(Group)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:flight" class="icheck"/>Flight List</label>
	                                    </div>
	                                      <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:airflight" class="icheck"/>Air Ticket List</label>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Product:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:product" class="icheck"/>Product</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:brand" class="icheck"/>Brand</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourType" class="icheck"/>Product Type</label>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Accounting:</label>
	                                <div class="col-sm-6">
                                		<div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:Accairflight" class="icheck"/>Air Ticket Audit(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:Agentairflight" class="icheck"/>Air Ticket Audit(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billAgent" class="icheck"/>Bill Audit(Agent)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billAgentGroup" class="icheck"/>Agent Bill Audit(Group)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billAcc" class="icheck"/>Bill Audit(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:payment" class="icheck"/>Booking Receivable(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:closeOrd" class="icheck"/>Booking Settlement(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:account" class="icheck"/>Checking Accounts(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:accountOffice" class="icheck"/>Account Current(Office)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:accountRegion" class="icheck"/>Account Current(Region)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:accountCEO" class="icheck"/>Account Current(CEO)</label>
	                                    </div>
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupBillAcc" class="icheck"/>Bill Audit(Group Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupPayment" class="icheck"/>Booking Receivable(Group Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupCloseOrd" class="icheck"/>Booking Settlement(Group Account)</label>
	                                    </div>
	                                       <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:billAuditEurope" class="icheck"/>Bill Audit(Europe)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourSettle" class="icheck"/>Tour Settle(AccOP)</label>
	                                    </div>
	                                </div>
	                            </div>
								<div class="form-group">
									<label class="col-sm-3 control-label">Statistical:</label>
									<div class="col-sm-6">
										<!--<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:bookingClientsAgent" class="icheck"/>Booking Clients(Agent)</label>
										</div>-->
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:bookingClientsOP" class="icheck"/>Booking Clients(OP)</label>
										</div>
										<!--<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:bookingClientsOffice" class="icheck"/>Booking Clients(Office)</label>
										</div>
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:bookingClientsRegion" class="icheck"/>Booking Clients(Region)</label>
										</div>-->
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:bookingClientsCEO" class="icheck"/>Booking Clients(CEO Region Office)</label>
										</div>
										<!--<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:arrivalClientsAgent" class="icheck"/>Arrival Clients(Agent)</label>
										</div>-->
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:arrivalClientsOP" class="icheck"/>Arrival Clients(OP)</label>
										</div>
										<!--<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:arrivalClientsOffice" class="icheck"/>Arrival Clients(Office)</label>
										</div>
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:arrivalClientsRegion" class="icheck"/>Arrival Clients(Region)</label>
										</div>-->
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:arrivalClientsCEO" class="icheck"/>Arrival Clients(CEO Region Office)</label>
										</div>
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:airTicketClients" class="icheck"/>Air Ticket</label>
										</div>
										<div class="radio">
											<label><input type="checkbox" name="authority" value="admin:StatisticReports" class="icheck"/>Statistic Reports</label>
										</div>
									</div>
								</div>
								<div class="form-group">
	                                <label class="col-sm-3 control-label">Customer List:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:customer" class="icheck"/>Customer List</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:phoneRecords" class="icheck"/>Phone Records</label>
	                                    </div>
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:phoneRecordsOffice" class="icheck"/>Office Phone Records</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:phoneRecordsRegion" class="icheck"/>Region Phone Records</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:phoneRecordsCEO" class="icheck"/>CEO Phone Records</label>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Information:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:groupline" class="icheck"/>Products(Admin)</label>
	                                    </div>
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:grouplineAgency" class="icheck"/>Products(Agency)</label>
	                                    </div>
	                                    <!--
	                                    <div class="radio">
	                                     	<label><input type="checkbox" name="authority" value="admin:itinerary" class="icheck"/>确认单管理</label>
	                                    </div>
	                                    -->
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:tourType" class="icheck"/>Tour Types(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:supplier" class="icheck"/>Operators(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:hotel" class="icheck"/>Hotels(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:country" class="icheck"/>Countries(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:state" class="icheck"/>States(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:city" class="icheck"/>Cities(Admin)</label>
	                                    </div>
                                    	<div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:vender" class="icheck"/>Suppliers / Agencies(Account)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:currencyType" class="icheck"/>Currency(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:news" class="icheck"/>News</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:optional" class="icheck"/>Optional Excurision</label>
	                                    </div>
	                                </div>
	                            </div>
	                             <div class="form-group">
	                                <label class="col-sm-3 control-label">Report Form:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:subjectSettings" class="icheck"/>Subject Settings</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:subjectManage" class="icheck"/>Subject Manage</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:reportManage" class="icheck"/>Report Manage</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:viewReportCEO" class="icheck"/>View Report(CEO)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:viewReport" class="icheck"/>View Report</label>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-3 control-label">Settings:</label>
	                                <div class="col-sm-6">
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:company" class="icheck"/>Office(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:roles" class="icheck"/>Role(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:user" class="icheck"/>User(Admin)</label>
	                                    </div>
	                                    <!--
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:password" class="icheck"/>Password(All)</label>
	                                    </div>
	                                    -->
	                                     <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:team" class="icheck"/>Team(Admin)</label>
	                                    </div>
	                                    <div class="radio">
	                                    	<label><input type="checkbox" name="authority" value="admin:setRegion" class="icheck"/>Region(Admin)</label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:CEO" class="icheck"/>CEO</label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:Region" class="icheck"/>Region</label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:Office" class="icheck"/>Office</label>
	                                    </div>
	                                     <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:Group" class="icheck"/>Group </label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:Agent" class="icheck"/>Agent </label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="order:retail" class="icheck"/>retail</label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="order:wholeSale" class="icheck"/>wholeSale</label>
	                                    </div>
	                                     <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:nexusholidays" class="icheck"/>nexusholidays</label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:showbtn" class="icheck"/>Showbtn</label>
	                                    </div>
	                                    <div class="radio color-warning">
	                                    	<label><input type="checkbox" name="authority" value="admin:editCustomerName" class="icheck"/>edit customerName</label>
	                                    </div>
	                                     <div class="radio color-danger">
	                                    	<label><input type="checkbox" name="authority" value="admin:admin" class="icheck"/>admin</label>
	                                    </div>
	                                </div>
	                            </div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
										<button type="submit" style="margin-left:336px;" class="btn btn-primary">Save</button>
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
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        [#list role.authorities as au]
        	$("[name = authority][value = '${au}']:checkbox").attr("checked", true);
        [/#list]
        App.init();
    });
</script>
</body>
</html>
