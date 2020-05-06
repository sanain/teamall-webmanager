package com.jq.support.main.controller.merchandise.shop;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alipay.api.domain.ShopInfo;
import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.dao.merchandise.shop.PmShopDeviceDao;
import com.jq.support.dao.merchandise.user.EbUserDao;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.EbOrderitem;
import com.jq.support.model.product.*;
import com.jq.support.model.shop.PmShopDevice;
import com.jq.support.model.shop.PmShopSettlement;
import com.jq.support.model.shop.PmShopUser;
import com.jq.support.model.user.LogUserlogin;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.loginLog.LogUserLoginService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.EbOrderitemService;
import com.jq.support.service.merchandise.product.*;
import com.jq.support.service.merchandise.shop.*;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.utils.StringUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.shop.PmShopDepotAddress;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.mecontent.EbAdvertiseService;
import com.jq.support.service.merchandise.mecontent.EbLayouttypeService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;

@Controller
@RequestMapping(value = "${adminPath}/PmShopInfo")
public class PmShopInfoController extends BaseController {
    @Autowired
    PmShopInfoService pmShopInfoService;
    @Autowired
    PmShopDepotAddressService pmShopDepotAddressService;
    @Autowired
    EbUserService ebUserService;
    @Autowired
    private EbAdvertiseService ebAdvertiseService;
    @Autowired
    private EbLayouttypeService ebLayouttypeService;
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    private EbProductcommentService ebProductcommentService;
    @Autowired
    private PmProductTypeService productTypeService;
    @Autowired
    private PmShopCooperTypeService pmShopCooperTypeService;
    @Autowired
    private EbMessageService ebMessageService;
    @Autowired
    private EbMessageUserService messageInfoUserService;
    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private PmShopUserService pmShopUserService;
    @Autowired
    private PmShopDeviceService pmShopDeviceService;
    @Autowired
    private EbProductFreightModelService ebProductFreightModelService;
    @Autowired
    private PmShopSettlementService pmShopSettlementService;
    @Autowired
    private PmAmtLogService pmAmtLogService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private EbOrderService ebOrderService;
    @Autowired
    private EbOrderitemService ebOrderitemService;

    private static String shopLoginFlag = Global.getConfig("shopLoginFlag");
    private static String shopShoppingFlag = Global.getConfig("shopShoppingFlag");
    private static String domainurl = Global.getConfig("domainurl");
    private static String innerImgPartPath = "src=\"/uploads/images/";
    private static String innerImgFullPath = "src=\"" + domainurl
            + "/uploads/images/";
    @Autowired
    private EbShopChargingService ebShopChargingService;
    @ModelAttribute
    public PmShopInfo get(@RequestParam(required = false) String id) {
        if (org.apache.commons.lang3.StringUtils.isNotBlank(id)) {
            return pmShopInfoService.getpmPmShopInfo(id);
        } else {
            return new PmShopInfo();
        }
    }

    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(PmShopInfo pmShopInfo, String stule,
                       HttpServletRequest request, HttpServletResponse response,
                       Model model, String openingTime, String closingTime) {
        if (StringUtils.isNotBlank(stule)) {
            if (stule.equals("99")) {
                pmShopInfo.setReviewStatus(1);
            }
        }
        pmShopInfo.setShopTypeIdentity(0);
        Page<PmShopInfo> page = pmShopInfoService.getPageList(
                new Page<PmShopInfo>(request, response), pmShopInfo, openingTime, closingTime);
        model.addAttribute("page", page);
        model.addAttribute("stule", stule);
        model.addAttribute("openingTime", openingTime);
        model.addAttribute("closingTime", closingTime);
        model.addAttribute("pmShopInfo", pmShopInfo);
        return "modules/shopping/shop/pmShopInfolist";
    }

    /**
     * 查询门店
     *
     * @param pmShopUser
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = "employees")
    public String employees(PmShopUser pmShopUser,
                            HttpServletRequest request, HttpServletResponse response,
                            Model model, Integer id) {

        pmShopUser.setShopId(id);

        Page<PmShopUser> page = pmShopUserService.getEmployees(
                new Page<PmShopUser>(request, response), pmShopUser);

        model.addAttribute("page", page);
        model.addAttribute("pmShopUser", pmShopUser);
        return "modules/shopping/shop/employees-msg";
    }

    /**
     * 查询门店设备列表
     *
     * @param pmShopDevice
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = "device")
    public String getDeviceInfo(PmShopDevice pmShopDevice,
                                HttpServletRequest request, HttpServletResponse response,
                                Model model, PmShopInfo pmShopInfo) {

        //当id获取不到的时候调回门店首页，重新加载数据
//	    if(pmShopInfo.getId() == null){
//            return "redirect:" + Global.getAdminPath()
//                    + "/PmShopInfo";
//        }

        pmShopDevice.setShopId(pmShopInfo.getId());

        Page<PmShopDevice> page = pmShopDeviceService.getDeviceInfo(
                new Page<PmShopDevice>(request, response), pmShopDevice);

        model.addAttribute("page", page);
        model.addAttribute("pmShopDevice", pmShopDevice);
        return "modules/shopping/shop/device-msg";
    }

    /**
     * 跳转到设备编辑页面
     *
     * @param prompt 提示
     * @param flag   表示  add  绑定  ""修改
     * @param device 设备对象
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping("/deviceForm")
    public String deviceForm(String prompt, String flag, PmShopInfo pmShopInfo, Integer deviceId, PmShopDevice device, Model model) {
        model.addAttribute("prompt", prompt);
        model.addAttribute("pmShopInfo", pmShopInfo);

        //判断是跳到增加页面
        if ("add".equals(flag)) {
            model.addAttribute("flag", flag);
            return "modules/shopping/shop/deviceForm";
        }

        if (deviceId != null) {
            device = pmShopDeviceService.getDeviceById(deviceId);
            model.addAttribute("device", device);
        }
        model.addAttribute("device", device);
        return "modules/shopping/shop/deviceForm";
    }

    /**
     * 绑定设备
     *
     * @param pmShopDevice
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping("/addDevice")
    public String addDevice(PmShopDevice pmShopDevice, Model model, PmShopInfo pmShopInfo) {
        String[] promptArr = {"绑定设备成功！", "绑定设备失败！", "设备编码冲突！", "设备名称冲突！"};

        /**
         * 避免把pmShopInfo的Id封装到id中
         */
        pmShopDevice.setId(null);

        pmShopDevice.setShopId(pmShopInfo.getId());
        Integer index = pmShopDeviceService.addShopDevice(pmShopDevice);
        String prompt = promptArr[index];

        model.addAttribute("prompt", prompt);
        model.addAttribute("pmShopInfo", pmShopInfo);
        model.addAttribute("flag", "add");

