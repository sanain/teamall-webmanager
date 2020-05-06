package com.jq.support.service.utils.excel.fieldtype;

import java.util.List;

import com.google.common.collect.Lists;
import com.jq.support.common.utils.Collections3;
import com.jq.support.common.utils.SpringContextHolder;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.sys.SysRole;
import com.jq.support.service.sys.SystemService;

/**
 * 字段类型转换
 * @author 
 * @version 2013-5-29
 */
public class RoleListType {

	private static SystemService systemService = SpringContextHolder.getBean(SystemService.class);
	
	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		List<SysRole> roleList = Lists.newArrayList();
		List<SysRole> allRoleList = systemService.findAllRole();
		for (String s : StringUtils.split(val, ",")){
			for (SysRole e : allRoleList){
				if (StringUtils.trimToEmpty(s).equals(e.getName())){
					roleList.add(e);
				}
			}
		}
		return roleList.size()>0?roleList:null;
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null){
			@SuppressWarnings("unchecked")
			List<SysRole> roleList = (List<SysRole>)val;
			return Collections3.extractToString(roleList, "name", ", ");
		}
		return "";
	}
	
}
