package com.jq.support.main.controller.merchandise.product;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.model.product.*;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.utils.FormatUtil;
import com.jq.support.service.utils.StringUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

/**
 * 后台的商品价格修改
 */
@Controller
@RequestMapping("${adminPath}/productPriceApply")
public class EbProductPriceApplyController {
    @Autowired
    private EbProductPriceApplyService ebProductPriceApplyService;
    @Autowired
    private EbProductPriceItemService ebProductPriceItemService;
    @Autowired
    private EbProductPriceRemarkService ebProductPriceRemarkService;
    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private PmProductStandardDetailService pmProductStandardDetailService;
    @Autowired
    private EbShopProductService ebShopProductService;
    @Autowired
    private EbShopProductStandardDetailService ebShopProductStandardDetailService;

    /**
     * 进入申请列表
     * @param request
     * @param response
     * @param model
     * @param apply
     * @param startTime
     * @param endTime
     * @return
     */
    @RequiresPermissions(value = "merchandise:productPriceChargingApply:view")
    @RequestMapping("applyList")
    public String applyList(HttpServletRequest request , HttpServletResponse response , Model model,
                            EbProductPriceApply apply,String startTime , String endTime){

        Page<EbProductPriceApply> page = ebProductPriceApplyService.getList(apply, new Page<EbProductPriceApply>(request, response),
                startTime, endTime);

        model.addAttribute("startTime",startTime);
        model.addAttribute("endTime",endTime);
        model.addAttribute("apply",apply);
        model.addAttribute("page",page);

        return "modules/shopping/brands/productPriceApplyList";
    }


    /**
     * 进入审核页面
     * @param request
     * @param response
     * @param model
     * @param applyId
     * @return
     */
    @RequestMapping("toCheckApply")
    @RequiresPermissions(value = "merchandise:productPriceChargingApply:edit")
    public String toCheckApply(HttpServletRequest request , HttpServletResponse response , Model model,
                               Integer applyId,Integer code , String source){

        //处理来自审核的提示信息
        if("checkApply".equals(source) && code == 1){
            model.addAttribute("prompt","操作成功");
        }else if("checkApply".equals(source)  && code == 0){
            model.addAttribute("prompt","操作失败");
        }else if("checkApply".equals(source)  && code == 2){
            model.addAttribute("prompt","商品信息变更，将自动拒绝该申请");
        }else if("checkApply".equals(source)  && code == 3){
            model.addAttribute("prompt","已经有更新的申请生效中，将自动拒绝该申请");
        }

        if(applyId == null){
            return "modules/shopping/brands/checkProductPriceApply";
        }

        EbProductPriceApply apply = ebProductPriceApplyService.getById(applyId);
        if(apply == null){
            return "modules/shopping/brands/checkProductPriceApply";
        }

        //获得明细表信息
        List<EbProductPriceItem> itemList = ebProductPriceItemService.getByApplyId(applyId);
        List<EbProductPriceRemark> remarkList = ebProductPriceRemarkService.getByApplyId(applyId);


        model.addAttribute("apply",apply);
        model.addAttribute("itemList",itemList);
        model.addAttribute("remarkList",remarkList);

        return "modules/shopping/brands/checkProductPriceApply";
    }


