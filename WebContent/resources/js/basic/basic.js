$(document).ready(function () {
	selectDontViewNotice();
	setInterval(function(){selectDontViewNotice();},'300000');	//5分钟间隔
});


//pis  根据num区分cancel,Save and New;url 为保存方法,newUrl为重定向页面
function redirect(num){
	var basePath = window.location.href;
    	basePath = basePath.substring(0,basePath.lastIndexOf('/'));
	var url="";
	if(num == 1){
		 url=basePath+'/list.jhtml';
		 location.href=url;
	}
	if(num == 2){
		 var formData = $("#formId").serialize();
		 url=basePath+'/save.jhtml';
		 newUrl = basePath + '/add.jhtml';	
			 $.ajax({
    		   type:"POST",
	           url: url,
	           data:formData,
	           dataType: "text",
	   		   success: function (data) {
	   		   	location.href=newUrl;
			 }
        });
	}
}    