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
            <h2>Confirmation</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="content">
			    <div id='body' style='background-color:#F5F1E8;width:900px;;font-family:微软雅黑;border-top:#FFF 2px solid;color:#333; position:relative;margin:0 auto; '>
			  		<div style="padding:0 20px 10px 20px;background-color:#FFF; margin:20px; font-size:13px; line-height:30px;">
			  			<div style='width:100%;height:100px; text-align:center; padding-top:20px;'>
				  			<img src="[@spring.url '/resources/images/chinatour1Log.png'/]"> 
				  		</div>
						<div style="text-align:center; margin-top:10px;"><span style="font-size:22px; font-weight:bold;font-family:Times New Roman, Times, serif, sans-serif;">Confirmation Letter</span></div>
			  			<div id='outId'>
							<table border="0" cellpadding="0" cellspacing="0">
								<tr >
									<td colspan="2">AGENT:  </td>
								</tr>
								<tr >
									<td>Tour Code：</td>
									<td>INVOICE&nbsp;&nbsp;NO:  </td>
								</tr>
								<tr >
									<td>Product Name： </td>
									<td>Arrival Date：</td>
								</tr>
							</table>
							
			      			<div>
			      				<span style=" font-weight:bold;font-size:14px;  ">一、Passenger Info</span>
			      				<!-- cellspacing="0" cellpadding="5" bordercolor="#666666" border="1" align="left" style="table-layout:fixed; border-collapse: collapse;float:left; " -->
								<table width="720" cellspacing="0" cellpadding="5" bordercolor="#666666" border="1" style="table-layout:fixed; border-collapse: collapse;">
									<tbody>
										<tr bgcolor="#ebebeb" align="center" style="font-weight:bold; font-size:12px; font-family:Times New Roman, Times, serif, sans-serif;"> 
											<td width="">No.</td>
											<td width="">Last Name</td>
											<td width="">First Name</td>
											<td width="">Middle Name</td>
											<td width="">Sex</td>
											<td width="">Nationality</td>
										</tr>
									</tbody>
								</table>
							</div>
			      			<div style="margin-top:10px;">
								<span style=" font-weight:bold;font-size:14px;  ">二、Flight Info</span>
		        			</div>
		
							<div>
								<span style=" font-weight:bold;font-size:14px;  ">三、The Specific Itinerary</span>
								<div id="ItineraryContentDiv" onclick="editDiv('Itinerary')">${itinerary.itineraryDescribe}</div>
								<div id="Itinerary" style="display:none">
					   				<textarea id="ItineraryContent" cols="" rows="8"  name="itineraryinfo.itineraryDescribe"></textarea>
					   			</div>
							</div>		
		        			<div>
		        				<span style=" font-weight:bold;font-size:14px;  ">四、Hotel Info</span>
						        <div id="HotelinfoContentDiv"  onclick="editDiv('Hotelinfo')">${itinerary.hotelInfo}</div>
		        				<div id="Hotelinfo" style="display:none">
		        					<textarea style="width:100%;  border:#CCC 1px solid;" id="HotelinfoContent" cols="" rows="8" name="itineraryinfo.hotelInfo">${itinerary.hotelInfo}</textarea>
		        				</div>
		        			</div>
		        			
							<div>
								<div id="ContactContentDiv" onclick="editDiv('Contact')">${itinerary.contact}</div>	
		        				<div id="Contact" style="display:none">
		        					<textarea style="width:100%;  border:#CCC 1px solid;" id="ContactContent" cols="" rows="8" name="itineraryinfo.contact">${itinerary.contact}</textarea>
		        				</div>
							</div>
						</div>
						
						<div style="color:#111111">
							<div style="width:720px; line-height:20px;margin-bottom:10px; font-size:12px;color:#864D44;">*Remind：</div>
							<div style="width:690px; line-height:20px;margin-bottom:10px; font-size:12px;">For traveler without pick-up service, we will provide you the detailed hotel information, please check in with your passport at the hotel, our guide will contact you in time.  </div>
						</div> 
					</div>
				</div>
				<div style="width:760px;height:51px; text-align:right;margin:0px 20px 0px 0px;">
				</div>
			</div>
          </div>
        
      </div>
    </div>
    
</div>


[#include "/admin/include/foot.ftl"]
<script type="text/javascript" src="[@spring.url '/resources/js/jspdf.debug.js'/]"></script> 
<script type="text/javascript" src="[@spring.url '/resources/js/basic.js'/]"></script> 
<script type="text/javascript">
$(document).ready(function () {
	App.init();
});
</script>
</body>
</html>
