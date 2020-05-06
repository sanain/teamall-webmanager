package com.jq.support.main.controller.merchandise.mecontent;

import com.jq.support.common.config.Global;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.article.EbJoinIn;
import com.jq.support.service.merchandise.article.EbJoinInService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;

/**
 * 加盟信息的控制层
 */
@RequestMapping(value = "${adminPath}/EbJoinIn")
@Controller
public class EbJoinInController {
    @Autowired
    private EbJoinInService ebJoinInService;

    /**
     * 跳转到编辑页面
     * @param model
     * @param prompt
     * @return
     */
    @RequiresPermissions("merchandise:EbJoinIn:view")
    @RequestMapping("form")
    public String from(HttpServletRequest request , Model model , String prompt){
        createPicFold(request);
        model.addAttribute("prompt" , prompt);

        EbJoinIn ebJoinIn = ebJoinInService.getFirst();
        model.addAttribute("ebJoinIn",ebJoinIn);

        return "/modules/shopping/Article/EbJoinInForm";
    }

    /**
     * 保存
     * @param model
     * @param ebJoinIn
     * @return
     */
    @RequiresPermissions("merchandise:EbJoinIn:edit")
    @RequestMapping("save")
    public String save(Model model , EbJoinIn ebJoinIn){

        if(ebJoinIn == null || ebJoinIn.getId() == null){
            ebJoinIn.setCreateTime(new Date());
            ebJoinInService.save(ebJoinIn);
        }else{
            EbJoinIn old = ebJoinInService.getEbJoinIn(ebJoinIn.getId().toString());
            old.setUpdateTime(new Date());
            old.setContent(ebJoinIn.getContent());
            old.setPhone(ebJoinIn.getPhone());
            ebJoinInService.save(old);
        }

        model.addAttribute("prompt", "保存成功！");
        return "forward:" + Global.getAdminPath()
                + "/EbJoinIn/form";
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
        folder.append("EbJoinIn");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }

}
