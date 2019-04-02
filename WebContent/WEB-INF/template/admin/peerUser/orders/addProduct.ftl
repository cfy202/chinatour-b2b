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
[#include "/admin/peerUser/include/navbar.ftl"]
<div id="cl-wrapper" class="bg">
    <div class="w1" id="pcont">
        <div class="">		
    <div>
      <div class="fuelux ">
        <div class="block-wizard tourinfo_buzhou">
          <div id="wizard1" class="wizard wizard-ux" style="font-weight:bold;background:#ffffff;">
            <ul>
              <li data-target="#step1" id="stepdiv1" class="active"><i class="fa fa-calendar"></i>&nbsp;Tour Info<span class="chevron"></span></li>
              <li data-target="#step2" id="stepdiv2" ><i class="fa fa-group"></i>&nbsp;Customer Info<span class="chevron"></span></li>
              <li data-target="#step3" id="stepdiv3" ><i class="fa fa-home"></i>&nbsp;Room Info<span class="chevron"></span></li>
              <li data-target="#step4" id="stepdiv4" ><i class="fa fa-plane"></i>&nbsp;Flight Info<span class="chevron"></span></li>
              <li data-target="#step5" id="stepdiv5" ><i class="fa fa-meh-o"></i>&nbsp;Pre/Post Tour Accommodation<span class="chevron"></span></li>
              <li data-target="#step6" id="stepdiv6" ><i class="fa fa-file-text"></i>&nbsp;Tour Remark<span class="chevron"></span></li>
            </ul>
            <!--span style="float:right;margin: 14px 12px 0px 0px;color: #3a87ad;font-size: 15px;">Booking NO.:${ordersTotal.orderNumber}</span-->
            <div class="clear"></div>
          </div>
          <div class="step-content" style="margin-top:20px;">
            <form class="form-horizontal group-border-dashed" id="ww" action="addProduct.jhtml" data-parsley-validate novalidate>
            	<input type="hidden" id="showPay" value="${groupL.otherCol}"/> 
            	<input type="hidden" name="productVO.order.peerUserId" value="${peerUser.peerUserId}"/>
            	<input type="hidden" id="orderNumber" value="${ordersTotal.orderNumber}"/> 
            	<input type="hidden" name="productVO.order.peerUserName" value="${peerUser.peerUserName}"/> 
				<input type="hidden" name="productVO.ordersTotalId" id="ordersTotalId" value="${ordersTotal.ordersTotalId}">
				<input type="hidden" name="productVO.tourInfoForOrder.groupLineId" id="groupId" value="${groupLine.id}">
				<input type="hidden" id="isOceania" value="${groupLine.isOceania}">
				<input type="hidden" name="productVO.tourInfoForOrder.scheduleLineCode" value="${groupLine.tourCode}">
				<input type="hidden" name="productVO.tourInfoForOrder.lineName" value="${groupLine.tourName}">
				<input type="hidden" name="productVO.order.brand" value="${groupLines.brand}">
				<input type="hidden" name="productVO.receivableInfoOfOrder.totalCommonTourFee" value="${groupLines.price}">
				<input type="hidden" name="productVO.order.peerUserRate" value="${rate.usRate}">
				<!--input type="hidden" name="productVO.order.peerUserRate" value="[#if peerUser.currencyTypeId=='42DC81C7-3FEE-4B15-9C08-CC575620FD4B']1.4[#else]1[/#if]"-->
				<input type="hidden" id="singlePrice" value="0">
				<input type="hidden" name="productVO.order.peerUserFee" id="peerUserFee" value="">
				<input type="hidden" name="productVO.otherFeeList[0].itemFee" id="tipTotal" value="0"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[0].remark" value="小费总额"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[0].type" value="2"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[0].num" value="201"><!--小费总额-->
				<input type="hidden" name="productVO.otherFeeList[1].itemFee" id="selfTotal" value="0"><!--自费总额-->
				<input type="hidden" name="productVO.otherFeeList[1].remark" value="自费总额"><!--自费总额-->
				<input type="hidden" name="productVO.otherFeeList[1].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[1].num" value="202"><!--自费总额-->
				<input type="hidden" name="productVO.otherFeeList[2].itemFee" id="hotelTotal" value="0"><!--酒店费用总额-->
				<input type="hidden" name="productVO.otherFeeList[2].remark" value="酒店费用总额"><!--酒店费用总额-->
				<input type="hidden" name="productVO.otherFeeList[2].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[2].num" value="203">
				<input type="hidden" name="productVO.otherFeeList[3].itemFee" id="ticketTotal" value="0"><!--接送机费用总额-->
				<input type="hidden" name="productVO.otherFeeList[3].remark" value="接送机费用总额"><!--接送机费用总额-->
				<input type="hidden" name="productVO.otherFeeList[3].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[3].num" value="204">
				<input type="hidden" name="productVO.otherFeeList[4].itemFee" id="supTotal" value="0"><!--单房差价格-->
				<input type="hidden" name="productVO.otherFeeList[4].remark" value="单房差价格"><!--接送机费用总额-->
				<input type="hidden" name="productVO.otherFeeList[4].type" value="2">
				<input type="hidden" name="productVO.otherFeeList[4].num" value="205">
				<input type="hidden" id="supplement"><!--单房差价格-->
				<!--input type="hidden" id="PriceTotal" name="productVO.price"/><订单应收款-->
				<input type="hidden" id="totalSP" name="productVO.price"/><!--订单应收款-->
				<input type="hidden" name="" id="hotelPrice" value=""><!--酒店费用单价-->
				<input type="hidden" name="" id="pickSendPrice" value="${groupL.pickSendPrice}"><!--接送机费用单价美元-->
				<input type="hidden" name="" id="lease" value="${groupL.least}"><!--最少人数用单价-->
				<input name="wr" value="wholeSale" type="hidden">
				<input name="productVO.feeItems" id="feeItems" type="hidden">
				<div style="display:none;" id="cusback"></div>
				<div class="step-pane active" id="step1">
						<div class="tourinfo_leftbox fl">
		                    <div class="tourinfo_name">
				        		Product Code：${groupLine.tourCode}
				        		</br>
				        		${groupLine.tourName}
				        	</div>
				            <div class="tourinfo_box">
				            	<div class="tourinfo_titile_1">Product Info</div>
				                <div class="lineb"></div>
				                [#if groupLine.tripDesc??]
				                <div class="tourinfo_date" style="border:1px dashed #ff0000;color:#ff0000;padding:5px;">
				                	<div class="date_d fl">
				                       <B>Notice：</B>${groupLine.tripDesc}
				                    </div>
				                    <div class="clear"></div>
				                </div>
				                [/#if]
				                <div class="tourinfo_date">
				                	[#if groupLine.ticket==0 ]
					                	<div class="date_d fl">
					                    	<label style="width:200px">Date Arrive In Destination<b style="color:red;">*</b>:</label>
					                        <input id="departureDateInput" type="text" disable="disable" required="required" name="productVO.tourInfoForOrder.departureDate" value="${departureDate}" class="tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
											<input name="productVO.order.tourTypeId" type="hidden" value="${groupLine.tourTypeId}">
					                    </div>
				                    [/#if]
				                    [#if groupLine.ticket==1 ]
				                    	<div class="date_d fl">
					                    	<label>Departure Date<b style="color:red;">*</b>:</label>
					                        <input id="departureDateInput" type="text" disable="disable" required="required" name="productVO.tourInfoForOrder.departureDate" value="${departureDate}" class="tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
											<input name="productVO.order.tourTypeId" type="hidden" value="${groupLine.tourTypeId}">
					                    </div>
					                    <div class="date_d fl">
					                    	<label style="width:200px">Date Arrive In Destination<b style="color:red;">*</b>:</label>
					                        <input id="scheduleOfArriveTimeInput" type="text" name="productVO.tourInfoForOrder.scheduleOfArriveTime" class="tourDate_d" required="required" placeholder="yyyy-mm-dd"/>
					                    </div>
				                    [/#if]
				                    <div class="clear"></div>
				                </div>
				                <div class="tourinfo_titile_1">Contact Information</div>
				                <div class="lineb"></div>
				                <div class="tourinfo_date">
				                	<div class="date_d fl">
				                    	<label style="width:140px;">Consultant Name <b style="color:red;">*</b>:</label>
				                    	<select class="perlist" id="contactName" name="productVO.ordersTotal.contactName" style="width:120px">
				                    	[#list cList as cList]
				                    		<option value="${cList.contactsName}" id="op${cList.contactsId}">${cList.contactsName}</option>
				                    	[/#list]
				                    	</select>
				                        <!--input type="text" id="contactName" name="productVO.ordersTotal.contactName" class="tourDate_d"-->
				                        <input type="button" class="per_btn popup_addContacts" style="border:none !important;">
				                        <input type="button" class="per_btnd popup_addContactselect" style="border:none !important;">
				                    </div>
				                    <div class="date_d fl" style="float:right">
				                    	<label style="width:80px;">REF NO :</label>
				                        <input type="text" name="productVO.order.refNo" class="tourDate_d">
				                    </div>
				                    <div class="clear"></div>
				                </div>
				            </div>
				            <div class="form-group tourinfo_fy_btn" align="right">
								<div class="col-sm-offset-2 col-sm-10 ">
									<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default fy_btn_1" style="width:62px">Cancel</button>
									<button onclick="nextDiv(2);" class="btn btn-primary wizard-next fy_btn_2" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
								</div>
							</div>
				        </div>
					</div>
				<div class="step-pane" id="step2">
					<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
		        		<div style="margin:0px 0px 10px 18px !important;font-weight: bold; color:#0088cc;">${groupLine.level}</div>
			            <div id="tsDiv" [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
			            	<p style="margin-left:18px !important;font-weight: bold;">Did the customer prepaid the fee?(USD 1 : ${currency.currencyEng} ${rate.usRate})</p>
			            	<p style="margin-left:18px !important;font-weight: bold;"><i class="fa fa-hand-o-right"></i>Service Fee :
			            		<span style="color:#0081cc;margin: 0px 0px 0px 15px;">USD ${groupLine.tip}/Pax</span>
            					(<span style="color:#0081cc;">${currency.currencyEng} <span id="tipPax"></span>/Pax</span>)
            					<span><input type="radio" name="tipids" id="tipchange1" onclick="tipchange(1)"/>Yes    <input type="radio" id="tipchange2" name="tipids" onclick="tipchange(2)" checked="checked"/>No</span> 
			            	</p>
			            	<p style="margin-left:18px !important;font-weight: bold;"><i class="fa fa-hand-o-right"></i>Compulsory Programs : 
				            	<span style="color:#0081cc;margin: 0px 0px 0px 15px;">USD ${groupLine.selfExpense}/Pax</span>
	            				(<span style="color:#0081cc;">${currency.currencyEng}  <span id="selfPax"></span>/Pax</span>)
            					<span><input type="radio" name="selfids" id="tipchange3" onclick="tipchange(3)"/>Yes    <input type="radio" id="tipchange4" name="selfids" onclick="tipchange(4)" checked="checked"/>No</span> 
            				</p>
			            </div>
			             <div [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
			            	<p style="margin-left:18px !important;font-weight: bold;">Please pay below surcharges on arrival.</p>
			            	<p style="margin-left:18px !important;font-weight: bold;"><i class="fa fa-hand-o-right"></i>Service Fee :
			            		<span style="color:#0081cc;margin: 0px 0px 0px 15px;">EUR 188/Pax</span>
			            	</p>
			            	<p style="margin-left:18px !important;font-weight: bold;"><i class="fa fa-hand-o-right"></i>Compulsory Programs : 
				            	<span style="color:#0081cc;margin: 0px 0px 0px 15px;">EUR 0/Pax</span>
            				</p>
			            </div>
			            <div class="tourinfo_box" id="cusListDiv">
			            	<table cellpadding="0" cellspacing="0" id="table" class="customer_tab" width="100%">
			                	<tr class="customer_tab_1" align="left">
			                    	<td align="left"><b>Last/Frist Middle Name</b></td>
			                        <td align="left"><b>Gender</b></td>
			                        <td align="left"><b>Nationality</b></td>
			                        <td align="left"><b>Residency</b></td>
			                        <td align="left"><b>PassportNo.</b></td>
			                        <td align="left"><b>Date Of Birth</b></td>
			                        <td align="left"><b>Type</b></td>
			                        <td align="left"><b>Remark</b></td>
			                        <td align="left"><b>Action</b></td>
			                    </tr>
			                    <tbody id="customerList" class="no-border-y">
								</tbody>
			                </table>
			                <p style="text-align:center;"><span class="customer_p" id="passenger"><a class="popup_login" href="javascript:;">Add Passenger</a></span>
			                <span class="customer_p" id="selectCustomerButton"><a class="popup_select" href="javascript:;">Select Passenger</a></span></p>
			            </div>
			            <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(1);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" id="customerFlightStep" onclick="curInfo(3);" class="btn btn-primary wizard-next fy_btn_2" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
				 	</div>
			    </div>	
			    <div class="step-pane" id="step3">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
	                    <div class="tourinfo_box" id="PerList">
	                    	<div class="perbox">
			                	<div class="tourinfo_titile_1">Room Type</div>
			                    <div class="lineb"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Guest:</label>
			                            <select class="perlist" id="guestNum" onChange="setRoomType()">
			                            	<option value="">Select Guest</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Room:</label>
			                            <select class="perlist" id="roomType"><!--onChange="getRoommate(this.value,$('#roomNum'));"-->
			                            	<option value="">select roomType</option>
			                            	[#list constant.GUEST_ROOM_TYPES as room]
												<option value="${room}" class="opsel">
													${room}
												</option>
											[/#list]
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:110px">Choose Room:</label>
			                            <select class="perlist" id="roomNum">
			                            	<option value="">Select No.</option>
			                            	<option value="1">NO.1</option>
			                            	<option value="2">NO.2</option>
			                            	<option value="3">NO.3</option>
			                            	<option value="4">NO.4</option>
			                            	<option value="5">NO.5</option>
			                            	<option value="6">NO.6</option>
			                            	<option value="7">NO.7</option>
			                            	<option value="8">NO.8</option>
			                            	<option value="9">NO.9</option>
			                            	<option value="10">NO.10</option>
			                            	<option value="11">NO.11</option>
			                            	<option value="12">NO.12</option>
			                            	<option value="13">NO.13</option>
			                            	<option value="14">NO.14</option>
			                            	<option value="15">NO.15</option>
			                            	<option value="16">NO.16</option>
			                            	<option value="17">NO.17</option>
			                            	<option value="18">NO.18</option>
			                            	<option value="19">NO.19</option>
			                            	<option value="20">NO.20</option>
			                            </select>
			                            <input type="button" onclick="addRoomType()" class="per_btn" style="border:none !important;">
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="room" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%" align="left"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%" align="left"><b>Room Type</b></td>
			                            <td width="40%" align="left" ><b>Room Number</b></td>
			                            <td width="40%" align="left"><b>Action</b></td>
			                        </tr>
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                </div> 
			            <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(2);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="supp(4);" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
	                </div>
			    </div>
          		<div class="step-pane" id="step4">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
	                    <div class="tourinfo_box" id="tourinfo_box">
	                    	<span id="message" style='height:30px;line-height:30px;padding:0 5px;color:red;margin:15px 0;font-weight:bold;'></span>
	                    </div>
	                    <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(3);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="checktic(5);" id="stepHave" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
			    </div>
			    <div class="step-pane" id="step5">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
	                    <div class="tourinfo_box" id="PerList">
	                    	<input type="hidden" id="perInfoList" name="productVO.order.proInfo">
	                    	<input type="hidden" id="postInfoList" name="productVO.order.postInfo">
	                    	<input type="hidden" id="perTrNum" value="0">
	                    	<input type="hidden" id="postTrNumt" value="0">
	                    	<div id="pDiv" style="margin-bottom:10px;font-size:16px;">
				               <span ><i class="fa  fa-hand-o-right"></i>  <b>Pre Tour Accommodation?</b></span>
				               <span style="margin:0px 10px">
				               		<b><input type="checkbox"  name="preBox"  id="divP" onclick="haveFee(1)"/>Yes</b>
				               </span>
			            	</div>
	                    	<div class="perbox" id="perDiv" style="display:none;">
			                	<div class="tourinfo_titile_1">Pre Accommodation</div>
			                    <div class="lineb"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Guest:</label>
			                            <select class="perlist" id="percus"><!--id="percusSelect" onclick="preTogle()"-->
			                            	<option id="preSelect">Select Guest</option>
			                            </select>
		                            	<!--ul style="margin-left:50px;display:none;border-color: #cccccc #5c5c5c #5c5c5c #cccccc; border-style: solid;border-width: 1px;margin-left: 50px;" id="percus">  
	               						</ul-->  
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Room:</label>
			                            <select class="perlist" id="perroom">
			                            	<option value="Twin Bed">Twin Bed</option>
											<option value="King Bed">King Bed</option>
											<option value="Single">Single</option>
											<option value="Extra Bed">Extra Bed</option>
											<option value="Sharing Existing Bed">Sharing Existing Bed</option>
			                            </select>
			                        </div>
			                         <div class="date_d fl">
			                            <label class="per_label" style="width:45px">No.:</label>
			                            <select class="perlist" id="roomNumt" style="width:70px">
			                            	<option value="1">NO.1</option>
			                            	<option value="2">NO.2</option>
			                            	<option value="3">NO.3</option>
			                            	<option value="4">NO.4</option>
			                            	<option value="5">NO.5</option>
			                            	<option value="6">NO.6</option>
			                            	<option value="7">NO.7</option>
			                            	<option value="8">NO.8</option>
			                            	<option value="9">NO.9</option>
			                            	<option value="10">NO.10</option>
			                            	<option value="11">NO.11</option>
			                            	<option value="12">NO.12</option>
			                            	<option value="13">NO.13</option>
			                            	<option value="14">NO.14</option>
			                            	<option value="15">NO.15</option>
			                            	<option value="16">NO.16</option>
			                            	<option value="17">NO.17</option>
			                            	<option value="18">NO.18</option>
			                            	<option value="19">NO.19</option>
			                            	<option value="20">NO.20</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label_day">Nights:</label>
			                            <input type="text" id="pre" value="0" class="per_day" style="height:33px !important; line-height:33px !important;">
			                            <input type="button" onclick="hotelPerAcc()" class="per_btn" style="border:none !important;">
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="pertr" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%" align="left"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%" align="left"><b>Room Type</b></td>
			                            <td width="10%" align="left"><b>Room NO.</b></td>
			                            <td width="10%" align="left"><b>Nights</b></td>
			                            <td width="10%" align="left"><b>Action</b></td>
			                        </tr>
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                </div> 
			                <div id="poDiv" style="margin-bottom:10px;font-size:16px;">
				               <span ><i class="fa  fa-hand-o-right"></i>  <b>Post Tour Accommodation?</b></span>
				               <span style="margin:0px 10px">
				               		<b><input type="checkbox"  name="postBox" id="divPost" onclick="haveFee(2)"/>Yes</b>
				               </span>
			            	</div>
			                <div class="perbox" id="postDiv" style="display:none;">
			                	<div class="tourinfo_titile_1">Post Accommodation</div>
			                    <div class="lineb"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Guest:</label>
			                            <select class="perlist" id="postcus">
			                            	<option id="postSelect">Select Guest</option>
			                            </select>
			                        </div>
			                         <div class="date_d fl">
			                            <label class="per_label" style="width:45px">Room:</label>
			                            <select class="perlist" id="postroom">
			                            	<option value="Twin Bed">Twin Bed</option>
											<option value="King Bed">King Bed</option>
											<option value="Single">Single</option>
											<option value="Extra Bed">Extra Bed</option>
											<option value="Sharing Existing Bed">Sharing Existing Bed</option>
			                            </select>
			                        </div>
			                       	<div class="date_d fl">
			                            <label class="per_label" style="width:45px">No.:</label>
			                            <select class="perlist" id="roomNump" style="width:70px">
			                            	<option value="1">NO.1</option>
			                            	<option value="2">NO.2</option>
			                            	<option value="3">NO.3</option>
			                            	<option value="4">NO.4</option>
			                            	<option value="5">NO.5</option>
			                            	<option value="6">NO.6</option>
			                            	<option value="7">NO.7</option>
			                            	<option value="8">NO.8</option>
			                            	<option value="9">NO.9</option>
			                            	<option value="10">NO.10</option>
			                            	<option value="11">NO.11</option>
			                            	<option value="12">NO.12</option>
			                            	<option value="13">NO.13</option>
			                            	<option value="14">NO.14</option>
			                            	<option value="15">NO.15</option>
			                            	<option value="16">NO.16</option>
			                            	<option value="17">NO.17</option>
			                            	<option value="18">NO.18</option>
			                            	<option value="19">NO.19</option>
			                            	<option value="20">NO.20</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label_day">Nights:</label>
			                            <input type="text" id="post" value="0" class="per_day"  style="height:33px !important; line-height:33px !important;">
			                            <input type="button" onclick="hotelPostAcc()" class="per_btn" style="border:none !important;">
			                            <input type="hidden" id="postDays" value="0" >
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="posttr" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%" align="left"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%" align="left"><b>Room Type</b></td>
			                            <td width="10%" align="left"><b>Room NO.</b></td>
			                            <td width="10%" align="left"><b>Nights</b></td>
			                            <td width="10%" align="left"><b>Action</b></td>
			                        </tr>
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                    <input type="hidden" id="days" value="0" >
			                    <input type="hidden" id="roomNoPax" value="0" >
			                    <input type="hidden" id="helfDays" value="0" >
			                    <input type="hidden" id="helfPax" value="0" >
			                </div> 
	                    </div>
	                    <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(4);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="sumPrePost(6);" style="width:90px">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
			    </div>
			    <div class="step-pane" id="step6">
			    	<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">
			        		Product Code：${groupLine.tourCode}
			        		</br>
			        		${groupLine.tourName}
			        	</div>
			            <div class="tourinfo_box">
		                    	<span class="flight_1_num fl">Requirement:</span>
		                    	<div class="flight_1_down_main">
		                    		<textarea name="productVO.tourInfoForOrder.specialRequirements" class="textarea"></textarea>
		                        </div>
		                        <div class="lineb"></div>
		                    	<span class="flight_1_num fl">Remark：(为了更方便导游接机，建议您请留下客人在旅游目的地可以联系电话号码)</span>
		                    	<div class="flight_1_down_main">
		                    		<textarea name="productVO.tourInfoForOrder.tourInfo" id="remarkes" class="textarea">小费未付/自费未付</textarea>
		                        </div>
		                        <div class="lineb"></div>
		                    	<span class="flight_1_num fl">Tour Vorcher Remark:</span>
		                    	<div class="flight_1_down_main">
		                    		<textarea name="productVO.tourInfoForOrder.voucherRemarks" id="voucherRemarks" class="textarea">自费未付/小费未付</textarea>
		                        </div>
		                        <div class="lineb"></div>
		                        <div class="flight_1_down_main">
		                    		<input type="checkbox" id="terms" />I agreed and accept InterTrips’ <a href="[@spring.url '/terms.jsp'/]" target="_blank">Terms & Conditions</a>.
		                        </div>
			            </div>
			            <div class="tourinfo_fy_btn">
			                <button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(5);" style="width:90px"><i class="fa fa-caret-left"></i> Previous</button>
							<button type="button" onclick="sub();" id="subBT" data-wizard="#wizard1" class="btn btn-success wizard-next fy_btn_3" style="width:90px"><i class="fa fa-check"></i> Submit </button>
			            </div>
			        </div>
          		</div>
          <!--右侧层-->
          <div class="tourinfo_summary r1">
        	<div class="summary_tit"><span>SUMMARY</span></div>
            <div class="summary_box">
            	<table class="sum_table">
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Departure Date:</span></td>
            			<td style="text-align:right;width:100px"><span id="dated"></span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">End Date:</span></td>
            			<td style="text-align:right;width:100px"><span id="offTime"></span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Total Number:</span><input type="hidden" value="0" id="totalPeople" name="totalPeople" readonly /></td>
            			<td style="text-align:right"><span id="totalPeople1">0</span>&nbsp;&nbsp;&nbsp;Pax</td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Adult:</span></td>
            			<td style="text-align:right"><span id="adult">0</span> x <span id="adultNum">0</span> <span>Pax</span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Child with Bed:</span></td>
            			<td style="text-align:right"><span id="bed">0</span> x <span id="bedNum">0</span> <span>Pax</span></td>
            		<tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Child without Bed:</span></td>
            			<td style="text-align:right"><span  id="notBed">0</span> x <span id="notBedNum">0</span> <span>Pax</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Infant:</span></td>
            			<td style="text-align:right"><span id="baby">0</span> x <span id="babyNum">0</span> <span>Pax</span></td>
            		</tr>
            		<tr>
            			<td class="lineTd summary_box2"><span style="margin-right:10px;">Selling Price:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right"><span style="color:#ed6f42;">${currency.currencyEng}</span>  <span style="color:#ed6f42;" id="totalS">0</span></td>
            		</tr>
            		
            		<tr>
            			<td><span style="margin-right:10px;width: 130px;display: inline-block;">Single Supplement :</span></td>
            			<td style="text-align:right"><span>${currency.currencyEng}</span> <span id="sup">0</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Pre/Post-Stay:</span></td>
            			<td style="text-align:right"><span>${currency.currencyEng}</span>  <span id="pp">0</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Pick/Send:</span></td>
            			<td  style="text-align:right"><span>${currency.currencyEng}</span>  <span id="ps">0</span></td>
            		</tr>
            		<tr>
            			<td>
            				<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
            					<span style="display: inline-block;color:#0081cc;"><input type="checkbox" id="tipBox" name="tipBox" onclick="tipSum();" style="width:14px"/>Service Fee:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">USD ${groupLine.tip}/Pax</p>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">${currency.currencyEng} <span id="tipPrice"></span>/Pax</p>
            				</span>
            				<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
            					<span style="display: inline-block;color:#0081cc;">Service Fee:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">EUR 188/Pax</p>
            				</span>
            			</td>
            			<td style="text-align:right">
            				<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
            					<span>${currency.currencyEng}</span>  <span id="tipDiv" style="display:none">0</span><span id="tPrice">0</span> x <span id="tipPaxs">0</span> Pax
			                	<input type="hidden" id="tip"value="${groupLine.tip}"/>
			                	<input type="hidden" id="rate" value="${rate.usRate}"/>
			                	<!--input type="hidden" id="rate" value="[#if peerUser.currencyTypeId=='42DC81C7-3FEE-4B15-9C08-CC575620FD4B']1.4[#else]1[/#if]"/-->
			                	<input type="hidden" name="productVO.order.rate" value="0"/>
		                	</span>
		                	<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
			                	<span>EUR</span>  <span  style="display:none">0</span><span>0</span> x <span>0</span> Pax
		                	</span>
            			</td>
            		</tr>
            		<tr>
            			<td>
            				<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
	            				<span style="display: inline-block;color:#0081cc;"><input type="checkbox" id="expenseBox" name="expenseBox" onclick="selfSum();" style="width:14px"/>Compulsory Programs:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">USD ${groupLine.selfExpense}/Pax</p>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">${currency.currencyEng}  <span id="selfPrice"></span>/Pax</p>
            				</span>
            				<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
	            				<span style="display: inline-block;color:#0081cc;">Compulsory Programs:</span>
	            				<p style="color:#0081cc;margin: 0px 0px 0px 15px;">EUR 0/Pax</p>
            				</span>
            			</td>
            			<td style="text-align:right">
	            			<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]style="display:none"[/#if]>
	            				<span>${currency.currencyEng}</span>  <span id="selfDiv" style="display:none">0</span><span id="sPrice">0</span> x <span id="selfPaxs">0</span> Pax
	                			<input type="hidden" id="self" value="${groupLine.selfExpense}"/>
                			</span>
                			<span [#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"][#else]style="display:none"[/#if]>
	            				<span>EUR</span>  <span  style="display:none">0</span><span >0</span> x <span >0</span> Pax
                			</span>
            			</td>
            		</tr>
            		<tr style="display:none;">
            			<td><span style="margin-right:10px;">Discount:</span></td>
            			<td style="text-align:right">
            				<input type="text"  style="text-align:right" value="0" name="productVO.discount.discountPrice" id="dis" onchange="disPrice()" class="summary_zhekou">
            				<input type="hidden" id="disOld" value="0">
            			</td>
            			
            		</tr>
            		<tr >
            			<td class="lineTd summary_box2"><span style="margin-right:10px;">Other Surcharge:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right"><span style="color:#ed6f42;">${currency.currencyEng}</span> <span style="color:#ed6f42;" id="otherPrice">0</span></td>
            		</tr>
            		<tr style="display:none">
            			<td class="lineTd summary_box2"><span style="margin-right:10px;">Final Amount:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right"><span style="color:#ed6f42;">${currency.currencyEng}</span> <span style="color:#ed6f42;" id="totalPrice">0</span></td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Adult Commission:</span></td>
            			<td style="text-align:right">
            				<span id="compax" style="color:#ed6f42;">0</span><font style="color:#ed6f42;"> x </font><span id="compaxdiv" style="color:#ed6f42;">0</span>  <span style="color:#ed6f42;">Pax</span>
                			<input type="hidden" id="comm" value=""/>
            			</td>
            		</tr>
            		<tr>
            			<td><span style="margin-right:10px;width: 115px;display: inline-block;">Child Commission:</span></td>
            			<td style="text-align:right">
            				<span id="childcompax" style="color:#ed6f42;">0</span><font style="color:#ed6f42;"> x </font><span id="childcompaxdiv" style="color:#ed6f42;">0</span>  <span style="color:#ed6f42;">Pax</span>
                			<input type="hidden" id="childcomm" value=""/>
            			</td>
            		</tr>
            		<tr>
            			<td class="lineTd summary_box2"><span style="margin-right:10px;width: 115px;display: inline-block;">Commission:</span></td>
            			<td class="lineTd summary_box2" style="text-align:right">
            				<span style="color:#ed6f42;">${currency.currencyEng}</span>  <span style="color:#ed6f42;" id="totalComm">0</span></span>
            			</td>
            		</tr>
            	</table>
            	<!--table>
            		<tr><td>Selling Price + Other Surcharge - Commission=Total Payable/Receivable</td></tr>
            		<tr>
            			<td><span id="sumFee">0</span>+<span id="otherFee">0</span>-<span id="comFee">0</span>=<span id="disFee">0</span></td>
            		</tr>
            	</table-->
            	<table width="100%">
            		<tr><td>Selling Price</td><td></td><td align="right"><span id="sumFee">0</span></td></tr>
            		<tr><td>&nbsp;&nbsp;</td><td>+</td><td>&nbsp;&nbsp;</td></tr>
            		<tr><td>Other Surcharge</td><td></td><td align="right"><span id="otherFee">0</span></td></tr>
            		<tr><td>&nbsp;&nbsp;</td><td>-</td><td>&nbsp;&nbsp;</td></tr>
            		<tr><td>Commission</td><td></td><td align="right"><span id="comFee">0</span></td></tr>
            		<tr><td>&nbsp;&nbsp;</td><td>=</td><td>&nbsp;&nbsp;</td></tr>
            		<tr><td width="77%" class="summary_box2">Total Payable/Receivable</td><td></td><td align="right"><span id="disFee">0</span></td></tr>
            		<tr>
            			<td class="summary_box2" colspan="2">
            				<span style="color:#0081cc;display: inline-block;">The above amount is subject to final approval, please refer to the final invoice.(以上結算價格僅供參考，請以經審核的最終單據為準)</span>
            			</td>
            		</tr>
            	</table>
            </div>
        </div>        
          </form>
          <div class="clear"></div>
        </div>
      </div>
    </div>
    </div>
    </div>
    <div class="clear"></div>
</div>
<div class="popup_form">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Add Customer</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
    <div class="popup_from_down">
    	<form id="customerForm">
    	<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
    	<input name="customer.peerId" id="peerId" value="${peerUser.peerId}" type="hidden" />
    	<div class="popup_from_down_list">
			<label class="popup_from_label" style="width:50px">Type:</label>
        	<label class="radio-inline" style="padding-left:0px;">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="1"
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Infant
			</label>
			<label style="padding-left:0px;" class="radio-inline">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="2" 
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Child without Bed
			</label>
			<label class="radio-inline" style="padding-left:0px;">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="3"
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Child with Bed
			</label>
			<label style="padding-left:0px;" id="type5" class="radio-inline">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="4" checked="checked"
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Adult
			</label>
			[#if groupLine.level!=""]
			<label class="popup_from_label" style="margin-left:10px;color:#018ddf;" onmouseover="overDiv('addDiv');" onmouseout="outDiv('addDiv');">
				<p>Age Remark</p>
				<!--div id="addDiv" style="display:none;color:red;font-weight:normal;">
					<em></em>   
      				<span></span>
      				${groupLine.level}
      			</div-->
      			<div id="addDiv" style="display:none;color:red;font-weight:normal;">
      				<div style="margin: 23px 10px 0 10px;">${groupLine.level}</div>
      			</div>
      		</label>
      		[/#if]
        </div>
    	<div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Last Name<b style="color:red;">*</b>:</label>
                <input class="popup_from_control" name="customer.lastName" onblur="customerListen();" onkeyup="this.value = this.value.toUpperCase();" id="lastNameId" required type="text">
            </div>
            <div class="popup_from_down_list_right">
            	<label class="popup_from_label">First Name<b style="color:red;">*</b>:</label>
                <input class="popup_from_control" name="customer.firstName" onblur="customerListen();" id="firstNameId" onkeyup="this.value = this.value.toUpperCase();" required type="text">
            </div>
            <div class="clear"></div>
        </div>
        <div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Middle Name:</label>
                <input class="popup_from_control" name="customer.middleName" onblur="customerListen();" id="middleNameId" onkeyup="this.value = this.value.toUpperCase();" required type="text">
            </div>
            <div class="popup_from_down_list_right">
            	<label class="popup_from_label">Gender:</label>
            	<label class="radio-inline" id="sexRadio1" style="padding-left:0px;">
					<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
						<input class="icheck" type="radio" name="customer.sex" value="1"checked="checked"
							style="position: absolute; opacity: 0;">
							<ins class="iCheck-helper"
								style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
							</ins>
					</div>
					Female&nbsp;&nbsp;
				</label>
				<label style="padding-left:0px;" id="sexRadio2" class="radio-inline">
					<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
						<input class="icheck" type="radio" name="customer.sex" value="2" 
							style="position: absolute; opacity: 0;">
							<ins class="iCheck-helper"
								style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
							</ins>
					</div>
					Male
				</label>
            </div>
            <div class="clear"></div>
   		</div>
        <div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Date Of Birth<b style="color:red;">*</b>:</label>
                <input id="dateOfBirth" class="popup_from_control"  name="customer.dateOfBirth" placeholder="YYYY-MM-DD" required="required" parsley-type="dateIso" type="text" size="14">
            </div>
            <div class="popup_from_down_list_right ">
            	<label class="popup_from_label">Nationality:</label>
            	<select name="customer.nationalityOfPassport" id="nationalityOfPassport" class="popup_from_select">
					<option value="Australia">Australia</option>
            		<option value="Canada">Canada</option>
            		<option value="China">China</option>
            		<option value="New Zealand">New Zealand</option>
            		<option value="United States of America">United States of America</option>
					[#list country as ctry]
						<option value="${ctry.name}">${ctry.name}</option>
					[/#list]>
            	</select>
            </div>
            <div class="clear"></div>
   		</div>
   		<div class="popup_from_down_list">
   			<div class="popup_from_down_list_left fl ">
            	<label class="popup_from_label">Residency:</label>
            	<select name="customer.residency" id="residency" class="popup_from_select">
						<option value="Same As Nationality">Same As Nationality</option>
						<option value="Australian PR">Australia PR</option>
						<option value="New Zelend PR">New Zelend PR</option>
						<option value="USA Green Card">USA Green Card</option>
						<option value="Canada Maple Card">Canada Maple Card</option>
						<option value="European Union PR">European Union PR</option>
						<option value="Others">Others</option>
            	</select>
            </div>
        	<div class="popup_from_down_list_right">
            	<label class="popup_from_label">Passport No.:</label>
                <input class="popup_from_control"  name="customer.passportNo"  id="passportNoId" type="text">
            </div>
        </div>
        <div class="popup_from_down_list">
            <div class="popup_from_down_list_left fl ">
            	<label class="popup_from_label">Expired Date:</label>
                <input id="expireDateOfPassport"  class="popup_from_control"  name="customer.expireDateOfPassport" placeholder="YYYY-MM-DD" required type="text" size="14">
            </div>
            <div class="popup_from_down_list_right">
            	<label class="popup_from_label">Language:</label>
                <select class="popup_from_select" name="customer.languageId" tabindex="-1" id="languageSelect">
					[#list language as language]
					<option value="${language.languageId}">
						${language.language}
					</option>
					[/#list]
                </select>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="popup_from_down_list">
            <div class="popup_from_down_list_left fl ">
            	<label class="popup_from_label">Remark:</label>
                <select name="customer.memoOfCustomer" id="remarks" class="popup_from_select">
                    <option value="0">
						--Select--
					</option>
					[#list constant.CUSTOMER_MEMOS as memoOfCustomer]
					<option value="${memoOfCustomer}">
						${memoOfCustomer}
					</option>
					[/#list]
                </select>
            </div>
            <div class="clear"></div>
        </div>
        </form>
    </div>
    <div class="popup_from_footer" style="background-color:#f3f3f3;">
        <button type="reset" class="popup_from_Cancel" data-dismiss="modal">Cancel</button>
        <button type="reset" onclick="initCustomerForm();" class="popup_from_Reset">Reset</button>
        <button type="button" onclick="saveCustomer(this);" class="popup_from_Save" data-dismiss="modal">Save</button>
        <button type="button" onclick="saveCustomerNew(this);" class="popup_from_Save" data-dismiss="modal">Save & New</button>
    </div>
</div>
</div>

<div class="popup_formEdit">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Edit Customer</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
    <div class="popup_from_down">
    	<form id="customerFormEdit">
		<input id="idInput" name="id" type="hidden" />
    	<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
    	<input name="customer.peerId" value="${peerUser.peerId}" type="hidden" />
    	<div class="popup_from_down_list">
        	<label class="popup_from_label" style="width:50px">Type:</label>
        	<label  id="type0" style="padding-left:0px;">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="0"
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
			</label>
        	<label class="radio-inline" id="type1" style="padding-left:0px;">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="1"
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Infant
			</label>
			<label style="padding-left:0px;" id="type2" class="radio-inline">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="2" 
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Child without Bed
			</label>
			<label class="radio-inline" id="type3" style="padding-left:0px;">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="3"
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Child with Bed
			</label>
			<label style="padding-left:0px;" id="type4" class="radio-inline">
				<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
					<input class="icheck" type="radio" name="customer.type" value="4" 
						style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper"
							style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
						</ins>
				</div>
				Adult
			</label>
			[#if groupLine.level!=""]
			<label class="popup_from_label" style="margin-left:10px;color:#018ddf;" onmouseover="overDiv('addDiv');" onmouseout="outDiv('addDiv');">
				<p>Age Remark</p>
      			<div id="addDiv" style="display:none;color:red;font-weight:normal;">
      				<div style="margin: 23px 10px 0 10px;">${groupLine.level}</div>
      			</div>
      		</label>
      		[/#if]
            <div class="clear"></div>
        </div>
    	<div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Last Name:</label>
                <input id="lastNameInput" class="popup_from_control" name="customer.lastName" onblur="customerListen();" onkeyup="this.value = this.value.toUpperCase();" required type="text">
            </div>
            <div class="popup_from_down_list_right">
            	<label class="popup_from_label">First Name:</label>
                <input id="firstNameInput" class="popup_from_control" name="customer.firstName" onblur="customerListen();" onkeyup="this.value = this.value.toUpperCase();" required type="text">
            </div>
            <div class="clear"></div>
        </div>
        <div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Middle Name:</label>
                <input id="middleNameInput" class="popup_from_control" name="customer.middleName" onblur="customerListen();" onkeyup="this.value = this.value.toUpperCase();" required type="text">
            </div>
            <div class="popup_from_down_list_right">
            	<label class="popup_from_label">Gender:</label>
            	<label class="radio-inline" id="sexRadi1" style="padding-left:0px;">
					<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
						<input class="icheck" type="radio" name="customer.sex" value="1"
							style="position: absolute; opacity: 0;">
							<ins class="iCheck-helper"
								style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
							</ins>
					</div>
					Female&nbsp;&nbsp;
				</label>
				<label style="padding-left:0px;" id="sexRadi2" class="radio-inline">
					<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
						<input class="icheck" type="radio" name="customer.sex" value="2" 
							style="position: absolute; opacity: 0;">
							<ins class="iCheck-helper"
								style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
							</ins>
					</div>
					Male
				</label>
            </div>
            <div class="clear"></div>
   		</div>
        <div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Date Of Birth:</label>
                <input id="dateOfBirthInput" class="popup_from_control"  name="customer.dateOfBirth" placeholder="YYYY-MM-DD" required="required" parsley-type="dateIso" type="text" size="14">
            </div>
            <div class="popup_from_down_list_right ">
            	<label class="popup_from_label">Nationality:</label>
                <select name="customer.nationalityOfPassport" id="nationalityOfPassportInput" class="popup_from_select">
					[#list country as ctry]
						<option value="${ctry.name}">${ctry.name}</option>
					[/#list]
            	</select>
            </div>
            <div class="clear"></div>
   		</div>
   		<div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
        		<label class="popup_from_label">Residency:</label>
            	<select name="customer.residency" id="residencyInput" class="popup_from_select">
						<option value="Same As Nationality">Same As Nationality</option>
						<option value="Australian PR">Australia PR</option>
						<option value="New Zelend PR">New Zelend PR</option>
						<option value="USA Green Card">USA Green Card</option>
						<option value="Canada Maple Card">Canada Maple Card</option>
						<option value="European Union PR">European Union PR</option>
						<option value="Others">Others</option>
            	</select>
            </div>
            <div class="popup_from_down_list_right ">
            	<label class="popup_from_label">Passport No.:</label>
                <input class="popup_from_control"  name="customer.passportNo"  id="passportNoInput" type="text">
            </div>
            <div class="clear"></div>
        </div>
        <div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Expiry Date:</label>
                <input id="expireDateOfPassportInput"  class="popup_from_control"  name="customer.expireDateOfPassport" placeholder="YYYY-MM-DD" required type="text" size="14">
            </div>
            <div class="popup_from_down_list_right ">
            	<label class="popup_from_label">Language:</label>
                <select id="languageIdSelect" class="popup_from_select" name="customer.languageId" tabindex="-1">
					[#list language as language]
					<option value="${language.languageId}">
						${language.language}
					</option>
					[/#list]
                </select>
            <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="popup_from_down_list">
            <div class="popup_from_down_list_left fl">
            	<label class="popup_from_label">Remark:</label>
                <select id="remarkInput" name="customer.memoOfCustomer" class="popup_from_select">
                    <option value="0">
						--Select--
					</option>
					[#list constant.CUSTOMER_MEMOS as memoOfCustomer]
					<option value="${memoOfCustomer}">
						${memoOfCustomer}
					</option>
					[/#list]
                </select>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="popup_from_footer" style="background-color:#f3f3f3;">
        <input type="hidden" id="typeOld" />
        <button type="reset" class="popup_from_Cancel" data-dismiss="modal">Cancel</button>
        <button type="button" onclick="updateCustomer(this);" class="popup_from_Save" data-dismiss="modal">Modify</button>
    </div>
    </form>
</div>
</div>

<div class="popup_formSelect">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Select Customer</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
   <div class="modal-body" width="100%">
      		<div style="border-bottom: 2px solid #ddd;margin:5 10px;padding: 8px;" >
		      	<input id="sea_lastName" name="customer.lastName" class="popup_from_control" type="text" placeholder="Last Name" style="width:150px;margin: 0 10px;">
		      	<input id="sea_firstName" name="customer.firstName"  placeholder="First Name" class="popup_from_control" type="text"style="width:150px;margin: 0 10px;">
		      	<input id="sea_orderNo" name="customer.orderNo" placeholder="Order No" class="popup_from_control" type="text" style="width:150px;margin: 0 10px;">
		      	<button class="popup_from_Save" id="s_cus" style="height: 35px;margin: 0 10px;">Search</button>
	      	</div>
			<form id="selectCustomerForm" action="addCustomerForSelection.jhtml" method="post">
				 <table  class="table table-bordered dataTable no-footer" id="datatable" style="margin-top:20px;">
				 	<input name="ordersTotalId" value="${ordersTotal.ordersTotalId}" type="hidden" />
		              <thead>
		                  <tr>
		                  	   <th width="5%"><input id="allCheck" onclick="check(this);" type="checkbox" disabled="disabled"></th>
		                       <th width="15%">Last/First/Middle Name</th>
		                       <th width="15%">Birthday</th>
		                       <th width="15%">Type</th>
		                       <th width="15%">Nationality</th>
		                       <th width="15%">Residency</th>
		                       <th width="20%">Pax No.</th>
		                    </tr>
		               </thead>
		          </table>
	        </form>
      </div>
      <div class="modal-footer">
		   <button class="popup_from_Cancel" data-dismiss="modal" type="button">Cancel</button>
		   <button class="popup_from_Save" data-dismiss="modal" type="button" id="selectCustomerForAddButton">Ok</button>
	  </div>
</div>
</div>

<div class="popup_formRoomType">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Eidt Room Type</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
    <div class="popup_from_down">
    	<div class="perbox">
        	<div class="tourinfo_titile_1">Room Type</div>
            <div class="line"></div>
            <div class="tourinfo_date">
                <div class="date_d fl">
                    <label class="per_label" style="width:45px">Guest:</label>
                    <select class="perlist" id="guestNums" onChange="setRoomType()">
                    	<option value="">Select Guest</option>
                    </select>
                </div>
                <div class="date_d fl">
                    <label class="per_label" style="width:45px">Room:</label>
                    <select class="perlist" id="roomTypes">
                    	<option value="">select roomType</option>
                    	[#list constant.GUEST_ROOM_TYPES as room]
							<option value="${room}" class="opsel">
								${room}
							</option>
						[/#list]
                    </select>
                </div>
                <div>
                    <label class="per_label" style="width:50px">No.:</label>
                    <select class="perlist" id="roomNums" style="width:120px">
                    	<option value="">Select Room No.</option>
                    	<option value="1">NO.1</option>
                    	<option value="2">NO.2</option>
                    	<option value="3">NO.3</option>
                    	<option value="4">NO.4</option>
                    	<option value="5">NO.5</option>
                    	<option value="6">NO.6</option>
                    	<option value="7">NO.7</option>
                    	<option value="8">NO.8</option>
                    	<option value="9">NO.9</option>
                    	<option value="10">NO.10</option>
                    	<option value="11">NO.11</option>
                    	<option value="12">NO.12</option>
                    	<option value="13">NO.13</option>
                    	<option value="14">NO.14</option>
                    	<option value="15">NO.15</option>
                    	<option value="16">NO.16</option>
                    	<option value="17">NO.17</option>
                    	<option value="18">NO.18</option>
                    	<option value="19">NO.19</option>
                    	<option value="20">NO.20</option>
                    </select>
                </div>
                <div class="clear"></div>
        	</div>
        	</div>
    </div>
    <div class="popup_from_footer" style="background-color:#f3f3f3;">
        <button type="reset" class="popup_from_Cancel" data-dismiss="modal">Cancel</button>
        <button type="button" onclick="addRoomType();" class="popup_from_Save" data-dismiss="modal">Modify</button>
    </div>
    </form>
</div>
</div>
<div class="popup_form_contacts">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Add Contacts</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
    <div class="popup_from_down">
    	<form id="contactsForm">
    	<input name="contacts.peerUserId" id="peerUserId" value="${peerUser.peerUserId}" type="hidden" />
    	<div class="popup_from_down_list">
        	<div class="popup_from_down_list_left fl" style="width:80%,text-align:center">
            	<label class="popup_from_label" style="width:130px">Consultant Name<b style="color:red;">*</b>:</label>
                <input class="popup_from_control" name="contacts.contactsName" id="contactsName" required type="text">
            </div>
            <div class="clear"></div>
        </div>
        </form>
    </div>
    <div class="popup_from_footer" style="background-color:#f3f3f3;">
        <button type="reset" class="popup_from_Cancel" data-dismiss="modal">Cancel</button>
        <button type="button" onclick="addContacts();" class="popup_from_Save" data-dismiss="modal">Save</button>
    </div>
</div>
</div>

<div class="popup_form_contactselect">
<div class="popup_form_box">
    <div class="popup_form_header" style="background-color:#018ddf;">
        <span style="color:#fff; font-size:16px;">Contacts List</span>
        <button type="button" class="popup_close" data-dismiss="modal" aria-hidden="true">×</button>
        <div class="clear"></div>
    </div>
    <div class="popup_from_down">
    	<form id="contactsForm">
    	<input name="contacts.peerUserId" id="peerUserId" value="${peerUser.peerUserId}" type="hidden" />
    	<div class="popup_from_down_list">
        	<table style="width:100%" id="clistTable">
        		<tr>
	        	   <th style="border-bottom:1px solid #E9E9E9">Consultant Name</th>
	        	   <th style="border-bottom:1px solid #E9E9E9;border-right:0px">Action</th>
        	   </tr>
        	   [#list cList as cList]
        	   	  <tr id="${cList.contactsId}">
            		<td value="${cList.contactsName}" style="border-bottom:1px solid #E9E9E9">${cList.contactsName}</td>
            		<td style="border-bottom:1px solid #E9E9E9;border-left:1px solid #E9E9E9"><a href="javascript:;"onclick="deleteCon('${cList.contactsId}')">Delete</a></td>
            	  </tr>
            	[/#list]
        	</table>
        </div>
        </form>
    </div>
    <div class="popup_from_footer" style="background-color:#f3f3f3;">
        <button type="reset" class="popup_from_Cancel" data-dismiss="modal">Cancel</button>
    </div>
</div>
</div>

<div class="popup_from_mask"></div>


<table style="display:none">
	<tr id="customerListTemplate" align="center" height="50">
		<td align="left"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td class="text-center">
			<a class="label label-default md-trigger" title="Modify" data-modal="customerEditForm" href=""><i class="fa fa-pencil"></i></a>
		    <a title="Delete" class="label label-danger" href="#"><i class="fa fa-times"></i></a>
		</td>
	</tr>
<table>
<select id="optionCache" style="display:none">
</select>

<!-- Modal -->
<div class="modal fade" id="confirm-delete-customer" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Client Info will be cancelled?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!-- Modal -->
<div class="modal fade" id="confirm-delete-order" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Booking will be cancelled?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="md-overlay"></div>

[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript">
/*************************悬浮层js****************************/
jQuery(document).ready(function($) {
	$('.popup_login').click(function(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_form').slideDown(400);
	})
	$('.popup_close').click(function(){
		$('.popup_from_mask').fadeOut(300);
		$('.popup_form').slideUp(400);
		$('.popup_formEdit').slideUp(400);
		$('.popup_formSelect').slideUp(400);
		$('.popup_formRoomType').slideUp(400);
		$('.popup_form_contacts').slideUp(400);
		$('.popup_form_contactselect').slideUp(400);
	})
	$('.popup_edit').click(function(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_formEdit').slideDown(400);
	})
	$('.popup_from_Cancel').click(function(){
		$('.popup_from_mask').fadeOut(300);
		$('.popup_formEdit').slideUp(400);
		$('.popup_form').slideUp(400);
		$('.popup_formSelect').slideUp(400);
		$('.popup_formRoomType').slideUp(400);
		$('.popup_form_contacts').slideUp(400);
		$('.popup_form_contactselect').slideUp(400);
	})
	$('.popup_select').click(function(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_formSelect').slideDown(400);
	})
	$('.popup_roomType').click(function(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_formRoomType').slideDown(400);
	})
	$('.popup_addContacts').click(function(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_form_contacts').slideDown(400);
	})
	
	$('.popup_addContactselect').click(function(){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_form_contactselect').slideDown(400);
	})
	$("#finalTr").hide();

})

$(document).ready(function(){
	$('input[name="radio-btn"]').wrap('<div class="radio-btn"><i></i></div>');
	$(".radio-btn").on("click", function () {
    	var _this = $(this),
        block = _this.parent().parent();
    	block.find("input:radio").attr("checked", false);
    	block.find(".radio-btn").removeClass("checkedRadio");
    	_this.addClass("checkedRadio");
    	_this.find("input:radio").attr("checked", true);
    });
    var showPay=$("#showPay").val();
	if(showPay=="pay"){
		tipchange(1);
		tipchange(3);
		$("#tipchange1").attr("disabled","disabled");
		$("#tipchange2").attr("disabled","disabled");
		$("#tipBox").attr("disabled","disabled");
		$("#tipchange3").attr("disabled","disabled");
		$("#tipchange4").attr("disabled","disabled");
		$("#expenseBox").attr("disabled","disabled");
	}
	if(showPay=="noPay"){
		$("#tipchange1").attr("disabled","disabled");
		$("#tipchange2").attr("disabled","disabled");
		$("#tipBox").attr("disabled","disabled");
		$("#tipchange3").attr("disabled","disabled");
		$("#tipchange4").attr("disabled","disabled");
		$("#expenseBox").attr("disabled","disabled");
	}
});

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
/*************************************************/
   $(document).ready(function(){
    	$("#departureDateInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay: available, numberOfMonths: 1, minDate: 1 });
    	$("#scheduleOfArriveTimeInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#dateOfBirthInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange:'-100:+0'});
    	$("#dateOfBirth").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange:'-100:+0',maxDate: -1 });
    	/*$("#dateOfBirth").datetimepicker({showSecond: true,showMillisec: true,timeFormat: 'hh:mm:ss:l' });*/
    	$("#arriveDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#expireDateOfPassportInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#expireDateOfPassport").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	
    	var self=changeTwoDecimal(Number($("#self").val())*Number($("#rate").val()));
    	$("#selfPrice").text(self);
    	$("#sPrice").text(self);
    	$("#selfPax").text(self);
    	var tip=changeTwoDecimal(Number($("#tip").val())*Number($("#rate").val()));
    	$("#tipPrice").text(tip);
    	$("#tPrice").text(tip);
    	$("#tipPax").text(tip);
    	$(".tip").show();
    	$(".self").hide();
		App.wizard();
    });
    function getCurrentTime() { $(".ui-datepicker-current").click(); }
    //获取两位小数点
	function changeTwoDecimal(x){
			var f_x = parseFloat(x);
			if (isNaN(f_x))
			{
				//alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x*100)/100;
		
			return f_x;
		}
    var dateArray = "${groupLine.departureDate}";
    var strs= new Array(); //定义一数组 
	availableDates=dateArray.split(","); //字符分割 
	function available(date) {
		var dmy = $.datepicker.formatDate('yy-mm-dd',date);
		if ($.inArray(dmy, availableDates) != -1) {
			return [true, "","Available"];
		} else {
			return [false,"","unAvailable"];
		}
	}
    function curInfo(divnum){
     nextDiv(divnum);
     //计算佣金值
     	var autPrice=Number($("#compax").text())*Number($("#compaxdiv").text());
     	var childPrice=Number($("#childcompax").text())*Number($("#childcompaxdiv").text());
     	$("#peerUserFee").val(changeTwoDecimal(Number(autPrice)+Number(childPrice)));
     	var groupLineId=$("#groupId").val();
		var departureTime=$("#departureDateInput").val();
		var isOceania=$("#isOceania").val();
    	if($("#totalPeople").val()>0){
    		var totalPrice=$("#PriceTotal").val();
	    	var ordersTotalId=$("#ordersTotalId").val();
	    	if(isOceania==1){
	    		$.ajax({
	                cache: true,
	                type: "POST",
	                url:"backUp.jhtml?ordersTotalId="+ordersTotalId+"&groupLineId="+groupLineId+"&departureTime="+departureTime,
	                data:$('#ww').serialize(),// 你的formid
	                async: true,
	                error: function(request) {
	                    alert("Connection error");
	                },
	                success: function(data) {
	                }
	            });
	    	}else{
	    		$.ajax({
	                cache: true,
	                type: "POST",
	                url:"backUp.jhtml?ordersTotalId="+ordersTotalId+"&groupLineId="+groupLineId+"&departureTime="+departureTime,
	                data:$('#ww').serialize(),// 你的formid
	                async: true,
	                error: function(request) {
	                    alert("Connection error");
	                },
	                success: function(data) {
	                }
	            });
	         }
    	}
    }
    function sub(){
		if($('#terms').is(':checked')) {
		    $("#subBT").attr("disabled","disabled");
	        var itemJson="Adult:1:"+$("#adult").text()+":"+$("#adultNum").text()+",Child with Bed:2:"+$("#bed").text()+":"+$("#bedNum").text()
	        			+",Child without Bed:3:"+$("#notBed").text()+":"+$("#notBedNum").text()+",Infant:4:"+$("#baby").text()+":"+$("#babyNum").text()
	        			+",Service Fee:5:"+$("#tPrice").text()+":"+$("#tipPaxs").text()+",Compulsory Programs:6:"+$("#sPrice").text()+":"+$("#selfPaxs").text()
	        			+",Single Supplement:7:"+$("#sup").text()+":1"+",Pre/Post-Stay:8:"+$("#pp").text()+":1"
	        			+",Extra Transfer:9:"+$("#ps").text()+":1"+",Adult Commission:10:"+$("#compax").text()+":"+$("#compaxdiv").text()
	        			+",Child Commission:11:"+$("#childcompax").text()+":"+$("#childcompaxdiv").text();
	        $("#feeItems").val(itemJson);
	    	$.ajax({
	                cache: true,
	                type: "POST",
	                url:"addProduct.jhtml",
	                data:$('#ww').serialize(),// 你的formid
	                async: true,
	                error: function(request) {
	                    alert("Booking NO: "+$("#orderNumber").val()+" Create Failure ");
	                },
	                success: function(data) {
	                   if(data.message=="OK"){
	                   		alert("Booking NO: "+$("#orderNumber").val()+" Create Success");
	                   		window.location.href="${base}/admin/peerUser/list.jhtml";
	                   }else{
	                   	    alert("Create Failure ");
	                   }
	                }
	            });
		 }else{
		 	alert('please agree with the user agreement.');
		 }
    	
    }
	   
    /* 将上一个客人的信息复制到本客人   */
    function theSameAsPrevious(n){
    	var number = n;
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].flightCode']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].flightCode']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].flightNumber']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].flightNumber']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].arriveDate']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].arriveDate']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].arriveTime']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].arriveTime']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].flightCode']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].flightCode']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].flightNumber']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].flightNumber']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].arriveDate']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].arriveDate']").val());
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].arriveTime']").val($("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].arriveTime']").val());
    	var ifPickUp = $("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[0].ifPickUp']:checked").val();
    	var ifSendUp = $("input[name='productVO.customerFlights[" + (number - 1) + "].customerFlightList[1].ifSendUp']:checked").val();
    	$("input[name='productVO.customerFlights[" + number + "].customerFlightList[0].ifPickUp']").parent().parent().eq(ifPickUp - 1).click();
		$("input[name='productVO.customerFlights[" + number + "].customerFlightList[1].ifSendUp']").parent().parent().eq(ifSendUp - 1).click();  	
    }
    
    Array.prototype.contains = function(element) {
	    for (var i = 0; i < this.length; i++) {
			if (this[i] === element) {
			    return true;
			}
	    }
	    return false;
	};
	
    var twinBed = '${constant.GUEST_ROOM_TYPES[0]}';
    var kingBed = '${constant.GUEST_ROOM_TYPES[1]}';
    var single = '${constant.GUEST_ROOM_TYPES[2]}';
    var extraBed = '${constant.GUEST_ROOM_TYPES[3]}';
    var suite = '${constant.GUEST_ROOM_TYPES[4]}';
    var sharingExistingBed = '${constant.GUEST_ROOM_TYPES[5]}';
    var roomMatching = '${constant.GUEST_ROOM_TYPES[6]}';
    
    $(document).ready(function(){
    	App.init();
    });
    
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	
    /* 新增客人时初始化房型和房号以及reset时reset所有的select */
    function initCustomerForm(){
		$("#lastNameId").val("");	
		$("#firstNameId").val("");
		$("#middleNameId").val("");
		$("#dateOfBirth").val("");
		$("#sexRadio1").click();
		$("#nationalityOfPassport").val("Australia");	
		$("#passportNoId").val("");
		$("#expireDateOfPassport").val("");
		$("#remarks").val(0);	
		$("#type5").click();
		$("#languageSelect").val("f1340b85-8218-11e2-8c18-94de800a7ba1");
		$("#residency").val("Same As Nationality");	
    }
    //备选客人列表
    $("#selectCustomerButton").click(function(){
	 $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "bLengthChange":false,
            "bDestroy":true,
            "aLengthMenu":[10,20,50,100],
            "ajax": {
                url: "[@spring.url '/admin/customer/list.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.lastName = $("#sea_lastName").val();
					data.firstName = $("#sea_firstName").val();
					data.orderNo = $("#sea_orderNo").val();
					data.peerId = $("#peerId").val();
				}
            },
            "columns": [
         	    { "data": "customerId",
                  "render": function (data, type, row) {
	                       return '<input class="customerCheckbox" name="customerIds" value="'+ data +'" type="checkbox">';
                   }
                 },
				{ "data": "lastName",
					 "render": function (data, type, row) {
					 	   var name=data+"/"+row.firstName+"/"+row.middleName;
	                       return name;
                   }
				},
				{ "data": "dateOfBirth" },
				{ "data": "type",
					 "render": function (data, type, row) {
					 	   var typeP="";
					 	   if(data==1){
					 	   		typeP="Infant";
					 	   }else if(data==2){
					 	   		typeP="Child without Bed";
					 	   }else if(data==3){
					 	   		typeP="Child with Bed";
					 	   }else{
					 	   		typeP="Adult";
					 	   }
	                       return typeP;
                   }
				},
				{ "data": "nationalityOfPassport" },
				{ "data": "residency" },
				{ "data": "passportNo" }
            ]
        });
    })
    $("#selectCustomerForAddButton").click(function(){
    	var length = $(".customerCheckbox:checked").size();
		if(length == 0){
			alert("Select Customer");
			return;
		}else{
			$.ajax({
				url:'addCustomerForSelection.jhtml',
				data: $("#selectCustomerForm").serialize(),
				type:"POST",
				async: true,
				beforeSend:function(){
				},
				success:function(map){
						for(var a=0;a<map.num;a++){
							var type=map.customerList[a].type;
							var html='<tr id="'+map.customerList[a].ticketType+'" align="center" height="50">';
								html+='<td align="left">'+map.customerList[a].lastName+'/'+map.customerList[a].firstName+'/'+map.customerList[a].middleName+'</td>';
								if(map.customerList[a].sex==1){
									html+='<td>F</td>';
								}else{
									html+='<td>M</td>';
								}
								html+='<td>'+map.customerList[a].nationalityOfPassport+'</td>';
								html+='<td>'+map.customerList[a].residency+'</td>';
								html+='<td>'+map.customerList[a].passportNo+'</td>';
								html+='<td>'+map.customerList[a].dateOfBirth+'</td>';
								if(map.customerList[a].type==1){
									html+='<td>Infant</td>';
									typeH="Infant";
								}else if(map.customerList[a].type==2){
									html+='<td>Child without Bed</td>';
									typeH="Child without Bed";
								}else if(map.customerList[a].type==3){
									html+='<td>Child with Bed</td>';
									typeH="Child with Bed";
								}else{
									html+='<td>Adult</td>';
									typeH="Adult";
								}
								if(map.customerList[a].memoOfCustomer==0){
									html+='<td> </td>';
								}else{
									html+='<td>'+map.customerList[a].memoOfCustomer+'</td>';
								}
								html+='<td class="text-center"><a class="label label-danger" href="javascript:deleteCustomer(\''+map.customerList[a].ticketType+'\',\''+map.customerList[a].type+'\');"> <i class="fa fa-times" ></i></a>';
								html+='</td>';
								html+='</tr>';
						$("#customerList").append(html);
						htmlP ='<option value="'+map.customerList[a].customerId+','+map.customerList[a].type+'">'+map.customerList[a].lastName +'/'+map.customerList[a].firstName+'/'+map.customerList[a].middleName+'---'+typeH+'</option>';
						$("#guestNum").append(htmlP);
						$("#total").val(Number($("#total").val())+1);
						$("#totalPeople").attr("value",Number($("#totalPeople").val())+1);
						$("#totalPeople1").text(Number($("#totalPeople").val()));
						addPrice(type);
						}
						$('.popup_from_mask').fadeOut(300);
						$('.popup_formSelect').slideUp(400);
				}
			});
		}
    });
     $("#s_cus").on( 'click', function () {
        $('#datatable').DataTable().draw();
    });
	/*  保存客人信息   */
	function saveCustomer(saveButton){
		if($("#dateOfBirth").val()==""){
			alert("Plase Enter Birthday");
		}else if($("#lastNameId").val()==""){
			alert("Plase Enter Last Name");
		}else if($("#firstNameId").val()==""){
			alert("Plase Enter First Name");
		}else if($("#nationalityOfPassport").val()==""){
			alert("Plase Enter Nationality");
		}else{
			var type=$("input:radio[name='customer.type']:checked").val();
			var guestRoomType = $("#guestRoomTypeAddSelect").val();
			var roomNumber = $("#addSelect").val();
			if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
				alert('Extra bed can not exist without any roommate.');
				return;
			}
			var $customerForm = $(saveButton).parent().parent();
			$.ajax({
				url:'${base}/admin/orders/addCustomer.jhtml',
				data: $("#customerForm").serialize(),
				type:"POST",
				async: true,
				beforeSend:function(){
				},
				success:function(result){
					if(result.Msg == 'noOrder'){
						alert('There is no order in the total order.');
						$(saveButton).prev().click();
						return;
					}
					addCustomerList($customerForm,result.customerOrderRelId,type);
					if(type==1){
			 	   		typeH="Infant";
			 	   	}else if(type==2){
			 	   		typeH="Child without Bed";
			 	   	}else if(type==3){
			 	   		typeH="Child with Bed";
			 	   	}else{
			 	   		typeH="Adult";
				 	 }
					htmlP ='<option value="'+result.customerId+','+type+'">'+$("#lastNameId").val() +'/'+$("#firstNameId").val()+'/'+$("#middleNameId").val()+'---'+typeH+'</option>';
                    //$("#guestNum").find("option:not(:first)").remove();
					$("#guestNum").append(htmlP);
					$(saveButton).prev().click();
					$("#total").val(Number($("#total").val())+1);
					$("#totalPeople").attr("value",Number($("#totalPeople").val())+1);
					$("#totalPeople1").text(Number($("#totalPeople").val()));
					addPrice(type);
					$('.popup_from_mask').fadeOut(300);
					$('.popup_form').slideUp(400);
				}
			});
		}
	}
	
	/*保存信息后继续添加客人信息*/
	function saveCustomerNew(saveButton){
		if($("#dateOfBirth").val()==""){
			alert("Plase Enter Birthday");
		}else if($("#lastNameId").val()==""){
			alert("Plase Enter Last Name");
		}else if($("#firstNameId").val()==""){
			alert("Plase Enter First Name");
		}else if($("#nationalityOfPassport").val()==""){
			alert("Plase Enter Nationality");
		}else{
			var type=$("input:radio[name='customer.type']:checked").val();
			var guestRoomType = $("#guestRoomTypeAddSelect").val();
			var roomNumber = $("#addSelect").val();
			if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
				alert('Extra bed can not exist without any roommate.');
				return;
			}
			var $customerForm = $(saveButton).parent().parent();
			$.ajax({
				url:'${base}/admin/orders/addCustomer.jhtml',
				data: $("#customerForm").serialize(),
				type:"POST",
				async: true,
				beforeSend:function(){
				},
				success:function(result){
				if(result.Msg == 'noOrder'){
						alert('There is no order in the total order.');
						$(saveButton).prev().click();
						return;
					}
					addCustomerList($customerForm,result.customerOrderRelId,type);
					if(type==1){
			 	   		typeH="Infant";
			 	   	}else if(type==2){
			 	   		typeH="Child without Bed";
			 	   	}else if(type==3){
			 	   		typeH="Child with Bed";
			 	   	}else{
			 	   		typeH="Adult";
				 	 }
					htmlP ='<option value="'+result.customerId+','+type+'">'+$("#lastNameId").val() +'/'+$("#firstNameId").val()+'/'+$("#middleNameId").val()+'---'+typeH+'</option>';
                    //$("#guestNum").find("option:not(:first)").remove();
					$("#guestNum").append(htmlP);
					$("#total").val(Number($("#total").val())+1);
					$("#totalPeople").attr("value",Number($("#totalPeople").val())+1);
					$("#totalPeople1").text(Number($("#totalPeople").val()));
					addPrice(type);
					initCustomerForm();
				}
			});
		}
	}
	/* 向客人列表增加一条记录  */
	function addCustomerList($customerForm,customerOrderRelId,type){
		var $customerListTr = $("#customerListTemplate").clone(true).removeAttr("id").attr("id",customerOrderRelId);
		setValue($customerListTr,$customerForm,customerOrderRelId,1,type);
		$("#customerList").append($customerListTr);
	}
	
	/* 对客人列表更新客人变更后的值   */
	function updateCustomerList($customerForm,type){
		var customerOrderRelId = $('#idInput').val();
		setValue($("#" + customerOrderRelId),$customerForm,customerOrderRelId,0,type);
	}
	
	/* 给列表设置值  */
	function setValue($customerListTr,$customerForm,customerOrderRelId,isAddCustomer,type){
		var cusBirth=$customerForm.find("input[name='customer.dateOfBirth']").val();
		var $tds = $customerListTr.find("td");
		$tds.eq(0).html($customerForm.find("input[name='customer.lastName']").val() + '/' + $customerForm.find("input[name='customer.firstName']").val()+ ' ' + $customerForm.find("input[name='customer.middleName']").val());
		$tds.eq(1).html($customerForm.find("input[name='customer.sex']:checked").val() == '1' ? 'F':'M');
		$tds.eq(2).html($customerForm.find("select[name='customer.nationalityOfPassport']").val());
		$tds.eq(3).html($customerForm.find("select[name='customer.residency']").val());
		$tds.eq(4).html($customerForm.find("input[name='customer.passportNo']").val());
		$tds.eq(5).html(cusBirth);
		if($customerForm.find("input[name='customer.type']:checked").val()==1){
			$tds.eq(6).html("Infant");
		}else if($customerForm.find("input[name='customer.type']:checked").val()==2){
			$tds.eq(6).html("Child without Bed");
		}else if($customerForm.find("input[name='customer.type']:checked").val()==3){
			$tds.eq(6).html("Child with Bed");
		}else{
			$tds.eq(6).html("Adult");
		}
		if($customerForm.find("select[name='customer.memoOfCustomer']").val()==0){
			$tds.eq(7).html("");
		}else{
			$tds.eq(7).html($customerForm.find("select[name='customer.memoOfCustomer']").val());
		}
		var $a = $tds.eq(8).find("a");
		$a.eq(0).attr("href","javascript:editCustomer('" + customerOrderRelId + "');");
		$a.eq(1).attr("href","javascript:deleteCustomer('" + customerOrderRelId + "','" + type+ "');");
	}
	
	/* 编辑客人信息  */
	function editCustomer(customerOrderRelId){
		$.post("${base}/admin/orders/loadCustomer.jhtml",{"id":customerOrderRelId},function(customerOrderRel){
			$("#idInput").val(customerOrderRelId);
			$("#lastNameInput").val(customerOrderRel.customer.lastName);	
			$("#firstNameInput").val(customerOrderRel.customer.firstName);
			$("#middleNameInput").val(customerOrderRel.customer.middleName);	
			$("#dateOfBirthInput").val(customerOrderRel.customer.dateOfBirth);	
			$("#typeOld").val(customerOrderRel.customer.type);		
			$("#sexRadi" + customerOrderRel.customer.sex).click();
			$("#nationalityOfPassportInput").val(customerOrderRel.customer.nationalityOfPassport);	
			$("#residencyInput").val(customerOrderRel.customer.residency);		
			$("#passportNoInput").val(customerOrderRel.customer.passportNo);	
			$("#expireDateOfPassportInput").val(customerOrderRel.customer.expireDateOfPassport);	
			$("#remarkInput").val(customerOrderRel.customer.memoOfCustomer);	
			$("#languageIdSelect").val(customerOrderRel.customer.languageId);	
			$("#type"+customerOrderRel.customer.type).click();
			//getRoomNumberOptionsAndSetValue(customerOrderRel);
		});
		$('.popup_formEdit').slideDown(400);
		$('.popup_from_mask').fadeIn(300);
	}
	
	/*  异步获取可选的客人,并根据值显示选中  */
	function getRoomNumberOptionsAndSetValue(customerOrderRel){
		var $roomNumberSelect = $("#roomNumberEditSelect");
		var roomNum = customerOrderRel.roomNumber;
		var roomType = customerOrderRel.guestRoomType;
		$roomNumberSelect.find("option").remove();
		
		if(roomType == single || roomType == sharingExistingBed || roomType == roomMatching){
		//如果客人的房型是单间或不占床以及拼房
			/* 显示New Room或No Room,并将选项值设置为房间号  */
			if(roomType == sharingExistingBed){
				$roomNumberSelect.append("<option value='" + roomNum + "'>No Room</option>");
			}else{
				$roomNumberSelect.append("<option value='" + roomNum + "'>New Room</option>");
			}
			$roomNumberSelect.val(roomNum);
		}else if(roomType == twinBed || roomType == kingBed){
		//如果客人的房型是标间或大床房
			if(customerOrderRel.roomIsFull == 0){
				$roomNumberSelect.append("<option value='"+ roomNum +"'>New Room</option>");
			}else{
				$roomNumberSelect.append("<option value='0'>New Room</option>");
			}
			var append;
			$.post("${base}/admin/orders/getRoommatesWithRoomNumber.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}","roomNumber":roomNum},function(result){
				$.each(result,function(i,cusorel){
					if(cusorel.id != customerOrderRel.id){
						append = '<option value="' + cusorel.roomNumber + '">' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName + '</option>';
						$roomNumberSelect.append(append);
					}
				});
				$roomNumberSelect.val(roomNum);
			});
		}else{
		//如果客人的房型是加床或套房
			if(roomType == suite){
				$roomNumberSelect.append("<option value='0'>New Room</option>");
			}
			var roomNumbers = new Array();
			var index = 0;
			$.post("${base}/admin/orders/getRoommatesWithRoomNumber.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}","roomNumber":roomNum},function(result){
				$.each(result,function(i,cusorel){
					if(cusorel.id != customerOrderRel.id){
						if(roomNumbers.contains(cusorel.roomNumber)){
							var $existOption = $roomNumberSelect.find("option[value="+ cusorel.roomNumber +"]");
							$existOption.html($existOption.html() + '/' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName);
						}else{
							roomNumbers[index++] = cusorel.roomNumber;
							append = '<option value="' + cusorel.roomNumber + '">' + cusorel.customer.lastName + ' ' + cusorel.customer.firstName + '</option>';
						 	$roomNumberSelect.append(append);
						}
					}
				});
				if($roomNumberSelect.find("option[value="+ roomNum +"]").size() == 0){
					$roomNumberSelect.find("option[value='0']").val(roomNum);
				}
				$roomNumberSelect.val(roomNum);
			});
		}
		$roomNumberSelect.attr("first","true");
		$roomNumberSelect.attr("roomType",roomType);
		$roomNumberSelect.attr("roomNumber",roomNum);
		$("#optionCache").find("option").remove();
	}
	
	/* 修改客人时根据房型变更可选的房间  */
	function getEditRoommate(roomType){
		var $roomNumberSelect = $("#roomNumberEditSelect");
		
		if($roomNumberSelect.attr("first")){
		/* 如果是第一次变动，将options缓存起来  */
			$roomNumberSelect.removeAttr("first");
			$roomNumberSelect.find("option").appendTo($("#optionCache"));
			
			getRoommate(roomType,$roomNumberSelect);
		}else{
			if($roomNumberSelect.attr("roomType") == roomType){
			/* 如果返回原始自带的房型，从缓存中拿出，选择好  */
				$roomNumberSelect.find("option").remove();
				$roomNumberSelect.append($("#optionCache").find("option").clone(true));
				$roomNumberSelect.val($roomNumberSelect.attr("roomNumber"));
			}else{
				getRoommate(roomType,$roomNumberSelect);
			}
		}
	}
	
	/* 新增客人时根据房型变更可选的房间  */
	function getRoommate(roomType,$roomNumberSelect){
		$roomNumberSelect.find("option").remove();
		if(roomType == sharingExistingBed){
			$roomNumberSelect.append('<option value="0">No Room</option>');
		}else if(roomType=="Single" || roomType=="Room Matching" || roomType=="Suite"){
			$roomNumberSelect.append('<option value="0">New Room</option>');
		}else if(roomType=="Extra Bed"){
			$.ajax({
				url:"${base}/admin/peerUser/getKingRoom.jhtml",
				data:"ordersTotalId=${ordersTotal.ordersTotalId}",
				type:"POST",
				async: true,
				dataType:"json",
				beforeSend:function(){
				},
				success:function(map){
					var append="";
					for(var i=0;i<map.num;i++){
						append += '<option value="'+map.corList[i].roomNumber+'">'+map.corList[i].customerId+'</option>';
					}
					$("#roomNum").append(append);
				}
			});
		}else{
			$.ajax({
				url:"${base}/admin/peerUser/getNoRoom.jhtml",
				data:"ordersTotalId=${ordersTotal.ordersTotalId}",
				type:"POST",
				async: true,
				dataType:"json",
				beforeSend:function(){
				},
				success:function(map){
					var append='<option value="0">New Room</option>';
					for(var i=0;i<map.num;i++){
						append += '<option value="'+map.corList[i].customer.customerId+'">'+map.corList[i].customer.lastName+'/'+map.corList[i].customer.firstName+'/'+map.corList[i].customer.middleName+'</option>';
					}
					$("#roomNum").append(append);
				}
			});
		}
	}
	
	/* 在房型不是Sharing Existing Bed(不占床),Single(单人间)以及Room Matching(拼房)的情况下异步获取可以组的房间  */
	function getRoomNumberOptions(roomType){
		if(roomType != single && roomType != roomMatching && roomType != sharingExistingBed){
			$.post("getRoommates.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}"},function(result){
				var append;
				var roomNumbers = new Array();
				var index = 0;
				$.each(result,function(i,customerOrderRel){
					if(roomType == extraBed && customerOrderRel.roomNumber == $roomNumberSelect.attr("roomNumber")){
						return ;
					}
					if(roomNumbers.contains(customerOrderRel.roomNumber)){
						var $existOption = $roomNumberSelect.find("option[value="+ customerOrderRel.roomNumber +"]");
						$existOption.html($existOption.html() + '/' + customerOrderRel.customer.lastName + ' ' + customerOrderRel.customer.firstName);
					}else{
						roomNumbers[index++] = customerOrderRel.roomNumber;
						append = '<option value="' + customerOrderRel.roomNumber + '">' + customerOrderRel.customer.lastName + ' ' + customerOrderRel.customer.firstName + '</option>';
					 	$roomNumberSelect.append(append);
					}
				});
			});
		}

	
		/*if(roomType =='Extra Bed'){
			$.post("${base}/admin/orders/getRoommates.jhtml",{"guestRoomType":roomType,"ordersTotalId":"${ordersTotal.ordersTotalId}"},function(result){
				var append;
				var roomNumbers = new Array();
				var index = 0;
				$.each(result,function(i,customerOrderRel){
						roomNumbers[index++] = customerOrderRel.roomNumber;
						append = '<option value="' + customerOrderRel.roomNumber + '">' + customerOrderRel.customer.lastName + ' ' + customerOrderRel.customer.firstName + '</option>';
					 	$("#roomNum").append(append);
				});
			});
		}
		if(roomType != single && roomType != roomMatching && roomType != sharingExistingBed){
			roomType
		}*/
	}
	/*  更新客人信息   */
	function updateCustomer(updateButton){
		var guestRoomType = $("#guestRoomTypeSelect").val();
		var roomNumber = $("#roomNumberEditSelect").val();
		if(guestRoomType == 'Extra Bed' && roomNumber == '0'){
			alert('Extra bed can not exist without any roommate.');
			return;
		}	
		var $customerForm = $(updateButton).parent().parent();
		var type=$customerForm.find("input[name='customer.type']:checked").val();
		var typeOld=$("#typeOld").val();
		if(type!=typeOld){
			delPrice(typeOld);
			addPrice(type);
		}
		$.ajax({
			url:'updateCustomer.jhtml',
			data: $("#customerFormEdit").serialize(),
			type:"POST",
			async: true,
			beforeSend:function(){
			},
			success:function(){
				$('.popup_from_mask').fadeOut(300);
				$('.popup_formEdit').slideUp(400);
				updateCustomerList($customerForm,type);
				$(updateButton).prev().click();
				alert("Client Info. Updated！");
			}
		});
	}
	
	/* 删除客人  */
	function deleteCustomer(customerOrderRelId,type){
		$.post("${base}/admin/peerUser/delCustomer.jhtml",{"customerOrderRelId" : customerOrderRelId},function(result){
			$("tr#"+customerOrderRelId).remove();
			if(result == 'success' || result == 'all'){
				alert('Client Info. Cancelled！');
			}
				/******改变显示的人数******/
				$("#totalPeople1").text(Number($("#totalPeople1").text())-1);
				$("#totalPeople").attr("value",Number($("#totalPeople").val())-1);
				delPrice(type);
		}); 
	}
	/**********删除相应费用***************/
	function delPrice(type){
		var totalPrice=$("#totalS").text();
		var tPrice=$("#totalPrice").text();
		var self=0;
		var tip=0;
		var selfP=0;
		var tipP=0;
		if($("input:checkbox[name='expenseBox']:checked").size()){
		   self=$("#selfPrice").text();
		   selfP=1;
		}
		if($("input:checkbox[name='tipBox']:checked").size()){
		   tip=$("#tipPrice").text();
		   tipP=1;
		}
		var commission=$("#comm").val();
		if(type==1){
		   	var baby=$("#babyNum").text();
		   	$("#babyNum").text(Number(baby)-1);
		   	var totalPrices=changeTwoDecimal(Number(totalPrice)-Number($("#baby").text()));
		   	$("#totalPrice").text(totalPrices);
		   	$("#totalSP").attr("value",totalPrices);/*总费用，应收款*/
			$("#totalS").text(totalPrices);
		}else if(type==2){
			//小费值自费值
			var xtip=changeTwoDecimal(Number($("#tipTotal").val())-Number(tip));
			var xself=changeTwoDecimal(Number($("#selfTotal").val())-Number(self));
			var notBed=$("#notBedNum").text();
			$("#notBedNum").text(Number(notBed)-1);
			var totalPrices=changeTwoDecimal(Number(totalPrice)-Number($("#notBed").text())-Number(self)-Number(tip));
			var prices=changeTwoDecimal(Number(totalPrice)-Number($("#notBed").text()));
		   	$("#totalSP").attr("value",prices);/*总费用，应收款*/
			$("#totalS").text(prices);
		   	$("#tipTotal").attr("value",xtip);/*小费总费用*/
		   	$("#tipDiv").text(xtip);/*小费总费用*/
		   	$("#selfTotal").attr("value",xself);/*自费总费用*/
		   	$("#selfDiv").text(xself);/*自费总费用*/
		   	if(tipP>0){
		   		var t=changeTwoDecimal(Number($("#tipPaxs").text())-1);
		   		$("#tipPaxs").text(t);/*小费人数*/
		   	}else{
		   		$("#tipPaxs").text(0);/*小费人数*/
		   	}
		   	if(selfP>0){
		   		var s=changeTwoDecimal(Number($("#selfPaxs").text())-1);
		   		$("#selfPaxs").text(s);/*自费人数*/
		   	}else{
		   		$("#selfPaxs").text(0);/*自费人数*/
		   	}
		}else if(type==3){
			//小费值自费值
			var xtip=changeTwoDecimal(Number($("#tipTotal").val())-Number(tip));
			var xself=changeTwoDecimal(Number($("#selfTotal").val())-Number(self));
			var bed=$("#bedNum").text();
			$("#bedNum").text(Number(bed)-1);
			var totalPrices=changeTwoDecimal(Number(tPrice)-Number($("#bed").text())-Number(self)-Number(tip));
			var prices=changeTwoDecimal(Number(totalPrice)-Number($("#bed").text()));
		   	$("#totalSP").attr("value",prices);/*总费用，应收款*/
			$("#totalS").text(prices);
		   	$("#tipTotal").attr("value",xtip);/*小费总费用*/
		   	$("#tipDiv").text(xtip);/*小费总费用*/
		   	$("#selfTotal").attr("value",xself);/*自费总费用*/
		   	$("#selfDiv").text(xself);/*自费总费用*/
		   	$("#tipPaxs").val($("#compaxdiv").text());/*小费人数*/
		   	$("#selfPaxs").val($("#compaxdiv").text());/*自费人数*/
		   	if(tipP>0){
		   		var t=changeTwoDecimal(Number($("#tipPaxs").text())-1);
		   		$("#tipPaxs").text(t);/*小费人数*/
		   	}else{
		   		$("#tipPaxs").text(0);/*小费人数*/
		   	}
		   	if(selfP>0){
		   		var s=changeTwoDecimal(Number($("#selfPaxs").text())-1);
		   		$("#selfPaxs").text(s);/*自费人数*/
		   	}else{
		   		$("#selfPaxs").text(0);/*自费人数*/
		   	}
		}else{
			//小费值自费值
			var xtip=changeTwoDecimal(Number($("#tipTotal").val())-Number(tip));
			var xself=changeTwoDecimal(Number($("#selfTotal").val())-Number(self));
			var adult=$("#adultNum").text();
			$("#adultNum").text(Number(adult)-1);
			var totalPrices=changeTwoDecimal(Number(tPrice)-Number($("#adult").text())-Number(self)-Number(tip));
			var prices=changeTwoDecimal(Number(totalPrice)-Number($("#adult").text()));
		   	$("#totalSP").attr("value",prices);/*总费用，应收款*/
			$("#totalS").text(prices);
		    $("#tipTotal").attr("value",xtip);/*小费总费用*/
		   	$("#tipDiv").text(xtip);/*小费总费用*/
		   	$("#selfTotal").attr("value",xself);/*自费总费用*/
		   	$("#selfDiv").text(xself);/*自费总费用*/
		   	$("#tipPaxs").val($("#compaxdiv").text());/*小费人数*/
		   	$("#selfPaxs").val($("#compaxdiv").text());/*自费人数*/
		   	if(tipP>0){
		   		var t=changeTwoDecimal(Number($("#tipPaxs").text())-1);
		   		$("#tipPaxs").text(t);/*小费人数*/
		   	}else{
		   		$("#tipPaxs").text(0);/*小费人数*/
		   	}
		   	if(selfP>0){
		   		var s=changeTwoDecimal(Number($("#selfPaxs").text())-1);
		   		$("#selfPaxs").text(s);/*自费人数*/
		   	}else{
		   		$("#selfPaxs").text(0);/*自费人数*/
		   	}
		}
		//佣金
		var paxNumber=Number($("#bedNum").text())+Number($("#notBedNum").text());
		var autNumber=$("#adultNum").text();
		$("#compaxdiv").text(autNumber);//佣金人数
		$("#childcompaxdiv").text(paxNumber);//小孩佣金人数
		//佣金总额
		var autPrice=Number($("#comm").val())*Number($("#compaxdiv").text());
     	var childPrice=Number($("#childcomm").val())*Number($("#childcompaxdiv").text());
     	$("#totalComm").text(changeTwoDecimal(Number(autPrice)+Number(childPrice)));
     	//计算回扣
     	price();
     	
	}
	/************增加相应费用***************/
	function addPrice(type){
		var totalPrice=$("#totalS").text();
		var tPrice=$("#totalPrice").text();
		var self=0;
		var tip=0;
		var selfP=0;
		var tipP=0;
		if($("input:checkbox[name='expenseBox']:checked").size()){
		   self=$("#selfPrice").text();
		   selfP=1;
		}
		if($("input:checkbox[name='tipBox']:checked").size()){
		   tip=$("#tipPrice").text();
		   tipP=1;
		}
		//佣金
		var commission=$("#comm").val();
		if(type==1){
		   	var baby=$("#babyNum").text();
		   	$("#babyNum").text(Number(baby)+1);
		   	$("#compaxdiv").text(Number($("#compaxdiv").text())+1);//佣金人数
		   	var totalPrices=changeTwoDecimal(Number(totalPrice)+Number($("#baby").text()));
		   	$("#totalSP").attr("value",totalPrices);/*总费用，应收款*/
			$("#totalS").text(totalPrices);
		}else if(type==2){
			//小费值自费值
			var xtip=changeTwoDecimal(Number($("#tipTotal").val())+Number(tip));
			var xself=changeTwoDecimal(Number($("#selfTotal").val())+Number(self));
			var oPrice=changeTwoDecimal(Number(xtip)+Number(xself));
			var notBed=$("#notBedNum").text();
			$("#notBedNum").text(Number(notBed)+1);
		   	$("#compaxdiv").text(Number($("#compaxdiv").text())+1);//佣金人数
			var totalPrices=changeTwoDecimal(Number(totalPrice)+Number($("#notBed").text())+Number(self)+Number(tip));
			var prices=changeTwoDecimal(Number(totalPrice)+Number($("#notBed").text()));
		   	$("#totalSP").attr("value",prices);/*总费用，应收款*/
			$("#totalS").text(prices);
		   	$("#tipTotal").attr("value",xtip);/*小费总费用*/
		   	$("#tipDiv").text(xtip);/*小费总费用*/
		   	$("#selfTotal").attr("value",xself);/*自费总费用*/
		   	$("#selfDiv").text(xself);/*自费总费用*/
		   	if(tipP>0){
		   		var t=changeTwoDecimal(Number($("#tipPaxs").text())+1);
		   		$("#tipPaxs").text(t);/*小费人数*/
		   	}else{
		   		$("#tipPaxs").text(0);/*小费人数*/
		   	}
		   	if(selfP>0){
		   		var s=changeTwoDecimal(Number($("#selfPaxs").text())+1);
		   		$("#selfPaxs").text(s);/*自费人数*/
		   	}else{
		   		$("#selfPaxs").text(0);/*自费人数*/
		   	}
		}else if(type==3){
			//小费值自费值
			var xtip=changeTwoDecimal(Number($("#tipTotal").val())+Number(tip));
			var xself=changeTwoDecimal(Number($("#selfTotal").val())+Number(self));
			var oPrice=changeTwoDecimal(Number(xtip)+Number(xself));
			var bed=$("#bedNum").text();
			$("#bedNum").text(Number(bed)+1);
		   	$("#compaxdiv").text(Number($("#compaxdiv").text())+1);//佣金人数
			var totalPrices=changeTwoDecimal(Number(tPrice)+Number($("#bed").text())+Number(self)+Number(tip));
			var prices=changeTwoDecimal(Number(totalPrice)+Number($("#bed").text()));
		   	$("#totalSP").attr("value",prices);/*总费用，应收款*/
			$("#totalS").text(prices);
		   	$("#tipTotal").attr("value",xtip);/*小费总费用*/
		   	$("#tipDiv").text(xtip);/*小费总费用*/
		   	$("#selfTotal").attr("value",xself);/*自费总费用*/
		   	$("#selfDiv").text(xself);/*自费总费用*/
		   	var t=changeTwoDecimal(Number(tipP)+1);
		   	var s=changeTwoDecimal(Number(selfP)+1);
		   	if(tipP>0){
		   		var t=changeTwoDecimal(Number($("#tipPaxs").text())+1);
		   		$("#tipPaxs").text(t);/*小费人数*/
		   	}else{
		   		$("#tipPaxs").text(0);/*小费人数*/
		   	}
		   	if(selfP>0){
		   		var s=changeTwoDecimal(Number($("#selfPaxs").text())+1);
		   		$("#selfPaxs").text(s);/*自费人数*/
		   	}else{
		   		$("#selfPaxs").text(0);/*自费人数*/
		   	}
		}else{
			//小费值自费值
			var xtip=changeTwoDecimal(Number($("#tipTotal").val())+Number(tip));
			var xself=changeTwoDecimal(Number($("#selfTotal").val())+Number(self));
			var oPrice=changeTwoDecimal(Number(xtip)+Number(xself));
			var adult=$("#adultNum").text();
			$("#adultNum").text(Number(adult)+1);
		   	$("#compaxdiv").text(Number($("#compaxdiv").text())+1);//佣金人数
			var totalPrices=changeTwoDecimal(Number(tPrice)+Number($("#adult").text())+Number(self)+Number(tip));
			var prices=changeTwoDecimal(Number(totalPrice)+Number($("#adult").text()));
		   	$("#totalSP").attr("value",prices);/*总费用，应收款*/
			$("#totalS").text(prices);
		    $("#tipTotal").attr("value",xtip);/*小费总费用*/
		   	$("#tipDiv").text(xtip);/*小费总费用*/
		   	$("#selfTotal").attr("value",xself);/*自费总费用*/
		   	$("#selfDiv").text(xself);/*自费总费用*/
		   	if(tipP>0){
		   		var t=changeTwoDecimal(Number($("#tipPaxs").text())+1);
		   		$("#tipPaxs").text(t);/*小费人数*/
		   	}else{
		   		$("#tipPaxs").text(0);/*小费人数*/
		   	}
		   	if(selfP>0){
		   		var s=changeTwoDecimal(Number($("#selfPaxs").text())+1);
		   		$("#selfPaxs").text(s);/*自费人数*/
		   	}else{
		   		$("#selfPaxs").text(0);/*自费人数*/
		   	}
		}
		//佣金
		var paxNumber=Number($("#bedNum").text())+Number($("#notBedNum").text());
		var autNumber=$("#adultNum").text();
		$("#compaxdiv").text(autNumber);//佣金人数
		$("#childcompaxdiv").text(paxNumber);//小孩佣金人数
		//佣金总额
		var autPrice=Number($("#comm").val())*Number($("#compaxdiv").text());
     	var childPrice=Number($("#childcomm").val())*Number($("#childcompaxdiv").text());
     	$("#totalComm").text(changeTwoDecimal(Number(autPrice)+Number(childPrice)));
     	price();
	}
	
	
    function customerListen(){
    	var lastName=$("#lastNameId").val().trim();
		var firstName=$("#firstNameId").val();
		var passportNo=$("#passportNoId").val();
		$.ajax({
			type: "POST",
			async: true,
			url: "[@spring.url '/admin/customer/findCustomerTourInfo.jhtml'/]",
			data:"lastName="+lastName+"&firstName="+firstName+"&passportNo="+passportNo,
			success: function(msg){
				 $("#modalId").html("");
				 if(msg!=null&&msg.customer!=null&&msg.customer.customerId!=null){
				 	 html="<span class='pull-left' >The Passenger Repetition <a href='${base}/admin/customer/orderByCusId?id="+msg.customer.customerId+"' >&nbsp;&nbsp;&nbsp;Detail</a></span>"
	  				 $("#modalId").html(html); 
				}
			 }
		});
    }
    /*********小费自费计算*************/
    function tipchange(vals){
    	if(vals==1){//小费选中
	    	$("#tipBox").prop("checked",true);
	    	tipSum();
    	}else if(vals==2){//小费未选中
	    	$("#tipBox").removeAttr("checked");
	    	tipSum();
    	}else if(vals==3){//自费选中
	    	$("#expenseBox").prop("checked",true);
	    	selfSum();
    	}else{//自费未选中
	    	$("#expenseBox").removeAttr("checked");
	    	selfSum();
    	}
    }
	//小费
    function tipSum(){
    	var totalPrice=$("#totalPrice").text();
    	var tip1=$("#tipDiv").text();
    	var self1=$("#selfDiv").text();
		if($("input:checkbox[name='tipBox']:checked").size()){
			$("#tipchange1").prop("checked",true);
			$("#tipchange2").removeAttr("checked");
		    tip=$("#tipPrice").text();
    		var adultNum=$("#adultNum").text();
    		var bedNum=$("#bedNum").text();
    		var notBedNum=$("#notBedNum").text();
    		var peopleNum=Number(adultNum)+Number(bedNum)+Number(notBedNum);
		    //人数所使用的费用
		    var tipprice=changeTwoDecimal(Number(tip)*Number(peopleNum));
		   	$("#tipTotal").val(tipprice);
		   	$("#tipDiv").text(tipprice);
		   	//选中未选中Remark值
		   	$("#remarkes").val("");
		   	var val="小费已付";
		   	if($("input:checkbox[name='expenseBox']:checked").size()){
		   		val=val+"/自费已付";
		   	}else{
		   		val=val+"/自费未付";
		   	}
		   	$("#remarkes").val(val);
			$("#voucherRemarks").val(val);
		   	$("#tipPaxs").text(peopleNum);/*小费人数*/
		   	price();
		}else{
			$("#tipchange2").prop("checked",true);
			$("#tipchange1").removeAttr("checked");
			if(tip1!=0){
				$("#tipTotal").val(0);
			   	$("#tipDiv").text(0);	
			   	$("#tipPaxs").text(0);/*小费人数*/
			   	price();
			}
			$("#remarkes").val("");
			var val="小费未付";
		   	if($("input:checkbox[name='expenseBox']:checked").size()){
		   		val=val+"/自费已付";
		   	}else{
		   		val=val+"/自费未付";
		   	}
			$("#remarkes").val(val);
			$("#voucherRemarks").val(val);
		}
    }
	//自费
    function selfSum(){
    	var self1=$("#selfDiv").text();
    	var tip1=$("#tipDiv").text();
    	var totalPrice=$("#totalPrice").text();
    	if($("input:checkbox[name='expenseBox']:checked").size()){
			$("#tipchange3").prop("checked",true);
			$("#tipchange4").removeAttr("checked");
    		var adultNum=$("#adultNum").text();
    		var bedNum=$("#bedNum").text();
    		var notBedNum=$("#notBedNum").text();
    		var peopleNum=Number(adultNum)+Number(bedNum)+Number(notBedNum);
		    self=$("#selfPrice").text();
		    //人数所使用的费用
		    var selfprice=changeTwoDecimal(Number(self)*Number(peopleNum));
		   	$("#selfTotal").val(selfprice);/*自费总费用*/
		   	$("#selfDiv").text(selfprice);/*自费总费用*/
		   	
		   	$("#remarkes").val("");
		   	var val="自费已付";
		   	if($("input:checkbox[name='tipBox']:checked").size()){
		   		val=val+"/小费已付";
		   	}else{
		   		val=val+"/小费未付";
		   	}
		   	$("#remarkes").val(val);
			$("#voucherRemarks").val(val);
		   	$("#selfPaxs").text(peopleNum);/*自费人数*/
		    price();
		}else{
			$("#tipchange4").prop("checked",true);
			$("#tipchange3").removeAttr("checked");
			if(self1!=0){
				$("#selfTotal").val(0);/*自费总费用*/
			   	$("#selfDiv").text(0);/*自费总费用*/
		   		$("#selfPaxs").text(0);/*自费人数*/
			   price();
			}
			$("#remarkes").val("");
			var val="自费未付";
		   	if($("input:checkbox[name='tipBox']:checked").size()){
		   		val=val+"/小费已付";
		   	}else{
		   		val=val+"/小费未付";
		   	}
			$("#remarkes").val(val);
			$("#voucherRemarks").val(val);
		}
    }
    /****************选项卡*********************/
     function changeDiv(num){
    	for(var c=1;c<7;c++){
    		if(c==num){
    			$("#stepdiv"+num).attr("class","active");
    			$("#step"+num).show();
    		}else{
    			if(c<num){
    				$("#stepdiv"+c).attr("class","complete");
	    			$("#step"+c).hide();
    			}else{
	    			$("#stepdiv"+c).attr("class","");
	    			$("#step"+c).hide();
    			}
    		}
    	}
    }
    function nextDiv(num){
    	if(num==2){
    		if($("#departureDateInput").val()==""){
    			alert("Please Enter Departure Date");
    		}else if($("#scheduleOfArriveTimeInput").val()!=undefined&&$("#scheduleOfArriveTimeInput").val()==""){
    			alert("Please Enter Arrive Date");
    		}else if($("#contactName").val()==""){
    			alert("Please Enter Contants");
    		}else{
    			changeDiv(num);
    		} 
    	}else{
    		changeDiv(num);
    	}
    		
    }
    /***获取出发日期对应的金额***/
	function changePrice(){
		var groupLineId=$("#groupId").val();
		var departureTime=$("#departureDateInput").val();
		$("#dated").text(departureTime);
		$.ajax({
			url:'${base}/admin/peerUser/arrPrice.jhtml',
			data:'groupLineId='+groupLineId+'&departureTime='+departureTime,
			type:"POST",
			async: true,
			dataType:"json",
			beforeSend:function(){
			},
			success:function(ageOfPrice){
				$("#adult").text(ageOfPrice.adult);
				$("#bed").text(ageOfPrice.bed);
				$("#notBed").text(ageOfPrice.notBed);
				$("#baby").text(ageOfPrice.baby);
				$("#peerUserFee").attr("value",ageOfPrice.commission);
				$("#compax").text(ageOfPrice.commission);
				$("#comm").attr("value",ageOfPrice.commission);
				$("#hotelPrice").attr("value",ageOfPrice.hotelPrice);
				$("#supplement").attr("value",ageOfPrice.supplement);
				$("#childcomm").attr("value",ageOfPrice.childComm);
				$("#childcompax").text(ageOfPrice.childComm);
				if(ageOfPrice.hotelPrice==0){
					$("#divP").attr("disabled","disabled");
					$("#divPost").attr("disabled","disabled");
				}
				//离团时间
				var year=departureTime.substring(0,4);
				var month=departureTime.substring(5,7);
				var day=departureTime.substring(8,10);
				var days=Number(day)+Number(ageOfPrice.dayNum)-1;
				var offDate=0;
				if(month==02){
					if(days>29){
						var d=Number(days)-29;
						var m=Number(month)+1;
						if(d<10){
							d=0+''+d;
						}
						if(m<10){
							m=0+''+m;
						}
						offDate=year+'-'+m+'-'+d;
					}else{
						offDate=year+'-'+month+'-'+days;
					}
				}else if(month==01||month==03||month==05||month==07||month==08||month==10||month==12){
					if(days>31){
						var d=Number(days)-31;
						var m=Number(month)+1;
						if(d<10){
							d=0+''+d;
						}
						if(m<10){
							m=0+''+m;
						}
						offDate=year+'-'+m+'-'+d;
					}else{
						offDate=year+'-'+month+'-'+days;
					}
				}else{
					if(days>30){
						var d=Number(days)-30;
						var m=Number(month)+1;
						if(d<10){
							d=0+''+d;
						}
						if(m<10){
							m=0+''+m;
						}
						offDate=year+'-'+m+'-'+d;
					}else{
						offDate=year+'-'+month+'-'+days;
					}
				}
				$("#offTime").text(offDate);
			}
		});
	}
	/************提前入住或续住操作处理（添加酒店续住）***********/
	function hotelPerAcc(){
		if($("#pre").val()>0){
			var nights=$("#pre").val();
			var roomType=$("#perroom").val();
			var roomNo=$("#roomNumt").val();
			var guest=$("#percus").val();
			$.ajax({
				cache: true,
                type: "POST",
                url:"prePost.jhtml",
                data:'nights='+nights+'&roomType='+roomType+'&roomNo='+roomNo+'&guest='+guest+'&type=0'+'&ordersTotalId='+$("#ordersTotalId").val(),
                async: true,
                error: function(request) {
                    alert("Connection error");
                },
                success: function(data) {
                	var html1='';
                	for(var a=0;a<data.num1;a++){
                		html1+='<tr height="50"  align="center" id="'+data.list1[a].prePostHotelId+'"><td width="40%">'+data.list1[a].guest+'</td>';
						html1+='<td width="40%">'+data.list1[a].roomType+'</td><td width="10%">NO.'+data.list1[a].roomNo+'</td><td width="10%">'+data.list1[a].nights+'</td>';
						html1+='<td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delPrePost(\''+data.list1[a].prePostHotelId+'\')"><i class="fa fa-times"/></a></td></tr>';
                	}
                	$("#pertr tr").eq(0).nextAll().remove();
                	$("#pertr").append(html1);
                	var html2='';
                	for(var i=0;i<data.num2;i++){
                		html2+='<tr height="50"  align="center" id="'+data.list2[i].prePostHotelId+'"><td width="40%">'+data.list2[i].guest+'</td>';
						html2+='<td width="40%">'+data.list2[i].roomType+'</td><td width="10%">NO.'+data.list2[i].roomNo+'</td><td width="10%">'+data.list2[i].nights+'</td>';
						html2+='<td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delPrePost(\''+data.list2[i].prePostHotelId+'\')"><i class="fa fa-times"/></a></td></tr>';
                	}
                	$("#posttr tr").eq(0).nextAll().remove();
                	$("#posttr").append(html2);
                	$("#days").val(data.night);
                	$("#roomNoPax").val(data.numPax);
                	$("#helfDays").val(data.nightH);
                	$("#helfPax").val(data.num);
                }
			});
		}else{
			alert("Please Enter Nights");
		}
	}
	function hotelPostAcc(){
		if($("#post").val()>0){
		    var nights=$("#post").val();
			var roomType=$("#postroom").val();
			var roomNo=$("#roomNump").val();
			var guest=$("#postcus").val();
			$.ajax({
				cache: true,
                type: "POST",
                url:"prePost.jhtml",
                data:'nights='+nights+'&roomType='+roomType+'&roomNo='+roomNo+'&guest='+guest+'&type=1'+'&ordersTotalId='+$("#ordersTotalId").val(),
                async: true,
                error: function(request) {
                    alert("Connection error");
                },
                success: function(data) {
                	var html1='';
                	for(var a=0;a<data.num1;a++){
                		html1+='<tr height="50"  align="center" id="'+data.list1[a].prePostHotelId+'"><td width="40%">'+data.list1[a].guest+'</td>';
						html1+='<td width="40%">'+data.list1[a].roomType+'</td><td width="10%">NO.'+data.list1[a].roomNo+'</td><td width="10%">'+data.list1[a].nights+'</td>';
						html1+='<td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delPrePost(\''+data.list1[a].prePostHotelId+'\')"><i class="fa fa-times"/></a></td></tr>';
                	}
                	$("#pertr tr").eq(0).nextAll().remove();
                	$("#pertr").append(html1);
                	var html2='';
                	for(var i=0;i<data.num2;i++){
                		html2+='<tr height="50"  align="center" id="'+data.list2[i].prePostHotelId+'"><td width="40%">'+data.list2[i].guest+'</td>';
						html2+='<td width="40%">'+data.list2[i].roomType+'</td><td width="10%">NO.'+data.list2[i].roomNo+'</td><td width="10%">'+data.list2[i].nights+'</td>';
						html2+='<td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delPrePost(\''+data.list2[i].prePostHotelId+'\')""><i class="fa fa-times"/></a></td></tr>';
                	}
                	$("#posttr tr").eq(0).nextAll().remove();
                	$("#posttr").append(html2);
                	$("#days").val(data.night);
                	$("#roomNoPax").val(data.numPax);
                	$("#helfDays").val(data.nightH);
                	$("#helfPax").val(data.num);
                }
			});
		}else{
			alert("Please Enter Nights");
		}
	}
	//删除续住信息
	function delPrePost(id){
		$.ajax({
			cache: true,
            type: "POST",
            url:"delPrePost.jhtml",
            data:'id='+id,
            async: true,
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
            	var html1='';
            	for(var a=0;a<data.num1;a++){
            		html1+='<tr height="50"  align="center" id="'+data.list1[a].prePostHotelId+'"><td width="40%">'+data.list1[a].guest+'</td>';
					html1+='<td width="40%">'+data.list1[a].roomType+'</td><td width="10%">NO.'+data.list1[a].roomNo+'</td><td width="10%">'+data.list1[a].nights+'</td>';
					html1+='<td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delPrePost(\''+data.list1[a].prePostHotelId+'\')"><i class="fa fa-times"/></a></td></tr>';
            	}
            	$("#pertr tr").eq(0).nextAll().remove();
            	$("#pertr").append(html1);
            	var html2='';
            	for(var i=0;i<data.num2;i++){
            		html2+='<tr height="50"  align="center" id="'+data.list2[i].prePostHotelId+'"><td width="40%">'+data.list2[i].guest+'</td>';
					html2+='<td width="40%">'+data.list2[i].roomType+'</td><td width="10%">NO.'+data.list2[i].roomNo+'</td><td width="10%">'+data.list2[i].nights+'</td>';
					html2+='<td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delPrePost(\''+data.list2[i].prePostHotelId+'\')"><i class="fa fa-times"/></a></td></tr>';
            	}
            	$("#posttr tr").eq(0).nextAll().remove();
            	$("#posttr").append(html2);
            	$("#days").val(data.night);
            	$("#roomNoPax").val(data.numPax);
            	$("#helfDays").val(data.nightH);
            	$("#helfPax").val(data.num);
            }
		});
	}
	function sumPrePost(divnum){
    	var hotelTotal=$("#hotelTotal").val();//酒店总费用
		//将之前的费用清零
		$("#totalPrice").text(Number($("#totalPrice").text())-Number(hotelTotal));
		
		var days=$("#days").val();
    	var roomNoPax=$("#roomNoPax").val();
    	var helfDays=$("#helfDays").val();
    	var helfPax=$("#helfPax").val();
		var hotelPrice=$("#hotelPrice").val();//hotel单价
		var totalPrice=$("#totalPrice").text();//final Price
		var hotelHelf=changeTwoDecimal(Number($("#hotelPrice").val())/2);//hotel半单价
		//全价费用
		var hTotal=Number(days)*Number(hotelPrice);
		//全半价费用
		var hTotalHelf=Number(helfDays)*Number(hotelHelf);
		var total=changeTwoDecimal(Number(hTotal)+Number(hTotalHelf));
		
		$("#hotelTotal").val(total);
		$("#pp").text($("#hotelTotal").val());
		price();
		nextDiv(divnum);
	}
	function haveFee(val){
		if(val==1){
			if($("input:checkbox[name='preBox']:checked").size()){//选中
			   $("#perDiv").show();
			}else{
				$("#pertr tr:gt(0)").each(function(i){
					var a=i+1;
					var id=$("#pertr tr").eq(a).attr("id");
					$.ajax({
						cache: true,
			            type: "POST",
			            url:"delPrePost.jhtml",
			            data:'id='+id,
			            async: true,
			            error: function(request) {
			                alert("Connection error");
			            },
			            success: function(data) {
			            	$("#days").val(data.night);
			            	$("#roomNoPax").val(data.numPax);
			            	$("#helfDays").val(data.nightH);
			            	$("#helfPax").val(data.num);
			            }
			         });
				});
            	$("#pertr tr").eq(0).nextAll().remove();
				$("#perDiv").hide();
			}
		}
		if(val==2){
			if($("input:checkbox[name='postBox']:checked").size()){//选中
			   $("#postDiv").show();
			}else{
				$("#posttr tr:gt(0)").each(function(i){
					var a=i+1;
					var id=$("#posttr tr").eq(a).attr("id");
					$.ajax({
						cache: true,
			            type: "POST",
			            url:"delPrePost.jhtml",
			            data:'id='+id,
			            async: true,
			            error: function(request) {
			                alert("Connection error");
			            },
			            success: function(data) {
			            	$("#days").val(data.night);
			            	$("#roomNoPax").val(data.numPax);
			            	$("#helfDays").val(data.nightH);
			            	$("#helfPax").val(data.num);
			            }
			         });
				});
            	$("#posttr tr").eq(0).nextAll().remove();
				$("#postDiv").hide();
			}
		}
	}
	
	
	function delInfo(trNum,type,nights){
		var hotelTotal=$("#hotelTotal").val();//酒店总费用
		var totalPrice=$("#totalPrice").text();
		var hotelPrice=$("#hotelPrice").val();
		var price=Number(hotelPrice)*Number(nights);//计算后的酒店费用
		if(type=="per"){
			$("#perInfo"+trNum+"").remove();
			$("#preDays").val(Number($("#preDays").val())-Number(nights));
		}
		if(type=="post"){
			$("#postIn"+trNum+"").remove();
			$("#postDays").val(Number($("#postDays").val())-Number(nights));
		}
		$("#hotelTotal").attr("value",Number(hotelTotal)-Number(price));
		$("#pp").text($("#hotelTotal").val());
		price();
	}
	function info(divnum){
		var perInfo="";
		var postInfo="";
		$('input[name="perInfoList"]').each(function(){   
	        perInfo=perInfo+ $(this).val()+",";   
	    });
		$('input[name="postInfoList"]').each(function(){   
	        postInfo=postInfo+ $(this).val()+",";   
	    });   
	    $("#perInfoList").attr("value",perInfo);
	    $("#postInfoList").attr("value",postInfo);
	    
		nextDiv(divnum);
	}
	/*************接送机费用计算***************************/
	function checktic(divnum){
	var ticketNum=0;
	var totalPrice=Number($("#totalPrice").text())-Number($("#ticketTotal").val());/*减去原接机费用的总价*/
	var pickSendPrice=changeTwoDecimal(Number($("#pickSendPrice").val())*Number($("#rate").val()));//转换后的接送机费用
	var lease=$("#lease").val();
	var num=$("#totalPeople").val();
	
	//接机
	for(var a=0;a<num;a++){
		if($("input[id='ifPickUp"+a+"']:checked").val()>0){
			ticketNum +=1;
		}
	}
	var telPrice=0;
	if(ticketNum!=0){
		if(ticketNum<lease&&ticketNum!=0){
			telPrice +=Number(pickSendPrice)*Number(lease);//总接送机费用
		}else{
			telPrice +=Number(pickSendPrice)*Number(ticketNum);//总接送机费用
		}
	}
	//送机
	var numb=0
	for(var a=0;a<num;a++){
		if($("input[id='ifSendUp"+a+"']:checked").val()>0){
			numb +=1;
		}
	}
	if(numb!=0){
		if(numb<lease){
			telPrice +=Number(pickSendPrice)*Number(lease);//总接送机费用
		}else{
			telPrice +=Number(pickSendPrice)*Number(ticketNum);//总接送机费用
		}
	}
	$("#ticketTotal").attr("value",changeTwoDecimal(telPrice));
	$("#ps").text($("#ticketTotal").val());
	price();
	 nextDiv(divnum);
	}
	
	
	
	function disPrice(){
		var disOld=$("#disOld").val();
		$("#totalPrice").text(Number($("#totalPrice").text())+Number(disOld));
		var dis=$("#dis").val();
		$("#disOld").val(dis);
		$("#totalPrice").text(Number($("#totalPrice").text())-Number(dis));
	}
	
	/******房型选择*******/
	function setRoomType(){
		var guestval=$("#guestNum").val();
		var type=guestval.substring(guestval.indexOf(",")+1,guestval.length);
		$("#roomType").find("option").remove();
		if(type<=2){
			var html='<option value="Sharing Existing Bed">Sharing Existing Bed</option>';
			$("#roomType").append(html);
		}else if(type==3){
			var html='<option value="Twin Bed">Twin Bed</option>'
				+'<option value="King Bed">King Bed</option>'
				+'<option value="Single">Single</option>'
				+'<option value="Extra Bed">Extra Bed</option>';
			$("#roomType").append(html);
		}else{
			var html='<option value="Twin Bed">Twin Bed</option>'
				+'<option value="King Bed">King Bed</option>'
				+'<option value="Single">Single</option>'
				+'<option value="Extra Bed">Extra Bed</option>'
				+'<option value="Male Sharing">Male Sharing</option>';
			$("#roomType").append(html);
		}
	}
	function editRoomType(type,customerId,customerName){
		$('.popup_from_mask').fadeIn(300);
		$('.popup_formRoomType').slideDown(400);
		$("#guestNums").find("option").remove();
		$("#roomTypes").find("option").remove();
		var htmls='';
		var html='';
		if(type<=2){
			htmls='<option value="'+customerId+','+type+'">'+customerName+'---Child without Beb/Infant</option>';
			html='<option value="Sharing Existing Bed">Sharing Existing Bed</option>';
		}else if(type==3){
			htmls='<option value="'+customerId+','+type+'">'+customerName+'---Child with Beb</option>';
			html='<option value="Twin Bed">Twin Bed</option>'
				+'<option value="King Bed">King Bed</option>'
				+'<option value="Single">Single</option>'
				+'<option value="Extra Bed">Extra Bed</option>';
				/*+'<option value="Sharing Existing Bed">Sharing Existing Bed</option>';*/
		}else{
			htmls='<option value="'+customerId+','+type+'">'+customerName+'---Adult'+'</option>';
			html='<option value="Twin Bed">Twin Bed</option>'
				+'<option value="King Bed">King Bed</option>'
				+'<option value="Single">Single</option>'
				+'<option value="Extra Bed">Extra Bed</option>';
		}
		$("#guestNums").append(htmls);
		$("#roomTypes").append(html);
	}
	var $singlePrice=0;
	function addRoomType(){
		var ordersTotalId=$("#ordersTotalId").val();
		var guestval=$("#guestNum").val();
		var cName=$("#guestNum").find("option:selected").text();
		var temp=guestval;//temp判断是修改房型还是添加房型，不为空新添加 反之 修改。
		if($("#guestNums").val()!=null && $("#guestNums").val()!="" && temp==""){
			guestval=$("#guestNums").val();
			cName=$("#guestNums").find("option:selected").text();
		}
		var cuso=guestval.substring(0,guestval.indexOf(","));
		var cusT=$("#roomNum").val();
		if($("#roomNums").val()!=null && $("#roomNums").val()!="" && temp==""){
			cusT=$("#roomNums").val();
		}
		
		var roomtype=$("#roomType").val();
		if($("#roomTypes").val()!=null && $("#roomTypes").val()!="" && temp==""){
			roomtype=$("#roomTypes").val();
		}
		if(temp!=null && temp!=""){
			$.ajax({
				url:'${base}/admin/peerUser/roomType.jhtml',
				data:'ordersTotalId='+ordersTotalId+'&cuso='+cuso+'&cusT='+cusT+'&roomtype='+roomtype,
				type:"POST",
				async: true,
				dataType:"json",
				beforeSend:function(){
				},
				success:function(map){
					$('.popup_from_mask').fadeOut(300);
					$('.popup_formRoomType').slideUp(400);
					$("#singlePrice").val(map.numbers);
					//$("#room").find("tr:not(:first)").remove();
					var html='<tr id="'+cuso +'">'
						+'<td>'+cName+'</td>'
						+'<td>'+roomtype+'</td>'
						+'<td> NO.'+cusT+'</td>'
						+'<td><a class="label label-default md-trigger popup_roomType" href="javascript:editRoomType(\''+roomtype+'\',\''+$("#guestNum").val()+'\',\''+cName+'\');" data-modal="customerEditForm" title="Modify"><i class="fa fa-pencil"></i></a></td>'
						+'</tr>';
					$("#room").append(html);
					$("#guestNum").find("option:selected").remove();
				}
			});
		}else{
			$.ajax({
				url:'${base}/admin/peerUser/roomType.jhtml',
				data:'ordersTotalId='+ordersTotalId+'&cuso='+cuso+'&cusT='+cusT+'&roomtype='+roomtype,
				type:"POST",
				async: true,
				dataType:"json",
				beforeSend:function(){
				},
				success:function(map){
					$('.popup_from_mask').fadeOut(300);
					$('.popup_formRoomType').slideUp(400);
					$("#singlePrice").val(map.numbers);
					$("#room").find("tr[id='"+cuso+"']").remove();
					var html='<tr id="'+cuso +'">'
						+'<td>'+cName+'</td>'
						+'<td>'+roomtype+'</td>'
						+'<td> NO.'+cusT+'</td>'
						+'<td><a class="label label-default md-trigger popup_roomType" href="javascript:editRoomType(\''+roomtype+'\',\''+$("#guestNum").val()+'\',\''+cName+'\');" data-modal="customerEditForm" title="Modify"><i class="fa fa-pencil"></i></a></td>'
						+'</tr>';
					$("#room").append(html);
					$("#guestNum").find("option:selected").remove();
				}
			});
		}
			
	}
	
	function supp(num){
			var numb= $("#guestNum option").size();
			if(numb>1){
				alert("Everybody must have a Room Type");
	    	}else{
	    		var ordersTotalId=$("#ordersTotalId").val();
	    		var n=Number($("#singlePrice").val());
	    		var suppl=Number($("#supplement").val())*n;
	    		var price=Number($("#totalPrice").text())-Number($("#supTotal").val());/*减去单房差的总费用*/
	    		$("#supTotal").val(suppl);
				$("#sup").text(suppl);
				var oprice=changeTwoDecimal(Number($("#tipTotal").val())+Number($("#selfTotal").val())+Number($("#hotelTotal").val())+Number($("#ticketTotal").val())+Number($("#supTotal").val()));
				$("#otherPrice").text(oprice);/*其他总费用*/
				//页面计算公式显示数据
				var tourFee=$("#totalSP").val();
				$("#sumFee").text(tourFee);
				$("#comFee").text($("#totalComm").text());
				$("#otherFee").text(oprice);
				var disFee=changeTwoDecimal(Number(tourFee)-Number($("#totalComm").text())+Number(oprice));
				$("#disFee").text(disFee);
	    		var groupLineId=$("#groupId").val();
				var departureTime=$("#departureDateInput").val();
				var isOceania=$("#isOceania").val();
				if(isOceania==1){
					$.ajax({
	                cache: true,
	                type: "POST",
	                url:"backUpForSpecial.jhtml?ordersTotalId="+ordersTotalId+"&groupLineId="+groupLineId+"&departureTime="+departureTime,
	                data:$('#ww').serialize(),// 你的formid
	                async: true,
	                error: function(request) {
	                    alert("Please Try Again");
	                },
	                success: function(data) {
	                	if(data.msg=="No change"){
				    		$("#totalPrice").text(Number(price)+Number(suppl));
				    		nextDiv(num);
	                	}else if(data.msg=="Please check the room number."){
	                		alert(data.msg);
	                	}else{
		                	//页面进行相应的计算
							var otherPrice=Number($("#tipTotal").val())+Number($("#selfTotal").val())+Number($("#hotelTotal").val())+Number($("#ticketTotal").val())+Number($("#supTotal").val());
							$("#totalSP").attr("value",data.price);/*应收款*/
							$("#totalS").text(Number(data.price));/*应收款*/
		                	$("#totalPrice").text(Number(data.price)+Number(otherPrice));/*总费用，合计后的费用*/
				    		nextDiv(num);
				    	}
				    	//续住酒店客人列表加载
                		var html="";
                		for(var i=0 ; i<data.roomNumber; i++){
                        html +='<option value="'+data.customerRoomList[i].lastName+'/'+data.customerRoomList[i].firstName+'/'+data.customerRoomList[i].middleName+'",id="'+data.customerRoomList[i].dateOfBirth+'">'+data.customerRoomList[i].lastName +'/'+data.customerRoomList[i].firstName+'/'+data.customerRoomList[i].middleName+'</option>';
                        	//html +='<li><label style="font-weight:normal; width:100%;"><input value="'+data.customerList[i].lastName+'/'+data.customerList[i].firstName+'/'+data.customerList[i].middleName+'",id="'+data.customerList[i].dateOfBirth+'" name="prePax" type="checkbox"><span>'+data.customerList[i].lastName +'/'+data.customerList[i].firstName+'/'+data.customerList[i].middleName+'</span></label></li>';
                        }
                        $("#percus").find("option").remove();
                        $("#postcus").find("option").remove();
                        $("#percus").append(html);
                        $("#postcus").append(html);
	                	//航班
	                	$("#tourinfo_box").empty();
	                	for(var i=0 ; i<data.roomNumber; i++){
							var html2='<div class="flight_1">';
		                             html2+='<div class="flight_1_top">';
		                                 html2+='<span class="flight_1_num fl">No.'+(i+1)+'   <input type="hidden" name="productVO.customerFlights['+i+'].customerId" value="'+data.customerRoomList[i].customerId+'">'+data.customerRoomList[i].lastName +'/'+data.customerRoomList[i].firstName+'/'+data.customerRoomList[i].middleName+'</span>';
		                                 if(i!=0){
		                                  	html2+='<a class="flight_1_btn r1" href="javascript:;"  onclick="theSameAsPrevious('+i+');">As Above</a>';
		                                  }
		                                  html2+='<div class="clear"></div>'
		                             +'</div>'
		                             +'<div class="flight_1_down">'
		                                 +'<div class="flight_1_down_main">'
		                                 	 +'<div class="clear"></div>'
		                                 	 +'<div class="tourinfo_date_an fl" style="margin:10px 0px;color:#0081cc;"><i class="fa  fa-hand-o-right"></i><b>Arrival Info</b></div>'
		                                     +'<div class="tourinfo_date_an fl">'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Airline:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[0].flightCode" type="text"  placeholder="Airline">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Flight No.:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[0].flightNumber" type="text"  placeholder="Flight No.">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Arrival Date:</label>'
		                                             +'<input type="text" name="productVO.customerFlights['+i+'].customerFlightList[0].arriveDate" value="" id="arriveDate'+i+'" class="tourDate_d_an" placeholder="yyyy-mm-dd" />'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Arrival Time:</label>'
		                                             +'<input class="tourDate_d_an" type="text" name="productVO.customerFlights['+i+'].customerFlightList[0].arriveTime" placeholder="hh:mm"/>'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<span>Pick-up:</span>'
		                                             +'<input  type="radio" name="productVO.customerFlights['+i+'].customerFlightList[0].ifPickUp" value="1" checked="checked" id="ifPickUp'+i+'" style="width:30px" >Yes'
		                                             +'<input type="radio" name="productVO.customerFlights['+i+'].customerFlightList[0].ifPickUp" value="2"  style="width:30px">No'
		                                         +'<input class="hasDatepicker" name="productVO.customerFlights['+i+'].customerFlightList[0].outOrEnter" value="1" type="hidden"></div>'
		                                         +'<div class="clear"></div>'
		                                     +'</div>'
		                                     +'<div class="clear"></div>'
		                                     +'<div class="line_las"></div>'
		                                     +'<div class="tourinfo_date_an fl" style="margin:10px 0px;color:#0081cc;"><i class="fa  fa-hand-o-right"></i><b>Departure Info</b></div>'
		                                     +'<div class="tourinfo_date_an fl">'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Airline:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[1].flightCode" type="text" placeholder="Airline">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Flight No.:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[1].flightNumber" type="text" placeholder="Flight No.">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Departure Date:</label>'
		                                             +'<input type="text" name="productVO.customerFlights['+i+'].customerFlightList[1].arriveDate" id="departure'+i+'" value="" class="tourDate_d_an"  placeholder="yyyy-mm-dd" />'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Departure Time:</label>'
		                                             +'<input class="tourDate_d_an"  type="text" name="productVO.customerFlights['+i+'].customerFlightList[1].arriveTime"  placeholder="hh:mm"/>'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<span>Drop-off:</span>'
		                                             +'<input type="radio" name="productVO.customerFlights['+i+'].customerFlightList[1].ifSendUp" value="1" checked="checked" id="ifSendUp'+i+'" style="width:30px">Yes'
		                                             +'<input  type="radio" name="productVO.customerFlights['+i+'].customerFlightList[1].ifSendUp" value="2" style="width:30px">No'
		                                         +'<input  class="hasDatepicker" name="productVO.customerFlights['+i+'].customerFlightList[1].outOrEnter" value="2" type="hidden"></div>'
		                                         +'<div class="clear"></div>'
		                                     +'</div>'
		                                   +'<div class="clear"></div>'
		                                +'</div>'
		                             +'</div>'
		                         +'</div>'
							$("#tourinfo_box").append(html2);
							$("#arriveDate"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#arriveTime"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#departure"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#departureTime"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#message").text("");
							$("#stepHave").show();
							$("#sumFee").text(data.price);
							if(data.comm!=0){
			               		$("#totalComm").text(data.comm);
								$("#totalSP").text(data.comm);
								$("#comFee").text(data.comm);
								$("#peerUserFee").val(data.comm);
	                		}else{
	                		   totalfee=$("#totalComm").text();
	                		 	$("#totalComm").text(totalfee);
								$("#totalSP").text(totalfee);
								$("#comFee").text(totalfee);
								$("#peerUserFee").val(totalfee);
	                		}
	                	}
	                	if(data.roomNumber==0){
		               		$("#message").text("Please Add Passenger");
							$("#stepHave").hide();
	                	}
	                }
	            });
				}else{
	    		$.ajax({
	                cache: true,
	                type: "POST",
	                url:"backUp.jhtml?ordersTotalId="+ordersTotalId+"&groupLineId="+groupLineId+"&departureTime="+departureTime,
	                data:$('#ww').serialize(),// 你的formid
	                async: true,
	                error: function(request) {
	                    alert("Please Try Again");
	                },
	                success: function(data) {
	                	if(data.msg=="No change"){
				    		$("#totalPrice").text(Number(price)+Number(suppl));
				    		nextDiv(num);
	                	}else if(data.msg=="Please check the room number."){
	                		alert(data.msg);
	                	}else{
		                	//页面进行相应的计算
							var otherPrice=Number($("#tipTotal").val())+Number($("#selfTotal").val())+Number($("#hotelTotal").val())+Number($("#ticketTotal").val())+Number($("#supTotal").val());
							$("#totalSP").attr("value",data.price);/*应收款*/
							$("#totalS").text(Number(data.price));/*应收款*/
		                	$("#totalPrice").text(Number(data.price)+Number(otherPrice));/*总费用，合计后的费用*/
		                	if(data.comm!="" ||data.childComm!=""){
			                	$("#compax").text(data.comm)
			                	$("#childcompax").text(data.childComm);
		                	}

				    		nextDiv(num);
				    	}
				    	//续住酒店客人列表加载
                		var html="";
                		for(var i=0 ; i<data.roomNumber; i++){
                        html +='<option value="'+data.customerRoomList[i].lastName+'/'+data.customerRoomList[i].firstName+'/'+data.customerRoomList[i].middleName+'",id="'+data.customerRoomList[i].dateOfBirth+'">'+data.customerRoomList[i].lastName +'/'+data.customerRoomList[i].firstName+'/'+data.customerRoomList[i].middleName+'</option>';
                        	//html +='<li><label style="font-weight:normal; width:100%;"><input value="'+data.customerList[i].lastName+'/'+data.customerList[i].firstName+'/'+data.customerList[i].middleName+'",id="'+data.customerList[i].dateOfBirth+'" name="prePax" type="checkbox"><span>'+data.customerList[i].lastName +'/'+data.customerList[i].firstName+'/'+data.customerList[i].middleName+'</span></label></li>';
                        }
                        $("#percus").find("option").remove();
                        $("#postcus").find("option").remove();
                        $("#percus").append(html);
                        $("#postcus").append(html);
	                	//航班
	                	$("#tourinfo_box").empty();
	                	for(var i=0 ; i<data.roomNumber; i++){
							var html2='<div class="flight_1">';
		                             html2+='<div class="flight_1_top">';
		                                 html2+='<span class="flight_1_num fl">No.'+(i+1)+'   <input type="hidden" name="productVO.customerFlights['+i+'].customerId" value="'+data.customerRoomList[i].customerId+'">'+data.customerRoomList[i].lastName +'/'+data.customerRoomList[i].firstName+'/'+data.customerRoomList[i].middleName+'</span>';
		                                 if(i!=0){
		                                  	html2+='<a class="flight_1_btn r1" href="javascript:;"  onclick="theSameAsPrevious('+i+');">As Above</a>';
		                                  }
		                                  html2+='<div class="clear"></div>'
		                             +'</div>'
		                             +'<div class="flight_1_down">'
		                                 +'<div class="flight_1_down_main">'
		                                 	 +'<div class="clear"></div>'
		                                 	 +'<div class="tourinfo_date_an fl" style="margin:10px 0px;color:#0081cc;"><i class="fa  fa-hand-o-right"></i><b>Arrival Info</b></div>'
		                                     +'<div class="tourinfo_date_an fl">'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Airline:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[0].flightCode" type="text"  placeholder="Airline">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Flight No.:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[0].flightNumber" type="text"  placeholder="Flight No.">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Arrival Date:</label>'
		                                             +'<input type="text" name="productVO.customerFlights['+i+'].customerFlightList[0].arriveDate" value="" id="arriveDate'+i+'" class="tourDate_d_an" placeholder="yyyy-mm-dd" />'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Arrival Time:</label>'
		                                             +'<input class="tourDate_d_an" type="text" name="productVO.customerFlights['+i+'].customerFlightList[0].arriveTime" placeholder="hh:mm"/>'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<span>Pick-up:</span>'
		                                             +'<input  type="radio" name="productVO.customerFlights['+i+'].customerFlightList[0].ifPickUp" value="1" checked="checked" id="ifPickUp'+i+'" style="width:30px" >Yes'
		                                             +'<input type="radio" name="productVO.customerFlights['+i+'].customerFlightList[0].ifPickUp" value="2"  style="width:30px">No'
		                                         +'<input class="hasDatepicker" name="productVO.customerFlights['+i+'].customerFlightList[0].outOrEnter" value="1" type="hidden"></div>'
		                                         +'<div class="clear"></div>'
		                                     +'</div>'
		                                     +'<div class="clear"></div>'
		                                     +'<div class="line_las"></div>'
		                                     +'<div class="tourinfo_date_an fl" style="margin:10px 0px;color:#0081cc;"><i class="fa  fa-hand-o-right"></i><b>Departure Info</b></div>'
		                                     +'<div class="tourinfo_date_an fl">'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Airline:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[1].flightCode" type="text" placeholder="Airline">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Flight No.:</label>'
		                                             +'<input class="tourDate_d_an" name="productVO.customerFlights['+i+'].customerFlightList[1].flightNumber" type="text" placeholder="Flight No.">'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Departure Date:</label>'
		                                             +'<input type="text" name="productVO.customerFlights['+i+'].customerFlightList[1].arriveDate" id="departure'+i+'" value="" class="tourDate_d_an"  placeholder="yyyy-mm-dd" />'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<label>Departure Time:</label>'
		                                             +'<input class="tourDate_d_an"  type="text" name="productVO.customerFlights['+i+'].customerFlightList[1].arriveTime"  placeholder="hh:mm"/>'
		                                         +'</div>'
		                                         +'<div class="date_d_an fl">'
		                                             +'<span>Drop-off:</span>'
		                                             +'<input type="radio" name="productVO.customerFlights['+i+'].customerFlightList[1].ifSendUp" value="1" checked="checked" id="ifSendUp'+i+'" style="width:30px">Yes'
		                                             +'<input  type="radio" name="productVO.customerFlights['+i+'].customerFlightList[1].ifSendUp" value="2" style="width:30px">No'
		                                         +'<input  class="hasDatepicker" name="productVO.customerFlights['+i+'].customerFlightList[1].outOrEnter" value="2" type="hidden"></div>'
		                                         +'<div class="clear"></div>'
		                                     +'</div>'
		                                   +'<div class="clear"></div>'
		                                +'</div>'
		                             +'</div>'
		                         +'</div>'
							$("#tourinfo_box").append(html2);
							$("#arriveDate"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#arriveTime"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#departure"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#departureTime"+i).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
							$("#message").text("");
							$("#stepHave").show();
	                	}
	                	if(data.roomNumber==0){
		               		$("#message").text("Please Add Passenger");
							$("#stepHave").hide();
	                	}
	                }
	            });
	          }
	       }
	}
	/**页面费用计算**/
	function price(){
	     //团款
	     var tourFee=$("#totalSP").val();
	    //其他费用
		var oprice=changeTwoDecimal(Number($("#tipTotal").val())+Number($("#selfTotal").val())+Number($("#hotelTotal").val())+Number($("#ticketTotal").val())+Number($("#supTotal").val()));
		$("#otherPrice").text(oprice);/*其他总费用*/
		var totalPrice=changeTwoDecimal(Number(tourFee)+Number(oprice));//Final Amount
		$("#totalPrice").text(totalPrice);
		//页面计算公式显示数据
		$("#sumFee").text(tourFee);
		$("#comFee").text($("#totalComm").text());
		$("#otherFee").text(oprice);
		var disFee=changeTwoDecimal(Number(tourFee)-Number($("#totalComm").text())+Number(oprice));
		$("#disFee").text(disFee);
	}
	//年龄段说明提醒
	function overDiv(div){
		$("#"+div).show();
	}
	function outDiv(div){
		$("#"+div).hide();
	}
	
	//添加联系人
	function addContacts(){
		if($("#contactsName").val()!=""){
			$.ajax({
				url:'addContacts.jhtml?contactsName='+$("#contactsName").val()+'&peerUserId='+$("#peerUserId").val(),
				data: $("#contactsForm").serialize(),
				type:"POST",
				async: true,
				beforeSend:function(){
				},
				success:function(result){
					$("#contactName").empty();
					var html='';
					var html2='';
					for(var a=0;a<result.num;a++){
						html+='<option id="op'+result.cList[a].contactsId+'" value="'+result.cList[a].contactsName+'">'+result.cList[a].contactsName+'</option>';
						html2+='<tr id="'+result.cList[a].contactsId+'">'
            				+'<td style="border-bottom:1px solid #E9E9E9">'+result.cList[a].contactsName+'</td>'
            				+'<td style="border-bottom:1px solid #E9E9E9;border-left:1px solid #E9E9E9"><a href="javascript:;"onclick="deleteCon(\''+result.cList[a].contactsId+'\')">Delete</a></td></tr>';
					}
					$("#contactName").append(html);
					$("#clistTable tr").eq(0).nextAll().remove();
					$("#clistTable").append(html2);
					$('.popup_from_mask').fadeOut(300);
					$('.popup_form_contacts').slideUp(400);
					$("#contactsName").val('');
				}
			});
		}else{
			alert("Enter Consultant Name");
		}
	}
	
	function deleteCon(conId){
		if(confirm("Confirm To Delete?")){
			$.post("delCon",{id:conId},function(data){
				if(data.success=='success'){
					$("#"+conId).remove();
					$("#op"+conId).remove();
				}
			});
		}else{
			return false;
		};
	}
	
</script>
<script type="text/javascript" src="[@spring.url '/resources/js/behaviour/general.js'/]"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>