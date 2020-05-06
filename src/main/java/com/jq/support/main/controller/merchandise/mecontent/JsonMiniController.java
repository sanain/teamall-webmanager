package com.jq.support.main.controller.merchandise.mecontent;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jq.support.common.interceptor.model.JPostMode;
import com.jq.support.common.web.BaseController;
import com.jq.support.jsoncode.JsonMiniCode;
import com.jq.support.service.JsonMiniService;
import com.jq.support.service.JsonService;
import com.jq.support.service.common.PcUserLoginException;
import com.jq.support.service.common.ServiceException;
import com.jq.support.service.common.UserLoginException;
import com.jq.support.service.common.UserStatusException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 小程序访问接口
 */

@Controller
@RequestMapping("/jsonMini")
public class JsonMiniController extends BaseController {
    //小程序日志
    private static Log logger = LogFactory.getLog("Minijson");
    @Autowired
    private JsonMiniService jsonService;

    @RequestMapping(value = "/index")
    @ResponseBody
    public String index(HttpServletRequest request, HttpServletResponse response) {
        String contenthtm = request.getParameter("content");// 内容
        logger.info(contenthtm);
        ObjectMapper mapper = new ObjectMapper();
        String strRet = null;
        try {
            JPostMode jpost = mapper.readValue(contenthtm, JPostMode.class);
            JsonMiniCode code = JsonMiniCode.valueOf(jpost.getHead().getCode());
            try {
                switch (code) {
                    case WxJsCode://微信获取code
                        strRet = jsonService.WxJsCode(jpost, request);
                        break;
                    case Login://登陆(1001)
                        strRet = jsonService.Login(jpost, request);
                        break;
                    case GetEbUser://获取用户信息
                        strRet = jsonService.GetEbUser(jpost, request);
                        break;
                    case GetDefaultPmShopInfo://获取默认门店
                        strRet = jsonService.GetDefaultPmShopInfo(jpost, request);
                        break;
                    case GetPmShopInfoList://获取门店列表
                        strRet = jsonService.GetPmShopInfoList(jpost, request);
                        break;
                    case GetPmShopProductTypeList://根据门店ID获取该门店下的商品分类
                        strRet = jsonService.GetPmShopProductTypeList(jpost);
                        break;
                    case GetEbUseraddressList://获取收货地址列表
                        strRet = jsonService.GetEbUseraddressList(jpost);
                        break;
                    case DelectEbUseraddress://删除收货地址
                        strRet = jsonService.DelectEbUseraddress(jpost);
                        break;
                    case EditEbUseraddress://编辑用户收货地址
                        strRet = jsonService.EditEbUseraddress(jpost);
                        break;
                    case GetEbUseraddress://获取单个地址信息
                        strRet = jsonService.GetEbUseraddress(jpost);
                        break;
                    case GetShoppingcartList://购物车list
                        strRet = jsonService.GetShoppingcartList(jpost);
                        break;
                    case AddShoppingcart://添加商品到购物车
                        strRet = jsonService.AddShoppingcart(jpost);
                        break;
                    case EditShoppingcart://修改购物车
                        strRet = jsonService.EditShoppingcart(jpost);
                        break;
                    case ClearShoppingcart://清空购物车
                        strRet = jsonService.ClearShoppingcart(jpost);
                        break;
                    case GetProductInfo://商品详情
                        strRet = jsonService.GetProductInfo(jpost);
                        break;
                    case GetStandardList://商品规格
                        strRet = jsonService.GetStandardList(jpost);
                        break;
                    case EbCertificateUserEnabledCount://获取用户下单时可用的优惠券数量
                        strRet = jsonService.EbCertificateUserEnabledCount(jpost);
                        break;
                    case EbCertificateUserList://获取用户优惠券列表
                        strRet = jsonService.EbCertificateUserList(jpost);
                        break;
                    case PayType://支付方式
                        strRet = jsonService.PayType(jpost);
                        break;
                    case CreateOrder://生成订单
                        strRet = jsonService.CreateOrder(jpost,request);
                        break;
                    case ServicePay://余额支付，微信支付，银联支付，支付宝支付调用接口
                        strRet = jsonService.ServicePay(jpost,request);
                        break;
                    case EbUserDataUpdate://修改用户信息
                        strRet = jsonService.EbUserDataUpdate(jpost,request);
                        break;
                    case SmsCode: //发送验证码
                        strRet = jsonService.SmsCode(jpost);
                        break;
                    case BindEbUserMobile: //绑定用户手机号
                        strRet = jsonService.BindEbUserMobile(jpost);
                        break;
                    case GetPmQaHelpList://获取问答帮助中心列表
                        strRet = jsonService.getPmQaHelpList(jpost);
                        break;
                    case OrderList://订单列表
                        strRet = jsonService.orderList(jpost);
                        break;
                    case OrderDetails://订单详情
                        strRet = jsonService.orderDetails(jpost);
                        break;
                    case AddPmUserFeedback://添加意见反馈
                        strRet = jsonService.addPmUserFeedback(jpost,request);
                        break;
                    case EbUserMessageList://获取用户消息列表
                        strRet = jsonService.EbUserMessageList(jpost);
                        break;
                    case EbUserAmtLogList://获取我的余额明细列表
                        strRet = jsonService.EbUserAmtLogList(jpost);
                        break;
                    case IsOpenEbUserMonny://是否开通钱包
                        strRet = jsonService.IsOpenEbUserMonny(jpost,request);
                        break;
                    case PmProtocol://平台服务协议
                        strRet = jsonService.PmProtocol(jpost);
                        break;
                    case EbUserPaycode://获取用户会员付款码
                        strRet = jsonService.EbUserPaycode(jpost);
                        break;
                    case EditOrder://修改订单
                        strRet = jsonService.EditOrder(jpost);
                        break;
                    case ShoppingCartProductFreight://购物车按照价格运费计算
                        strRet = jsonService.ShoppingCartProductFreight(jpost);
                        break;
                    case UpdateImg: //图片上传接口
                        strRet=jsonService.UpdateImg(jpost,request);
                        break;
                    case ShoppingNumber: //获取店铺前面还有多少个人在排队
                        strRet=jsonService.ShoppingNumber(jpost,request);
                        break;
                    case EbUserPayPassword://设置支付密码
                        strRet = jsonService.EbUserPayPassword(jpost);
                        break;
                    case EbUserPassWordUpdate://修改支付或登录密码
                        strRet = jsonService.EbUserPassWordUpdate(jpost);
                        break;
                    case EbUserPassWordFind://短信找回支付或登录密码
                        strRet = jsonService.EbUserPassWordFind(jpost);
                        break;
                    case SearchProductList://商品搜索接口
                        strRet = jsonService.SearchProductList(jpost);
                        break;
                    case CreateOrderProduct://生成商品订单
                        strRet = jsonService.CreateOrderProduct(jpost,request);
                        break;
                    case AddShoppingcarts://批量添加商品到购物车
                        strRet = jsonService.AddShoppingcarts(jpost);
                        break;
                    case DelEbPutshoppingcart://删除挂单信息
                        strRet = jsonService.DelEbPutshoppingcart(jpost);
                        break;
                    case GetEbPutshoppingcart://获取用户门店挂单信息
                        strRet = jsonService.GetEbPutshoppingcart(jpost);
                        break;
                    case CreateOrderRecharge://创建充值订单
                        strRet = jsonService.CreateOrderRecharge(jpost,request);
                        break;
                    case ReceiveCertificate://领取优惠券
                        strRet = jsonService.ReceiveCertificate(jpost);
                        break;
                    case ReceiveCertificateList://获取待领取优惠券列表
                        strRet = jsonService.ReceiveCertificateList(jpost);
                        break;
                    case UnreadMessagesTotal://获取用户未读消息总数
                        strRet = jsonService.UnreadMessagesTotal(jpost);
                        break;
                    case ChangeMessageState://改变消息状态为已读接口
                        strRet = jsonService.ChangeMessageState(jpost);
                        break;
                    case GetEbJoinIn://获取加盟信息
                        strRet = jsonService.GetEbJoinIn(jpost);
                        break;
                    case GetaddressShopInfo:// 获取收货地址附近店铺
                        strRet = jsonService.GetaddressShopInfo(jpost);
                        break;
                    case GetEbShopAdvertiseList://  商家广告图片列表
                        strRet = jsonService.GetEbShopAdvertiseList(jpost);
                        break;
                    case GetSysSource:  //  根据位置id获取系统资源
                        strRet = jsonService.GetSysSource(jpost);
                        break;
                    default:
                        strRet = jsonService.CodeError("Code有错:" + code);
                        break;

                }

            } catch (SecurityException ex) {// 效验不通过
                strRet = jsonService.HeadError(ex.getMessage());
            } catch (ServiceException ex) {// 判断用户错误信息
                strRet = jsonService.userError(ex.getMessage());
            } catch (UserLoginException ex) {// 判断用户是否登录
                strRet = jsonService.loginError(ex.getMessage());
            } catch (UserStatusException ex) {// 用户禁用
                strRet = jsonService.userStatusError(ex.getMessage());
            } catch (Exception ex) {// 其它错误
                strRet = jsonService.CodeError(ex.getMessage());
            }
            logger.info("codereturn:" + strRet);

        } catch (Exception ex) {
            ex.printStackTrace();
            try {
                strRet = jsonService.HeadError(ex.getMessage());
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }

        return strRet;
    }
}