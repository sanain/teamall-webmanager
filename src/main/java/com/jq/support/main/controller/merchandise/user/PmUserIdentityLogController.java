package com.jq.support.main.controller.merchandise.user;

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
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmSensitiveWords;
import com.jq.support.model.user.PmUserIdentityLog;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmUserIdentityLogService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;




@Controller
@RequestMapping(value = "${adminPath}/PmUserIdentityLog")
public class PmUserIdentityLogController extends BaseController {
	@Autowired
	private PmUserIdentityLogService pmUserIdentityLogService;
	@Autowired
	private EbUserService ebUserService;
	private static String domainurl = Global.getConfig("domainurl");
	
	@ModelAttribute
	public PmUserIdentityLog get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmUserIdentityLogService.getPmUserIdentityLog(id);
		}else{
			return new PmUserIdentityLog();
		}
	}
	
	@RequiresPermissions("merchandise:PmUserIdentityLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmUserIdentityLog pmUserIdentityLog, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmUserIdentityLog> page=pmUserIdentityLogService.getPageList(pmUserIdentityLog, new Page<PmUserIdentityLog>(request, response));
		    model.addAttribute("page", page);
		    model.addAttribute("pmUserIdentityLog", pmUserIdentityLog);
		    return "modules/shopping/Article/PmUserIdentityLogList";
	}
	
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String syllable[]= request.getParameterValues("syllable");
		if(syllable!=null&&syllable.length>0){
			int t=1;
			int pageNo=1;
			int rowNum=1;
			int rowNums=100;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("身份列表");
			HSSFRow row = sheet.createRow((int) 0);
			HSSFCellStyle style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("序号");
			cell.setCellStyle(style);
			for (int i = 0; i < syllable.length; i++) {
					 cell = row.createCell((short) i);
				    if(syllable[i].equals("1")){
					 cell.setCellValue("账号");
				    }
				    if(syllable[i].equals("2")){
					 cell.setCellValue("状态");
					}
				    if(syllable[i].equals("3")){
					 cell.setCellValue("支付金额");
					}
				    if(syllable[i].equals("4")){
					 cell.setCellValue("开始时间");
					}
				    if(syllable[i].equals("5")){
					 cell.setCellValue("结束时间");
					}
				    if(syllable[i].equals("6")){
					 cell.setCellValue("最后修改人");
					}
					 cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while(t==1){
				PmUserIdentityLog pmUserIdentityLog=new PmUserIdentityLog();
				String acount= request.getParameter("acount");
				if(StringUtils.isNotBlank(acount)){
					pmUserIdentityLog.setAcount(acount);
				}
				Page<PmUserIdentityLog> page=pmUserIdentityLogService.getPageList(pmUserIdentityLog, new Page<PmUserIdentityLog>(pageNo,rowNums));
				List<PmUserIdentityLog> userIdentityLogs=new ArrayList<PmUserIdentityLog>();
				List list=page.getList();
				if(list!=null&&list.size()>0){
					for (int i = 0; i < list.size(); i++) {
						 Object[] objects=(Object[]) list.get(i);
						 userIdentityLogs.add((PmUserIdentityLog)objects[0]);
					}
				}
				  if ((page.getCount() == rowNums && pageNo > 1)
							|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					  userIdentityLogs = null;
					}
				  if(userIdentityLogs!=null&&userIdentityLogs.size()>0){
						for (PmUserIdentityLog userIdentityLog : userIdentityLogs) {
						try {
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
							   if(syllable[i].equals("1")){
								 EbUser ebUser= new EbUser();
								 if(userIdentityLog.getUserId()!=null){
									  ebUser= ebUserService.getEbUser(userIdentityLog.getUserId().toString());
								 }
								 row.createCell((short) i).setCellValue(ebUser.getMobile());
							    }
							    if(syllable[i].equals("2")){
							    	String type="";
							    	if(userIdentityLog.getStatus()==0){
							    		type="未支付";
							    	}else if(userIdentityLog.getStatus()==1){
							    		type="使用中";
							    	}else{
							    		type="已过期";
							    	}
							    	row.createCell((short) i).setCellValue(type);
								}
							    if(syllable[i].equals("3")){
							    	row.createCell((short) i).setCellValue(userIdentityLog.getAmt());
								}
							    if(syllable[i].equals("4")){
							    	row.createCell((short) i).setCellValue(userIdentityLog.getStartTime());
								}
							    if(syllable[i].equals("5")){
							    	row.createCell((short) i).setCellValue(userIdentityLog.getEndTime());
								}
							    if(syllable[i].equals("6")){
							    	row.createCell((short) i).setCellValue(userIdentityLog.getModifyUser());
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
			String RootPath = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
			String path = "uploads/xlsfile/tempfile";
			Random r = new Random();
			String strfileName = DateUtil.getDateFormat(new Date(),"yyyyMMddHHmmss") + r.nextInt();
			File f = new File(RootPath + path);
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
