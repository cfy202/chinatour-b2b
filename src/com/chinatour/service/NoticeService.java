/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Appendix;
import com.chinatour.entity.Notice;
import com.chinatour.entity.NoticeContact;


/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-16 下午3:15:01
 * @revision  3.0
 */
public interface NoticeService extends BaseService<NoticeContact, String>{
	/*
	 * 保存邮件及收发件人
	 */
	void save(List<NoticeContact> saveList,List<NoticeContact> updateList,Notice notice,String delNoticeId,List<Appendix> appendixList);
	
	/**
     * 查找实体对象分页
     *
     * @param pageable 分页信息
     * @return 实体对象分页
     */
    Page<NoticeContact> findSendBoxPage(NoticeContact t, Pageable pageable);
    
    /*
	 * 查找发送用户
	 */
    List<NoticeContact> findReceiveUser(String id);
    
    /*
	 * 查询未读记录条数
	 */
    int unReadTotal(NoticeContact noticeContact);
    
    void sendMail(String title,String sendUser,String receiveUser);
    
    void sendMail(String title,String Content,String sendUser,String receiveUser);
}
