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
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
                <li class="active">Product-Hotel</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">
          		<h3>${groupLine.tourName}</h3>							
          </div>
          <div class="content">
            <input name="groupLineId" value="${groupLine.id}" type="hidden">
            <table>
		        <thead>
		            <tr>
		                <th>Date</th>
		                <th>Name</th>
		                <th>Action</th>
		            </tr>
		        </thead>
		        <tbody>
		        [#list hotels as hotels]
		        	<tr>
		                <td>The ${hotels.dayNum} Day</td>
		                <td>${hotels.hotelName}</td>
		                <td>
		                	<i class="fa fa-pencil"></i><a href="editHotelForGroupLine.jhtml?id=${hotels.id}&groupLineId=${groupLine.id}">Edit</a>
		                </td>
		            </tr>
		        [/#list]
		        </tbody>
		     </table>
          </div>
        </div>
      </div>
    </div>
</div>
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Set Hotel</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form action="saveHotel.jhtml" style="border-radius: 0px;" method="post">
	     <div class="modal-body form">
	     	<div class="form-group">
                <label>DayNum</label>
                <div>
                  <select type="text" name="dayNum" class="select2">
                    [#list dayNums as dayNum]
                        <option value="${dayNum}">The ${dayNum} Day</option>
                    [/#list]
                  </select>
                </div>
            </div>
	      	<div class="form-group">
	          <label>Hotel Name&nbsp;&nbsp;&nbsp;&nbsp;<div style="float:right;width:30px;"><a id="name_option" class="input" style="font-weight:bold;cursor:pointer;">Entry</a></div></label>
	          <div>
	          	<input id="select_hotelName" name="hotelName" type="hidden" class="form-control"></input>
	          	<select type="text" name="id" class="select2" onchange="getHotel(this.value);">
		            <option value="0">--Select--</option>
		            [#list hotelList as hotel]
		            	<option value="${hotel.id}">${hotel.hotelName}</option>
		            [/#list]
	            </select>
	          </div>
	        </div>
	        <div class="form-group">
                <label>Start</label>
                  <select type="text" name="standard" class="select2" id="select_standard">
                       <option value="0">--Select--</option>
                       <option value="5">5</option>
                       <option value="4">4</option>
                       <option value="3">3</option>
                       <option value="2">2</option>
                       <option value="1">1</option>
                  </select>
             </div>
	        <div class="form-group">
                <label>City</label>
	            <select type="text" name="cityId" class="select2" id="select_cityId">
		            <option value="">--Select--</option>
		            [#list citys as city]
		            	<option value="0">--Select--</option>
		            	<option value="${city.id}">${city.cityName}</option>
		            [/#list]
	            </select>
            </div>
	        <div class="form-group">
	          <label>Address</label> 
	          	<input name="address" type="text" class="form-control" id="select_address"></input>
	        </div>
	        <div class="form-group">
                <label>Tel</label>
                <div>
                  <input type="text" name="tel" class="form-control"  />
                </div>
              </div>  
	        <div class="form-group">
	          	<input name="groupLineId" value="${groupLine.id}" type="hidden" >
	        </div>
	    </div>
	    <div class="modal-footer">
	        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
	        <button type="submit" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
	    </div>
    </form>
   </div>
</div>
<div class="md-overlay"></div>

[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $('.md-trigger').modalEffects();
        
         [@flash_message /]
       var oTable = $('#datatables').DataTable({
            "processing": true,
            "bSort":false,
            "filter": false
        });
        
       $('#name_option').on('click', function () {
       		if($(this).attr('class')=="input"){
       			$(this).html("选择");
       			$(this).removeClass("input").addClass("select");
       			$("input[name='hotelName']").attr("type", "text");
       			$("select[name='id']").css("display", "none");
       			$('#s2id_autogen1').css("display", "none");
       			$("select[name='id']").select2("val", "0");
       			getHotel(0);
       		}else{
       			$(this).html("Entry");
       			$(this).removeClass("select").addClass("input");
       			$("input[name='hotelName']").attr("type", "hidden");
       			$("select[name='id']").css("display", "");
       			$('#s2id_autogen1').css("display", "");
       		}
            
        }); 
    });
    
    /* 根据酒店Id获得酒店信息  */
    function getHotel(id){
    	if(id == 0){
    		$("#select_hotelName").val('');
    		$("#select_standard").select2("val", "");
    		$("#select_cityId").select2("val", "");
    		$("#select_address").val('');
    		return;
    	}
    	$.post("getHotel.jhtml",{'id':id},function(hotel){
    		$("#select_hotelName").val(hotel.hotelName);
    		$("#select_standard").select2("val", hotel.standard);
    		$("#select_cityId").select2("val", hotel.cityId);
    		$("#select_address").val(hotel.address);
    	});
    }
</script>
</html>
