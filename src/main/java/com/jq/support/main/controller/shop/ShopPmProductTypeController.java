package com.jq.support.main.controller.shop;

import com.jq.support.common.persistence.Page;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 门店端的商品分类 controller
 */
@RequestMapping("${adShopPath}/shopPmProductType")
@Controller
public class ShopPmProductTypeController {
    @Autowired
    private PmProductTypeService pmProductTypeService;

    @RequestMapping(value = {"list"})
    public String list(HttpServletResponse response , HttpServletRequest request , Model model,
                       PmProductType pmProductType){
        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        Integer shopId = ebUser.getShopId();

        Page<PmProductType> page=pmProductTypeService.getPageList(new Page<PmProductType>(request, response),pmProductType,shopId);

        model.addAttribute("pmProductType",pmProductType);
        model.addAttribute("page",page);

        return "modules/shop/pmProductTypeList";
    }


}
