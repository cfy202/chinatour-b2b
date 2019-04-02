/**
 * 
 */
package com.chinatour.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.fileUploadStatus;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Appendix;
import com.chinatour.entity.Enquirys;
import com.chinatour.entity.Notice;
import com.chinatour.entity.NoticeContact;
import com.chinatour.service.AdminService;
import com.chinatour.service.AppendixService;
import com.chinatour.service.FileService;
import com.chinatour.service.NoticeService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-16 下午3:41:41
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/notice")
public class NoticeController extends BaseController{
	
	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;
	
	@Resource(name = "adminServiceImpl")
    private AdminService adminService;
	
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	
	@Resource(name = "appendixServiceImpl")
	private AppendixService appendixService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/listIn" , method = RequestMethod.GET)
	public String listIn(ModelMap model){
		model.addAttribute("menuId", "602");
		return "/admin/notice/inboxList";
	}
	
	/**
	 * 异步查询收件箱
	 */
	@RequestMapping(value = "/listIn", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listIn(Pageable pageable, NoticeContact noticeContact) {
		Admin admin = adminService.getCurrent();
		noticeContact.setReceiveUser(admin.getId());
		noticeContact.setState(3);
		Page<NoticeContact> page = noticeService.findPage(noticeContact,pageable);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/listOut" , method = RequestMethod.GET)
	public String listOut(ModelMap model){
		model.addAttribute("menuId", "603");
		return "/admin/notice/outboxList";
	}
	
	/**
	 * 异步查询发件箱
	 */
	@RequestMapping(value = "/listOut", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listOut(Pageable pageable, NoticeContact noticeContact) {
		Admin admin = adminService.getCurrent();
		noticeContact.setSendUser(admin.getId());
		noticeContact.setState(3);
		Page<NoticeContact> page = noticeService.findSendBoxPage(noticeContact,pageable);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/listDrafts" , method = RequestMethod.GET)
	public String listDrafts(ModelMap model){
		model.addAttribute("menuId", "604");
		return "/admin/notice/draftsList";
	}
	
	/**
	 * 异步查询发件箱
	 */
	@RequestMapping(value = "/listDrafts", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listDrafts(Pageable pageable, NoticeContact noticeContact) {
		Admin admin = adminService.getCurrent();
		noticeContact.setSendUser(admin.getId());
		noticeContact.setState(2);
		Page<NoticeContact> page = noticeService.findSendBoxPage(noticeContact,pageable);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 添加Vender信息，并且加载国家信息
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(ModelMap model){
		model.addAttribute("adminList", adminService.findAllOfDeptName());
		model.addAttribute("menuId", "601");
		return "/admin/notice/add";
	}
	
	/**
	 * 新增保存,草稿箱发送保存
	 @param noticeContact 联系人
	 * @param receiveUserS 收件人
	 * @param receiveUserC 抄送人
	 * @param appendixFile 附件地址
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(NoticeContact noticeContact, String[] receiveUserS,String tempId,
			String[] receiveUserC, RedirectAttributes redirectAttributes) {
		Admin admin = adminService.getCurrent();
		if(admin!=null){
			Notice notice = noticeContact.getNotice();
			notice.setNoticeId(UUIDGenerator.getUUID());
			
			List<NoticeContact> saveList = new ArrayList<NoticeContact>();
			List<NoticeContact> updateList = new ArrayList<NoticeContact>();
			List<Appendix> appendixList = new ArrayList<Appendix>();
			String delNotice = null;
			//发件箱保存
			if(receiveUserS!=null){
				for(String receiveUser:receiveUserS){
					NoticeContact nc = new NoticeContact();
					nc.setNoticeContactId(UUIDGenerator.getUUID());
					nc.setSendUser(admin.getId());
					nc.setReceiveUser(receiveUser);
					nc.setType(1);
					nc.setState(0);
					nc.setNoticeId(notice.getNoticeId());
					saveList.add(nc);
				}
			}
			if(receiveUserC!=null){
				for(String receiveUser:receiveUserC){
					NoticeContact nc = new NoticeContact();
					nc.setNoticeContactId(UUIDGenerator.getUUID());
					nc.setSendUser(admin.getId());
					nc.setReceiveUser(receiveUser);
					nc.setType(2);
					nc.setState(0);
					nc.setNoticeId(notice.getNoticeId());
					saveList.add(nc);
				}
			}
			
			if(noticeContact.getAppendixFile()!=null&&noticeContact.getAppendixFile().size()!=0){
				for(Map.Entry<String, String> entry:noticeContact.getAppendixFile().entrySet()){
					Appendix app = new Appendix();
					app.setAppendixId(UUIDGenerator.getUUID());
					app.setAppendixFile(entry.getKey());
					app.setAppendixName(entry.getValue());
					app.setServerIp(Constant.SERVERIP);
					app.setNoticeId(notice.getNoticeId());
					appendixList.add(app);
				}
			}
			if(noticeContact.getNoticeId()!=null){
				//草稿箱发出后，删除原草稿箱文件
				delNotice = noticeContact.getNoticeId();
			}
			
			noticeService.save(saveList,updateList, notice,delNotice,appendixList);
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		if(tempId!=null&tempId!=""){
			return "redirect:details.jhtml?id="+tempId;
		}
		return "redirect:add.jhtml";
	}
	
	/**
	 *  草稿箱发送保存
	 * @param noticeContact 联系人
	 * @param receiveUserS 收件人
	 * @param receiveUserC 抄送人
	 * @param appendixFile 附件地址
	 * @return
	 */
	@RequestMapping(value = "/saveDrafts", method = RequestMethod.POST)
	public String saveDrafts(NoticeContact noticeContact,
			String[] receiveUserS, String[] receiveUserC,
			RedirectAttributes redirectAttributes, String tempId) {
		Admin admin = adminService.getCurrent();
		if(admin!=null){
			Notice notice = noticeContact.getNotice();
			notice.setNoticeId(UUIDGenerator.getUUID());
			
			List<NoticeContact> saveList = new ArrayList<NoticeContact>();
			List<NoticeContact> updateList = new ArrayList<NoticeContact>();
			List<Appendix> appendixList = new ArrayList<Appendix>();
			//草稿箱保存
			if(receiveUserS!=null){
				for(String receiveUser:receiveUserS){
					NoticeContact nc = new NoticeContact();
					nc.setSendUser(admin.getId());
					nc.setReceiveUser(receiveUser);
					nc.setType(1);
					nc.setState(2);
					nc.setNoticeId(notice.getNoticeId());
					if(noticeContact.getNoticeContactId() != null){
						//草稿箱编辑保存
						nc.setNoticeContactId(noticeContact.getNoticeContactId());
						updateList.add(nc);
					}else{
						//草稿箱保存
						nc.setNoticeContactId(UUIDGenerator.getUUID());
						saveList.add(nc);
					}
				}
			}
			if(receiveUserC!=null){
				for(String receiveUser:receiveUserC){
					NoticeContact nc = new NoticeContact();
					nc.setSendUser(admin.getId());
					nc.setReceiveUser(receiveUser);
					nc.setType(2);
					nc.setState(2);
					nc.setNoticeId(notice.getNoticeId());
					if(noticeContact.getNoticeContactId() != null){
						//草稿箱编辑保存
						nc.setNoticeContactId(noticeContact.getNoticeContactId());
						updateList.add(nc);
					}else{
						//草稿箱保存
						nc.setNoticeContactId(UUIDGenerator.getUUID());
						saveList.add(nc);
					}
				}
			}
			if(receiveUserS==null||receiveUserC==null){
				NoticeContact nc = new NoticeContact();
				nc.setSendUser(admin.getId());
				nc.setReceiveUser("");
				nc.setType(2);
				nc.setState(2);
				nc.setNoticeId(notice.getNoticeId());
				if(noticeContact.getNoticeContactId() != null){
					//草稿箱编辑保存
					nc.setNoticeContactId(noticeContact.getNoticeContactId());
					updateList.add(nc);
				}else{
					//草稿箱保存
					nc.setNoticeContactId(UUIDGenerator.getUUID());
					saveList.add(nc);
				}
			}
			if(noticeContact.getAppendixFile()!=null&&noticeContact.getAppendixFile().size()!=0){
				for(Map.Entry<String, String> entry:noticeContact.getAppendixFile().entrySet()){
					Appendix app = new Appendix();
					app.setAppendixId(UUIDGenerator.getUUID());
					app.setAppendixFile(entry.getKey());
					app.setAppendixName(entry.getValue());
					app.setServerIp(Constant.SERVERIP);
					app.setNoticeId(notice.getNoticeId());
					appendixList.add(app);
				}
			}
			
			noticeService.save(saveList,updateList, notice,null,appendixList);
		}
		if(tempId!=null&tempId!=""){
			return "redirect:details.jhtml?id="+tempId;
		}
		return "redirect:add.jhtml";
	}
	
	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del" , method=RequestMethod.GET)
	public String delete(String id,RedirectAttributes redirectAttributes){
		noticeService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(NoticeContact noticeContact){
		/*vender.setModifyDate(new Date());
		vender.setIsDel(vender.getIsDel());*/
		noticeService.update(noticeContact);
		return "redirect:list.jhtml"; 
	}
	
	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("menuId", "604");
		NoticeContact noticeContact = noticeService.findById(id);
		model.addAttribute("noticeContact",noticeContact);
		model.addAttribute("receiverList",noticeService.findReceiveUser(noticeContact.getNoticeId()));
		model.addAttribute("adminList", adminService.findAllOfDeptName());
		model.addAttribute("AppendixList", appendixService.findByNoticeId(noticeContact.getNoticeId()));
		return "/admin/notice/edit";
	}
	
	/**
	 * 按id查看站内信信息
	 */
	@RequestMapping(value = "/details", method = RequestMethod.GET)
	public String details(ModelMap model, String id) {
		model.addAttribute("menuId", "603");
		NoticeContact noticeContact = noticeService.findById(id);
		noticeContact.setState(1);
		noticeService.update(noticeContact);
		model.addAttribute("noticeContact",noticeContact);
		model.addAttribute("receiverList",noticeService.findReceiveUser(noticeContact.getNoticeId()));
		model.addAttribute("AppendixList", appendixService.findByNoticeId(noticeContact.getNoticeId()));
		return "/admin/notice/details";
	}
	
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/upload" , method=RequestMethod.POST)
	public @ResponseBody String upload(MultipartFile file){
		return fileService.uploadLocal(FileType.appendixPath,file);
	}
	/**
	 * 显示进度上传
	 * 通过前台js 多次访问显示
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/doPost", method = RequestMethod.GET)
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		fileUploadStatus status = (fileUploadStatus) session.getAttribute("status");
		try {
			response.reset();
			response.getWriter().write("{\"pBytesRead\":"
					+status.getPBytesRead()+",\"pContentLength\":"+status.getPContentLength()+"}");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
			HttpServletResponse response,String id) throws Exception {
		String contentType = "application/octet-stream";
		Appendix appendix=appendixService.findById(id);
		String downLoadPath=appendix.getAppendixFile();
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	
	/**
	 * 转发
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/forward", method = RequestMethod.GET)
	public String forward(ModelMap model, String id) {
		model.addAttribute("menuId", "603");
		NoticeContact noticeContact = noticeService.findById(id);
		model.addAttribute("noticeContact",noticeContact);
		model.addAttribute("receiverList",noticeService.findReceiveUser(noticeContact.getNoticeId()));
		model.addAttribute("adminList", adminService.findAllOfDeptName());
		model.addAttribute("AppendixList", appendixService.findByNoticeId(noticeContact.getNoticeId()));
		return "/admin/notice/forward";
	}
	
	/**
	 * 回复
	 */
	@RequestMapping(value = "/reply", method = RequestMethod.GET)
	public String reply(ModelMap model, String id) {
		model.addAttribute("menuId", "603");
		NoticeContact noticeContact = noticeService.findById(id);
		model.addAttribute("noticeContact",noticeContact);
		model.addAttribute("receiverList",noticeService.findReceiveUser(noticeContact.getNoticeId()));
		model.addAttribute("adminList", adminService.findAllOfDeptName());
		model.addAttribute("AppendixList", appendixService.findByNoticeId(noticeContact.getNoticeId()));
		return "/admin/notice/reply";
	}
	
}
