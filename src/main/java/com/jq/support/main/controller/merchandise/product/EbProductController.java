package com.jq.support.main.controller.merchandise.product;

import java.io.File;
import java.io.FileOutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alipay.api.domain.ShopInfo;
import com.jq.support.dao.redis.JedisPoolTilems;
import com.jq.support.dao.redis.SerializeUtil;
import com.jq.support.model.certificate.EbCertificateApplyRemark;
import com.jq.support.model.certificate.EbCertificateUser;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.model.product.*;
import com.jq.support.model.shop.PmBusinessStatistics;
import com.jq.support.service.certificate.EbCertificateApplyRemarkService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.utils.*;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.certificate.EbCertificate;
import com.jq.support.model.certificate.EbCertificateLocation;
import com.jq.support.model.merchandise.utilentity.SpreIdName;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.pay.PmLovePayDeploy;
import com.jq.support.model.region.PmSysDistrict;
import com.jq.support.model.shop.PmShopFreightTem;
import com.jq.support.model.shop.PmShopProductType;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.certificate.EbCertificateLocationService;
import com.jq.support.service.certificate.EbCertificateService;
import com.jq.support.service.certificate.EbCertificateUserService;
import com.jq.support.service.merchandise.mecontent.EbLabelService;
import com.jq.support.service.merchandise.mecontent.PmSysDistrictService;
import com.jq.support.service.merchandise.shop.PmShopCooperTypeService;
import com.jq.support.service.merchandise.shop.PmShopFreightTemService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.shop.PmShopProductTypeService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.pay.PmLovePayDeployService;
import com.yeepay.shade.org.springframework.web.bind.annotation.InitBinder;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.ShardedJedisPool;

/**
 * 商品Controller
 *
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/Product")
public class EbProductController extends BaseController {
    private static Logger logger = LoggerFactory
            .getLogger(EbProductController.class);
    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private EbLabelService ebLabelService;
    @Autowired
    private EbMessageService ebMessageService;
    @Autowired
    private EbMessageUserService messageInfoUserService;
    @Autowired
    private PmSysDistrictService pmSysDistrictService;
    @Autowired
    private PmProductTypeBrandService pmProductTypeBrandService;
    @Autowired
    private PmProductTypeSpertAttrService pmProductTypeSpertAttrService;
    @Autowired
    private PmProductTypeSpertAttrValueService productTypeSpertAttrValueService;
    @Autowired
    private PmShopFreightTemService pmShopFreightTemService;
    @Autowired
    private PmProductPropertyStandardService pmProductPropertyStandardService;
    @Autowired
    private PmProductStandardDetailService pmProductStandardDetailService;
    @Autowired
    private PmShopProductTypeService pmShopProductTypeService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private EbUserService ebUserService;
    @Autowired
    private PmLovePayDeployService pmLovePayDeployService;
    @Autowired
    private PmShopCooperTypeService pmShopCooperTypeService;
    @Autowired
    private EbProductFreightModelService ebProductFreightModelService;
    @Autowired
    private EbBlockTradingService ebBlockTradingService;
    @Autowired
    private EbCertificateService ebCertificateService;
    @Autowired
    private EbCertificateUserService ebCertificateUserService;
    @Autowired
    private EbCertificateLocationService ebCertificateLocationService;
    @Autowired
    private EbProductChargingItemService ebProductChargingItemService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private EbShopProductService ebShopProductService;
    @Autowired
    private EbShopProductStandardDetailService ebShopProductStandardDetailService;
    @Autowired
    private EbShoppingcartService ebShoppingcartService;
    @Autowired
    private EbCertificateApplyRemarkService ebCertificateApplyRemarkService;
    @Autowired
    private PmOpenPayWayService pmOpenPayWayService;
    @Autowired
    private JedisPoolTilems jedisPoolTilems;
//    @Autowired
//    private ShardedJedisPool shardedJedisPool;

    private static String domainurl = Global.getConfig("domainurl");

    @ModelAttribute
    public EbProduct get(@RequestParam(required = false) String productId) {
        if (org.apache.commons.lang3.StringUtils.isNotBlank(productId)) {
            return ebProductService.getEbProduct(productId);
        } else {
            return new EbProduct();
        }
    }

    /**
     * 商品列表
     * @param ebProduct
     * @param shopType 门店类型,1自营 2其他
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
    @RequiresPermissions("merchandise:pro:view")
    @RequestMapping(value = { "list", "" })
    public String getProductList( EbProduct ebProduct,Integer shopType,String stule,
                                  String statrPrice, String stopPrice, String statrDate,
                                  String stopDate, String priceType, String podateType,
                                  String isLovePay, HttpServletRequest request,
                                  HttpServletResponse response, Model model, @RequestParam(defaultValue = "1") Integer findType ,
                                  Integer isAllShop , String chooseShopId) {
        String productTags = request.getParameter("productTags");
        SysUser currentUser = SysUserUtils.getUser();
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

            Page<Object> page = null;
            List<PmShopInfo> pmShopInfoList = null; //门店列表
            List<EbProduct> ebProductList = null;   //商品列表
            List<EbShopProduct> ebShopProductList = null;   //商家商品价格关联信息列表

            /**根据门店展示商品**/
            if(findType == 0){
                List<Object> resultList = null;
                resultList = ebShopProductService.getResultListByShop(
                        currentUser, ebProduct, new Page<Object>(request,
                                response), podateType, statrDate, stopDate, "", "",
                        priceType, statrPrice, stopPrice, shopType, chooseShopId);

                /**
                 * 解析返回结果
                 */
                if(resultList != null && resultList.size() > 0){
                    page = (Page<Object> )resultList.get(0);
                    ebProductList = ( List<EbProduct>)resultList.get(1);
                    pmShopInfoList = ( List<PmShopInfo>)resultList.get(2);
                    ebShopProductList = ( List<EbShopProduct>)resultList.get(3);
                }

                model.addAttribute("pmShopInfoList",pmShopInfoList);
                model.addAttribute("ebShopProductList",ebShopProductList);
            }else{  /**根据商品展示商品**/
                List<Object>  resultList = ebShopProductService.getEbProductListByProduct(
                        currentUser, ebProduct, new Page<Object>(request,
                                response), podateType, statrDate, stopDate, "", "",
                        priceType, statrPrice, stopPrice,shopType);


                if(resultList != null && resultList.size() > 0){
                    page = (Page<Object> )resultList.get(0);
                    ebProductList = ( List<EbProduct>)resultList.get(1);
                }
            }


            if (ebProduct.getProductTypeId() != null) {
                PmProductType pmProductType = pmProductTypeService
                        .getSbProductType(ebProduct.getProductTypeId()
                                .toString());
                model.addAttribute("sbProductType", pmProductType);
            }
            if(page.getList()!=null){
                for(EbProduct eProduct:ebProductList){
                    ebProduct= ebProductService.getProduct(eProduct);
                    Map map=pmProductStandardDetailService.PmProductStandardDetailCountSum(eProduct.getProductId());
                    if(map.get("count")!=null){
                        ebProduct.setStoreNums(Integer.parseInt((map.get("sumDetailInventory")+"")));
                    }
                }
            }
            model.addAttribute("shopType", shopType);
            model.addAttribute("findType", findType);
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
            model.addAttribute("ebProductList",ebProductList);
            model.addAttribute("isAllShop",isAllShop);

//            Jedis jedis = jedisPoolTilems.getResource();
//            jedis.set("ppp","11111");
//            jedis.set("key1".getBytes(), SerializeUtil.serialize(page));
//            jedis.expire("key1".getBytes() , 100);
            //获取ShardedJedis对象
//            ShardedJedis shardJedis = shardedJedisPool.getResource();
            //存入键值对
//            shardJedis.set("key1","hello jedis");
            //回收ShardedJedis实例