        return "modules/shopping/shop/deviceForm";

    }

    /**
     * 更新设备信息
     *
     * @param pmShopDevice
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping("updateDevice")
    public String updateDevice(PmShopDevice pmShopDevice, Integer deviceId, PmShopInfo pmShopInfo, Model model) {
        String[] promptArr = {"更新设备信息成功！", "更新设备信息失败！", "设备编码冲突！", "设备名称冲突！"};

        pmShopDevice.setShopId(pmShopInfo.getId());
        pmShopDevice.setId(deviceId);

        Integer index = pmShopDeviceService.updateDevice(pmShopDevice);
        String prompt = promptArr[index];

        model.addAttribute("prompt", prompt);
        model.addAttribute("pmShopInfo", pmShopInfo);
        model.addAttribute("device", pmShopDevice);
        return "modules/shopping/shop/deviceForm";
    }

    /**
     * 解绑设备
     *
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping("deleteDevice")
    public String deviceForm(Integer deviceId, Model model) {
        String[] promptArr = {"解除绑定失败！", "解除绑定成功！"};

        Integer index = pmShopDeviceService.deleteDevice(deviceId);
        String prompt = promptArr[index];

        model.addAttribute("prompt", prompt);
        return "forward:" + Global.getAdminPath()
                + "/PmShopInfo/device";
    }

    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = {"smallBList"})
    public String smallBList(PmShopInfo pmShopInfo, String stule,
                             HttpServletRequest request, HttpServletResponse response,
                             Model model) {
        if (StringUtils.isNotBlank(stule)) {
            if (stule.equals("99")) {
                pmShopInfo.setReviewStatus(1);
            }
        }
        pmShopInfo.setShopTypeIdentity(2);
        Page<PmShopInfo> page = pmShopInfoService.getPageList(
                new Page<PmShopInfo>(request, response), pmShopInfo);

        model.addAttribute("page", page);
        model.addAttribute("stule", stule);
        model.addAttribute("pmShopInfo", pmShopInfo);
        return "modules/shopping/smallb/smallblist";
    }

    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = {"shopDepotAddress"})
    public String shopDepotAddress(HttpServletRequest request,
                                   HttpServletResponse response, Model model) {
        String shopid = request.getParameter("shopid");
        String isDefault = request.getParameter("isDefault");
        String contactName = request.getParameter("contactName");
        String phoneNumber = request.getParameter("phoneNumber");
        // String verifyStatus=request.getParameter("verifyStatus");
        PmShopDepotAddress parameter = new PmShopDepotAddress();
        if (StringUtils.isNotBlank(shopid)) {
            parameter.setShopId(Integer.valueOf(shopid));
        }
        if (StringUtils.isNotBlank(isDefault)) {
            parameter.setIsDefault(Integer.valueOf(isDefault));
        }
        if (StringUtils.isNotBlank(contactName)) {
            parameter.setContactName(contactName);
        }
        if (StringUtils.isNotBlank(phoneNumber)) {
            parameter.setPhoneNumber(phoneNumber);
        }
        // if(StringUtils.isNotBlank(verifyStatus)){
        // parameter.setVerifyStatus(Integer.valueOf(verifyStatus));
        // }
        Page<PmShopDepotAddress> page = pmShopDepotAddressService.getPageList(
                new Page<PmShopDepotAddress>(request, response), parameter);
        model.addAttribute("page", page);
        if (StringUtils.isNotBlank(shopid)) {
            model.addAttribute("shopid", shopid);
        }
        model.addAttribute("isDefault", isDefault);
        model.addAttribute("contactName", contactName);
        model.addAttribute("phoneNumber", phoneNumber);
        // model.addAttribute("verifyStatus", verifyStatus);
        return "modules/shopping/shop/shopDepotAddress";
    }

    @RequiresPermissions("merchandise:PmShopInfo:editedit")
    @RequestMapping(value = "verifyStatus")
    public String verifyStatus(HttpServletRequest request,
                               HttpServletResponse response, Model model,
                               RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String shopid = request.getParameter("shopid");
        String verifyStatus = request.getParameter("verifyStatus");
        pmShopDepotAddressService.verifyStatus(Integer.valueOf(verifyStatus),
                Integer.valueOf(shopid), Integer.valueOf(id));
        addMessage(redirectAttributes, "审核通过");
        return "redirect:" + Global.getAdminPath()
                + "/PmShopInfo/shopDepotAddress?shopid=" + shopid + "";
    }

    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = "shopDepotAddressfrom")
    public String shopDepotAddressfrom(HttpServletRequest request,
                                       HttpServletResponse response, Model model,
                                       RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String shopid = request.getParameter("shopid");
        PmShopDepotAddress shopDepotAddress = pmShopDepotAddressService
                .getPmShopDepotAddress(id);
        if (shopDepotAddress != null) {
            model.addAttribute("shopDepotAddress", shopDepotAddress);
        }
        model.addAttribute("id", id);
        model.addAttribute("shopid", shopid);
        return "modules/shopping/shop/shopDepotAddressfrom";
    }

    @RequiresPermissions("merchandise:pmShopInfo:edit")
    @RequestMapping(value = "shopDepotAddressSave")
    public String shopDepotAddressSave(HttpServletRequest request,
                                       HttpServletResponse response, Model model,
                                       RedirectAttributes redirectAttributes) {
        String shopid = request.getParameter("shopid");
        String id = request.getParameter("id");
        String verifyStatus = request.getParameter("verifyStatus");
        String verifyRemar = request.getParameter("verifyRemar");
        PmShopDepotAddress pmShopDepotAddress = pmShopDepotAddressService
                .getPmShopDepotAddress(id);
        if (pmShopDepotAddress != null) {
            if (StringUtils.isNotBlank(verifyRemar)) {
                pmShopDepotAddress.setVerifyRemar(verifyRemar);
            }
            pmShopDepotAddress.setVerifyStatus(Integer.valueOf(verifyStatus));
            SysUser user = SysUserUtils.getUser();
            pmShopDepotAddress.setVerifyUser(user.getName());
            pmShopDepotAddress.setModifyUser(user.getName());
            Date nowTime = new Date();
            pmShopDepotAddress.setVerifyTime(nowTime);
            pmShopDepotAddress.setModifyTime(nowTime);
            pmShopDepotAddressService.save(pmShopDepotAddress);
        }
        addMessage(redirectAttributes, "提交成功");
        return "redirect:" + Global.getAdminPath()
                + "/PmShopInfo/shopDepotAddress?shopid=" + shopid + "";
    }

    @RequiresPermissions("merchandise:EbAdvertise:view")
    @RequestMapping(value = "form")
    public String form(PmShopInfo pmShopInfo, HttpServletRequest request,
                       HttpServletResponse response, Model model) {
        EbUser user = ebUserService.getShop(pmShopInfo.getId().toString());
        if (user != null) {
            model.addAttribute("mobile", user.getMobile());
            model.addAttribute("pmShopInfo", pmShopInfo);
        }
        return "modules/shopping/shop/company-msg";
    }

    @RequiresPermissions("merchandise:pmShopInfo:edit")
    @RequestMapping(value = "save")
    public String save(HttpServletRequest request,
                       HttpServletResponse response, Model model,
                       RedirectAttributes redirectAttributes) throws ParseException {
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
        String msgPhone = request.getParameter("msgPhone");
        String id = request.getParameter("id");
        String isLineShop = request.getParameter("isLineShop");
        SysUser user = SysUserUtils.getUser();
        if (StringUtils.isNotEmpty(id)) {
            PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(id);
            if (pmShopInfo != null) {
                pmShopInfo.setLegalPerson(legalPerson);
                pmShopInfo.setCapital(BigDecimal.valueOf(Double
                        .parseDouble(capital)));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                if (StringUtils.isNotEmpty(businessStartTime)) {
                    pmShopInfo.setBusinessStartTime(sdf
                            .parse(businessStartTime));
                }
                if (StringUtils.isNotEmpty(businessEndTime)) {
                    pmShopInfo.setBusinessEndTime(sdf.parse(businessEndTime));
                }
                pmShopInfo.setLicenseAppScope(licenseAppScope);
                if (StringUtils.isNotEmpty(customerPhone)) {
                    pmShopInfo.setCustomerPhone(customerPhone);
                }
                if (StringUtils.isNotBlank(isLineShop)) {
                    pmShopInfo.setIsLineShop(Integer.parseInt(isLineShop));
                }
                if (StringUtils.isNotEmpty(fax)) {
                    pmShopInfo.setFax(fax);
                }
                if (StringUtils.isNotEmpty(officialUrl)) {
                    pmShopInfo.setOfficialUrl(officialUrl);
                }
                pmShopInfo.setContactName(contactName);
                pmShopInfo.setEmail(email);
                pmShopInfo.setMsgPhone(msgPhone);
                pmShopInfo.setModifyUser(user.getLoginName());
                pmShopInfo.setModifyTime(new Date());

                pmShopInfoService.save(pmShopInfo);
                EbUser ebuser = ebUserService.getShop(pmShopInfo.getId()
                        .toString());
                if (user != null) {
                    model.addAttribute("mobile", ebuser.getMobile());
                }
                model.addAttribute("message", "保存成功");
                return "modules/shopping/shop/company-msg";
            }
        }
        return "redirect:" + Global.getAdminPath() + "/PmShopInfo/list";
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequiresPermissions("merchandise:EbAdvertise:view")
    @RequestMapping(value = "shopinfo")
    public String shopinfo(PmShopInfo pmShopInfo, HttpServletRequest request,
                           HttpServletResponse response, Model model, String flag, String prompt) {


        String message = request.getParameter("messager");
        createPicFold(request);

        List<PmProductType> productTypes = productTypeService
                .getSbProductTypeHQLListLevel("1");
        model.addAttribute("productTypes", productTypes);

        //如果是前往增加页面，直接跳转
        if ("add".equals(flag)) {
            PmShopInfo newPmShopInfo = new PmShopInfo();
            newPmShopInfo.setId(pmShopInfo.getId());
            model.addAttribute("pmShopInfo", newPmShopInfo);
            model.addAttribute("flag", flag);
            model.addAttribute("prompt", prompt);
            return "modules/shopping/shop/store-msg";
        }

        EbUser user = ebUserService.getShop(pmShopInfo.getId().toString());

        SysDict minParmeter = new SysDict();
        minParmeter.setType("gyconfig");
        minParmeter.setLabel("minRatioOnLine");
        SysDict minRatioOnLine = sysDictService.getDict(minParmeter);

        SysDict maxParmeter = new SysDict();
        maxParmeter.setType("gyconfig");
        maxParmeter.setLabel("maxRatioOnLine");
        SysDict maxRatioOnLine = sysDictService.getDict(maxParmeter);


        PmShopCooperType parmetershopid = new PmShopCooperType();
        parmetershopid.setShopId(pmShopInfo.getId());
        List<PmShopCooperType> pmShopCooperTypes = pmShopCooperTypeService
                .getShopList(parmetershopid);
        String cooperTypesid = "";
        if (CollectionUtils.isNotEmpty(pmShopCooperTypes)) {
            for (int i = 0; i < pmShopCooperTypes.size(); i++) {
                cooperTypesid += pmShopCooperTypes.get(i).getProductTypeId()
                        + ",";
            }
            cooperTypesid = cooperTypesid.substring(0,
                    cooperTypesid.length() - 1);
        }
        EbProductcomment ebProductcomment = new EbProductcomment();
        ebProductcomment.setShopId(pmShopInfo.getId());
        List commentAVGs = ebProductcommentService.getCount(ebProductcomment);
        if (commentAVGs.size() > 0 && commentAVGs != null) {
            Object[] objects = (Object[]) commentAVGs.get(0);
            Object object1 = 0;
            Object object2 = 0;
            Object object3 = 0;
            if (objects[1] != null) {
                object1 = objects[1];
            }
            if (objects[2] != null) {
                object2 = objects[2];
            }
            if (objects[3] != null) {
                object3 = objects[3];
            }
            model.addAttribute("servicefraction", object1);
            model.addAttribute("logisticsfraction", object2);
            model.addAttribute("colorfraction", object3);
        }
        if (StringUtils.isNotBlank(cooperTypesid)) {
            model.addAttribute("cooperTypesid", cooperTypesid);
        }

        model.addAttribute("minRatioOnLine", minRatioOnLine.getValue());
        model.addAttribute("maxRatioOnLine", maxRatioOnLine.getValue());
        model.addAttribute("pmShopInfo", pmShopInfo);

        if (StringUtils.isNotBlank(user.getMobile())) {
            model.addAttribute("mobile", user.getMobile().replaceAll(shopLoginFlag, ""));
        }
        if (StringUtils.isNotBlank(message)) {
            if (message.equals("0")) {
                model.addAttribute("message", "保存成功");
            } else if (message.equals("1")) {
                model.addAttribute("message", "店名重复");
            }
        }
        return "modules/shopping/shop/store-msg";
    }


    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = "smallBShopinfo")
    public String smallBShopinfo(PmShopInfo pmShopInfo,
                                 HttpServletRequest request, HttpServletResponse response,
                                 Model model) {
        String message = request.getParameter("messager");
        createPicFold(request);

        SysDict minParmeter = new SysDict();
        minParmeter.setType("gyconfig");
        minParmeter.setLabel("minRatioOnLine");
        SysDict minRatioOnLine = sysDictService.getDict(minParmeter);

        SysDict maxParmeter = new SysDict();
        maxParmeter.setType("gyconfig");
        maxParmeter.setLabel("maxRatioOnLine");
        SysDict maxRatioOnLine = sysDictService.getDict(maxParmeter);

        List<PmProductType> productTypes = productTypeService
                .getSbProductTypeHQLListLevel("1");
        PmShopCooperType parmetershopid = new PmShopCooperType();
        parmetershopid.setShopId(pmShopInfo.getId());
        List<PmShopCooperType> pmShopCooperTypes = pmShopCooperTypeService
                .getShopList(parmetershopid);
        String cooperTypesid = "";
        if (CollectionUtils.isNotEmpty(pmShopCooperTypes)) {
            for (int i = 0; i < pmShopCooperTypes.size(); i++) {
                cooperTypesid += pmShopCooperTypes.get(i).getProductTypeId()
                        + ",";
            }
            cooperTypesid = cooperTypesid.substring(0,
                    cooperTypesid.length() - 1);
        }
        EbProductcomment ebProductcomment = new EbProductcomment();
        ebProductcomment.setShopId(pmShopInfo.getId());
        List commentAVGs = ebProductcommentService.getCount(ebProductcomment);
        if (commentAVGs.size() > 0 && commentAVGs != null) {
            Object[] objects = (Object[]) commentAVGs.get(0);
            Object object1 = 0;
            Object object2 = 0;
            Object object3 = 0;
            if (objects[1] != null) {
                object1 = objects[1];
            }
            if (objects[2] != null) {
                object2 = objects[2];
            }
            if (objects[3] != null) {
                object3 = objects[3];
            }
            model.addAttribute("servicefraction", object1);
            model.addAttribute("logisticsfraction", object2);
            model.addAttribute("colorfraction", object3);
        }
        model.addAttribute("cooperTypesid", cooperTypesid);
        model.addAttribute("productTypes", productTypes);
        model.addAttribute("minRatioOnLine", minRatioOnLine.getValue());
        model.addAttribute("maxRatioOnLine", maxRatioOnLine.getValue());
        model.addAttribute("pmShopInfo", pmShopInfo);
        if (StringUtils.isNotBlank(message)) {
            if (message.equals("0")) {
                model.addAttribute("message", "保存成功");
            } else if (message.equals("1")) {
                model.addAttribute("message", "店名重复");
            }
        }
        return "modules/shopping/smallb/smallb_msg";
    }

    // 跳到百度地图选经纬度
    @RequestMapping(value = "mapBaidu")
    public String mapBaidu(PmShopInfo pmShopInfo, HttpServletRequest request,
                           HttpServletResponse response, Model model) {
        return "modules/shopping/shop/mapBaidu";
    }

    /**
     * 更新平台抽点
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "updateReturnRatio")
    @ResponseBody
    public Map updateReturnRatio(HttpServletRequest request,
                           HttpServletResponse response,Model model) throws Exception {
        Map map = new HashMap();
        double miniReturnRatio = 0.0;  //来源于小程序订单（门店自取和外卖） %
        double shopReturnRatio = 0.0;  //来源于门店支付订单（门店自取和外卖） %
        double otherReturnRatio = 0.0;  //来源于第三方平台支付订单（门店自取和外卖） %
        String setMiniReturnRatio = request.getParameter("miniReturnRatio");
        String setShopReturnRatio = request.getParameter("shopReturnRatio");
        String setOtherReturnRatio = request.getParameter("otherReturnRatio");
        String shopId = request.getParameter("shopId");
        if (StringUtil.isBlank(shopId)) {
            map.put("code", "01");
            map.put("msg", "门店信息不能为空！");
            return map;
        }
        if (StringUtil.isBlank(setMiniReturnRatio) || StringUtil.isBlank(setShopReturnRatio) || StringUtil.isBlank(setOtherReturnRatio)) {
            map.put("code", "01");
            map.put("msg", "抽点信息不能为空！");
            return map;
        }
        miniReturnRatio = Double.parseDouble(setMiniReturnRatio);
        shopReturnRatio = Double.parseDouble(setShopReturnRatio);
        otherReturnRatio = Double.parseDouble(setOtherReturnRatio);
        if ((miniReturnRatio < 0 || miniReturnRatio > 100) || (shopReturnRatio < 0 || shopReturnRatio > 100) || (otherReturnRatio < 0 || otherReturnRatio > 100)) {
            map.put("code", "01");
            map.put("msg", "抽点值不得小于0或大于100！");
            return map;
        }
        PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(shopId);
        //设置抽点值
        pmShopInfo.setMiniReturnRatio(miniReturnRatio);
        pmShopInfo.setShopReturnRatio(shopReturnRatio);
        pmShopInfo.setOtherReturnRatio(otherReturnRatio);
        pmShopInfoService.save(pmShopInfo);
        map.put("code", "00");
        map.put("msg", "修改成功！");
        return map;
    }
    /**
     * 后台展示用户余额日志
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:user:view")
    @RequestMapping(value = "useramtlog")
    public String useramtlog(HttpServletRequest request,
                             HttpServletResponse response, Model model) {
        String id = request.getParameter("id");
        EbUser ebUser=ebUserService.getShop(id);
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String amt = request.getParameter("amt");
        String amtType = request.getParameter("amtType");
        PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(id);
        PmAmtLog pmAmtLog = new PmAmtLog();
        if (StringUtils.isNotBlank(amt)) {
            Double aDouble = Double.parseDouble(amt);
            if (aDouble == 1) {// 消费余额，1 收入 2消费
                pmAmtLog.setAmt(aDouble);
            }
            if (aDouble == 2) {
                pmAmtLog.setAmt(aDouble);
            }
        }
        pmAmtLog.setUserId(ebUser.getUserId());
        if (StringUtils.isNotBlank(amtType)) {
            pmAmtLog.setAmtType(Integer.valueOf(amtType));
        }

        Page<PmAmtLog> page = pmAmtLogService.findPmAmtLogList("", "",
                startTime, endTime, "", pmAmtLog, new Page<PmAmtLog>(request,
                        response,30));

        model.addAttribute("page", page);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("amt", amt);
        model.addAttribute("amtType", amtType);
        model.addAttribute("pmShopInfo", pmShopInfo);
        return "modules/shopping/shop/member-amtlog";
    }
    /**
     * 后台展示门店结算
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:user:view")
    @RequestMapping(value = "amtlogIndex")
    public String amtlogIndex(HttpServletRequest request,
                             HttpServletResponse response, Model model) {
        String id = request.getParameter("id");
        EbUser ebUser=ebUserService.getShop(id);
        PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(id);
        PmShopSettlement pmShopSettlement=pmShopSettlementService.getPmShopSettlementByshopId(pmShopInfo.getId());

        double  waitingCashWithdrawalAmt=0.0;//正在提现金额
        List<PmAmtLog> amtLogList = pmAmtLogService.getUnfinishedWithdrawal(ebUser);
        if(CollectionUtils.isNotEmpty(amtLogList)){
            for(PmAmtLog log : amtLogList){
                if(log.getAmt() != null){
                    waitingCashWithdrawalAmt+=log.getAmt();
                }
            }
        }

        model.addAttribute("waitingCashWithdrawalAmt", waitingCashWithdrawalAmt);//当前正在提现的金额
        model.addAttribute("currentAmt", ebUser.getCurrentAmt());//当前余额
        model.addAttribute("cashWithdrawalAmt", ebUser.getCashWithdrawalAmt());//已提现金额
        model.addAttribute("shopName", pmShopInfo.getShopName());//门店名称
        model.addAttribute("pmShopSettlement", pmShopSettlement);//总览信息
        model.addAttribute("pmShopInfo", pmShopInfo);
        return "modules/shopping/shop/amtlogIndex";
    }
    /**
     * 添加新门店信息
     * @param pmShopInfo
     * @param mobile
     * @param oldShopId
     * @param model
     * @param openingTime
     * @param closingTime
     * @param longitude
     * @param latitude
     * @param shopPassword
     * @param cooperTypesId
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "addShopInfo")
    @ResponseBody
    public Map addShopInfo(PmShopInfo pmShopInfo, String mobile, Integer oldShopId,
                           Model model, String openingTime, String closingTime,
                           String longitude, String latitude, String shopPassword,
                           String cooperTypesId, HttpServletRequest request,
                           HttpServletResponse response) throws Exception {
        Map map = new HashMap();
        double miniReturnRatio = 0.0;  //来源于小程序订单（门店自取和外卖） %
        double shopReturnRatio = 0.0;  //来源于门店支付订单（门店自取和外卖） %
        double otherReturnRatio = 0.0;  //来源于第三方平台支付订单（门店自取和外卖） %
        String setMiniReturnRatio = request.getParameter("setMiniReturnRatio");
        String setShopReturnRatio = request.getParameter("setShopReturnRatio");
        String setOtherReturnRatio = request.getParameter("setOtherReturnRatio");
        if (StringUtil.isBlank(setMiniReturnRatio) || StringUtil.isBlank(setShopReturnRatio) || StringUtil.isBlank(setOtherReturnRatio)) {
            map.put("code", "01");
            map.put("msg", "抽点信息不能为空！");
            return map;
        }
        miniReturnRatio = Double.parseDouble(setMiniReturnRatio);
        shopReturnRatio = Double.parseDouble(setShopReturnRatio);
        otherReturnRatio = Double.parseDouble(setOtherReturnRatio);
        if ((miniReturnRatio < 0 || miniReturnRatio > 100) || (shopReturnRatio < 0 || shopReturnRatio > 100) || (otherReturnRatio < 0 || otherReturnRatio > 100)) {
            map.put("code", "01");
            map.put("msg", "抽点值不得小于0或大于100！");
            return map;
        }
        //设置抽点值
        pmShopInfo.setMiniReturnRatio(miniReturnRatio);
        pmShopInfo.setShopReturnRatio(shopReturnRatio);
        pmShopInfo.setOtherReturnRatio(otherReturnRatio);
        /**
         * 0 成功  1 用户已经有门店  2  用户不存在 3 失败 5 账号为空
         */

        if (StringUtils.isBlank(pmShopInfo.getMobilePhone())) {
            model.addAttribute("prompt", "5");
            map.put("code", "01");
            map.put("msg", "账号不能为空！");
            return map;
        }

        SysUser user = SysUserUtils.getUser();
        pmShopInfo.setCreateTime(new Date());
        pmShopInfo.setCreateUser(user.getName());
        pmShopInfo.setShopCode(pmShopInfo.getMobilePhone());


        /**初始化数据库不能为空的字段**/
        pmShopInfo.setCapital(pmShopInfo.getCapital() == null ? new BigDecimal("0") : pmShopInfo.getCapital());
        pmShopInfo.setTotalAmt(pmShopInfo.getTotalAmt() == null ? 0 : pmShopInfo.getTotalAmt());
        pmShopInfo.setCurrentAmt(pmShopInfo.getCurrentAmt() == null ? 0 : pmShopInfo.getCurrentAmt());
        pmShopInfo.setFrozenAmt(pmShopInfo.getFrozenAmt() == null ? 0 : pmShopInfo.getFrozenAmt());
        pmShopInfo.setCurrentGold(pmShopInfo.getCurrentGold() == null ? 0 : pmShopInfo.getCurrentGold());
        pmShopInfo.setTotalGold(pmShopInfo.getTotalGold() == null ? 0 : pmShopInfo.getTotalGold());
        pmShopInfo.setFrozenGold(pmShopInfo.getFrozenGold() == null ? 0 : pmShopInfo.getFrozenGold());

        pmShopInfo.setCurrentLove(pmShopInfo.getCurrentLove() == null ? 0 : pmShopInfo.getCurrentLove());
        pmShopInfo.setTotalLove(pmShopInfo.getTotalLove() == null ? 0 : pmShopInfo.getTotalLove());
        pmShopInfo.setLoveAmt(pmShopInfo.getLoveAmt() == null ? 0 : pmShopInfo.getLoveAmt());
        pmShopInfo.setTodayAmt(pmShopInfo.getTodayAmt() == null ? 0 : pmShopInfo.getTodayAmt());
        pmShopInfo.setUsableLove(pmShopInfo.getUsableLove() == null ? 0 : pmShopInfo.getUsableLove());
        pmShopInfo.setIsLineShop(pmShopInfo.getIsLineShop() == null ? 0 : pmShopInfo.getIsLineShop());
        pmShopInfo.setReturnRatio(pmShopInfo.getReturnRatio() == null ? 0 : pmShopInfo.getReturnRatio());
        pmShopInfo.setReturnRatioOnline(pmShopInfo.getReturnRatioOnline() == null ? 0 : pmShopInfo.getReturnRatioOnline());
        pmShopInfo.setIsRecommend(pmShopInfo.getIsRecommend() == null ? 0 : pmShopInfo.getIsRecommend());
        pmShopInfo.setShopTypeIdentity(pmShopInfo.getShopTypeIdentity() == null ? 0 : pmShopInfo.getShopTypeIdentity());
        pmShopInfo.setIsLineShop(1);
        pmShopInfo.setReviewStatus(1);
        pmShopInfo.setReviewReason("后台添加系统自动通过");
        pmShopInfo.setReviewDate(new Date());

        //运费
        pmShopInfo.setCourier(0D);
        //初始化起送费
        pmShopInfo.setStartingPrice(0);


        /**营业时间类型转化**/
        if (StringUtils.isNotBlank(openingTime)) {
            String[] strArr = openingTime.split(":");
            Time time = new Time(0);
            time.setHours(Integer.parseInt(strArr[0]));
            time.setMinutes(Integer.parseInt(strArr[1]));
            pmShopInfo.setOpeningTime(time);
        }

        if (StringUtils.isNotBlank(closingTime)) {
            String[] strArr = closingTime.split(":");
            Time time = new Time(0);
            time.setHours(Integer.parseInt(strArr[0]));
            time.setMinutes(Integer.parseInt(strArr[1]));
            pmShopInfo.setClosingTime(time);
        }

        /**设置经纬度**/
        pmShopInfo.setShopLatitude(latitude);
        pmShopInfo.setShopLongitude(longitude);

