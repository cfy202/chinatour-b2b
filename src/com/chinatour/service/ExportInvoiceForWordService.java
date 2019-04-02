package com.chinatour.service;


import java.io.InputStream;


public interface ExportInvoiceForWordService {
	public InputStream getWordFile(String orderId) throws Exception;
}
