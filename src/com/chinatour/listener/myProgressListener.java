package com.chinatour.listener;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.apache.commons.fileupload.ProgressListener;

import com.chinatour.fileUploadStatus;
/**
 * 上传进度监听器
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-13 上午9:26:11
 * @revision  3.0
 */
public class myProgressListener implements ProgressListener {
	private HttpSession session;

	public myProgressListener(HttpServletRequest req) {
		session=req.getSession();
		fileUploadStatus status = new fileUploadStatus();
		session.setAttribute("status", status);
	}

	/* pBytesRead  到目前为止读取文件的比特数
	 * pContentLength 文件总大小
	 * pItems 目前正在读取第几个文件
	 */
	public void update(long pBytesRead, long pContentLength, int pItems) {
		// TODO Auto-generated method stub
		fileUploadStatus status = (fileUploadStatus) session.getAttribute("status");
		status.setPBytesRead(pBytesRead);
		status.setPContentLength(pContentLength);
		status.setPItems(pItems);
	}

}
