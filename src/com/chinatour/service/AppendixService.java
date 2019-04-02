/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Appendix;
/**
 * Service - 附件
 *
 * @author 
 * @version 3.0
 */
public interface AppendixService extends BaseService<Appendix, String> {

	List<Appendix> findByNoticeId(String NoticeId);
}