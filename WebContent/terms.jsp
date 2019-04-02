<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="java.security.interfaces.RSAPublicKey"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.chinatour.Setting"%>
<%@page import="com.chinatour.util.SettingUtils"%>
<%@page import="com.chinatour.util.SpringUtils"%>
<%@page import="com.chinatour.Setting.CaptchaType"%>
<%@page import="com.chinatour.Setting.AccountLockType"%>
<%@page import="com.chinatour.service.RSAService"%>
<%@page import="org.apache.commons.lang3.ArrayUtils" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String base = request.getContextPath();
    String captchaId = UUID.randomUUID().toString();
    ApplicationContext applicationContext = SpringUtils.getApplicationContext();
    Setting setting = SettingUtils.get();
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
 <link rel="shortcut icon" href="<c:url value="/resources/images/favicon.png" />">
<title>InterTrips</title>
<!-- <link href='http://fonts.useso.com/css?family=Open+Sans:400,300,600,400italic,700,800' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Raleway:300,200,100' rel='stylesheet' type='text/css'> -->
<link href="<c:url value="/resources/peerUser/css/public.css" />" rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/peerUser/css/style.css" />" rel="stylesheet" type="text/css" />
<style type="text/css">
    #login{
    	position:absolute;
    	background:#000;
    	z-index:2000;
    	opacity:0.5;
    	left:0px;
    	right:0px;
    	top:0px;
    }
     #logindiv{
    	width:620px;
    	height:570px;
    	position:absolute;
    	background:#000;
    	z-index:1500;
    }
</style>
</head>

<body>
<div class="top">
	<div class="top_main">
    	<ul class="top_login">
        	<li>
            	<a id="loginHtml" class="theme-login" href="javascript:;">Login</a>
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
        	<li>
            	<a href="">English</a>
            </li>
            <li>|</li>
            <li>
            	<a href="">中文</a>
            </li>
        </ul>
        <ul class="top_language">
        	<li id="read"><a href="<%=base%>/admin/peerUser/download">Use Manual</a> | </li>
        	<li id="RPas"><a href="<%=base%>/admin/peerUser/editPeerUser"><img src="<c:url value="/resources/images/about_us/iconfont.png "/>"/>  My Account</a> | </li>
        	<%-- <li id="UserCen"><a href="<%=base%>/admin/peerUser/download">User Center</a> | </li> --%>
        	<li id="loOut">
            	<a onclick="logout();" href="">Logout</a>
            </li>
            
        </ul>
        <!--登录弹出框-->
<div class="theme-popover">
<a href="javascript:;" title="关闭" class="theme-close">×</a>
     <div class="theme-poptit">
       <img src="<c:url value="/resources/peerUser/images/logo.png "/>"/>
     </div>
     <div class="theme-popbod">
        <form id="loginForm" method="post" action="">
        	<input type="hidden" id="enPassword" name="enPassword" />
            <%if (ArrayUtils.contains(setting.getCaptchaTypes(), CaptchaType.adminLogin)) {%>
            <input type="hidden" name="captchaId" value="<%=captchaId%>" id="captchaId"/>
            <%}%>
             <ol>
                  <li>
                     <label>Email</label>
                     <input type="text" placeholder="user name" id="username" name="username" class="ipt" />
                     <!--  <div class="theme-tips">邮箱格式错误</div>-->
                  </li>
                  <li>
                     <label>Password</label>
                     <input type="password" placeholder="password" id="password" name="password" class="ipt" />
                     <div id="passwordSpan" class="theme-tips"></div>
                  </li>
                  <!-- li>
                     <label>Captcha</label>
                     <input type="text" placeholder="captcha" id="captcha" name="captcha" class="captcha" />
                     <img id="captchaImage" class="yzm-img" src="<%=base%>/common/captcha.jhtml?captchaId=<%=captchaId%>" title="<%=SpringUtils.getMessage("admin.captcha.imageTitle")%>" />
                           <div id="imageSpan" class="theme-tips"></div>
                   </li-->
  
                       <li><input id="submitButton" class="btn" type="button" value=" LOGIN "></li>
                  </ol>
             </form>
             <div class="theme-rm">
                  <div class="fl"><a class="theme-password" id="theme-password" href="javascript:;">&nbsp;<!-- Forgot password? --></a></div>
                  <div class="r1"><a class="theme-register" id="theme-register" href="javascript:;">&nbsp;<!-- Register> --></a></div>
                  <div class="clear"></div>
             </div>
         		<div class="clear"></div>
   		</div>
