<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>增加图片</title>

</head>

<body>

	<div class="r_main" style="margin-top:10px;">
		<div class="r_content">
			<div class="r_content_1">
				<form action="${ctxweb}/jsonMini/index" method="post" name="form1"
					id="form1" enctype="multipart/form-data">

					<table border="0" class="tb_Style" width="98%"
						style="margin:0 auto;">
						<tr>
							<td colspan="3" class="td_title" height="30">&nbsp;信息&nbsp;</label>
							</td>
						</tr>

						<tr>
							<td height="20" align="left" class="td_border">&nbsp;&nbsp;上传图片：</td>
							<td class="td_border"><textarea id="content" name="content"style="margin: 0px; height: 209px; width: 1649px;"
									rows="5" cols="50"></textarea> <label id="tishi"
								style="color:#F00"><font color="#FF0000">＊</font>
							</td>
						</tr>
						<tr>
							<td height="20" align="left" class="td_border">&nbsp;&nbsp;上传图片：</td>
							<td class="td_border"><input type="file" id="file" name="file" value="" /><font
								color="#FF0000">＊</font>
							</td>
						</tr>
						<tr>
							<td height="20" align="left" class="td_border">&nbsp;&nbsp;上传图片：</td>
							<td class="td_border"><input type="file" id="file" name="file" value="" /><font
								color="#FF0000">＊</font>
							</td>
						</tr>
						<tr>
							<td height="20" align="left" class="td_border">&nbsp;&nbsp;上传图片：</td>
							<td class="td_border"><input type="file" id="file" name="file" value="" /><font
								color="#FF0000">＊</font>
							</td>
						</tr>
						<tr>
							<td height="20" align="left" class="td_border">&nbsp;&nbsp;上传图片：</td>
							<td class="td_border"><input type="file" id="file" name="file" value="" /><font
								color="#FF0000">＊</font>
							</td>
						</tr>
						<tr>
							<td height="20" align="left" class="td_border">&nbsp;&nbsp;上传图片：</td>
							<td class="td_border"><input type="file" id="file" name="file" value="" /><font
								color="#FF0000">＊</font>
							</td>
						</tr>

						<tr>
							<td height="30" class="td_border" align="right">&nbsp;</td>
							<td height="30" class="td_border" align="left"><input
								name="submit" type="submit" class="rb1" id="queren" value="提交" />
								&nbsp; <input type="reset" value="重置设置" class="rb1" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>

</html>
