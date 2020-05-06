package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.BaseDao;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbProductCharging;
import com.jq.support.model.product.EbShopCharging;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.EbProductChargingService;
import com.jq.support.service.merchandise.product.EbShopChargingService;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 门店端的加料 controller
 */
@RequestMapping("${adShopPath}/ebShopCharging")
@Controller
public class EbShopChargingController extends BaseController {
    @Autowired
    private EbShopChargingService ebShopChargingService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private PmShopInfoService pmShopInfoService;

    @RequestMapping(value = {"","index"})
    public String list(HttpServletResponse response , HttpServletRequest request , Model model,
                       EbProductCharging ebProductCharging , String chargingIds){
        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        Integer shopId = ebUser.getShopId();
        PmProductType pmProductType=pmProductTypeService.getID(ebProductCharging.getProductTypeId());
        //查询当前分类对于当前商家是否可用
        boolean available = pmProductTypeService.isAvailable(shopId, pmProductType);
        List<Object> allList = ebShopChargingService.getList(ebProductCharging, new Page<Object>(request, response),
                shopId);

        Page<Object> page = new Page<Object>();
        if(allList != null && allList.size() == 3){
            page = (Page<Object>) allList.get(0);
            List<EbProductCharging> ebProductChargingList = (List<EbProductCharging>)allList.get(1);
            List<EbShopCharging> ebShopChargingList = (List<EbShopCharging>)allList.get(2);

            model.addAttribute("ebProductChargingList",ebProductChargingList);
            model.addAttribute("ebShopChargingList",ebShopChargingList);
        }

        model.addAttribute("page",page);
        model.addAttribute("shopId",shopId);
        model.addAttribute("available",available);
        model.addAttribute("pmProductType",pmProductType);
        model.addAttribute("ebProductCharging",ebProductCharging);
        model.addAttribute("chargingIds",chargingIds);

        return "modules/shop/chargingList";
    }

    /**
     * 修改加料的成本
     */
    @ResponseBody
    @RequestMapping(value = "updateCost")
    public Map<String,String> updateCost(EbShopCharging ebShopCharging , Model model){
        boolean result = ebShopChargingService.updateCost(ebShopCharging);

        Map<String,String> map = new HashMap();
        map.put("code",result?"1":"0");

        return map;
    }


    /**
     * 跳转到增加或者修改页面
     * @param ebProductCharging
     * @param model
     * @return
     */
    @RequestMapping(value = "form")
    public String form(EbProductCharging ebProductCharging,Integer typeId, Model model,HttpServletRequest request){

        //防止通过链接跳转
        if(typeId == null){
            addMessage(model,"分类id不能为空");
        }


        //前往修改页面前，查询加料信息
        if(ebProductCharging.getId() != null){
            ebProductCharging = ebProductChargingService.getById(ebProductCharging.getId());
        }

        PmProductType pmProductType = null;
        if(typeId != null){
            pmProductType = pmProductTypeService.getID(typeId);
        }

        model.addAttribute("pmProductType",pmProductType);
        model.addAttribute("ebProductCharging",ebProductCharging);
        return "modules/shop/ebProductChargingForm";
    }

