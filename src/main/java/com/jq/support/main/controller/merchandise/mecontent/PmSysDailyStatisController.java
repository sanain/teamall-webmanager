package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.PmAgentAmtLog;
import com.jq.support.model.product.Clinetversion;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.PmAgentBank;
import com.jq.support.model.user.PmSysDailyStatis;
import com.jq.support.service.merchandise.user.PmSysDailyStatisService;
import com.jq.support.service.utils.CommonFile;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;


@Controller
@RequestMapping(value = "${adminPath}/PmSysDailyStatis")
public class PmSysDailyStatisController extends BaseController {
   @Autowired
   private PmSysDailyStatisService pmSysDailyStatisService;
   

	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public PmSysDailyStatis get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmSysDailyStatisService.getPmSysDailyStatis(id);
		}else{
			return new  PmSysDailyStatis();
		}
	}
	
	@RequiresPermissions("merchandise:PmSysDailyStatis:view")
	@RequestMapping(value = {"list", ""})
	public String getProductList(
			PmSysDailyStatis pmSysDailyStatis ,String statrDate,String stopDate,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmSysDailyStatis> page=pmSysDailyStatisService.getPageList(pmSysDailyStatis, new Page<PmSysDailyStatis>(request, response), statrDate, stopDate);
		    model.addAttribute("page", page);
		    model.addAttribute("statrDate",statrDate);
		    model.addAttribute("stopDate", stopDate);
		    model.addAttribute("pmSysDailyStatis", pmSysDailyStatis);
		    return "modules/shopping/Article/PmSysDailyStatisList";
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
		folder.append("images" );
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("file");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
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
						String projectName = Global.getConfig("projectName");
					 cell.setCellValue("当天产生总"+projectName+"数");
					}
				    if(syllable[i].equals("3")){
					 cell.setCellValue("让利金额");
					}
				    if(syllable[i].equals("4")){
					 cell.setCellValue("今日新增资金池金额");
					}
				    if(syllable[i].equals("5")){
					 cell.setCellValue("资金池余额");
					}
					 cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while(t==1){
				String statrDate= request.getParameter("statrDate");
				String stopDate=request.getParameter("stopDate");
				PmSysDailyStatis pmSysDailyStatis=new PmSysDailyStatis();
				Page<PmSysDailyStatis> page=pmSysDailyStatisService.getPageList(pmSysDailyStatis, new Page<PmSysDailyStatis>(pageNo, rowNums), statrDate, stopDate);
				List<PmSysDailyStatis> sysDailyStatis=new ArrayList<PmSysDailyStatis>();
				sysDailyStatis=page.getList();
				  if ((page.getCount() == rowNums && pageNo > 1)
							|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					  sysDailyStatis = null;
					}
				  if(sysDailyStatis!=null&&sysDailyStatis.size()>0){
						for (PmSysDailyStatis agentAmtLog : sysDailyStatis) {
						try {
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
							 if(syllable[i].equals("1")){
								 row.createCell((short) i).setCellValue(agentAmtLog.getCreateTime());
							    }
							    if(syllable[i].equals("2")){
							    	row.createCell((short) i).setCellValue(agentAmtLog.getRewardLove());
								}
							    if(syllable[i].equals("3")){
							    	row.createCell((short) i).setCellValue(agentAmtLog.getOrderAmt());
								}
							    if(syllable[i].equals("4")){
							    	row.createCell((short) i).setCellValue(agentAmtLog.getDayPoolAmt());
								}
							    if(syllable[i].equals("5")){
							    	row.createCell((short) i).setCellValue(agentAmtLog.getPoolAmt());
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
