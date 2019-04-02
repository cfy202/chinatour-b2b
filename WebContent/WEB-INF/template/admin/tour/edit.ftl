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

    <div class="container-fluid" id="pcont">
        <div class="page-head">
           <h2>Tour Compose</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit Tour Info</h3>
          </div>
          <div class="content">
            <form class="form-horizontal group-border-dashed" id="formId" action="update.jhtml" method="post" parsley-validate novalidate>     
			  <input type="hidden" name="tourId" value="${tour.tourId}">
			   <input type="hidden" name="menuId" value="${menuId}">
			  <div class="form-group">				
				 <label class="col-sm-3 control-label">Tour Type</label>			
				 <div class="col-sm-6">			 
					<label id="defaultType" class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
						<input class="icheck" type="radio" name="type" checked="" value="${tourType.tourTypeId}" style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
						</div>
						${tourType.typeName}
					</label>
				</div>
		      </div>
			  <div class="form-group">
				  <label class="col-sm-3 control-label">Arrival Date</label>
				  <div class="col-sm-6">
					<div class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
						<input name="arriveDateTime" class="form-control" [#if (tour.arriveDateTime)??]value="${tour.arriveDateTime?string('yyyy-MM-dd')}"[/#if] readonly="readonly" type="text" size="16">
						<span class="input-group-addon btn btn-primary">
							<span class="glyphicon glyphicon-th"></span>
						</span>
					</div>
				  </div>
			  </div>
			  <div class="form-group">
                  <label class="col-sm-3 control-label">Product Name</label>
                  <div class="col-sm-6">
                    <input type="text" name="lineName" value="${tour.lineName}" class="form-control" placeholder="country of passport">
                  </div>
              </div>  
			  <div class="form-group">
                  <label class="col-sm-3 control-label">Product Code</label>
                  <div class="col-sm-6">
                  	<input type="text" name="lineCode" value="${tour.lineCode}" class="form-control" placeholder="country of passport">
                  </div>
              </div>  
			  <div class="form-group">
                  <label class="col-sm-3 control-label">Tour Code</label>
                  <div class="col-sm-6">
                  	<input type="text" name="tourCode" value="${tour.tourCode}" class="form-control" placeholder="country of passport">
                  </div>
              </div> 
              <div class="form-group">
                  <label class="col-sm-3 control-label">Passengers</label>
                  <div class="col-sm-6">
                  	<input type="text" name="totalPeople" value="${tour.totalPeople}" class="form-control" placeholder="country of passport">
                  </div>
              </div> 
				<div class="form-group">
					<label class="col-sm-3 control-label">Guarantee Departure</label>
					<div class="col-sm-6">
						<div class="switch" id ="mySwitch" data-on-label="Yes" data-off-label="No">
							<input type="checkbox" [#if tour.isDeparture==0]checked[/#if] name="str">
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Add Other</label>
					<div class="col-sm-6">
						<div class="switch" id ="" data-on-label="Yes" data-off-label="No">
							<input type="checkbox" id="addOther" [#if itineraryInfo.isDel==1]checked[/#if] name="addOther">
						</div>
					</div>
				</div>
				<input type="hidden" value="${itineraryInfo.isDel}" id="isDel">
			  <div class="form-group" id="FRemarks" style="display: none;">
                  <label class="col-sm-3 control-label">Final Voucher Remarks</label>
                  <div class="col-sm-6">
                  	<textarea name="finalRemarks" cols="30" rows="8" class="form-control input-group">${itineraryInfo.hotelInfo}</textarea>
                  </div>
              </div>
              <div class="form-group" id="ORemarks" style="display: none;">
                  <label class="col-sm-3 control-label">Other Remarks</label>
                  <div class="col-sm-6">
                  	<textarea name="otherRemarks" cols="30" rows="8" class="form-control input-group">${itineraryInfo.itineraryInfo}</textarea>
                  </div>
              </div>  
              <div class="form-group" align="right">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="javascript:history.go(-1);" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" onclick="submit();" style="margin-left:206px;">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	[@flash_message /]
    	//chooseType("${tour.type}");
    var isDel=$("#isDel").val();
    if(isDel=="1"){
    	$("#FRemarks").show();
    	$("#ORemarks").show();
    }
    });
    
    /* 提交表单  */
    function submit(){
    	$("#formId").submit();
    }
    
    /* 取消  */
    function cancel(){
	    var basePath = window.location.href;
	    	basePath = basePath.substring(0,basePath.lastIndexOf('/'));
	   location.href = basePath+'/tourList.jhtml';
    }
    
    /* 根据值选中checkbox
    function chooseType(val){
    	$("input[name='type']").each(function(){
    		if(val == $(this).val()){
    			$(this).parent().click();
    		}
    	});
    } */
    $("#addOther").change(function(){
    var temp=$("#FRemarks").is(":hidden");
    if(temp==true){
    	$("#FRemarks").show();
    	$("#ORemarks").show();
    	
    }else{
    	$("#FRemarks").hide();
    	$("#ORemarks").hide();
    }
    });
    
</script>
</body>
</html>
