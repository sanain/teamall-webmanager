package com.jq.support.main.controller.shop;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.shop.PmShopUser;
import com.jq.support.model.shop.PmShopUserAmt;
import com.jq.support.model.statement.PmShopUserStatistics;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysRole;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.shop.PmShopUserAmtService;
import com.jq.support.service.merchandise.shop.PmShopUserService;
import com.jq.support.service.statement.PmShopUserSourceStatisticsService;
import com.jq.support.service.statement.PmShopUserStatisticsService;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.SysUserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 门店人员Controller
 *
 * @author
 */
@Controller
@RequestMapping(value = "${adShopPath}/shop/user")
public class ShopUserController extends BaseController {
    @Autowired
    private PmShopUserStatisticsService pmShopUserStatisticsService;
    @Autowired
    private PmShopUserSourceStatisticsService pmShopUserSourceStatisticsService;
    @Autowired
    private PmShopUserService pmShopUserService;
    @Autowired
    private PmShopUserAmtService pmShopUserAmtService;

    /***
     * 员工列表
     * @param meduser
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping({"list", ""})
    public String list(PmShopUser meduser, String isSuccess , HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
        Page<PmShopUser> page = pmShopUserService.findUser(new Page<PmShopUser>(request, response), ebUser,meduser,statrDate,stopDate);
        model.addAttribute("page", page);
        model.addAttribute("meduser", meduser);
        model.addAttribute("isSuccess", isSuccess);
        
        model.addAttribute("statrDate", statrDate);
        model.addAttribute("stopDate", stopDate);

        return "modules/shop/shopUserList";
    }

    /**
     * 新增页面
     * @return
     */
    @RequestMapping("form")
    public String form(HttpServletRequest request,Model model) {
        String id=request.getParameter("id");
        if(id!=null){
            PmShopUser pmShopUser =pmShopUserService.getUser(Integer.parseInt(id));
            model.addAttribute("user",pmShopUser);
            model.addAttribute("type",1);
        }else{
        	PmShopUser pmShopUser=new PmShopUser();
        	pmShopUser.setIsPrinting(0);
            model.addAttribute("user",pmShopUser);
            model.addAttribute("type",0);
        }
        return "modules/shop/shopUserForm";
    }

    /**
     * 删除
     *
     * @param id
     * @param redirectAttributes
     * @return
     */

    @RequestMapping("delete")
    public String delete(Integer id, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        PmShopUser meduser=pmShopUserService.getUser(id);
        meduser.setDel(1);
        pmShopUserService.updateUser(meduser);
        addMessage(redirectAttributes, "删除用户成功");
        return "redirect:" + Global.getConfig("adShopPath") + "/shop/user/list?office.isAgent=0&company.isAgent=0";
    }

    /**
     * 修改
     * @param meduser
     * @return
     */
    @RequestMapping("update")
    public String update(PmShopUser meduser, HttpServletRequest request) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        if(meduser.getCreateTime()==null){
            meduser.setCreateTime(new Date());
        }
        if(meduser.getDel()==null){
            meduser.setDel(0);
        }
        if(meduser.getShopId()==null){
            meduser.setShopId(ebUser.getShopId());
        }

        if(meduser.getStatus()==null){
            meduser.setStatus(1);
        }
        boolean result = pmShopUserService.updateUser(meduser);
        Integer isSuccess = result ? 1 : 0; //1 成功 0 失败
        return "redirect:" + Global.getConfig("adShopPath") + "/shop/user/list?isSuccess="+isSuccess+"&office.isAgent=0&company.isAgent=0";
    }

    @RequestMapping("updateStatus")
    public String updateStatus(Integer id,HttpServletRequest request){
        PmShopUser meduser=pmShopUserService.getUser(id);
        if(meduser.getStatus()==1){
            meduser.setStatus(0);
        }else{
            meduser.setStatus(1);
        }
        pmShopUserService.updateUser(meduser);
        return "redirect:" + Global.getConfig("adShopPath") + "/shop/user/list?office.isAgent=0&company.isAgent=0";
    }



    @RequestMapping(value="performanceList")
    public String handoverList(HttpServletRequest request , HttpServletResponse response
            , Model model , PmShopUser pmShopUser){

        if(pmShopUser.getShopId() == null){
            return "modules/shop/performanceList";
        }

        //查询交班的主表
        Page<PmShopUserStatistics> page = pmShopUserStatisticsService.getListByPmShopUser(pmShopUser, new Page<PmShopUserStatistics>(request, response));

        List<Integer> ids = new ArrayList<Integer>();
        for(PmShopUserStatistics pus: page.getList()){
            ids.add(pus.getShopUserId());
        }

        //查询交班人员列表
        List<PmShopUser> shopUsersList = pmShopUserService.getShopUsersByIds(ids);

        model.addAttribute("page" , page);
        model.addAttribute("pmShopUser" , pmShopUser);
        model.addAttribute("shopUsersList" , shopUsersList);

        return "modules/shop/performanceList";
    }
    
    /***
     * 员工提成列表
     * @param meduser
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping({"amtList"})
    public String amtList(PmShopUserAmt pmShopUserAmt, HttpServletRequest request, HttpServletResponse response, Model model) {
        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
        String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
        Page<PmShopUserAmt> page = pmShopUserAmtService.findUserAmtLlist(new Page<PmShopUserAmt>(request, response), ebUser,pmShopUserAmt,statrDate,stopDate);
       
        for(PmShopUserAmt pmShopUserAmt2: page.getList()){
        	PmShopUser pmShopUser=pmShopUserService.getUser(pmShopUserAmt2.getShopUserId());
        	pmShopUserAmt2.setPmShopUser(pmShopUser);
        }
        
        model.addAttribute("page", page);
        model.addAttribute("pmShopUserAmt", pmShopUserAmt);
        
        model.addAttribute("statrDate", statrDate);
        model.addAttribute("stopDate", stopDate);

        return "modules/shop/shopUserAmtList";
    }
}
