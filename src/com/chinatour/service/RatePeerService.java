/**
 * 
 */
package com.chinatour.service;

import com.chinatour.entity.RatePeer;


/**
 * @copyright   Copyright: 2016 
 * @author Aries
 * @create-time 2016-3-29 下午2:26:01
 * @revision  3.0
 */

public interface RatePeerService extends BaseService<RatePeer, String>{
	RatePeer findByCurrency(RatePeer patePeer);//使用实体查找数据
}
