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
<!-- Fixed navbar -->http://my.mi.com/portal
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="w1">
	<div class="fl search_list">
    	<form action="commission.jhtml" method="get" id="myinfo">
        	<input name="orderNo" class="search_1" value="${order.orderNo}" placeholder="Booking NO.">
            <input name="tourCode" class="search_1" value="${order.tourCode}" placeholder="Tour Code">
            <input name="lineName" class="search_1" value="${order.lineName}" placeholder="Tour Name">
            <input id="search_refNo" name="refNo" class="search_1" value="${order.refNo}" placeholder="REF NO">
            <input id="search_contact" name="contact" class="search_1" value="${order.contact}" placeholder="Consultant">
            Arrival Date：
            <input id="search_beginningDate" name="bookingBeginningDate" class="search_1" [#if order.bookingBeginningDate??]value="${order.bookingBeginningDate?string("yyyy-MM-dd")}"[/#if] placeholder="From">
            -
            <input id="search_endingDate" name="bookingEndingDate" class="search_1" [#if order.bookingEndingDate??]value="${order.bookingEndingDate?string("yyyy-MM-dd")}"[/#if] placeholder="TO">
            <input type="submit" class="search_sub" id="search_sub" value="Search">
        </form>
    </div>
    <div class="r1 print">
    	<a style="cursor:pointer;" id="printCommission"><img src="[@spring.url '/resources/peerUser/'/]images/print.png" width="18" height="17">&nbsp;<span>Print</span></a>
    </div>
    <div class="clear"></div>
    <div class="search_line"></div>
    <div class="search_tab" id="printContent" style="padding: inherit;">
    	<table cellpadding="0" cellspacing="0" width="100%">
        	<tr class="tr_1">
                <th>BOOKING NO.</th>
                <th>TOUR NAME</th>
                <th align="center">ARRIVAL DATE</th>
                <th align="center">BOOKING AGENT</th>
                <th align="center">TOUR　COST</th>
                <th align="center">COMMISSION</th>
                <th align="center">SINGLE SUPPL- EMENT</th>
                <th align="center">PREPAID SERVICE FEE</th>
                <th align="center">PREPAID EXCUR- SIONS</th>
                <th align="center">PRE/POST</th>
                <th align="center">EXTRA TRANSP- ORTATION</th>
                <th align="center">OTHER CHARGE</th>
                <th align="center">OTHER DISCOUNT</th>
                <th align="center">SETTLEMENT PRICE</th>
                <th align="center">PAID</th>
                <th align="center" style="border-right:0px">UNPAID</th>
            </tr>
            [#list orderList as order]
            	<tr>
	                <td><a href="tourOrderEdit.jhtml?id=${order.orderId}" target="_blank">${order.orderNo.substring(0,order.orderNo.indexOf('-'))}</a></td>
	                <td>${order.lineName}</td>
	                <td align="center">${order.arriveDateTime?string('yyyy-MM-dd')}</td>
	                <td align="center">${order.contactName}</td>
	                <td align="center">${order.cusPrice}</td>
	                <td align="center">${order.peerUserFee}</td>
	                <td align="center">${order.singleProfit}</td>
	                <td align="center">${order.opProfit}</td>
	                <td align="center">${order.agentProfit}</td>
	                <td align="center">${order.payTotalSum}</td>
	                <td align="center">${order.costTotalSum}</td>
	                <td align="center">${order.cost}</td>
	                <td align="center">${order.priceExpression}</td>
	                <td align="center">${order.commonTourFee}</td>
	                <td align="center">[#if order.costState==2]${order.commonTourFee}[#else]0[/#if]</td>
	                <td align="center">[#if order.costState!=2]${order.commonTourFee}[#else]0[/#if]</td>
	                
	            </tr>
            [/#list]
            	<tr>
	            	<td align="center"class="tab_t" ><span class="total">Total:</span></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t" align="center">${orders.cusPrice}</td>
	                <td class="tab_t" align="center">${orders.peerUserFee}</td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t"></td>
	                <td class="tab_t" align="center">${orders.commonTourFee}</td>
	                <td class="tab_t" align="center">${orders.cost}</td>
	                <td class="tab_t" align="center">${orders.priceExpression}</td>
	            </tr>
        </table>
    </div>
</div>

[#include "/admin/peerUser/include/foot.ftl"]
<script src="[@spring.url '/resources/js/jquery.PrintArea.js'/]"></script>
<script type="text/javascript">
$("#printCommission").click(function(){
	$("#printContent").printArea();	
});

$(function(){
	$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
	$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
    })
</script>
</body>
</html>
