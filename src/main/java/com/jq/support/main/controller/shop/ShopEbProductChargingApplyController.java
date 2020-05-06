package com.jq.support.main.controller.shop;

import com.jq.support.common.persistence.Page;
import com.jq.support.model.product.*;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.utils.FormatUtil;
import com.jq.support.service.utils.StringUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 商品加料价格修改申请的controller 门店端
 */
@Controller
@RequestMapping(value = "${adShopPath}/ebProductChargingApply")
public class ShopEbProductChargingApplyController {
    @Autowired
    private EbProductChargingApplyService ebProductChargingApplyService;
    @Autowired
    private EbProductChargingApplyItemService ebProductChargingApplyItemService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private EbShopChargingService ebShopChargingService;
    @Autowired
    private EbProductChargingApplyRemarkService ebProductChargingApplyRemarkService;

    /**
     * 增加申请
     * @param request
     * @param apply
     * @param chargingIdArr
     * @param newPriceArr
     * @return
     */
    @ResponseBody
    @RequestMapping("insertApply")
    public Map<String,String> insertApply(HttpServletRequest request , EbProductChargingApply apply,
                                          Integer[] chargingIdArr , Double []newPriceArr){

        EbUser shopuser = (EbUser) request.getSession().getAttribute("shopuser");
        apply.setCreateTime(new Date());
        apply.setIsApply(0);
        apply.setApplyStatus(0);
        apply.setShopId(shopuser.getShopId());
        apply.setShopName(shopuser.getShopName());

        //插入申请表信息
        boolean result = ebProductChargingApplyService.insert(apply);

        Map<String,String> map = new HashMap<String, String>();

        if(!result){
            map.put("code","0");
            map.put("prompt","提交申请失败");
        }


        List<EbProductChargingApplyItem> itemList = new ArrayList<EbProductChargingApplyItem>();
        for(Integer i=0 ; i < chargingIdArr.length ; i++){
            EbShopCharging ebShopCharging = ebShopChargingService.getByShopIdAndChargingId(shopuser.getShopId(), chargingIdArr[i]);
            EbProductCharging ebProductCharging = ebProductChargingService.getById(chargingIdArr[i]);
            EbProductChargingApplyItem item = new EbProductChargingApplyItem();
            item.setApplyId(apply.getId());
            item.setChargingId(chargingIdArr[i]);
            item.setNewPrice(newPriceArr[i]);
            if(ebShopCharging != null){
                item.setOldPrice(ebShopCharging.getSellPrice());
            }
            if(ebProductCharging != null){
                item.setChargingName(ebProductCharging.getcName());
            }
            itemList.add(item);
        }
        //插入申请明细表信息
        result = ebProductChargingApplyItemService.batchInsert(itemList);

        map.put("code",result?"1":"0");
        map.put("prompt",result?"提交申请成功":"提交申请失败");

        return map;
    }


    /**
     * 修改申请
     * @param request
     * @param apply
     * @param itemIdArr
     * @param newPriceArr
     * @return
     */
    @ResponseBody
    @RequestMapping("updateApply")
    public Map<String,String> updateApply(HttpServletRequest request , EbProductChargingApply apply,
                                          Integer[] itemIdArr , Double []newPriceArr){

        //更新申请表信息
        boolean result = ebProductChargingApplyService.updateApply(apply);

        Map<String,String> map = new HashMap<String, String>();

        if(!result){
            map.put("code","0");
            map.put("prompt","修改申请失败");
        }


        List<EbProductChargingApplyItem> itemList = new ArrayList<EbProductChargingApplyItem>();
        for(Integer i=0 ; i < itemIdArr.length ; i++){
            EbProductChargingApplyItem item = ebProductChargingApplyItemService.getById(itemIdArr[i]);
            item.setNewPrice(newPriceArr[i]);
            itemList.add(item);
        }
        //更新申请明细表信息
        result = ebProductChargingApplyItemService.batchUpdate(itemList);

        map.put("code",result?"1":"0");
        map.put("prompt",result?"修改申请成功":"修改申请失败");

        return map;
    }


