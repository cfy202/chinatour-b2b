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
import com.chinatour.entity.PeerUserRate;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.service.CurrencyTypeService;
import com.chinatour.service.PeerUserRateService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2015
 * @author Aries
 * @create-time Jun 25, 2015 10:20:00 AM
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/peerUserRate")
public class PeerUserRateController extends BaseController {

	@Autowired
	private PeerUserRateService  peerUserRateService;
	@Autowired
	private CurrencyTypeService currencyTypeService;

	/**
	 * 保存同行专用汇率
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(PeerUserRate peerUserRate) {
		peerUserRate.setId(UUIDGenerator.getUUID());
		peerUserRateService.save(peerUserRate);
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
		model.addAttribute("currencyTypeList", currencyTypeService.findAll());
		model.addAttribute("peerUserRate", peerUserRateService.findById(id));
		model.addAttribute("menuId", "813");
		return "/admin/basic/currencyType/editPeerUserRate";
	}

	/**
	 * 根据传来的currencyType对象进行更新操作
	 * 
	 * @param currencyType
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(PeerUserRate peerUserRate) {
		peerUserRate.setUpdateTime(new Date());
		peerUserRateService.update(peerUserRate);
		return "redirect:list.jhtml";
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("currencyTypeList", currencyTypeService.findAll());
		model.addAttribute("peerUserRateList", peerUserRateService.findAll());
		model.addAttribute("menuId", "813");
		return "/admin/basic/currencyType/setPeerUserRate";
	}
}