//            shardJedis.close();
        }
        return "modules/shopping/brands/Productlist";
    }

    /**
     *优惠券日志
     */
    @RequiresPermissions("merchandise:user:view")
    @RequestMapping(value = "/certificateLoglist")
    public String getCertificateLogList(EbCertificateUser ebCertificateUser,
                                        HttpServletRequest request, HttpServletResponse response,
                                        Model model, @ModelAttribute("msg") String msg,
                                        String serviceTime) {
//        model.get("userId");
        String userIdStr = request.getParameter("user_id");
        Integer userId = userIdStr != null && !"".equals(userIdStr) ? Integer.parseInt(userIdStr) : null;
        ebCertificateUser.setUserId(userId);

        Object[] objects= ebCertificateService.getCertificateLogList(ebCertificateUser , new Page<EbCertificateUser>(request, response) , serviceTime);
        Page<EbCertificateUser> page = (Page<EbCertificateUser>) objects[0];
        List<EbOrder> orderList = (List<EbOrder>) objects[1];

// System.out.println(request.getParameter("startDate"));
//		System.out.println(page);
        model.addAttribute("page", page);
        model.addAttribute("orderList", orderList);
        model.addAttribute("msg", msg);
        model.addAttribute("certificate", ebCertificateUser);
        model.addAttribute("serviceTime", serviceTime);
        model.addAttribute("userId", ebCertificateUser.getUserId());
        return "modules/shopping/brands/EbCertificateLog";
    }


    @RequiresPermissions("merchandise:pro:view")
    @RequestMapping(value = "supplylist")
    public String getSupplyProductList(EbProduct ebProduct, String stule,
                                       String statrPrice, String stopPrice, String statrDate,
                                       String stopDate, String priceType, String podateType,
                                       String isLovePay, HttpServletRequest request,
                                       HttpServletResponse response, Model model) {

        if (StringUtils.isNotBlank(isLovePay)) {
            ebProduct.setIsLovePay(Integer.valueOf(isLovePay));
        }
        Page<EbProduct> page = ebProductService.getEbProductList(null,
                ebProduct, new Page<EbProduct>(request, response), podateType,
                statrDate, stopDate, "", "", priceType, statrPrice, stopPrice,null);
        if (ebProduct.getProductTypeId() != null) {
            PmProductType pmProductType = pmProductTypeService
                    .getSbProductType(ebProduct.getProductTypeId().toString());
            model.addAttribute("sbProductType", pmProductType);
        }

        model.addAttribute("page", page);
        model.addAttribute("stule", stule);
        model.addAttribute("podateType", podateType);
        model.addAttribute("priceType", priceType);
        model.addAttribute("statrPrice", statrPrice);
        model.addAttribute("stopPrice", stopPrice);
        model.addAttribute("statrDate", statrDate);
        model.addAttribute("stopDate", stopDate);

        return "modules/shopping/supplyproduct/Productlist";
    }

    /**
     * 积分商城
     *
     * @param ebProduct
     * @param stule
     * @param statrPrice
     * @param stopPrice
     * @param statrDate
     * @param stopDate
     * @param priceType
     * @param podateType
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:pro:view")
    @RequestMapping(value = "Orderlist")
    public String getProductOrderList(EbProduct ebProduct, String stule,
                                      String statrPrice, String stopPrice, String statrDate,
                                      String stopDate, String priceType, String podateType,
                                      String lovePayMinRatio, String lovePayMaxRatio,
                                      HttpServletRequest request, HttpServletResponse response,
                                      Model model, RedirectAttributes redirectAttributes) {
        String productTags = request.getParameter("productTags");
        SysUser currentUser = SysUserUtils.getUser();
        SysUser user = SysUserUtils.getUser();
        SysOffice sysOffice = user.getCompany();
        ebProduct.setIsLovePay(1);
        if (sysOffice != null) {
            String shopId = request.getParameter("shopId");
            if (StringUtils.isNotBlank(shopId)) {
                ebProduct.setShopId(Integer.parseInt(shopId));
            }
            if (StringUtils.isNotBlank(productTags)) {
                ebProduct.setProductTags(productTags);
            }
            if (StringUtils.isNotBlank(lovePayMaxRatio)) {
                ebProduct.setLovePayMaxRatio(Double
                        .parseDouble(lovePayMaxRatio));
            }
            if (StringUtils.isNotBlank(lovePayMinRatio)) {
                ebProduct.setLovePayMinRatio(Double
                        .parseDouble(lovePayMinRatio));
            }
            ebProduct.setAgentId(sysOffice.getId());
            Page<EbProduct> page = ebProductService.getEbProductList(
                    currentUser, ebProduct, new Page<EbProduct>(request,
                            response), podateType, statrDate, stopDate, "", "",
                    priceType, statrPrice, stopPrice,null);
            for (EbProduct ebProduct2 : page.getList()) {
                String OnThePrice = "";
                List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                        .getProductIdPmProductStandardDetail(ebProduct2
                                .getProductId().toString());
                if (pmProductStandardDetails != null
                        && pmProductStandardDetails.size() > 0) {
                    Integer mus = 0;
                    List<PmProductStandardDetail> max = pmProductStandardDetailService
                            .getProductIdPmProductStandardMaximum(ebProduct2
                                    .getProductId().toString());
                    for (PmProductStandardDetail pmProductStandardDetail : max) {
                        mus += pmProductStandardDetail.getDetailInventory();
                    }
                    ebProduct.setStoreNums(mus);
                    List<PmProductStandardDetail> min = pmProductStandardDetailService
                            .getProductIdPmProductStandardMinimum(ebProduct2
                                    .getProductId().toString());
                    if (max != null && max.size() > 0 && min != null
                            && min.size() > 0) {
                        if (min.get(0).getDetailPrices() == max.get(0)
                                .getDetailPrices()) {
                            ebProduct2.setReasonablePrice(min.get(0)
                                    .getDetailPrices() + "");
                            OnThePrice = min.get(0).getDetailPrices()
                                    * min.get(0).getReturnRatio() / 100 + "";
                        } else {
                            ebProduct2.setReasonablePrice(min.get(0)
                                    .getMarketPrice() + "");
                            OnThePrice = min.get(0).getDetailPrices()
                                    * min.get(0).getReturnRatio() / 100 + "";
                        }
                    }
                } else {
                    ebProduct2.setReasonablePrice(ebProduct2.getCostPrice()
                            + "");
                    OnThePrice = ebProduct2.getCostPrice()
                            * ebProduct2.getReturnRatio() / 100 + "";
                }
                String rewardDeeds = CountMoney.PriceTreasurett(OnThePrice);
                ebProduct2.setRewardDeeds(rewardDeeds);
            }
            if (ebProduct.getProductTypeId() != null) {
                PmProductType pmProductType = pmProductTypeService
                        .getSbProductType(ebProduct.getProductTypeId()
                                .toString());
                model.addAttribute("sbProductType", pmProductType);
            }
            model.addAttribute("productTags", productTags);
            model.addAttribute("shopId", shopId);
            model.addAttribute("page", page);
            model.addAttribute("stule", stule);
            model.addAttribute("lovePayMinRatio", lovePayMinRatio);
            model.addAttribute("lovePayMaxRatio", lovePayMaxRatio);
            model.addAttribute("podateType", podateType);
            model.addAttribute("priceType", priceType);
            model.addAttribute("statrPrice", statrPrice);
            model.addAttribute("stopPrice", stopPrice);
            model.addAttribute("statrDate", statrDate);
            model.addAttribute("stopDate", stopDate);
        }
        return "modules/shopping/brands/ProductOrderlist";
    }

    /**
     * 批量设置流向
     *
     * @param ebProduct
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:pro:edit")
    @ResponseBody
    @RequestMapping(value = "getliu")
    public JSONObject getliu(EbProduct ebProduct, HttpServletRequest request,
                             HttpServletResponse response, Model model,
                             RedirectAttributes redirectAttributes) {
        JSONObject json = new JSONObject();
        String ktvs[] = request.getParameterValues("ktvs");
        String lovePayGains = request.getParameter("lovePayGains");
        if (ktvs != null && ktvs.length > 0) {
            for (int i = 0; i < ktvs.length; i++) {
                if (StringUtils.isNotBlank(ktvs[i])) {
                    EbProduct product = ebProductService.getEbProduct(ktvs[i]);
                    if (product != null) {
                        if (StringUtils.isNotBlank(lovePayGains)) {
                            product.setLovePayGain(Integer
                                    .parseInt(lovePayGains));
                            ebProductService.saveProduct(product);
                        }

                    }
                }
            }
        } else {
            json.put("code", "01");
            json.put("msg", "至少选择选择一个");
            return json;
        }
        json.put("code", "00");
        json.put("msg", "成功");
        return json;
    }
    /**
     * 添加商品页
     * @param ebProduct
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "form")
    public String from(EbProduct ebProduct, HttpServletRequest request,
                       HttpServletResponse response, Model model) {
        // System.out.println("tuichu====================================");
        createPicFold(request);

        //该商品是否属于所有的门店的标识
        boolean isAllShop = true;

        PmLovePayDeploy lovePayEffectType = new PmLovePayDeploy();
        List<PmLovePayDeploy> pmLovePayDeploys = pmLovePayDeployService
                .findPmLovePayDeployList(lovePayEffectType);
        model.addAttribute("pmLovePayDeploys", pmLovePayDeploys);
        List<PmProductType> productTypes = pmProductTypeService
                .getSbProductTypeLevel("1");
        model.addAttribute("productTypes", productTypes);
        if (ebProduct.getProductId() != null) {

            //查询所有的加料
            List<EbProductCharging> ebProductChargingList = ebProductChargingService.findEbProductChargingByProductId(ebProduct.getProductId());

            //查询该商品所有的所有门店
            List<EbShopProduct> ebShopProductList  = ebShopProductService.getListByProductId(ebProduct.getProductId());
            Integer shopCount = pmShopInfoService.getShopCount();

            //判断商品是否属于所有商品
            if(shopCount != ebShopProductList.size()){
                isAllShop = false;
            }
            StringBuffer shopIds = new StringBuffer("");
            StringBuffer shopNames = new StringBuffer("");
            for(EbShopProduct e:ebShopProductList){
                shopIds.append(e.getShopId()+",");
                PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(e.getShopId() + "");
                if(pmShopInfo != null){
                    shopNames.append(pmShopInfo.getShopName()+",");
                }
            }
            if(shopIds.length() != 0){
                shopIds.setLength(shopIds.length()-1);
            }

            if(shopNames.length() > 0){
                shopNames.setLength(shopNames.length()-1);
            }


            PmProductPropertyStandard pmProductPropertyStandard = pmProductPropertyStandardService
                    .getPmProductIdPropertyStandard(ebProduct.getProductId()
                            .toString());
            model.addAttribute("pmProductPropertyStandard",
                    pmProductPropertyStandard);
            List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                    .getProductIdPmProductStandardDetail(ebProduct
                            .getProductId().toString());
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
                standsName += pmProductStandardDetail.getStandardValueStr()
                        + ";";
                String[] les = pmProductStandardDetail.getStandardIdStr()
                        .split(";");
                String[] lev = pmProductStandardDetail.getStandardValueStr()
                        .split(";");
                String[] idsTss = pmProductStandardDetail.getStandardIdStr()
                        .split(";");
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
                        st1 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    } else if (i == 1) {
                        idName.setId(les[i].split(":")[1].toString());
                        idName.setName(lev[i].split(":")[1].toString());
                        st2 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    } else if (i == 2) {
                        idName.setId(les[i].split(":")[1].toString());
                        idName.setName(lev[i].split(":")[1].toString());
                        st3 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    }else if (i == 3) {
                        idName.setId(les[i].split(":")[1].toString());
                        idName.setName(lev[i].split(":")[1].toString());
                        st4 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    }
                    list.add(idName);
                }
                pmProductStandardDetail.setStrlust(list);
            }
            model.addAttribute("standsName", standsName);
            model.addAttribute("lesize", lesize);
            model.addAttribute("st1", st1);
            model.addAttribute("st2", st2);
            model.addAttribute("st3", st3);
            model.addAttribute("st4", st4);
            model.addAttribute("stands", stands);
            model.addAttribute("ebProductChargingList", ebProductChargingList);
            model.addAttribute("shopIds",shopIds.toString());
            model.addAttribute("shopNames",shopNames.toString());

            model.addAttribute("pmProductStandardDetails",
                    pmProductStandardDetails);
        } else {
            List<PmShopInfo> pmShopInfos = pmShopInfoService.getShopType(1);
            if (pmShopInfos != null && pmShopInfos.size() > 0) {
                ebProduct.setShopId(pmShopInfos.get(0).getId());
            }
        }
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("isAllShop",isAllShop);
        return "modules/shopping/brands/commodity-details";
    }

    @RequestMapping(value = "supplyform")
    public String supplyform(EbProduct ebProduct, HttpServletRequest request,
                             HttpServletResponse response, Model model) {
        // System.out.println("tuichu====================================");
        createPicFold(request);
        PmLovePayDeploy lovePayEffectType = new PmLovePayDeploy();
        List<PmLovePayDeploy> pmLovePayDeploys = pmLovePayDeployService
                .findPmLovePayDeployList(lovePayEffectType);
        model.addAttribute("pmLovePayDeploys", pmLovePayDeploys);
        List<PmProductType> productTypes = pmProductTypeService
                .getSbProductTypeLevel("1");
        model.addAttribute("productTypes", productTypes);

        SysDict sysDict = new SysDict();
        sysDict.setId("1");
        sysDict.setLabel("审核通过");
        SysDict sysDict1 = new SysDict();
        sysDict1.setId("0");
        sysDict1.setLabel("审核不通过");
        List<SysDict> dicts = new ArrayList<SysDict>();
        dicts.add(sysDict);
        dicts.add(sysDict1);
        model.addAttribute("dicts", dicts);
        if (ebProduct.getProductId() != null) {
            if (ebProduct.getShopId() == null) {
                List<PmShopInfo> pmShopInfos = pmShopInfoService.getShopType(1);
                if (pmShopInfos != null && pmShopInfos.size() > 0) {
                    ebProduct.setShopId(pmShopInfos.get(0).getId());
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
            String stands = "";
            String st1 = "";
            String st2 = "";
            String st3 = "";
            String standsName = "";
            Integer lesize = 0;
            for (PmProductStandardDetail pmProductStandardDetail : pmProductStandardDetails) {
                String idStr = "";
                List<SpreIdName> list = new ArrayList<SpreIdName>();
                stands += pmProductStandardDetail.getStandardIdStr();
                standsName += pmProductStandardDetail.getStandardValueStr()
                        + ";";
                String[] les = pmProductStandardDetail.getStandardIdStr()
                        .split(";");
                String[] lev = pmProductStandardDetail.getStandardValueStr()
                        .split(";");
                String[] idsTss = pmProductStandardDetail.getStandardIdStr()
                        .split(";");
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
                        st1 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    } else if (i == 1) {
                        idName.setId(les[i].split(":")[1].toString());
                        idName.setName(lev[i].split(":")[1].toString());
                        st2 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    } else if (i == 2) {
                        idName.setId(les[i].split(":")[1].toString());
                        idName.setName(lev[i].split(":")[1].toString());
                        st3 += les[i].split(":")[1] + ":"
                                + lev[i].split(":")[1] + ",";
                    }
                    list.add(idName);
                }
                pmProductStandardDetail.setStrlust(list);
            }
            model.addAttribute("standsName", standsName);
            model.addAttribute("lesize", lesize);
            model.addAttribute("st1", st1);
            model.addAttribute("st2", st2);
            model.addAttribute("st3", st3);
            model.addAttribute("stands", stands);
            model.addAttribute("pmProductStandardDetails",
                    pmProductStandardDetails);

        }
        model.addAttribute("ebProduct", ebProduct);
        return "modules/shopping/supplyproduct/commodity_details";
    }

    // 根据商家获取经营范围
    @ResponseBody
    @RequestMapping(value = "/PmProductTypeId")
    public List PmProductTypeId(String shopId, String isWholesale,
                                HttpServletRequest request, HttpServletResponse response,
                                Model model) throws JsonProcessingException {
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(shopId);
        List<PmProductType> pmProductTypes = new ArrayList<PmProductType>();

        if (pmShopInfo.getShopType() != null && pmShopInfo.getShopType() == 1) {
            pmProductTypes = pmProductTypeService.getAlList();
        } else if ("1".equals(isWholesale)) {
            pmProductTypes = pmProductTypeService.getAlList();
        } else {
            PmShopCooperType pmShopCooperType = new PmShopCooperType();
            if (StringUtils.isNotBlank(shopId)) {
                pmShopCooperType.setShopId(Integer.parseInt(shopId));
                List<PmShopCooperType> cooperTypes = pmShopCooperTypeService
                        .getShopList(pmShopCooperType);
                for (PmShopCooperType pmShopCooperType2 : cooperTypes) {
                    PmProductType pmProductType = pmProductTypeService
                            .getID(pmShopCooperType2.getProductTypeId());
                    pmProductTypes.add(pmProductType);
                }
            }
        }
        return pmProductTypes;
    }

    @RequiresPermissions("merchandise:pro:view")
    @RequestMapping(value = "show")
    public String show(EbProduct ebProduct,Integer espShopId,
                       @RequestParam(defaultValue = "1") Integer findType ,
                       HttpServletRequest request,HttpServletResponse response,
                       Model model) {
        model.addAttribute("ebProduct", ebProduct);
        model.addAttribute("espShopId", espShopId);

        //查询商品属性
        PmProductPropertyStandard pmProductPropertyStandard = pmProductPropertyStandardService
                .getPmProductIdPropertyStandard(ebProduct.getProductId()
                        .toString());
        model.addAttribute("pmProductPropertyStandard",
                pmProductPropertyStandard);
        //查询规格信息
        List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                .getProductIdPmProductStandardDetail(ebProduct
                        .getProductId().toString());

        if (ebProduct.getProductId() != null) {

            //当显示模式为门店，点击查看
            if(findType == 0 && espShopId != null){
                EbShopProduct ep = new EbShopProduct();
                ep.setShopId(espShopId);
                ep.setProductId(ebProduct.getProductId());

                PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(espShopId+"");
                if(pmShopInfo != null){
                    ebProduct.setNewShopName(pmShopInfo.getShopName());
                }

                //查询门店商品关联表
                EbShopProduct ebShopProduct = ebShopProductService.getByProductIdAndShopId(ep);
                model.addAttribute("ebShopProduct",ebShopProduct);
                model.addAttribute("espShopId",espShopId);
                // 多规格id、名称、键值
                List<Map> datas=new ArrayList<Map>();
                //判断是否是多规格
                boolean isMoreStandar = true;
                if(pmProductStandardDetails == null || pmProductStandardDetails.size() == 0){
                    isMoreStandar = false;
                }else{
                    String standardIdStr=pmProductStandardDetails.get(0).getStandardIdStr();
                    String standardValueStr=pmProductStandardDetails.get(0).getStandardValueStr();
                    if(standardIdStr!=null){
//                        24:818;25:799;58:769
                        String ids[]=standardIdStr.split(";");
//                        温度:温度3;杯型:杯型2;茶底:茶底1
                        String values[]=standardValueStr.split(";");
                        for(int i=0;i<ids.length;i++){
                            Map map=new HashMap();
                            map.put("id",ids[i].split(":")[0]);
                            map.put("value",values[i].split(":")[0]);
                            List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = new ArrayList<PmProductTypeSpertAttrValue>();
                                PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
                                pmProductTypeSpertAttrValue.setShopId(ebProduct.getShopId());
                                pmProductTypeSpertAttrValue.setSpertAttrId(Integer.parseInt(ids[i].split(":")[0]));
                                pmProductTypeSpertAttrValue.setProductId(ebProduct.getProductId());
                                pmProductTypeSpertAttrValues = productTypeSpertAttrValueService
                                        .getpsList(pmProductTypeSpertAttrValue);
                            map.put("pmProductTypeSpertAttrValues",pmProductTypeSpertAttrValues);
                            datas.add(map);
                            }

                    }
                }
                model.addAttribute("isMoreStandar",isMoreStandar);
                model.addAttribute("datas",datas);

                for(PmProductStandardDetail detail : pmProductStandardDetails){
                    // 查询商家商品多规格关联信息
                    List<EbShopProductStandardDetail> detailList = ebShopProductStandardDetailService.getByShopIdAndProductId(ebShopProduct.getShopId(), ebShopProduct.getProductId(),detail.getId()+"");
                    if(detailList != null && detailList.size() > 0){
                        detail.setEbShopProductStandardDetail(detailList.get(0));
                    }
                }

            }

            //查询加料信息
            List<EbProductCharging> chargingList = ebProductChargingService.findEbProductChargingByProductId(ebProduct.getProductId());
            model.addAttribute("chargingList",chargingList);

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
//			PmProductPropertyStandard pmProductPropertyStandard = pmProductPropertyStandardService
//					.getPmProductIdPropertyStandard(ebProduct.getProductId()
//							.toString());
//			model.addAttribute("pmProductPropertyStandard",
//					pmProductPropertyStandard);
//			List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
//					.getProductIdPmProductStandardDetail(ebProduct
//							.getProductId().toString());
//
//			model.addAttribute("pmProductStandardDetails",
//					pmProductStandardDetails);

            model.addAttribute("findType",findType);
            model.addAttribute("detailList",pmProductStandardDetails);
        }

        return "modules/shopping/brands/commodity-overview";
    }

    /**
     * 添加
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     * @throws ParseException
     */
    @ResponseBody
    @RequestMapping(value = "/save")
    public JSONObject save(HttpServletRequest request,String productChargingIds,String shopIds,Integer shopType,
                           HttpServletResponse response, Model model)
            throws JsonProcessingException, ParseException {
        JSONObject json = new JSONObject();
        String productId = request.getParameter("productId");
        String shopId = request.getParameter("shopId");
        String isLovePay = request.getParameter("isLovePay");
        String lovePayStartDate = request.getParameter("lovePayStartDate");
        String lovePayEndDate = request.getParameter("lovePayEndDate");
        String lovePayMinRatio = request.getParameter("lovePayMinRatio");
        String lovePayMaxRatio = request.getParameter("lovePayMaxRatio");
        String productHtml = request.getParameter("productHtml");
        String pmshoprodic = request.getParameter("pmshoprodic");
        String isTakeOut = request.getParameter("isTakeOut");   //是否支持外卖

        /** 原代码start */
        // String
        // freightType=request.getParameter("money1");//运费类型：1卖家承担运费，2买家承担运费
        // String freightTempType=request.getParameter("freightTempType");
        // String freightTempMoney=request.getParameter("freightTempMoney");
        /** 原代码end */
        String freightType = "2";
        // String freightTempId=request.getParameter("freightTempId");
        String advertuseImg = request.getParameter("prdouctImg");
        String auditState = request.getParameter("auditState");
        String auditRemark = request.getParameter("auditRemark");
        String[] standard_id_str = request
                .getParameterValues("standard_id_str");
        // String[] standard_value_str=
        // request.getParameterValues("standard_value_str");
        String[] detailInventory = request
                .getParameterValues("detailInventory");
//		String[] standard_real_id = request
//				.getParameterValues("standard_real_id");

        String[] market_price = request.getParameterValues("market_price");//市场价
        String[] supply_price =  request.getParameterValues("detail_prices");//request.getParameterValues("supply_price");//结算价
        String[] detail_prices = request.getParameterValues("detail_prices");//销售价
        String[] return_ratio = request.getParameterValues("return_ratio");//让利比
        String[] member_price = request.getParameterValues("member_price");//会员价

        String productName = request.getParameter("productName");
        String li5 = request.getParameter("li5");
        String li2 = request.getParameter("li2");
        String measuringType = request.getParameter("measuringType");
        String measuringUnit = request.getParameter("measuringUnit");
        String isAPhysicalStore = request.getParameter("isAPhysicalStore");
        String isAgentStore = request.getParameter("isAgentStore");
        String isFreshStore = request.getParameter("isFreshStore");
        String isHehuiguan = request.getParameter("isHehuiguan"); //是否是合汇馆商品
        String hehuiUrl = request.getParameter("hehuiUrl"); //合汇馆地址

        String sellPrice = request.getParameter("sellPrice");
        String costPrice = request.getParameter("costPrice");
        String memberPrice = request.getParameter("memberPrice");//会员价格
        String marketPrice = request.getParameter("marketPrice");
        String barCode = request.getParameter("barCode");
        String productIntro = request.getParameter("productIntro");//商品简介
        String storeNums = request.getParameter("storeNums");
        String provincesId = request.getParameter("provincesId");
        String municipalId = request.getParameter("municipalId");
        String area = request.getParameter("area");
        String country = request.getParameter("country");
        String typeId = request.getParameter("type");
        String standarBraind_id = request.getParameter("standarBraind_id");// 品牌id
        String[] standard_id = request.getParameterValues("standard_id");// 属性ids
        String[] standard_name = request.getParameterValues("standard_name");// 属性值ids
        String ReturnRatio = request.getParameter("ReturnRatio");
        PmShopInfo pmShopInfo = pmShopInfoService.getShopType(1).get(0);
        String minRatio = DictUtils.getDictValue("minRatio", "gyconfig", "");
        String maxRatio = DictUtils.getDictValue("maxRatio", "gyconfig", "");

        String invcode_t = request.getParameter("invcode_t");
        String conversionRatio_t = request.getParameter("conversionRatio_t");
        String unitName_t = request.getParameter("unitName_t");
        String saveNums_t = request.getParameter("saveNums_t");
        Double gainLove = 0.00;



        if(StringUtils.isNotBlank(isHehuiguan) && isHehuiguan.equals("1")){
            if(StringUtils.isBlank(hehuiUrl)){
                json.put("code", "01");
                json.put("msg", "合汇馆商品需要添加合汇馆链接");
                return json;
            }
        }

        if (StringUtils.isBlank(advertuseImg)) {
            json.put("code", "01");
            json.put("msg", "商品主图不能为空");
            return json;
        }

        if(StringUtil.isBlank(measuringType)){
            json.put("code", "01");
            json.put("msg", "请选择计量类型");
            return json;
        }

        if("1".equals(measuringType)){
            if (StringUtils.isBlank(li2)) {
                json.put("code", "01");
                json.put("msg", "请选择多规格或单规格");
                return json;
            }
        }else{
            if (StringUtils.isBlank(measuringUnit)) {
                json.put("code", "01");
                json.put("msg", "请选择计量单位");
                return json;
            }
        }

        if(StringUtils.isNotBlank(storeNums) && storeNums.indexOf('.') >= 0){

                if ("1".equals(measuringType)) {
                    json.put("code", "01");
                    json.put("msg", "当前计量类型为件，库存不能为小数");
                    return json;
                }

                if (StringUtils.isNotBlank(measuringUnit) && "2".equals(measuringType) && "2".equals(measuringUnit)) {
                    json.put("code", "01");
                    json.put("msg", "当前计量单位为克，库存不能为小数");
                    return json;
                }
        }
// 		if (standard_id == null || standard_id.length == 0) {
//			json.put("code", "01");
//			json.put("msg", "请填写属性");
//			return json;
//		}
        /** 原代码start */
        // if(StringUtils.isNotBlank(freightType)){
        // if(freightType.equals("2")){
        // if(StringUtils.isNotBlank(freightTempType)){
        // if(!freightTempType.equals("1")){
        // if(StringUtils.isNotBlank(freightTempMoney)){
        // if(Double.parseDouble(freightTempMoney)>200){
        // json.put("code", "01");
        // json.put("msg", "运费必须小于200");
        // return json;
        // }
        // }
        // }
        // }
        // }
        // }
        /** 原代码end */
        //单规格或者按计量单位为重量
        if ("1".equals(li2) || "2".equals(measuringType)) {
            if (StringUtils.isBlank(li5)) {
                json.put("code", "01");
                json.put("msg", "请选着默认还是手动输入让利比");
                return json;
            }

            if (StringUtils.isBlank(sellPrice)) {
                json.put("code", "01");
                json.put("msg", "本店价格不能为空");
                return json;
            }
            if (Double.parseDouble(sellPrice) < 0) {
                json.put("code", "01");
                json.put("msg", "本店价格不能小于0");
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
            if (Double.parseDouble(minRatio) > Double.parseDouble(ReturnRatio)
                    || Double.parseDouble(ReturnRatio) > Double
                    .parseDouble(maxRatio)) {
                json.put("code", "01");
                json.put("msg", "请输入正确的让利比");
                return json;
            }
        } else {
            if (return_ratio != null && return_ratio.length > 0) {
                for (int i = 0; i < return_ratio.length; i++) {
                    return_ratio[i]="0";//默认让利比赋值为0
                    if (StringUtils.isBlank(detail_prices[i])) {
                        json.put("code", "01");
                        json.put("msg", "销售价不能为空");
                        return json;
                    }
//
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
                    if (StringUtils.isBlank(member_price[i])) {
                        json.put("code", "01");
                        json.put("msg", "会员价不能为空");
                        return json;
                    }
                    if (Double.parseDouble(member_price[i]) < 0) {
                        json.put("code", "01");
                        json.put("msg", "会员价不能小于0");
                        return json;
                    }

                    if (StringUtils.isBlank(return_ratio[i])) {
                        json.put("code", "01");
                        json.put("msg", "请输入让利比");
                        return json;
                    }
                    if (Double.parseDouble(minRatio) > Double
                            .parseDouble(return_ratio[i])
                            || Double.parseDouble(return_ratio[i]) > Double
                            .parseDouble(maxRatio)) {
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
            ebProduct = ebProductService.getEbProductById(ebProduct
                    .getProductId());
        }else{
            ebProduct.setShopType(1);
        }

        if (StringUtils.isNotBlank(invcode_t)&&StringUtils.isBlank(conversionRatio_t)) {
            json.put("code", "01");
            json.put("msg", "兑换比不能为空");
            return json;
        }
        if (StringUtils.isNotBlank(unitName_t)&&StringUtils.isBlank(unitName_t)) {
            json.put("code", "01");
            json.put("msg", "兑换比不能为空");
            return json;
        }
        if (StringUtils.isNotBlank(saveNums_t)) {
            try{
                ebProduct.setSaveNums(Integer.parseInt(saveNums_t));
            }catch(Exception e){
                json.put("code", "01");
                json.put("msg", "保留库存不能为空");
                return json;
            }
        }

        if (StringUtils.isNotBlank(unitName_t)) {
            ebProduct.setUnitName(unitName_t);
        } else {
            ebProduct.setUnitName(null);
        }
        EbUser ebUser = ebUserService.getShop(shopId);
        ebProduct.setAgentId(ebUser.getAgentId());
        ebProduct.setShopId(ebUser.getShopId());
        if (StringUtils.isNotBlank(freightType)) {
            ebProduct.setFreightType(Integer.parseInt(freightType));
            if (freightType.equals("2")) {// 运费类型：1卖家承担运费，2买家承担运费
                ebProduct.setUserFreightTemp(1);
            } else {
                ebProduct.setUserFreightTemp(0);
                ebProduct.setCourier(0.00);
            }
        }

        if (StringUtils.isNotBlank(provincesId)) {
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            pmSysDistrict.setId(Integer.parseInt(provincesId));
            ebProduct.setProvincesName(pmSysDistrictService.findId(
                    pmSysDistrict).getDistrictName());
        }
        if (StringUtils.isNotBlank(municipalId)) {
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            pmSysDistrict.setId(Integer.parseInt(municipalId));
            ebProduct.setMunicipalName(pmSysDistrictService.findId(
                    pmSysDistrict).getDistrictName());
        }
        if (StringUtils.isNotBlank(area)) {
            ebProduct.setArea(Integer.parseInt(area));
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            pmSysDistrict.setId(Integer.parseInt(area));
            ebProduct.setAreaName(pmSysDistrictService.findId(pmSysDistrict)
                    .getDistrictName());
        }
        if (StringUtils.isNotBlank(advertuseImg)) {
            if (advertuseImg.substring(0, 1).equals("|")) {
                StringBuilder advertuseImgs = new StringBuilder(advertuseImg);
                advertuseImg = advertuseImgs.replace(0, 1, "").toString();
            }
        }



        ebProduct.setPrdouctImg(advertuseImg);
        ebProduct.setProductIntro(productIntro);
        ebProduct.setProductHtml(productHtml);
        ebProduct.setPrdouctStatus(1);
        if (StringUtils.isNotBlank(storeNums)) {
            //当重量单位为公斤或者斤时，把库存转化成克
            if(Integer.valueOf(measuringType) == 2){
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
        ebProduct.setProductName(productName);
        if (StringUtils.isNotBlank(pmshoprodic)) {
            PmShopProductType pmShopProductType = pmShopProductTypeService
                    .getpmPmShopProductType(pmshoprodic);
            PmShopProductType pmShopProductType2 = pmShopProductTypeService
                    .getpmPmShopProductType(pmShopProductType.getParentId()
                            .toString());
            ebProduct.setShopProTypeIdStr("," + pmShopProductType2.getId()
                    + "," + pmShopProductType.getId() + ",");
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
        if (StringUtils.isNotBlank(isLovePay)) {
            ebProduct.setIsLovePay(Integer.parseInt(isLovePay));
            if (StringUtils.isNotBlank(lovePayStartDate)) {
                ebProduct
                        .setLovePayStartDate(org.apache.solr.common.util.DateUtil
                                .parseDate(lovePayStartDate));
            }
            if (StringUtils.isNotBlank(lovePayEndDate)) {
                ebProduct
                        .setLovePayEndDate(org.apache.solr.common.util.DateUtil
                                .parseDate(lovePayEndDate));
            }
            if (StringUtils.isNotBlank(lovePayMinRatio)) {
                ebProduct.setLovePayMinRatio(Double
                        .parseDouble(lovePayMinRatio));
            }
            if (StringUtils.isNotBlank(lovePayMaxRatio)) {
                ebProduct.setLovePayMaxRatio(Double
                        .parseDouble(lovePayMaxRatio));
            }
        } else {
            ebProduct.setIsLovePay(null);
            ebProduct.setIsLovePay(0);
            ebProduct.setLovePayStartDate(null);
            ebProduct.setLovePayEndDate(null);
            ebProduct.setLovePayMinRatio(0.0);
            ebProduct.setLovePayMaxRatio(0.00);
        }
        ebProduct.setShopName(pmShopInfo.getShopName());
        ebProduct.setBarCode(barCode);
        ebProduct.setProvincesId(provincesId);
        ebProduct.setMunicipalId(municipalId);
        ebProduct.setCountry(country);
        if(StringUtil.isNotBlank(standarBraind_id)){
            ebProduct.setBrandId(Integer.parseInt(standarBraind_id));
        }

        ebProduct.setBrandName(pmProductTypeBrandService.getSbProductTypeBrand(
                standarBraind_id).getBrandName());
        ebProduct.setProductTypeId(Integer.parseInt(typeId));
        // 三级
        PmProductType pmProductType1 = pmProductTypeService
                .getSbProductType(typeId);
        ebProduct.setProductTypeName(pmProductType1.getProductTypeName());
        // 2级
        PmProductType pmProductType2 = pmProductTypeService
                .getSbProductType(pmProductType1.getParentId().toString());
        ebProduct.setProductTypeParent2Id(pmProductType2.getId());
        // ebProduct.setProductTypeName(pmProductType1.getProductTypeName());
        // 1级
        PmProductType pmProductType3 = pmProductTypeService
                .getSbProductType(pmProductType2.getParentId().toString());
        ebProduct.setPrdouctStatus(0);
        ebProduct.setProductTypeParentId(pmProductType3.getId());
        if(ebProduct.getProductName()!=null)
            ebProduct.setProductNameFirst(ChineseCharacterUtil.convertHanzi2Pinyin(ebProduct.getProductName(),false).toLowerCase());
        ebProductService.saveProduct(ebProduct);
        ebProduct = ebProductService.getEbProductById(ebProduct.getProductId());
        PmProductPropertyStandard pmProductPropertyStandard = new PmProductPropertyStandard();
        pmProductPropertyStandard.setProductId(ebProduct.getProductId());
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


        if(standard_id!=null&&standard_id.length>0)
            for (int i = 0; i < standard_id.length; i++) {
                PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService
                        .getSbProductTypeSpertAttr(standard_id[i]);
                PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
                pmProductTypeSpertAttrValue.setSpertAttrId(pmProductTypeSpertAttr
                        .getId());
                List<PmProductTypeSpertAttrValue> attrValues = productTypeSpertAttrValueService
                        .getAttList(pmProductTypeSpertAttrValue);
                if (pmProductTypeSpertAttr.getShowType() == 1) {
                    String chu = request.getParameter("chu"
                            + pmProductTypeSpertAttr.getId());
                    if (attrValues != null && attrValues.size() > 0) {
                        propertyStandardIdStr += standard_id[i] + ":" + chu + ";";
                        propertyStandardValueStr += ""
                                + pmProductTypeSpertAttr.getSpertAttrName()
                                + ":"
                                + productTypeSpertAttrValueService
                                .getSbProductTypeSpertAttrValue(chu)
                                .getSpertAttrValue() + ";";
                    }
                } else {
                    if (attrValues != null && attrValues.size() > 0) {
                        propertyStandardIdStr += standard_id[i] + ":"
                                + (standard_name == null || standard_name[i]==null  ? "" : standard_name[i]) + ";";
                        propertyStandardValueStr += pmProductTypeSpertAttrService
                                .getSbProductTypeSpertAttr(standard_id[i])
                                .getSpertAttrName()
                                + ":"
                                + productTypeSpertAttrValueService
                                .getSbProductTypeSpertAttrValue(
                                        standard_name[i])
                                .getSpertAttrValue() + ";";
                    }

                }
            }

        pmProductPropertyStandard.setPropertyStandardType(1);
        pmProductPropertyStandard
                .setPropertyStandardValueStr(propertyStandardValueStr);
        pmProductPropertyStandard.setShopId(ebUser.getShopId());
        pmProductPropertyStandard
                .setPropertyStandardIdStr(propertyStandardIdStr);
        pmProductPropertyStandardService.save(pmProductPropertyStandard);

        //商品明细列表
        List<PmProductStandardDetail> pmProductStandardDetailList = new ArrayList();
//        已经被删除的规格map
        Map<Integer , PmProductStandardDetail> deleteStanderMap = new HashMap<Integer, PmProductStandardDetail>();
        //发生改变的规格列表
        List<PmProductStandardDetail> changeStanderList = new ArrayList<PmProductStandardDetail>();

        //查出原有的所有规格
        List<PmProductStandardDetail> oldStanderList = pmProductStandardDetailService.getByProductId(ebProduct.getProductId());
        if(oldStanderList != null && oldStanderList.size()>0){
            for (PmProductStandardDetail standar:oldStanderList) {
                if(standar != null){
                    deleteStanderMap.put(standar.getId(),standar);
                }
            }
        }

        // 循环添加多条规格规格
        if ("1".equals(measuringType) && "2".equals(li2)) {
//			if (return_ratio != null && return_ratio.length > 0) {
//				for (int i = 0; i < return_ratio.length; i++) {

            if (detailInventory != null && detailInventory.length > 0) {
                for (int i = 0; i < detailInventory.length; i++) {
                    PmProductStandardDetail pmProductStandardDetail = new PmProductStandardDetail();;

                    if(StringUtil.isNotBlank(standard_id_str[i])){
                        //根据商品id和规格id获取规格
                        PmProductStandardDetail detail= pmProductStandardDetailService.
                                getByProductIdAndstandardIds(ebProduct.getProductId(),standard_id_str[i]);

                        //不等于空的话，说明从前有这个规格
                        if(detail != null){
                            pmProductStandardDetail = detail;
                            //从删除的map中移除这个规格
                            deleteStanderMap.remove(pmProductStandardDetail.getId());
                        }

                        //获得修改价格的规格
                        if((pmProductStandardDetail.getDetailPrices() != null && !Double.valueOf(detail_prices[i]).equals(pmProductStandardDetail.getDetailPrices()))
                                || (pmProductStandardDetail.getMemberPrice() != null && Double.valueOf(member_price[i]).equals(pmProductStandardDetail.getMemberPrice()))){
                            changeStanderList.add(pmProductStandardDetail);
                        }
                    }

                    pmProductStandardDetail.setDetailInventory(Integer
                            .parseInt(detailInventory[i]));
                    pmProductStandardDetail.setDetailPrices(Double
                            .parseDouble(detail_prices[i]));
//					pmProductStandardDetail.setMarketPrice(StringUtils.isNotBlank(market_price[i]) ? Double
//							.parseDouble(market_price[i]) : 0.0);
                    pmProductStandardDetail.setSupplyPrice(Double
                            .parseDouble(supply_price[i]));
                    pmProductStandardDetail.setMemberPrice(Double
                            .parseDouble(member_price[i]));

                    String StandardIdStr = "";
                    String StandardValueStr = "";
                    pmProductStandardDetail.setShopId(ebUser.getShopId());

                    //新增规格才需要计算StandardIdStr和StandardValueStr
                    if (StringUtils.isNotBlank(standard_id_str[i])
                            && pmProductStandardDetail.getId()==null) {
                        String[] idStr = standard_id_str[i].split(":");
                        for (int j = 0; j < idStr.length; j++) {
                            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = productTypeSpertAttrValueService
                                    .getSbProductTypeSpertAttrValue(idStr[j]);
                            if (pmProductTypeSpertAttrValue != null) {
                                pmProductTypeSpertAttrValue
                                        .setProductId(ebProduct.getProductId());
                                productTypeSpertAttrValueService
                                        .save(pmProductTypeSpertAttrValue);
                                if (pmProductTypeSpertAttrValue
                                        .getSpertAttrId() != null) {
                                    PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService
                                            .getSbProductTypeSpertAttr(pmProductTypeSpertAttrValue
                                                    .getSpertAttrId()
                                                    .toString());
                                    if (pmProductTypeSpertAttr != null) {
                                        StandardIdStr += pmProductTypeSpertAttr
                                                .getId()
                                                + ":"
                                                + pmProductTypeSpertAttrValue
                                                .getId() + ";";
                                        StandardValueStr += pmProductTypeSpertAttr
                                                .getSpertAttrName()
                                                + ":"
                                                + pmProductTypeSpertAttrValue
                                                .getSpertAttrValue()
                                                + ";";
                                    }
                                }
                            }
                        }
                    }
                    if (StringUtils.isNotBlank(StandardIdStr)
                            && StringUtils.isNotBlank(StandardValueStr)) {
                        if (StandardIdStr.substring(0,
                                StandardIdStr.length() - 1).equals(";")) {
                            StandardIdStr = StandardIdStr.substring(0,
                                    StandardIdStr.length() - 1);
                        }
                        if (StandardValueStr.substring(0,
                                StandardValueStr.length() - 1).equals(";")) {
                            StandardValueStr = StandardValueStr.substring(0,
                                    StandardValueStr.length() - 1);
                        }
                    }

                    //新增规格才设置这些值
                    if(pmProductStandardDetail.getId() == null) {
                        pmProductStandardDetail.setStandardIdStr(StandardIdStr);
                        pmProductStandardDetail
                                .setStandardValueStr(StandardValueStr);
                        pmProductStandardDetail.setProductId(ebProduct
                                .getProductId());
                        //					pmProductStandardDetail.setReturnRatio(Double
                        //							.parseDouble(return_ratio[0]));
                        pmProductStandardDetail.setReturnRatio(0.0);
                    }

                    pmProductStandardDetailService
                            .save(pmProductStandardDetail);

                    pmProductStandardDetailList.add(pmProductStandardDetail);
                }

            }

        }

        Collection<PmProductStandardDetail> values = deleteStanderMap.values();
        if(deleteStanderMap.size() > 0) {
            //删除已经移除
            String ids = FormatUtil.getFieldAllValue(values.iterator(), "id");
            pmProductStandardDetailService.deleteByIds(ids);
        }
        //把已经删除的规格也加入到修改规格列表中
        Iterator<PmProductStandardDetail> iterator = values.iterator();
        while (iterator.hasNext()){
            changeStanderList.add(iterator.next());
        }

        //把购物车的状态设置成失效
        String propertyIds = FormatUtil.getFieldAllValue(changeStanderList, "id");
        if(StringUtil.isNotBlank(propertyIds)){
            ebShoppingcartService.updateStatusByPropertyIds(2,propertyIds);
        }


        List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                .getProductIdPmProductStandardDetail(ebProduct.getProductId()
                        .toString());
        if (pmProductStandardDetails != null
                && pmProductStandardDetails.size() > 0) {
            Integer mus = 0;
            List<PmProductStandardDetail> max = pmProductStandardDetailService
                    .getProductIdPmProductStandardMaximum(ebProduct
                            .getProductId().toString());
            for (PmProductStandardDetail pmProductStandardDetail : max) {
                mus += pmProductStandardDetail.getDetailInventory();
            }
//            //当重量单位为公斤时，把库存转化成克
//            if(StringUtils.isNotBlank(measuringType) && StringUtils.isNotBlank(measuringType)
//                    && Integer.valueOf(measuringType) == 2 && Integer.valueOf(measuringUnit)==1){
//                ebProduct.setStoreNums(mus*1000);
//            }else{
//                ebProduct.setStoreNums(mus);
//            }
            ebProduct.setStoreNums(mus);
            List<PmProductStandardDetail> min = pmProductStandardDetailService
                    .getProductIdPmProductStandardMinimum(ebProduct
                            .getProductId().toString());
            if (max != null && max.size() > 0 && min != null && max.size() > 0) {
                ebProduct.setMarketPrice(min.get(0).getMarketPrice());
                ebProduct.setCostPrice(min.get(0).getSupplyPrice());
                ebProduct.setSellPrice(min.get(0).getDetailPrices());
                ebProduct.setMemberPrice(min.get(0).getMemberPrice());
                ebProduct.setReturnRatio(min.get(0).getReturnRatio());
            }
        }
        DictUtils dictUtils = new DictUtils();
        if ("1".equals(li2) || "2".equals(measuringType)) {
            gainLove = (ebProduct.getSellPrice() * ebProduct.getSellPrice() / 100)
                    / Double.parseDouble(dictUtils.getDictValue("InLove_One",
                    "gyconfig", ""));
        } else {
            List<PmProductStandardDetail> min = pmProductStandardDetailService
                    .getProductIdPmProductStandardMinimum(ebProduct
                            .getProductId().toString());
            if (min != null && min.size() > 0) {
                gainLove = (min.get(0).getDetailPrices()
                        * min.get(0).getReturnRatio() / 100)
                        / Double.parseDouble(dictUtils.getDictValue(
                        "InLove_One", "gyconfig", ""));
            }
        }
        ebProduct.setGainLove(gainLove);
        ebProduct.setIsTakeOut(Integer.parseInt(isTakeOut));
        ebProduct.setMeasuringType(StringUtils.isBlank(measuringType) ? 1 : Integer.valueOf(measuringType) );
        ebProduct.setMeasuringUnit(StringUtils.isBlank(measuringUnit) ? null : Integer.valueOf(measuringUnit) );
        ebProductService.saveProduct(ebProduct);

        //保存加料明细
        if(StringUtils.isNotBlank(productChargingIds) && ebProduct.getProductId() != null){
            ebProductChargingItemService.saveItems(ebProduct,productChargingIds);
        }

        //保存商品所属门店
        boolean flag = false;

        Integer measuringUnitNum = StringUtils.isBlank(measuringUnit)?null : Integer.valueOf(measuringUnit);

        flag = ebShopProductService.batchSave(pmProductStandardDetailList,ebProduct ,shopIds,Integer.valueOf(measuringType),measuringUnitNum,shopType);

        if(!flag){
            json.put("msg", "保存所属门店失败！");
        }
        ebProductChargingItemService.saveItems(ebProduct,productChargingIds);

        //循环保存商家商品多规格关联信息列表
        if(pmProductStandardDetailList.size() > 0){
            //商家商品多规格关联信息列表
            List<EbShopProductStandardDetail> ebShopProductStandardDetailList = new ArrayList();
            String[] shopIdArr = shopIds.split(",");
            if(shopType ==0){
                List<PmShopInfo> pmShopInfos=pmShopInfoService.getAllShop();
                shopIdArr=new String[pmShopInfos.size()];
                for(int i=0;i<pmShopInfos.size();i++){
                    PmShopInfo pmShopInfo1=pmShopInfos.get(i);
                    shopIdArr[i]=pmShopInfo1.getId()+"";
                }
            }else{
                shopIdArr = shopIds.split(",");
            }
//				店家id数组


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

            if(!reuslt){
                json.put("msg", "商家商品多规格关联信息失败！");
            }
        }
        if (StringUtils.isNotBlank(isLovePay)) {
            if (isLovePay.equals("1")) {
                json.put("code", "05");
                json.put("msg", "保存商品成功");
                return json;
                // return
                // "redirect:"+Global.getAdminPath()+"/Product/Orderlist?isLovePay=1";
            }
        }
        if (StringUtils.isNotBlank(auditState)) {
            json.put("code", "009");
        } else {
            json.put("code", "00");
        }
        json.put("shopType", ebProduct.getShopType());
        json.put("msg", "保存商品成功");
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "jsonPmShopFreightTemList")
    public List jsonPmShopFreightTemList(String shopId,
                                         HttpServletRequest request, HttpServletResponse response,
                                         Model model, RedirectAttributes redirectAttributes)
            throws ParseException {
        // EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
        PmShopFreightTem pmShopFreightTem = new PmShopFreightTem();
        if (StringUtils.isNotBlank(shopId)) {
            pmShopFreightTem.setShopId(Integer.parseInt(shopId));
        }
        List<PmShopFreightTem> freightTems = pmShopFreightTemService
                .PmShopFreightTemList(pmShopFreightTem);
        return freightTems;
    }

    // 查询规格明细
    @ResponseBody
    @RequestMapping(value = "/commercialeDetail")
    public List commercialeDetail(String id, String shopId, String productId,
                                  HttpServletRequest request, HttpServletResponse response,
                                  Model model) throws JsonProcessingException {
        List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = new ArrayList<PmProductTypeSpertAttrValue>();
        if (StringUtils.isNotBlank(id) && StringUtils.isNotBlank(shopId)) {
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
            pmProductTypeSpertAttrValue.setShopId(Integer.parseInt(shopId));
            pmProductTypeSpertAttrValue.setSpertAttrId(Integer.parseInt(id));
            if (StringUtils.isNotBlank(productId)) {
                pmProductTypeSpertAttrValue.setProductId(Integer
                        .parseInt(productId));
            }
            pmProductTypeSpertAttrValues = productTypeSpertAttrValueService
                    .getpsList(pmProductTypeSpertAttrValue);
        }
        return pmProductTypeSpertAttrValues;
    }

    // 添加规格值
    // ID外的明细值
    @ResponseBody
    @RequestMapping(value = "/addcommercialeDehors")
    public List addcommercialeDehors(String shopId, String values,
                                     String typeId, String productId, HttpServletRequest request,
                                     HttpServletResponse response, Model model)
            throws JsonProcessingException {
        SysUser sysUser = SysUserUtils.getUser();
        List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = new ArrayList<PmProductTypeSpertAttrValue>();
        if (StringUtils.isNotBlank(typeId) && StringUtils.isNotBlank(shopId)) {
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
            pmProductTypeSpertAttrValue.setCreateTime(new Date());
            pmProductTypeSpertAttrValue.setCreateUser(sysUser.getLoginName());
            pmProductTypeSpertAttrValue.setModifyTime(new Date());
            pmProductTypeSpertAttrValue.setOrderNo(1);
            pmProductTypeSpertAttrValue.setModifyUser(sysUser.getLoginName());
            pmProductTypeSpertAttrValue.setShopId(Integer.parseInt(shopId));
            pmProductTypeSpertAttrValue
                    .setSpertAttrId(Integer.parseInt(typeId));
            pmProductTypeSpertAttrValue.setSpertAttrValue(values);
            if (StringUtils.isNotBlank(productId)) {
                pmProductTypeSpertAttrValue.setProductId(Integer
                        .parseInt(productId));
            }
            productTypeSpertAttrValueService.save(pmProductTypeSpertAttrValue);
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue2 = new PmProductTypeSpertAttrValue();
            pmProductTypeSpertAttrValue2.setSpertAttrId(Integer
                    .parseInt(typeId));
            pmProductTypeSpertAttrValue2.setShopId(Integer.parseInt(shopId));
            if (StringUtils.isNotBlank(productId)) {
                pmProductTypeSpertAttrValue2.setProductId(Integer
                        .parseInt(productId));
            }
            pmProductTypeSpertAttrValues = productTypeSpertAttrValueService
                    .getpsList(pmProductTypeSpertAttrValue2);
        }
        return pmProductTypeSpertAttrValues;
    }

    /**
     * 国家
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/oneji")
    public List oneji(HttpServletRequest request, HttpServletResponse response,
                      Model model) throws JsonProcessingException {
        PmSysDistrict pmSysDistrict = new PmSysDistrict();
        pmSysDistrict.setDisLevel(0);
        List<PmSysDistrict> pmSysDistricts = pmSysDistrictService
                .getDistrictOne(pmSysDistrict);
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
    public List towjij(String id, HttpServletRequest request,
                       HttpServletResponse response, Model model)
            throws JsonProcessingException {
        List<PmSysDistrict> pmSysDistricts = new ArrayList<PmSysDistrict>();
        if (StringUtils.isNotBlank(id)) {
            PmSysDistrict pmSysDistrictsy = new PmSysDistrict();
            pmSysDistrictsy.setId(Integer.parseInt(id));
            PmSysDistrict pmSysDistrictsyl = pmSysDistrictService.findId(id);
            PmSysDistrict pmSysDistrict = new PmSysDistrict();
            if (pmSysDistrictsyl != null) {
                pmSysDistrict.setParentId(pmSysDistrictsyl.getId());
                pmSysDistricts = pmSysDistrictService
                        .getDistrictOne(pmSysDistrict);
            }
        }
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
    public List onejij(HttpServletRequest request,
                       HttpServletResponse response, Model model)
            throws JsonProcessingException {
        PmSysDistrict pmSysDistrict = new PmSysDistrict();
        pmSysDistrict.setDisLevel(0);
        List<PmSysDistrict> pmSysDistricts = pmSysDistrictService
                .getDistrictOne(pmSysDistrict);
        return pmSysDistricts;
    }

    /**
     * 根据商家id查询类别
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/shopType")
    public List shopType(String shopId, HttpServletRequest request,
                         HttpServletResponse response, Model model)
            throws JsonProcessingException {
        PmShopProductType pmShopProductType = new PmShopProductType();
        if (StringUtils.isNotBlank(shopId)) {
            pmShopProductType.setShopId(Integer.parseInt(shopId));
        }
        pmShopProductType.setLevel(1);
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService
                .getList(pmShopProductType);
        /*
         * for (PmShopProductType pmShopProductType2 : pmShopProductTypes) {
         * PmShopProductType pmShopProductType3=new PmShopProductType();
         * if(StringUtils.isNotBlank(shopId)){
         * pmShopProductType.setShopId(Integer.parseInt(shopId)); }
         * pmShopProductType3.setParentId(pmShopProductType2.getId());
         * List<PmShopProductType> pmShopProductTypes2=
         * pmShopProductTypeService.getList(pmShopProductType3);
         * pmShopProductType2.setPmShopProductTypes(pmShopProductTypes2); }
         */
        return pmShopProductTypes;
    }

    /**
     * 根据商家id查询类别
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/shopType2")
    public List shopType2(String shopTypeId, HttpServletRequest request,
                          HttpServletResponse response, Model model)
            throws JsonProcessingException {
        PmShopProductType pmShopProductType = new PmShopProductType();
        if (StringUtils.isNotBlank(shopTypeId)) {
            pmShopProductType.setParentId(Integer.parseInt(shopTypeId));
        }
        List<PmShopProductType> pmShopProductTypes = pmShopProductTypeService
                .getList(pmShopProductType);
        return pmShopProductTypes;
    }

    /**
     * 省市
     *
     * @param request
     * @param response
     * @param model
     * @return
     * @throws JsonProcessingException
     */
    @ResponseBody
    @RequestMapping(value = "/towji")
    public List towji(String id, HttpServletRequest request,
                      HttpServletResponse response, Model model)
            throws JsonProcessingException {
        PmSysDistrict pmSysDistrictsy = new PmSysDistrict();
        pmSysDistrictsy.setDistrictCode(id);
        PmSysDistrict pmSysDistrictsyl = pmSysDistrictService
                .getDistrictOneMo(id);
        System.out.println(pmSysDistrictsyl.getId());
        PmSysDistrict pmSysDistrict = new PmSysDistrict();
        List<PmSysDistrict> pmSysDistricts = new ArrayList<PmSysDistrict>();
        if (StringUtils.isNotBlank(id)) {
            pmSysDistrict.setParentId(pmSysDistrictsyl.getId());
            pmSysDistricts = pmSysDistrictService.getDistrictOne(pmSysDistrict);
        }
        return pmSysDistricts;
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
    public List productType(String id, HttpServletRequest request,
                            HttpServletResponse response, Model model)
            throws JsonProcessingException {
        List<PmProductType> productTypes = new ArrayList<PmProductType>();
        if (StringUtils.isNotBlank(id)) {
            productTypes = pmProductTypeService.getSbProductTypeHQLList(id);
            for (PmProductType pmProductType : productTypes) {
                List<PmProductType> productTypes2 = pmProductTypeService
                        .getSbProductTypeHQLList(pmProductType.getId()
                                .toString());
                pmProductType.setPmProductTypes(productTypes2);
            }
        }
        return productTypes;
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
    public PmProductType productTypeId(String id, HttpServletRequest request,
                                       HttpServletResponse response, Model model)
            throws JsonProcessingException {
        PmProductType pmProductType = pmProductTypeService.getSbProductType(id);
        return pmProductType;
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
    public List productTypeBrand(String id, HttpServletRequest request,
                                 HttpServletResponse response, Model model)
            throws JsonProcessingException {
        List<PmProductTypeBrand> pmProductTypeBrands = new ArrayList<PmProductTypeBrand>();
        if (StringUtils.isNotBlank(id)) {
            PmProductType pmProductType = pmProductTypeService
                    .getSbProductType(id);
            PmProductTypeBrand productTypeBrand = new PmProductTypeBrand();
            productTypeBrand.setProductTypeId(pmProductType.getParentId());
            pmProductTypeBrands = pmProductTypeBrandService
                    .getList(productTypeBrand);
        }
        return pmProductTypeBrands;
    }

    @ResponseBody
    @RequestMapping(value = "/tyeps")
    public List tyeps(String id, HttpServletRequest request,
                      HttpServletResponse response, Model model)
            throws JsonProcessingException {
        @SuppressWarnings("unchecked")
        List<PmProductType> productTypes = pmProductTypeService
                .getSbProductTypeList(id);
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
    public List commerciale(String id, String shopId,
                            HttpServletRequest request, HttpServletResponse response,
                            Model model) throws JsonProcessingException {
        List<PmProductTypeSpertAttr> pmProductTypeSpertAttrs = new ArrayList<PmProductTypeSpertAttr>();
        // EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
        if (StringUtils.isNotBlank(id)) {
            PmProductTypeSpertAttr pmProductTypeSpertAttr = new PmProductTypeSpertAttr();
            pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(id));
            pmProductTypeSpertAttr.setIsPublic(-2);
            pmProductTypeSpertAttrs = pmProductTypeSpertAttrService
                    .getPmProductTypeSpertAttrProductTypeId(pmProductTypeSpertAttr);
            //获取上级（第二级）属性
            PmProductType pmProductType = pmProductTypeService
                    .getSbProductType(id);
            if(pmProductType.getParentId()!=null){
                //获取属性值
                pmProductTypeSpertAttr.setProductTypeId(pmProductType.getParentId());
                pmProductTypeSpertAttr.setIsPublic(-2);
                List<PmProductTypeSpertAttr> pmProductTypeSpertAttrs1 = pmProductTypeSpertAttrService
                        .getPmProductTypeSpertAttrProductTypeId(pmProductTypeSpertAttr);
                if(pmProductTypeSpertAttrs1!=null&&pmProductTypeSpertAttrs1.size()>0){
                    pmProductTypeSpertAttrs.addAll(pmProductTypeSpertAttrs1);
                }

            }
            if (pmProductTypeSpertAttrs != null
                    && pmProductTypeSpertAttrs.size() > 0) {
                for (PmProductTypeSpertAttr pmProductTypeSpertAttr1 : pmProductTypeSpertAttrs) {
                    PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = new PmProductTypeSpertAttrValue();
                    if (StringUtils.isNotBlank(shopId)) {
                        pmProductTypeSpertAttrValue.setShopId(Integer
                                .parseInt(shopId));
                    }
                    pmProductTypeSpertAttrValue
                            .setSpertAttrId(pmProductTypeSpertAttr1.getId());
                    List<PmProductTypeSpertAttrValue> pmProductTypeSpertAttrValues = productTypeSpertAttrValueService
                            .getList(pmProductTypeSpertAttrValue);
                    pmProductTypeSpertAttr1
                            .setPmProductTypeSpertAttrValues(pmProductTypeSpertAttrValues);
                }
            }
        }
        return pmProductTypeSpertAttrs;
    }

    @ResponseBody
    @RequestMapping(value = "classOne")
    public List classOne(String type, HttpServletRequest request,
                         HttpServletResponse response) {
        EbLabel ebLabel = new EbLabel();
        ebLabel.setLabelType(Integer.parseInt(type));
        List<EbLabel> ebLabels = ebLabelService.ebLabelList(ebLabel);
        return ebLabels;
    }

    // 删除规格值
    // ID外的明细值
    @ResponseBody
    @RequestMapping(value = "/deletecommercialeDehors")
    public JSONObject deletecommercialeDehors(String typeId, String productId,
                                              HttpServletRequest request, HttpServletResponse response,
                                              Model model) throws JsonProcessingException {
        JSONObject json = new JSONObject();
        json.put("code", "01");
        json.put("msg", "失败");
        if (StringUtils.isNotBlank(typeId)) {
            PmProductTypeSpertAttrValue pmProductTypeSpertAttrValue = productTypeSpertAttrValueService
                    .getSbProductTypeSpertAttrValue(typeId);
            if (pmProductTypeSpertAttrValue != null) {
                if (pmProductTypeSpertAttrValue.getShopId() == null){
                    json.put("code", "01");
                    json.put("msg", "平台规格值需要到规格管理删除！");
                    return json;
                }else if (pmProductTypeSpertAttrValue.getSpertAttrId() != null) {
                    if (StringUtils.isNotBlank(productId)) {
                        List<PmProductStandardDetail> details = pmProductStandardDetailService
                                .getProductIdPmProductStandardDetail(productId);
                        if (details != null && details.size() > 0) {
                            for (PmProductStandardDetail pmProductStandardDetail : details) {
                                String idsr = "";
                                String idsrNme = "";
                                String ids[] = pmProductStandardDetail
                                        .getStandardIdStr().split(";");
                                String idsN[] = pmProductStandardDetail
                                        .getStandardValueStr().split(";");
                                for (int i = 0; i < ids.length; i++) {
                                    if (!ids[i]
                                            .equals(pmProductTypeSpertAttrValue
                                                    .getSpertAttrId()
                                                    + ":"
                                                    + pmProductTypeSpertAttrValue
                                                    .getId())) {
                                        idsr += ids[i] + ";";
                                    }
                                    if (pmProductTypeSpertAttrValue
                                            .getSpertAttrId() != null) {
                                        PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService
                                                .getSbProductTypeSpertAttr(pmProductTypeSpertAttrValue
                                                        .getSpertAttrId()
                                                        .toString());
                                        if (!idsN[i]
                                                .equals(pmProductTypeSpertAttr
                                                        .getSpertAttrName()
                                                        + ":"
                                                        + pmProductTypeSpertAttrValue
                                                        .getSpertAttrValue())) {
                                            idsrNme += idsN[i] + ";";
                                        }
                                    }
                                }
                                if (StringUtils.isNotBlank(idsr)) {
                                    idsr = idsr.substring(0, idsr.length() - 1);
                                    idsrNme = idsrNme.substring(0,
                                            idsrNme.length() - 1);
                                    pmProductStandardDetail
                                            .setStandardIdStr(idsr);
                                    pmProductStandardDetail
                                            .setStandardValueStr(idsrNme);
                                    pmProductStandardDetailService
                                            .save(pmProductStandardDetail);
                                } else {
                                    pmProductStandardDetailService
                                            .delete(pmProductStandardDetail);
                                }
                            }
                        }
                    }
                    productTypeSpertAttrValueService
                            .delete(pmProductTypeSpertAttrValue);
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

    @RequestMapping(value = "saveTags")
    public String saveTags(String id, HttpServletRequest request,
                           HttpServletResponse response) {
        String[] tag = request.getParameterValues("tag");
        String ids = "";
        String name = "";
        if (StringUtils.isNotBlank(id)) {
            EbProduct ebProduct = ebProductService.getEbProduct(id);
            if (tag != null) {
                for (int i = 0; i < tag.length; i++) {
                    ids += "" + tag[i] + ",";
                    EbLabel ebLabels = ebLabelService.getEbLabel(tag[i]);
                    name += "" + ebLabels.getName() + ",";
                }
            }
            ebProduct.setProductTags(ids);
            ebProduct.setProductTagsName(name);
            ebProductService.saveProduct(ebProduct);
        }
        return "redirect:" + Global.getAdminPath() + "/Product/list";
    }

    /**
     * 导出报表
     * @param request
     * @param ebProduct
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "exsel")
    public String exsel( EbProduct ebProduct,Integer shopType,
                         String statrPrice, String stopPrice, String statrDate,
                         String stopDate, String priceType, String podateType,
                         String isLovePay, HttpServletRequest request,
                         @RequestParam(defaultValue = "1") Integer findType ,
                         String chooseShopId,String[] syllable){

        String productTags = request.getParameter("productTags");
        SysUser currentUser = SysUserUtils.getUser();
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
        }
        List<PmShopInfo> pmShopInfoList = null;   //门店列表
        List<EbProduct> ebProductList = null;   //商品列表
        List<EbShopProduct> ebShopProductList = null;   //商家商品价格关联信息列表

        /**根据门店展示商品**/
        if(findType == 0){
            List<Object> resultList = null;
            resultList = ebShopProductService.getResultListByShop(
                    currentUser, ebProduct, new Page<Object>(1,
                            Integer.MAX_VALUE), podateType, statrDate, stopDate, "", "",
                    priceType, statrPrice, stopPrice, shopType, chooseShopId);

            /**
             * 解析返回结果
             */
            if(resultList != null && resultList.size() > 0){
                ebProductList = ( List<EbProduct>)resultList.get(1);
                pmShopInfoList=(List<PmShopInfo>)resultList.get(2);
                ebShopProductList = ( List<EbShopProduct>)resultList.get(3);
            }

        }else{  /**根据商品展示商品**/
            List<Object>  resultList = ebShopProductService.getEbProductListByProduct(
                    currentUser, ebProduct, new Page<Object>(1,
                            Integer.MAX_VALUE), podateType, statrDate, stopDate, "", "",
                    priceType, statrPrice, stopPrice,shopType);


            if(resultList != null && resultList.size() > 0){
                ebProductList = ( List<EbProduct>)resultList.get(1);
            }
        }

        //按照商品展示
        if(findType!=1){
            if (CollectionUtils.isNotEmpty(ebProductList) && CollectionUtils.isNotEmpty(ebShopProductList)
                    && CollectionUtils.isNotEmpty(pmShopInfoList)) {
                for(int i = 0 ; i < ebProductList.size() ; i++){
                    //查询相同的数据，是同一个实例
                    EbProduct product = new EbProduct();
                    //拷贝属性
                    BeanUtils.copyProperties(ebProductList.get(i),product);
                    ebProductList.set(i,product);
                    EbShopProduct shopProduct = ebShopProductList.get(i);
                    PmShopInfo pmShopInfo = pmShopInfoList.get(i);

                    product.setSellPrice(shopProduct.getSellPrice());
                    product.setMemberPrice(shopProduct.getMemberPrice());
                    product.setStoreNums(shopProduct.getStoreNums());
                    product.setShopName(pmShopInfo.getShopName());
                }
            }
        }

        for(EbProduct product:ebProductList){
            PmProductType pmProductType = IdNameUtil.getsbProductTypeName(product.getProductTypeId() + "");
            if(pmProductType!=null){
                product.setProductTypeName(pmProductType.getProductTypeStr());
            }
        }

        String url = new ExcelUtil().export(syllable, ebProductList, "商品列表", request);

        return url;
    }

    @RequiresPermissions("merchandise:pro:edit")
    @RequestMapping(value = "getIsRecommend")
    public String getIsRecommend(EbProduct ebProduct,
                                 HttpServletRequest request, HttpServletResponse response,
                                 Model model, RedirectAttributes redirectAttributes) {
        if (ebProduct.getIsRecommend() != null) {
            if (ebProduct.getIsRecommend() == 0) {
                ebProduct.setIsRecommend(1);
                ebProduct.setRecommendTime(new Date());
            } else {
                ebProduct.setIsRecommend(0);
            }
        } else {
            ebProduct.setIsRecommend(1);
            ebProduct.setRecommendTime(new Date());
        }
        ebProductService.saveProduct(ebProduct);
        addMessage(redirectAttributes, "保存成功");
        return "redirect:" + Global.getAdminPath() + "/Product/list?shopType="+ebProduct.getShopType();
    }

    @RequiresPermissions("merchandise:pro:edit")
    @RequestMapping(value = "getProstatus")
    public String getProstatus(EbProduct ebProduct, HttpServletRequest request,
                               HttpServletResponse response, Model model) {
        if (ebProduct.getPrdouctStatus() != null) {
            if (ebProduct.getPrdouctStatus() == 0) {
                ebProduct.setPrdouctStatus(1);
                EbUser ebUser = ebUserService.getShop(ebProduct.getShopId()
                        .toString());
                EbMessageUser messageInfoUser = new EbMessageUser();
                messageInfoUser.setUserId(ebUser.getUserId());
                EbMessage eMessage = new EbMessage();
                eMessage.setCreateTime(new Date());
                eMessage.setCreateUser("平台管理员");
                eMessage.setMessageAbstract("商品上架通知");
                eMessage.setMessageClass(2);
                eMessage.setMessageContent("您的商品'" + ebProduct.getProductName()
                        + "'被平台管理员上架了");
                eMessage.setMessageIcon("");
                eMessage.setMessageObjId(ebProduct.getProductId());
                eMessage.setMessageType(5);
                ebMessageService.saveflush(eMessage);
                messageInfoUser.setMessageInfo(eMessage);
                messageInfoUser.setState(0);
                messageInfoUser.setUserType(1);
                messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
                messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
                // 推送
                messageInfoUserService.sendMsgJgEbMessageUser(
                        ebUser.getUserId(), eMessage);
            } else if (ebProduct.getPrdouctStatus() == 1) {
                ebProduct.setPrdouctStatus(0);
                EbUser ebUser = ebUserService.getShop(ebProduct.getShopId()
                        .toString());
                EbMessageUser messageInfoUser = new EbMessageUser();
                messageInfoUser.setUserId(ebUser.getUserId());
                EbMessage eMessage = new EbMessage();
                eMessage.setCreateTime(new Date());
                eMessage.setCreateUser("平台管理员");
                eMessage.setMessageAbstract("商品下架通知");
                eMessage.setMessageClass(2);
                eMessage.setMessageContent("您的商品'" + ebProduct.getProductName()
                        + "'被平台管理员下架了");
                eMessage.setMessageIcon("");
                eMessage.setMessageObjId(ebProduct.getProductId());
                eMessage.setMessageType(5);
                ebMessageService.saveflush(eMessage);
                messageInfoUser.setMessageInfo(eMessage);
                messageInfoUser.setState(0);
                messageInfoUser.setUserType(1);
                messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
                messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
                // 推送
                messageInfoUserService.sendMsgJgEbMessageUser(
                        ebUser.getUserId(), eMessage);
            }
        } else {
            ebProduct.setPrdouctStatus(1);
        }

        ebProductService.saveProduct(ebProduct);

        return "redirect:" + Global.getAdminPath() + "/Product/list?shopType="+ebProduct.getShopType();
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
                        } else if("0".equals(status)){
                            messageAbstract = "商品下架通知";
                            messageContent = "您的商品" + product.getProductName()
                                    + "被平台管理员下架了";
                            product.setPrdouctStatus(0);
                            product.setDownTime(new Date());
                        }else{
                            messageAbstract = "商品删除通知";
                            messageContent = "您的商品" + product.getProductName()
                                    + "被平台管理员删除";
                            product.setPrdouctStatus(2);
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

    @ResponseBody
    @RequiresPermissions("merchandise:pro:edit")
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

    @ResponseBody
    @RequiresPermissions("merchandise:pro:edit")
    @RequestMapping(value = "getzijin")
    public String getzijin(EbProduct ebProduct, HttpServletRequest request,
                           HttpServletResponse response, Model model,
                           RedirectAttributes redirectAttributes) {
        if (ebProduct.getLovePayGain() != null) {
            if (ebProduct.getLovePayGain() == 1) {
                ebProduct.setLovePayGain(2);
            } else {
                ebProduct.setLovePayGain(1);
            }
        } else {
            ebProduct.setLovePayGain(2);
        }
        ebProductService.saveProduct(ebProduct);
        return "00";
    }

    /**
     * 积分商城下架
     *
     * @param ebProduct
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:pro:edit")
    @RequestMapping(value = "getzijinUp")
    @ResponseBody
    public JSONObject getzijinUp(EbProduct ebProduct,
                                 HttpServletRequest request, HttpServletResponse response,
                                 Model model, RedirectAttributes redirectAttributes) {
        JSONObject json = new JSONObject();
        String ktvs[] = request.getParameterValues("ktvs");
        if (ktvs != null && ktvs.length > 0) {
            for (int i = 0; i < ktvs.length; i++) {
                if (StringUtils.isNotBlank(ktvs[i])) {
                    EbProduct product = ebProductService.getEbProduct(ktvs[i]);
                    if (product != null) {
                        product.setPrdouctStatus(0);
                        // product.setProductViewMall(0);
                        product.setDownTime(new Date());
                        ebProductService.saveProduct(product);
                        if (ebProduct.getShopId() != null) {
                            EbUser ebUser = ebUserService.getShop(ebProduct
                                    .getShopId().toString());
                            if (ebUser != null) {
                                EbMessageUser messageInfoUser = new EbMessageUser();
                                messageInfoUser.setUserId(ebUser.getUserId());
                                EbMessage eMessage = new EbMessage();
                                eMessage.setCreateTime(new Date());
                                eMessage.setMessageIcon("/upload/drawable-xhdpi/xtfk.png");
                                eMessage.setCreateUser("平台管理员");
                                eMessage.setMessageAbstract("商品下架通知");
                                eMessage.setMessageTitle("商品下架通知");
                                eMessage.setMessageClass(2);
                                eMessage.setMessageContent("您的商品'"
                                        + ebProduct.getProductName()
                                        + "'被平台管理员下架了");
                                eMessage.setMessageObjId(ebProduct
                                        .getProductId());
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
     * 积分商城上架
     *
     * @param ebProduct
     * @param request
     * @param response
     * @param model
     * @return
     */

    @RequestMapping(value = "getzijinSave")
    @ResponseBody
    public JSONObject getzijinSave(EbProduct ebProduct,
                                   HttpServletRequest request, HttpServletResponse response,
                                   Model model) {
        JSONObject json = new JSONObject();
        String productViewMallt = request.getParameter("productViewMallt");
        String ktvs[] = request.getParameterValues("ktvs");
        if (ktvs != null && ktvs.length > 0) {
            for (int i = 0; i < ktvs.length; i++) {
                if (StringUtils.isNotBlank(ktvs[i])) {
                    EbProduct product = ebProductService.getEbProduct(ktvs[i]);
                    if (product != null) {
                        String type = "";
                        if (productViewMallt.equals("1")) {
                            type = "被上架到普通商城了";
                        } else if (productViewMallt.equals("2")) {
                            type = "被上架到积分商城了";
                        } else if (productViewMallt.equals("3")) {
                            type = "被上架到积分商城和普通商城了";
                        }

                        product.setProductViewMall(Integer
                                .parseInt(productViewMallt));
                        if (StringUtils.isNotBlank(productViewMallt)
                                && "0".equals(productViewMallt)) {
                            product.setProductViewMall(1);
                        }

                        product.setUpTime(new Date());
                        product.setPrdouctStatus(1);
                        ebProductService.saveProduct(product);
                        if (ebProduct.getShopId() != null) {
                            EbUser ebUser = ebUserService.getShop(ebProduct
                                    .getShopId().toString());
                            EbMessageUser messageInfoUser = new EbMessageUser();
                            messageInfoUser.setUserId(ebUser.getUserId());
                            EbMessage eMessage = new EbMessage();
                            eMessage.setCreateTime(new Date());
                            eMessage.setCreateUser("平台管理员");
                            eMessage.setMessageAbstract("商品上架通知");
                            eMessage.setMessageTitle("商品上架通知");
                            eMessage.setMessageClass(2);
                            eMessage.setMessageContent("您的商品'"
                                    + ebProduct.getProductName() + "'" + type);
                            eMessage.setMessageIcon("/upload/drawable-xhdpi/xtfk.png");
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
     * 是否开启消费金支付
     *
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:pro:edit")
    @ResponseBody
    @RequestMapping(value = "eaitIsisConsumptionPointsPay")
    public JSONObject eaitIsisConsumptionPointsPay(HttpServletRequest request,
                                                   HttpServletResponse response, Model model,
                                                   RedirectAttributes redirectAttributes) {
        JSONObject json = new JSONObject();
        json.put("code", "01");
        json.put("msg", "失败");
        String productId = request.getParameter("productId");
        if (StringUtils.isNotBlank(productId)) {
            EbProduct ebProduct = ebProductService.getEbProduct(productId);
            if (ebProduct != null) {
                if (ebProduct.getIsConsumptionPointsPay() != null) {
                    if (ebProduct.getIsConsumptionPointsPay() == 0) {
                        ebProduct.setIsConsumptionPointsPay(1);
                    } else {
                        ebProduct.setIsConsumptionPointsPay(0);
                    }
                } else {
                    ebProduct.setIsConsumptionPointsPay(1);
                }
                ebProductService.saveProduct(ebProduct);
                json.put("code", "00");
                json.put("msg", "成功");
                return json;
            } else {
                json.put("code", "01");
                json.put("msg", "商品异常");
                return json;
            }
        } else {
            json.put("code", "01");
            json.put("msg", "商品id不能为空");
            return json;
        }
    }

    /**
     * 是否进入激活专区
     *
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:pro:edit")
    @ResponseBody
    @RequestMapping(value = "eaitIsisActivateProduct")
    public JSONObject eaitIsisActivateProduct(HttpServletRequest request,
                                              HttpServletResponse response, Model model,
                                              RedirectAttributes redirectAttributes) {
        JSONObject json = new JSONObject();
        json.put("code", "01");
        json.put("msg", "失败");
        String productId = request.getParameter("productId");
        if (StringUtils.isNotBlank(productId)) {
            EbProduct ebProduct = ebProductService.getEbProduct(productId);
            if (ebProduct != null) {
                if (ebProduct.getIsActivateProduct() != null) {
                    if (ebProduct.getIsActivateProduct() == 0) {
                        ebProduct.setIsActivateProduct(1);
                    } else {
                        ebProduct.setIsActivateProduct(0);
                    }
                } else {
                    ebProduct.setIsConsumptionPointsPay(1);
                }
                ebProductService.saveProduct(ebProduct);
                json.put("code", "00");
                json.put("msg", "成功");
                return json;
            } else {
                json.put("code", "01");
                json.put("msg", "商品异常");
                return json;
            }
        } else {
            json.put("code", "01");
            json.put("msg", "商品id不能为空");
            return json;
        }
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
        folder.append("product");
        folder.append(File.separator);
        folder.append("adImg");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }

    /**
     * 大宗贸易
     */
    @RequestMapping(value = "/bigBlist")
    public String getEbBlockTradinglist(EbBlockTrading ebBlockTrading,
                                        HttpServletRequest request, HttpServletResponse response,
                                        Model model, @ModelAttribute("msg") String msg) {
        SysUser currentUser = SysUserUtils.getUser();
        Page<EbBlockTrading> page = ebBlockTradingService.getList(currentUser,
                ebBlockTrading, new Page<EbBlockTrading>(request, response));
        System.out.println(page);
        model.addAttribute("msg", msg);
        model.addAttribute("page", page);
        return "modules/shopping/brands/EbBlockTradinglist";
    }

    @InitBinder
    public void initBinder(ServletRequestDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(
                dateFormat, true));
    }

    /**
     * 添加大宗贸易
     *
     * @param ebProduct
     * @param request
     * @param response
     * @param expiryDate
     * @param type
     * @param production
     * @param model
     * @return
     */
    @RequestMapping(value = "/addsuplyinfo")
    public String addEbBlockTradinglist(EbProduct ebProduct,
                                        HttpServletRequest request, HttpServletResponse response,
                                        String expiryDate, String production, Model model,
                                        @ModelAttribute("msg") String msg,
                                        @ModelAttribute("type") String type) {
        model.addAttribute("msg", msg);
        String id = request.getParameter("id");
        String flag = request.getParameter("flag");
        if (StringUtils.isNotBlank(id)) {
            EbBlockTrading ebBlockTrading = ebBlockTradingService
                    .getEbBlockTradingById(Integer.parseInt(id));
            model.addAttribute("ebBlockTrading", ebBlockTrading);
        }

        model.addAttribute("type", type);
        model.addAttribute("flag", flag);
        return "modules/shopping/brands/addEbBlockTrading";
    }

    @RequestMapping(value = "/suplyinfoJson")
    public String addSupplyInfo(EbBlockTrading ebBlockTrading,
                                HttpServletRequest request, RedirectAttributes redirectAttributes) {
        SysUser currentUser = SysUserUtils.getUser();
        Map<String, Object> map = new HashMap<String, Object>();
        String userName = currentUser != null ? currentUser.getLoginName() : "";
        if (ebBlockTrading.getId() == null) {
            map = ebBlockTradingService.addEbBlockTrading(ebBlockTrading,
                    userName, 1);
            redirectAttributes.addFlashAttribute("msg", map.get("msg"));
        } else {
            map = ebBlockTradingService.addEbBlockTrading(ebBlockTrading,
                    userName, 2);
            redirectAttributes.addFlashAttribute("type", map.get("type"));
            redirectAttributes.addFlashAttribute("msg", map.get("msg"));
        }

        return "redirect:" + Global.getAdminPath() + "/Product/addsuplyinfo";
    }
    @RequiresPermissions("merchandise:certificatelist:edit")
    @RequestMapping(value = "/deleteInfo")
    public String deleteInfo(HttpServletRequest request,
                             RedirectAttributes redirectAttributes) {
        SysUser currentUser = SysUserUtils.getUser();
        Map<String, Object> map = new HashMap<String, Object>();
        String userName = currentUser != null ? currentUser.getLoginName() : "";
        Integer id = Integer.parseInt(request.getParameter("id"));
        String updateDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                .format(new Date());
        int result = ebBlockTradingService.deleteById(id, updateDate, userName);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("msg", "删除成功");
        } else {
            redirectAttributes.addFlashAttribute("msg", "删除失败");
        }

        return "redirect:" + Global.getAdminPath() + "/Product/bigBlist";
    }
    @RequiresPermissions("merchandise:certificatelist:view")
    @RequestMapping(value = "/certificatelist")
    public String getCertificatelist(EbCertificate ebCertificate,
                                     HttpServletRequest request, HttpServletResponse response,
                                     Model model, @ModelAttribute("msg") String msg, String startDate,
                                     String endDate) {
        Page<EbCertificate> page = ebCertificateService.getList(ebCertificate,
                new Page<EbCertificate>(request, response), startDate, endDate,null);

        for(EbCertificate certificate : page.getList()){
            if(certificate.getProductType()!=null&&certificate.getProductType()==1){
                certificate.setProductInfos( ebProductService.getProductNameByIds(certificate.getProductTypeId()));
            }
            if(certificate.getShopType()!=null&&certificate.getShopType()==1){
                certificate.setShopInfos( pmShopInfoService.getShopInfoByIds(certificate.getShopTypeId()));
            }

        }

        System.out.println(request.getParameter("startDate"));
        System.out.println(page);
        model.addAttribute("page", page);
        model.addAttribute("msg", msg);
        model.addAttribute("certificate",ebCertificate);
        model.addAttribute("startDate",startDate);
        model.addAttribute("endDate",endDate
        );
        return "modules/shopping/brands/EbCertificatelist";
    }

    /**
     * 导航到新增优惠券页面
     *
     * @param ebCertificate
     * @param request
     * @param response
     * @param model
     * @param msg
     * @return
     */
    @RequiresPermissions("merchandise:certificatelist:edit")
    @RequestMapping(value = "/addcertificate")
    public String addCertificate(EbCertificate ebCertificate,
                                 HttpServletRequest request, HttpServletResponse response,
                                 Model model, @ModelAttribute("msg") String msg,
                                 @ModelAttribute("type") String type) {
        model.addAttribute("msg", msg);
        String id = request.getParameter("id");
        String flag = request.getParameter("flag");
        if (StringUtils.isNotBlank(id)) {
            EbCertificate ebCertificate2 = ebCertificateService
                    .getEbCertificateById(Integer.parseInt(id));
//			String remark=ebCertificateUserService.getEnabledRemark(ebCertificate2.getCertificateId());
            model.addAttribute("ebCertificate", ebCertificate2);
            model.addAttribute("remarksys", ebCertificate2.getEnabledRemarkSys());

        }
        List<EbCertificateLocation> ebCertificateLocations=ebCertificateLocationService.getCertificateslocation();
        SysUser currentUser = SysUserUtils.getUser();
        EbProduct ebProduct = new EbProduct();
        Page<EbProduct> page = ebProductService.getEbProductList(currentUser,
                ebProduct, new Page<EbProduct>(request, response), "", "", "",
                "", "", "", "", "",null);

//		List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
        model.addAttribute("page", page);
//		model.addAttribute("allShop", allShop);
        model.addAttribute("flag", flag);
        model.addAttribute("type", type);
        model.addAttribute("ebCertificateLocations", ebCertificateLocations);
        return "modules/shopping/brands/addEbCertificate";

    }
    /**
     * 优惠卷发放列表
     * @param ebCertificateLocation
     * @param request
     * @param response
     * @param model
     * @param msg
     * @param startDate
     * @param endDate
     * @return
     */
    @RequiresPermissions("eb:certificatelocaltion:view")
    @RequestMapping(value = "/certificatelocaltionlist")
    public String getCertificateLocaltionlist(EbCertificateLocation ebCertificateLocation,
                                              HttpServletRequest request, HttpServletResponse response,
                                              Model model, @ModelAttribute("msg") String msg, String startDate,
                                              String endDate) {
        Page<EbCertificateLocation> page = ebCertificateLocationService.getList(ebCertificateLocation,new Page<EbCertificateLocation>(request, response), startDate, endDate);

        model.addAttribute("page", page);
        model.addAttribute("msg", msg);
        return "modules/shopping/brands/EbCertificateLocaltionlist";
    }

    /**
     * 编辑或添加投放位置
     * @param ebCertificateLocation
     * @param request
     * @param response
     * @param model
     * @param msg
     * @return
     */
    @RequiresPermissions("eb:certificatelocaltion:edit")
    @RequestMapping(value = "/addcertificatelocaltion")
    public String addCertificateLocaltion(EbCertificateLocation ebCertificateLocation,
                                          HttpServletRequest request, HttpServletResponse response,
                                          Model model, @ModelAttribute("msg") String msg) {
        if(ebCertificateLocation.getId()!=null){
            ebCertificateLocation=ebCertificateLocationService.getEbCertificateLocationById(ebCertificateLocation.getId());
        }else{
            ebCertificateLocation.setStatus(1);
        }
        model.addAttribute("msg", msg);
        model.addAttribute("ebCertificateLocation", ebCertificateLocation);
        return "modules/shopping/brands/addEbCertificateLocaltion";

    }

    /**
     * 选择投放优惠券
     * @param ebCertificate
     * @param request
     * @param response
     * @param model
     * @param startDate
     * @param endDate
     * @return
     */
    @RequiresPermissions("eb:certificatelocaltion:edit")
    @RequestMapping(value = "/chooseCertificate")
    public String chooseCertificate(EbCertificate ebCertificate, HttpServletRequest request,
                                    HttpServletResponse response, Model model, String startDate,
                                    String endDate) {
        String ids=request.getParameter("ids");//优惠券id，逗号隔开
        String chooseIds=request.getParameter("chooseIds");//默认选择的优惠券
        String msg="";
        if(StringUtils.isNotBlank(ids)&&!Pattern.matches("\\d+(,\\d+)*",ids)){
            ids=null;
            msg="优惠券编码格式不正确，请以英文逗号隔开，例如：1,2,3";
        }
        Page<EbCertificate> page = ebCertificateService.getList(ebCertificate,new Page<EbCertificate>(request, response), startDate, endDate,ids);
        for(EbCertificate certificate : page.getList()){
            if(certificate.getProductType()!=null&&certificate.getProductType()==1){
                certificate.setProductInfos( ebProductService.getProductNameByIds(certificate.getProductTypeId()));
            }
            if(certificate.getShopType()!=null&&certificate.getShopType()==1){
                certificate.setShopInfos( pmShopInfoService.getShopInfoByIds(certificate.getShopTypeId()));
            }

        }
        model.addAttribute("page", page);
        model.addAttribute("msg", msg);
        model.addAttribute("ids", ids);
        model.addAttribute("chooseIds", chooseIds);
        return "modules/shopping/brands/chooseCertificatelist";

    }

    /**
     * 开启关闭投放
     * @param ebCertificateLocation
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:certificatelocaltion:edit")
    @ResponseBody
    @RequestMapping(value = "LocaltionStatus")
    public Map status(EbCertificateLocation ebCertificateLocation, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
        Map map=new HashMap();
        SysUser sysUser=SysUserUtils.getUser();
        //获取修改的优惠券信息
        ebCertificateLocation=ebCertificateLocationService.getEbCertificateLocationById(ebCertificateLocation.getId());
        ebCertificateLocation.setUpdateDate(new Date());
        ebCertificateLocation.setUpdateBy(sysUser.getId());
        if(ebCertificateLocation.getStatus()!=null&&ebCertificateLocation.getStatus()==0){
            ebCertificateLocation.setStatus(1);
            map.put("msg","开启成功");
        }else{
            ebCertificateLocation.setStatus(0);
            map.put("msg","关闭成功");
        }
        ebCertificateLocationService.save(ebCertificateLocation);
        map.put("ebCertificateLocation",ebCertificateLocation);
        map.put("code","00");

        return map;
    }

    /**
     * 保存或新增优惠券投放
     * @param ebCertificateLocation
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("eb:certificatelocaltion:edit")
    @RequestMapping(value = "saveCertificatelocaltion")
    public String saveCertificatelocaltion(EbCertificateLocation ebCertificateLocation,HttpServletRequest request, HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) {
        SysUser sysUser=SysUserUtils.getUser();
        String msg;
        if(ebCertificateLocation.getId()!=null){
            ebCertificateLocation.setUpdateBy(sysUser.getId());
            ebCertificateLocation.setUpdateDate(new Date());
            msg="修改成功";
        }else{
            ebCertificateLocation.setCreateBy(sysUser.getId());
            ebCertificateLocation.setCreateDate(new Date());
            msg="添加成功";
        }
        ebCertificateLocation.setDelflag(0);
        ebCertificateLocationService.save(ebCertificateLocation);
        addMessage(redirectAttributes, msg);
        return "redirect:"+Global.getAdminPath()+"/Product/certificatelocaltionlist";
    }

    /**
     * 删除投放
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("eb:certificatelocaltion:edit")
    @RequestMapping(value = "/deletecertificatelocaltion")
    @ResponseBody
    public Map deletecertificatelocaltion(HttpServletRequest request,
                                          RedirectAttributes redirectAttributes) {
        Map map=new HashMap();
        Integer id = Integer.parseInt(request.getParameter("id"));
        EbCertificateLocation ebCertificateLocation = ebCertificateLocationService.getEbCertificateLocationById(id);
        ebCertificateLocation.setDelflag(1);
        ebCertificateLocationService.save(ebCertificateLocation);
        map.put("code","00");
        map.put("msg","删除成功");
        return map;
    }
    @RequestMapping(value = "/chooseProducts")
    public String chooseProducts(EbProduct ebProduct, String stule,
                                 String statrPrice, String stopPrice, String statrDate,
                                 String stopDate, String priceType, String podateType,
                                 String isLovePay, HttpServletRequest request,
                                 HttpServletResponse response, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        SysUser currentUser = SysUserUtils.getUser();
        Page<EbProduct> page = ebProductService.getEbProductList(currentUser,
                ebProduct, new Page<EbProduct>(request, response), podateType,
                statrDate, stopDate, "", "", priceType, statrPrice, stopPrice,null);
        model.addAttribute("page", page);
        return "modules/shopping/brands/chooseProductlist";

    }

    /**
     * 选择门店
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/chooseShops")
    public String chooseShops(String shopIds ,String shopNames, PmShopInfo pmShopInfo, HttpServletRequest request,
                              HttpServletResponse response, Model model,String openingTime , String closingTime) {

        Page<PmShopInfo> page = pmShopInfoService.getPageList(new Page<PmShopInfo>(request, response), pmShopInfo,
                openingTime, closingTime);


        if(StringUtil.isNotBlank(shopIds) && StringUtils.isBlank(shopNames)){
            List<String> shopNameList = new ArrayList<String>();
            String[] strings = shopIds.split(",");
            for(int i = 0 ; i < strings.length ; i++){
                PmShopInfo info = pmShopInfoService.getpmPmShopInfo(strings[i]);
                if(info == null){
                    continue;
                }
                shopNameList.add(info.getShopName());
            }
            shopNames = shopNameList.toString().replace("[","").replace("]","");
        }

        model.addAttribute("shopNames",shopNames);
        model.addAttribute("page", page);
        model.addAttribute("pmShopInfo", pmShopInfo);
        model.addAttribute("shopIds", shopIds);
        return "modules/shopping/brands/chooseShoplist";

    }

    /**
     * 选择非自营门店
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/chooseNoSelfShops")
    public String chooseNoSelfShops(String chooseIds , PmShopInfo pmShopInfo, String shopNames,HttpServletRequest request,
                                    HttpServletResponse response, Model model,String openingTime , String closingTime) {

        Page<PmShopInfo> page = pmShopInfoService.getNoSelfShopList(new Page<PmShopInfo>(request, response), pmShopInfo,
                openingTime, closingTime);


        if(StringUtil.isNotBlank(chooseIds) && StringUtil.isBlank(shopNames)){
            List<String> shopNameList = new ArrayList<String>();
            String[] strings = chooseIds.split(",");
            for(int i = 0 ; i < strings.length ; i++){
                PmShopInfo info = pmShopInfoService.getpmPmShopInfo(strings[i]);
                if(info == null){
                    continue;
                }
                shopNameList.add(info.getShopName());
            }
            shopNames = shopNameList.toString().replace("[","").replace("]","");
        }

        model.addAttribute("shopNames",shopNames);
        model.addAttribute("page", page);
        model.addAttribute("pmShopInfo", pmShopInfo);
        model.addAttribute("chooseIds", chooseIds);
        return "modules/shopping/brands/chooseNoSelfShop";

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
    @RequiresPermissions("merchandise:certificatelist:edit")
    @RequestMapping(value = "/addcertificateJson")
    public String addCertificateJson(EbCertificate ebCertificate,
                                     RedirectAttributes redirectAttributes, HttpServletRequest request,
                                     HttpServletResponse response, Model model, Date startDate,
                                     Date endDate, Date sendtime) {
        Map<String, Object> map = new HashMap<String, Object>();
        if((ebCertificate.getType()==3||ebCertificate.getType()==4)&&(ebCertificate.getAmount()<0||ebCertificate.getAmount()>=10)){
//            折扣不得大于等于10或小于0
            return null;
        }
        if(ebCertificate.getProvinceOutFullFreight()<0){
//            满减金额不能为空或者小于0
            return null;
        }
        if (ebCertificate.getCertificateId() == null) {
            ebCertificate.setEnabledSys(0);
            map = ebCertificateService.addEbCertificate(ebCertificate, 1);
        } else {
            String enabledSysRemark=request.getParameter("enabledSysRemark");
            if(ebCertificate.getEnabledSys()==1){
                if(StringUtils.isBlank(enabledSysRemark)){
                    redirectAttributes.addFlashAttribute("msg", "禁用原因不能为空");
                    redirectAttributes.addFlashAttribute("type", map.get("flag"));
                    return "redirect:" + Global.getAdminPath() + "/Product/addcertificate";
                }else{
                    ebCertificateUserService.setEbCertificateUserEnabled(ebCertificate.getCertificateId(), ebCertificate.getEnabledSys(), enabledSysRemark);
                    System.out.println("禁用");
                }

            }else{
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
            ebCertificate.setCreateTime(cate2.getCreateTime());
            ebCertificate.setDelflag(0);
            ebCertificate.setEnabledSys(ebCertificate.getEnabledSys());
            ebCertificate.setShopId(cate2.getShopId());
            ebCertificate.setEnabledRemarkSys(enabledSysRemark);
            map = ebCertificateService.addEbCertificate(ebCertificate, 2);
        }

        redirectAttributes.addFlashAttribute("msg", map.get("msg"));
        redirectAttributes.addFlashAttribute("type", map.get("flag"));
        return "redirect:" + Global.getAdminPath() + "/Product/addcertificate";
    }

    /**
     * 优惠券选择分类
     *
     * @param extId
     * @param response
     * @return
     */
    @RequiresUser
    @ResponseBody
    @RequestMapping(value = "/category/treeData")
    public List<Map<String, Object>> treeData(
            @RequestParam(required = false) Long extId,
            HttpServletResponse response) {
        response.setContentType("application/json; charset=UTF-8");
        List<Map<String, Object>> mapList = Lists.newArrayList();
        List<PmProductType> list = pmProductTypeService
                .getSbProductTypeHQLList("");
        String name = "";
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i) != null) {
                PmProductType e = list.get(i);
                if (extId == null
                        || (extId != null && !extId.equals(e.getId()) && e
                        .getProductTypeIdStr().indexOf(
                                "," + extId + ",") == -1)) {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", e.getId());
                    map.put("pId", e.getParentId() != null ? e.getParentId()
                            : 0);
                    map.put("name", e.getProductTypeName());
                    mapList.add(map);
                }
            }
        }
        return mapList;
    }

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

        return "redirect:" + Global.getAdminPath() + "/Product/certificatelist";
    }


    /**
     * 根据商品id查询所有所属门店
     * @param pmShopInfo
     * @param model
     * @param productId
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("findShopsByProduct")
    public String findShopsByProduct(PmShopInfo pmShopInfo , Model model,Integer productId  , HttpServletRequest request, HttpServletResponse response){

        Page<ShopInfo> page = ebShopProductService.getShopsByProductId(pmShopInfo , productId, new Page<ShopInfo>(request, response));

        model.addAttribute("page" ,page);
        model.addAttribute("pmShopInfo" ,pmShopInfo);
        model.addAttribute("productId" ,productId);
        return "modules/shopping/brands/showShopsByProductId";
    }


    /**
     * 单规格更新价格和库存
     * @param ebShopProduct
     * @return
     */
    @RequestMapping("updatePriceAndStoreNums")
    @ResponseBody
    public Map<String , String>  updatePriceAndStoreNums(EbShopProduct ebShopProduct,String newStoreNum){
        Map<String , String> map = new HashMap<String, String>();
        EbShopProduct oldEbShopProduct = ebShopProductService.getById(ebShopProduct.getId());
        if(oldEbShopProduct == null){
            map.put("prompt","fail");
            map.put("msg","信息有误");
            return map;
        }

        Integer measuringType = oldEbShopProduct.getMeasuringType();
        Integer measuringUnit = oldEbShopProduct.getMeasuringUnit();
        //只有计量单位为公斤时，才可以输入小数


        if(String.valueOf(newStoreNum).indexOf('.')>=0){

            if(measuringType == null || measuringType ==1){
                map.put("msg","当前计量单位为件，库存不能为小数");
                map.put("prompt","fail");
                return map;
            }

            if(measuringUnit!=null && measuringType == 2   && measuringUnit ==2){
                map.put("msg","当前计量单位为克，库存不能为小数");
                map.put("prompt","fail");
                return map;
            }

        }


        //把库存先转成int
        if(measuringType !=null && measuringType ==2) {
            if(measuringUnit != null && measuringUnit==1 ){
                ebShopProduct.setStoreNums((int)(Double.parseDouble(newStoreNum)*1000));
            }else if(measuringUnit != null && measuringUnit==3 ){
                ebShopProduct.setStoreNums((int)(Double.parseDouble(newStoreNum)*500));
            }else{
                ebShopProduct.setStoreNums(Integer.parseInt(newStoreNum));
            }
        }else{
            ebShopProduct.setStoreNums(Integer.parseInt(newStoreNum));
        }

        //更新商品门店关联表
        boolean result = ebShopProductService.updatePriceAndStoreNums(ebShopProduct);
        if(!result){
            map.put("prompt","fail");
            map.put("msg","修改失败");
        }else{
            map.put("prompt","success");
            map.put("msg","修改成功");
        }

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
        boolean flag = ebShopProductStandardDetailService.updatePriceAndStoreNum(detail);
        if(!flag){
            map.put("prompt","fail");
            return map;
        }

        List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                .getProductIdPmProductStandardDetail(detail.getProductId().toString());

        String detailIds = FormatUtil.getFieldAllValue(pmProductStandardDetails,"id");

//        查询当前商品的所有规格
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
        ebShopProduct.setMemberPrice(detail.getMemberPrice());
//        rangeArr  0 会员价范围  1 销售价范围
        String[] rangeArr = ebShopProductService.updateRange(ebShopProduct , detailList);
        if(rangeArr == null){
            map.put("prompt","fail");
            return map;
        }else{
            map.put("prompt","success");
        }

        map.put("rangeArr",rangeArr[0]+","+rangeArr[1]+","+storeCount);

        return map;
    }
    /**
     * 批量更新多规格的信息
     * @param arr 多规格id  [23:809,24:810]
     * @return
     */
    @RequestMapping("updateStandardDetailPl")
    @ResponseBody
    public Map<String , String> updateStandardDetailPl(String arr , Integer productShopId, Integer productId, Double detailPrices, Double memberPrice, Integer detailInventory){
        Map<String , String> map = new HashMap<String, String>();
        String arrs[]=arr.split(";");
        List<PmProductStandardDetail> pmProductStandardDetails = pmProductStandardDetailService
                .getProductIdPmProductStandardDetail(productId.toString());
        for(PmProductStandardDetail pmProductStandardDetail:pmProductStandardDetails){
            int flag=1;//可以修改值
            for(String ar:arrs){
                if(StringUtil.isBlank(ar)||(";"+pmProductStandardDetail.getStandardIdStr()+";").indexOf(";"+ar+";")!=-1){

                }else{
                    flag=-1;
                }
            }
            if(flag==1){
                EbShopProductStandardDetail detail=new EbShopProductStandardDetail();
                detail.setProductId(productId);
                detail.setShopId(productShopId);
                detail.setProductStandardId(pmProductStandardDetail.getId());
                detail.setDetailPrices(detailPrices);
                detail.setMemberPrice(memberPrice);
                detail.setDetailInventory(detailInventory);
                //更新商家商品多规格关联信息表
               ebShopProductStandardDetailService.updatePriceAndStoreNumPl(detail);
            }
        }
        String detailIds = FormatUtil.getFieldAllValue(pmProductStandardDetails,"id");

//        查询当前商品的所有规格
        List<EbShopProductStandardDetail> detailList = ebShopProductStandardDetailService.getByShopIdAndProductId(productShopId, productId,detailIds);

        //统计总库存
        Integer  storeCount = 0;
        for(EbShopProductStandardDetail ebShopProductStandardDetail : detailList){
            storeCount += ebShopProductStandardDetail.getDetailInventory();
        }

        //更新商品门店关联表
        EbShopProduct ebShopProduct = ebShopProductService.getByProductIdAndShopId(productId,productShopId);
//        ebShopProduct.setId(productShopId);
        ebShopProduct.setStoreNums(storeCount);
//        rangeArr  0 会员价范围  1 销售价范围
        String[] rangeArr = ebShopProductService.updateRange(ebShopProduct , detailList);
        if(rangeArr == null){
            map.put("prompt","fail");
            return map;
        }else{
            map.put("prompt","success");
        }

        map.put("rangeArr",rangeArr[0]+","+rangeArr[1]+","+storeCount);

        return map;
    }

    /**
     * 快速给门店增加商品,用于门店列表的增加商品
     * @return
     */

    @RequestMapping(value="quickChooseProduct")
    public String quickChooseProduct(HttpServletRequest request,HttpServletResponse response , Model model,
                                     EbProduct ebProduct,Integer shopId,String productIds,String productNames){

        //获得所有的商品
        ebProduct.setShopType(1);
        Page<EbProduct> page = ebProductService.getEbProductList(ebProduct, new Page<EbProduct>(request, response));

        if (ebProduct.getProductTypeId() != null) {
            PmProductType pmProductType = pmProductTypeService.getSbProductType(ebProduct.getProductTypeId().toString());
            model.addAttribute("sbProductType", pmProductType);
        }

        productIds = productIds == null ? "" : productIds;
        //当productIds为空时，说明是第一次进入，需要查询门店原有的商品
        if(StringUtil.isBlank(productIds)){
            //获得该门店原有的商品
            List<EbShopProduct> shopProductList = ebShopProductService.getListByShopId(shopId);
            if(CollectionUtils.isNotEmpty(shopProductList)){
                productIds = FormatUtil.getFieldAllValue(shopProductList,"productId");
            }
        }

        StringBuffer nameBuf = new StringBuffer();
        //当第一次进入时，需要查询商品id对应的商品名
        if(StringUtils.isNotBlank(productIds) && StringUtils.isBlank(productNames)){
            for(String productId : productIds.split(",")){
                EbProduct ebProductById = ebProductService.getEbProductById(Integer.valueOf(productId));
                nameBuf.append(ebProductById.getProductName()+",");
            }
        }

        if(nameBuf.length() > 0){
            nameBuf.setLength(nameBuf.length()-1);
            productNames=nameBuf.toString();
        }


        model.addAttribute("productIds",productIds);
        model.addAttribute("productNames",productNames);
        model.addAttribute("page",page);

        return "modules/shopping/brands/quickChooseProduct";
    }

    /**
     * 选中所有的商品
     * @param request
     * @param response
     * @param model
     * @param ebProduct
     * @param shopId
     * @param productIds
     * @param productNames
     * @return
     */
    @ResponseBody
    @RequestMapping(value="selectAllProduct")
    public Map<String , String > selectAllProduct(HttpServletRequest request,HttpServletResponse response , Model model,
                                                  EbProduct ebProduct,Integer shopId,String productIds,String productNames){
        //获得所有的商品
        ebProduct.setShopType(1);
        Page<EbProduct> page = ebProductService.getEbProductList(ebProduct, new Page<EbProduct>(1, Integer.MAX_VALUE));

        String ids = FormatUtil.getFieldAllValue(page.getList(), "productId");
        String names = FormatUtil.getFieldAllValue(page.getList(), "productName");

        Map<String,String> map = new HashMap<String, String>();
        map.put("ids",ids);
        map.put("names",names);

        return map;
    }
    /**
     * 快速给门店增加商品
     * @param shopId
     * @param productIds
     * @return
     */
    @ResponseBody
    @RequestMapping("quickInsertProduct")
    public Map<String , String> quickInsertProduct(Integer shopId , String productIds){
        HashMap<String, String> map = new HashMap<String, String>();

        if(StringUtil.isBlank(productIds) ){
            map.put("prompt","没有添加任何商品");
            map.put("code","2");	//code  0失败 1 成功 2参数异常
        }


        //获得原来的商品id
        List<EbShopProduct> listByShopId = ebShopProductService.getListByShopId(shopId);
        String oldProductIds = FormatUtil.getFieldAllValue(listByShopId, "productId");
        String[] oldProductIdArr = null;
        if(StringUtil.isNotBlank(oldProductIds)){
            oldProductIdArr = oldProductIds.split(",");
        }

        PmShopInfo pmShopInfo = pmShopInfoService.getById(shopId);
        //遍历添加
        for(String productId : productIds.split(",")){
            EbShopProduct ebShopProduct = ebShopProductService.getEbShopProductByProductIdAndShopId(Integer.valueOf(productId), shopId);
            if(ebShopProduct != null){	//已经存在，不处理
                //从将要删除的列表中移除该商品id
                Integer index = ArrayUtils.indexOf(oldProductIdArr, ebShopProduct.getProductId()+"");
                if(index >= 0){
                    oldProductIdArr=(String[])ArrayUtils.remove(oldProductIdArr,index);
                }
                continue;
            }

            EbProduct ebProduct = ebProductService.getEbProduct(productId);
            //获得商品规格
            List<PmProductStandardDetail> detailList = pmProductStandardDetailService.getByProductId(Integer.valueOf(productId));

            //是否是多规格
            boolean isDetail = false;
            //规格不为空说是多规格
            if(detailList != null && detailList.size() >  0){
                isDetail = true;
            }

            ebShopProduct = new EbShopProduct();
            if(isDetail) {		//多规格

                //循环插入门店商品规格关联表信息
                for(PmProductStandardDetail detail : detailList){
                    EbShopProductStandardDetail shopProductStandardDetail = new EbShopProductStandardDetail();

                    //初始化参数
                    shopProductStandardDetail.setDetailPrices(detail.getDetailPrices());
                    shopProductStandardDetail.setCost(0.0);
                    shopProductStandardDetail.setDetailInventory(detail.getDetailInventory());
                    shopProductStandardDetail.setMemberPrice(detail.getMemberPrice());
                    shopProductStandardDetail.setDetailPrices(detail.getDetailPrices());
                    shopProductStandardDetail.setShopId(shopId);
                    shopProductStandardDetail.setProductId(ebProduct.getProductId());
                    shopProductStandardDetail.setCreateTime(new Date());
                    shopProductStandardDetail.setProductStandardId(detail.getId());

                    ebShopProductStandardDetailService.insert(shopProductStandardDetail);
                }

                String sellPriceRange = null;  //销售价的范围
                String memberPriceRange = null;    //会员价的范围

                String detailIds = FormatUtil.getFieldAllValue(detailList, "id");
                List<EbShopProductStandardDetail> standardDetailList = ebShopProductStandardDetailService.getByShopIdAndProductId(shopId, Integer.valueOf(productId), detailIds);
                //当多规格时计算范围
                sellPriceRange = ebShopProductService.getRanage("detailPrices", standardDetailList);
                memberPriceRange = ebShopProductService.getRanage("memberPrice", standardDetailList);

                ebShopProduct.setSellPriceRange(sellPriceRange);
                ebShopProduct.setSellPrice(Double.parseDouble(sellPriceRange.split("~")[0]));
                ebShopProduct.setMemberPriceRange(memberPriceRange);
                ebShopProduct.setMemberPrice(Double.parseDouble(memberPriceRange.split("~")[0]));

                //计算库存
                Integer storeNumCount = 0;
                for(EbShopProductStandardDetail detail : standardDetailList){
                    storeNumCount+=detail.getDetailInventory();
                }
                ebShopProduct.setStoreNums(storeNumCount);
            }else{	//单规格
                ebShopProduct.setSellPrice(ebProduct.getSellPrice());
                ebShopProduct.setMemberPrice(ebProduct.getMemberPrice());
                ebProduct.setStoreNums(ebProduct.getStoreNums());
                ebShopProduct.setSellPriceRange(ebProduct.getSellPrice()+"");
                ebShopProduct.setMemberPriceRange(ebProduct.getMemberPrice()+"");
            }

            //初始化一些参数
            ebShopProduct.setShopId(pmShopInfo.getId());
            ebShopProduct.setShopName(pmShopInfo.getShopName());
            ebShopProduct.setCost(0.0);
            ebShopProduct.setProductId(ebProduct.getProductId());
            ebShopProduct.setCreateTime(new Date());

            //插入门店商品关联表信息
            ebShopProductService.insert(ebShopProduct);
        }

        //如果没有需要删除的商品关联，直接返回
        if(oldProductIdArr == null){
            map.put("prompt","增加成功！");
            map.put("code","1");
            return map;
        }

        for(String productId : oldProductIdArr) {
            //删除掉已经取消的商品的相对于关联记录
            ebShopProductService.deleteByProductIdAndShopId(Integer.valueOf(productId), shopId);
            List<PmProductStandardDetail> detailList = pmProductStandardDetailService.getByProductId(Integer.valueOf(productId));
            if(detailList!=null && detailList.size()>0){   //多规格
                //删除门店商品规格关联表
                ebShopProductStandardDetailService.deleteByProductIdAndShop(Integer.valueOf(productId),
                        shopId,detailList);
            }
        }

        map.put("prompt","增加成功！");
        map.put("code","1");

        return map;
    }


    /**
     * 促销活动申请列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/promotionApplyList")
    @RequiresPermissions("merchandise:promotionApply:view")
    public String promotionApplyList(HttpServletRequest request, HttpServletResponse response,
                                     Model model,EbCertificate ebCertificate,String searchStartDate,
                                     String searchEndDate) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");

        ebCertificate.setCertificateType(1);//促销
        Page<EbCertificate> page = ebCertificateService.getApplyList(ebCertificate,
                new Page<EbCertificate>(request,response), searchStartDate, searchEndDate);

        for (EbCertificate certificate : page.getList()) {
            if (certificate.getProductType() != null && certificate.getProductType() == 1) {
                certificate.setProductInfos(ebProductService.getProductNameByIds(certificate.getProductTypeId()));
            }
            if (certificate.getShopType() != null && certificate.getShopType() == 1) {
                certificate.setShopInfos(pmShopInfoService.getShopInfoByIds(certificate.getShopTypeId()));
            }

            //判断当前是否可用
            certificate.setAvailable(ebCertificateService.promotionIsAvailable(certificate));

            if(certificate.getShopId() != null){
                PmShopInfo pmShopInfo = pmShopInfoService.getById(certificate.getShopId());
                if(pmShopInfo != null){
                    certificate.setShopName(pmShopInfo.getShopName());
                }

            }
        }

        model.addAttribute("page", page);
        model.addAttribute("ebCertificate", ebCertificate);
        model.addAttribute("searchEndDate", searchEndDate);
        model.addAttribute("searchStartDate", searchStartDate);
        return "modules/shopping/brands/promotionApplyList";
    }


    /**
     * 审核促销活动
     * @param id
     * @param applyStatus
     * @param remark
     * @return
     */
    @ResponseBody
    @RequestMapping("checkPromotionApply")
    public Map<String , String> checkPromotionApply(Integer id , Integer applyStatus,String remark){
        Map<String,String> map = new HashMap<String, String>();

        if(id == null || applyStatus == null){
            map.put("code","00");
            map.put("msg","传递参数错误！");
            return map;
        }

        boolean result = ebCertificateService.checkPromotionApply(id, applyStatus);
        if(!result) {
            map.put("code","00");
            map.put("msg","审核失败！");
            return map;
        }

        if(StringUtils.isNotBlank(remark)){
            ebCertificateApplyRemarkService.insert(remark,id);
        }

        map.put("code","01");
        map.put("msg","审核成功！");
        return map;
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
     * 促销活动
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/promotionList")
    @RequiresPermissions("merchandise:promotion:view")
    public String promotionList(
            HttpServletRequest request, HttpServletResponse response,EbCertificate ebCertificate,
            Model model,String searchStartDate , String  searchEndDate) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");

        ebCertificate.setCertificateType(1);//促销
        Page<EbCertificate> page = ebCertificateService.getShopCertificateList(ebCertificate,
                new Page<EbCertificate>(request, response), searchStartDate, searchEndDate, null);

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

        }
        model.addAttribute("page", page);
        model.addAttribute("searchStartDate", searchStartDate);
        model.addAttribute("searchEndDate", searchEndDate);

        return "modules/shopping/brands/promotionList";
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
    @RequestMapping(value = "/promotionForm")
    @RequiresPermissions("merchandise:promotion:edit")
    public String from(HttpServletRequest request, HttpServletResponse response,
                       Model model, @ModelAttribute("msg") String msg,
                       @ModelAttribute("type") String type) {
        return "modules/shopping/brands/addPromotion";
    }

    /**
     * 新增促销活动
     * @return
     */
    @ResponseBody
    @RequiresPermissions("merchandise:promotion:edit")
    @RequestMapping(value = "/editPromotion")
    public Map<String, Object> editPromotion(EbCertificate ebCertificate,String certificateStartDate,String certificateEndDate
    ) throws ParseException {
        EbCertificate newEbCertificate = new EbCertificate();
        Map<String, Object> map = new HashMap<String, Object>();//错误信息

        //验证数据
        if(verificationPromotionData(map,ebCertificate,certificateStartDate,certificateEndDate)){
            //当是修改时，先获取从前的促销活动
            if(ebCertificate.getCertificateId() != null){
                newEbCertificate=ebCertificateService.getEbCertificateById(ebCertificate.getCertificateId());
            }

            newEbCertificate.setPromotionType(ebCertificate.getPromotionType());
            if(ebCertificate.getPromotionType()==2){//第二件打折
                newEbCertificate.setType(5);
            }else if(ebCertificate.getPromotionType()==3){ //团购
                newEbCertificate.setType(6);
            }else {
                newEbCertificate.setType(ebCertificate.getType());
            }
            if(StringUtils.isNotBlank(ebCertificate.getProductTypeId())){
                newEbCertificate.setProductType(1);
                newEbCertificate.setProductTypeId(ebCertificate.getProductTypeId());
            }else{
                newEbCertificate.setProductType(3);
                newEbCertificate.setProductTypeId("");
            }
            if(StringUtils.isNotBlank(ebCertificate.getShopTypeId())){
                newEbCertificate.setShopType(1);
                newEbCertificate.setShopTypeId(ebCertificate.getShopTypeId());
            }else{
                newEbCertificate.setShopType(2);
                newEbCertificate.setShopTypeId("");
            }
            newEbCertificate.setRemark(ebCertificate.getRemark());
            newEbCertificate.setCertificateName(ebCertificate.getCertificateName());
            newEbCertificate.setProvinceOutFullFreight(ebCertificate.getProvinceOutFullFreight());
            newEbCertificate.setAmount(ebCertificate.getAmount());
            newEbCertificate.setBanner(ebCertificate.getBanner());
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            newEbCertificate.setCertificateStartDate(simpleDateFormat.parse(certificateStartDate));
            newEbCertificate.setCertificateEndDate(simpleDateFormat.parse(certificateEndDate));
            newEbCertificate.setSendTime(new Date());
            newEbCertificate.setShopTypeId(ebCertificate.getShopTypeId());
            newEbCertificate.setDelflag(0);
            newEbCertificate.setCertificateType(1);//类型：0、优惠券 1、促销活动
            newEbCertificate.setGroupCertificateNum(ebCertificate.getGroupCertificateNum());
            newEbCertificate.setGroupNum(ebCertificate.getGroupNum());

            if(ebCertificate.getCertificateId() == null) {
                newEbCertificate.setEnabledSys(0);
                newEbCertificate.setCreateTime(new Date());
                newEbCertificate.setIsapply(1);//提交申请
                newEbCertificate.setApplyStatus(1);
                newEbCertificate.setApplyTime(new Date());
            }

            ebCertificateService.save(newEbCertificate);
            map.put("code", "00");

            if(ebCertificate.getCertificateId() == null){
                map.put("msg", "新增促销活动成功");
            }else{
                map.put("msg", "修改促销活动成功");
            }

        }
        return map;
    }



    /**
     * 删除促销活动
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deletePromotion")
    public Map<String,String> deletePromotion(Integer id){
        Map<String,String> map = new HashMap<String, String>();

        if(id == null){
            map.put("code","00");
            map.put("msg","传递参数错误！");
            return map;
        }

        Integer result = ebCertificateService.deleteById(id);
        if(result == null && result<=0) {
            map.put("code","00");
            map.put("msg","删除促销活动失败！");
        }else{
            map.put("code","01");
            map.put("msg","删除促销活动成功！");
        }


        return map;
    }

    /**
     * 选择商品
     * @return
     */
    @RequestMapping(value="chooseProduct")
    public String chooseProduct(HttpServletRequest request,HttpServletResponse response , Model model,
                                EbProduct ebProduct,String productIds,String productNames){

        Page<EbProduct> page = ebProductService.getEbProductList(null,
                ebProduct, new Page<EbProduct>(request, response), null,
                null, null, "", "", null, null, null, null);

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

        return "modules/shopping/brands/chooseProduct";
    }


    /**
     * 选择门店
     * @return
     */
    @RequestMapping(value="chooseShop")
    public String chooseShop(HttpServletRequest request,HttpServletResponse response , Model model,
                             PmShopInfo pmShopInfo,String shopIds,String shopNames){

        Page<PmShopInfo> page = pmShopInfoService.getPageList(new Page<PmShopInfo>(request,response),pmShopInfo);

        //当第一次跳转选择门店时，门店id可能不为空，门店名称一定为空
        if(StringUtils.isNotBlank(shopIds) && StringUtils.isBlank(shopNames)){
            StringBuffer nameBuf = new StringBuffer();
            for(String id : shopIds.split(",")){
                PmShopInfo pmShopInfoById = pmShopInfoService.getById(Integer.valueOf(id));
                if(pmShopInfoById != null){
                    nameBuf.append(pmShopInfoById.getShopName()+",");
                }
            }

            if(nameBuf.length() > 0){
                nameBuf.setLength(nameBuf.length()-1);
                shopNames = nameBuf.toString();
            }
        }
        model.addAttribute("page",page);
        model.addAttribute("pmShopInfo",pmShopInfo);
        model.addAttribute("shopIds",shopIds);
        model.addAttribute("shopNames",shopNames);

        return "modules/shopping/brands/chooseShop";
    }

    /**
     * 选择支付方式
     * @return
     */
    @RequestMapping(value="choosePayWay")
    public String chooseShop(HttpServletRequest request,HttpServletResponse response , Model model,
                             PmOpenPayWay way,String chooseCodes,String chooseNames){

        Page<PmOpenPayWay> page = pmOpenPayWayService.getPageList(new Page<PmOpenPayWay>(request,response),way);

        //当第一次跳转选择门店时，门店id可能不为空，门店名称一定为空
        if(StringUtils.isNotBlank(chooseCodes) && StringUtils.isBlank(chooseNames)){
            chooseNames = pmOpenPayWayService.getPayRemarkByCodes(chooseCodes);
        }
        model.addAttribute("page",page);
        model.addAttribute("pmOpenPayWay",way);
        model.addAttribute("chooseCodes",chooseCodes);
        model.addAttribute("chooseNames",chooseNames);

        return "modules/shopping/brands/choosePayWay";
    }


    /**
     * 验证促销活动的数据的正确性
     * @param map
     * @param ebCertificate
     * @param certificateStartDate
     * @param certificateEndDate
     * @return
     */
    public boolean verificationPromotionData(Map<String, Object> map,EbCertificate ebCertificate,String certificateStartDate ,String certificateEndDate){
        if(ebCertificate.getPromotionType()==null){
            map.put("code","01");
            map.put("msg","促销类型不能为空");
            return false;
        }else if(ebCertificate.getPromotionType()==1 && (ebCertificate.getType()==null||(ebCertificate.getType()!=1&&ebCertificate.getType()!=3))){
            map.put("code","01");
            map.put("msg","促销方式不能为空");
            return false;
        }else if(StringUtil.isBlank(ebCertificate.getCertificateName())){
            map.put("code","01");
            map.put("msg","促销名称不能为空");
            return false;
        }else if(ebCertificate.getProvinceOutFullFreight()==null){
            map.put("code","01");
            map.put("msg","满减金额不能为空");
            return false;
        }else if(ebCertificate.getProvinceOutFullFreight()<0){
            map.put("code","01");
            map.put("msg","满减金额需要是数值，并且需要大于或等于0");
            return false;
        }else if(((ebCertificate.getPromotionType()==1&& ebCertificate.getType()==3)||ebCertificate.getPromotionType()==2)&&ebCertificate.getAmount()==null){
            map.put("code","01");
            map.put("msg","折扣不能为空");
            return false;
        }else if(((ebCertificate.getPromotionType()==1&&ebCertificate.getType()==3)||ebCertificate.getPromotionType()==2)&&(ebCertificate.getAmount()<0||ebCertificate.getAmount()>10)){
            map.put("code","01");
            map.put("msg","折扣需要是数值，并且需要大于0且小于等于10");
            return false;
        }else if((ebCertificate.getPromotionType()==1&&ebCertificate.getType()==1)&& ebCertificate.getAmount()==null){
            map.put("code","01");
            map.put("msg","优惠金额不能为空");
            return false;
        }else if(ebCertificate.getPromotionType()==3&&ebCertificate.getGroupCertificateNum()==null){
            map.put("code","01");
            map.put("msg","优惠商品数不能为空");
            return false;
        }else if((ebCertificate.getPromotionType()==1&&ebCertificate.getType()==1)&&(ebCertificate.getAmount()<=0||ebCertificate.getAmount()> ebCertificate.getProvinceOutFullFreight())){
            map.put("code","01");
            map.put("msg","优惠金额需要是数值，并且需要大于等于0且小于满减金额");
            return false;
        }else if (StringUtil.isBlank(certificateStartDate)) {
            map.put("code", "01");
            map.put("msg", "开始日期不能为空");
        }else if (StringUtil.isBlank(certificateEndDate)) {
            map.put("code", "01");
            map.put("msg", "结束日期不能为空");
        }

        return true;
    }
}
