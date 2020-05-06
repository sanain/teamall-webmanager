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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.model.user.PmAmtStatistics;
import com.jq.support.model.user.PmUserOfflineRechargeLog;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.merchandise.user.PmAmtStatisticsService;
import com.jq.support.service.utils.DateUtil;

/**
 * 用户提现列表功能
 * 御可贡茶_用户余额日志 Controller
 */
@Controller
@RequestMapping(value = "${adminPath}/UserAmtStatistics")
public class PmAmtStatisticsController extends BaseController {

	private static String domainurl = Global.getConfig("domainurl");
	
	@Autowired
	private PmAmtStatisticsService  pmAmtStatisticsService;
	@Autowired
	private PmAmtLogService  pmAmtLogService;
	
	@RequestMapping(value ={"list",""})
	public String list(HttpServletRequest request, HttpServletResponse response, Model model){
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		Page<PmAmtStatistics> page = pmAmtStatisticsService.findPmAmtStatisticsList( startTime, endTime, new Page<PmAmtStatistics>(request, response));
		model.addAttribute("page", page);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		return "modules/shopping/user/userAmtStatisticsList";
	}
	
	@RequestMapping(value ="orderlist")
	public String orderlist(HttpServletRequest request, HttpServletResponse response, Model model){
		String time = request.getParameter("time");
		String orderNo = request.getParameter("orderNo");
		String type = request.getParameter("amtType");
		String mobile = request.getParameter("mobile");
		Page<PmAmtLog> page = pmAmtLogService.findPmAmtStatisticsList(mobile, orderNo, time, type, new Page<PmAmtLog>(request, response));
		model.addAttribute("page", page);
		model.addAttribute("time", time);
		model.addAttribute("amtType", type);
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("mobile", mobile);
		return "modules/shopping/user/orderList";
	}

	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "statisticsExsel")
	public String statisticsExsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String syllable[] = request.getParameterValues("syllable");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		int t=1;
		int pageNo=1;
		int rowNum=1;
		int rowNums=100000;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("余额汇总");
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCell cell = row.createCell((short) 0);
		cell.setCellStyle(style);
		for (int i = 0; i < syllable.length+1; i++) {
			cell = row.createCell((short) i);
			if(i==0){
				cell.setCellValue("序号");
			}
			if(i==1){
					cell.setCellValue("日期");
			}
			if(i==2){
				cell.setCellValue("平台总余额");
			}
			if(i==3){
				cell.setCellValue("用户充值余额");
			}
			if(i==4){
				cell.setCellValue("分红金额");
			}
			if(i==5){
				cell.setCellValue("退款金额");
			}
			cell.setCellStyle(style);
		}
		while(t==1){
			Page<PmAmtStatistics> page = pmAmtStatisticsService.findPmAmtStatisticsList( startTime, endTime, new Page<PmAmtStatistics>(request, response));
			List<PmAmtStatistics> exsels=new ArrayList<PmAmtStatistics>();
			exsels=page.getList();
			if ((page.getCount() == rowNums && pageNo > 1)|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
				exsels = null;
			}
			if(exsels!=null&&exsels.size()>0){
				for (PmAmtStatistics exsel : exsels) {
					try {
						row = sheet.createRow((int) rowNum);
						row.createCell((short) 0).setCellValue(rowNum);
					for (int i = 0; i < syllable.length; i++) {
						if(syllable[i].equals("1")){
							row.createCell((short) i+1).setCellValue(exsel.getTime());
						}
						if(syllable[i].equals("2")){
							row.createCell((short) i+1).setCellValue(exsel.getTotalAmt());
						}
						if(syllable[i].equals("3")){
							row.createCell((short) i+1).setCellValue(exsel.getRecharge().doubleValue());
						}
						if(syllable[i].equals("4")){
							row.createCell((short) i+1).setCellValue(exsel.getTodayAmt());
						}
						if(syllable[i].equals("5")){
							row.createCell((short) i+1).setCellValue(exsel.getRefund());
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
		try{
			FileOutputStream fout = new FileOutputStream(tempPath);
			wb.write(fout);
			fout.close();
			url= domainurl+"/" + path + "/" + strfileName + ".xls";
//			url= "http://localhost:8080/sbsc-webmanager"+"/" + path + "/" + strfileName + ".xls";
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return url;
	}


	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "amtLogExsel")
	public String amtLogExsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String syllable[] = request.getParameterValues("syllable");
		String time = request.getParameter("time");
		String orderNo = request.getParameter("orderNo");
		String type = request.getParameter("amtType");
		String mobile = request.getParameter("mobile");		
		int t=1;
		int pageNo=1;
		int rowNum=1;
		int rowNums=100000;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("余额汇总");
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCell cell = row.createCell((short) 0);
		cell.setCellStyle(style);
		for (int i = 0; i < syllable.length+1; i++) {
			cell = row.createCell((short) i);
			if(i==0){
				cell.setCellValue("序号");
			}
			if(i==1){
					cell.setCellValue("交易时间");
			}
			if(i==2){
				cell.setCellValue("用户账号");
			}
			if(i==3){
				cell.setCellValue("订单类型");
			}
			if(i==4){
				cell.setCellValue("订单编号");
			}
			if(i==5){
				cell.setCellValue("交易金额");
			}
			cell.setCellStyle(style);
		}
		while(t==1){
			Page<PmAmtLog> page = pmAmtLogService.findPmAmtStatisticsList(mobile, orderNo, time, type, new Page<PmAmtLog>(request, response));
			List<PmAmtLog> exsels=new ArrayList<PmAmtLog>();
			exsels=page.getList();
			if ((page.getCount() == rowNums && pageNo > 1)|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
				exsels = null;
			}
			if(exsels!=null&&exsels.size()>0){
				for (PmAmtLog exsel : exsels) {
					try {
						row = sheet.createRow((int) rowNum);
						row.createCell((short) 0).setCellValue(rowNum);
					for (int i = 0; i < syllable.length; i++) {
						if(syllable[i].equals("1")){
							row.createCell((short) i+1).setCellValue(exsel.getCreateTime());
						}
						if(syllable[i].equals("2")){
							row.createCell((short) i+1).setCellValue(exsel.getEbUser().getMobile());
						}
						if(syllable[i].equals("4")){
							row.createCell((short) i+1).setCellValue(exsel.getEbOrder().getOrderNo());
						}
						if(syllable[i].equals("5")){
							row.createCell((short) i+1).setCellValue(exsel.getAmt());
						}
						if(syllable[i].equals("3")){
							String amtType = "";
							if(exsel.getAmtType() == 1){
								amtType = "购物";
							}else if(exsel.getAmtType() == 2){
								amtType = "充值";
							}else if(exsel.getAmtType() == 3){
								amtType = "返现";
							}else if(exsel.getAmtType() == 4){
								amtType = "提现";
							}else if(exsel.getAmtType() == 5){
								amtType = "积分兑现";
							}else if(exsel.getAmtType() == 6){
								amtType = "领取红包";
							}else if(exsel.getAmtType() == 7){
								String projectName = Global.getConfig("projectName");
								amtType = projectName+"奖励";
							}else if(exsel.getAmtType() == 8){
								amtType = "线下门店消费";
							}else if(exsel.getAmtType() == 9){
								amtType = "后台充值,转账";
							}else if(exsel.getAmtType() == 10){
								amtType = "线上贷款";
							}else if(exsel.getAmtType() == 11){
								amtType = "爱心奖励";
							}else if(exsel.getAmtType() == 12){
								amtType = "商家付款";
							}else if(exsel.getAmtType() == 13){
								amtType = "线下贷款";
							}else if(exsel.getAmtType() == 14){
								amtType = "退款";
							}else if(exsel.getAmtType() == 15){
								amtType = "购买精英合伙人";
							}else if(exsel.getAmtType() == 16){
								amtType = "线下充值";
							}
							row.createCell((short) i+1).setCellValue(amtType);
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
		try{
			FileOutputStream fout = new FileOutputStream(tempPath);
			wb.write(fout);
			fout.close();
			url= domainurl+"/" + path + "/" + strfileName + ".xls";
//			url= "http://localhost:8080/sbsc-webmanager"+"/" + path + "/" + strfileName + ".xls";
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return url;
	}
	
}