//        pmShopInfo.setReviewName(user.getName());
        map = pmShopInfoService.insertShopInfo(pmShopInfo, shopPassword);


        //增加营业类别
        if ("00".equals(map.get("code").toString()) && StringUtil.isNotBlank(cooperTypesId)) {
            //初始化运费模板
//			EbProductFreightModel ebProductFreightModel = new EbProductFreightModel();
//			ebProductFreightModel.setCreateTime(new Date());
//			ebProductFreightModel.setFullFreight(0.0);
//			ebProductFreightModel.setNormalFreight(0.0);
//			ebProductFreightModel.setShopId(pmShopInfo.getId());
//			ebProductFreightModel.setCreateUser(user.getId());
//			ebProductFreightModel.setFreightModelName(pmShopInfo.getShopName()+"运费模板");
//			ebProductFreightModelService.save(ebProductFreightModel);


            String cooperTypesidArr[] = cooperTypesId.split(",");
            for (int i = 0; i < cooperTypesidArr.length; i++) {
                Date nowDate = new Date();
                PmShopCooperType pmShopCooperType = new PmShopCooperType();
                pmShopCooperType.setShopId(pmShopInfo.getId());
                pmShopCooperType.setProductTypeId(Integer
                        .valueOf(cooperTypesidArr[i]));
                pmShopCooperType.setRate(0);
                pmShopCooperType.setCreateTime(nowDate);
                pmShopCooperType.setCreateUser(user.getLoginName());
                pmShopCooperTypeService.save(pmShopCooperType);
                List<PmProductType> pmProductTypesLevel3=pmProductTypeService.getPmProductLevel3(pmShopCooperType.getProductTypeId());
                String pmProductTypesLevel3Id="";

                if (CollectionUtils.isNotEmpty(pmProductTypesLevel3)) {
                    for (PmProductType pmProductType : pmProductTypesLevel3) {
                        pmProductTypesLevel3Id += pmProductType
                                .getId() + ",";
                    }
                    pmProductTypesLevel3Id = pmProductTypesLevel3Id.substring(0,
                            pmProductTypesLevel3Id.length() - 1);
                }
                if(StringUtil.isNotBlank(pmProductTypesLevel3Id)) {
                    List<EbProductCharging> ebProductChargings = ebProductChargingService.findEbProductChargingByProductTypeId(pmProductTypesLevel3Id);
                    if (CollectionUtils.isNotEmpty(ebProductChargings)) {
                        for (EbProductCharging ebProductCharging : ebProductChargings) {
                            EbShopCharging ebShopCharging = null;
                            ebShopCharging = ebShopChargingService.findEbShopChargingById(pmShopInfo.getId(), ebProductCharging.getId());
                            if (ebShopCharging != null) {
                            } else {
                                ebShopCharging = new EbShopCharging();
                                ebShopCharging.setCost(0.0);
                                ebShopCharging.setChargingId(ebProductCharging.getId());
                                ebShopCharging.setSellPrice(ebProductCharging.getSellPrice());
                                ebShopCharging.setShopId(pmShopInfo.getId());
                                ebShopCharging.setCreateTime(new Date());
                                ebShopChargingService.insert(ebShopCharging);
                            }
                        }
                    }
                }
            }
        }
        return map;

    }

    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "shopinfoEdit")
    @ResponseBody
    public Map shopinfoEdit(HttpServletRequest request,
                            HttpServletResponse response, Model model,
                            RedirectAttributes redirectAttributes, String openingTime,
                            String closingTime, String mobile, String password) {
        Map map = new HashMap();//错误信息
        String id = request.getParameter("id");
        String shopName = request.getParameter("shopName");
        String businessCodeLogo = request.getParameter("businessCodeLogo");
        String remarkDesc = request.getParameter("remarkDesc");
        String isLineShop = request.getParameter("isLineShop");
        String returnRatio = request.getParameter("returnRatio");
        String customerPhone = request.getParameter("customerPhone");
        String legalPerson = request.getParameter("legalPerson");
        String coordinate = request.getParameter("coordinate");
        String shopLogo = request.getParameter("shopLogo");
        String shopBanner = request.getParameter("shopBanner");
        String cooperTypesid = request.getParameter("cooperTypesId");
        if (cooperTypesid == null || "".equals(cooperTypesid)) {
            cooperTypesid = "7,";
        }
//		String openingTime = request.getParameter("openingTime");
//		String closingTime = request.getParameter("closingTime");
        String shopLongitude = request.getParameter("longitude");
        String shopLatitude = request.getParameter("latitude");
        String onlineStatus = request.getParameter("onlineStatus");
        String contactAddress = request.getParameter("contactAddress");
        String districtName = request.getParameter("districtName");
        String isOptimization = request.getParameter("isOptimization");
        String isProductType = request.getParameter("isProductType");
        String isProduct = request.getParameter("isProduct");
        String isRoundApplet = request.getParameter("isRoundApplet");
        String accuracyApplet = request.getParameter("accuracyApplet");
        String isRoundCash = request.getParameter("isRoundCash");
        String accuracyCash = request.getParameter("accuracyCash");
        String test = request.getParameter("test");//测试门店，1是
        String startNumber = request.getParameter("startNumber");//起始取餐号
        String isTakeMeals = request.getParameter("isTakeMeals");//门店取餐提醒
        String isMiniOrder = request.getParameter("isMiniOrder");//小程序点餐开关
        String storeOrderReturns = request.getParameter("storeOrderReturns");//订单退款申请开关

        String cooperTypesid2[] = null;
        SysUser user = SysUserUtils.getUser();
        PmShopCooperType parmetershopid = new PmShopCooperType();
        if (StringUtils.isEmpty(id)) {
            map.put("code", "01");
            map.put("msg", "门店id错误！");
            return map;
        }

        parmetershopid.setShopId(Integer.valueOf(id));
        List<PmShopCooperType> pmShopCooperTypes = pmShopCooperTypeService
                .getShopList(parmetershopid);
        String cooperTypesid1 = "";
        if (CollectionUtils.isNotEmpty(pmShopCooperTypes)) {
            if (CollectionUtils.isNotEmpty(pmShopCooperTypes)) {
                for (int i = 0; i < pmShopCooperTypes.size(); i++) {
                    cooperTypesid1 += pmShopCooperTypes.get(i)
                            .getProductTypeId() + ",";
                }
                cooperTypesid1 = cooperTypesid1.substring(0,
                        cooperTypesid1.length() - 1);
            }
        }
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(id);
        if (pmShopInfo != null) {
            if (StringUtils.isNotBlank(shopName)) {
                PmShopInfo paramter = new PmShopInfo();
                paramter.setShopName(shopName);
                paramter.setId(Integer.valueOf(id));
                Integer count = 0;
                String countString = pmShopInfoService.getCount(paramter);
                if (StringUtils.isNotBlank(countString)) {
                    count = Integer.valueOf(countString);
                }
                if (count != 0) {
                    map.put("code", "01");
                    map.put("msg", "门店名称已存在！");
                    return map;
                } else {
                    pmShopInfo.setShopName(shopName);
                }
            }


            if (StringUtils.isNotBlank(remarkDesc)) {
                pmShopInfo.setRemarkDesc(remarkDesc);
            }
            if (StringUtils.isNotEmpty(isLineShop)) {
                if (isLineShop.equals("on") || isLineShop.equals("1")) {
                    pmShopInfo.setIsLineShop(1);
                } else {
                    pmShopInfo.setIsLineShop(0);
                }
            } else {
                pmShopInfo.setIsLineShop(0);
            }
            if (returnRatio != null && !"".equals(returnRatio)) {
                pmShopInfo.setReturnRatio(Double.parseDouble(returnRatio));
                pmShopInfo
                        .setReturnRatioOnline(Double.parseDouble(returnRatio));
            }

            if (StringUtils.isNotBlank(contactAddress)) {
                pmShopInfo.setContactAddress(contactAddress);
            }
            if (StringUtils.isNotBlank(districtName)) {
                String area[] = districtName.split(",");
                if (area.length == 5) {
                    pmShopInfo.setDistrictName(area[0] + "," + area[1]
                            + "," + area[2] + "," + area[3]);
                    pmShopInfo.setShopLlAddress(districtName.substring(
                            districtName.lastIndexOf(",") + 1,
                            districtName.length()));
                } else if (area.length == 4) {
                    pmShopInfo.setDistrictName(area[0] + "," + area[1]
                            + "," + area[2] + "," + area[3]);
                    pmShopInfo.setShopLlAddress("");
                }

            }
            if (StringUtils.isNumeric(onlineStatus)) {
                pmShopInfo.setOnlineStatus(Integer.valueOf(onlineStatus));
            }
            if (StringUtils.isNumeric(test)) {
                pmShopInfo.setTest(Integer.valueOf(test));
            }
            if (StringUtils.isNumeric(isOptimization)) {
                pmShopInfo.setIsOptimization(Integer
                        .valueOf(isOptimization));
            }
            if (StringUtils.isNotBlank(openingTime)) {
                String[] strings = openingTime.split(":");
                Time time = new Time(0);
                time.setHours(Integer.parseInt(strings[0]));
                time.setMinutes(Integer.parseInt(strings[1]));
                pmShopInfo.setOpeningTime(time);
            }
            if (StringUtils.isNotBlank(closingTime)) {
                String[] strings = closingTime.split(":");
                Time time = new Time(0);
                time.setHours(Integer.parseInt(strings[0]));
                time.setMinutes(Integer.parseInt(strings[1]));
                pmShopInfo.setClosingTime(time);
            }
            if (StringUtils.isNotBlank(startNumber)) {
                pmShopInfo.setStartNumber(Integer.parseInt(startNumber));
            }
            if (StringUtils.isNotBlank(isTakeMeals)) {
                pmShopInfo.setIsTakeMeals(Integer.parseInt(isTakeMeals));
            }
            if (StringUtils.isNotBlank(isMiniOrder)) {
                pmShopInfo.setIsMiniOrder(Integer.parseInt(isMiniOrder));
            }

            if (StringUtils.isNotBlank(storeOrderReturns)) {
                pmShopInfo.setStoreOrderReturns(Integer.parseInt(storeOrderReturns));
            }

            if (StringUtils.isNumeric(isOptimization)) {
                pmShopInfo.setIsOptimization(Integer
                        .valueOf(isOptimization));
            }
            if (StringUtils.isNotBlank(shopLongitude)) {
                pmShopInfo.setShopLongitude(shopLongitude);
            }
            if (StringUtils.isNotBlank(shopLatitude)) {
                pmShopInfo.setShopLatitude(shopLatitude);
            }
            if (StringUtils.isNotBlank(customerPhone)) {
                pmShopInfo.setCustomerPhone(customerPhone);
            }
            if (StringUtils.isNotBlank(legalPerson)) {
                pmShopInfo.setLegalPerson(legalPerson);
            }
            if (StringUtils.isNotBlank(shopLogo)) {
                pmShopInfo.setShopLogo(shopLogo);
            }
            if (StringUtils.isNotBlank(shopBanner)) {
                pmShopInfo.setShopBanner(shopBanner);
            }
            if (StringUtils.isNotBlank(businessCodeLogo)) {
                pmShopInfo.setBusinessCodeLogo(businessCodeLogo);
            }
            //商家是否支持商品分类添加 1是
            if (StringUtils.isNotBlank(isProductType)) {
                pmShopInfo.setIsProductType(Integer.parseInt(isProductType));
            }else{
                pmShopInfo.setIsProductType(0);
            }
            //商家是否支持商品添加 1是
            if (StringUtils.isNotBlank(isProduct)) {
                pmShopInfo.setIsProduct(Integer.parseInt(isProduct));

            }else{
                pmShopInfo.setIsProduct(0);
            }

            //小程序是否支持四舍五入 0 不支持  1支持
            if (StringUtils.isNotBlank(isRoundApplet)) {
                pmShopInfo.setIsRoundApplet(Integer.parseInt(isRoundApplet));
                if (StringUtils.isNotBlank(accuracyApplet) && Integer.valueOf(isRoundApplet)==1) {
                    pmShopInfo.setAccuracyApplet(Integer.valueOf(accuracyApplet));
                }
            }else{
                pmShopInfo.setIsRoundApplet(0);
            }

            //收银端是否支持四舍五入 0 不支持  1支持
            if (StringUtils.isNotBlank(isRoundCash)) {
                pmShopInfo.setIsRoundCash(Integer.parseInt(isRoundCash));
                if(StringUtil.isNotBlank(accuracyCash) && Integer.valueOf(isRoundCash)==1){
                    pmShopInfo.setAccuracyCash(Integer.valueOf(accuracyCash));
                }
            }else{
                pmShopInfo.setIsRoundCash(0);
            }

            if (StringUtils.isNotBlank(cooperTypesid)) {
                if (StringUtils.isNotBlank(cooperTypesid1)) {
                    cooperTypesid2 = cooperTypesid1.split(",");
                    if (cooperTypesid2 != null && cooperTypesid2.length > 0) {
                        String newcooperTypesid = cooperTypesid;
                        newcooperTypesid += ",00";
                        String cooperTypesids1[] = newcooperTypesid
                                .split(",");
                        for (int a = 0; a < cooperTypesid2.length; a++) {
                            for (int i = 0; i < cooperTypesids1.length; i++) {
                                if (cooperTypesids1[i]
                                        .equals(cooperTypesid2[a])) {
                                    break;
                                } else {
                                    if (cooperTypesids1.length == i + 1) {
                                        PmShopCooperType parmeterCooperType = new PmShopCooperType();
                                        parmeterCooperType
                                                .setShopId(pmShopInfo
                                                        .getId());
                                        parmeterCooperType
                                                .setProductTypeId(Integer
                                                        .valueOf(cooperTypesid2[a]));
                                        PmShopCooperType pmShopCooperType = pmShopCooperTypeService
                                                .findPmShopCooperType(parmeterCooperType);
                                        pmShopCooperTypeService
                                                .delete(pmShopCooperType);
                                    }
                                }
                            }
                        }
                    }
                }
                String cooperTypesids2[] = cooperTypesid.split(",");
                for (int i = 0; i < cooperTypesids2.length; i++) {
                    PmShopCooperType parmeterCooperType = new PmShopCooperType();
                    parmeterCooperType.setShopId(pmShopInfo.getId());
                    parmeterCooperType.setProductTypeId(Integer
                            .valueOf(cooperTypesids2[i]));
                    PmShopCooperType pmShopCooperType = pmShopCooperTypeService
                            .findPmShopCooperType(parmeterCooperType);
                    Date nowDate = new Date();
                    if (pmShopCooperType == null) {
                        pmShopCooperType = new PmShopCooperType();
                        pmShopCooperType.setShopId(pmShopInfo.getId());
                        pmShopCooperType.setProductTypeId(Integer
                                .valueOf(cooperTypesids2[i]));
                        pmShopCooperType.setRate(0);
                        pmShopCooperType.setCreateTime(nowDate);
                        pmShopCooperType.setCreateUser(user.getLoginName());
                    } else {
                        pmShopCooperType.setModifyUser(user.getLoginName());
                        pmShopCooperType.setModifyTime(nowDate);
                    }
                    pmShopCooperTypeService.save(pmShopCooperType);
                    List<PmProductType> pmProductTypesLevel3=pmProductTypeService.getPmProductLevel3(pmShopCooperType.getProductTypeId());
                    String pmProductTypesLevel3Id="";

                    if (CollectionUtils.isNotEmpty(pmProductTypesLevel3)) {
                        for (PmProductType pmProductType : pmProductTypesLevel3) {
                            pmProductTypesLevel3Id += pmProductType
                                    .getId() + ",";
                        }
                        pmProductTypesLevel3Id = pmProductTypesLevel3Id.substring(0,
                                pmProductTypesLevel3Id.length() - 1);
                    }
                    if(StringUtil.isNotBlank(pmProductTypesLevel3Id)) {
                    List<EbProductCharging> ebProductChargings= ebProductChargingService.findEbProductChargingByProductTypeId(pmProductTypesLevel3Id);
                    if (CollectionUtils.isNotEmpty(ebProductChargings)) {
                        for (EbProductCharging ebProductCharging : ebProductChargings) {
                            EbShopCharging ebShopCharging = null;
                            ebShopCharging = ebShopChargingService.findEbShopChargingById(pmShopInfo.getId(), ebProductCharging.getId());
                            if (ebShopCharging != null) {
                            } else {
                                ebShopCharging = new EbShopCharging();
                                ebShopCharging.setCost(0.0);
                                ebShopCharging.setChargingId(ebProductCharging.getId());
                                ebShopCharging.setSellPrice(ebProductCharging.getSellPrice());
                                ebShopCharging.setShopId(pmShopInfo.getId());
                                ebShopCharging.setCreateTime(new Date());
                                ebShopChargingService.insert(ebShopCharging);
                            }
                        }
                    }
                    }
                }
            }
        }
        map.put("code", "00");
        map.put("msg", "保存门店信息成功！");
        return map;

    }

