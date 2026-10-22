<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    
    <title>运维人员故障单列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
  </head>
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
.tatatop{ font-weight:bold; line-height:25px; text-align:center; border-bottom:4px solid #50a804}
.td_rightt{ border-right:1px solid #fff; background-color:#50a804}
.tab_color_two{ background-color:#e8e8e8;}
</style>

<script>
//window.onload=function(){
//   var zt = $("#zt").val();
//   if(zt==1){
//     setTimeout("location.href='<%=request.getContextPath()%>/toreceiveFault.do?flag=1&zt=1'",2000)
//   }
// }
</script>

<script type="text/javascript">
   //模糊查询
   function selectData(){
     var bz = $("#flag").val();
     var zt = $("#zt").val();
     forms.action="<%=request.getContextPath()%>/pdm/ywselectFault.do";
     forms.submit();
   }
   
   //接收
   function receive(id){
     var url = "<%=request.getContextPath()%>/toReceiveFault.do?yid="+id;
     window.location.href= url;
   }
   
   //按enter键实现模糊查询
   function sel(){
      if(event.keyCode=="13"){
         selectData();
      }
   }
   
   function getall(){
     selectData();
   }
   
   //用户点击处理
   function handle(id){
      var url = "<%=request.getContextPath()%>/handleCoFault.do?coid="+id;
      window.location.href=url;
   }
   
   //查看处理详情
   function clxq(id){
     var url = "<%=request.getContextPath()%>/clxqFault.do?cid="+id;
     window.location.href=url;
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
	   if(ids[i].checked==true){
	      allid+=ids[i].value+",";
	   }
	}
	
	if(confirm("确定要删除吗?")){
	    if(allid!=""){
	      window.location.href="<%=request.getContextPath()%>/deleteAll2Fault.do?ids="+allid+"&zt="+zt;
	   }
	   
	   if(allid=="" || allid==null){
	      alert("请选择要删除的项!");
	      return;
	   }
	  
	   
	}
}
</script>
  <body>
   <div class="wzdh">
<span class="wzls">&nbsp;&nbsp;您的位置</span><span class="font_color_hui">：首页&gt;客服中心&gt;</span><span class="wzcs">运维人员故障单列表</span>
</div>
<table width="100%" border="0" cellspacing="0"   cellpadding="0">
  <tr>
    <td height="32" colspan="8" align="right">
    <form action="" method="post" id="forms">
  	  <table width="100%" class="form_search" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%"  height="45" border="0" cellspacing="0" cellpadding="0" class="tdtdtop">
            <tr>
              <td width="10%" align="right">客户姓名&nbsp;&nbsp;&nbsp;			  </td>
              <td width="18%" align="left">
                <input type="hidden" id="zt" name="zt" value="${zt}"/>
                <input name="realName2" value="" type="text" class="text" size="15" onkeyup="sel()" /></td>
              <td width="9%" align="right">故障单号</td>
              <td width="17%" align="left"><label for="select">
                <input name="faultNo2" type="text" class="text" size="15" value="" onkeyup="sel()" />
              </label></td>
              <td width="11%" align="right">产品类型&nbsp;&nbsp;</td>
              <td width="14%" align="left"><label for="select2"></label>
                <select name="proType2" id="select2" onchange="getall()">
                  <option value="-1">请选择</option>
                  <c:forEach items="${questionlist}" var="data">
                    <option value="${data.id}">${data.questionName}</option>
                  </c:forEach>
                </select>                
                <label for="textfield"></label></td>
              <td width="10%" align="left">
                <span class="fd_cx"><a style="text-decoration:none;color: white;" href="javascript:selectData();">查询</a></span>
              </td>
              <td width="11%" align="left"><span class="fd_cx"><a style="text-decoration:none;color: white;" href="<%=request.getContextPath()%>/goAddFault.do">新增</a></span></td>
            </tr>
            
          </table></td>
          </tr>
      </table>
      </form>
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
    <td width="90" <c:if test="${type==1 || zt==1}"> class='td_rightt' </c:if>><a href="<%=request.getContextPath()%>/pdm/toreceiveFault.do?flag=1&zt=1">待接收</a></td>
    <td width="90" <c:if test="${type==2 || zt==2}"> class='td_rightt' </c:if>><a href="<%=request.getContextPath()%>/pdm/ywclFault.do?flag=2&zt=2">处理中</a></td>
    <td width="90" <c:if test="${type==3 || zt==3}"> class='td_rightt' </c:if>><a href="<%=request.getContextPath()%>/pdm/clwcFault.do?flag=3&zt=3">已完成</a></td>
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
        <c:forEach items="${pages.pageList}" var="data">
        <tr>
              <td width="5%" height="25" align="center" class="td_bcolor">
	              <input type="checkbox" value="${data.id}"　name="ids" id="ids"/>
	         </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${data.conkOutNo} 
	             
	             <input type="hidden" id="did" value="${data.id}"/>         
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${data.customer.realName}          
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${data.proudcotType.questionName}
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${data.faultTime}
	          </td>
	          <td height="25" align="center" class="td_bcolor" id="fdbj">
	             ${data.issueType.questionName}
	          </td>
	          <td height="25" align="center" class="td_bcolor">
	            <c:if test="${data.status==2}">
				      未接收
				</c:if>
				<c:if test="${data.status==3}">
				   ${data.group.missiontype.name}已接收
				</c:if>
				<c:if test="${data.status==5}">
				    处理完成
				</c:if>
				
	          </td>
	          
	          <td height="25" align="center" class="fdcz" id="fdbj">
	             <c:if test="${data.status==2}">
	               <a href="javascript:receive(${data.id});">接收</a>
	             </c:if>
	             
	             <c:if test="${data.status==3}">
	               <a href="javascript:handle(${data.id});">处理</a>
	             </c:if>
	             <c:if test="${data.status==5}">
	               <a href="javascript:clxq(${data.id});">查看处理详情</a>
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
	          <c:if test="${flag==1}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/toreceiveFault.do?flag=1&zt=1" /></td>
			  </c:if>
			  <c:if test="${flag==2}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/ywclFault.do?flag=2&zt=2" /></td>
			  </c:if>
			  <c:if test="${flag==3}">
				<td id="pageNo" colspan="8"><p:pages url="pdm/clwcFault.do?flag=3&zt=3" /></td>
			  </c:if>
			  <c:if test="${flag==5}">
				<td id="pageNo" colspan="8">
				  <c:if test="${zt==1}">
				      <p:pages url="pdm/ywselectFault.do?flag=5&zt=1"/>
				  </c:if>
				  <c:if test="${zt==2}">
				      <p:pages url="pdm/ywselectFault.do?flag=5&zt=2"/>
				  </c:if>
				  <c:if test="${zt==3}">
				      <p:pages url="pdm/ywselectFault.do?flag=5&zt=3"/>
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
  </body>
</html>
