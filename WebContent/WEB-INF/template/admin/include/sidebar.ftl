<div class="cl-sidebar" data-position="right" data-step="1" data-intro="<strong>Fixed Sidebar</strong> <br/> It adjust to your needs." >
    <div class="cl-toggle"><i class="fa fa-bars"></i></div>
    <div class="cl-navblock">
        <div class="menu-space">
            <div class="content">
                <div class="side-user">
                    <div class="avatar"><img src="[@spring.url '/resources/images/userImage/'/][@shiro.principal property="userImage"/]-1.jpg" alt="Avatar" /></div>
                    <div class="info">
                        <a href="#">[@shiro.principal /]</a>
                        <img src="[@spring.url '/resources/images/state_online.png'/]" alt="Status" /> <span>Online</span>
                    </div>
                </div>
                <ul class="cl-vnavigation">
					[#list ["admin:admin","admin:enquirys","admin:enquirysDraft","admin:enquirysOp"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-smile-o"></i><span>Inquiry</span></a>
							<ul class="sub-menu">
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:enquirys"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="201"] class="active"[/#if]><a href="[@spring.url '/admin/enquirys/list.jhtml'/]"> Inquiries</a></li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:enquirysDraft"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="202"] class="active"[/#if]><a href="[@spring.url '/admin/enquirys/draftList.jhtml'/]"> Draft</a></li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:enquirysOp"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="203"] class="active"[/#if]><a href="[@spring.url '/admin/enquirys/opList.jhtml'/]"><!-- <span class="label label-primary pull-right">New</span> --> List</a></li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:enquirys","admin:enquirysDraft","admin:enquirysOp"] as permission]
						[@shiro.hasPermission name = permission]
								</ul>
							</li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:booking","admin:orders","admin:ordOffice","admin:ordRegion","admin:ordCEO","admin:groupItem","admin:regionItem","admin:officeItem","admin:CEOItem","admin:outboundItem"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-list-alt"></i><span>Booking</span></a>
								<ul class="sub-menu">
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					
							[@shiro.lacksPermission name = "admin:nexusholidays"]
								[#list ["admin:admin","admin:addBooking"] as permission]
									[@shiro.hasPermission name = permission]
										<li[#if menuId=="301"] class="active"[/#if]><a href="[@spring.url '/admin/orders/add.jhtml'/]">Add Booking</a></li>
										[#break /]
									[/@shiro.hasPermission]
								[/#list]
							[/@shiro.lacksPermission]
							
							[#list ["admin:admin","admin:booking"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="302"] class="active"[/#if]><a href="[@spring.url '/admin/orders/ordersTotalList.jhtml'/]" title="Agent">Agent Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:orders"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="303"] class="active"[/#if]><a href="[@spring.url '/admin/orders/list.jhtml'/]" title="Agent">Agent Item List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:agencyOrders"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="321"] class="active"[/#if]><a href="[@spring.url '/admin/orders/listAgency.jhtml'/]" title="Agency">Agency Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							<!--[#list ["admin:admin","admin:webBooking"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="322"] class="active"[/#if]><a href="[@spring.url '/admin/orders/listWeb.jhtml'/]" title="Web">Web Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]-->
							[#list ["admin:admin","admin:webBooking"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="323"] class="active"[/#if]><a href="[@spring.url '/admin/orders/listWebGroup.jhtml'/]" title="Web">Web Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
						<!--	[#list ["admin:admin","admin:booking"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="307"] class="active"[/#if]><a href="[@spring.url '/admin/orders/singleList.jhtml'/]">Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]-->
							<!--[#list ["admin:admin"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="303"] class="active"[/#if]><a href="#"><span class="label label-primary pull-right">New</span>入境订单管理</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]-->
							[#list ["admin:admin","admin:ordGroup"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="307"] class="active"[/#if]><a href="[@spring.url '/admin/orders/groupList.jhtml'/]" title="Group">Group Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:ordOffice"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="306"] class="active"[/#if]><a href="[@spring.url '/admin/orders/findAllOrderForDeptList.jhtml'/]" title="Office">Office Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:ordRegion"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="305"] class="active"[/#if]><a href="[@spring.url '/admin/orders/regionList.jhtml'/]" title="Region">Region Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:ordCEO"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="304"] class="active"[/#if]><a href="[@spring.url '/admin/orders/findAllOrderList.jhtml'/]" title="CEO">Booking List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:groupItem"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="308"] class="active"[/#if]><a href="[@spring.url '/admin/orders/itemGroupList.jhtml'/]" title="Group">Group Item List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:regionItem"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="309"] class="active"[/#if]><a href="[@spring.url '/admin/orders/itemRegionList.jhtml'/]" title="Region">Region Item List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:officeItem"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="310"] class="active"[/#if]><a href="[@spring.url '/admin/orders/itemOfficeList.jhtml'/]" title="Office">Office Item List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:CEOItem"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="311"] class="active"[/#if]><a href="[@spring.url '/admin/orders/itemCeoOrderList.jhtml'/]" title="CEO">Item List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:agencyItem"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="325"] class="active"[/#if]><a href="[@spring.url '/admin/orders/agencyGroupList.jhtml'/]" title="Group">Group Agency List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:outboundItem"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="320"] class="active"[/#if]><a href="[@spring.url '/admin/orders/viseBookingList.jhtml'/]" title="Group">Item List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
					[#list ["admin:admin","admin:booking","admin:orders","admin:ordOffice","admin:ordRegion","admin:ordCEO","admin:groupItem","admin:regionItem","admin:officeItem","admin:CEOItem","admin:outboundItem"] as permission]
						[@shiro.hasPermission name = permission]
									</ul>
								</li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
						<li><a href="#"><i class="fa fa-group"></i><span>Tour</span></a>
							<ul class="sub-menu">
					[#list ["admin:admin","admin:groupTour"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="401"] class="active"[/#if]><a href="[@spring.url '/admin/tour/list.jhtml'/]" title="Tour"> <!-- <span class="label label-primary pull-right">New</span> --> Booking</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:groupNonTour"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="405"] class="active"[/#if]><a href="[@spring.url '/admin/tour/singleOrdersList.jhtml'/]" title="SingleTour">SingleTour Booking</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:tour"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="402"] class="active"[/#if]><a href="[@spring.url '/admin/tour/tourList.jhtml'/]" title="OP">OP Tour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:tourAll"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="409"] class="active"[/#if]><a href="[@spring.url '/admin/tour/tourAllList.jhtml'/]" title="Tour">Tour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:singleTour"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="510"] class="active"[/#if]><a href="[@spring.url '/admin/tour/singleTourList.jhtml'/]" title="SingleTour">SingleTour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:tourAgent"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="410"] class="active"[/#if]><a href="[@spring.url '/admin/tour/agentTourList.jhtml'/]" title="Agent">Agent Tour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:tourGroup"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="403"] class="active"[/#if]><a href="[@spring.url '/admin/tour/groupTourList.jhtml'/]" title="Group">Group Tour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:billEntry"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="404"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/orderInfoList.jhtml'/]">Billing</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:billEurope"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="413"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/billListForEurope.jhtml'/]">Billing(Europe)</a></li>
					[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:billGroup"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="414"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/billListForGroup.jhtml'/]">Billing(Group)</a></li>
					[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:tourRegion"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="406"] class="active"[/#if]><a href="[@spring.url '/admin/tour/regionTourList.jhtml'/]" title="Region">Region Tour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[@shiro.lacksPermission name = "admin:nexusholidays"]
						[#list ["admin:admin","admin:tourOffice"] as permission]
							[@shiro.hasPermission name = permission]
								<li[#if menuId=="407"] class="active"[/#if]><a href="[@spring.url '/admin/tour/officeTourList.jhtml?isChanged=2'/]" title="Office">Office Tour List</a></li>
								[#break /]
							[/@shiro.hasPermission]
						[/#list]
					[/@shiro.lacksPermission]
					[#list ["admin:admin","admin:tourCEO"] as permission]
						[@shiro.hasPermission name = permission]
							<li[#if menuId=="408"] class="active"[/#if]><a href="[@spring.url '/admin/tour/ceoTourList.jhtml'/]" title="CEO">Tour List</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:flight"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="409"] class="active"[/#if]><a href="[@spring.url '/admin/tour/flightList.jhtml'/]" title="OP">Flight List</a></li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:airflight"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="515"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/ticketList.jhtml'/]">Air Ticket List</a></li>
					[#break /]
						[/@shiro.hasPermission]
					[/#list]
						<li[#if menuId=="411"] class="active"[/#if]><a href="[@spring.url '/admin/roomSharing/roomList.jhtml'/]">Room Sharing  request</a></li>
						<li[#if menuId=="412"] class="active"[/#if]><a href="[@spring.url '/admin/roomSharing/tourList.jhtml'/]">Tour Sharing request</a></li>
					</ul>
				</li>
					<!--		
					[#list ["admin:admin","admin:product"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-text-height"></i><span>Product</span></a>
								<ul class="sub-menu">
									<li[#if menuId=="801"] class="active"[/#if]><a href="[@spring.url '/admin/groupline/listforUser.jhtml'/]">Product</a></li>
									<li[#if menuId=="998"] class="active"[/#if]><a href="[@spring.url '/admin/brand/list.jhtml'/]">Brand</a></li>
									<li[#if menuId=="803"] class="active"[/#if]><a href="[@spring.url '/admin/tourType/list.jhtml'/]">Product Type</a></li>
								</ul>
							</li>
								[#break /]
						[/@shiro.hasPermission]
					[/#list]
					-->	
					[#list ["admin:admin","admin:billAgent","admin:billAcc","admin:payment","admin:closeOrd","admin:account","admin:accountOffice","admin:accountRegion","admin:accountCEO","admin:groupBillAcc","admin:groupPayment","admin:groupCloseOrd","admin:billAuditEurope","admin:tourSettle"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-money"></i><span>Accounting</span></a>
								<ul class="sub-menu">
								[#break /]
						[/@shiro.hasPermission]
					[/#list]
							[#list ["admin:admin","admin:Accairflight"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="516"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/ticketAccCheckList.jhtml'/]" title="Account"> Air Ticket Audit(Account)</a></li>
							[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:Agentairflight"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="517"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/ticketAgentCheckList.jhtml'/]" title="Agent">Air Ticket Audit(Agent)</a></li>
								[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:billAgent"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="501"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/agentTourList.jhtml'/]" title="Agent"> <!-- <span class="label label-primary pull-right">New</span> -->Agent Bill Audit</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:billAgentGroup"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="521"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/groupTourList.jhtml'/]" title="Group"> <!-- <span class="label label-primary pull-right">New</span> -->Agent Bill Audit(Group)</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:billAcc"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="502"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/accountantTourList.jhtml'/]" title="Account"> <!-- <span class="label label-primary pull-right">New</span> -->Account Bill Audit</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:payment"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="503"] class="active"[/#if]><a href="[@spring.url '/admin/payCostRecords/list.jhtml'/]">Order Receivable</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:closeOrd"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="505"] class="active"[/#if]><a href="[@spring.url '/admin/payCostRecords/findOrderTotalTaxList.jhtml'/]">Order Settlement</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:account"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="506"] class="active"[/#if]><a href="[@spring.url '/admin/invoiceAndCredit/list.jhtml'/]">Checking Accounts</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:accountOffice"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="508"] class="active"[/#if]><a href="[@spring.url '/admin/invoiceAndCredit/accountRecordMgt.jhtml'/]" title="Office">Office Account Current</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:accountRegion"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="509"] class="active"[/#if]><a href="[@spring.url '/admin/invoiceAndCredit/globalAccountRecordMgtForRegion.jhtml'/]" title="Region">Region Account Current</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:accountCEO"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="507"] class="active"[/#if]><a href="[@spring.url '/admin/invoiceAndCredit/globalAccountRecordMgt.jhtml'/]" title="CEO">Account Current</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:groupBillAcc"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="511"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/accGroupTourList.jhtml'/]" title="Account">Account Bill Audit</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:groupPayment"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="512"] class="active"[/#if]><a href="[@spring.url '/admin/payCostRecords/groupList.jhtml'/]">Order Receivable</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:groupCloseOrd"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="513"] class="active"[/#if]><a href="[@spring.url '/admin/payCostRecords/findOrderTotalTaxGroupList.jhtml'/]">Order Settlement</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:billAuditEurope"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="519"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/approveIncomeForOP.jhtml'/]">Bill Audit(Europe)</a></li>
							[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:tourSettle"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="518"] class="active"[/#if]><a href="[@spring.url '/admin/supplierPrice/settleForAccOP.jhtml'/]">Tour Settle(AccOP)</a></li>
							[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:account"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="520"] class="active"[/#if]><a href="[@spring.url '/admin/orders/agencyPayList.jhtml'/]"> Agency Payment</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
					[#list ["admin:admin","admin:billAgent","admin:billAcc","admin:payment","admin:closeOrd","admin:account","admin:accountOffice","admin:accountRegion","admin:accountCEO","admin:groupBillAcc","admin:groupPayment","admin:groupCloseOrd","admin:billAuditEurope","admin:tourSettle"] as permission]
						[@shiro.hasPermission name = permission]
								</ul>
							</li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
							[#list ["admin:admin","admin:subjectSettings","admin:subjectManage","admin:reportManage","admin:viewReportCEO","admin:viewReport"] as permission]
					[@shiro.hasPermission name = permission]
				<li><a href="#"><i class="fa fa-table"></i><span>Financial Reports</span></a>
					<ul class="sub-menu">
					[#break /]
				[/@shiro.hasPermission]
				[/#list]
					[#list ["admin:admin","admin:subjectSettings"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="1001"] class="active"[/#if]><a href="[@spring.url '/admin/accountSubject/accountingSetup.jhtml'/]" title="Office">Subject Settings</a></li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:subjectManage"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="1002"] class="active"[/#if]><a href="[@spring.url '/admin/accountSubject/accountingManage.jhtml'/]" title="Office">Subject Manage</a></li>
						[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:reportManage"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="1003"] class="active"[/#if]><a href="[@spring.url '/admin/accountSubject/businessFlowManage.jhtml'/]" title="Office">Report Manage</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:viewReportCEO"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="1005"] class="active"[/#if]><a href="[@spring.url '/admin/accountSubject/searchAccountInfoForCEO.jhtml'/]" title="CEO">View Report</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:viewReport"] as permission]
						[@shiro.hasPermission name = permission]
						<li[#if menuId=="1004"] class="active"[/#if]><a href="[@spring.url '/admin/accountSubject/searchAccountInfo.jhtml'/]">View Report</a></li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:subjectSettings","admin:subjectManage","admin:reportManage","admin:viewReportCEO","admin:viewReport"] as permission]
					[@shiro.hasPermission name = permission]
					</ul>
				</li>
					[#break /]
				[/@shiro.hasPermission]
				[/#list]
					[#list ["admin:admin","admin:bookingClientsAgent","admin:bookingClientsOP","admin:bookingClientsOffice","admin:bookingClientsRegion","admin:bookingClientsCEO","admin:arrivalClientsAgent","admin:arrivalClientsOP","admin:arrivalClientsOffice","admin:arrivalClientsRegion","admin:arrivalClientsCEO","admin:airTicketClients","admin:StatisticReports"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-bar-chart-o"></i><span>Statistics</span></a>
								<ul class="sub-menu">
								[#break /]
						[/@shiro.hasPermission]
					[/#list]
							<!--[#list ["admin:admin","admin:bookingClientsAgent"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1101"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/bookingStatistical.jhtml?role=Agent&menuId=1101'/]" title="Agent">Booking Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:bookingClientsOffice"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1102"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/bookingStatisticalCEO.jhtml?role=Office&menuId=1102'/]" title="Office">Booking Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:bookingClientsRegion"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1103"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/bookingStatistical.jhtml?role=Region&menuId=1103'/]" title="Region">Booking Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]-->
							[#list ["admin:admin","admin:bookingClientsCEO"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1104"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/bookingStatisticalCEO.jhtml?menuId=1104'/]">Booking Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:bookingClientsOP"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1105"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/bookingStatistical.jhtml?role=OP&menuId=1105'/]" title="OP">Booking Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							<!--[#list ["admin:admin","admin:arrivalClientsAgent"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1106"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/arrivalStatistical.jhtml?role=Agent&menuId=1106'/]" title="Agent">Arrival Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:arrivalClientsOffice"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1107"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/arrivalStatisticals.jhtm?role=Office&menuId=1107'/]" title="Office">Arrival Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:arrivalClientsRegion"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1108"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/arrivalStatistical.jhtml?role=Region&menuId=1108'/]" title="Region">Arrival Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]-->
							[#list ["admin:admin","admin:arrivalClientsCEO"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1109"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/arrivalStatisticals.jhtml?menuId=1109'/]">Arrival Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:arrivalClientsOP"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1110"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/arrivalStatistical.jhtml?role=OP&menuId=1110'/]" title="OP">Arrival Clients</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:airTicketClients"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1111"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/airStatisticals.jhtml'/]">Air Ticket</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:StatisticReports"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1112"] class="active"[/#if]><a href="[@spring.url '/admin/statistical/statisticalReports.jhtml?time=2018&date=2018&isSelfOrganize=0'/]">Statistic Reports</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							
					[#list ["admin:admin","admin:bookingClientsAgent","admin:bookingClientsOP","admin:bookingClientsOffice","admin:bookingClientsRegion","admin:bookingClientsCEO","admin:arrivalClientsAgent","admin:arrivalClientsOP","admin:arrivalClientsOffice","admin:arrivalClientsRegion","admin:arrivalClientsCEO","admin:airTicketClients","admin:StatisticReports"] as permission]
						[@shiro.hasPermission name = permission]
								</ul>
							</li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					[#list ["admin:admin","admin:customer","admin:phoneRecords","admin:phoneRecordsOffice","admin:phoneRecordsRegion","admin:phoneRecordsCEO"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-user-md"></i><span>Customer</span></a>
								<ul class="sub-menu">
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
							[#list ["admin:admin","admin:customer"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1301"] class="active"[/#if]><a href="[@spring.url '/admin/customer/list.jhtml'/]">Customer List</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:phoneRecords"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="1302"] class="active"[/#if]><a href="[@spring.url '/admin/customer/customerConsultlist.jhtml'/]" title="Agent">Phone Records</a></li>
								[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:phoneRecordsOffice"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="1303"] class="active"[/#if]><a href="[@spring.url '/admin/customer/customerConsultlistForOffice.jhtml'/]" title="Office">Phone Records</a></li>
							[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:phoneRecordsRegion"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="1304"] class="active"[/#if]><a href="[@spring.url '/admin/customer/customerConsultlistForRegion.jhtml'/]" title="Region">Phone Records</a></li>
							[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:phoneRecordsCEO"] as permission]
								[@shiro.hasPermission name = permission]
								<li[#if menuId=="1305"] class="active"[/#if]><a href="[@spring.url '/admin/customer/customerConsultlistForCEO.jhtml'/]" title="CEO">Phone Records</a></li>
							[#break /]
								[/@shiro.hasPermission]
							[/#list]
					[#list ["admin:admin","admin:customer","admin:phoneRecords","admin:phoneRecordsOffice","admin:phoneRecordsRegion","admin:phoneRecordsCEO"] as permission]
						[@shiro.hasPermission name = permission]
								</ul>
							</li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					<li><a href="#"><i class="fa fa-envelope nav-icon"></i><span>Email</span></a>
						<ul class="sub-menu">
							<li[#if menuId=="601"] class="active"[/#if]><a href="[@spring.url '/admin/notice/add.jhtml'/]">Compose</a></li>
							<li[#if menuId=="602"] class="active"[/#if]><a href="[@spring.url '/admin/notice/listIn.jhtml'/]"><!-- <span class="label label-primary pull-right">New</span> --> Inbox</a></li>
							<li[#if menuId=="603"] class="active"[/#if]><a href="[@spring.url '/admin/notice/listOut.jhtml'/]">Sent</a></li>
							<li[#if menuId=="604"] class="active"[/#if]><a href="[@spring.url '/admin/notice/listDrafts.jhtml'/]">Drat</a></li>
						</ul>
					</li>
					<li[#if menuId=="701"] class="active"[/#if]><a href="[@spring.url '/admin/shareSpace/list.jhtml'/]"><i class="fa fa-cloud-upload"></i><span>Training</span></a></li>
					<!--
					[#list ["admin:admin","admin:groupline","admin:tourType","admin:supplier","admin:hotel","admin:country","admin:state","admin:city","admin:vender","admin:customer","admin:currencyType","admin:news","admin:optional"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-bars"></i><span>Information</span></a>
								<ul class="sub-menu">
								[#break /]
						[/@shiro.hasPermission]
					[/#list]
					-->
					<li><a href="#"><i class="fa fa-bars"></i><span>Information</span></a>
						<ul class="sub-menu">
							<li[#if menuId==899] class="active"[/#if]><a href="[@spring.url '/admin/groupline/list.jhtml'/]">Products</a></li>
							<!--
							[#list ["admin:admin","admin:groupline"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId==899] class="active"[/#if]><a href="[@spring.url '/admin/groupline/list.jhtml'/]">Products</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							-->
							[#list ["admin:admin","admin:grouplineAgency"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="813"] class="active"[/#if]><a href="[@spring.url '/admin/groupline/agencyList.jhtml'/]">Products(Agency)</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:tourType"] as permission]
								[@shiro.hasPermission name = permission]
										 <!--<li[#if menuId=="802"] class="active"[/#if]><a href="[@spring.url '/admin/itinerary/list.jhtml'/]">确认单管理</a></li>-->
									<li[#if menuId=="898"] class="active"[/#if]><a href="[@spring.url '/admin/tourType/listforAdmin.jhtml'/]">Tour Type</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:supplier"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="804"] class="active"[/#if]><a href="[@spring.url '/admin/supplier/list.jhtml'/]">Operators</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:hotel"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="805"] class="active"[/#if]><a href="[@spring.url '/admin/hotel/list.jhtml'/]">Hotels</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:country"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="806"] class="active"[/#if]><a href="[@spring.url '/admin/country/list.jhtml'/]">Countries</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:state"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="807"] class="active"[/#if]><a href="[@spring.url '/admin/state/list.jhtml'/]">States</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:city"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="808"] class="active"[/#if]><a href="[@spring.url '/admin/city/list.jhtml'/]">Cities</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:vender"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="809"] class="active"[/#if]><a href="[@spring.url '/admin/vender/list.jhtml'/]">Suppliers / Agencies</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:currencyType"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="811"] class="active"[/#if]><a href="[@spring.url '/admin/currencyType/list.jhtml'/]">Currency</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:news"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="812"] class="active"[/#if]><a href="[@spring.url '/admin/news/list.jhtml'/]">News</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:optional"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="1000"] class="active"[/#if]><a href="[@spring.url '/admin/optional/list.jhtml'/]">Optional Excurision</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
					<!--
					[#list ["admin:admin","admin:groupline","admin:tourType","admin:supplier","admin:hotel","admin:country","admin:state","admin:city","admin:vender","admin:customer","admin:currencyType"] as permission]
						[@shiro.hasPermission name = permission]
								</ul>
							</li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
					-->
					  </ul>
					</li>
					[#list ["admin:admin","admin:company","admin:roles","admin:user","admin:team","admin:setRegion"] as permission]
						[@shiro.hasPermission name = permission]
							<li><a href="#"><i class="fa fa-cogs fa-fw"></i><span>Settings</span></a>
								<ul class="sub-menu">
								[#break /]
						[/@shiro.hasPermission]
					[/#list]
							[#list ["admin:admin","admin:company"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="901"] class="active"[/#if]><a href="[@spring.url '/admin/dept/list.jhtml'/]">Office</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:roles"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="902"] class="active"[/#if]><a href="[@spring.url '/admin/roles/list.jhtml'/]">Role</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:user"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="903"] class="active"[/#if]><a href="[@spring.url '/admin/admin/list.jhtml'/]">User</a></li>
									<!-- <li[#if menuId=="904"] class="active"[/#if]><a href="#">修改密码</a></li> -->
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:team"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="905"] class="active"[/#if]><a href="[@spring.url '/admin/smallGroup/list.jhtml'/]">Team</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
							[#list ["admin:admin","admin:setRegion"] as permission]
								[@shiro.hasPermission name = permission]
									<li[#if menuId=="906"] class="active"[/#if]><a href="[@spring.url '/admin/region/list.jhtml'/]">Region</a></li>
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
					[#list ["admin:admin","admin:company","admin:roles","admin:user","admin:team","admin:setRegion"] as permission]
						[@shiro.hasPermission name = permission]
								</ul>
							</li>
							[#break /]
						[/@shiro.hasPermission]
					[/#list]
                </ul>
            </div>
        </div>
        <div class="text-right collapse-button" style="padding:7px 9px;">
            <!-- <input type="text" class="form-control search" placeholder="Search..." /> -->
            <button id="sidebar-collapse" class="btn btn-default" style=""><i style="color:#fff;" class="fa fa-angle-left"></i></button>
        </div>
    </div>
</div>