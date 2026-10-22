<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>资源核实单</title>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
.main { width:760px; margin:0 auto;}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
	.font_color_hui{ color:#8c8c8c;}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:810px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:818px; border:1px solid #455c32;  float:left}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; }
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}
.tab_border{ border:1px solid #e6dcdd; border-bottom:0px;border-top:0px;}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
.form_search{ margin-bottom:10px;}
.form_search td{ line-height:25px; }
.search_bt{ background-color:#7B7B7B; line-height:20px; color:#fff; display:block; width:50px; text-align:center}
.tj{ width:20px; color:#FF6600; text-align:center;}
.item dl{ float:left;}
.item .jg{color:#A0A0A0; font-weight:bold;}
.item span{ color:#FF6600;}
.item dt{ line-height:200%;color:#295A00; font-size:13px;}
.item .smallpic{ float:left; width:52px; margin:10px;}
.item a{ color:#285B00}
.item  .other{ display:block; width:60px; line-height:200%; background-color:  #E6E6E6; color:#000;margin-top:10px;}
.item_title { background-color:#EAFED9; height:25px; border-top:1px solid #295A00; color:#746F6C;}
#bts{ width:300px; float:left;}
#bts ul li { float:left; line-height:25px; margin-left:10px; font-size:14px;}
#pages{ width:420px; float:right;}
.foot{ border-top:2px solid #7C7C7C}
.fd_cx { background-color:#5da601; line-height:20px; color:#fff; display:block; width:50px; text-align:center; font-weight:bold;border:0}
.fd_xz { background-color:#464646; line-height:20px; color:#fff; display:block; width:50px; text-align:center; float:left; font-weight:bold; border:0}
.fddh { background-color:#7b7b7b; color:#fff; text-align:center; line-height:25px; border-right:1px solid #e6dcdd}
.fddhr { background-color:#7b7b7b; color:#fff; text-align:center; line-height:25px;}
a {text-decoration:none}
.trbg a:hover { background-color:#0C6}
.fdcz { color:#4e9b11; border-bottom:1px solid #e6dcdd}
.fdcz a{ color:#4e9b11;}
.fdcz a:hover {color:#FF6600;text-decoration:none}
#fdbj { background-color:#f3f3f3; border-bottom:1px solid #e6dcdd}
.fd_foot { background-color:#7b7b7b; line-height:5px}
.hui{ color:#3b393a; line-height:30px; font-size:12px;}
.hui a{color:#3b393a;text-decoration: none;}
.hui a:hover{ color:#FFF; background-color:#5da601;}
.td_bcolor{ border-bottom:1px solid #e6dcdd; border-right:1px solid #e6dcdd}
.tdtdtop{ font-weight:bold; border:1px solid #d6d6d6;}
.tatatop{ font-weight:bold; line-height:25px; text-align:center; border-bottom:4px solid #50a804}
.td_rightt{ border-right:1px solid #fff;color:#fff; background-color:#50a804}
.tab_color_two{ background-color:#e8e8e8;}
.d2{z-index: 100004;position:absolute;left:13%;top:22%;}
</style>

	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/data.js"></script>
	
	<script type="text/javascript">
	function delsg(){
		var urls = "delRCsalegoods.do";
		var all=document.getElementsByName('ids');
		var allId=new Array();
		var j=0;
		for(var i=0;i<all.length;i++){
			if(all[i].checked==true)
			{
				allId[j]=all[i].value;
				j++;
			}
		}
		if(allId.length>0){
			delflag=true;
		}
		if(!delflag){
			alert("请选择要操作的记录！");
			return false;
		}
		if(!delflag){
			return false;
		}
		$.post(urls,{objs:allId},	
		function (data)
		{
			if(data =="1")
			{
				alert("删除资源核实单成功!");
				window.location.href="<%=request.getContextPath()%>/selectReourcesalegoods.do";
			}
			if(data =="2")
			{
				alert("删除资源核实单失败!");
			}
		});
	}

	function onchangmang()
	{
		var obj = document.getElementById("select3");
		var selectIndex = obj.selectedIndex;
		var values = obj.options[selectIndex].value;
		$("#depotid").attr("value",values);
	}

	//弹出添加一行。
	function addrow()
	{
<%--		alert("aaa");--%>
<%--		 $("#addrow").load('<%=basePath%>pdm/addRCUIsalegoods.do');--%>
<%--		 $("#addrow").css("display","block");--%>
		var demo = $("#demo").val();
		$("#myFrames").attr("src","<%=request.getContextPath()%>/addRCUIsalegoods.do?demo="+demo);
		$("#addrow").css("display","block");
	}
	
	function yingcang()
	{
		alert("bbb");
		$("#addrow").empty();
	}

	function onchexiao(obj)
	{
		 $("#addrow1").load("<%=request.getContextPath()%>/potal/page/salegoods/repalRC.jsp?obj="+obj);
	 	 $("#addrow1").css("display","block");
	}

	function detailRC(obj)
	{
		var rcid = obj;
		 $("#addrow2").load("<%=basePath%>detailRCsalegoods.do?rcids="+rcid);
	 	 $("#addrow2").css("display","block");
	}

	function yingcang2()
	{
		 $("#addrow2").css("display","none");
	}
	function yingcang1()
	{
		 $("#addrow1").css("display","none");
	}
	function yingcangall()
	{
		$("#addrow1").css("display","none");
		$("#addrow2").css("display","none");
		$("#addrow").css("display","none");
	}

	function sumbitRC()
	{
		var demo = $("#demo").val();
		if(demo == 'rc')
		{
			form1.action = "<%=basePath%>selectReourcesalegoods.do";
			form1.submit();
		}
		if(demo == 'myrc')
		{
			form1.action = "<%=basePath%>selectmyrcsalegoods.do";
			form1.submit();
		}
		if(demo == 'deptrc')
		{
			form1.action = "<%=basePath%>selectdeptrcsalegoods.do";
			form1.submit();
		}
	}
	</script>
	
</head>

<body>
<div class="wzdha">
<span class="wzlsa">&nbsp;&nbsp;您的位置</span><span class="font_color_huia">：<a href="<%=basePath%>potal/page/desk.jsp">首页</a>&gt;</span><span class="wzcsa">资源核查单列表</span>
</div>
<form  action="" method="post" id="form1">
<input type="hidden" name="rcids" id="rcids" value=""/>
<input type="hidden" id="depotid" name="depotid" value="" />
<input type="hidden" id="demo" name="demo" value="${demo}"/>
<table width="100%" border="0" cellspacing="0"   cellpadding="0">
  <tr>
    <td height="32" colspan="8" align="right">
  	  <table width="100%" class="form_search" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%"  height="45" border="0" cellspacing="0" cellpadding="0" class="tdtdtop">
            <tr>
              <td width="10%" align="right">核查编号&nbsp;&nbsp;&nbsp;			  </td>
              <td width="17%" align="left"><input name="rvid" value="${rvid}" id="rvid" type="text" class="texta" size="15"  /></td>
              <td width="8%" align="right">申请人&nbsp;&nbsp;&nbsp;</td>
              <td width="16%" align="left"><label for="select">
                <input name="empnames" value="${empnames}" id="empnames" type="text" class="texta" size="15"  />
              </label></td>
              <td width="10%" align="right">仓库&nbsp;&nbsp;</td>
              <td width="16%" align="left"><label for="select2"></label>
                <select name="select" id="select3" onchange="onchangmang();">
                  <option>--请选择仓库--</option>
                  <c:forEach items="${listdepot}" var="dt">
                  	  <option value="${dt.id}" <c:if test="${dt.id == depotid}">selected</c:if> >${dt.name}</option>
                  </c:forEach>
                </select>                
                <label for="textafield"></label></td>
              <td width="10%" align="left"><input type="button" onclick="sumbitRC();" style="CURSOR:pointer;" name="button" id="button" class="fd_cx" value="查&nbsp;询" /></td>
              <td width="13%" align="left"><input type="button" style="CURSOR:pointer;" onclick="javascript:addrow();" name="button1" id="button1" class="fd_xz" value="新&nbsp;增" /></td>
            </tr>
            
          </table></td>
          </tr>
      </table>
 
	</td>
    </tr>
     <tr>
  	<td colspan="7">
		
	 </td>
  </tr>
  <tr>
    
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="tab_bordera">
        <tr>
          <td width="5%" class="fddh">选择</td>
          <td width="10%" class="fddh">核查编号</td>
          <td width="10%" class="fddh">申请人</td>
          <td width="13%" class="fddh">商品名称</td>
          <td width="10%" class="fddh">地区</td>
          <td width="15%" class="fddh">仓库</td>
          <td width="14%" class="fddh">状态</td>
          <td width="23%" class="fddhr">操作</td>
        </tr>
        <c:if test="${pages != null}">
        <c:forEach items="${pages.pageList}" var="rc">
        <tr>
          <td height="25" align="center" class="td_bcolor" id="fdbj">
            <label>
              <INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" type="checkbox" value="${rc.id}" name="ids" /> 
              </label>
          </td>
          <td height="25" align="center" class="td_bcolor" id="fdbj">${rc.rvid }</td>
          <td height="25" align="center" class="td_bcolor" id="fdbj">${rc.empid.name}</td>
          <td height="25" align="center" class="td_bcolor" id="fdbj">${rc.saleGoods.sgname}</td>
          <td height="25" align="center" class="td_bcolor" id="fdbj">${rc.city.name}</td>
          <td align="center" class="td_bcolor" id="fdbj">${rc.depot.name}</td>
          <td align="center" class="td_bcolor" id="fdbj">
          	<c:if test="${rc.isstate ==0}">未审批</c:if>
          	<c:if test="${rc.isstate ==1}">已审批</c:if>
          	<c:if test="${rc.isstate ==2}">已回复</c:if>
          	<c:if test="${rc.isstate ==3}">拒审批</c:if>
          	<c:if test="${rc.isstate ==4}">已撤销</c:if>
          </td>
          <td height="25" align="center" class="fdcz" id="fdbj">
          <c:if test="${rc.isstate ==0 || rc.isstate ==3}">
          	<a href="javascript:onchexiao('${rc.id}');">撤销</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </c:if>
		  <a href="javascript:detailRC('${rc.id}');">详情</a>
		  </td>
        </tr>
        </c:forEach>
        </c:if>
        <c:if test="${pages == null}">
        	<tr><td colspan="7" align="center" class="td_bcolor" id="fdbj">
        		
        	</td></tr>
        </c:if>
		<tr><td></td></tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="fd_foota">&nbsp;</td>
  </tr>
</table>
<table width="100%" height="25px" border="0" cellpadding="0" cellspacing="0" class="hui">
  <tr>
    <td width="6%" align="center">
            <label>
              <INPUT id="chkall" style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" onclick="CheckAll(this.form)" type="checkbox" value="select" name="chkall" />
            </label>
       </td>
    
    <td width="14%" align="left">全选&nbsp;&nbsp;
    &nbsp;<a href="javascript:void(0);" onclick="delsg();">删除</a></td>
    <td width="74%">
    	<c:if test="${demo == 'myrc'}">
    		 <pp:pages1 url="selectmyrcsalegoods.do" param="demo=myrc&openmethod=1"/>
    	</c:if>
    	<c:if test="${demo == 'rc'}">
    		<pp:pages1 url="selectReourcesalegoods.do" param="demo=rc&openmethod=1"/>
    	</c:if>
    	<c:if test="${demo == 'deptrc'}">
    		<pp:pages1 url="selectdeptrcsalegoods.do" param="demo=deptrc&openmethod=1"/>
    	</c:if>
		</td>
    <td width="6%"><a href="javascript:window.print();">打印</a> ]</td>
    </tr>
</table>


<!-- 弹出一行 -->

</form>

<div id="addrow" class="d2" style="display: none;">
	<iframe frameborder="0"  marginheight="0" marginwidth="0" id="myFrames" src="" style="width:582px;height:430px;"></iframe>
</div> 
<div id="addrow1" class="d2"></div> 
<div id="addrow2" class="d2"></div>
</body>
</html>