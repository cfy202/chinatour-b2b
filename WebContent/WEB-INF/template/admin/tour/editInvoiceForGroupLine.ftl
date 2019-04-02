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
            <h2>Tour</h2>
            <div class="pull-right option-left">
	            <div class="new">
            		<button type="button" class="btn btn-success btn-flat md-trigger" id="submitButton">Complete &nbsp;&nbsp;</button>
            		<a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
            	</div>
             </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
                <li class="active">Hotel</li>
            </ol>
        </div>
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">
          		<h3>${groupLine.tourName}</h3>							
          </div>
         <form class="form-horizontal group-border-dashed" id="formId" action="saveInfomationForOp.jhtml" method="post">
         	<input type="hidden" name="tourId" value="${tourId}"/>
         	<input type="hidden" name="isChanged" value="${isChanged}"/>
         	<input type="hidden" name="itineraryInfoId" value="${itineraryInfo.itineraryInfoId}"/>
         	
          <div class="content">
            <input name="groupLineId" value="${groupLine.id}" type="hidden"/>
            <input id="hotelInfo" name ="hotelInfo" type="hidden"/>
            <label>Itinerary：</label>
            <table id="datatables" class="table table-bordered" >
		        <thead>
		            <tr>
		            	<th>Date</th>
		                <th>Name</th>
		                <th>Description(Chinese)</th>
		                <th>Description(English)</th>
		            </tr>
		        </thead>
		        <tbody>
		        [#list groupRoutes as groupRoute]
		        	<tr>
		        		<td> The ${groupRoute.dayNum} Day</td>
		                <td>${groupRoute.routeName}</td>
		                <td>${groupRoute.routeDescribeForUs} </td>
		                <td>${groupRoute.routeDescribeForEn}</td>
		            </tr>
		        [/#list]
		        </tbody>
		     </table>
          </div>
          <div class="content">
            <input name="groupLineId" value="${groupLine.id}" type="hidden">
            <label>Hotel Info:</label>
            <table id="datatables" class="table table-bordered" >
		        <thead>
		            <tr>
		            	<th>DayNum</th>
		                <th>Name</th>
		                <th>Star</th>
		                <th>City</th>
		                <th>Address</th>
		                <th>Tel</th>
		                <th>Action</th>
		            </tr>
		        </thead>
		        <tbody>
		        [#list hotels as hotels]
		        	<tr class="hotel">
		                <td>The <input type="text"  name="hotelList[${hotels_index}].dayNum" readonly="readonly" style="border:0px;width:20px;"   value="${hotels.dayNum}"/>Day</td>
		                <td><input type="text"   name="hotelList[${hotels_index}].hotelName" readonly="readonly" style="border:0px;"  value="${hotels.hotelName}"/></td>
		                <td><input type="text"   name="hotelList[${hotels_index}].standard" readonly="readonly" style="border:0px;width:20px;"     value="${hotels.standard}"/></td>
		                <td><input type="text"  name="hotelList[${hotels_index}].cityName" readonly="readonly" style="border:0px;"  value="${hotels.cityName}"/></td>
		                <td><input type="text"   name="hotelList[${hotels_index}].address" readonly="readonly" style="border:0px;"    value="${hotels.address}"/></td>
		                <td><input type="text"   name="hotelList[${hotels_index}].tel" readonly="readonly" style="border:0px;"    value="${hotels.tel}"/></td>
		                <td onclick="exchange(this)">
		                	<i class="fa fa-pencil"></i><a href="#" >Edit</a>
		                </td>
		            </tr>
		        [/#list]
		        </tbody>
		     </table>
          </div>
          
         
          <div class="content">
          	<label>Contact:&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:red;">*</font></label><label id="message" style="color:red;"></label>
          	 <textarea id="contact" name="contact" rows="4" style="width:100%;">${itineraryInfo.contact}</textarea>
          </div>
          </form>
        </div>
      </div>
    </div>
	</div>
</div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
       App.init();
    });
    
    function exchange(object){
    	$(object).siblings().each(function(){
    		$(this).find("input").attr("readonly",false);
    		$(this).find("input").css("border","1px solid #ccc");
    		$(this).find("input").css("height","32px");
    		
    	});
    }
    
    $("#submitButton").click(function(){
    	var contact = $("#contact").val();
    	if(contact==""){
    		$("#message").html("This value is required");
    		return false;
    	}
    	$("#formId").submit();
    });
</script>
</body>
</html>
