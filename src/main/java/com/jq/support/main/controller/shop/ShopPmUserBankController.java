package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmUserBank;
import com.jq.support.model.user.PmUserSmsCode;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmUserBankService;
import com.jq.support.service.merchandise.user.PmUserSmsCodeService;
import com.jq.support.service.utils.CommonUtils;
import com.jq.support.service.utils.RandomNumber;
import com.jq.support.service.utils.RealNameAuthentiCationUtil;
import com.jq.support.service.utils.StringUtil;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商家银行卡管理
 */
@Controller
@RequestMapping(value = "${adShopPath}/pmUserBank")
public class ShopPmUserBankController extends BaseController {
    @Autowired
    private PmUserBankService pmUserBankService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmUserSmsCodeService pmUserSmsCodeService;
    @Autowired
    private EbUserService ebUserService;

    /**
     * 列表
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("list")
    public String list(PmUserBank pmUserBank, HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String keyword = request.getParameter("keyword");//关键字
        pmUserBank.setUserId(ebUser.getUserId());
        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");
        Page rPage=new Page<PmUserBank>(request, response);
        if(StringUtil.isNotBlank(pageNo)&&StringUtil.isNotBlank(pageSize)){
            rPage.setPageNo(Integer.parseInt(pageNo));
            rPage.setPageSize(Integer.parseInt(pageSize));
        }
        Page<PmUserBank> page = pmUserBankService.pmUserBankPage(rPage, pmUserBank, keyword);
        model.addAttribute("page", page);
        model.addAttribute("pmUserBank", pmUserBank);
        model.addAttribute("keyword", keyword);
        return "modules/shop/pmUserBankList";
    }

    /**
     * 添加页面
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("form")
    public String form(HttpServletRequest request, HttpServletResponse response, Model model) {
        String id = request.getParameter("id");
        if (id != null) {
            PmUserBank getShop = pmUserBankService.findid(Integer.parseInt(id));
            model.addAttribute("user", getShop);
        } else {
            model.addAttribute("user", new PmUserBank());
        }
        return "modules/shop/pmUserBankForm";
    }

    /**
     * 广告是否可用
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "isdelete")
    public String isdelete(
            HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
        String id=request.getParameter("id");
        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");
        PmUserBank pmUserBank = pmUserBankService.findid(Integer.parseInt(id));
        pmUserBank.setIsdelete(1);
        pmUserBankService.save(pmUserBank);
        addMessage(redirectAttributes, "操作成功");
        return "redirect:"+ Global.getConfig("adShopPath")+"/pmUserBank/list?pageNo="+pageNo+"&pageSize="+pageSize;
    }
    /**
     * 发送短信验证码
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping("smsCode")
    public Map smsCode(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String mobile = request.getParameter("mobile");// 手机号
        Map map = new HashMap();
        if (StringUtils.isBlank(mobile)) {
            map.put("code", "01");
            map.put("msg", "手机号不能为空！");
        } else if (mobile.length() != 11) {
            map.put("code", "01");
            map.put("msg", "手机号格式错误！");
        } else {
            String smsCode = RandomNumber.getRandomCode();
            String smsmsg = "";//发送验证码内容
            PmUserSmsCode pmUserSmsCode = new PmUserSmsCode();
            pmUserSmsCode.setCreateTime(new Date());
            pmUserSmsCode.setSmsCode(smsCode);//验证码
            pmUserSmsCode.setMobile(mobile);//手机号
            pmUserSmsCode.setType(3);
            smsmsg = "尊敬的用户，您本次使用服务的短信验证码为：" + smsCode
                    + "。请注意查收，勿向他人泄露此验证码，2分钟内有效。";

            boolean flag = CommonUtils.sendMsg(mobile, smsmsg);
            if (flag) {
                pmUserSmsCodeService.save(pmUserSmsCode);
                map.put("code", "00");
                map.put("msg", "发送验证码成功！");
            } else {
                map.put("code", "01");
                map.put("msg", "发送验证码失败！");
            }
        }

        return map;
    }

    /**
     * 添加银行卡
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping("addMyBankCard")
    public Map addMyBankCard(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String isCertification = ebUser.getIsCertification() + "";
        String userId = ebUser.getUserId() + "";
        String account = request.getParameter("account");
        String accountName = request.getParameter("accountName");
        String bankName = request.getParameter("bankName");
        String subbranchName = request.getParameter("subbranchName");
        String phoneNum = request.getParameter("phoneNum");
        String SmsCode = request.getParameter("vCode");
        String idcard = request.getParameter("idcard");
        Map map = new HashMap();
        if (StringUtils.isBlank(account)) {
            map.put("code", "01");
            map.put("msg", "交易银行账号不能为空！");
            return map;
        } else if (StringUtils.isBlank(accountName)) {
            map.put("code", "01");
            map.put("msg", "开户名（持卡人）不能为空！");
            return map;
        } else if (StringUtils.isBlank(bankName)) {
            map.put("code", "01");
            map.put("msg", "开户行不能为空！");
            return map;
        } else if (StringUtils.isBlank(subbranchName)) {
            map.put("code", "01");
            map.put("msg", "开所属支行不能为空！");
            return map;
        } else if (StringUtils.isBlank(phoneNum)) {
            map.put("code", "01");
            map.put("msg", "银行预留手机号不能为空！");
            return map;
        } else if (StringUtils.isBlank(SmsCode)) {
            map.put("code", "01");
            map.put("msg", "验证码不能为空！");
            return map;
        } else if (StringUtils.isBlank(idcard)) {
            map.put("code", "01");
            map.put("msg", "身份证号不能为空！");
            return map;
        }

        com.alibaba.fastjson.JSONObject jsonCode = pmUserSmsCodeService
                .yzSmacode(phoneNum, SmsCode, 3);
        if (jsonCode.get("code").equals("01")) {
            map.put("code", "01");
            map.put("msg", jsonCode.get("msg").toString());
            return map;
        }
        if (isCertification.equals("0")) {

            Map json = RealNameAuthentiCationUtil
                    .RealNameAuthentiCationoC(account, accountName,
                            idcard, phoneNum);
            if ("00".equals(json.get("errorcode"))) {
                ebUser.setIdcard(idcard);
                ebUser.setRealName(accountName);
                ebUser.setIsCertification(1);
                ebUserService.save(ebUser);
                PmUserBank userBank = new PmUserBank();
                userBank.setBankType(0);
                userBank.setIsdelete(0);
                userBank.setIsDefault(0);
                Date nowtime = new Date();
                userBank.setUserId(ebUser.getUserId());
                userBank.setAccountName(ebUser.getRealName());
                userBank.setIdcard(ebUser.getIdcard());
                userBank.setAccount(account);
                userBank.setBankName(bankName);
                userBank.setSubbranchName(subbranchName);
                userBank.setPhoneNum(phoneNum);
                userBank.setCreateUser("userid:"
                        + ebUser.getUserId().toString());
                userBank.setCreateTime(nowtime);
                userBank.setModifyUser("userid:"
                        + ebUser.getUserId().toString());
                userBank.setModifyTime(nowtime);
                pmUserBankService.save(userBank);
                map.put("code", "00");
                map.put("msg", "添加银行卡成功！");
                return map;
            } else {
                map.put("code", "01");
                map.put("msg", json.get("msg").toString());
                return map;
            }

        } else if (isCertification.equals("1")) {
            Map json = RealNameAuthentiCationUtil
                    .RealNameAuthentiCationoC(account, accountName,
                            idcard, phoneNum);
            if (!"00".equals(json.get("errorcode"))) {
                map.put("code", "01");
                map.put("msg", json.get("msg").toString());
                return map;
            }
            PmUserBank pmUserBank = new PmUserBank();
            pmUserBank.setUserId(ebUser.getUserId());
            pmUserBank.setAccount(account);
            List<PmUserBank> userBanks = pmUserBankService
                    .getAccountUserBank(pmUserBank);
            PmUserBank userBank = null;
            if (CollectionUtils.isNotEmpty(userBanks)) {
                userBank = userBanks.get(0);
                if (userBank.getIsdelete() != null
                        && userBank.getIsdelete() == 0) {
                    map.put("code", "01");
                    map.put("msg", "银行卡已存在！");
                    return map;
                }
                userBank.setBankType(0);
                userBank.setIsdelete(0);
                userBank.setIsDefault(0);
                userBank.setSubbranchName(subbranchName);
                userBank.setPhoneNum(phoneNum);
                userBank.setModifyUser("userid:"
                        + ebUser.getUserId().toString());
                userBank.setModifyTime(new Date());
                pmUserBankService.save(userBank);
                map.put("code", "00");
                map.put("msg", "添加银行卡成功！");
                return map;
            } else {

                if ("00".equals(json.get("errorcode"))) {
                    userBank = new PmUserBank();
                    userBank.setBankType(0);
                    userBank.setIsdelete(0);
                    userBank.setIsDefault(0);
                    Date nowtime = new Date();
                    userBank.setUserId(ebUser.getUserId());
                    userBank.setAccountName(accountName);
                    userBank.setIdcard(idcard);
                    userBank.setAccount(account);
                    userBank.setBankName(bankName);
                    userBank.setSubbranchName(subbranchName);
                    userBank.setPhoneNum(phoneNum);
                    userBank.setCreateUser("userid:"
                            + ebUser.getUserId().toString());
                    userBank.setCreateTime(nowtime);
                    userBank.setModifyUser("userid:"
                            + ebUser.getUserId().toString());
                    userBank.setModifyTime(nowtime);
                    pmUserBankService.save(userBank);
                    map.put("code", "00");
                    map.put("msg", "添加银行卡成功！");
                    return map;
                } else {
                    map.put("code", "01");
                    map.put("msg", json.get("msg").toString());
                    return map;
                }
            }

        }

        return map;
    }
}
