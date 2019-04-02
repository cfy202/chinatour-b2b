/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;


import org.springframework.stereotype.Repository;

import com.chinatour.entity.Contacts;


/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-11-9 下午3:06:18
 * @revision  3.0
 */
@Repository
public interface ContactsMapper extends BaseMapper<Contacts, String>{
	List<Contacts> findByPeerUserId(String peerUserId);

}
