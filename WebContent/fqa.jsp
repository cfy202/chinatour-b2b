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
            <li><a href="<%=base%>/fqa.jsp" class="nav_current">FAQ</a></li>
            <li><a href="<%=base%>/terms.jsp" >Booking Terms</a></li>
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
            	<h2 style="margin-bottom:20px !important;">2019-2020年發現中國美中國&亞洲團收客條款</h2>
                <p><h4>一、	接送條款:</h4><br/>
	                1、接送地點	<br/>
					指定機場（或部分線路指定高鐵站）接送機，其他地點不接送。請提前提供航班資訊。免費接送的高鐵站為：廣州高鐵站，桂林高鐵站，長沙高鐵站，成都高鐵站，上海虹橋站，北京高鐵站、廈門高鐵站。<br/>
           			2、接機時間	<br/>
A:中國超值特價團& B:中國純玩無購物團：所有線路都全天候接機（抵達當天24小時全天分批接機，相鄰兩小時的航班一起接機）<br/>
*無需接機，自行入住酒店的客人務必于抵達前一周左右再次聯繫我社中國地區亞洲線路緊急聯絡人，已確認最終酒店是否有變更。	<br/>
C:亞洲超值特價團：請見單頁和網站備註，不同線路規定不同<br/>
3、送機時間<br/>
請見單頁和網站備註，不同線路規定不同<br/>
4、提前入住(延住)需要接（送）機	<br/>
A:中國超值特價團 & B:中國純玩無購物團：30美金/人，60美金保底，150美金封頂	<br/>1·
C:亞洲超值特價團：50美金/人，100美金保底，250美金封頂。（日本線無此服務）<br/>
           			
                </p>
                <p><h4>二、連續參團規定:</h4><br/>
                	無限制，歡迎客人連續參加多個不同旅遊團，沒有附加費，但是江南系列（江南7天以及所有含江南行程的線路）必須是客人抵達中國後參加的首個特價旅遊團，連續參團必須把江南團放在首站，否則江南團無傭金（獨立整團連續參團，需要提供名單詳情單獨詢價）<br/>
                </p>
                <p><h4>三、客人參團資格的認定:</h4><br/>
                1、華僑客人的認定	<br/>
華僑客人是指美國/加拿大/澳大利亞/新西蘭等國公民或美國綠卡/加拿大楓葉卡/澳洲永久居住證明/新西蘭永久居住證明持有的中文流利之華人華僑。<br/>
抵達參團時如果出示不了相應證件或發現中文聽說不流利，則認定為非華僑客人，將按照非華僑客人收費和返傭。<br/>
*出生於印尼的客人請諮詢後再報。<br/>
                2、成人旅客的認定	<br/>
中國團路線中的絲綢之路經典風情和江南系列團認定18周歲-74周歲為成人北京購物團認定成人為18周歲以上；其它所有中國路線的團認定成人是12周歲以上； <br/>
大陸境外線路認定成人為12周歲以上，除了新馬泰認定成人為18周歲以上  <br/>
（參團抵達日期在12周歲生日之後，例如，參加2018年2月1日的團，必須是2006年2月1日之前出生的客人才認定為正常成人）<br/>	

3、75歲或以上老年人參團注意事項	<br/>
75歲以上長者參團必須滿足以下兩個條件之一才可參團：需由60歲以下華僑陪同；身體健康。經報名則默認為客人知道自身健康狀況是否適合參團，如參團中發生任何意外恕旅行社無法負責。由此產生的各種費用及責任由客人自行承擔。<br/>
4、小童收取標準	<br/>
2周歲以上小童收取A.兒童報名費（占床或不占床）,B自費專案（與成人同價），C綜合服務費（與成人同價）;2周歲以下不占床小童，免收以上三項費用<br/>
所有線路規定12歲以上兒童必須占床，日本線路規定6歲以上兒童必須占床。<br/>
其中2歲（含兩歲）以下兒童收費沒有傭金，滿2歲以上兒童收費含49/PP的傭金。<br/>
                5、西人收費條款	<br/>
A:中國超值團：1:1比例由華僑帶領，按照華僑傭金正常返回，超出1:1比例，按照兒童占床收費和兒童傭金（必須由華僑客人帶領參團，無英文講解服務，有人數限制）<br/>
B:中國純玩無購物團：西人與華僑客人同價同傭金（必須由華僑客人帶領參團，提供中文講解服務，無英文講解服務）<br/>
C:亞洲超值團：按照華僑客人團費收取的基礎上，在華人正常收費和正常返傭金的基礎上，加收USD300/人附加費。（必須由華僑客人帶領參團，無英文講解服務）<br/>

6、港澳臺，流利中文的東南亞客人收費條款<br/>
A:中國超值特價團：1:1比例由華僑帶領，按照華僑傭金正常返回，超出比例的按照兒童占床收費和兒童傭金返回（必須由華僑客人帶領參團）<br/>
Ø江南系列團僅允許港澳臺客人作為海外護照的朋友1:1參團同傭同價，東南亞護照親友在華人正常收費和正常返傭金的基礎上，加收USD300/人附加費。超出1:1比例，按照兒童占床收費和兒童傭金（必須由華僑客人帶領參團）	<br/>
B:中國純玩無購物團：港澳臺客人與華僑客人同價同傭金（必須由華僑客人帶領參團，提供中文英文講解服務）<br/>
C:亞洲超值團：1:1比例由華僑帶領，按照華僑傭金正常返回，超出比例的，超出1:1比例，按照兒童占床收費和兒童傭金（必須由華僑客人帶領參團）（當地客人不得參加當地團，例如臺灣證件客人不得參加臺灣團，日本護照客人不得參加日本團，韓國護照客人不得參加韓國團。）<br/>

