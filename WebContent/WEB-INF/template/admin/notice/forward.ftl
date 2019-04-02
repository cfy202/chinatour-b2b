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
           <h2>Email</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Email</a></li>
                <li class="active">Compose</li>
            </ol>
        </div>
        
		<div class="row">
			<div class="col-md-12">
				<div class="block-flat">
					<div class="content1">
						<form id="dataForm" class="form-horizontal group-border-dashed" novalidate="" action="${base}/admin/notice/save.jhtml" method="post">
							<!--<input name="noticeId" value="${noticeContact.noticeId}" type="hidden">
							<input name="noticeContactId" value="${noticeContact.noticeContactId}" type="hidden">-->
							<input name="tempId" value="${noticeContact.noticeContactId}" type="hidden">
							<input id="state" name="state" value="" type="hidden">
							<div class="form-group" style="padding:10px 0;">
				                <label class="col-sm-3 control-label labelS">To：</label>
				                <div class="col-sm-6 col-sm-6S">
				                  <select name="receiveUserS" class="select2" multiple="multiple" size="25">
				                     [#list adminList as admin]
				                     	<option value="${admin.id}">${admin.username}&nbsp;——&nbsp;${admin.deptName}</option>
				                     [/#list]
				                  </select>
				            	</div>
				            </div>
				            <div class="form-group" style="padding:10px 0;">
				                <label class="col-sm-3 control-label labelS">Cc：</label>
				                <div class="col-sm-6 col-sm-6S">
				                  <select name="receiveUserC" class="select2" multiple="multiple" size="25">
				                     [#list adminList as admin]
				                        <option value="${admin.id}">${admin.username}&nbsp;——&nbsp;${admin.deptName}</option>
				                    [/#list]
				                  </select>
				            	</div>
				            </div>
				            <div class="form-group" style="padding:10px 0;">
				                <label class="col-sm-3 control-label labelS">Subject：</label>
				                <div class="col-sm-6 col-sm-6S">
				                   <input class="form-control" name="notice.title" value="RE:${noticeContact.notice.title}" type="text"/>
				            	</div>
				            </div>
			            	<div>
				            	<a href="javascript:void(0);" class="btn btn-success" id="upload" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>Upload</a>
				            	<div>
				            		<div id="fileName" style="float:left;" >
					            		 [#list AppendixList as appendix]
					            			 &nbsp;&nbsp;<span id="fileName${appendix_index}">
					            			 <a href="${appendix.serverIp}${base}/admin/notice/download?id=${appendix.appendixId}" >${appendix.appendixName}</a><a href="javascript:remPath('fileName${appendix_index}');" class="label label-danger"><i class="fa fa-times"></i></a>
					            			 <div style="display: none"><input  name="appendixFile['${appendix.appendixFile}']" type="text" value="${appendix.appendixName}"></div>
					            			 </span>
				            			 [/#list]
				            		</div>
				            		<div class="progress progress-striped active" id="progress-striped" style="display: none;width:150px;float:left;">
							  			<div class="progress-bar progress-bar-info" id="progress"></div>
									</div>
				            	</div>
				            	<div id="info">&nbsp;</div>
							</div>
			            	
				            <div class="form-group">
								<textarea name="notice.content" value="" class="ckeditor form-control">
									<p></p><p></p>
									------------------ Forwarding the message ------------------
									</br>Sender:[#list adminList as admin]
				                     	[#list receiverList as receiver]
							      			[#if admin.id==receiver.receiveUser] ${admin.username},&nbsp;[/#if]
							      		[/#list]
				                     [/#list]
									</br>Send Time: [#if (noticeContact.notice.createDate)??]${noticeContact.notice.createDate?date},<b>${noticeContact.notice.createDate?time}</b>[/#if] 
									</br>Subject: ${noticeContact.notice.title}
									</br>${noticeContact.notice.content}
								</textarea>
							</div>
	          				<div class="form-group">
								<div class="col-sm-12">
								  <button type="submit" class="btn btn-primary">&nbsp;&nbsp;Send&nbsp;&nbsp;</button>
								  <button id="saveDraft" class="btn btn-default">&nbsp;&nbsp;Save Draft&nbsp;&nbsp;</button>
								  <a class="btn btn-default" href="javascript:history.go(-1)" title="Back">&nbsp;&nbsp;Cancel&nbsp;&nbsp;</a>
								</div>
							</div>
						</form>
       	 			</div>
				</div>
			</div>
		</div>
    </div>

</div>

<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
            <iframe id='target_upload' onload="onIFrameLoaded(this);" name='target_upload' src=''style='display: none'></iframe>
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" target="target_upload" enctype="multipart/form-data"   action="upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file" id="fileId" placeholder="Upload File" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" onclick="upload();" class="btn btn-primary" style="margin-left:206px;">Upload</button>
						</div>
					</div>
				</form>
			</div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


[#include "/admin/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]"></script>
<script src="[@spring.url '/resources/js/ckeditor/ckeditor.js'/]"></script>
<script src="[@spring.url '/resources/js/ckeditor/adapters/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/lib/js/wysihtml5-0.3.0.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.wysihtml5/src/bootstrap-wysihtml5.js'/]"></script>
<script src="[@spring.url '/resources/js/basic/progressBar.js'/]"></script>
<script type="text/javascript">
$(document).ready(function () {
	App.init();
	App.textEditor();
	$('#summernote').summernote();
	
	$("#saveDraft").click(function(){
    	$("#dataForm").submit(function(){  
		    $('#state').attr("value",2);  
		    var formData = $('#dataForm').serialize();
		    $("#dataForm").attr("action","${base}/admin/notice/saveDrafts.jhtml")
		    return true;
		}); 
	});
});
var fileNumber=${AppendixList?size};
var number;
function upload(){
		var myDate = new Date();
		startTime = myDate.getTime();
		number=++fileNumber;
		$("#formId").submit();
		$(".close").trigger("click");//关闭上传弹出框
		$("#fileName").append('&nbsp;&nbsp;<span id="fileName'+number+'"><a href="javascript:void(0);" >'+$("#fileId").val()+'</a></span>');
		$("#progress-striped").show();
		window.setTimeout("getProgressBar()", 1000);
	}
function onIFrameLoaded(iframe) {
    var doc = iframe.contentWindow.document;
    var html = doc.body.innerHTML;
    if (html != '') {
    	var uploadPath=$.trim(html);
    	$("#fileName"+number+"").append('<div style="display: none"><input  name="appendixFile[\''+uploadPath+'\']" type="text" value="'+$("#fileId").val()+'"></div>');
    }
}
function remPath(fileName){
	$("#"+fileName).remove();
}
</script>
</body>
</html>
