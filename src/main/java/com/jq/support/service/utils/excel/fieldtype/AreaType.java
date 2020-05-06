package com.jq.support.service.utils.excel.fieldtype;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.sys.SysArea;
import com.jq.support.service.utils.SysUserUtils;


/**
 * 字段类型转换
 * @author 
 * @version 
 */
public class AreaType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		for (SysArea e : SysUserUtils.getAreaList()){
			if (StringUtils.trimToEmpty(val).equals(e.getName())){
				return e;
			}
		}
		return null;
	}

	/**
	 * 获取对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((SysArea)val).getName() != null){
			return ((SysArea)val).getName();
		}
		return "";
	}
}
