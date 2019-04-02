package com.chinatour.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.ItineraryInfo;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.ItineraryInfoService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2014
 * @author Pis
 * @create-time 2014/8/26 上午10:47:24
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/itinerary")
public class ItineraryInfoController extends BaseController {

	@Resource(name = "itineraryServiceImpl")
	private ItineraryInfoService itineraryInfoService;
	
	@Autowired
	private GroupLineService groupLineService;

	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(ModelMap model) {
		model.addAttribute("menuId", "802");
		return "/admin/basic/itinerary/list";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, ItineraryInfo itinerary) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<ItineraryInfo> page = itineraryInfoService.findPage(itinerary,
				pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 保存
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(ItineraryInfo itinerary) {
		itinerary.setItineraryInfoId(UUIDGenerator.getUUID());
		itineraryInfoService.save(itinerary);
		return "redirect:list.jhtml";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ItineraryInfo itinerary) {
		itineraryInfoService.update(itinerary);
		return "redirect:list.jhtml";
	}

	/**
	 * 按照id加载
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("menuId", "802");
		model.addAttribute("itinerary", itineraryInfoService.findById(id));
		model.addAttribute("groupLines", groupLineService.findAll());
		return "/admin/basic/itinerary/edit";
	}

	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id,RedirectAttributes redirectAttributes) {
		itineraryInfoService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 添加
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		model.addAttribute("menuId", "802");
		model.addAttribute("groupLines", groupLineService.findAll());
		return "/admin/basic/itinerary/add";
	}
	
	/**
	 * 按照id加载
	 */
	@RequestMapping(value = "/preview", method = RequestMethod.GET)
	public String preview(ModelMap model, String id) {
		//PDFGenerater.createInvoice("123456");
		//PDFService.createItinerary(itineraryInfoService.findById(id));
		model.addAttribute("menuId", "802");
		model.addAttribute("itinerary", itineraryInfoService.findById(id));
		return "/admin/basic/itinerary/preview";
	}
	
	@RequestMapping(value = "/showBody", method = RequestMethod.GET)
	public String showBody(ModelMap model, String id) {
		//PDFGenerater.createInvoice("123456");
		//PDFService.createItinerary(itineraryInfoService.findById(id));
		model.addAttribute("menuId", "802");
		model.addAttribute("itinerary", itineraryInfoService.findById(id));
		return "/admin/basic/itinerary/itineraryBody";
	}
}
