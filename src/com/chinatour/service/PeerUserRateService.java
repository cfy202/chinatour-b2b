/**
 * 
 */
package com.chinatour.service;

import java.util.List;
import com.chinatour.entity.PeerUserRate;


/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-06-25 上午09：50：00
 * @revision  3.0
 */

public interface PeerUserRateService extends BaseService<PeerUserRate, String>{
	PeerUserRate getRate(PeerUserRate peerUserRate);
}
