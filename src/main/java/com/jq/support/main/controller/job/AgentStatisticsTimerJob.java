package com.jq.support.main.controller.job;

import com.jq.support.model.agent.PmAgent;
import com.jq.support.model.agent.PmAgentShop;
import com.jq.support.model.shop.*;
import com.jq.support.model.statement.PmBusinessIndicatorsAgent;
import com.jq.support.model.statement.PmBusinessStatisticsAgent;
import com.jq.support.service.agent.PmAgentService;
import com.jq.support.service.agent.PmAgentShopService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.EbOrderitemService;
import com.jq.support.service.merchandise.product.EbProductChargingService;
import com.jq.support.service.merchandise.shop.*;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 *代理商报表定时任务
 *
 */
@Controller
public class AgentStatisticsTimerJob {
    @Autowired
    private PmBusinessStatisticsService pmBusinessStatisticsService;
    @Autowired
    private PmBusinessStatisticsAgentService pmBusinessStatisticsAgentService;
    @Autowired
    private EbOrderService ebOrderService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmBusinessDailyService pmBusinessDailyService;
    @Autowired
    private PmBusinessDailyItemService pmBusinessDailyItemService;
    @Autowired
    private PmBusinessDailyRankingService pmBusinessDailyRankingService;
    @Autowired
    private  PmBusinessDailyItemPayService pmBusinessDailyItemPayService;
    @Autowired
    private PmProductTasteRankingService pmProductTasteRankingService;
    @Autowired
    private EbOrderitemService ebOrderitemService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private PmProductTasteService pmProductTasteService;
    @Autowired
    private PmBusinessIndicatorsService pmBusinessIndicatorsService;
    @Autowired
    private PmBusinessIndicatorsAgentService pmBusinessIndicatorsAgentService;
    @Autowired
    private PmShopUserService pmShopUserService;
    @Autowired
    private PmAgentService pmAgentService;
    @Autowired
    private PmAgentShopService pmAgentShopService;
    @Autowired
    private PmBusinessDailyAgentService pmBusinessDailyAgentService;
    @Autowired
    private PmBusinessDailyItemAgentService pmBusinessDailyItemAgentService;
    @Autowired
    private PmBusinessDailyItemPayAgentService pmBusinessDailyItemPayAgentService;
    @Autowired
    private PmBusinessDailyRankingAgentService pmBusinessDailyRankingAgentService;
    @Autowired
    private PmProductTasteAgentService pmProductTasteAgentService;
    @Autowired
    private PmProductTasteRankingAgentService pmProductTasteRankingAgentService;

