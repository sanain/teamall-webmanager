package com.jq.support.main.controller.merchandise.agent;

import com.google.common.collect.Lists;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.agent.PmAgent;
import com.jq.support.model.agent.PmAgentShop;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.PmBusinessStatistics;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysRole;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.agent.PmAgentService;
import com.jq.support.service.agent.PmAgentShopService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.shop.*;
import com.jq.support.service.statement.PmShopUserSourceStatisticsService;
import com.jq.support.service.statement.PmShopUserStatisticsService;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 御可贡茶代理商
 */
@RequestMapping(value = "${adminPath}/pmAgent")
@Controller
public class PmAgentController extends BaseController {
    @Autowired
    private PmAgentService pmAgentService;
    @Autowired
    private SystemService systemService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmAgentShopService pmAgentShopService;
    @Autowired
    private PmShopUserSourceStatisticsService pmShopUserSourceStatisticsService;
    @Autowired
    private PmShopUserStatisticsService pmShopUserStatisticsService;
    @Autowired
    private PmShopUserService pmShopUserService;
    @Autowired
    private PmBusinessStatisticsService pmBusinessStatisticsService;
    @Autowired
    private EbOrderService ebOrderService;
    @Autowired
    private PmBusinessDailyService pmBusinessDailyService;
    @Autowired
    private PmBusinessDailyItemService pmBusinessDailyItemService;
    @Autowired
    private PmBusinessDailyItemPayService pmBusinessDailyItemPayService;
    @Autowired
    private PmBusinessDailyRankingService pmBusinessDailyRankingService;
    @Autowired
    private PmProductTasteRankingService pmProductTasteRankingService;
    @Autowired
    private PmProductTasteService pmProductTasteService;
    @Autowired
    private PmBusinessIndicatorsService pmBusinessIndicatorsService;


