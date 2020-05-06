package com.jq.support.main.controller.shop;

import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.model.product.EbProductApply;
import com.jq.support.model.product.EbResources;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.EbProductApplyRemarkService;
import com.jq.support.service.merchandise.product.EbProductApplyService;
import com.jq.support.service.merchandise.product.EbResourceService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping(value = "${adShopPath}/ebProductApplyShop")
public class EbProductApplyShopController {
    @Autowired
    private EbResourceService ebResourceService;
    @Autowired
    private EbProductApplyService ebProductApplyService;
    @Autowired
    private EbProductApplyRemarkService ebProductApplyRemarkService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    /**
     * 列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("list")
    public String list(EbProductApply ebProductApply, HttpServletRequest request, HttpServletResponse response, Model model){
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopInfo getShop=pmShopInfoService.getpmPmShopInfo(String.valueOf(ebUser.getShopId()));
        Page<EbProductApply> page = ebProductApplyService.ebProductApplyPage(new Page<EbProductApply>(request,response),getShop,ebProductApply);
        model.addAttribute("page",page);
        model.addAttribute("getShop",ebProductApply);
        return "modules/shop/productApplyList";
    }

    /**
     * 添加页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("productApplyForm")
    public String form(HttpServletRequest request, HttpServletResponse response, Model model){
        String id=request.getParameter("id");
        if(id!=null){
            EbProductApply getShop=ebProductApplyService.ebProductApply(Integer.parseInt(id));
            model.addAttribute("user",getShop);
        }else{
            model.addAttribute("user",new EbProductApply());
        }
        return "modules/shop/productApplyForm";
    }

    /**
     * 下载附件并且添加数据
     * @param multipartFile
     * @param ebProductApply
     * @param request
     * @param model
     * @param response
     * @return
     */
    @RequestMapping("insert")
    public String insert(@RequestParam("multipartFile") MultipartFile multipartFile, EbProductApply ebProductApply, HttpServletRequest request, Model model, HttpServletResponse response){
        try {
            EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
            PmShopInfo getShop=pmShopInfoService.getpmPmShopInfo(String.valueOf(ebUser.getShopId()));
            ebProductApply.setDel(0);
            ebProductApply.setApplyStatus(0);
            ebProductApply.setIsapply(2);
            ebProductApply.setCreateTime(new Date());
            ebProductApply.setShopId(getShop.getId());
            ebProductApply.setShopName(getShop.getShopName());
            //随机生产文件名
            UUID uuid = UUID.randomUUID();
            //获取后缀
            String suffix = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1);
            // 录音存放路径
            File date = new File(request.getSession().getServletContext().getRealPath("/") + "/file");
            if (!date.exists()) {
                date.mkdir();// 创建文件夹
            }
            //存放路径
            String paths= date + "/" + uuid + "."+suffix;
            byte[] bytes = multipartFile.getBytes();
            BufferedOutputStream buffStream = new BufferedOutputStream(new FileOutputStream(paths));
            buffStream.write(bytes);
            buffStream.close();
            ebProductApply.setFileUrl("/file/"+ uuid + "."+suffix);
            ebProductApplyService.inset(ebProductApply);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list(new EbProductApply() ,request,response,model);
    }
    /**
     * 下载申请材料
     * @param request
     * @param response
     * @return
     * @throws IOException
     */

    @RequestMapping("downloadApplyFile")
    public void downloadApplyFile( Integer id, HttpServletRequest request , HttpServletResponse response) throws IOException {
        EbProductApply ebProductApply = ebProductApplyService.getById(id);
        String fileName = ebProductApply.getFileUrl();
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
     * 修改
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("update")
    public String update(HttpServletRequest request, HttpServletResponse response, Model model){
        String id=request.getParameter("id");
        EbProductApply getShop=ebProductApplyService.ebProductApply(Integer.parseInt(id));
        getShop.setApplyStatus(3);
        ebProductApplyService.inset(getShop);
        return list(new EbProductApply(),request,response,model);
    }

    /**
     * 下载申请模板文件
     * @param request
     * @param response
     * @return
     * @throws IOException
     */

    @RequestMapping("downloadApplyModelFile")
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
     * 查询回复列表
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/remarkList",method = RequestMethod.POST)
    public Map<String,Object> remarkList(Integer id){
        Map<String, Object> map=new HashMap<String, Object>();
        try{
            map.put("obj",ebProductApplyRemarkService.getRemarkByApplyId(id));
            map.put("msg", "成功");
            map.put("code", "00");
        }catch (Exception e){
            e.printStackTrace();
            map.put("msg", "系统出错");
            map.put("code", "01");
        }
        return map;
    }


    /**
     * 判断下载的文件是否存在
     * @param fileType      文件类型 model  模板文件   否则 是申请文件
     * @param id            申请文件的id
     * @param response
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/fileIsExists")
    public Map<String , String> fileIsExists(String fileType , Integer id ,HttpServletResponse response , HttpServletRequest request ){

        String fileName=null;
        if("model".equals(fileType)){
            EbResources ebResources = ebResourceService.getNewestResource();
            fileName = ebResources.getResourcesUrl();
        }else{
            EbProductApply ebProductApply = ebProductApplyService.getById(id);
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
