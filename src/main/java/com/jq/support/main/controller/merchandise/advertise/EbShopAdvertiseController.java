package com.jq.support.main.controller.merchandise.advertise;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.merchandise.order.EbOrderDao;
import com.jq.support.model.advertisement.EbShopAdvertise;
import com.jq.support.model.advertisement.EbShopAdvertiseRemark;
import com.jq.support.model.certificate.EbCertificate;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.advertisement.EbShopAdvertiseRemarkService;
import com.jq.support.service.advertisement.EbShopAdvertiseService;
import com.jq.support.service.certificate.EbCertificateService;
import com.jq.support.service.utils.CkfinderFormatUtil;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.UploadUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
 * 后端的广告申请管理
 */
@Controller
@RequestMapping(value = "${adminPath}/ebShopAdvertise")
public class EbShopAdvertiseController extends BaseController {
    @Autowired
    private EbShopAdvertiseService ebShopAdvertiseService;
    @Autowired
    private EbShopAdvertiseRemarkService ebShopAdvertiseRemarkService;
    @Autowired
    private EbCertificateService ebCertificateService;

    /**
     * 查看申请列表
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:view")
    @RequestMapping(value = "shopApplyList")
    public String shopApplyList(HttpServletRequest request, HttpServletResponse response,
                            Model model, EbShopAdvertise ebShopAdvertise,String startTime){
        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");
        Page rPage=new Page<EbShopAdvertise>(request, response);
        if(StringUtil.isNotBlank(pageNo)&&StringUtil.isNotBlank(pageSize)){
            rPage.setPageNo(Integer.parseInt(pageNo));
            rPage.setPageSize(Integer.parseInt(pageSize));
        }
       ebShopAdvertise.setSourceType(2);

        Page<EbShopAdvertise> page = ebShopAdvertiseService.findShopApplyList(ebShopAdvertise,rPage ,startTime);


        model.addAttribute("page",page);
        model.addAttribute("startTime",startTime);
        model.addAttribute("ebShopAdvertise",ebShopAdvertise);

        return "modules/shopping/advertise/advertiseApplyList";
    }

    /**
     * 广告是否可用
     * @param request
     * @param response
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:edit")
    @RequestMapping(value = "isStatus")
    public String isStatus(
            HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
        String id=request.getParameter("id");
        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");
        EbShopAdvertise ebShopAdvertise = ebShopAdvertiseService.findById(Integer.parseInt(id));
        if(ebShopAdvertise.getIsStatus()==0){
            ebShopAdvertise.setIsStatus(1);
        }else{
            ebShopAdvertise.setIsStatus(0);
        }
        ebShopAdvertiseService.save(ebShopAdvertise);
        addMessage(redirectAttributes, "操作成功");
        if(ebShopAdvertise.getSourceType()==1){
            return "redirect:"+Global.getAdminPath()+"/ebShopAdvertise/advertiseList?pageNo="+pageNo+"&pageSize="+pageSize;
        }else{
            return "redirect:"+Global.getAdminPath()+"/ebShopAdvertise/shopApplyList?pageNo="+pageNo+"&pageSize="+pageSize;
        }

    }
    /**
     * 进入审核页面
     * @param request
     * @param response
     * @param model
     * @param id    广告id
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:edit")
    @RequestMapping(value = "applyCheckFrom")
    public String applyCheckFrom(HttpServletRequest request , HttpServletResponse response ,
                            Model model,Integer id ){

        EbShopAdvertise ebShopAdvertise = ebShopAdvertiseService.findById(id);
//        String newPath = CkfinderFormatUtil.restore(ebShopAdvertise.getPic());
//        ebShopAdvertise.setPic(newPath);

        if(ebShopAdvertise != null && ebShopAdvertise.getId() != null){
            List<EbShopAdvertiseRemark> remarkList = ebShopAdvertiseRemarkService.getByApplyId(ebShopAdvertise.getId());
            model.addAttribute("remarkList",remarkList);
        }

        model.addAttribute("ebShopAdvertise",ebShopAdvertise);

        return "modules/shopping/advertise/applyCheckFrom";
    }

    /**
     * 审核
     * @param request
     * @param response
     * @param id    申请id
     * @param status    申请状态
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "applyCheck")
    public  Map<String , String > applyCheck(HttpServletRequest request , HttpServletResponse response ,
                                 Integer id,Integer status,String applyRemark){
        Map<String , String > map = new HashMap<String, String>();

        //失败
        if(id == null){
            map.put("code","0");
            return map;
        }

        Integer code;
        EbShopAdvertise oldAdvertise = ebShopAdvertiseService.findById(id);

        //申请通过
        if(status == 1 && oldAdvertise.getSite() == 1){
            //设置从前的广告弹窗不可用
            ebShopAdvertiseService.updateStatusToDisabledByShopId(oldAdvertise.getShopId());
        }

        oldAdvertise.setApplyStatus(status);
        oldAdvertise.setIsApply(1);
        oldAdvertise.setApplyTime(new Date());
        oldAdvertise.setIsStatus(1);
        boolean result = ebShopAdvertiseService.update(oldAdvertise);

        code = result?1:2;

        if(result && StringUtil.isNotBlank(applyRemark)){
            EbShopAdvertiseRemark remark = new EbShopAdvertiseRemark();
            remark.setAdvertiseId(id);
            remark.setApplyRemark(applyRemark);
            remark.setCreateTime(new Date());

            result = ebShopAdvertiseRemarkService.insert(remark);

            code = result?1:2;
        }

        map.put("code",code+"");

        return map;
    }





    /**
     * 查看平台广告列表
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:view")
    @RequestMapping(value = "advertiseList")
    public String advertiseList(HttpServletRequest request, HttpServletResponse response,
                            Model model, EbShopAdvertise ebShopAdvertise,Integer prompt,String startTime){
        String pageNo=request.getParameter("pageNo");
        String pageSize=request.getParameter("pageSize");
        Page rPage=new Page<EbShopAdvertise>(request, response);
        if(StringUtil.isNotBlank(pageNo)&&StringUtil.isNotBlank(pageSize)){
            rPage.setPageNo(Integer.parseInt(pageNo));
            rPage.setPageSize(Integer.parseInt(pageSize));
        }
        ebShopAdvertise.setSourceType(1);

        Page<EbShopAdvertise> page = ebShopAdvertiseService.findApplyList(ebShopAdvertise, rPage,startTime);


        if(prompt != null && prompt == 1){
            model.addAttribute("prompt","操作成功");
        }else if(prompt != null && prompt == 0){
            model.addAttribute("prompt","操作失败");
        }

        model.addAttribute("page",page);
        model.addAttribute("startTime",startTime);
        model.addAttribute("ebShopAdvertise",ebShopAdvertise);

        return "modules/shopping/advertise/advertiseList";
    }


    /**
     * 进入平台广告增加（或者修改）页面
     * @param request
     * @param response
     * @param model
     * @param id    广告id
     * @param flag  是否进入增加  add  增加  反之  修改
     * @param prompt    提示
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:edit")
    @RequestMapping(value = "advertiseFrom")
    public String advertiseFrom(HttpServletRequest request , HttpServletResponse response ,
                            Model model,Integer id , String flag,Integer prompt,String isChange){

        if(prompt != null && prompt == 1){
            model.addAttribute("prompt","操作成功");
        }else if(prompt != null && prompt == 0){
            model.addAttribute("prompt","操作失败");
        }

        createPicFold(request); //创建存放文件目录
        model.addAttribute("flag",flag);
        model.addAttribute("isChange",isChange);


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

        return "modules/shopping/advertise/advertiseFrom";
    }


    /**
     * 增加平台广告
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:edit")
    @RequestMapping("insertAdvertise")
    public String insertAdvertise(HttpServletRequest request , HttpServletResponse response,
                         Model model ,EbShopAdvertise ebShopAdvertise , String startTime){

        if (StringUtil.isNotBlank(startTime)) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                ebShopAdvertise.setEntryTime(dateFormat.parse(startTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        ebShopAdvertise.setCreateTime(new Date());
        ebShopAdvertise.setApplyStatus(1);
        ebShopAdvertise.setIsApply(1);
        ebShopAdvertise.setApplyTime(new Date());
        ebShopAdvertise.setSourceType(1);
        ebShopAdvertise.setIsStatus(1);
        String newPath = CkfinderFormatUtil.change(ebShopAdvertise.getPic());
        ebShopAdvertise.setPic(newPath);
        ebShopAdvertise.setDelFlag(0);

        boolean b = ebShopAdvertiseService.insert(ebShopAdvertise);


        model.addAttribute("prompt",b?1:0);
        if(!b){
            model.addAttribute("flag","add");
            return "modules/shopping/advertise/advertiseFrom";
        }
        return "redirect:"+ Global.getConfig("adminPath")+"/ebShopAdvertise/advertiseList";
    }


    /**
     * 修改平台广告
     * @param request
     * @param response
     * @param model
     * @param ebShopAdvertise
     * @return
     */
    @RequiresPermissions("merchandise:ebShopAdvertise:edit")
    @RequestMapping("updateAdvertise")
    public String updateAdvertise(HttpServletRequest request , HttpServletResponse response
            , Model model, EbShopAdvertise ebShopAdvertise, String startTime, RedirectAttributes redirectAttributes){

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

        //转化路径的逗号
        String newPath = CkfinderFormatUtil.change(ebShopAdvertise.getPic());
        ebShopAdvertise.setPic(newPath);

        //更新新的数据
        EbShopAdvertise oldAdvertise = ebShopAdvertiseService.findById(ebShopAdvertise.getId());
        oldAdvertise.setEntryTime(ebShopAdvertise.getEntryTime());
        oldAdvertise.setName(ebShopAdvertise.getName());
        oldAdvertise.setRemark(ebShopAdvertise.getRemark());
        oldAdvertise.setPic(ebShopAdvertise.getPic());
        oldAdvertise.setSite(ebShopAdvertise.getSite());
        oldAdvertise.setType(ebShopAdvertise.getType());
        oldAdvertise.setCertificateId(ebShopAdvertise.getCertificateId());
        oldAdvertise.setCertificateName(ebShopAdvertise.getCertificateName());

        boolean b = ebShopAdvertiseService.update(oldAdvertise);

        redirectAttributes.addAttribute("prompt",b ? 1:0);
        redirectAttributes.addAttribute("id",oldAdvertise.getId());
        return "redirect:"+ Global.getConfig("adminPath")+"/ebShopAdvertise/advertiseFrom";
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

        return "modules/shopping/advertise/chooseCertificate";
    }

