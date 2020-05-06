package com.jq.support.main.controller.shop;

import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.product.*;
import com.jq.support.model.shop.PmShopFreightTem;
import com.jq.support.model.shop.PmShopProductType;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.certificate.EbCertificateLocationService;
import com.jq.support.service.certificate.EbCertificateService;
import com.jq.support.service.certificate.EbCertificateUserService;
import com.jq.support.service.merchandise.mecontent.EbLabelService;
import com.jq.support.service.merchandise.mecontent.PmSysDistrictService;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.merchandise.shop.PmShopCooperTypeService;
import com.jq.support.service.merchandise.shop.PmShopFreightTemService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.shop.PmShopProductTypeService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.pay.PmLovePayDeployService;
import com.jq.support.service.utils.FormatUtil;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "${adShopPath}/ebproductshop/")
public class EbProductShopController {

    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private PmShopFreightTemService pmShopFreightTemService;
    @Autowired
    private PmProductPropertyStandardService pmProductPropertyStandardService;
    @Autowired
    private PmProductStandardDetailService pmProductStandardDetailService;
    @Autowired
    private PmShopProductTypeService pmShopProductTypeService;
    @Autowired
    private EbShopProductService ebShopProductService;
    @Autowired
    private EbShopProductStandardDetailService ebShopProductStandardDetailService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private EbProductChargingService ebProductChargingService;

    @RequestMapping("index")
    public String index(EbProduct ebProduct,String statrDate,String stopDate,String statrPrice,String stopPrice,HttpServletRequest request, HttpServletResponse response, Model model,Integer typeId,Integer isShow){
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");

        Page<PmProductType> typePage=pmProductTypeService.getPageList(new Page<PmProductType>(1, Integer.MAX_VALUE),new PmProductType(),ebUser.getShopId());
//        //获取第一个类型id
//        if(typeId == null && CollectionUtils.isNotEmpty(typePage.getList())){
//            typeId = typePage.getList().get(0).getId();
//        }

        List<Object> resultList = ebProductService.getResultListByShop(ebProduct.getProductName(), statrDate, stopDate, statrPrice, stopPrice, ebProduct.getPrdouctStatus(), ebUser.getShopId(), new Page<Object>(request, response),typeId);

        Page page = (Page) resultList.get(0);
        List<EbProduct> ebProductList = (List<EbProduct>) resultList.get(1);
        List<EbShopProduct> ebShopProductList = (List<EbShopProduct>) resultList.get(2);


        if(ebShopProductList != null && ebProductList.size() != 0){
            for (EbShopProduct ebShopPrdoduct : ebShopProductList) {
                PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebShopPrdoduct.getShopId() + "");
                ebShopPrdoduct.setShopName(pmShopInfo.getShopName());
            }
        }


