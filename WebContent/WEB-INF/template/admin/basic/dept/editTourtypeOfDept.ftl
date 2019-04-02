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
            <h2>Tour Type</h2>
            <ol class="breadcrumb">
                <li><a href="[@spring.url '/admin'/]">Home</a></li>
                <li><a href="#">SettingS</a></li>
                <li class="active">Office</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit </h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" method="POST"   action="${base}/admin/dept/updateTourtypeOfDept.jhtml">
              <div class="form-group">
                <label class="col-sm-3 control-label">Office Name</label>
                <div class="col-sm-6">
                  <input type="text" class="form-control" name="deptName" value="${dept.deptName}" />
                  <input type="hidden" class="form-control" name="id" value="${dept.deptId}"/>
                </div>
              </div>
              <div class="form-group">
                 <label class="col-sm-3 control-label">Tour Type:</label>
				 <div class="col-sm-6">
                    [#list tourType as tourType]
		               <div class="radio">
		                   <label>
		                   		<input type="checkbox" name="tourTypeOfDeptList[${tourType_index}].tourTypeId" id="${tourType_index}"
		                   			[#list tourTypeOfDeptS as tourTypeOfDept] 
                    					[#if tourType.tourTypeId==tourTypeOfDept.tourTypeId]
                    						checked="checked" 
                    		 			[/#if]
                     				[/#list]
                    				value="${tourType.tourTypeId}"/>
                    			${tourType.typeName}
                    		</label>
                 		</div>
                 		<label class="col-sm-3 control-label">StartTime</label>
						<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
							<input type="text" class="form-control" name="tourTypeOfDeptList[${tourType_index}].startTime" id="start${tourType_index}"  placeholder="YYYY-MM-DD"
							[#list tourTypeOfDeptS as tourTypeOfDept] 
								 [#if tourType.tourTypeId==tourTypeOfDept.tourTypeId&&tourTypeOfDept.startTime??]
								 	value="${tourTypeOfDept.startTime?string("yyyy-MM-dd")}"
						         [/#if]
					        [/#list]
							 size="10">
							<span class="input-group-addon btn btn-primary">
							     <span class="glyphicon glyphicon-th"></span>
					        </span>
					    </div>
					  <label class="col-sm-3 control-label">EndTime</label>
						<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">
							<input type="text" class="form-control" name="tourTypeOfDeptList[${tourType_index}].endTime" id="end${tourType_index}"  placeholder="YYYY-MM-DD"
							[#list tourTypeOfDeptS as tourTypeOfDept] 
								 [#if tourType.tourTypeId==tourTypeOfDept.tourTypeId&&tourTypeOfDept.endTime??]
								 	value="${tourTypeOfDept.endTime?string("yyyy-MM-dd")}"
						         [/#if]
						     [/#list]
							size="10">
							<span class="input-group-addon btn btn-primary">
							     <span class="glyphicon glyphicon-th"></span>
					        </span>
					    </div>
                     [/#list]
                     [#list tourTypeOfDeptS as tourTypeOfDept]
                    		<input type="hidden" name="tourTypeOfDeptList[${tourTypeOfDept_index}].tourTypeOfDeptId"value="${tourTypeOfDept.tourTypeOfDeptId}"/>
                    [/#list]
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

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$('input').iCheck({
			checkboxClass: 'icheckbox_square-blue checkbox',
			radioClass: 'iradio_square-blue'
		});
    	
    	/*$("input[name^='tourTypeOfDeptList']").each(function(){
			$(this).on("ifChanged",function(){
				che(this);
			 });
		});*/
    });
    
    //判断checkbox是否选中    是时间不能为空    否移除 required
    //废弃
	/*function che(num){
		var id=$(num).attr("id");
		var startId=$("#start"+id).val();
		var endId=$("#end"+id).val();
		alert(endId);
		if($(num).is(':checked')&&(startId!=""||endId!="")) {
			$("#start"+id).attr("required","required");
			$("#end"+id).attr("required","required");
		} else {
			$("#start"+id).removeAttr("required");
			$("#end"+id).removeAttr("required");
		}
	}*/
</script>
</body>
</html>
