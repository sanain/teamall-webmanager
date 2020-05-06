package com.jq.support.service.utils.excel.fieldtype;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 字段类型转换
 * @author ThinkGem
 * @version 2013-03-10
 */
public class OfficeType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		for (SysOffice e : SysUserUtils.getOfficeList()){
			if (StringUtils.trimToEmpty(val).equals(e.getName())){
				return e;
			}
		}
		return null;
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((SysOffice)val).getName() != null){
			return ((SysOffice)val).getName();
		}
		return "";
	}
}
