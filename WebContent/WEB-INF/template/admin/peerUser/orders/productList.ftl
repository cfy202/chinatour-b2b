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
<div class="w1 mt1">

<div id="xfc" class="w1 mt1" style="display:none;background-color:#fff;position:fixed;margin-top: -200px;z-index: 1000;">
	<div id="listTop">
		<table cellpadding="0" cellspacing="0" width="100%">
	        <tr class="tr_1">
	            <th rowspan="2" width="35">No.</th>
	            <th rowspan="2" width="63">Brand</th>
	            <th width="155" rowspan="2" id="cnNames">Product Name</th>
	            <th align="center" rowspan="2" width="66">Adult</th>
	            <th align="center" rowspan="2" width="91">Commission</th>
	            <th align="center" rowspan="2" width="40">Net</th>
	            <th align="center" colspan="2" width="114">Child without Bed</th>
	            <th align="center" rowspan="2" width="43">Child with Bed</th>
	            <th align="center" rowspan="2" width="91">Child Commission</th>
	            <th align="center" rowspan="2" width="90">Single Supplement</th>
	            <th align="center" rowspan="2" width="66">Pre/Post</th>
	            <th align="center" colspan="2" width="147">Other Fee</th>
	            <th align="center" rowspan="2" width="77">Departure Date</th>
	            <th align="center" width="74">Remark</th>
	            <th align="center" rowspan="2" style="border-right:0px" >Action</th>
	        </tr>
	        <tr class="tr_1">
	            <th align="center" width="48">Infant</th>
	            <th align="center" width="66">Children</th>
	            <th align="center" width="57">Service Fee</th>
	            <th align="center" width="90">Compulsory Programs</th>
	            <th align="center">Start/End City</th>
	        </tr>
	    </table>
	</div>
