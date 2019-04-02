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
                    <p> Data will be permanently deleted ?</p>
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
        	<div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertInfoButton" data-modal="form-primary1">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <h3>Checking Accounts</h3>
            <div class="pull-right option-left">
            	<div class="btn-group">
					  <button type="button" id="approve" onclick="verify()" class="btn btn-primary md-trigger"  style="height:33px;">Approve</button>
					  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"  style="height:33px;">
						<span class="caret"></span>
						<span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" id="exportButton">Export</a></li>
						<li><a href="javascript:void(0)" id="printButton">print</a></li>
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
							  <li><a href="javascript:;" onclick="javascript:window.location.href='list.jhtml'" data-toggle="tab">Office&nbsp;&nbsp;&nbsp;<span class="bubble" style="background-color:blue;">${disapproveForMountForSelf}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
							  <li class="active"><a href="javascript:;" onclick="javascript:window.location.href='otherList.jhtml'" data-toggle="tab">Other Office&nbsp;&nbsp;&nbsp;<span class="bubble">${disapproveForMount}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
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
													<input type="text" size="14" id="search_businessNo" placeholder="businessNo..." /> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_recordType"  placeholder="recordType..." />
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
            					<div class="pull-right" style="width:165px; margin-top:10px;">
				                    <input id="billToTd" type="hidden" name="billToDeptId" value="${deptFor.deptId}"/>
				                    <input id="billToTdName" type="hidden"value="${deptFor.deptName}"/>
		                        	<select id="deptId" class="select2"   name="billDeptId" onchange="deptChange();" >
				                  		[#list deptList as depts]
				                  			[#if depts.deptId !=deptId]
				                        	<option value="${depts.deptId}" [#if depts.deptId==deptFor.deptId] selected = "selected"[/#if]>${depts.deptName}</option>
				                        	[/#if]
				                    	[/#list]
				                  	</select>
            					</div>
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
	                                    <tr>
	                                        <th width="7%"><input id="check-all" type="checkbox"></th>
	                                        <th width="13%">Business No.</th>
	                                        <th width="8%">Rate</th>
	                                        <th width="10%">Amount</th>
	                                        <th width="10%">Exchange Amount</th>
	                                        <th width="10%">Dollar</th>
	                                        <th width="10%">Record Month</th>
	                                        <th width="10%">Record Type</th>
	                                        <th width="10%">Tour Code</th>
	                                        <th width="10%">Auditing Remark</th>
	                                        <th width="10%">Record Remark</th>
	                                        <th width="10%">Status</th>
	                                        <th width="300px">Action</th>
	                                    </tr>
                                    </thead>
                              </table>
					</div>
			</div>
		</div>
    </div>
   
	</div>
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
    <div class="md-content">
      <div class="modal-header">
        <h3>Verify</h3>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <form id="verifyFormId" action="" style="border-radius: 0px;" method="post">
      	  <input id="deptIdFor" type="hidden" name="deptIdFor" value="${deptFor.deptId}"/>
      	  <div id="checkId"></div>
	      <div class="modal-body form" >
	      	 <div class="form-group" style="height:80px;">
                <label class="col-sm-3 control-label">Auditing Status</label>
                <div class="col-sm-6">
				  <input class="icheck" id="pass" type="radio" name="pass" value="1" checked="" style="position: absolute; opacity: 0;">审核不通过
                  <input class="icheck" id="pass" type="radio" name="pass" value="2" checked="" style="position: absolute; opacity: 0;">审核通过
                </div>
              </div>   
	      	 <div class="form-group" style="height:100px;">
                <label class="col-sm-3 control-label">Auditing Remark</label>
                <div class="col-sm-6">
                  <textarea class="form-control" name="rem" id="rem"> </textarea>
                </div>
              </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
		        <button type="button" class="btn btn-primary btn-flat md-close" data-dismiss="modal" id="OKButton">Save</button>
		      </div>
	      </div>
      </form>
  	</div>
</div>
<div class="md-overlay"></div>
<form action="jxlExcelForOtherIc.jhtml" id="exportCondition" method="post">
		<input id="confirmStatusForCondition" type="hidden" name="confirmStatusForFlag"/>
    	<input id="tourCodeForCondition" type="hidden" name="tourCode"/>
    	<input id="beginningDateForCondition" type="hidden" name="beginningDate"/>
    	<input id="endingDateForCondition" type="hidden" name="endingDate"/>
    	<input id="beginningDateForArrForCondition" type="hidden" name="beginningDateForArr"/>
    	<input id="endingDateForArrForCondition" type="hidden" name="endingDateForArr"/>
    	<input id="deptIdForCondition" type="hidden" name="deptId" />
    	<input id="recordTypeForCondition" type="hidden" name="recordType" />
    	<input id="remarksForCondition" type="hidden" name="remarks"/>
    	<input id="enterCurrencyForCondition" type="hidden" name="enterCurrency"/>
    	<input id="dollarForCondition" type="hidden" name="dollar"/>
</form>
[#include "/admin/include/foot.ftl"]

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary1" style="width:80%; height:60%;">
    <div class="md-content" id="accInfo">
   </div>
</div>
<div class="md-overlay"></div>
<script type="text/javascript">
	//格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动
	function formatAsText(item){
		 var itemFmt ="";
		[#list deptList as depts]
			if('${depts.deptId}'==item.id){
				var i="";
				if(${depts.deptForInvoiceAndCredit}!=0){
					itemFmt ="<div style='display:inline;'>"+item.text+"&nbsp;&nbsp;&nbsp;<span class='bubble'>"+${depts.deptForInvoiceAndCredit}+"</span></div>"
				}else{
					itemFmt ="<div style='display:inline;'>"+item.text+"&nbsp;&nbsp;&nbsp;</div>"
				}
				
			}
    	[/#list]
	    
	     return itemFmt;
	}

    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $("#deptIdFor").attr("value",$("#deptId").val());
        [@flash_message /]
        init();
        var Value=$("#billToTd").val();
        var ValueName=$("#billToTdName").val();
        $(".select2").select2({
        	width: '100%',
        	formatResult: formatAsText
		});
		$('input').iCheck({
        checkboxClass: 'icheckbox_square-blue checkbox',
        radioClass: 'iradio_square-blue'
      });
    });
    function init(){
    	$("#datatable2").dataTable().fnDestroy(); 
        var billToTd=$("#billToTd").val();
        if(billToTd==""){
        	billToTd=$("#deptId").val();
        	$("#deptIdForCondition").attr("value",billToTd);
        	
        }
        $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
         
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "ajax": {
                url: "[@spring.url '/admin/invoiceAndCredit/otherList.jhtml'/]",
                type: "POST",
                data:function(d){
                			d.deptId = billToTd;
		                	d.businessNo = $("#search_businessNo").val();
		                	d.tourCode = $("#search_tourCode").val();
			                d.beginningDate = $("#search_beginningDate").val();
							d.endingDate = $("#search_endingDate").val();
							d.beginningDateForArr = $("#search_beginningDateForArr").val();
							d.endingDateForArr = $("#search_endingDateForArr").val();
							d.recordType = $("#search_recordType").val();
							d.remarks = $("#search_remarks").val();
							d.enterCurrency = $("#search_enterCurrency").val();
							d.dollar = $("#search_dollar").val();
							d.confirmStatus = $("#statusSpan").val();
							d.isAuto = $("#isAuto").val();
                }
            },
            "columns": [
            	{ "data": "invoiceAndCreditId",
                  "render": function (data, type, row) {
                  		if(row.confirmStatus=='NEW'||row.confirmStatus=='NEWAUTO'){
	                     	return '<div class="radio"><input name="render" value="'+ data +'" type="checkbox"></div>';
	                     }else{
	                     	return '';
	                     }
                   }
                },
                { "data": "businessNo",
                	"render" : function(data, type, row) {
					  	if(!data && typeof(data)!="undefined" && data!=0){
                        	return "";
                        }else{
					  		return row.prefix+"-"+data ;
					  	}
					}
				},
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
					} },
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
                { "data": "dollar","render" : function(data, type, row) {
					  	str = data+"";
					  	str = str.trim();
					  	if(str.indexOf('.')<0){
					  		return data+".00";
					  	}else if(str.indexOf('.')>0&&(str.substring(str.indexOf('.')+1,str.length)).length<2){
					  		
					  		return str+'0';
					  	}
					  	return data;
					} },
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
					  		case 'REJECT' : return '<i title="DisApproved" class="fa fa-times"></i>';
					  		break;
					  		default: return '';
					  	}
					}
                },
                { "data": "invoiceAndCreditId"}
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group" style="width:70px"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li id="'+data+'" onclick="approveForOnly(\''+data+'\');"><a href="#"><i class="fa fa-pencil"></i>View</a></li><li><a href="printForDetail.jhtml?invoiceAndCreditId='+data+'" target="_blank"><i class="fa fa-print"></i>Print</a></li></ul></div>';
                 },
				"targets" :12
		  }],
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) { 
				initAddHtml($("#datatable2"));
				if(aData.invoiceAndCreditId==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(12)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			}
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
       	
       //	alert(oTable[10].val());
    }
    
    //查看选中部门的对账数据
    function deptChange(){
    	$("#billToTd").attr("value",$("#deptId").val());
    	$("#deptIdFor").attr("value",$("#deptId").val());
    	//alert($("#deptId").val());
    	//window.location.reload();
    	init();
    };
   
    function verify(){
    	$("#rem").attr("value","  ");
    	$("#approve").attr("data-modal",false);
    	var	length = $("input[type=checkbox][name=render]:checked").length;
    	if(length<=0){
    		alert("Please select the bill for auditing");
    	}else if(length>0){
    		$("#approve").attr("data-modal","form-primary");
	    	$("input[type=checkbox][name=render]:checked").each(function(){
				$("#checkId").append('<input type="hidden" name="invoiceAndCreditId" value="'+$(this).val()+'"/> ');
			});
			$('.md-trigger').modalEffects();
			var oTable = $('#datatables').DataTable({
	            "processing": true,
	            "filter": false
	        });
	      }
	    };
	     $("div.options").hide();
		
    	
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
		
    	
    	$("#exportButton").on('click',function(){
    		$("#confirmStatusForCondition").attr("value",$("#statusSpan").val());
    		$("#tourCodeForCondition").attr("value",$("#search_tourCode").val());
			$("#beginningDateForCondition").attr("value",$("#search_beginningDate").val());
			$("#endingDateForCondition").attr("value",$("#search_endingDate").val());
			$("#beginningDateForArrForCondition").attr("value",$("#search_beginningDateForArr").val());
			$("#endingDateForArrForCondition").attr("value",$("#search_endingDateForArr").val());
			$("#recordTypeForCondition").attr("value",$("#search_recordType").val());
			$("#deptIdForCondition").attr("value",$("#deptId").val());
			$("#remarksForCondition").attr("value",$("#search_remarks").val());
			$("#enterCurrencyForCondition").attr("value",$("#search_enterCurrency").val());
			$("#dollarForCondition").attr("value",$("#search_dollar").val());
    		$("#exportCondition").submit();
    	});
    	
    	$("#printButton").on('click',function(){
    		$("#tourCodeForCondition").attr("value",$("#search_tourCode").val());
			$("#beginningDateForCondition").attr("value",$("#search_beginningDate").val());
			$("#endingDateForCondition").attr("value",$("#search_endingDate").val());
			$("#recordTypeForCondition").attr("value",$("#search_recordType").val());
			$("#deptIdForCondition").attr("value",$("#deptId").val());
    		$("#exportCondition").attr("action","printForOtherIc.jhtml");
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
		
		$("#OKButton").click(function(){
			$.ajax({
                type: "POST",
                url:"${base}/admin/invoiceAndCredit/verify.jhtml",
                data:$('#verifyFormId').serialize(),
                success: function(map) {
                    $.each( map.invoiceAndCreditList,function(index,invoiceAndCredit){
                    	$("#datatable2 tr:not(:first):not(:last)").each(function(){
                    		str1 = $(this).children('td').eq(0).find("input").val();
                    		status = invoiceAndCredit['confirmStatus'];
                    		if(str1==invoiceAndCredit['invoiceAndCreditId']){
                    			str ="";
                    			switch(status){
								  		case 'NEW' : str = '<i title="New" class="fa fa-clock-o"></i>';
								  		break;
								  		case 'NEWAUTO' : str = '<i title="New" class="fa fa-clock-o"></i>';
								  		break;
								  		case 'CONFIRM' : str =  '<i title="Approved" class="fa fa-check"></i>';
								  		break; 
								  		case 'CONFIRMAUTO' : str =  '<i title="Approved" class="fa fa-check"></i>';
								  		break; 
								  		case 'CONFIRMSEND' : str =  '<i title="Approved" class="fa fa-check"></i>'; 
								  		break;
								  		case 'REJECT' : str =  '<i title="DisApproved" class="fa fa-times"></i>';
								  		break;
								  		default: str =  '';
					  				}
					  			$(this).children('td').eq(0).html("");
					  			$(this).children('td').eq(9).html(invoiceAndCredit.confirmRemarks);
					  			$(this).children('td').eq(11).html("");
					  			$(this).children('td').eq(11).append(str);
                    		}
                    	});
                    });
                    alert(map.message);
                    }
				})
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
	
	
	function approveForOnly(id){
	
		$.ajax({
                type: "GET",
                url:"${base}/admin/invoiceAndCredit/infoByIdForAjax.jhtml?id="+id,
                success: function(map) {
                	$("#accInfo").html("");
                	str = ' <div class="modal-header">'+
						        '<h4>Bill Detailed-'+map.invoiceAndCredit.businessNo+'</h4>'+
						        '<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true" id="closeForm">&times;</button>'+
						      '</div>'+
						      '<div class="modal-body form" style=" overflow:auto;">';
                    
				            str += '<table style="word-break:break-all;white-space:nowrap; " width="100%">'+
								 '<tbody>'+
									'<tr>'+
										'<td width="13%">'+
											'<span>BillTo:</span>'+
											'<input id="invoiceAndCreditIdForOnly" type="hidden" name="invoiceAndCreditId" value="'+id+'"/>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="text"value="'+map.dept.deptName+'" class="form-control" style="width:201px" disabled="disabled"/>'+
										'</td>'+
										'<td width="13%">'+
											'<span>Record Type:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="text" name="recordType" class="form-control" style="width:201px"  disabled="disabled"  value="'+map.invoiceAndCredit.recordType+'"/>'+
										'</td>'+
									'</tr>'+
									'<tr>'+
										'<td width="13%">'+
											'<span>TourCode:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="text"  id="tourCode" name="tourCode" value="'+map.invoiceAndCredit.tourCode+'"  disabled="disabled" class="form-control" style="width:201px" />'+
											'<input type="hidden"  id="tourId" name="tourId"/>'+			
										'</td>'+
										'<td width="13%">'+
											'<span>DATE:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<div  class="input-group date datetime col-md-5 col-xs-7" data-date-format="yyyy-mm-dd" data-min-view="2">'+
												'<input type="text" readonly="readonly" class="form-control"  disabled="disabled" name="createDate" value="'+map.invoiceAndCredit.month.substring(0,7)+'"  style="width:165px">'+
												'<span class="input-group-addon btn btn-primary">'+
												     '<span class="glyphicon glyphicon-th"></span>'+
										        '</span>'+
										    '</div>'+
										'</td>'+
									'</tr>'+
									'<tr>'+
										'<td width="13%">'+
											'<span>Email:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="email" name="emailTo" value="'+map.invoiceAndCredit.emailTo+'"  disabled="disabled" class="form-control" style="width:201px" />'+
										'</td>'+
										'<td width="13%">'+
											'<span>Remarks:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="text"  id="remarks" name="remarks" value="'+map.invoiceAndCredit.remarks+'"  disabled="disabled" class="form-control" style="width:201px" />'+	
										'</td>'+
									'</tr>'+
									'<tr>'+
										'<td width="13%">'+
											'<span>Auditing Status:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="text" id="confirmStatus" name="confirmStatus" value="'+map.invoiceAndCredit.confirmStatus+'" disabled="disabled" class="form-control" style="width:201px" />'+
										'</td>'+
										'<td width="13%">'+
											'<span>Auditing Remark:</span>'+
										'</td>'+
										'<td width="37%">'+
											'<input type="text" value="'+map.invoiceAndCredit.confirmRemarks+'" disabled="disabled" class="form-control" style="width:201px" />'+	
										'</td>'+
									'</tr>'+
								  '</tbody>'+
								'</table>'+
								'<div name="slide_customerIndex" id="slide_customerIndex">'+
									'<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;">'+
										'<i class="fa fa-bars"></i>'+
										'<span class="customerNumber">Checking Details</span>'+
										'<div class="pull-right">'+
							               '<i class="fa fa-angle-up"></i>&nbsp;&nbsp;'+
							           '</div>'+
							        '</h4>'+
							        '<div id="infotab">'+
										'<table id="tab">'+
					                		'<tr>'+
					                			'<td width="20%" align="center">Remark</td>'+
					                			'<td width="20%" align="center">Description</td>'+
					                			'<td width="20%" align="center">Amount</td>'+
					                			'<td width="20%" align="center">Exchange Amount</td>'+
					                			'<td width="20%" align="center">USD</td>'+
					                			'<td width="100px" align="center">Action</td>'+
					                		'</tr>';
					                		str1 = "";
					                		$.each(map.listInvoiceAndCreditItems,function(index,invoiceAndCreditItems){
					                			str1+= '<tr>'+
						                			'<td align="center"><input type="text"  id="tourCode"  value="'+invoiceAndCreditItems.remarks+'" class="form-control" style="width:230px;"/></td>'+
						                			'<td align="center"><input type="text"  id="description"  value="'+invoiceAndCreditItems.description+'" class="form-control" style="width:100px;"/></td>'+
						                			'<td align="center">'+
						                				'<input type="text"  value="'+invoiceAndCreditItems.amount+'" class="form-control" style="width:100px;"/>'+
						                			'</td>'+
						                			'<td align="center">'+
						                				'<input type="text" readonly="readonly" value="'+invoiceAndCreditItems.afteramount+'" class="form-control" style="width:100px;"/>'+
						                			'</td>'+
						                			'<td align="center">'+
						                				'<input type="text" readonly="readonly" value="'+invoiceAndCreditItems.dollarAmount+'" class="form-control" style="width:100px;"/>'+
						                			'</td>'+
						                			'<td align="center"><button type="button" id="removeButton" class="btn btn-default">REMOVE</button></td>'+
						                		'</tr>';
					                		});
					                		str+=str1;
					                		str2 = "";
					                		str2 = '<tr id="lastTr" style="border-top:#2BBCA0 solid 5px;">'+
						                			'<td align="center" width="20%">'+
						                				'ROE($)'+
						                				'<input type="hidden"  id="rateOfCurrencyId" name="rateOfCurrencyId" value="'+map.invoiceAndCredit.rateOfCurrencyId+'"/>'+
						                				'<input type="hidden"  id="rateUp" value="'+map.rateOfCurrency.rateUp+'/'+map.rateOfCurrency.rateDown+'"/>'+
						                				'<input type="hidden"  id="rateDown" value="'+map.rateOfCurrency.rateDown+'"/>'+
						                				'<input type="hidden"  id="usRate" value="'+map.rateOfCurrency.usRate+'"/>'+
						                			'</td>'+
						                			'<td align="center" width="20%"><input type="text" id="changeRateInput" value="'+map.rateOfCurrency.rateUp+'/'+map.rateOfCurrency.rateDown+'" readonly="readonly" class="form-control" style="width:100px;"/></td>'+
						                			'<td align="center" width="20%">'+
						                				'<span id="allAmount" size="10px">'+map.invoiceAndCredit.enterCurrency+'</span>'+
						                				'<input type="hidden"  id="enterCurrency" name="enterCurrency" value="'+map.invoiceAndCredit.enterCurrency+'"/>'+
						                			'</td>'+
						                			'<td align="center" width="20%"><span id="allAfterAmount" size="10px">0</span></td>'+
						                			'<td align="center" width="20%">'+
						                				'<span id="allDollarAmount" size="10px">$'+map.invoiceAndCredit.dollar+'</span>'+
						                			'</td>'+
						                			'<td align="center" width="300px">'+
						                				'<button type="button" id="addButton" onclick="addTr()" class="btn btn-default" size="25">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </button>'+
						                			'</td>'+
						                		'</tr>'+
					                	'</table>'+
					               	'</div>'+
					              '</div>'+
			              '<div class="form-group">'+
			                '<div style="border:1px dashed #ccc; width:60%;">'+
			                	'<form id="verifyForOnlyFormId" style="border-radius: 0px;" method="post">'+
			                	'<input type="hidden" id="invoiceId" name="invoiceAndCreditId" value="'+map.invoiceAndCredit.invoiceAndCreditId+'">'+
						      	  '<div id="checkId"></div>'+
							      '<div class="modal-body form" >'+
							      	 '<div class="form-group">'+
						                '<div>'+
						                	'<div>'+
						                	'Auditing&nbsp;&nbsp; Status：'+
										  '&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="passForOnly" value="1">&nbsp;&nbsp;&nbsp;&nbsp;Auditing Disapproved &nbsp;&nbsp;&nbsp;&nbsp;'+
						                   '<input checked type="radio" name="passForOnly" value="2">&nbsp;&nbsp;&nbsp;&nbsp;Auditing Approved'+
						                   '</div>'+
						                   '<div style="margin-top:10px;">'+
						                'Auditing Remark：&nbsp;&nbsp;&nbsp;&nbsp;<input name="remark" id="remarkForOnly"  style="width:301px; height:32px;" value=" "/>'+
						                  '</div>'+
						              '</div>'+
							      '</div>'+
						      '</form>'+
							  '<input type="button" style="margin-left:80%;width:80px;height:35px;" value="OK" onclick="approveForOnlySubmit();">'+
			                '</div>'+
			              '</div>'+
			            '</div>';
			            str+=str2;
			            $("#accInfo").append(str);
			            allAfterAmount = (parseFloat(map.invoiceAndCredit.enterCurrency)/(map.rateOfCurrency.rateDown)*(map.rateOfCurrency.rateUp)).toFixed(2);
			            $("#allAfterAmount").html(allAfterAmount);
			            $("#alertInfoButton").click();
                    }
				})
	};
	
	function approveForOnlySubmit(){
	 var invoiceId = $("#invoiceId").val();
	 var remark = $("#remarkForOnly").val();
	 var pass = $("input[name=passForOnly]:checked").val();
		$("#closeForm").click();
		$.ajax({
                type: "POST",
                data: $("#verifyForOnlyFormId").serialize(),
                url:"${base}/admin/invoiceAndCredit/verifyDeptId.jhtml",
                success: function(map) {
                	$("#"+invoiceId).parent().parent().parent().parent().children('td').eq(0).html("");
                	$("#"+invoiceId).parent().parent().parent().parent().children('td').eq(8).html(remark);
                	if(pass==2){
                		$("#"+invoiceId).parent().parent().parent().parent().children('td').eq(10).html('<i title="Approved" class="fa fa-check"></i>');
                	}else if(pass==1){
                		$("#"+invoiceId).parent().parent().parent().parent().children('td').eq(10).html('<i title="DisApproved" class="fa fa-times"></i>');
                	}
                    alert(map.message);
                    }
				});
	};
	
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
<script src="[@spring.url '/resources/js/basic/custom-general.js'/]" type="text/javascript"></script>
</body>
</html>
