<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>

<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.WorkLog"%>
<%@page import="com.fuao.fajxc.vo.AuditingOrderTab"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>
    <base href="<%=basePath%>">
    <title>待分配</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript" src="<%=path%>/potal/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path%>/potal/js/thickbox.js"></script>
<script type="text/javascript" src="<%=path %>/potal/js/newPortalworkLogJs.js"></script>
	
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
.fd_cx { background-color:#5da601; line-height:20px; color:#fff; display:block; width:50px; text-align:center; }
.fd_xz { background-color:#464646; line-height:20px; color:#fff; display:block; width:50px; text-align:center; float:left;}
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
.hui a{color:#3b393a;}
.hui a:hover{ color:#FFF; background-color:#5da601;}
.td_bcolor{ border-bottom:1px solid #e6dcdd; border-right:1px solid #e6dcdd}
.tdtdtop{ font-weight:bold; border:1px solid #d6d6d6;}
.tatatop{ font-weight:bold; line-height:25px; text-align:center; border-bottom:3px solid #50a804}
.td_rightt{ border-right:1px solid #fff}
.lk_bz {background-color:#50a804; color:black; border-right:1px solid #fff;}
.hk_hz { background-color:#e8e8e8; font-weight:bold; border-right:1px solid #fff;}
</style>
  </head>
<script type="text/javascript">


   //模块查询的表单提交
   function selectData(){
     var cusName = $("#cusName").val();
     var faultNo = $("#faultNo").val();
     var proType = $("#proType").val();
     myform.submit();
   }
  
   //接收完毕--转接
   function zhuanjie(id){
     var url = "<%=request.getContextPath()%>/zhuanjieFault.do?cid="+id;
     window.location.href=url;
   }
  
  //按enter键实现模糊查询
   function sel(){
      if(event.keyCode=="13"){
         selectData();
      }
   }
   
   //处理中--查看
   function chakan(id){
     var url = "<%=request.getContextPath()%>/chakanFault.do?cid="+id;
     window.location.href=url;
   }
   
   //处理完成--详情
   function detail(id){
     var url = "<%=request.getContextPath()%>/detailFault.do?cid="+id;
     window.location.href=url;
   }
   
   //待反馈--反馈
   function fankui(id){
     var url = "<%=request.getContextPath()%>/fankuiFault.do?cid="+id;
     window.location.href=url;
   }
   
  //     全选/反选
  var ids = "";
  function checkAll(op){
     var ch = document.getElementsByName("chk");
     if(op=="qx"){
        for(var i=0;i<ch.length;i++){
           ch[i].checked=true;
           ids+=ch[i].value+",";
        }
        alert(ids);
     }
     
     if(op=="fx"){
       for(var i=0;i<ch.length;i++){
         ch[i].checked=false;
         ids+="";
       }
       alert(ids);
     }
  }
  

  
  //勾选所有要删除项
function CheckA(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'chkall')
	    	e.checked = form.chkall.checked; 
	  }
}


function deleteAll(){ 
  	var ids=document.getElementsByName("ids");
  	var zt = $("#zt").val();
	var allid="";
	for(var i=0;i<ids.length;i++){
	   alert("length:"+ids[i].value);
	   if(ids[i].checked==true){
	      alert("进入循环...");
	      allid+=ids[i].value+",";
	   }
	}
	if(confirm("确定要删除吗?")){
	    alert("ID:"+allid);
	    if(allid!=""){
	      window.location.href="<%=request.getContextPath()%>/deleteAllFault.do?ids="+allid+"&zt="+zt;
	   }
	   
	   if(allid=="" || allid==null){
	      alert("请选择要删除的项!");
	      return;
	   }
	  
	   
	}
}

  //评分链接
  function pingfen(id){
     var url = "<%=request.getContextPath()%>/pingfenFault.do?cid="+id;
     window.location.href = url;
  }
   
</script>
  
  <body>
	<div class="wzdh">
	<span class="wzls">&nbsp;&nbsp;您的位置</span><span class="font_color_hui">：首页&gt;客服中心&gt;</span><span class="wzcs">客服人员故障单列表</span>
	</div>
	<table width="100%" border="0" cellspacing="0"   cellpadding="0">
	  <tr>
	    <td height="32" colspan="8" align="right">
	  	  <table width="100%" class="form_search" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td>
	          
	        <form action="<%=request.getContextPath()%>/pdm/selectFault.do" id="myform" method="post" id="selform">
	          <table width="100%"  height="45" border="0" cellspacing="0" cellpadding="0" class="tdtdtop">
	            <tr>
	              <td width="10%" align="right">客户姓名&nbsp;&nbsp;&nbsp;			  </td>
	              <td width="15%" align="left">
	                <input type="hidden" id="zt" name="zt" value="${zt}"/>
	                <input name="realName" type="text" value="" id="cusName" class="text" size="15" onkeyup="sel()" />
	              </td>
	              <td width="10%" align="right">故障单号&nbsp;&nbsp;&nbsp;</td>
	              <td width="16%" align="left"><label for="select">
	                <input name="faultNo" id="faultNo" type="text" class="text" size="15" onkeyup="sel()" />
	              </label></td>
	              <td width="10%" align="right">产品类型&nbsp;&nbsp;</td>
	              <td width="16%" align="left"><label for="select2"></label>
	                <select name="proType" id="proType" onchange="selectData()">
	                  <option value="-1">请选择</option>
	                  <c:forEach items="${questionlist}" var="data">
	                    <option value="${data.id}">${data.questionName}</option>
	                  </c:forEach>
	                </select>                
	                <label for="textfield"></label></td>
	              <td width="10%" align="left"><span class="fd_cx"><a style="text-decoration:none;color: white;" href="javascript:selectData();" onkeyup="if(event.keyCode='13'){selectData();}">查询</a></span></td>
	              <td width="13%" align="left"><span class="fd_cx"><a style="text-decoration:none;color: white;" href="<%=request.getContextPath()%>/goAddFault.do">新增</a></span></td>
	            </tr>
	          </table>
	        </form>
	          </td>
	          </tr>
	      </table>
	 
		</td>
	    </tr>
	     <tr>
	  	<td colspan="7">
			
		 </td>
	  </tr>
	  <tr>
	    
	    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tatatop">
	  <tr>
	    <td width="90" <c:if test="${f==1 || zt==1}"> class='lk_bz' </c:if> ><a style="text-decoration:none;" href="<%=request.getContextPath() %>/pdm/conkoutListFault.do?flag=1&zt=1">待分配</a></td>
	    <td width="90" <c:if test="${f==2 || zt==2}"> class='lk_bz' </c:if> ><a style="text-decoration:none;" href="<%=request.getContextPath() %>/pdm/conkoutList2Fault.do?flag=2&zt=2">处理中</a></td>
	    <td width="90" <c:if test="${f==3 || zt==3}"> class='lk_bz' </c:if> ><a style="text-decoration:none;" href="<%=request.getContextPath() %>/pdm/conkoutList3Fault.do?flag=3&zt=3">待反馈</a></td>
		<td width="90" <c:if test="${f==4 || zt==4}"> class='lk_bz' </c:if> ><a style="text-decoration:none;" href="<%=request.getContextPath() %>/pdm/conkoutList4Fault.do?flag=4&zt=4">已完成</a></td>
	    <td>&nbsp;</td>
	  </tr>
	</table>
	
	<form action="" method="post" id="form1">
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tab_border">
	        <tr>
	          <td width="5%" class="fddh">选择</td>
	          <td width="10%" class="fddh">故障单号</td>
	          <td width="15%" class="fddh">客户名称</td>
	          <td width="14%" class="fddh">产品类型</td>
	          <td width="10%" class="fddh">申报日期</td>
	          <td width="15%" class="fddh">问题类型</td>
	          <td width="19%" class="fddh">处理状态</td>
	          <td width="17%" class="fddhr">操作</td>
	        </tr>
	        
	        <c:if test="${empty pages.pageList}">
	           <tr><td height="20" colspan="8" align="center"><h4>"没有查询到符合你的条件"</h4></td></tr>
	        </c:if>
	        
	      <c:if test="${!empty pages.pageList}">
	        <c:forEach items="${pages.pageList}" var="conkout">
	        <tr>
	         <td width="5%" height="25" align="center" class="td_bcolor">
	              <input type="checkbox" value="${conkout.id}"　name="ids" id="ids"/>
	         </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${conkout.conkOutNo} 
	             <input type="hidden" id="flag" value="${flag}"/>
	             <input type="hidden" id="conkoutid" value="${conkout.id}"/>         
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${conkout.customer.realName}          
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             
	             <c:if test="${conkout.proudcotType.questionName==null}">
	                                        上架单
	             </c:if>
	             <c:if test="${conkout.proudcotType.questionName!=null}">
	                ${conkout.proudcotType.questionName}
	             </c:if>
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${conkout.faultTime}
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${conkout.issueType.questionName}
	          </td>
	          <td height="25" align="center" class="td_bcolor">
	            <c:if test="${conkout.status==0}">
				  未转接
				</c:if><!--
				<c:if test="${conkout.status==1}">
				客服接收
				</c:if>
				--><c:if test="${conkout.status==2}">
				 已转接
				</c:if>
				<c:if test="${conkout.status==3}">
				 运维接收
				</c:if>
				<c:if test="${conkout.status==4 || conkout.status==6}">
				 待反馈
				</c:if>
				<c:if test="${conkout.status==5}">
				 处理完成
				</c:if>
				<c:if test="${conkout.status==7}">
				 处理
				</c:if>
	          </td>
	          
	          <td height="25" align="center" class="fdcz" id="fdbj"><!--
	             <c:if test="${conkout.status==0}">
	               <a href="javascript:jieshou(${conkout.id});">接收</a>
	             </c:if>
	             --><c:if test="${conkout.status==0}">
	               <a href="javascript:zhuanjie(${conkout.id});">转接</a>
	             </c:if>
	             <c:if test="${conkout.status==2 || conkout.status==7}">
	               <a href="javascript:chakan(${conkout.id});">查看</a>
	             </c:if>
	              <c:if test="${conkout.status==4 || conkout.status==6}">
	               <a href="javascript:fankui(${conkout.id});">反馈</a>
	             </c:if>
	             <c:if test="${conkout.status==5}">
	               <a href="javascript:detail(${conkout.id})">详情</a>
	                 <c:if test="${conkout.grades!=5 && conkout.appraise!='无'}">
	                    <a href="javascript:pingfen(${conkout.id});">评分</a>
	                 </c:if>
	                 <c:if test="${conkout.grades==5 && conkout.appraise=='无'}">
	                                                           已评分
	                 </c:if>
	             </c:if>
	            
	          </td>
	        </tr>
	        </c:forEach>
	      </c:if>
	        
	        <tr>
	          <td align="left" colspan="2">
	            <input type="checkbox" onclick="CheckA(this.form)" value=select name=chkall />全选/反选&nbsp;<a href="javascript:deleteAll();">删除</a>
	            <input type="hidden" id="allid"/>
	          </td>
	          
	          </td>
	          <input type="hidden" id="bs" name="bs" value="${flag}"/>
	          <c:if test="${flag==1}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/conkoutListFault.do?flag=1&zt=1" /></td>
			  </c:if>
			  <c:if test="${flag==2}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/conkoutList2Fault.do?flag=2&zt=2" /></td>
			  </c:if>
			  <c:if test="${flag==3}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/conkoutList3Fault.do?flag=3&zt=3" /></td>
			  </c:if>
			  <c:if test="${flag==4}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/conkoutList4Fault.do?flag=4&zt=4" /></td>
			  </c:if>
			  <c:if test="${flag==5}">
				<td id="pageNo" colspan="8">
				<c:if test="${zt==1}">
				  <p:pages url="pdm/selectFault.do?flag=5&zt=1"/>
				</c:if>
				<c:if test="${zt==2}">
				  <p:pages url="pdm/selectFault.do?flag=5&zt=2"/>
				</c:if>
				<c:if test="${zt==3}">
				  <p:pages url="pdm/selectFault.do?flag=5&zt=3"/>
				</c:if>
				<c:if test="${zt==4}">
				  <p:pages url="pdm/selectFault.do?flag=5&zt=4"/>
				</c:if> 
				</td>
			  </c:if>
			</tr>
	    </table>
	 </form>
	    </td>
	  </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="fd_foot">&nbsp;</td>
	  </tr>
	</table>
	<table width="100%" height="25px" border="0" cellpadding="0" cellspacing="0" class="hui">
	</table>
  </body>
</html>