</div>
      <!--登录弹出框结束-->
      <div class="theme-popover-mask"></div>
        <div class="clear"></div>
    </div>
</div>
<div class="w1 mt1">
	<div class="logo">
    	<img src="<c:url value="/resources/peerUser/images/logo.png "/>" >
    </div>
    <div class="fl search" style="width:474px;">
        <!-- <div class="fl" style="position:relative;" >
            <div class="from_choice" tabindex="1" >
            	<span>Product</span>
                <ul class="brand_op" style="display:none;">                                                          
                    <li><a  href="javascript:;">China Tour</a></li>
                    <li><a href="javascript:;">Intertrips</a></li>
                    <li><a href="javascript:;">中国美</a></li>
                    <li><a href="javascript:;">文景假期</a></li>
                    <div class="clear"></div>
                </ul>
                <div class="clear"></div>
            </div>
            
        </div> -->
        <div class="fl" style="position:relative;" onmouseover="isOut=false" onmouseout="isOut=true">
			<input type="text" name="keyword" id="keywords" placeholder="Product Name / Code" class="search_input" autocomplete="off">
		</div>
        <div class="clear"></div>
        <div class="submit">
              <input type="submit" value="Search" onclick="search();">
        </div>
    </div>
    <div class="r1 tel">
    	<img src="<c:url value="/resources/peerUser/images/logo3.png" />">
    </div>
    <div class="clear"></div>
