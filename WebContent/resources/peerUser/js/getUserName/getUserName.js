$(document).ready(function () {
	var basePath = window.location.href;
	basePath = basePath.substring(0,basePath.lastIndexOf('/'));
	var newLoginUrl = basePath + '/getUserName.jhtml';	
	 $.ajax({
			url: newLoginUrl,
			type: "GET",
			success: function(message) {
				if(message.length>0){
					$("#loginHtml").html("Welcome&nbsp;&nbsp;"+message);
				}	
			}
			});
})