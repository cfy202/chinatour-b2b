package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.News;
/**
 * 同行首页news
 * @author chinatour
 *
 */
public interface NewsService extends BaseService<News, String> {
	public List<News> findNewsForPage(News n);
	public int findNewsForPageCount(String currency);
	public List<News> findNewsList(News n);
}
