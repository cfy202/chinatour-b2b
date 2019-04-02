package com.chinatour.interceptor;
import java.util.List;
 
import javax.servlet.http.HttpServletRequest;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
 
import com.chinatour.listener.myProgressListener;

/**
 * 重写上传进度的监听
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-13 上午9:13:17
 * @revision  3.0
 */

public class CustomMultipartResolver extends CommonsMultipartResolver {
     
    @Override
    @SuppressWarnings("unchecked")
    public MultipartParsingResult parseRequest(HttpServletRequest request)
            throws MultipartException {
        String encoding = determineEncoding(request);
        FileUpload fileUpload = prepareFileUpload(encoding);
        myProgressListener getBarListener = new myProgressListener(request);
        fileUpload.setProgressListener(getBarListener);
        try {
            List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
            return parseFileItems(fileItems, encoding);
        }
        catch (FileUploadBase.SizeLimitExceededException ex) {
            throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
        }
        catch (FileUploadException ex) {
            throw new MultipartException("Could not parse multipart servlet request", ex);
        }
    }
}