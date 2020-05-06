<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="center">
					<div class="t1">
							<div class="l">
								<div class="tell"> 
								<p>客服电话： 400 - 1681120 </p>
								</div>
							</div>
							<div class="r"> 
										<ul>
												<%--<li><a href="javascript:" style="" class="search" id="seat">区域选择</a></li>
												--%><li><a href="${ctx}/search/search${urlSuffix}" style="" class="search ">搜索</a></li>
												<li><a href="${ctx}/appload" style="" class="user ">客户端</a></li>
												
												<c:set var="userinfo" value="${fnf:getUserInfo()}"/>
												
																																	
												<c:choose>
												   <c:when test="${userinfo eq null}">
												   		<li><a href="${ctx}/login" style="" class="loging ">登陆/注册</a></li>
												   </c:when>   
												   <c:otherwise> 
												        <li><a href="${ctx}/userinfo/baseinfo" style="" class="landed ">${userinfo.mobileNo}</a>，<a href="${ctx}/loginout" class="del">注销</a></li>
												   		
												   </c:otherwise>  
												</c:choose>
												
										</ul>	
							</div>
							</div>

					</div>
					
					
					
					
					<%--<div id="popwindow" class="addr-wrap " style="z-index: 19891020; position: absolute;  left: 855.078px; top: 40px; ">
					    <a class="close" href="javascript:" id="close_chuang"></a>
					    <div class="hot-city J_HotCity">
							<label>当前：</label>
								<ul>
									<li>
										<span id="nowCity">德阳</span>
									</li>
								</ul>
							</div>
					    <div class="area-content ">
					        <div class="province ">
										<p class="content-title">请选择地区:</p>
										<ul>
											<li>
												<a title="jiankangsichuan" href="http://www.jkscw.com.cn">德阳</a>
											</li>
										</ul>
									</div>
							</div>
					 </div>
					<script type="text/javascript">
						$("#popwindows").hide();
						$("#close_chuang").click(function(){
							$("#popwindow").hide();
						});
						$("#seat").click(function(){
							$("#popwindow").show();
						});
					</script> 
					<style type="text/css">
						  .addr-wrap  {
								background-color: #fff;
							    border: 1px solid #3d9ee9;
							    display: none;
							    font-size: 12px;
							    left: 147px;
							    padding: 15px 0 12px 20px;
							    position: absolute;
							    top: 58px;
							    width: 200px;
							}
							.close {
							    background: url("${ctx}/static/front/images/addr.png") no-repeat scroll 0 -48px;
							    height: 18px;
							    position: absolute;
							    right: 4px;
							    top: 10px;
							    width: 18px;
							}
							.hot-city label {
							    color: #f9a821;
							    float: left;
							    padding: 2px 0;
							    width: 40px;
							    border: 0 none;
							    font-size: 100%;
							    margin: 0;
							    vertical-align: baseline;
							    font-family: "Hiragino Sans GB","Microsoft YaHei","微软雅黑","宋体",Arial,Verdana,sans-serif;
							    font-weight: 400;
							    line-height: 16px;
							}
							.area-content ul li a {
							    color: #000;
							    display: block;
							    height: 20px;
							    margin-right: 6px;
							    overflow: hidden;
							    padding-left: 3px;
							    text-decoration: none;
							    text-overflow: ellipsis;
							    white-space: nowrap;
							    width: 55px;
							    border: 0 none;
							    font-size: 100%;
							    vertical-align: baseline;
							}
							.area-content ul li a:hover {
							    color: #000;
							    display: block;
							    background-color:#DFF2FF;
							    height: 20px;
							    margin-right: 6px;
							    overflow: hidden;
							    padding-left: 3px;
							    text-decoration: none;
							    text-overflow: ellipsis;
							    white-space: nowrap;
							    width: 55px;
							    border: 0 none;
							    font-size: 100%;
							    vertical-align: baseline;
							}
							.area-content ul {
							    line-height: 20px;
							    list-style: outside none none;
							}
							.area-content ul li {
							    float: left;
							    margin-bottom: 3px;
							    width: 64px;
							    border: 0 none;
							    font-size: 100%;
							    padding: 0;
							    vertical-align: baseline;
							}
							.area-content .content-title {
							    margin: 8px 0 4px;
							    border: 0 none;
							    font-size: 100%;
							    padding: 0;
							    vertical-align: baseline;
							    color: #333;
							    font-family: "Hiragino Sans GB","Microsoft YaHei","微软雅黑","宋体",Arial,Verdana,sans-serif;
							    font-size: 12px;
							    font-weight: 400;
							    line-height: 16px;
							}
							.hot-city ul li span {
							    color: #000;
							    display: block;
							    margin-right: 6px;
							    padding: 2px 3px;
							    text-decoration: none;
							    border: 0 none;
							    font-size: 100%;
							    vertical-align: baseline;
							}
							.hot-city{
								border-bottom: 1px solid #ccc;
							    height: 26px;
							    margin-right: 20px;
							    font-size: 100%;
							    padding: 0;
							    vertical-align: baseline;
							}
					</style>
					--%>