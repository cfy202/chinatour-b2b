/**
 * 
 */
package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Appendix;
import com.chinatour.entity.Notice;
import com.chinatour.entity.NoticeContact;
import com.chinatour.persistence.AppendixMapper;
import com.chinatour.persistence.NoticeContactMapper;
import com.chinatour.persistence.NoticeMapper;
import com.chinatour.service.NoticeService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-16 下午3:16:12
 * @revision  3.0
 */
@Service("noticeServiceImpl")
public class NoticeServiceImpl extends BaseServiceImpl<NoticeContact, String> implements NoticeService{
	@Autowired
	private NoticeContactMapper noticeContactMapper;
	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private AppendixMapper appendixMapper;

	@Autowired
	public void setBaseMapper(NoticeContactMapper noticeContactMapper) {
	    	super.setBaseMapper(noticeContactMapper);
	}
	
	
	@Transactional(readOnly = true)
	public int unReadTotal(NoticeContact noticeContact) {
		return noticeContactMapper.findSendBoxForPageCount(noticeContact);
	}
	
	@Override
	@Transactional(readOnly = true)
	public NoticeContact findById(String id) {
		return super.findById(id);
	}

	@Override
	@Transactional
	public int update(NoticeContact entity) {
		return super.update(entity);
	}

    @Override
    @Transactional
    public void save(NoticeContact entity) {
    	super.save(entity);
    }

    @Override
    @Transactional
    public void delete(String id) {
    	super.delete(id);
    }


	/* 
	 * saveList 发送站内信保存
	 * updateList  草稿箱发送保存
	 * notice 站内信
	 * appendixFile 附件地址
	 */
	@Override
	@Transactional
	public void save(List<NoticeContact> saveList,List<NoticeContact> updateList, Notice notice,String delNoticeId , List<Appendix> appendixList) {
		if (saveList.size()!=0 || updateList.size()!=0) {
			noticeMapper.save(notice);
        }
		if (saveList.size()!=0) {
			noticeContactMapper.batchSave(saveList);
        }
		if (updateList.size()!=0) {
			for(NoticeContact item:updateList){
				noticeContactMapper.update(item);
			}
        }
		if (delNoticeId != null) {
				noticeMapper.removeById(delNoticeId);
        }
		if (appendixList.size()!=0) {
			appendixMapper.removeById(notice.getNoticeId());
			for(Appendix item:appendixList){
				appendixMapper.save(item);
			}
        }
	}
	
	@Transactional(readOnly = true)
    public Page<NoticeContact> findSendBoxPage(NoticeContact t, Pageable pageable) {

        if (pageable == null) {
            pageable = new Pageable();
        }
        List<NoticeContact> page = noticeContactMapper.findSendBoxForPage(t, pageable);
        int pageCount = noticeContactMapper.findSendBoxForPageCount(t);
        return new Page<NoticeContact>(page, pageCount, pageable);
    }


	/* (non-Javadoc)
	 * @see com.chinatour.service.NoticeService#findReceiveUser(java.lang.String)
	 */
	@Override
	public List<NoticeContact> findReceiveUser(String id) {
		return noticeContactMapper.findReceiveUser(id);
	}
	
	/*
	 * 发送站内信提示订单改变
	 * title 标题
	 * senduser 发件人id
	 * reciveruser 收件人id
	 */
	@Override
	@Transactional
	public void sendMail(String title,String sendUser,String receiveUser){
		List<NoticeContact> saveList = new ArrayList<NoticeContact>();
		//发送站内信
		Notice notice = new Notice();
		notice.setNoticeId(UUIDGenerator.getUUID());
		notice.setTitle(title);//保存标题
		notice.setContent(title);//保存内容
		NoticeContact nc = new NoticeContact();
		nc.setNoticeContactId(UUIDGenerator.getUUID());
		nc.setSendUser(sendUser);
		nc.setReceiveUser(receiveUser);
		nc.setType(1);
		nc.setState(0);
		nc.setNoticeId(notice.getNoticeId());
		saveList.add(nc);
		this.save(saveList, new ArrayList(), notice, null, new ArrayList());
	}
	/*
	 * 发送站内信提示订单改变
	 * title 标题
	 * Content 内容
	 * senduser 发件人id
	 * reciveruser 收件人id
	 */
	@Override
	@Transactional
	public void sendMail(String title,String Content,String sendUser,String receiveUser){
		List<NoticeContact> saveList = new ArrayList<NoticeContact>();
		//发送站内信
		Notice notice = new Notice();
		notice.setNoticeId(UUIDGenerator.getUUID());
		notice.setTitle(title);//保存标题
		notice.setContent(Content);//保存内容
		NoticeContact nc = new NoticeContact();
		nc.setNoticeContactId(UUIDGenerator.getUUID());
		nc.setSendUser(sendUser);
		nc.setReceiveUser(receiveUser);
		nc.setType(1);
		nc.setState(0);
		nc.setNoticeId(notice.getNoticeId());
		saveList.add(nc);
		this.save(saveList, new ArrayList(), notice, null, new ArrayList());
	}
}
