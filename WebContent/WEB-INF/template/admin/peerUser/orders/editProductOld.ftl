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
              <li data-target="#step1" id="stepdiv1" class="active"><i class="fa fa-group"></i>&nbsp;Tour Info<span class="chevron"></span></li>
              <li data-target="#step2" id="stepdiv2" ><i class="fa fa-group"></i>&nbsp;Customer Info<span class="chevron"></span></li>
              <li data-target="#step3" id="stepdiv3" ><i class="fa fa-plane"></i>&nbsp;Flight Info<span class="chevron"></span></li>
              <li data-target="#step4" id="stepdiv4" ><i class="fa fa-home"></i>&nbsp;Pre/Post Accommodation<span class="chevron"></span></li>
              <li data-target="#step5" id="stepdiv5" ><i class="fa fa-money"></i>&nbsp;Tour Remark<span class="chevron"></span></li>
            </ul>
            <span style="float:right;margin: 14px 12px 0px 0px;color: #3a87ad;font-size: 15px;">Booking NO.:${ordersTotal.orderNumber}</span>
            <div class="clear"></div>
          </div>
          <div class="step-content" style="margin-top:20px;">
            <form class="form-horizontal group-border-dashed" id="ww" action="addProduct.jhtml" data-parsley-validate novalidate>
            	<input type="hidden" name="productVO.order.peerUserId" value="${productVO.order.peerUserId}}"/> 
				<input type="hidden" name="productVO.ordersTotalId" value="${ordersTotal.ordersTotalId}">
				<input type="hidden" name="productVO.order.orderId" value="${productVO.order.id}">
				<input type="hidden" name="productVO.tourInfoForOrder.id" value="${productVO.tourInfoForOrder.id}">
				<input type="hidden" name="productVO.tourInfoForOrder.groupLineId" value="${groupLine.id}">
				<input type="hidden" name="productVO.order.peerUserFee" value="${productVO.order.peerUserFee}">
				<input type="hidden" name="productVO.receivableInfoOfOrder.totalCommonTourFee" value="${productVO.receivableInfoOfOrder.totalCommonTourFee}">
				<input type="hidden" name="productVO.order.profit" id="supplement" value="${ageOfPrice.supplement}">
				<input type="hidden" id="PriceTotal" name="productVO.price" value="${productVO.receivableInfoOfOrder.totalCommonTourFee}"/>
				<input type="hidden" name="" id="hotelPrice" value="${ageOfPrice.hotelPrice}">
				<div style="display:none;" id="cusback"></div>
				<div class="step-pane active" id="step1">
						<div class="tourinfo_leftbox fl">
				        	<div class="tourinfo_name">${groupLine.tourName}&nbsp;&nbsp;&nbsp;Product Code：${groupLine.tourCode}</div>
				            <div class="tourinfo_box">
				            	<div class="tourinfo_titile_1">Product Info</div>
				                <div class="line"></div>
				                <!--div class="tourinfo_date">
				                	<div class="date_d fl">
				                    	<label>Tour Type:<b style="color:red;">*</b>:</label>
				                        <select id="tourTypeSelect" name="productVO.order.tourTypeId" onchange="tourTypeSelectChange(this);" class="perlist">
										[#list tourTypeList as tourType]
											<option value="${tourType.tourTypeId}" type="${tourType.type}" [#if tourType.tourTypeId == productVO.order.tourTypeId]selected="selected" original="true"[#else]original="false"[/#if]>${tourType.typeName}</option>
										[/#list]
										</select>
				                    </div>
				                    <div class="date_d fl">
				                    	<label>Product<b style="color:red;">*</b>:</label>
				                        <select id="groupLineSelect" name="productVO.tourInfoForOrder.groupLineId" class="perlist">
										[#list groupLineList as groupLine]
											<option value="${groupLine.id}" [#if groupLine.id == productVO.tourInfoForOrder.groupLineId]selected="selected"[/#if]>${groupLine.tourCode}</option>
										[/#list]
										</select>

				                    </div>
				                    <div class="clear"></div>
				                </div>
				                <div class="line_s"></div-->
				                <div class="tourinfo_date">
				                	[#if groupLine.ticket==0 ]
					                	<div class="date_d fl">
					                    	<label style="width:200px">Date Arrive In Destination<b style="color:red;">*</b>:</label>
					                        <input  type="text" disable="disable" name="productVO.tourInfoForOrder.departureDate" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] class="form-control input-group1 tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
					                    </div>
				                    [/#if]
				                    [#if groupLine.ticket==1 ]
				                    	<div class="date_d fl">
					                    	<label>Departure Date<b style="color:red;">*</b>:</label>
					                        <input  type="text" disable="disable" name="productVO.tourInfoForOrder.departureDate" [#if productVO.tourInfoForOrder.departureDate??] value="${productVO.tourInfoForOrder.departureDate?string('yyyy-MM-dd')}"[/#if] class="form-control input-group1 tourDate_d" placeholder="yyyy-mm-dd" onChange="changePrice();"/>
					                    </div>
					                    <div class="date_d fl">
					                    	<label style="width:200px">Date Arrive In Destination<b style="color:red;">*</b>:</label>
					                        <input type="hidden" name="productVO.tourInfoForOrder.id" value="${productVO.tourInfoForOrder.id}"/>
										<input class="form-control input-group1 JDATE tourDate_d" type="text" id="scheduleOfArriveTime" name="productVO.tourInfoForOrder.scheduleOfArriveTime" value="[#if (productVO.tourInfoForOrder.scheduleOfArriveTime)??]${productVO.tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}[/#if]" class="form-control input-group1" required  placeholder="yyyy-mm-dd" />
					                    </div>
				                    [/#if]
				                    <div class="clear"></div>
				                </div>
				                <div class="line_s"></div>
				                <div class="tourinfo_titile_1">Contact Information</div>
				                <div class="line"></div>
				                <div class="tourinfo_date">
				                	<div class="date_d fl">
				                    	<label>Contacts <b style="color:red;">*</b>:</label>
				                        <input type="text" id="contactName" name="productVO.ordersTotal.contactName" value="${ordersTotal.contactName}" class="tourDate_d">
				                    </div>
				                    <div class="clear"></div>
				                </div>
				            </div>
				            <div class="form-group tourinfo_fy_btn" align="right">
								<div class="col-sm-offset-2 col-sm-10 ">
									<button type="button" onclick="javascript:history.go(-1)" class="btn btn-default fy_btn_1">Cancel</button>
									<button  onclick="nextDiv(2);" class="btn btn-primary wizard-next fy_btn_2">Next Step <i class="fa fa-caret-right"></i></button>
								</div>
							</div>
				        </div>
					</div>
				
				<div class="step-pane" id="step2">
					<div class="tourinfo_leftbox fl">
		        		<div class="tourinfo_name">${groupLine.tourName}&nbsp;&nbsp;&nbsp;Product Code：${groupLine.tourCode}</div>
			            <div class="tourinfo_box">
			            	<table cellpadding="0" cellspacing="0" class="customer_tab" width="100%">
			                	<tr class="customer_tab_1">
			                    	<td align="left"><b>Last/Frist Middle Name</b></td>
			                        <td><b>Gender</b></td>
			                        <td><b>Nationality</b></td>
			                        <td><b>PassportNo.</b></td>
			                        <td><b>RoomType</b></td>
			                    </tr>
			                    <tbody id="customerList" class="no-border-y">
			                    [#list customerOrderRelList as customerOrderRel]
									<tr id="${customerOrderRel.id}">
										<td>${customerOrderRel.customer.lastName}/${customerOrderRel.customer.firstName} ${customerOrderRel.customer.middleName}</td>
										<td>[#if customerOrderRel.customer.sex == 1]F[#else]M[/#if]</td>
										<td>${customerOrderRel.customer.nationalityOfPassport}</td>
										<td>${customerOrderRel.customer.passportNo}</td>
										<td>${customerOrderRel.guestRoomType}</td>
									</tr>
								[/#list]
								</tbody>
			                </table>
			            </div>
			            <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(1);"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" id="customerFlightStep" onclick="nextDiv(3);" class="btn btn-primary wizard-next fy_btn_2">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
				 	</div>
			    </div>	
          		<div class="step-pane" id="step3">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">${groupLine.tourName}&nbsp;&nbsp;&nbsp;Product Code：${groupLine.tourCode}</div>
	                    <div class="tourinfo_box" id="tourinfo_box">
	                    	<input type="hidden" id="customerNumber" value="${productVO.customerFlights.size()}"/>
							[#list productVO.customerFlights as cor]
							 <div class="flight_1">
	                            <div class="flight_1_top">
	                                <span class="flight_1_num fl">No.${cor_index+1}   
	                                	[#list customerList as customer]
											[#if customer.customerId == cor.customerId]${customer.lastName}/${customer.firstName}/${customer.middleName}[/#if]
										[/#list]
									</span>
	                                <a class="flight_1_btn r1" href="javascript:;" onclick="theSameAsPrevious(${cor_index});">As Above</a>
	                                <div class="clear"></div>
	                            </div>
	                            <input type="hidden" name="productVO.customerFlights[${cor_index}].customerId" value="${cor.customerList[0].customerId}">
								<input type="hidden" name="productVO.customerFlights[${cor_index}].customerOrderRelId" value="${cor.customerList[0].customerOrderRelId}">
								<input type="hidden" name="productVO.customerFlights[${cor_index}].customerFlightList[0].id" value="${cor.customerFlightList[0].id}">
	                            <div class="flight_1_down">
	                                <div class="flight_1_down_main">
	                                    <div class="tourinfo_date">
	                                        <div class="date_d fl">
	                                            <label>Airline:</label>
	                                            <input class="tourDate_d" name="productVO.customerFlights[${cor_index}].customerFlightList[0].flightCode" value="${cor.customerFlightList[0].flightCode}" type="text"  placeholder="Airline">
	                                        </div>
	                                        <div class="date_d fl">
	                                            <label>Flight No.:</label>
	                                            <input class="tourDate_d" name="productVO.customerFlights[${cor_index}].customerFlightList[0].flightNumber" value="${cor.customerFlightList[0].flightNumber}"  type="text"  placeholder="Flight No.">
	                                        </div>
	                                        <div class="clear"></div>
	                                    </div>
	                                    <div class="tourinfo_date">
	                                        <div class="date_d fl">
	                                            <label>Arrival Date:</label>
	                                            <input type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[0].arriveDate" id="arriveDate${cor_index}" value="[#if (cor.customerFlightList[0].arriveDate)??]${cor.customerFlightList[0].arriveDate?string('yyyy-MM-dd')}[/#if]" class=" tourDate_d" placeholder="Arrival Date：yyyy-mm-dd" />
	                                        </div>
	                                        <div class="date_d fl">
	                                            <label>Arrival Time:</label>
	                                            <input class="tourDate_d" type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[0].arriveTime" value="${cor.customerFlightList[0].arriveTime}"  placeholder="Arrival Time"/><font size="2px" color="red"></font>
	                                        </div>
	                                        <div class="clear"></div>
	                                    </div>
	                                    <div class="tourinfo_date">
	                                        <div class="date_d fl">
	                                            <label>Pick-up:</label>
	                                            <input type="radio" name="productVO.customerFlights[${cor_index}].customerFlightList[0].ifPickUp" value="1" style="width: 30px;" [#if cor.customerFlightList[0].ifPickUp==1]checked="checked"[/#if] >Yes
	                                            <input type="radio" name="productVO.customerFlights[${cor_index}].customerFlightList[0].ifPickUp" value="2" style="width: 30px;" [#if cor.customerFlightList[0].ifPickUp==2]checked="checked"[/#if]>No
	                                            <input class="hasDatepicker" name="productVO.customerFlights[${cor_index}].customerFlightList[0].outOrEnter" value="1" type="hidden">
	                                        </div>
	                                        <div class="clear"></div>
	                                    </div>
	                                    <div class="line_s"></div>
	                                    <div class="tourinfo_date">
	                                        <div class="date_d fl">
	                                            <label>Airline:</label>
	                                            <input type="hidden" name="productVO.customerFlights[${cor_index}].customerFlightList[1].id" value="${cor.customerFlightList[1].id}">
												<input class=" tourDate_d" name="productVO.customerFlights[${cor_index}].customerFlightList[1].flightCode" value="${cor.customerFlightList[1].flightCode}" type="text" placeholder="Airline">
	                                        </div>
	                                        <div class="date_d fl">
	                                            <label>Flight No.:</label>
	                                            <input class=" tourDate_d" name="productVO.customerFlights[${cor_index}].customerFlightList[1].flightNumber" value="${cor.customerFlightList[1].flightNumber}"  type="text" placeholder="Flight No.">
	                                        </div>
	                                        <div class="clear"></div>
	                                    </div>
	                                    <div class="tourinfo_date">
	                                        <div class="date_d fl">
	                                            <label>Departure Date:</label>
	                                            <input type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[1].arriveDate" id="departure${cor_index}" class="tourDate_d"  value="[#if (cor.customerFlightList[1].arriveDate)??]${cor.customerFlightList[1].arriveDate?string('yyyy-MM-dd')}[/#if]"   placeholder="Departure Date:yyyy-mm-dd" />
	                                        </div>
	                                        <div class="date_d fl">
	                                            <label>Departure Time:</label>
	                                            <input class="tourDate_d"  type="text" name="productVO.customerFlights[${cor_index}].customerFlightList[1].arriveTime"  value="${cor.customerFlightList[1].arriveTime}"   placeholder="Departure Time"/>
	                                        </div>
	                                        <div class="clear"></div>
	                                    </div>
	                                    <div class="tourinfo_date">
	                                        <div class="date_d fl">
	                                            <label>See-of:</label>
	                                            <input type="radio" style="width: 30px;" name="productVO.customerFlights[${cor_index}].customerFlightList[1].ifSendUp" [#if cor.customerFlightList[1].ifSendUp==1]Checked[/#if] value="1" >Yes
	                                            <input type="radio" style="width: 30px;" name="productVO.customerFlights[${cor_index}].customerFlightList[1].ifSendUp" [#if cor.customerFlightList[1].ifSendUp==2]Checked[/#if] value="2" >No
	                                            <input  class="hasDatepicker" name="productVO.customerFlights[${cor_index}].customerFlightList[1].outOrEnter" value="2" type="hidden">
	                                        </div>
	                                        <div class="clear"></div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                       [/#list]
	                    </div>
	                    <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(2);"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="checktic(4);" id="stepHave">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
			    </div>
			    <div class="step-pane" id="step4">
          			<div class="tourinfo_leftbox fl">
	                    <div class="tourinfo_name">${groupLine.tourName}&nbsp;&nbsp;&nbsp;Product Code：${groupLine.tourCode}</div>
	                    <div class="tourinfo_box" id="PerList">
	                    	<input type="hidden" id="perInfoList" name="productVO.order.proInfo">
	                    	<input type="hidden" id="postInfoList" name="productVO.order.postInfo">
	                    	<input type="hidden" id="perTrNum" value="">
	                    	<input type="hidden" id="postTrNumt" value="">
	                    	<div class="perbox">
			                	<div class="tourinfo_titile_1">Per accommodation</div>
			                    <div class="line"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label">Change Guest:</label>
			                            <select class="perlist" id="percus">
			                            	[#list customerList as customer]
												<option value="${customer.lastName}/${customer.firstName}/${customer.middleName}">${customer.lastName}/${customer.firstName}/${customer.middleName}</option>
											[/#list]
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label">Room Type:</label>
			                            <select class="perlist" id="perroom">
			                            	<option value="Single">Single</option>
			                            	<Option value="Twin Bed">Twin Bed</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label_day">Nights:</label>
			                            <input type="text" id="pre" class="per_day">
			                            <input type="button" onclick="hotelPerAcc()" class="per_btn">
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="pertr" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%"><b>Room Type</b></td>
			                            <td width="10%"><b>Nights</b></td>
			                            <td width="10%"><b>Action</b></td>
			                        </tr>
			                        [#list inf as proInfo]
				                        <tr height="50" align="center" id="perInfo${inf_index+1}">
				                        	<input type="hidden" name="perInfoList" value="proInfo"/>
			                        		[#list proInfo?split(":") as fo]  
				                            <td>${fo}</td>
				                            [/#list]
				                            [#list proInfo?split(":") as po]  
				                            [#if po_index==2]
				                            	<td><a title="Delete" class="label label-danger" href="javascript:;" onclick="delInfo('${inf_index+1}','per','${po}')"><i class="fa fa-times"/></a></td>
				                            [/#if]
				                            [/#list]
				                            
				                        </tr>
			                        [/#list]
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                </div> 
			                
			                <div class="perbox">
			                	<div class="tourinfo_titile_1">Post accommodation</div>
			                    <div class="line"></div>
			                    <div class="tourinfo_date">
			                        <div class="date_d fl">
			                            <label class="per_label">Guest:</label>
			                            <select class="perlist" id="postcus">
			                                [#list customerList as customer]
												<option value="${customer.lastName}/${customer.firstName}/${customer.middleName}">${customer.lastName}/${customer.firstName}/${customer.middleName}</option>
											[/#list]
			                            </select>
			                        </div>
			                         <div class="date_d fl">
			                            <label class="per_label">Room:</label>
			                            <select class="perlist" id="postroom">
			                            	<option value="Single">Single</option>
			                            	<Option value="Twin Bed">Twin Bed</option>
			                            </select>
			                        </div>
			                        <div class="date_d fl">
			                            <label class="per_label_day">Nights:</label>
			                            <input type="text" id="post" class="per_day">
			                            <input type="button" onclick="hotelPostAcc()" class="per_btn">
			                        </div>
			                        <div class="clear"></div>
			                	</div>
			                    <div class="per_table">
			                        <table cellpadding="0" id="posttr" cellspacing="0" class="per_tab" width="100%">
			                        <tr class="per_tab_1">
			                            <td width="40%"><b>Last/Frist Middle Name</b></td>
			                            <td width="40%"><b>Room Type</b></td>
			                            <td width="10%"><b>Nights</b></td>
			                            <td width="10%"><b>Action</b></td>
			                        </tr>
			                        [#list pos as posInfo]
				                        <tr height="50" align="center" id="postIn${pos_index+1}">
				                        	<input type="hidden" name="postInfoList" value="posInfo"/>
			                        		[#list posInfo?split(":") as po]  
				                            <td>${po}</td>
				                            [/#list]
				                            [#list posInfo?split(":") as po]  
				                            [#if po_index==2]
				                            	<td><a title="Delete" class="label label-danger" href="javascript:;" onclick="delInfo('${pos_index+1}','post','${po}')"><i class="fa fa-times"/></a></td>
				                            [/#if]
				                            [/#list]
				                        </tr>
			                        [/#list]
			                        </table>
			                	</div>
			                    <div class="line_s"></div>
			                </div> 
	                    </div>
	                    <div class="form-group tourinfo_fy_btn" align="right">
							<div class="col-sm-12">
								<button data-wizard="#wizard1" class="btn btn-default wizard-previous fy_btn_1" onclick="nextDiv(3);"><i class="fa fa-caret-left"></i> Previous</button>
								<button data-wizard="#wizard1" class="btn btn-primary wizard-next fy_btn_2" onclick="info(5);" id="stepHave">Next Step <i class="fa fa-caret-right"></i></button>
							</div>
						</div>
	                </div>
			    </div>
			    <div class="step-pane" id="step5">
			    	<div class="tourinfo_leftbox fl">
			        	<div class="tourinfo_name">${groupLine.tourName}&nbsp;&nbsp;&nbsp;Product Code：${groupLine.tourCode}</div>
			            <div class="tourinfo_box">
			            	<div class="flight_1">
			                	<div class="flight_1_top">
			                    	<span class="flight_1_num fl">Requirement:</span>
			                        <div class="clear"></div>
			                    </div>
			                    <div class="flight_1_down">
			                    	<div class="flight_1_down_main">
			                    		<textarea name="productVO.tourInfoForOrder.specialRequirements" class="textarea">${productVO.tourInfoForOrder.specialRequirements}</textarea>
			                        </div>
			                    </div>
			                    
			                </div>
			                <div class="flight_1">
			                	<div class="flight_1_top">
			                    	<span class="flight_1_num fl">Remark:</span>
			                        <div class="clear"></div>
			                    </div>
			                    <div class="flight_1_down">
			                    	<div class="flight_1_down_main">
			                    	<textarea name="productVO.tourInfoForOrder.tourInfo" class="textarea">${productVO.tourInfoForOrder.tourInfo}</textarea>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="tourinfo_fy_btn">
			                <button type="button" onclick="javascript:history.go(-1)" class="btn btn-default fy_btn_1">Cancel</button>
							<button type="button" onclick="sub();" data-wizard="#wizard1" class="btn btn-success wizard-next fy_btn_3"><i class="fa fa-check"></i> Save </button>
			            </div>
			        </div>
          		</div>
          <!--右侧层-->
          <div class="tourinfo_summary r1">
        	<div class="summary_tit"><span>SUMMARY</span></div>
            <div class="summary_box">
            	<div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Adult Price:</span><span id="adult">[#if ageOfPrice.adult??]${ageOfPrice.adult}[#else]0[/#if]</span>/<span id="adultNum">0</span><span>Pax</span>
                </div>
                <div class="line_2s"></div>
            	<div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Child Bed:</span><span id="bed">[#if ageOfPrice.bed??]${ageOfPrice.bed}[#else]0[/#if]</span>/<span id="bedNum">0</span><span>Pax</span>
                </div>
                <div class="line_2s"></div>
            	<div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Child Not Bed:</span><span  id="notBed">[#if ageOfPrice.notBed??]${ageOfPrice.notBed}[#else]0[/#if]</span>/<span id="notBedNum">0</span><span>Pax</span>
                </div>
                <div class="line_2s"></div>
            	<div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Children:</span><span id="children">[#if ageOfPrice.children??]${ageOfPrice.children}[#else]0[/#if]</span>/<span id="childrenNum">0</span><span>Pax</span>
                </div>
                <div class="line_2s"></div>
            	<div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Baby Price:</span><span id="baby">[#if ageOfPrice.baby??]${ageOfPrice.baby}[#else]0[/#if]</span>/<span id="babyNum">0</span><span>Pax</span>
                </div>
                <div class="line_2s"></div>
                <div class="summary_box1">
                	<input type="hidden" value="0" id="totalPeople" name="totalPeople" readonly />
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Total Number:</span><span id="totalPeople1">${ordersTotal.totalPeople}</span>&nbsp;&nbsp;&nbsp;Pax
                </div>
                <div class="line_2s"></div>
                <div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Tip :</span><span>$</span><span><input type="hidden" id="tip"value="${groupLine.tip}"/>${groupLine.tip}</span>
                	<input type="hidden" id="rate"value="${rate.usRate}"/>
                </div>
                <div class="line_2s"></div>
                <div class="summary_box1">
                	<span style="margin-right:10px;width: 130px;display: inline-block;">Self Expense:</span><span>$</span><span><input type="hidden" id="self" value="${groupLine.selfExpense}"/>${groupLine.selfExpense}</span>
                </div>
                <div class="line_2s"></div>
                <div class="summary_box2">
                	<span style="margin-right:10px;">Total:</span><span style="color:#ed6f42;">${currency.symbol}</span><span style="color:#ed6f42;" id="totalPrice">${productVO.receivableInfoOfOrder.totalCommonTourFee}</span>
                </div>
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
[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript">
/*************************悬浮层js****************************/
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
    })
/*************************************************/
   $(document).ready(function(){
    	$("#departureDateInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay: available, numberOfMonths: 1, minDate: 1 });
    	$("#scheduleOfArriveTime").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#dateOfBirthInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay: available, numberOfMonths: 1, minDate: 1 });
    	$("#dateOfBirth").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	$("#arriveDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#expireDateOfPassportInput").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	$("#expireDateOfPassport").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
    	for(var a=0;a<${ordersTotal.totalPeople};a++){
    		$("#arriveDate"+a).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    		$("#departure"+a).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    	}
		App.wizard();
    });
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
       function sub(){
    	$.ajax({
                cache: true,
                type: "POST",
                url:"tourOrderUpdate.jhtml",
                data:$('#ww').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    alert("Connection error");
                },
                success: function(data) {
                   alert("success");
                    location.reload();
                }
            });
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
	
    $(document).ready(function(){
    	App.init();
    });
    
	
	/* 异步修改订单信息  */
	function updateOrdersTotal(){
		if($("#retailWholeSale").val() != 'retail'){
    		if($("#userSelect").val() == ''){
    			alert('Please select agency.');
    			return;
    		}
    	}
		$.ajax({
			url:'${base}/admin/orders/updateOrdersTotal.jhtml',
			data: $("#form").serialize(),
			type:"POST",
			beforeSend:function(){
			},
			success:function(result){
				if(result == 'success'){
					alert("Update completed");
				}
			}
		});
	}
	
    function changeDiv(num){
    	for(var c=1;c<6;c++){
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
		$.ajax({
			url:'${base}/admin/peerUser/arrPrice.jhtml',
			data:'groupLineId='+groupLineId+'&departureTime='+departureTime,
			type:"POST",
			dataType:"json",
			beforeSend:function(){
			},
			success:function(ageOfPrice){
				$("#adult").text(ageOfPrice.adult);
				$("#bed").text(ageOfPrice.bed);
				$("#notBed").text(ageOfPrice.notBed);
				$("#children").text(ageOfPrice.children);
				$("#baby").text(ageOfPrice.baby);
				$("#peerUserFee").attr("value",ageOfPrice.commission);
				$("#hotelPrice").attr("value",ageOfPrice.hotelPrice);
				$("#supplement").attr("value",ageOfPrice.supplement);
			}
		});
	}
	/**添加酒店续住**/
		   	
	function hotelPerAcc(){
		var hotelTotal=$("#hotelTotal").val();//酒店总费用
		var totalPrice=$("#totalPrice").text();
		var hotelPrice=$("#hotelPrice").val();
		var trNum=Number($("#perTrNum").val())+1;
		$("#perTrNum").attr("value",trNum);
		var price=Number(hotelPrice)*Number($("#pre").val());//计算后的酒店费用
		$("#hotelTotal").attr("value",Number(hotelTotal)+Number(price));
		var info=$("#perInfoList").val();
		var perInfo=$("#percus").val()+":"+$("#perroom").val()+":"+$("#pre").val();
		$("#totalPrice").text(Number(totalPrice)+Number(price));
		$("#PriceTotal").attr("value",Number(totalPrice)+Number(price));
		html='<tr height="50" id="perInfo'+trNum+'" align="center"><td width="40%"><input type="hidden" name="perInfoList" value="'+perInfo+'">'+$("#percus").val()+'</td><td width="40%">'+$("#perroom").val()+'</td><td width="10%">'+$("#pre").val()+'</td><td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delInfo(\''+trNum+'\',\'per\',\''+$("#pre").val()+'\')"><i class="fa fa-times"/></a></td></tr>';
		$("#pertr").append(html);
	}
	function hotelPostAcc(){
		var hotelTotal=$("#hotelTotal").val();//酒店总费用
		var totalPrice=$("#totalPrice").text();
		var hotelPrice=$("#hotelPrice").val();
		var trNum=Number($("#postTrNum").val())+1;
		$("#postTrNum").attr("value",trNum);
		var price=Number(hotelPrice)*Number($("#post").val());//计算后的酒店费用
		$("#hotelTotal").attr("value",Number(hotelTotal)+Number(price));
		var info=$("#postInfoList").val();
		var perInfo=$("#postcus").val()+":"+$("#postroom").val()+":"+$("#post").val();//获取存储值
		$("#totalPrice").text(Number(totalPrice)+Number(price));
		$("#PriceTotal").attr("value",Number(totalPrice)+Number(price));
		html='<tr height="50" id="postIn'+trNum+'" align="center"><td width="40%"><input type="hidden" name="postInfoList" value="'+perInfo+'">'+$("#postcus").val()+'</td><td width="40%">'+$("#postroom").val()+'</td><td width="10%">'+$("#post").val()+'</td><td width="10%"><a title="Delete" class="label label-danger" href="javascript:;" onclick="delInfo(\''+trNum+'\',\'post\',\''+$("#post").val()+'\')"><i class="fa fa-times"/></a></td></tr>';
		$("#posttr").append(html);
	}
	/**接送机费用计算**/
	function checktic(divnum){
	var ticketNum=0;
	var pickSendPrice=self=Number($("#pickSendPrice").val())*Number($("#rate").val());//转换后的接送机费用
	var lease=$("#lease").val();
	var num=$("#totalPeople").val();
		for(var a=0;a<num;a++){
			if($("input[id='ifPickUp"+a+"']:checked").val()>0||$("input[id='ifSendUp"+a+"']:checked").val()>0){
				ticketNum +=1;
			}
		}
		var telPrice=0;
		if(ticketNum<lease){
			telPrice=Number(pickSendPrice)*Number(lease);//总接送机费用
		}else{
			telPrice=Number(pickSendPrice)*Number(ticketNum);//总接送机费用
		}
		$("#ticketTotal").attr("value",telPrice);
		 nextDiv(divnum);
	}
	function delInfo(trNum,type,nights){
		var hotelTotal=$("#hotelTotal").val();//酒店总费用
		var totalPrice=$("#totalPrice").text();
		var hotelPrice=$("#hotelPrice").val();
		var price=Number(hotelPrice)*Number(nights);//计算后的酒店费用
		if(type=="per"){
			$("#perInfo"+trNum+"").remove();
		}
		if(type=="post"){
			$("#postIn"+trNum+"").remove();
		}
		$("#totalPrice").text(Number(totalPrice)-Number(price));
		$("#PriceTotal").attr("value",Number(totalPrice)-Number(price));
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
	    alert(perInfo);
	    $("#perInfoList").attr("value",perInfo);
	    $("#postInfoList").attr("value",postInfo);
	    
		nextDiv(divnum);
	}
</script>
<script type="text/javascript" src="[@spring.url '/resources/js/behaviour/general.js'/]"></script>
<script src="[@spring.url '/resources/js/fuelux/loader.js'/]" type="text/javascript"></script>
<script src="[@spring.url '/resources/js/jquery.parsley/parsley.js'/]" type="text/javascript"></script>
</body>
</html>