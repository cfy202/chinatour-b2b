package com.chinatour.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.chinatour.entity.GroupLine;


/**
 * Service - 文件
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-9 上午11:21:56
 * @revision 3.0
 */
public interface PDFService {

	/**
	 * 文件上传至本地
	 * 
	 * @param fileType
	 *            文件类型
	 * @param multipartFile
	 *            上传文件
	 * @return 路径
	 */
	String createPdf(String id);

}