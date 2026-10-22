<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0044)http://www.ebadu.com/sendpass.asp -->
<HTML><HEAD><TITLE>邮件取回密码</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<LINK rel=stylesheet type=text/css href="subnote_files/doc.css">
<META name=GENERATOR content="MSHTML 8.00.6001.19154">
<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css"/>
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css"/>
</HEAD>
<BODY onload="select()">
<TABLE style="margin-left:0px;" border=0 cellSpacing=1 cellPadding=2 width="800" bgColor=#cccccc 
      align=left>
        <TBODY>
        <TR bgColor=#f0f0f0>
          <TD colspan="4">&nbsp;当前操作-》我的资料修改-》设置密保资料</TD><td align="center"><A href="javascript:history.go(-1)">返回</A></td></TR></TBODY>
        <tr>
        	<td colspan="5">
        		<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" align=center 
height="100%">
  <TR>
    <TD vAlign=center align=middle>
      <TABLE border=0 width=760 align=center>
        <TBODY>
        <TR>
          <TD>
            <TABLE style="LINE-HEIGHT: 200%; FONT-SIZE: 9pt" border=0 
            cellSpacing=1 cellPadding=2 width="100%" bgColor=#cccccc 
            align=center>
              <TBODY>
              <TR>
                <TD bgColor=#ffffff align=middle><BR>
                  <TABLE cellSpacing=1 cellPadding=2 width=500 bgColor=#cccccc 
                  align=center>
                    <FORM method=post name=AddForm action=?action=action>
                    <TBODY>
                    <TR>
                      <TD bgColor=#ffffff height=24 colSpan=3 
                        align=middle>设置密码保护资料</TD></TR>
                    <TR bgColor=#ffffff>
                      <TD>&nbsp;<FONT color=red>*</FONT> 安全提问:</TD>
                      <TD colSpan=2>&nbsp;<SELECT 
                        style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid" 
                        id=questionid size=1 name=questionid> <OPTION selected 
                          value="-1">请选择</OPTION> <OPTION value=1>母亲的名字</OPTION> 
                          <OPTION value=2>爷爷的名字</OPTION> <OPTION 
                          value=3>父亲出生的城市</OPTION> <OPTION 
                          value=4>您其中一位老师的名字</OPTION> <OPTION 
                          value=5>您个人计算机的型号</OPTION> <OPTION 
                          value=6>您最喜欢的餐馆名称</OPTION> <OPTION 
                          value=7>驾驶执照的最后四位数字</OPTION></SELECT> </TD></TR>
                    <TR bgColor=#ffffff>
                      <TD>&nbsp;<FONT color=red>*</FONT> 您的回答:</TD>
                      <TD colSpan=2>&nbsp;<INPUT 
                        style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid" 
                       id=answer name=answer></TD></TR>
                    <TR>
                      <TD bgColor=#ffffff>&nbsp;<FONT color=red>*</FONT> 
                      验证密码:</TD>
                      <TD bgColor=#ffffff colSpan=2>&nbsp;<INPUT 
                        style="WIDTH: 77px" class=inputText maxLength=4 
                       id=valuecode name=valuecode> 
                        <% String imgpath =request.getProtocol().substring(0, 4).toLowerCase()+ "://" + request.getServerName() + ":"+request.getServerPort(); %>
                          <IMG SRC="<%=imgpath%><%=request.getContextPath() %>/servlet/Img">
                          &nbsp;<font color="red">${errorMsg == null ? "" : errorMsg }</font>
                        </TD></TR>
                    <TR>
                      <TD bgColor=#ffffff height=30 colSpan=3 align=middle><INPUT class=bt value=" 提 交 " type="button" onclick="tijiao()" name=Submit>&nbsp;&nbsp;&nbsp; 
<INPUT class=bt value=" 重 置 " type=reset name=B2></TD></TR><INPUT 
                    value=mail type=hidden name=SType> </FORM>
                 </TBODY></TABLE><BR></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
        	</td>
        </tr>
      
        <TR>
          <TD bgColor=#f0f0f0 height=1 width="90%" align=middle colspan="5">
            <LI>如你在本站系统中有什么还不明白的地方，请使用<A 
            href="http://www.ebadu.com/manager/subnote.asp"><FONT 
            color=red>帮助留言</FONT></A>功能，我们的技术人员会给你答复。 
      </LI></TD></TR></TBODY></TABLE><BR><!--right end--></TR></TBODY></TABLE></TD></TR><!--mid end--></TABLE></TD></TR></TABLE>


</BODY>
                 <script type="text/javascript">
                 	function tijiao()
                 	{
                 		var questionid = $("#questionid").val();
                 		var answer = encodeURI($("#answer").val());
                 		var valuecode = $("#valuecode").val();
                 		var id = "<%=request.getParameter("id") %>";
                 		if(questionid=='-1')
                 		{
                 			alert("请选择安全提问！");
                 			return false;
                 		}
                 		else
                 		{
                 			if(answer==''||answer==null)
                 			{
                 				alert("请填写您的回答！");
                 				return false;
                 			}
                 			else
                 			{
                 				var str = window.confirm("您确定提交已填写的数据吗？");
                 				if(str)
                 				{
                 					var url = "setmibaoCustomerServer.Action";
                 					$.post(url,{id:id,questionid:questionid,answer:answer,valuecode:valuecode},function (data){
                 						if(data == '1')
                 						{
                 							alert("您的密保设置成功，请保存好密码保护资料！");
                 							history.go(-2);
                 						}
                 						else if(data == '2')
                 						{
                 							alert("验证码错误，请重新填写！");
                 							return false;
                 						}
                 						else
                 						{
                 							alert("您的密保设置失败，请稍后再试！");
                 							return false;
                 						}
                 					});
                 				}
                 			}
                 		}
                 	}
                 	
                 	function select()
                 	{
                 		var id = "${customer.issetmibao}";
                 		var qid = "${customer.questionid}";
                 		var value = "${customer.answervalue}";
                 		 $("#questionid").val(qid);          
                 		 $("#answer").attr("value",value);          		
                 	}
                 </script>
                 </HTML>
