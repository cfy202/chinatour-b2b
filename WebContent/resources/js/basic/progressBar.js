/**
 * 上传显示进度条
 * jacky
 * 
 */
var startTime;
function getProgressBar() {
	var timestamp = (new Date()).valueOf();
	var bytesReadToShow = 0;//上传速度
	var contentLengthToShow = 0;//总大小
	var bytesReadGtMB = 0;//已上传
	var contentLengthGtMB = 0;
	$.getJSON("doPost.jhtml", {"t":timestamp}, function (json) {
		var bytesRead = (json.pBytesRead / 1024).toString();
		if (bytesRead > 1024) {
			bytesReadToShow = (bytesRead / 1024).toString();
			bytesReadGtMB = 1;
		}else{
			bytesReadToShow = bytesRead.toString();
		}
		var contentLength = (json.pContentLength / 1024).toString();
		if (contentLength > 1024) {
			contentLengthToShow = (contentLength / 1024).toString();
			contentLengthGtMB = 1;
		}else{
			contentLengthToShow= contentLength.toString();
		}
		bytesReadToShow = bytesReadToShow.substring(0, bytesReadToShow.lastIndexOf(".") + 3);
		contentLengthToShow = contentLengthToShow.substring(0, contentLengthToShow.lastIndexOf(".") + 3);
		if (bytesRead == contentLength) {
			if (contentLengthGtMB == 0) {
				$("div#info").html("Upload Complete" + contentLengthToShow + "KB.Total size100%");
			} else {
				$("div#info").html("Upload Complete" + contentLengthToShow + "MB.Total size100%");
			}
			$("#progress").html("0%");
			$("#progress").css("width","0%");
			$("#progress-striped").hide();
			window.clearTimeout(interval);
		} else {
			var pastTimeBySec = (new Date().getTime() - startTime) / 1000;
			var sp = (bytesRead / pastTimeBySec).toString();
			var speed = sp.substring(0, sp.lastIndexOf(".") + 3);		//上传速度
			var percent = Math.floor((bytesRead / contentLength) * 100) + "%";//上传百分百
			$("#progress").html(percent);
			$("#progress").css("width",percent);
			if (bytesReadGtMB == 0 && contentLengthGtMB == 0) {
				$("div#info").html("The upload speed:" + speed + "KB/Sec,Read" + bytesReadToShow + "KB,Total size" + contentLengthToShow + "KB.Complete" + percent);
			} else {
				if (bytesReadGtMB == 0 && contentLengthGtMB == 1) {
					$("div#info").html("The upload speed:" + speed + "KB/Sec,Read" + bytesReadToShow + "KB,Total size" + contentLengthToShow + "MB.Complete" + percent);
				} else {
					if (bytesReadGtMB == 1 && contentLengthGtMB == 1) {
						$("div#info").html("The upload speed:" + speed + "KB/Sec,Read" + bytesReadToShow + "MB,Total size" + contentLengthToShow + "MB.Complete" + percent);
					}
				}
			}
		}
	});
	var interval = window.setTimeout("getProgressBar()", 500);
}
