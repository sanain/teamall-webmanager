package com.jq.support.main.controller.merchandise.product;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.product.EbProductApply;
import com.jq.support.model.product.EbProductApplyRemark;
import com.jq.support.model.product.EbResources;
import com.jq.support.service.merchandise.product.EbProductApplyRemarkService;
import com.jq.support.service.merchandise.product.EbProductApplyService;
import com.jq.support.service.merchandise.product.EbResourceService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * 商家申请添加商品
 */
@Controller
@RequestMapping(value = "${adminPath}/ebProductApply")
public class EbProductApplyController {
    @Autowired
    private EbResourceService ebResourceService;
    @Autowired
    private EbProductApplyService ebProductApplyService;
    @Autowired
    private EbProductApplyRemarkService ebProductApplyRemarkService;

    /**
     * 查询单个,在每个请求之前调用该方法
     * @param id
     * @return
     */
    @ModelAttribute
    public EbProductApply get(@RequestParam(required = false) String id) {
        if (org.apache.commons.lang3.StringUtils.isNotBlank(id)) {
            return ebProductApplyService.getById(Integer.parseInt(id));
        } else {
            return new EbProductApply();
        }
    }

    /**
     * 查询单个
     * @param
     * @return
     */
    @RequiresPermissions("merchandise:ebProductApply:view")
    @RequestMapping(value =  "findApplyById")
    public String findApplyById(EbProductApply ebProductApply , Model model) {
        model.addAttribute("ebProductApply",ebProductApply);

        List<EbProductApplyRemark> remarkList = ebProductApplyRemarkService.getRemarkByApplyId(ebProductApply.getId());

        model.addAttribute("remarkList",remarkList);

        return "modules/shopping/brands/productApplyFrom";
    }

    /**
     * 分页条件查询
     * @param ebProductApply
     * @param request
     * @param response
     * @param model
     * @param createTime
     * @return
     */
    @RequiresPermissions("merchandise:ebProductApply:view")
    @RequestMapping(value = { "list", "" })
    public String list(EbProductApply ebProductApply , HttpServletRequest request
        , HttpServletResponse response , Model model , String createTime){

        //创建保存文件的目录
        createPicFold(request);

        Page<EbProductApply> page = ebProductApplyService.getList(ebProductApply, new Page(request, response), createTime);

        model.addAttribute("page",page);
        model.addAttribute("ebProductApply",ebProductApply);
//        model.addAttribute("ebResources",ebResources);
        model.addAttribute("createTime",createTime);

        return "modules/shopping/brands/productApplyList";
    }

    /**
     * 更新申请的状态
     * @param ebProductApply
     * @param model
     * @return
     */
    @ResponseBody
    @RequiresPermissions("merchandise:ebProductApply:edit")
    @RequestMapping(value =  "updateApplyStatus")
    public String updateApplyStatus(EbProductApply ebProductApply ,Model model ){

        boolean result = ebProductApplyService.updateApplyStatus(ebProductApply);

        String prompt = "success";

        if(!result){
            prompt="fail";
        }

        return prompt;
    }


    /**
     * 保存申请回复
     * @param ebProductApplyRemark
     * @param model
     * @return
     */
    @ResponseBody
    @RequiresPermissions("merchandise:ebProductApply:edit")
    @RequestMapping(value =  "saveRemark")
    public String saveRemark(EbProductApplyRemark ebProductApplyRemark ,Model model ){

        boolean result = ebProductApplyRemarkService.save(ebProductApplyRemark);

        String prompt = "success";

        if(!result){
            prompt="fail";
        }

        return prompt;
    }


