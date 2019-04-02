package com.chinatour.persistence;

/**
 * Created by XuXuebin on 2014/7/9.
 */

import com.chinatour.Filter;
import com.chinatour.Order;
import com.chinatour.Pageable;
import org.apache.ibatis.annotations.Param;

import java.io.Serializable;
import java.util.List;

/**
 * Dao - 基类
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface BaseMapper<T, ID extends Serializable> {

    /**
     * 查找实体对象
     *
     * @param id ID
     * @return 实体对象，若不存在则返回null
     */
    T findById(ID id);

    /**
     * 查找实体对象
     *
     * @param t T
     * @return 实体对象，若不存在则返回null
     */
    List<T> find(T t);

    /**
     * 查找实体对象集合
     *
     * @param first   起始记录
     * @param count   数量
     * @param filters 筛选
     * @param orders  排序
     * @return 实体对象集合
     */
    List<T> findList(Integer first, Integer count, List<Filter> filters, List<Order> orders);

    /**
     * 查找实体对象分页
     *
     * @param pageable 分页信息
     * @return 实体对象分页
     */
    List<T> findForPage(@Param("record") T t, @Param("page") Pageable pageable);

    /**
     * 查找实体对象分页Count
     *
     * @param t        实体对象
     * @param pageable 分页信息
     * @return
     */
    int findForPageCount(@Param("record") T t);

    /**
     * 查询实体对象数量
     *
     * @param filters 筛选
     * @return 实体对象数量
     */
    long count(Filter... filters);

    /**
     * 移除实体对象
     *
     * @param entity 实体对象
     */
    void remove(T entity);

    /**
     * 更新
     *
     * @param entity
     * @return
     */
    int update(T entity);

    /**
     * 保存
     *
     * @param entity
     */
    void save(T entity);

    /**
     * 查询所有数据
     *
     * @return
     */
    List<T> findAll();

    /**
     * 根据ID数组查询多个对象
     *
     * @param ids
     * @return
     */
    List<T> findByIds(@Param("ids") ID... ids);

    /**
     * 根据ID数组移除多个对象
     *
     * @param ids
     */
    void removeByIds(@Param("ids") ID... ids);

    /**
     * 根据ID移除对象
     *
     * @param id
     */
    void removeById(ID id);
}