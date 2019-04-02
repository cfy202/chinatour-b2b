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
          <div class="header" style="font-size:16px;">
          	Product Name  :  ${groupLine.tourName}	
          	<input id="groupLineId" type="hidden" value="${groupLine.id}">						
          </div>
          <div class="content">	
          		<div>
          			<input type="hidden" value="${currencyId}" id="currencyId">
          			<font size="3">Departure Date:</font>
          				[#list monthList as month]
          					<p style="margin:10px">${month}</p>
          					<ul style="padding-left:50px;overflow: hidden;width:100%">
          					[#list list as departureTime]
          						[#if month==departureTime[0..6]]
          							<li style="width:87px;background-color:#6699FF;padding: 5px;margin:5px;white-space: nowrap;display: inline;color:#ffffff"><input type="checkBox" name="delTime" value="${departureTime}">${departureTime}</li>
          						[/#if]
          					[/#list]
          					</ul>
          				[/#list]
          				<span><button class="btn btn-default" onclick="javascript:history.go(-1)" style="margin-left:206px;" type="button">Cancel</button><button class="btn btn-primary" style="margin-left:500px;" onclick="save()">Sold Out</button></spna>
          		</div>						
          </div>
        </div>
      </div>
    </div>
</div>
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/date/kalendae.standalone.js'/]" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    });
    function save(){
    	var groupLineId=$("#groupLineId").val();
    	var currencyId=$("#currencyId").val();
    	var delTime="";
    	var time="";
    	var unCheckedBoxs = $("input[name='delTime']").not("input:checked");
    	$("input[name='delTime']:checked").each(function(i){ 
            	delTime += $(this).val()+',';  
    	});
    	$("input[name='delTime']:not(:checked)").each(function(i){ 
            	time += $(this).val()+',';  
    	});
    	if(delTime==""){
    		alert("Please choose the tour date to be closed!");
    	}else{
    		if(confirm("Whether to close the group or not？")){
    			window.location.href="updateDeparture.jhtml?groupLineId="+groupLineId+"&delTime="+delTime+"&time="+time+"&currencyId="+currencyId;
    		}
    	}
    }
</script>
</body>
</html>
