package com.jq.support.main.controller.shop;

import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.region.PmSysDistrict;
import com.jq.support.model.shop.PmShopDepotAddress;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.mecontent.PmSysDistrictService;
import com.jq.support.service.merchandise.shop.PmShopDepotAddressService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.sys.SysDictService;

@Controller
@RequestMapping(value = "${adShopPath}/shopInfo")
public class PmShopInfoShopController extends BaseController {

    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmShopDepotAddressService pmShopDepotAddressService;
    @Autowired
    private PmSysDistrictService pmSysDistrictService;
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    private EbUserService ebUserService;

    @RequestMapping(value = "addressList")
    public String addressList(HttpServletRequest request,
                              HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopDepotAddress pmShopDepotAddress = new PmShopDepotAddress();
        pmShopDepotAddress.setShopId(ebUser.getShopId());
        List<PmShopDepotAddress> pmShopDepotAddressList = pmShopDepotAddressService.getList(pmShopDepotAddress);
        if (pmShopDepotAddressList != null && pmShopDepotAddressList.size() > 10) {
            model.addAttribute("mess", "不能超过10条");
        }
        String saleId = request.getParameter("saleId");
        String view = request.getParameter("view");
        if (StringUtils.isNotBlank(saleId)) {
            model.addAttribute("view", view);
            model.addAttribute("saleId", saleId);
        }
        model.addAttribute("pmShopDepotAddressList", pmShopDepotAddressList);
        return "modules/shop/site-manage";
    }

    @RequestMapping(value = "form")
    public String form(HttpServletRequest request,
                       HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String saleId = request.getParameter("saleId");
        String view = request.getParameter("view");
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopDepotAddress pmShopDepotAddress = new PmShopDepotAddress();
        pmShopDepotAddress.setShopId(ebUser.getShopId());
        List<PmShopDepotAddress> pmShopDepotAddressList = pmShopDepotAddressService.getList(pmShopDepotAddress);
        model.addAttribute("pmShopDepotAddressList", pmShopDepotAddressList);
        PmShopDepotAddress pmShopDepotAddress1 = new PmShopDepotAddress();
        if (StringUtils.isNotBlank(id)) {
            pmShopDepotAddress1 = pmShopDepotAddressService.getPmShopDepotAddress(id);
        }
        if (StringUtils.isNotBlank(saleId) && view.equals("1")) {
            model.addAttribute("view", view);
            model.addAttribute("saleId", saleId);
        }
        model.addAttribute("pmShopDepotAddress", pmShopDepotAddress1);
        return "modules/shop/site-manage";
    }

    @RequestMapping(value = "delete")
    public String delete(HttpServletRequest request,
                         HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String saleId = request.getParameter("saleId");
        String view = request.getParameter("view");
        if (StringUtils.isNotBlank(id)) {
            pmShopDepotAddressService.delete(pmShopDepotAddressService.getPmShopDepotAddress(id));
        }
        if (StringUtils.isNotBlank(saleId) && view.equals("1")) {
            model.addAttribute("view", view);
            model.addAttribute("saleId", saleId);
            return "redirect:/shop/shopInfo/addressList?view=1&saleId=" + saleId;
        } else {
            return "redirect:/shop/shopInfo/addressList";
        }
    }

