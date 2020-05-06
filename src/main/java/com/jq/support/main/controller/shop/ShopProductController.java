package com.jq.support.main.controller.shop;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jq.support.model.certificate.EbCertificate;
import com.jq.support.model.certificate.EbCertificateApplyRemark;
import com.jq.support.model.certificate.EbCertificateLocation;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.product.*;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.certificate.EbCertificateApplyRemarkService;
import com.jq.support.service.certificate.EbCertificateLocationService;
import com.jq.support.service.certificate.EbCertificateService;
import com.jq.support.service.certificate.EbCertificateUserService;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.utils.*;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.solr.common.util.DateUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.merchandise.utilentity.SpreIdName;
import com.jq.support.model.pay.PmLovePayDeploy;
import com.jq.support.model.region.PmSysDistrict;
import com.jq.support.model.shop.PmShopProductType;
import com.jq.support.model.shop.PmShopShippingMethod;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmSensitiveWordsFilter;
import com.jq.support.service.merchandise.mecontent.PmSensitiveWordsFilterService;
import com.jq.support.service.merchandise.mecontent.PmServiceProtocolService;
import com.jq.support.service.merchandise.mecontent.PmSysDistrictService;
import com.jq.support.service.merchandise.shop.PmShopCooperTypeService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.shop.PmShopProductTypeService;
import com.jq.support.service.merchandise.shop.PmShopShippingMethodService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.pay.PmLovePayDeployService;


@Controller
@RequestMapping(value = "${adShopPath}/product")
public class ShopProductController extends BaseController {
    private static String uploads = "uploads";
    private static String ymd = "";
    private static String domainurl = Global.getConfig("domainurl");
    @Autowired
    private PmServiceProtocolService pmServiceProtocolService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private PmProductTypeSpertAttrService pmProductTypeSpertAttrService;
    @Autowired
    private PmProductTypeSpertAttrValueService productTypeSpertAttrValueService;
    @Autowired
    private PmProductTypeBrandService pmProductTypeBrandService;
    @Autowired
    private PmShopProductTypeService pmShopProductTypeService;
    @Autowired
    private PmSysDistrictService pmSysDistrictService;
    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private PmProductPropertyStandardService pmProductPropertyStandardService;
    @Autowired
    private PmProductStandardDetailService pmProductStandardDetailService;
    @Autowired
    private PmSensitiveWordsFilterService pmSensitiveWordsFilterService;
    @Autowired
    private PmShopShippingMethodService pmShopShippingMethodService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmLovePayDeployService pmLovePayDeployService;
    @Autowired
    private PmShopCooperTypeService pmShopCooperTypeService;
    @Autowired
    private EbCertificateService ebCertificateService;//优惠卷服务
    @Autowired
    private EbCertificateUserService ebCertificateUserService;
    @Autowired
    private EbCertificateLocationService ebCertificateLocationService;
    @Autowired
    private EbMessageService ebMessageService;
    @Autowired
    private EbUserService ebUserService;
    @Autowired
    private EbMessageUserService messageInfoUserService;
    @Autowired
    private EbProductChargingItemService ebProductChargingItemService;
    @Autowired
    private EbShopProductService ebShopProductService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private EbShoppingcartService ebShoppingcartService;
    @Autowired
    private EbCertificateApplyRemarkService ebCertificateApplyRemarkService;
    @Autowired
    private EbShopProductStandardDetailService ebShopProductStandardDetailService;
    /**
     * 查询一级规格
     */
    @ResponseBody
    @RequestMapping(value = "classOne")
    public List classOne(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser shopuser = (EbUser)request.getSession().getAttribute("shopuser");
        Page<PmProductType> page = pmProductTypeService.getPageList(new Page<PmProductType>(1, Integer.MAX_VALUE),new PmProductType(),shopuser.getShopId());

        return page.getList();
    }

    @RequestMapping(value = "/eateSbscType")
    public String eateSbscType(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String podateType = "";
        String statrDate = "";
        String stopDate = "";
        String priceType = "";
        String turn = request.getParameter("turn");
        String statrPrice = request.getParameter("statrPrice");
        String stopPrice = request.getParameter("stopPrice");
        String productName = request.getParameter("productName");
        String barCode = request.getParameter("barCode");
        String shopTypeId = request.getParameter("shopTypeId");
        String prdouctStatus = request.getParameter("prdouctStatus");
        String storeNums = request.getParameter("storeNums");
        EbProduct ebProduct = new EbProduct();
        ebProduct.setShopId(ebUser.getShopId());
        ebProduct.setProductName(productName);
        ebProduct.setBarCode(barCode);
        if (StringUtils.isNotBlank(prdouctStatus)) {
            ebProduct.setPrdouctStatus(Integer.parseInt(prdouctStatus));
        }
        if (StringUtils.isNotBlank(shopTypeId)) {
            ebProduct.setShopProTypeIdStr(shopTypeId);
        }
        if (StringUtils.isNotBlank(storeNums)) {
            ebProduct.setStoreNums(Integer.parseInt(storeNums));
        }
        String productTypeParentId = request.getParameter("productTypeParentId");
        if (StringUtils.isNotBlank(productTypeParentId)) {
            ebProduct.setProductTypeParentId(Integer.parseInt(productTypeParentId));
        }
        Page<EbProduct> page = ebProductService.getEbProductList1(null, ebProduct, new Page<EbProduct>(request, response), podateType, statrDate, stopDate, "2", statrPrice, stopPrice, null);
        for (EbProduct ebProduct2 : page.getList()) {
            if (StringUtils.isNotBlank(ebProduct2.getShopProTypeIdStr())) {
                String shopProTypeIdStr[] = ebProduct2.getShopProTypeIdStr().split(",");
                if (shopProTypeIdStr.length > 2) {
                    if (StringUtils.isNotBlank(shopProTypeIdStr[2])) {
                        PmShopProductType shopProductType = pmShopProductTypeService.getpmPmShopProductType(shopProTypeIdStr[2]);
                        ebProduct2.setShopProductType(shopProductType);
                    }
                }
            }
        }
        PmShopProductType pmShopProductType = new PmShopProductType();
        pmShopProductType.setShopId(ebUser.getShopId());
        pmShopProductType.setLevel(1);
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService.getList(pmShopProductType);
        for (PmShopProductType pmShopProductType2 : pmShopProductTypes) {
            PmShopProductType pmShopProductType3 = new PmShopProductType();
            pmShopProductType3.setShopId(ebUser.getShopId());
            pmShopProductType3.setParentId(pmShopProductType2.getId());
            List<PmShopProductType> pmShopProductTypes2 = pmShopProductTypeService.getList(pmShopProductType3);
            pmShopProductType2.setPmShopProductTypes(pmShopProductTypes2);
        }
        model.addAttribute("pmShopProductTypes", pmShopProductTypes);
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("page", page);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("prdouctStatus", prdouctStatus);
        model.addAttribute("turn", turn);
        return "modules/shop/batch-manage";
    }

