package com.chinatour;
/**
 * 显示上传进度 实体类
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-14 下午2:29:04
 * @revision  3.0
 */
public class fileUploadStatus {
	private long pBytesRead = 0L;	//读取字节总数
	private long pContentLength = 0L;	//数组总长度
	private int pItems;				//当前正在被读取的field号
	public fileUploadStatus(){
		pBytesRead = 0L;
		pContentLength = 0L;
	}
	public long getPBytesRead() {
		return pBytesRead;
	}
	public void setPBytesRead(long bytesRead) {
		pBytesRead = bytesRead;
	}
	public long getPContentLength() {
		return pContentLength;
	}
	public void setPContentLength(long contentLength) {
		pContentLength = contentLength;
	}
	public int getPItems() {
		return pItems;
	}
	public void setPItems(int items) {
		pItems = items;
	}
}
