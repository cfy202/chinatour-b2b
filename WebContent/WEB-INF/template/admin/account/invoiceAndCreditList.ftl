[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i> Warning!</h4>

                    <p>Data will be permanently deleted ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Checking Accounts</h3>
            <div class="pull-right option-left">
            	<div class="btn-group">
					  <button type="button" onclick="location.href='add.jhtml'" class="btn btn-success md-trigger"  style="height:33px;">&nbsp;&nbsp;&nbsp;&nbsp; New &nbsp;&nbsp;&nbsp;&nbsp;</button>
					  <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown"  style="height:33px;">
						<span class="caret"></span>
						<span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" id="exportButton">Export</a></li>
						<li><a href="javascript:void(0)" id="printButton">Print</a></li>
					  </ul>
				</div>
				
            </div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Accounting</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
						<div class="tab-container">
							<ul class="nav nav-tabs">
							  <input type="hidden" id="nameDept" value="${deptName}">
							  <li class="active"><a href="javascript:;" onclick="javascript:window.location.href='list.jhtml'" data-toggle="tab">Office&nbsp;&nbsp;&nbsp;<span class="bubble" style="background-color:blue;">${disapproveForMountForSelf}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
							  <li><a href="javascript:;" onclick="javascript:window.location.href='otherList.jhtml'" data-toggle="tab">Other Office&nbsp;&nbsp;&nbsp;<span class="bubble">${disapproveForMount}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
							</ul>
                        </div>
					<div class="tab-content block-flat">
                        <div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-angle-down"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="margin:10px; padding:5px 0;">
								<div  class="nav-panel">
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="statusSpan" checked="false" onclick="change(this,1);">NEW</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,2);" >Approved</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="statusSpan" checked="false" onclick="change(this,3);" >Disapproved</span> 
													</a>  
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="isAuto" checked="false" onclick="change(this,1);" >Auto</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="isAuto" checked="false" onclick="change(this,0);" >Not Auto</span> 
													</a> 
													<input type="hidden" id="statusSpan"/>
													<input type="hidden" id="isAuto"/>
												</div>
											</div>
										</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Record Month</span>:
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
													<input type="text" size="14" id="search_businessCode" placeholder="businessCode..." /> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_recordType"  placeholder="recordType..." />
													<input type="text" size="14" id="search_deptName"  placeholder="deptName..." />
													<input type="text" size="14" id="search_remarks"  placeholder="Record Remark..." />
													<input type="text" size="14" id="search_enterCurrency"  placeholder="Amount..." />
													<input type="text" size="14" id="search_dollar"  placeholder="Dollar..." />
												</div>
											</div>
									</div>
									<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Arrive Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_beginningDateForArr" size="14"  placeholder="Beginning Date." />
													<input type="text" id="search_endingDateForArr" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDateForArr" class="fa fa-rotate-left" title="Clear Date"></i>
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
						</div>
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
	                                    <tr>
	                                        <th width="13%">Business No.</th>
	                                        <th width="8%">Rate</th>
	                                        <th width="10%">Amount(${currency.symbol})</th>
	                                        <th width="10%">Exchange Amount</th>
	                                        <th width="10%">Dollar($)</th>
	                                        <th width="10%">Record Month</th>
	                                        <th width="10%">Record Type</th>
	                                        <th width="10%">Tour Code</th>
	                                        <th width="10%">BillTo</th>
	                                        <th width="10%">Auditing Remark</th>
	                                        <th width="10%">Record Remark</th>
	                                        <th width="10%">Status</th>
	                                        <th width="200px">Action</th>
	                                    </tr>
	                                    </thead>
	                                </table>
						</div>
		</div>
    </div>
</div>
<form action="jxlExcelForIc.jhtml" id="exportCondition" method="post">
		<input id="confirmStatusForCondition" type="hidden" name="confirmStatusForFlag"/>
    	<input id="tourCodeForCondition" type="hidden" name="tourCode"/>
    	<input id="beginningDateForCondition" type="hidden" name="beginningDate"/>
    	<input id="endingDateForCondition" type="hidden" name="endingDate"/>
    	<input id="beginningDateForArrForCondition" type="hidden" name="beginningDateForArr"/>
    	<input id="endingDateForArrForCondition" type="hidden" name="endingDateForArr"/>
    	<input id="recordTypeForCondition" type="hidden" name="recordType"/>
    	<input id="deptNameForCondition" type="hidden" name="billToReceiver"/>
    	<input id="remarksForCondition" type="hidden" name="remarks"/>
    	<input id="enterCurrencyForCondition" type="hidden" name="enterCurrency"/>
    	<input id="dollarForCondition" type="hidden" name="dollar"/>
