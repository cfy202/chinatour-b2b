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
            <h2>Tour Compose</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New Tour Info</h3>
          </div>
          <div class="content">
             <form class="form-horizontal group-border-dashed" id="formId" action="addOrders.jhtml" method="post" parsley-validate novalidate>     
              <input type="hidden" name="orderIds" value="${orderIds}">
              <!--<input id="existTourId" type="hidden" name="existTourId">-->
			  <!--<div class="form-group">				
				 <label class="col-sm-3 control-label">Tour Type</label>			
				 <div class="col-sm-6">			 
					<label id="defaultType" class="radio-inline">
						<div class="iradio_square-blue" style="position: relative;" aria-checked="false" aria-disabled="false">
						<input class="icheck" type="radio" name="type" checked="" value="${order.tourTypeId}" style="position: absolute; opacity: 0;">
						<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: none repeat scroll 0% 0% rgb(255, 255, 255); border: 0px none; opacity: 0;"></ins>
						</div>
						${tourType.typeName}
					</label>
				</div>				
		      </div>-->
			  <div class="form-group">
				  <label class="col-sm-3 control-label">Arrival Date</label>
				  <div class="col-sm-6">
					<div class="input-group date datetime" data-date-format="yyyy-mm-dd" data-min-view="2">
						<input name="arriveDateTime" class="form-control" readonly="readonly" [#if (tourInfoForOrder.scheduleOfArriveTime)??]value="${tourInfoForOrder.scheduleOfArriveTime?string('yyyy-MM-dd')}"[/#if] type="text" size="16">
						<span class="input-group-addon btn btn-primary">
							<span class="glyphicon glyphicon-th"></span>
						</span>
					</div>
				  </div>
			  </div>
			  <div class="form-group">
                  <label class="col-sm-3 control-label">Product Name</label>
                  <div class="col-sm-6">
                    <input type="text" name="lineName" class="form-control" value="${tourInfoForOrder.lineName}" placeholder="country of passport">
                  </div>
              </div>  
			  <div class="form-group">
                  <label class="col-sm-3 control-label">Product Code</label>
                  <div class="col-sm-6">
                  	<input type="text" name="lineCode" class="form-control" value="${tourInfoForOrder.scheduleLineCode}" placeholder="country of passport">
                  </div>
              </div>  
			  <div class="form-group">
                  <label class="col-sm-3 control-label">Tour Code</label>
                  <div class="col-sm-6">
	                  <input type="hidden"  id="tourCodeT" name="existTourId" style="width:92%;"/><a id="tourCode_option" class="input" style="font-weight:bold;cursor:pointer;">New</a>
	                  <input type="hidden"  id="tourCode" name="tourCode"/>
	                  <input id="newCode" name="tourCode" style="margin-top:10px;" class="form-control" type="hidden" />
                  </div>
              </div> 
              <div class="form-group">
                  <label class="col-sm-3 control-label">Tour Compose Type</label>
                  <div id="result" class="col-sm-6">
                  	
                  </div>
              </div>        
              <div class="form-group" align="right">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" onclick="submit();" style="margin-left:206px;">Group</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    	selectTour();
    	$("#defaultType").click();
    });
    
    /* 提交表单  */
    function submit(){
    	$("#formId").submit();
    }
    
    /* 判断团号是否存在   */
    function checkTourCode(tourCodeInput){
    	var tourCode = $(tourCodeInput).val();
    	var $groupType = $("#result");
    	var $form = $("form");
    	if(tourCode == ''){
    	    $groupType.empty();
    		$groupType.append("Available tour code, new compose！");
    		//$form.attr("action","save.jhtml");
    		return;
    	}
	    $.post("checkTourCode.jhtml", {"tourCode":tourCode}, function(tour){
	    	$groupType.empty();
	    	if(tour == ''){
	    		$groupType.append("Available tour code, new compose！");
	    		$form.attr("action","save.jhtml");
	    	}else{
	    		$groupType.append("Existed tour code, please join in！");
	    		$("#existTourId").val(tour.tourId);
	    		chooseType(tour.type);
	    		$("input[name='arriveDateTime']").val(tour.arriveDateTime);
	    		$("input[name='lineName']").val(tour.lineName);
	    		$("input[name='lineCode']").val(tour.lineCode);
	    		$("input[name='tourCode']").val(tour.tourCode);
	    		//$form.attr("action","addOrders");
	    	}
		});
    }
    
    /*  根据值选中checkbox   */
    function chooseType(val){
    	$("input[name='type']").each(function(){
    		if(val == $(this).val()){
    			$(this).parent().click();
    		}
    	});
    }
	
	
		function selectTour(){
			var enterString = $(".select2-input").val();
		//按用户输入查询团
    	$("#tourCodeT").select2({
			placeholder:"Search TourCode",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'[@spring.url '/admin/invoiceAndCredit/listSelect.jhtml'/]',	//地址
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
	                return {  
	                     tourCode: term   //联动查询的字符  
	                 }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
						for(var i=0;i<dataStr.tourList.length;i++){
							var tour = dataStr.tourList[i];
							 dataA.push({id: tour.tourId, text: tour.tourCode});
							 $("#result").html("Existed tour code, please join in！");
						}
						
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/invoiceAndCredit/listSelect.jhtml?id='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		if(data.tourList[0]==undefined){
				    			callback({id:"",text:"Search TourCode"});
				    		}else{
				    			callback({id:data.tourList[0].tourId,text:data.tourList[0].tourCode});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) {
				//$("#supplierShortNameId").val(m);
				return m; 
			}
		});
	    
	    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
		function formatAsText(item){
		     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>";
		     return itemFmt;
		}
    	
	}	
	
	$("#tourCode_option").click(function(){
		if($("#tourCode_option").html()=="New"){
			$("#newCode").attr("type","text");
			$("#tourCodeT").attr("disabled","disabled");
			$("#tourCode").attr("disabled","disabled");
			$("#formId").attr("action","save.jhtml");
			$("#result").html("Available tour code, new compose！");
			$("#tourCode_option").html("Search");
		}else if($("#tourCode_option").html()=="Search"){
			$("#tourCode_option").html("New");
			$("#tourCodeT").attr("disabled",false);
			$("#result").html("Existed tour code, please join in！");
			$("#newCode").attr("type","hidden");
			$("#formId").attr("action","addOrders.jhtml");
		}
	});	
		
</script>
</body>
</html>
