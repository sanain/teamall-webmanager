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
import com.jq.support.model.order.EbAftersale;
import com.jq.support.model.order.EbSalesrecord;
import com.jq.support.model.order.PmReturnGoodIntervene;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.order.EbAftersaleService;
import com.jq.support.service.merchandise.order.EbSalesrecordService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 管理平台
 * 协商历史
 * @author Li-qi
 */
@Controller
@RequestMapping(value = "${adminPath}/AfterSale")
public class EbAfterSaleController extends BaseController{
	private static String domainurl = Global.getConfig("domainurl");
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private EbSalesrecordService ebSalesrecordService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	
	@ModelAttribute
	public EbAftersale get(@RequestParam(required=false) String saleId) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(saleId)){
			return ebAftersaleService.getebAftersale(saleId);
		}else{
			return new EbAftersale();
		}
	}
	
	@RequiresPermissions("merchandise:AfterSale:view")
	@RequestMapping(value = {"aftersalelist",""})
	public String aftersalelist(EbAftersale ebAftersale, HttpServletRequest request, HttpServletResponse response, Model model){
		String shopId= request.getParameter("shopId");
		String saleNo= request.getParameter("saleNo");
		String applicationType=request.getParameter("applicationType");
		String refundStatus=request.getParameter("refundStatus");
		if(StringUtils.isNotEmpty(shopId)){
			ebAftersale.setShopId(Integer.valueOf(shopId));
		}
		if(StringUtils.isNotEmpty(applicationType)){
			ebAftersale.setApplicationType(Integer.parseInt(applicationType));
		}
		if(StringUtils.isNotEmpty(refundStatus)){
			ebAftersale.setRefundStatus(Integer.parseInt(refundStatus));
		}
		if(StringUtils.isNotEmpty(saleNo)){
			ebAftersale.setSaleNo(saleNo);
		}
		String orderNo= request.getParameter("orderNo");
		String mobileNo= request.getParameter("mobileNo");
		String startTime= request.getParameter("startTime");
		String endTime= request.getParameter("endTime");
		Page<EbAftersale> page=ebAftersaleService.pageEbAftersaleList(ebAftersale, orderNo, mobileNo, startTime, endTime,new Page<EbAftersale>(request, response));
		model.addAttribute("page", page);
		model.addAttribute("shopId", shopId);
		model.addAttribute("saleNo", saleNo);
		model.addAttribute("applicationType", applicationType);
		model.addAttribute("refundStatus", refundStatus);
		return "modules/shopping/aftersale/aftersaleList";
	}
	
	@ResponseBody
	@RequestMapping(value = {"salesrecordlist"})
	public List<EbSalesrecord> salesrecordlist(HttpServletRequest request, HttpServletResponse response){
		String saleId= request.getParameter("saleId");
		EbSalesrecord ebSalesrecord=new EbSalesrecord();
		if(StringUtils.isNotEmpty(saleId)){
			ebSalesrecord.setSaleId(Integer.valueOf(saleId));
		}
		List<EbSalesrecord> salesrecords=ebSalesrecordService.getEbSalesrecordList(ebSalesrecord,2);
		if(salesrecords.size()>0&&salesrecords!=null){
			for(EbSalesrecord img:salesrecords){
				if(img.getRecordObjType()==1){
					EbUser ebUser=ebUserService.getEbUser(img.getRecordObjId().toString());
					if(ebUser!=null){
						img.setRecordObjName(ebUser.getUsername());
						img.setRecordObjImg(ebUser.getAvataraddress());
					}
				}
				if(img.getRecordObjType()==2){
					PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(img.getRecordObjId().toString());
					if(pmShopInfo!=null){
						img.setRecordObjName(pmShopInfo.getShopName());
						img.setRecordObjImg(pmShopInfo.getShopLogo());
					}
				}
				if(StringUtils.isNotEmpty(img.getRecordEvidencePicUrl())){
					String[] aStrings=img.getRecordEvidencePicUrl().split(",");
					img.setImgList(aStrings);
				}
			}
			return salesrecords;
		}
		return null;
	}
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		EbAftersale ebAftersale=new EbAftersale();
		String syllable[]= request.getParameterValues("syllable");
		String shopId= request.getParameter("shopId");
		String saleNo= request.getParameter("saleNo");
		String applicationType=request.getParameter("applicationType");
		String refundStatus=request.getParameter("refundStatus");
		if(StringUtils.isNotEmpty(shopId)){
			ebAftersale.setShopId(Integer.valueOf(shopId));
		}
		if(StringUtils.isNotEmpty(applicationType)){
			ebAftersale.setApplicationType(Integer.parseInt(applicationType));
		}
		if(StringUtils.isNotEmpty(refundStatus)){
			ebAftersale.setRefundStatus(Integer.parseInt(refundStatus));
		}
		if(StringUtils.isNotEmpty(saleNo)){
			ebAftersale.setSaleNo(saleNo);
		}
		String orderNo= request.getParameter("orderNo");
		String mobileNo= request.getParameter("mobileNo");
		String startTime= request.getParameter("startTime");
		String endTime= request.getParameter("endTime");
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
					 cell.setCellValue("用户账号");
				    }
				    if(syllable[i].equals("2")){
					 cell.setCellValue("退款编号");
					}
				    if(syllable[i].equals("3")){
					 cell.setCellValue("退款原因");
					}
				    if(syllable[i].equals("4")){
					 cell.setCellValue("申请类型");
					}
				    if(syllable[i].equals("5")){
					 cell.setCellValue("申请时间");
					}
				    if(syllable[i].equals("6")){
					 cell.setCellValue("退款金额");
					}
				    if(syllable[i].equals("7")){
					 cell.setCellValue("退款说明");
					}
				    if(syllable[i].equals("8")){
					 cell.setCellValue("收货状态");
					}
				    if(syllable[i].equals("9")){
					 cell.setCellValue("退款状态");
					}
					 cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while(t==1){
				  Page<EbAftersale> page=ebAftersaleService.pageEbAftersaleList(ebAftersale, orderNo, mobileNo, startTime, endTime,new Page<EbAftersale>(pageNo, rowNums));
				  List<EbAftersale> ebAftersales=new ArrayList<EbAftersale>();
				  ebAftersales=page.getList();
				  if ((page.getCount() == rowNums && pageNo > 1)
							|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					  ebAftersales = null;
					}
				  if(ebAftersales!=null&&ebAftersales.size()>0){
						for (EbAftersale goodIntervene : ebAftersales) {
						try {
							//SmsUserblacklist userblacklist=smsUserblacklists.get(i);
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
							 if(syllable[i].equals("1")){
								EbUser ebUser= ebUserService.getEbUser(goodIntervene.getUserId().toString());
								 row.createCell((short) i).setCellValue(ebUser.getMobile());
							    }
							    if(syllable[i].equals("2")){
							    	row.createCell((short) i).setCellValue(goodIntervene.getSaleNo());
								}
							    
							    if(syllable[i].equals("3")){
							    	row.createCell((short) i).setCellValue(goodIntervene.getTravelingApplicants());
								}
							    if(syllable[i].equals("4")){
							    	String Application="";
							    	if(goodIntervene.getApplicationType()==0){
							    		Application="退货退款";
							    	}else if(goodIntervene.getApplicationType()==1){
							    		Application="退款";
							    	}else if(goodIntervene.getApplicationType()==2){
							    		Application="换货";
							    	}
							    	row.createCell((short) i).setCellValue(Application);
								}
							    if(syllable[i].equals("5")){
							    	row.createCell((short) i).setCellValue(DateUtil.convertDateToString(goodIntervene.getApplicationTime()));
								}
							    if(syllable[i].equals("6")){
							    	row.createCell((short) i).setCellValue(goodIntervene.getDeposit());
								}
							    if(syllable[i].equals("7")){
							    		row.createCell((short) i).setCellValue(goodIntervene.getRefundExplain());
								}
							    if(syllable[i].equals("8")){
							    	String Application="";
							    	if(goodIntervene.getTakeStatus()==0){
							    		Application="未发货";
							    	}else if(goodIntervene.getTakeStatus()==1){
							    		Application="未收货";
							    	}else if(goodIntervene.getTakeStatus()==2){
							    		Application="已收货";
							    	}
							    		row.createCell((short) i).setCellValue(Application);
								}
							    if(syllable[i].equals("9")){
							    	String Application="";
							    	if(goodIntervene.getRefundStatus()==1){
							    		Application="待卖家处理";
							    	}else if(goodIntervene.getRefundStatus()==2){
							    		Application="卖家已拒绝";
							    	}else if(goodIntervene.getRefundStatus()==3){
							    		Application="退款成功";
							    	}else if(goodIntervene.getRefundStatus()==4){
							    		Application="关闭退款";
							    	}else if(goodIntervene.getRefundStatus()==5){
							    		Application="等待买家退货";
							    	}else if(goodIntervene.getRefundStatus()==6){
							    		Application="等待卖家确认收货";
							    	}else if(goodIntervene.getRefundStatus()==7){
							    		Application="等待买家确认收款";
							    	}else if(goodIntervene.getRefundStatus()==8){
							    		Application="等待卖家退款";
							    	}else if(goodIntervene.getRefundStatus()==9){
							    		Application="平台已介入处理";
							    	}
							    		row.createCell((short) i).setCellValue(Application);
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