package com.jq.support.main.controller.merchandise.product;

import com.alipay.util.httpClient.HttpResponse;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.*;
import com.jq.support.service.merchandise.product.EbProductChargingService;
import com.jq.support.service.merchandise.product.EbShopChargingService;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.utils.ChineseCharacterUtil;
import com.jq.support.service.utils.FormatUtil;
import com.jq.support.service.utils.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.Choose;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 商品加料
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/EbProductCharging")
public class EbProductChargingController extends BaseController {
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private PmProductTypeService pmProductTypeService;
    @Autowired
    private EbShopChargingService ebShopChargingService;
    @Autowired
    private PmShopInfoService pmShopInfoService;

    /**
     * 调用如何方法之前都会先调用该方法
     * 更新id查询记录
     * @param id
     * @return
     */
    @ModelAttribute
    public  EbProductCharging get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return ebProductChargingService.getEbadAdvertisement(id);
        }else{
            return new  EbProductCharging();
        }
    }

    /**
     * 条件分页查询
     * @param ebProductCharging
     * @param createTime
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:EbProductCharging:view")
    @RequestMapping(value = {"list", ""})
    public String list(EbProductCharging ebProductCharging,String createTime,
            HttpServletRequest request, HttpServletResponse response, Model model){

        Page<EbProductCharging> page=ebProductChargingService.getPageList(new Page<EbProductCharging>(request, response),ebProductCharging,createTime);

        model.addAttribute("createTime", createTime);
        model.addAttribute("page", page);
        model.addAttribute("ebProductCharging", ebProductCharging);
        return "modules/shopping/brands/ebProductChargingList";
    }

    /**
     * 跳转到增加或者修改页面
     * @param ebProductCharging
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:EbProductCharging:edit")
    @RequestMapping(value = "form")
    public String form(EbProductCharging ebProductCharging, Model model){

        //增加页面默认选中平台使用
        if(ebProductCharging.getId() == null){
            ebProductCharging.setIsPublic(0);
        }

        PmProductType pmProductType = null;
        if(ebProductCharging.getProductTypeId() != null){
            pmProductType = pmProductTypeService.getID(ebProductCharging.getProductTypeId());
        }

        model.addAttribute("pmProductType",pmProductType);
        model.addAttribute("ebProductCharging",ebProductCharging);
        return "modules/shopping/brands/ebProductChargingFrom";
    }

    /**
     * 增加标签
     * @param ebProductCharging
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:EbProductCharging:edit")
    @RequestMapping(value = "save" ,  method = RequestMethod.POST)
    public String save(EbProductCharging ebProductCharging, Model model,RedirectAttributes redirectAttributes){

        String []promptArr = {"增加成功!" , "增加失败！" , "加料名字已经存在！", "标签名已经存在！"};
        PmProductType pmProductType = pmProductTypeService.getID(ebProductCharging.getProductTypeId());

        ebProductCharging.setCreateTime(new Date());
        ebProductCharging.setDel(0);
        ebProductCharging.setProductTypeName(pmProductType.getProductTypeName());
        //由汉字生成拼音
        ebProductCharging.setPyName(ChineseCharacterUtil.convertHanzi2Pinyin(ebProductCharging.getcName(),false).toLowerCase()); 
        ebProductCharging.setProductTypeStr(pmProductType.getProductTypeStr());

        //验证提交的数据是否正确
        Integer result = validationDate(ebProductCharging,true);

        //保存到数据库中
        if(result == 0){
            result = ebProductChargingService.save(ebProductCharging);
        }

        if(result > 0){
            addMessage(redirectAttributes, promptArr[result]);
            model.addAttribute("productType",pmProductType);
            return "redirect:"+Global.getAdminPath()+"/EbProductCharging/form?productTypeId="+pmProductType.getId();
        }

        //插入门店加料关联信息
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
        for(PmShopInfo pmShopInfo : allShop){
            EbShopCharging ebShopCharging = new EbShopCharging();
            ebShopCharging.setCost(0.0);
            ebShopCharging.setChargingId(ebProductCharging.getId());
            ebShopCharging.setSellPrice(ebProductCharging.getSellPrice());
            ebShopCharging.setShopId(pmShopInfo.getId());
            ebShopCharging.setCreateTime(new Date());
            ebShopChargingService.insert(ebShopCharging);
        }

        //把需要返回前端的数据放入redirectAttributes中
        addMessage(redirectAttributes, promptArr[result]);
        return "redirect:"+Global.getAdminPath()+"/EbProductCharging/list?productTypeId="+pmProductType.getId();
    }

    /**
     * 更新商品加料
     * @param ebProductCharging
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequiresPermissions("merchandise:EbProductCharging:edit")
    @RequestMapping(value = "update" , method = RequestMethod.POST)
    public String update( EbProductCharging ebProductCharging,
                          RedirectAttributes redirectAttributes,Model model){

        String []promptArr = {"修改成功!" , "修改失败！" , "加料名字已经存在！", "标签名已经存在！"};


        //验证提交的数据是否正确
        Integer result = validationDate(ebProductCharging,false);

        //更新数据
        if(result == 0){
            EbProductCharging oldCharging = ebProductChargingService.getById(ebProductCharging.getId());

            oldCharging.setcName(ebProductCharging.getcName());
            oldCharging.setPyName(ChineseCharacterUtil.convertHanzi2Pinyin(ebProductCharging.getcName(),false).toLowerCase());
            oldCharging.setLable(ebProductCharging.getLable());
            oldCharging.setSellPrice(ebProductCharging.getSellPrice());
            oldCharging.setStatus(ebProductCharging.getStatus());

            oldCharging.setShopId(ebProductCharging.getShopId());
            oldCharging.setShopName(ebProductCharging.getShopName());
            oldCharging.setIsPublic(ebProductCharging.getIsPublic());

            result = ebProductChargingService.update(oldCharging);
        }

        addMessage(redirectAttributes, promptArr[result]);
        return "redirect:"+Global.getAdminPath()+"/EbProductCharging/form?id="+ebProductCharging.getId()+"&productTypeId="+ebProductCharging.getProductTypeId();

    }

    /**
     * 删除标签
     * @param ebProductCharging
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:EbProductCharging:edit")
    @RequestMapping(value = "delete")
    public String delete(
            EbProductCharging ebProductCharging,
            HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){

        ebProductChargingService.delete(ebProductCharging);
        //删除门店加料关联表的信息
        ebShopChargingService.deleteByChargingId(ebProductCharging.getId());

        addMessage(redirectAttributes, "删除成功");
        PmProductType pmProductType = pmProductTypeService.getID(ebProductCharging.getProductTypeId());
        return "redirect:"+Global.getAdminPath()+"/EbProductCharging/list?productTypeId="+ebProductCharging.getProductTypeId();
    }


    /**
     * 查询指定分类的所有标签
     * @param ebProductCharging
     * @param createTime    创建的时间
     * @param chooseIds     已经选中的加料id
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "chooseProductCharging")
    public String chooseProductCharging(
            EbProductCharging ebProductCharging,String createTime,String chooseIds,
            HttpServletRequest request, HttpServletResponse response, Model model){
        List<String> cNames = new ArrayList<String>();
        List<String> sellPrices = new ArrayList<String>();
        List<String> lables = new ArrayList<String>();

        Page<EbProductCharging> page=ebProductChargingService.getPageList(new Page<EbProductCharging>(request, response),ebProductCharging,createTime);

        //根据id查询加料名等信息
        if(StringUtil.isNotBlank(chooseIds)) {
            String[] ids = chooseIds.split(",");
            for (int i = 0; i < ids.length; i++) {
                EbProductCharging charging = ebProductChargingService.getById(Integer.parseInt(ids[i]));
                if(charging != null){
                    cNames.add(charging.getcName());
                    sellPrices.add(charging.getSellPrice()+"");
                    lables.add(charging.getLable());
                }
            }

            model.addAttribute("cNames",cNames.toString().replace("[","").replace("]",""));
            model.addAttribute("sellPrices",sellPrices.toString().replace("[","").replace("]",""));
            model.addAttribute("lables",lables.toString().replace("[","").replace("]",""));
        }

        model.addAttribute("createTime", createTime);
        model.addAttribute("page", page);
        model.addAttribute("ebProductCharging", ebProductCharging);
        model.addAttribute("chooseIds", chooseIds);
        return "modules/shopping/brands/chooseProductCharging";
    }


    /**
     * 一键所有
     * @return
     */
    @ResponseBody
    @RequestMapping("chooseAll")
    public Map<String,String> chooseAll(EbProductCharging ebProductCharging,String createTime){
        Map<String,String> map = new HashMap<String, String>();

        Page<EbProductCharging> page=ebProductChargingService.getPageList(new Page<EbProductCharging>(1, Integer.MAX_VALUE),ebProductCharging,createTime);;

        String chooseIds = FormatUtil.getFieldAllValue(page.getList(), "id");
        String cNames = FormatUtil.getFieldAllValue(page.getList(), "cName");
        String sellPrices = FormatUtil.getFieldAllValue(page.getList(), "sellPrice");
        String lables = FormatUtil.getFieldAllValue(page.getList(), "lable");


        map.put("chooseIds",chooseIds);
        map.put("cNames",cNames);
        map.put("sellPrices",sellPrices);
        map.put("lables",lables);

        return map;
    }

    /**
     * 更新加料的状态
     * @param chargingStatus
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateStatus")
    public String updateStatus(Integer chargingStatus , Integer chargingId){

        boolean result=ebProductChargingService.updateStatus(chargingStatus ,chargingId);

       if(result){
           return "success";
        }
        return "error";
    }

    /**
     * 验证数据的正确性
     * @param ebProductCharging
     * @param isAdd
     * @return
     */
    public Integer validationDate(EbProductCharging ebProductCharging , Boolean isAdd){

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

        return 0;
    }
}
