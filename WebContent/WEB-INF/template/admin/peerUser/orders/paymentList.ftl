[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"]/]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <link href="[@spring.url '/resources/peerUser/css/payment.css'/]" rel="stylesheet" type="text/css" />
    <title>Edit Booking</title>
    [#include "/admin/peerUser/include/head.ftl"]
</head>
<body>
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="bg">
    <div class="w1">
        <form method="post" id="addPaymentForm">
        <div class="fl">
        <div class="tourinfo_leftbox">
        	<div class="tourinfo_name">
        		<span>Payment-${order.orderNo}</span>
        		<input type="hidden" name="orderId" value="${order.id}">
				<input type="hidden" name="orderNo" value="${order.orderNo}">
        	</div>
            <div class="tourinfo_box">
                <div class="tourinfo_date">
                	<div class="date_d fl">
                    	<label>Pay Method:</label>
                        <select class="paymethod" name="payType">
                        	<option>--Select--</option>
                        	[#list payTypeList as payType]	
                          		<option value="${payType}">${payType}</option>
                          	[/#list]
                        </select>
                    </div>
                    <div class="date_d fl">
                    	<label>Pay Info:</label>
                        <input type="text" name="payInfo" id="payInfo" class="tourDate_d">
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="tourinfo_date">
                	<div class="date_d fl">
                    	<label>Amount:</label>
                        <input type="text" name="amount" id="amount" class="tourDate_d">
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="line_s"></div> 
                <p class="customer_p"><input id="savePaymentButton" type="button"  class="payment_btn" value="Save"></p>  
            </div>
        </div>
        <div class="tourinfo_leftbox_down">
        		<table cellpadding="0" cellspacing="0" class="payment_tab" width="100%" id="payList">
                	<tr class="payment_tab_1">
                    	<td><b>Payment Date</b></td>
                        <td><b>ReceivedAmount</b></td>
                        <td><b>Balance</b></td>
                        <td><b>Paymethod</b></td>
                        <td><b>PayMent</b></td>
                        <td><b>PayInfo</b></td>
                        <!--<td><b>Action</b></td>-->
                    </tr>
                   [#list paymentList as pay]
						<tr>
							<td>${pay.createDate?string('yyyy-MM-dd')}</td>
							<td>${pay.payment}</td>
							<td>${pay.balance}</td>
							<td>${pay.payType}</td>
							<td>${pay.amount}</td>
							<td>${pay.payInfo}</td>
						</tr>
					[/#list]
                </table>
        </div>
        </div>
        <div class="tourinfo_summary r1">
        	<div class="summary_tit"><span>SUMMARY</span></div>
            <div class="summary_box">
            	<div class="summary_box1">
                	<span style="margin-right:10px;">Booking No.:</span>${order.orderNo}</span>
                </div>
                <div class="line_2s"></div>
                <div class="summary_box1">
                	<span style="margin-right:10px;">Total:</span><span>${totalFee}</span>
                </div>
                <div class="line_2s"></div>
                <div class="summary_box1">
                	<span style="margin-right:10px;">Paid:&nbsp;&nbsp;<span id="payment">${lastPay.payment}</span></span>
                	<input type="hidden" name="payment" id="paymentInput" value="${lastPay.payment}">
                </div>
                <div class="line_2s"></div>
                <div class="summary_box2">
                	<span style="margin-right:10px;">Balance:</span><span style="color:#ed6f42;"></span><span style="color:#ed6f42;">${lastPay.balance}</span>
                	<input type="hidden" id="balanceInput" name="balance" value="${lastPay.balance}">
                </div>
            </div>
        </div>
        </form>
        <div class="clear"></div>
    </div>
</div>
[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript">
	$("#credit_slider").slider().on("slide", function(e) {
		$("#credits").html("$" + e.value);
	});
	$("#rate_slider").slider().on("slide", function(e) {
		$("#rate").html(e.value + "%");
	});
</script>
<script>
 $(function () {
            //获取要定位元素距离浏览器顶部的距离
            var navH = $(".tourinfo_summary").offset().top;
            //计算left值
            var zhi = (($(window).width() - 1100)/2)+838;
            //滚动条事件
            $(window).scroll(function () {
                //获取滚动条的滑动距离
                var scroH = $(this).scrollTop();
                //滚动条的滑动距离大于等于定位元素距离浏览器顶部的距离，就固定，反之就不固定
                if (scroH >= navH) {
                    $(".tourinfo_summary").css({
                        "position": "fixed",
                        "top": 0,
                        "left":zhi
                    });
                } else if (scroH < navH) {
                    $(".tourinfo_summary").css({
                        "position": "static"
                    });
                }
            })
        })


$(".from_choice span").click(function(){
        if($(this).parent().find(".brand_op").css("display")==="none"){
            $(this).parent().find(".brand_op").fadeIn(300);
        }else{
            $(this).parent().find(".brand_op").fadeOut(300);
        }
    })
    $(".from_choice").blur(function(){
        $(this).find(".brand_op").fadeOut(300);
    });
    $(".brand_op li").click(function(){
         $(".from_choice span").text($(this).text());
		 $(".brand_op").fadeOut(300);
    });
    
    $("#savePaymentButton").click( function(){
		$.ajax({
			type: "POST",
			url: "[@spring.url '/admin/peerUser/savePayment.jhtml'/]",
			data:$("#addPaymentForm").serialize(),
			success: function(map){
				$("#payment").html(map.pay.payment);
				$("#paymentInput").attr("value",map.pay.payment);
				$("#balance").html(map.pay.balance);
				$("#balanceInput").attr("value",map.pay.balance);
				$("#payInfo").attr("value","");
				$("#amount").attr("value","");
				str='<tr>'+
						'<td>'+map.pay.dateStr+'</td>'+
						'<td>'+map.pay.payment+'</td>'+
						'<td>'+map.pay.balance+'</td>'+
						'<td>'+map.pay.payType+'</td>'+
						'<td>'+map.pay.amount+'</td>';
					if(map.pay.payInfo=="null"){
						str+='<td></td>';
					}else{
						str+='<td>'+map.pay.payInfo+'</td>';
					};
					str+='</tr>';
				$("#payList").append(str);
			 }
		});
    })
   
 
</script>
</body>
</html>
