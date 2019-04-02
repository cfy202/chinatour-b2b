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
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="bg">
<div class="w1">
	<div class="tours_condition">
    	<div class="tours_line_title">
    		<h2 align="center" style="color:#333;">Booking  ${ordersTotal.orderNumber}</h2>
    		<span style="float:right"><a class="pull-right" href="javascript:history.go(-1)" title="Back"><i class="fa fa-reply" ></i></a></span>
        </div>
        <div class="a_information">
        	<p class="f16"><i class="info_icon_one"><img src="${base}/resources/peerUser/images/1.png" width="19"></i>Tour Info</p>
            <div>
            	<p class="a_info fl mt1">
                	<span class="color">Tour name:</span>
                    <span>${groupLine.tourName}</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Product Code:</span>
                    <span>${groupLine.tourCode}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Date Arrive In Destination:</span>
                    <span>[#if productVO.tourInfoForOrder.departureDate??]${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}[/#if]</span>
                </p>
                <div class="clear"></div>
            </div>
        </div>
        <div class="a_information">
        	<p class="f16"><i class="info_icon_one"><img src="${base}/resources/peerUser/images/2.png" width="19"></i>Customer Info</p>
        	[#list customerOrderRelList as customerOrderRel]
             <div style="border: 1px dotted #cccccc;margin-top:10px">
            	<div style="width:90%;margin:10px">
            	<p class="a_info fl mt1">
                	<span class="color">Last/Frist Middle Name:</span>
                    <span>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Gender:</span>
                    <span>[#if customerOrderRel.customer.sex == 1]F[#else]M[/#if]</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Nationality:</span>
                    <span>${customerOrderRel.customer.nationalityOfPassport}</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">PassportNo.:</span>
                    <span>${customerOrderRel.customer.passportNo}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Date Of Birth:</span>
                    <span>[#if productVO.tourInfoForOrder.dateOfBirth??]${productVO.tourInfoForOrder.dateOfBirth?string('yyyy-MM-dd')}[/#if]</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Room Type:</span>
                    <span>${customerOrderRel.guestRoomType}</span>
                </p>
                <div class="clear"></div>
                </div>
            </div>
            [/#list]
        </div>
        <div class="a_information">
        	<p class="f16"><i class="info_icon_one"><img src="${base}/resources/peerUser/images/4.png" width="19"></i>Flight Info</p>
        	[#list productVO.customerFlights as cor]
            <div style="border: 1px dotted #cccccc;margin-top:10px">
            	<div style="width:90%;margin:10px">
            	<p class="a_info fl mt1">
                	<span class="color">NO.${cor_index+1}</span>
                	[#list customerOrderRelList as customerOrderRel]
                	[#if customerOrderRel_index=cor_index]
                    <span>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</span>
                    [/#if]
                    [/#list]
                </p>
                <div class="clear"></div>
            	<p class="a_info fl mt1">
                	<span class="color">Airline:</span>
                    <span>${cor.customerFlightList[0].flightCode}</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Flight No.:</span>
                    <span>${cor.customerFlightList[0].flightNumber}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Arrival Date:</span>
                    <span>[#if (cor.customerFlightList[0].arriveDate)??]${cor.customerFlightList[0].arriveDate?string('yyyy-MM-dd')}[/#if]</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Arrival Time:</span>
                    <span>${cor.customerFlightList[0].arriveTime}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Pick-up:</span>
                    <span>[#if cor.customerFlightList[0].ifPickUp==1]Yes[/#if][#if cor.customerFlightList[0].ifPickUp==2]No[/#if]</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Airline:</span>
                    <span>${cor.customerFlightList[1].flightCode}</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Flight No.:</span>
                    <span>${cor.customerFlightList[1].flightNumber}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Departure Date:</span>
                    <span>[#if (cor.customerFlightList[1].arriveDate)??]${cor.customerFlightList[1].arriveDate?string('yyyy-MM-dd')}[/#if]</span>
                </p>
                <p class="a_info fl mt1">
                	<span class="color">Departure Time:</span>
                    <span>${cor.customerFlightList[1].arriveTime}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1">
                	<span class="color">Drop-off:</span>
                    <span>[#if cor.customerFlightList[1].ifSendUp==1]Yes[/#if][#if cor.customerFlightList[1].ifSendUp==2]No[/#if]</span>
                </p>
                <div class="clear"></div>
            	</div>
            </div>
            [/#list]
        </div>
        <div class="a_information">
        	<p class="f16"><i class="info_icon_one"><img src="${base}/resources/peerUser/images/5.png" width="19"></i>Pre/Post Tour Accommodation</p>
        	 <p class="a_info fl mt1">
           		<span class="color">Post Tour Accommodation</span>
           </p>
        	<table cellpadding="0" id="pertr" cellspacing="0" class="per_tab" width="100%">
                <tr class="per_tab_1">
                    <td width="40%"><b>Last/Frist Middle Name</b></td>
                    <td width="40%"><b>Room Type</b></td>
                    <td width="10%"><b>Room NO.</b></td>
                    <td width="10%"><b>Nights</b></td>
                </tr>
                [#if prePostList!=null]
	                [#list prePostList as proInfo]
	                	[#if proInfo.type==0]
	                    <tr height="50" align="center" id="perInfo${inf_index+1}">
	                    	<td>${proInfo.guest}</td>
	                    	<td>${proInfo.roomType}</td>
	                    	<td>${proInfo.roomNo}</td>
	                    	<td>${proInfo.nights}</td>
	                    </tr>
                		[/#if]
	                [/#list]
                [/#if]
           </table>
           <p class="a_info fl mt1">
           		<span class="color">Post Tour Accommodation</span>
           </p>
           <table cellpadding="0" id="posttr" cellspacing="0" class="per_tab" width="100%">
	            <tr class="per_tab_1">
	                <td width="40%"><b>Last/Frist Middle Name</b></td>
	                <td width="40%"><b>Room Type</b></td>
                    <td width="10%"><b>Room NO.</b></td>
	                <td width="10%"><b>Nights</b></td>
	            </tr>
	            [#if prePostList!=null]
	                [#list prePostList as proInfo]
	                	[#if proInfo.type==1]
	                    <tr height="50" align="center" id="perInfo${inf_index+1}">
	                    	<td>${proInfo.guest}</td>
	                    	<td>${proInfo.roomType}</td>
	                    	<td>${proInfo.roomNo}</td>
	                    	<td>${proInfo.nights}</td>
	                    </tr>
                		[/#if]
	                [/#list]
                [/#if]
	        </table>
        </div>
        <div class="a_information">
        	<p class="f16"><i class="info_icon_one"><img src="${base}/resources/peerUser/images/6.png" width="19"></i>Tour Remark</p>
            <div>
            	<p class="a_info fl mt1" style="width:100%">
                	<span class="color">Requirement:</span>
                    <span>${productVO.tourInfoForOrder.specialRequirements}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1" style="width:100%">
                	<span class="color">Remark:</span>
                    <span>${productVO.tourInfoForOrder.tourInfo}</span>
                </p>
                <div class="clear"></div>
                <p class="a_info fl mt1" style="width:100%">
                	<span class="color">Tour Vorcher Remark:</span>
                    <span>${productVO.tourInfoForOrder.voucherRemarks}</span>
                </p>
                <p class="a_info fl mt1" style="width:100%">
                	<span class="color">Agent Remark:</span>
                    <span>${productVO.order.peerUserRemark}</span>
                </p>
                <div class="clear"></div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
</div>
[#include "/admin/peerUser/include/foot.ftl"]
<script>

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
    })
</script>
</body>
</html>
