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
	                <label class="col-sm-3 control-label">Currency Type</label>
	                <div class="col-sm-6">
	                	[#list currencyList as currency]
	                	<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" id="currencyTypeId" name="currencyTypeId" value="${currency.currencyTypeId}" style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper" onclick="updateTime('${currency.id}')"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							${currency.currencyEng} (${currency.currencyChs})
						</label>
              			[/#list]
	                </div>
	              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                	<input type="text" disabled="disabled" value="${groupLine.tourName}" class="form-control"/>
                </div>
              </div>
              [#list list as ageOfPrice]
              <div id="div${ageOfPrice_index}" style="display:none">
              	<div class="form-group">
	                <label class="col-sm-3 control-label">Currency Type</label>
	                <div class="col-sm-6">
	                	<input type="text" disabled="disabled" class="form-control" value="${ageOfPrice.currencyEng} (${ageOfPrice.currencyChs})"/>
	                </div>
	            </div>
              	<div class="form-group">
	               <label class="col-sm-3 control-label">Arrival Date</label>
	               <div class="col-sm-6">
	               		<label class="radio-inline">
							<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
								<input class="icheck" type="radio" name="checkTime" value="${ageOfPrice_index}" style="position: absolute; opacity: 0;">
									<ins class="iCheck-helper"
										style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;">
									</ins>
							</div>
							${ageOfPrice.maxTime?string('yyyy-MM-dd')}—${ageOfPrice.minTime?string('yyyy-MM-dd')}
						</label>
	               		<input type="hidden" id="timeInput${ageOfPrice_index}" value="${ageOfPrice.maxTime?string('yyyy-MM-dd')},${ageOfPrice.minTime?string('yyyy-MM-dd')}">
	               		<input type="hidden" id="updateCurrency${ageOfPrice_index}" value="${ageOfPrice.currencyId}">
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
	                			<!--td>Children(2~5) Price</td-->
	                			<td>Infant Price</td>
	                		</tr>
	                		<tr>
	                			<td>
	                				<input type="hidden" id="children${ageOfPrice_index}" class="form-control" value="${ageOfPrice.children}"/>
	                				<input type="text" id="adult${ageOfPrice_index}" class="form-control" value="${ageOfPrice.adult}"/>
	                			</td>
	                			<td><input type="text" id="bed${ageOfPrice_index}" class="form-control" value="${ageOfPrice.bed}"/></td>
	                			<td><input type="text" id="noBed${ageOfPrice_index}" class="form-control" value="${ageOfPrice.notBed}"/></td>
	                			<!--td><input type="text" id="children${ageOfPrice_index}" class="form-control" value="${ageOfPrice.children}"/></td-->
	                			<td><input type="text" id="baby${ageOfPrice_index}" class="form-control" value="${ageOfPrice.baby}"/></td>
	                		</tr>
	                		<tr>
	                			<td>Single Supplement</td>
	                			<td>Pre/Post Price</td>
	                			<td>Adult Commission</td>
	                			<td>Child Commission</td>
	                		</tr>
	                		<tr>
	                			<td><input type="text" id="supplement${ageOfPrice_index}" class="form-control" value="${ageOfPrice.supplement}"/></td>
	                			<td><input type="text" id="hotelPrice${ageOfPrice_index}" class="form-control" value="${ageOfPrice.hotelPrice}"/></td>
	                			<td><input type="text" id="commission${ageOfPrice_index}" class="form-control" value="${ageOfPrice.commission}"/></td>
	                			<td><input type="text" id="childComm${ageOfPrice_index}" class="form-control" value="${ageOfPrice.childComm}"/></td>
	                		</tr>
	                	</table>
	                </div>
	              </div>
	             </div>
              [/#list]
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
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
	function updateTime(currencyId){
		for(var a=0;a<8;a++){
			var id=$("#updateCurrency"+a).val();
			if(currencyId==id){
				$("#div"+a).show();
			}else{
				$("#div"+a).hide();
			}
		}
	}
	function price(){
		var num=$('input[name="checkTime"]:checked').val();
		if(typeof(num)!="undefined"){
			var time=$("#timeInput"+num).val();
			var currencyId=$("#updateCurrency"+num).val();
			var adult=$("#adult"+num).val();
			var bed=$("#bed"+num).val();
			var noBed=$("#noBed"+num).val();
			var children=$("#children"+num).val();
			var baby=$("#baby"+num).val();
			var supplement=$("#supplement"+num).val();
			var hotelPrice=$("#hotelPrice"+num).val();
			var commission=$("#commission"+num).val();
			var childComm=$("#childComm"+num).val();
			if(adult!=""&&bed!=""&&noBed!=""&&children!=""&&baby!=""&&supplement!=""&&hotelPrice!=""&&commission!=""&&childComm!=""){
				var price=currencyId+":"+adult+":"+bed+":"+noBed+":"+children+":"+baby+":"+supplement+":"+hotelPrice+":"+commission+":"+childComm;
			}else{
				alert("The price can't be empty");
				return false;
			}
			window.location.href="updatePrice.jhtml?groupLineId="+$("#groupLineId").val()+"&time="+time+"&price="+price;
		}else{
			alert("Please choice Departure Date");
		}
	}
</script>
</body>
</html>
