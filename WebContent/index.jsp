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
<%@ page import="org.apache.commons.lang3.ArrayUtils" %>
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
<!--


                                         
                                   .. .vr       
                                 qBMBBBMBMY     
                                8BBBBBOBMBMv    
                              iMBMM5vOY:BMBBv        
              .r,             OBM;   .: rBBBBBY     
              vUL             7BB   .;7. LBMMBBM.   
             .@Wwz.           :uvir .i:.iLMOMOBM..  
              vv::r;             iY. ...rv,@arqiao. 
               Li. i:             v:.::::7vOBBMBL.. 
               ,i7: vSUi,         :M7.:.,:u08OP. .  
                 .N2k5u1ju7,..     BMGiiL7   ,i,i.  
                  :rLjFYjvjLY7r::.  ;v  vr... rE8q;.:,, 
                 751jSLXPFu5uU@guohezou.,1vjY2E8@Yizero.    
                 BB:FMu rkM8Eq0PFjF15FZ0Xu15F25uuLuu25Gi.   
               ivSvvXL    :v58ZOGZXF2UUkFSFkU1u125uUJUUZ,   
             :@kevensun.      ,iY20GOXSUXkSuS2F5XXkUX5SEv.  
         .:i0BMBMBBOOBMUi;,        ,;8PkFP5NkPXkFqPEqqkZu.  
       .rqMqBBMOMMBMBBBM .           @kexianli.S11kFSU5q5   
     .7BBOi1L1MM8BBBOMBB..,          8kqS52XkkU1Uqkk1kUEJ   
     .;MBZ;iiMBMBMMOBBBu ,           1OkS1F1X5kPP112F51kU   
       .rPY  OMBMBBBMBB2 ,.          rME5SSSFk1XPqFNkSUPZ,.
              ;;JuBML::r:.:.,,        SZPX0SXSP5kXGNP15UBr.
                  L,    :@huhao.      :MNZqNXqSqXk2E0PSXPE .
              viLBX.,,v8Bj. i:r7:,     2Zkqq0XXSNN0NOXXSXOU 
            :r2. rMBGBMGi .7Y, 1i::i   vO0PMNNSXXEqP@Secbone.
            .i1r. .jkY,    vE. iY....  20Fq0q5X5F1S2F22uuv1M; 


    别看了，我们不招聘，我们只求你能抽点时间陪陪自己的亲人！

