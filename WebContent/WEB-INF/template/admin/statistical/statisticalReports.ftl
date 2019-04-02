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
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Statistics</h3>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Statistic Reports</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">							
				           <h3>Filter</h3>
				         </div>
				         <div class="options" style="padding:10px;">
				         <input type="hidden" value="${menuId}" id="menuId"/>
			          		<input type="hidden" value="ceo" id="role"/>
							<label>
				            	<select  class="select2" id="time">
									[#list constant.BRAND_YEAR as val]
										<option value="${val}"[#if "${statistical.time==val}"]selected="selected"[/#if]>${val}</option>
									[/#list]
								</select>
							</label>
								To
							<label>
								<select  class="select2" id="date">
									[#list constant.BRAND_YEAR as val]
										<option value="${val}"[#if "${statistical.date==val}"]selected="selected"[/#if]>${val}</option>
									[/#list]
								</select>
							</label>
							&nbsp;
							<label>
				            	<select  class="select2" id="isSelfOrganize">
									<option value="0" [#if "${statistical.isSelfOrganize=0}"]selected="selected"[/#if]>Booking</option>
									<option value="1" [#if "${statistical.isSelfOrganize=1}"]selected="selected"[/#if]>Arrival</option>
								</select>
							</label>
							<label>
				            	<select  class="select2" id="deptId" [#if role="Office" || role="Agent"]disabled="disabled"[/#if] >
									<option value="">Select Office ...</option>
									[#list dept as dept]
										<option value="${dept.deptId}"[#if "${dept.deptId=statistical.deptId}"]selected="selected"[/#if]>${dept.deptName}</option>
									[/#list]
								</select>
							</label>
							<label>
								<select  class="select2" id="brand">
									<option value="">Select ... </option>
									[#list constant.BRAND_ITEMS as val]
										<option value="${val}"[#if "${statistical.brand==val}"]selected="selected"[/#if]>${val}</option>
									[/#list]
								</select>
							</label>
							<label>
				            	<select  class="select2" id="orderType">
									<option value="">Select ... </option>
									<option value="2" [#if "${statistical.orderType=2}"]selected="selected"[/#if]>Tour Booking</option>
									<option value="5" [#if "${statistical.orderType=5}"]selected="selected"[/#if]>Other Booking</option>
								</select>
							</label>
							<label>
				            	<select  class="select2" id="orderTourType">
									<option value="">Select ... </option>
									<option value="0" [#if "${statistical.orderTourType=0}"]selected="selected"[/#if]>Wholesale</option>
									<option value="1" [#if "${statistical.orderTourType=1}"]selected="selected"[/#if]>Retail</option>
								</select>
							</label>
							<br />
							<label>
								<select  class="select2" id="agent" [#if role="Agent"]disabled="disabled"[/#if]>
									<option value="">Select Agent ...</option>
									[#list adminList as user]
										<option value="${user.username}"[#if "${user.username=statistical.agent}"]selected="selected"[/#if]>${user.username}</option>
									[/#list]
								</select>
							</label>
							<label style="width:40%">
								<input name="venderName" type="hidden">
								<input name="venderName" type="hidden" id="userSelect" style="width:100%" doName="4808" required="" value="${statistical.venderName}"/>
							</label>
							<label>
				            	<input type="text" id="beginningDate" name="bDate" size="14"  placeholder="Beginning Date." [#if (statistical.bDate)??]value="${statistical.bDate?string('MM-dd')}"[/#if] />
							</label>
								To
							<label>
								<input type="text" id="endingDate" name="eDate" size="14"  placeholder="Ending Date." [#if (statistical.eDate)??]value="${statistical.eDate?string('MM-dd')}"[/#if] />
							</label>
							
							<label>
								<input type="button" onclick="sear();" class="btn btn-primary" value="Search" style="margin:8px 0 0 6px;"/>
							</label>
				         </div>
			          <div class="content">
			              <div style="clear:both;"></div>
			              		<table id="dataTable2" class="ompTable" style="overflow:scroll;">
										<thead>
											<tr style="background-color:#F1F1F1">
												<th width="5%" style="font-weight:bold">Year</th>
												<th width="15%" style="font-weight:bold">Office</th>
												<th width="6%" style="font-weight:bold">Jan</th>
												<th width="6%" style="font-weight:bold">Feb</th>
												<th width="6%" style="font-weight:bold">Mar</th>
												<th width="6%" style="font-weight:bold">Apr</th>
												<th width="6%" style="font-weight:bold">May</th>
												<th width="6%" style="font-weight:bold">June</th>
												<th width="6%" style="font-weight:bold">Jul</th>
												<th width="6%" style="font-weight:bold">Aug</th>
												<th width="6%" style="font-weight:bold">Sep</th>
												<th width="6%" style="font-weight:bold">Oct</th>
												<th width="6%" style="font-weight:bold">Nov</th>
												<th width="6%" style="font-weight:bold">Dec</th>
												<th width="8%" style="font-weight:bold">SubTotal</th>
											</tr>
										</thead>
										<tbody class="no-border">
										[#list year as y]
											<tr style="border-top:3px solid #ffffff;">
												<td rowspan="${deptList.size()+1}" style="background-color:#FFEDD7;">${y}</td>
												
											</tr>
											[#list statisticalList as acc]
												[#if "${y=acc.date}"]
												<tr>
													[#if "${statistical.agent??}"]
													<td style="border-right:1px solid #ffffff;">${acc.agent}</td>
													[#elseif "${statistical.venderName??}"]
													<td style="border-right:1px solid #ffffff;">${acc.venderName}</td>
													[#else]
													<td style="border-right:1px solid #ffffff;">${acc.deptName}</td>
													[/#if]
													<td id="jan" style="border-right:1px solid #ffffff;">${acc.jan}</a></td>
													<td id="feb" style="border-right:1px solid #ffffff;">${acc.feb}</td>
													<td id="mar" style="border-right:1px solid #ffffff;">${acc.mar}</td>
													<td id="apr" style="border-right:1px solid #ffffff;">${acc.apr}</td>
													<td id="may" style="border-right:1px solid #ffffff;">${acc.may}</td>
													<td id="jun" style="border-right:1px solid #ffffff;">${acc.jun}</td>
													<td id="jul" style="border-right:1px solid #ffffff;">${acc.jul}</td>
													<td id="aug" style="border-right:1px solid #ffffff;">${acc.aug}</td>
													<td id="sep" style="border-right:1px solid #ffffff;">${acc.sep}</td>
													<td id="oct" style="border-right:1px solid #ffffff;">${acc.oct}</td>
													<td id="nov" style="border-right:1px solid #ffffff;">${acc.nov}</td>
													<td id="dec" style="border-right:1px solid #ffffff;">${acc.dec}</td>
													<td id="total">${acc.total}</td>
													<input id="tal${acc_index}" type="hidden" value="${acc.total}"/>
												</tr>		
												[/#if]
											[/#list]
										[/#list]
										<tr>
												<td colspan="2" style="font-weight:bold">GrandTotal</td>
												<td id="one" style="font-weight:bold"></td>
												<td id="two" style="font-weight:bold"></td>
												<td id="thr" style="font-weight:bold"></td>
												<td id="fou" style="font-weight:bold"></td>
												<td id="fiv" style="font-weight:bold"></td>
												<td id="six" style="font-weight:bold"></td>
												<td id="sev" style="font-weight:bold"></td>
												<td id="eig" style="font-weight:bold"></td>
												<td id="nin" style="font-weight:bold"></td>
												<td id="ten" style="font-weight:bold"></td>
												<td id="eve" style="font-weight:bold"></td>
												<td id="tew" style="font-weight:bold"></td>
												<td id="sub" style="font-weight:bold"></td>
											</tr>
									</tbody>
								</table>
							</div>
						</div>
			        </div>
        		</div>
		</div>
</div>
[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $("#beginningDate").datepicker({dateFormat: 'mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#endingDate").datepicker({dateFormat: 'mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
        $("#userSelect").select2({
			placeholder:"Select Agency ...",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				//url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
				url:'${base}/admin/vender/listSelect.jhtml?type=2&role='+$("#role").val(),	//地址(type=2供应商，查找type!=2)
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term); 
                    return {  
                         name: term   //联动查询的字符  
                     }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					dataA.push({id:"",text:"Search All"});
					for(var i=0;i<dataStr.venderList.length;i++){
						var vender = dataStr.venderList[i];
						 dataA.push({id: vender.venderId, text: vender.name});
					}
					
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		   
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/vender/listSelect.jhtml?type=2&role=ceo&venderId='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    	//	alert(JSON.stringify(data));
				    	//	alert(JSON.stringify(data.venderList[0].venderId));
				    		if(data.venderList[0]==undefined){
				    			callback({id:"",text:"Search Vender"});
				    		}else{
				    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) { return m; }
		});
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
	
        [@flash_message /]
		//统计纵向总数
		var one=0,two=0,thr=0,fou=0,fiv=0,six=0,sev=0,eig=0,nin=0,ten=0,eve=0,tew=0,sub=0;        
        $("td[id^='jan']").each(function(i){
        	one += parseFloat($(this).text());
        })
        $("td[id^='feb']").each(function(i){
        	two += parseFloat($(this).text());
        })
        $("td[id^='mar']").each(function(i){
        	thr += parseFloat($(this).text());
        })
        $("td[id^='apr']").each(function(i){
        	fou += parseFloat($(this).text());
        })
        $("td[id^='may']").each(function(i){
        	fiv += parseFloat($(this).text());
        })
        $("td[id^='jun']").each(function(i){
        	six += parseFloat($(this).text());
        })
        $("td[id^='jul']").each(function(i){
        	sev += parseFloat($(this).text());
        })
        $("td[id^='aug']").each(function(i){
        	eig += parseFloat($(this).text());
        })
        $("td[id^='sep']").each(function(i){
        	nin += parseFloat($(this).text());
        })
        $("td[id^='oct']").each(function(i){
        	ten += parseFloat($(this).text());
        })
        $("td[id^='nov']").each(function(i){
        	eve += parseFloat($(this).text());
        })
        $("td[id^='dec']").each(function(i){
        	tew += parseFloat($(this).text());
        })
        $("td[id^='total']").each(function(i){
        	sub += parseFloat($(this).text());
        })
        $("#one").html(one); $("#two").html(two);$("#thr").html(thr);$("#fou").html(fou);$("#fiv").html(fiv);$("#six").html(six);
        $("#sev").html(sev);$("#eig").html(eig); $("#nin").html(nin);$("#ten").html(ten);$("#eve").html(eve);$("#tew").html(tew);
        $("#sub").html(sub);
         for(var a=0;a<$("#valSize").val();a++){
        	var vals=changeTwoDecimal(parseFloat($("#tal"+a).val())/sub*100);
        	$("#talP"+a).text(vals+"%");
        }
    });
    
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
    
function sear() {
	var date=$("#date").val();
	var time=$("#time").val();
	var menuId=$("#menuId").val();
	var isSelfOrganize=$("#isSelfOrganize").val();
	var orderType=$("#orderType").val();
	var orderTourType=$("#orderTourType").val();
	var brand=$("#brand").val();
	var deptId=$("#deptId").val();
	var venderName=$("#userSelect").val();
	var agent=$("#agent").val();
	var bDate=$("#beginningDate").val();
	var eDate=$("#endingDate").val();
	location.href="${base}/admin/statistical/statisticalReports.jhtml?menuId="+menuId+"&date="+date+"&deptId="+deptId+"&time="+time+"&agent="+agent+"&venderName="+venderName+"&brand="+brand+"&orderType="+orderType+"&orderTourType="+orderTourType+"&isSelfOrganize="+isSelfOrganize+"&bDate="+bDate+"&eDate="+eDate;
}
</script>
</html>