        model.addAttribute("page",page);
        model.addAttribute("typeList",typePage.getList());
        model.addAttribute("ebProductList",ebProductList);
        model.addAttribute("typeId",typeId);
        model.addAttribute("isShow",isShow == null ? 0 : isShow);
        model.addAttribute("ebShopProductList",ebShopProductList);
        model.addAttribute("ebProduct",ebProduct);
        model.addAttribute("statrDate",statrDate);
        model.addAttribute("stopDate",stopDate);
        model.addAttribute("statrPrice",statrPrice);
        model.addAttribute("stopPrice",stopPrice);
        return "modules/shop/EbProductList";
    }

    @RequestMapping(value = "show")
    public String show(EbProduct ebProduct, HttpServletRequest request,
                       HttpServletResponse response, Model model) {
        EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
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

            if (ebProduct.getFreightType() != null) {
                if (ebProduct.getFreightType() == 2) {
                    if (ebProduct.getUserFreightTemp() != null
                            && ebProduct.getUserFreightTemp() == 1) {
                        if (ebProduct.getFreightTempId() != null) {
                            PmShopFreightTem pmShopFreightTem = pmShopFreightTemService
                                    .findid(ebProduct.getFreightTempId());
                            model.addAttribute("pmShopFreightTem",
                                    pmShopFreightTem);
                        }
                    }
                }
            }
            PmProductPropertyStandard pmProductPropertyStandard = pmProductPropertyStandardService
                    .getPmProductIdPropertyStandard(ebProduct.getProductId()
                            .toString());
            model.addAttribute("pmProductPropertyStandard",
                    pmProductPropertyStandard);
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


            List<EbProductCharging> chargingList = ebProductChargingService.findEbProductChargingByProductId(ebProduct.getProductId());
            model.addAttribute("chargingList",chargingList);


            Integer inventory = 0;

            //多规格，统计真正的库存
            if(isMoreStandar){
                for (PmProductStandardDetail detail:pmProductStandardDetails) {
                    if(detail == null || detail.getEbShopProductStandardDetail() == null){
                        continue;
                    }

                    inventory += detail.getEbShopProductStandardDetail().getDetailInventory();
                }

                ebShopProduct.setStoreNums(inventory);
            }
        }

        return "modules/shop/commodity-overview";
    }


    /**
     * 更新价格和库存
     * @param ebShopProduct
     * @return
     */
    @RequestMapping("updatePriceAndStoreNums")
    @ResponseBody
    public Map<String , String>  updatePriceAndStoreNums(EbShopProduct ebShopProduct,String newStoreNums){
        Map<String , String> map = new HashMap<String, String>();

        EbShopProduct oldEbShopProduct = ebShopProductService.getById(ebShopProduct.getId());
        if(oldEbShopProduct == null){
            map.put("code","0");
            map.put("msg","信息有误");
            return map;
        }

        Integer measuringType = oldEbShopProduct.getMeasuringType();
        Integer measuringUnit = oldEbShopProduct.getMeasuringUnit();
        //只有计量单位为公斤时，才可以输入小数
        if(String.valueOf(newStoreNums).indexOf('.')>=0){
            if(measuringType == null || measuringType ==1){
                map.put("msg","当前计量单位为件，库存不能为小数");
                map.put("code","1");
                return map;
            }

            if(measuringUnit!=null && measuringType == 2  && measuringUnit ==2){
                map.put("msg","当前计量单位为克，库存不能为小数");
                map.put("code","1");
                return map;
            }

        }

        //把库存先转成int
        if(measuringType !=null &&  measuringType==2) {
            if(measuringUnit != null){
                if(measuringUnit == 1){
                    ebShopProduct.setStoreNums((int)(Double.parseDouble(newStoreNums)*1000));
                }else if(measuringUnit == 2){
                    ebShopProduct.setStoreNums(Integer.parseInt(newStoreNums));
                }else if(measuringUnit == 3){
                    ebShopProduct.setStoreNums((int)(Double.parseDouble(newStoreNums)*500));
                }
            }

        }else{
            ebShopProduct.setStoreNums(Integer.parseInt(newStoreNums));
        }

        //更新商品门店关联表
        boolean result = ebShopProductService.updatePriceAndStoreNums(ebShopProduct);
        if(!result){
            map.put("code","0");
            map.put("msg","修改失败");
        }else{
            map.put("code","1");
            map.put("msg","修改成功");
        }

//        更新商品表
//        EbProduct ebProduct = new EbProduct();
//        ebProduct.setProductId(ebShopProduct.getProductId());
//        ebProduct.setSellPrice(ebShopProduct.getSellPrice());
//        ebProduct.setMemberPrice(ebShopProduct.getMemberPrice());
//        ebProduct.setStoreNums(ebShopProduct.getStoreNums());
//        result = ebProductService.updatePriceAndStoreNums(ebProduct);

//        if(!result) {
//            map.put("prompt","fail");
//
//        }else{
//            map.put("prompt","success");
//        }

        return map;
    }

    /**
     * 更新多规格的信息
     * @param detail
     * @return
     */
    @RequestMapping("updateStandardDetail")
    @ResponseBody
    public Map<String , String> updateStandardDetail(EbShopProductStandardDetail detail , Integer productShopId){
        Map<String , String> map = new HashMap<String, String>();


        //更新商家商品多规格关联信息表
        boolean flag = ebShopProductStandardDetailService.update(detail);
        if(!flag){
            map.put("prompt","fail");
            return map;
        }

        List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                .getProductIdPmProductStandardDetail(detail.getProductId().toString());

        String detailIds = FormatUtil.getFieldAllValue(pmProductStandardDetails, "id");

        //查询当前商品的所有规格
        List<EbShopProductStandardDetail> detailList = ebShopProductStandardDetailService.getByShopIdAndProductId(detail.getShopId(), detail.getProductId(),detailIds);

        //统计总库存
        Integer  storeCount = 0;
        for(EbShopProductStandardDetail ebShopProductStandardDetail : detailList){
            storeCount += ebShopProductStandardDetail.getDetailInventory();
        }

        //更新商品门店关联表
        EbShopProduct ebShopProduct = new EbShopProduct();
        ebShopProduct.setId(productShopId);
        ebShopProduct.setStoreNums(storeCount);
//        rangeArr  0 会员价范围  1 销售价范围
        boolean result = ebShopProductService.updatePriceAndStoreNums(ebShopProduct);
        if(!result){
            map.put("prompt","fail");
            return map;
        }else{
            map.put("prompt","success");
        }

        map.put("storeNum",storeCount+"");

        return map;
    }
}
