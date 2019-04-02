[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>View Email</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Email</a></li>
            </ol>
        </div>
        
     <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div class="message">
				      <div class="head">
				        <h3>Subject &nbsp;:&nbsp;${noticeContact.notice.title}<span><a href="forward.jhtml?id=${noticeContact.noticeContactId}" title="Forward"><i class="fa fa-mail-forward"></i></a><span><a href="reply.jhtml?id=${noticeContact.noticeContactId}" title="Reply"><i class="fa fa-comment"></i></a><a href="javascript:history.back()" title="Back"><i class="fa fa-reply"></i></a></span></h3>
				        <h4>Sender &nbsp;:&nbsp;${noticeContact.admin.username} <span><a href="#"><i class="fa fa-star"></i></a> ${noticeContact.notice.createDate?date}, <b>${noticeContact.notice.createDate?time}</b></span></h4>
				      	<h4>To &nbsp;:&nbsp;
				      		[#list receiverList as receiver]
				      			${receiver.receiveUserName}&nbsp;;&nbsp;
				      		[/#list]
				      	</h4>
				      	[#list AppendixList as appendix]
				     		 <a href="${appendix.serverIp}${base}/admin/notice/download?id=${appendix.appendixId}" >${appendix.appendixName}</a>
			      		[/#list]
				      </div>
				      <div class="mail">
				        	${noticeContact.notice.content}
				      </div>
				 </div>
			</div>
		</div>
	</div>
  </div>

</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]"></script>
<script src="[@spring.url '/resources/js/ckeditor/ckeditor.js'/]"></script>
<script src="[@spring.url '/resources/js/ckeditor/adapters/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/lib/js/wysihtml5-0.3.0.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/src/bootstrap-wysihtml5.js'/]"></script>
<script type="text/javascript">
$(document).ready(function () {
	App.init();
	App.textEditor();
	[@flash_message /]
	$('#summernote').summernote();
});
</script>
</body>
</html>
