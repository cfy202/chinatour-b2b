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
<body>
	<div>
		<form action="sendMailforTicket.jhtml" method="post">
			<input id= "fOrC" type="hidden" name="iOrV" value="${iOrV}"/>
	        <input type="hidden" name="destPath" value="${destPath}"/>
	        <input type="hidden" name="orderNo" value="${invoiceNo}"/>
	        <input type="hidden" name="orderId" value="${invoiceId}"/>
	        <input type="hidden" name="menuId" value="${menuId}"/>
	        Email address ：<input type="text" id="addressTo" name="addressTo" placeholder="username@example.com" required="" size="25">
	        <input type="submit" name="submit" value="send mail"/>
		</form>
	</div>
	<div style="float:right;">
		<a id="btnInv" href="[@spring.url'/admin/OrdersController/exportInvoice.jhtml?id=${orderNo}'/]"><i class="fa fa-share-square-o md-trigger" title="Export"></i>Export Word</a>
	</div>
   <div class="cl-mcont" id="preview" style="height:700px;margin-top:15px;clear:both;">
     	<!-- 放置PDF文件-->
   </div>   
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/pdfobject.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/admin/js/common.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	var success = new PDFObject({ url: "[@spring.url '${destPath}'/]" }).embed("preview");
    	//alert($("#fOrC").val());
    	if($("#fOrC").val()==1){
    		$("#btn").hide();
    	}else{
    		$("#btnInv").hide();
    	}
    	[#if temp!=1]
    		$("#btnInv").hide();
    	[/#if]
    });
</script>
</body>
</html>
