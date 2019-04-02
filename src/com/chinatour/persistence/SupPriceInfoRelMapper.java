package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Order;
import com.chinatour.entity.SupPriceInfoRel;
import com.chinatour.vo.CustomerOrderVO;

/**
 * Dao--账单供应商
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:33:38
 * @revision 3.0
 */
@Repository
public interface SupPriceInfoRelMapper extends
		BaseMapper<SupPriceInfoRel, String> {

	List<CustomerOrderVO> findCustomerByTourId(String tourId);

	List<SupPriceInfoRel> findSupplierByTourId(String tourId);

	List<SupPriceInfoRel> findSupplierOfOrderOfTour(
			SupPriceInfoRel supPriceInfoRel);

}