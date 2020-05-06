package com.jq.support.main.controller.merchandise.statement;

import com.jq.support.common.persistence.Page;
import com.jq.support.model.agent.PmAgent;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.*;
import com.jq.support.model.statement.PmBusinessIndicatorsAgent;
import com.jq.support.model.statement.PmBusinessStatisticsAgent;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.agent.PmAgentService;
import com.jq.support.service.agent.PmAgentShopService;
import com.jq.support.service.merchandise.shop.*;
import com.jq.support.service.statement.AgentTodayStatementService;
import com.jq.support.service.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 代理商报表的controller
 */
@Controller
@RequestMapping(value = "${adminPath}/agentStatement")
public class AgentStatementController {
    @Autowired
    private PmBusinessStatisticsAgentService pmBusinessStatisticsAgentService;
    @Autowired
    private PmBusinessIndicatorsAgentService pmBusinessIndicatorsAgentService;
    @Autowired
    private PmProductTasteAgentService pmProductTasteAgentService;
    @Autowired
    private PmProductTasteRankingAgentService pmProductTasteRankingAgentService;
    @Autowired
    private PmAgentService pmAgentService;
    @Autowired
    private PmAgentShopService pmAgentShopService;
    @Autowired
    private PmBusinessDailyItemAgentService pmBusinessDailyItemAgentService;
    @Autowired
    private PmBusinessDailyAgentService pmBusinessDailyAgentService;
    @Autowired
    private PmBusinessDailyRankingAgentService pmBusinessDailyRankingAgentService;
    @Autowired
    private PmBusinessDailyItemPayAgentService pmBusinessDailyItemPayAgentService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private AgentTodayStatementService agentTodayStatementService;

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
    @RequiresPermissions("merchandise:agentStatement:view")
    @RequestMapping(value = "statisticsList")
    public String statisticsList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                 String timeRange ,Integer quickTime,
                                 Integer type,@RequestParam(defaultValue = "1") Integer isAll){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 1;
        }
        SysUser user = SysUserUtils.getUser();

        Page<PmBusinessStatisticsAgent> page = null;
        List<PmBusinessStatisticsAgent> todayDateList = new ArrayList<PmBusinessStatisticsAgent>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = agentTodayStatementService.statistics(isAll,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessStatisticsAgentService.getRangeListByDay(new Page<PmBusinessStatisticsAgent>(request, response), quickTime, startTime, endTime, isAll, user.getTeaAgentId());
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsAgentService.getRangeListByMonth(new Page<PmBusinessStatisticsAgent>(request, response),  quickTime, startTime, endTime , isAll ,  user.getTeaAgentId());
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessStatisticsAgent>(request, response));
        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shopping/statement/agentStatisticsList";
    }


    /**
     * 导入营业汇总excel
     * @param request
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "statisticsExcel")
    public String statisticsList(HttpServletRequest request ,String timeRange ,Integer quickTime,
                                 Integer type,Integer isAll,String[] syllable){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        SysUser user = SysUserUtils.getUser();

        Page<PmBusinessStatisticsAgent> page = null;
        List<PmBusinessStatisticsAgent> todayDateList = new ArrayList<PmBusinessStatisticsAgent>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = agentTodayStatementService.statistics(isAll,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessStatisticsAgentService.getRangeListByDay(new Page<PmBusinessStatisticsAgent>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, isAll, user.getTeaAgentId());
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsAgentService.getRangeListByMonth(new Page<PmBusinessStatisticsAgent>(1, Integer.MAX_VALUE), quickTime, startTime, endTime , isAll ,  user.getTeaAgentId());
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessStatisticsAgent>(1, Integer.MAX_VALUE));

        String title = type ==1 ? "代理商营业汇总日报":"代理商营业汇总月报";

        String url = new ExcelUtil().export(syllable, page.getList(), title, request);

        return url;
    }


    /**
     * 查看营业日报
     * @param specificTime
     * @param model
     * @param isAll 是否为所有门店的汇总  0 不是 1是
     * @param shopId    门店id
     * @return
     */
    @RequiresPermissions("merchandise:agentStatement:view")
    @RequestMapping(value = "businessDaily")
    public String getBusinessDaily(String specificTime , Model model ,Integer agentId,String agentName,
                                   @RequestParam(defaultValue="1") Integer isAll , Integer shopId,String shopName){

        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);
        model.addAttribute("shopName",shopName);
        if(StringUtil.isBlank(specificTime)){
            specificTime =  FormatUtil.getTodayStr();
        }
        model.addAttribute("specificTime",specificTime);

        Integer teaAgentId = SysUserUtils.getUser().getTeaAgentId();
        //当不是代理商登录时，显示一个默认的代理商数据
        if(teaAgentId == null) {
            if(agentId == null) {
                model.addAttribute("isAgent", false);
                List<PmAgent> all = pmAgentService.getAll();
                if (all == null || all.size() == 0) {
                    return "modules/shopping/statement/agentBusinessDaily";
                }
                agentId = all.get(0).getId();
                agentName = all.get(0).getAgentName();
            }
        }else{
            model.addAttribute("isAgent",true);
            PmAgent pmAgent = pmAgentService.getById(teaAgentId);
            if(pmAgent != null){
                agentId = pmAgent.getId();
                agentName = pmAgent.getAgentName();
            }
        }

        PmBusinessDailyAgent pmBusinessDaily = null;
        //来源表
        List<PmBusinessDailyItemAgent> itemList = null;

        List<List<PmBusinessDailyItemPayAgent>> payList = new ArrayList();
        List<List<PmBusinessDailyRankingAgent>> rankingList = new ArrayList();
        List<List<PmBusinessDailyRankingAgent>> weightRankingList = new ArrayList();

        if(!FormatUtil.getTodayStr().equals(specificTime)) {
            //日报总表
            pmBusinessDaily = pmBusinessDailyAgentService.getListBySpecificTime(specificTime, isAll, shopId, agentId);


            if(pmBusinessDaily != null) {
                //来源表
               itemList = pmBusinessDailyItemAgentService.getListByDailyId(pmBusinessDaily.getId());

                if (itemList != null) {
                    for (PmBusinessDailyItemAgent item : itemList) {
                        //实付构成
                        List<PmBusinessDailyItemPayAgent> pays = pmBusinessDailyItemPayAgentService.getListByDailItemId(item.getId());
                        payList.add(pays);

                        //菜品排名
                        List<PmBusinessDailyRankingAgent> rankings1 = pmBusinessDailyRankingAgentService.getListByDailItemId(item.getId(),1);
                        rankingList.add(rankings1);
                        //斩料排名
                        List<PmBusinessDailyRankingAgent> rankings2 = pmBusinessDailyRankingAgentService.getListByDailItemId(item.getId(),2);
                        weightRankingList.add(rankings2);

                    }
                }
            }
        }else{
            pmBusinessDaily = agentTodayStatementService.daily(isAll,shopId,agentId);
            if(CollectionUtils.isNotEmpty(pmBusinessDaily.getItemList())){
                itemList = pmBusinessDaily.getItemList();
                payList = new ArrayList();
                rankingList = new ArrayList();
                for (PmBusinessDailyItemAgent item : itemList){
                    payList.add(item.getPayList());
                    rankingList.add(item.getRankingList());
                    weightRankingList.add(item.getWeightRankingList());
                }
            }
        }
        model.addAttribute("agentName",agentName);
        model.addAttribute("agentId",agentId);
        model.addAttribute("pmBusinessDaily",pmBusinessDaily);
        model.addAttribute("itemList",itemList);
        model.addAttribute("payList",payList);
        model.addAttribute("rankingList",rankingList);
        model.addAttribute("weightRankingList",weightRankingList);

        return "modules/shopping/statement/agentBusinessDaily";
    }

    /**
     * 菜品营业分析
     * @param request
     * @param response
     * @param model
     * @param timeRange      时间范围
     * @param quickTime      快速选择的时间  1  昨天  2 前七天  3 前三十天
     * @param isAll      是否是所有门店的汇总 0 不是 1是
     * @param shopId      门店id
     * @return
     */
    @RequiresPermissions("merchandise:agentStatement:view")
    @RequestMapping("productTasteList")
    public  String productTasteList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                    String timeRange , Integer quickTime,
                                    @RequestParam(defaultValue = "1") Integer isAll ,Integer agentId,String agentName,
                                    Integer shopId,String shopName){

        model.addAttribute("timeRange",timeRange);
        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);
        model.addAttribute("shopName",shopName);


        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }else if (quickTime == null){
            quickTime=1;
        }
        model.addAttribute("quickTime",quickTime);

        Integer teaAgentId = SysUserUtils.getUser().getTeaAgentId();
        //当不是代理商登录时，显示一个默认的代理商数据
        if(teaAgentId == null) {
            if(agentId == null) {
                model.addAttribute("isAgent", false);
                List<PmAgent> all = pmAgentService.getAll();
                if (all == null || all.size() == 0) {
                    return "modules/shopping/statement/agentProductTasteList";
                }
                agentId = all.get(0).getId();
                agentName = all.get(0).getAgentName();
            }
        }else{
            model.addAttribute("isAgent",true);
            PmAgent pmAgent = pmAgentService.getById(teaAgentId);
            if(pmAgent != null){
                agentId = pmAgent.getId();
                agentName = pmAgent.getAgentName();
            }
        }
        model.addAttribute("agentId",agentId);
        model.addAttribute("agentName",agentName);

        List<PmProductTasteAgent> tasteList = pmProductTasteAgentService.getListByTimeRange(quickTime, startTime, endTime , isAll ,agentId, shopId);

        Page<PmProductTasteRankingAgent> rankingPage1 = pmProductTasteRankingAgentService.getListTimeRange(new Page<PmProductTasteRankingAgent>(request, response), 0,
                0, 1, quickTime, startTime, endTime, isAll , shopId,agentId);

        Page<PmProductTasteRankingAgent> rankingPage2 = pmProductTasteRankingAgentService.getListTimeRange(new Page<PmProductTasteRankingAgent>(request, response), 0,
                0, 2, quickTime, startTime, endTime, isAll , shopId,agentId);

        Page<PmProductTasteRankingAgent> rankingPage3 = pmProductTasteRankingAgentService.getListTimeRange(new Page<PmProductTasteRankingAgent>(request, response), 0,
                0, 2, quickTime, startTime, endTime, isAll , shopId,agentId);
        model.addAttribute("tasteList",tasteList);
        model.addAttribute("rankingPage1",rankingPage1);
        model.addAttribute("rankingPage2",rankingPage2);
        model.addAttribute("rankingPage3",rankingPage3);

        return "modules/shopping/statement/agentProductTasteList";
    }

    /**
     * 选择代理商
     * @param agentId
     * @param request
     * @param response
     * @param model
     * @param pmAgent
     * @return
     */
    @RequiresPermissions("merchandise:agentStatement:view")
    @RequestMapping("chooseAgent")
    public String chooseAgent(Integer agentId , HttpServletRequest request , HttpServletResponse response ,
                              Model model, PmAgent pmAgent){
        Page<PmAgent> page = pmAgentService.getList(pmAgent, new Page<PmAgent>(request, response));

        PmAgent agent = pmAgentService.getById(agentId);
        if(agent != null){
            model.addAttribute("agentName",agent.getAgentName());
        }
        model.addAttribute("page",page);
        model.addAttribute("agentId",agentId);

        return "modules/shopping/statement/chooseAgent";
    }


    /**
     * 选择门店
     * @param agentId
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:agentStatement:view")
    @RequestMapping("chooseShopByAgent")
    public String chooseShopByAgent(Integer agentId , Integer chooseIds , String shopNames ,
                                    HttpServletRequest request , HttpServletResponse response ,
                                    Model model, PmShopInfo pmShopInfo){
        List<Object> list = pmAgentShopService.getShopListByAgent(agentId+"", new Page<Object>(request, response),null,null,pmShopInfo);

        if (list != null && list.size() == 3){
            model.addAttribute("page",list.get(0));
            model.addAttribute("pmShopList",list.get(1));
            model.addAttribute("pmAgentShopList",list.get(2));
        }

        PmShopInfo pmShopInfo1 = pmShopInfoService.getById(chooseIds);
        if(pmShopInfo != null){
            shopNames = pmShopInfo1.getShopName();
        }

        model.addAttribute("chooseIds",chooseIds);
        model.addAttribute("shopNames",shopNames);
        model.addAttribute("agentId",agentId);

        return "modules/shopping/statement/chooseShopByAgent";
    }


    /**
     * 对菜品口味排序进行分页条件查询
     * @param request
     * @param response
     * @param timeRange     时间范围
     * @param quickTime     快速选择的时间  1  昨天  2 前七天  3 前三十天
     * @param type          类型 1 不包含加料  2  包含加料
     * @param sortType      排序的类型 0 门店  1 自提  2外卖
     * @param sortBy        排序的依据 0 销售量 1 金额
     * @param isAll        是否是所有门店的汇总 0 不是 1是
     * @param shopId       门店id
     * @return
     */
    @RequiresPermissions("merchandise:agentStatement:view")
    @ResponseBody
    @RequestMapping("productTasteCharging")
    public Map productTasteCharging(HttpServletRequest request , HttpServletResponse response,
                                    String timeRange , Integer quickTime,@RequestParam(defaultValue = "1") Integer type
            ,@RequestParam(defaultValue = "0")Integer sortType ,@RequestParam(defaultValue = "0")Integer sortBy
            ,@RequestParam(defaultValue = "1") Integer isAll , Integer shopId,Integer agentId){

        Map<String , Page<PmProductTasteRankingAgent>> map = new HashMap<String, Page<PmProductTasteRankingAgent>>();

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmProductTasteRankingAgent> rankingPage = pmProductTasteRankingAgentService.getListTimeRange(new Page<PmProductTasteRankingAgent>(request, response), sortType,
                sortBy, type, quickTime, startTime, endTime, isAll , shopId,agentId);

        map.put("data",rankingPage);

        return map;
    }


    /**
     * 分页条件查询营业指标列表
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @param isAll  是否为所有门店的汇总 0 不是  1是
     * @return
     */
    @RequiresPermissions("merchandise:agentStatement:view")
    @RequestMapping(value = "indicatorList")
    public String indicatorList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                String timeRange , @RequestParam(defaultValue = "1") Integer quickTime,
                                @RequestParam(defaultValue = "1") Integer type , @RequestParam(defaultValue = "0")Integer orderType,
                                @RequestParam(defaultValue = "1") Integer isAll){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmBusinessIndicatorsAgent> page = null;
        SysUser user = SysUserUtils.getUser();
        List<PmBusinessIndicatorsAgent> todayDateList = new ArrayList<PmBusinessIndicatorsAgent>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = agentTodayStatementService.indicator(orderType,isAll,type);
        }

        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsAgentService.getRangeListByDay(new Page<PmBusinessIndicatorsAgent>(request, response), quickTime, startTime, endTime, orderType, isAll, user.getTeaAgentId());
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){

                page = pmBusinessIndicatorsAgentService.getRangeListByMonth(new Page<PmBusinessIndicatorsAgent>(request, response),  quickTime, startTime, endTime , orderType,isAll,user.getTeaAgentId());
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessIndicatorsAgent>(request, response));

        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("orderType",orderType);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shopping/statement/agentIndicatorList";
    }


    /**
     * 导出营业指标报表
     * @param request
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @param isAll  是否为所有门店的汇总 0 不是  1是
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "indicatorExcel")
    public String indicatorExcel(HttpServletRequest request ,String timeRange , Integer quickTime,
                                 Integer type ,Integer orderType,Integer isAll,String[] syllable ){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmBusinessIndicatorsAgent> page = null;
        SysUser user = SysUserUtils.getUser();
        List<PmBusinessIndicatorsAgent> todayDateList = new ArrayList<PmBusinessIndicatorsAgent>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = agentTodayStatementService.indicator(orderType,isAll,type);
        }


        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsAgentService.getRangeListByDay(new Page<PmBusinessIndicatorsAgent>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, user.getTeaAgentId());
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){

                page = pmBusinessIndicatorsAgentService.getRangeListByMonth(new Page<PmBusinessIndicatorsAgent>(1, Integer.MAX_VALUE),  quickTime, startTime, endTime , orderType,isAll,user.getTeaAgentId());
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessIndicatorsAgent>(1, Integer.MAX_VALUE));


        String title = type == 1?"代理商营业指标日报":"代理商营业指标月报";

        String url = new ExcelUtil().export(syllable, page.getList(), title, request);

        return url;
    }


    /**
     * 手动给page
     * @param todayDateList 今天的数据
     * @param oldPage   原来统计好的数据
     * @param oldPage   需要放入数据的新newPage
     * @param <T>
     * @return
     */
    public <T>Page<T> getPage(List<T> todayDateList,Page<T> oldPage , Page<T> newPage){
        List<T> list = null;
        if(oldPage == null || CollectionUtils.isEmpty(oldPage.getList())){
            list = new ArrayList();
        }else{
            list = oldPage.getList();
        }

        //把当前的数据直接放入总的列表中
        if(CollectionUtils.isNotEmpty(todayDateList)){
            list.addAll(0,todayDateList);
        }

        List<T> resultList = new ArrayList<T>();

        //循环取出当前页的数据
        for(int i = 0 ; i < newPage.getMaxResults();i++){
            if(newPage.getFirstResult() + i >=list.size()){
                continue;
            }

            resultList.add(list.get(newPage.getFirstResult()+i));
        }

        newPage.setList(resultList);
        newPage.setCount(list.size());
        return newPage;
    }
}
