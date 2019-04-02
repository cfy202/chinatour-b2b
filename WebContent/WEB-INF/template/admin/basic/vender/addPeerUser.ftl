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
            <h2>New</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Agency User</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/vender/savePeerUser.jhtml">
              	<input type="hidden" name="peerId" value="${peerUser.peerId}">
              <div class="form-group">
                <label class="col-sm-3 control-label">Agency User Name</label>
                <div class="col-sm-6">
                  <input type="email" class="form-control"  name="peerUserName" required placeholder="Please Enter Email" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Password</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="password" required parsley-type="number" placeholder="Please enter the password" />
                </div>
              </div>
              <div class="form-group" style="display:none">
                <label class="col-sm-3 control-label">Level</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="level" value="1" checked="" class="icheck"> 1</label> 
                  <label class="radio-inline"> <input type="radio" name="level" value="2" class="icheck"> 2</label> 
                  <label class="radio-inline"> <input type="radio" name="level" value="3" class="icheck"> 3</label> 
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
                  <input type="checkbox"  name="brandMange" value="文景假期" class="icheck" />文景假期
                  <input type="checkbox"  name="brandMange" value="InterTrips" class="icheck"/>InterTrips
                  <input type="checkbox"  name="brandMange" value="chinatour" class="icheck"/>chinatour
                  <input type="checkbox"  name="brandMange" value="中国美" class="icheck"/>中国美
                </div>
              </div>
              <div class="form-group" style="">
                <label class="col-sm-3 control-label">LOGO</label>
                <div class="col-sm-6">
                	<img id="image" width="100" height="100"/>
                	<a href="javascript:void(0);" class="btn btn-success" id="upload" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>Upload</a>
                	<input type="hidden" name="logoAddress" id="fileName"/>
                </div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Authority</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="authority" value="0" checked="" class="icheck">Sales</label> 
                  <label class="radio-inline"> <input type="radio" name="authority" value="1" class="icheck">Manager</label> 
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
        
      </div>
    </div>

</div>
<!--上传图片 Begin-->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
            <iframe id='target_upload' onload="onIFrameLoaded(this);" name='target_upload' src=''style='display: none'></iframe>
				<form class="form-horizontal group-border-dashed" id="fileUpload" method="POST" target="target_upload" enctype="multipart/form-data"   action="upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file" id="fileId" placeholder="请上传文件" />
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
<!--end-->
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
$(document).ready(function () {
	App.init();
});
	function upload(){
			var myDate = new Date();
			startTime = myDate.getTime();
			$("#fileUpload").submit();
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
	    	$("#fileName").attr("value",uploadPath);
	    	$("#image").attr("src","${base}"+uploadPath);
	    }
	}
</script>
</body>
</html>
