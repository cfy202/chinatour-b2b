package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;
import com.chinatour.persistence.GroupLineHotelRelMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.persistence.HotelMapper;
import com.chinatour.service.GroupLineService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.TourOrderListVO;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 25, 2014 3:28:51 PM
 * @revision  3.0
 */
@Service("groupLineServiceImpl")
public class GroupLineServiceImpl extends BaseServiceImpl<GroupLine, String> implements
		GroupLineService {
	
	@Autowired
	private GroupLineMapper groupLineMapper;
	
	@Autowired
	private GroupRouteMapper groupRouteMapper;
	
	@Autowired
	private GroupLineHotelRelMapper groupLineHotelRelMapper;
	
	@Autowired
	private HotelMapper hotelMapper;
	
	/**
	 * GroupLineMapper注入
	 * @param groupLineMapper
	 */
    @Autowired
    public void setBaseMapper(GroupLineMapper groupLineMapper) {
        super.setBaseMapper(groupLineMapper);
    }

	/* (non-Javadoc)
	 * @see com.chinatour.service.GroupLineService#findByTourTypeId(java.lang.String)
	 */
	@Override
	public List<GroupLine> findByTourTypeId(String tourTypeId) {
		return groupLineMapper.findByTourTypeId(tourTypeId);
	}

	@Override
	@Transactional
	public void save(GroupRoute groupRoute) {
		groupRouteMapper.save(groupRoute);
	}

	@Override
	@Transactional
	public void updateRoute(GroupRoute groupRoute) {
		groupRouteMapper.update(groupRoute);
	}

	@Override
	@Transactional
	public List<GroupRoute>  findGroupRouteByGroupLineId(String id) {
		return groupRouteMapper.findGroupRouteByGroupLineId(id);
	}

	@Override
	@Transactional
	public GroupLine findGroupLineById(String id) {
		return groupLineMapper.findById(id);
	}

	@Override
	@Transactional
	public GroupRoute findGroupRouteById(String id) {
		return groupRouteMapper.findById(id);
	}

	@Override
	@Transactional
	public GroupLine findHotelByGroupLineId(String groupLineId) {
		return groupLineMapper.findHotelByGroupLineId(groupLineId);
	}

	@Override
	public void saveGroupLineHotelRel(GroupLineHotelRel groupLineHotelRel) {
		 groupLineHotelRelMapper.save(groupLineHotelRel);
		
	}

	@Override
	public void updateHotel(Hotel hotel) {
		hotelMapper.update(hotel);
		
	}

	@Override
	public List<GroupLineHotelRel> findByGroupLineId(String groupLineHotelRelId) {
		return groupLineHotelRelMapper.findByGroupLineId(groupLineHotelRelId);
	}

	@Override
	@Transactional
	public String saveIndependentProduct(GroupLine groupLine) {
		groupLine.setId(UUIDGenerator.getUUID());
		groupLineMapper.save(groupLine);
		return groupLine.getId();
	}

	@Override
	public GroupLineHotelRel findGroupLineHotelRelByHotelId(String hotelId) {
		return groupLineHotelRelMapper.findGroupLineHotelRelByHotelId(hotelId);
	}

	@Override
	public void updateGroupLineHotelRel(GroupLineHotelRel groupLineHotelRel) {
		groupLineHotelRelMapper.update(groupLineHotelRel);
	}

	@Override
	public GroupLineHotelRel findGroupLineHotelRelById(String id) {
		return groupLineHotelRelMapper.findById(id);
	}

	@Override
	public void delGroupLineHotelRel(String id) {
		groupLineHotelRelMapper.removeById(id);
	}

	@Override
	public List<GroupLine> findGroupLine(GroupLine groupLine) {
		return groupLineMapper.findGroupLine(groupLine);
	}
	


		@Override
		public Page<GroupLine> findGroupLineList(GroupLine groupLine,Pageable pageable,String[] brand) {
			if (pageable == null) {
				pageable = new Pageable();
			}
			/*int pageCount = groupLineMapper.findForPageCount(groupLine);*/
			int pageCount = groupLineMapper.findGroupLineForPageCount(groupLine,pageable,brand);
			//int pageCount = 30;
			List<GroupLine> groupLineList= groupLineMapper.findGroupLineForPage(groupLine, pageable,brand);
			return new Page<GroupLine>(groupLineList, pageCount, pageable);
		}

		@Override
		public String lineNoMax(String tourCode) {
			return groupLineMapper.lineNoMax(tourCode);
		}

		@Override
		public String operaterList(String brand) {
			return groupLineMapper.operaterByBrand(brand);
		}

		@Override
		public String venderList(GroupLine groupline) {
			return groupLineMapper.venderByBrand(groupline);
		}
		@Override
		public String operaterAllList() {
			return groupLineMapper.operaterAll();
		}

		@Override
		public String venderAllList() {
			return groupLineMapper.venderAll();
		}

		@Override
		public Page<GroupLine> findPageForOp(GroupLine groupLine,
				Pageable pageable) {

	        if (pageable == null) {
	            pageable = new Pageable();
	        }
	        List<GroupLine> page = groupLineMapper.findForPageForOp(groupLine, pageable);
	        int pageCount = groupLineMapper.findForPageCountForOp(groupLine,pageable);
	        return new Page<GroupLine>(page, pageCount, pageable);
		}

	/**
	 * 同行用户产品列表
	 * *//*
	@Override
	public Page<GroupLine> findGroupLineList(GroupLine groupLine,Pageable pageable,String[] brand) {
		if (pageable == null) {
			pageable = new Pageable();

		}
		int pageCount = groupLineMapper.findForPageCount(groupLine);
		int pageCount = groupLineMapper.findGroupLineForPageCount(groupLine,pageable);
		int pageCount = 30;
		List<GroupLine> groupLineList= groupLineMapper.findGroupLineForPage(groupLine, pageable,brand);
		return new Page<GroupLine>(groupLineList, pageCount, pageable);
	}*/
}