//	@RequiresPermissions("merchandise:PmShopInfo:edit")
//	@RequestMapping(value = "shopinfoEdit")
//	public String shopinfoEdit(HttpServletRequest request,
//			HttpServletResponse response, Model model,
//			RedirectAttributes redirectAttributes) {
//		String id = request.getParameter("id");
//		String shopName = request.getParameter("shopName");
//		String businessCodeLogo = request.getParameter("businessCodeLogo");
//		String remarkDesc = request.getParameter("remarkDesc");
//		String customerPhone = request.getParameter("customerPhone");
//		String shopLogo = request.getParameter("shopLogo");
//		String shopBanner = request.getParameter("shopBanner");
//		String shopLongitude = request.getParameter("longitude");
//		String shopLatitude = request.getParameter("latitude");
//		String contactAddress = request.getParameter("contactAddress");
//		String districtName = request.getParameter("districtName");
//		String openingTime = request.getParameter("openingTime");
//		String closingTime = request.getParameter("closingTime");
//		String password = request.getParameter("password");
//		String mobile = request.getParameter("mobile");
//
//		PmShopInfo pmShopInfo = new PmShopInfo();
//		if(id!=null && !"".equals(id)){
//			pmShopInfo.setId(Integer.parseInt(id));
//		}
//		pmShopInfo.setShopName(shopName);
//		String count = pmShopInfoService.getCount(pmShopInfo);
//
//		if(!"0".equals(count)){
//			return "redirect:" + Global.getAdminPath()
//					+ "/PmShopInfo/shopinfo?message=1&id=" + pmShopInfo.getId();
//		}
//		Map<String , String> map = new HashMap<String, String>();
//
//		if(StringUtils.isNotBlank(customerPhone)){
//			map.put("customer_phone",customerPhone);
//		}
//		if(StringUtils.isNotBlank(shopLogo)){
//			map.put("shop_logo",shopLogo);
//		}
//		if(StringUtils.isNotBlank(shopBanner)){
//			map.put("shop_banner",shopBanner);
//		}
//		if(StringUtils.isNotBlank(shopLongitude)){
//			map.put("shop_longitude",shopLongitude);
//		}
//		if(StringUtils.isNotBlank(shopLatitude)){
//			map.put("shop_latitude",shopLatitude);
//		}
//		if(StringUtils.isNotBlank(contactAddress)){
//			map.put("contact_address",contactAddress);
//		}
//		if(StringUtils.isNotBlank(districtName)){
//			map.put("district_name",districtName);
//		}
//		if(StringUtils.isNotBlank(openingTime)){
//			map.put("opening_time",openingTime);
//		}
//		if(StringUtils.isNotBlank(closingTime)){
//			map.put("closing_time",closingTime);
//		}
//		if(StringUtils.isNotBlank(businessCodeLogo)){
//			map.put("business_code_logo",businessCodeLogo);
//		}
//		if(StringUtils.isNotBlank(shopName)){
//			map.put("shop_name",shopName);
//		}
//
//		boolean isSuccess = pmShopInfoService.updatePmShopInfo(id,map);
//
//		if(!isSuccess){
//			return "redirect:" + Global.getAdminPath()
//					+ "/PmShopInfo/shopinfo?message=2&id=" + pmShopInfo.getId();
//		}
//		return "redirect:" + Global.getAdminPath()
//					+ "/PmShopInfo/shopinfo?message=0&id=" + pmShopInfo.getId();
//	}


    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "smallBShopinfoEdit")
    public String smallBShopinfoEdit(HttpServletRequest request,
                                     HttpServletResponse response, Model model,
                                     RedirectAttributes redirectAttributes) {
        String id = request.getParameter("id");
        String contactName = request.getParameter("contactName");
        String businessCodeLogo = request.getParameter("businessCodeLogo");
        String mobilePhone = request.getParameter("mobilePhone");
        String describeInfo = request.getParameter("describeInfo");
        String remarkDesc = request.getParameter("remarkDesc");

        SysUser user = SysUserUtils.getUser();

        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(id);
        if (pmShopInfo != null) {
            pmShopInfo.setModifyUser(user.getName());
            pmShopInfo.setModifyTime(new Date());
            if (StringUtils.isNotBlank(remarkDesc)) {
                pmShopInfo.setRemarkDesc(remarkDesc);
            }

            if (StringUtils.isNotBlank(businessCodeLogo)) {
                pmShopInfo.setBusinessCodeLogo(businessCodeLogo);
            }
            if (StringUtils.isNotBlank(contactName)) {
                pmShopInfo.setContactName(contactName);
            }
            if (StringUtils.isNotBlank(mobilePhone)) {
                pmShopInfo.setMobilePhone(mobilePhone);
            }
            if (StringUtils.isNotBlank(describeInfo)) {
                pmShopInfo.setDescribeInfo(describeInfo);
            }

        }
        return "redirect:" + Global.getAdminPath()
                + "/PmShopInfo/smallBList";

    }

    @RequiresPermissions("merchandise:EbAdvertise:view")
    @RequestMapping(value = "shopAdvertise")
    public String shopAdvertise(HttpServletRequest request,
                                HttpServletResponse response, Model model) {
        String shopid = request.getParameter("shopid");
        String message = request.getParameter("message");
        EbAdvertise ebAdvertise = new EbAdvertise();
        ebAdvertise.setStatus(2);
        ebAdvertise.setShopId(Integer.valueOf(shopid));
        Page<EbAdvertise> page = ebAdvertiseService.getPageList(
                new Page<EbAdvertise>(request, response), ebAdvertise);
        if (page.getCount() != 0) {
            model.addAttribute("page", page);
        }
        if (StringUtils.isNotBlank(message)) {
            if (message.equals("0")) {
                model.addAttribute("message", "已启用");
            }
            if (message.equals("1")) {
                model.addAttribute("message", "已禁用");
            }
            if (message.equals("2")) {
                model.addAttribute("message", "已删除");
            }
            if (message.equals("3")) {
                model.addAttribute("message", "更新成功");
            }
            if (message.equals("4")) {
                model.addAttribute("message", "保存成功");
            }
        }
        model.addAttribute("shopid", shopid);
        return "modules/shopping/shop/fitment";
    }

    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "status")
    public String status(HttpServletRequest request,
                         HttpServletResponse response, Model model) throws Exception {
        String shopid = request.getParameter("shopid");
        String advertiseid = request.getParameter("advertiseid");
        String status = request.getParameter("status");
        String message = "";
        if (StringUtils.isNotBlank(advertiseid)) {
            EbAdvertise advertise = ebAdvertiseService
                    .getebadAdvertise(advertiseid);
            if (advertise != null) {
                if (status.equals("0")) {// 0,显示1隐藏2，删除
                    advertise.setStatus(0);
                    message = "0";
                }
                if (status.equals("1")) {// 0,显示1隐藏2，删除
                    advertise.setStatus(1);
                    message = "1";
                }
                if (status.equals("2")) {// 0,显示1隐藏2，删除
                    advertise.setStatus(2);
                    message = "2";
                }
                ebAdvertiseService.save(advertise);
            }
        }
        model.addAttribute("shopid", shopid);
        return "redirect:" + Global.getAdminPath()
                + "/PmShopInfo/shopAdvertise?shopid=" + shopid + "&message="
                + message;
    }

    @RequiresPermissions("merchandise:PmShopInfo:view")
    @RequestMapping(value = "advertiselist")
    public String advertiselist(HttpServletRequest request,
                                HttpServletResponse response, Model model) throws Exception {
        String shopid = request.getParameter("shopid");
        String layouttypeId = request.getParameter("layouttypeId");
        String advertiseid = request.getParameter("advertiseid");
        if (StringUtils.isNotBlank(layouttypeId)) {
            if (StringUtils.isNotBlank(advertiseid)) {
                EbAdvertise advertise = ebAdvertiseService
                        .getebadAdvertise(advertiseid);
                if (advertise != null) {
                    if (advertise.getAdvertiseType() != null) {
                        if (advertise.getAdvertiseType() == 2) {
                            if (advertise.getAdvertiseTypeObjId() != null) {
                                EbProduct ebProduct = ebProductService
                                        .getEbProduct(advertise
                                                .getAdvertiseTypeObjId()
                                                .toString());
                                advertise.setEbProduct(ebProduct);
                            }
                        }
                    }
                    model.addAttribute("advertise", advertise);
                }
            }
            createPicFold(request);
            EbLayouttype layouttype = ebLayouttypeService
                    .geteblLayouttype(layouttypeId);
            if (layouttype != null) {
                model.addAttribute("layouttype", layouttype);
            }
            model.addAttribute("shopid", shopid);
            return "modules/shopping/shop/fitment-edit";
        } else {
            EbLayouttype layouttype = new EbLayouttype();
            layouttype.setObjAdModule("5");// 对应业务广告模板：1、线上商城（天猫）；2、线下门店（美团/附近）；3、善于发现（什么值得买）；4、御可贡茶商学院；5、商家；
            layouttype.setStatus(1);
            List<EbLayouttype> layouttypes = ebLayouttypeService
                    .getList(layouttype);
            if (CollectionUtils.isNotEmpty(layouttypes)) {
                model.addAttribute("layouttypes", layouttypes);
            }
            model.addAttribute("shopid", shopid);
            return "modules/shopping/shop/fitment-add";
        }
    }

    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "advertiseadd")
    public String advertiseadd(HttpServletRequest request,
                               HttpServletResponse response, Model model) throws Exception {
        String shopid = request.getParameter("shopid");
        String advertiseid = request.getParameter("advertiseid");
        String orderNo = request.getParameter("orderNo");
        String mo = request.getParameter("mo");
        String advertiseType = request.getParameter("advertiseType");
        String advertuseImg = request.getParameter("advertuseImg");
        String advertiseTitle = request.getParameter("advertiseTitle");
        String sellPrice = request.getParameter("sellPrice");
        String charitySize = request.getParameter("charitySize");
        String layouttypeId = request.getParameter("layouttypeId");
        String lamoduleTitle = request.getParameter("lamoduleTitle");// 模板名称
        String advertiseTypeObjId = request.getParameter("advertiseTypeObjId");// 对象id
        String linkUrl = request.getParameter("linkUrl");// 链接
        SysUser user = SysUserUtils.getUser();
        String message = "";
        EbAdvertise ebAdvertise = null;
        if (StringUtils.isNotBlank(advertiseid)) {
            ebAdvertise = ebAdvertiseService.getebadAdvertise(advertiseid);
        } else {
            ebAdvertise = new EbAdvertise();
        }
        if (ebAdvertise != null) {
            Date nowDate = new Date();
            ebAdvertise.setLayouttypeId(layouttypeId);
            ebAdvertise.setLayouttypeName(lamoduleTitle);
            ebAdvertise.setAdvertiseTitle(advertiseTitle);
            // ebAdvertise.setAdvertiseName(advertiseName);//广告名称
            ebAdvertise.setAdvertiseType(Integer.valueOf(advertiseType));
            ebAdvertise.setAdvertuseImg(advertuseImg);
            // ebAdvertise.setAdcertuseDetails(adcertuseDetails);//广告详情
            ebAdvertise.setStatus(Integer.valueOf(mo));
            // ebAdvertise.setIsBack(isBack);//滚动1.不滚动，2，滚动 3，置顶滚动
            // ebAdvertise.setPints(pints);//热点1，是2，否
            ebAdvertise.setLinkUrl(linkUrl);// 链接
            if (StringUtils.isNotBlank(advertiseTypeObjId)) {
                ebAdvertise.setAdvertiseTypeObjId(Integer
                        .parseInt(advertiseTypeObjId));
            }
            ebAdvertise.setOrderNo(Integer.valueOf(orderNo));
            ebAdvertise.setShopId(Integer.valueOf(shopid));
            // ebAdvertise.setSellPrice(Double.parseDouble(sellPrice));
            // ebAdvertise.setCharitySize(charitySize);
            if (StringUtils.isNotBlank(advertiseid)) {
                ebAdvertise.setModifyTime(nowDate);
                ebAdvertise.setModifyUser(user.getLoginName());
                message = "3";
            } else {
                ebAdvertise.setCreateTime(nowDate);
                ebAdvertise.setCreateUser(user.getLoginName());
                ebAdvertise.setModifyTime(nowDate);
                ebAdvertise.setModifyUser(user.getLoginName());
                message = "4";
            }
            ebAdvertiseService.save(ebAdvertise);
        }
        return "redirect:" + Global.getAdminPath()
                + "/PmShopInfo/shopAdvertise?shopid=" + shopid + "&message="
                + message;
    }

    @RequiresPermissions("merchandise:PmShopInfo:edit")
    @RequestMapping(value = "delete")
    public String delete(PmShopInfo pmShopInfo, HttpServletRequest request,
                         HttpServletResponse response, Model model,
                         RedirectAttributes redirectAttributes) {
        pmShopInfoService.delete(pmShopInfo);
        addMessage(redirectAttributes, "删除成功");
        return "redirect:" + Global.getAdminPath() + "/PmShopInfo/list";
    }

    @ResponseBody
    @RequestMapping(value = "geturl")
    public String geturl(HttpServletRequest request,
                         HttpServletResponse response) {
        String url = "01";
        String id = request.getParameter("id");
        if (StringUtils.isNotBlank(id)) {
            PmShopInfo shopInfo = pmShopInfoService.getpmPmShopInfo(id);

            if (shopInfo != null) {
                Integer shopTypeIdentity = shopInfo.getShopTypeIdentity();
                EbUser ebuser2 = null;
                String reviewStatus = request.getParameter("Fruit");
                String reviewReason = request.getParameter("fult");
                String reason = StringUtils.isBlank(reviewReason) ? "" : "理由："
                        + reviewReason + "，";// 审核原因
                if (shopTypeIdentity == 0) {
                    ebuser2 = ebUserService.getShop(shopInfo.getId()
                            .toString());
                } else if (shopTypeIdentity == 1) {
                    ebuser2 = ebUserService.getshopIdBigB(shopInfo.getId()
                            .toString());
                } else if (shopTypeIdentity == 2) {
                    ebuser2 = ebUserService.getshopIdSmallB(shopInfo.getId()
                            .toString());
                }
                if (reviewStatus.equals("1")) {
                    String messageContent = "";
                    if (shopTypeIdentity == 0) {
                        messageContent = "您的商家入驻申请已通过，" + reason
                                + "登录" + Global.getConfig("domainurl")
                                + "/shop 即可管理您的门店。如需帮助，可联系平台客服。";
                    } else if (shopTypeIdentity == 1) {
                        messageContent = "供应商审核已通过";
                    } else if (shopTypeIdentity == 2) {
                        messageContent = "店商审核已通过。如需帮助，可联系平台客服。";
                    }
                    shopInfo.setReviewStatus(1);
                    shopInfo.setOnlineStatus(1);
                    shopInfo.setIsLineShop(1);
                    shopInfo.setReviewReason(reviewReason);
                    SysUser user = SysUserUtils.getUser();
                    shopInfo.setReviewName(user.getLoginName());
                    shopInfo.setReviewDate(new Date());
                    pmShopInfoService.save(shopInfo);


                    if (ebuser2 != null) {
                        // 消息
                        EbMessageUser messageInfoUser = new EbMessageUser();
                        messageInfoUser.setUserId(ebuser2.getUserId());
                        EbMessage eMessage = new EbMessage();
                        eMessage.setCreateTime(new Date());
                        eMessage.setCreateUser("平台管理员");
                        eMessage.setMessageAbstract("您的申请已通过！");
                        eMessage.setMessageTitle("您的申请已通过！");
                        eMessage.setMessageClass(2);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
                        eMessage.setMessageContent(messageContent);
                        eMessage.setMessageIcon("/uploads/drawable-xhdpi/xtxx.png");
                        eMessage.setMessageObjId(ebuser2.getUserId());
                        eMessage.setMessageType(5);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
                        // 结算提醒；8、退货/售后提醒；9、系统公告；
                        ebMessageService.saveflush(eMessage);
                        messageInfoUser.setMessageInfo(eMessage);
                        messageInfoUser.setState(3);
                        messageInfoUser.setUserType(1);
                        messageInfoUser.setCreateUser(SysUserUtils.getUser()
                                .getId());
                        messageInfoUserService
                                .sqlsaveEbMessage(messageInfoUser);
                        // 推送
                        messageInfoUserService.sendMsgJgEbMessageUser(
                                ebuser2.getUserId(),
                                eMessage);
                    }
                } else {
                    shopInfo.setReviewStatus(2);
                    SysUser user = SysUserUtils.getUser();
                    shopInfo.setReviewName(user.getLoginName());
                    shopInfo.setReviewDate(new Date());
                    pmShopInfoService.save(shopInfo);
                    // 消息
                    if (ebuser2 != null) {
                        String messageContent = "";
                        if (shopTypeIdentity == 0) {
                            messageContent = "您的商家入驻申请未通过，" + reason
                                    + "请重新提交资料进行申请。如需帮助，可联系平台客服。";
                        } else if (shopTypeIdentity == 1) {
                            messageContent = "供应商审核未通过，请重新提交资料进行申请。如需帮助，可联系平台客服。";
                        } else if (shopTypeIdentity == 2) {
                            messageContent = "店商审核未通过，请重新提交资料进行申请。如需帮助，可联系平台客服。";
                        }
                        EbMessageUser messageInfoUser = new EbMessageUser();
                        messageInfoUser.setUserId(ebuser2.getUserId());
                        EbMessage eMessage = new EbMessage();
                        eMessage.setCreateTime(new Date());
                        eMessage.setCreateUser("平台管理员");
                        eMessage.setMessageTitle("您的申请未通过！");
                        eMessage.setMessageAbstract("您的申请未通过");
                        eMessage.setMessageClass(2);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
                        eMessage.setMessageContent(messageContent);
                        eMessage.setMessageIcon("/uploads/drawable-xhdpi/xtxx.png");
                        eMessage.setMessageObjId(ebuser2.getUserId());
                        eMessage.setMessageType(5);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
                        // 结算提醒；8、退货/售后提醒；9、系统公告；
                        ebMessageService.saveflush(eMessage);
                        messageInfoUser.setMessageInfo(eMessage);
                        messageInfoUser.setState(3);
                        messageInfoUser.setUserType(1);
                        messageInfoUser.setCreateUser(SysUserUtils.getUser()
                                .getId());
                        messageInfoUserService
                                .sqlsaveEbMessage(messageInfoUser);
                        // 推送
                        messageInfoUserService.sendMsgJgEbMessageUser(
                                ebuser2.getUserId(),
                                eMessage);
                    }
                }
                url = "00";
                return url;
            }
        }
        return url;
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
        folder.append("ShopImg");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }

    @SuppressWarnings("deprecation")
    @ResponseBody
    @RequestMapping(value = "exsel")
    public String exsel(HttpServletRequest request, HttpServletResponse response) {
        String url = "";
        String syllable[] = request.getParameterValues("syllable");
        if (syllable != null && syllable.length > 0) {
            int t = 1;
            int pageNo = 1;
            int rowNum = 1;
            int rowNums = 100;
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("商户列表");
            HSSFRow row = sheet.createRow((int) 0);
            HSSFCellStyle style = wb.createCellStyle();
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("序号");
            cell.setCellStyle(style);
            for (int i = 0; i < syllable.length; i++) {
                cell = row.createCell((short) i);
                if (syllable[i].equals("1")) {
                    cell.setCellValue("商户代码");
                }
                if (syllable[i].equals("2")) {
                    cell.setCellValue("公司名称");
                }
                if (syllable[i].equals("3")) {
                    cell.setCellValue("门店名称");
                }
                if (syllable[i].equals("4")) {
                    cell.setCellValue("联系手机");
                }
                if (syllable[i].equals("5")) {
                    cell.setCellValue("审核状态");
                }
                if (syllable[i].equals("6")) {
                    cell.setCellValue("在线状态");
                }
                if (syllable[i].equals("7")) {
                    cell.setCellValue("审核人");
                }
                if (syllable[i].equals("8")) {
                    cell.setCellValue("线下门店");
                }
                if (syllable[i].equals("9")) {
                    cell.setCellValue("让利比");
                }
                if (syllable[i].equals("10")) {
                    cell.setCellValue("审核时间");
                }
                cell.setCellStyle(style);
            }
            while (t == 1) {
                String shopCode = request.getParameter("shopCode");
                String reviewStatus = request.getParameter("reviewStatus");
                String onlineStatus = request.getParameter("onlineStatus");
                String isLineShop = request.getParameter("isLineShop");
                PmShopInfo pmShopInfo = new PmShopInfo();
                if (StringUtils.isNotBlank(shopCode)) {
                    pmShopInfo.setShopCode(shopCode);
                }
                if (StringUtils.isNotBlank(reviewStatus)) {
                    pmShopInfo.setReviewStatus(Integer.parseInt(reviewStatus));
                }
                if (StringUtils.isNotBlank(onlineStatus)) {
                    pmShopInfo.setOnlineStatus(Integer.parseInt(onlineStatus));
                }
                if (StringUtils.isNotBlank(isLineShop)) {
                    pmShopInfo.setIsLineShop(Integer.parseInt(isLineShop));
                }
                Page<PmShopInfo> page = pmShopInfoService.getPageList(
                        new Page<PmShopInfo>(pageNo, rowNums), pmShopInfo);
                List<PmShopInfo> pmShopInfos = new ArrayList<PmShopInfo>();
                pmShopInfos = page.getList();
                if ((page.getCount() == rowNums && pageNo > 1)
                        || (page.getCount() / rowNums) < 1 && pageNo > 1) {
                    pmShopInfos = null;
                }
                if (pmShopInfos != null && pmShopInfos.size() > 0) {
                    for (PmShopInfo pmShopInfo2 : pmShopInfos) {
                        try {
                            row = sheet.createRow((int) rowNum);
                            row.createCell((short) 0).setCellValue(rowNum);
                            for (int i = 0; i < syllable.length; i++) {
                                if (syllable[i].equals("1")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getShopCode());
                                }
                                if (syllable[i].equals("2")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getCompanyName());
                                }
                                if (syllable[i].equals("3")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getShopName());
                                }
                                if (syllable[i].equals("4")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getMobilePhone());
                                }
                                if (syllable[i].equals("5")) {
                                    String type = "";
                                    if (pmShopInfo2.getReviewStatus() == 0) {
                                        type = "未审核";
                                    } else {
                                        type = "审核通过";
                                    }
                                    row.createCell((short) i)
                                            .setCellValue(type);
                                }
                                if (syllable[i].equals("6")) {
                                    String type = "";
                                    if (pmShopInfo2.getOnlineStatus() == 0) {
                                        type = "离线";
                                    } else {
                                        type = "在线";
                                    }
                                    row.createCell((short) i)
                                            .setCellValue(type);
                                }
                                if (syllable[i].equals("7")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getReturnRatio());
                                }
                                if (syllable[i].equals("8")) {
                                    String type = "";
                                    if (pmShopInfo2.getIsLineShop() == 0) {
                                        type = "未开通";
                                    } else {
                                        type = "已开通";
                                    }
                                    row.createCell((short) i)
                                            .setCellValue(type);
                                }
                                if (syllable[i].equals("9")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getReturnRatio());
                                }
                                if (syllable[i].equals("10")) {
                                    row.createCell((short) i).setCellValue(
                                            pmShopInfo2.getReviewDate());
                                }
                            }

                        } catch (Exception e) {
                            /* System.out.print(e.getCause()); */
                        }
                        rowNum++;
                    }
                    pageNo++;
                } else {
                    t = 2;
                }
            }
            String RootPath = request.getSession().getServletContext()
                    .getRealPath("/").replace("\\", "/");
            String path = "uploads/xlsfile/tempfile";
            Random r = new Random();
            String strfileName = DateUtil.getDateFormat(new Date(),
                    "yyyyMMddHHmmss") + r.nextInt();
            File f = new File(RootPath + path);
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


    /**
     * 商家入驻申请
     *
     * @param pmShopInfo
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "applylist")
    public String applylist(PmShopInfo pmShopInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        if (pmShopInfo.getReviewStatus() == null) {
            pmShopInfo.setReviewStatus(0);
        }
        Page<PmShopInfo> page = pmShopInfoService.getPageList(
                new Page<PmShopInfo>(request, response), pmShopInfo);
        model.addAttribute("page", page);
        return "modules/businessapply/businessapplylist";
    }


    /**
     * 查看商家入驻详情
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "businessDetail")
    public String businessDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        String id = request.getParameter("id");
        if (StringUtils.isNotBlank(id)) {
            PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(id);
            model.addAttribute("apply", pmShopInfo);
        }
        return "modules/businessapply/businessdetail";
    }


    /**
     * 入驻审核
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/auditing")
    @ResponseBody
    public Map<String, Object> auditing(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        String reviewStatus = request.getParameter("status");
        String id = request.getParameter("id");
        String reviewReason = request.getParameter("reviewReason");
        if (StringUtils.isNotBlank(id) && StringUtils.isNotBlank(reviewStatus)) {
            PmShopInfo shopInfo = pmShopInfoService.getpmPmShopInfo(id);

            if (shopInfo != null) {
                Integer shopTypeIdentity = shopInfo.getShopTypeIdentity();
                EbUser ebuser2 = null;

                String reason = StringUtils.isBlank(reviewReason) ? "" : "理由："
                        + reviewReason + "，";// 审核原因
                if (shopTypeIdentity == 0) {
                    ebuser2 = ebUserService.getShop(shopInfo.getId()
                            .toString());
                } else if (shopTypeIdentity == 1) {
                    ebuser2 = ebUserService.getshopIdBigB(shopInfo.getId()
                            .toString());
                } else if (shopTypeIdentity == 2) {
                    ebuser2 = ebUserService.getshopIdSmallB(shopInfo.getId()
                            .toString());
                }
                if (reviewStatus.equals("1")) {
                    String messageContent = "";
                    if (shopTypeIdentity == 0) {
                        messageContent = "您的商家入驻申请已通过，" + reason
                                + "登录" + Global.getConfig("domainurl")
                                + "/shop 即可管理您的门店。如需帮助，可联系平台客服。";
                    } else if (shopTypeIdentity == 1) {
                        messageContent = "供应商审核已通过";
                    } else if (shopTypeIdentity == 2) {
                        messageContent = "店商审核已通过。如需帮助，可联系平台客服。";
                    }
                    shopInfo.setReviewStatus(1);
                    shopInfo.setOnlineStatus(1);
                    shopInfo.setIsLineShop(1);
                    shopInfo.setReviewReason(reviewReason);
                    SysUser user = SysUserUtils.getUser();
                    shopInfo.setReviewName(user.getLoginName());
                    shopInfo.setReviewDate(new Date());
                    pmShopInfoService.save(shopInfo);


                    if (ebuser2 != null) {
                        // 消息
                        EbMessageUser messageInfoUser = new EbMessageUser();
                        messageInfoUser.setUserId(ebuser2.getUserId());
                        EbMessage eMessage = new EbMessage();
                        eMessage.setCreateTime(new Date());
                        eMessage.setCreateUser("平台管理员");
                        eMessage.setMessageAbstract("您的申请已通过！");
                        eMessage.setMessageTitle("您的申请已通过！");
                        eMessage.setMessageClass(2);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
                        eMessage.setMessageContent(messageContent);
                        eMessage.setMessageIcon("/uploads/drawable-xhdpi/xtxx.png");
                        eMessage.setMessageObjId(ebuser2.getUserId());
                        eMessage.setMessageType(5);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
                        // 结算提醒；8、退货/售后提醒；9、系统公告；
                        ebMessageService.saveflush(eMessage);
                        messageInfoUser.setMessageInfo(eMessage);
                        messageInfoUser.setState(3);
                        messageInfoUser.setUserType(1);
                        messageInfoUser.setCreateUser(SysUserUtils.getUser()
                                .getId());
                        messageInfoUserService
                                .sqlsaveEbMessage(messageInfoUser);
                        // 推送
                        messageInfoUserService.sendMsgJgEbMessageUser(
                                ebuser2.getUserId(),
                                eMessage);
                    }
                } else {
                    shopInfo.setReviewStatus(2);
                    SysUser user = SysUserUtils.getUser();
                    shopInfo.setReviewName(user.getLoginName());
                    shopInfo.setReviewDate(new Date());
                    shopInfo.setReviewReason(reviewReason);
                    pmShopInfoService.save(shopInfo);
                    // 消息
                    if (ebuser2 != null) {
                        String messageContent = "";
                        if (shopTypeIdentity == 0) {
                            messageContent = "您的商家入驻申请未通过，" + reason
                                    + "请重新提交资料进行申请。如需帮助，可联系平台客服。";
                        } else if (shopTypeIdentity == 1) {
                            messageContent = "供应商审核未通过，请重新提交资料进行申请。如需帮助，可联系平台客服。";
                        } else if (shopTypeIdentity == 2) {
                            messageContent = "店商审核未通过，请重新提交资料进行申请。如需帮助，可联系平台客服。";
                        }
                        EbMessageUser messageInfoUser = new EbMessageUser();
                        messageInfoUser.setUserId(ebuser2.getUserId());
                        EbMessage eMessage = new EbMessage();
                        eMessage.setCreateTime(new Date());
                        eMessage.setCreateUser("平台管理员");
                        eMessage.setMessageTitle("您的申请未通过！");
                        eMessage.setMessageAbstract("您的申请未通过");
                        eMessage.setMessageClass(2);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
                        eMessage.setMessageContent(messageContent);
                        eMessage.setMessageIcon("/uploads/drawable-xhdpi/xtxx.png");
                        eMessage.setMessageObjId(ebuser2.getUserId());
                        eMessage.setMessageType(5);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
                        // 结算提醒；8、退货/售后提醒；9、系统公告；
                        ebMessageService.saveflush(eMessage);
                        messageInfoUser.setMessageInfo(eMessage);
                        messageInfoUser.setState(3);
                        messageInfoUser.setUserType(1);
                        messageInfoUser.setCreateUser(SysUserUtils.getUser()
                                .getId());
                        messageInfoUserService
                                .sqlsaveEbMessage(messageInfoUser);
                        // 推送
                        messageInfoUserService.sendMsgJgEbMessageUser(
                                ebuser2.getUserId(),
                                eMessage);
                    }
                }
                map.put("code", "00");
                map.put("msg", "操作成功");
                return map;
            }
        } else {
            map.put("code", "01");
            map.put("msg", "异常操作!id或状态不能为空");
        }
        return map;
    }


    @RequestMapping("testmap")
    public String testMap() {
        return "/modules/store/storeedit2";
    }

}