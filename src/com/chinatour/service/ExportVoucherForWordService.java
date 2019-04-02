package com.chinatour.service;


import java.io.InputStream;


public interface ExportVoucherForWordService {
	public InputStream getWordFile(String orderId) throws Exception;
}
