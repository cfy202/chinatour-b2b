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
    if (applicationContext != null) {
%>
<shiro:authenticated>
    <%
        response.sendRedirect(base + "/admin/common/main.jhtml");
    %>
</shiro:authenticated>
<%
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="<c:url value="/resources/images/favicon.png" />">
    <%
        RSAService rsaService = SpringUtils.getBean("rsaServiceImpl", RSAService.class);
        RSAPublicKey publicKey = rsaService.generateKey(request);
        String modulus = Base64.encodeBase64String(publicKey.getModulus().toByteArray());
        String exponent = Base64.encodeBase64String(publicKey.getPublicExponent().toByteArray());

        String message = null;
        String loginFailure = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
        if (loginFailure != null) {
            if (loginFailure.equals("org.apache.shiro.authc.pam.UnsupportedTokenException")) {
                message = "验证码错误";
            } else if (loginFailure.equals("org.apache.shiro.authc.UnknownAccountException")) {
                message = "此账号不存在";
            } else if (loginFailure.equals("org.apache.shiro.authc.DisabledAccountException")) {
                message = "此账号已被禁用";
            } else if (loginFailure.equals("org.apache.shiro.authc.LockedAccountException")) {
                message = "此账号已被锁定";
            } else if (loginFailure.equals("org.apache.shiro.authc.AuthenticationException")) {
                message = "账号认证失败";
            }
        }
    %>
    <title>InterTrips</title>
    <!--  <link href='http://fonts.useso.com/css?family=Open+Sans:400,300,600,400italic,700,800' rel='stylesheet' type='text/css'>
    <link href='http://fonts.useso.com/css?family=Raleway:300,200,100' rel='stylesheet' type='text/css'>-->
    <!-- Bootstrap core CSS -->
    <!-- Custom styles for this template -->
    <link href="<c:url value="/resources/css/login.css" />" rel="stylesheet"/>
	    
	<script src="<c:url value="/resources/js/jquery.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/behaviour/general.js" />"></script>
	
	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="<c:url value="/resources/js/behaviour/voice-commands.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap/dist/js/bootstrap.min.js" />"></script>
	<!-- <script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.pie.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.resize.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.flot/jquery.flot.labels.js" />"></script> -->
	<script type="text/javascript" src="<c:url value="/resources/js/jsbn.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/prng4.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/rng.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/rsa.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/base64.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/admin/js/common.js" />"></script>
</head>

<body>

<div class="wrap">

    <div class="main">
    	<div class="logo">
        	<img src="<c:url value="/resources/images/logo_1.png" />"/>
        </div>
        <form id="loginForm" method="post" action="login.jsp">
        	<input type="hidden" id="enPassword" name="enPassword" />
            <%if (ArrayUtils.contains(setting.getCaptchaTypes(), CaptchaType.adminLogin)) {%>
            <input type="hidden" name="captchaId" value="<%=captchaId%>" />
            <%}%>
            
        	<div class="login_box">
        		<input type="text" placeholder="user name" id="username" name="username" class="login_name" />
                <input type="password" placeholder="password" id="password" name="password" class="login_mima" />
                <input type="text" placeholder="captcha" id="captcha" name="captcha" class="login_code" />
                <img id="captchaImage" class="code" src="<%=base%>/common/captcha.jhtml?captchaId=<%=captchaId%>" title="点击更换验证码" />
                <input type="submit" name="" value="" class="login_btn" />
        	</div>
        </form>
        <div class="logo_1">
        	<img src="<c:url value="/resources/images/logo_2.png" />" />
        </div>
    </div>

</div>

<script type="text/javascript">
    $().ready( function() {

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

        // 表单验证、记住用户名
        $loginForm.submit( function() {
            if ($username.val() == "") {
                $.message("warn", "请输入您的用户名");
                return false;
            }
            if ($password.val() == "") {
                $.message("warn", "请输入您的密码");
                return false;
            }
            if ($captcha.val() == "") {
                $.message("warn", "请输入您的验证码");
                return false;
            }

            if ($isRememberUsername.prop("checked")) {
                addCookie("adminUsername", $username.val(), {expires: 7 * 24 * 60 * 60});
            } else {
                removeCookie("adminUsername");
            }

            var rsaKey = new RSAKey();
            rsaKey.setPublic(b64tohex("<%=modulus%>"), b64tohex("<%=exponent%>"));
            var enPassword = hex2b64(rsaKey.encrypt($password.val()));
            $enPassword.val(enPassword);
        });

        <%if (message != null) {%>
        $.message("error", message);
        <%}%>
        
        
    });
</script>
</body>
</html>
