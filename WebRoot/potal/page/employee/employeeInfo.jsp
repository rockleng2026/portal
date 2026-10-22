<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<title>浮动层迷你模式</title>
<SCRIPT type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js">  
</SCRIPT>
<SCRIPT type="text/javascript" src="js/employeeJs.js">  
</SCRIPT>
<script type="text/javascript">
	function delcust(){
if(confirm("确定删除所勾选的意向客户吗？")==true){
  var ids="";
      $("input[@type=checkbox][@checked]").each(function(){ //由于复选框一般选中的是多个,所以可以循环输出 

   		
  	 	ids=ids+$(this).val()+",";
   }); 
    

     $.ajax({
           type:'post',
           url:'delcustNewportalCustomer1.do',
           data:{ids:ids},
           success:function(res){
              location.reload();
           }
        })
        }
        }

    $(function () { 
    
    $('#custname1').keydown(function(e){
if(e.keyCode==13){
   filterform.submit(); //处理事件
}
}); 
$('#custname2').keydown(function(e){
if(e.keyCode==13){
   filterform.submit(); //处理事件
}
}); 

               
    
    		  $(".changecolor1").bind("click", function () { 
               $(".changecolor1").css("background-color","#50a806");
            });
              $(".changecolor2").bind("click", function () { 
               $(".changecolor2").css("background-color","#50a806");
            });
            // 全选 
            $("#btnCheckAll").bind("click", function () { 
                $("[name = ids]:checkbox").attr("checked", true); 
            }); 
              
            // 全不选 
            $("#btnCheckNone").bind("click", function () { 
                $("[name = ids]:checkbox").attr("checked", false); 
            }); 
  
            // 反选 
            $("#btnCheckReverse").bind("click", function () { 
                $("[name = ids]:checkbox").each(function () { 
                    $(this).attr("checked", !$(this).attr("checked")); 
                }); 
            }); 
  
            // 全不选 
            $("#btnSubmit").bind("click", function () { 
                var result = new Array(); 
                $("[name = ids]:checkbox").each(function () { 
                    if ($(this).is(":checked")) { 
                        result.push($(this).attr("value")); 
                    } 
                }); 
  
                alert(result.join(",")); 
            }); 
        }); 
        
        function changepage(a,b){
        if(a!="" && a!=null){
        if(a>b){
        alert("所填页数大于总页数");
        }else{
        location.href="getEmplistemp.do?pageNo="+a;
        }
        }
        }
        function cheacka(a){
        
        if(a.checked==true){
         $("[name = ids]:checkbox").attr("checked", true); 
        
        }else{
           $("[name = ids]:checkbox").attr("checked", false); 
        }
        }
        function nextpage(npage,apage){
        var npage1=npage+1;
        if(npage+1>apage){
        
        }else{
         location.href="getEmplistemp.do?pageNo="+npage1;
        
        }
        
        
        }
        function getempInfoemp(a){
        
        window.location.href = "detail1emp.do?cid="+a;	
        }
	function addEmployee()
	{
		window.location.href = "addloademp.do";	
		//$("#tanchukuang").load("editEmployee.html");
		//$("#tanchukuang").show();
	}
	function getempInfoemp1(a)
	{
		  window.location.href = "detail1emp.do?cid="+a+"&isedit=edit";	
	}
