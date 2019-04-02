/**
 * 
 */
package com.chinatour.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.chinatour.Constant;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.Setting;
import com.chinatour.entity.Enquirys;
import com.chinatour.entity.ShareSpace;
import com.chinatour.entity.ShareType;
import com.chinatour.service.AdminService;
import com.chinatour.service.FileService;
import com.chinatour.service.ShareSpaceService;
import com.chinatour.service.TourTypeService;
import com.chinatour.util.FreemarkerUtils;
import com.chinatour.util.SettingUtils;
import com.chinatour.util.UUIDGenerator;

import freemarker.template.TemplateException;

/**
 * @copyright Copyright: 2014
 * @author Nina
 * @create-time 2014-9-15 上午10:10:10
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/shareSpace")
public class ShareSpaceController extends BaseController {

	@Resource(name = "shareSpaceServiceImpl")
	private ShareSpaceService shareSpaceService;
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;

	@Resource(name = "fileServiceImpl")
	private FileService fileService;

	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(ModelMap model) {
		model.addAttribute("menuId", "701");
		return "/admin/shareSpace/shareTypeList";
	}

	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, ShareType shareType) {
		Map<String, Object> map = new HashMap<String, Object>();
		shareType.setIsDel(0);
		Page<ShareType> page = shareSpaceService.findPage(shareType, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/shareSpaceList", method = RequestMethod.GET)
	public String shareSpaceList(ModelMap model, ShareSpace shareSpace) {
		List<ShareSpace> shareSpaceList = shareSpaceService.find(shareSpace);
		model.addAttribute("menuId", "711");
		model.addAttribute("shareSpaceList", shareSpaceList);
		model.addAttribute("shareTypeId", shareSpace.getShareTypeId());
		return "/admin/shareSpace/shareSpaceList";
	}

	/**
	 * 添加Vender信息，并且加载国家信息
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		return "/admin/shareSpace/shareTypeAdd";
	}

	/**
	 * 保存
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(ShareType shareType) {
		shareType.setShareTypeId(UUIDGenerator.getUUID());
		shareSpaceService.save(shareType);
		return "redirect:list.jhtml";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ShareType tourType) {
		shareSpaceService.update(tourType);
		return "redirect:list.jhtml";
	}

	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("shareType", shareSpaceService.findById(id));
		return "/admin/shareSpace/shareTypeEdit";
	}

	/**
	 * 添加Vender信息，并且加载国家信息
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload(ModelMap model, String shareTypeId) {
		model.addAttribute("shareTypeId", shareTypeId);
		return "/admin/shareSpace/upload";
	}

	/**
	 * 上传
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(ShareSpace shareSpace, String shareTypeId,
			ModelMap model, MultipartFile file, HttpServletRequest request)
			throws IOException {

		if (file.isEmpty()) {
		} else {
			shareSpace.setShareName(file.getOriginalFilename());
			shareSpace.setShareSpaceId(UUIDGenerator.getUUID());
			shareSpace.setShareTypeId(shareTypeId);
			shareSpace.setModifyDate(new Date());
			shareSpace.setUserId(adminService.getCurrent().getId());

			String fileString = fileService.uploadLocal(FileType.sharePath,file);
			shareSpace.setShareUrl(fileString);
			shareSpace.setServerIp(Constant.SERVERIP);
			shareSpaceService.save(shareSpace);
		}
		model.addAttribute("shareTypeId", shareTypeId);
		return "redirect:shareSpaceList.jhtml";
	}

	/**
	 * 下载
	 * 
	 * @author
	 * @date
	 * @param attachment
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response, String shareSpaceId) throws Exception {

		ShareSpace shareSpace = shareSpaceService.findById(shareSpaceId, null);
		String downLoadPath = shareSpace.getShareUrl();
		String contentType = "application/octet-stream";
		if (downLoadPath.isEmpty()) {
			return null;
		}
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
}
