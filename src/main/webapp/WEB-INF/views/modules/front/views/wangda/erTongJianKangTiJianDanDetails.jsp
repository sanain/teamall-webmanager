<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>

<body>
<style type="text/css"> 
	
	*{padding: 0;margin: 0;font-family:"5FAE8F6F96C59ED1", "Microsoft Yahei";list-style-type: none;}

	body{padding: 15px;}
	table{width: 730px;margin: 0 auto;border-left: 1px solid #bbc6dd;border-top: 1px solid #bbc6dd}
	table td{border-right: 1px solid #bbc6dd;border-bottom: 1px solid #bbc6dd;height: 35px;line-height: 35px;color: #888d95;font-size: 14px;}
	table td.indent{text-indent: 20px}
	h1{font-size: 30px;padding-bottom: 10px;color: #404d5e;font-weight: normal;text-align: center;}
	.bard{width: 60px;height: 1px ;background: #0186d5;margin: 0 auto 30px auto}
	</style>

<h1>儿童体检报告详情</h1>
<table cellspacing="0" cellpadding="0">
	<tr>
		<td width="25%" align="center">身高/cm</td>
		<td width="75%" class="indent">${am.height}</td>
	</tr>
	<tr>
		<td width="25%" align="center">体重/kg</td>
		<td width="75%" class="indent">${am.weight}</td>
	</tr>
	<tr>
		<td width="25%" align="center">新生儿面色代码(儿童面色代码表  1:红润)</td>
		<td width="75%" class="indent">${am.childComplexion}</td>
	</tr>
	<tr>
		<td width="25%" align="center"> 可疑佝偻病症状代码(可疑佝偻病症状代码表  1:无)</td>
		<td width="75%" class="indent">${am.suspiciousRickets}</td>
	</tr>
	<tr>
		<td width="25%" align="center">可疑佝偻病体征代码(可疑佝偻病体征代码表  1:无)</td>
		<td width="75%" class="indent">${am.suspiciousSignsRickets}</td>
	</tr>
	<tr>
		<td width="25%" align="center">步态异常标志</td>
		<td width="75%" class="indent">${am.abnormalGait}</td>
	</tr>
	<tr>
		<td width="25%" align="center">皮肤检查异常标志</td>
		<td width="75%" class="indent">${am.abnormalSkinExamination}</td>
	</tr>
	<tr>
		<td width="25%" align="center">前囟闭合标志</td>
		<td width="75%" class="indent">${am.anteriorFontanelleClosedSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">头围/cm</td>
		<td width="75%" class="indent">${am.headCircumference}</td>
	</tr>
	<tr>
		<td width="25%" align="center">颈部包块标志</td>
		<td width="75%" class="indent">${am.neckBlockMark}</td>
	</tr>
	<tr>
		<td width="25%" align="center">颈部包块检查结果描述</td>
		<td width="75%" class="indent">${am.neckBlockResultDescription}</td>
	</tr>
	<tr>
		<td width="25%" align="center">左眼裸眼远视力值</td>
		<td width="75%" class="indent">${am.leftNakedEye}</td>
	</tr>
	<tr>
		<td width="25%" align="center">右眼裸眼远视力值</td>
		<td width="75%" class="indent">${am.rightNakedEye}</td>
	</tr>
	
	
	
	
	
	
	
	<tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrectEye}</td>
	</tr><tr>
		<td width="25%" align="center">右眼矫正远视力值</td>
		<td width="75%" class="indent">${am.rightCorrectEye}</td>
	</tr><tr>
		<td width="25%" align="center">眼外观检查异常标志</td>
		<td width="75%" class="indent">${am.abnormalAppearanceEye}</td>
	</tr><tr>
		<td width="25%" align="center">眼外观检查异常结果描述</td>
		<td width="75%" class="indent">${am.abnormalAppearanceEyeDescription}</td>
	</tr><tr>
		<td width="25%" align="center">耳外观检查异常标志</td>
		<td width="75%" class="indent">${am.earAppearanceCheckSigns}</td>
	</tr><tr>
		<td width="25%" align="center">耳外观检查异常结果描述</td>
		<td width="75%" class="indent">${am.earAppearanceCheckSignsDescription}</td>
	</tr><tr>
		<td width="25%" align="center">新生儿听力筛查结果代码</td>
		<td width="75%" class="indent">${am.neonatalHearingScreening}</td>
	</tr><tr>
		<td width="25%" align="center">口腔检查异常标志</td>
		<td width="75%" class="indent">${am.oralCavityCheckSigns}</td>
	</tr><tr>
		<td width="25%" align="center">口腔检查异常结果描述</td>
		<td width="75%" class="indent">${am.oralCavityCheckSignsDescription}</td>
	</tr><tr>
		<td width="25%" align="center">出牙数/颗</td>
		<td width="75%" class="indent">${am.teechNumber}</td>
	</tr><tr>
		<td width="25%" align="center">龋齿数/颗 </td>
		<td width="75%" class="indent">${am.cariesNumber}</td>
	</tr><tr>
		<td width="25%" align="center">心脏听诊异常标志</td>
		<td width="75%" class="indent">${am.cardiacAuscultationSign}</td>
	</tr><tr>
		<td width="25%" align="center">心脏听诊异常结果描述</td>
		<td width="75%" class="indent">${am.cardiacAuscultationDescription}</td>
	</tr><tr>
		<td width="25%" align="center">肺部听诊异常标志</td>
		<td width="75%" class="indent">${am.lungAuscultationSign}</td>
	</tr><tr>
		<td width="25%" align="center">肺部听诊异常结果描述</td>
		<td width="75%" class="indent">${am.lungAuscultationDescription}</td>
	</tr><tr>
		<td width="25%" align="center">腹部触诊异常标志</td>
		<td width="75%" class="indent">${am.abdominalPalpationSign}</td>
	</tr><tr>
		<td width="25%" align="center">腹部触诊异常结果描述</td>
		<td width="75%" class="indent">${am.abdominalPalpationDescription}</td>
	</tr><tr>
		<td width="25%" align="center">脐带脱落标志</td>
		<td width="75%" class="indent">${am.umbilicalCordSign}</td>
	</tr><tr>
		<td width="25%" align="center">脐带检查结果</td>
		<td width="75%" class="indent">${am.umbilicalCordCheckResult}</td>
	</tr>
	
	
	<tr>
		<td width="25%" align="center">四肢活动度异常标志</td>
		<td width="75%" class="indent">${am.limbActivitySign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">四肢活动度异常结果描述</td>
		<td width="75%" class="indent">${am.limbActivityDescription}</td>
	</tr><tr>
		<td width="25%" align="center">脊柱检查异常标志</td>
		<td width="75%" class="indent">${am.spineExaminationSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">脊柱检查异常结果描述</td>
		<td width="75%" class="indent">${am.spineExaminationDescription}</td>
	</tr><tr>
		<td width="25%" align="center">外生殖器检查异常标志</td>
		<td width="75%" class="indent">${am.aedeaSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">外生殖器检查异常结果描述</td>
		<td width="75%" class="indent">${am.aedeaDescription}</td>
	</tr>
	<tr>
		<td width="25%" align="center">肛门检查异常标志</td>
		<td width="75%" class="indent">${am.anusSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">肛门检查异常结果描述</td>
		<td width="75%" class="indent">${am.anusSignDescription}</td>
	</tr>
	<tr>
		<td width="25%" align="center">户外活动时长 小时/天</td>
		<td width="75%" class="indent">${am.outdoorActivities}</td>
	</tr>
	<tr>
		<td width="25%" align="center">两次随访间患病标志</td>
		<td width="75%" class="indent">${am.twoFollowIntervalSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">两次随访间患肺炎住院次数</td>
		<td width="75%" class="indent">${am.twoFollowPneumoniaNumber}</td>
	</tr>
	<tr>
		<td width="25%" align="center">两次随访间患腹泻住院次数</td>
		<td width="75%" class="indent">${am.twoFollowDiarrheaNumber}</td>
	</tr>
	<tr>
		<td width="25%" align="center">两次随访间因外伤住院次数</td>
		<td width="75%" class="indent">${am.twoFollowTraumaNumber}</td>
	</tr>
	<tr>
		<td width="25%" align="center">两次随访间患其他疾病情况</td>
		<td width="75%" class="indent">${am.twoFollowOtherNumber}</td>
	</tr><tr>
		<td width="25%" align="center">血红蛋白数量 g/L</td>
		<td width="75%" class="indent">${am.hemoglobin}</td>
	</tr>
	<tr>
		<td width="25%" align="center">用药剂量 单次IU/d</td>
		<td width="75%" class="indent">${am.dosage}</td>
	</tr>
	<tr>
		<td width="25%" align="center">用药频率 次/日</td>
		<td width="75%" class="indent">${am.drugFrequency}</td>
	</tr>
	<tr>
		<td width="25%" align="center">年龄别身高评价结果</td>
		<td width="75%" class="indent">${am.heightResult}</td>
	</tr>
	<tr>
		<td width="25%" align="center">年龄别体重评价结果 </td>
		<td width="75%" class="indent">${am.wieghtResult}</td>
	</tr>
	<tr>
		<td width="25%" align="center">儿童体格发育评价结果</td>
		<td width="75%" class="indent">${am.sevelopmentResulkt}</td>
	</tr>
	<tr>
		<td width="25%" align="center">儿童发育评估通过标志</td>
		<td width="75%" class="indent">${am.sevelopmentSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">儿童健康指导类别代码</td>
		<td width="75%" class="indent">${am.healthGuidanceCode}</td>
	</tr>
	<tr>
		<td width="25%" align="center">转诊标志</td>
		<td width="75%" class="indent">${am.transferTreatmentSign}</td>
	</tr>
	<tr>
		<td width="25%" align="center">转诊科室</td>
		<td width="75%" class="indent">${am.transferTreatmentDep}</td>
	</tr>
	
	
	<tr>
		<td width="25%" align="center">转诊医院名称</td>
		<td width="75%" class="indent">${am.transferTreatmentOrgName}</td>
	</tr><tr>
		<td width="25%" align="center">下次随访日期</td>
		<td width="75%" class="indent">${am.nextVisitDate}</td>
	</tr><tr>
		<td width="25%" align="center">前囟横径/cm</td>
		<td width="75%" class="indent">${am.diameterAnteriorFontanel}</td>
	</tr><tr>
		<td width="25%" align="center">前囟纵径/cm</td>
		<td width="75%" class="indent">${am.anteriorLongitudinalDiameter}</td>
	</tr><tr>
		<td width="25%" align="center">前囟张力</td>
		<td width="75%" class="indent">${am.anteriorFontanelTension}</td>
		</tr>	
	
</body>
</html>