    /**
     * 上传申请文件
     * @param file
     * @return
     */
    @ResponseBody
    @RequiresPermissions("merchandise:ebProductApply:edit")
    @RequestMapping("updateApplyFile")
    public Map<String , String> updateApplyFile(MultipartFile file, HttpServletRequest request){
        createPicFold(request);

        String portionPath = "\\uploads\\000000\\applyFile\\";
        String completePath = request.getSession().getServletContext().getRealPath("/")+
                portionPath;

        boolean result = ebResourceService.insert(file , completePath , portionPath);
        HashMap<String, String> map = new HashMap<String, String>();
        if(result){
            map.put("flag","success");
        }else{
            map.put("flag","fail");
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
        folder.append("applyFile");
        folder.append(File.separator);
        FileUtils.createDirectory(folder.toString());
    }


    /**
     * 下载申请模板文件
     * @param request
     * @param response
     * @return
     * @throws IOException
     */

    @RequestMapping(value = "/downloadApplyModelFile")
    public void downloadApplyModelFile( HttpServletRequest request , HttpServletResponse response) throws IOException {
        //获得最新的申请材料
        EbResources ebResources = ebResourceService.getNewestResource();
        String fileName = ebResources.getResourcesUrl();
        // 拼接真实路径
        String realPath = request.getSession().getServletContext().getRealPath("/")
                + fileName;
        // 读取文件
        File file = new File(realPath);
        if(file.exists()){
            OutputStream os = new BufferedOutputStream(response.getOutputStream());
            try {
                response.setContentType("application/octet-stream");
                if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {   //IE浏览器
                    fileName = URLEncoder.encode(fileName , "UTF-8");
                } else {
                    fileName = URLDecoder.decode(fileName );//其他浏览器
                }

                response.setHeader("Content-disposition", "attachment; filename="
                        + UUID.randomUUID().toString() +file.getName().substring(file.getName().lastIndexOf("."))); // 指定下载的文件名

                os.write(FileUtils.readFileToByteArray(file));
                os.flush();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if(os != null){
                    os.close();
                }
            }
        }

    }


    /**
     * 下载商家申请材料
     * @param request
     * @param response
     * @return
     * @throws IOException
     */

    @RequestMapping(value = "/downloadApplyFile")
    public void downloadApplyFile( EbProductApply ebProductApply, HttpServletRequest request , HttpServletResponse response , Model model) throws IOException {

        String fileName = ebProductApply.getFileUrl();

        // 拼接真实路径
        String realPath = request.getSession().getServletContext().getRealPath("/")
                + fileName;
        // 读取文件
        File file = new File(realPath);
        OutputStream os = new BufferedOutputStream(response.getOutputStream());
        try {
            response.setContentType("application/octet-stream");
            if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {   //IE浏览器
                fileName = URLEncoder.encode(fileName , "UTF-8");
            } else {
                fileName = URLDecoder.decode(fileName );//其他浏览器
            }



            if(!file.exists() || file.isDirectory()){
                os.write(new byte[0]);
                model.addAttribute("prompt","文件不存在");

                response.setHeader("Content-disposition", "attachment; filename=error.txt"); // 指定下载的文件名

            }else{
                response.setHeader("Content-disposition", "attachment; filename="
                        + UUID.randomUUID().toString() +file.getName().substring(file.getName().lastIndexOf("."))); // 指定下载的文件名
                os.write(FileUtils.readFileToByteArray(file));
            }

            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if(os != null){
                os.close();
            }
        }

    }

    /**
     * 判断下载的文件是否存在
     * @param response
     * @param request
     * @param ebProductApply
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileIsExists")
    public Map<String , String> fileIsExists(String fileType , HttpServletResponse response , HttpServletRequest request , EbProductApply ebProductApply){
        String fileName=null;
        if("model".equals(fileType)){
            EbResources ebResources = ebResourceService.getNewestResource();
            fileName = ebResources.getResourcesUrl();
        }else{
            fileName = ebProductApply.getFileUrl();
        }

        // 拼接真实路径
        String realPath = request.getSession().getServletContext().getRealPath("/")
                + fileName;

        File file = new File(realPath);
        Map<String , String > map = new HashMap<String, String>();

        if(!file.exists()||file.isDirectory()){
            map.put("flag","no");
        }else{
            map.put("flag","yes");
        }

        return map;
    }

}
