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
		th{
			background:#f1f1f1;
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
            <h2>Flight List</h2>
            <div class="new"><button class="btn btn-success" type="button" id="printFlightWithCus">&nbsp;&nbsp;Print &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li class="active"><a href="#">Tour</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
                          <div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-caret-square-o-down fa-lg color-blue"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="margin:10px; padding:5px 0;">
								<div  class="nav-panel">
								<form action="flightListForAjax.jhtml" id="formId" method="POST">
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Arrival Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" name="beginningDate" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" name="endingDate" id="search_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">入境/出境</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<select name="outOrEnter" id="type" style="width:60px;height:20px;font-size:12px;" >
														<option value="1">入境</option>
														<option value="2">出境</option>
													</select>
												</div>
											</div>
										</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
												
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" name="tourCode" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_op" value="${userName}" placeholder="op..."  readonly="readonly"/>
												</div>
											</div>
									</div>
								</form>
									<div  class="nav-panel">
										<div class="btn-cont">
											<input class="submit-btn"  type="submit" id="subId" value="Search">
										</div>
									</div>
							</div>
						</div>
						</div>
          <div class="content" style="margin-top:30px;">
             <table cellspacing="0" cellpadding="0" border="0">
				<thead>
					<tr>
						<th width="10%" style="font-size:14px;font-weight:bold;">TourCode</th>
						<th id="arriveDate" width="10%" style="font-size:14px;font-weight:bold;">Arrival Date</th>
						<th width="8%" style="font-size:14px;font-weight:bold;">FLT #</th>
						<th width="8%" style="font-size:14px;font-weight:bold;">ETA</th>
						<th width="8%" style="font-size:14px;font-weight:bold;">#PAX</th>
						<th width="8%" style="font-size:14px;font-weight:bold;">Remark</th>
						<th width="10%" style="font-size:14px;font-weight:bold;">Last Name</th>
						<th width="10%" style="font-size:14px;font-weight:bold;">First Name</th>
						<th width="10%" style="font-size:14px;font-weight:bold;">Middle Name</th>
					</tr>
				</thead>
				<tbody id="tableContent">
					[#list flightWithCustomersList as flightWithCustomers]
						[#if flightWithCustomers.customerFlight.outOrEnter==1]
							[#list flightWithCustomers.customerList as customer]
							<tr>
								<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.tourCode}[/#if]</td>
								<td>
									[#if (customer_index==0) && (flightWithCustomers.customerFlight.arriveDate)??]
										${flightWithCustomers.customerFlight.arriveDate?string('yyyy-MM-dd')}
									[/#if]
								</td>
								<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.flightCode}  ${flightWithCustomers.customerFlight.flightNumber}[/#if]</td>
								<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.arriveTime}[/#if]</td>
								<td>[#if (customer_index==0)]${flightWithCustomers.customerSize}[/#if]</td>
								<td>[#if (customer_index==0)]${flightWithCustomers.customerFlight.remark}[/#if]</td>
								<td>${customer.lastName}</td>
								<td>${customer.firstName}</td>
								<td>${customer.middleName}</td>
							</tr>
							[/#list]
						[/#if]
					[/#list]
				</tbody>
			</table>
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
    	$("#search_op").attr("readonly","readonly");
    	$("#arriveDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
    	
    	 $("div.options").hide();
    	$("#departureDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
   		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-caret-square-o-up fa-lg color-blue"){
				_slide.removeClass("fa fa-caret-square-o-up fa-lg color-blue").addClass("fa fa-caret-square-o-down fa-lg color-blue");
			}else{
				_slide.removeClass("fa fa-caret-square-o-down fa-lg color-blue").addClass("fa fa-caret-square-o-up fa-lg color-blue");
			}
		});
    
    });
   $("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
  $("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
  
  $("#subId").click(function(){
  	$.ajax({
         type: "POST",
         url:"flightListForAjax.jhtml",
         data:$('#formId').serialize(),
         success: function(map) {
         if(map.flag==1){
			$("#arriveDate").html("Arrival Date");         
         }else{
         	$("#arriveDate").html("Departure Date");
         }
          	$("#tableContent").html("");
          		str="";
          		$.each(map.fcListForAjax,function(index,flightWithCustomers){
          			$.each(flightWithCustomers.customerList,function(ind,customer){
          				tourCode = "";
          				arriveDate="";
          				fltCode="";
          				arriveTime="";
          				size="";
          				remark="";
          				if(ind==0){
          					tourCode = flightWithCustomers.customerFlight.tourCode;
	          				arriveDate = flightWithCustomers.customerFlight.arriveDateStr;
	          				fltCode = flightWithCustomers.customerFlight.flightCode+' '+flightWithCustomers.customerFlight.flightNumber;
	          				arriveTime = flightWithCustomers.customerFlight.arriveTime;
	          				size = flightWithCustomers.customerSize;
	          				remark = flightWithCustomers.customerFlight.remark==null?"":flightWithCustomers.customerFlight.remark;
          				};
          				str+='<tr>'+
          						'<td>'+tourCode+'</td>'+
          						'<td>'+arriveDate+'</td>'+
          						'<td>'+fltCode+'</td>'+
          						'<td>'+arriveTime+'</td>'+
          						'<td>'+size+'</td>'+
          						'<td>'+remark+'</td>'+
          						'<td>'+customer.lastName+'</td>'+
          						'<td>'+customer.firstName+'</td>'+
          						'<td>'+customer.middleName+'</td>'+
          					'</tr>';
          			});
          		});
          		$("#tableContent").append(str);
          }
            });
  });
  
  $("#printFlightWithCus").click(function(){
  		$("#formId").attr("action","printFlightWithCus.jhtml");
  		$("#formId").submit();
  });
</script>
</body>
</html>