</script>
<link rel="stylesheet" type="text/css" href="css/employeeCss.css"/>
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
.tab_border{ border:1px solid #e6dcdd}

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
.fd_cx { background-color:#5da601; line-height:20px; color:#fff; display:block; width:50px; text-align:center; border:0; }
.fd_xz { background-color:#464646; line-height:20px; color:#fff; display:block; width:50px; text-align:center; float:left; border:0;}
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
.hui a:hover{ color:red;}
.td_bcolor{ border-bottom:1px solid #e6dcdd; border-right:1px solid #e6dcdd}
</style>
</head>

<body>
<div class="wzdh">
<span class="wzls">&nbsp;&nbsp;您的位置</span><span class="font_color_hui">：首页&gt;办公桌面&gt;</span><span class="wzcs">员工信息</span>
</div>
<table width="100%" border="0" cellspacing="0"   cellpadding="0">
  <tr>
    <td height="32" colspan="8" align="right">
  	  <table width="100%" class="form_search" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <form action="getEmplistemp.do?pageNo=${pageNo }">
              <td width="6%" align="right">姓名</td>
              <td width="25%" align="left"><input name="empname" type="text" class="text"  value=""/></td>
              <td width="6%" align="right">部门;</td>
              <td width="13%" align="left">
              <select name="seldept" style="width: 100">
               <option ></option>
                ${ deptlist}
                </select>
                </td>
              <td width="7%" align="right">工号&nbsp;&nbsp;</td>
              <td width="23%" align="left"><label for="textfield"></label>
                <input type="text" name="empno" id="textfield" /></td>
              <td width="8%" align="left"><input type="submit" name="Submit" value="查询" class="fd_cx" /></td>
             </form>
              <td width="9%" align="left"><input type="button" name="add" value="新增" class="fd_xz" onclick="addEmployee()"/></td>
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
    
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="tab_border">
        <tr>
          <td class="fddh">选择</td>
          <td class="fddh">姓名</td>
          <td class="fddh">性别</td>
          <td class="fddh">联系电话</td>
          <td class="fddh">所属部门</td>
          <td class="fddh">职位</td>
          <td class="fddh">工号</td>
          <td class="fddh">入职时间</td>
          <td class="fddhr">操作</td>
        </tr>
        <c:forEach items="${newcustomerlist}" var="v2">
        <tr  name="color">
          <td height="25" align="center" class="td_bcolor">
            <label>
              <input type="checkbox" name="ids" value="checkbox" />
              </label>
         
		  </td>
          <td height="25" align="center" class="td_bcolor">${v2.name}</td>
          <td height="25" align="center" class="td_bcolor"><c:if test="${v2.sex==1 }">男</c:if><c:if test="${v2.sex==2 }">女</c:if></td>
          <td height="25" align="center" class="td_bcolor">${v2.tel}</td>
          <td height="25" align="center" class="td_bcolor">${v2.department.name}</td>
          <td height="25" align="center" class="td_bcolor">${v2.workposition.name}</td>
          <td align="center" class="td_bcolor">${v2.empNo}</td>
          <td height="25" align="center" class="td_bcolor">${v2.entryTime}</td>
          <td height="25" align="center" class="fdcz"><a href="javascript:getempInfoemp(${v2.id})">详细信息</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:getempInfoemp1(${v2.id})">编辑</a></td>
        </tr>
        </c:forEach>
 
		<tr><td></td></tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="fd_foot">&nbsp;</td>
  </tr>
</table>
<table width="100%" height="25px" border="0" cellpadding="0" cellspacing="0" class="hui">
  <tr>
    <td width="6%" align="center"><form id="form1" name="form1" method="post" action="">
            <label>
              <input type="checkbox" name="lastcheckbox" onclick="cheacka(this)" value="checkbox" />
            </label>
        </form></td>
    
    <td width="13%" align="center"><a href="#" id="btnCheckAll">全选</a>&nbsp;<a href="#" id="btnCheckReverse">反选</a>&nbsp</td>
    <td width="11%">[共${allline} 条记录</td>
    <td width="4%"><a href="getEmplistemp.do?pageNo=1">首页</a></td>
    <td width="6%"><a href="getEmplistemp.do?pageNo=${pageNo-1}">上一页</a></td>
    <td width="6%"><a href="javascript:nextpage(${pageNo},${gageNoall})">下一页</a></td>
    <td width="5%"><a href="getEmplistemp.do?pageNo=${gageNoall}">尾页</a></td>
    <td width="6%" align="right">页数：${pageNo }</td>
    <td width="6%">/${gageNoall}</td>
    <td width="7%" align="right">转到</td>
    <td width="8%" align="center"><input type="text" name="yeshu" size="1"  onblur="changepage(this.value,${gageNoall})"/>
      页</td>
    <td width="6%">打印]</td>
    </tr>
</table>

<!--
<div id="tanchukuang" style="z-index:100; position:absolute;top:2%;left:21%;display:none;">
	<iframe src="addEmployee.html">
    </iframe>
</div>
-->
</body>
</html>
