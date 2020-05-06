package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.advertisement.EbShopAdvertise;
import com.jq.support.model.advertisement.EbShopAdvertiseRemark;
import com.jq.support.model.certificate.EbCertificate;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.advertisement.EbShopAdvertiseRemarkService;
import com.jq.support.service.advertisement.EbShopAdvertiseService;
import com.jq.support.service.certificate.EbCertificateService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.utils.CkfinderFormatUtil;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.UploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 商家端的广告申请
 */
@Controller
@RequestMapping(value = "${adShopPath}/ebShopAdvertise")
public class ShopEbShopAdvertiseController {
    @Autowired
    private EbShopAdvertiseService ebShopAdvertiseService;
    @Autowired
    private EbShopAdvertiseRemarkService ebShopAdvertiseRemarkService;
    @Autowired
    private EbCertificateService ebCertificateService;
    @Autowired
    private PmShopInfoService pmShopInfoService;

    /**
     * 查看申请列表
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequestMapping(value = "applyList")
    public String applyList(HttpServletRequest request, HttpServletResponse response,
                            Model model, EbShopAdvertise ebShopAdvertise,Integer prompt){

        if(prompt != null && prompt == 1){
            model.addAttribute("prompt","操作成功");
        }else if(prompt != null && prompt == 0){
            model.addAttribute("prompt","操作失败");
        }

        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
       ebShopAdvertise.setShopId(ebUser.getShopId());
       ebShopAdvertise.setSourceType(2);

        Page<EbShopAdvertise> page = ebShopAdvertiseService.findApplyList(ebShopAdvertise, new Page<EbShopAdvertise>(request, response),null);

        model.addAttribute("page",page);

        model.addAttribute("ebShopAdvertise",ebShopAdvertise);

        return "modules/shop/advertiseApplyList";
    }


    /**
     * 查看广告列表
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequestMapping(value = "advertiseList")
    public String advertiseList(HttpServletRequest request, HttpServletResponse response,
                            Model model, EbShopAdvertise ebShopAdvertise){
        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        ebShopAdvertise.setShopId(ebUser.getShopId());
        ebShopAdvertise.setSourceType(2);
        Page<EbShopAdvertise> page = ebShopAdvertiseService.findAdvertiseByShopId(ebShopAdvertise, new Page<EbShopAdvertise>(request, response));

        model.addAttribute("page",page);
        model.addAttribute("ebShopAdvertise",ebShopAdvertise);

        return "modules/shop/advertiseList";
    }



    /**
     * 进入申请增加（或者修改）页面
     * @param request
     * @param response
     * @param model
     * @param id    广告id
     * @param flag  是否进入增加  add  增加  反之  修改
     * @param prompt    提示
     * @return
     */
    @RequestMapping(value = "applyFrom")
    public String applyFrom(HttpServletRequest request , HttpServletResponse response ,
                       Model model,Integer id , String flag,Integer prompt,String isChange){
        createPicFold(request); //创建存放文件目录


        model.addAttribute("flag",flag);

        if(prompt != null && prompt == 1){
            model.addAttribute("prompt","操作成功");
        }else if(prompt != null && prompt == 0){
            model.addAttribute("prompt","操作失败");
        }
        model.addAttribute("isChange",isChange);

//        if("add".equals(flag)){
//            return "modules/shop/advertiseFrom";
//        }

        EbShopAdvertise ebShopAdvertise = ebShopAdvertiseService.findById(id);
        if(ebShopAdvertise != null && ebShopAdvertise.getId() != null){
            String newPath = CkfinderFormatUtil.restore(ebShopAdvertise.getPic());
            ebShopAdvertise.setPic(newPath);

            if(ebShopAdvertise.getEntryTime() != null) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                ebShopAdvertise.setEntryTimeStr(dateFormat.format(ebShopAdvertise.getEntryTime()));
            }
            List<EbShopAdvertiseRemark> remarkList = ebShopAdvertiseRemarkService.getByApplyId(ebShopAdvertise.getId());
            model.addAttribute("remarkList",remarkList);
        }

