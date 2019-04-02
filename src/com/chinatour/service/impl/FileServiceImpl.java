/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import java.awt.SystemColor;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import com.chinatour.Constant;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Setting;
import com.chinatour.service.FileService;
import com.chinatour.util.FreemarkerUtils;
import com.chinatour.util.SettingUtils;
/**
 * Service - 文件
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("fileServiceImpl")
public class FileServiceImpl implements FileService, ServletContextAware {

	/** servletContext */
	private ServletContext servletContext;

	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;

	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	/**
	 * 添加上传任务
	 * 
	 * @param storagePlugin
	 *            存储插件
	 * @param path
	 *            上传路径
	 * @param tempFile
	 *            临时文件
	 * @param contentType
	 *            文件类型
	 */

	@Override
	public boolean isValid(FileType fileType,MultipartFile multipartFile) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String upload(FileType fileType,MultipartFile multipartFile, boolean async) {
		if (multipartFile == null) {
			return null;
		}
		Setting setting = SettingUtils.get();
		String uploadPath;
		if (fileType == FileType.enquiryPath) {
			uploadPath = setting.getEnquiryUploadPath();
		} else if (fileType == FileType.sharePath) {
			uploadPath = setting.getShareUploadPath();
		} else if (fileType == FileType.appendixPath) {
			uploadPath = setting.getAppendixUploadPath();
		} else if (fileType == FileType.productImagePath) {
			uploadPath = setting.getProductImageUploadPath();
		} else {
			uploadPath = setting.getTourQuoteUploadPath();
		}
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("uuid", UUID.randomUUID().toString());
			String path = FreemarkerUtils.process(uploadPath, model);
			String destPath = path + UUID.randomUUID() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());
				File tempFile = new File(System.getProperty("java.io.tmpdir") + "/upload_" + UUID.randomUUID() + ".tmp");
				if (!tempFile.getParentFile().exists()) {
					tempFile.getParentFile().mkdirs();
				}
				multipartFile.transferTo(tempFile);
				String realPath = servletContext.getRealPath(destPath);  
				//新建上传目录
				File destFile = new File(servletContext.getRealPath(destPath));
				//这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉
	            FileUtils.copyInputStreamToFile(multipartFile.getInputStream(), destFile); 
				return destPath;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public String upload(FileType fileType,MultipartFile multipartFile) {
		return upload(fileType, multipartFile, false);
	}

	@Override
	public String uploadLocal(FileType fileType,MultipartFile multipartFile) {
		if (multipartFile == null) {
			return null;
		}
		Setting setting = SettingUtils.get();
		String uploadPath;
		if (fileType == FileType.enquiryPath) {
			uploadPath = setting.getEnquiryUploadPath();
		} else if (fileType == FileType.sharePath) {
			uploadPath = setting.getShareUploadPath();
		} else if (fileType == FileType.appendixPath) {
			uploadPath = setting.getAppendixUploadPath();
		} else if (fileType == FileType.productImagePath) {
			uploadPath = setting.getProductImageUploadPath();
		} else if(fileType == FileType.imagePath){
			uploadPath = setting.getNewsForAgencyPath();
		}  else if(fileType == FileType.peerUserLogoPath){
			uploadPath = setting.getPeerUserLogoPath();
		} else {
			uploadPath = setting.getTourQuoteUploadPath();
		}
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("uuid", UUID.randomUUID().toString());
			String path = FreemarkerUtils.process(uploadPath, model);
			String destPath =  path + UUID.randomUUID() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());
			String rootPath = servletContext.getRealPath("/") ;
			if (fileType != FileType.productImagePath&&fileType != FileType.peerUserLogoPath&&fileType != FileType.imagePath) {//上传到未处理的路径
				/*rootPath = rootPath.substring(0, rootPath.lastIndexOf("webapps"));*/
				rootPath=Constant.UPLOADLOCAL;
			}
			//String rootPath = servletContext.getRealPath("/") ;
			//rootPath = rootPath.substring(0, rootPath.lastIndexOf("webapps"));
			//String 	rootPath=Constant.UPLOADLOCAL;
			//File destFile = new File(servletContext.getRealPath(destPath));
			File destFile = new File(rootPath+destPath);
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			multipartFile.transferTo(destFile);
			return destPath;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 文件下载
	 * downLoadPath 文件地址
	 * contentType 下载类型
	 */
	public  void download(HttpServletRequest request,
			HttpServletResponse response, String downLoadPath, String contentType) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		//取得最后一个/的下标  
		int index = downLoadPath.lastIndexOf("/");  
		//将字符串转为字符数组  
		char[] ch = downLoadPath.toCharArray();  
		//根据 copyValueOf(char[] data, int offset, int count) 取得最后一个字符串  
		String realName = String.copyValueOf(ch, index + 1, ch.length - index - 1);
		//项目目录
		//String ctxPath = request.getSession().getServletContext()
				//.getRealPath("/");
		//String rootPath = servletContext.getRealPath("/") ;
		//rootPath = rootPath.substring(0, rootPath.lastIndexOf("webapps"));
		String 	rootPath=Constant.UPLOADLOCAL;
		downLoadPath = rootPath + downLoadPath;
		long fileLength = new File(downLoadPath).length();
		try {
			response.setContentType(contentType);
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String(realName.getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			if(fileLength<=0){
				return;
			}
			bis = new BufferedInputStream(new FileInputStream(downLoadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
			bis.close();
			bos.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
}