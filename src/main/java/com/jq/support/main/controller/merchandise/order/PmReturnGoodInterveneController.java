package com.jq.support.main.controller.merchandise.order;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.PmReturnGoodIntervene;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.order.PmReturnGoodInterveneService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 御可贡茶_退款申请介入 Controller
 * @author Li-qi
 *
 */

@Controller
@RequestMapping(value = "${adminPath}/ReturnGoodIntervene")
public class PmReturnGoodInterveneController extends BaseController{

	@Autowired
	private PmReturnGoodInterveneService pmReturnGoodInterveneService;
	@Autowired
	private EbUserService ebUserService;
	
	private static String domainurl = Global.getConfig("domainurl");
	@ModelAttribute
	public PmReturnGoodIntervene get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmReturnGoodInterveneService.getebaAftersale(Integer.valueOf(id));
		}else{
			return new PmReturnGoodIntervene();
		}
	}
	
	@RequiresPermissions("merchandise:ReturnGoodIntervene:view")
	@RequestMapping(value = {"list",""})
	public String list(PmReturnGoodIntervene pmReturnGoodIntervene, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<PmReturnGoodIntervene> page=pmReturnGoodInterveneService.pagePmReturnGoodIntervenePage(pmReturnGoodIntervene,new Page<PmReturnGoodIntervene>(request, response));
		model.addAttribute("page", page);
		model.addAttribute("pmReturnGoodIntervene", pmReturnGoodIntervene);
		return "modules/shopping/aftersale/returngoodinterveneList";
	}
	
	@RequiresPermissions("merchandise:ReturnGoodIntervene:view")
	@RequestMapping(value = {"form"})
	public String form(PmReturnGoodIntervene pmReturnGoodIntervene, HttpServletRequest request, HttpServletResponse response, Model model){
		model.addAttribute("pmReturnGoodIntervene", pmReturnGoodIntervene);
		String msg= request.getParameter("msg");
		if(pmReturnGoodIntervene.getInterveneStatus()!=null){
			if(pmReturnGoodIntervene.getInterveneStatus()<3){
				pmReturnGoodIntervene.setInterveneStatus(3);
				pmReturnGoodIntervene.setUpdateTime(new Date());
				pmReturnGoodInterveneService.save(pmReturnGoodIntervene);
			}
		}
		if(StringUtils.isNotBlank(pmReturnGoodIntervene.getUserEvidencePicUrl())){
			String[] imgs=pmReturnGoodIntervene.getUserEvidencePicUrl().split(",");
			pmReturnGoodIntervene.setUserEvidencePicUrlList(imgs);
		}
		if(StringUtils.isNotBlank(pmReturnGoodIntervene.getShopEvidencePicUrl())){
			String[] imgs=pmReturnGoodIntervene.getShopEvidencePicUrl().split(",");
			pmReturnGoodIntervene.setShopEvidencePicUrlList(imgs);
		}
		if(StringUtils.isNotBlank(msg)&&msg.equals("1")){
			model.addAttribute("message", "保存成功");
		}
		model.addAttribute("pmReturnGoodIntervene", pmReturnGoodIntervene);
		return "modules/shopping/aftersale/returngoodinterveneForm";
	}
	
	@RequiresPermissions("merchandise:ReturnGoodIntervene:edit")
	@RequestMapping(value = {"edit"})
	public String edit(PmReturnGoodIntervene pmReturnGoodIntervene, HttpServletRequest request, HttpServletResponse response, Model model){
		if(pmReturnGoodIntervene.getId()!=null){
			pmReturnGoodIntervene.setInterveneStatus(4);
			pmReturnGoodIntervene.setUpdateTime(new Date());
			pmReturnGoodInterveneService.save(pmReturnGoodIntervene);
//			model.addAttribute("message", "修改成功");
			model.addAttribute("pmReturnGoodIntervene", pmReturnGoodIntervene);
			return "redirect:"+Global.getAdminPath()+"/ReturnGoodIntervene/form?msg=1&id="+pmReturnGoodIntervene.getId();
		}
		return "redirect:"+Global.getAdminPath()+"/ReturnGoodIntervene";
	}
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String syllable[]= request.getParameterValues("syllable");
		String interveneStatus=request.getParameter("interveneStatus");
		if(syllable!=null&&syllable.length>0){
			int t=1;
			int pageNo=1;
			int rowNum=1;
			int rowNums=100000;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("平台介入列表");
			HSSFRow row = sheet.createRow((int) 0);
			HSSFCellStyle style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("序号");
			cell.setCellStyle(style);
			for (int i = 0; i < syllable.length; i++) {
					 cell = row.createCell((short) i);
				    if(syllable[i].equals("1")){
					 cell.setCellValue("退款申请编号");
				    }
				    if(syllable[i].equals("2")){
					 cell.setCellValue("介入状态");
					}
				    if(syllable[i].equals("3")){
					 cell.setCellValue("用户账号");
					}
				    if(syllable[i].equals("4")){
					 cell.setCellValue("用户问题描述");
					}
				    if(syllable[i].equals("5")){
					 cell.setCellValue("用户提交时间");
					}
				    if(syllable[i].equals("6")){
					 cell.setCellValue("商家");
					}
				    if(syllable[i].equals("7")){
					 cell.setCellValue("商家问题描述");
					}
				    if(syllable[i].equals("8")){
					 cell.setCellValue("商家提交时间");
					}
				    if(syllable[i].equals("9")){
					 cell.setCellValue("创建时间");
					}
					 cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while(t==1){
				  PmReturnGoodIntervene pmReturnGoodIntervene=new PmReturnGoodIntervene();
				  if(StringUtils.isNotBlank(interveneStatus)){
					  pmReturnGoodIntervene.setInterveneStatus(Integer.parseInt(interveneStatus));
				  }
				  Page<PmReturnGoodIntervene> page=pmReturnGoodInterveneService.pagePmReturnGoodIntervenePage(pmReturnGoodIntervene,new Page<PmReturnGoodIntervene>(pageNo, rowNums));
				  List<PmReturnGoodIntervene> pmReturnGoodIntervenes=new ArrayList<PmReturnGoodIntervene>();
				  pmReturnGoodIntervenes=page.getList();
				  if ((page.getCount() == rowNums && pageNo > 1)
							|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					  pmReturnGoodIntervenes = null;
					}
				  if(pmReturnGoodIntervenes!=null&&pmReturnGoodIntervenes.size()>0){
						for (PmReturnGoodIntervene goodIntervene : pmReturnGoodIntervenes) {
						try {
							//SmsUserblacklist userblacklist=smsUserblacklists.get(i);
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
							 if(syllable[i].equals("1")){
								 row.createCell((short) i).setCellValue(goodIntervene.getAftersale().getSaleNo());
							    }
							    if(syllable[i].equals("2")){
							    	String InterveneStatus="";
							    	if(goodIntervene.getInterveneStatus()==1){
							    		InterveneStatus="买家申请介入";
							    	}else if(goodIntervene.getInterveneStatus()==2){
							    		InterveneStatus="卖家申请介入";
							    	}else if(goodIntervene.getInterveneStatus()==3){
							    		InterveneStatus="平台客服处理中";
							    	}else if(goodIntervene.getInterveneStatus()==4){
							    		InterveneStatus="平台客服已完成处理";
							    	}
							    	row.createCell((short) i).setCellValue(InterveneStatus);
								}
							    
							    if(syllable[i].equals("3")){
							    	row.createCell((short) i).setCellValue(goodIntervene.getUser().getMobile());
								}
							    if(syllable[i].equals("4")){
							    	row.createCell((short) i).setCellValue(goodIntervene.getUserProblemDesc());
								}
							    if(syllable[i].equals("5")){
							    	row.createCell((short) i).setCellValue(DateUtil.convertDateToString(goodIntervene.getUserSubmitTime()));
								}
							    if(syllable[i].equals("6")){
							    	row.createCell((short) i).setCellValue(goodIntervene.getShopInfo().getShopName());
								}
							    if(syllable[i].equals("7")){
							    		row.createCell((short) i).setCellValue(goodIntervene.getShopProblemDesc());
								}
							    if(syllable[i].equals("8")){
							    		row.createCell((short) i).setCellValue(DateUtil.convertDateToString(goodIntervene.getShopSubmitTime()));
								}
							    if(syllable[i].equals("9")){
							    		row.createCell((short) i).setCellValue(DateUtil.convertDateToString(goodIntervene.getCreateTime()));
								}
							}
						} catch (Exception e) {
							/*System.out.print(e.getCause());*/
						}
						rowNum++;
					 }
						pageNo++;
				}else{
					t=2;
				}
			}
//			JSONObject json=new JSONObject();
//			String code="01";
			String RootPath = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
			String path = "uploads/xlsfile/tempfile";
			Random r = new Random();
			String strfileName = DateUtil.getDateFormat(new Date(),
			"yyyyMMddHHmmss") + r.nextInt();
			File f = new File(RootPath + path);
			// 不存在则创建它
			if (!f.exists())
				f.mkdirs();
			String tempPath = RootPath + path + "/" + strfileName + ".xls";
			try
			{
				FileOutputStream fout = new FileOutputStream(tempPath);
				wb.write(fout);
				fout.close();
				url= domainurl+"/" + path + "/" + strfileName + ".xls";
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}else{
			
		}
		return url;
	}
}