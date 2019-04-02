
<div class="top">
	<div class="top_main">
    	<ul class="top_login">
        	<li>
            	<a id="loginHtml" href="">Login</a>
            </li>
        </ul>
        <ul class="top_login" id="top_login_2" style="display:none;">
        	<li>Welcome, CCC</li>
        	<li>
            	<a href="">My Account</a>
            </li>
            <li>|</li>
            <li>
            	<a href="">Logout</a>
            </li>
        </ul>
        <ul class="top_language" style="display:none;">
        	<li >
            	<a href="">English</a>
            </li>
            <li>|</li>
            <li>
            	<a href="">中文</a>
            </li>
        </ul>
        <ul class="top_language">
        	<li id="read"><a href="[@spring.url '/admin/peerUser/download'/]">Use Manual</a> | </li>
        	<li id="RPas"><a href="[@spring.url '/admin/peerUser/editPeerUser'/]"><i class="fa fa-user"></i>  My Account</a> | </li>
        	<!--li id="UserCen"><a href="<%=base%>/admin/peerUser/download">User Center</a> | </li-->
        	<li><a href="[@spring.url '/admin/weblogout.jsp'/]">Logout</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="w1 mt1">
	<div class="logo">
    	<img src="[@spring.url '/resources/peerUser/'/]images/logo.png">
    </div>
    <div class="fl search">        
        <form id="form1" action="add.jhtml">
        <div class="fl" style="position:relative;" onmouseover="isOut=false" onmouseout="isOut=true">
			<input type="text" name="departureDate" id="keywords" placeholder="Product Name / Code" class="search_input" autocomplete="off">
		</div>
        <div class="clear"></div>
        <div class="submit">
              <input type="submit" value="Search">
        </div>
        </form>
    </div>
    <div class="r1 tel">
    	<img src="[@spring.url '/resources/peerUser/images/logo3.png'/]">
    </div>
    <div class="clear"></div>
</div>
<div class="mt1 nav">
	<div class="w1">
    	<ul class="nav_main">
        	<li><a [#if menuId=="1000"]class="nav_current"[/#if] href="[@spring.url '/index.jsp'/]">Home</a></li>
            <li><a [#if menuId=="1001"]class="nav_current"[/#if] href="${base}/admin/peerUser/add.jhtml?area=文景假期(Cruises)&degree=超值特价&tourName=2019">Tours</a></li>
            <li><a [#if menuId=="1002"]class="nav_current"[/#if] href="${base}/admin/peerUser/list.jhtml">My Booking</a></li>
            <li><a [#if menuId=="1003"]class="nav_current"[/#if] href="${base}/admin/peerUser/commission.jhtml"  >Statement</a></li>
            <li><a [#if menuId=="1004"]class="nav_current"[/#if] href="[@spring.url '/about_us.jsp'/]">About Us</a></li>
        	<li><a [#if menuId=="1005"]class="nav_current"[/#if] href="[@spring.url '/fqa.jsp'/]" >FAQ</a></li>
            <li><a [#if menuId=="1006"]class="nav_current"[/#if] href="[@spring.url '/terms.jsp'/]">Booking Terms</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>