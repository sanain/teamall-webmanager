package com.jq.support.main.controller.sys;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysSource;
import com.jq.support.model.sys.SysSourceType;
import com.jq.support.service.sys.SysSourceService;
import com.jq.support.service.sys.SysSourceTypeService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.*;

/**
 * 系统资源的控制层
 */
@Controller
@RequestMapping("${adminPath}/sysSource")
public class SysSourceController extends BaseController {
    @Autowired
    private SysSourceService sysSourceService;
    @Autowired
    private SysSourceTypeService sysSourceTypeService;

    /**
     * 查询分页
     * @param response
     * @param request
     * @param model
     * @param sysSource
     * @return
     */
    @RequestMapping(value = {"list",""})
    public String list(HttpServletResponse response , HttpServletRequest request ,
                       Model model, SysSource sysSource){
        Page<SysSource> page = sysSourceService.getList(sysSource, new Page<SysSource>(request, response));

        if(CollectionUtils.isNotEmpty(page.getList())){
            for(SysSource s : page.getList()){
                if(s.getContentType() == 2){
                    s.setValue(s.getValue().replace("|",""));
                }
            }
        }
        model.addAttribute("sysSource",sysSource);
        model.addAttribute("page",page);

        return "modules/sys/sysSourceList";
    }

    /**
     *导航到编辑页面
     * @param request
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "form")
    public String form(HttpServletRequest request , Model model,Integer id){
        createPicFold(request);

        SysSource sysSource = new SysSource();
        if(id != null){
            sysSource = sysSourceService.getById(id);
        }

        model.addAttribute("sysSource",sysSource);

        return "modules/sys/sysSourceForm";
    }


    /**
     * 编辑系统资源
     * @param sysSource
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "save")
    public Map<String,String> save(SysSource sysSource){
        if(sysSource.getId() == null){
            sysSource.setDelFlag(0);
            sysSource.setCreateTime(new Date());
        }else{
            SysSource oldSource = sysSourceService.getById(sysSource.getId());
            oldSource.setContentType(sysSource.getContentType());
            oldSource.setSourceType(sysSource.getSourceType());
            oldSource.setPositionType(sysSource.getPositionType());
            oldSource.setDescription(sysSource.getDescription());
            oldSource.setSort(sysSource.getSort());
            oldSource.setValue(sysSource.getValue());
            sysSource = oldSource;
        }
        SysSourceType contentType = sysSourceTypeService.getById(sysSource.getContentType());
        SysSourceType sourceType = sysSourceTypeService.getById(sysSource.getSourceType());
        SysSourceType positionType = sysSourceTypeService.getById(sysSource.getPositionType());
        String contentStr = contentType == null ? "" : contentType.getLabel();
        String sourceStr = sourceType == null ? "" : sourceType.getLabel();
        String positionStr = positionType == null ? "" : positionType.getLabel();
        sysSource.setTypeStr(contentStr+"->"+sourceStr+"->"+positionStr);

        boolean result = sysSourceService.save(sysSource);

        Map<String , String> map = new HashMap<String, String>();
        map.put("code",result?"01":"00");
        map.put("msg",result?"编辑成功":"编辑失败");

        return map;
    }

    /**
     * 删除系统资源
     * @param id
     * @return
     */
    @RequestMapping(value = "delete")
    public String delete(Integer id , RedirectAttributes redirectAttributes){
        if(id == null){
            addMessage(redirectAttributes, "信息错误");
            return "redirect:"+Global.getAdminPath()+"/sysSource/list";
        }

        boolean result = sysSourceService.delete(id);

        addMessage(redirectAttributes, result?"删除成功":"删除失败");
        return "redirect:"+Global.getAdminPath()+"/sysSource/list";
    }


    /**
     * 获得分类
     * @param levelNum
     * @param typeId
     * @return
     */
    @ResponseBody
    @RequestMapping("getTypes")
    public Map<String,Object> getType(Integer levelNum,Integer typeId){
        Map<String,Object> map = new HashMap<String, Object>();

        if(levelNum != 1 && typeId == null){
            map.put("code","00");
            map.put("msg","参数错误");
            return map;
        }

        List<SysSourceType> list = null;
        if(levelNum==1){
            list = sysSourceTypeService.getFirstLevelType();
        }else{
            list = sysSourceTypeService.getChildrenByParentId(typeId);
        }

        map.put("code","01");
        map.put("msg","成功");
        map.put("data",list);
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
        folder.append("images");
        folder.append(File.separator);
        folder.append("merchandise");
        folder.append(File.separator);
        folder.append("sysSource");
        folder.append(File.separator);
        folder.append(DateUtils.getYear());
        folder.append(File.separator);
        folder.append(DateUtils.getMonth());
        FileUtils.createDirectory(folder.toString());
    }

}
