[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
	<style type="text/css" media="screen">
		a{cursor:pointer;}
	</style>
    <title>${message("admin.main.title")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>
<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i> Warning !</h4>

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
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Report Manage</h3>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertEffectiveDataButton" data-modal="form-primary3">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <div class="pull-right option-left">
            	<div class="btn-group">
					  <button type="button" onclick="location.href='addAccountForSalesIncome.jhtml'" class="btn btn-success md-trigger"  style="height:33px;">&nbsp;&nbsp;&nbsp;&nbsp; NEW &nbsp;&nbsp;&nbsp;&nbsp;</button>
					  <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown"  style="height:33px;">
						<span class="caret"></span>
						<span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" id="effectiveDataButton">Submit the effective data</a></li>
						<li><a href="javascript:void(0)" id="printButton">Into Account</a></li>
						<li><a href="javascript:void(0)" onclick="location.href='searchInfoForDept.jhtml'" id="searchInfo">View Report</a></li>
					  </ul>
				</div>
				
            </div>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertEditButton" data-modal="form-primary1">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Report Manage</a></li>
            </ol>
        </div>
       <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
			<div class="block-flat">
				<div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<!--模拟点击弹出框按钮-->
							<a href="javascript:void(0);" class="md-trigger" data-modal="form-primary" id="triggerId"></a>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-caret-square-o-down fa-lg color-blue"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="margin:10px; padding:5px 0;">
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Type</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="typeSpan" checked="false" onclick="change(this,1);">INCOME</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="typeSpan" checked="false" onclick="change(this,2);" >COST</span> 
													</a> 
													<input type="hidden" id="typeSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Into Account Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="ifCloseSpan" checked="false" onclick="change(this,1);">Has Taken Account</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="ifCloseSpan" checked="false" onclick="change(this,0);" >No Into Account</span> 
													</a> 
													<input type="hidden" id="ifCloseSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Data Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="dataSpan" checked="false" onclick="change(this,0);">Effective</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="dataSpan" checked="false" onclick="change(this,2);" >Invalid</span> 
													</a> 
													<input type="hidden" id="dataSpan"/>
												</div>
											</div>
										</div>
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Month</span>:
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
													<input type="text" size="14" id="search_subjectCode" placeholder="subjectCode..." />
													<input type="text" size="14" id="search_subjectName" placeholder="subjectName..." />
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
						</div>
					<div class="tab-content block-flat">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
	                                    <tr>
	                                        <th width="15%">Code</th>
	                                        <th width="15%">Subject Name</th>
	                                        <th width="8%">Amount</th>
	                                        <th width="9%">Month</th>
	                                        <th width="20%">Remark</th>
	                                        <th width="8%">Status</th>
	                                        <th width="10%">Into Account Status</th>
	                                        <th width="300px">Action</th>
	                                    </tr>
                                    </thead>
                              </table>
						</div>
					</div>
				</div>
    		</div>
		</div>
		
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary1" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <h4>Modiry Report</h4>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
	     <div class="modal-body form">
	      <form action="updateBusinessFlow.jhtml" id="editBusinessFlowForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			<table>
	    				<tr>
	    					<td>Subject Code:</td>
	    					<td id="subjectCode"></td>
	    				</tr>
	    				<tr>
	    					<td>Subject Name:</td>
	    					<td id="subjectName">
	    						
	    					</td>
	    				</tr>
	    				<tr>
	    					<td>Month:</td>
	    					<td id="month">
	    					</td>
	    				</tr>
	    				<tr>
	    					<td>Amount:</td>
	    					<td id="money">
	    						<input type="text" name="accountsSum" id="accountsSum">
	    					</td>
	    				</tr>
	    				<tr>
	    					<td>Remark:</td>
	    					<td>
	    						<input type="text" name="remark" id="remark">
	    					</td>
	    				</tr>
	    				<input type="hidden" name="businessFlowId" id="businessFlowId">
	    			</table>
	    		</div>
	     </form>
	     <div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button id="submitButtonForAddAcc" class="btn btn-default btn-flat md-close" onclick="addAcc()">OK</button>
		    	</div>
	     
	    </div>
   </div>
</div>

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary3" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <h4>Are you sure submit the effective data？</h4>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
	     <div class="modal-body form">
	      <form action="addAccountSubject.jhtm" id="effectiveDataForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			Select Month：<input id="accountDateStr" type="text" name="accountDateStr">
	    		</div>
	     </form>
	    		<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button id="submitButtonForAddAcc" class="btn btn-default btn-flat md-close" data-dismiss="modal" onclick="addAcc()">OK</button>
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
        [@flash_message /]
        init();
    });
    function init(){
    	$("#datatable2").dataTable().fnDestroy(); 
        $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/accountSubject/businessFlowManage.jhtml'/]",
                type: "POST",
                data:function(d){
                	d.subjectCode = $("#search_subjectCode").val();
                	d.subjectName = $("#search_subjectName").val();
                	d.beginningDate = $("#search_beginningDate").val();
                	d.endingDate = $("#search_endingDate").val();
                	d.ifClose = $("#ifCloseSpan").val();
                	d.subjectType = $("#typeSpan").val();
                	d.isAvailable = $("#dataSpan").val();
                }
            },
            "columns": [
                { "data": "subjectCode"},
                { "data": "subjectName" },
                { "data": "accountsSum"},
                { "data": "accountDate",
                "render" : function(data, type, row) {
					  	return data.substring(0,data.length-3);
					}},
                { "data": "remark" },
                { "data": "isAvailable",
                	"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return '<i title="Invalid" class="fa fa-clock-o"></i>';
					  		case 1 : return '<i title="Effective" class="fa fa-clock-o"></i>';
					  	}
					}},
                { "data": "ifClose",
                	"render" : function(data, type, row) {
					  	switch(data){
					  		case 0 : return '<i title="No Into Account" class="fa fa-clock-o"></i>';
					  		case 1 : return '<i title="Has Taken Account" class="fa fa-check"></i>';
					  	}
					}},
                { "data": "businessFlowId"}
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
						return '<div class="btn-group" style="width:90px"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li><a href="#" onclick="alertForm(\''+row.businessFlowId+'\',\''+row.subjectCode+'\',\''+row.subjectName+'\',\''+row.accountDate+'\',\''+row.accountsSum+'\',\''+row.remark+'\')"><i class="fa fa-pencil"></i>Edit</a></li><li class="divider"></li><li><a data-href="delBusinessFlow.jhtml?id='+data+'" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li></ul></div>';
                 },
				"targets" :7
		  }]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
       	
    }
    
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
		
		$("#clearDate").click(function(){
		$("#search_beginningDate").val('');
		$("#search_endingDate").val('');
	});
	
	$("#search_beginningDate").datepicker({dateFormat: 'yy-mm',changeYear: true,changeMonth: true });
	$("#search_endingDate").datepicker({dateFormat: 'yy-mm',changeYear: true,changeMonth: true });
	
	
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
   
   function alertForm(businessFlowId,subjectCode,subjectName,month,money,remark){
	   	$("#subjectCode").html(subjectCode);
	   	$("#subjectName").html(subjectName);
	   	month = month.substring(0,7);
	   	$("#month").html(month);
	   	$("#accountsSum").attr("value",money);
	   	if(remark=="null"){
	   		remark="";
	   	}
	   	$("#remark").attr("value",remark);
	   	$("#businessFlowId").attr("value",businessFlowId);
	   	$("#alertEditButton").click();
   }
   
   function addAcc(){
   		$("#editBusinessFlowForm").submit();
   }
   
   $("#effectiveDataButton").click(function(){
   		$("#alertEffectiveDataButton").click();
   });
   
   $("#accountDateStr").datepicker({dateFormat: 'yy-mm',changeYear: true,changeMonth: true });
</script>
</body>
</html>