    /**
     * 查询列表
     * @param response
     * @param request
     * @param model
     * @param pmAgent
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:view")
    @RequestMapping(value = {"","list"})
    public String list(HttpServletResponse response , HttpServletRequest request , Model model,
                       PmAgent pmAgent){

        model.addAttribute("pmAgent",pmAgent);

        Page<PmAgent> page = pmAgentService.getList(pmAgent, new Page<PmAgent>(request, response));

        model.addAttribute("page",page);

        return "modules/shopping/agent/pmAgentList";
    }

    /**
     * 增加代理商
     * @param request
     * @param response
     * @param model
     * @param password
     * @param pmAgent
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:edit")
    @RequestMapping(value = "insert")
    public String insertAgent(HttpServletRequest request , HttpServletResponse response ,
                              Model model , String password , PmAgent pmAgent, RedirectAttributes redirectAttributes){

        if (systemService.getUserByLoginName(pmAgent.getAgentCode()) != null) {
            addMessage(redirectAttributes, "已经存在这个账号");
            redirectAttributes.addAttribute("flag","add");
            return "redirect:" + Global.getAdminPath() + "/pmAgent/form";
        }

        //检查选中的门店是否已经被代理
        if(isAlreadyAgent(pmAgent.getShopIds(), pmAgent.getShopIds(),redirectAttributes)) {
            redirectAttributes.addAttribute("flag","add");
            return "redirect:" + Global.getAdminPath() + "/pmAgent/form";
        }

        //增加代理商的信息
        pmAgent.setCreateTime(new Date());
        pmAgent.setDelFlag(0);
        pmAgentService.insert(pmAgent);

        //插入关联信息
        if(StringUtil.isNotBlank(pmAgent.getShopIds())){
            String shopIds = pmAgent.getShopIds();
            String shopNames = pmAgent.getShopNames();

            String[] idArr = shopIds.split(",");
            String[] nameArr = shopNames.split(",");

            for (int i = 0 ; i < nameArr.length ; i++) {
                PmAgentShop pmAgentShop = new PmAgentShop();
                pmAgentShop.setAgentId(pmAgent.getId());
                pmAgentShop.setAgentName(pmAgent.getAgentName());
                pmAgentShop.setShopId(Integer.valueOf(idArr[i]));
                pmAgentShop.setShopName(nameArr[i]);
                pmAgentShop.setDelFlag(0);
                pmAgentShop.setCreateTime(new Date());

                pmAgentShopService.insert(pmAgentShop);
            }
        }

        //增加系统用户
        SysUser sysUser = new SysUser();

        sysUser.setId("");
        sysUser.setCompany(new SysOffice("1")); //公司和部门设置成总公司
        sysUser.setOffice(new SysOffice("1"));
        sysUser.setPassword(SystemService.entryptPassword(password));
        sysUser.setLoginName(pmAgent.getAgentCode());
        sysUser.setName(pmAgent.getAgentName());
        sysUser.setNo(pmAgent.getAgentCode());
        sysUser.setDelFlag("0");

        // 角色数据有效性验证，过滤不在授权内的角色
        List<SysRole> roleList = Lists.newArrayList();
        List<SysRole> allRole = systemService.findAllRole();
        //获得代理商角色
        SysRole agentRole = systemService.getRole("6631ce6c10c14c359e7de058c0b084c3");
        for (SysRole r : allRole) {
            if (r.getId().equals(agentRole.getId())) {
                roleList.add(r);
            }
        }

        sysUser.setTeaAgentId(pmAgent.getId());
        sysUser.setRoleList(roleList);
        // 保存用户信息
        systemService.saveUser(sysUser);

        addMessage(redirectAttributes, "新增代理商" + pmAgent.getAgentName() + "成功");
        return "redirect:" + Global.getAdminPath() + "/pmAgent/list";
    }


    /**
     * 修改代理商
     * @param request
     * @param response
     * @param redirectAttributes
     * @param password
     * @param pmAgent
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:edit")
    @RequestMapping(value = "update")
    public String updateAgent(HttpServletRequest request , HttpServletResponse response ,
                              RedirectAttributes redirectAttributes , String password , PmAgent pmAgent){

        if(pmAgent == null || pmAgent.getId() == null){
            addMessage(redirectAttributes, "修改代理商" + pmAgent.getAgentName() + "失败");
            redirectAttributes.addAttribute("flag","update");
            redirectAttributes.addAttribute("agentId",pmAgent.getId());
            return "redirect:" + Global.getAdminPath() + "/pmAgent/form";
        }


        //更新门店和代理商关联表
        PmAgent oldAgent = pmAgentService.getById(pmAgent.getId());
        //直接使用Arrays.asList生成的列表，调用add或者remove方法会报UnsupportedOperationException错
        List<String> newIdList = new ArrayList(Arrays.asList(pmAgent.getShopIds() == null ? new String[0] : pmAgent.getShopIds().split(",")));
        List<String> newNameList = new ArrayList(Arrays.asList(pmAgent.getShopNames() == null ? new String[0] : pmAgent.getShopNames().split(",")));
        List<String> oldIdList = new ArrayList<String>(Arrays.asList(oldAgent.getShopIds() == null ? new String[0] : oldAgent.getShopIds().split(",")));


        //筛选不需要操作的部分
        for (int i = 0 ; i <oldIdList.size() ; ){
            int index = newIdList.indexOf(oldIdList.get(i));
            if(index >= 0 ){
                newIdList.remove(index);
                newNameList.remove(index);
                oldIdList.remove(i);
            }else{
                i++;
            }
        }

        String newIds = newIdList.toString().replace("[","").replace("]","");
        String newNames = newNameList.toString().replace("[","").replace("]","");
        //检查选中的门店是否已经被代理
        if(isAlreadyAgent(newIds, newNames,redirectAttributes)) {
            redirectAttributes.addAttribute("flag","update");
            redirectAttributes.addAttribute("agentId", pmAgent.getId());
            return "redirect:" + Global.getAdminPath() + "/pmAgent/form";
        }


        //插入新增加的部分
        for(int  i = 0 ; i < newIdList.size() ; i++){
            PmAgentShop pmAgentShop = new PmAgentShop();
            pmAgentShop.setShopName(newNameList.get(i));
            pmAgentShop.setShopId(Integer.valueOf(newIdList.get(i)));
            pmAgentShop.setAgentName(pmAgent.getAgentName());
            pmAgentShop.setAgentId(pmAgent.getId());
            pmAgentShop.setCreateTime(new Date());
            pmAgentShop.setDelFlag(0);

            pmAgentShopService.insert(pmAgentShop);
        }
        //删除多出来的部分
        String oldIds = oldIdList.toString().replace("[", "").replace("]", "");
        pmAgentShopService.deleteByShopIds(pmAgent.getId(),oldIds);


        //修改代理商的信息
        boolean result = pmAgentService.update(pmAgent);
        if(!result){
            addMessage(redirectAttributes, "修改代理商" + pmAgent.getAgentName() + "失败");
            redirectAttributes.addAttribute("flag","update");
            redirectAttributes.addAttribute("agentId",pmAgent.getId());
            return "redirect:" + Global.getAdminPath() + "/pmAgent/form";
        }


        //修改系统用户
        SysUser sysUser = systemService.getUserByLoginName(pmAgent.getAgentCode());

        if(StringUtil.isNotBlank(password)){
            sysUser.setPassword(SystemService.entryptPassword(password));
        }
        sysUser.setName(pmAgent.getAgentName());
        // 保存用户信息
        systemService.saveUser(sysUser);


        addMessage(redirectAttributes, "修改代理商" + pmAgent.getAgentName() + "成功");
        redirectAttributes.addAttribute("flag","update");
        redirectAttributes.addAttribute("agentId",pmAgent.getId());
        return "redirect:" + Global.getAdminPath() + "/pmAgent/form";
    }


    /**
     * 导航到增加或者修改代理商信息页面
     * @param model
     * @param agentId
     * @param flag
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:view")
    @RequestMapping(value = "form")
    public String form(HttpServletRequest request , HttpServletResponse response,Model model ,
                       Integer agentId,String flag){
        if("add".equals(flag)){
            model.addAttribute("flag","add");
            return "modules/shopping/agent/pmAgentForm";
        }

        PmAgent pmAgent = pmAgentService.getById(agentId);

        model.addAttribute("pmAgent",pmAgent);

        return "modules/shopping/agent/pmAgentForm";
    }



    /**
     * 选择门店
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/chooseShops")
    public String chooseShops(String chooseIds ,Integer agentId , PmShopInfo pmShopInfo, HttpServletRequest request,
                              HttpServletResponse response, Model model,String openingTime , String closingTime) {

        Page<PmShopInfo> page = pmShopInfoService.getNoAgentShopPage(new Page<PmShopInfo>(request, response), agentId,pmShopInfo,
                openingTime, closingTime);


        if(StringUtil.isNotBlank(chooseIds)){
            List<String> shopNameList = new ArrayList<String>();
            String[] strings = chooseIds.split(",");
            for(int i = 0 ; i < strings.length ; i++){
                PmShopInfo info = pmShopInfoService.getpmPmShopInfo(strings[i]);
                if(info == null){
                    continue;
                }
                shopNameList.add(info.getShopName());
            }
            String shopNames = shopNameList.toString().replace("[","").replace("]","");
            model.addAttribute("shopNames",shopNames);
        }

        model.addAttribute("page", page);
        model.addAttribute("pmShopInfo", pmShopInfo);
        model.addAttribute("chooseIds", chooseIds);
        model.addAttribute("agentId", agentId);

        return "modules/shopping/agent/chooseShopList";

    }



    /**
     * 删除
     * @param agentId
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:edit")
    @RequestMapping(value = "delete")
    public String delete(Integer agentId,RedirectAttributes redirectAttributes){

        if(agentId == null){
            addMessage(redirectAttributes,"id不能为空");
            return "redirect:" + Global.getAdminPath() + "/pmAgent/list";
        }

        PmAgent pmAgent = pmAgentService.getById(agentId);
        if(pmAgent == null){
            addMessage(redirectAttributes,"代理商不存在！");
            return "redirect:" + Global.getAdminPath() + "/pmAgent/list";
        }
        SysUser sysUser = systemService.getByTeaAgentId(pmAgent.getId());
        if(sysUser == null){
            addMessage(redirectAttributes,"代理商不存在！");
            return "redirect:" + Global.getAdminPath() + "/pmAgent/list";
        }

        systemService.deleteUser(sysUser.getId());
        pmAgentService.deleteById(pmAgent.getId());
        pmAgentShopService.deleteByAgent(pmAgent.getId());

        addMessage(redirectAttributes,"删除成功！");
        return "redirect:" + Global.getAdminPath() + "/pmAgent/list";
    }


    /**
     * 查询指定的代理商管理的门店
     * @param request
     * @param response
     * @param model
     * @param pmShopInfo
     * @param openingTime
     * @param closingTime
     * @param agentIds
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:view")
    @RequestMapping(value = "shopList")
    public String shopList(HttpServletRequest request , HttpServletResponse response , Model model
            , PmShopInfo pmShopInfo, String openingTime , String closingTime,
                           String agentIds,Integer isAllAgent){

        SysUser sysuser = SysUserUtils.getUser();

        model.addAttribute("isAgent",sysuser.getTeaAgentId() == null ? false:true);
        if(sysuser.getTeaAgentId() != null){    //说明当前登录的是一个代理商，所以只能查自己的门店
            agentIds = sysuser.getTeaAgentId()+"";
        }

        List<Object> list = pmAgentShopService.getShopListByAgent(agentIds, new Page<Object>(request, response),
                openingTime, closingTime, pmShopInfo);

        if (list != null && list.size() == 3){
            model.addAttribute("page",list.get(0));
            model.addAttribute("pmShopList",list.get(1));
            model.addAttribute("pmAgentShopList",list.get(2));
        }

        model.addAttribute("pmShopInfo",pmShopInfo);
        model.addAttribute("openingTime",openingTime);
        model.addAttribute("closingTime",closingTime);

        return "modules/shopping/agent/pmAgentShopList";
    }


    /**
     * 选择代理商
     * @param agentIds
     * @param response
     * @param request
     * @param pmAgent
     * @param model
     * @return
     */
    @RequestMapping("chooseAgent")
    public String chooseAgent(String agentIds , HttpServletResponse response , HttpServletRequest request,
                              PmAgent pmAgent,Model model){
        model.addAttribute("agentIds",agentIds);
        model.addAttribute("pmAgent",pmAgent);

        Page<PmAgent> page = pmAgentService.getList(pmAgent, new Page<PmAgent>(request, response));

        model.addAttribute("page",page);

        return "modules/shopping/agent/chooseAgent";
    }


