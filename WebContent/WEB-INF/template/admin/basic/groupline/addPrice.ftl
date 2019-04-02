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
              <input type="hidden" name="groupLineId" value="${groupLine.id}" class="form-control"/>
              <div class="form-group">
                <label class="col-sm-3 control-label">Product Name</label>
                <div class="col-sm-6">
                	<input type="text" disabled="disabled" value="${groupLine.tourName}" class="form-control"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Arrival Date</label>
                <div class="col-sm-6">
                	<textarea rows="3" style="width:100%;" disabled="disabled">${groupLine.departureDate}</textarea>
                	<input type="hidden" name="currencyChs" value="${groupLine.departureDate}"/>
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-3 control-label">Currency</label>
                <div class="col-sm-6">
                	<select type="text" name="currencyId" class="select2" onchange="currencyChange()">
              			[#list currencyList as currency]
	                      <option value="${currency.id}" [#if "${currency.id==ageOfPrice.currencyId}"] selected="selected" [/#if]> ${currency.currencyEng} (${currency.currencyChs})</option>
	                    [/#list]
	                </select>
                </div>
              </div>
             <div class="form-group">
                <label class="col-sm-3 control-label">Adult Price</label>
                <div class="col-sm-6">
                	<input type="text" name="adult" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Children with Bed Price</label>
                <div class="col-sm-6">
                	<input type="text" name="bed" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Children without Bed Price</label>
                <div class="col-sm-6">
                	<input type="text" name="notBed" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group" style="display:none">
                <label class="col-sm-3 control-label">Children(2~5) Price:</label>
                <div class="col-sm-6">
                	<input type="text" name="children" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Infant Price</label>
                <div class="col-sm-6">
                	<input type="text" name="baby" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Single Supplement</label>
                <div class="col-sm-6">
                	<input type="text" name="supplement" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Pre/Post Price</label>
                <div class="col-sm-6">
                	<input type="text" name="hotelPrice" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Adult Commission</label>
                <div class="col-sm-6">
                	<input type="text" name="commission" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Child Commission</label>
                <div class="col-sm-6">
                	<input type="text" name="childComm" class="form-control" value="0"/>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
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
	
	function currencyChange(){
		$.ajax({
    		url:'selectCurrency.jhtml',
    		data:'currencyId='+$("select[name='currencyId']").val()+'&groupLineId='+$("input[name='groupLineId']").val(),
    		type:'POST',
    		beforeSend:function(){},
    		success:function(data){
    			if(data.ageOfPrice!=null){
    				$("input[name='adult']").val(data.ageOfPrice.adult);
    				$("input[name='bed']").val(data.ageOfPrice.bed);
    				$("input[name='notBed']").val(data.ageOfPrice.notBed);
    				$("input[name='children']").val(data.ageOfPrice.children);
    				$("input[name='supplement']").val(data.ageOfPrice.supplement);
    				$("input[name='hotelPrice']").val(data.ageOfPrice.hotelPrice);
    				$("input[name='commission']").val(data.ageOfPrice.commission);
    				$("input[name='childComm']").val(data.ageOfPrice.childComm);
    			}else{
    				$("input[name='adult']").val(0);
    				$("input[name='bed']").val(0);
    				$("input[name='notBed']").val(0);
    				$("input[name='children']").val(0);
    				$("input[name='supplement']").val(0);
    				$("input[name='hotelPrice']").val(0);
    				$("input[name='commission']").val(0);
    				$("input[name='childComm']").val(0);
    			}
    		}
    	})
	
	}
</script>
</body>
</html>
