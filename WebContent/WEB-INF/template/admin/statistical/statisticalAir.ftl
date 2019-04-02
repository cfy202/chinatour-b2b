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
            <h3>Statistics</h3>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Statistics</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="stats_bar">
					    <div class="butpro butstyle flat" style="height:auto;margin-right:10%">
					        <div class="stat">
					        	<div><span class="spk1">
					        		<canvas style="display: inline-block; width: 74px; height: 16px; vertical-align: top;" width="74" height="16"></canvas>
					        	</span></div>
					        	<span style="font-size:12px;">
					        		<a href="[@spring.url '/admin/statistical/agentStatistical.jhtml'/]"> <font size="3"><b>Agent Statistics</b></font> </a>
					        	</span>
					        </div>
					    </div>
					    <div class="butpro butstyle flat" style="height:auto;margin-right:10%">
					        <div class="stat">
					        	<div><span class="spk2">
					        		<canvas style="display: inline-block; width: 74px; height: 16px; vertical-align: center;" width="74" height="16"></canvas>
					        	</span></div>
					        	<span style="font-size:12px;">
					        	 <a href="[@spring.url '/admin/statistical/retailStatistical.jhtml'/]"> <font size="3"><b>Retail Statistics</b></font> </a>
					        	</span>
					        </div>
					    </div>
					    <div class="butpro butstyle flat" style="height:auto;">
					        <div class="stat">
					        	<div><span class="spk1">
					        		<canvas style="display: inline-block; width: 74px; height: 16px; vertical-align: top;" width="74" height="16"></canvas>
					        	</span></div>
					        	<span style="font-size:12px;">
					        		<a href="[@spring.url '/admin/statistical/agencyStatistical.jhtml'/]"> <font size="3"><b>Wholesale Statistics</b></font> </a>
					        	</span>
					        </div>
					    </div>
					</div>
					<div class="stats_bar">
					    <div class="butpro butstyle flat" style="height:auto;margin-right:10%">
					        <div class="stat">
					        	<div><span class="spk1">
					        		<canvas style="display: inline-block; width: 74px; height: 16px; vertical-align: center;" width="74" height="16"></canvas>
					        	</span></div>
					        	<span style="font-size:12px;">
					        		<a href="[@spring.url '/admin/statistical/venderStatistical.jhtml'/]"> <font size="3"><b>Vender Statistics</b></font> </a> 
					        	</span>
					        </div>
					    </div>
					    <div class="butpro butstyle flat" style="height:auto;margin-right:10%">
					        <div class="stat">
					        	<div><span class="spk2">
					        		<canvas style="display: inline-block; width: 74px; height: 16px; vertical-align: center;" width="74" height="16"></canvas>
					        	</span></div>
					        	<span style="font-size:12px;">
					        		<a href="[@spring.url '/admin/statistical/airlineStatisticalBooking.jhtml'/]"> <font size="3"><b>Airline Statistics(Booking)</b></font> </a> 
					        	</span>
					        </div>
					    </div>
					    <div class="butpro butstyle flat" style="height:auto;">
					        <div class="stat">
					        	<div><span class="spk1">
					        		<canvas style="display: inline-block; width: 74px; height: 16px; vertical-align: center;" width="74" height="16"></canvas>
					        	</span></div>
					        	<span style="font-size:12px;">
					        		<a href="[@spring.url '/admin/statistical/airlineStatistical.jhtml'/]"> <font size="3"><b>Airline Statistics(Departure)</b></font> </a> 
					        	</span>
					        </div>
					    </div>
					</div>
				</div>
		</div>
</div>
[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        //App.dashBoard();        
         /*Sparklines*/
        $(".spk1").sparkline([2,4,3,6,7,5,8,9,4,2,6,8,8,9,10,15,18,16,5], { type: 'bar', width: '100px', height:'50px', barColor: '#60c060'});
        $(".spk2").sparkline([2,4,3,6,7,5,8,9,4,2,6,8,8,9,10,15,18,16,5], { type: 'bar', width: '100px', height:'50px', barColor: '#60c060'});
        
    });
</script>
</html>
