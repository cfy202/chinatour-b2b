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
            <h2>Flight List</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New">&nbsp;&nbsp;Export &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
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
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Flight</span>:
										</div>
										<div  class="block-body default-4-line">
											<div  class="params-cont"> 
												<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
													<span  class="unchecked"  name="flightSpan" checked="false" onclick="change(this,1);">Arrival</span> 
												</a>
												<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
													<span  class="unchecked" name="flightSpan" checked="false" onclick="change(this,2);" >Departure</span> 
												</a> 
												<input type="hidden" id="flightSpan"/>
											</div>
										</div>
									</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Arrival Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="search_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
												</div>
											</div>
									</div>
									<div  class="nav-panel">
										<div class="btn-cont">
											<input class="submit-btn"  type="submit" id="subId" value="Search">
										</div>
									</div>
							</div>
						</div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                   <tr>
										<th width="10%" style="font-size:14px;font-weight:bold;">TourCode</th>
										<th id="arriveDate" width="10%" style="font-size:14px;font-weight:bold;">Arrival Date</th>
										<th width="8%" style="font-size:14px;font-weight:bold;">ETA</th>
										<th width="8%" style="font-size:14px;font-weight:bold;">FLT #</th>
										<th width="8%" style="font-size:14px;font-weight:bold;">Remark</th>
										<th width="10%" style="font-size:14px;font-weight:bold;">Last Name</th>
										<th width="10%" style="font-size:14px;font-weight:bold;">First Name</th>
										<th width="10%" style="font-size:14px;font-weight:bold;">Middle Name</th>
										<th width="10%" style="font-size:14px;font-weight:bold;">Arrival/Departure</th>
									</tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form id="formId" action="printFlightWithCus.jhtml" method="post">
    	<input id="exTourCode" name="tourCode" type="hidden">
    	<input id="exBeginningDate" name="beginningDate" type="hidden">
    	<input id="exEndingDate" name="endingDate" type="hidden">
    	<input id="exOutOrEnter" name="outOrEnter" type="hidden">
    </form>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
       
        t = "${today}";
        beginDate = t;
        $("#search_beginningDate").attr("value",t);
       
        endDate = t;
        $("#search_endingDate").attr("value",t);
       
       $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bSort":false,
            "bFilter":false,
            "aLengthMenu":[10,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/tour/flightList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.outOrEnter = $("#flightSpan").val();
				}
            },
            "columns": [
            	{ "data": "tourCode" },
                { "data": "arriveDate" },
                { "data": "arriveTime" },
                { "data": "flightCode",
                   "render": function (data, type, row) {
	              		return data+" "+row.flightNumber;
                    }
                     },
                { "data": "remark" },
                { "data": "lastName"},
                { "data": "firstName" },
                { "data": "middleName" },
                { "data": "outOrEnter",
                   "render": function (data, type, row) {
	              		if(data==1){
	              			return "Arrival";
	              		}else{
	              			return "Departure";
	              		}
                    }
                     }
            ]
        });
        
        //$("div.options").hide();//默认隐藏 筛选 div
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-caret-square-o-up fa-lg color-blue"){
				_slide.removeClass("fa fa-caret-square-o-up fa-lg color-blue").addClass("fa fa-caret-square-o-down fa-lg color-blue");
			}else{
				_slide.removeClass("fa fa-caret-square-o-down fa-lg color-blue").addClass("fa fa-caret-square-o-up fa-lg color-blue");
			}
		});
		
		$("#subId").on( 'click', function () {
			$("#exTourCode").val($("#search_tourCode").val());
			$("#exBeginningDate").val($("#search_beginningDate").val());
			$("#exEndingDate").val($("#search_endingDate").val());
			$("#exOutOrEnter").val($("#flightSpan").val());
			$('#datatable2').DataTable().draw();
		} );
    });
    
    var obj={
		 colorSpan:"",
		};
		function change(span,value)
		{
			//给所以span的属性初始化
		    $('span[name="'+$(span).attr('name')+'"]').each(function(){
		             if(this.checked&&this!=span)
		          {
		                this.className="unchecked";
		                this.checked=false;
		          }               
		    });
		    //判断是否有选中   是 初始化取消加粗   否加粗
		  	if(span.checked&&span.className=="checked"){
			    span.className="unchecked";
			    span.checked=false;
			    $("#"+$(span).attr('name')+"").val("");
		  	}else{
		  		obj[$(span).attr('name')]=span.innerHTML;
			    span.className="checked";
			    span.checked=true;
			    $("#"+$(span).attr('name')+"").val(value);
		  	}
		};
	$("#clearDate").click(function(){
		$("#search_beginningDate").val('');
		$("#search_endingDate").val('');
	});
	
	function comvar(tid){
		if (window.confirm("Are you sure to modify state ？")) {
            location.href="updateState.jhtml?tourId="+tid+"&type=tour";
        }
	}
	
	$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
	$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
	
	$("#New").click(function(){
		    $("#exTourCode").val($("#search_tourCode").val());
			$("#exBeginningDate").val($("#search_beginningDate").val());
			$("#exEndingDate").val($("#search_endingDate").val());
			$("#exOutOrEnter").val($("#flightSpan").val());
		$("#formId").submit();
	});
</script>
</body>
</html>