</div>
	<div class="tours_condition">
        <div class="tours_country">
	        <li [#if groupLine.settlePrice=1||groupLine.settlePrice==null]class="tours_c tours_check"[#else]class="tours_c"[/#if] onclick="changeName(1)">
			   中文
			</li>
			<li [#if groupLine.settlePrice=2]class="tours_c tours_check"[#else]class="tours_c"[/#if] onclick="changeName(2)">
			   English
			</li>
			<input type="hidden" id="nameB" value="${groupLine.settlePrice}">
	    </div>
        <div class="clear"></div>
		</br>
    	<ul class="tours_country">
    		[#list area as areas]
    			<li 
    				[#if areas.areaName==groupLine.area]
    					class="tours_c tours_check"
    				[#else]
    					[#if groupLine.area==null && areas_index==0]
    						class="tours_c tours_check"
    					[#else]
    						class="tours_c"
    					[/#if]
    				[/#if] 
    				id="areaId${areas_index}" onclick="changeArea('${areas.areaName}','${areas_index}')">${areas.areaName}</li>
            	<li class="tours_line">丨</li>
    		[/#list]
    			<!--<li class="tours_line"><font color="red">Notice:文景假期（美洲及欧洲）-2017年新团期已出，请进2016年板块选择</font></li>-->
    			<!--li class="tours_c tours_check" id="areaId${areas_index}">
    			    中国美（中国&亚洲）
    			</li-->
            	<!--li class="tours_line">丨</li-->
            <input type="hidden" value="${groupLine.area}" id="area"/>
            <input type="hidden" value="${area.size()}" id="areaSize">
        </ul>
        <div class="clear"></div>
        <div class="tours_top_fenge"></div>
        <form name="ksearch" method="get" action="">
        <div class="tours_search">
	        	<div class="fl">
	                <ul class="tours_country">
	                	<li class="tours_c" style="padding: 0px;color:#ff0000">Key Words：</li>
	                	<li [#if groupLine.degree=="超值特价"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searDes('超值特价');" id="超值特价">超值特价</li>
	                	<li [#if groupLine.degree=="纯玩无购物"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searDes('纯玩无购物');" id="纯玩无购物">纯玩无购物</li>
	                	<!--
	                	<li [#if groupLine.degree=="英文系列"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searDes('英文系列');" id="英文系列">英文系列</li>
	                	<li [#if groupLine.degree=="美西洛杉矶"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searDes('美西洛杉矶');" id="美西洛杉矶">美西/洛杉矶</li>
	                	<li [#if groupLine.degree=="黄石旧金山"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searDes('黄石旧金山');" id="黄石旧金山">黄石/旧金山</li>
	                	<li [#if groupLine.degree=="美东纽约华盛顿"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searDes('美东纽约华盛顿');" id="美东纽约华盛顿">美东/纽约/华盛顿</li>
	                	-->
	                	<input id="degree" type="hidden" value="${groupLine.degree}">
	                </ul>
	            </div>
	            <div class="clear"></div>
	            <div class="fl" style="margin:10px;">
	                <ul class="tours_country">
	                	<li class="tours_c" style="padding: 0px;color:#ff0000;margin-left:30px">Year：</li>
	                	<!-- <li [#if groupLine.tourName=="2018"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searYear('2018');" id="2018Year">2018（2018年3月-2019年2月）</li> -->
						<li [#if groupLine.tourName=="2019"]class="tours_c tours_check"[#else]class="tours_c" style="color:#018ddf"[/#if] onclick="searYear('2019');" id="2019Year">2019（2019年3月-2020年2月）</li>
	                	<input id="tourName" type="hidden" value="${groupLine.tourName}">
	                </ul>
	            </div>
	            <div class="clear"></div>
	            <div class="tours_search_main fl">
	            	<ul class="tours_country">
	            	 	<li class="tours_c" style="padding: 0px;color:#ff0000;margin-left:30px">Other：</li>
		             	<li class="tours_c" style="padding: 0px;color:#333;margin-left:10px"><input type="text" id="lineNo"  value="${groupLine.lineNo}" placeholder="NO." class="tours_name" style="height:35px;"></li>
		                <li class="tours_c" style="padding: 0px;color:#333;margin-left:10px;display:none"><input type="text" id="tourNames" value="${groupLine.tourName}" placeholder="Product Name" class="tours_code" style="height:35px"></li>
		                <li class="tours_c" style="padding: 0px;color:#333;margin-left:10px"><input type="text" id="remark"  value="${groupLine.remark}" class="tours_code" style="height:35px" placeholder="Day"></li>
		                <li class="tours_c" style="padding: 0px;color:#333;margin-left:10px">
		                	<select id="destinationList" style="height:35px;" >
		                		<option value="">Select Destination</option>
		                		[#list destinationList as des]
		                		<option value="${des.destination}" [#if groupLine.destinationlist==des.destination]selected="selected"[/#if]>${des.destination}</option>
		                		[/#list]
		                	</select>
		                </li>
		                <li class="tours_c" style="padding: 0px;color:#ff0000;margin-left:10px">
		                	<div class="tours_search_btn" style="width: 170px;float: right;">
		            			<input type="button" value=" Search " onclick="searchAll();" class="tours_btn_1">
	            			</div>
	            		</li>
	            	</ul>
            	</div>
            <div class="clear"></div>
        </div>
        </form>
    </div>
    <div class="list_cont_sort">
      <div class="list_cont_sort_1">
        <span class="down" title="" onclick="search();">
                  Default
        </span>
        <span class="down" title="From high to low" onclick="sear('t');">
                  Days
        </span>
        <span class="down" title="From high to low" onclick="sear('p');">
                  Price
        </span>
        <div class="clear"></div>
      </div> 
    </div>
    <div class="tours_box" id="tableId" style="position: relative;z-index:99">
		<table cellpadding="0" cellspacing="0" width="100%">
			<tr class="tr_1">
                    <th rowspan="2" width="10">No.</th>
                    <th rowspan="2" width="63">Brand</th>
                    <th width="182" rowspan="2" id="cnName">Product Name</th>
                    <th align="center" rowspan="2" width="73">Adult</th>
                    <th align="center" rowspan="2" width="91">Commission</th>
                    <th align="center" rowspan="2" width="40">Net</th>
                    <th align="center" colspan="2" width="114">Child without Bed</th>
                    <th align="center" rowspan="2" width="43">Child with Bed</th>
                    <th align="center" rowspan="2" width="91">Child Commission</th>
                    <th align="center" rowspan="2" width="90">Single Supplement</th>
                    <th align="center" rowspan="2" width="66">Pre/Post</th>
                    <th align="center" colspan="2" width="147">Other Fee</th>
                    <th align="center" rowspan="2" width="77">Departure Date</th>
                    <th align="center" width="74">Remark</th>
                    <th align="center" rowspan="2" style="border-right:0px" >Action</th>
                </tr>
                <tr class="tr_1">
                    <th align="center" width="48">Infant</th>
                    <th align="center" width="66">Children</th>
                    <th align="center" width="57">Service Fee</th>
                    <th align="center" width="90">Compulsory Programs</th>
                    <th align="center">Start/End City</th>
                </tr>
		   [#list groupLineList as groupLines]
		    	<tr>
		    		<td rowspan="2" width="10" class="tab_t1" style="border-left:0px;text-align:right">${groupLines.lineNo}</td>
		            <td rowspan="2" width="63" class="tab_t1" style="text-align:center">
		            	[#if groupLines.brand=="InterTrips"]
                    		<img src="[@spring.url '/resources/peerUser/images/brand_1.png'/]" width="50" height="23" style="margin-left:2px"/>
                    	[/#if]
                		[#if groupLines.brand=="chinatour"]
                    		<img src="[@spring.url '/resources/peerUser/images/brand_2.png'/]" width="50" height="23" style="margin-left:2px"/>
                    	[/#if]
                		[#if groupLines.brand=="文景假期"]
                    		<img src="[@spring.url '/resources/peerUser/images/brand_3.png'/]" width="50" height="23" style="margin-left:2px"/>
                    	[/#if]
                		[#if groupLines.brand=="中国美"]
                    		<img src="[@spring.url '/resources/peerUser/images/brand_4.png'/]" width="50" height="23" style="margin-left:2px"/>
                    	[/#if]
					</td>
		            <td rowspan="2" width="182" class="tab_t1" style="text-align:left">
		            [#if groupLine.settlePrice=2]
	                    <a style="cursor:pointer;" onclick="tourinfo(this);" id="enNameP">${groupLines.tourNameEn}</a>
		            	<input type="hidden" value="${groupLines.id}">
	                 [#else]
	                 	<a style="cursor:pointer;" onclick="tourinfo(this);" id="cnNameP">${groupLines.tourName}</a>
		            	<input type="hidden" value="${groupLines.id}">
		            	<div class="tours_info_icon">
	                    	<span>${groupLines.degree}</span>
	                        <div class="clear"></div>
	                    </div>
	                 [/#if]
		            </td>
		            <td class="tab_t1" width="73" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.adult}</td>
		            <td class="tab_t1" width="91" rowspan="2">${groupLines.currencyEng}	<br/>[#if groupLines.type==1]${groupLines.adult*groupLines.commission/100}[#else]${groupLines.commission}[/#if]</td>
		            <td class="tab_t1" width="40" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.settlePrice}</td>
		            <td class="tab_t1" width="48" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.baby}</td>
		            <td class="tab_t1" width="66" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.notBed}</td>
		            <td class="tab_t1" width="43" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.bed}</td>
		            <td class="tab_t1" width="91" rowspan="2">${groupLines.currencyEng} <br/>[#if groupLines.type==1]${groupLines.bed*groupLines.childComm/100}[#else]${groupLines.childComm}[/#if]</td>
		            <td class="tab_t1" width="90" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.price}</td>
		            <td class="tab_t1" width="66" rowspan="2">${groupLines.currencyEng} <br/>${groupLines.hotelPrice}</td>
		            <td class="tab_t1" width="57" rowspan="2">[#if groupLines.id=="9028C1AF-1047-41E6-BD4F-3A6C8D73BB9C" || groupLines.id=="4F4C7078-DA9A-4EA7-90AC-B107476BAE65"]EUR 188[#else]USD <br/>${groupLines.tip}[/#if]</td>
		            <td class="tab_t1" width="90" rowspan="2">USD <br/>${groupLines.selfExpense}</td>
	                <td class="tab_t1" width="77" style="text-align:center" rowspan="2"><input type="text" style="background:url([@spring.url '/resources/peerUser/images/date.png'/]);width:21px;height:22px;border:none;padding-left:21px; outline:none;cursor: pointer;"  id="date_${groupLines.id}" name="${groupLines.departureDate}" onfocus="showDate('${groupLines.departureDate}')"></td>
		            <td class="tab_t1" width="74" style="text-align:left" rowspan="2">${groupLines.placeStart}/${groupLines.destination}</td>
		            <td class="tab_t1" style="border-bottom: 0px;">
		                [#if groupLines.image!=0]
		            		<a style="width:57px" class="tours_btn_view" href="[@spring.url '/resources/web/${groupLines.currencyEng}/${groupLines.image}'/]" target="_blank">PDF</a>
		            	[#else]
		            		<a style="width:57px" class="tours_btn_view" href="exportB2BVoucher.jhtml?groupLineId=${groupLines.id}" target="_blank">PDF</a>
		            	[/#if]
		            </td>
		        </tr>
		        <tr>
		            <td class="tab_t1"><a class="tours_btn_book" href="bookProduct.jhtml?&brand=${groupLines.brand}&id=${groupLines.id}&price=${groupLines.price}&level=${groupLines.level}&supplement=${groupLines.supplement}&cost=${rate}">BOOK</a></td>
		        </tr>
		    [/#list]
		</table>
	      <div class="r1 pagination_page" id="pageNums">
	      	[#list 1..pageSize as i]
                <a title="第${i}页" href="javascript:;" onclick="page('${i}')" [#if pageable.pageNumber==i]class="page_cur"[#else]class="page"[/#if]>${i}</a>
            [/#list]
                <a id="nextPage" title="下一页" href="javascript:;" class="page" onclick="page('${pageable.pageNumber+1}')">Next></a>
          </div>
    </div>
    <div class="clear"></div>
</div>
[#include "/admin/peerUser/include/foot.ftl"]
<script src="[@spring.url '/resources/peerUser/js/lazyLoad/jquery.lazyload.js'/]"></script>
<script>
$(document).ready(function(){
	$(window).scroll(function () {
		var $bookingBar=$("#tableId");
		DEFAULT_TOP = $bookingBar.offset().top;
		var st = $(this).scrollTop();
		if(st>DEFAULT_TOP){
			$("#xfc").show();
		}else{
			$("#xfc").hide();
		}
	});
	//清除废弃数据
    	$.ajax({
			url: "${base}/admin/peerUser/delTotalInfo.jhtml",
			type: "GET",
			success: function(message) {
			}
		});
	size = "${pageSize}";
	if(size==0){
		$("#pageNums").hide();
	}else{
		i = $(".page_cur").html();
		if(size==i){
			$("#nextPage").hide();
		}else{
			$("#nextPage").show();
		};
	}
	
	$(function() {
		$("img").lazyload({
		effect : "fadeIn"
	});
	})
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
         if($(this).text()=='China Tour'){
         	$("#topBrand").attr('value','chinatour');
         }
         if($(this).text()=='InterTrips'){
         	$("#topBrand").attr('value','InterTrips');
         }
         if($(this).text()=='中国美'){
         	$("#topBrand").attr('value','中国美');
         }
         if($(this).text()=='文景假期'){
         	$("#topBrand").attr('value','文景假期');
         }
		 $(".brand_op").fadeOut(300);
    })
    
	var availableDates=""; //字符分割 
		
	function available(date) {
		var dmy = $.datepicker.formatDate('yy-mm-dd',date);
		if ($.inArray(dmy, availableDates) != -1) {
			return [true, "","Available"];
		} else {
			return [false,"","unAvailable"];
		}
	}
	
	function showDate(dateStr){
		availableDates=dateStr.split(",");
	}
	
 
$(function(){

	var tourName=$("#tourName").val();
	if(tourName==2018){
		$("#2018Year").attr("class","tours_c tours_check");
	}else{
		$("#2019Year").attr("class","tours_c tours_check");
	}
	$("#beginDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
	$("#endDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true});
        var $div_li =$(".brand_all li");
        $div_li.click(function(){
            $(this).addClass("brand_choice")            //当前<li>元素高亮
                   .siblings().removeClass("brand_choice");  //去掉其它同辈<li>元素的高亮
            var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
            $(".tours_right_main > div")       //选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
                    .eq(index).show()   //显示 <li>元素对应的<div>元素
                    .siblings().hide(); //隐藏其它几个同辈的<div>元素
        });
        
        $("input[id^='date_']").each(function(){
        	$(this).datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,beforeShowDay:available, numberOfMonths: 1, minDate: 1 });
        });
        
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
	/**区域获取值操作*/
	function changeArea(area,index){
		$("#area").attr("value",area);
		for(var i=0;i<$("#areaSize").val();i++){
			if(index==i){
				$("#areaId"+index).attr("class","tours_c tours_check");
			}else{
				$("#areaId"+i).attr("class","tours_c");
			}
		}
		search();
		
	}
	
	
	function search(){
		//var degree=$("#degree").val();
		var area=$("#area").val();
		var tourName=$("#tourName").val();
		/*var tourCode=$("#tourCode").val();
		var destination=$("#destination").val();
		var dateTime=$("#beginDate").val();
		var time=$("#endDate").val();*/
		/*window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&tourName="+tourName+"&tourCode="+tourCode+"&destination="+destination+"&dateTime="+dateTime+"&time="+time+"&degree="+degree;*/
		window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&tourName="+tourName;
	}
	function sear(valu){
		var degree=$("#degree").val();//标签 key Words
		var area=$("#area").val();//区域
		var tourName=$("#tourName").val();//年份及名称
		var nameB=$("#nameB").val();//读取方式是中文还是英文
		var lineNo=$("#lineNo").val();//B2B产品编号（1...50...）
		var remark=$("#remark").val();//天数
		var destinationList=$("#destinationList").val();//目的地
		var days,role="";
		if(valu=='t'){
			days=2;
		}else{
			days="";
			role="down";
		}
		window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&days="+days+"&role="+role+"&degree="+degree+"&tourName="+tourName+"&settlePrice="+nameB+"&destinationlist="+destinationList+"&lineNo="+lineNo+"&remark="+remark;
	}
	function searDes(valu){
		if(valu==$("#degree").val()){
			$("#degree").val("");
		}else{
			$("#degree").val(valu);
		}
		searchAll();
	}
	function searYear(valu){
		if(valu==$("#tourName").val()){
			$("#tourName").val("");
		}else{
			$("#tourName").val(valu);
		}
		var area=$("#area").val();
		var tourName=$("#tourName").val();
		/*var tourCode=$("#tourCode").val();
		var destination=$("#destination").val();
		var dateTime=$("#beginDate").val();
		var time=$("#endDate").val();*/
		var degree=$("#degree").val();
		/*window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&tourName="+tourName+"&tourCode="+tourCode+"&destination="+destination+"&dateTime="+dateTime+"&time="+time+"&degree="+degree;*/
		window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&degree="+degree+"&tourName="+tourName;
	}
	function searchAll(){
		var degree=$("#degree").val();//标签 key Words
		var area=$("#area").val();//区域
		var tourName=$("#tourName").val();//年份及名称
		/*var tourNames=$("#tourNames").val();//输入框名称
		if(tourNames!=null){
			if(tourNames.indexOf(""+tourName+"")>0){
				tourName=tourNames;
			}else{
				tourName=tourName+" "+tourNames;
			}
		}*/
		var nameB=$("#nameB").val();//读取方式是中文还是英文
		var lineNo=$("#lineNo").val();//B2B产品编号（1...50...）
		var remark=$("#remark").val();//天数
		var destinationList=$("#destinationList").val();//目的地
		window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&tourName="+tourName+"&degree="+degree+"&settlePrice="+nameB+"&destinationlist="+destinationList+"&lineNo="+lineNo+"&remark="+remark;
	}
	/*翻页功能*/
	function page(num){
		var degree=$("#degree").val();
		var area=$("#area").val();
		var start=0;
		if(num!=1){
			start=Number(Number(num-1)*100);
		}
		window.location.href="${base}/admin/peerUser/add.jhtml?area="+area+"&degree="+degree+"&start="+start+"&pageNumber="+num;
	}
	
	function tourinfo(a){
		id=$(a).next().val();
		window.location.href="${base}/admin/peerUser/groulineInfo.jhtml?id="+id;
		}
	function changeName(name){
	    $("#nameB").val(name); 
	    searchAll();
	}
</script>
</body>
</html>
