package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 25, 2014 3:28:51 PM
 * @revision  3.0
 */

public interface GroupLineService extends BaseService<GroupLine, String> {
	
	/**
	 * 独立团保存产品
	 * 
	 * @param groupLine
	 * @return
	 */
	public String saveIndependentProduct(GroupLine groupLine);
	
	/**
	 * 根据团队类别查出所有的线路
	 * 
	 * @param tourTypeId
	 * @return
	 */
	public List<GroupLine> findByTourTypeId(String tourTypeId);
	/*
	 * 保存行程
	 */
	void save(GroupRoute groupRoute);
	
	/*
	 * 修改行程
	 */
	void updateRoute(GroupRoute groupRoute);
	
	/*
	 * 通过id查询线路
	 */
	GroupLine findGroupLineById(String id);
	
	/*
	 * 查询所有行程
	 */
	List<GroupRoute> findGroupRouteByGroupLineId(String groupLineId);
	
	/*
	 * 通过id查询行程
	 */
	GroupRoute findGroupRouteById(String id);
	
	/*
	 * 通过线路id查出包含对应酒店的行程
	 */
	GroupLine findHotelByGroupLineId(String groupLineId);
	
	/*
	 * 保存中间表
	 */
	void saveGroupLineHotelRel(GroupLineHotelRel groupLineHotelRel);
	
	/*
	 * 修改酒店
	 */
	void updateHotel(Hotel hotel);
	
	List<GroupLineHotelRel> findByGroupLineId(String groupLineHotelRelId);
	
	GroupLineHotelRel findGroupLineHotelRelByHotelId(String hotelId);
	
	void updateGroupLineHotelRel(GroupLineHotelRel groupLineHotelRel);
	
	GroupLineHotelRel findGroupLineHotelRelById(String id);
	
	void delGroupLineHotelRel(String id);
	
	List<GroupLine> findGroupLine(GroupLine groupLine);
	/**
	 * 同行用户产品列表
	 * */
	Page<GroupLine> findGroupLineList(GroupLine groupLine,Pageable pageable,String[] brand);
	/**
	 * 根君TourCode寻找最大的产品排序号
	 * */
	String lineNoMax(String tourCode);
	/**
	 * 查找操作中心
	 * */
	String operaterList(String brand);
	/**
	 * 供应商
	 * */
	String venderList(GroupLine groupline);
	
	/**
	 * 查找操作中心
	 * */
	String operaterAllList();
	/**
	 * 供应商
	 * */
	String venderAllList();
	
	/**
	 * OP查找本部门操作的产品
	 */
	Page<GroupLine> findPageForOp(GroupLine groupLine, Pageable pageable);
}