    @RequestMapping(value = "saveAddress")
    public String saveAddress(HttpServletRequest request,
                              HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String saleId = request.getParameter("saleId");
        String view = request.getParameter("view");
        String se = request.getParameter("se");
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopDepotAddress pmShopDepotAddress1 = new PmShopDepotAddress();
        pmShopDepotAddress1.setShopId(ebUser.getShopId());
        List<PmShopDepotAddress> pmShopDepotAddressList = pmShopDepotAddressService.getList(pmShopDepotAddress1);
        if (pmShopDepotAddressList != null && pmShopDepotAddressList.size() >= 10) {
            return "redirect:/shop/shopInfo/addressList";
        }
        PmShopDepotAddress pmShopDepotAddress = new PmShopDepotAddress();
        if (StringUtils.isNotBlank(se)) {
            pmShopDepotAddress = pmShopDepotAddressService.getPmShopDepotAddress(id);
            pmShopDepotAddressService.isDf(ebUser.getShopId());
            pmShopDepotAddress.setIsDefault(1);
        } else {
            if (StringUtils.isNotBlank(id)) {
                pmShopDepotAddress = pmShopDepotAddressService.getPmShopDepotAddress(id);
            }
            String country = request.getParameter("country");
            String provincesId = request.getParameter("provincesId");
            String municipalId = request.getParameter("municipalId");
            String area = request.getParameter("area");
            String detailAddress = request.getParameter("detailAddress");
            String contactName = request.getParameter("contactName");
            String phoneNumber = request.getParameter("phoneNumber");
            String isDefault = request.getParameter("isDefault");
            String qu = request.getParameter("qu");
            String mo = request.getParameter("mo");
            String fq = request.getParameter("fq");
            pmShopDepotAddress.setShopId(ebUser.getShopId());
            if (StringUtils.isNotBlank(area)) {
                PmSysDistrict pmSysDistrict = new PmSysDistrict();
                pmSysDistrict.setId(Integer.parseInt(area));
                PmSysDistrict sysDistrict = pmSysDistrictService.findId(pmSysDistrict);
                pmShopDepotAddress.setAreaName(sysDistrict.getDistrictName());
                pmShopDepotAddress.setArea(sysDistrict.getId());
            }
            if (StringUtils.isNotBlank(country)) {
                PmSysDistrict pmSysDistrict = new PmSysDistrict();
                pmSysDistrict.setId(Integer.parseInt(country));
                PmSysDistrict sysDistrict = pmSysDistrictService.findId(pmSysDistrict);
                pmShopDepotAddress.setCountryName(sysDistrict.getDistrictName());
                pmShopDepotAddress.setCountry(sysDistrict.getId());
            }
            if (StringUtils.isNotBlank(provincesId)) {
                PmSysDistrict pmSysDistrict = new PmSysDistrict();
                pmSysDistrict.setId(Integer.parseInt(provincesId));
                PmSysDistrict sysDistrict = pmSysDistrictService.findId(pmSysDistrict);
                pmShopDepotAddress.setProvinceName(sysDistrict.getDistrictName());
                pmShopDepotAddress.setProvince(sysDistrict.getId());
            }
            if (StringUtils.isNotBlank(municipalId)) {
                PmSysDistrict pmSysDistrict = new PmSysDistrict();
                pmSysDistrict.setId(Integer.parseInt(municipalId));
                PmSysDistrict sysDistrict = pmSysDistrictService.findId(pmSysDistrict);
                pmShopDepotAddress.setCityName(sysDistrict.getDistrictName());
                pmShopDepotAddress.setCity(sysDistrict.getId());
            }
            if (StringUtils.isNotBlank(detailAddress)) {
                pmShopDepotAddress.setDetailAddress(detailAddress);
            }
            if (StringUtils.isNotBlank(contactName)) {
                pmShopDepotAddress.setContactName(contactName);
            }
            if (StringUtils.isNotBlank(phoneNumber)) {
                pmShopDepotAddress.setPhoneNumber(phoneNumber);
            }
            pmShopDepotAddress.setTelephoneNumber(qu + "_" + mo + "_" + fq);
            if (StringUtils.isNotBlank(isDefault)) {
                pmShopDepotAddressService.isDf(ebUser.getShopId());
                pmShopDepotAddress.setIsDefault(Integer.parseInt(isDefault));
            } else {
                pmShopDepotAddress.setIsDefault(0);
            }
        }
        pmShopDepotAddressService.save(pmShopDepotAddress);
        if (StringUtils.isNotBlank(saleId) && view.equals("1") && !saleId.equals("'undefined'")) {
            return "redirect:/shop/ReturnManagement/refundAgree?saleId=" + saleId;
        } else {
            return "redirect:/shop/shopInfo/addressList";
        }
    }

