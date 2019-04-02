package com.chinatour.controller.admin;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by XuXuebin on 2014/8/7.
 */
@Controller
@RequestMapping("/admin/datatables")
public class DataTablesController {

    @Autowired
    private AdminService adminService;


    @RequestMapping(method = RequestMethod.GET)
    public String main(Model model) {
        model.addAttribute("menuId", "12");
        return "/admin/common/datatables";
    }
//
//    @RequestMapping(value = "/list", method = RequestMethod.GET)
//    public String list(Model model) {
//        model.addAttribute("menuId", "12");
//        return "/admin/common/datatables";
//    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public
    @ResponseBody
    Map<String, Object> list(Pageable pageable, Admin admin) {
        Map<String, Object> map = new HashMap<String, Object>();
        Page<Admin> page = adminService.findPage(admin, pageable);
        map.put("recordsTotal", page.getTotal());
        map.put("recordsFiltered", page.getTotal());
        map.put("data", page.getContent());
        return map;
    }
}
