package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmProductTypeSpertAttr;
import com.jq.support.model.product.PmProductTypeSpertAttrValue;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.PmProductTypeSpertAttrService;
import com.jq.support.service.merchandise.product.PmProductTypeSpertAttrValueService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.utils.SysUserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Date;


/**
 * 规格明细
 *
 * @author Administrator
 */

@Controller
@RequestMapping(value = "${adShopPath}/PmProductTypeSpertAttrValue")
public class ShopPmProductTypeSpertAttrValueController extends BaseController {
    @Autowired
    private PmProductTypeSpertAttrValueService pmProductTypeSpertAttrValueService;
    @Autowired
    private PmProductTypeSpertAttrService pmProductTypeSpertAttrService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    private static String domainurl = Global.getConfig("domainurl");
    private static String innerImgPartPath = "src=\"/uploads/images/";
    private static String innerImgFullPath = "src=\"" + domainurl + "/uploads/images/";

    @ModelAttribute
    public PmProductTypeSpertAttrValue get(@RequestParam(required = false) String id) {
        if (org.apache.commons.lang3.StringUtils.isNotBlank(id)) {
            return pmProductTypeSpertAttrValueService.getSbProductTypeSpertAttrValue(id);
        } else {
            return new PmProductTypeSpertAttrValue();
        }
    }

    @RequestMapping(value = "list")
    public String list(String spertAttrId, String spertAttrValue, String spertAttrType, HttpServletRequest request, HttpServletResponse response, Model model) {
        PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        pmProductTypeSpertAttrValue.setShopId(ebUser.getShopId());
        if (StringUtils.isNotBlank(spertAttrId)) {
            pmProductTypeSpertAttrValue.setSpertAttrId(Integer.parseInt(spertAttrId));
        }
        if (StringUtils.isNotBlank(spertAttrValue)) {
            pmProductTypeSpertAttrValue.setSpertAttrValue(spertAttrValue);
        }
        model.addAttribute("page", pmProductTypeSpertAttrValueService.getPageList(new Page<PmProductTypeSpertAttrValue>(request, response), pmProductTypeSpertAttrValue));
        model.addAttribute("sbProductTypeSpertAttrValue", pmProductTypeSpertAttrValue);
        model.addAttribute("spertAttrId", spertAttrId);
        return "modules/shop/spertattr/SbProductTypeSpertAttrValueList";
    }


    @RequestMapping(value = "from")
    public String form(PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("sbProductTypeSpertAttrValue", pmProductTypeSpertAttrValue);
        PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(pmProductTypeSpertAttrValue.getSpertAttrId().toString());
        model.addAttribute("sbProductTypeSpertAttr", pmProductTypeSpertAttr);
        model.addAttribute("spertAttrId", pmProductTypeSpertAttr.getId());
        return "modules/shop/spertattr/sbProductTypeSpertAttrValueFrom";
    }

    @RequiresPermissions("merchandise:PmProductTypeSpertAttrValue:edit")
    @RequestMapping(value = "save")
    public String save(PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebUser.getShopId()+"");
        if (pmProductTypeSpertAttrValue.getId() == null) {
            pmProductTypeSpertAttrValue.setShopId(pmShopInfo.getId());
            pmProductTypeSpertAttrValue.setCreateUser(pmShopInfo.getShopName());
            pmProductTypeSpertAttrValue.setCreateTime(new Date());
        } else {
            pmProductTypeSpertAttrValue.setModifyUser(pmShopInfo.getShopName());
            pmProductTypeSpertAttrValue.setModifyTime(new Date());
        }

        pmProductTypeSpertAttrValueService.save(pmProductTypeSpertAttrValue);
        addMessage(redirectAttributes, "保存成功");
        return "redirect:" + Global.getConfig("adShopPath") + "/PmProductTypeSpertAttrValue/list?spertAttrId=" + pmProductTypeSpertAttrValue.getSpertAttrId();
    }

    @RequiresPermissions("merchandise:PmProductTypeSpertAttrValue:edit")
    @RequestMapping(value = "delete")
    public String delete(String id, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        PmProductTypeSpertAttrValue productTypeSpertAttrValue = pmProductTypeSpertAttrValueService.getSbProductTypeSpertAttrValue(id);
        pmProductTypeSpertAttrValueService.delete(productTypeSpertAttrValue);
        addMessage(redirectAttributes, "保存成功");
        return "redirect:" + Global.getConfig("adShopPath") + "/PmProductTypeSpertAttrValue/list?spertAttrId=" + productTypeSpertAttrValue.getSpertAttrId();
    }


    /**
     * 创建图片存放目录
     */
    private void createPicFold(HttpServletRequest request) {
        String root = request.getSession().getServletContext().getRealPath("/");
        StringBuffer folder = new StringBuffer(root);
        folder.append("uploads");
        folder.append(File.separator);
        // ===========集群文件处理 start===============
        String wfsName = Global.getConfig("wfsName");
        if (StringUtils.isNotBlank(wfsName)) {
            folder.append(wfsName);
            folder.append(File.separator);
        }
        // ===========集群文件字段处理 end===============
        folder.append("000000");
        folder.append(File.separator);
        folder.append("images");
        folder.append(File.separator);
        folder.append("merchandise");
        folder.append(File.separator);
        folder.append("PmProductTypeSpertAttrValue");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }


}