    @RequestMapping(value = "companyMsgForm")
    public String companyMsgForm(PmShopInfo shopInfo, HttpServletRequest request,
                                 HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        } else {
            model.addAttribute("ebUser", ebUser);
            shopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId().toString());
            if (shopInfo != null) {
                model.addAttribute("shopInfo", shopInfo);
            }
        }
        return "modules/shop/company-msg";
    }

    @RequestMapping(value = "companyMsgFormEdit")
    public String companyMsgFormEdit(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        } else {
            String legalPerson = request.getParameter("legalPerson");
            String capital = request.getParameter("capital");
            String businessStartTime = request.getParameter("businessStartTime");
            String businessEndTime = request.getParameter("businessEndTime");
            String licenseAppScope = request.getParameter("licenseAppScope");
            String officialUrl = request.getParameter("officialUrl");
            String customerPhone = request.getParameter("customerPhone");
            String fax = request.getParameter("fax");
            String contactName = request.getParameter("contactName");
            String email = request.getParameter("email");
            PmShopInfo shopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId().toString());
            if (shopInfo != null) {
                shopInfo.setLegalPerson(legalPerson);
                shopInfo.setCapital(new BigDecimal(capital));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                if (StringUtils.isNotEmpty(businessStartTime)) {
                    shopInfo.setBusinessStartTime(sdf.parse(businessStartTime));
                }
                if (StringUtils.isNotEmpty(businessEndTime)) {
                    shopInfo.setBusinessEndTime(sdf.parse(businessEndTime));
                }
                shopInfo.setLicenseAppScope(licenseAppScope);
                shopInfo.setCustomerPhone(customerPhone);
                shopInfo.setFax(fax);
                shopInfo.setOfficialUrl(officialUrl);
                shopInfo.setMobilePhone(ebUser.getMobile());
                shopInfo.setContactName(contactName);
                shopInfo.setEmail(email);
                shopInfo.setModifyUser(ebUser.getUserId().toString());
                shopInfo.setModifyTime(new Date());
                pmShopInfoService.save(shopInfo);

                model.addAttribute("message", "保存成功");
                model.addAttribute("shopInfo", shopInfo);
                return "modules/shop/company-msg";
            }
        }
        return null;
    }

    //修改用户密码
    @RequestMapping(value = "modifyPasswd")
    @ResponseBody
    public String modifyPasswd(HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        } else {
            String passwd = request.getParameter("passwd");
            String pass = Md5Encrypt.getMD5Str(passwd).toLowerCase();
            ebUser.setPassword(pass);
            ebUserService.update(ebUser);

            model.addAttribute("message", "修改成功");
            model.addAttribute("ebUser", ebUser);
            return null;
//            return "modules/shop/storeSetForm";
        }
    }


    @RequestMapping(value = "storeSetForm")
    public String storeSetForm(PmShopInfo shopInfo, HttpServletRequest request,
                               HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        } else {
            shopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId().toString());
            if (shopInfo != null) {
                model.addAttribute("shopInfo", shopInfo);
            }
        }
        SysDict minParmeter = new SysDict();
        minParmeter.setType("gyconfig");
        minParmeter.setLabel("minRatio");
        SysDict minRatioOnLine = sysDictService.getDict(minParmeter);

        SysDict maxParmeter = new SysDict();
        maxParmeter.setType("gyconfig");
        maxParmeter.setLabel("maxRatio");
        SysDict maxRatioOnLine = sysDictService.getDict(maxParmeter);

        model.addAttribute("minRatioOnLine", minRatioOnLine.getValue());
        model.addAttribute("maxRatioOnLine", maxRatioOnLine.getValue());
        createPicFold(request);
        return "modules/shop/store-set";
    }
