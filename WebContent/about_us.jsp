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
            <li><a href="<%=base%>/about_us.jsp" class="nav_current">About Us</a></li>
            <li><a href="<%=base%>/fqa.jsp" >FQA</a></li>
            <li><a href="<%=base%>/terms.jsp" >T&C</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="w1 mt1">
	<div class="about_us_banner">
            	<img src="<%=base%>/resources/peerUser/images/aboutus-banner.jpg" style="display:block;"> 
    </div>
    <div class="about_us_main">
            	<h2 style="margin-bottom:20px !important;">公司简介</h2>
                <p>文景假期创立于2002年的美国旧金山，在创立之初文景假期就以“为旅客带来一站式的旅游服务”作为自己的发展目标。致力于为全世界华人带来最优质的旅游产品。</p>
                <p>伴随着这个始终如一的目标，文景假期从2002年一家只有一间门店的传统旅行社，一步一脚印的演变成了现在囊括线上线下，从旅游销售到具体操作的旅游资源整合平台。</p>
                <p>文景假期的优势在于比传统旅行社更加了解旅游线上电商销售的方便实惠快捷高效，却又比互联网时代的电商更加注重对于每个客人线下实体个性化的服务。</p>
                <p>今天，文景假期总部位于美国洛杉矶，已在美国洛杉矶，旧金山，芝加哥，纽约，加拿大温哥华，西班牙马德里，中国北京，西安，上海，苏州均设立了分支机构，在西安建立技术服务中心。通过整合自身资源，为海外三亿华人，上千家旅行社提供旅游度假，机票酒店预订，游轮预订，差旅服务，旅游咨询在内的一站式个性化服务。</p>
			    <div class="us_photo">
							<h2 style="margin-bottom:20px !important;display:none;">企业人文环境</h2>
							<div class="botton_scroll" style="display:none;">
					          <ul class="featureul">
					            <li class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="<%=base%>/resources/images/about_us/1.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/2.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/3.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/4.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/5.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/6.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/1.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/2.jpg" height="167" width="225"> </li>
					            <li class="featurebox"> <img src="/assets-web/images/about_us/3.jpg" height="167" width="225"> </li>
					          </ul>
							</div>
						<div class="switch"  style="display:none;">
							<a class="switch_prev" href="javascript:void();"></a>
							<a class="switch_next" href="javascript:void();"></a>
						</div>
						<div class="clear"></div>
				</div>
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
