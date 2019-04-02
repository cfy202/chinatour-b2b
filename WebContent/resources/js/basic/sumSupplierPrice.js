/**
 * 团账单 供应商中计算平均价
 * jacky
 * 
 */
$(function(){
	
	App.init();
	//初始化全选框
	$('input').iCheck({
        checkboxClass: 'icheckbox_square-blue checkbox',
  		 radioClass: 'iradio_square-blue'
 	});
  	//取消客人标记
	$("tr[id^='trCss_5_']").css("background-color","#AAAAAA");
	$("tr[id^='trCss_6_']").css("background-color","#AAAAAA");
	$(".tr_1").css("background-color","#AAAAAA");
	//全选或不全选
	$("#check-all").on('ifChanged',function(){
		var checkboxes = $(".item").find(':checkbox');
		if($(this).is(':checked')) {
		    checkboxes.iCheck('check');
		    $("input[id^=planning_IsCalculate_]").attr("value",1);
		} else {
		    checkboxes.iCheck('uncheck');
		    $("input[id^=planning_IsCalculate_]").attr("value",0);
		}
	});
	$("input[id^='update_']").each(function(){
		$(this).on("keyup",function(){
			sumPriceUpdate();
		 });
	});
	
	$("input[id^='planning_update_']").each(function(){
		$(this).on("ifChanged",function(){
			sumPriceUpdate();
		 });
	});
	
	$("input[id^='tourSumFee']").each(function(){
		$(this).on("keyup",function(){
			sumPriceUpdate();
		 });
	});
	
	$("input[id^='save_']").each(function(){
		$(this).on("keyup",function(){
			sumPriceOfTour();
		 });
	});
	
	$("#totalPeopleSpanId").html($("input[name='totalPeople']").val()+"人");
	
});
//（总数-特殊)/平均
function sumPriceUpdate(){
	//不参与计算团费为0
	$("input[id^='planning_update_']").each(function(){
		var name=$(this).attr("name");
		if($(this).is(':checked')){
			$("#planning_IsCalculate_"+name).val(1);
		}else{
			$("#planning_IsCalculate_"+name).val(0);
			$("#save_"+name).val(0);
		}
	});
	
	//总数
	var tourSumFee=$("#tourSumFee").val();
	//特殊
	var specialPrice=0;
	$("input[id^='update_']").each(function(){
		var dbp=$(this).val();
		specialPrice=parseFloat(specialPrice)+parseFloat(dbp);	
	});
	
	tourSumFee=parseFloat(tourSumFee)-parseFloat(specialPrice);
	 //选中人数
	var customerCount=0;
	$("input[id^='planning_update_']").each(function(){
		if(this.checked){
			customerCount=parseFloat(customerCount)+1;
		}
	});
	
	//余数
	var remainder=parseFloat(tourSumFee)%parseFloat(customerCount);
	//平局整数
	var integer=parseInt(parseFloat(tourSumFee)/parseFloat(customerCount)) ;
	//将余数平摊到前几个人身上
	$("input[id^='planning_update_']").each(function(){
		var name=$(this).attr("name");
		if(remainder>0||remainder==0){
			if(this.checked&&parseFloat(remainder)>0){
				$("#save_"+name).val(parseFloat(integer)+1);
				remainder--;
			}else if(this.checked&&parseFloat(remainder)==0){
				$("#save_"+name).val(integer);
			}
		}else{
			if(this.checked&&parseFloat(remainder)<0){
				$("#save_"+name).val(parseFloat(integer)-1);
				remainder++;
			}else if(this.checked&&parseFloat(remainder)==0){
				$("#save_"+name).val(integer);
			}
		}
	});
}

//球总和
function sumPriceOfTour(){
	//不参与计算团费为0
	$("input[id^='planning_update_']").each(function(){
		var name=$(this).attr("name");
		if(!$(this).is(':checked')){
			$("#save_"+name).val(0);
		}
	});
	
	//总数
	var tourSumFee=0;
	$("input[id^='save_']").each(function(){
		var dbp=$(this).val();
		tourSumFee=parseFloat(tourSumFee)+parseFloat(dbp);
	});
	
	$("input[id^='update_']").each(function(){
		var dbp=$(this).val();
		tourSumFee=parseFloat(tourSumFee)+parseFloat(dbp);	
	});
	$("#tourSumFee").val(tourSumFee);
}

function submitCheck(){
	var re = /^-?\d+(\.[0]){0,1}$/;   //判断字符串是否为数字
	var flag=0;
	//总数
	var tourSumFee=$("#tourSumFee").val();
	if(!re.test(tourSumFee)){
		flag=1;
	}
	//特殊
	var specialPrice=0;
	$("input[id^='update_']").each(function(){
		var dbp=$(this).val();
		specialPrice=parseFloat(specialPrice)+parseFloat(dbp);	
	});
	//总数
	var saveFee=0;
	$("input[id^='save_']").each(function(){
		var dbp=$(this).val();
		saveFee=parseFloat(saveFee)+parseFloat(dbp);
	});
	
	var supplierShortName=$("#supplierShortNameId").val();
	if(supplierShortName=="Search Hotel"||supplierShortName==""){
		alert("No selected hotel");
		return false;
	}else if(supplierShortName=="Search Supplier"||supplierShortName==""){
		alert("No selected operator");
		return false;
	}else if(parseFloat(tourSumFee)!=(parseFloat(specialPrice)+parseFloat(saveFee))||flag==1){
		alert("Total amount does not equal or decimal exists");
		return false;
	}else {
		return true;
	}
}