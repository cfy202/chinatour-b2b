[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
	 <style type="text/css" media="screen">
		.kalendae .k-days span.closed {
			background:red;
		}
	</style>
    <title>${message("admin.main.title")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Product</h2> 
            <a class="btn pull-right" href="javascript:history.go(-1)">
				<i class="fa fa-reply" title="Back"></i>
			</a>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Product</li>
            </ol>
        </div>
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="savePrice.jhtml" method="post">
              <input type="hidden" id="groupLineId" value="${groupLine.id}" class="form-control"/>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                	<input type="text" disabled="disabled" value="${groupLine.tourName}" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Arrival Date <span id="clearDate" class="fa fa-rotate-left" style="color:blue" title="Clear Date"></span>&nbsp;</label>
                <div class="col-sm-6">
                	<textarea id="dateStr" rows="3" style="width:100%;" disabled="disabled">${groupLine.departureDate}</textarea>
                	<!--<input type="text" name="departureDate" id="departureDate" class="form-control" required parsley-minlength="6" placeholder="可填写多个日期,以英文逗号隔开.如:2015-01-06,2015-01-18,..." />-->
                	<input type="text" id="beginningDate" class="form-control" name="symbol" required style="width:150px" placeholder="Beginning Date." />
    				<input type="text" id="endingDate" class="form-control" name="currencyEng" required style="width:150px; margin: -32px 0px 20px 200px;" placeholder="Ending Date." />
    				<!--
    				<p>
	    				<input type="checkbox" class="icheck" name="time" value="每天"/>每天
	    				<input type="checkbox" class="icheck" name="time" value="星期一"/>星期一
	                	<input type="checkbox" class="icheck" name="time" value="星期二"/>星期二
	                	<input type="checkbox" class="icheck" name="time" value="星期三"/>星期三
	                	<input type="checkbox" class="icheck" name="time" value="星期四"/>星期四
	                	<input type="checkbox" class="icheck" name="time" value="星期五"/>星期五
	                	<input type="checkbox" class="icheck" name="time" value="星期六"/>星期六
	                	<input type="checkbox" class="icheck" name="time" value="星期日"/>星期日
                	</p>
                	-->
                	<p>
	                	<input type="checkbox" class="icheck" name="time" value="e"/>每天
	    				<input type="checkbox" class="icheck" name="time" value="Monday"/>星期一
	                	<input type="checkbox" class="icheck" name="time" value="Tuesday"/>星期二
	                	<input type="checkbox" class="icheck" name="time" value="Wednesday"/>星期三
	                	<input type="checkbox" class="icheck" name="time" value="Thursday"/>星期四
	                	<input type="checkbox" class="icheck" name="time" value="Friday"/>星期五
	                	<input type="checkbox" class="icheck" name="time" value="Saturday"/>星期六
	                	<input type="checkbox" class="icheck" name="time" value="Sunday"/>星期日
                	</p>
                	
                </div>
              </div>
              <input type="hidden" id="size" value="${size}"/>
              [#list list as ageOfPrice]
              	 <div class="form-group">
	                <label class="col-sm-3 control-label">Currency Type</label>
	                <div class="col-sm-6">
	                	<input type="text" disabled="disabled" class="form-control" value="${ageOfPrice.currencyEng} (${ageOfPrice.currencyChs})"/>
	                	<input type="hidden" id="currencyId${ageOfPrice_index}" class="form-control" value="${ageOfPrice.currencyId}"/>
	                </div>
	              </div>
	              <div class="form-group">
	                <label class="col-sm-3 control-label"></label>
	                <div class="col-sm-6">
	                	<table>
	                		<tr>
	                			<td>Adult Price</td>
	                			<td>Children with Bed Price</td>
	                			<td>Children without Bed Price</td>
	                			<td>Children(2~5) Price</td>
	                			<td>Infant Price</td>
	                		</tr>
	                		<tr>
	                			<td><input type="text" id="adult${ageOfPrice_index}" class="form-control" value="${ageOfPrice.adult}"/></td>
	                			<td><input type="text" id="bed${ageOfPrice_index}" class="form-control" value="${ageOfPrice.bed}"/></td>
	                			<td><input type="text" id="noBed${ageOfPrice_index}" class="form-control" value="${ageOfPrice.notBed}"/></td>
	                			<td><input type="text" id="children${ageOfPrice_index}" class="form-control" value="${ageOfPrice.children}"/></td>
	                			<td><input type="text" id="baby${ageOfPrice_index}" class="form-control" value="${ageOfPrice.baby}"/></td>
	                		</tr>
	                		<tr>
	                			<td>Single Supplement</td>
	                			<td>Pre/Post Price</td>
	                			<td>Adult Commission</td>
	                			<td>Child Commission</td>
	                			<td></td>
	                		</tr>
	                		<tr>
	                			<td><input type="text" id="supplement${ageOfPrice_index}" class="form-control" value="${ageOfPrice.supplement}"/></td>
	                			<td><input type="text" id="hotelPrice${ageOfPrice_index}" class="form-control" value="${ageOfPrice.hotelPrice}"/></td>
	                			<td><input type="text" id="commission${ageOfPrice_index}" class="form-control" value="${ageOfPrice.commission}"/></td>
	                			<td><input type="text" id="childComm${ageOfPrice_index}" class="form-control" value="${ageOfPrice.childComm}"/></td>
	                			<td></td>
	                		</tr>
	                	</table>
	                </div>
	              </div>
              [/#list]
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="history.back()" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="button" class="btn btn-primary" onclick="price()" style="margin-left:206px;">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

</div>
[#include "/admin/include/foot.ftl"]
<script src="[@spring.url '/resources/js/date/kalendae.standalone.js'/]" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("#clearDate").click(function(){
			$("#dateStr").val(' ');
		});
		
		$("#beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
		$("#endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true, numberOfMonths: 1, minDate: 1 });
    });
    
    
	
     var picker = new Kalendae.Input('departureDate',{
			//attachTo:document.body,
			months:3,
			mode:'multiple',
			direction:'future',
			multipleDelimiter:',',
			format:'YYYY-MM-DD',
			titleFormat:'YYYY,MM',
		});
	function price(){
		var beginning=$("#beginningDate").val();
		var ending=$("#endingDate").val();
		if(beginning!="" && ending!=""){
			var size=$("#size").val();
			var allPrice;
			for(var a=0;a<size;a++){
				var currencyId=$("#currencyId"+a).val();
				var adult=$("#adult"+a).val();
				var bed=$("#bed"+a).val();
				var noBed=$("#noBed"+a).val();
				var children=$("#children"+a).val();
				var baby=$("#baby"+a).val();
				var supplement=$("#supplement"+a).val();
				var hotelPrice=$("#hotelPrice"+a).val();
				var commission=$("#commission"+a).val();
				var childComm=$("#childComm"+a).val();
				if(adult!=""&&bed!=""&&noBed!=""&&children!=""&&baby!=""&&supplement!=""&&hotelPrice!=""&&commission!=""&&childComm!=""){
					var price=currencyId+":"+adult+":"+bed+":"+noBed+":"+children+":"+baby+":"+supplement+":"+hotelPrice+":"+commission+":"+childComm;
					if(a==0){
						allPrice=price;
					}else{
						allPrice=allPrice+","+price;
					}
				}else{
					alert("The price can't be empty");
					return false;
				}
			}
			
			var arr=[];
			$("p :checkbox").each(function(){
				if($(this).is(':checked')){
				var data= $(this).val();
					 arr.push(data);
					
				}
			});
			var time = arr.toString();
			if($("#dateStr").val()==' '){
				$("#dateStr").val(1);
			}
			window.location.href="saveTime.jhtml?groupLineId="+$("#groupLineId").val()+"&Endtime="+ending+"&price="+allPrice+"&beginningDate="+beginning+"&time="+time+"&dateStr="+$("#dateStr").val();
		}else{
			alert("Beginning date and ending date cannot be empty!");
		}
	}
</script>
</body>
</html>
