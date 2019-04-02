package com.chinatour.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.web.multipart.MultipartFile;

import com.chinatour.FileInfo.FileType;

/**
 * Service - 文件
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-9 上午11:21:56
 * @revision 3.0
 */
public interface FileService {

	/**
	 * 文件验证
	 * 
	 * @param fileType
	 *            文件类型
	 * @param multipartFile
	 *            上传文件
	 * @return 文件验证是否通过
	 */
	boolean isValid(FileType fileType,MultipartFile multipartFile);

	/**
	 * 文件上传
	 * 
	 * @param fileType
	 *            文件类型
	 * @param multipartFile
	 *            上传文件
	 * @param async
	 *            是否异步
	 * @return 访问URL
	 */
	String upload(FileType fileType,MultipartFile multipartFile, boolean async);

	/**
	 * 文件上传(异步)
	 * 
	 * @param fileType
	 *            文件类型
	 * @param multipartFile
	 *            上传文件
	 * @return 访问URL
	 */
	String upload(FileType fileType,MultipartFile multipartFile);

	/**
	 * 文件上传至本地
	 * 
	 * @param fileType
	 *            文件类型
	 * @param multipartFile
	 *            上传文件
	 * @return 路径
	 */
	String uploadLocal(FileType fileType,MultipartFile multipartFile);

	/**
	 * 文件下载
	 * 
	 * @param request
	 * @param response
	 * @param storeName
	 *            文件名
	 * @param contentType
	 * @param realName
	 * @throws Exception
	 */
	void download(HttpServletRequest request, HttpServletResponse response,
			String downLoadPath, String contentType) throws Exception;
}