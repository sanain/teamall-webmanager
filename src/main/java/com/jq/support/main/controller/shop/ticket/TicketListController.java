//package com.jq.support.main.controller.shop.ticket;
//
//import com.jq.support.common.persistence.Page;
//import com.jq.support.model.ticket.EbDictionaries;
//import com.jq.support.model.ticket.EbRecommend;
//import com.jq.support.model.ticket.EbTicket;
//import com.jq.support.model.user.EbUser;
//import com.jq.support.service.ticket.EbDictionariesService;
//import com.jq.support.service.ticket.EbRecommendService;
//import com.jq.support.service.ticket.EbTicketService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
///**
// * 小票模板
// */
//@Controller
//@RequestMapping(value = "${adShopPath}/ticket/")
//public class TicketListController {
//
//    @Autowired
//    private EbDictionariesService ebDictionariesService;
//
//    @Autowired
//    private EbTicketService ebTicketService;
//
//    @Autowired
//    private EbRecommendService ebRecommendService;
//
//    @RequestMapping(value = "ticketList")
//    public String index (HttpServletRequest request, HttpServletResponse response, Model model){
//        EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
//        Page<EbTicket> page=ebTicketService.getPageList(new Page<EbTicket>(request, response), ebUser.getShopId().toString());
//        model.addAttribute("page", page);
//        return "modules/shop/ticket/ticketList";
//    }
//
//
//    @RequestMapping(value = "ticketForm")
//    public String insert (HttpServletRequest request, HttpServletResponse response, Model model){
//        //查询默认模板
//        EbRecommend ebRecommend=ebRecommendService.getEbRecommend();
//        model.addAttribute("ebRecommend",ebRecommend);
//        model.addAttribute("ticket",new EbTicket());
//        return "modules/shop/ticket/ticketForm";
//    }
//
//    /**
//     * 预览模板
//     * @param ebRecommend
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping(value = "replace",method = RequestMethod.POST)
//    public Map<String,Object> replace(EbRecommend ebRecommend){
//        Map<String,Object> map=new HashMap<String, Object>();
//        try{
//            //字典集合
//            List<EbDictionaries> list=ebDictionariesService.getlist(1);
//            for (EbDictionaries ebDictionaries : list) {
//                ebRecommend.setTemplateText(ebRecommend.getTemplateText().replace(ebDictionaries.getParameter(),ebDictionaries.getLable()));
//            }
//            map.put("obj",ebRecommend);
//            map.put("msg", "成功");
//            map.put("code", "00");
//        }catch (Exception e){
//            e.printStackTrace();
//            map.put("msg", "系统出错");
//            map.put("code", "01");
//        }
//        return map;
//    }
//    /**
//     * 小票预览
//     * @param request
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping(value = "ebTicketReplace",method = RequestMethod.POST)
//    public Map<String,Object> ebTicketReplace(HttpServletRequest request){
//        Map<String,Object> map=new HashMap<String, Object>();
//        try{
//            String id=request.getParameter("id");//小票id
//            EbTicket ebTicket=ebTicketService.get(Integer.parseInt(id));
//            //字典集合
//            List<EbDictionaries> list=ebDictionariesService.getlist(1);
//            String templateText=ebTicket.getTemplateText();
//            for (EbDictionaries ebDictionaries : list) {
//                templateText=templateText.replace(ebDictionaries.getParameter(),ebDictionaries.getLable());
//            }
//            map.put("templateText",templateText);
//            map.put("ebTicket",ebTicket);
//            map.put("msg", "成功");
//            map.put("code", "00");
//        }catch (Exception e){
//            e.printStackTrace();
//            map.put("msg", "系统出错");
//            map.put("code", "01");
//        }
//        return map;
//    }
//    /**
//     * 添加模板
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping(value = "insertTicket",method = RequestMethod.POST)
//    public Map<String,Object> insertTicket(EbTicket ebTicket, HttpServletRequest request){
//        Map<String,Object> map=new HashMap<String, Object>();
//        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
//        try{
//            ebTicket.setDel(0);
//            ebTicket.setCreationTime(new Date());
//            ebTicket.setShopId(ebUser.getShopId());
//            ebTicket.setState(0);
//            ebTicketService.save(ebTicket);
//            map.put("obj",ebDictionariesService.getlist(1));
//            map.put("msg", "成功");
//            map.put("code", "00");
//        }catch (Exception e){
//            e.printStackTrace();
//            map.put("msg", "系统出错");
//            map.put("code", "01");
//        }
//        return map;
//    }
//    /**
//     * 删除模板
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping(value = "delTicket",method = RequestMethod.POST)
//    public Map<String,Object> delTicket(HttpServletRequest request){
//        Map<String,Object> map=new HashMap<String, Object>();
//        String id=request.getParameter("id");
//        try{
//            EbTicket ebTicket=ebTicketService.get(Integer.parseInt(id));
//            ebTicket.setDel(1);
//            ebTicketService.save(ebTicket);
//            map.put("msg", "删除模板成功");
//            map.put("code", "00");
//        }catch (Exception e){
//            e.printStackTrace();
//            map.put("msg", "系统出错");
//            map.put("code", "01");
//        }
//        return map;
//    }
//    /**
//     * 更改模板启用和禁用状态
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping(value = "stateTicket",method = RequestMethod.POST)
//    public Map<String,Object> stateTicket(HttpServletRequest request){
//        Map<String,Object> map=new HashMap<String, Object>();
//        EbUser ebUser = (EbUser) request.getSession().getAttribute("shopuser");
//        String id=request.getParameter("id");
//        try{
//            ebTicketService.findEbTicketState(ebUser.getShopId());
//            EbTicket ebTicket=ebTicketService.get(Integer.parseInt(id));
//            //切换状态
//            ebTicket.setState((ebTicket.getState()==null||ebTicket.getState()==0)?1:0);
//            ebTicketService.save(ebTicket);
//            map.put("msg", "更改模板状态成功");
//            map.put("code", "00");
//        }catch (Exception e){
//            e.printStackTrace();
//            map.put("msg", "系统出错");
//            map.put("code", "01");
//        }
//        return map;
//    }
//    /**
//     * 字典
//     * @return
//     */
//    @ResponseBody
//    @RequestMapping(value = "getEbDictionaries",method = RequestMethod.POST)
//    public Map<String,Object> getEbDictionaries(){
//        Map<String,Object> map=new HashMap<String, Object>();
//        try{
//            map.put("obj",ebDictionariesService.getlist(1));
//            map.put("msg", "成功");
//            map.put("code", "00");
//        }catch (Exception e){
//            e.printStackTrace();
//            map.put("msg", "系统出错");
//            map.put("code", "01");
//        }
//        return map;
//    }
//
//
//}
