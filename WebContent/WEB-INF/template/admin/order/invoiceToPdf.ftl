[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>${message("admin.main.title")}</title>
</head>
<body style="height:100%;">
	<div>
	   <form action="[@spring.url '/admin/orders/sendMailForOrdersTotal.jhtml'/]" method="post">
		         <input id = "destPath" type="hidden" name="destPath" value="${destPath}"/>
		         <input type="hidden" name="iOrV" value="${iOrV}"/>
		         <input type="hidden" name="orderNo" value="${order.orderNumber}"/>
		          <input type="hidden" name="lineName" value="${lineName}"/>
		         <input type="hidden" name="ordersTotalId" value="${ordersTotalId}"/>
		         <input type="hidden" name="orderId" value="${orderId}"/>
		         <input type="hidden" name="logo" value="${logo}"/>
		         <input type="hidden" name="tourCode" value="${tourCode}"/>
				 Email address ：<input type="email" id="addressTo" name="addressTo" size="25">
				 <input type="submit" name="submit" value="send"/>
	    </form>
	</div>
	<div style="float:right;">
        &nbsp;&nbsp;&nbsp;&nbsp;<a class="btn pull-right" href="javascript:history.go(-1)"><i>Back</i></a></label>
	</div>
   <div id="preview" style="height:700px;margin-top:10px;clear:both;">
     	<!-- 放置PDF文件-->
   </div> 
   
</body> 
<script type="text/javascript" src="[@spring.url '/resources/js/pdfobject.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/admin/js/common.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	var success = new PDFObject({ url: "[@spring.url '${destPath}'/]" }).embed("preview");
    	if($("#destPath").val()=="No"){
    		$("#sendButton").hide();
    	}
    });
</script>
</html>
