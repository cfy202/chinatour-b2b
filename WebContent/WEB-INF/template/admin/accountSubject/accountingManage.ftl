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
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Subject Manage</h3>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertChangeChildAccDeptButton" data-modal="form-primary1">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertEditAccountSubectButton" data-modal="form-primary2">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <div style="display:none;"><a class="btn btn-success btn-flat md-trigger" type="hidden" id="alertAddAccountSubectButton" data-modal="form-primary3">&nbsp;&nbsp; New &nbsp;&nbsp;</a></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Subject Manage</a></li>
            </ol>
        </div>
       <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
					<div class="tab-content block-flat">
                        <div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-angle-down"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="margin:10px; padding:5px 0;">
								<div  class="nav-panel">
									<div  class="nav-block">
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" id="search_subjectCode" size="14"  placeholder="SubjectCode." />
													<input type="text" id="search_subjectName" size="14"  placeholder="SubjectName." />
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
		                        	<select id="subjectType" class="select2" name="subjectType" onchange="subjectTypeChange();" >
		                        			<option [#if subjectType=="3"]selected="selected"[/#if] value="3">SALES INCOME</option>
		                        			<option [#if subjectType=="4"]selected="selected"[/#if] value="4">TOUR COST</option>
				                        	<option [#if subjectType=="1"]selected="selected"[/#if] value="1">Gross Profit</option>
				                        	<option [#if subjectType=="2"]selected="selected"[/#if] value="2">Expense</option>
				                  	</select>
            					</div>
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
	                                    <tr>
	                                        <th>Code</th>
	                                        <th>Subject Name</th>
	                                        <th>Accounting Department</th>
	                                        <th width="300px">Action</th>
	                                    </tr>
                                    </thead>
                              </table>
						</div>
					</div>
				</div>
    		</div>
		</div>
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary1" style="width:20%;">
    <div class="md-content">
      <div class="modal-header">
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4>Select Accounting Department</h4>
      </div>
	     <div class="modal-body form">
	     	<form  action="changeAccChildDept.jhtml" id="changeChildAccDeptForm" method="post">
	     		<select name="childAccDept" class="select2" id="accDeptChange">
	     			[#list groupList as groupList]
	     				<option value="${groupList.groupId}">${groupList.name}</option>
	     			[/#list]
	     		</select>
	    		<input type="hidden" id="changeAccountSubjectId" name="accountSubjectId">
	    		<input type="hidden" name="childAccDeptName" id="childAccDeptName">
	    		<input type="hidden" name="subjectType" id="subjectTypeForChange">
	     	</form>
	    		<div class="modal-footer">
			        <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			        <button id="submitButtonForChange" class="btn btn-default btn-flat md-close" data-dismiss="modal">OK</button>
		    	</div>
	     
	    </div>
   </div>
</div>

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary2" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <h4>Modify</h4>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
	     <div class="modal-body form">
	      <form action="changeAccChildDept.jhtml" id="editAccountSubjectForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			<table>
	    				<tr>
	    					<td>The Current Code:</td>
	    					<td id="subjectCodeForNow"></td>
	    				</tr>
	    				<tr>
	    					<td>Modify Code:</td>
	    					<td id="subjectCodeForTd">
	    						
	    					</td>
	    					<input type="hidden" name="subjectCode" id="subjectCodeForEdit">
	    					<input type="hidden" name="" id="parentSubjectCodeForEdit">
	    					<input type="hidden" name="accountSubjectId" id="accountSubjectIdForEdit">
	    					<input type="hidden" name="subjectType" id="subjectTypeForEdit">
	    				</tr>
	    				<tr>
	    					<td>Subject Name:</td>
	    					<td id="subjectNameForEdit">
	    						<input type="text" name="subjectName" id="subjectNameForInput">
	    					</td>
	    				</tr>
	    			</table>
	    		</div>
	     </form>
	     <div class="modal-footer">
			 <button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
			 <button id="submitButtonForEditAcc" class="btn btn-default btn-flat md-close" data-dismiss="modal">OK</button>
		  </div>
	    </div>
   </div>
</div>

<div class="md-modal colored-header custom-width md-effect-9" id="form-primary3" style="width:30%;">
    <div class="md-content">
      <div class="modal-header">
        <h4>New</h4>
        <button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
	     <div class="modal-body form">
	      <form action="addAccountSubject.jhtml" id="addAccountSubjectForm" style="border-radius: 0px;" method="post">
	    		<div>
	    			<table>
	    				<tr>
	    					<td>Superiors Name:</td>
	    					<td id="subjectNameForparent"></td>
	    				</tr>
	    				<tr>
	    					<td>Subject Code:</td>
	    					<td id="subjectCodeForAddTd">
	    						
	    					</td>
	    				</tr>
	    				<input id="subjectCodeForAdd" type="hidden" name="subjectCode">
	    				<input id="subjectTypeForAdd" type="hidden" name="subjectType">
	    				<input id="parentSubjectIdForAdd" type="hidden" name="parentSubjectId">
	    				<input id="parentSubjectCodeForAdd" type="hidden" name="parentSubjectCode">
	    				<tr>
	    					<td>Subject Name:</td>
	    					<td>
	    						<input type="text" name="subjectName" id="subjectNameForAdd">
	    					</td>
	    				</tr>
	    			</table>
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
            "ajax": {
                url: "[@spring.url '/admin/accountSubject/accountingManage.jhtml'/]",
                type: "POST",
                data:function(d){
                	d.subjectType=$("#subjectType").val();
                	d.subjectCode=$("#search_subjectCode").val();
                	d.subjectName=$("#search_subjectName").val();
                }
            },
            "columns": [
                { "data": "subjectCode"},
                { "data": "subjectName" },
                { "data": "childAccDept",
                	"render" : function(data, type, row) {
						 	if(row.accountSubjectId!='null'&&row.childAccDept!=null&&row.childAccDept!=''){
						  		return '<a class="changeAccDept" id="'+row.accountSubjectId+'" onclick="changeAccDept(\''+row.accountSubjectId+'\')">'+row.childAccDeptName+'</a>';
						  	}else{
						  		return '<a class="changeAccDept" id="'+row.accountSubjectId+'" onclick="changeAccDept(\''+row.accountSubjectId+'\')">select</a>';
						  	}
						  return '';
					}},
                { "data": "accountSubjectId"}
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					if(row.level=="2"){
						return '<div class="btn-group" style="width:90px"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li onclick="addAccountSubject(\''+row.accountSubjectId+'\',\''+row.subjectCode+'\',\''+row.subjectName+'\',\''+row.parentSubjectCode+'\',\''+row.subjectType+'\')"><a href="#"><i class="fa fa-pencil"></i>Add Tertiary Catalog</a></li><li onclick="deleteSubject(\''+row.accountSubjectId+'\')"><a href="#"><i class="fa fa-times"></i>delete</a></li></ul></div>';
					}else if(row.level=="3"){
						return '<div class="btn-group" style="width:90px"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button" style="height:23px"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right"><li onclick="editAccountSubject(\''+row.accountSubjectId+'\',\''+row.subjectCode+'\',\''+row.subjectName+'\',\''+row.parentSubjectCode+'\')"><a href="#"><i class="fa fa-pencil"></i>edit</a></li><li onclick="deleteSubject(\''+row.accountSubjectId+'\')"><a href="#"><i class="fa fa-times"></i>delete</a></li></ul></div>';
					}else{
						return '';
					}
                 },
				"targets" :3
		  }]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
       	
    }
    
    function subjectTypeChange(){
    	init();
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
   // 弹出修改对账部门对话框 
   function changeAccDept(accountSubjectId){
   		$("#changeAccountSubjectId").val(accountSubjectId);
   		$("#subjectTypeForChange").attr("value",$("#subjectType").val());
   		$("#alertChangeChildAccDeptButton").click();
   }
   
   $("#submitButtonForChange").click(function(){
   		str = $("#accDeptChange").find("option:selected").text();
   		$("#childAccDeptName").attr("value",str);
   		$("#changeChildAccDeptForm").submit();
   });
   	//修改或添加对账部门(ajax)
    function changeChildDept(accountSubjectId){
    	$.ajax({
			url:'changeAccChildDept.jhtml',
			data: $("#changeChildAccDeptForm").serialize(),
			type:"POST",
			success:function(){
				alert("a");
			}
		});
    }
    
    //设置修改科目时的form表单的内容
    function editAccountSubject(sujectId,subjectCode,subjectName,parentSubjectCode){
    	$("#accountSubjectIdForEdit").attr("value",sujectId);
    	parentSubjectCode = subjectCode.substring(0,8);
    	$("#parentSubjectCodeForEdit").attr("value",parentSubjectCode);
    	$("#subjectCodeForNow").html(subjectCode);
    	var subjectCodeForTd = parentSubjectCode+'-<input name="" id="subjectCodeForChild" type="text" style="width:127px;">';
    	$("#subjectCodeForTd").html(subjectCodeForTd);
    	$("#subjectNameForInput").attr("value",subjectName);
    	$("#subjectTypeForEdit").attr("value",$("#subjectType").val());
    	$("#alertEditAccountSubectButton").click();
    }
    
    //修改form表单ajax提交
   /* function changeAcc(){
    	subjectCode = $("#parentSubjectCodeForEdit").val()+"-"+$("#subjectCodeForChild").val();
    	$("#subjectCodeForEdit").attr("value",subjectCode);
    	$.ajax({
			url:'changeAccChildDept.jhtml',
			data: $("#editAccountSubjectForm").serialize(),
			type:"POST",
			success:function(){
				alert("a");
			}
		});
    }*/
    
    //弹出子科目增加对话框
    function addAccountSubject(sujectId,subjectCode,subjectName,parentSubjectCode,subjectType){
    	str = subjectCode+"-"+subjectName;
    	subjectCodeHtml=subjectCode+'-'+'<input type="text" style="width:127px;" name="subjectCodeForChild" id="subjectCodeForAddChild">'; 
    	$("#subjectCodeForAddTd").html(subjectCodeHtml);
    	$("#subjectNameForparent").html(str);
    	$("#parentSubjectCodeForAdd").val(subjectCode);
    	$("#subjectTypeForAdd").val(subjectType);
    	$("#parentSubjectIdForAdd").val(sujectId);
    	$("#alertAddAccountSubectButton").click();
    }
    //ajax提交增加子科目表单
    /*function addAcc(){
    	$.ajax({
			url:'addAccountSubject.jhtml',
			data: $("#addAccountSubjectForm").serialize(),
			type:"POST",
			success:function(){
				alert("a");
			}
		});
    }*/
    

    
    //提交修改表单
    $("#submitButtonForEditAcc").click(function(){
    	subjectCode = $("#parentSubjectCodeForEdit").val()+"-"+$("#subjectCodeForChild").val();
    	$("#subjectCodeForEdit").val(subjectCode);
    	$("#editAccountSubjectForm").submit();
    });
    //提交子科目表单
    $("#submitButtonForAddAcc").click(function(){
    	subjectCodeForAdd = $("#parentSubjectCodeForAdd").val()+"-"+$("#subjectCodeForAddChild").val();
    	$("#subjectCodeForAdd").val(subjectCodeForAdd);
    	$("#addAccountSubjectForm").submit();
    });
    
    $("#accDeptChange").change(function(){
    	str = $(this).find("option:selected").text();
    	$("#childAccDeptName").attr("value",str);
    });
    
    
        //删除科目
    function deleteSubject(sujectId){
    	if(confirm("确定删除此科目吗？")){
    		$.ajax({
				url:'deleteSubject.jhtml?accountSubjectId='+sujectId,
				data: sujectId,
				type:"POST",
				success:function(map){
		    		$("#"+sujectId).parent().parent().remove();
				}
			});
    	}
		
    }
</script>
</body>
</html>
