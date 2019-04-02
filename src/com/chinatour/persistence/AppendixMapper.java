/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Appendix;
import com.chinatour.entity.GroupLine;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-16 下午2:28:38
 * @revision  3.0
 */

@Repository
public interface AppendixMapper extends BaseMapper<Appendix, String> {
		
	/**
	 * 根据NoticeId 查出附件
	 * 
	 * @param NoticeId
	 * @return
	 */
	List<Appendix> findByNoticeId(String NoticeId);
}