    /**
     * 促销活动
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/promotionlist")
    public String promotionlist(
            HttpServletRequest request, HttpServletResponse response,
            Model model) {
        EbCertificate ebCertificate=new EbCertificate();
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String searchType=request.getParameter("searchType");
        String searchCertificateName=request.getParameter("searchCertificateName");
        String searchStartDate=request.getParameter("searchStartDate");
        String searchApplyStatus=request.getParameter("searchApplyStatus");
        String searchEndDate=request.getParameter("searchEndDate");
        String groupCertificateNum=request.getParameter("groupCertificateNum");

        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");

        Page rPage=new Page<EbCertificate>(request, response);
        if(StringUtil.isNotBlank(pageNo)&&StringUtil.isNotBlank(pageSize)){
            rPage.setPageNo(Integer.parseInt(pageNo));
            rPage.setPageSize(Integer.parseInt(pageSize));
        }
        if(StringUtil.isNotBlank(searchType))
            ebCertificate.setType(Integer.parseInt(searchType));
        if(StringUtil.isNotBlank(searchCertificateName))
            ebCertificate.setCertificateName(searchCertificateName);
        if(StringUtil.isNotBlank(groupCertificateNum))
            ebCertificate.setGroupCertificateNum(Integer.valueOf(groupCertificateNum));

        ebCertificate.setShopTypeId(ebUser.getShopId() + "");
        ebCertificate.setShopId(ebUser.getShopId());
        ebCertificate.setCertificateType(1);//促销
        ebCertificate.setShopType(3);//查询所有门店或者指定门店中有这个门店的情况
        Page<EbCertificate> page = ebCertificateService.getShopCertificateList(ebCertificate,
                rPage, searchStartDate, searchEndDate, null);
        for (EbCertificate certificate : page.getList()) {
            if (certificate.getProductType() != null && certificate.getProductType() == 1) {
                certificate.setProductInfos(ebProductService.getProductNameByIds(certificate.getProductTypeId()));
            }
            if (certificate.getShopType() != null && certificate.getShopType() == 1) {
                certificate.setShopInfos(pmShopInfoService.getShopInfoByIds(certificate.getShopTypeId()));
            }

            //判断当前是否可用
            certificate.setAvailable(ebCertificateService.promotionIsAvailable(certificate));
            List<EbCertificateApplyRemark> remarkList = ebCertificateApplyRemarkService.getRemarkByApplyId(certificate.getCertificateId());
            if(CollectionUtils.isNotEmpty(remarkList)){
                ebCertificate.setCheckRemark(remarkList.get(0).getApplyRemark());
            }

            if(StringUtils.isNotBlank(ebCertificate.getProductTypeId())){
                String names = ebProductService.getProductNameByIds(ebCertificate.getProductTypeId());
                ebCertificate.setProductInfos(names);
            }

        }
        model.addAttribute("page", page);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchApplyStatus", searchApplyStatus);
        model.addAttribute("searchCertificateName", searchCertificateName);
        model.addAttribute("searchStartDate", searchStartDate);
        model.addAttribute("searchEndDate", searchEndDate);
        model.addAttribute("groupCertificateNum", groupCertificateNum);

        return "modules/shop/promotionlist";
    }

    /**
     * 优惠卷管理
     *
     * @param ebCertificate
     * @param request
     * @param response
     * @param model
     * @param msg
     * @param startDate
     * @param endDate
     * @return
     */
    @RequestMapping(value = "/shopCertificatelist")
    public String getCertificatelist(EbCertificate ebCertificate,
                                     HttpServletRequest request, HttpServletResponse response,
                                     Model model, @ModelAttribute("msg") String msg, String startDate,
                                     String endDate) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        ebCertificate.setShopTypeId(ebUser.getShopId() + "");
        ebCertificate.setShopId(ebUser.getShopId());
        Page<EbCertificate> page = ebCertificateService.getShopCertificateList(ebCertificate,
                new Page<EbCertificate>(request, response), startDate, endDate, null);
        for (EbCertificate certificate : page.getList()) {
            if (certificate.getProductType() != null && certificate.getProductType() == 1) {
                certificate.setProductInfos(ebProductService.getProductNameByIds(certificate.getProductTypeId()));
            }
            if (certificate.getShopType() != null && certificate.getShopType() == 1) {
                certificate.setShopInfos(pmShopInfoService.getShopInfoByIds(certificate.getShopTypeId()));
            }

        }
        model.addAttribute("page", page);
        model.addAttribute("msg", msg);
        return "modules/shop/shopCertificatelist";
    }

    /**
     * 更新是否可用
     * @param id
     * @param enableSys
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateEnabledSys")
    public Map<String,String> updateEnabledSys(Integer id , Integer enableSys){
        Map<String,String> map = new HashMap<String, String>();

        if(id == null || enableSys == null){
            map.put("code","00");
            map.put("msg","传递参数错误！");
            return map;
        }

        boolean result = ebCertificateService.setEbCertificateEnabled(id,enableSys,"");
        if(!result) {
            map.put("code","00");
            map.put("msg","更新失败！");
        }else{
            map.put("code","01");
            map.put("msg","更新成功！");
        }


        return map;
    }

    /**
     * 新增优惠券页面
     *
     * @param request
     * @param response
     * @param model
     * @param msg
     * @return
     */
    @RequestMapping(value = "/addcertificate")
    public String addCertificate(HttpServletRequest request, HttpServletResponse response,
                                 Model model, @ModelAttribute("msg") String msg,
                                 @ModelAttribute("type") String type) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId() + "");
        model.addAttribute("msg", msg);
        String certificateName = request.getParameter("certificateName");
        String id = request.getParameter("id");
        String flag = request.getParameter("flag");
        if (StringUtils.isNotBlank(id)) {
            EbCertificate ebCertificate2 = ebCertificateService
                    .getEbCertificateById(Integer.parseInt(id));
            String remark = ebCertificate2.getEnabledRemarkSys();
            model.addAttribute("ebCertificate", ebCertificate2);
            model.addAttribute("remarksys", remark);

        }
        List<EbCertificateLocation> ebCertificateLocations = ebCertificateLocationService.getCertificateslocation();
        EbProduct ebProduct = new EbProduct();
        Page<EbProduct> page = ebProductService.getEbProductNoUserList(
                ebProduct, new Page<EbProduct>(request, response), "", "", "",
                "", "", "", "", "");
        model.addAttribute("pmShopInfo", pmShopInfo);
        model.addAttribute("page", page);
        model.addAttribute("flag", flag);
        model.addAttribute("type", type);
        model.addAttribute("ebCertificateLocations", ebCertificateLocations);
        return "modules/shop/shopAddEbCertificate";
    }

    /**
     * 新增促销活动页面
     *
     * @param request
     * @param response
     * @param model
     * @param msg
     * @return
     */
    @RequestMapping(value = "/addpromotion")
    public String addpromotion(HttpServletRequest request, HttpServletResponse response,
                               Model model, @ModelAttribute("msg") String msg,
                               @ModelAttribute("type") String type) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        return "modules/shop/addpromotion";
    }

    /**
     * 新增促销活动
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addPromotion")
    public Map addPromotion(HttpServletRequest request,
                            HttpServletResponse response, Model model) throws ParseException {
        EbCertificate ebCertificate = new EbCertificate();
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        Map<String, Object> map = new HashMap<String, Object>();//错误信息
        String certificateId=request.getParameter("certificateId");
        String promotionType=request.getParameter("promotionType");
        String type=request.getParameter("type");
        String certificateName=request.getParameter("certificateName");
        String provinceOutFullFreight=request.getParameter("provinceOutFullFreight");
        String amount=request.getParameter("amount");
        String banner=request.getParameter("banner");
        String certificateStartDate=request.getParameter("certificateStartDate");
        String certificateEndDate=request.getParameter("certificateEndDate");
        String remark=request.getParameter("remark");
        String productIds=request.getParameter("productIds");
        String groupCertificateNum=request.getParameter("groupCertificateNum");

        if(StringUtil.isBlank(promotionType)){
            map.put("code","01");
            map.put("msg","促销类型不能为空");
        }else if("1".equals(promotionType)&&(StringUtil.isBlank(type)||(!"1".equals(type)&&!"3".equals(type)))){
            map.put("code","01");
            map.put("msg","促销方式不能为空");
        }else if(StringUtil.isBlank(certificateName)){
            map.put("code","01");
            map.put("msg","促销名称不能为空");
        }else if(StringUtil.isBlank(provinceOutFullFreight)){
            map.put("code","01");
            map.put("msg","满减金额不能为空");
        }else if(Double.parseDouble(provinceOutFullFreight)<0){
            map.put("code","01");
            map.put("msg","满减金额需要是数值，并且需要大于或等于0");
        }else if((("1".equals(promotionType)&& "3".equals(type))||("2".equals(promotionType)))&&StringUtil.isBlank(amount)){
            map.put("code","01");
            map.put("msg","折扣不能为空");
        }else if("1".equals(promotionType)&&StringUtil.isBlank(groupCertificateNum)){
            map.put("code","01");
            map.put("msg","优惠商品数不能为空");
        }else if((("1".equals(promotionType)&&"3".equals(type))||"2".equals(promotionType))&&(Double.parseDouble(amount)<0||Double.parseDouble(amount)>10)){
            map.put("code","01");
            map.put("msg","折扣需要是数值，并且需要大于0且小于等于10");
        }else if(("1".equals(promotionType)&&"1".equals(type))&&StringUtil.isBlank(amount)){
            map.put("code","01");
            map.put("msg","优惠金额不能为空");
        }else if(("1".equals(promotionType)&&"1".equals(type))&&(Double.parseDouble(amount)<=0||Double.parseDouble(amount)>Double.parseDouble(provinceOutFullFreight))){
            map.put("code","01");
            map.put("msg","优惠金额需要是数值，并且需要大于等于0且小于满减金额");
        }else if (StringUtil.isBlank(certificateStartDate)) {
            map.put("code", "01");
            map.put("msg", "开始日期不能为空");
        }else if (StringUtil.isBlank(certificateEndDate)) {
            map.put("code", "01");
            map.put("msg", "结束日期不能为空");
        }else {
            if(StringUtil.isNotBlank(certificateId)){
                ebCertificate=ebCertificateService.getEbCertificateById(Integer.parseInt(certificateId));
            }
            ebCertificate.setPromotionType(Integer.parseInt(promotionType));
            if("2".equals(promotionType)){//第二件打折
                ebCertificate.setType(5);
            }else if(ebCertificate.getPromotionType()==3){ //团购
                ebCertificate.setType(6);
            }else {
                ebCertificate.setType(Integer.parseInt(type));
            }
            if(StringUtils.isNotBlank(productIds)){
                ebCertificate.setProductType(1);
                ebCertificate.setProductTypeId(productIds);
            }else{
                ebCertificate.setProductType(3);
            }
            if(StringUtil.isNotBlank(groupCertificateNum)){
                ebCertificate.setGroupCertificateNum(Integer.parseInt(groupCertificateNum));
            }

            ebCertificate.setRemark(remark);
            ebCertificate.setCertificateName(certificateName);
            ebCertificate.setProvinceOutFullFreight(Double.parseDouble(provinceOutFullFreight));
            ebCertificate.setAmount(Double.parseDouble(amount));
            ebCertificate.setBanner(banner);
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            ebCertificate.setCertificateStartDate(simpleDateFormat.parse(certificateStartDate));
            ebCertificate.setCertificateEndDate(simpleDateFormat.parse(certificateEndDate));
            ebCertificate.setSendTime(new Date());
            ebCertificate.setEnabledSys(0);
            ebCertificate.setShopTypeId(ebUser.getShopId() + "");
            ebCertificate.setShopType(1);
            ebCertificate.setShopId(ebUser.getShopId());
            ebCertificate.setCreateTime(new Date());
            ebCertificate.setDelflag(0);
            ebCertificate.setCertificateType(1);//类型：0、优惠券 1、促销活动
            ebCertificate.setIsapply(2);//提交申请
            ebCertificate.setApplyStatus(0);

            ebCertificateService.save(ebCertificate);
            map.put("code", "00");
            map.put("msg", "提交申请成功，请耐心等待平台审核");
        }
        return map;
    }
    /**
     * 取消申请促销
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("update")
    public String update(HttpServletRequest request, HttpServletResponse response, Model model){
        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");
        String certificateId=request.getParameter("certificateId");
        EbCertificate ebCertificate=ebCertificateService.getEbCertificateById(Integer.parseInt(certificateId));
        ebCertificate.setApplyStatus(3);
        ebCertificateService.save(ebCertificate);
        return "redirect:" + Global.getConfig("adShopPath") + "/product/promotionlist?pageNo="+pageNo+"&pageSize="+pageSize;
    }

    /**
     * 根据促销活动的id查询回复信息
     * @param applyId
     * @return
     */
    @ResponseBody
    @RequestMapping("getPromotionRemarkById")
    public Map<String , Object> getPromotionRemarkById(Integer applyId){
        List<EbCertificateApplyRemark> list = ebCertificateApplyRemarkService.getRemarkByApplyId(applyId);

        Map<String , Object > map = new HashMap<String, Object>();
        map.put("code",CollectionUtils.isNotEmpty(list) ? "01":"00");
        map.put("data",list);

        return map;
    }


    /**
     * 新增优惠券
     *
     * @param ebCertificate
     * @param redirectAttributes
     * @param request
     * @param response
     * @param model
     * @param startDate
     * @param endDate
     * @param sendtime
     * @return
     */
    @RequestMapping(value = "/addcertificateJson")
    public String addCertificateJson(EbCertificate ebCertificate,
                                     RedirectAttributes redirectAttributes, HttpServletRequest request,
                                     HttpServletResponse response, Model model, Date startDate,
                                     Date endDate, Date sendtime) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        Map<String, Object> map = new HashMap<String, Object>();


        if (ebCertificate.getCertificateId() == null) {
            ebCertificate.setEnabledSys(0);
            ebCertificate.setShopTypeId(ebUser.getShopId() + "");
            ebCertificate.setShopId(ebUser.getShopId());
            map = ebCertificateService.addEbCertificate(ebCertificate, 1);
            ebCertificateService.save(ebCertificate);
        } else {
            String enabledSysRemark = request.getParameter("enabledSysRemark");
            if (ebCertificate.getEnabledSys() != null && ebCertificate.getEnabledSys() == 1) {
                if (StringUtils.isBlank(enabledSysRemark)) {
                    redirectAttributes.addFlashAttribute("msg", "禁用原因不能为空");
                    redirectAttributes.addFlashAttribute("type", map.get("flag"));
                    return "redirect:" + Global.getAdminPath() + "/shop/product/addcertificate";
                } else {
                    ebCertificateUserService.setEbCertificateUserEnabled(ebCertificate.getCertificateId(), ebCertificate.getEnabledSys(), enabledSysRemark);
                    System.out.println("禁用");
                }

            } else {
                ebCertificateUserService.setEbCertificateUserEnabled(ebCertificate.getCertificateId(), ebCertificate.getEnabledSys(), "");
            }
            EbCertificate cate2 = ebCertificateService
                    .getEbCertificateById(ebCertificate.getCertificateId());
            if (ebCertificate.getProductTypeId() == null) {
                ebCertificate.setProductTypeId(cate2.getProductTypeId());
            }
            if (ebCertificate.getSendTime() == null) {
                ebCertificate.setSendTime(cate2.getSendTime());
            }
            if (ebCertificate.getCertificateStartDate() == null) {
                ebCertificate.setCertificateStartDate(cate2
                        .getCertificateStartDate());
            }
            if (ebCertificate.getCertificateEndDate() == null) {
                ebCertificate.setCertificateEndDate(cate2
                        .getCertificateEndDate());
            }
            ebCertificate.setCertificateType(0);//设置类型为优惠券
            ebCertificate.setCreateTime(cate2.getCreateTime());
            ebCertificate.setDelflag(0);
            ebCertificate.setShopTypeId(ebUser.getShopId() + "");
            ebCertificate.setShopId(cate2.getShopId());
            ebCertificate.setEnabledSys(ebCertificate.getEnabledSys());
            ebCertificate.setEnabledRemarkSys(enabledSysRemark);

            map = ebCertificateService.addEbCertificate(ebCertificate, 2);
            ebCertificateService.save(ebCertificate);
        }
        ebCertificateLocationService.addEbCertificateLocation(ebUser.getShopId(), ebCertificate.getCertificateId());

        redirectAttributes.addFlashAttribute("msg", map.get("msg"));
        redirectAttributes.addFlashAttribute("type", map.get("flag"));
        return "redirect:" + Global.getConfig("adShopPath") + "/product/shopCertificatelist";
    }

    /**
     * 删除优惠卷
     *
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/deletecertificate")
    public String deletecertificate(HttpServletRequest request,
                                    RedirectAttributes redirectAttributes) {
        Integer id = Integer.parseInt(request.getParameter("id"));
        int result = ebCertificateService.deleteById(id);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("msg", "删除成功");
        } else {
            redirectAttributes.addFlashAttribute("msg", "删除失败");
        }
        return "";
    }

    /**
     * 优惠卷新增商品选择
     *
     * @param ebProduct
     * @param stule
     * @param statrPrice
     * @param stopPrice
     * @param statrDate
     * @param stopDate
     * @param priceType
     * @param podateType
     * @param isLovePay
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/shopchooseProducts")
    public String chooseProducts(EbProduct ebProduct, String stule,
                                 String statrPrice, String stopPrice, String statrDate,
                                 String stopDate, String priceType, String podateType,
                                 String isLovePay, HttpServletRequest request,
                                 HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        Map<String, Object> map = new HashMap<String, Object>();
        String chooseIds = request.getParameter("chooseIds");//默认选择的优惠券
        Page<EbProduct> page = ebProductService.getEbProductList(null,
                ebProduct, new Page<EbProduct>(request, response), podateType,
                statrDate, stopDate, "", "", priceType, statrPrice, stopPrice, ebUser.getShopId());

        String userShopid = (String) request.getSession().getAttribute("userShopId");
        Integer shopId = Integer.valueOf(userShopid.split("_")[1]);

        //获得关联表中对应的门店名
        for (EbProduct e : page.getList()) {
            e.setNewShopName(pmShopInfoService.getById(shopId).getShopName());
        }

        model.addAttribute("page", page);
        model.addAttribute("chooseIds", chooseIds);
        return "modules/shop/shopchooseProductlist";

    }

    /**
     * 优惠卷新增选择商品列表
     *
     * @param ebProduct
     * @param stule
     * @param statrPrice
     * @param stopPrice
     * @param statrDate
     * @param stopDate
     * @param priceType
     * @param podateType
     * @param isLovePay
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"listdata", ""})
    public String getProductList(EbProduct ebProduct, Integer shopType, String stule,
                                 String statrPrice, String stopPrice, String statrDate,
                                 String stopDate, String priceType, String podateType,
                                 String isLovePay, HttpServletRequest request,
                                 HttpServletResponse response, Model model) {
        String productTags = request.getParameter("productTags");
        SysUser user = SysUserUtils.getUser();
        SysOffice sysOffice = user.getCompany();

        if (sysOffice != null) {
            String shopId = request.getParameter("shopId");
            if (StringUtils.isNotBlank(shopId)) {
                ebProduct.setShopId(Integer.parseInt(shopId));
            }
            if (StringUtils.isNotBlank(productTags)) {
                ebProduct.setProductTags(productTags);
            }
            if (StringUtils.isNotBlank(isLovePay)) {
                ebProduct.setIsLovePay(Integer.valueOf(isLovePay));
            }
            ebProduct.setAgentId(sysOffice.getId());
            Page<EbProduct> page = ebProductService.getEbProductNoUserList(
                    ebProduct, new Page<EbProduct>(request,
                            response), podateType, statrDate, stopDate, "", "",
                    priceType, statrPrice, stopPrice);
            if (ebProduct.getProductTypeId() != null) {
                PmProductType pmProductType = pmProductTypeService
                        .getSbProductType(ebProduct.getProductTypeId()
                                .toString());
                model.addAttribute("sbProductType", pmProductType);
            }
            if (page.getList() != null) {
                for (EbProduct eProduct : page.getList()) {
                    ebProduct = ebProductService.getProduct(eProduct);
                    Map map = pmProductStandardDetailService.PmProductStandardDetailCountSum(eProduct.getProductId());
                    if (map.get("count") != null) {
                        ebProduct.setStoreNums(Integer.parseInt((map.get("sumDetailInventory") + "")));
                    }
                }
            }
            model.addAttribute("shopType", shopType);
            model.addAttribute("productTags", productTags);
            model.addAttribute("shopId", shopId);
            model.addAttribute("page", page);
            model.addAttribute("stule", stule);
            model.addAttribute("podateType", podateType);
            model.addAttribute("priceType", priceType);
            model.addAttribute("statrPrice", statrPrice);
            model.addAttribute("stopPrice", stopPrice);
            model.addAttribute("statrDate", statrDate);
            model.addAttribute("stopDate", stopDate);
        }
        return "modules/shop/shopProductlist";
    }


    /**
     * 选择商品
     * @return
     */
    @RequestMapping(value="chooseProduct")
    public String chooseProduct(HttpServletRequest request,HttpServletResponse response , Model model,
                                EbProduct ebProduct,String productIds,String productNames){
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");

        Page<EbProduct> page = ebProductService.getEbProductList(null,
                ebProduct, new Page<EbProduct>(request, response), null,
                null, null, "", "", null, null, null, ebUser.getShopId());

        //当第一次跳转选择商品时，商品id可能不为空，商品名称一定为空
        if(StringUtils.isNotBlank(productIds) && StringUtils.isBlank(productNames)){
            StringBuffer nameBuf = new StringBuffer();
            for(String id : productIds.split(",")){
                EbProduct ebProductById = ebProductService.getEbProductById(Integer.valueOf(id));
                if(ebProductById != null){
                    nameBuf.append(ebProductById.getProductName()+",");
                }
            }

            if(nameBuf.length() > 0){
                nameBuf.setLength(nameBuf.length()-1);
                productNames = nameBuf.toString();
            }
        }
        model.addAttribute("page",page);
        model.addAttribute("ebProduct",ebProduct);
        model.addAttribute("productIds",productIds);
        model.addAttribute("productNames",productNames);

        return "modules/shop/chooseProduct";
    }


    /**
     * 一键选择所有商品
     * @return
     */
    @ResponseBody
    @RequestMapping(value="getAllProduct")
    public  Map<String,String> getAllProduct(HttpServletRequest request,HttpServletResponse response , Model model,
                                             EbProduct ebProduct){
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");

        Page<EbProduct> page = ebProductService.getEbProductList(null,
                ebProduct, new Page<EbProduct>(1, Integer.MAX_VALUE), null,
                null, null, "", "", null, null, null, ebUser.getShopId());


        Map<String,String> map = new HashMap<String, String>();
        String productIds = FormatUtil.getFieldAllValue(page.getList(), "productId");
        String productNames = FormatUtil.getFieldAllValue(page.getList(), "productName");

        map.put("productIds",productIds);
        map.put("productNames",productNames);
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "exsel")
    public String exsel(HttpServletRequest request, HttpServletResponse response) {
        String url = "";
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String syllable[] = request.getParameterValues("syllable");
        if (syllable != null && syllable.length > 0) {
            int t = 1;
            int pageNo = 1;
            int rowNum = 1;
            int rowNums = 100;
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("商品列表");
            HSSFRow row = sheet.createRow((int) 0);
            HSSFCellStyle style = wb.createCellStyle();
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("序号");
            cell.setCellStyle(style);
            for (int i = 0; i < syllable.length; i++) {
                cell = row.createCell((short) i);
                if (syllable[i].equals("1")) {
                    cell.setCellValue("商品名称");
                }
                if (syllable[i].equals("2")) {
                    cell.setCellValue("商品图片");
                }
                if (syllable[i].equals("3")) {
                    cell.setCellValue("所属分类");
                }
                if (syllable[i].equals("4")) {
                    cell.setCellValue("市场价");
                }
                if (syllable[i].equals("5")) {
                    cell.setCellValue("销售价");
                }
                if (syllable[i].equals("6")) {
                    cell.setCellValue("成本价");
                }
                if (syllable[i].equals("7")) {
                    cell.setCellValue("门店名称");
                }
                if (syllable[i].equals("8")) {
                    cell.setCellValue("商品状态");
                }
                if (syllable[i].equals("9")) {
                    cell.setCellValue("创建时间");
                }
                if (syllable[i].equals("10")) {
                    cell.setCellValue("上架时间");
                }
                if (syllable[i].equals("11")) {
                    cell.setCellValue("折扣比");
                }
                if (syllable[i].equals("12")) {
                    cell.setCellValue("收藏量");
                }
                if (syllable[i].equals("13")) {
                    cell.setCellValue("月销量");
                }
                if (syllable[i].equals("14")) {
                    cell.setCellValue("品牌");
                }
                cell.setCellStyle(style);
            }
            while (t == 1) {
                Page<EbProduct> page = ebProductService.getEbProductList(
                        null, new EbProduct(), new Page<EbProduct>(
                                pageNo, rowNums), "", "", "", "", "", "", "",
                        "", ebUser.getShopId());
                List<EbProduct> products = new ArrayList<EbProduct>();
                products = page.getList();
                if ((page.getCount() == rowNums && pageNo > 1)
                        || (page.getCount() / rowNums) < 1 && pageNo > 1) {
                    products = null;
                }
                if (products != null && products.size() > 0) {
                    for (EbProduct product : products) {
                        try {
                            // SmsUserblacklist
                            // userblacklist=smsUserblacklists.get(i);
                            row = sheet.createRow((int) rowNum);
                            row.createCell((short) 0).setCellValue(rowNum);
                            for (int i = 0; i < syllable.length; i++) {
                                if (syllable[i].equals("1")) {
                                    row.createCell((short) i).setCellValue(
                                            product.getProductName());
                                }
                                if (syllable[i].equals("2")) {
                                    row.createCell((short) i).setCellValue(
                                            product.getPrdouctImg());
                                }
                                if (syllable[i].equals("3")) {
                                    String productTypename = "";
                                    PmProductType pmProductType = pmProductTypeService
                                            .getSbProductType(product
                                                    .getProductTypeId()
                                                    .toString());
                                    if (pmProductType != null) {
                                        productTypename += ""
                                                + pmProductType
                                                .getProductTypeName()
                                                + "<";
                                        PmProductType pmProductType1 = pmProductTypeService
                                                .getSbProductType(pmProductType
                                                        .getParentId()
                                                        .toString());
                                        if (pmProductType1 != null) {
                                            productTypename += ""
                                                    + pmProductType1
                                                    .getProductTypeName()
                                                    + "<";
                                        }
                                        PmProductType pmProductType2 = pmProductTypeService
                                                .getSbProductType(pmProductType1
                                                        .getParentId()
                                                        .toString());
                                        if (pmProductType2 != null) {
                                            productTypename += ""
                                                    + pmProductType2
                                                    .getProductTypeName()
                                                    + "";
                                        }
                                    }
                                    row.createCell((short) i).setCellValue(
                                            productTypename);
                                }
                                if (syllable[i].equals("4")) {
                                    row.createCell((short) i).setCellValue(
                                            product.getSellPrice());
                                }
                                if (syllable[i].equals("5")) {
                                    row.createCell((short) i).setCellValue(
                                            product.getMarketPrice());
                                }
                                if (syllable[i].equals("6")) {
                                    row.createCell((short) i).setCellValue(
                                            product.getCostPrice());
                                }
                                if (syllable[i].equals("7")) {
                                    row.createCell((short) i).setCellValue(
                                            product.getShopName());
                                }
                                if (syllable[i].equals("8")) {
                                    String statusName = "";
                                    if (product.getPrdouctStatus() == 1) {
                                        statusName = "已上架";
                                    } else if (product.getPrdouctStatus() == 3) {
                                        statusName = "已删除";
                                    } else {
                                        statusName = "已下架";
                                    }
                                    row.createCell((short) i).setCellValue(
                                            statusName);
                                }
                                if (syllable[i].equals("9")) {
                                    row.createCell((short) i).setCellValue(
                                            com.jq.support.service.utils.DateUtil.getDate(product
                                                    .getCreateTime()));
                                }
                                if (syllable[i].equals("10")) {
                                    row.createCell((short) i).setCellValue(
                                            com.jq.support.service.utils.DateUtil.getDate(product
                                                    .getUpTime()));
                                }
                                if (syllable[i].equals("11")) {
                                    row.createCell((short) i).setCellValue(product.getReturnRatio());
                                }
                                if (syllable[i].equals("12")) {
                                    row.createCell((short) i).setCellValue(product.getFavorite());
                                }
                                if (syllable[i].equals("13")) {
                                    row.createCell((short) i).setCellValue(product.getMonthSalesAmount());
                                }
                                if (syllable[i].equals("14")) {
                                    row.createCell((short) i).setCellValue(product.getBrandName());
                                }
                            }
                        } catch (Exception e) {
                            System.out.print(e.getCause());
                        }
                        rowNum++;
                    }
                    pageNo++;
                } else {
                    t = 2;
                }
            }
            // JSONObject json=new JSONObject();
            // String code="01";
            String RootPath = request.getSession().getServletContext()
                    .getRealPath("/").replace("\\", "/");
            String path = "uploads/xlsfile/tempfile";
            Random r = new Random();
            String strfileName = com.jq.support.service.utils.DateUtil.getDateFormat(new Date(),
                    "yyyyMMddHHmmss") + r.nextInt();
            File f = new File(RootPath + path);
            // 不存在则创建它
            if (!f.exists())
                f.mkdirs();
            String tempPath = RootPath + path + "/" + strfileName + ".xls";
            try {
                FileOutputStream fout = new FileOutputStream(tempPath);
                wb.write(fout);
                fout.close();
                url = domainurl + "/" + path + "/" + strfileName + ".xls";
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {

        }
        return url;
    }

    @ResponseBody
    @RequestMapping(value = "editProstatus")
    public String editProstatus(String productId, HttpServletRequest request,
                                HttpServletResponse response, Model model,
                                RedirectAttributes redirectAttributes) {
        if (StringUtils.isNotBlank(productId)) {
            EbProduct ebProduct = ebProductService.getEbProduct(productId);
            if (ebProduct.getPrdouctStatus() != null) {
                if (ebProduct.getShopId() != null) {
                    if (ebProduct.getPrdouctStatus() == 0) {
                        if (ebProduct.getIsLovePay() != null) {
                            if (ebProduct.getIsLovePay() == 1) {
                                ebProduct.setProductViewMall(1);
                            }
                        }
                        ebProduct.setPrdouctStatus(1);
                        ebProduct.setUpTime(new Date());
                        EbUser ebUser = ebUserService.getShop(ebProduct
                                .getShopId().toString());
                        if (ebUser != null) {
                            EbMessageUser messageInfoUser = new EbMessageUser();
                            messageInfoUser.setUserId(ebUser.getUserId());
                            EbMessage eMessage = new EbMessage();
                            eMessage.setCreateTime(new Date());
                            eMessage.setCreateUser("平台管理员");
                            eMessage.setMessageAbstract("商品上架通知");
                            eMessage.setMessageTitle("商品上架通知");
                            eMessage.setMessageClass(2);
                            eMessage.setMessageContent("您的商品'"
                                    + ebProduct.getProductName() + "'被平台管理员上架了");
                            eMessage.setMessageIcon("");
                            eMessage.setMessageObjId(ebProduct.getProductId());
                            eMessage.setMessageType(5);
                            ebMessageService.saveflush(eMessage);
                            messageInfoUser.setMessageInfo(eMessage);
                            messageInfoUser.setState(0);
                            messageInfoUser.setUserType(1);
                            messageInfoUser.setCreateUser(SysUserUtils
                                    .getUser().getId());
                            messageInfoUserService
                                    .sqlsaveEbMessage(messageInfoUser);
                            // 推送
                            messageInfoUserService.sendMsgJgEbMessageUser(
                                    ebUser.getUserId(),
                                    eMessage);
                        } else {
                            addMessage(redirectAttributes, "失败,商家不存在");
                        }

                    } else if (ebProduct.getPrdouctStatus() == 1) {
                        ebProduct.setPrdouctStatus(0);
                        EbUser ebUser = ebUserService.getShop(ebProduct
                                .getShopId().toString());
                        if (ebUser != null) {
                            EbMessageUser messageInfoUser = new EbMessageUser();
                            messageInfoUser.setUserId(ebUser.getUserId());
                            EbMessage eMessage = new EbMessage();
                            eMessage.setCreateTime(new Date());
                            eMessage.setCreateUser("平台管理员");
                            eMessage.setMessageAbstract("商品下架通知");
                            eMessage.setMessageTitle("商品下架通知");
                            eMessage.setMessageClass(2);
                            eMessage.setMessageContent("您的商品'"
                                    + ebProduct.getProductName() + "'被平台管理员下架了");
                            eMessage.setMessageIcon("");
                            eMessage.setMessageObjId(ebProduct.getProductId());
                            eMessage.setMessageType(5);
                            ebMessageService.saveflush(eMessage);
                            messageInfoUser.setMessageInfo(eMessage);
                            messageInfoUser.setState(0);
                            messageInfoUser.setUserType(1);
                            messageInfoUser.setCreateUser(SysUserUtils
                                    .getUser().getId());
                            messageInfoUserService
                                    .sqlsaveEbMessage(messageInfoUser);
                            // 推送
                            messageInfoUserService.sendMsgJgEbMessageUser(
                                    ebUser.getUserId(),
                                    eMessage);
                        } else {
                            addMessage(redirectAttributes, "失败,商家不存在");
                        }
                    }
                } else {
                    addMessage(redirectAttributes, "失败,商家不存在");
                }

            } else {
                ebProduct.setPrdouctStatus(1);
            }
            ebProductService.saveProduct(ebProduct);
        }

        return "00";
    }

    @ResponseBody
    @RequestMapping(value = "eaitIsRecommend")
    public String eaitIsRecommend(String productId, HttpServletRequest request,
                                  HttpServletResponse response, Model model,
                                  RedirectAttributes redirectAttributes) {
        if (StringUtils.isNotBlank(productId)) {
            EbProduct ebProduct = ebProductService.getEbProduct(productId);
            if (ebProduct.getIsRecommend() != null) {
                if (ebProduct.getIsRecommend() == 0) {
                    ebProduct.setIsRecommend(1);
                } else {
                    ebProduct.setIsRecommend(0);
                }
            } else {
                ebProduct.setIsRecommend(1);
            }
            ebProductService.saveProduct(ebProduct);
        }
        addMessage(redirectAttributes, "保存成功");
        return "00";
    }

    @RequestMapping(value = "puStatusUpdw")
    @ResponseBody
    public JSONObject puStatusUpdw(HttpServletRequest request,
                                   HttpServletResponse response, Model model) {
        JSONObject json = new JSONObject();
        String status = request.getParameter("status");
        String ktvs = request.getParameter("ktvs");
        if (StringUtils.isBlank(ktvs)) {
            json.put("code", "01");
            json.put("msg", "失败！请选择至少一条数据");
            return json;
        }
        String[] ivd = ktvs.split(",");
        if (StringUtils.isBlank(status)) {
            json.put("code", "01");
            json.put("msg", "状态错误");
            return json;
        }
        if (ivd != null && ivd.length > 0) {
            for (int i = 0; i < ivd.length; i++) {
                if (StringUtils.isNotBlank(ivd[i])) {
                    EbProduct product = ebProductService.getEbProduct(ivd[i]);
                    if (product != null) {
                        String messageContent = "";
                        String messageAbstract = "";
                        if (status.equals("1")) {
                            messageAbstract = "商品上架通知";
                            messageContent = "您的商品" + product.getProductName()
                                    + "被平台管理员上架了";
                            product.setPrdouctStatus(1);
                            product.setUpTime(new Date());
                        } else {
                            messageAbstract = "商品下架通知";
                            messageContent = "您的商品" + product.getProductName()
                                    + "被平台管理员下架了";
                            product.setPrdouctStatus(0);
                            product.setDownTime(new Date());
                        }
                        ebProductService.saveProduct(product);
                        if (product.getShopId() != null) {
                            EbUser ebUser = ebUserService.getShop(product
                                    .getShopId().toString());
                            EbMessageUser messageInfoUser = new EbMessageUser();
                            messageInfoUser.setUserId(ebUser.getUserId());
                            EbMessage eMessage = new EbMessage();
                            eMessage.setCreateTime(new Date());
                            eMessage.setCreateUser("平台管理员");
                            eMessage.setMessageAbstract(messageAbstract);
                            eMessage.setMessageTitle(messageAbstract);
                            eMessage.setMessageClass(2);
                            eMessage.setMessageContent(messageContent);
                            eMessage.setMessageIcon("/upload/drawable-xhdpi/xtfk.png");
                            eMessage.setMessageObjId(product.getProductId());
                            eMessage.setMessageType(5);
                            ebMessageService.saveflush(eMessage);
                            messageInfoUser.setMessageInfo(eMessage);
                            messageInfoUser.setState(0);
                            messageInfoUser.setUserType(1);
                            messageInfoUser.setCreateUser(SysUserUtils
                                    .getUser().getId());
                            messageInfoUserService
                                    .sqlsaveEbMessage(messageInfoUser);
                            // 推送
                            messageInfoUserService.sendMsgJgEbMessageUser(
                                    ebUser.getUserId(),
                                    eMessage);
                        }
                    }
                }
            }
        } else {
            json.put("code", "01");
            json.put("msg", "失败！请选择至少一条数据");
            return json;
        }
        json.put("code", "00");
        json.put("msg", "成功");
        return json;
    }

    /**
     * 修改商品名
     *
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     * @throws ParseException
     */
    @ResponseBody
    @RequestMapping(value = "saveName")
    public String saveName(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        if (StringUtils.isNotBlank(id) && StringUtils.isNotBlank(name)) {
            EbProduct ebProduct = ebProductService.getEbProduct(id);
            ebProduct.setProductName(name);
            ebProductService.saveProduct(ebProduct);
        }
        return "00";
    }

    @ResponseBody
    @RequestMapping(value = "saveIds")
    public String saveIds(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String ids = request.getParameter("ids");
        String type = request.getParameter("type");//等于4 推荐
        String[] ivd = ids.split(",");
        for (int i = 0; i < ivd.length; i++) {
            if (StringUtils.isNotBlank(ivd[i])) {
                if (type.equals("4")) {
                    EbProduct ebProduct = ebProductService.getEbProduct(ivd[i]);
                    List<EbProduct> list = ebProductService.getShopList(ebUser.getShopId().toString());
                    if (list.size() >= 20) {
                        return "01";
                    } else {
                        ebProduct.setIsShopRecommend(1);
                        ebProductService.saveProduct(ebProduct);
                    }
                } else if (type.equals("5")) {
                    EbProduct ebProduct = ebProductService.getEbProduct(ivd[i]);
                    List<EbProduct> list = ebProductService.getShopList(ebUser.getShopId().toString());
                    if (list.size() >= 20) {
                        return "01";
                    } else {
                        ebProduct.setIsShopRecommend(0);
                        ebProductService.saveProduct(ebProduct);
                    }
                } else {
                    EbProduct ebProduct = ebProductService.getEbProduct(ivd[i]);
                    if (type.equals("1")) {
                        ebProduct.setPrdouctStatus(0);
                        ebProductService.saveProduct(ebProduct);
                        if (ebProduct.getIsLovePay() != null) {
                            if (ebProduct.getIsLovePay() == 0) {
                                PmSensitiveWordsFilter pmSensitiveWordsFilter = new PmSensitiveWordsFilter();
                                pmSensitiveWordsFilter.setFilterObjId(ebProduct.getProductId());
                                pmSensitiveWordsFilter.setCreateTime(new Date());
                                pmSensitiveWordsFilter.setCreateUser(ebUser.getMobile());
                                pmSensitiveWordsFilter.setFilterObjType(1);
                                pmSensitiveWordsFilter.setFilterStatus(1);
                                pmSensitiveWordsFilterService.save(pmSensitiveWordsFilter);
                            }
                        } else {
                            PmSensitiveWordsFilter pmSensitiveWordsFilter = new PmSensitiveWordsFilter();
                            pmSensitiveWordsFilter.setFilterObjId(ebProduct.getProductId());
                            pmSensitiveWordsFilter.setCreateTime(new Date());
                            pmSensitiveWordsFilter.setCreateUser(ebUser.getMobile());
                            pmSensitiveWordsFilter.setFilterObjType(1);
                            pmSensitiveWordsFilter.setFilterStatus(1);
                            pmSensitiveWordsFilterService.save(pmSensitiveWordsFilter);
                        }
                    } else {
                        ebProduct.setPrdouctStatus(Integer.parseInt(type));
                        ebProductService.saveProduct(ebProduct);
                    }
                }
            } else {
                return "03";
            }
        }
        return "00";
    }

    @ResponseBody
    @RequestMapping(value = "Tyepshop")
    public String Tyepshop(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String ids = request.getParameter("ids");
        String typeId = request.getParameter("typeId");//商品分类类别
        String[] ivd = ids.split(",");
        for (int i = 0; i < ivd.length; i++) {
            if (StringUtils.isNotBlank(ivd[i])) {
                EbProduct ebProduct = ebProductService.getEbProduct(ivd[i]);
                if (StringUtils.isNotBlank(typeId)) {
                    PmShopProductType pmShopProductType = pmShopProductTypeService.getpmPmShopProductType(typeId);
                    PmShopProductType pmShopProductType2 = pmShopProductTypeService.getpmPmShopProductType(pmShopProductType.getParentId().toString());
                    ebProduct.setShopProTypeIdStr("," + pmShopProductType2.getId() + "," + pmShopProductType.getId() + ",");
                }
                ebProductService.saveProduct(ebProduct);
            }
        }
        return "00";
    }

    @ResponseBody
    @RequestMapping(value = "showTyepshop")
    public String showTyepshop(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String ids = request.getParameter("ids");//商品id,
        String typeId = request.getParameter("typeId");//模板id
        String[] ivd = ids.split(",");
        for (int i = 0; i < ivd.length; i++) {
            if (StringUtils.isNotBlank(ivd[i])) {
                EbProduct ebProduct = ebProductService.getEbProduct(ivd[i]);
                if (StringUtils.isNotBlank(typeId)) {
                    PmShopShippingMethod pmShopShippingMethod = pmShopShippingMethodService.findid(typeId);
                    ebProduct.setFreightTempId(pmShopShippingMethod.getId());
                    ebProduct.setUserFreightTemp(1);
                }
                ebProductService.saveProduct(ebProduct);
            }
        }
        return "00";
    }

    @ResponseBody
    @RequestMapping(value = "munsEate")
    public String munsEate(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String ids = request.getParameter("ids");
        String typeId = request.getParameter("typeId");//0,替换1加2减3乘4除
        String munSize = request.getParameter("munSize");//数量
        if (StringUtils.isBlank(munSize)) {
            munSize = "0";
        }
        String[] ivd = ids.split(",");
        for (int i = 0; i < ivd.length; i++) {
            if (StringUtils.isNotBlank(ivd[i])) {
                EbProduct ebProduct = ebProductService.getEbProduct(ivd[i]);
                List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService.getProductIdPmProductStandardDetail(ebProduct.getProductId().toString());
                if (pmProductStandardDetails != null && pmProductStandardDetails.size() > 0) {
                    Integer muns = 0;
                    for (PmProductStandardDetail pmProductStandardDetail : pmProductStandardDetails) {
                        if (typeId.equals("0")) {
                            pmProductStandardDetail.setDetailInventory(Integer.parseInt(munSize));
                        } else if (typeId.equals("1")) {
                            pmProductStandardDetail.setDetailInventory(pmProductStandardDetail.getDetailInventory() + Integer.parseInt(munSize));
                        } else if (typeId.equals("2")) {
                            Integer StoreNums = pmProductStandardDetail.getDetailInventory() - Integer.parseInt(munSize);
                            if (StoreNums < 0) {
                                StoreNums = 0;
                            }
                            pmProductStandardDetail.setDetailInventory(StoreNums);
                        } else if (typeId.equals("3")) {
                            Integer StoreNums = pmProductStandardDetail.getDetailInventory() * Integer.parseInt(munSize);
                            pmProductStandardDetail.setDetailInventory(StoreNums);
                        } else if (typeId.equals("4")) {
                            double StoreNums = pmProductStandardDetail.getDetailInventory() * Integer.parseInt(munSize);
                            pmProductStandardDetail.setDetailInventory((int) Math.floor(StoreNums));
                        }
                        muns += pmProductStandardDetail.getDetailInventory();
                        pmProductStandardDetailService.save(pmProductStandardDetail);
                    }
                    ebProduct.setStoreNums(muns);
                } else {
                    if (typeId.equals("0")) {
                        ebProduct.setStoreNums(Integer.parseInt(munSize));
                    } else if (typeId.equals("1")) {
                        ebProduct.setStoreNums(ebProduct.getStoreNums() + Integer.parseInt(munSize));
                    } else if (typeId.equals("2")) {
                        Integer StoreNums = ebProduct.getStoreNums() - Integer.parseInt(munSize);
                        if (StoreNums < 0) {
                            StoreNums = 0;
                        }
                        ebProduct.setStoreNums(StoreNums);
                    } else if (typeId.equals("3")) {
                        Integer StoreNums = ebProduct.getStoreNums() * Integer.parseInt(munSize);
                        ebProduct.setStoreNums(StoreNums);
                    } else if (typeId.equals("4")) {
                        double StoreNums = ebProduct.getStoreNums() * Integer.parseInt(munSize);
                        ebProduct.setStoreNums((int) Math.floor(StoreNums));
                    }

                }
                ebProductService.saveProduct(ebProduct);
            }
        }
        return "00";
    }

    @RequestMapping(value = "/list")
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId() + "");
        if (pmShopInfo == null || pmShopInfo.getIsProduct() != 1) {
            model.addAttribute("messager", "没有权限添加商品");
            return null;
        }
        String podateType = "3";
        String statrDate = "";
        String stopDate = "";
        String priceType = "1";
        String starpmun = request.getParameter("starpmun");
        String stopmun = request.getParameter("stopmun");
        String statrPrice = request.getParameter("statrPrice");
        String stopPrice = request.getParameter("stopPrice");
        String productName = request.getParameter("productName");
        String barCode = request.getParameter("barCode");
        String prdouctStatus = request.getParameter("prdouctStatus");
        String storeNums = request.getParameter("storeNums");
        EbProduct ebProduct = new EbProduct();
        ebProduct.setShopId(ebUser.getShopId());
        ebProduct.setProductName(productName);
        ebProduct.setBarCode(barCode);
//	    if(StringUtils.isNotBlank(prdouctStatus)){
//	    	ebProduct.setPrdouctStatus(Integer.parseInt(prdouctStatus));
//	    }else{
//	    	ebProduct.setPrdouctStatus(0);
//	    }
        if (StringUtils.isNotBlank(storeNums)) {
            ebProduct.setStoreNums(Integer.parseInt(storeNums));
        }
        String productTypeParentId = request.getParameter("productTypeParentId");
        if (StringUtils.isNotBlank(productTypeParentId)) {
            ebProduct.setProductTypeParentId(Integer.parseInt(productTypeParentId));
        }
        Page<EbProduct> page = ebProductService.getEbProductList(null, ebProduct, new Page<EbProduct>(request, response), podateType, statrDate, stopDate, starpmun, stopmun, priceType, statrPrice, stopPrice,
                ebUser.getShopId());
        for (EbProduct ebProduct1 : page.getList()) {
            ebProduct1.setPrdouctStatusTemp(ebProduct1.getPrdouctStatus());
            if (ebProduct1.getPrdouctStatus() == 0) {
                PmSensitiveWordsFilter pmSensitiveWordsFilter1 = new PmSensitiveWordsFilter();
                pmSensitiveWordsFilter1.setFilterStatus(1);
                pmSensitiveWordsFilter1.setFilterObjType(1);
                pmSensitiveWordsFilter1.setFilterObjId(ebProduct1.getProductId());
                PmSensitiveWordsFilter pmSensitiveWordsFilter = pmSensitiveWordsFilterService.getPmSensitiveWordsFilter(pmSensitiveWordsFilter1);
                if (pmSensitiveWordsFilter != null) {
                    ebProduct1.setPrdouctStatusTemp(3);
                }
            }
        }
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("page", page);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("stopPrice", stopPrice);
        model.addAttribute("starpmun", starpmun);
        model.addAttribute("stopmun", stopmun);
        return "modules/shop/warehouse-comm";
    }

    @RequestMapping(value = "/list3")
    public String list3(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String podateType = "3";
        String statrDate = "";
        String stopDate = "";
        String priceType = "1";
        String statrPrice = request.getParameter("statrPrice");
        String stopPrice = request.getParameter("stopPrice");
        String starpmun = request.getParameter("starpmun");
        String stopmun = request.getParameter("stopmun");
        String productName = request.getParameter("productName");
        String barCode = request.getParameter("barCode");
        String prdouctStatus = request.getParameter("prdouctStatus");
        String storeNums = request.getParameter("storeNums");
        EbProduct ebProduct = new EbProduct();
        ebProduct.setShopId(ebUser.getShopId());
        ebProduct.setProductName(productName);
        ebProduct.setBarCode(barCode);
//	    if(StringUtils.isNotBlank(prdouctStatus)){
//	    	ebProduct.setPrdouctStatus(Integer.parseInt(prdouctStatus));
//	    }else{
        ebProduct.setPrdouctStatus(1);
//	    }
        if (StringUtils.isNotBlank(storeNums)) {
            ebProduct.setStoreNums(Integer.parseInt(storeNums));
        }
        String productTypeParentId = request.getParameter("productTypeParentId");
        if (StringUtils.isNotBlank(productTypeParentId)) {
            ebProduct.setProductTypeParentId(Integer.parseInt(productTypeParentId));
        }
        Page<EbProduct> page = ebProductService.getEbProductList(null, ebProduct, new Page<EbProduct>(request, response), podateType, statrDate, stopDate, starpmun, stopmun, priceType, statrPrice, stopPrice
                , ebUser.getShopId());
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("page", page);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("stopPrice", stopPrice);
        model.addAttribute("starpmun", starpmun);
        model.addAttribute("stopmun", stopmun);
        return "modules/shop/warehouse-comm3";
    }

    @RequestMapping(value = "/list4")
    public String list4(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String podateType = "3";
        String statrDate = "";
        String stopDate = "";
        String priceType = "1";
        String starpmun = request.getParameter("starpmun");
        String stopmun = request.getParameter("stopmun");
        String statrPrice = request.getParameter("statrPrice");
        String stule = request.getParameter("stule");
        String stopPrice = request.getParameter("stopPrice");
        String productName = request.getParameter("productName");
        String barCode = request.getParameter("barCode");
        String prdouctStatus = request.getParameter("prdouctStatus");
        String storeNums = request.getParameter("storeNums");
        EbProduct ebProduct = new EbProduct();
        ebProduct.setShopId(ebUser.getShopId());
        ebProduct.setProductName(productName);
        ebProduct.setBarCode(barCode);
        if (StringUtils.isNotBlank(prdouctStatus)) {
            ebProduct.setPrdouctStatus(Integer.parseInt(prdouctStatus));
        } else {
            ebProduct.setPrdouctStatus(1);
        }
        if (StringUtils.isNotBlank(storeNums)) {
            ebProduct.setStoreNums(Integer.parseInt(storeNums));
        }
        String productTypeParentId = request.getParameter("productTypeParentId");
        if (StringUtils.isNotBlank(productTypeParentId)) {
            ebProduct.setProductTypeParentId(Integer.parseInt(productTypeParentId));
        }
        Page<EbProduct> page = ebProductService.getEbProductList(null, ebProduct, new Page<EbProduct>(request, response), podateType, statrDate, stopDate, starpmun, stopmun, priceType, statrPrice, stopPrice
                , ebUser.getShopId());
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("stule", stule);
        model.addAttribute("page", page);
        model.addAttribute("starpmun", starpmun);
        model.addAttribute("stopmun", stopmun);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("stopPrice", stopPrice);
        return "modules/shop/warehouse-comm3";
    }

    /**
     * 的商品
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @RequestMapping(value = "/list2")
    public String list2(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        String podateType = "3";
        String statrDate = "";
        String stopDate = "";
        String priceType = "3";
        String starpmun = request.getParameter("starpmun");
        String stopmun = request.getParameter("stopmun");
        String statrPrice = request.getParameter("statrPrice");
        String stopPrice = request.getParameter("stopPrice");
        String productName = request.getParameter("productName");
        String barCode = request.getParameter("barCode");
        String prdouctStatus = request.getParameter("prdouctStatus");
        String storeNums = request.getParameter("storeNums");
        EbProduct ebProduct = new EbProduct();
        ebProduct.setShopId(ebUser.getShopId());
        ebProduct.setProductName(productName);
        ebProduct.setBarCode(barCode);
//	    if(StringUtils.isNotBlank(prdouctStatus)){
//	    	ebProduct.setPrdouctStatus(Integer.parseInt(prdouctStatus));
//	    }else{
        ebProduct.setPrdouctStatus(1);
//	    }
        if (StringUtils.isNotBlank(storeNums)) {
            ebProduct.setStoreNums(Integer.parseInt(storeNums));
        }
        String productTypeParentId = request.getParameter("productTypeParentId");
        if (StringUtils.isNotBlank(productTypeParentId)) {
            ebProduct.setProductTypeParentId(Integer.parseInt(productTypeParentId));
        }
        Page<EbProduct> page = ebProductService.getEbProductList(null, ebProduct, new Page<EbProduct>(request, response), podateType, statrDate, stopDate, starpmun, stopmun, priceType, statrPrice, stopPrice,
                ebUser.getShopId());
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("page", page);
        model.addAttribute("starpmun", starpmun);
        model.addAttribute("stopmun", stopmun);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("stopPrice", stopPrice);
        return "modules/shop/warehouse-comms";
    }

    /**
     * 添加商品申明
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @RequestMapping(value = "/addShow")
    public String addShow(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        createPicFold(request, null);//创建文件夹路径
        PmServiceProtocol pmServiceProtocol = pmServiceProtocolService.getSbServiceProtocolCode("8");
        model.addAttribute("pmServiceProtocol", pmServiceProtocol);

        return "modules/shop/release-comm-rule";
    }

    /**
     * 查看商品
     *
     * @return
     */
    @RequestMapping(value = "/from")
    public String from(HttpServletRequest request, HttpServletResponse response, Model model) {
        String productId = request.getParameter("productId");
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        EbProduct ebProduct = ebProductService.getEbProductByShopId(Integer.parseInt(productId), ebUser.getShopId());
        if (ebProduct != null) {
            createPicFold(request, productId);
            if (ebProduct.getShopId() != null) {
                PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebProduct.getShopId().toString());
                ebProduct.setPmShopInfo(pmShopInfo);
                model.addAttribute("pmShopInfo", pmShopInfo);
            }
        }
        PmLovePayDeploy lovePayEffectType = new PmLovePayDeploy();
        lovePayEffectType.setLovePayEndDate(new Date());
        List<PmLovePayDeploy> pmLovePayDeploys = pmLovePayDeployService.findPmLovePayDeployLists(lovePayEffectType);
        model.addAttribute("pmLovePayDeploys", pmLovePayDeploys);
        model.addAttribute("ebProduct", ebProduct);
        PmShopProductType pmShopProductType = new PmShopProductType();
        pmShopProductType.setShopId(ebUser.getShopId());
        pmShopProductType.setLevel(1);
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService.getList(pmShopProductType);
        for (PmShopProductType pmShopProductType2 : pmShopProductTypes) {
            PmShopProductType pmShopProductType3 = new PmShopProductType();
            pmShopProductType3.setShopId(ebUser.getShopId());
            pmShopProductType3.setParentId(pmShopProductType2.getId());
            List<PmShopProductType> pmShopProductTypes2 = pmShopProductTypeService.getList(pmShopProductType3);
            pmShopProductType2.setPmShopProductTypes(pmShopProductTypes2);
        }
        model.addAttribute("pmShopProductTypes", pmShopProductTypes);
        PmProductPropertyStandard pmProductPropertyStandard = pmProductPropertyStandardService.getPmProductIdPropertyStandard(ebProduct.getProductId().toString());
        model.addAttribute("pmProductPropertyStandard", pmProductPropertyStandard);
        List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService.getProductIdPmProductStandardDetail(productId);
        String stands = "";
        String st1 = "";
        String st2 = "";
        String st3 = "";
        String st4 = "";
        String standsName = "";
        Integer lesize = 0;
        for (PmProductStandardDetail pmProductStandardDetail : pmProductStandardDetails) {
            String idStr = "";
            List<SpreIdName> list = new ArrayList<SpreIdName>();
            stands += pmProductStandardDetail.getStandardIdStr();
            standsName += pmProductStandardDetail.getStandardValueStr() + ";";
            String[] les = pmProductStandardDetail.getStandardIdStr().split(";");
            String[] lev = pmProductStandardDetail.getStandardValueStr().split(";");
            String[] idsTss = pmProductStandardDetail.getStandardIdStr().split(";");
            if (idsTss != null && idsTss.length > 0) {
                for (int i = 0; i < idsTss.length; i++) {
                    idStr += idsTss[i].split(":")[1] + ":";
                }
                idStr = idStr.substring(0, idStr.length() - 1);
            }
            pmProductStandardDetail.setIdStr(idStr);
            lesize = les.length;
            for (int i = 0; i < les.length; i++) {
                SpreIdName idName = new SpreIdName();
                if (i == 0) {
                    idName.setId(les[i].split(":")[1].toString());
                    idName.setName(lev[i].split(":")[1].toString());
                    st1 += les[i].split(":")[1] + ":" + lev[i].split(":")[1] + ",";
                } else if (i == 1) {
                    idName.setId(les[i].split(":")[1].toString());
                    idName.setName(lev[i].split(":")[1].toString());
                    st2 += les[i].split(":")[1] + ":" + lev[i].split(":")[1] + ",";
                } else if (i == 2) {
                    idName.setId(les[i].split(":")[1].toString());
                    idName.setName(lev[i].split(":")[1].toString());
                    st3 += les[i].split(":")[1] + ":" + lev[i].split(":")[1] + ",";
                }else if (i == 3) {
                    idName.setId(les[i].split(":")[1].toString());
                    idName.setName(lev[i].split(":")[1].toString());
                    st4 += les[i].split(":")[1] + ":" + lev[i].split(":")[1] + ",";
                }
                list.add(idName);
            }
            pmProductStandardDetail.setStrlust(list);
        }
        //查询所有的加料
        List<EbProductCharging> ebProductChargingList = ebProductChargingService.findEbProductChargingByProductId(ebProduct.getProductId());
        model.addAttribute("ebProductChargingList", ebProductChargingList);
        model.addAttribute("standsName", standsName);
        model.addAttribute("st1", st1);
        model.addAttribute("lesize", lesize);
        model.addAttribute("st2", st2);
        model.addAttribute("st3", st3);
        model.addAttribute("st4", st4);
        model.addAttribute("stands", stands);
        model.addAttribute("pic", "/" + productId + "/" + DateUtils.getYear() + DateUtils.getMonth() + DateUtils.getDay());
        model.addAttribute("pmProductStandardDetails", pmProductStandardDetails);
        return "modules/shop/release-comm-step";
    }

    /**
     * 添加
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws ParseException
     * @throws IOException
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public JSONObject save(HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException, IOException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        JSONObject json = new JSONObject();
        if (ebUser == null) {
            json.put("code", "11");
            json.put("msg", "登陆失效,请重新登陆");
            return json;
        }
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId() + "");
        if (pmShopInfo == null || pmShopInfo.getIsProduct() != 1) {
            json.put("code", "01");
            json.put("msg", "没有权限添加商品");
            return json;
        }
        String productId = request.getParameter("productId");
        String isLovePay = request.getParameter("isLovePay");
        String lovePayStartDate = request.getParameter("lovePayStartDate");
        String lovePayEndDate = request.getParameter("lovePayEndDate");
        String lovePayMinRatio = request.getParameter("lovePayMinRatio");
        String lovePayMaxRatio = request.getParameter("lovePayMaxRatio");
        String productHtml = request.getParameter("productHtml");//详情
        String pmshoprodic = request.getParameter("pmshoprodic");
        String freightType = request.getParameter("money1");
        String freightTempType = request.getParameter("freightTempType");
        String freightTempMoney = request.getParameter("freightTempMoney");
        String freightTempId = request.getParameter("freightTempId");
        String advertuseImg = request.getParameter("advertuseImg");//图片
        String[] standard_id_str = request.getParameterValues("standard_id_str");
        //String[] standard_value_str= request.getParameterValues("standard_value_str");
        String[] detailInventory = request.getParameterValues("detailInventory");
        String[] market_price = request.getParameterValues("market_price");
        String[] supply_price = request.getParameterValues("detail_prices");//request.getParameterValues("supply_price");
        String[] detail_prices = request.getParameterValues("detail_prices");
        String[] member_price = request.getParameterValues("member_price");//多规格，会员价格
        String[] return_ratio = request.getParameterValues("return_ratio");
        String productName = request.getParameter("productName");
        String li5 = request.getParameter("li5");
        String li2 = request.getParameter("li2");
        String measuringType = request.getParameter("measuringType");
        String measuringUnit = request.getParameter("measuringUnit");
        String sellPrice = request.getParameter("sellPrice");
        String costPrice = request.getParameter("costPrice");
        String marketPrice = request.getParameter("marketPrice");
        String memberPrice = request.getParameter("memberPrice");
        String barCode = request.getParameter("barCode");
        String storeNums = request.getParameter("storeNums");
        String provincesId = request.getParameter("provincesId");
        String municipalId = request.getParameter("municipalId");
        String country = request.getParameter("country");
        String typeId = request.getParameter("type");
        String standarBraind_id = request.getParameter("standarBraind_id");//品牌id
        String[] standard_id = request.getParameterValues("standard_id");//属性ids
        String[] standard_name = request.getParameterValues("standard_name");//属性值ids
        String ReturnRatio = request.getParameter("ReturnRatio");
        String productChargingIds = request.getParameter("productChargingIds");//加料信息
        String area = request.getParameter("area");
        String isTakeOut = request.getParameter("isTakeOut");//是否外卖
        String productIntro = request.getParameter("productIntro");//产品简介
        String minRatio = DictUtils.getDictValue("minRatio", "gyconfig", "");
        String maxRatio = DictUtils.getDictValue("maxRatio", "gyconfig", "");

        if (StringUtils.isBlank(advertuseImg)) {
            json.put("code", "01");
            json.put("msg", "商品主图不能为空");
            return json;
        }
        if (StringUtils.isBlank(li2)) {
            json.put("code", "01");
            json.put("msg", "请选择多规格或单规格");
            return json;
        }
        if (StringUtils.isBlank(productIntro)) {
            json.put("code", "01");
            json.put("msg", "请填写简介");
            return json;
        }
        if (StringUtils.isBlank(measuringType)) {
            json.put("code", "01");
            json.put("msg", "请选择计量单位");
            return json;
        }
        if(StringUtils.isNotBlank(storeNums) && storeNums.indexOf('.') >= 0){
            if("1".equals(measuringType)){
                json.put("code", "01");
                json.put("msg", "当前计量类型为件，库存不能为小数");
                return json;
            }

            if("2".equals(measuringType) && "2".equals(measuringUnit)){
                json.put("code", "01");
                json.put("msg", "当前计量单位为克，库存不能为小数");
                return json;
            }


        }
//		if(standard_id==null||standard_id.length==0){
//			json.put("code", "01");
//			json.put("msg", "请填写属性");
//			return json;
//		}
        if (StringUtils.isNotBlank(freightType)) {
            if (freightType.equals("2")) {
                if (StringUtils.isNotBlank(freightTempType)) {
                    if (!freightTempType.equals("1")) {
                        if (StringUtils.isNotBlank(freightTempMoney)) {
                            if (Double.parseDouble(freightTempMoney) > 200) {
                                json.put("code", "01");
                                json.put("msg", "运费必须小于200");
                                return json;
                            }
                        }
                    }
                }
            }
        }
        if ("2".equals(measuringType)||"1".equals(li2)) {
            if (StringUtils.isBlank(li5)) {
                json.put("code", "01");
                json.put("msg", "请选着默认还是手动输入让利比");
                return json;
            }
//			if(StringUtils.isBlank(marketPrice)){
//				json.put("code", "01");
//				json.put("msg", "市场价格不能为空");
//				return json;
//			}
//			if(Double.parseDouble(marketPrice)<0){
//				json.put("code", "01");
//				json.put("msg", "市场价格不能小于0");
//				return json;
//			}
            if (StringUtils.isBlank(sellPrice)) {
                json.put("code", "01");
                json.put("msg", "销售价不能为空");
                return json;
            }
            if (Double.parseDouble(sellPrice) < 0) {
                json.put("code", "01");
                json.put("msg", "销售价不能小于0");
                return json;
            }
            if (StringUtils.isBlank(memberPrice)) {
                json.put("code", "01");
                json.put("msg", "会员价格不能为空");
                return json;
            }
            if (Double.parseDouble(memberPrice) < 0) {
                json.put("code", "01");
                json.put("msg", "会员价格不能小于0");
                return json;
            }

            if (StringUtils.isBlank(costPrice)) {
                json.put("code", "01");
                json.put("msg", "结算价不能为空");
                return json;
            }
//			if(Double.parseDouble(marketPrice)<Double.parseDouble(sellPrice)){
//				json.put("code", "01");
//				json.put("msg", "市场价格要大于销售价");
//				return json;
//			}
            if (StringUtils.isBlank(costPrice)) {
                json.put("code", "01");
                json.put("msg", "结算价不能为空");
                return json;
            }
            if (Double.parseDouble(costPrice) < 0) {
                json.put("code", "01");
                json.put("msg", "结算价不能小于0");
                return json;
            }
            if (li5.equals("1")) {
                ReturnRatio = pmShopInfo.getReturnRatio().toString();
            }
            if (StringUtils.isBlank(ReturnRatio)) {
                json.put("code", "01");
                json.put("msg", "请输入让利比");
                return json;
            }
            if (Double.parseDouble(minRatio) > Double.parseDouble(ReturnRatio)) {
                json.put("code", "01");
                json.put("msg", "请输入正确的让利比");
                return json;
            }
            if (Double.parseDouble(ReturnRatio) > Double.parseDouble(maxRatio)) {
                json.put("code", "01");
                json.put("msg", "请输入正确的让利比");
                return json;
            }
        } else {
            if (return_ratio != null && return_ratio.length > 0) {
                for (int i = 0; i < return_ratio.length; i++) {
                    return_ratio[i] = "0";
//					if(StringUtils.isBlank(market_price[i])){
//						json.put("code", "01");
//						json.put("msg", "市场价格不能为空");
//						return json;
//					}
//					if(Double.parseDouble(market_price[i])<0){
//						json.put("code", "01");
//						json.put("msg", "市场价格不能小于0");
//						return json;
//					}
                    if (StringUtils.isBlank(detail_prices[i])) {
                        json.put("code", "01");
                        json.put("msg", "销售价不能为空");
                        return json;
                    }
                    if (Double.parseDouble(detail_prices[i]) < 0) {
                        json.put("code", "01");
                        json.put("msg", "销售价不能小于0");
                        return json;
                    }
                    if (StringUtils.isBlank(member_price[i])) {
                        json.put("code", "01");
                        json.put("msg", "会员价格不能为空");
                        return json;
                    }
                    if (Double.parseDouble(member_price[i]) < 0) {
                        json.put("code", "01");
                        json.put("msg", "会员价格不能小于0");
                        return json;
                    }

//					if(Double.parseDouble(market_price[i])<Double.parseDouble(detail_prices[i])){
//						json.put("code", "01");
//						json.put("msg", "市场价格要大于销售价");
//						return json;
//					}
                    if (StringUtils.isBlank(supply_price[i])) {
                        json.put("code", "01");
                        json.put("msg", "结算价不能为空");
                        return json;
                    }
                    if (Double.parseDouble(supply_price[i]) < 0) {
                        json.put("code", "01");
                        json.put("msg", "结算价不能小于0");
                        return json;
                    }
                    if (StringUtils.isBlank(return_ratio[i])) {
                        json.put("code", "01");
                        json.put("msg", "请输入让利比");
                        return json;
                    }
                    if (Double.parseDouble(minRatio) > Double.parseDouble(return_ratio[i])) {
                        json.put("code", "01");
                        json.put("msg", "请输入正确的让利比");
                        return json;
                    }
                    if (Double.parseDouble(return_ratio[i]) > Double.parseDouble(maxRatio)) {
                        json.put("code", "01");
                        json.put("msg", "请输入正确的让利比");
                        return json;
                    }
                }
            }
        }
        EbProduct ebProduct = new EbProduct();
        if (StringUtils.isNotBlank(productId)) {
            ebProduct.setProductId(Integer.parseInt(productId));
            ebProduct = ebProductService.getEbProductById(ebProduct.getProductId());
        } else {
            ebProduct.setShopType(2);
        }
        ebProduct.setAgentId(ebUser.getAgentId());
        if (StringUtils.isNotBlank(freightType)) {
            ebProduct.setFreightType(Integer.parseInt(freightType));
            if (freightType.equals("2")) {
                if (StringUtils.isNotBlank(freightTempType)) {
                    if (freightTempType.equals("1")) {
                        if (StringUtils.isNotBlank(freightTempId)) {
                            ebProduct.setUserFreightTemp(1);
                            ebProduct.setFreightTempId(Integer.parseInt(freightTempId));
                        }
                    } else {
                        if (StringUtils.isNotBlank(freightTempMoney)) {
                            ebProduct.setUserFreightTemp(0);
                            ebProduct.setCourier(Double.parseDouble(freightTempMoney));
                        }
                    }
                } else {
                    ebProduct.setUserFreightTemp(0);
                }
            } else {
                ebProduct.setUserFreightTemp(0);
            }
        }
        if (StringUtils.isNotBlank(provincesId)) {
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            pmSysDistrict.setId(Integer.parseInt(provincesId));
            ebProduct.setProvincesName(pmSysDistrictService.findId(pmSysDistrict).getDistrictName());
        }
        if (StringUtils.isNotBlank(municipalId)) {
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            pmSysDistrict.setId(Integer.parseInt(municipalId));
            ebProduct.setMunicipalName(pmSysDistrictService.findId(pmSysDistrict).getDistrictName());
        }
        if (StringUtils.isNotBlank(area)) {
            ebProduct.setArea(Integer.parseInt(area));
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            pmSysDistrict.setId(Integer.parseInt(area));
            ebProduct.setAreaName(pmSysDistrictService.findId(pmSysDistrict).getDistrictName());
        }
        if (StringUtils.isNotBlank(advertuseImg)) {
            if (advertuseImg.substring(0, 1).equals("|")) {
                StringBuilder advertuseImgs = new StringBuilder(advertuseImg);
                advertuseImg = advertuseImgs.replace(0, 1, "").toString();
            }
        }
        ebProduct.setPrdouctImg(advertuseImg);
        ebProduct.setProductHtml(productHtml);
        ebProduct.setProductIntro(productIntro);

        ebProduct.setShopId(ebUser.getShopId());
        ebProduct.setPrdouctStatus(1);
        if (StringUtils.isNotBlank(storeNums)) {
            //当重量单位为公斤时，把库存转化成克
            if(StringUtils.isNotBlank(measuringType)&& Integer.valueOf(measuringType) == 2 ){
                if("1".equals(measuringUnit)){
                    //因为公斤有可能输入小数
                    ebProduct.setStoreNums((int)( Double.parseDouble(storeNums)*1000));
                }else if("3".equals(measuringUnit)){
                    //因为斤有可能输入小数
                    ebProduct.setStoreNums((int)( Double.parseDouble(storeNums)*500));
                }else{
                    ebProduct.setStoreNums(Integer.parseInt(storeNums));
                }
            }else{
                ebProduct.setStoreNums(Integer.parseInt(storeNums));
            }
        } else {
            ebProduct.setStoreNums(0);
        }
        if (StringUtils.isNotBlank(isTakeOut)) {
            ebProduct.setIsTakeOut(Integer.parseInt(isTakeOut));
        } else {
            ebProduct.setIsTakeOut(0);
        }
        ebProduct.setProductName(productName);
        if (StringUtils.isNotBlank(pmshoprodic)) {
            PmShopProductType pmShopProductType = pmShopProductTypeService.getpmPmShopProductType(pmshoprodic);
            PmShopProductType pmShopProductType2 = pmShopProductTypeService.getpmPmShopProductType(pmShopProductType.getParentId().toString());
            ebProduct.setShopProTypeIdStr("," + pmShopProductType2.getId() + "," + pmShopProductType.getId() + ",");
        }
        if (StringUtils.isNotBlank(sellPrice)) {
            ebProduct.setSellPrice(Double.parseDouble(sellPrice));
        } else {
            ebProduct.setSellPrice(0.00);
        }
        if (StringUtils.isNotBlank(memberPrice)) {
            ebProduct.setMemberPrice(Double.parseDouble(memberPrice));
        } else {
            ebProduct.setMemberPrice(0.00);
        }
        if (StringUtils.isNotBlank(costPrice)) {
            ebProduct.setCostPrice(Double.parseDouble(costPrice));
        } else {
            ebProduct.setCostPrice(0.00);
        }
        if (StringUtils.isNotBlank(marketPrice)) {
            ebProduct.setMarketPrice(Double.parseDouble(marketPrice));
        } else {
            ebProduct.setMarketPrice(0.00);
        }
        if (StringUtils.isNotBlank(productId)) {
            ebProduct.setModifyTime(new Date());
            ebProduct.setModifyUser(ebUser.getUsername());
            if (ebProduct.getCreateTime() == null) {
                ebProduct.setCreateTime(new Date());
                ebProduct.setCreateUser(ebUser.getUsername());
            }
        } else {
            ebProduct.setCreateTime(new Date());
            ebProduct.setCreateUser(ebUser.getUsername());
        }
        if (StringUtils.isNotBlank(li5)) {
            if (li5.equals("1")) {
                ebProduct.setReturnRatio(pmShopInfo.getReturnRatio());
            } else {
                if (StringUtils.isNotBlank(ReturnRatio)) {
                    ebProduct.setReturnRatio(Double.parseDouble(ReturnRatio));
                }
            }
        } else {
            ebProduct.setReturnRatio(pmShopInfo.getReturnRatio());
        }
        ebProduct.setShopName(pmShopInfo.getShopName());
        ebProduct.setBarCode(barCode);
        ebProduct.setProvincesId(provincesId);
        ebProduct.setMunicipalId(municipalId);
        ebProduct.setCountry(country);
        if (StringUtils.isNotBlank(standarBraind_id))
            ebProduct.setBrandId(Integer.parseInt(standarBraind_id));
        ebProduct.setBrandName(pmProductTypeBrandService.getSbProductTypeBrand(standarBraind_id).getBrandName());
        ebProduct.setProductTypeId(Integer.parseInt(typeId));
        //三级
        PmProductType pmProductType1 = pmProductTypeService.getSbProductType(typeId);
        ebProduct.setProductTypeName(pmProductType1.getProductTypeName());
        //2级
        PmProductType pmProductType2 = pmProductTypeService.getSbProductType(pmProductType1.getParentId().toString());
//		ebProduct.setProductTypeName(pmProductType1.getProductTypeName());
        ebProduct.setProductTypeParent2Id(pmProductType2.getId());
        //1级
        if (StringUtils.isNotBlank(isLovePay)) {
            ebProduct.setIsLovePay(Integer.parseInt(isLovePay));
            if (StringUtils.isNotBlank(lovePayStartDate)) {
                ebProduct.setLovePayStartDate(DateUtil.parseDate(lovePayStartDate));
            }
            if (StringUtils.isNotBlank(lovePayEndDate)) {
                ebProduct.setLovePayEndDate(DateUtil.parseDate(lovePayEndDate));
            }
            if (StringUtils.isNotBlank(lovePayMinRatio)) {
                ebProduct.setLovePayMinRatio(Double.parseDouble(lovePayMinRatio));
            }
            if (StringUtils.isNotBlank(lovePayMaxRatio)) {
                ebProduct.setLovePayMaxRatio(Double.parseDouble(lovePayMaxRatio));
            }
        } else {
            ebProduct.setIsLovePay(null);
            ebProduct.setIsLovePay(0);
            ebProduct.setLovePayStartDate(null);
            ebProduct.setLovePayEndDate(null);
            ebProduct.setLovePayMinRatio(0.0);
            ebProduct.setLovePayMaxRatio(0.00);
        }

        PmProductType pmProductType3 = pmProductTypeService.getSbProductType(pmProductType2.getParentId().toString());
        ebProduct.setPrdouctStatus(0);
        ebProduct.setProductTypeParentId(pmProductType3.getId());
        if (ebProduct.getProductName() != null)
            ebProduct.setProductNameFirst(ChineseCharacterUtil.convertHanzi2Pinyin(ebProduct.getProductName(), false).toLowerCase());
        ebProduct.setMeasuringType(StringUtil.isNotBlank(measuringType)?Integer.valueOf(measuringType):null);
        ebProduct.setMeasuringUnit(StringUtil.isNotBlank(measuringUnit)?Integer.valueOf(measuringUnit):null);
        ebProductService.saveProduct(ebProduct);
        //商品id空就移动图片
        if (StringUtils.isBlank(productId)) {
            String servletPath = request.getSession().getServletContext().getRealPath("");
            //System.out.println("初始路径："+servletPath);
            //servletPath=servletPath.substring(0, servletPath.lastIndexOf("\\/"));
            String loc = createPicFold(request, ebProduct.getProductId().toString());
            String rep = "/images/" + ebProduct.getProductId() + "/" + ymd;
            String imgs[] = advertuseImg.split("\\|");
            for (String img : imgs) {
                if (img.contains("/images/temp/")) {
                    String temp = img.substring(img.lastIndexOf("/") + 1, img.length());//图片
                    File newimg = new File(loc + temp);//图片新路径
                    System.out.println("新路径路径：" + loc + temp);
                    System.out.println("旧的路径：" + servletPath + img);
                    File old = new File(servletPath + img);//旧的
                    if (old.exists()) {
                        FileUtils.moveFile(old, newimg);
                    }
                }
            }
            if (StringUtils.isNotBlank(productHtml)) {
                Document doc = Jsoup.parse(productHtml);
                Elements pngs = doc.select("img");
                for (Element element : pngs) {
                    String src = element.attr("src");
                    if (src.contains("/images/temp/")) {
                        String temp = src.substring(src.lastIndexOf("/") + 1, src.length());//图片
                        File newimg = new File(loc + temp);//图片新路径
                        System.out.println("新路径路径：" + loc + temp);
                        System.out.println("旧的路径：" + servletPath + src);
                        File old = new File(servletPath + src);//旧的
                        if (old.exists()) {
                            FileUtils.moveFile(old, newimg);
                        }
                    }
                }
            }
            advertuseImg = advertuseImg.replace("/images/temp", rep);
            productHtml = productHtml.replace("/images/temp", rep);
            ebProductService.updateprdouctimg(advertuseImg, productHtml, ebProduct.getProductId().toString());
        }

        EbProduct ebProductNew = ebProductService.getEbProductById(ebProduct.getProductId());
        PmProductPropertyStandard pmProductPropertyStandard = new PmProductPropertyStandard();
        pmProductPropertyStandard.setProductId(ebProductNew.getProductId());
        String propertyStandardIdStr = "";
        String propertyStandardValueStr = "";

        // 修改前删除属性
        if (StringUtils.isNotBlank(productId)) {
            PmProductPropertyStandard pmProductPropertyStandard2 = pmProductPropertyStandardService
                    .getPmProductIdPropertyStandard(productId);
            if (pmProductPropertyStandard2 != null) {
                pmProductPropertyStandardService
                        .delete(pmProductPropertyStandard2);
            }
        }

        if (standard_id != null)
            for (int i = 0; i < standard_id.length; i++) {
                PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(standard_id[i]);
                PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
                pmProductTypeSpertAttrValue.setSpertAttrId(pmProductTypeSpertAttr.getId());
                List<PmProductTypeSpertAttrValue> attrValues = productTypeSpertAttrValueService.getAttList(pmProductTypeSpertAttrValue);
                if (pmProductTypeSpertAttr.getShowType() == 1) {
                    String chu = request.getParameter("chu" + pmProductTypeSpertAttr.getId());
                    if (attrValues != null && attrValues.size() > 0) {
                        propertyStandardIdStr += standard_id[i] + ":" + chu + ";";
                        propertyStandardValueStr += "" + pmProductTypeSpertAttr.getSpertAttrName() + ":" + productTypeSpertAttrValueService.getSbProductTypeSpertAttrValue(chu).getSpertAttrValue() + ";";
                    }
                } else {
                    if (attrValues != null && attrValues.size() > 0) {
                        propertyStandardIdStr += standard_id[i] + ":" + standard_name[i] + ";";
                        propertyStandardValueStr += pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(standard_id[i]).getSpertAttrName() + ":" + productTypeSpertAttrValueService.getSbProductTypeSpertAttrValue(standard_name[i]).getSpertAttrValue() + ";";
                    }

                }
            }
        pmProductPropertyStandard.setPropertyStandardValueStr(propertyStandardValueStr);
        pmProductPropertyStandard.setShopId(ebUser.getShopId());
        pmProductPropertyStandard.setPropertyStandardType(1);
        pmProductPropertyStandard.setPropertyStandardIdStr(propertyStandardIdStr);
        pmProductPropertyStandardService.save(pmProductPropertyStandard);

        List<PmProductStandardDetail> pmProductStandardDetails = new ArrayList<PmProductStandardDetail>();
        //已经被删除的规格map
        Map<Integer, PmProductStandardDetail> deleteStanderMap = new HashMap<Integer, PmProductStandardDetail>();
        //发生改变的规格列表
        List<PmProductStandardDetail> changeStanderList = new ArrayList<PmProductStandardDetail>();

        //查出原有的所有规格
        List<PmProductStandardDetail> oldStanderList = pmProductStandardDetailService.getByProductId(ebProduct.getProductId());
        if (oldStanderList != null && oldStanderList.size() > 0) {
            for (PmProductStandardDetail standar : oldStanderList) {
                if (standar != null) {
                    deleteStanderMap.put(standar.getId(), standar);
                }
            }
        }

        //循环添加
        if ("1".equals(measuringType) && "2".equals(li2)) {

            if (return_ratio != null && return_ratio.length > 0) {
                for (int i = 0; i < return_ratio.length; i++) {
                    PmProductStandardDetail pmProductStandardDetail = new PmProductStandardDetail();

                    if (StringUtil.isNotBlank(standard_id_str[i])) {
                        //根据商品id和规格id获取规格
                        PmProductStandardDetail detail = pmProductStandardDetailService.
                                getByProductIdAndstandardIds(ebProduct.getProductId(), standard_id_str[i]);

                        //不等于空的话，说明从前有这个规格
                        if (detail != null) {
                            pmProductStandardDetail = detail;
                            //从删除的map中移除这个规格
                            deleteStanderMap.remove(pmProductStandardDetail.getId());
                        }

                        //获得修改价格的规格
                        if (pmProductStandardDetail.getDetailPrices() != null && pmProductStandardDetail.getMemberPrice() != null) {
                            if (!Double.valueOf(detail_prices[i]).equals(pmProductStandardDetail.getDetailPrices())
                                    || !Double.valueOf(member_price[i]).equals(pmProductStandardDetail.getMemberPrice())) {
                                changeStanderList.add(pmProductStandardDetail);
                            }
                        }
                    }


                    pmProductStandardDetail.setDetailInventory(Integer.parseInt(detailInventory[i]));
                    pmProductStandardDetail.setDetailPrices(Double.parseDouble(detail_prices[i]));
                    pmProductStandardDetail.setMemberPrice(Double.parseDouble(member_price[i]));

                    pmProductStandardDetail.setMarketPrice(StringUtils.isNotBlank(market_price[i]) ? Double.parseDouble(market_price[i]) : 0.0);
                    pmProductStandardDetail.setSupplyPrice(Double.parseDouble(supply_price[i]));
                    String StandardIdStr = "";
                    String StandardValueStr = "";
                    pmProductStandardDetail.setShopId(ebUser.getShopId());
                    if (StringUtils.isNotBlank(standard_id_str[i])
                            && pmProductStandardDetail.getId() == null) {
                        String[] idStr = standard_id_str[i].split(":");
                        for (int j = 0; j < idStr.length; j++) {
                            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = productTypeSpertAttrValueService.getSbProductTypeSpertAttrValue(idStr[j]);
                            if (pmProductTypeSpertAttrValue != null) {
                                pmProductTypeSpertAttrValue.setProductId(ebProductNew.getProductId());
                                productTypeSpertAttrValueService.save(pmProductTypeSpertAttrValue);
                                if (pmProductTypeSpertAttrValue.getSpertAttrId() != null) {
                                    PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(pmProductTypeSpertAttrValue.getSpertAttrId().toString());
                                    if (pmProductTypeSpertAttr != null) {
                                        StandardIdStr += pmProductTypeSpertAttr.getId() + ":" + pmProductTypeSpertAttrValue.getId() + ";";
                                        StandardValueStr += pmProductTypeSpertAttr.getSpertAttrName() + ":" + pmProductTypeSpertAttrValue.getSpertAttrValue() + ";";
                                    }
                                }
                            }
                        }
                    }

                    //新增规格才设置这些值
                    if (pmProductStandardDetail.getId() == null) {
                        StandardIdStr = StandardIdStr.substring(0, StandardIdStr.length() - 1);
                        StandardValueStr = StandardValueStr.substring(0, StandardValueStr.length() - 1);
                        pmProductStandardDetail.setStandardIdStr(StandardIdStr);
                        pmProductStandardDetail.setStandardValueStr(StandardValueStr);
                        pmProductStandardDetail.setProductId(ebProductNew.getProductId());
                        pmProductStandardDetail.setReturnRatio(Double.parseDouble(return_ratio[i]));
                    }

                    pmProductStandardDetailService.save(pmProductStandardDetail);
                }
            }
            pmProductStandardDetails = pmProductStandardDetailService.getProductIdPmProductStandardDetail(ebProductNew.getProductId().toString());
            if (pmProductStandardDetails != null && pmProductStandardDetails.size() > 0) {
                Integer mus = 0;
                List<PmProductStandardDetail> max = pmProductStandardDetailService.getProductIdPmProductStandardMaximum(ebProductNew.getProductId().toString());
                for (PmProductStandardDetail pmProductStandardDetail : max) {
                    mus += pmProductStandardDetail.getDetailInventory();
                }
                ebProductNew.setStoreNums(mus);
                List<PmProductStandardDetail> min = pmProductStandardDetailService.getProductIdPmProductStandardMinimum(ebProductNew.getProductId().toString());
                if (max != null && max.size() > 0 && min != null && max.size() > 0) {
                    ebProductNew.setMarketPrice(min.get(0).getMarketPrice());
                    ebProductNew.setCostPrice(min.get(0).getSupplyPrice());
                    ebProductNew.setSellPrice(min.get(0).getDetailPrices());
                    ebProductNew.setReturnRatio(min.get(0).getReturnRatio());
                }
            }
        }

        Collection<PmProductStandardDetail> values = deleteStanderMap.values();
        if (deleteStanderMap.size() > 0) {
            //删除已经移除
            String ids = FormatUtil.getFieldAllValue(values.iterator(), "id");
            pmProductStandardDetailService.deleteByIds(ids);
        }
        //把已经删除的规格也加入到修改规格列表中
        Iterator<PmProductStandardDetail> iterator = values.iterator();
        while (iterator.hasNext()) {
            changeStanderList.add(iterator.next());
        }

        //把购物车的状态设置成失效
        String propertyIds = FormatUtil.getFieldAllValue(changeStanderList, "id");
        if (StringUtil.isNotBlank(propertyIds)) {
            ebShoppingcartService.updateStatusByPropertyIds(2, propertyIds);
        }


        DictUtils dictUtils = new DictUtils();
        double gainLove = 0.00;
        if ("2".equals(measuringType) || "1".equals(li2)) {
            gainLove = (ebProduct.getSellPrice() * ebProduct.getSellPrice() / 100) / Double.parseDouble(dictUtils.getDictValue("InLove_One", "gyconfig", ""));
        } else {
            List<PmProductStandardDetail> min = pmProductStandardDetailService.getProductIdPmProductStandardMinimum(ebProduct.getProductId().toString());
            if (min != null && min.size() > 0) {
                gainLove = (min.get(0).getDetailPrices() * min.get(0).getReturnRatio() / 100) / Double.parseDouble(dictUtils.getDictValue("InLove_One", "gyconfig", ""));
            }
        }
        ebProductNew.setGainLove(gainLove);
        ebProductService.saveProduct(ebProductNew);
        //保存加料明细
        if (StringUtils.isNotBlank(productChargingIds) && ebProduct.getProductId() != null) {
            ebProductChargingItemService.saveItems(ebProduct, productChargingIds);
        }

        List<PmProductStandardDetail> pmProductStandardDetailList = pmProductStandardDetailService.getByProductId(ebProduct.getProductId());

        //循环保存商家商品多规格关联信息列表
        if(pmProductStandardDetailList.size() > 0) {
            //商家商品多规格关联信息列表
            List<EbShopProductStandardDetail> ebShopProductStandardDetailList = new ArrayList();
//				店家id数组
            String[] shopIdArr = {pmShopInfo.getId() + ""};

            for (int i = 0; i < shopIdArr.length; i++) {
                for (PmProductStandardDetail p : pmProductStandardDetailList) {
                    EbShopProductStandardDetail e = new EbShopProductStandardDetail();

                    e.setCreateTime(new Date());
                    e.setDetailInventory(p.getDetailInventory());
                    e.setDetailPrices(p.getDetailPrices());
                    e.setMemberPrice(p.getMemberPrice());
                    e.setProductId(p.getProductId());
                    e.setProductStandardId(p.getId());
                    e.setShopId(Integer.parseInt(shopIdArr[i]));
                    e.setCost(0.0);

                    //增加到列表
                    ebShopProductStandardDetailList.add(e);
                }

            }

            //批量保存
            boolean reuslt = ebShopProductStandardDetailService.batchSave(ebShopProductStandardDetailList);
        }
        //不清楚原有的门店
        List<Integer> oldShopIdList = new ArrayList();
        //保存商品所属门店
        boolean flag = false;
        Integer measuringTypeNum = StringUtil.isNotBlank(measuringType)? Integer.valueOf(measuringType):null;
        Integer measuringUnitNum = StringUtil.isNotBlank(measuringUnit)? Integer.valueOf(measuringUnit):null;
        flag = ebShopProductService.saveByShop(pmProductStandardDetails, ebProduct);
        json.put("code", "00");
        json.put("msg", "保存商品成功");
        return json;
    }

    /**
     * 添加前展示商铺类别
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @RequestMapping(value = "/addProduct")
    public String addProduct(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        List<PmProductType> pmProductTypes = new ArrayList<PmProductType>();
        PmShopCooperType pmShopCooperType = new PmShopCooperType();
        pmShopCooperType.setShopId(ebUser.getShopId());
        List<PmShopCooperType> cooperTypes = pmShopCooperTypeService.getShopList(pmShopCooperType);
        for (PmShopCooperType pmShopCooperType2 : cooperTypes) {
            PmProductType pmProductType = pmProductTypeService.getID(pmShopCooperType2.getProductTypeId());
            pmProductTypes.add(pmProductType);
        }
        PmLovePayDeploy lovePayEffectType = new PmLovePayDeploy();
        lovePayEffectType.setLovePayEndDate(new Date());
        List<PmLovePayDeploy> pmLovePayDeploys = pmLovePayDeployService.findPmLovePayDeployLists(lovePayEffectType);
        model.addAttribute("pmLovePayDeploys", pmLovePayDeploys);
        model.addAttribute("pmProductTypes", pmProductTypes);
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId().toString());
        model.addAttribute("pmShopInfo", pmShopInfo);
        PmShopProductType pmShopProductType = new PmShopProductType();
        pmShopProductType.setShopId(ebUser.getShopId());
        pmShopProductType.setLevel(1);
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService.getList(pmShopProductType);
        for (PmShopProductType pmShopProductType2 : pmShopProductTypes) {
            PmShopProductType pmShopProductType3 = new PmShopProductType();
            pmShopProductType3.setShopId(ebUser.getShopId());
            pmShopProductType3.setParentId(pmShopProductType2.getId());
            List<PmShopProductType> pmShopProductTypes2 = pmShopProductTypeService.getList(pmShopProductType3);
            pmShopProductType2.setPmShopProductTypes(pmShopProductTypes2);
        }
        createPicFold(request, "");
        model.addAttribute("pmShopProductTypes", pmShopProductTypes);
        model.addAttribute("pic", "/temp");//新添加商品图片临时路径
        return "modules/shop/release-comm-step";
    }

    /**
     * 商品分类
     *
     * @param id
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/productType")
    public List productType(String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        List<PmProductType> productTypes = new ArrayList<PmProductType>();
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (StringUtils.isNotBlank(id)) {
            productTypes = pmProductTypeService.getShopProductTypeList(ebUser.getShopId() + "", id);
            for (PmProductType pmProductType : productTypes) {
                List<PmProductType> productTypes2 = pmProductTypeService.getShopProductTypeList(ebUser.getShopId() + "", pmProductType.getId().toString());
                pmProductType.setPmProductTypes(productTypes2);
            }
        }
        return productTypes;
    }

    /**
     * 规格属性
     *
     * @param id
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/commerciale")
    public List commerciale(String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        List<PmProductTypeSpertAttr> pmProductTypeSpertAttrs = new ArrayList<PmProductTypeSpertAttr>();
        if (StringUtils.isNotBlank(id)) {
            PmProductTypeSpertAttr pmProductTypeSpertAttr = new PmProductTypeSpertAttr();
            pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(id));
            pmProductTypeSpertAttr.setIsPublic(-1);
            pmProductTypeSpertAttr.setShopId(ebUser.getShopId());
            pmProductTypeSpertAttrs = pmProductTypeSpertAttrService.getPmProductTypeSpertAttrProductTypeId(pmProductTypeSpertAttr);

            //获取上级（第二级）属性
            PmProductType pmProductType = pmProductTypeService
                    .getSbProductType(id);
            if (pmProductType.getParentId() != null) {
                //获取属性值
                pmProductTypeSpertAttr.setProductTypeId(pmProductType.getParentId());
                pmProductTypeSpertAttr.setIsPublic(-1);
                pmProductTypeSpertAttr.setShopId(ebUser.getShopId());
                List<PmProductTypeSpertAttr> pmProductTypeSpertAttrs1 = pmProductTypeSpertAttrService
                        .getPmProductTypeSpertAttrProductTypeId(pmProductTypeSpertAttr);
                if (pmProductTypeSpertAttrs1 != null && pmProductTypeSpertAttrs1.size() > 0) {
                    pmProductTypeSpertAttrs.addAll(pmProductTypeSpertAttrs1);
                }

            }
            if (pmProductTypeSpertAttrs != null && pmProductTypeSpertAttrs.size() > 0) {
                for (PmProductTypeSpertAttr pmProductTypeSpertAttr1 : pmProductTypeSpertAttrs) {
                    PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
                    pmProductTypeSpertAttrValue.setShopId(ebUser.getShopId());
                    pmProductTypeSpertAttrValue.setSpertAttrId(pmProductTypeSpertAttr1.getId());
                    List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = productTypeSpertAttrValueService.getList(pmProductTypeSpertAttrValue);
                    pmProductTypeSpertAttr1.setPmProductTypeSpertAttrValues(pmProductTypeSpertAttrValues);
                }
            }
        }
        return pmProductTypeSpertAttrs;
    }

    /**
     * 品牌
     *
     * @param id
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/productTypeBrand")
    public List productTypeBrand(String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        List<PmProductTypeBrand> pmProductTypeBrands = new ArrayList<PmProductTypeBrand>();
        if (StringUtils.isNotBlank(id)) {
            PmProductType pmProductType = pmProductTypeService.getSbProductType(id);
            PmProductTypeBrand productTypeBrand = new PmProductTypeBrand();
            productTypeBrand.setProductTypeId(pmProductType.getParentId());
            pmProductTypeBrands = pmProductTypeBrandService.getList(productTypeBrand);
        }
        return pmProductTypeBrands;
    }

    /**
     * 类别单个
     *
     * @param id
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/productTypeId")
    public String productTypeId(String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        String ptyName = "";
        PmProductType pmProductType = pmProductTypeService.getSbProductType(id);
        if (pmProductType != null) {
            ptyName += pmProductType.getProductTypeName() + "<";
            PmProductType pmProductType2 = pmProductTypeService.getSbProductType(pmProductType.getParentId().toString());
            if (pmProductType2 != null) {
                ptyName += pmProductType2.getProductTypeName() + "<";
                PmProductType pmProductType3 = pmProductTypeService.getSbProductType(pmProductType2.getParentId().toString());
                if (pmProductType3 != null) {
                    ptyName += pmProductType3.getProductTypeName() + "";
                }
            }
        }
        return ptyName;
    }

    @RequestMapping(value = "/shopProductType")
    public String shopProductType(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        }
        PmShopProductType pmShopProductType = new PmShopProductType();
        pmShopProductType.setShopId(ebUser.getShopId());
        pmShopProductType.setLevel(1);
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService.getList(pmShopProductType);
        for (PmShopProductType pmShopProductType2 : pmShopProductTypes) {
            PmShopProductType pmShopProductType3 = new PmShopProductType();
            pmShopProductType3.setShopId(ebUser.getShopId());
            pmShopProductType3.setParentId(pmShopProductType2.getId());
            List<PmShopProductType> pmShopProductTypes2 = pmShopProductTypeService.getList(pmShopProductType3);
            pmShopProductType2.setPmShopProductTypes(pmShopProductTypes2);
        }
        model.addAttribute("pmShopProductTypes", pmShopProductTypes);
        return "modules/shop/input";
    }

    /**
     * 添加商店类别
     *
     * @param select
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/shopProductTypeAdd")
    public String shopProductTypeAdd(String select, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        select = select.replaceAll("&quot;", "\"");
        System.out.println(select);
        JSONArray jsStr = JSONArray.parseArray(select);
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopProductType pmShopProductType = new PmShopProductType();
        pmShopProductType.setShopId(ebUser.getShopId());
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService.getList(pmShopProductType);
        if (pmShopProductTypes != null && pmShopProductTypes.size() > 0) {
            for (PmShopProductType pmShopProductType2 : pmShopProductTypes) {
                pmShopProductTypeService.delete(pmShopProductType2);
            }
        } else {

        }
        for (int i = 0; i < jsStr.size(); i++) {
            JSONObject json = JSONObject.fromObject(jsStr.get(i));
            PmShopProductType pmShopProductType3 = new PmShopProductType();
            if (StringUtils.isNotBlank(json.getString("aa"))) {
                pmShopProductType3.setProductTypeName(json.getString("aa"));
                pmShopProductType3.setCreateTime(new Date());
                pmShopProductType3.setCreateUser(ebUser.getUsername());
                pmShopProductType3.setLevel(1);
                pmShopProductType3.setModifyTime(new Date());
                pmShopProductType3.setModifyUser(ebUser.getUsername());
                pmShopProductType3.setParentId(0);
                pmShopProductType3.setOrderNo(1);
                pmShopProductType3.setProductTypeNameStr(json.getString("aa"));
                pmShopProductType3.setShopId(ebUser.getShopId());
                pmShopProductTypeService.save(pmShopProductType3);
                JSONArray jsSta = JSONArray.parseArray(json.get("cc").toString());
                for (int j = 0; j < jsSta.size(); j++) {
                    if (StringUtils.isNotBlank(jsSta.get(j).toString())) {
                        PmShopProductType pmShopProductType4 = new PmShopProductType();
                        pmShopProductType4.setOrderNo(1);
                        pmShopProductType4.setProductTypeName(jsSta.get(j).toString());
                        pmShopProductType4.setCreateTime(new Date());
                        pmShopProductType4.setCreateUser(ebUser.getUsername());
                        pmShopProductType4.setLevel(2);
                        pmShopProductType4.setModifyTime(new Date());
                        pmShopProductType4.setModifyUser(ebUser.getUsername());
                        pmShopProductType4.setParentId(pmShopProductType3.getId());
                        pmShopProductType4.setProductTypeNameStr(json.getString("aa") + "->" + jsSta.get(j));
                        pmShopProductType4.setShopId(ebUser.getShopId());
                        pmShopProductTypeService.save(pmShopProductType4);
                    }
                }
            }
        }
        return "00";
    }

    //查询规格明细
    @ResponseBody
    @RequestMapping(value = "/commercialeDetail")
    public List commercialeDetail(String id, String productId, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = new ArrayList<PmProductTypeSpertAttrValue>();
        if (StringUtils.isNotBlank(id)) {
            EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
            pmProductTypeSpertAttrValue.setShopId(ebUser.getShopId());
            pmProductTypeSpertAttrValue.setSpertAttrId(Integer.parseInt(id));
            if (StringUtils.isNotBlank(productId)) {
                pmProductTypeSpertAttrValue.setProductId(Integer.parseInt(productId));
            }
            pmProductTypeSpertAttrValues = productTypeSpertAttrValueService.getpsList(pmProductTypeSpertAttrValue);
        }
        return pmProductTypeSpertAttrValues;
    }

    /**
     * 国家code
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/oneji")
    public List oneji(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        PmSysDistrict pmSysDistrict = new PmSysDistrict();
        pmSysDistrict.setDisLevel(0);
        List<PmSysDistrict> pmSysDistricts = pmSysDistrictService.getDistrictOne(pmSysDistrict);
        return pmSysDistricts;
    }

    /**
     * 国家id
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/onejij")
    public List onejij(HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        PmSysDistrict pmSysDistrict = new PmSysDistrict();
        pmSysDistrict.setDisLevel(0);
        List<PmSysDistrict> pmSysDistricts = pmSysDistrictService.getDistrictOne(pmSysDistrict);
        return pmSysDistricts;
    }

    /**
     * 省市code
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/towji")
    public List towji(String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        PmSysDistrict pmSysDistrictsy = new PmSysDistrict();
        pmSysDistrictsy.setDistrictCode(id);
        PmSysDistrict pmSysDistrictsyl = pmSysDistrictService.getDistrictOneMo(id);
        PmSysDistrict pmSysDistrict = new PmSysDistrict();
        List<PmSysDistrict> pmSysDistricts = new ArrayList<PmSysDistrict>();
        if (pmSysDistrictsyl != null) {
            pmSysDistrict.setParentId(pmSysDistrictsyl.getId());
            pmSysDistricts = pmSysDistrictService.getDistrictOne(pmSysDistrict);
        }
        return pmSysDistricts;
    }

    /**
     * 省市id
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/towjij")
    public List towjij(String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        List<PmSysDistrict> pmSysDistricts = new ArrayList<PmSysDistrict>();
        if (StringUtils.isNotBlank(id)) {
            PmSysDistrict pmSysDistrictsy = new PmSysDistrict();
            pmSysDistrictsy.setId(Integer.parseInt(id));
            PmSysDistrict pmSysDistrictsyl = pmSysDistrictService.findId(id);
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            if (pmSysDistrictsyl != null) {
                pmSysDistrict.setParentId(pmSysDistrictsyl.getId());
                pmSysDistricts = pmSysDistrictService.getDistrictOne(pmSysDistrict);
            }
        }
        return pmSysDistricts;
    }

    //ID外的明细值
    @ResponseBody
    @RequestMapping(value = "/commercialeDehors")
    public List commercialeDehors(String ids, String id, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        List<PmProductTypeSpertAttr> pmProductTypeSpertAttrs = new ArrayList<PmProductTypeSpertAttr>();
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (StringUtils.isNotBlank(ids)) {
            pmProductTypeSpertAttrs = pmProductTypeSpertAttrService.getPmProductTypeSpertAttrNotProductTypeId(ids, id);
            if (pmProductTypeSpertAttrs != null && pmProductTypeSpertAttrs.size() > 0) {
                for (PmProductTypeSpertAttr pmProductTypeSpertAttr1 : pmProductTypeSpertAttrs) {
                    PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
                    pmProductTypeSpertAttrValue.setShopId(ebUser.getShopId());
                    pmProductTypeSpertAttrValue.setSpertAttrId(pmProductTypeSpertAttr1.getId());
                    List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = productTypeSpertAttrValueService.getList(pmProductTypeSpertAttrValue);
                    pmProductTypeSpertAttr1.setPmProductTypeSpertAttrValues(pmProductTypeSpertAttrValues);
                }
            }
        }
        return pmProductTypeSpertAttrs;
    }

    //添加规格值
    //ID外的明细值
    @ResponseBody
    @RequestMapping(value = "/addcommercialeDehors")
    public List addcommercialeDehors(String values, String typeId, String productId, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = new ArrayList<PmProductTypeSpertAttrValue>();
        if (StringUtils.isNotBlank(typeId)) {
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
            EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
            pmProductTypeSpertAttrValue.setCreateTime(new Date());
            pmProductTypeSpertAttrValue.setCreateUser(ebUser.getUsername());
            pmProductTypeSpertAttrValue.setModifyTime(new Date());
            pmProductTypeSpertAttrValue.setOrderNo(1);
            pmProductTypeSpertAttrValue.setModifyUser(ebUser.getUsername());
            pmProductTypeSpertAttrValue.setShopId(ebUser.getShopId());
            pmProductTypeSpertAttrValue.setSpertAttrId(Integer.parseInt(typeId));
            pmProductTypeSpertAttrValue.setSpertAttrValue(values);
            if (StringUtils.isNotBlank(productId)) {
                pmProductTypeSpertAttrValue.setProductId(Integer.parseInt(productId));
            }
            productTypeSpertAttrValueService.save(pmProductTypeSpertAttrValue);
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue2 = new PmProductTypeSpertAttrValue();
            pmProductTypeSpertAttrValue2.setSpertAttrId(Integer.parseInt(typeId));
            pmProductTypeSpertAttrValue2.setShopId(ebUser.getShopId());
            if (StringUtils.isNotBlank(productId)) {
                pmProductTypeSpertAttrValue2.setProductId(Integer.parseInt(productId));
            }
            pmProductTypeSpertAttrValues = productTypeSpertAttrValueService.getpsList(pmProductTypeSpertAttrValue2);
        }
        return pmProductTypeSpertAttrValues;
    }

    //删除规格值
    //ID外的明细值
    @ResponseBody
    @RequestMapping(value = "/deletecommercialeDehors")
    public JSONObject deletecommercialeDehors(String typeId, String productId, HttpServletRequest request, HttpServletResponse response, Model model) throws JsonProcessingException {
        JSONObject json = new JSONObject();
        json.put("code", "01");
        json.put("msg", "失败");
        if (StringUtils.isNotBlank(typeId)) {
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = productTypeSpertAttrValueService.getSbProductTypeSpertAttrValue(typeId);
            if (pmProductTypeSpertAttrValue != null) {
                if (pmProductTypeSpertAttrValue.getShopId() != null && pmProductTypeSpertAttrValue.getSpertAttrId() != null) {
                    if (StringUtils.isNotBlank(productId)) {
                        List<PmProductStandardDetail> details = pmProductStandardDetailService.getProductIdPmProductStandardDetail(productId);
                        if (details != null && details.size() > 0) {
                            for (PmProductStandardDetail pmProductStandardDetail : details) {
                                String idsr = "";
                                String idsrNme = "";
                                String ids[] = pmProductStandardDetail.getStandardIdStr().split(";");
                                String idsN[] = pmProductStandardDetail.getStandardValueStr().split(";");
                                for (int i = 0; i < ids.length; i++) {
                                    if (!ids[i].equals(pmProductTypeSpertAttrValue.getSpertAttrId() + ":" + pmProductTypeSpertAttrValue.getId())) {
                                        idsr += ids[i] + ";";
                                    }
                                    if (pmProductTypeSpertAttrValue.getSpertAttrId() != null) {
                                        PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(pmProductTypeSpertAttrValue.getSpertAttrId().toString());
                                        if (!idsN[i].equals(pmProductTypeSpertAttr.getSpertAttrName() + ":" + pmProductTypeSpertAttrValue.getSpertAttrValue())) {
                                            idsrNme += idsN[i] + ";";
                                        }
                                    }
                                }
                                if (StringUtils.isNotBlank(idsr)) {
                                    idsr = idsr.substring(0, idsr.length() - 1);
                                    idsrNme = idsrNme.substring(0, idsrNme.length() - 1);
                                    pmProductStandardDetail.setStandardIdStr(idsr);
                                    pmProductStandardDetail.setStandardValueStr(idsrNme);
                                    pmProductStandardDetailService.save(pmProductStandardDetail);
                                } else {
                                    pmProductStandardDetailService.delete(pmProductStandardDetail);
                                }
                            }
                        }
                    }
                    productTypeSpertAttrValueService.delete(pmProductTypeSpertAttrValue);
                    json.put("code", "00");
                    json.put("msg", "删除成功");
                    return json;
                } else {
                    json.put("code", "01");
                    json.put("msg", "删除失败");
                    return json;
                }
            } else {
                json.put("code", "01");
                json.put("msg", "已删除");
                return json;
            }
        }
        return json;
    }

    private String createPicFold(HttpServletRequest request, String productId) {
        String root = request.getSession().getServletContext().getRealPath("/");
        StringBuffer folder = new StringBuffer(root);
        folder.append(uploads);
        folder.append(File.separator);
        // ===========集群文件处理 start===============
        String wfsName = Global.getConfig("wfsName");
        if (StringUtils.isNotBlank(wfsName)) {
            folder.append(wfsName);
            folder.append(File.separator);
        }
        String userShopId = "";
        // ===========集群文件字段处理 end===============
        if (request.getSession().getAttribute("userShopId") != null) {
            userShopId = (String) request.getSession().getAttribute("userShopId");
        }
        folder.append(userShopId);
        folder.append(File.separator);
        folder.append("images");
        folder.append(File.separator);
        if (StringUtils.isNotBlank(productId)) {
            ymd = DateUtils.getYear() + DateUtils.getMonth() + DateUtils.getDay();
            folder.append(productId);
            folder.append(File.separator);
            folder.append(ymd);
            folder.append(File.separator);
        } else {
            folder.append("temp");
            folder.append(File.separator);
        }
        FileUtils.createDirectory(folder.toString());
        return folder.toString();
    }
}