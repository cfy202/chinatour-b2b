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
[#include "/admin/peerUser/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="w1">
	 <div class="cl-mcont" id="preview" style="height:550px;">
	 	<!-- 放置PDF文件-->
	 </div>
</div>
[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/pdfobject.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	//alert("Test");
    	var success = new PDFObject({ url: "[@spring.url '${path}'/]" }).embed("preview");
    });
</script>
</body>
</html>
