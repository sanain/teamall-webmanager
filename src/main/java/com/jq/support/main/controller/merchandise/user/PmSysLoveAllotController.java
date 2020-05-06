package com.jq.support.main.controller.merchandise.user;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
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
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.PmSysLoveAllot;
import com.jq.support.service.merchandise.user.PmSysLoveAllotService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;


@Controller
@RequestMapping(value = "${adminPath}/PmSysLoveAllot")
public class PmSysLoveAllotController extends BaseController {
	
	private static String domainurl = Global.getConfig("domainurl");
	
   @Autowired
   private PmSysLoveAllotService pmSysLoveAllotService;
	@ModelAttribute
	public PmSysLoveAllot get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmSysLoveAllotService.get(id);
		}else{
			return new PmSysLoveAllot();
		}
	}
	
	@RequestMapping(value ={"list",""})
	public String list(PmSysLoveAllot pmSysLoveAllot,HttpServletRequest request, HttpServletResponse response, Model model){
		String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
		Page<PmSysLoveAllot> page =pmSysLoveAllotService.getPage( pmSysLoveAllot, new Page<PmSysLoveAllot>(request, response), statrDate, stopDate);
		model.addAttribute("page", page);
		model.addAttribute("pmSysLoveAllot", pmSysLoveAllot);
		model.addAttribute("statrDate", statrDate);
		model.addAttribute("stopDate", stopDate);
		return "modules/shopping/user/pmSysLoveAllotList";
	}
	
	@ResponseBody
	@RequestMapping(value = "fenpei")
	public String fenpei(String zhishu,String idinfo,HttpServletRequest request, HttpServletResponse response) {
		if(StringUtils.isNotBlank(idinfo)){
			PmSysLoveAllot pmSysLoveAllot= pmSysLoveAllotService.get(idinfo);
			if(pmSysLoveAllot!=null){
				pmSysLoveAllotService.updatePmSysLoveAllotStatus(pmSysLoveAllot);
//				pmSysLoveAllotService.fenpei(idinfo, zhishu);
//				if(pmSysLoveAllot.getActualAmt()>0){
//				NcInformationConfiguration ncInfor = ncInfoService
//						.getNcInformationConfiguration();
//				ncPortWareHouseService.PmSysLoveAllot(ncInfor, 4, 11, pmSysLoveAllot);
//				}
			}
		}
		return "00";
	}
	
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url = "";
		String syllable[] = request.getParameterValues("syllable");
		String payStatus = request.getParameter("payStatus");
		String orderNo = request.getParameter("orderNo");
		String status = request.getParameter("status");
		String onoffLineStatus = request.getParameter("onoffLineStatus");
		if (syllable != null && syllable.length > 0) {
			int t = 1;
			int pageNo = 1;
			int rowNum = 1;
			int rowNums = 100000;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("订单列表");
			HSSFRow row = sheet.createRow((int) 0);
			HSSFCellStyle style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("序号");
			cell.setCellStyle(style);
			for (int i = 0; i < syllable.length; i++) {
				cell = row.createCell((short) i);
				if (syllable[i].equals("1")) {
					cell.setCellValue("统计时间");
				}
				if (syllable[i].equals("2")) {
					cell.setCellValue("平台总积分数");
				}
				if (syllable[i].equals("3")) {
					cell.setCellValue("分配红包总数");
				}
				if (syllable[i].equals("4")) {
					cell.setCellValue("商家昨日让利总额");
				}
				if (syllable[i].equals("5")) {
					cell.setCellValue("红包指数");
				}
				if (syllable[i].equals("6")) {
					cell.setCellValue("实际分配总额");
				}
				if (syllable[i].equals("7")) {
					cell.setCellValue("税费");
				}
				if (syllable[i].equals("8")) {
					cell.setCellValue("费率");
				}
				if (syllable[i].equals("9")) {
					cell.setCellValue("分配时间");
				}
				cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while (t == 1) {
				String statrDate = request.getParameter("statrDate");
				String s = request.getParameter("s");
				String stopDate = request.getParameter("stopDate");
				String types = request.getParameter("type");
				PmSysLoveAllot pmSysLoveAllot = new PmSysLoveAllot();
				Page<PmSysLoveAllot> page = pmSysLoveAllotService.getPage(
						pmSysLoveAllot, new Page<PmSysLoveAllot>(pageNo, rowNums), statrDate,
						stopDate);
				List<PmSysLoveAllot> pmSysLoveAllots = new ArrayList<PmSysLoveAllot>();
				pmSysLoveAllots = page.getList();
				if ((page.getCount() == rowNums && pageNo > 1)
						|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					pmSysLoveAllots = null;
				}
				if (pmSysLoveAllots != null && pmSysLoveAllots.size() > 0) {
					for (PmSysLoveAllot pmSysLoveAllot1 : pmSysLoveAllots) {
						try {
							// SmsUserblacklist
							// userblacklist=smsUserblacklists.get(i);
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
								if (syllable[i].equals("1")) {
									if ( pmSysLoveAllot1.getStartTime() != null 
											&& pmSysLoveAllot1.getEndTime() != null) {
										row.createCell((short) i).setCellValue(
												pmSysLoveAllot1.getStartTime() +"~"+ pmSysLoveAllot1.getEndTime());
									} else {
										row.createCell((short) i).setCellValue(
												"");
									}
								}
								if (syllable[i].equals("2")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getTotalAmt().toString());
								}
								if (syllable[i].equals("3")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getLoveNum().toString());
								}
								if (syllable[i].equals("4")) {
										row.createCell((short) i).setCellValue(
												pmSysLoveAllot1.getTotalAmt().toString());
								}
								if (syllable[i].equals("5")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getExponential().toString());
								}
								if (syllable[i].equals("6")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getActualAmt().toString());
								}
								if (syllable[i].equals("7")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getFee().toString());
								}
								if (syllable[i].equals("8")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getRatio().toString());
								}
								if (syllable[i].equals("9")) {
									row.createCell((short) i).setCellValue(
											pmSysLoveAllot1.getAllotTime());
								}
							}
						} catch (Exception e) {
						}
						rowNum++;
					}
					pageNo++;
				} else {
					t = 2;
				}
			}
			String RootPath = request.getSession().getServletContext()
					.getRealPath("/").replace("\\", "/");
			String path = "upload/xlsfile/tempfile";
			Random r = new Random();
			String strfileName = DateUtil.getDateFormat(new Date(),
					"yyyyMMddHHmmss") + r.nextInt();
			File f = new File(RootPath + path);
			// 不存在则创建它
			if (!f.exists())
				f.mkdirs();
			String tempPath = RootPath + path + "/" + strfileName + ".xls";
			try {
				FileOutputStream fout = new FileOutputStream(tempPath);
				wb.write(fout);
				fout.close();
				url = domainurl + "/" + path + "/" + strfileName + ".xls";
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {

		}
		return url;
	}
   
}
