package com.jq.support.main.controller.shop;

import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.product.*;
import com.jq.support.model.shop.PmShopProductType;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.shop.PmShopProductTypeService;
import org.apache.http.protocol.HTTP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 门店商品价格修改申请
 */
@Controller
@RequestMapping("${adShopPath}/ebProductPriceApply")
public class ShopEbProductPriceApplyController {
    @Autowired
    private EbProductPriceRemarkService ebProductPriceRemarkService;
    @Autowired
    private EbProductPriceApplyService ebProductPriceApplyService;
    @Autowired
    private EbProductPriceItemService ebProductPriceItemService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private PmShopProductTypeService pmShopProductTypeService;
    @Autowired
    private PmProductPropertyStandardService pmProductPropertyStandardService;
    @Autowired
    private PmProductStandardDetailService pmProductStandardDetailService;
    @Autowired
    private EbShopProductService ebShopProductService;
    @Autowired
    private EbShopProductStandardDetailService ebShopProductStandardDetailService;
    @Autowired
    private EbShopChargingService ebShopChargingService;
    @Autowired
    private EbProductChargingService ebProductChargingService;

    /**
     * 导航到增加商品价格申请页面
     * @param ebProduct
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "toPriceApplyInsert")
    public String toPriceApplyInsert(EbProduct ebProduct, HttpServletRequest request,
                       HttpServletResponse response, Model model) {
        EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
        //查询当前商品
        ebProduct=ebProductService.getEbProductById(ebProduct.getProductId());
        model.addAttribute("ebProduct", ebProduct);

        if (ebProduct.getProductId() != null) {
            PmProductType productType = pmProductTypeService
                    .getSbProductType(ebProduct.getProductTypeId().toString());
            model.addAttribute("productType", productType);
            if (StringUtils.isNotBlank(ebProduct.getShopProTypeIdStr())) {
                ebProduct.getShopProTypeIdStr().split(",");
                PmShopProductType pmShopProductType = pmShopProductTypeService
                        .getpmPmShopProductType(ebProduct.getShopProTypeIdStr()
                                .split(",")[2]);
                model.addAttribute("pmShopProductType", pmShopProductType);

            }


            PmProductPropertyStandard pmProductPropertyStandard = pmProductPropertyStandardService
                    .getPmProductIdPropertyStandard(ebProduct.getProductId()
                            .toString());
            model.addAttribute("pmProductPropertyStandard",pmProductPropertyStandard);
            List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                    .getProductIdPmProductStandardDetail(ebProduct
                            .getProductId().toString());

            EbShopProduct ep = new EbShopProduct();
            ep.setProductId(ebProduct.getProductId());
            //获得当前登录的门店id
            ep.setShopId(ebUser.getShopId());
            EbShopProduct ebShopProduct = ebShopProductService.getByProductIdAndShopId(ep);
            model.addAttribute("ebShopProduct",ebShopProduct);

            //判断是否是多规格
            boolean isMoreStandar = true;
            if(pmProductStandardDetails == null || pmProductStandardDetails.size() == 0){
                isMoreStandar = false;
            }
            model.addAttribute("isMoreStandar",isMoreStandar);

            for(PmProductStandardDetail detail : pmProductStandardDetails){
                // 查询商家商品多规格关联信息
                List<EbShopProductStandardDetail> detailList = ebShopProductStandardDetailService.getByShopIdAndProductId(ebShopProduct.getShopId(), ebShopProduct.getProductId(),detail.getId()+"");
                if(detailList != null && detailList.size() > 0){
                    detail.setEbShopProductStandardDetail(detailList.get(0));
                }
            }

            model.addAttribute("detailList",pmProductStandardDetails);

        }

        return "modules/shop/priceApplyInsert";
    }


    /**
     * 导航到修改商品价格申请页面
     * @param apply
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "toPriceApplyUpdate")
    public String toPriceApplyUpdate(EbProductPriceApply apply, HttpServletRequest request,
                               HttpServletResponse response, Model model,Integer isChange) {
        model.addAttribute("isChange",isChange);

        apply = ebProductPriceApplyService.getById(apply.getId());
        List<EbProductPriceItem> itemList = ebProductPriceItemService.getByApplyId(apply.getId());
        List<EbProductPriceRemark> remarkList = ebProductPriceRemarkService.getByApplyId(apply.getId());

        model.addAttribute("apply",apply);
        model.addAttribute("remarkList",remarkList);
        model.addAttribute("itemList",itemList);

        return "modules/shop/priceApplyUpdate";
    }



    /**
     *增加价格申请
     * @param apply 门店商品价格申请实体类
     * @param detailIdArr   多规格的规格id ， 如果是单规格 为空
     * @param newPriceArr   修改后的价格 ， 单规格 ：商品修改后的价格   多规格：商品多规格修改后的价格
     * @param oldPriceArr   原本的价格 ， 单规格 ：空   多规格：商品多规格原本的价格
     * @param applyContent  申请的内容  ， 单规格 ：空   多规格：规格名称，如多糖，正常，大杯
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "insertPriceApply")
    public Map<String,String> insertPriceApply(EbProductPriceApply apply , Integer[] detailIdArr
            , Double[] newPriceArr, Double[] oldPriceArr , String[] applyContent, Double[] newMemberPriceArr,
                                               Double[] oldMemberPriceArr,  HttpServletRequest request){
        Map<String,String> map = new HashMap<String,String>();

        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        PmShopInfo pmShopInfo = pmShopInfoService.getById(ebUser.getShopId());
        EbProduct ebProduct = ebProductService.getEbProduct(apply.getProductId() + "");

        apply.setProductPic(ebProduct.getPrdouctImg());
        apply.setProductName(ebProduct.getProductName());
        apply.setApplyStatus(0);
        apply.setCreateTime(new Date());
        apply.setIsApply(0);
        apply.setShopId(pmShopInfo.getId());
        apply.setShopName(pmShopInfo.getShopName());
        apply.setShopAddress(pmShopInfo.getContactAddress());
//        apply.setApplyType(1);

        boolean result = ebProductPriceApplyService.insert(apply);

        if(!result){
            map.put("prompt","0");
            map.put("prompt",result ? "增加商品价格申请成功":"增加商品价格申请失败");
            return map;
        }

        //插入门店商品价格和加料价格修改申请明细表信息
        if(apply.getIsMoreDetail() == 0){   //单规格
            if(newPriceArr != null && newPriceArr.length != 0){
                apply.setNewPrice(newPriceArr[0]);
                apply.setNewMemberPrice(newMemberPriceArr[0]);
                result = ebProductPriceApplyService.update(apply);
            }
        }else{  //多规格
            if(newPriceArr.length != 0){
                List<EbProductPriceItem> itemList = new ArrayList<EbProductPriceItem>();
               for(int i = 0 ; i < detailIdArr.length ; i++){
                   EbProductPriceItem item = new EbProductPriceItem();
                   item.setNewPrice(newPriceArr[i]);
                   item.setApplyContent(applyContent[i]);
                   item.setApplyId(apply.getId());
                   item.setItemId(detailIdArr[i]);
                   item.setOldPrice(oldPriceArr[i]);
                   item.setNewMemberPrice(newMemberPriceArr[i]);
                   item.setOldMemberPrice(oldMemberPriceArr[i]);
                   itemList.add(item);
               }
                result = ebProductPriceItemService.batchInser(itemList);

            }
        }

        map.put("code",result ? "1":"0");
        map.put("prompt",result ? "增加商品价格申请成功":"增加商品价格申请失败");
        return map;
    }


    /**
     *修改价格申请
     * @param apply 门店商品价格申请实体类
     * @param detailIdArr   多规格的规格id ， 如果是单规格 为空
     * @param newPriceArr   修改后的价格 ， 单规格 ：商品修改后的价格   多规格：商品多规格修改后的价格
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updatePriceApply")
    public Map<String,String> updatePriceApply(EbProductPriceApply apply,Double[] newMemberPriceArr,
                                               Integer[] detailIdArr, Double[] newPriceArr){
        Map<String,String> map = new HashMap<String,String>();
        boolean reslut = false;

        if(apply == null || apply.getId() == null){
            map.put("code","0");
            return map;
        }

        reslut = ebProductPriceApplyService.update(apply);
        EbProductPriceApply oldApply = ebProductPriceApplyService.getById(apply.getId());

        //如果是多规格更新明细表
        if(oldApply.getIsMoreDetail() == 1){

            for (int i = 0; newPriceArr!= null && i < newPriceArr.length; i++) {
                EbProductPriceItem item = ebProductPriceItemService.getById(detailIdArr[i]);
                item.setNewPrice(newPriceArr[i]);
                item.setNewMemberPrice(newMemberPriceArr[i]);
                reslut = ebProductPriceItemService.update(item);

                if(!reslut){
                    break;
                }
            }
        }

        map.put("code",reslut?"1":"0");
        return map;

    }

    /**
     * 导航到门店申请列表
     * @param request
     * @param response
     * @param model
     * @param apply
     * @param startTime  开始时间
     * @param endTime    结束时间
     * @param prompt      提示
     * @return
     */
    @RequestMapping("applyList")
    public String applyList(HttpServletRequest request , HttpServletResponse response , Model model,
                            EbProductPriceApply apply , String startTime , String endTime,Integer prompt){
        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        PmShopInfo pmShopInfo = pmShopInfoService.getById(ebUser.getShopId());

        apply.setShopId(pmShopInfo.getId());

        model.addAttribute("apply",apply);
        model.addAttribute("startTime",startTime);
        model.addAttribute("endTime",endTime);
        if(prompt != null && prompt == 0){
            model.addAttribute("prompt","操作失败");
        }else{
            model.addAttribute("prompt","操作成功");
        }

        Page<EbProductPriceApply> page = ebProductPriceApplyService.getList(apply, new Page<EbProductPriceApply>(request, response), startTime, endTime);

        model.addAttribute("page",page);
        return "modules/shop/productPriceApplyList";
    }


    /**
     * 取消申请
     * @param apply
     * @return
     */
    @ResponseBody
    @RequestMapping("cancelApply")
    public Map<String,String> cancelApply(EbProductPriceApply apply){
        Map<String,String> map = new HashMap<String, String>();

        if(apply == null || apply.getId() == null){
            map.put("code","0");
            return map;
        }

        apply.setApplyStatus(4);
        boolean result = ebProductPriceApplyService.updateApplyStatus(apply);

        map.put("code",result?"1":"0");

        return map;
    }

}