7、大陸內賓客人收費條款	<br/>
A:中國超值特價團：1:1比例由華僑帶領，按照兒童占床收費和兒童傭金返回（必須由華僑客人帶領參團）<br/>
B:中國純玩無購物團：1:1比例由華僑帶領，內賓客人結算價格和華僑一樣。（必須由華僑客人帶領參團）	<br/>
C:亞洲超值特價團：1:1比例由華僑帶領，內賓客人結算價格和華僑一樣。 （必須由華僑客人帶領參團）<br/>
                
                </p>
                <p><h4>四、收客截止日期:</h4><br/>
               A:中國超值特價團&B:中國純玩無購物團：團隊抵達日期5天前截止收客，5天內還需緊急加收客人的必須先詢問是否可以加收，得到確認後方可收客。<br/>	
C:亞洲超值特價團：團隊抵達日期15天前必須截止收客！！！15天內還需緊急加收客人的必須先詢問是否可以加收，得到確認後方可收客。<br/>
                
                </p>
                <p><h4>五、客人提前取消或NOSHOW條款:</h4><br/>
A:中國超值特價團：無罰款(除了涉及到三峽的線路在抵達日期前15天內取消需要收取USD400/人船票損失外,其他線路無罰款,如已有機票,火車票已經開具的,會有損失） 備註：亞洲超值團在團抵達15日內不得取消，如有取消，收取全額團款+小費+自費作為損失罰款（這個是最高標準，每次按照實際情況收取罰款，不會超過這個標準）<br/>
B:中國純玩無購物團：無罰款(除了涉及到三峽的線路在抵達日期前15天內取消需要收取USD400/人船票損失外,其他線路無罰款,如已有機票,火車票已經開具的,會有損失）	<br/>
C:亞洲超值特價團：在抵達日期前15天之內取消，收取團費價格+小費+自費作為損失罰款（這個是最高標準，每次按照實際情況收取損失費，不超過這個標準）<br/>			                	
                </p>
                <p><h4>六、成人傭金正常返回年齡段:</h4><br/>
                1、中國線路<br/>
中國線路（除江南系列團和絲綢之路經典風情、北京外）12周歲以上按照成人傭金正常返回（參團抵達日期在12周歲生日之後，例如，參加2018年2月1日的團，必須是2006年2月1日之前出生的客人才認定為正常成人）<br/>
絲綢之路經典風情和江南系列團（江南7天以及所有包含江南段行程的線路在內）18周歲(含18周歲)至74周歲(不含75周歲)按照成人傭金正常返回.不滿18周歲和超過75周歲的客人均按照兒童價格收費和返回兒童傭金。<br/>
北京購物團認定成人為18周歲以上；<br/>

2、亞洲線路 <br/>
亞洲線路原則上按照12周歲作為常規成人返傭標準（星馬泰線路為18周歲）<br/>
                
                </p>
                <p><h4>七、導遊語種:</h4><br/>
                	所有特價團體提供中文導遊服務（不保證有粵語導遊服務）<br/>
                </p>
                <p><h4>八、小費和自費收取標準:</h4><br/>
                	自費專案和綜合服務費是團費的重要組成部分，請在報名時和報名費一起足額繳納。<br/>
					購物團（除張家界購物系列團）的當地推薦自費客人需要保證參加一半以上項目（例如江南團3個當地推薦自費，客人需要保證至少參加2個）<br/>
					注意：由於受特殊情況影響，張家界購物系列團（含張家界長江三峽團）暫時需要在報名時預繳推薦自費。<br/>
                </p>
                <p><h4>九、額外日期散拼開團許可	:</h4><br/>
                	有客人需要報名我們計畫中沒有的日期，可以單獨為他們開一個散拼日期，具體標准是至少16人（亞洲線路為20人），提前45天以上諮詢和報名<br/>
                </p>
                <p><h4>十、獨立包團開團要求:</h4><br/>
                	獨立包團（除日本線路）開團要求最低人數為20人，提前30天以上諮詢價格和報名。需提供客人名單和詳細資訊確認是否開團。<br/>
                	日本線路：最低人數30人，提前45天以上詢價.<br/>
                </p>
                <p><h4>十一、酒店入住／退房時間:</h4><br/>
                	1、酒店正常入住時間是下午15：00之後，如果在此時間前抵達的客人，酒店儘量讓客人有房間就入住，沒有乾淨房間的情況下只能等待。<br/>
2、酒店正常退房時間是中午12:00之前（亞洲部分線路為11:00之前），超過此時間退房的客人需要補房費。<br/>

                </p>
				 <p><h4>十二、其他:</h4><br/>
                	1、 購物團客人因各種原因（包括生病、突發狀況）離團，罰離團費USD100/人/天<br/>
2、	購物團6個月內不可以重複參團的政策，被發現後需要補足團費。<br/>

                </p>
			    
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
