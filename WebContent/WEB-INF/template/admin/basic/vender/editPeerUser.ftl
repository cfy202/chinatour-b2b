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
            <h2>Edit</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Supplier/Agencies</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" method="POST"   action="${base}/admin/vender/updatePeerUser.jhtml">
              <div class="form-group">
                <label class="col-sm-3 control-label">Agency Name</label>
                <div class="col-sm-6">
                  <input type="email" class="form-control"  name="peerUserName" required value="${peerUser.peerUserName}"  placeholder="Please enter the Name" />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Password</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="password" required placeholder="Please enter the Password" value="${peerUser.password}"/>
                </div>
              </div>
              <div class="form-group" style="display:none">
                <label class="col-sm-3 control-label">Level</label>
                <div class="col-sm-6">
                  <input type="radio" class="icheck"  name="level" value="1" [#if peerUser.level==1]checked[/#if]/>1
                  <input type="radio" class="icheck"  name="level" value="2" [#if peerUser.level==2]checked[/#if]/>2
                  <input type="radio" class="icheck"  name="level" value="3" [#if peerUser.level==3]checked[/#if]/>3
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
                  <input type="checkbox" class="icheck"  name="brandMange" value="文景假期" [#if a1=='文景假期']checked="checked"[/#if]/>文景假期
                  <input type="checkbox" class="icheck"  name="brandMange" value="InterTrips" [#if a2=='InterTrips']checked="checked"[/#if]/>InterTrips
                  <input type="checkbox" class="icheck"  name="brandMange" value="chinatour" [#if a3=='chinatour']checked="checked"[/#if]/>chinatour
                  <input type="checkbox" class="icheck"  name="brandMange" value="中国美" [#if a4=='中国美']checked="checked"[/#if]/>中国美
                </div>
              </div>
              <div class="form-group" style="">
                <label class="col-sm-3 control-label">LOGO</label>
                <div class="col-sm-6">
                	<img id="image"src="${base}${peerUser.logoAddress}" width="100" height="100"/>
                	<a href="javascript:void(0);" class="btn btn-success" id="upload" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>Upload</a>
                	<input type="hidden" name="logoAddress" id="fileName"/>
                </div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Authority</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="Authority" value="0" [#if peerUser.authority=='0']checked[/#if] class="icheck">Sales</label> 
                  <label class="radio-inline"> <input type="radio" name="Authority" value="1" [#if peerUser.authority=='1']checked[/#if] class="icheck">Manager</label> 
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <input name="peerUserId" type="hidden"  value="${peerUser.peerUserId}">
                  <input name="peerId" type="hidden"  value="${peerUser.peerId}">
                  <input name="userId" type="hidden"  value="${peerUser.userId}">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="submit" style="margin-left:336px;" class="btn btn-primary">Save</button>
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
