package com.jq.support.main.controller.shop;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.advertisement.EbAdvertisement;
import com.jq.support.model.advertisement.EbAdvertisementShop;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.advertisement.EbAdvertisementService;
import com.jq.support.service.advertisement.EbAdvertisementShopService;
import com.jq.support.service.pay.yeepay.paymobile.utils.Base64;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;

//广告投放
@Controller
@RequestMapping(value = "${adShopPath}/EbAdvertisement")
public class ShopEbAdvertisementController extends BaseController {

    @Autowired
    EbAdvertisementService ebAdvertisementService;
    @Autowired
    EbAdvertisementShopService ebAdvertisementShopService;
    /**
     * 查询列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("list")
    public String list(HttpServletRequest request, HttpServletResponse response,Model model){
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        Page<EbAdvertisement> page = ebAdvertisementService.getEbAdvertisementList(new Page<EbAdvertisement>(request,response));
        EbAdvertisementShop ebAdvertisementShop=ebAdvertisementShopService.getEbAdvertisementShop(ebUser.getShopId());
        if(ebAdvertisementShop!=null)
        for(EbAdvertisement ebAdvertisement:page.getList()){
            if(ebAdvertisement.getId().toString().equals(ebAdvertisementShop.getAdvertisementId().toString())){
                ebAdvertisement.setEbAdvertisementShop(ebAdvertisementShop);
                ebAdvertisement.setIsEbAdvertisementShop(1);
            }else{
                ebAdvertisement.setIsEbAdvertisementShop(0);
            }
        }
        model.addAttribute("page",page);
        return "modules/shop/advertisement";
    }
    /**
     * 设置商家收银端广告关联表
     *
     * @param id
     * @param redirectAttributes
     * @return
     */
    @ResponseBody
    @RequestMapping("ebAdvertisementShop")
    public HashMap<String, String> ebAdvertisementShop(Integer id, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        EbAdvertisementShop ebAdvertisementShop=ebAdvertisementShopService.getEbAdvertisementShop(ebUser.getShopId());
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("code","1");
        map.put("message","操作成功");

        if(ebAdvertisementShop!=null){
            if(id.toString().equals(ebAdvertisementShop.getAdvertisementId().toString())){
                ebAdvertisementShopService.delete(ebAdvertisementShop);
                addMessage(redirectAttributes, "操作成功");
                return map;
            }
            ebAdvertisementShop.setAdvertisementId(id);
            ebAdvertisementShop.setCreateTime(new Date());
        }else{
            ebAdvertisementShop=new EbAdvertisementShop();
            ebAdvertisementShop.setCreateTime(new Date());
            ebAdvertisementShop.setAdvertisementId(id);
            ebAdvertisementShop.setShopId(ebUser.getShopId());
        }
        ebAdvertisementShopService.save(ebAdvertisementShop);
        return map;
    }
    /**
     * 下载图片并打包
     * @param request
     * @param response
     */
    @RequestMapping("download")
    public void downPicture(HttpServletRequest request,HttpServletResponse response)throws Exception{
        try {
            //文件名
            String downloadFilename = "广告图.zip";//文件的名称
            //域名
            String ourl="http://127.0.0.1:8080/teamall-webmanager/";
            //获取路径
            String urls = request.getParameter("pictureUrl");
            String[] sourceStrArray = urls.split(",");
            String[] files = new String[sourceStrArray.length];
            for (int i = 0; i < sourceStrArray.length; i++) {
                files[i]=ourl+sourceStrArray[i];
            }
            downloadFilename = URLEncoder.encode(downloadFilename, "UTF-8");//转换中文否则可能会产生乱码
            response.setContentType("application/octet-stream");// 指明response的返回对象是文件流
            response.setHeader("Content-Disposition", "attachment;filename=" + downloadFilename);// 设置在下载框默认显示的文件名
            ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
            for (int i=0;i<files.length;i++) {
                URL url = new URL(files[i]);
                String suffix = files[i].substring(files[i].lastIndexOf(".") + 1);
                zos.putNextEntry(new ZipEntry(i+"."+suffix));
                //FileInputStream fis = new FileInputStream(new File(files[i]));
                InputStream fis = url.openConnection().getInputStream();
                byte[] buffer = new byte[1024];
                int r = 0;
                while ((r = fis.read(buffer)) != -1) {
                    zos.write(buffer, 0, r);
                }
                fis.close();
            }
            zos.flush();
            zos.close();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }




    /*@RequestMapping("download")
    public void downPicture(HttpServletRequest request,HttpServletResponse response)throws Exception{
        String urls = request.getParameter("pictureUrl");
        String ourl="http://127.0.0.1:8080//teamall-webmanager/";
        String[] sourceStrArray = urls.split(",");
        HttpServletResponse responses=response;
        for (int i = 0; i < sourceStrArray.length; i++) {
            response=responses;
            //图片的资源地址，http://10.80.3.229:8081/mediaserver/574fe515e30ab97c9068d2e1
            //这是媒体服务器返回的地址，因为是网络地址，所以需要使用HttpURLConnection去获取图片
            //String imgUrl = request.getParameter("imgUrl");
            String imgUrl = ourl+sourceStrArray[i];
            String suffix = imgUrl.substring(imgUrl.lastIndexOf(".") + 1);
            //图片的名称
            String imgName = System.currentTimeMillis()+"."+suffix;
            //名称转码，避免中文乱码
            imgName = new String(imgName.getBytes("iso8859-1"),"UTF-8");
            //输入流，用来读取图片
            InputStream ins = null;
            HttpURLConnection httpURL = null;
            //输出流
            OutputStream out = response.getOutputStream();
            try{
                URL url = new URL(imgUrl);
                //打开一个网络连接
                httpURL = (HttpURLConnection)url.openConnection();
                //设置网络连接超时时间
                httpURL.setConnectTimeout(3000);
                //设置应用程序要从网络连接读取数据
                httpURL.setDoInput(true);
                //设置请求方式
                httpURL.setRequestMethod("GET");
                //获取请求返回码
                int responseCode = httpURL.getResponseCode();
                if(responseCode == 200){
                    //如果响应为“200”，表示成功响应，则返回一个输入流
                    ins = httpURL.getInputStream();
                    //设置response响应头
                    //encodeChineseDownloadFileName()用来解决文件名为中文的问题，方法体在下面
                    response.setHeader("content-disposition", "attachment;filename="+ encodeChineseDownloadFileName(request,imgName));
                    //输出流到response中
                    byte[] data = new byte[1024];
                    int len = 0;
                    while((len = ins.read(data)) > 0){
                        out.write(data, 0, len);
                    }
                }
            }catch(Exception e){
                e.printStackTrace();
            }finally{
                if(ins != null){
                    ins.close();
                }
                if(out != null){
                    out.close();
                }
            }
        }
    }*/

    /*
     * 解决文件为中文名的乱码问题
     */
    private String encodeChineseDownloadFileName(HttpServletRequest request, String pFileName) throws UnsupportedEncodingException{
        String filename = null;
        //获取请求头中的浏览器标识
        String agent = request.getHeader("USER-AGENT");
        if(agent != null){
            if(agent.indexOf("Firefox") != -1){
                //Firefox
                filename = "=?UTF-8?B?" +
                        (new String(Base64.encodeBase64(pFileName.getBytes("UTF-8")))) + "?=";
            }else if(agent.indexOf("Chrome") != -1){
                //Chrome
                filename = new String(pFileName.getBytes(), "ISO8859-1");
            }else{
                //IE7+
                filename = URLEncoder.encode(pFileName, "UTF-8");
                //替换空格
                filename = StringUtils.replace(filename, "+", "%20");
            }
        }else{
            filename = pFileName;
        }
        return filename;
    }
}
