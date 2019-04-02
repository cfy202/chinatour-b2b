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
                <li><a href="#">Tour</a></li>
                <li class="active">Room/Tour Sharing</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/roomSharing/update.jhtml" parsley-validate novalidate>
               <input type="hidden" name="roomSharingId" value="${roomSharing.roomSharingId}" />
               <input type="hidden" name="roomOrTour" value="${roomSharing.roomOrTour}" />
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Code</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="productCode" value='${roomSharing.productCode}' required placeholder="Please enter the Product Code" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control"  name="productName" value='${roomSharing.productName}' placeholder="Please enter the Product Name" />
                </div>
              </div>
               [#if (roomSharing.roomOrTour)==2]	
            <div class="form-group">
                <label class="col-sm-3 control-label">Total Passengers</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" value='${roomSharing.totalPeople}' name="totalPeople" parsley-type="number"/>
                </div>
              </div>
                 [/#if]
                   [#if (roomSharing.roomOrTour)==1]	
          <div class="form-group">
               <label class="col-sm-3 control-label">Gender</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" [#if roomSharing.sex ==1] checked="checked" [/#if] name="sex" class="icheck" value="1"> Female</label> 
                  <label class="radio-inline"> <input type="radio" [#if roomSharing.sex ==2] checked="checked" [/#if] name="sex" class="icheck" value="2"> Male</label> 
                </div>
              </div>
                   [/#if]
              <div class="form-group">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6">
	               	  <div class="input-group date datetime" data-min-view="2" data-date-format="yyyy-mm-dd">
	                    <input  name="arrivalDate" class="form-control" size="16" type="text" [#if roomSharing.arrivalDate??]value="${roomSharing.arrivalDate?string("yyyy-MM-dd")}" [/#if] readonly>
	                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
	                  </div>
                 </div>
              </div>
              
               <div class="form-group">
                <label class="col-sm-3 control-label">Tour Type</label>
               <div class="col-sm-6">
				<select id="selCountry" name="tourType"  class="select2" >
					<option value="">Select</option>
					[#list tourTypeList as tourType]
						<option value="${tourType.tourTypeId}" [#if roomSharing.tourType==(tourType.tourTypeId)] selected="selected"[/#if] >
							${tourType.typeName}
						</option>
					[/#list]
				</select>
                </div>
              </div>
               [#if (roomSharing.roomOrTour)==1]	
              <div class="form-group">
                <label class="col-sm-3 control-label">Room Type</label>
                <div class="col-sm-6">
				<select id="selCountry" name="roomType"  class="select2" >
					<option value="">Select</option>
					[#list constant.GUEST_ROOM_TYPES as room]
						<option value="${room}" [#if roomSharing.roomType==room] selected="selected"[/#if] >
							${room}
						</option>
					[/#list]
				</select>
                </div>
              </div>
              [/#if]
              <div class="form-group">
                <label class="col-sm-3 control-label">Status</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" name="status" value="0" [#if roomSharing.status ==0] checked="checked" [/#if] class="icheck"> Pending</label> 
                  <label class="radio-inline"> <input type="radio" name="status" value="1" [#if roomSharing.status ==1] checked="checked" [/#if] class="icheck"> Closed</label> 
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Remark</label>
                <div class="col-sm-6">
                	<textarea name="remark" style="width:100%;height:100px">${roomSharing.remark}</textarea>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="history.go(-1);" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">update</button>
                  <!--<button type="button" onclick="redirect(2)" class="btn btn-default">Save and New</button>-->
                </div>
              </div>
            </form>
          </div>
        </div>
        
      </div>
    </div>

</div>

[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function () {
	App.init();
});   
</script>
</body>
</html>
