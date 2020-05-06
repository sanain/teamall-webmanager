package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.product.PmServiceProtocol;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.PmShopSettlement;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.model.user.PmUserBank;
import com.jq.support.service.merchandise.mecontent.PmServiceProtocolService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.shop.PmShopSettlementService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.merchandise.user.PmUserBankService;
import com.jq.support.service.merchandise.user.PmUserSmsCodeService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.utils.CommonUtils;
import com.jq.support.service.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 收支明细
 */
@Controller
@RequestMapping(value = "${adShopPath}/shopPmAmtLog")
public class ShopPmAmtLogController extends BaseController {
    private static String domainurl = Global.getConfig("domainurl");
    private static String domain = Global.getConfig("domain");
    private static String innerImgPartPath = "src=\"/uploads";
    private static String innerImgPartPath_1 = "src=\"/" + domain + "/uploads";
    private static String innerImgFullPath = "src=\"" + domainurl + "/uploads";
    @Autowired
    private PmAmtLogService pmAmtLogService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private EbUserService ebUserService;
    @Autowired
    private PmUserBankService pmUserBankService;
    @Autowired
    private PmUserSmsCodeService pmUserSmsCodeService;
    @Autowired
    private EbMessageService ebMessageService;
    @Autowired
    private PmShopSettlementService pmShopSettlementService;
    @Autowired
    private PmServiceProtocolService pmServiceProtocolService;
    /**
     * 收支明细列表
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("list")
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String amt = request.getParameter("amt");
        String amtType = request.getParameter("amtType");
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
                        response));
        model.addAttribute("page", page);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("amt", amt);
        model.addAttribute("amtType", amtType);
        return "modules/shop/pmAmtLogList";
    }

    /**
     * 提现申请
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("form")
    public String form(HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        ebUser = ebUserService.getEbUser(ebUser.getUserId() + "");
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId() + "");
        PmUserBank pmUserBank = new PmUserBank();
        pmUserBank.setIsdelete(0);
        pmUserBank.setBankType(0);
        pmUserBank.setUserId(ebUser.getUserId());
        List<PmUserBank> pmUserBanks = pmUserBankService.getPmUserBankList(pmUserBank);
        model.addAttribute("currentAmt", ebUser.getCurrentAmt());//当前余额
        model.addAttribute("shopName", pmShopInfo.getShopName());//门店名称
        model.addAttribute("pmUserBanks", pmUserBanks);//银行卡列表
        return "modules/shop/pmAmtLogForm";
    }
    /**
     * 门店结算
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("index")
    public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        ebUser = ebUserService.getEbUser(ebUser.getUserId() + "");
        PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopId() + "");
        PmShopSettlement pmShopSettlement=pmShopSettlementService.getPmShopSettlementByshopId(pmShopInfo.getId());
        model.addAttribute("currentAmt", ebUser.getCurrentAmt());//当前余额
        model.addAttribute("cashWithdrawalAmt", ebUser.getCashWithdrawalAmt());//已提现金额
        model.addAttribute("shopName", pmShopInfo.getShopName());//门店名称
        model.addAttribute("pmShopSettlement", pmShopSettlement);//总览信息

        return "modules/shop/pmAmtLogIndex";
    }


    /**
     * 门店结算
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("hint")
    public String hint(HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        ebUser = ebUserService.getEbUser(ebUser.getUserId() + "");
        PmServiceProtocol pmServiceProtocol=pmServiceProtocolService.getSbServiceProtocolCode("18");
        if(pmServiceProtocol!=null&&StringUtils.isNotBlank(pmServiceProtocol.getContentInfo())) {
            String contentView = pmServiceProtocol.getContentInfo();
            contentView = htmltoUrl(contentView);
            pmServiceProtocol.setContentView(contentView);
        }

        model.addAttribute("pmServiceProtocol",pmServiceProtocol);//当前余额

        return "modules/shop/hint";
    }


    public String htmltoUrl(String html) {
            String wfsName = Global.getConfig("wfsName");
        if (StringUtils.isNotBlank(wfsName)) {
            innerImgPartPath = innerImgPartPath + "/" + wfsName;
            innerImgPartPath_1 = innerImgPartPath_1 + "/" + wfsName;
        }
        if (StringUtils.contains(html, innerImgPartPath)) {
            html = html.replace(innerImgPartPath, innerImgFullPath);
        }
        if (StringUtils.contains(html, innerImgPartPath_1)) {
            html = html.replace(innerImgPartPath_1, innerImgFullPath);
        }

        return html;
    }

    /**
     * 申请提现
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping("applyToCash")
    public Map applyToCash(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        Map map = new HashMap();//返回错误信息
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        ebUser = ebUserService.getEbUser(ebUser.getUserId() + "");
        String bankCardId = request.getParameter("bankCardId");// 银行卡
        String payPassword = request.getParameter("payPassword");// 支付密码(md5加密)
        String amt = request.getParameter("amt");
        if (StringUtils.isBlank(payPassword)) {
            map.put("code", "01");
            map.put("msg", "参数错误，支付密码不能为空！");
            return map;
        } else if (StringUtils.isBlank(bankCardId)) {
            map.put("code", "01");
            map.put("msg", "参数错误，银行卡ID不能为空！");
            return map;
        } else if (StringUtils.isBlank(amt)) {
            map.put("code", "01");
            map.put("msg", "参数错误，提现金额不能为空！");
            return map;
        } else if (pmUserBankService.isNumeric(amt) == false || Integer.parseInt(amt) < 0 || Integer.parseInt(amt) == 0 || Integer.parseInt(amt) % 100 != 0) {
            map.put("code", "01");
            map.put("msg", "提现金额错误，提现金额需是100的整数倍！");
            return map;
        }else if (ebUser.getCurrentAmt() - Double.parseDouble(amt) < 0) {
            map.put("code", "01");
            map.put("msg", "提现金额不能大于当前余额！");
            return map;
        }
        payPassword= Md5Encrypt.getMD5Str(payPassword).toLowerCase();
        if (!ebUser.getPassword().equals(payPassword)) {
            map.put("code", "01");
            map.put("msg", "提现密码错误！");
            return map;
        }
        PmUserBank userBank = pmUserBankService.findid(Integer
                .valueOf(bankCardId));
        if (userBank == null) {
            map.put("code", "01");
            map.put("msg", "银行卡不存在！");
            return map;
        }

        PmAmtLog pmAmtLog = new PmAmtLog();
        pmAmtLog.setUserId(ebUser.getUserId());
        List<PmAmtLog> pmAmtLogs = pmAmtLogService.getpmAmtList(pmAmtLog);
        if (pmAmtLogs != null && pmAmtLogs.size() > 0) {
            long min = pmUserSmsCodeService.getDistanceTimes(DateUtil
                    .getDateFormat(pmAmtLogs.get(0).getCreateTime(),
                            "yyyy-MM-dd HH:mm:ss"), DateUtil.getDateFormat(
                    new Date(), "yyyy-MM-dd HH:mm:ss"));
            if (min < 2) {
                map.put("code", "01");
                map.put("msg", "不能频繁提现，两分钟后再试！");
                return map;
            }
        }

        PmAmtLog amtLog = pmAmtLogService.saveWithdrawDeposit(amt,
                ebUser, userBank);
        if (amtLog != null) {
            String img = "/uploads/drawable-xhdpi/sjzs.png";
            EbUser userMsg = ebUserService.getShop("1");
            EbMessage eMessage = new EbMessage();
            eMessage.setCreateTime(new Date());
            eMessage.setCreateUser("系统");
            eMessage.setMessageAbstract("提现提醒");// 简介
            eMessage.setMessageTitle("有新的提现订单，请查看！");// 标题
            eMessage.setMessageClass(3);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
            eMessage.setMessageContent("有新的提现订单，请及时查看！");// 内容
            eMessage.setMessageAbstract("提现提醒");// 简介
            eMessage.setMessageIcon(img);
            eMessage.setMessageObjId(amtLog.getId());
            eMessage.setMessageType(11);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
            // 结算提醒；8、退货/售后提醒；9、系统公告；10、发货通知；11、提现通知
            eMessage.setReceiverType(4);// 发送类型：1.所有用户;2.所有商家;3.所有买家;4.指定用户;5、指定代理；6、所有代理；
            eMessage.setSendUserIds(userMsg.getUserId().toString());// 接受用户id
            eMessage.setIsRead(0);
            ebMessageService.saveflush(eMessage);

            String smsmsg = "有新的提现订单，请尽快处理！";
            PmShopInfo pmShopInfo = pmShopInfoService
                    .getpmPmShopInfo("1");
            if (StringUtils.isNotBlank(pmShopInfo.getMsgPhone())) {
                String[] phone = pmShopInfo.getMsgPhone().split(",");
                for (int i = 0; i < phone.length; i++) {
                    boolean flag = CommonUtils
                            .sendMsg(phone[i], smsmsg);
                    if (flag) {
                        System.out.println("Key = " + phone[i]
                                + ", Value =短信发送成功 ");
                    } else {
                        System.out.println("Key = " + phone[i]
                                + ", Value =短信发送失败 ");
                    }
                }
            }
            map.put("code", "00");
            map.put("msg", "提交提现申请成功！");
        } else {
            map.put("code", "01");
            map.put("msg", "提现异常，请联系客服！");
        }

        return map;
    }
    /**
     *申请提现列表
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("applyToCashlist")
    public String applyToCashlist(HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");

        PmAmtLog pmAmtLog = new PmAmtLog();
        pmAmtLog.setUserId(ebUser.getUserId());
         pmAmtLog.setAmtType(Integer.valueOf(4));
        Page<PmAmtLog> page = pmAmtLogService.findPmAmtLogList("", "",
                "", "", "", pmAmtLog, new Page<PmAmtLog>(request,
                        response));
        model.addAttribute("page", page);
        return "modules/shop/applyToCashList";
    }

}
