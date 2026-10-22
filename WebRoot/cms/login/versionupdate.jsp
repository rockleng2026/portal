<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎页</title>
<link href="../css/admin.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="weizhi">
<div id="weizhiwz">当前位置&nbsp;>>&nbsp;首页</div>
</div>
<table style="width:100%; height:430px; margin:0 auto;">
 
<tr>
<td width="100%" height="330px">
<form style="width:95%; height:330px;overflow-y: scroll;border:#CCC 1px double; margin: 0 auto; text-indent:20px;">
<br/><br/>
<p style=" font-weight: bold;">CMS版本更新说明</p>
<p>1.0 文章的基本管理(发布、编辑、查看、审核) 
</p>
<p>1.1 文章加入titlepic(标题图片，便于列表显示如果是图文的话显示标题图片) 
</p>
<p>1.2 文章加入模板管理，暂写出4个模板(首页、栏目页、内容页、最新页面模板)，添加、修改和生成静态页面 
     备注：这里的模板内容暂时未启用,生成静态页面时根据模板文件菜单里的jsp页面去生成的 
</p>
<p>1.3 模板文件管理，启用目录管理功能，锁定模板文件所在目录，并对其中的内容进行管理 在线编辑模板文件 
<p>1.4 追加了配置文件管理和对生成的静态文件的管理</p> 

<p>…………</p>
<p>1.28  静态页面中实现浏览量统计 
</p>
<p>1.29  栏目页面分页静态化 
</p>
<p>1.30  增加了评论功能，在动态情况下显示在线留言列表并实现在线添加留言以及分页 
</p>
<p>1.31  增加了评论审核功能 后台审核和前台显示 审核管理-信息审核-评论审核 已经评论管理 
</p>
<p>1.32  增加了生成静态页面条件评论留言和分页 
</p>
<p>1.33  增加了文章的一切用户操作(顶，踩，收藏，分享)，并实现了设置cookie值1分钟内不能重复点击 
</p>
<p>1.34  修复了评论功能中的提交后无法显示正常列表的bug
</p>
<p>1.35  </p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;1.修改了栏目管理 加入了多级栏目表现 
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;2.栏目下拉中层级体现 以前只有2级显示-->可以无限极显示
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;3.文章管理中加入id 限制id及所属子类的文章
//
</p>
<p style=" font-weight: bold;">华强网络科技站点-编写
</p>
<p>2.1 各个功能点加入topid-分类别来处理 区别出游戏站点和华强站点
</p>
<p>2.2 InitContent初始化加入全局参数共系统调用</p>
<p>2.3 推荐位置也加入全局参数供系统共系统全局调用</p>
<p>2.4 增加密钥验证机制规则(暂提供个接口)</p>
<p>2.5 生成静态页面部分重写</p>
</form>
</td>
</tr>
<tr>
<td width="100%" height="100">

  <img src="../images/shouye-title.jpg" width="360" height="58" style=" float:right; margin-right:25px; margin-top:10px;" /></td>
</tr>
</table>
  
</body>
</html>

