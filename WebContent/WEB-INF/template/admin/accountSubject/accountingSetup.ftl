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
		.rounded-rectangular {
			width:42%;
			height:500px;
			border:1px solid #ccc;
			overflow-y:auto;
			border-radius: 6px;
		}
		.tableHead{
			font-weight:bold; 
			font-size:14px;
			background:#99ccff;
		}
		li{list-style-type:none;}
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
            <h2>Subject Settings</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Subject Settings</a></li>
            </ol>
        </div>
    <div class="cl-mcont">
		<div class="row">
			<div class="col-md-12">
				<div class="tab-content block-flat">
					<div class="pull-right" style="width:165px; margin-top:10px;margin-bottom:8px;">
					    <select id="subjectType" class="select2" name="subjectType" onchange="subjectTypeChange();" >
					    		  <option value="3">SALES INCOME</option>
							      <option value="4">TOUR COST</option>
							      <option value="1">Gross Profit</option>
							      <option value="2">Expense</option>
						</select>
			        </div> 
					<div style="clear:both;height:500px;">
						<div id="globalAccount" class="rounded-rectangular" style="float:left;margin-left:2%;">
							<form id="globalFinanceForm" action="" method="post">
								<table style="clear:both;">
									<thead>
										<tr>
											<th class="tableHead">Select</th>
											<th class="tableHead">Subject Code</th>
											<th class="tableHead">Subject Name</th>
										</tr>
									</thead>
									<tbody id="globalFinanceForTable">
										[#list globalAccountList as globalAccount]
											<tr font-weight:bold;">
												<td align="left"><input type="checkbox" name="globalAccountId" id="check_box_0" /></td>
												<td align="left">${globalAccount.subjectCode}</td>
												<td align="left">${globalAccount.subjectName}</td>
												<input type="hidden" disabled="true" name="accountSubjectList[${globalAccount_index}].subjectCode"  value="${globalAccount.subjectCode}">
												<input type="hidden" disabled="ture" name="accountSubjectList[${globalAccount_index}].subjectName"  value="${globalAccount.subjectName}">
												<input type="hidden" disabled="true" name="accountSubjectList[${globalAccount_index}].level"  	   value="${globalAccount.level}">
												<input type="hidden" disabled="ture" name="accountSubjectList[${globalAccount_index}].subjectType"  value="${globalAccount.subjectType}">
												<input type="hidden" disabled="true" name="accountSubjectList[${globalAccount_index}].directionOfBalance"  value="${globalAccount.directionOfBalance}">
												<input type="hidden" disabled="ture" name="accountSubjectList[${globalAccount_index}].hasChild"  value="${globalAccount.hasChild}">
												<input type="hidden" disabled="ture" name="accountSubjectList[${globalAccount_index}].globalAccountId"  value="${globalAccount.globalAccountId}">
											</tr>	
										[/#list]
									</tbody>
								</table>
							</form>
						</div>
						<div style="float:left;margin-top:80px;">
							<ul style="clear:both;">
								<li><button id="add" class="btn btn-default" style="background:#DCDCDC; width:70px;" onclick="add();">Add&gt;&gt;</button></li>
								<li style="margin-top:20px;"><button id="remove" style="background:#DCDCDC;width:70px;" class="btn btn-default" onclick="removeTr();">&lt;&lt;Remove</button></li>
							</ul>
						</div>
						<div id="accountSubject" class="rounded-rectangular" style="float:left;margin-left:3%;">
							<form id="financeForm" action="" method="post">
								<table style="clear:both;">
									<thead>
										<tr>
											<th class="tableHead">Select</th>
											<th class="tableHead">Subject Code</th>
											<th class="tableHead">Subject Name</th>
										</tr>
									</thead>
									<tbody id="financeForTable">
										[#list accountSubjectList as accountSubject]
											<tr font-weight:bold;">
												<td align="left"><input name="accountSubjectId" type="checkbox" value="${accountSubject.accountSubjectId}"/></td>
												<td align="left">${accountSubject.subjectCode}</td>
												<td align="left">${accountSubject.subjectName}</td>
											</tr>	
										[/#list]
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
	   </div>
	</div>
</div>
</div>
</div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	$("#tab-content block-flat").attr("height","100%");
       });
       
        function subjectTypeChange(){
    	var subjectType = $("#subjectType").val();
    	$.ajax({
				type:"GET",
				url:"${base}/admin/accountSubject/accountingSetupForSubjectType.jhtml?subjectType="+subjectType,
				dataType:"json",
				success:function(map) {
					$("#globalAccount").html("");
					$("#accountSubject").html("");
					var str1 = "";
					var str2 = "";
					str1 += '<form id="globalFinanceForm" action="" method="post">'+
					'<table>'+
				        '<thead>'+
					         '<tr>'+
								'<th class="tableHead"><input type="checkbox" value="" id="check_box_0" />Select</th>'+
								'<th class="tableHead">Subject Code</th>'+
								'<th class="tableHead">Subject Name</th>'+
							'</tr>'+
				        '</thead>'+
		        		'<tbody id="globalFinanceForTable">';
					$.each( map.globalAccountList,function(index,globalAccount){
							globalAccountId = globalAccount['globalAccountId'];
							str1+='<tr font-weight:bold;">'+
							'<td align="left"><input name="globalAccountId" type="checkbox" value='+globalAccount["globalAccountId"]+' id="check_box_0" /></td>'+
							'<td align="left">'+globalAccount['subjectCode']+'</td>'+
							'<td align="left">'+globalAccount['subjectName']+'</td>'+
							'<input type="hidden" disabled="true" name="accountSubjectList['+index+'].subjectCode" value='+globalAccount['subjectCode']+'>'+
							'<input type="hidden" disabled="true" name="accountSubjectList['+index+'].subjectName" value="'+globalAccount['subjectName']+'">'+
							'<input type="hidden" disabled="true" name="accountSubjectList['+index+'].level"  	  value='+globalAccount['level']+'>'+
							'<input type="hidden" disabled="true" name="accountSubjectList['+index+'].subjectType"  value='+globalAccount['subjectType']+'>'+
							'<input type="hidden" disabled="true" name="accountSubjectList['+index+'].hasChild"  value='+globalAccount['hasChild']+'>'+
							'<input type="hidden" disabled="true" name="accountSubjectList['+index+'].globalAccountId"  value='+globalAccount['globalAccountId']+'>'+
						'</tr>';
						});
					str1+='</tbody>'+
					'</table>'+
					'</form>';
					$("#globalAccount").append(str1);
					
					//部门科目
					str2 += '<form id="financeForm" action="" method="post">'+
					'<table>'+
				        '<thead>'+
					         '<tr>'+
								'<th class="tableHead"><input type="checkbox"/>Select</th>'+
								'<th class="tableHead">Subject Code</th>'+
								'<th class="tableHead">Subject Name</th>'+
							'</tr>'+
				        '</thead>'+
		        		'<tbody id="financeForTable">';
					$.each( map.accountSubjectList,function(index,accountSubject){
							str2+='<tr font-weight:bold;">'+
							'<td align="left"><input name="accountSubjectId" type="checkbox" value='+accountSubject['accountSubjectId']+'></td>'+
							'<td align="left">'+accountSubject['subjectCode']+'</td>'+
							'<td align="left">'+accountSubject['subjectName']+'</td>'+
						'</tr>';
						});
					str2+='</tbody>'+
					'</table>'+
					'</form>';
					$("#accountSubject").append(str2);
				}
				})
    };
    //点击添加按钮
    function add(){
    	//获取以选中的会计科目
    	var gFSForSize = $('input[name="globalAccountId"]:checked').length;
    	$('input[name="globalAccountId"]:checked').each(function(){
    		$(this).parent().parent().find("input").attr("disabled",false);
    	});
    	if(gFSForSize==0){
    		alert("Select Add Items！");
    	}else{
			$.ajax({
				url:'addAccountSubjectForDept.jhtml',
				data: $("#globalFinanceForm").serialize(),
				type:"POST",
				success:function(map){
					$('input[name="globalAccountId"]:checked').each(function(){
		    			str = $(this).parent().parent().html();
		    			str1 = '<tr font-weight:bold;">'+str+'</tr>';
		    			$("#financeForTable").append(str1);
		    			$(this).parent().parent().remove();
  					}); 
					alert(map.ok);
				}
			});
  		}
    }
    //点击移除按钮
    function removeTr(){
    	fsSize = $('input[name="accountSubjectId"]:checked').length;
    	if(fsSize==0){
    		alert("Select Delete Items");
    	}else{
    	$.ajax({
    		url:'deleteAccountSubject.jhtml',
				data: $("#financeForm").serialize(),
				type:"POST",
				success:function(map){
			    	$('input[name="accountSubjectId"]:checked').each(function(){
			    			str = $(this).parent().parent().html();
			    			str1 = '<tr font-weight:bold;">'+str+'</tr>';
			    			$("#globalFinanceForTable").append(str1);
			    			$(this).parent().parent().remove();
			  			});
			  			alert(map.ok);
	  			}
	  			})
  		} 
    }
</script>
</body>
</html>
