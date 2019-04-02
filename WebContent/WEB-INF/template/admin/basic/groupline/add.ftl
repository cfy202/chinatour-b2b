[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
	 <style type="text/css" media="screen">
		.kalendae .k-days span.closed {
			background:red;
		}
	</style>
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
            <h2>Product</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Product</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="save.jhtml" method="post">
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Code</label>
                <div class="col-sm-6">
                  <input type="text" name="tourCode" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                  <input type="text" name="tourName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Description</label>
                <div class="col-sm-6">
                  <input type="text" name="tripDesc" class="form-control"  parsley-min="6" placeholder="Min 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
					<select type="text" name="brand" class="select2">
	                    [#list brandList as brand]
	                        <option value="${brand.brandName}">${brand.brandName}</option>
	                    [/#list]
                 	</select>
				</div>
              </div> 
          	  <div class="form-group">
                <label class="col-sm-3 control-label">Product Type</label>
                <div class="col-sm-6">
					<select type="text" name="tourTypeId" class="select2">
	                    [#list tourTypeList as tourType]
	                        <option value="${tourType.tourTypeId}">${tourType.typeName}</option>
	                    [/#list]
                 	</select>
				</div>
              </div>  
              <div class="form-group">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6">
                  <input type="text" name="departureDate" id="departureDate" class="form-control" required parsley-minlength="6" placeholder="可填写多个日期,以英文逗号隔开.如:2015-01-06,2015-01-18,..." />
                </div>
                <!--
				<div class="input-group date datetime col-sm-6" data-date-format="yyyy-mm-dd" data-min-view="2" style="padding:0 15px;">
					<input name="departureDate" class="form-control" readonly="readonly" type="text">
					<span class="input-group-addon btn btn-primary">
						<span class="glyphicon glyphicon-th"></span>
					</span>
				</div>
				-->
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Operater</label>
                <div class="col-sm-6">
                  <input type="text" name="operater" class="form-control" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Vender</label>
                <div class="col-sm-6">
                  	<input type="text" name="Source" class="form-control" required />
                </div>
              </div>
              <!--<div class="form-group">
                <label class="col-sm-3 control-label">Destination</label>
                <div class="col-sm-6">
                	<input type="text" name="destination" class="form-control" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Attractions</label>
                <div class="col-sm-6">
                 <textarea name="attractions" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Difficult degree</label>
                <div class="col-sm-6">
                 <textarea name="degree" rows="6" style="width:100%;"></textarea>
                </div>
              </div-->
              <div class="form-group">
                <label class="col-sm-3 control-label">SpecificItems</label>
                <div class="col-sm-6">
                 <textarea name="specificItems" id="SpecificItems" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Days</label>
                <div class="col-sm-6">
                	<input type="text" name="Remark" class="form-control" required  placeholder="" />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Area</label>
                <div class="col-sm-6">
                	[#list productAreaList as productArea]
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="area" value="${productArea.areaName}" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						${productArea.areaName}
					</label>
					[/#list]
                </div>
              </div>
              
               <!--div class="form-group">
                <label class="col-sm-3 control-label">Image</label>
                <div class="col-sm-6">
                	<a href="javascript:void(0);" class="btn btn-success" id="upload" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>Upload</a>
                	<input type="hidden" name="image" id="fileName"/>
                </div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Commision Type</label>
                <div class="col-sm-6">
                	<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="type" value="1" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Percent
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="type" value="0" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Amount 
					</label>
                </div>
              </div>
               <!--div class="form-group">
                <label class="col-sm-3 control-label">level1</label>
                <div class="col-sm-6">
                	<input type="text" name="level" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">level2</label>
                <div class="col-sm-6">
                	<input type="text" name="level" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">level3</label>
                <div class="col-sm-6">
                	<input type="text" name="level" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Price</label>
                <div class="col-sm-6">
                	<input type="text" name="price" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Self-Expense</label>
                <div class="col-sm-6">
                	<input type="text" name="selfExpense" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tip</label>
                <div class="col-sm-6">
                	<input type="text" name="tip" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Supplement</label>
                <div class="col-sm-6">
                	<input type="text" name="supplement" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Ticket</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="ticket" value="0" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						No
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="ticket" value="1" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes
					</label>
                </div>
              </div-->
              <div class="form-group">
                <label class="col-sm-3 control-label">Type</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isSystem" value="1" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						System
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isSystem" value="12" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						System And Agency
					</label>
                </div>
              </div>
              <div class="form-group" style="display:none">
                <label class="col-sm-3 control-label">Notice</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<input type="checkbox"  name="least" value="100"  checked class="icheck" />Yes(是同行产品时通知，不是同行产品请取消)
					</label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Available</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isAvailable" value="1" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						No
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isAvailable" value="0" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes
					</label>
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
<script src="[@spring.url '/resources/js/date/kalendae.standalone.js'/]" type="text/javascript" charset="utf-8"></script>
<script src="[@spring.url '/resources/ckeditor/ueditor.config.js'/]" type="text/javascript" charset="utf-8"></script>
<script src="[@spring.url '/resources/ckeditor/ueditor.all.min.js'/]" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/ckeditor/themes/default/css/ueditor.css'/]" />
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    });
    $(function(){
    	var editor= UE.getEditor('SpecificItems');
    });
     var picker = new Kalendae.Input('departureDate',{
			//attachTo:document.body,
			months:3,
			mode:'multiple',
			direction:'future',
			multipleDelimiter:',',
			format:'YYYY-MM-DD',
			titleFormat:'YYYY,MM',
		});
	function upload(){
		alert(1);
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
	    }
	}
</script>
</body>
</html>
