[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
</head>
<body>
<!--input type="hidden" value="[@shiro.principal property="type" /]" id="userRole"-->
<!-- <script src="http://html5media.googlecode.com/svn/trunk/src/html5media.min.js"></script>-->

<!-- Bootstrap core JavaScript
  ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if("[@shiro.principal property="type" /]"=="PeerUser"){
			window.location.href="${base}/admin/peerUser/web.jhtml"; 
		}else{
			window.location.href="${base}/admin/common/main.jhtml"; 
		}
    });
</script>
</body>
</html>