    /**
     * 修改可不可用
     * @param advertiseId
     * @param isStatus
     * @return
     */
    @RequestMapping("/updateIsStatus")
    @ResponseBody
    public Map<String,String> updateIsStatus(Integer advertiseId , Integer isStatus){
        Map<String , String > map = new HashMap<String, String>();

        if(advertiseId == null || isStatus == null){
            map.put("code","0");
            return map;
        }

        boolean result = ebShopAdvertiseService.updateStatus(advertiseId, isStatus);

        map.put("code",result?"1":"0");

        return map;
    }


    /**
     * 上传广告图片
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping("updateAdvertisePic")
    public Map<String , String> updateAdvertisePic(MultipartFile file, HttpServletRequest request){
        createPicFold(request);

        String portionPath = "\\uploads\\000000\\images\\merchandise\\advertise\\";
        String completePath = request.getSession().getServletContext().getRealPath("/")+
                portionPath;

        String uuid = UUID.randomUUID().toString();

        //文件名（不包括后缀）
        String fileName = UploadUtil.uploadFile(file, completePath , uuid);
        fileName = portionPath + fileName;
        HashMap<String, String> map = new HashMap<String, String>();


        if(fileName != null){
            map.put("url",fileName);
        }else{
            map.put("url","");
        }

        return map;
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
        folder.append("images" );
        folder.append(File.separator);
        folder.append("merchandise");
        folder.append(File.separator);
        folder.append("advertise");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }
}
