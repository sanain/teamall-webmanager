package com.jq.support.main.controller.merchandise.product;

import com.jq.support.common.persistence.Page;
import com.jq.support.model.product.*;
import com.jq.support.service.merchandise.product.EbProductChargingApplyItemService;
import com.jq.support.service.merchandise.product.EbProductChargingApplyRemarkService;
import com.jq.support.service.merchandise.product.EbProductChargingApplyService;
import com.jq.support.service.merchandise.product.EbShopChargingService;
import com.jq.support.service.utils.StringUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 商品加料价格修改申请的controller  后台
 */
@Controller
@RequestMapping("${adminPath}/ebProductChargingApply")
public class EbProductChargingApplyController {
    @Autowired
    private EbProductChargingApplyRemarkService ebProductChargingApplyRemarkService;
    @Autowired
    private EbProductChargingApplyService ebProductChargingApplyService;
    @Autowired
    private EbProductChargingApplyItemService ebProductChargingApplyItemService;
    @Autowired
    private EbShopChargingService ebShopChargingService;


    /**
     * 导航到申请列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "checkApplyList")
    @RequiresPermissions("merchandise:ebProductChargingApply:view")
    public String checkApplyList(HttpServletRequest request , HttpServletResponse response , Model  model,
                                 EbProductChargingApply apply){
        Page<EbProductChargingApply> page = ebProductChargingApplyService.getList(apply, new Page<EbProductChargingApply>(request, response));
        model.addAttribute("page",page);
        model.addAttribute("apply",apply);

        return "modules/shopping/brands/EbProductChargingApplyList";
    }

    /**
     * 导航到审核页面
     * @param applyId
     * @param model
     * @return
     */
    @RequestMapping(value = "toCheckApply")
    @RequiresPermissions("merchandise:ebProductChargingApply:edit")
    public String toCheckApply(Integer applyId , Model model){
        EbProductChargingApply apply = ebProductChargingApplyService.getById(applyId);

        if(apply == null){
            return "modules/shopping/brands/ebProductChargingApplyForm";
        }

        List<EbProductChargingApplyItem> itemList = ebProductChargingApplyItemService.getByApplyId(apply.getId());
        List<EbProductChargingApplyRemark> remarkList = ebProductChargingApplyRemarkService.getByApplyId(apply.getId());

        model.addAttribute("apply",apply);
        model.addAttribute("itemList",itemList);
        model.addAttribute("remarkList",remarkList);

        return "modules/shopping/brands/ebProductChargingApplyForm";
    }

    /**
     * 审核
     * @param apply
     * @param remark
     * @return
     */
    @ResponseBody
    @RequestMapping(value="checkApply")
    public Map<String , String> checkApply(EbProductChargingApply apply, String remark){
        Map<String , String> map = new HashMap<String, String>();

        if(apply.getId() == null){
            map.put("code","0");
            map.put("prompt","审核失败");
            return map;
        }


        //更新申请总表
        EbProductChargingApply oldApply = ebProductChargingApplyService.getById(apply.getId());
        oldApply.setApplyStatus(apply.getApplyStatus());
        oldApply.setIsApply(1);
        oldApply.setApplyTime(new Date());
        ebProductChargingApplyService.update(oldApply);

        //插入回复
        if(StringUtil.isNotBlank(remark)){
            EbProductChargingApplyRemark applyRemark = new EbProductChargingApplyRemark();
            applyRemark.setApplyId(oldApply.getId());
            apply.setCreateTime(new Date());
            applyRemark.setRemark(remark);
            ebProductChargingApplyRemarkService.insert(applyRemark);
        }


        //更新加料的销售价格
        if(oldApply.getApplyStatus() == 1) {
            List<EbProductChargingApplyItem> itemList = ebProductChargingApplyItemService.getByApplyId(oldApply.getId());
            for (EbProductChargingApplyItem item : itemList) {
                EbShopCharging ebShopCharging = ebShopChargingService.getByShopIdAndChargingId(oldApply.getShopId(), item.getChargingId());
                if (ebShopCharging != null) {
                    ebShopCharging.setSellPrice(item.getNewPrice());
                    ebShopChargingService.update(ebShopCharging);
                }
            }
        }

        map.put("code","1");
        map.put("prompt","审核成功");
        return map;
    }

}