-->
<head>
<meta charset="utf-8">
<%-- <%
        RSAService rsaService = SpringUtils.getBean("rsaServiceImpl", RSAService.class);
        RSAPublicKey publicKey = rsaService.generateKey(request);
        String modulus = Base64.encodeBase64String(publicKey.getModulus().toByteArray());
        String exponent = Base64.encodeBase64String(publicKey.getPublicExponent().toByteArray());

        String message = null;
        String loginFailure = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
        if (loginFailure != null) {
            if (loginFailure.equals("org.apache.shiro.authc.pam.UnsupportedTokenException")) {
                message = "admin.captcha.invalid";
            } else if (loginFailure.equals("org.apache.shiro.authc.UnknownAccountException")) {
                message = "admin.login.unknownAccount";
            } else if (loginFailure.equals("org.apache.shiro.authc.DisabledAccountException")) {
                message = "admin.login.disabledAccount";
            } else if (loginFailure.equals("org.apache.shiro.authc.LockedAccountException")) {
                message = "admin.login.lockedAccount";
            } else if (loginFailure.equals("org.apache.shiro.authc.IncorrectCredentialsException")) {
                if (ArrayUtils.contains(setting.getAccountLockTypes(), AccountLockType.admin)) {
                    message = "admin.login.accountLockCount";
                } else {
                    message = "admin.login.incorrectCredentials";
                }
            } else if (loginFailure.equals("org.apache.shiro.authc.AuthenticationException")) {
                message = "admin.login.authentication";
            }
        }
    %>  --%>
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
        	<%--<li id="UserCen"><a href="<%=base%>/admin/peerUser/download">User Center</a> | </li> --%>
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
    	<img src="<c:url value="/resources/peerUser/images/logo.png "/>">
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
        	<li><a href="#" class="nav_current">Home</a></li>
            <li><a href="<%=base%>/admin/peerUser/add.jhtml?area=zhongguo&degree=key&tourName=2019" >Tours</a></li>
            <li><a href="<%=base%>/admin/peerUser/list.jhtml">My Booking</a></li>
            <li><a href="<%=base%>/admin/peerUser/commission.jhtml">Statement</a></li>
            <li><a href="<%=base%>/about_us.jsp" >About Us</a></li>
            <li><a href="<%=base%>/fqa.jsp" >FAQ</a></li>
            <li><a href="<%=base%>/terms.jsp" >Booking Terms</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="w1 mt1">
	<div class="fl left_main">
    	<div class="news_tit">
            <h2>LATEST NEWS</h2>
            <p class="title_s">LATEST FROM INTERTRIPS</p>
        </div>
        <div class="line_1"></div>
        <div class="news_main">
        	<ul class="news_choice" id="smallImages">
            </ul>
            <div class="r1 pagination_page" id="pageNumber">
            	<a title="上一页" style="cursor:pointer;"  class="page" id="prePage">&lt;Previous</a>
                <a style="cursor:pointer"  class="page_cur" id="first">1</a>
                <a class="page" style="cursor:pointer" id="second">2</a>
                <a title="下一页" style="cursor:pointer"  class="page" id="nextPage">Next&gt;</a>
                <input id="currentPageNumber" value="1" type="hidden">
                <input id="PageNumberCount" value="0" type="hidden">
            </div>
            <div class="clear"></div>
        </div>
        <div class="news_tit">
            <h2>COMPANY INFO</h2>
            <p class="title_s">LASTEST CONTACT DETAILS</p>
        </div>
        <div class="line_1"></div>
        <div class="news_main">
        	<ul class="comany_cont">
                <li>
                	<p class="company_1">(AUS) Sydney office</p>
                    <p class="company_2"><span>Telephone:</span>  1300 998 259</p>
                    <p class="company_2"><span>Fax:</span>        +61(2)8747-8687</p>
                    <p class="company_2"><span>Email:</span>      au@intertrips.com</p>
                    <p class="company_2"><span>Address:</span>    Level 8, 66 Goulburn St Sydney NSW 2000</p>
                </li>
            	<li>
                	<p class="company_1">(USA) Headquarter Office</p>
                    <p class="company_2"><span>Telephone:</span>   +1 (626) 377 9888</p>
                    <p class="company_2"><span>Fax:</span>     	   +1 (626) 602 7786</p>
                    <p class="company_2"><span>Email:</span>     	Jeffrey.c@wenjing.com</p>
                    <p class="company_2"><span>Address:</span>     680 Brea Canyon Road, Suite 268, Diamond Bar, CA 91789 USA</p>
                </li>
                <li>
                	<p class="company_1">(USA) New York Office</p>
                    <p class="company_2"><span>Telephone:</span>   +1 (718) 412 0111</p>
                    <p class="company_2"><span>Fax:</span>     	   +1 (718) 932 3814</p>
                    <p class="company_2"><span>Email:</span>      Bruce.z@wenjing.com</p>
                    <p class="company_2"><span>Address:</span>    4006 Main St, Rm 3A, Flushing, NY 11354 USA</p>
                </li>
                <li>
                	<p class="company_1">(USA) San Francisco Office</p>
                    <p class="company_2"><span>Telephone:</span>   +1 (415) 876-7888</p>
                    <p class="company_2"><span>Fax:</span>         +1 (415) 294 9004</p>
                    <p class="company_2"><span>Email:</span>       Sweet.r@wenjing.com</p>
                    <p class="company_2"><span>Address:</span>    548 Clement St,, San Francisco, CA 94118 USA</p>
                </li>
                <li>
                	<p class="company_1">(USA) Los Angeles Office</p>
                    <p class="company_2"><span>Telephone:</span>   +1 (626) 576 9688</p>
                    <p class="company_2"><span>Fax:</span>         +1 (626) 576 9388</p>
                    <p class="company_2"><span>Email:</span>       Selina.w@wenjing.com</p>
                    <p class="company_2"><span>Address:</span>     301 W. Valley Blvd, Suite 220, San Gabriel, CA 91776 USA</p>
                </li>
                <li>
                	<p class="company_1">(Canada) Vancouver Office</p>
                    <p class="company_2"><span>Telephone:</span>   +1 (604) 800 6411 </p>
                    <p class="company_2"><span>Fax:</span>         +1 (866) 594 1370</p>
                    <p class="company_2"><span>Email:</span>       Colin.z@wenjing.com</p>
                    <p class="company_2"><span>Address:</span>     2380-4000 No.3 Road, Richmond, BC V6X 0J8 Canada</p>
                </li>
                <li>
                	<p class="company_1">(China) Beijing Office</p>
                    <p class="company_2"><span>Telephone:</span>  +86 010 6520 6136</p>
                    <p class="company_2"><span>Fax:</span>        +86 (10) 6568-8972-804</p>
                    <p class="company_2"><span>Email:</span>      BJ@chinatour.com</p>
                    <p class="company_2"><span>Address:</span>    北京朝阳门银河SOHO B座5层20516, 中国</p>
                </li>
                <li>
                	<p class="company_1">(China) Suzhou Office</p>
                    <p class="company_2"><span>Telephone:</span>  +86 0512 6760 0096</p>
                    <p class="company_2"><span>Fax:</span>        +86 0512 6760 0122</p>
                    <p class="company_2"><span>Email:</span>      Tony.z@wenjing.com</p>
                    <p class="company_2"><span>Address:</span>    苏州姑苏区平泷路1258号6层, 中国</p>
                </li>
                
            </ul>
            <div class="clear"></div>
        </div>
    </div>
    <div class="right_main">
    </div>
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
<script type="text/javascript" src="<c:url value="/resources/admin/js/common.js" />"></script>
<script type="text/javascript">
    $(document).ready( function() {
    	$.ajax({
				url: "<%=base%>/index/getUserName.jhtml",
				type: "GET",
				success: function(message) {
					if(message.length>0){
						$.ajax({
							url: "<%=base%>/admin/peerUser/delTotalInfo.jhtml",
							type: "GET",
							success: function(message) {
							}
							});
						$("#loginHtml").html("Welcome&nbsp;&nbsp;"+message);
						 $("#RPas").show();
						 $("#read").show();
						 $("#loOut").show();
						 $("#UserCen").show();
					}else{
							$('.theme-popover-mask').fadeIn(300);
							$('.theme-popover-register').slideUp(300);//隐藏注册弹出窗
							$('.theme-popover-password').slideUp(300);
							$('.theme-popover').slideDown(400);//显示登陆弹出窗
					}	
				}
				});
        var $loginForm = $("#loginForm");
        var $enPassword = $("#enPassword");
        var $username = $("#username");
        var $password = $("#password");
        var $captcha = $("#captcha");
        var $captchaImage = $("#captchaImage");
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

        // 更换验证码
        $captchaImage.click( function() {
            $captchaImage.attr("src", "<%=base%>/common/captcha.jhtml?captchaId=<%=captchaId%>&timestamp=" + (new Date()).valueOf());
        });
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
            /*if ($captcha.val() == "") {
                $.message("warn", "<%=SpringUtils.getMessage("admin.login.captchaRequired")%>");
                return false;
            }*/
            addCookie("adminUsername", $username.val(), {expires: 7 * 24 * 60 * 60});
            $.ajax({
				url: "<%=base%>/index/login.jhtml",
				type: "POST",
				data: {
					username: $username.val(),
					password: $password.val(),
					/*captcha:  $captcha.val(),
					captchaId:$("#captchaId").val()*/
				},
				success: function(message) {
					if(message==2){
						$("#passwordSpan").html("密码错误");
					}
					/*if(message==1){
						$("#imageSpan").html("验证码错误");
						$("#captchaImage").click();
					}*/
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
	
       <%--  <%if (message != null) {%>
        $.message("error", "<%=SpringUtils.getMessage(message, setting.getAccountLockCount())%>");
        <%}%> --%>
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
</script>
<script  type="text/javascript">
var pageIndex = 1;
var pageCount = 0;
 $(document).ready(function () {
	 $("#RPas").hide();
	 $("#read").hide();
	 $("#UserCen").hide();
	 $("#loOut").hide();
	
 	$.ajax({
        type: "GET",
        url:"<%=base%>/index/getPageCount.jhtml",
        success: function(map) {
        	pageCount = map.pageCount;
        	
        	if(pageCount<=2){
        		if(pageCount==1){
        			$("#second").hide();
        			$("#first").hide();
        		}else{
        			$("#second").show();
        			$("#first").show();
        		}
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 		$("#nextPage").show();
		 	}
        }
        });
 	$("#prePage").hide();
 	imageForPage(1);
 	 // 登录
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
    //图片分页
   

	$(".from_choice span").click(function(){
        if($(this).parent().find(".brand_op").css("display")==="none"){
            $(this).parent().find(".brand_op").fadeIn(300);
        }else{
            $(this).parent().find(".brand_op").fadeOut(300);
        }
    })
    $(".from_choice").blur(function(){
        $(this).find(".brand_op").fadeOut(300);
    });
    $(".brand_op li").click(function(){
         $(".from_choice span").text($(this).text());
		 $(".brand_op").fadeOut(300);
    });
    
    $(function(){
        var $div_li =$(".news_choice li");
        $div_li.mouseover(function(){
            $(this).addClass("news_current")            //当前<li>元素高亮
                   .siblings().removeClass("news_current");  //去掉其它同辈<li>元素的高亮
            var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
            $(".right_main > div")       //选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
                    .eq(index).show()   //显示 <li>元素对应的<div>元素
                    .siblings().hide(); //隐藏其它几个同辈的<div>元素
        })
    });
    
    $("#pageNumber").find("a").not(":first").not(":last").each(function(){
    	$(this).click(function(){
    		$(this).addClass("page_cur").removeClass("page");
    		$(this).siblings().addClass("page").removeClass("page_cur");
    		startPage = $(this).html();
    		pageIndex = startPage;
    		imageForPage(startPage);
    		if(pageIndex>1){
    			$("#prePage").show();
    		}else{
    			$("#prePage").hide();
    		};
    		//alert(pageCount);
    		//alert(pageIndex);
    		if(pageCount<=2){
    			$("#nextPage").hide();
    			$("#prePage").hide();
    		}else{
    			if(pageCount==pageIndex){
			 		$("#nextPage").hide();
			 	}else{
			 		$("#nextPage").show();
			 	};
    			
    		}
    	});
    });
	 
	 //点击下一页
	 $("#nextPage").click(function(){
	 	pageIndex  = parseInt(pageIndex);
	 	pageIndex++;
	 	first = parseInt($("#first").html());
	 	first++;
	 	second = parseInt($("#second").html());
	 	second++;
	 	$("#first").html(first);
	 	$("#second").html(second);
	 	$(".page").not(":first").not(":last").each(function(){
	 		if($(this).html()==pageIndex){
	 			$(this).siblings().addClass("page").removeClass("page_cur");
	 			$(this).addClass("page_cur").removeClass("page");
	 		}
	 	});
	 	if(pageIndex>1){
    			$("#prePage").show();
    		}else{
    			$("#prePage").hide();
    		};
    	if(pageCount==pageIndex){
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 	};
		 if(pageIndex==2&&$("#first").is(":hidden")){
		 		$("#first").show();
		 }
	 	imageForPage(pageIndex);
	 });
	 
	 //点击上一页
	 $("#prePage").click(function(){
	 	pageIndex  = parseInt(pageIndex);
	 	pageIndex--;
	 	first = parseInt($("#first").html());
	 	first--;
	 	second = parseInt($("#second").html());
	 	second--;
	 	$("#first").html(first);
	 	$("#second").html(second);
	 	$(".page").not(":first").not(":last").each(function(){
	 		if($(this).html()==pageIndex){
	 			$(this).siblings().addClass("page").removeClass("page_cur");
	 			$(this).addClass("page_cur").removeClass("page");
	 		}
	 	});
	 	if(pageIndex>1){
    			$("#prePage").show();
    		}else{
    			$("#prePage").hide();
    		};
    	if(pageCount==pageIndex){
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 	};
		 if($("#second").html()==1&&pageIndex==1){
		 	$("#first").hide();
		 }else{
		 	$("#first").show();
		 }
	 	imageForPage(pageIndex);
	 });
	 
	 //获取总页数
	 function getPageCount(){
	 	$.ajax({
                type: "GET",
                url:"<%=base%>/index/getPageCount.jhtml",
                success: function(map) {
                	pageCount = map.pageCount;
                }
                });
	 };
	 //绑定数据
	  function imageForPage(startPage){
		$.ajax({
                type: "GET",
                url:"<%=base%>/index/imageForPage.jhtml?startPage="+startPage,
                success: function(map) {
							$("#smallImages").html("");
							$(".right_main").html("");
							var str1  = "";
							var str2 = "";
							$.each(map.newsList,function(index,news){
									str1 += '<li style="cursor:pointer;">'+
					                        '<div class="news_img">'+
					                            '<img class="smallImage" src="<%=base%>'+news.image+'" width="100" height="70">'+
					                        '</div>'+
					                        '<div class="news_title_1">'+
					                            '<p  class="news_title_p">'+news.title+'</p>'+
					                            '<p>'+
					                                '<span class="news_s1">Travel</span>'+
					                                '<span class="news_s1">'+news.createDateStr+'</span>'+
					                            '</p>'+
					                        '</div>'+
					                '</li>';
					                
								                str2+= '<div class="r1 right_box"';
								                if(index!=0){
								                	str2+='style="display:none;"';
								                }
					                			str2+='>'+
									            '<div class="news_banner">'+
									                '<img id="bigImage" src="<%=base%>'+news.image+'" width="730" height="414">'+
									            '</div>'+
									            '<div class="clear"></div>'+
									            '<div class="news_contant">'+
									                '<h1>'+news.title+'</h1>'+
									                '<p class="fa news_time">'+
									                    '<i></i>'+news.createDateStr+
									                '</p>'+
									                '<div class="news_line"></div>'+
									                '<p class="news_p">'+news.content+'</p>'+
									            '</div>'+
									        '</div>';
								});
						$("#smallImages").append(str1);
						$(".right_main").append(str2);
						 $(function(){
							        var $div_li =$(".news_choice li");
							        $div_li.click(function(){
							            $(this).addClass("news_current")            //当前<li>元素高亮
							                   .siblings().removeClass("news_current");  //去掉其它同辈<li>元素的高亮
							            var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
							            $(".right_main > div")       //选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
							                    .eq(index).show()   //显示 <li>元素对应的<div>元素
							                    .siblings().hide(); //隐藏其它几个同辈的<div>元素
							        })
    });
					}
				});
	};
	
	function search(){
		departureDate=$("#keywords").val();
		window.location.href="<%=base%>/admin/peerUser/add.jhtml?departureDate=";
		
	}
	
</script>
<!--
                              _.._        ,------------.
                           ,'      `.    ( We want you! )
                          /  __) __` \    `-,----------'
                         (  (`-`(-')  ) _.-'
                         /)  \  = /  (
                        /'    |--' .  \
                       (  ,---|  `-.)__`
                        )(  `-.,--'   _`-.
                       '/,'          (  Uu",
                        (_       ,    `/,-' )
                        `.__,  : `-'/  /`--'
                          |     `--'  |
                          `   `-._   /
                           \        (
                           /\ .      \.  难道一定要放在顶部么？
                          / |` \     ,-\
                         /  \| .)   /   \
                        ( ,'|\    ,'     :
                        | \,`.`--"/      }
                        `,'    \  |,'    /
                       / "-._   `-/      |
                       "-.   "-.,'|     ;
                      /        _/["---'""]
                     :        /  |"-     '
                     '           |      /
                                 `      |
-->
</body>
</html>
