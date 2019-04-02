package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.GroupLine;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 25, 2014 3:28:51 PM
 * @revision  3.0
 */
@Repository
public interface GroupLineMapper extends BaseMapper<GroupLine, String> {

	/**
	 * 根据团队类别查出所有的线路
	 * 
	 * @param tourTypeId
	 * @return
	 */
	List<GroupLine> findByTourTypeId(String tourTypeId);
	
	/**
	 * 根据线路查出所有该线路对应的酒店
	 */
	GroupLine findHotelByGroupLineId(String groupLineId);
	
	/**
	 * 根据条件查找相应产品
	 * */
	List<GroupLine> findGroupLine(@Param("record")GroupLine groupLine);
	
	List<GroupLine> findGroupLineForPage(@Param("record")GroupLine groupLine,@Param("page")Pageable pageable,@Param("cc")String[] brand);
	
	void updateIndependentGroupLine(GroupLine groupLine);
	

	int findGroupLineForPageCount(@Param("record")GroupLine groupLine, @Param("page") Pageable pageable,@Param("cc")String[] brand);

	//int findGroupLineForPageCount(@Param("record")GroupLine groupLine, @Param("page")Pageable pageable);
	/**根据TourCode寻找最大的产品排序号*/
	String lineNoMax(String tourCode);
	String operaterByBrand(String brand);
	String venderByBrand(GroupLine groupline);
	String operaterAll();
	String venderAll();
	String OpCenterAll();
	
	List<GroupLine> findByTourCode(String tourCode);
	
	/*给op查看，修改本部门产品*/
	List<GroupLine> findForPageForOp(@Param("record") GroupLine groupLine, @Param("page") Pageable pageable);
	
	int findForPageCountForOp(@Param("record") GroupLine groupLine, @Param("page") Pageable pageable);
}
