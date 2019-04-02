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
    <style type="text/css" media="screen">
		.kalendae .k-days span.closed {
			background:red;
		}
	</style>
    
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
            <a class="btn pull-right" href="javascript:history.go(-1)">
				<i class="fa fa-reply" title="Back"></i>
			</a>
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
            <h3>Edit</h3>
          </div>
          <div class="content">
            <form class="form-horizontal group-border-dashed" action="updateforAdmin.jhtml" method="post">
              <input type="hidden" name="id" value="${groupLine.id}" class="form-control" required placeholder="Min 6 chars." />
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Code</label>
                <div class="col-sm-6">
                  <input type="text" name="tourCode" value="${groupLine.tourCode}" class="form-control" required parsley-minlength="6" placeholder="Min 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                  <input type="text" name="tourName" value="${groupLine.tourName}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Description</label>
                <div class="col-sm-6">
                  <input type="text" name="tripDesc" value="${groupLine.tripDesc}" class="form-control" parsley-min="6" placeholder="Min 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
					<select type="text" name="brand" class="select2">
	                    [#list brandList as brand]
	                      <option value="${brand.brandName}" [#if "${brand.brandName==groupLine.brand}"] selected="selected" [/#if]> ${brand.brandName}</option>
	                    [/#list]
	                </select>
				</div>
              </div> 
     		  <div class="form-group">
                <label class="col-sm-3 control-label">Product Type</label>
                <div class="col-sm-6">
					<select type="text" name="tourTypeId" class="select2">
	                    [#list tourTypeList as tourType]
	                      <option value="${tourType.tourTypeId}" 
	                      [#if "${tourType.tourTypeId==groupLine.tourTypeId}"] selected="selected" [/#if]>
	                      ${tourType.typeName}</option>
	                    [/#list]
	                </select>
				</div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6">
                  <input id="departureDate" type="text" name="departureDate" value="${groupLine.departureDate}" class="form-control" required parsley-minlength="6" placeholder="Min 6 chars." />
                </div>
              </div>
               <!--div class="form-group">
                <label class="col-sm-3 control-label">Source</label>
                <div class="col-sm-6">
                  <input type="text" name="source" class="form-control"  value="${groupLine.source}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Place Start</label>
                <div class="col-sm-6">
                 <textarea name="placeStart" rows="6" style="width:100%;">${groupLine.placeStart}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Destination</label>
                <div class="col-sm-6">
                 <textarea name="destination" rows="6" style="width:100%;">${groupLine.destination}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Attractions</label>
                <div class="col-sm-6">
                 <textarea name="attractions" rows="6" style="width:100%;">${groupLine.attractions}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Difficult degree</label>
                <div class="col-sm-6">
                 <textarea name="degree" rows="6" style="width:100%;">${groupLine.degree}</textarea>
                </div>
              </div-->
              <div class="form-group">
                <label class="col-sm-3 control-label">Operater</label>
                <div class="col-sm-6">
                  <input type="text" name="operater" class="form-control" value="${groupLine.operater}" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Vender</label>
                <div class="col-sm-6">
                  	<input type="text" name="source" class="form-control" value="${groupLine.source}" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">SpecificItems</label>
                <div class="col-sm-6">
                 <textarea name="specificItems" id="SpecificItems" rows="6" style="width:100%;">${groupLine.specificItems}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Days</label>
                <div class="col-sm-6">
                  <input type="text" name="Remark" class="form-control" required value="${groupLine.remark}" />
                </div>
              </div>
              <!--div class="form-group">
                <label class="col-sm-3 control-label">Image</label>
                <div class="col-sm-6">
                	<img src="${base}${groupLine.image}" width="100" height="100" id="imgsrc"/>
                	<a href="javascript:void(0);" class="btn btn-success" id="upload" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>Upload</a>
                	<input type="hidden" name="image" id="fileName"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Commision Type</label>
                <div class="col-sm-6">
                	<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="type" value="1"[#if groupLine.type==1]checked="checked"[/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Percent
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="type" value="0" [#if groupLine.type==0]checked="checked"[/#if] style="position: absolute; opacity: 0;">
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
                	<input type="text" name="level" class="form-control" value="${a}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">level2</label>
                <div class="col-sm-6">
                	<input type="text" name="level" class="form-control" value="${b}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">level3</label>
                <div class="col-sm-6">
                	<input type="text" name="level" class="form-control" value="${c}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Self Expense</label>
                <div class="col-sm-6">
                	<input type="text" name="selfExpense" class="form-control" value="${groupLine.price}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Gratuity</label>
                <div class="col-sm-6">
                	<input type="text" name="tip" class="form-control" value="${groupLine.price}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Pick-Send Price</label>
                <div class="col-sm-6">
                	<input type="text" name="pickSendPrice" class="form-control" value="${groupLine.price}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Least Passenger </label>
                <div class="col-sm-6">
                	<input type="text" name="least" class="form-control" value="${groupLine.price}"/>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Supplement</label>
                <div class="col-sm-6">
                	<input type="text" name="supplement" class="form-control" value="${groupLine.supplement}"/>
                </div>
              </div-->
              <div class="form-group">
                <label class="col-sm-3 control-label">Type</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isSystem" value="1"  [#if "${groupLine.isSystem==1}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						System
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isSystem" value="12" [#if "${groupLine.isSystem==12}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						System And Agency
					</label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Area</label>
                <div class="col-sm-6">
                	[#list productAreaList as productArea]
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="area" value="${productArea.areaName}" [#if groupLine.area==productArea.areaName]checked="checked"[/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						${productArea.areaName}
					</label>
					[/#list]
                </div>
              </div>
              <!--<div class="form-group">
                <label class="col-sm-3 control-label">Notice</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<input type="checkbox"  name="least" value="100" class="icheck" />Yes(是同行产品时通知，不是同行产品请取消)
					</label>
                </div>
              </div>-->
              <div class="form-group">
                <label class="col-sm-3 control-label">Available</label>
                <div class="col-sm-6">
                	<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isAvailable" value="1" [#if "${groupLine.isAvailable==1}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						No
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isAvailable" value="0" [#if "${groupLine.isAvailable==0}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
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
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" target="target_upload" enctype="multipart/form-data"   action="upload.jhtml">
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
    	$(function(){
    		var editor= UE.getEditor('SpecificItems');
    	});
    	$(function() {
	    /*$("#datepicker").datepickerRefactor({
	        target : "#timelist",
	    });
	
	    $("#sel_time_begin").datepicker($.extend({}, $.datepicker.regional["zh-CN"], {
	        showOn : "focus",
	        numberOfMonths : 1,
	        passCtrl : false,
	        showButtonPanel : false,
	    }));
	
	    $("#sel_time_end").datepicker($.extend({}, $.datepicker.regional["zh-CN"], {
	        showOn : "focus",
	        numberOfMonths : 1,
	        passCtrl : false,
	        showButtonPanel : false,
    }));*/

});
    	var avi="${groupLine.isAvailable}";
    	var isAvailable = document.getElementsByName("isAvailable");
    	for(var i=0;i<isAvailable.length;i++){
    		if(isAvailable[i].value==avi){
    			isAvailable[i].checked='checked';
    		}
    	}
    	
    	/*
    	var dateArray = "${groupLine.departureDate}";
    	var strs= new Array(); //定义一数组 
		availableDates=dateArray.split(","); //字符分割 
		
		function available(date) {
			var dmy = $.datepicker.formatDate('yy-mm-dd',date);
			if ($.inArray(dmy, availableDates) != -1) {
				
				return [true, "","Available"];
			} else {
				return [false,"","unAvailable"];
			}
		}
		*/
		
		
    	$("#testDate").datepicker({
    								dateFormat: 'yy-mm-dd',
    								changeYear: true,
    								changeMonth: true, 
    								numberOfMonths: 3, 
    								minDate: 1 ,
    								onClose: function(dateText, inst) {
    									$("#testDate").val("Date");
    								},
    								onSelect: function(dateText, inst) { 
    									//$("#this").css("color","red");
    									$("#testDate").val("Date");
    									var currentDate = $("#departureDate").val();
    									if(currentDate!=""){
    										currentDate=currentDate+","+dateText;
    									}else{
    										currentDate = dateText;
    									}
										$("#departureDate").val(currentDate);
										inst.show();
    								},
    								onConfirm:function(){
    									alert(arg.date);
    								}
    								});
    	
    	
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
    var fileNumber=1;
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
    	$("#fileName").attr("value",uploadPath);
    	$("#imgsrc").attr("src","${base}"+uploadPath);
    }
}
</script>
</body>
</html>
