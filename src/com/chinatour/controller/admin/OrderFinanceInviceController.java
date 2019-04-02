package com.chinatour.controller.admin;

import java.util.HashMap;
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
import com.chinatour.service.CityService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time Jan 30, 2015 9:48:04 AM
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/orderFinanceInvice")
public class OrderFinanceInviceController extends BaseController {
	
}
