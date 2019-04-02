[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!doctype html>
<html lang="en">
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
<title>${message("admin.main.title")}</title>
[#include "/admin/peerUser/include/head.ftl"]
</head>

<body>
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="w1 mt1">
	<div class="fl left_main">
    	<div class="news_tit">
            <h2>LATEST NEWS</h2>
            <p class="title_s">LATEST FROM INTERTRIPS</p>
        </div>
        <div class="line_1"></div>
        <div class="news_main">
        	<ul class="news_choice" id="smallImages">
            </ul>
            <div class="r1 pagination_page" id="pageNumber">
            	<a title="上一页" style="cursor:pointer;"  class="page" id="prePage">&lt;Previous</a>
                <a style="cursor:pointer"  class="page_cur" id="first">1</a>
                <a class="page" style="cursor:pointer" id="second">2</a>
                <a title="下一页" style="cursor:pointer"  class="page" id="nextPage">Next></a>
                <input id="currentPageNumber" value="1" type="hidden">
                <input id="PageNumberCount" value="0" type="hidden">
            </div>
            <div class="clear"></div>
        </div>
        <div class="news_tit">
            <h2>COMPANY INFO</h2>
            <p class="title_s">LASTEST CONTACT DETAILS</p>
        </div>
        <div class="line_1"></div>
        <div class="news_main">
        	<ul class="comany_cont">
            	<li>
                	<p class="company_1">Los Angeles</p>
                    <p class="company_2"><span>Telephone:</span>   (626)-377-9888 (888)-736-4685</p>
                    <p class="company_2"><span>Address:</span>     680 Brea Canyon Road, Suite 268 Diamond Bar, CA 91789</p>
                    <p class="company_2"><span>Fax:</span>     	   (626)602-7786</p>
                </li>
                <li>
                	<p class="company_1">New York</p>
                    <p class="company_2"><span>Telephone:</span>   (718) 539-4800 (888) 486-9981</p>
                    <p class="company_2"><span>Address:</span>    New York Office 4006 Main St, Rm 3A Flushing, NY 11354</p>
                    <p class="company_2"><span>Fax:</span>     	   (718) 932-3814</p>
                </li>
                <li>
                	<p class="company_1">San Francisco</p>
                    <p class="company_2"><span>Telephone:</span>   (415) 876-7888 (866) 244-6287</p>
                    <p class="company_2"><span>Address:</span>    San Francisco Downtown Office918 Clement St, Suite 101San Francisco, CA 94118</p>
                    <p class="company_2"><span>Fax:</span>        (415) 294-9004</p>
                </li>
                <li>
                	<p class="company_1">Vancouver</p>
                    <p class="company_2"><span>Telephone:</span>   (604)800-6411 / 1(888)880-7718</p>
                    <p class="company_2"><span>Address:</span>    2380-4000 No.3 Road, Richmond, BC V6X 0J8</p>
                    <p class="company_2"><span>Fax:</span>        1(866)594-1370</p>
                </li>
                <li>
                	<p class="company_1">Vancouver</p>
                    <p class="company_2"><span>Telephone:</span>   (604)800-6411 / 1(888)880-7718</p>
                    <p class="company_2"><span>Address:</span>    2380-4000 No.3 Road, Richmond, BC V6X 0J8</p>
                    <p class="company_2"><span>Fax:</span>        1(866)594-1370</p>
                </li>
                
            </ul>
            <div class="clear"></div>
        </div>
    </div>
    <div class="right_main">
    </div>
    
    <div class="clear"></div>
</div>
<div class="footer">
	<div class="w1">
    	<p>&copy; 2015 Copyright Intertrips. All Rights reserved.</p>
    </div>
</div>
<script type="text/javascript" src="[@spring.url '/resources/peerUser/js/jquery-1.10.2.min.js'/]"></script>
<script  type="text/javascript">
var pageIndex = 1;
var pageCount = 0;
 $(document).ready(function () {
 	$.ajax({
        type: "GET",
        url:"${base}/news/getPageCount.jhtml",
        success: function(map) {
        	pageCount = map.pageCount;
        	if(pageCount<=2){
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 	}
        }
        });
 	$("#prePage").hide();
 	imageForPage(1);
 });
    //图片分页
   

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
    
    $(function(){
        var $div_li =$(".news_choice li");
        $div_li.mouseover(function(){
            $(this).addClass("news_current")            //当前<li>元素高亮
                   .siblings().removeClass("news_current");  //去掉其它同辈<li>元素的高亮
            var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
            $(".right_main > div")       //选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
                    .eq(index).show()   //显示 <li>元素对应的<div>元素
                    .siblings().hide(); //隐藏其它几个同辈的<div>元素
        })
    });
    
    $("#pageNumber").find("a").not(":first").not(":last").each(function(){
    	$(this).click(function(){
    		$(this).addClass("page_cur").removeClass("page");
    		$(this).siblings().addClass("page").removeClass("page_cur");
    		startPage = $(this).html();
    		pageIndex = startPage;
    		imageForPage(startPage);
    		if(pageIndex>1){
    			$("#prePage").show();
    		}else{
    			$("#prePage").hide();
    		};
    		if(pageCount==pageIndex){
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 	};
    	});
    });
	 
	 //点击下一页
	 $("#nextPage").click(function(){
	 	pageIndex  = parseInt(pageIndex);
	 	pageIndex++;
	 	first = parseInt($("#first").html());
	 	first++;
	 	second = parseInt($("#second").html());
	 	second++;
	 	$("#first").html(first);
	 	$("#second").html(second);
	 	$(".page").not(":first").not(":last").each(function(){
	 		if($(this).html()==pageIndex){
	 			$(this).siblings().addClass("page").removeClass("page_cur");
	 			$(this).addClass("page_cur").removeClass("page");
	 		}
	 	});
	 	if(pageIndex>1){
    			$("#prePage").show();
    		}else{
    			$("#prePage").hide();
    		};
    	if(pageCount==pageIndex){
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 	};
		 if(pageIndex==2&&$("#first").is(":hidden")){
		 		$("#first").show();
		 }
	 	imageForPage(pageIndex);
	 });
	 
	 //点击上一页
	 $("#prePage").click(function(){
	 	pageIndex  = parseInt(pageIndex);
	 	pageIndex--;
	 	first = parseInt($("#first").html());
	 	first--;
	 	second = parseInt($("#second").html());
	 	second--;
	 	$("#first").html(first);
	 	$("#second").html(second);
	 	$(".page").not(":first").not(":last").each(function(){
	 		if($(this).html()==pageIndex){
	 			$(this).siblings().addClass("page").removeClass("page_cur");
	 			$(this).addClass("page_cur").removeClass("page");
	 		}
	 	});
	 	if(pageIndex>1){
    			$("#prePage").show();
    		}else{
    			$("#prePage").hide();
    		};
    	if(pageCount==pageIndex){
		 		$("#nextPage").hide();
		 	}else{
		 		$("#nextPage").show();
		 	};
		 if($("#second").html()==1&&pageIndex==1){
		 	$("#first").hide();
		 }else{
		 	$("#first").show();
		 }
	 	imageForPage(pageIndex);
	 });
	 
	 //获取总页数
	 function getPageCount(){
	 	$.ajax({
                type: "GET",
                url:"${base}/news/getPageCount.jhtml",
                success: function(map) {
                	pageCount = map.pageCount;
                }
                });
	 };
	 
	 //绑定数据
	  function imageForPage(startPage){
		$.ajax({
                type: "GET",
                url:"${base}/news/imageForPage.jhtml?startPage="+startPage,
                success: function(map) {
							$("#smallImages").html("");
							$(".right_main").html("");
							var str1  = "";
							var str2 = "";
							$.each(map.newsList,function(index,news){
									str1 += '<li style="padding:0px; margin-top:10px;">'+
					                		'<a href="javascript:;">'+
					                        '<div class="news_img" style="margin-right:0px;">'+
					                            '<img class="smallImage" src="${base}'+news.image+'" width="100" height="70">'+
					                        '</div>'+
					                        '<div class="news_title_1" style="float:right">'+
					                            '<p  class="news_title_p">'+news.title+'</p>'+
					                            '<p>'+
					                                '<span class="news_s1">Travel</span>'+
					                                '<span class="news_s1">Jul 6, 2015</span>'+
					                            '</p>'+
					                        '</div>'+
					                    '</a>'+
					                '</li>';
					                
								                str2+= '<div class="r1 right_box"';
								                if(index!=0){
								                	str2+='style="display:none;"';
								                }
					                			str2+='>'+
									            '<div class="news_banner">'+
									                '<img id="bigImage" src="${base}'+news.image+'" width="730" height="414">'+
									            '</div>'+
									            '<div class="clear"></div>'+
									            '<div class="news_contant">'+
									                '<h1>'+news.title+'</h1>'+
									                '<p class="fa news_time">'+
									                    '<i></i>Jun 16, 2015'+
									                '</p>'+
									                '<div class="news_line"></div>'+
									                '<p class="news_p">'+news.content+'</p>'+
									            '</div>'+
									        '</div>';
								});
						$("#smallImages").append(str1);
						$(".right_main").append(str2);
						 $(function(){
							        var $div_li =$(".news_choice li");
							        $div_li.click(function(){
							            $(this).addClass("news_current")            //当前<li>元素高亮
							                   .siblings().removeClass("news_current");  //去掉其它同辈<li>元素的高亮
							            var index =  $div_li.index(this);  // 获取当前点击的<li>元素 在 全部li元素中的索引。
							            $(".right_main > div")       //选取子节点。不选取子节点的话，会引起错误。如果里面还有div 
							                    .eq(index).show()   //显示 <li>元素对应的<div>元素
							                    .siblings().hide(); //隐藏其它几个同辈的<div>元素
							        })
    });
					}
				});
	};
	
</script>
</body>
</html>