    /**
     * 检查门店是否已经被代理
     * @param ids 门店id
     * @param names 门店名字
     * @param redirectAttributes
     * @return
     */
    public boolean isAlreadyAgent(String ids , String names  ,RedirectAttributes redirectAttributes){

        //检查选中的门店是否已经被代理
        if(StringUtil.isNotBlank(ids)) {
            String [] shopIdArr = ids.split(",");
            for (int i = 0 ; i < shopIdArr.length ; i++ ) {
                boolean alreadyAgent = pmAgentShopService.isAlreadyAgent(Integer.valueOf(shopIdArr[i].trim()));
                if(alreadyAgent){
                    addMessage(redirectAttributes,names.split(",")[i] + "门店已经被代理，操作失败");
                    return true;
                }
            }
        }

        return false;
    }



    /**
     * 分页条件查询营业汇总列表
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @RequiresPermissions("merchandise:pmAgent:view")
    @RequestMapping(value = "statisticsList")
    public String statisticsList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                 String timeRange , @RequestParam(defaultValue = "1")Integer quickTime,
                                 Integer type,@RequestParam(defaultValue = "0") Integer isAll,Integer shopId){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmBusinessStatistics> page = null;
        if(type == 1){
//            page = pmBusinessStatisticsService.getRangeListByDayAgent(new Page<PmBusinessStatistics>(request, response),  quickTime, startTime, endTime , isAll , agentId);
        }else{
//            page = pmBusinessStatisticsService.getRangeListByMonthAgent(new Page<PmBusinessStatistics>(request, response),  quickTime, startTime, endTime , isAll , agentId);
        }


        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shop/statement/statisticsList";
    }

}