    /**
     * 审核
     * @param apply
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value="checkApply")
    @RequiresPermissions(value = "merchandise:productPriceChargingApply:edit")
    public String checkApply(EbProductPriceApply apply, String remark , RedirectAttributes redirectAttributes){
        redirectAttributes.addAttribute("source","checkApply");
        redirectAttributes.addAttribute("applyId",apply.getId());

        if(apply == null || apply.getId()==null){
            redirectAttributes.addAttribute("code",0);
            return "redirect:"+ Global.getConfig("adminPath")+"productPriceApply/toCheckApply";
        }

        boolean isChange = false;
        //检查商品名称、商品规格名称
        EbProductPriceApply oldApply = ebProductPriceApplyService.getById(apply.getId());
        EbProduct product = ebProductService.getEbProduct(oldApply.getProductId()+"");
        //检查商品名称是否改变
        if(product == null || !oldApply.getProductName().equals(product.getProductName())){
            isChange=true;
        }

        if(!isChange && oldApply.getIsMoreDetail() == 1){    //多规格时，检查规格名称
            List<EbProductPriceItem> itemList = ebProductPriceItemService.getByApplyId(oldApply.getId());

            for (int i = 0; itemList != null && i < itemList.size(); i++) {
                PmProductStandardDetail detail = pmProductStandardDetailService.getPmProductStandardDetail(itemList.get(i).getItemId() + "");
                if(itemList.get(i)==null || !itemList.get(i).getApplyContent().equals(detail.getStandardValueStr())){    //检查商品名称是否改变
                    isChange=true;
                    break;
                }
            }

        }


        if(isChange ){
            apply.setApplyStatus(2);
            apply.setIsApply(1);
            apply.setApplyTime(new Date());
            ebProductPriceApplyService.updateApplyStatus(apply);
            redirectAttributes.addAttribute("code",2);   //商品信息变更
            return "redirect:"+ Global.getConfig("adminPath")+"/productPriceApply/toCheckApply";
        }

        //检查是否有时间更晚，并且已经通过的申请
        if(ebProductPriceApplyService.isExpired(oldApply)){
            apply.setApplyStatus(2);
            apply.setIsApply(1);
            apply.setApplyTime(new Date());
            ebProductPriceApplyService.updateApplyStatus(apply);
            redirectAttributes.addAttribute("prompt","已经有更新的申请生效中，将自动拒绝该申请！");
            redirectAttributes.addAttribute("code",3);   //商品信息变更

            return "redirect:"+ Global.getConfig("adminPath")+"/productPriceApply/toCheckApply";
        }

        apply.setIsApply(1);
        apply.setApplyTime(new Date());

        //修改申请
        boolean result = ebProductPriceApplyService.updateApplyStatus(apply);
        //加入回复信息
        if(StringUtil.isNotBlank(remark)){
            EbProductPriceRemark ebProductPriceChargingRemark = new EbProductPriceRemark();
            ebProductPriceChargingRemark.setApplyId(apply.getId());
            ebProductPriceChargingRemark.setCreateTime(new Date());
            ebProductPriceChargingRemark.setRemark(remark);
            ebProductPriceRemarkService.insert(ebProductPriceChargingRemark);
        }

        if(result && apply.getApplyStatus() == 2){  //不通过
            redirectAttributes.addAttribute("code","1");
            return "redirect:"+ Global.getConfig("adminPath")+"/productPriceApply/toCheckApply";
        }

        //同意之后的更新数据
        apply = ebProductPriceApplyService.getById(apply.getId());
        if(oldApply.getIsMoreDetail() == 0) {
            //更新门店商品关联表
            EbShopProduct ebShopProduct=ebShopProductService.getEbShopProductByProductIdAndShopId( apply.getProductId(),apply.getShopId());
            ebShopProduct.setSellPrice(apply.getNewPrice());
            ebShopProduct.setSellPriceRange(apply.getNewPrice()+"");
            ebShopProduct.setMemberPrice(apply.getNewMemberPrice());
            ebShopProduct.setMemberPriceRange(apply.getNewMemberPrice()+"");

            ebShopProductService.update(ebShopProduct);
        }else{    //多规格时，更新多规格的销售价
            //更新门店商品规格关联表信息
            List<EbProductPriceItem> itemList = ebProductPriceItemService.getByApplyId(oldApply.getId());
            for (int i = 0; itemList != null && i < itemList.size(); i++) {
                List<EbShopProductStandardDetail> list = ebShopProductStandardDetailService.getByShopIdAndProductId(
                        apply.getShopId(), apply.getProductId(),itemList.get(i).getItemId()+"");
                if(list.size() >0){
                    EbShopProductStandardDetail detail = list.get(0);
                    detail.setDetailPrices(itemList.get(i).getNewPrice());
                    detail.setMemberPrice(itemList.get(i).getNewMemberPrice());
                    ebShopProductStandardDetailService.updatePriceAndStoreNum(detail);
                }
            }

            List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                    .getProductIdPmProductStandardDetail(apply.getProductId().toString());
            String productStandardIds = FormatUtil.getFieldAllValue(pmProductStandardDetails, "id");
            //获得商品规格
            List<EbShopProductStandardDetail> detailList = ebShopProductStandardDetailService.getByShopIdAndProductId( apply.getShopId(),apply.getProductId(),productStandardIds);
            //当多规格时计算范围
            EbShopProduct ebShopProduct = ebShopProductService.getByProductIdAndShopId(apply.getProductId() , apply.getShopId());
            ebShopProductService.updateRange(ebShopProduct,detailList);

        }

        redirectAttributes.addAttribute("code","1");
        return "redirect:"+ Global.getConfig("adminPath")+"/productPriceApply/applyList";
    }

}
