<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'selserverInfomation.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
	<link type="text/css" rel="stylesheet"
		href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet"
		href="<%=basePath%>serm/css/easyui.css">
	<script type="text/javascript"
		src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>

<style type="text/css">
#fuwuqixxbut {
	height:38px;
	width:100px;
	margin-bottom:0px;
	background:url(<%=basePath%>serm/images/fuwuqixxbut.jpg);
	background-repeat:no-repeat;
	margin-left:50px;
	float:left;
	color:#3fade0;
	font-size:16px;
	font-weight:bold;
	line-height:45px;
	text-align:center;
	cursor:pointer;
}
#cuid9{width:300px; word-break:break-all;padding-right:15px;line-height: 20px; }
#fuwuqixx {
	width:100%;
	height:245px;
	overflow-y:scroll;
}
#kehuxxbut {
	height:38px;
	width:100px;
	margin-bottom:0px;
	background-repeat:no-repeat;
	margin-left:30px;
	float:left;
	color:#FFF;
	font-size:16px;
	font-weight:bold;
	line-height:45px;
	text-align:center;
	cursor:pointer;
}
#kehuxx {
	width:100%;
	height:245px;
	overflow-y:scroll;
	display:none;
}
</style>
<script>
function outputvalue(){
       var m = <%= request.getSession().getAttribute("servID")%>  
       //alert("m="+m);
		$('#dd').datagrid({
			fit:true,
			pageSize:15,
			fitColumns:false,
			rownumbers:true,
			pageList:[2,10,15,20],			
			nowrap: true,						//把数据显示在一行里,可以自动换行
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:'cms/getLogersUps.do?strinID='+m,		
			loadMsg:'数据正在加载...',						
			remoteSort:false,	
            columns:[[
	              {title:'服务器名称',field:'sername',width:'150',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'操作人',field:'logMen',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'具体操作',field:'logOper',width:'250',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'时间',field:'logTime',width:'150',rowspan:2,align:'center',sortable:true,resizable:false}
	              ]],
			pagination:true,
			rownumbers:false
			 
		});
		
	    displayMsg();
	}
  function displayMsg(){
		$('#dd').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
	
  }
 function fuwuqi()
 { 
   document.getElementById("fuwuqixx").style.display="Block"
   document.getElementById("kehuxx").style.display="none"
   document.getElementById("fuwuqixxbut").style.background="url(<%=basePath%>serm/images/fuwuqixxbut.jpg)"
   document.getElementById("kehuxxbut").style.background="none"
   document.getElementById("kehuxxbut").style.color="#FFF"
   document.getElementById("fuwuqixxbut").style.color="#3fade0"
   }
  function kehu()
  { 
   //alert(111);
   document.getElementById("kehuxx").style.display="Block";
   document.getElementById("fuwuqixx").style.display="none"
   document.getElementById("kehuxxbut").style.background="url(<%=basePath%>serm/images/fuwuqixxbut.jpg)"
   document.getElementById("kehuxxbut").style.color="#3fade0"
   document.getElementById("fuwuqixxbut").style.color="#FFF"
   document.getElementById("fuwuqixxbut").style.background="none"
   customerInfo();
   }
   function customerInfo(){
       var m = <%= request.getSession().getAttribute("servID")%>
       //alert(222+","+m);
       var mi = "pms";
       $.getJSON("cms/show_showallServer.do",{strinID : m,strinFlag:mi},function callback(result){
               $('#cuid1').html(result.upserID);
               $('#cuid2').html(result.custerCompany);
               $('#cuid3').html(result.customerPhone);
               $('#cuid4').html(result.custerString);
               $('#cuid5').html(result.serverPort);
               $('#cuid6').html(result.netWidth);
               $('#cuid7').html(result.countIP);
               $('#cuid8').html(result.exchangeMatch);
               $('#cuid9').html(result.numberIP);
               $('#cuid10').html(result.admOperString);
               $('#cuid11').html(result.uptimeString);
               $('#cuid12').html(result.downtimeString);
              
       });
   }
