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
    		<h2 class="fl">${groupLine.tourName}</h2>
            <div class="r1 tours_line_icon" style="display:none">
            	<span class="tours_line_icon_1"></span>
                <span class="tours_line_icon_2"></span>
                <span class="tours_line_icon_3"></span>
                <span class="tours_line_icon_4"></span>
            </div>
            <div class="clear"></div>
        </div>
        <div class="tours_line_fenge"></div>
        <div class="tm">
        	[#list groupRouteList as groupRoute]
	            <div class="tours_line_main">
	                <div class="tours_line_main_left fl">
	                    <span class="tours_line_date">第${groupRoute.dayNum}天</span>
	                </div>
	                <div class="tours_line_main_right fl">
	                    <p class="tours_line_name">${groupRoute.routeName}</p>
	                    <div class="tours_line_box">
	                        <p><!--span style="color:#fa7546;">参考航班号</span-->${groupRoute.routeDescribeForEn}</p>
	                    </div>
	                    <p style="margin-top:15px;"><span style="color:#2771bb; ">酒店:</span>[#list groupLineHotelRelList as groupLineHotelRel][#if groupRoute.dayNum==groupLineHotelRel.dayNum]${groupLineHotelRel.hotel.hotelName}[/#if][/#list]</p>
	                    <!--<p style="margin-top:15px;"><span style="color:#2771bb;">用餐:</span>  无 </p>
	                    <p style="margin-top:15px;"><span style="color:#2771bb;">交通:</span>  飞机 汽车 </p>-->
	                </div>
	                <div class="clear"></div>
            	</div>
             [/#list]
            <!--div class="tours_line_main">
                <div class="tours_line_main_left fl">
                    <span class="tours_line_date">第2天</span>
                </div>
                <div class="tours_line_main_right fl">
                    <p class="tours_line_name">家园 / 首尔 / 夏威夷</p>
                    <div class="tours_line_box">
                        <p><span style="color:#fa7546;">参考航班号</span>（非最终确认航班，以出团通知为准）:KE808 12:40/16：50  KE053  21:00/10:20
    搭乘5星大韩航空飞往首尔，接着飞往热情洋溢的太平洋的中心HONOLULU，导游将在机场“行李提取处”等候您的到来，接下来将您送往酒店休息。夏威夷群岛是由火山爆发形成的，包括8个大岛和124个小岛，绵延2450千米，形成新月形岛链。其中，欧胡岛是夏威夷群岛中最多彩多姿的岛屿，你可以充分自由活动，探索这个太平洋最让人向往的岛屿。在这个轻松悠闲氛围中，您即可以漫步海边，享受海风的轻抚海水的轻拍，也可以在商业街里选购自己喜欢的工艺品小饰品。美景，美食，美人都在您的身边，让我们尽情放松，感受夏威夷的热情。此日晚餐请自理以便您能更好的安排自己的时间。</p>
                    </div>
                    <p style="margin-top:15px;"><span style="color:#2771bb; ">酒店:</span>  Ambassador Hotel或同级 </p>
                    <p style="margin-top:15px;"><span style="color:#2771bb;">用餐:</span>  无 </p>
                    <p style="margin-top:15px;"><span style="color:#2771bb;">交通:</span>  飞机 汽车 </p>
                </div>
                <div class="clear"></div>
            
            </div>
            <div class="tours_line_main">
                <div class="tours_line_main_left fl">
                    <span class="tours_line_date">第3天</span>
                </div>
                <div class="tours_line_main_right fl">
                    <p class="tours_line_name">家园 / 首尔 / 夏威夷</p>
                    <div class="tours_line_box">
                        <p><span style="color:#fa7546;">参考航班号</span>（非最终确认航班，以出团通知为准）:KE808 12:40/16：50  KE053  21:00/10:20
    搭乘5星大韩航空飞往首尔，接着飞往热情洋溢的太平洋的中心HONOLULU，导游将在机场“行李提取处”等候您的到来，接下来将您送往酒店休息。夏威夷群岛是由火山爆发形成的，包括8个大岛和124个小岛，绵延2450千米，形成新月形岛链。其中，欧胡岛是夏威夷群岛中最多彩多姿的岛屿，你可以充分自由活动，探索这个太平洋最让人向往的岛屿。在这个轻松悠闲氛围中，您即可以漫步海边，享受海风的轻抚海水的轻拍，也可以在商业街里选购自己喜欢的工艺品小饰品。美景，美食，美人都在您的身边，让我们尽情放松，感受夏威夷的热情。此日晚餐请自理以便您能更好的安排自己的时间。</p>
                    </div>
                    <p style="margin-top:15px;"><span style="color:#2771bb; ">酒店:</span>  Ambassador Hotel或同级 </p>
                    <p style="margin-top:15px;"><span style="color:#2771bb;">用餐:</span>  无 </p>
                    <p style="margin-top:15px;"><span style="color:#2771bb;">交通:</span>  飞机 汽车 </p>
                </div>
                <div class="clear"></div>
            
            </div>
            <div class="tours_line_main">
                <div class="tours_line_main_left fl">
                    <span class="tours_line_date">第4天</span>
                </div>
                <div class="tours_line_main_right fl">
                    <p class="tours_line_name">家园 / 首尔 / 夏威夷</p>
                    <div class="tours_line_box">
                        <p><span style="color:#fa7546;">参考航班号</span>（非最终确认航班，以出团通知为准）:KE808 12:40/16：50  KE053  21:00/10:20
    搭乘5星大韩航空飞往首尔，接着飞往热情洋溢的太平洋的中心HONOLULU，导游将在机场“行李提取处”等候您的到来，接下来将您送往酒店休息。夏威夷群岛是由火山爆发形成的，包括8个大岛和124个小岛，绵延2450千米，形成新月形岛链。其中，欧胡岛是夏威夷群岛中最多彩多姿的岛屿，你可以充分自由活动，探索这个太平洋最让人向往的岛屿。在这个轻松悠闲氛围中，您即可以漫步海边，享受海风的轻抚海水的轻拍，也可以在商业街里选购自己喜欢的工艺品小饰品。美景，美食，美人都在您的身边，让我们尽情放松，感受夏威夷的热情。此日晚餐请自理以便您能更好的安排自己的时间。</p>
                    </div>
                    <p style="margin-top:15px;"><span style="color:#2771bb; ">酒店:</span>  Ambassador Hotel或同级 </p>
                    <p style="margin-top:15px;"><span style="color:#2771bb;">用餐:</span>  无 </p>
                    <p style="margin-top:15px;"><span style="color:#2771bb;">交通:</span>  飞机 汽车 </p>
                </div>
                <div class="clear"></div>
            </div-->
        </div>
        <div class="tours_line_fenge"></div>
        <div class="tours_line_Notes">
        	<h2><span class="tours_line_Notes_icon"><i></i>注意事项</span></h2>
            <div class="tours_line_Notes_main">
            	${groupLine.specificItems}
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
