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
		<form action="sendMailForOpConfirm.jhtml" method="post">
			<input id= "fOrC" type="hidden" name="iOrV" value="${iOrV}"/>
	        <input type="hidden" name="destPath" value="${destPath}"/>
	        <input type="hidden" name="orderNo" value="${order.orderNo}"/>
	        <input type="hidden" name="itInfo" value="${order.itInfo}"/>
	        <input type="hidden" name="orderId" value="${orderId}"/>
	        <input type="hidden" name="menuId" value="${menuId}"/>
	        <input type="hidden" name="lineName" value="${lineName}"/>
	        <input type="hidden" name="tourCode" value="${tourCode}"/>
		    Email address ：<input type="text" id="addressTo" name="addressTo" placeholder="username@example.com" required="" size="25">
		    <input type="submit" name="submit" value="send mail"/> 
		</form>
	</div>
	[#if order.itInfo !=1 ]
	<div style="float:right;">
		<a id="btn" href="exportVoucher.jhtml?id=${orderId}"><i class="fa fa-share-square-o md-trigger" title="Export"></i>Export Word</a>
		<a id="btnInv" href="exportInvoice.jhtml?id=${orderId}"><i class="fa fa-share-square-o md-trigger" title="Export"></i>Export Word</a>
        &nbsp;&nbsp;&nbsp;&nbsp;<a class="btn pull-right" href="javascript:history.go(-1)"><i>Back</i></a>
	</div>
	[/#if]
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
