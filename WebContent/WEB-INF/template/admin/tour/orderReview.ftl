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
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

 <div class="container-fluid" id="pcont" >
	<div class="page-head">
            <h2>Invoice</h2>
            <div class="pull-right option-left">
	            <div class="new">
            		<button type="button" class="btn btn-success btn-flat md-trigger" id="New" onclick="location.href='editInvoiceForGroupLine.jhtml?tourId=${tourId}&isChanged=${isChanged}&menuId=402'">Edit Booking Confirmation &nbsp;&nbsp;</button>
            		<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
            		<!--<button class="btn btn-success btn-flat md-trigger" type="button" id="New" data-modal="form-primary">&nbsp;&nbsp; 发送邮件 &nbsp;&nbsp;</button>-->
            	</div>
             </div>
            <ol class="breadcrumb">
                <li><a href="../../">Home</a></li>
                <li><a href="#">Tour</a></li>
                <li class="active">invoice</li>
            </ol>
   </div>
   <div class="cl-mcont" id="preview" style="height:540px;">
     	<!-- 放置PDF文件-->
   </div>   
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/pdfobject.js'/]"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	var str = "${destPath}";
    	if(str=="No"){
    		$("#preview").html("<h3>No Invoice</h3>");
    		$("#New").hide();
    	}else{
    		var success = new PDFObject({ url: "[@spring.url '${destPath}'/]" }).embed("preview");
    		}
    });
</script>
</body>
</html>
