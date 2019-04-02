package com.chinatour.service.impl;

/**
 * Created by XuXuebin on 2014/7/9.
 */

import com.chinatour.Filter;
import com.chinatour.Order;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.persistence.BaseMapper;
import com.chinatour.service.BaseService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

/**
 * Service - 基类
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Transactional
public class BaseServiceImpl<T, ID extends Serializable> implements BaseService<T, ID> {

    /**
     * baseMapper
     */
    private BaseMapper<T, ID> baseMapper;

    public void setBaseMapper(BaseMapper<T, ID> baseMapper) {
        this.baseMapper = baseMapper;
    }

    @Transactional(readOnly = true)
    public T findById(ID id) {
        return baseMapper.findById(id);
    }

    @Transactional(readOnly = true)
    public List<T> findAll() {
        return baseMapper.findAll();
    }

    @Transactional(readOnly = true)
    public List<T> findList(ID... ids) {
        return baseMapper.findByIds(ids);
    }

    @Transactional(readOnly = true)
    public List<T> findList(Integer count, List<Filter> filters, List<Order> orders) {
        return findList(null, count, filters, orders);
    }

    @Transactional(readOnly = true)
    public List<T> findList(Integer first, Integer count, List<Filter> filters, List<Order> orders) {
        return baseMapper.findList(first, count, filters, orders);
    }

    @Transactional(readOnly = true)
    public Page<T> findPage(T t, Pageable pageable) {

        if (pageable == null) {
            pageable = new Pageable();
        }
        List<T> page = baseMapper.findForPage(t, pageable);
        int pageCount = baseMapper.findForPageCount(t);
        return new Page<T>(page, pageCount, pageable);
    }

    @Transactional(readOnly = true)
    public long count() {
        return count(new Filter[]{});
    }

    @Transactional(readOnly = true)
    public long count(Filter... filters) {
        return baseMapper.count(filters);
    }

    @Transactional
    public void save(T entity) {
        baseMapper.save(entity);
    }

    @Transactional
    public int update(T entity) {
        return baseMapper.update(entity);
    }

    @Transactional
    public void delete(ID id) {
        baseMapper.removeById(id);
    }

    @Transactional
    public void delete(ID... ids) {
        baseMapper.removeByIds(ids);
    }

    @Transactional
    public void delete(T entity) {
        baseMapper.remove(entity);
    }
}
