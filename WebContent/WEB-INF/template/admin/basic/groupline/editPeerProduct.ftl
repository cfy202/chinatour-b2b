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
            <form class="form-horizontal group-border-dashed" action="updatePeerProduct.jhtml" method="post">
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
                <label class="col-sm-3 control-label">Product Name(En)</label>
                <div class="col-sm-6">
                  <input type="text" name="tourNameEn" value="${groupLine.tourNameEn}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars."/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
					<select type="text" name="brand" class="select2" id="selectBrandId">
	                    [#list brandList as brand]
	                      <option value="${brand.brandName}" [#if "${brand.brandName==groupLine.brand}"] selected="selected" [/#if]> ${brand.brandName}</option>
	                    [/#list]
	                </select>
				</div>
              </div> 
     		  <div class="form-group">
                <label class="col-sm-3 control-label">Product Type</label>
                <div class="col-sm-6">
					<select type="text" name="tourTypeId" class="select2" id="selectTypeId">
	                    <option value="">Select</option>
	                </select>
				</div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6">
                  <input id="departureDate" type="text" disabled="disabled" value="${groupLine.departureDate}" class="form-control" required parsley-minlength="6" placeholder="Min 6 chars." />
                  <input type="hidden" name="departureDate" value="${groupLine.departureDate}" />
                </div>
              </div>
                  <div class="form-group">
                <label class="col-sm-3 control-label">Operater</label>
                <div class="col-sm-6">
                  <select type="text" name="operater" class="select2">
                  		<option value="">请选择</option>
	                    <option value="北京操作中心" [#if groupLine.operater?index_of("北京操作中心")!=-1] selected="selected" [/#if]>北京操作中心</option>
	                    <option value="苏州操作中心" [#if groupLine.operater?index_of("苏州操作中心")!=-1] selected="selected" [/#if]>苏州操作中心</option>
	                    <option value="美国操作中心" [#if groupLine.operater?index_of("美国操作中心")!=-1] selected="selected" [/#if]>美国操作中心</option>
	                    <option value="澳洲操作中心" [#if groupLine.operater?index_of("澳洲操作中心")!=-1] selected="selected" [/#if]>澳洲操作中心</option>
	                    <option value="WJ操作中心" [#if groupLine.operater?index_of("WJ操作中心")!=-1] selected="selected" [/#if]>WJ操作中心</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Supplier</label>
                <div class="col-sm-6">
                  	<input type="text" name="source" class="form-control" value="${groupLine.source}" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Place Start</label>
                <div class="col-sm-6">
                  <input type="text" name="placeStart" class="form-control"  value="${groupLine.placeStart}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Destination</label>
                <div class="col-sm-6">
                  <input type="text" name="destination" class="form-control"  value="${groupLine.destination}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Label</label>
                <div class="col-sm-6">
                  <input type="text" name="degree" class="form-control"  value="${groupLine.degree}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Line No</label>
                <div class="col-sm-6">
                	<input type="text" name="lineNo" class="form-control" value="${groupLine.lineNo}" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tour Notice</label>
                <div class="col-sm-6">
                  <textarea name="tripDesc" id="tripDesc" rows="6" style="width:100%;">${groupLine.tripDesc}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">SpecificItems</label>
                <div class="col-sm-6">
                 <textarea name="specificItems" id="SpecificItems" rows="6" style="width:100%;">${groupLine.specificItems}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Attractions</label>
                <div class="col-sm-6">
                 <textarea name="attractions" rows="6" style="width:100%;">${groupLine.attractions}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">All Destination</label>
                <div class="col-sm-6">
                 <textarea name="destinationlist" rows="6" style="width:100%;">${groupLine.destinationlist}</textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Days</label>
                <div class="col-sm-6">
                  <input type="text" name="Remark" class="form-control" required value="${groupLine.remark}" />
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
               <div class="form-group">
                <label class="col-sm-3 control-label">Self-Expense</label>
                <div class="col-sm-6">
                	<input type="text" name="selfExpense" class="form-control" value="${groupLine.selfExpense}" style="width:78%"/><span style="float: right;margin-top:-24px;color:red">(Currency Unit : $)</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tip</label>
                <div class="col-sm-6">
                	<input type="text" name="tip" class="form-control" value="${groupLine.tip}" style="width:78%"/><span style="float: right;margin-top:-24px;color:red">(Currency Unit : $)</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Ticket Price</label>
                <div class="col-sm-6">
                	<input type="text" name="pickSendPrice" class="form-control" value="${groupLine.pickSendPrice}" style="width:78%"/><span style="float: right;margin-top:-24px;color:red">(Currency Unit : $)</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Least</label>
                <div class="col-sm-6">
                	<input type="text" name="least" class="form-control" value="${groupLine.least}"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Ticket</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="ticket" value="0" [#if "${groupLine.ticket==0}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						No
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="ticket" value="1" [#if "${groupLine.ticket==1}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes
					</label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Prepaid the fee?</label>
                <div class="col-sm-6">
                	<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="otherCol" value="" checked="" [#if "${groupLine.otherCol==''}"] checked="checked" [/#if]  style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						None
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="otherCol" value="pay" [#if "${groupLine.otherCol=='pay'}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="otherCol" value="noPay" [#if "${groupLine.otherCol=='noPay'}"] checked="checked" [/#if]  style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						No
					</label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">System Or Agency</label>
                <div class="col-sm-6">
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isSystem" value="2" [#if "${groupLine.isSystem==2}"] checked="checked" [/#if] style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Agency
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
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
		//默认选中
		$("#selectBrandId").trigger('click');
		$("#selectTypeId").select2("val","${groupLine.tourTypeId}");
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
$("#selectBrandId").click(function(){
		var tourTypeList=${tourTypeList};
		var brand=$(this).val();
		var html='<option value="">Select</option>';
		$.each(tourTypeList,function(index,values){
			if(brand==values.brand){
				html+='<option value="'+values.tourTypeId+'">'+values.typeName+'</option>';
			}
		});
		$("#selectTypeId").select2("val","");
		$("#selectTypeId").empty();
		$("#selectTypeId").append(html);
	});
</script>
</body>
</html>
