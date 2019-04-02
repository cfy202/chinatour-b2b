<!-- Fixed navbar -->
<div id="head-nav" class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="fa fa-gear"></span>
            </button>
            <a class="navbar-brand" href="#"><span>&nbsp;</span></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active" title="Home"><a href="[@spring.url '/admin/'/]" style="padding-bottom: 11px;padding-top: 11px;"><i class="fa fa-home fa-2x"></i></a></li>
                <!-- <li><a href="#about">About</a></li> -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Bookmarks <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="http://www.chinatour.com" target="_blank" >China Tour.com</a></li>
                        <li><a href="http://www.wenjing.com" target="_blank" >Wen Jing.com</a></li>
                        <li><a href="http://www.echinatours.com" target="_blank" >Echinatours.com</a></li>
                        <li class="dropdown-submenu"><a href="#">Mail</a>
                            <ul class="dropdown-menu">
                                <!-- <li><a href="http://mail.nexusholidays.com" target="_blank" >Nexus Holidays</a></li> -->
                                <li><a href="http://mail.chinatour.com" target="_blank" >China Tour</a></li>
                            </ul>
                        </li>
                        <li><a href="${base}/admin/admin/download">Read me</a></li>
                       <!-- <li><a href="http://173.193.149.242:8080/TourSyChs/" target="_blank" >ERP V2.0</a></li>
                        [@shiro.hasPermission name = "admin:admin"]
							<li><a href="${base}/admin/supplierPrice/checkTour.jhtml" target="_blank" >CheckTour</a></li>
						[/@shiro.hasPermission]-->
                    </ul>
                </li>
                <!--
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Large menu <b class="caret"></b></a>
                    <ul class="dropdown-menu col-menu-2">
                        <li class="col-sm-6 no-padding">
                            <ul>
                                <li class="dropdown-header"><i class="fa fa-group"></i>Users</li>
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="dropdown-header"><i class="fa fa-gear"></i>Config</li>
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                            </ul>
                        </li>
                        <li  class="col-sm-6 no-padding">
                            <ul>
                                <li class="dropdown-header"><i class="fa fa-legal"></i>Sales</li>
                                <li><a href="#">New order(Peer)</a></li>
                                <li><a href="#">New order(Outbound)</a></li>
                                <li><a href="#">New order(Inbound)</a></li>
                                <li><a href="#">My orders</a></li>
                                <li><a href="#">Has the settlement orders</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                -->
            </ul>
            <ul class="nav navbar-nav navbar-right user-nav">
                <li class="dropdown profile_menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img alt="Avatar" src="[@spring.url '/resources/images/userImage/'/][@shiro.principal property="userImage"/]-2.jpg" /><span> [@shiro.principal property="username" /]</span> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="[@spring.url '/admin/admin/editUser.jhtml'/]">My Account</a></li>
                        <li><a href="[@spring.url '/admin/admin/editPassword.jhtml'/]">Password</a></li>
                        <li class="divider"></li>
                        <li><a href="[@spring.url '/admin/logout.jsp'/]">Sign Out</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right not-nav" >
                		<li style="list-style-type:none;">
                			<input type="text" id="searchCustomer" name="customerInfo" placeholder="Please enter last name/first name or tel" style="margin-top:8px;width:352px;height:30px;background-color:#FFFFFF;color:#000;border:0px;font-size:14px;"/><button style="border:1px solid #fff;margin-top:8px;width:30px;height:30px;background-color:#2494F2;1px solid rgba(0, 0, 0, 0.15);border-radius: 2px;box-shadow: 1px 1px 0 rgba(255, 255, 255, 0.2) inset;font-size:14px;font-weight:bold;" onclick="location.href='${base}/admin/customer/addCustomerWithBasicInfo.jhtml'">+</button>
                			<div id="customerInfoList" style="position:absolute;width:382px;z-index:1px;border:0px;margin:0px;padding:0px;">
                			</div>
                		</li>
                <li class="button dropdown">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"><i class=" fa fa-comments"></i><span id="news_nav" class=""></span></a>
                    <ul class="dropdown-menu messages">
                        <li>
                            <div class="nano nscroller">
                                <div class="content">
                                    <ul id="Msg">
                                        
                                    </ul>
                                </div>
                            </div>
                           <!--  <ul class="foot"><li><a href="#">View all messages </a></li></ul>  -->
                        </li>
                    </ul>
                </li>
                
                <li class="button dropdown">
                    <a href="[@spring.url '/admin/notice/listIn.jhtml'/]" class="dropdown-toggle" ><i class="fa fa-envelope"></i><span id="notice_nav" class=""></span></a>
                    <!-- 
                    <ul class="dropdown-menu">
                        <li>
                            <div class="nano nscroller">
                                <div class="content">
                                    <ul>
                                        <li><a href="#"><i class="fa fa-cloud-upload info"></i><b>Daniel</b> is now following you <span class="date">2 minutes ago.</span></a></li>
                                        <li><a href="#"><i class="fa fa-male success"></i> <b>Michael</b> is now following you <span class="date">15 minutes ago.</span></a></li>
                                        <li><a href="#"><i class="fa fa-bug warning"></i> <b>Mia</b> commented on post <span class="date">30 minutes ago.</span></a></li>
                                        <li><a href="#"><i class="fa fa-credit-card danger"></i> <b>Andrew</b> killed someone <span class="date">1 hour ago.</span></a></li>
                                    </ul>
                                </div>
                            </div>
                            <ul class="foot"><li><a href="#">View all activity </a></li></ul>
                        </li>
                    </ul>
                    -->
                </li>
                <!-- <li class="button"><a href="javascript:;" class="speech-button"><i class="fa fa-microphone"></i></a></li> -->
            </ul>

        </div><!--/.nav-collapse animate-collapse -->
    </div>
</div>