    /**
     * 导航到申请列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"","applyList"})
    public String applyList(HttpServletRequest request , HttpServletResponse response , Model  model,
                                 EbProductChargingApply apply){
        EbUser shopuser = (EbUser) request.getSession().getAttribute("shopuser");
        apply.setShopId(shopuser.getShopId());

        Page<EbProductChargingApply> page = ebProductChargingApplyService.getList(apply, new Page<EbProductChargingApply>(request, response));
        model.addAttribute("page",page);
        model.addAttribute("apply",apply);

        return "modules/shop/ebProductChargingApplyList";
    }

    /**
     * 导航到审核页面
     * @param applyId
     * @param model
     * @return
     */
    @RequestMapping(value = "applyForm")
    public String applyForm(Integer applyId , Model model){
        EbProductChargingApply apply = ebProductChargingApplyService.getById(applyId);

        if(apply == null){
            return  "modules/shop/ebProductChargingApplyForm";
        }

        List<EbProductChargingApplyItem> itemList = ebProductChargingApplyItemService.getByApplyId(apply.getId());
        List<EbProductChargingApplyRemark> remarkList = ebProductChargingApplyRemarkService.getByApplyId(apply.getId());

        model.addAttribute("apply",apply);
        model.addAttribute("itemList",itemList);
        model.addAttribute("remarkList",remarkList);

        return  "modules/shop/ebProductChargingApplyForm";
    }

    /**
     * 打开加料申请单
     * @return
     */
    @RequestMapping("openApplyChargingList")
    public String openApplyChargingList(HttpServletRequest request , Model model , String chargingIds){

        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        List<Object> list = ebProductChargingService.getByChargingIds(chargingIds,ebUser.getShopId());

        if(list != null && list.size() == 2){
            model.addAttribute("shopChargingList",list.get(0));
            model.addAttribute("chargingList",list.get(1));
        }


        return "modules/shop/openApplyChargingList";
    }


    /**
     * 取消申请
     * @param applyId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "cancelApply")
    public Map<String,String> cancelApply(Integer applyId){
        Map<String,String> map = new HashMap<String, String>();

        if(applyId == null){
            map.put("code","0");
            map.put("prompt","取消申请失败");
            return map;
        }

        EbProductChargingApply apply = ebProductChargingApplyService.getById(applyId);
        if(apply != null){
            apply.setApplyStatus(4);
            boolean result = ebProductChargingApplyService.update(apply);

            map.put("code",result?"1":"0");
            map.put("prompt",result?"修改申请成功":"修改申请失败");
        }else{
            map.put("code","0");
            map.put("prompt","取消申请失败");
        }

        return map;
    }

    /**
     * 查询指定分类的所有标签
     * @param ebProductCharging
     * @param createTime
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "chooseProductCharging")
    public String chooseProductCharging(
            EbProductCharging ebProductCharging,String createTime,String chooseIds,
            HttpServletRequest request, HttpServletResponse response, Model model){
        List<String> cNames = new ArrayList<String>();
        List<String> sellPrices = new ArrayList<String>();
        List<String> lables = new ArrayList<String>();

        //根据id查询加料名等信息
        if(StringUtil.isNotBlank(chooseIds)) {
            String[] ids = chooseIds.split(",");
            for (int i = 0; i < ids.length; i++) {
                EbProductCharging charging = ebProductChargingService.getById(Integer.parseInt(ids[i]));
                if(charging != null){
                    cNames.add(charging.getcName());
                    sellPrices.add(charging.getSellPrice()+"");
                    lables.add(charging.getLable());
                }
            }

            model.addAttribute("cNames",cNames.toString().replace("[","").replace("]",""));
            model.addAttribute("sellPrices",sellPrices.toString().replace("[","").replace("]",""));
            model.addAttribute("lables",lables.toString().replace("[","").replace("]",""));
        }


        Page<EbProductCharging> page=ebProductChargingService.getPageList(new Page<EbProductCharging>(request, response),ebProductCharging,createTime);

        model.addAttribute("createTime", createTime);
        model.addAttribute("page", page);
        model.addAttribute("ebProductCharging", ebProductCharging);
        model.addAttribute("chooseIds", chooseIds);
        return "modules/shop/chooseProductCharging";
    }


    /**
     * 一键所有
     * @return
     */
    @ResponseBody
    @RequestMapping("chooseAll")
    public Map<String,String> chooseAll(EbProductCharging ebProductCharging,String createTime){
        Map<String,String> map = new HashMap<String, String>();

        Page<EbProductCharging> page=ebProductChargingService.getPageList(new Page<EbProductCharging>(1, Integer.MAX_VALUE),ebProductCharging,createTime);

        String chooseIds = FormatUtil.getFieldAllValue(page.getList(), "id");
        String cNames = FormatUtil.getFieldAllValue(page.getList(), "cName");
        String sellPrices = FormatUtil.getFieldAllValue(page.getList(), "sellPrice");
        String lables = FormatUtil.getFieldAllValue(page.getList(), "lable");


        map.put("chooseIds",chooseIds);
        map.put("cNames",cNames);
        map.put("sellPrices",sellPrices);
        map.put("lables",lables);

        return map;
    }


}
