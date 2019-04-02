package com.chinatour.service.impl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.chinatour.entity.News;
import com.chinatour.persistence.NewsMapper;
import com.chinatour.service.NewsService;
/**
 * 同行系统首页news
 * @author chinatour
 *
 */
@Service("newsServiceImpl")
public class NewsServiceImpl extends BaseServiceImpl<News, String> implements NewsService {
	@Autowired
	private NewsMapper newsMapper;
	@Autowired
	public void setBaseMapper(NewsMapper newsMapper) {
	    	super.setBaseMapper(newsMapper);
	}
	@Override
	public List<News> findNewsForPage(News n) {
		
		return newsMapper.findNewsForPage(n);
	}
	@Override
	public int findNewsForPageCount(String currency) {
		return newsMapper.findNewsForPageCount(currency);
	}
	@Override
	public List<News> findNewsList(News n) {
		return newsMapper.findNewsList(n);
	}
}
