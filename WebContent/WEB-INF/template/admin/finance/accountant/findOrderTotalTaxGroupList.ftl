
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
            <h2>Order Settlement</h2>
            <div class="new"><a href='javascript:chbox();' class="btn btn-success" >Settlement</a><a id="btnPrint" href='javascript:printOrder();' class="btn btn-primary" ><i class="fa fa-print"></i> Print</a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Booking</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
    			<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
									<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
									<div class="pull-right pull-cursor" title="Filter">
										<i id="filter" class="fa fa-angle-down"></i>&nbsp;&nbsp;
									</div>
									<div class="options" style="margin:10px; padding:5px 0;">
											<div  class="nav-panel">
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Settlement Status</span>:
													</div>
													<div  class="block-body default-4-line">
														<div  class="params-cont"> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
																<span  class="unchecked"  name="taxSpan" checked="false" onclick="change(this,3);">Settling</span> 
															</a>
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,2);" >Settled</span> 
															</a> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="taxSpan" checked="false" onclick="change(this,0);" >Unsettled</span> 
															</a> 
															<input type="hidden" id="taxSpan"/>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Revised Bill Status</span>:
													</div>
													<div  class="block-body default-4-line">
														<div  class="params-cont"> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
																<span  class="unchecked"  name="sprCheckSpan" checked="false" onclick="change(this,1);">Unsettled</span> 
															</a>
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="sprCheckSpan" checked="false" onclick="change(this,5);" >Settled</span> 
															</a> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="sprCheckSpan" checked="false" onclick="change(this,3);" >New(Agent)</span> 
															</a> 
															<input type="hidden" id="sprCheckSpan"/>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Booking</span>:
													</div>
													<div  class="block-body default-4-line">
														<div  class="params-cont"> 
															<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
																<span  class="unchecked"  name="isSelfOrganizeSpan" checked="false" onclick="change(this,0);">Tour Booking</span> 
															</a>
															<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
																<span  class="unchecked" name="isSelfOrganizeSpan" checked="false" onclick="change(this,2);" >Other Booking</span> 
															</a> 
															<input type="hidden" id="isSelfOrganizeSpan"/>
														</div>
													</div>
												</div>
												<div class="nav-block">
													<div class="block-head">
														<span class="nav-title">Booking Time</span>:
													</div>
													<div class="block-body default-4-line pull-cursor">
														<div class="params-cont">
															<input type="text" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
															<input type="text" id="search_endingDate" size="14"  placeholder="Ending Date." />
															&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
														</div>
													</div>
												</div>
												<div class="nav-block">
													<div class="block-head">
														<span class="nav-title">Arrival Time</span>:
													</div>
													<div class="block-body default-4-line pull-cursor">
														<div class="params-cont">
															<input type="text" id="search_arrivalBeginningDate" size="14"  placeholder="Beginning Date." />
															<input type="text" id="search_arrivalEndingDate" size="14"  placeholder="Ending Date." />
															&nbsp;<i id="clearDate2" class="fa fa-rotate-left" title="Clear Date"></i>
														</div>
													</div>
												</div>
												<div class="nav-block">
													<div class="block-head">
														<span class="nav-title">Settlement Date</span>:
													</div>
													<div class="block-body default-4-line pull-cursor">
														<div class="params-cont">
															<input type="text" id="search_settlementDateBeg" size="14"  placeholder="Beginning Date." />
															<input type="text" id="search_settlementDateEnd" size="14"  placeholder="Ending Date." />
															&nbsp;<i id="clearDate1" class="fa fa-rotate-left" title="Clear Date"></i>
														</div>
													</div>
												</div>
												<div  class="nav-block">
													<div  class="block-head">
														<span  class="nav-title">Others</span>:
													</div>
													<div  class="block-body default-2-line">
														<div  class="params-cont"> 
															<input type="text" size="14" id="search_orderNumber" placeholder="orderNo..." />
															<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
															<input type="text" size="14" id="search_agent" placeholder="agent..." />
															<input type="text" size="14" id="search_peer" placeholder="Peer..." />
														</div>
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
							<form method="post" id="formId" action="[@spring.url '/admin/payCostRecords/accSettlementAll.jhtml?menuId=513'/]">
								<div class="table-responsive">
									<table class="table table-bordered" id="datatable2">
										<thead>
											<tr>
												<th></th>
												<th>Tour Code</th>
												<th><input id="check-all" type="checkbox" name="checkall"/>Booking No.</th>
												<th>Settlement Date</th>
												<th>Agent</th>
												<th>totalPeople</th>
												<th>Total Amount</th>
												<th>Income</th>
												<th>Cost</th>
												<th>Total Profit</th>
												<th>5% Profit</th>
												<th>Profit</th>
												<!--<th>Settlement Status</th>-->
												<th width="10%">Action</th>
											</tr>
										</thead>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
     $(document).ready(function () {
        //initialize the javascript
        App.init();
        $('.md-trigger').modalEffects();
        [@flash_message /]
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
      $('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	        radioClass: 'iradio_square-blue'
      });
        $("#datatable2").attr("width","100%");
         
      	/* Formating function for row details */
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Peer:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.peerId+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Revised Bill Status:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
			if(aData.sprCheck == 1){
				 sOut += 'Auditing Approved';
			}else if(aData.sprCheck == 3){
				 sOut += 'Approved(Accountant)';
			}else if(aData.sprCheck == 5){
				 sOut += 'Revised Bill Settled';
			}
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Settlement Status:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
			if(aData.tax==3){
     			sOut +="<span class='color-warning'> Settling </span>";
     		}else if(aData.tax==2 || aData.tax==4){
     			sOut +="<span class='color-success'>Settled </span>";
     		}else if(aData.tax==0){
     			sOut +="<span class='color-danger'>Unsettled</span>";
     		}
            sOut += '</td></tr></table>';
            return sOut;
        }
         
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "autoWidth":true,
            "bFilter":false,
            "bSort":false,
             "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/payCostRecords/findOrderTotalTaxGroupList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.orderNo = $("#search_orderNumber").val();
					data.userName = $("#search_agent").val();
					data.tax = $("#taxSpan").val();
					data.sprCheck = $("#sprCheckSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
	                data.endingDate = $("#search_endingDate").val();
					data.arrivalBeginningDate = $("#search_arrivalBeginningDate").val();
	                data.arrivalEndingDate = $("#search_arrivalEndingDate").val();
	                data.settlementDateBeg = $("#search_settlementDateBeg").val();
	                data.settlementDateEnd = $("#search_settlementDateEnd").val();
	                data.tourCode = $("#search_tourCode").val();
	                data.isSelfOrganize = $("#isSelfOrganizeSpan").val();
                    data.peerId = $("#search_peer").val();
				}
            },
           "columns": [
                { "data": null},
                { "data": "tourCode" },
                { "data": "orderNo", 
					"render" : function(data, type, row) {
						var html="";
                		if(row.tax==3){
                 			html="<div class='radio'><input type='checkbox'  name='ordersTotalIds' value='"+row.ordersTotalId+"' class='icheck'/><span class='color-warning'>"+data+"</span>";
                 		}else if(row.tax==2 || row.tax==4){
                 			html="<span class='color-success'>"+data+"</span>";
                 		}else if(row.tax==0){
                 			html="<span class='color-danger'>"+data+"</span>";
                 		}
              			return html;
					}
                },
                { "data": "checkTime" },
                { "data": "userName" },
                { "data": "totalPeople" },
                { "data": "commonTourFee"},
                { "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return data.payTotalSum
						}else{
							return '0';
						}
					}
				},
                { "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return data.costTotalSum
						}else{
							return '0';
						}
					}
				},
				{ "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return (data.payTotalSum-data.costTotalSum).toFixed(2)
						}else{
							return '0';
						}
					}
				},
				{ "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return ((data.payTotalSum-data.costTotalSum)*row.priceExpression).toFixed(2)
						}else{
							return '0';
						}
					}
				},
				{ "data": "payCost",
					"render":function(data, type, row) {
						if(data!=null){
							return ((data.payTotalSum-data.costTotalSum)*(1-row.priceExpression)).toFixed(2)
						}else{
							return '0';
						}
					}
				},
                /*{ "data": "tax", 
					"render" : function(data, type, row) {
						var html="";
                		if(data==3){
                 			html="<span class='color-warning'> Settling </span>";
                 		}else if(data==2 || data==4){
                 			html="<span class='color-success'>Settled </span>";
                 		}else if(data==0){
                 			html="<span class='color-danger'>Unsettled</span>";
                 		}
              			return html;
					}
                },*/
                { "data": "ordersTotalId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					var html='<a href="accSettlementOrdersTotal.jhtml?ordersTotalId='+row.ordersTotalId+'&userId='+row.userId+'">';
					if(row.tax==3){
						html+='<i class="fa fa-pencil"></i>Settlement';
					}else{
						html+='<i class="fa fa-eye"></i>View';
					}
					html+="</a>";
					return html;
                 },
				"targets" : 12
		  }],
		 /* "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		    	  var str='';
                 		if(aData.tax==3){
                 			str+='<div class="radio"><input type="checkbox"  name="orderIds" value="'+aData.id+'" class="icheck"/>Settling</div>';
                 		}else if(aData.tax==2 || aData.tax==4){
                 			str+='<input type="checkbox" class="icheck" disabled="disabled"/>Settled';
                 		}else if(aData.tax==0){
                 			str+='<input type="checkbox" class="icheck" disabled="disabled"/>Unsettled';
                 		}
		        $('td:eq(3)', nRow).html(str);
		    },*/
			"fnDrawCallback": function() {
				initAddHtml($("#datatable2"));
		    },
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.ordersTotalId==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(12)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}else{
					if(aData.tax==3){
                 			$(nRow).attr("title","Settling");
                 		}else if(aData.tax==2 || aData.tax==4){
                 			$(nRow).attr("title","Settled");
                 		}else if(aData.tax==0){
                 			$(nRow).attr("title","Unsettled");
                 		}
					
				}
			},
		    "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
            }
        });
        
        $('#datatable2').delegate('tbody td img','click', function () {
            var nTr = $(this).parents('tr')[0];
            
            if ( oTable.fnIsOpen(nTr) )
            {
                /* This row is already open - close it */
                this.src = "[@spring.url '/resources/images/plus.png'/]";
                oTable.fnClose( nTr );
            }
            else
            {
                /* Open this row */
                this.src = "[@spring.url '/resources/images/minus.png'/]";
                oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
            }
        } );
        
      $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
      $('.dataTables_length select').addClass('form-control');    
        
       $("div.options").hide();//默认隐藏 筛选 div
		
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-angle-up"){
				_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
			}
		});
		
		$("#subId").on( 'click', function () {
			$('#datatable2').DataTable().draw();
		} );
		
    });
    //全选或不全选
    $("#check-all").on('ifChanged',function(){
        var checkboxes = $(".radio").find(':checkbox');
        if($(this).is(':checked')) {
            checkboxes.iCheck('check');
        } else {
            checkboxes.iCheck('uncheck');
        }
      });
	/* 初始化添加的元素  */
	function initAddHtml($addHtml){
		$addHtml.find('.icheck').iCheck({
			checkboxClass: 'icheckbox_square-blue checkbox',
			radioClass: 'iradio_square-blue'
		});
		return $addHtml;
	}

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
		}
		$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
 			$("#search_endingDate").val('');
		});
		
		$("#clearDate1").click(function(){
			$("#search_settlementDateBeg").val('');
 			$("#search_settlementDateEnd").val('');
		});
		$("#clearDate2").click(function(){
			$("#search_arrivalBeginningDate").val('');
 			$("#search_arrivalEndingDate").val('');
		});
		
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_arrivalBeginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_arrivalEndingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_settlementDateBeg").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_settlementDateEnd").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		
		function printOrder(){
			var tourCode = $("#search_tourCode").val();
			var orderNo = $("#search_orderNumber").val();
			var userName = $("#search_agent").val();
			var tax = $("#taxSpan").val();
			var sprCheck = $("#sprCheckSpan").val();
			var beginningDate = $("#search_beginningDate").val();
            var endingDate = $("#search_endingDate").val();
			var arrivalBeginningDate = $("#search_arrivalBeginningDate").val();
            var arrivalEndingDate = $("#search_arrivalEndingDate").val();
            var settlementDateBeg = $("#search_settlementDateBeg").val();
            var settlementDateEnd = $("#search_settlementDateEnd").val();
            var isSelfOrganize = $("#isSelfOrganizeSpan").val();
            var peerId = $("#search_peer").val();
			window.open("[@spring.url '/admin/payCostRecords/findGroupOrderTotalTaxListPrint.jhtml'/]?tourCode="+tourCode+"&orderNo="+orderNo+"&userName="+userName+"&tax="+tax+"&sprCheck="+sprCheck+"&beginningDate="+beginningDate+"&endingDate="+endingDate+"&settlementDateBeg="+settlementDateBeg+"&settlementDateEnd="+settlementDateEnd+"&arrivalBeginningDate="+arrivalBeginningDate+"&arrivalEndingDate="+arrivalEndingDate+"&isSelfOrganize="+isSelfOrganize+"&peerId="+peerId);
		}
		/*格式化金额*/
		function fmoney(s, n)  
		{  
		   n = n > 0 && n <= 20 ? n : 2;  
		   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
		   var l = s.split(".")[0].split("").reverse(),  
		   r = s.split(".")[1];  
		   t = "";  
		   for(i = 0; i < l.length; i ++ )  
		   {  
		      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
		   }  
		   return t.split("").reverse().join("") + "." + r;  
		} 
		
	//批量审核 提交表单
	function chbox(){
		var length = $("input[name='ordersTotalIds']:checked").size();
		if(length == 0){
			alert("Select Booking");
			return;
		}
		$("#formId").submit();
	}
</script>
</body>
</html>
