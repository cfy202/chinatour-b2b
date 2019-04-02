<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Commisson</title>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
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
    	<img src="[@spring.url '/resources/images/newsForAgencyimages/logo.png'/]" width="213" height="60">
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
    	<img src="[@spring.url '/resources/images/newsForAgencyimagesbackground/phone.png'/]" width="15" height="15">
        <span>400-071-0197</span>
    </div>
    <div class="clear"></div>
</div>
<div class="mt1 nav">
	<div class="w1">
    	<ul class="nav_main">
        	<li><a href="/">Home</a></li>
            <li><a href="tours.html">Tours</a></li>
            <li><a href="mybook.html">My Booking</a></li>
            <li><a href="commission.html"  class="nav_current">Commission</a></li>
            <li><a href="about_us.html">About Us</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="w1">
	<div class="fl search_list">
    	<form action="" method="post" id="myinfo">
        	<input id="search_id" name="search_id" class="search_1" value="" placeholder="Booking NO.">
            <input id="search_id" name="search_id" class="search_1" value="" placeholder="Tour Code">
            <input id="search_id" name="search_id" class="search_2" value="" placeholder="Tour Name">
            <input id="search_id" name="search_id" class="search_3" value="" placeholder="From">
            <span>-</span>
            <input id="search_id" name="search_id" class="search_1" value="" placeholder="To">
            <input type="submit" class="search_sub" id="search_sub" value="Search">
        </form>
    </div>
    <div class="r1 print">
    	<a href=""><img src="[@spring.url '/resources/images/newsForAgencyimages/print.png'/]" width="18" height="17">&nbsp;<span>Print</span></a>
    </div>
    <div class="clear"></div>
    <div class="search_line"></div>
    <div class="search_tab">
    	<table cellpadding="0" cellspacing="0" width="100%">
        	<tr class="tr_1">
            	<th width="7%" align="center">#</th>
                <th width="17%">BOOKING NO.</th>
                <th width="38%">REMARKS</th>
                <th width="12%" align="center">AMOUNT</th>
                <th width="12%" align="center">PAID</th>
                <th width="12%" align="center">UNPAID</th>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td align="center">01</td>
                <td>#1001</td>
                <td class="tab_r">Yangtze Cruise & Tibet, 16 Days/06-23-2015</td>
                <td align="center">$1200</td>
                <td align="center">$1200</td>
                <td align="center">$0</td>
            </tr>
            <tr>
            	<td colspan="3" class="tab_t"><span class="total">Total:</span></td>
                <td align="center" class="tab_t">$1200</td>
                <td align="center" class="tab_t">$1200</td>
                <td align="center" class="tab_t">$0</td>
            </tr>
            
        </table>
    </div>
</div>
<div class="footer">
	<div class="w1">
    	<p>&copy; 2015 Copyright Intertrips. All Rights reserved.</p>
    </div>
</div>
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