</script>
</head>
<body>
<!--服务器信息框-->
<div style=" width:90%; height:320px; background:url(<%=basePath%>serm/images/jiguixx-bg.jpg); background-repeat:repeat-x; margin-top:30px;" >
  <div style=" width:100%; height:320px; background:url(<%=basePath%>serm/images/jiguixx-left.jpg); background-repeat:no-repeat; background-position:left;">
    <div style=" width:100%; height:320px; background:url(<%=basePath%>serm/images/jiguixx-right.jpg); background-repeat:no-repeat; background-position:right;">
      <!--选项卡按钮-->
      <div style=" width:100%; height:38px; overflow:hidden;">
        <div id="fuwuqixxbut" onclick="fuwuqi()">服务器信息</div>
        <div id="kehuxxbut" onclick="kehu()">上架单信息</div>
      </div>
      <!--服务器信息框-->
      <div id="fuwuqixx">
        <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" style=" font-size:12px;">
          <s:iterator value="#session.titleList" var="ms" id="pm" status="ps">
          <tr>
             <td width="50%" height="30px" style=" border-bottom:#CCC double 1px; text-indent:15px;"><s:property value="key"/>:</td>
             <td width="50%" height="30px" style=" border-bottom:#CCC double 1px; border-left:#CCC double 1px; text-indent:15px;"><s:property value="value"/></td>
          </tr>
          </s:iterator>  
        </table>
      </div>
      <!--客户信息框-->
      <div id="kehuxx">
        <table width="95%"  border="0" cellspacing="0" cellpadding="0" align="center" style=" font-size:12px;">
          <tr>
            <td class="fwqxxwz1">上架单号：</td>
            <td class="fwqxxwz2"><div id="cuid1"></div></td>
            <td class="fwqxxwz1">客户公司名称:</td>
            <td class="fwqxxwz2"><div id="cuid2"></div></td>
          </tr>
          <tr>
            <td class="fwqxxwz1">客户联系方式:</td>
            <td class="fwqxxwz2"><div id="cuid3"></div></td>
            <td class="fwqxxwz1">公司负责人：</td>
            <td class="fwqxxwz2"><div id="cuid4"></div></td>
          </tr>
          <tr>
            <td class="fwqxxwz1">端口号：</td>
            <td class="fwqxxwz2"><div id="cuid5"></div></td>
            <td class="fwqxxwz1">带宽：</td>
            <td class="fwqxxwz2"><div id="cuid6"></div></td>
          </tr>
          <tr>
            <td class="fwqxxwz1">IP个数：</td>
            <td class="fwqxxwz2"><div id="cuid7"></div></td>
            <td class="fwqxxwz1">交换机名称：</td>
            <td class="fwqxxwz2"><div id="cuid8"></div></td>
          </tr>
          <tr>
            <td class="fwqxxwz1">IP号：</td>
            <td class="fwqxxwz2"><div id="cuid9"></div></td>
            <td class="fwqxxwz1">操作人：</td>
            <td class="fwqxxwz2"><div id="cuid10"></div></td>
          </tr>
          <tr>
            <td class="fwqxxwz1">上架时间：</td>
            <td class="fwqxxwz2"><div id="cuid11"></div></td>
            <td class="fwqxxwz1">下架时间：</td>
            <td class="fwqxxwz2"><div id="cuid12"></div></td>
          </tr>
         
        </table>
      </div>
      <div style=" margin-bottom:10px; margin-left:10px; height:30px; width:122px;  
        background-repeat:no-repeat; text-indent:10px; font-size:14px; line-height:25px;color:#3fade0; cursor:pointer;" onclick="outputvalue()">
                                  查看日志信息
        </div>
      
    </div>
  </div>
</div>
<!--服务器日志框-->
<div style=" width:90%; height:207px; background:url(<%=basePath%>serm/images/rizhi-bg.jpg); background-repeat:repeat-x; margin-top:15px;">
  <div style=" width:100%; height:207px; background:url(<%=basePath%>serm/images/rizhi-left.jpg); background-repeat:no-repeat; background-position:left;">
    <div style=" width:100%; height:207px; background:url(<%=basePath%>serm/images/rizhi-right.jpg); background-repeat:no-repeat; background-position:right;">
      <div style="width:80%; height:38px; background:url(<%=basePath%>serm/images/rizhi-title.jpg); background-repeat:no-repeat; margin-left:50px;"></div>
<!--日志表格-->
      <div style="width:100%; height:155px; overflow-y:scroll;">
        <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" style=" font-size:12px;" id="dd">
         
        </table>
      </div>
    </div>
  </div>
</div>

</body>
</html>

