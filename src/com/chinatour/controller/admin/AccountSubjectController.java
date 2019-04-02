package com.chinatour.controller.admin;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.AccountSubject;
import com.chinatour.entity.Admin;
import com.chinatour.entity.BusinessFlow;
import com.chinatour.entity.BusinessFlowOfGlobalExcle;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GlobalAccount;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.entity.ReportForGroupExcle;
import com.chinatour.entity.SmallGroup;
import com.chinatour.entity.StatisticalProfit;
import com.chinatour.service.AccountSubjectService;
import com.chinatour.service.AdminService;
import com.chinatour.service.BusinessFlowService;
import com.chinatour.service.DeptService;
import com.chinatour.service.FinanceSubjectService;
import com.chinatour.service.GlobalAccountService;
import com.chinatour.service.SmallGroupService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.AccountSubjectVO;
import com.chinatour.vo.BusinessFlowVO;

@Controller
@RequestMapping("/admin/accountSubject")
public class AccountSubjectController extends BaseController {
	@Resource(name="adminServiceImpl")
	private AdminService adminService;
	@Resource(name = "globalAccountServiceImpl")
	private GlobalAccountService globalAccountService;
	@Resource(name = "accountSubjectServiceImpl")
	private AccountSubjectService accountSubjectService;
	@Resource(name = "financeSubjectServiceImpl")
	private FinanceSubjectService financeSubjectService;
	@Resource(name = "businessFlowServiceImpl")
	private BusinessFlowService businessFlowService;
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	@Resource(name = "smallGroupServiceImpl")
	private SmallGroupService smallGroupService;
	
	/**
	 * 基本路径
	 */
	private String BaseTemplateURL = "/admin/accountSubject";
	
	/**
	 * 会计科目设置
	 * @return
	 */
	@RequestMapping(value="/accountingSetup",method=RequestMethod.GET)
	public String accountingSetup(Model model){
		//获取会计科目类型
		String[] accountTypeList =Constant.accountType;
		Admin admin = adminService.getCurrent();
		GlobalAccount globalAccount = new GlobalAccount();
		globalAccount.setSubjectType("3");//设置点击科目设置按钮时进入页面时显示的会计科目类型-资产类
		globalAccount.setDeptId(admin.getDeptId());
		// 查询该部门未选择的会计科目
		List<GlobalAccount> globalAccountList = globalAccountService.queryNoChooseglobalAccount(globalAccount);
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setSubjectType(3);//设置点击科目设置按钮时进入页面时显示的会计科目类型-资产类
		accountSubject.setIsDel(0);
		List<AccountSubject> accountSubjectList = accountSubjectService.searchDeptAccountSubject(accountSubject);
		model.addAttribute("accountTypeList",accountTypeList);
		model.addAttribute("globalAccountList", globalAccountList);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1001");
		return BaseTemplateURL+"/accountingSetup";
	}
	
	@RequestMapping(value="/accountingSetupForSubjectType",method=RequestMethod.GET)
	public @ResponseBody Map<String,Object> accountingSetupForSubjectType(String subjectType){
		Admin admin = adminService.getCurrent();
		GlobalAccount globalAccount = new GlobalAccount();
		globalAccount.setSubjectType(subjectType);
		globalAccount.setDeptId(admin.getDeptId());
		// 查询该部门未选择的会计科目
		List<GlobalAccount> globalAccountList = globalAccountService.queryNoChooseglobalAccount(globalAccount);
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setSubjectType(Integer.parseInt(subjectType));
		accountSubject.setIsDel(0);
		accountSubject.setGlobalAccountId("A");
		List<AccountSubject> accountSubjectList = accountSubjectService.queryDeptBusinessSubject(accountSubject);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("globalAccountList", globalAccountList);
		map.put("accountSubjectList", accountSubjectList);
		return map;
	}
	
