/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.NoticeContact;


/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-16 下午2:28:38
 * @revision  3.0
 */

@Repository
public interface NoticeContactMapper extends BaseMapper<NoticeContact, String> {
	/*
	 * 批量保存
	 */
	void batchSave(List<NoticeContact> noticeContactList);
	/**
     * 查找实体对象分页
     *
     * @param pageable 分页信息
     * @return 实体对象分页
     */
    List<NoticeContact> findSendBoxForPage(@Param("record") NoticeContact t, @Param("page") Pageable pageable);

    /**
     * 查找实体对象分页Count
     *
     * @param t        实体对象
     * @param pageable 分页信息
     * @return
     */
    int findSendBoxForPageCount(@Param("record") NoticeContact t);
    
    /*
	 * 查找发送用户
	 */
    List<NoticeContact> findReceiveUser(String id);
}
