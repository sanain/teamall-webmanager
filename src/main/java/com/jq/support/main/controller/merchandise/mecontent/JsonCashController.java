package com.jq.support.main.controller.merchandise.mecontent;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jq.support.common.interceptor.model.JPostMode;
import com.jq.support.common.web.BaseController;
import com.jq.support.jsoncode.JsonCashCode;
import com.jq.support.service.JsonCashService;
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
 * 收银端访问接口
 */

@Controller
@RequestMapping("/jsonCash")
public class JsonCashController extends BaseController {
    //收银端日志
    private static Log logger = LogFactory.getLog("Cashjson");
    @Autowired
    private JsonCashService jsonService;

    @RequestMapping(value = "/index")
    @ResponseBody
    public String index(HttpServletRequest request, HttpServletResponse response) {
        String contenthtm = request.getParameter("content");// 内容
        logger.info(contenthtm);
        ObjectMapper mapper = new ObjectMapper();
        String strRet = null;
        try {
            JPostMode jpost = mapper.readValue(contenthtm, JPostMode.class);
            JsonCashCode code = JsonCashCode.valueOf(jpost.getHead().getCode());
            try {
                switch (code) {
                    case Login://登陆(1000)
                        strRet = jsonService.Login(jpost, request);
                        break;
                    case GetPmShopInfo://获取门店信息
                        strRet = jsonService.GetPmShopInfo(jpost, request);
                        break;
                    case GetPmShopProductTypeList://根据门店ID获取该门店下的商品分类
                        strRet = jsonService.GetPmShopProductTypeList(jpost);
                        break;
                    case GetProductListByShopIdAndTypeId://根据门店ID和分类id获取该门店下的商品
                        strRet = jsonService.GetProductListByShopIdAndTypeId(jpost);
                        break;
                    case GetProductInfo://商品详情
                        strRet = jsonService.GetProductInfo(jpost);
                        break;
                    case GetStandardList://商品规格
                        strRet = jsonService.GetStandardList(jpost);
                        break;
                    case VerifyPaycode://验证用户会员付款码是否失效，并返回用户信息
                        strRet = jsonService.VerifyPaycode(jpost);
                        break;
                    case AddShoppingcarts://批量添加商品到购物车
                        strRet = jsonService.AddShoppingcarts(jpost);
                        break;
                    case EbPutshoppingcartList://获取门店挂单列表
                        strRet = jsonService.EbPutshoppingcartList(jpost);
                        break;
                    case ShoppingcartByPutIdList://挂单购物车list
                        strRet = jsonService.ShoppingcartByPutIdList(jpost);
                        break;
                    case GetShoppingEbUser://获取门店下单用户信息
                        strRet = jsonService.GetShoppingEbUser(jpost, request);
                        break;
                    case DelEbPutshoppingcart://删除挂单信息
                        strRet = jsonService.DelEbPutshoppingcart(jpost);
                        break;
                    case CreateOrderProduct://门店生成商品订单
                        strRet = jsonService.CreateOrderProduct(jpost,request);
                        break;
                    case ShopOrderList://门店订单List
                        strRet = jsonService.ShopOrderList(jpost);
                        break;
                    case ShopShipments://商家发货
                        strRet = jsonService.ShopShipments(jpost);
                        break;
                    case EditOrder://修改订单
                        strRet = jsonService.EditOrder(jpost);
                        break;
                    case ChangeShifts://交接班数据统计查询
                        strRet = jsonService.ChangeShifts(jpost);
                        break;
                    case ChangeShiftsProduct://交接班数据统计查询商品列表
                        strRet = jsonService.ChangeShiftsProduct(jpost);
                        break;
                    case NoticeList://门店公告
                        strRet = jsonService.NoticeList(jpost);
                        break;
                    case AddOperationLog://添加门店设备操作记录
                        strRet = jsonService.AddOperationLog(jpost);
                        break;
                    case EditShoppingcart://修改购物车
                        strRet = jsonService.EditShoppingcart(jpost);
                        break;
                    case SearchProductList://商品搜索接口
                        strRet = jsonService.SearchProductList(jpost);
                        break;
                    case ServicePay://余额支付，微信支付，银联支付，支付宝支付调用接口
                        strRet = jsonService.ServicePay(jpost,request);
                        break;
                    case GetTictet://获取小票信息
                        strRet = jsonService.GetTictet(jpost);
                        break;
                    case PayType://支付方式
                        strRet = jsonService.PayType(jpost);
                        break;
                    case GetSticker://获取杯面贴纸
                        strRet = jsonService.GetSticker(jpost);
                        break;
                    case GetShopUserList://获取店铺人员列表
                    	strRet = jsonService.GetShopUserList(jpost);
                    	break;
                    case GetTictetRecord://获取交接班，销售清单小票信息
                        strRet = jsonService.GetTictetRecord(jpost);
                        break;
                    case GetEbAadvertisement://获取门店广告投放
                        strRet = jsonService.GetEbAdvertisement(jpost);
                        break;
                    case GetEbOrder://获取订单详情接口
                        strRet = jsonService.GetEbOrder(jpost);
                        break;
                    case ShopOrderCount://门店未发货未读订单数量
                        strRet = jsonService.ShopOrderCount(jpost);
                        break;
                    case Version: // 版本号
                        strRet = jsonService.Version(jpost);
                        break;
                    case ShopOrderState://更改门店未发货未读订单数量状态
                        strRet = jsonService.ShopOrderState(jpost);
                        break;
                    case GetSmallTicketRecord://获取销售清单小票信息
                        strRet = jsonService.GetSmallTicketRecord(jpost);
                        break;
                    case isPrint://更改订单已打印了小票
                        strRet = jsonService.isPrint(jpost);
                        break;
                    case GetShopStatistics://获取店铺交接班记录
                    	strRet = jsonService.GetShopStatistics(jpost);
                    	break;
                    case GetOffLineProductInfo://获取离线商品信息
                    	strRet = jsonService.GetOffLineProductInfo(jpost);
                    	break;
                    case UpOffLineProductInfOrder://上传离线商品订单
                    	strRet = jsonService.UpOffLineProductInfOrder(jpost);
                    	break;
                    case GetOffLineEbTicket://获取离线小票模板
                    	strRet = jsonService.GetOffLineEbTicket(jpost);
                    	break;
                    case GetPromotionList://获取促销活动列表
                        strRet = jsonService.GetPromotionList(jpost);
                        break;
                    case GetDayTictetRecord://获取营业日报小票信息
                        strRet = jsonService.GetDayTictetRecord(jpost);
                        break;
                    case GetSysSource:  //  根据位置id获取系统资源
                        strRet = jsonService.GetSysSource(jpost);
                        break;
                    case GetOffLineShopData:// 获取离线店铺数据
                    	strRet=jsonService.GetOffLineShopData(jpost);
                    	break;
                    case GetOffLineChargingInfo://获取离线加料数据
                    	strRet=jsonService.GetOffLineChargingInfo(jpost);
                    	break;
                    case isTakeMeals://自动提示取餐并确认订单接口
                        strRet = jsonService.isTakeMeals(jpost);
                        break;
                    case GetEbOrderById://获取订单详情接口
                        strRet = jsonService.GetEbOrderbById(jpost);
                        break;
                    case EbOrderRefund://订单退款
                        strRet = jsonService.EbOrderRefund(jpost);
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