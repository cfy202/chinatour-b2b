[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!doctype html>
<html lang="en">
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
<title>${message("admin.main.title")}</title>
<link href="http://fonts.googleapis.com/css?family=Roboto|PT Sans" rel="stylesheet" type="text/css" />
<link href="[@spring.url '/resources/css/indexForAgency/public.css'/]" rel="stylesheet" type="text/css" />
<link href="[@spring.url '/resources/css/indexForAgency/style.css'/]" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="top">
	<div class="top_main">
    	<ul class="top_login">
        	<li>
            	<a href="">Login</a>
            </li>
            <li>|</li>
            <li>
            	<a href="">Logout</a>
            </li>
        </ul>
        <ul class="top_login" id="top_login_2" style="display:none;">
        	<li>Welcome, CCC</li>
        	<li>
            	<a href="">My Account</a>
            </li>
            <li>|</li>
            <li>
            	<a href="">Logout</a>
            </li>
        </ul>
        <ul class="top_language">
        	<li>
            	<a href="">English</a>
            </li>
            <li>|</li>
            <li>
            	<a href="">中文</a>
            </li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="w1 mt1">
	<div class="logo">
    	<img src="[@spring.url '/resources/images/newsForAgency/logo.png'/]" width="213" height="60">
    </div>
    <div class="fl search">
        <div class="fl" style="position:relative;" >
            <div class="from_choice" tabindex="1" >
            	<span>Brand</span>
                <ul class="brand_op" style="display:none;">                                                          
                    <li><a href="javascript:;">China Tour</a></li>
                    <li><a href="javascript:;">Intertrips</a></li>
                    <li><a href="javascript:;">中国美</a></li>
                    <li><a href="javascript:;">文景假期</a></li>
                    <div class="clear"></div>
                </ul>
                <div class="clear"></div>
            </div>
            
        </div>
        <div class="fl" style="position:relative;" onmouseover="isOut=false" onmouseout="isOut=true">
			<input type="text" name="keyword" id="keywords" placeholder="Product Name / Code" class="search_input" autocomplete="off">
		</div>
        <div class="clear"></div>
        <div class="submit">
              <input type="submit" value="Search">
        </div>
    </div>
    <div class="fl tel">
    	<img src="[@spring.url '/resources/images/newsForAgency/background/phone.png'/]" width="15" height="15">
        <span>400-071-0197</span>
    </div>
    <div class="clear"></div>
</div>
<div class="mt1 nav">
	<div class="w1">
    	<ul class="nav_main">
        	<li><a href="/" class="nav_current">Home</a></li>
            <li><a href="tours.html">Tours</a></li>
            <li><a href="mybook.html">My Booking</a></li>
            <li><a href="commission.html">Commission</a></li>
            <li><a href="about_us.html">About Us</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
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
                	<p class="company_1">LA HEADQUARTER</p>
                    <p class="company_2"><span>Telephone:</span>   +1 888-410-4111</p>
                    <p class="company_2"><span>Address:</span>    680 Brea Canyon Road, Suite 268, Diamond  Bar, CA 9</p>
                </li>
                <li>
                	<p class="company_1">LA HEADQUARTER</p>
                    <p class="company_2"><span>Telephone:</span>   +1 888-410-4111</p>
                    <p class="company_2"><span>Address:</span>    680 Brea Canyon Road, Suite 268, Diamond  Bar, CA 9</p>
                </li>
                <li>
                	<p class="company_1">LA HEADQUARTER</p>
                    <p class="company_2"><span>Telephone:</span>   +1 888-410-4111</p>
                    <p class="company_2"><span>Address:</span>    680 Brea Canyon Road, Suite 268, Diamond  Bar, CA 9</p>
                </li>
                <li>
                	<p class="company_1">LA HEADQUARTER</p>
                    <p class="company_2"><span>Telephone:</span>   +1 888-410-4111</p>
                    <p class="company_2"><span>Address:</span>    680 Brea Canyon Road, Suite 268, Diamond  Bar, CA 9</p>
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
[#include "/admin/include/foot.ftl"]
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
									str1 += '<li>'+
					                		'<a href="javascript:;">'+
					                        '<div class="news_img">'+
					                            '<img class="smallImage" src="${base}'+news.image+'" width="100" height="70">'+
					                        '</div>'+
					                        '<div class="news_title_1">'+
					                            '<p  class="news_title_p">'+news.title+'</p>'+
					                            '<p>'+
					                                '<span class="news_s1">Travel</span>'+
					                                '<span class="news_s1">April 23, 2015</span>'+
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
									                    '<i></i>January 9, 2015'+
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
