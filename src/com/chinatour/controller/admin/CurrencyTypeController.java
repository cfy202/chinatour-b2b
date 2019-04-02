package com.chinatour.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.City;
import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.service.CityService;
import com.chinatour.service.CurrencyTypeService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2014
 * @author aries
 * @create-time Sup 25, 2014 19:48:50 PM
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/currencyType")
public class CurrencyTypeController extends BaseController {

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/currencyType";

	/*
	 * 货币币种的业务层注入
	 */
	@Autowired
	private CurrencyTypeService  currencyTypeService;

	/**
	 * 去添加货币币种页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "811");
		return BaseTemplateURL + "/add";
	}

	/**
	 * 根据传来的货币币种对象进行添加操作
	 * 
	 * @param currencyType
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(CurrencyType currencyType) {
		currencyType.setId(UUIDGenerator.getUUID());
		currencyTypeService.save(currencyType);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id执行删除货币币种的操作
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		currencyTypeService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id查询出currencyType对象存入model中，转去修改货币币种页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", "811");
		model.addAttribute("currencyType", currencyTypeService.findById(id));
		return BaseTemplateURL + "/edit";
	}

	/**
	 * 根据传来的currencyType对象进行更新操作
	 * 
	 * @param currencyType
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(CurrencyType currencyType) {
		currencyTypeService.update(currencyType);
		return "redirect:list.jhtml";
	}

	/**
	 * 将menuId值设为808存入model，去城市展示页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "811");
		return BaseTemplateURL + "/list";
	}

	/**
	 * 根据传来的Pageable对象和currencyType对象查出currencyType数据并以map返回
	 * 
	 * @param pageable
	 * @param currencyType
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, CurrencyType currencyType) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<CurrencyType> page = currencyTypeService.findPage(currencyType, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 将menuId值设为808存入model，去城市展示页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/setRate", method = RequestMethod.GET)
	public String setRate(RateOfCurrency rateOfCurrency,Model model) {
		rateOfCurrency.setIsAvailable(0);	//查询可用汇率，过滤不可用数据
		model.addAttribute("rateOfCurrencyList", currencyTypeService.findRateOfCurrency(rateOfCurrency));
		model.addAttribute("currencyTypeList", currencyTypeService.findAll());
		model.addAttribute("currencyType", currencyTypeService.findById(rateOfCurrency.getCurrencyId()));
		model.addAttribute("menuId", "811");
		return BaseTemplateURL + "/setRate";
	}
	
	@RequestMapping(value = "/saveRate", method = RequestMethod.POST)
	public String saveRate(RateOfCurrency rateOfCurrency) {
		rateOfCurrency.setId(UUIDGenerator.getUUID());
		currencyTypeService.save(rateOfCurrency);
		return "redirect:setRate.jhtml?currencyId="+rateOfCurrency.getCurrencyId();
	}
	
	@RequestMapping(value = "/editRate", method = RequestMethod.GET)
	public String editRate(String id,Model model) {
		RateOfCurrency rateOfCurrency = currencyTypeService.findRateById(id);
		model.addAttribute("currencyTypeList", currencyTypeService.findAll());
		model.addAttribute("rateOfCurrency", rateOfCurrency);
		model.addAttribute("menuId", "811");
		return BaseTemplateURL + "/editRate";
	}
	
	@RequestMapping(value = "/updateRate", method = RequestMethod.POST)
	public String updateRate(RateOfCurrency rateOfCurrency) {
		RateOfCurrency oldRate = currencyTypeService.findRateById(rateOfCurrency.getId());
		oldRate.setUpdateTime(new Date());	//设置汇率修改时间
		oldRate.setIsAvailable(1);	//设置旧汇率不可用
		rateOfCurrency.setId(UUIDGenerator.getUUID());
		currencyTypeService.update(oldRate,rateOfCurrency);	//更新旧汇率不可用，插入新汇率数据
		return "redirect:setRate.jhtml?currencyId="+rateOfCurrency.getCurrencyId();
	}
}
