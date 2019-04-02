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
<div class="w1">
    <div class="r1 print" id="printCommission">
    	<a href=""><img src="[@spring.url '/resources/peerUser/'/]images/print.png" width="18" height="17">&nbsp;<span>Print</span></a>
    </div>
    <div class="clear"></div>
    <div class="search_line"></div>
    <div class="search_tab" id="printContent">
    	<table cellpadding="0" cellspacing="0" width="100%">
        	<tr class="tr_1">
            	<th width="7%" align="center">#</th>
                <th width="17%">BOOKING NO.</th>
                <th width="38%">REMARKS</th>
                <th width="12%" align="center">TOUR　COST</th>
                <th width="12%" align="center">COMMISSION</th>
                <th width="12%" align="center">SETTLEMENT PRICE</th>
                <th width="12%" align="center">PAID</th>
                <th width="12%" align="center">UNPAID</th>
            </tr>
            [#list orderList as order]
            	<tr>
	            	<td align="center">${order_index+1}</td>
	                <td>${order.orderNo}</td>
	                <td class="tab_r">${order.lineName}/${order.arriveDateTime?string("yyyy-MM-dd")}</td>
	                <td align="center">${order.pay}</td>
	                <td align="center">${order.peerUserFee}</td>
	                <td align="center">${order.commonTourFee}</td>
	                <td align="center">[#if order.reviewState==4]${order.commonTourFee}[#else]0[/#if]</td>
	                <td align="center">[#if order.reviewState!=4]${order.commonTourFee}[#else]0[/#if]</td>
	            </tr>
            [/#list]
            	<tr>
	            	<td align="center"></td>
	                <td></td>
	                <td class="tab_r"></td>
	                <td align="center">${orders.pay}</td>
	                <td align="center">${orders.peerUserFee}</td>
	                <td align="center">${orders.commonTourFee}</td>
	                <td align="center">${orders.cost}</td>
	                <td align="center">${orders.priceExpression}</td>
	            </tr>
        </table>
    </div>
</div>

<script type="text/javascript" src="[@spring.url '/resources/peerUser/js/jquery-1.10.2.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/shop/js/common.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.gritter/js/jquery.gritter.js'/]"></script>

<script type="text/javascript" src="[@spring.url '/resources/js/jquery.nanoscroller/jquery.nanoscroller.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/behaviour/general.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.ui/jquery-ui.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.sparkline/jquery.sparkline.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.easypiechart/jquery.easy-pie-chart.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.nestable/jquery.nestable.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.switch/bootstrap-switch.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.datetimepicker/js/bootstrap-datetimepicker.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.select2/select2.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/skycons/skycons.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.slider/js/bootstrap-slider.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.niftymodals/js/jquery.modalEffects.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap.summernote/dist/summernote.min.js'/]"></script>

<script type="text/javascript" src="[@spring.url '/resources/js/jquery.datatables/jquery.datatables.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.datatables/jquery.datatables.zh_CN.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.datatables/bootstrap-adapter/js/datatables.js'/]"></script>

<script src="[@spring.url '/resources/js/jquery.vectormaps/jquery-jvectormap-1.2.2.min.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-us-merc-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-world-mill-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-fr-merc-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-uk-mill-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-us-il-chicago-mill-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-au-mill-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-in-mill-en.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-map.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.vectormaps/maps/jquery-jvectormap-ca-lcc-en.js'/]"></script>

<script type="text/javascript" src="[@spring.url '/resources/js/jquery.magnific-popup/dist/jquery.magnific-popup.min.js'/]"></script>

<script type="text/javascript" src="[@spring.url '/resources/js/behaviour/voice-commands.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/bootstrap/dist/js/bootstrap.min.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.flot/jquery.flot.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.flot/jquery.flot.pie.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.flot/jquery.flot.resize.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/jquery.flot/jquery.flot.labels.js'/]"></script>
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/hogan-3.0.1.js'/]"></script>
<script type="text/javascript" src="[@spring.url '/resources/js/basic/basicForPeer.js'/]"></script>
<script src="[@spring.url '/resources/js/modernizr.js'/]" type="text/javascript"></script>

<script src="[@spring.url '/resources/js/jquery.icheck/icheck.min.js'/]" type="text/javascript"></script><!-- -->

<script type="text/javascript">

$("#printCommission").click(function(){
		$("#printContent").printArea();	
});
</script>
</body>
</html>
