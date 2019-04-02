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
	[#include "/admin/peerUser/include/head.ftl"]
</head>
<body>
<!-- Fixed navbar -->
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="w1">
    <div class="tours_condition" style="padding: inherit;margin-top: 50px;">
    	<div style="width:90%;margin:5%;">
    	<form class="form-horizontal group-border-dashed" method="POST"   action="updatePeerUser.jhtml">
    		<div class="summary_tit" style="height: 35px;margin-bottom: 20px;text-align:left;line-height:0px; "><span style="font-size: large;margin-left:20px;margin-top:5px">Agency Info</span></div>
    		<div class="popup_from_down_list" >
	        	<div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Agency Name:</label>
	            	<input type="text" class="popup_from_control" style="width:300px;"  name="name" disabled="disabled" required value="${vender.name}"  placeholder="Please enter the Name" />
	            </div>
	            <div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Tel:</label>
	            	<input type="text" class="popup_from_control"  name="tel" style="width:300px;"  required parsley-type="number" value="${vender.tel}"  placeholder="Please enter the Tel" />
	            </div>
	            <div class="clear"></div>
	        </div>
	       <div class="popup_from_down_list">
	        	<div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Email:</label>
	            	<input type="text" class="popup_from_control" name="email" style="width:300px;"  required parsley-type="email" value="${vender.email}" placeholder="Please enter the Email" />
	            </div>
	            <div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Address:</label>
	            	<input type="text" class="popup_from_control" name="address" style="width:300px;"  value="${vender.address}" placeholder="Please enter the Address" />
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div class="popup_from_down_list">
	        	<div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Fax:</label>
	            	<input type="text" class="popup_from_control" name="fax" style="width:300px;"   value="${vender.fax}" placeholder="Please enter the Fax" />
	            </div>
	            <div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Contacts:</label>
	            	<input type="text" class="popup_from_control" name="contactor" style="width:300px;"   value="${vender.contactor}" placeholder="Please enter the Contacts" />
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div class="popup_from_down_list">
	        	<div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">ZipCode:</label>
	            	<input type="text" class="popup_from_control" name="zipCode" style="width:300px;"  maxlength="36" value="${vender.zipCode}" placeholder="Please enter the ZipCode" />
	            </div>
	            <div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Country:</label>
	            	<select id="selCountry" required class="popup_from_select" style="width:300px;height:38px" >
					<option value="">Select</option>
					[#list countryList as country]
							<option value="${country.id}" [#if vender.countryId==(country.id)] selected="selected"[/#if]>${country.countryName}</option>
					[/#list]
				</select>    
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div class="summary_tit" style="height: 35px;margin-bottom: 20px;margin-top:50px;text-align:left;line-height:0px; "><span style="font-size: large;margin-left:20px;margin-top:5px">User Info</span></div>
    		<div class="popup_from_down_list">
	        	<div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">User Name:</label>
	            	<input type="text" class="popup_from_control" disabled="disabled" style="width:300px;" name="peerUserName" required value="${peerUser.peerUserName}"  placeholder="Please enter the Name" />
	            </div>
	            <div class="popup_from_down_list_left fl" style="width:453px;">
	            	<label class="popup_from_label">Password:</label>
	            	<input type="text" class="popup_from_control" style="width:300px;" name="password" required placeholder="Please enter the Password" value="${peerUser.password}"/>
	            </div>
	            <div class="clear"></div>
	        </div>
              <!--div class="form-group">
                <label class="col-sm-3 control-label">LOGO</label>
                <div class="col-sm-6">
                	<img id="image"src="${base}${peerUser.logoAddress}" width="100" height="100"/>
                	<a href="javascript:void(0);" class="btn btn-success" id="upload" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>Upload</a>
                	<input type="hidden" name="logoAddress" id="fileName"/>
                </div>
              </div--> 
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <input name="type" type="hidden"  value="${vender.type}">
                  <input name="venderId" type="hidden"  value="${vender.venderId}">
                  <input name="userId" type="hidden"  value="${vender.userId}">
                  <input name="deptId" type="hidden"  value="${vender.deptId}">
                  <input name="type" type="hidden"  value="${vender.type}">
                  <input name="peerUserId" type="hidden"  value="${peerUser.peerUserId}">
                  <input name="peerId" type="hidden"  value="${peerUser.peerId}">
                  <input name="level" type="hidden"  value="${peerUser.level}">
                  <input name="brandMange" type="hidden"  value="${peerUser.brandMange}">
                  <button type="submit" class="btn btn-primary" style="margin-right: 130px;float:right;width:90px">Save</button>
                </div>
              </div>
            </form>
         </div>
    </div>
</div>

[#include "/admin/peerUser/include/foot.ftl"]
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
</script>
</body>
</html>
