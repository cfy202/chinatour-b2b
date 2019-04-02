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
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Setting</h2>
            <div class="new"><button class="btn btn-primary btn-flat md-trigger" type="button" id="New" data-modal="form-primary">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
               	<li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Currency</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
        <div class="block-flat">
          <div class="header">							
            <h3>${currencyType.currencyChs}&nbsp;${currencyType.currencyEng}&nbsp;${currencyType.symbol}</h3>
            <input name="id" value="${currencyType.id}" type="hidden">
          </div>
          <div class="content">
            
            <table id="datatables" class="display" cellspacing="0" width="100%">
		        <thead>
		            <tr>
		                <th>Chinese</th>
		                <th>Abbr</th>
		                <th>Symbol</th>
		                <th>Exchange Rate</th>
		                <th>USD Rate</th>
		                <th>Action</th>
		            </tr>
		        </thead>
		        <tbody>
		        [#list currencyTypeList as currencyTypes]
		        	[#list rateOfCurrencyList as rateOfCurrency]
			        	[#if currencyTypes.id == rateOfCurrency.toCurrencyId]
			        	<tr>
			                <td>${currencyTypes.currencyChs}</td>
			                <td>${currencyTypes.currencyEng}</td>
			                <td>${currencyTypes.symbol}</td>
			                <td>
			                	${rateOfCurrency.rateUp} &nbsp;/&nbsp;${rateOfCurrency.rateDown}
			                </td>
			                <td>
			                	${rateOfCurrency.usRate}
			                </td>
			                <td>
			                	<i class="fa fa-pencil"></i><a href="editRate.jhtml?id=${rateOfCurrency.id}">Edit</a>
			                </td>
			            </tr>
			            [/#if]
		            [/#list]
		        [/#list]
		        </tbody>
		     </table>
            
          </div>
        </div>
      </div>
    </div>
</div>

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Set Rate</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form action="saveRate.jhtml" style="border-radius: 0px;" method="post">
	      <div class="modal-body form">
	      	<div class="form-group">
	          <label>Currency</label> 
	          <select id="selDept" class="select2" disabled>
					<option value="">Select</option>
					[#list currencyTypeList as currencyTypes]
						<option value="${currencyTypes.id}" [#if currencyTypes.id==(currencyType.id)] selected="selected"[/#if]>${currencyTypes.currencyChs}</option>
					[/#list]
			 </select>
			 <input type="hidden" name="currencyId" value="${currencyType.id}">
	        </div>
	        <div class="form-group">
	          <label>Currency Conversion</label> 
	          <select id="selDept" name="toCurrencyId" class="select2" >
					<option value="">Select</option>
					[#list currencyTypeList as currencyType]
						<option value="${currencyType.id}">${currencyType.currencyChs}</option>
					[/#list]
			 </select>
	        </div>
	        <div class="row">
	          <div class="form-group col-md-12 no-margin">
	            <label>Rate:</label>
	          </div>
	        </div>
	        <div class="row no-margin-y">
	          <div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
	            <input type="text" name="rateUp" class="form-control" placeholder="rateUp">
	          </div>
	          <div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
	            <input type="text" name="rateDown" class="form-control" placeholder="rateDown">
	          </div>
	          <div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">
	            <input type="text" name="usRate" class="form-control" placeholder="USD Rate">
	          </div>
	        </div>
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
	        <button type="submit" class="btn btn-primary btn-flat md-close" data-dismiss="modal">Save</button>
	      </div>
	    </div>
    </form>
</div>
<div class="md-overlay"></div>

[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $('.md-trigger').modalEffects();
        [@flash_message /]
       var oTable = $('#datatables').DataTable({
            "processing": true,
            "filter": false
        });
       
        /*
       $('button').click( function() {
	       var data = oTable.$('input, select').serialize();
	        alert(
	            "The following data would have been submitted to the server: \n\n"+
	            data
	        );
	        return false;
	        
	        $('form').submit();
	    } );
    	*/
    	
    });
</script>
</html>