</form>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
       
       $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            'bStateSave': true,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/invoiceAndCredit/list.jhtml'/]",
                type: "POST",
               "data": function (data) {
	                data.businessNo = $("#search_businessCode").val();
	                data.tourCode = $("#search_tourCode").val();
	                data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
	                data.beginningDateForArr = $("#search_beginningDateForArr").val();
					data.endingDateForArr = $("#search_endingDateForArr").val();
					data.recordType = $("#search_recordType").val();
					data.deptName = $("#search_deptName").val();
					data.remarks = $("#search_remarks").val();
					data.enterCurrency = $("#search_enterCurrency").val();
					data.dollar = $("#search_dollar").val();
					data.confirmStatus = $("#statusSpan").val();
					data.isAuto = $("#isAuto").val();
            	}
            },
            "columns": [
                { "data": "businessNo" ,"render" : function(data, type, row) {
                        if(!data && typeof(data)!="undefined" && data!=0){
                        	return "";
                        }else{
					  		return row.prefix+"-"+data ;
					  	}
					  	
					}},
                { "data": "exRate" },
                { "data": "enterCurrency","render" : function(data, type, row) {
					  	str = data+"";
					  	str = str.trim();
					  	if(str.indexOf('.')<0){
					  		return data+".00";
					  	}else if(str.indexOf('.')>0&&(str.substring(str.indexOf('.')+1,str.length)).length<2){
					  		
					  		return str+'0';
					  	}
					  	return data;
					}
				},
				{ "data": "exAmount","render" : function(data, type, row) {
					  	str = data+"";
					  	str = str.trim();
					  	if(str.indexOf('.')<0){
					  		return data+".00";
					  	}else if(str.indexOf('.')>0&&(str.substring(str.indexOf('.')+1,str.length)).length<2){
					  		
					  		return str+'0';
					  	}
					  	return changeTwoDecimal(data);
					}
				},
                { "data": "dollar" ,"render" : function(data, type, row) {
					  	str = data+"";
					  	str = str.trim();
					  	if(str.indexOf('.')<0){
					  		return data+".00";
					  	}else if(str.indexOf('.')>0&&(str.substring(str.indexOf('.')+1,str.length)).length<2){
					  		
					  		return str+'0';
					  	}
					  	return data;
					}},
                { "data": "month","render" : function(data, type, row) {
                		if(!data && typeof(data)!="undefined" && data!=0){
                			return "";
                		}else{
					  		return data.substring(0,data.length-3);
					  	}
					}
				},
                { "data": "recordType" },
                { "data": "tourCode" },
                { "data": "deptName" },
                { "data": "confirmRemarks" },
                { "data": "remarks" },
                { "data": "confirmStatus",
                	"render" : function(data, type, row) {
					  	switch(data){
					  		case 'NEW' : return '<i title="New" class="fa fa-clock-o"></i>';
					  		break;
					  		case 'NEWAUTO' : return '<i title="New" class="fa fa-clock-o"></i>';
					  		break;
					  		case 'CONFIRM' : return '<i title="Approved" class="fa fa-check"></i>';
					  		break; 
					  		case 'CONFIRMAUTO' : return '<i title="Approved" class="fa fa-check"></i>';
					  		break; 
					  		case 'CONFIRMSEND' : return '<i title="Approved" class="fa fa-check"></i>';
					  		break; 
					  		case 'REJECT' : return '<i title="Disapproved" class="fa fa-times"></i>';
					  		break;
					  		default: return '';
					  	}
					}
                },
                { "data": "invoiceAndCreditId"}
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
				    html='<div class="btn-group" style="width:70px"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="edit.jhtml?id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li><li><a href="printForDetail.jhtml?invoiceAndCreditId='+data+'"  target="_blank"></i><i class="fa fa-print"></i>Print</a></li><li class="divider"></li>';
					if(row.confirmStatus!='CONFIRM' && row.confirmStatus!='CONFIRMAUTO' && row.confirmStatus!='CONFIRMSEND'){
						html+='<li><a data-href="del.jhtml?invoiceAndCreditId='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li>';
						}
					html+='</ul></div>';
					return html;
                 },
				"targets" :12
		  }],
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) { 
				if(aData.invoiceAndCreditId==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(11)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			}
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        $("div.options").hide();
        <!--默认隐藏div，或者在样式表中添加.text{display:none}，推荐使用后者-->
		
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
			$("#confirmStatusForCondition").attr("value",$("#statusSpan").val());
			$("#tourCodeForCondition").attr("value",$("#search_tourCode").val());
			$("#beginningDateForCondition").attr("value",$("#search_beginningDate").val());
			$("#endingDateForCondition").attr("value",$("#search_endingDate").val());
			$("#beginningDateForArrForCondition").attr("value",$("#search_beginningDateForArr").val());
			$("#endingDateForArrForCondition").attr("value",$("#search_endingDateForArr").val());
			$("#recordTypeForCondition").attr("value",$("#search_recordType").val());
			$("#deptNameForCondition").attr("value",$("#search_deptName").val());
			$("#remarksForCondition").attr("value",$("#search_remarks").val());
			$("#enterCurrencyForCondition").attr("value",$("#search_enterCurrency").val());
			$("#dollarForCondition").attr("value",$("#search_dollar").val());
			$('#datatable2').DataTable().draw();
		} );
		
    	//导出
    	$("#exportButton").on('click',function(){
    		$("#exportCondition").submit();
    	});
    	//打印
    	$("#printButton").on('click',function(){
    		$("#exportCondition").attr("action","printForIc.jhtml")
    		$("#exportCondition").submit();
    	});
    	
	    $("#clearDate").click(function(){
			$("#search_beginningDate").val('');
			$("#search_endingDate").val('');
		});
	    $("#clearDateForArr").click(function(){
			$("#search_beginningDateForArr").val('');
			$("#search_endingDateForArr").val('');
		});
	
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm',changeYear: true,changeMonth: true });
		$("#search_beginningDateForArr").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDateForArr").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
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
		}
		
		//获取两位小数点
	function changeTwoDecimal(x){
			var f_x = parseFloat(x);
			if (isNaN(f_x))
			{
				//alert('function:changeTwoDecimal->parameter error');
				return false;
			}
			var f_x = Math.round(x*100)/100;
		
			return f_x;
		}
   
</script>
</body>
</html>