    /**
     * 增加加料
     * @param ebProductCharging
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "save" ,  method = RequestMethod.POST)
    public String save(EbProductCharging ebProductCharging,HttpServletRequest request, Model model, RedirectAttributes redirectAttributes){

        String []promptArr = {"增加成功!" , "增加失败！" , "加料名字已经存在！", "标签名已经存在！","当前分类不能为当前商家所用"};
        EbUser user = (EbUser) request.getSession().getAttribute("shopuser");
        //验证提交的数据是否正确
        Integer result = validationDate(ebProductCharging,true,user);

        if(result > 0){
            addMessage(redirectAttributes, promptArr[result]);
            model.addAttribute("typeId",ebProductCharging.getProductTypeId());
            return "redirect:"+Global.getConfig("adShopPath")+"/ebShopCharging/form";
        }

        ebProductCharging.setCreateTime(new Date());
        ebProductCharging.setDel(0);
        //获得分类信息
        PmProductType pmProductType = pmProductTypeService.getID(ebProductCharging.getProductTypeId());
        ebProductCharging.setProductTypeName(pmProductType.getProductTypeName());
        ebProductCharging.setProductTypeStr(pmProductType.getProductTypeStr());

        PmShopInfo pmShopInfo = pmShopInfoService.getById(user.getShopId());
        ebProductCharging.setIsPublic(1);
        ebProductCharging.setShopName(pmShopInfo.getShopName());
        ebProductCharging.setShopId(pmShopInfo.getId());

        //保存
        result = ebProductChargingService.save(ebProductCharging);


        //插入门店加料关联信息
        EbShopCharging ebShopCharging = new EbShopCharging();
        ebShopCharging.setCost(0.0);
        ebShopCharging.setChargingId(ebProductCharging.getId());
        ebShopCharging.setSellPrice(ebProductCharging.getSellPrice());
        ebShopCharging.setShopId(pmShopInfo.getId());
        ebShopCharging.setCreateTime(new Date());
        ebShopChargingService.insert(ebShopCharging);

        addMessage(redirectAttributes, promptArr[result]);
        return "redirect:"+Global.getConfig("adShopPath")+"/ebShopCharging?productTypeId="+pmProductType.getId();
    }

    /**
     * 修改加料
     * @param ebProductCharging
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequestMapping(value = "update" , method = RequestMethod.POST)
    public String update( EbProductCharging ebProductCharging,HttpServletRequest request,
                          RedirectAttributes redirectAttributes,Model model){

        String []promptArr = {"修改成功!" , "修改失败！" , "加料名字已经存在！", "标签名已经存在！"};

        EbUser user = (EbUser) request.getSession().getAttribute("shopuser");
        //验证提交的数据是否正确
        Integer result = validationDate(ebProductCharging,true,user);

        PmShopInfo pmShopInfo = pmShopInfoService.getById(user.getShopId());
        //更新数据
        if(result == 0){
            EbProductCharging oldCharging = ebProductChargingService.getById(ebProductCharging.getId());

            oldCharging.setcName(ebProductCharging.getcName());
            oldCharging.setLable(ebProductCharging.getLable());
            oldCharging.setSellPrice(ebProductCharging.getSellPrice());
            oldCharging.setStatus(ebProductCharging.getStatus());
            result = ebProductChargingService.update(oldCharging);

            //更新关联表
            EbShopCharging ebShopCharging = ebShopChargingService.getByShopIdAndChargingId(pmShopInfo.getId(), oldCharging.getId());
            if(ebShopCharging != null){
                ebShopCharging.setSellPrice(oldCharging.getSellPrice());
                ebShopChargingService.update(ebShopCharging);
            }

        }

        addMessage(redirectAttributes, promptArr[result]);
        return "redirect:"+Global.getConfig("adShopPath")+"/ebShopCharging/form?id="+ebProductCharging.getId()+"&typeId="+ebProductCharging.getProductTypeId();

    }


    /**
     * 验证数据的正确性
     * @param ebProductCharging
     * @param isAdd
     * @return
     */
    public Integer validationDate(EbProductCharging ebProductCharging , Boolean isAdd,EbUser user ){

        /**
         * 验证加料名是否重复
         */
        if(!ebProductChargingService.validationRepeat(ebProductCharging,isAdd,true)){
            return 2;
        }

        /**
         * 验证标签名是否重复
         */
        if(!ebProductChargingService.validationRepeat(ebProductCharging,isAdd,false)){
            return 3;
        }

        /**
         * 验证门店信息*/
        PmShopInfo pmShopInfo = pmShopInfoService.getById(user.getShopId());
        if(pmShopInfo == null){
            return 1;
        }

        /**
         * 验证当前加料所属的分类是否可为当前商家所用
         */
        PmProductType pmProductType = pmProductTypeService.getID(ebProductCharging.getProductTypeId());
        if(pmProductType != null && !pmProductTypeService.isAvailable(pmShopInfo.getId() , pmProductType)){
            return 4;
        }


        return 0;
    }
}
