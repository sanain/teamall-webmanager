package com.jq.support.main.controller.merchandise.mecontent;

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
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.PmSysDailyStatis;
import com.jq.support.model.user.PmSysLoveStatistics;
import com.jq.support.service.merchandise.mecontent.PmSysLoveStatisticsService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;



@Controller
@RequestMapping(value = "${adminPath}/PmSysLoveStatistics")
public class PmSysLoveStatisticsController extends BaseController {
	   @Autowired
	   private PmSysLoveStatisticsService pmSysLoveStatisticsService ;
	   

		private static String domainurl = Global.getConfig("domainurl");
		private static String innerImgPartPath = "src=\"/uploads/images/";
		private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
		
		@ModelAttribute
		public PmSysLoveStatistics get(@RequestParam(required=false) String id) {
			if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
				return pmSysLoveStatisticsService.getPmSysLoveStatistics(id);
			}else{
				return new  PmSysLoveStatistics();
			}
		}
		
		@RequiresPermissions("merchandise:PmSysLoveStatistics:view")
		@RequestMapping(value = {"list", ""})
		public String getProductList(
				PmSysLoveStatistics pmSysLoveStatistics ,String statrDate,String stopDate,
				HttpServletRequest request, HttpServletResponse response, Model model){
			    Page<PmSysLoveStatistics> page=pmSysLoveStatisticsService.getPage(new Page<PmSysLoveStatistics>(request, response),pmSysLoveStatistics, statrDate, stopDate);
			    model.addAttribute("page", page);
			    model.addAttribute("statrDate", statrDate);
			    model.addAttribute("stopDate", stopDate);
			    model.addAttribute("pmSysLoveStatistics", pmSysLoveStatistics);
			    return "modules/shopping/Article/PmSysLoveStatisticsList";
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
				HSSFSheet sheet = wb.createSheet("今日统计列表");
				HSSFRow row = sheet.createRow((int) 0);
				HSSFCellStyle style = wb.createCellStyle();
				style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
				HSSFCell cell = row.createCell((short) 0);
				cell.setCellValue("序号");
				cell.setCellStyle(style);
				for (int i = 0; i < syllable.length; i++) {
						 cell = row.createCell((short) i);
					    if(syllable[i].equals("1")){
						 cell.setCellValue("统计日期");
					    }
					    if(syllable[i].equals("2")){
						 cell.setCellValue("期初存总积分数");
						}
					    if(syllable[i].equals("3")){
						 cell.setCellValue("当日增加积分数");
						}
					    if(syllable[i].equals("4")){
						 cell.setCellValue("当日减少积分数");
						}
					    if(syllable[i].equals("5")){
						 cell.setCellValue("期末结存总积分数");
						}
						 cell.setCellStyle(style);
				}
				SysUser currentUser = SysUserUtils.getUser();
				while(t==1){
					String statrDate= request.getParameter("statrDate");
					String stopDate=request.getParameter("stopDate");
					PmSysLoveStatistics pmSysLoveStatistics =new PmSysLoveStatistics();
					Page<PmSysLoveStatistics> page=pmSysLoveStatisticsService.getPage(new Page<PmSysLoveStatistics>(pageNo, rowNums),pmSysLoveStatistics, statrDate, stopDate);
					List<PmSysLoveStatistics> sysDailyStatis=new ArrayList<PmSysLoveStatistics>();
					sysDailyStatis=page.getList();
					  if ((page.getCount() == rowNums && pageNo > 1)
								|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
						  sysDailyStatis = null;
						}
					  if(sysDailyStatis!=null&&sysDailyStatis.size()>0){
							for (PmSysLoveStatistics agentAmtLog : sysDailyStatis) {
							try {
								row = sheet.createRow((int) rowNum);
								row.createCell((short) 0).setCellValue(rowNum);
								for (int i = 0; i < syllable.length; i++) {
								 if(syllable[i].equals("1")){
									 row.createCell((short) i).setCellValue(agentAmtLog.getCreateTime().toString());
								    }
								    if(syllable[i].equals("2")){
								    	row.createCell((short) i).setCellValue(agentAmtLog.getBeginLove());
									}
								    if(syllable[i].equals("3")){
								    	row.createCell((short) i).setCellValue(agentAmtLog.getTodayAddLove());
									}
								    if(syllable[i].equals("4")){
								    	row.createCell((short) i).setCellValue(agentAmtLog.getTodayReduceLove());
									}
								    if(syllable[i].equals("5")){
								    	row.createCell((short) i).setCellValue(agentAmtLog.getEndLove());
									}
								}
							} catch (Exception e) {
								System.out.print(e.getCause());
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