	/**
	 * 批量向部门会计科目添加
	 * @param globalFinanceSubjectId
	 * @return
	 */
	@RequestMapping(value="/addAccountSubjectForDept",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> addAccountSubjectForDept(AccountSubjectVO accountSubjectVO){
		//未解决页面传值时为空问题则去除globalFinanceSubjectId为null的值
		Admin admin = adminService.getCurrent();
		List<AccountSubject> accountSubjecList = accountSubjectVO.getAccountSubjectList();
		List<AccountSubject> accountSubjectListForRemove = new ArrayList<AccountSubject>();
		for(AccountSubject accountSubject:accountSubjecList){
			if(accountSubject.getGlobalAccountId()==null){
				accountSubjectListForRemove.add(accountSubject);
			}
		}
		accountSubjecList.removeAll(accountSubjectListForRemove);
		AccountSubject as = new AccountSubject();
		List<AccountSubject> accListForOne = new ArrayList<AccountSubject>();
		List<AccountSubject> accListForTwo = new ArrayList<AccountSubject>();
		for(AccountSubject accountSubject:accountSubjecList){
			accountSubject.setAccountSubjectId(UUIDGenerator.getUUID());
			accountSubject.setDeptId(admin.getDeptId());
			accountSubject.setCreateTime(new Date());
			if(accountSubject.getLevel()==1){
				accListForOne.add(accountSubject);
			}
			if(accountSubject.getLevel()==2){
				accListForTwo.add(accountSubject);
			}
		}
		if(accListForOne!=null&&accListForOne.size()!=0){
			accountSubjectService.addAccountToDept(accListForOne);
		}
		for(AccountSubject acc:accListForTwo){
			as.setDeptId(admin.getDeptId());
			as.setSubjectCode(acc.getSubjectCode().substring(0,5));
			List<AccountSubject> asList = accountSubjectService.find(as);
			if(asList.size()!=0){
				acc.setParentSubjectId(asList.get(0).getAccountSubjectId());
				acc.setParentSubjectCode(asList.get(0).getSubjectCode());
			}
		}
		if(accListForTwo!=null&&accListForTwo.size()!=0){
			accountSubjectService.addAccountToDept(accListForTwo);
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ok", "ok");
		return map;
	}
	/**
	 * 移除部门会计科目（科目设置）
	 * @param financeSubjectId
	 * @return
	 */
	@RequestMapping(value="/deleteAccountSubject",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> deleteFinance(String accountSubjectId){
		String[] accountSubjectIds = accountSubjectId.split(",");
		for(int i=0;i<accountSubjectIds.length;i++){
			accountSubjectService.delete(accountSubjectIds[i]);
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ok", "ok");
		return map;
	}
	
	//删除科目（科目管理）
	@RequestMapping(value="/deleteSubject",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> deleteSubject(String accountSubjectId){
		accountSubjectService.delete(accountSubjectId);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ok", "ok");
		return map;
	}
	
	@RequestMapping(value="/accountingManage",method=RequestMethod.GET)
	public String accountingManage(Model model,Integer subjectType){
		Admin admin = adminService.getCurrent();
		List<SmallGroup> groupList = smallGroupService.findByDeptId(admin.getDeptId());
		model.addAttribute("subjectType", subjectType);
		model.addAttribute("menuId", "1002");
		model.addAttribute("groupList", groupList);
		return BaseTemplateURL+"/accountingManage";
	}
	
	@RequestMapping(value = "/accountingManage", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> accountingManage(Pageable pageable, AccountSubject accountSubject,Model model) {
		Admin admin = adminService.getCurrent();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setIsDel(0);
		Map<String, Object> map = new HashMap<String, Object>();
		Page<AccountSubject> page = accountSubjectService.findPage(accountSubject,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/*@RequestMapping(value = "/changeAccChildDept", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> changeAccChildDept(AccountSubject accountSubject) {
		accountSubjectService.update(accountSubject);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ok", "ok");
		return map;
	}*/
	
	@RequestMapping(value = "/changeAccChildDept", method = RequestMethod.POST)
	public String changeAccChildDept(AccountSubject accountSubject) {
		accountSubjectService.update(accountSubject);
		return "redirect:accountingManage.jhtml?subjectType="+accountSubject.getSubjectType();
	}
	
	/*@RequestMapping(value = "/addAccountSubject", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> addAccountSubject(AccountSubject accountSubject) {
		accountSubjectService.save(accountSubject);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ok", "ok");
		return map;
	}*/
	
	@RequestMapping(value = "/addAccountSubject", method = RequestMethod.POST)
	public String addAccountSubject(AccountSubject accountSubject) {
		Admin admin = adminService.getCurrent();
		accountSubject.setAccountSubjectId(UUIDGenerator.getUUID());
		accountSubject.setLevel(3);
		accountSubject.setHasChild(0);
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setCreateTime(new Date());
		accountSubjectService.save(accountSubject);
		AccountSubject parentSubject = new AccountSubject();
		parentSubject.setAccountSubjectId(accountSubject.getParentSubjectId());
		parentSubject.setHasChild(1);
		accountSubjectService.update(parentSubject);
		return "redirect:accountingManage.jhtml?subjectType="+accountSubject.getSubjectType();
	}
	
	@RequestMapping(value="/businessFlowManage",method=RequestMethod.GET)
	public String businessFlowManage(Model model){
		model.addAttribute("menuId", "1003");
		return BaseTemplateURL+"/businessFlowManage";
	}
	
	/**
	 * 报表列表
	 * @param pageable
	 * @param businessFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/businessFlowManage", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> businessFlowManage(Pageable pageable, BusinessFlow businessFlow,Model model) {
		Admin admin = adminService.getCurrent();
		businessFlow.setDeptId(admin.getDeptId());
		Map<String, Object> map = new HashMap<String, Object>();
		Page<BusinessFlow> page = businessFlowService.findPage(businessFlow, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 删除报表
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="/delBusinessFlow",method = RequestMethod.GET)
	public String delBusinessFlow(String id,RedirectAttributes redirectAttributes){
		businessFlowService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:businessFlowManage";
	}
	
	/**
	 * 修改报表
	 * @param businessFlow
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="/updateBusinessFlow",method = RequestMethod.POST)
	public String updateBusinessFlow(BusinessFlow businessFlow,RedirectAttributes redirectAttributes){
		businessFlowService.update(businessFlow);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:businessFlowManage";
	}
	
	/**
	 * 添加报表信息(income)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addAccountForSalesIncome",method = RequestMethod.GET)
	public String addAccountForSalesIncome(Model model){
		Admin admin = adminService.getCurrent();
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setSubjectType(3);
		accountSubject.setIsDel(0);
		List<AccountSubject> accountSubjectList = accountSubjectService.query(accountSubject);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		return BaseTemplateURL+"/addAccountForSalesIncome";
	}
	
	/**
	 * 添加报表信息(income)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addAccountForTourCost",method = RequestMethod.GET)
	public String addAccountForTourCost(Model model){
		Admin admin = adminService.getCurrent();
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setSubjectType(4);
		accountSubject.setIsDel(0);
		List<AccountSubject> accountSubjectList = accountSubjectService.query(accountSubject);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		return BaseTemplateURL+"/addAccountForTourCost";
	}
	
	/**
	 * 添加报表信息(income)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addAccountForIncome",method = RequestMethod.GET)
	public String addReportForm(Model model){
		Admin admin = adminService.getCurrent();
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setSubjectType(1);
		accountSubject.setIsDel(0);
		List<AccountSubject> accountSubjectList = accountSubjectService.query(accountSubject);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		return BaseTemplateURL+"/addAccountForIncome";
	}
	
	/**
	 * 添加报表信息(cost)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addAccountForCost",method = RequestMethod.GET)
	public String addAccountForCost(Model model){
		Admin admin = adminService.getCurrent();
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(admin.getDeptId());
		accountSubject.setSubjectType(2);
		accountSubject.setIsDel(0);
		List<AccountSubject> accountSubjectList = accountSubjectService.query(accountSubject);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		return BaseTemplateURL+"/addAccountForCost";
	}
	
	/**
	 * 查看报表信息（region）
	 * @return
	 */
	@RequestMapping(value="/searchAccountInfo",method = RequestMethod.GET)
	public String searchAccountInfo(Model model){
		Admin admin = adminService.getCurrent();
		List<RegionDeptRel> regionList = deptService.findRegionByDeptId(admin.getDeptId());
		String regionId = regionList.get(0).getRegionId();
		List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
		List<RegionDeptRel> regionDeptList = deptService.findByRegionId(regionId);
		for(RegionDeptRel regionDept:regionDeptList){
			StatisticalProfit statisticalProfitTemp = new StatisticalProfit();
			statisticalProfitTemp.setDeptId(regionDept.getDeptId());
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			String time = simpleDateFormat.format(new Date());
			statisticalProfitTemp.setTime(time);
			statisticalProfitList.add(statisticalProfitTemp);
		}
		
		statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
		model.addAttribute("statisticalProfitList", statisticalProfitList);
		model.addAttribute("menuId", "1004");
		return BaseTemplateURL+"/searchAccountInfo";
		
	}
	
	@RequestMapping(value="/saveBusinessFlow",method = RequestMethod.POST)
	public String saveBusinessFlow(BusinessFlowVO businessFlowVO,RedirectAttributes redirectAttributes){
		Admin admin = adminService.getCurrent();
		List<BusinessFlow> businessFlowList = new ArrayList<BusinessFlow>();
		List<BusinessFlow> businessFlowListForNoZero = new ArrayList<BusinessFlow>();
		businessFlowList = businessFlowVO.getBusinessFlowList();
		BusinessFlow businessFlowFlag = businessFlowVO.getBusinessFlow();
		for(BusinessFlow businessFlow:businessFlowList){
			if((businessFlow.getAccountsSum()!=null)&&(businessFlow.getAccountsSum().intValue()!=0)&& businessFlow.getAccountSubjectId()!=null){
				businessFlow.setBusinessFlowId(UUIDGenerator.getUUID());
				businessFlow.setCreateTime(new Date());
				businessFlow.setDeptId(admin.getDeptId());
				businessFlow.setIfClose(0);
				businessFlow.setIsAvailable(0);
				businessFlow.setIsAvailable(0);
				businessFlow.setIsDel(0);
				if(businessFlowFlag.getAccountDate()!=null){
					businessFlow.setAccountDate(businessFlowFlag.getAccountDate());
				}else{
					businessFlow.setAccountDate(businessFlow.getCreateTime());
				}
				businessFlow.setSubjectType(businessFlowFlag.getSubjectType());
				businessFlowListForNoZero.add(businessFlow);
			}
		}
		if(businessFlowListForNoZero!=null&&businessFlowListForNoZero.size()!=0){
			businessFlowService.insertBatch(businessFlowListForNoZero);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:businessFlowManage";
	}
	
	//获取本部门的报表信息（office）
	@RequestMapping(value="/searchInfoForDept",method = RequestMethod.GET)
	public String searchInfoForDept(Model model){
		Admin admin = adminService.getCurrent();
		List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
		StatisticalProfit statisticalProfitTemp = new StatisticalProfit();
		statisticalProfitTemp.setDeptId(admin.getDeptId());
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
		String time = simpleDateFormat.format(new Date());;
		statisticalProfitTemp.setTime(time);
		statisticalProfitList.add(statisticalProfitTemp);
		statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
		model.addAttribute("statisticalProfitList", statisticalProfitList);
		model.addAttribute("menuId", "1003");
		return BaseTemplateURL+"/searchInfoForDept";
	}
	
	//改变年份时ajax获取部门报表信息（office）
	@RequestMapping(value="/searchInfoForDeptWithAjax",method = RequestMethod.GET)
	public @ResponseBody Map<String,List<StatisticalProfit>> searchInfoForDeptWithAjax(String year){
		Admin admin = adminService.getCurrent();
		StatisticalProfit statisticalProfitTemp = new StatisticalProfit();
		statisticalProfitTemp.setDeptId(admin.getDeptId());
		statisticalProfitTemp.setTime(year);
		List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
		statisticalProfitList.add(statisticalProfitTemp);
		statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
		Map<String,List<StatisticalProfit>> map = new HashMap<String,List<StatisticalProfit>>();
		map.put("statisticalProfitList", statisticalProfitList);
		return map;
	}
	
	//改变年份时ajax获取区域报表信息（region）
		@RequestMapping(value="/searchInfoAjax",method = RequestMethod.GET)
		public @ResponseBody Map<String,List<StatisticalProfit>> searchInfoAjax(String year){
			Admin admin = adminService.getCurrent();
			List<RegionDeptRel> regionList = deptService.findRegionByDeptId(admin.getDeptId());
			String regionId = regionList.get(0).getRegionId();
			List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
			List<RegionDeptRel> regionDeptList = deptService.findByRegionId(regionId);
			for(RegionDeptRel regionDept:regionDeptList){
				StatisticalProfit statisticalProfit = new StatisticalProfit();
				statisticalProfit.setTime(year);
				statisticalProfit.setDeptId(regionDept.getDeptId());
				statisticalProfitList.add(statisticalProfit);
			}
			statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
			Map<String,List<StatisticalProfit>> map = new HashMap<String,List<StatisticalProfit>>();
			map.put("statisticalProfitList", statisticalProfitList);
			return map;
		}
	
		//查看全部科目报表信息
	@RequestMapping(value="/businessFlowOfGlobal",method = RequestMethod.GET)
	public String businessFlowOfGlobal(String deptId,String year,String childAccDept,String subjectType, Model model){
		Dept dept = deptService.findById(deptId);
		Admin admin = null;
		if(dept==null){
			admin = adminService.getCurrent();
			dept = deptService.findById(admin.getDeptId());
		}
		BusinessFlow businessFlow = new BusinessFlow();
		businessFlow.setAccountDateStr(Integer.valueOf(year));
		businessFlow.setDeptId(dept.getDeptId());
		if(businessFlow.getDeptId()==null || businessFlow.getDeptId()==""){
			businessFlow.setDeptId(admin.getDeptId());
		}
		businessFlow.setIsDel(0);
		if(businessFlow.getAccountDateStr() == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			businessFlow.setAccountDateStr(Integer.valueOf(sdf.format(new Date())));
		}
		List<BusinessFlow> businessFlowList = new ArrayList<BusinessFlow>();
		List<AccountSubject> accountSubjectList = new ArrayList<AccountSubject>();
		businessFlowList = businessFlowService.searchBusinessFlowOfDept(businessFlow);
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(businessFlow.getDeptId());
		accountSubject.setChildAccDept(childAccDept);
		accountSubject.setIsDel(0);
		//判断显示income/cost
		String flag = "";
		if(subjectType!=null&&subjectType!=""){
			accountSubject.setSubjectType(Integer.valueOf(subjectType));
			flag=subjectType.toString();
		}
		accountSubjectList = accountSubjectService.queryDeptBusinessSubject(accountSubject);
		//如果是分小组
		if(childAccDept!=null&&childAccDept!=""&&accountSubjectList.size()!=0){
			//用于存储group by之后的一级code
			int size=accountSubjectList.size();
			for(int q=0;q<size;q++){
				if(q==size){
					break;
				}else{
					String code=accountSubjectList.get(q).getSubjectCode();
					String accId1=code.substring(0, 4);
					//String accId2=accountSubjectList.get(q+1).getSubjectCode().substring(0, 4);
					String accId2=accountSubjectList.get(q+1).getSubjectCode().substring(0, 4);
					//是二级或三级目录
					String accId3=null;//获取模糊的二级code
					if(accountSubjectList.get(q).getSubjectCode().indexOf("-")==4){
						accId3=code.substring(0, 7);
					}
					
					if(!accId1.equals(accId2)){
						List<AccountSubject> listAccountSubject = new ArrayList<AccountSubject>();
						listAccountSubject=accountSubjectService.likeAccountSubject(accId1);
							for(int p=0;p<listAccountSubject.size();p++){
								if(listAccountSubject.get(p).getSubjectCode().indexOf("-")<4){
									accountSubjectList.add(listAccountSubject.get(p));
								}else{
									if(listAccountSubject.get(p).getSubjectCode().equals(accId3)){
										accountSubjectList.add(listAccountSubject.get(p));
									}
								}
								
							}
					}
				}
				
			}
			Collections.sort(accountSubjectList, new ComparatorImpl());
		}
		
		model.addAttribute("businessFlowList", businessFlowList);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		model.addAttribute("year",year);
		model.addAttribute("deptId", deptId);
		model.addAttribute("flag", flag);
		model.addAttribute("deptName", dept.getDeptName());
		if(childAccDept==null){
			childAccDept="null";
		}
		model.addAttribute("childAccDept", childAccDept);
		return BaseTemplateURL+"/businessFlowOfGlobal";
	}
	
	//导出(excle)全部科目报表信息
	@RequestMapping(value="/exportBusinessFlowOfGlobal",method = RequestMethod.POST)
	public ModelAndView exportBusinessFlowOfGlobal(String deptId,String accountDateStr,String childAccDept,String subjectType, Model model){
		if(childAccDept.equals("null")){
			childAccDept=null;
		}
		Dept dept = deptService.findById(deptId);
		Admin admin = null;
		if(dept==null){
			admin = adminService.getCurrent();
			dept = deptService.findById(admin.getDeptId());
		}
		BusinessFlow businessFlow = new BusinessFlow();
		businessFlow.setAccountDateStr(Integer.valueOf(accountDateStr));
		businessFlow.setDeptId(dept.getDeptId());
		businessFlow.setChildAccDept(childAccDept);
		if(businessFlow.getDeptId()==null || businessFlow.getDeptId()==""){
			businessFlow.setDeptId(admin.getDeptId());
		}
		businessFlow.setIsDel(0);
		if(businessFlow.getAccountDateStr() == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			businessFlow.setAccountDateStr(Integer.valueOf(sdf.format(new Date())));
		}
		List<BusinessFlow> businessFlowList = new ArrayList<BusinessFlow>();
		List<AccountSubject> accountSubjectList = new ArrayList<AccountSubject>();
		businessFlowList = businessFlowService.searchBusinessFlowOfDept(businessFlow);
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(businessFlow.getDeptId());
		accountSubject.setChildAccDept(childAccDept);
		accountSubjectList = accountSubjectService.queryDeptBusinessSubject(accountSubject);
		//如果是分小组
				if(childAccDept!=null&&childAccDept!=""&&accountSubjectList.size()!=0){
					//用于存储group by之后的一级code
					int size=accountSubjectList.size();
					for(int q=0;q<size;q++){
						if(q==size){
							break;
						}else{
							String code=accountSubjectList.get(q).getSubjectCode();
							String accId1=code.substring(0, 4);
							String accId2=accountSubjectList.get(q+1).getSubjectCode().substring(0, 4);
							//是二级或三级目录
							String accId3=null;//获取模糊的二级code
							if(accountSubjectList.get(q).getSubjectCode().indexOf("-")==4){
								accId3=code.substring(0, 7);
							}
							
							if(!accId1.equals(accId2)){
								List<AccountSubject> listAccountSubject = new ArrayList<AccountSubject>();
								listAccountSubject=accountSubjectService.likeAccountSubject(accId1);
									for(int p=0;p<listAccountSubject.size();p++){
										if(listAccountSubject.get(p).getSubjectCode().indexOf("-")<4){
											accountSubjectList.add(listAccountSubject.get(p));
										}else{
											if(listAccountSubject.get(p).getSubjectCode().equals(accId3)){
												accountSubjectList.add(listAccountSubject.get(p));
											}
										}
										
									}
							}
						}
						
					}
					Collections.sort(accountSubjectList, new ComparatorImpl());
				}
		BusinessFlowOfGlobalExcle excle = new BusinessFlowOfGlobalExcle();
		for(AccountSubject as:accountSubjectList){
			List<BusinessFlow> bfList = new ArrayList<BusinessFlow>();
			BigDecimal totalYearly = new BigDecimal(0);
			for(BusinessFlow bf:businessFlowList){
				if(bf.getAccountSubjectId().equals(as.getAccountSubjectId())&& bf.getAccountsSum()!=null){
					bf.setAccountsSum(bf.getAccountsSum().setScale(2,BigDecimal.ROUND_HALF_UP));
					totalYearly = totalYearly.add(bf.getAccountsSum());
					bfList.add(businessFlow);
				}
				
			}
			as.setTotalYearly(totalYearly);
			as.setBusinessFlowList(bfList);
		}
		
		List<AccountSubject> accountSubjectListTemp = new ArrayList<AccountSubject>();
		for(AccountSubject as:accountSubjectList){
			if(as.getHasChild()==0&&as.getBusinessFlowList().size()==0){
				accountSubjectListTemp.add(as);
			}
		}
		accountSubjectList.removeAll(accountSubjectListTemp);
		accountSubject.setAccountDateStr(accountDateStr);
		accountSubject.setSubjectType(1);
		List<BusinessFlow> totalMonthForIncome = accountSubjectService.queryTotalMonth(accountSubject);
		BigDecimal totalYearForIncome = new BigDecimal(0.00);
		BigDecimal totalYearForCost = new BigDecimal(0.00);
		BigDecimal totalYearForSalesIncome = new BigDecimal(0.00);
		BigDecimal totalYearForTourCost = new BigDecimal(0.00);
		if(accountSubjectService.queryTotalYear(accountSubject)!=null){
			totalYearForIncome = accountSubjectService.queryTotalYear(accountSubject).getAccountsSum();
		}
		accountSubject.setSubjectType(2);
		
		List<BusinessFlow> totalMonthForCost = accountSubjectService.queryTotalMonth(accountSubject);
		
		if(accountSubjectService.queryTotalYear(accountSubject)!=null){
			totalYearForCost = accountSubjectService.queryTotalYear(accountSubject).getAccountsSum();
		}
		
		accountSubject.setSubjectType(3);
		
		List<BusinessFlow> totalMonthForSalesIncome = accountSubjectService.queryTotalMonth(accountSubject);
		
		if(accountSubjectService.queryTotalYear(accountSubject)!=null){
			totalYearForSalesIncome = accountSubjectService.queryTotalYear(accountSubject).getAccountsSum();
		}
		accountSubject.setSubjectType(4);
		
		List<BusinessFlow> totalMonthForTourCost = accountSubjectService.queryTotalMonth(accountSubject);
		
		if(accountSubjectService.queryTotalYear(accountSubject)!=null){
			totalYearForTourCost = accountSubjectService.queryTotalYear(accountSubject).getAccountsSum();
		}
		//获取income的行数
		int rowsForIncome = 0;
		List<AccountSubject> accountSubjectListForIncome = new ArrayList<AccountSubject>();
		List<AccountSubject> accountSubjectListForCost = new ArrayList<AccountSubject>();
		List<AccountSubject> accountSubjectListForSalesIncome = new ArrayList<AccountSubject>();
		List<AccountSubject> accountSubjectListForTourCost = new ArrayList<AccountSubject>();
		//List<AccountSubject> accountSubjectListForProfit = new ArrayList<AccountSubject>();
		for(AccountSubject as:accountSubjectList){
			if(as.getSubjectType()==1){
				if(as.getTotalYearly()!=null&&totalYearForIncome!=null&&totalYearForIncome.intValue()!=0){
					String yearPercent = as.getTotalYearly().multiply(new BigDecimal(100)).divide(totalYearForIncome,4).toString()+"%";
					as.setPercentYearly(yearPercent);
				}
				accountSubjectListForIncome.add(as);
			}else if(as.getSubjectType()==2){
				if(as.getTotalYearly()!=null&&totalYearForCost!=null&&totalYearForCost.intValue()!=0){
					String yearPercent = as.getTotalYearly().multiply(new BigDecimal(100)).divide(totalYearForCost,4).toString()+"%";
					as.setPercentYearly(yearPercent);
				}
				accountSubjectListForCost.add(as);
			}else if(as.getSubjectType()==3){
				if(as.getTotalYearly()!=null&&totalYearForSalesIncome!=null&&totalYearForSalesIncome.intValue()!=0){
					String yearPercent = as.getTotalYearly().multiply(new BigDecimal(100)).divide(totalYearForSalesIncome,4).toString()+"%";
					as.setPercentYearly(yearPercent);
				}
				accountSubjectListForSalesIncome.add(as);
			}else if(as.getSubjectType()==4){
				if(as.getTotalYearly()!=null&&totalYearForTourCost!=null&&totalYearForTourCost.intValue()!=0){
					String yearPercent = as.getTotalYearly().multiply(new BigDecimal(100)).divide(totalYearForTourCost,4).toString()+"%";
					as.setPercentYearly(yearPercent);
				}
				accountSubjectListForTourCost.add(as);
			}
		}
		List<BusinessFlow> totalMonthlyForProfit = new ArrayList<BusinessFlow>();
		BusinessFlow bf = null;
		for(int i=0;i<12;i++){
			  	bf = new BusinessFlow();
				//BusinessFlow businessFlowForIncomme =  totalMonthForIncome.get(i)==null?new BusinessFlow():totalMonthForIncome.get(i);
				//BusinessFlow businessFlowForCost =  totalMonthForCost.get(i)==null?new BusinessFlow():totalMonthForCost.get(i);
				bf.setAccountsSum((totalMonthForIncome.size()<=i?new BigDecimal(0.00):totalMonthForIncome.get(i).getAccountsSum()).subtract(totalMonthForCost.size()<=i?new BigDecimal(0.00):totalMonthForCost.get(i).getAccountsSum()));
				totalMonthlyForProfit.add(bf);
		}
		excle.setBusinessFlows(businessFlowList);
		excle.setAccountSubjects(accountSubjectList);
		excle.setRowsForIncome(rowsForIncome);
		excle.setTotalMonthlyForIncome(totalMonthForIncome);
		excle.setTotalMonthlyForCost(totalMonthForCost);
		excle.setTotalMonthlyForSalesIncome(totalMonthForSalesIncome);
		excle.setTotalMonthlyForTourCost(totalMonthForTourCost);
		excle.setAccountSubjectListForIncome(accountSubjectListForIncome);
		excle.setAccountSubjectListForCost(accountSubjectListForCost);
		excle.setAccountSubjectListForSalesIncome(accountSubjectListForSalesIncome);
		excle.setAccountSubjectListForTourCost(accountSubjectListForTourCost);
		excle.setTotalYearForIncome(totalYearForIncome);
		excle.setTotalYearForCost(totalYearForCost);
		excle.setTotalYearForSalesIncome(totalYearForSalesIncome);
		excle.setTotalYearForTourCost(totalYearForTourCost);
		excle.setTotalMonthlyForProfit(totalMonthlyForProfit);
		return new ModelAndView(excle); 
	}
	
	//查看全部科目报表信息
	@RequestMapping(value="/searchbusinessFlowOfGlobal",method = RequestMethod.POST)
	public String searchbusinessFlowOfGlobal(BusinessFlow businessFlow,AccountSubject accountSubject,Model model){
		String deptId = businessFlow.getDeptId();
		Dept dept = deptService.findById(deptId);
		if(deptId==null||deptId==""){
			Admin admin = adminService.getCurrent();
			dept = deptService.findById(admin.getDeptId());
		}
		if(businessFlow.getAccountDateStr() == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			businessFlow.setAccountDateStr(Integer.valueOf(sdf.format(new Date())));
		}
		
		List<BusinessFlow> businessFlowList = new ArrayList<BusinessFlow>();
		List<AccountSubject> accountSubjectList = new ArrayList<AccountSubject>();
		businessFlowList = businessFlowService.searchBusinessFlowOfDept(businessFlow);
		accountSubjectList = accountSubjectService.queryDeptBusinessSubject(accountSubject);
		String flag = "";
		if(accountSubject.getSubjectType()!=null&&accountSubject.getSubjectType()!=0){
			flag=accountSubject.getSubjectType().toString();
		}
		model.addAttribute("businessFlowList", businessFlowList);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		model.addAttribute("year",(businessFlow.getAccountDateStr()));
		model.addAttribute("deptId", deptId);
		model.addAttribute("flag", flag);
		model.addAttribute("deptName", dept.getDeptName());
		return BaseTemplateURL+"/businessFlowOfGlobal";
	}
	
	//
	@RequestMapping(value="/businessFlowNoDept",method = RequestMethod.GET)
	public String businessFlowNoDept(Model model){
		Admin admin = adminService.getCurrent();
		BusinessFlow businessFlow = new BusinessFlow();
		businessFlow.setDeptId(admin.getDeptId());
		if(businessFlow.getDeptId()==null || businessFlow.getDeptId()==""){
			businessFlow.setDeptId(admin.getDeptId());
		}
		businessFlow.setIsDel(0);
		String year = "";
		String flag = "";
		if(businessFlow.getAccountDateStr() == null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			year = sdf.format(new Date());
			businessFlow.setAccountDateStr(Integer.valueOf(year));
		}
		List<BusinessFlow> businessFlowList = new ArrayList<BusinessFlow>();
		List<AccountSubject> accountSubjectList = new ArrayList<AccountSubject>();
		businessFlowList = businessFlowService.searchBusinessFlowOfDept(businessFlow);
		AccountSubject accountSubject = new AccountSubject();
		accountSubject.setDeptId(businessFlow.getDeptId());
		accountSubjectList = accountSubjectService.queryDeptBusinessSubject(accountSubject);
		model.addAttribute("businessFlowList", businessFlowList);
		model.addAttribute("accountSubjectList", accountSubjectList);
		model.addAttribute("menuId", "1003");
		model.addAttribute("year",year);
		model.addAttribute("deptId", admin.getDeptId());
		model.addAttribute("flag", flag);
		model.addAttribute("deptName", deptService.findById(admin.getDeptId()).getDeptName());
		return BaseTemplateURL+"/businessFlowOfGlobal";
	}
	
	
	//查看全部科目报表信息
		@RequestMapping(value="/businessFlowOfChild",method = RequestMethod.GET)
		public String businessFlowOfChild(String deptId,String year,String childAccDept,String subjectType, Model model){
			Dept dept = deptService.findById(deptId);
			Admin admin = adminService.getCurrent();
			BusinessFlow businessFlow = new BusinessFlow();
			businessFlow.setAccountDateStr(Integer.valueOf(year));
			if(businessFlow.getDeptId()==null || businessFlow.getDeptId()==""){
				businessFlow.setDeptId(admin.getDeptId());
			}
			businessFlow.setIsDel(0);
			if(businessFlow.getAccountDateStr() == null){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
				businessFlow.setAccountDateStr(Integer.valueOf(sdf.format(new Date())));
			}
			List<BusinessFlow> businessFlowList = new ArrayList<BusinessFlow>();
			List<AccountSubject> accountSubjectList = new ArrayList<AccountSubject>();
			businessFlowList = businessFlowService.searchBusinessFlowOfDept(businessFlow);
			AccountSubject accountSubject = new AccountSubject();
			accountSubject.setDeptId(businessFlow.getDeptId());
			accountSubject.setChildAccDept(childAccDept);
			//判断显示income/cost
			String flag = "";
			if(subjectType!=null&&subjectType!=""){
				accountSubject.setSubjectType(Integer.valueOf(subjectType));
				flag=subjectType.toString();
			}
			accountSubjectList = accountSubjectService.queryDeptBusinessSubject(accountSubject);
			model.addAttribute("businessFlowList", businessFlowList);
			model.addAttribute("accountSubjectList", accountSubjectList);
			model.addAttribute("menuId", "1003");
			model.addAttribute("year",year);
			model.addAttribute("deptId", deptId);
			model.addAttribute("flag", flag);
			model.addAttribute("deptName", dept.getDeptName());
			return BaseTemplateURL+"/businessFlowOfChild";
		}
	
	//报表分析
	@RequestMapping(value="/exportAnalysisBusinessFlow",method = RequestMethod.POST)
	public ModelAndView exportAnalysisBusinessFlow(BusinessFlow businessFlow){
		StatisticalProfit statisticalProfit = new StatisticalProfit();
		statisticalProfit.setDeptId(businessFlow.getDeptId());
		SimpleDateFormat dft = new SimpleDateFormat("yyyy");
		if(businessFlow.getAccountDateStr()!=null){
			statisticalProfit.setTime(businessFlow.getAccountDateStr().toString());
		}
		String time = dft.format(new Date());
		if(statisticalProfit.getTime()==null||statisticalProfit.getTime()==""){
			statisticalProfit.setTime(time);
		}
		List<StatisticalProfit> listStatisticalProfit = new ArrayList<StatisticalProfit>();
		listStatisticalProfit = businessFlowService.sumPayCostOfMonthByHO(statisticalProfit);
		ReportForGroupExcle excle = new ReportForGroupExcle();
		excle.setListStatisticalProfit(listStatisticalProfit);
		return new ModelAndView(excle);
	}
	
	//报表分析
		@RequestMapping(value="/analysisBusinessFlow",method = RequestMethod.POST)
		public String analysisBusinessFlow(BusinessFlow businessFlow,Model model){
			StatisticalProfit statisticalProfit = new StatisticalProfit();
			statisticalProfit.setDeptId(businessFlow.getDeptId());
			SimpleDateFormat dft = new SimpleDateFormat("yyyy");
			if(businessFlow.getAccountDateStr()!=null){
				statisticalProfit.setTime(businessFlow.getAccountDateStr().toString());
			}
			String time = dft.format(new Date());
			if(statisticalProfit.getTime()==null||statisticalProfit.getTime()==""){
				statisticalProfit.setTime(time);
			}
			List<StatisticalProfit> listStatisticalProfit = new ArrayList<StatisticalProfit>();
			listStatisticalProfit = businessFlowService.sumPayCostOfMonthByHO(statisticalProfit);
			model.addAttribute("listStatisticalProfit", listStatisticalProfit);
			model.addAttribute("deptId", businessFlow.getDeptId());
			model.addAttribute("year",statisticalProfit.getTime());
			return BaseTemplateURL+"/analysisBusinessFlow";
		}
	
	//CEO查看报表
	@RequestMapping(value="/searchAccountInfoForCEO",method = RequestMethod.GET)
	public String searchAccountInfoForCEO(Model model){
		List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
		Date date = new Date();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd");
		String year = simpleDateFormat.format(date).substring(0,4);
		List<Dept> deptList = deptService.findAll();
		for(Dept dept:deptList){
			StatisticalProfit statisticalProfit = new StatisticalProfit();
			statisticalProfit.setDeptId(dept.getDeptId());
			statisticalProfit.setTime(year);
			statisticalProfitList.add(statisticalProfit);
		}
		statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
		model.addAttribute("statisticalProfitList", statisticalProfitList);
		model.addAttribute("menuId", "1005");
		return BaseTemplateURL+"/searchAccountInfoForCEO";
	}
	
	//年份改变时异步（ceo）
	@RequestMapping(value="/searchAccountInfoForCEOAjax",method = RequestMethod.GET)
	public @ResponseBody Map<String,List<StatisticalProfit>> searchAccountInfoForCEOAjax(String year){
		Map<String,List<StatisticalProfit>> map = new HashMap<String,List<StatisticalProfit>>();
		List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
		List<Dept> deptList = deptService.findAll();
		for(Dept dept:deptList){
			StatisticalProfit statisticalProfit = new StatisticalProfit();
			statisticalProfit.setDeptId(dept.getDeptId());
			statisticalProfit.setTime(year);
			statisticalProfitList.add(statisticalProfit);
		}
		statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
		map.put("statisticalProfitList", statisticalProfitList);
		return map;
	}
	
	// 打印功能
	@RequestMapping(value="/printSubject",method = RequestMethod.GET)
	public String printSubject(String year,String flag,Model model){
		Admin admin = adminService.getCurrent();
		List<StatisticalProfit> statisticalProfitList = new ArrayList<StatisticalProfit>();
		List<String> deptIdList = new ArrayList<String>();
		if(flag.equals("1")){
			List<Dept> deptList = deptService.findAll();
			for(Dept dept:deptList){
				deptIdList.add(dept.getDeptId());
			}
		}else if(flag.equals("2")){
			List<RegionDeptRel> regionList = deptService.findRegionByDeptId(admin.getDeptId());
			String regionId = regionList.get(0).getRegionId();
			List<RegionDeptRel> regionDeptList = deptService.findByRegionId(regionId);
			for(RegionDeptRel regionDeptRel:regionDeptList){
				deptIdList.add(regionDeptRel.getDeptId());
			}
		}else if(flag.equals("3")){
			deptIdList.add(admin.getDeptId());
		}
		for(String deptId:deptIdList){
			StatisticalProfit statisticalProfit = new StatisticalProfit();
			statisticalProfit.setDeptId(deptId);
			statisticalProfit.setTime(year);
			statisticalProfitList.add(statisticalProfit);
		}
		statisticalProfitList = businessFlowService.sumPayCostOfMonth(statisticalProfitList);
		model.addAttribute("statisticalProfitList", statisticalProfitList);
		return BaseTemplateURL+"/printSubject";
	}
	
	public class ComparatorImpl implements Comparator<AccountSubject> {
		@Override
		public int compare(AccountSubject a1, AccountSubject a2) {
			return a1.getSubjectCode().compareTo(a2.getSubjectCode());
		}
	}
}
