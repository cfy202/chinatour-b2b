/**
 * 
 */
package com.chinatour.controller.admin;

import java.util.Date;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Dept;
import com.chinatour.entity.TourType;
import com.chinatour.entity.TourTypeOfDept;
import com.chinatour.service.CityService;
import com.chinatour.service.CountryService;
import com.chinatour.service.CurrencyTypeService;
import com.chinatour.service.DeptService;
import com.chinatour.service.TourTypeOfDeptService;
import com.chinatour.service.TourTypeService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.TourTypeOfDeptListVO;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

/**
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午2:06:37
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/dept") 
public class DeptController extends BaseController{
	public static final TemplateHashModel CONSTANT;
	
	static {
		TemplateHashModel constant = null;
		try {
			constant = BeansWrapper.getDefaultInstance().getStaticModels();
			constant = (TemplateHashModel)constant.get("com.chinatour.Constant");
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		CONSTANT = constant;
	}
	
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	
	@Resource(name = "countryServiceImpl")
	private CountryService countryService;
	
	@Resource(name = "cityServiceImpl")
	private CityService cityService;
	
	@Resource(name = "currencyTypeServiceImpl")
	private CurrencyTypeService currencyTypeService;
	
	@Resource(name="tourTypeServiceImpl")
	private TourTypeService tourTypeService;
	
	@Resource(name="tourTypeOfDeptServiceImpl")
	private TourTypeOfDeptService tourTypeOfDeptService;
	
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public String list(ModelMap model){
		model.addAttribute("menuId", "901");
		return "/admin/basic/dept/list";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Dept dept) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Dept> page = deptService.findPage(dept,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	
	/**
	 * 添加
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute("menuId", "901");
		model.addAttribute("countrys", countryService.findAll());
		model.addAttribute("citys", cityService.findAll());
		model.addAttribute("currencys", currencyTypeService.findAll());
		model.addAttribute("tourType",tourTypeService.findAll());
		return "/admin/basic/dept/add";
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(Dept dept,String[] typeTours,TourTypeOfDept tourTypeOfDept){
		dept.setDeptId(UUIDGenerator.getUUID());
		dept.setCreateDate(new Date());
//		if(typeTours!=null){
//			for (int i = 0; i < typeTours.length; i++) {
//				TourType tourType= tourTypeService.findById(typeTours[i]);
//				tourTypeOfDept.setTourTypeOfDeptId(UUIDGenerator.getUUID());
//				tourTypeOfDept.setDeptId(dept.getDeptId());
//				tourTypeOfDept.setTourTypeId(tourType.getTourTypeId());
//				tourTypeOfDept.setCode(tourType.getCode());
//				tourTypeOfDeptService.save(tourTypeOfDept);
//			}
//		}
		deptService.save(dept);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del" , method=RequestMethod.GET)
	public String delete(String id,RedirectAttributes redirectAttributes){
		Dept dept=deptService.findById(id);
		dept.setIsDel(1);//邏輯刪除
		deptService.update(dept);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(Dept dept,String[] typeTours,String[] tourTypeOfDeptIds,TourTypeOfDept tourTypeOfDept){
		/*if(tourTypeOfDeptIds!=null){
			tourTypeOfDeptService.delete(tourTypeOfDeptIds);//删除原有的关系
		}
		if(typeTours!=null){
			for (int i = 0; i < typeTours.length; i++) {//添加新的关系
				TourType tourType= tourTypeService.findById(typeTours[i]);
				tourTypeOfDept.setTourTypeOfDeptId(UUIDGenerator.getUUID());
				tourTypeOfDept.setDeptId(dept.getDeptId());
				tourTypeOfDept.setTourTypeId(tourType.getTourTypeId());
				tourTypeOfDept.setCode(tourType.getCode());
				tourTypeOfDeptService.save(tourTypeOfDept);
			}
		}*/
		deptService.update(dept);
		return "redirect:list.jhtml"; 
	}
	
	/**
	 * 按照id加载
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("menuId", "901");
		model.addAttribute("dept",deptService.findById(id));
		model.addAttribute("countrys", countryService.findAll());
		model.addAttribute("citys", cityService.findAll());
		model.addAttribute("currencys", currencyTypeService.findAll());
		model.addAttribute("tourType",tourTypeService.findAll());
		model.addAttribute("tourTypeOfDeptS",tourTypeOfDeptService.queryTourTypeList(id));
		return "/admin/basic/dept/edit";
	}
	
	/**
	 * 按照id加载公司团队类型
	 */
	@RequestMapping(value = "/editTourTypeOfDept", method = RequestMethod.GET)
	public String editTourTypeOfDept(ModelMap model, String id) {
		model.addAttribute("menuId", "901");
		model.addAttribute("dept",deptService.findById(id));
		model.addAttribute("tourType",tourTypeService.findAll());
		model.addAttribute("tourTypeOfDeptS",tourTypeOfDeptService.queryTourTypeList(id));
		return "/admin/basic/dept/editTourtypeOfDept";
	}
	/**
	 * 更新
	 */
	@RequestMapping(value = "/updateTourtypeOfDept" , method=RequestMethod.POST)
	public String updateTourtypeOfDept(String id,TourTypeOfDeptListVO tourTypeOfDeptListVO){
		
		//要删除的原数据 ID
		String[] tourTypeOfDeptIds =new String[tourTypeOfDeptListVO.getTourTypeOfDeptList().size()];
		List<TourTypeOfDept> tourTypeOfDeptList=new ArrayList<TourTypeOfDept>();
		//循环团队类型集合 保存
		for (int i=0;i<tourTypeOfDeptListVO.getTourTypeOfDeptList().size();i++) {
			TourTypeOfDept tourTypeOfDept=tourTypeOfDeptListVO.getTourTypeOfDeptList().get(i);
			if(tourTypeOfDept.getTourTypeOfDeptId()!=null){
				tourTypeOfDeptIds[i]=tourTypeOfDept.getTourTypeOfDeptId();
			}
			if(tourTypeOfDept.getTourTypeId()!=null){
				TourType tourType= tourTypeService.findById(tourTypeOfDept.getTourTypeId());
				tourTypeOfDept.setTourTypeOfDeptId(UUIDGenerator.getUUID());
				tourTypeOfDept.setDeptId(id);
				tourTypeOfDept.setTourTypeId(tourType.getTourTypeId());
				tourTypeOfDept.setCode(tourType.getCode());
				//保存list集合
				tourTypeOfDeptList.add(tourTypeOfDept);
			}
		}
		//删除原有的关系
		if(tourTypeOfDeptIds.length>0){
			tourTypeOfDeptService.delete(tourTypeOfDeptIds);
		}
		//保存
		if(tourTypeOfDeptList.size()>0){
			tourTypeOfDeptService.batchSave(tourTypeOfDeptList);
		}
		
		return "redirect:list.jhtml"; 
	}
	
	
}
