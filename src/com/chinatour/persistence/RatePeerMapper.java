package com.chinatour.persistence;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.RatePeer;

/**
 * @copyright   Copyright: 2016 
 * @author Aries
 * @create-time 2016-3-29 下午2:26:01
 * @revision  3.0
 */
@Repository
public interface RatePeerMapper extends BaseMapper<RatePeer, String> {
	/**
	 * 根据条件查找汇率
	 * */
	RatePeer findByCurrency(@Param("record")RatePeer patePeer);
}