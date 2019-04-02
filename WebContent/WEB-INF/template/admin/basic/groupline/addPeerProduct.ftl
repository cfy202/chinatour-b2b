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
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="savePeerProduct.jhtml" method="post" data-parsley-validate novalidate>
               <div class="form-group">
              	<label class="col-sm-3 control-label"></label>
                <div class="col-sm-6" style="display:none">
                   <label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" id="times" name="times" value="1" checked="checked" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper" onclick="changeTime(1);"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Time Period 
					</label>
                   <label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" id="times" name="times" value="2" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper" onclick="changeTime(2);"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Time Period(Regular)
					</label>
                   <label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" id="times" name="times" value="3" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper" onclick="changeTime(3);"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Time Period(Irregular) 
					</label>
                </div>
              </div> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Code</label>
                <div class="col-sm-6">
                  <input type="text" name="tourCode" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars."/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                  <input type="text" name="tourName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars."/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name(En)</label>
                <div class="col-sm-6">
                  <input type="text" name="tourNameEn" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars."/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Brand</label>
                <div class="col-sm-6">
					<select type="text" name="brand" class="select2" id="selectBrandId">
						<option value="">Select</option>
	                    [#list brandList as brand]
	                        <option value="${brand.brandName}">${brand.brandName}</option>
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
               <div class="form-group" id="date2">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6" id="date1">
                </div>
              </div>
              
               <div class="form-group" id="date3">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6" id="depaAll">
                </div>
              </div>
			  <div class="form-group">
				  <label class="col-sm-3 control-label">Operater</label>
				  <div class="col-sm-6">
					  
					  <select type="text" name="operater" class="select2">
	                    <option value="无操作中心">Select</option>
	                    <option value="北京操作中心">北京操作中心</option>
						<option value="澳洲操作中心">澳洲操作中心</option>
						<option value="美国操作中心">美国操作中心</option>
						<option value="苏州操作中心">苏州操作中心</option>
						<option value="WJ操作中心">WJ操作中心</option>
                 	</select>
				  </div>
			  </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Supplier</label>
                <div class="col-sm-6">
                  	<input type="text" name="Source" class="form-control" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Place Start</label>
                <div class="col-sm-6">
                  	<input type="text" name="placeStart" class="form-control" required/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Destination</label>
                <div class="col-sm-6">
                	<input type="text" name="destination" class="form-control" required/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Label</label>
                <div class="col-sm-6">
                	<input type="text" name="degree" class="form-control" required  placeholder=""/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Line No</label>
                <div class="col-sm-6">
                	<input type="text" name="lineNo" class="form-control" required />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tour Notice</label>
                <div class="col-sm-6">
                  <textarea name="tripDesc" id="tripDesc" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">SpecificItems</label>
                <div class="col-sm-6">
                 <textarea name="specificItems" id="SpecificItems" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Attractions</label>
                <div class="col-sm-6">
                 <textarea name="attractions" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">All Destination</label>
                <div class="col-sm-6">
                 <textarea name="destinationlist" rows="6" style="width:100%;"></textarea>
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Days</label>
                <div class="col-sm-6">
                	<input type="text" name="Remark" class="form-control" required  placeholder=""/>
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
              <div class="form-group">
                <label class="col-sm-3 control-label">Currency Type</label>
                <div class="col-sm-6">
                	[#list currencyList as currency]
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="currencyId" value="${currency.id}" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						${currency.currencyEng}(${currency.currencyChs})
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
              </div--> 
              <div class="form-group">
                <label class="col-sm-3 control-label">Adult Price</label>
                <div class="col-sm-6">
                	<input type="text" name="adult" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Children with Bed Price</label>
                <div class="col-sm-6">
                	<input type="text" name="bed" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Children without Bed Price</label>
                <div class="col-sm-6">
                	<input type="text" name="notBed" class="form-control" value="0"/>
                	<input type="hidden" name="children" class="form-control" value="0"/>
                </div>
              </div>
              <!--div class="form-group">
                <label class="col-sm-3 control-label">Children(2~5) Price:</label>
                <div class="col-sm-6">
                	<input type="text" name="children" class="form-control" value="0"/>
                </div
              </div>-->
              <div class="form-group">
                <label class="col-sm-3 control-label">Infant Price</label>
                <div class="col-sm-6">
                	<input type="text" name="baby" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Single Supplement</label>
                <div class="col-sm-6">
                	<input type="text" name="price" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Pre/Post Price</label>
                <div class="col-sm-6">
                	<input type="text" name="hotelPrice" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Self-Expense</label>
                <div class="col-sm-6">
                	<input type="text" name="selfExpense" class="form-control" value="0" style="width:78%"/><span style="float: right;margin-top:-24px;color:red">(Currency Unit : $)</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tip</label>
                <div class="col-sm-6">
                	<input type="text" name="tip" class="form-control" value="0" style="width:78%"/><span style="float: right;margin-top:-24px;color:red">(Currency Unit : $)</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Ticket Price</label>
                <div class="col-sm-6">
                	<input type="text" name="pickSendPrice" class="form-control" value="0" style="width:78%"/><span style="float: right;margin-top:-24px;color:red">(Currency Unit : $)</span>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Least</label>
                <div class="col-sm-6">
                	<input type="text" name="least" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group" style="display:none">
                <label class="col-sm-3 control-label">Commission Type</label>
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
              <div class="form-group">
                <label class="col-sm-3 control-label">Adult Commission</label>
                <div class="col-sm-6">
                	<input type="text" name="commission" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Child Commission</label>
                <div class="col-sm-6">
                	<input type="text" name="childComm" class="form-control" value="0"/>
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
							<input class="icheck" type="radio" name="ticket" value="1" style="position: absolute; opacity: 0;">
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
							<input class="icheck" type="radio" name="otherCol" value="" checked=""  style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						None
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="otherCol" value="pay" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Yes
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="otherCol" value="noPay"  style="position: absolute; opacity: 0;">
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
							<input class="icheck" type="radio" name="isSystem" value="2" checked="" style="position: absolute; opacity: 0;">
								<ins class="iCheck-helper"
									style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
								</ins>
						</div>
						Agency
					</label>
					<label class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
							<input class="icheck" type="radio" name="isSystem" value="12"  style="position: absolute; opacity: 0;">
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
<script type="text/javascript">
    $(document).ready(function () {
	    $("#beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
	    $("#endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
	    $("#beginningDate1").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
	    $("#endingDate1").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
	    changeTime(1);//时间初始化
    	App.init();
    	changeTime(3);
    	$("#selectBrandId").trigger('click');
    });

    function changeTime(time){
    	if(time==1){
    		$("#date1").text("");
    		$("#depaAll").text("");
    		var html='<input type="text" id="beginningDate" class="form-control" name="symbol" required style="width:150px" placeholder="Beginning Date." />'
    			+'<input type="text" id="endingDate" class="form-control" name="currencyEng" required style="width:150px; margin: -32px 0px 20px 200px;" placeholder="Ending Date." />';
	    	$("#date1").append(html);
	    	$("#date2").show();
	    	$("#date3").hide();
    	}else if(time==2){
    		$("#date1").text("");
    		$("#depaAll").text("");
    		var html='<input type="text" id="beginningDate" class="form-control" name="symbol" required style="width:150px" placeholder="Beginning Date." />'
    			+'<input type="text" id="endingDate" class="form-control" name="currencyEng" required style="width:150px; margin: -34px 0px 20px 180px;" placeholder="Ending Date." />'
    			+'<p><input type="checkbox" class="icheck" name="time" value="星期一"/>星期一'
                +'<input type="checkbox" class="icheck" name="time" value="星期二"/>星期二'
                +'<input type="checkbox" class="icheck" name="time" value="星期三"/>星期三'
                +'<input type="checkbox" class="icheck" name="time" value="星期四"/>星期四'
                +'<input type="checkbox" class="icheck" name="time" value="星期五"/>星期五'
                +'<input type="checkbox" class="icheck" name="time" value="星期六"/>星期六'
                +'<input type="checkbox" class="icheck" name="time" value="星期日"/>星期日</p>';
	    	$("#date1").append(html);
	    	$("#date2").show();
	    	$("#date3").hide();
    	}else{
    		$("#date1").text("");
    		$("#depaAll").text("");
    		var html='<input type="text" name="departureDate" id="departureDate" class="form-control" required parsley-minlength="6" placeholder="可填写多个日期,以英文逗号隔开.如:2015-01-06,2015-01-18,..." required/>';
    		$("#depaAll").append(html);
	    	$("#date2").hide();
	    	$("#date3").show();
	    	date();
    	}
    	$("#beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
	    $("#endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    }
    function date(){
	    var picker = new Kalendae.Input('departureDate',{
				//attachTo:document.body,
				months:3,
				mode:'multiple',
				direction:'future',
				multipleDelimiter:',',
				format:'YYYY-MM-DD',
				titleFormat:'YYYY,MM',
			});
		}
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