    /**
     * 统计每日营业汇总(所有门店)(代理商)
     */
    @Transactional(readOnly = false)
    public void oneDayStatistics(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            PmBusinessStatisticsAgent statisticsAgent = pmBusinessStatisticsService.totalAll(1,1, pmAgent.getShopIds(), pmAgent.getId(),pmAgent.getAgentName());
            pmBusinessStatisticsAgentService.insert(statisticsAgent);
        }
        System.out.println("///////////////////////////////////////////////////////");
    }

    /**
     * 统计每日营业汇总(以门店为单位)(代理商)
     */
    @Transactional(readOnly = false)
    public void oneDayStatisticsByShop(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        Calendar cal  =  Calendar.getInstance();cal.add(Calendar.DATE,-1);

        for (PmAgent pmAgent:all) {
            List<PmAgentShop> list = pmAgentShopService.getByAgentId(pmAgent.getId());
            PmBusinessStatisticsAgent statisticsAgent = null;

            if(list != null || list.size() > 0 ){
                for (PmAgentShop pmAgentShop:list){
                    statisticsAgent = pmBusinessStatisticsService.totalByShop(1, pmAgentShop.getShopId(),
                            pmAgentShop.getShopName(), pmAgent.getId(), pmAgent.getAgentName(),0);
                    pmBusinessStatisticsAgentService.insert(statisticsAgent);
                }

            }
        }
        System.out.println("///////////////////////////////////////////////////////");
    }


    /**
     * 统计每月营业汇总(所有门店)(代理商)
     */
    @Transactional(readOnly = false)
    public void oneMonthStatistics(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {

            PmBusinessStatisticsAgent statisticsAgent = pmBusinessStatisticsService.totalAll(2,1, pmAgent.getShopIds(), pmAgent.getId(), pmAgent.getAgentName());
            pmBusinessStatisticsAgentService.insert(statisticsAgent);
        }
        System.out.println("///////////////////////////////////////////////////////");
    }

    /**
     * 统计每月营业汇总(以门店为单位)(代理商)
     */
    @Transactional(readOnly = false)
    public void oneMonthStatisticsByShop(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        Calendar cal  =  Calendar.getInstance();cal.add(Calendar.DATE,-1);

        for (PmAgent pmAgent:all) {
            List<PmAgentShop> list = pmAgentShopService.getByAgentId(pmAgent.getId());
            PmBusinessStatisticsAgent statisticsAgent = null;

            if(list != null || list.size() > 0 ){
                for (PmAgentShop pmAgentShop:list){
                    statisticsAgent = pmBusinessStatisticsService.totalByShop(2, pmAgentShop.getShopId(),
                            pmAgentShop.getShopName(), pmAgent.getId(), pmAgent.getAgentName(),0);
                    pmBusinessStatisticsAgentService.insert(statisticsAgent);
                }

            }
        }
        System.out.println("///////////////////////////////////////////////////////");
    }



    /**
     * 统计每日营业指标(所有门店)(代理商)
     */
    @Transactional
    public void oneDayIndicator(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            if(pmAgent == null){
                return ;
            }

            //获得代理商下所有门店的总员工
            List<PmAgentShop> list = pmAgentShopService.getByAgentId(pmAgent.getId());
            Integer employeesCount = 0;
            for(PmAgentShop pmAgentShop:list){
                Integer userCount = pmShopUserService.getUserCountByShopId(pmAgentShop.getShopId());
                employeesCount+=userCount;
            }

            for (int i = 0; i < 4; i++) {
                //统计
                PmBusinessIndicatorsAgent pmBusinessIndicatorsAgent = pmBusinessIndicatorsService.totalAll(employeesCount,
                        1,1, i, pmAgent.getShopIds(), pmAgent.getId(), pmAgent.getAgentName());
                pmBusinessIndicatorsAgentService.insert(pmBusinessIndicatorsAgent);
            }

        }
        System.out.println("///////////////////////////////////////////////////////");
    }


    /**
     * 统计每日营业指标(以门店为单位)(代理商)
     */
    @Transactional
    public void oneDayIndicatorByShop(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            if(pmAgent == null){
                return ;
            }
            List<PmAgentShop> pmAgentShopList = pmAgentShopService.getByAgentId(pmAgent.getId());
            if(pmAgentShopList == null || pmAgentShopList.size() == 0){
                return;
            }

            for(PmAgentShop pmAgentShop : pmAgentShopList){
                //获得门店的员工总数
                Integer employeesCount = pmShopUserService.getUserCountByShopId(pmAgentShop.getShopId());

                for (int i = 0; i < 4; i++) {
                    //统计
                    PmBusinessIndicatorsAgent pmBusinessIndicatorsAgent = pmBusinessIndicatorsService.totalByShop(employeesCount, 1,0, i,
                            pmAgentShop.getShopId(), pmAgentShop.getShopName(),pmAgent.getId(), pmAgent.getAgentName());
                    pmBusinessIndicatorsAgentService.insert(pmBusinessIndicatorsAgent);
                }

            }

        }
        System.out.println("///////////////////////////////////////////////////////");
    }


    /**
     * 统计每月营业指标(所有门店)(代理商)
     */
    @Transactional
    public void oneMonthIndicator(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            if(pmAgent == null){
                return ;
            }

            //获得代理商下所有门店的总员工
            List<PmAgentShop> list = pmAgentShopService.getByAgentId(pmAgent.getId());
            Integer employeesCount = 0;
            for(PmAgentShop pmAgentShop:list){
                Integer userCount = pmShopUserService.getUserCountByShopId(pmAgentShop.getShopId());
                employeesCount+=userCount;
            }

            for (int i = 0; i < 4; i++) {
                //统计
                PmBusinessIndicatorsAgent pmBusinessIndicatorsAgent = pmBusinessIndicatorsService.totalAll(employeesCount, 1,2, i,
                        pmAgent.getShopIds(), pmAgent.getId(), pmAgent.getAgentName());
                pmBusinessIndicatorsAgentService.insert(pmBusinessIndicatorsAgent);
            }

        }
        System.out.println("///////////////////////////////////////////////////////");
    }


    /**
     * 统计每月营业指标(以门店为单位)(代理商)
     */
    @Transactional
    public void oneMonthIndicatorByShop(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            if(pmAgent == null){
                return ;
            }
            List<PmAgentShop> pmAgentShopList = pmAgentShopService.getByAgentId(pmAgent.getId());
            if(pmAgentShopList == null || pmAgentShopList.size() == 0){
                return;
            }

            for(PmAgentShop pmAgentShop : pmAgentShopList){
                //获得门店的员工总数
                Integer employeesCount = pmShopUserService.getUserCountByShopId(pmAgentShop.getShopId());

                for (int i = 0; i < 4; i++) {
                    //统计
                    PmBusinessIndicatorsAgent pmBusinessIndicatorsAgent = pmBusinessIndicatorsService.totalByShop(employeesCount,
                            2,0, i, pmAgentShop.getShopId(),pmAgentShop.getShopName(), pmAgent.getId(), pmAgent.getAgentName());
                    pmBusinessIndicatorsAgentService.insert(pmBusinessIndicatorsAgent);
                }

            }

        }
        System.out.println("///////////////////////////////////////////////////////");
    }



    /**
     * 统计营业日报(所有门店)(代理商)
     */
    public void totalBusinessDaily(){
        List<PmAgent> all = pmAgentService.getAll();
        if(all == null || all.size() == 0 ){
            return ;
        }

        for (PmAgent pmAgent: all) {    //遍历代理商
            if (pmAgent == null) {
                continue;
            }

            //插入主表
            PmBusinessDailyAgent pmBusinessDailyAgent = pmBusinessDailyService.totalAll(pmAgent.getShopIds(),
                    pmAgent.getId(), pmAgent.getAgentName());
            pmBusinessDailyAgentService.insert(pmBusinessDailyAgent);
            String ids = pmBusinessDailyService.getYesterdayIdsByShop(pmAgent.getShopIds());

            if(ids == null){
                continue;
            }
//            System.out.println("*************************");
            for (int i = 1; i <= 3 ; i++) { //统计明细表
                PmBusinessDailyItemAgent item = pmBusinessDailyItemService.totalAll(i, ids);
                item.setBusinessDailyId(pmBusinessDailyAgent.getId());
                item.setType(i);
                pmBusinessDailyItemAgentService.insert(item);

                String itemIds = pmBusinessDailyItemService.getIdsByDailyIdAndType(ids, i);//获得来源表id（非代理商）

                //统计营业日报明细表的实付构成表信息
                List<PmBusinessDailyItemPayAgent> itemPayAgents = pmBusinessDailyItemPayService.totalAll(itemIds);
                if(itemPayAgents != null) {
                    for (PmBusinessDailyItemPayAgent payAgent : itemPayAgents) {
                        payAgent.setBusinessDailyItemId(item.getId());
                        pmBusinessDailyItemPayAgentService.insert(payAgent);
                    }
                }

                //统计营业日报件排行表信息
                List<PmBusinessDailyRankingAgent> rankingList = pmBusinessDailyRankingService.totalAll(itemIds,1);
                if(CollectionUtils.isNotEmpty(rankingList)) {
                    for (PmBusinessDailyRankingAgent rankingAgent : rankingList) {
                        rankingAgent.setBusinessDailyItemId(item.getId());
                        pmBusinessDailyRankingAgentService.insert(rankingAgent);
                    }
                }

                //统计营业日报重量排行表信息
                List<PmBusinessDailyRankingAgent> weightRankingList = pmBusinessDailyRankingService.totalAll(itemIds,2);
                if(CollectionUtils.isNotEmpty(weightRankingList)) {
                    for (PmBusinessDailyRankingAgent rankingAgent : weightRankingList) {
                        rankingAgent.setBusinessDailyItemId(item.getId());
                        pmBusinessDailyRankingAgentService.insert(rankingAgent);
                    }
                }
            }

        }

        System.out.println("////////////////////代理商的营业日报（汇总）//////////////////////////////");

    }


    /**
     * 统计营业日报（以门店为单位）
     */
    public void totalBusinessDailyByShop(){
        List<PmAgent> all = pmAgentService.getAll();
        if(all == null || all.size() == 0 ){
            return ;
        }

        for (PmAgent pmAgent: all) {    //遍历代理商
            if (pmAgent == null) {
                continue;
            }
            List<PmAgentShop> list = pmAgentShopService.getByAgentId(pmAgent.getId());
            if (list == null) {
                continue;
            }
            for (PmAgentShop pmAgentShop : list) {
               
                //插入主表
                PmBusinessDailyAgent pmBusinessDailyAgent = pmBusinessDailyService.totalByShop(pmAgentShop.getShopId(), pmAgentShop.getShopName(),
                        pmAgentShop.getAgentId(), pmAgentShop.getAgentName());
                pmBusinessDailyAgentService.insert(pmBusinessDailyAgent);
                String id = pmBusinessDailyService.getYesterdayIdsByShop(pmAgentShop.getShopId()+"");

                if(id == null){
                    continue;
                }
                System.out.println("*************************");
                for (int i = 1; i <= 3 ; i++) { //统计明细表

                    PmBusinessDailyItemAgent item = pmBusinessDailyItemService.totalByShop(i, Integer.valueOf(id));
                    item.setBusinessDailyId(pmBusinessDailyAgent.getId());
                    if(item.getId() != null){
                        System.out.println(item.toString());
                    }
                    pmBusinessDailyItemAgentService.insert(item);

                    String itemId = pmBusinessDailyItemService.getIdsByDailyIdAndType(id, i);//获得来源表id（非代理商）

                    //统计营业日报明细表的实付构成表信息
                    List<PmBusinessDailyItemPayAgent> itemPayAgents = pmBusinessDailyItemPayService.totalByShop(Integer.valueOf(itemId));
                    if(itemPayAgents != null){
                        for (PmBusinessDailyItemPayAgent payAgent : itemPayAgents){
                            payAgent.setBusinessDailyItemId(item.getId());
                            pmBusinessDailyItemPayAgentService.insert(payAgent);
                        }
                    }



                    //统计营业日报件排行表信息
                    List<PmBusinessDailyRankingAgent> rankingList = pmBusinessDailyRankingService.totalByShop(itemId,1);
                    if(CollectionUtils.isNotEmpty(rankingList)) {
                        for (PmBusinessDailyRankingAgent rankingAgent : rankingList) {
                            rankingAgent.setBusinessDailyItemId(item.getId());
                            pmBusinessDailyRankingAgentService.insert(rankingAgent);
                        }
                    }

                    //统计营业日报重量排行表信息
                    List<PmBusinessDailyRankingAgent> rankingList2 = pmBusinessDailyRankingService.totalByShop(itemId,2);
                    if(CollectionUtils.isNotEmpty(rankingList2)) {
                        for (PmBusinessDailyRankingAgent rankingAgent : rankingList2) {
                            rankingAgent.setBusinessDailyItemId(item.getId());
                            pmBusinessDailyRankingAgentService.insert(rankingAgent);
                        }
                    }
                }
            }
        }
        System.out.println("///////////////////营业日报（门店）///////////////////////////////");
    }


    /**
     * 统计菜品营业分析(所有门店)
     */
    public void totalProductTaste(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            if(pmAgent == null){
                return ;
            }

            //统计统计表信息
            PmProductTasteAgent pmProductTasteAgent = pmProductTasteService.totalAll(pmAgent.getShopIds(), pmAgent.getId(), pmAgent.getAgentName());
            pmProductTasteAgentService.insert(pmProductTasteAgent);

            //统计排行表
            String tasteIds = pmProductTasteService.getYesterdayTasteIdByShopId(pmAgent.getShopIds());
            //以商品为单位的排行
            List<PmProductTasteRankingAgent> rankingList1 = pmProductTasteRankingService.totalRankingAgent
                    (tasteIds, 1, pmAgent.getId(), pmAgent.getAgentName(),1);
            if(CollectionUtils.isNotEmpty(rankingList1)){
                for (PmProductTasteRankingAgent ranking:rankingList1){
                    ranking.setProductTasteId(pmProductTasteAgent.getId());
                    pmProductTasteRankingAgentService.insert(ranking);
                }
            }

            //以规格为单位的排行
            List<PmProductTasteRankingAgent> rankingList2 = pmProductTasteRankingService.totalRankingAgent
                    (tasteIds, 1, pmAgent.getId(), pmAgent.getAgentName(),2);
            if(CollectionUtils.isNotEmpty(rankingList2)){
                for (PmProductTasteRankingAgent ranking:rankingList2){
                    ranking.setProductTasteId(pmProductTasteAgent.getId());
                    pmProductTasteRankingAgentService.insert(ranking);
                }
            }

            //斩料的排行
            List<PmProductTasteRankingAgent> rankingList3 = pmProductTasteRankingService.totalRankingAgent
                    (tasteIds, 1, pmAgent.getId(), pmAgent.getAgentName(),3);
            if(CollectionUtils.isNotEmpty(rankingList3)){
                for (PmProductTasteRankingAgent ranking:rankingList3){
                    ranking.setProductTasteId(pmProductTasteAgent.getId());
                    pmProductTasteRankingAgentService.insert(ranking);
                }
            }
        }


        System.out.println("///////////////菜品营业分析(所有门店)///////////////////");


    }

    /**
     * 统计菜单营业分析(以门店为单位)
     */
    public void totalProductTasteByShop(){
        List<PmAgent> all = pmAgentService.getAll();

        if(all == null || all.size() == 0){
            return ;
        }

        for (PmAgent pmAgent:all) {
            if(pmAgent == null){
                return ;
            }

            List<PmAgentShop> pmAgentShopList = pmAgentShopService.getByAgentId(pmAgent.getId());

            for (PmAgentShop pmAgentShop: pmAgentShopList) {
                //统计统计表信息
                PmProductTasteAgent pmProductTasteAgent = pmProductTasteService.totalByShop(pmAgentShop.getShopId()+"",pmAgentShop.getShopName(),
                        pmAgent.getId(), pmAgent.getAgentName());
                pmProductTasteAgentService.insert(pmProductTasteAgent);

                //统计排行表
                String tasteIds = pmProductTasteService.getYesterdayTasteIdByShopId(pmAgentShop.getShopId()+"");

                List<PmProductTasteRankingAgent> rankingList1 = pmProductTasteRankingService.totalRankingAgent
                        (tasteIds, 0, pmAgent.getId(), pmAgent.getAgentName(),1);
                //统计包括加料的排行
                if(CollectionUtils.isNotEmpty(rankingList1)){
                    for (PmProductTasteRankingAgent ranking:rankingList1){
                        ranking.setProductTasteId(pmProductTasteAgent.getId());
                        pmProductTasteRankingAgentService.insert(ranking);
                    }
                }

                List<PmProductTasteRankingAgent> rankingList2 = pmProductTasteRankingService.totalRankingAgent
                        (tasteIds, 0, pmAgent.getId(), pmAgent.getAgentName(),2);
                //统计包括加料的排行
                if(CollectionUtils.isNotEmpty(rankingList2)){
                    for (PmProductTasteRankingAgent ranking:rankingList2){
                        ranking.setProductTasteId(pmProductTasteAgent.getId());
                        pmProductTasteRankingAgentService.insert(ranking);
                    }
                }

                List<PmProductTasteRankingAgent> rankingList3 = pmProductTasteRankingService.totalRankingAgent
                        (tasteIds, 0, pmAgent.getId(), pmAgent.getAgentName(),3);
                //统计包括加料的排行
                if(CollectionUtils.isNotEmpty(rankingList3)){
                    for (PmProductTasteRankingAgent ranking:rankingList3){
                        ranking.setProductTasteId(pmProductTasteAgent.getId());
                        pmProductTasteRankingAgentService.insert(ranking);
                    }
                }
            }


        }


        System.out.println("/////////////////菜品营业分析(以门店为单位)/////////////////");
    }
}