        model.addAttribute("ebShopAdvertise",ebShopAdvertise);


        return "modules/shop/advertiseApplyFrom";
    }


    /**
     * 进入广告详情页面
     * @param request
     * @param response
     * @param model
     * @param id    广告id
     * @return
     */
    @RequestMapping(value = "advertiseFrom")
    public String advertiseFrom(HttpServletRequest request , HttpServletResponse response ,
                            Model model,Integer id ){

        EbShopAdvertise ebShopAdvertise = ebShopAdvertiseService.findById(id);
        if(ebShopAdvertise != null && ebShopAdvertise.getId() != null){
            String newPath = CkfinderFormatUtil.restore(ebShopAdvertise.getPic());
            ebShopAdvertise.setPic(newPath);
            List<EbShopAdvertiseRemark> remarkList = ebShopAdvertiseRemarkService.getByApplyId(ebShopAdvertise.getId());
            model.addAttribute("remarkList",remarkList);
        }

        model.addAttribute("ebShopAdvertise",ebShopAdvertise);

        return "modules/shop/advertiseFrom";
    }

    /**
     * 取消申请
     * @param request
     * @param response
     * @param model
     * @param id    广告id
     * @return
     */
    @RequestMapping(value = "cancelApply")
    public String cancelApply(HttpServletRequest request , HttpServletResponse response ,
                              Model model,Integer id){

        //失败
        if(id == null){
            model.addAttribute("prompt",0);
            return "forward:"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/applyList";
        }

        EbShopAdvertise ebShopAdvertise = new EbShopAdvertise();
        ebShopAdvertise.setApplyStatus(4);
        ebShopAdvertise.setId(id);

        boolean b = ebShopAdvertiseService.updateApplyStatus(ebShopAdvertise);

        model.addAttribute("prompt",b?1:0);

        return "forward:"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/applyList";
    }

    /**
     * 删除广告
     * @param request
     * @param response
     * @param model
     * @param id    广告id
     * @return
     */
    @RequestMapping(value = "deleteAdvertise")
    public String deleteAdvertise(HttpServletRequest request , HttpServletResponse response ,
                              Model model,Integer id){

        //失败
        if(id == null){
            model.addAttribute("result",0);
            return "forward:"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/advertiseList";
        }

        EbShopAdvertise ebShopAdvertise = new EbShopAdvertise();
        ebShopAdvertise.setApplyStatus(5);
        ebShopAdvertise.setId(id);
        ebShopAdvertise.setDelFlag(1);

        boolean b = ebShopAdvertiseService.updateApplyStatus(ebShopAdvertise);

        model.addAttribute("result",b?1:0);

        return "forward:"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/advertiseList";
    }


    /**
     * 增加申请
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequestMapping("insert")
    public String insert(HttpServletRequest request , HttpServletResponse response,
            Model model ,EbShopAdvertise ebShopAdvertise , String startTime){
        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        Integer shopId = ebUser.getShopId();
        String shopName = ebUser.getShopName();

        if (StringUtil.isNotBlank(startTime)) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                ebShopAdvertise.setEntryTime(dateFormat.parse(startTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        String newPath = CkfinderFormatUtil.change(ebShopAdvertise.getPic());
        ebShopAdvertise.setPic(newPath);
        ebShopAdvertise.setCreateTime(new Date());
        ebShopAdvertise.setShopId(shopId);
        ebShopAdvertise.setShopName(shopName);
        ebShopAdvertise.setApplyStatus(0);
        ebShopAdvertise.setIsApply(0);
        ebShopAdvertise.setSourceType(2);
        ebShopAdvertise.setIsStatus(0);
        ebShopAdvertise.setDelFlag(0);

        boolean b = ebShopAdvertiseService.insert(ebShopAdvertise);


        model.addAttribute("prompt",b?1:0);
        if(!b){
            model.addAttribute("flag","add");
            return "modules/shop/advertiseApplyFrom";
        }
        return "redirect:"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/applyList";
    }

    /**
     * 修改可不可用
     * @param advertiseId
     * @param isStatus
     * @return
     */
    @RequestMapping("/updateIsStatus")
    @ResponseBody
    public Map<String,String> updateIsStatus(HttpServletRequest request , Integer advertiseId , Integer isStatus){
        Map<String , String > map = new HashMap<String, String>();

        if(advertiseId == null || isStatus == null){
            map.put("code","0");
            return map;
        }

        EbShopAdvertise ebShopAdvertise = ebShopAdvertiseService.findById(advertiseId);

        //弹窗广告设置成可用，就把其他的弹窗广告设置成不可用
        if(ebShopAdvertise.getSite() == 1 && isStatus == 1){
            EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
            Integer shopId = ebUser.getShopId();
            ebShopAdvertiseService.updateStatusToDisabledByShopId(shopId);
        }

        boolean result = ebShopAdvertiseService.updateStatus(advertiseId, isStatus);

        map.put("code",result?"1":"0");

        return map;
    }

    /**
     * 修改申请
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequestMapping("update")
    public String update(HttpServletRequest request , HttpServletResponse response
            ,Model model,EbShopAdvertise ebShopAdvertise,String startTime , RedirectAttributes redirectAttributes){

        if(ebShopAdvertise == null || ebShopAdvertise.getId() == null){
            model.addAttribute("prompt",0);
            return "forward:"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/applyFrom";
        }

        if (StringUtil.isNotBlank(startTime)) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                ebShopAdvertise.setEntryTime(dateFormat.parse(startTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        String newPath = CkfinderFormatUtil.change(ebShopAdvertise.getPic());
        ebShopAdvertise.setPic(newPath);

        //更新新的数据
        EbShopAdvertise oldAdvertise = ebShopAdvertiseService.findById(ebShopAdvertise.getId());
        oldAdvertise.setName(ebShopAdvertise.getName());
        oldAdvertise.setEntryTime(ebShopAdvertise.getEntryTime());
        oldAdvertise.setRemark(ebShopAdvertise.getRemark());
        oldAdvertise.setPic(ebShopAdvertise.getPic());
        oldAdvertise.setSite(ebShopAdvertise.getSite());
        oldAdvertise.setType(ebShopAdvertise.getType());
        oldAdvertise.setCertificateId(ebShopAdvertise.getCertificateId());
        oldAdvertise.setCertificateName(ebShopAdvertise.getCertificateName());

        boolean b = ebShopAdvertiseService.update(oldAdvertise);

        redirectAttributes.addAttribute("prompt",b ? 1:0);
        redirectAttributes.addAttribute("id",oldAdvertise.getId());
        return "redirect:/"+ Global.getConfig("adShopPath")+"/ebShopAdvertise/applyFrom";
    }


    /**
     * 选择优惠券
     * @param request
     * @param response
     * @param model
     * @param ids
     * @param ebCertificate
     * @return
     */
    @RequestMapping("/chooseCertificate")
    public String chooseCertificate(HttpServletRequest request , HttpServletResponse response,
                                    Model model , String ids, EbCertificate ebCertificate){



        if(StringUtil.isNotBlank(ids) && !"undefined".equals(ids)){
            List<String> nameList = new ArrayList<String>();

            String[] split = ids.split(",");
            for(int i = 0 ; i < split.length ; i++) {
                EbCertificate certificate = ebCertificateService.getEbExpand(split[i]);
                if(certificate != null){
                    nameList.add(certificate.getCertificateName());
                }
            }

            String names = nameList.toString().replace("[","").replace("]","");
            model.addAttribute("names",names);
        }else{
            ids="";
        }


        Page<EbCertificate> page = ebCertificateService.getList(ebCertificate, new Page<EbCertificate>(request,response), null, null, null);
        model.addAttribute("page",page);
        model.addAttribute("ids",ids);

        return "/modules/shop/chooseCertificate";
    }


    /**
     * 创建图片存放目录
     */
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