//保存修改
    @RequestMapping(value = "storeSetFormEdit")
    public String storeSetFormEdit(HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if (ebUser == null) {
            model.addAttribute("messager", "登陆失效,请重新登陆");
            return "modules/shop/login2";
        } else {
            String shopName = request.getParameter("shopName");
            String isLineShop = request.getParameter("isLineShop");
            String returnRatio = request.getParameter("returnRatio");
            String shopBanner = request.getParameter("shopBanner");
            String shopwapBanner = request.getParameter("shopwapBanner");
            String certificatePic = request.getParameter("certificatePic");//优惠券图片
            String takeout = request.getParameter("takeout");
            String startingPrice = request.getParameter("startingPrice");
            String shopLogo = request.getParameter("shopLogo");
            String shopBannerBg = request.getParameter("shopBannerBg");
            String remarkDesc = request.getParameter("remarkDesc");
            String describeInfo = request.getParameter("describeInfo");
            String longitude = request.getParameter("longitude");
            String latitude = request.getParameter("latitude");
            String contactAddress = request.getParameter("contactAddress");
            String districtName = request.getParameter("districtName");
            String shopRange = request.getParameter("shopRange");
            String isCertificate = request.getParameter("isCertificate");
            String isRoundApplet = request.getParameter("isRoundApplet");
            String accuracyApplet = request.getParameter("accuracyApplet");
            String isRoundCash = request.getParameter("isRoundCash");
            String accuracyCash = request.getParameter("accuracyCash");
            String startNumber = request.getParameter("startNumber");//起始取餐号
            String isTakeMeals = request.getParameter("isTakeMeals");//门店取餐提醒
            String isMiniOrder = request.getParameter("isMiniOrder");//小程序点餐开关

            PmShopInfo shopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId().toString());
            if (shopInfo != null) {
                if (StringUtils.isNotBlank(shopName)) {
                    PmShopInfo paramter = new PmShopInfo();
                    paramter.setShopName(shopName);
                    paramter.setId(Integer.valueOf(shopInfo.getId()));
                    Integer count = 0;
                    String countString = pmShopInfoService.getCount(paramter);
                    if (StringUtils.isNotBlank(countString)) {
                        count = Integer.valueOf(countString);
                    }
                    if (count != 0) {
                        model.addAttribute("message", "店名重复");
                    } else {
                        shopInfo.setShopName(shopName);
                    }
                }

                if (StringUtils.isNotEmpty(isLineShop)) {
                    if (isLineShop.equals("on")) {
                        shopInfo.setIsLineShop(1);
                    } else {
                        shopInfo.setIsLineShop(0);
                    }
                } else {
                    shopInfo.setIsLineShop(0);
                }

                if (StringUtils.isNotBlank(districtName)) {
                    String area[] = districtName.split(",");
                    if (area.length == 5) {
                        shopInfo.setDistrictName(area[0] + "," + area[1] + "," + area[2] + "," + area[3]);
                        shopInfo.setShopLlAddress(districtName.substring(districtName.lastIndexOf(",") + 1, districtName.length()));
                    } else if (area.length == 4) {
                        shopInfo.setDistrictName(area[0] + "," + area[1] + "," + area[2] + "," + area[3]);
                        shopInfo.setShopLlAddress("");
                    }
                }
                if (StringUtils.isNotBlank(contactAddress)) {
                    shopInfo.setContactAddress(contactAddress);
                }
                if (StringUtils.isNotBlank(returnRatio)) {
                    shopInfo.setReturnRatio(Double.parseDouble(returnRatio));
                    shopInfo.setReturnRatioOnline(Double.parseDouble(returnRatio));
                }
                if (StringUtils.isNotBlank(shopBanner)) {
                    shopInfo.setShopBanner(shopBanner);
                }
                if (StringUtils.isNotBlank(startNumber)) {
                    shopInfo.setStartNumber(Integer.parseInt(startNumber));
                }
                if (StringUtils.isNotBlank(isTakeMeals)) {
                    shopInfo.setIsTakeMeals(Integer.parseInt(isTakeMeals));
                }
                if (StringUtils.isNotBlank(isMiniOrder)) {
                    shopInfo.setIsMiniOrder(Integer.parseInt(isMiniOrder));
                }
                shopInfo.setCertificatePic(certificatePic);
                shopInfo.setShopwapBanner(shopwapBanner);
                shopInfo.setShopLogo(shopLogo);

                if (StringUtils.isNotBlank(longitude)) {
                    shopInfo.setShopLongitude(longitude);
                }
                if (StringUtils.isNotBlank(latitude)) {
                    shopInfo.setShopLatitude(latitude);
                }
                if (StringUtils.isNotBlank(shopBannerBg)) {
                    shopInfo.setShopBannerBg(shopBannerBg);
                }
                shopInfo.setRemarkDesc(remarkDesc);
                if (StringUtils.isNotBlank(describeInfo)) {
                    shopInfo.setDescribeInfo(describeInfo);
                }
                if (StringUtils.isNotBlank(startingPrice)) {
                    shopInfo.setStartingPrice(Double.valueOf(startingPrice));
                }
                if (StringUtils.isNotBlank(shopRange)) {
                    shopInfo.setShopRange(Integer.valueOf(shopRange));
                }

                //小程序是否支持四舍五入 0 不支持  1支持
                if (StringUtils.isNotBlank(isRoundApplet)) {
                    shopInfo.setIsRoundApplet(Integer.parseInt(isRoundApplet));
                    if (StringUtils.isNotBlank(accuracyApplet) && Integer.valueOf(isRoundApplet)==1) {
                        shopInfo.setAccuracyApplet(Integer.valueOf(accuracyApplet));
                    }
                }

                //收银端是否支持四舍五入 0 不支持  1支持
                if (StringUtils.isNotBlank(isRoundCash)) {
                    shopInfo.setIsRoundCash(Integer.parseInt(isRoundCash));
                    if(StringUtil.isNotBlank(accuracyCash) && Integer.valueOf(isRoundCash)==1){
                        shopInfo.setAccuracyCash(Integer.valueOf(accuracyCash));
                    }
                }

                shopInfo.setTakeout(Integer.valueOf(takeout));
                shopInfo.setIsCertificate(Integer.valueOf(isCertificate));
                shopInfo.setModifyUser(ebUser.getUserId().toString());
                shopInfo.setModifyTime(new Date());
                pmShopInfoService.save(shopInfo);
                model.addAttribute("shopInfo", shopInfo);
                model.addAttribute("message", "修改成功");
                return "redirect:/shop/shopInfo/storeSetForm";
            } else {
                model.addAttribute("shopInfo", shopInfo);
                model.addAttribute("message", "修改失败");
            }
            return "redirect:/shop/shopInfo/storeSetForm";
        }
    }

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
        String userShopId = "";
        // ===========集群文件字段处理 end===============
        if (request.getSession().getAttribute("userShopId") != null) {
            userShopId = (String) request.getSession().getAttribute("userShopId");
        }
        folder.append(userShopId);
        folder.append(File.separator);
        folder.append("images");
        folder.append(File.separator);
        folder.append(File.separator);
        folder.append("shopImg");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }
}