package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmProductTypeSpertAttr;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.merchandise.product.PmProductTypeSpertAttrService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * 商家规格属性管理Controller
 *
 * @author Administrator
 */


@Controller
@RequestMapping(value = "${adShopPath}/PmProductTypeSpertAttr")
public class ShopPmProductTypeSpertAttrController extends BaseController {
    @Autowired
    private PmProductTypeSpertAttrService pmProductTypeSpertAttrService;
    @Autowired
    private PmProductTypeService productTypeService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    private static String domainurl = Global.getConfig("domainurl");

    @ModelAttribute
    public PmProductTypeSpertAttr get(@RequestParam(required = false) String id) {
        if (org.apache.commons.lang3.StringUtils.isNotBlank(id)) {
            return pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(id);
        } else {
            return new PmProductTypeSpertAttr();
        }
    }

    @RequestMapping(value = "tree")
    public String tree(HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String shopId=ebUser.getShopId()+"";
        List<PmProductType> allProductTypes = new ArrayList<PmProductType>();
        List<PmProductType> productTypes = productTypeService.getShopProductTypeList(shopId);
        List<PmProductType> productTypesTwo = null, productTypesThree = null;
        if (productTypes != null && productTypes.size() > 0)
            allProductTypes.addAll(productTypes);
        for (PmProductType pmProductType : productTypes) {
            productTypesTwo = productTypeService.getShopProductTypeList(shopId, pmProductType.getId() + "");
            if (productTypesTwo != null && productTypesTwo.size() > 0) {
                allProductTypes.addAll(productTypesTwo);
                for (PmProductType pmProductType1 : productTypesTwo) {
                    productTypesThree = productTypeService.getShopProductTypeList(shopId, pmProductType1.getId() + "");
                    if (productTypesThree != null && productTypesThree.size() > 0) {
                        allProductTypes.addAll(productTypesThree);
                    }
                }
            }
        }

        model.addAttribute("productTypes", allProductTypes);
        String url = domainurl + Global.getConfig("adShopPath") + "/PmProductTypeSpertAttr/list?productTypeId=";
        model.addAttribute("url", url);
        return "modules/shop/spertattr/sbProductTypeTree";
    }

    @RequestMapping(value = {"show", ""})
    public String show(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "modules/shop/spertattr/SbProductTypeSpertAttrAll";
    }

    @RequestMapping(value = "list")
    public String list(String productTypeId, String spertAttrName, String spertAttrType, HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmProductTypeSpertAttr pmProductTypeSpertAttr = new PmProductTypeSpertAttr();
        pmProductTypeSpertAttr.setSpertAttrName(spertAttrName);
        if (StringUtils.isNotBlank(productTypeId)) {
            PmProductType pmProductType = productTypeService.getSbProductType(productTypeId);
            if (pmProductType != null) {
                if (pmProductType.getLevel() == 3 || pmProductType.getLevel() == 2) {
                    model.addAttribute("fulte", "1");
                    pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(productTypeId));
                } else {
                    pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(productTypeId));
                    model.addAttribute("fulte", "0");
                }
            } else {
                pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(productTypeId));
                model.addAttribute("fulte", "0");
            }

        }
        if (StringUtils.isNotBlank(spertAttrType)) {
            pmProductTypeSpertAttr.setSpertAttrType(Integer.parseInt(spertAttrType));
        }
        pmProductTypeSpertAttr.setIsPublic(-1);
        pmProductTypeSpertAttr.setShopId(ebUser.getShopId());
        model.addAttribute("page", pmProductTypeSpertAttrService.getPageSbProductTypeSpertAttrList(new Page<PmProductTypeSpertAttr>(request, response), pmProductTypeSpertAttr));
        model.addAttribute("sbProductTypeSpertAttr", pmProductTypeSpertAttr);
        model.addAttribute("productTypeId", productTypeId);
        model.addAttribute("shopId", ebUser.getShopId());
        return "modules/shop/spertattr/SbProductTypeSpertAttrList";
    }

    @RequestMapping(value = "checkName")
    @ResponseBody
    public boolean checkName(PmProductTypeSpertAttr pmProductTypeSpertAttr, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<PmProductTypeSpertAttr> list = pmProductTypeSpertAttrService.checkname(pmProductTypeSpertAttr);
        if (CollectionUtils.isNotEmpty(list)) {
            return false;
        }
        return true;
    }

    @RequestMapping(value = "from")
    public String from(PmProductTypeSpertAttr pmProductTypeSpertAttr, HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        model.addAttribute("sbProductTypeSpertAttr", pmProductTypeSpertAttr);
        PmProductType pmProductType = productTypeService.getSbProductType(pmProductTypeSpertAttr.getProductTypeId().toString());
        model.addAttribute("sbProductType", pmProductType);
        model.addAttribute("productTypeId", pmProductType.getId());
        model.addAttribute("shopId", ebUser.getShopId());
        return "modules/shop/spertattr/SbProductTypeSpertAttrFrom";
    }

    @RequestMapping(value = "save")
    public String save(PmProductTypeSpertAttr pmProductTypeSpertAttr, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebUser.getShopId()+"");

        if (pmProductTypeSpertAttr.getId() == null) {
            pmProductTypeSpertAttr.setCreateUser(pmShopInfo.getShopName());
            pmProductTypeSpertAttr.setCreateTime(new Date());
            pmProductTypeSpertAttr.setShopId(pmShopInfo.getId());
            pmProductTypeSpertAttr.setShopName(pmShopInfo.getShopName());
            pmProductTypeSpertAttr.setIsPublic(1);
        } else {
            pmProductTypeSpertAttr.setModifyUser(pmShopInfo.getShopName());
            pmProductTypeSpertAttr.setModifyTime(new Date());
        }
        if(pmProductTypeSpertAttr.getShopId()!=null&&pmProductTypeSpertAttr.getShopId().toString().equals(ebUser.getShopId().toString())) {
            pmProductTypeSpertAttrService.save(pmProductTypeSpertAttr);
            addMessage(redirectAttributes, "保存成功");
        }else{
            addMessage(redirectAttributes, "无权限编辑");
        }

        return "redirect:" + Global.getConfig("adShopPath") + "/PmProductTypeSpertAttr/list?productTypeId=" + pmProductTypeSpertAttr.getProductTypeId();
    }

    @RequestMapping(value = "delete")
    public String delete(String id, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(id);
        pmProductTypeSpertAttr.setIsDel(1);
        pmProductTypeSpertAttrService.save(pmProductTypeSpertAttr);
        //    	pmProductTypeSpertAttrService.delete(pmProductTypeSpertAttr);
        addMessage(redirectAttributes, "保存成功");
        return "redirect:" + Global.getConfig("adShopPath") + "/PmProductTypeSpertAttr/list?productTypeId=" + pmProductTypeSpertAttr.getProductTypeId();
    }


}