</div>
<div class="mt1 nav" style="margin-top:30px;">
	<div class="w1">
    	<ul class="nav_main">
        	<li><a href="<%=base%>/index.jsp" >Home</a></li>
            <li><a href="<%=base%>/admin/peerUser/add.jhtml?area=zhongguo&degree=key&tourName=2016">Tours</a></li>
            <li><a href="<%=base%>/admin/peerUser/list.jhtml">My Booking</a></li>
            <li><a href="<%=base%>/admin/peerUser/commission.jhtml">Statement</a></li>
            <li><a href="<%=base%>/about_us.jsp">About Us</a></li>
            <li><a href="<%=base%>/fqa.jsp" >FAQ</a></li>
            <li><a href="<%=base%>/terms.jsp" class="nav_current">Booking Terms</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="w1 mt1">
	<!-- 
	<div class="about_us_banner">
            	<img src="<%=base%>/resources/peerUser/images/aboutus-banner.jpg" style="display:block;"> 
    </div>
     -->
    <div class="about_us_main">
            	<h2 style="margin-bottom:20px !important;">Booking Conditions & Important information</h2>
            	<div class="about_us_banner">
            	<img src="<%=base%>/resources/peerUser/images/tms.jpg" style="display:block;"> 
    			</div>
                <p><h4>Reservations & Payments:</h4><br/>
	                1.	Your guided tours will be confirmed after receipt of a non-refundable, non-transferable deposit as detailed in the summary table. <br/>
					2.	Air-inclusive bookings may require an additional non-refundable deposit or payment in full at the time of booking and ticketing whichever comes first.<br/>
					3.	Final payment for your land reservation will be due prior to departure no later than as detailed in the summary information table.  Payment in full will be required at time of booking for reservations made less than 35/90 days prior to the departure date.<br/>
					4.	Intertrips reserve the right to cancel the reservation and impose cancellation charges if any payment is not received as details within the summary information table above. Intertrips will not be responsible for lost land and/or air reservations.<br/>
					                
                </p>
                <p><h4>Passports, Visas and other Entry/Exit requirements</h4> <br/>
                	All guests including children must be in possession of a passport valid for 6 months after their trip return date along with applicable visas. It’s the guest’s sole responsibility to secure and/or pay for any and all visas, reciprocity fees, affidavits, immunisations etc. Intertrips bears no responsibility for such information and will not be responsible for advising and/or obtaining required travel documentation for any guest, or for any delays, damages, and/or losses including missed portions of your holiday related to improper documentation or government decisions about entry.<br/>
                </p>
                <p><h4>Booking amendments, cancellations & Refunds</h4><br/>
                	A fee of $30 or more per person, per amendment plus any further cost we incur, will be charged for change made to a reservation after the booking is confirmed. Costs and charges may increase closer to the departure date that changes are made. We will try to make your requested change but it may not be possible due to availability and unforeseen circumstances.<br/>
                	The agent must also pay any changes imposed by airlines for any changes, including name and date changes. This can be up to 100% of the value of the ticket.<br/>
                </p>
                <p><h4>Name changes</h4><br/>
                	A fee of $30 per person will be charge for name changes or name corrections together with any airline penalties and other charges incurred.<br/>
                </p>
                <p><h4>Cancellations and Cancellation fees</h4><br/>
                	Travel arrangements for any member of the party may be cancelled at any time by written notice by the person who made the booking. Please note the following:<br/>
                	1.	If notice of cancellation is received by Intertrips more than 35/90 days prior to the guided tour departure date, deposit will be retained.<br/>
					2.	If full payment is not received 35/90 days prior to departure date. Intertrips has the right to cancel your reservation. Intertrips will not be responsible for lost reservations.<br/>
					3.	Notice of cancellation must be made in writing directly to Intertrips.<br/>
					4.	If a person in a party cancels and there is a room change caused by this cancellation (such as a Twin/Double to Single, or Triple to Twin (Double), charges for the new room type will be the responsibility of the remaining party. The charges details in the summary information table (includes GST)<br/>
					5.	Air Cancellation incurs a service fee of $30 per person, plus any airline penalties. Airline imposed penalties may be up to 100% of the air ticket price. Published fares, Promo fares and some other airfares booked are non-refundable.<br/>
					6.	Airline availability seats are limited in our contracted booking class of service and may not be available on every flight. Intertrips do not hold block space on any airlines and does not assure seat availability for every single guided holiday departure date.<br/>
					                	
                </p>
                <p><h4>Travel insurance</h4><br/>
                	Intertrips recommend that all guests purchase comprehensive Travel insurance. Certain countries have a requirement for foreign visitors to have valid medical insurance on entry. Intertrips cannot be held responsible for denied entry if a guest is unable to provide details to authorities of insurance or denial of entry for any reason.<br/>
                </p>
                <p><h4>Responsibility</h4><br/>
                	Complete agreement booking conditions, together with the other terms incorporated into this contract outline in booking conditions, represent the entire agreement between the parties.<br/>
                </p>
                <p><h4>Errors and Omissions</h4><br/>
                	In the case of computer or human billing errors, we reserve the right to re-invoice participants with correct billing. Every efforts is made to ensure brochure and b2b online accuracy at the time of press advertising , however, Intertrips cannot be held responsible for printing or typographical errors, or errors arising from unforeseen circumstances. Moreover, photographs and descriptions of locations or attractions are merely representative of conditions that existed at time of brochure printing and conditions may not be the same at the time of your guided holidays.<br/>
                </p>
                <p><h4>Complaint procedures & Consumer Protection</h4><br/>
                	If you or guest have a problem during holiday please inform Intertrips’s Travel Director/Local Representative immediately, who will try to make things right. If the matter was not resolved locally, please email to Intertrips AU/NZ Pty Ltd Guest Relations at au@intertrips.com within (30) days of the end of the Intertrips holiday, as this is important that you provide us the information quickly. Please quote your booking reference number and all relevant information. Failure to follow this procedure may delay or deny us the opportunity to investigate and rectify the problem, which may affect the way your complaint is dealt with and your rights under this contract.<br/>
                </p>
                <p><h4>Data Protection</h4><br/>
                	To process your guided holiday booking, Intertrips will need to use personal information for you and guests in your booking. Personal information may include each guest’s name, address, phone number, email address, passport number, and sensitive information such as health, medical, dietary, mobility, religious or other special requirements. This personal information may be passed on to other suppliers of your travel arrangements in addition to public authorities (such as customs and immigration), security and credit checking organisation, and otherwise as required by law. We may need to provide personal information to contractors who provide services to or for us (e.g. sending mail, providing marketing assistance, etc).  This may involve sending personal information (including sensitive information) to other countries that may not afford the same level of protection of personal information. In making your booking you consent to your personal data being passed to relevant third parties as a set out above. We may also use the personal information you provide us to review and improve the guided holidays and services that we offer, and to contact you (by email and/or telephone) about other guided holidays and services offered by Intertrips that you may be interested in. If you don’t want to receive this information, or if you want a copy of the personal information we hold about you, email to us at au@intertrips.com Attn: Intertrips AU/NZ Pty Ltd Guest Relations.<br/>
                </p>
                <p><h4>Other conditions</h4><br/>
                	Each guest is required to comply with the terms, conditions, requirement, laws, rules and/or regulations of any service provider, or any country or governmental authority, and shall be liable for any such non-compliance.<br/>
                </p>
    </div>
    <%-- <div class="us_photo">
				<h4>企业人文环境</h4>
				<div class="botton_scroll" style="visibility: visible; overflow: hidden; position: relative; z-index: 2; left: 0px; width: 789px;">
		          <ul style="margin: 0px; padding: 0px; position: relative; list-style-type: none; z-index: 1; width: 3156px;" class="featureul">
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <!--
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/2.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/3.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/4.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/5.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/6.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/2.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/3.jpg" height="167" width="233"> </li>
		            -->
		          </ul>
				</div>
			<div class="switch">
				<a class="switch_prev" href="javascript:void();"></a>
				<a class="switch_next" href="javascript:void();"></a>
			</div>
	</div> --%>
	
	<%-- <div class="us_main">
			<div class="us_photo">
				<h4>企业人文环境</h4>
				<div class="botton_scroll" style="visibility: visible; overflow: hidden; position: relative; z-index: 2; left: 0px; width: 789px;">
		          <ul style="margin: 0px; padding: 0px; position: relative; list-style-type: none; z-index: 1; width: 3156px;" class="featureul">
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="233"> </li>
		            <!--
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/2.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/3.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/4.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/5.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/6.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/1.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/2.jpg" height="167" width="233"> </li>
		            <li style="overflow: hidden; float: left; width: 233px; height: 167px;" class="featurebox"> <img src="/assets-web/images/about_us/3.jpg" height="167" width="233"> </li>
		            -->
		          </ul>
				</div>
			<div class="switch">
				<a class="switch_prev" href="javascript:void();"></a>
				<a class="switch_next" href="javascript:void();"></a>
			</div>
		</div>
	</div> --%>
	

    <div class="clear"></div>
</div>
<div class="footer">
	<div class="w1">
    	<p>&copy; 2015 Copyright Intertrips. All Rights reserved.</p>
    </div>
</div>
<script src="<c:url value="/resources/js/jquery.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/behaviour/general.js" />"></script>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<c:url value="/resources/js/behaviour/voice-commands.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap/dist/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.pie.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.resize.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.labels.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jsbn.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/prng4.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/rng.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/rsa.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/base64.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/peerUser/js/lrscroll.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/admin/js/common.js" />"></script>
<script type="text/javascript">
    $(document).ready( function() {
    	$("#RPas").hide();
    	$("#read").hide();
    	$("#UserCen").hide();
		$("#loOut").hide();
    	$.ajax({
				url: "<%=base%>/index/getUserName.jhtml",
				type: "GET",
				success: function(message) {
					if(message.length>0){
						$("#loginHtml").html("Welcome&nbsp;&nbsp;"+message);
						$("#RPas").show();
						$("#read").show();
						$("#loOut").show();
						$("#UserCen").show();
					}	
				}
				});
        var $loginForm = $("#loginForm");
        var $enPassword = $("#enPassword");
        var $username = $("#username");
        var $password = $("#password");
        var $isRememberUsername = $("#isRememberUsername");

        // 记住用户名
        if(getCookie("adminUsername") != null) {
            $isRememberUsername.prop("checked", true);
            $username.val(getCookie("adminUsername"));
            $password.focus();
        } else {
            $isRememberUsername.prop("checked", false);
            $username.focus();
        }
        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
            	if ($username.val() == "") {
                    $.message("warn", "<%=SpringUtils.getMessage("admin.login.usernameRequired")%>");
                    return false;
                }
                if ($password.val() == "") {
                    $.message("warn", "<%=SpringUtils.getMessage("admin.login.passwordRequired")%>");
                    return false;
                }
                addCookie("adminUsername", $username.val(), {expires: 7 * 24 * 60 * 60});
                $.ajax({
    				url: "<%=base%>/index/login.jhtml",
    				type: "POST",
    				data: {
    					username: $username.val(),
    					password: $password.val(),
    					captcha:  $captcha.val(),
    					captchaId:$("#captchaId").val()
    				},
    				success: function(message) {
    					if(message==2){
    						$("#passwordSpan").html("密码错误");
    					}
    					if(message==1){
    						$("#imageSpan").html("验证码错误");
    						$("#captchaImage").click();
    					}
    					if(message=="success"){
    						$(".theme-close").click();
    						path = window.location.href;
    						start =  path.indexOf("=")+1;
    						end = path.length;
    						path =  path.substring(start,end);
    						path = decodeURIComponent(path);
    						location.href = path;
    						
    					}
    				}
    			});
            }
        };

        // 表单验证、记住用户名
       $("#submitButton").click( function() {
            if ($username.val() == "") {
                $.message("warn", "<%=SpringUtils.getMessage("admin.login.usernameRequired")%>");
                return false;
            }
            if ($password.val() == "") {
                $.message("warn", "<%=SpringUtils.getMessage("admin.login.passwordRequired")%>");
                return false;
            }
            addCookie("adminUsername", $username.val(), {expires: 7 * 24 * 60 * 60});
            $.ajax({
				url: "<%=base%>/index/login.jhtml",
				type: "POST",
				data: {
					username: $username.val(),
					password: $password.val(),
				},
				success: function(message) {
					if(message==2){
						$("#passwordSpan").html("密码错误");
					}
					if(message=="success"){
						$(".theme-close").click();
						path = window.location.href;
						/* path = path.replace(/\%2F/g,"/");
						path = path.replace(/\%3F/g,"?");
						path = path.replace(/\%3D/g,"=");
						path = path.replace(/\%26/g,"&"); */
						//alert(path);
						start =  path.indexOf("=")+1;
						end = path.length;
						path =  path.substring(start,end);
						//path = encodeURIComponent(path);
						//path = decodeURIComponent(path);
						//alert(path);
						path = decodeURIComponent(path);
						location.href = path;
						
					}
				}
			});
        });
       $('.theme-login').click(function(){
	   		$("#passwordSpan").html("");
	   		$("#imageSpan").html("");
	   		$('.theme-popover-mask').fadeIn(300);
	   		$('.theme-popover-register').slideUp(300);//隐藏注册弹出窗
	   		$('.theme-popover-password').slideUp(300);
	   		$('.theme-popover').slideDown(400);//显示登陆弹出窗
	   	})
	   	$('.theme-close').click(function(){
	   		$('.theme-popover-mask').fadeOut(300);
	   		$('.theme-popover').slideUp(400);
	   		$('.theme-popover-register').slideUp(300);
	   		$('.theme-popover-password').slideUp(300);
	   	})
    });
    
  //退出
	function logout(){
		$.ajax({
			url: "<%=base%>/index/logout.jhtml",
			type:"GET",
			success:function(){
				//alert("aa");
			}
		})
	}
	function search(){
		departureDate=$("#keywords").val();
		window.location.href="<%=base%>/admin/peerUser/add.jhtml?departureDate=";
		
	}
</script>
</body>
</html>
