<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0044)http://www.ebadu.com/sendpass.asp -->
<HTML><HEAD><TITLE>邮件取回密码</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<LINK rel=stylesheet type=text/css href="subnote_files/doc.css">
<META name=GENERATOR content="MSHTML 8.00.6001.19154"></HEAD>
<BODY>
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" align=center 
height="100%">
  <TBODY>
	<tr></tr>
  <TR>
  
    <TD vAlign=center align=middle>
     <table height="50" width=780 align=center>
    	<tr>
        	 <td style="background-image: url('<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/bg_t.gif');"><font size="4">&nbsp;&nbsp;&nbsp;&nbsp;找回密码</font></td>
        </tr>
    </table>
   
    <table height="50">
    	<tr>
        	<td vAlign="middle" align=middle><font style="font-weight: bolder">1. 填写密保资料</font>>>2. 接收找回密码邮件>>3. 重置密码      	</td>
        </tr>
    </table>
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
                    <FORM method=post name=AddForm action="getbackPasswordByEmailCustomerServer.Action" onsubmit="emailpassword()">
                    <TBODY>
                    <TR>
                      <TD bgColor=#ffffff height=24 colSpan=3 
                        align=middle>邮件方式取回密码</TD></TR>
                    <TR>
                      <TD bgColor=#ffffff width="24%">&nbsp;<FONT 
                        color=red>*</FONT> 用户名称:</TD>
                      <TD bgColor=#ffffff width="26%">&nbsp;
                      <INPUT style="WIDTH: 120px" class=inputText id="customerName" name="customerName"></TD>
                      <TD bgColor=#ffffff width="50%">请输入您的登陆帐号</TD></TR>
                    <TR>
                      <TD bgColor=#ffffff>&nbsp;<FONT color=red>*</FONT> 
                      身份证号:</TD>
                      <TD bgColor=#ffffff>&nbsp;
                      <INPUT style="WIDTH: 120px" class=inputText name="cardid" id="cardid"></TD>
                      <TD bgColor=#ffffff>请输入密保证件号码</TD></TR>
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
                        name=answervalue id=answervalue></TD></TR>
                    <TR>
                      <TD bgColor=#ffffff>&nbsp;<FONT color=red>*</FONT> 
                      验证密码:</TD>
                      <TD bgColor=#ffffff colSpan=2>&nbsp;<INPUT 
                        style="WIDTH: 77px" class=inputText maxLength=4 
                        name=valuecode id=valuecode> 
                         <% String imgpath =request.getProtocol().substring(0, 4).toLowerCase()+ "://" + request.getServerName() + ":"+request.getServerPort(); %>
                          <IMG SRC="<%=imgpath%><%=request.getContextPath() %>/servlet/Img">
                        </TD></TR>
                      <TR>
                      <TD bgColor=#ffffff colSpan=3 align="center">&nbsp;
                          &nbsp;<font color="red">${errorMsg == null ? "" : errorMsg }</font>
                        </TD></TR>
                    <TR>
                      <TD bgColor=#ffffff height=30 colSpan=3 align=middle><INPUT class=bt value=" 提 交 " type="submit"  name=Submit>&nbsp;&nbsp;&nbsp; 
<INPUT class=bt value=" 重 置 " type=reset name=B2></TD></TR><INPUT value=mail type=hidden name=SType /> </FORM>
                    <TR>
                      <TD bgColor=#ffffff colSpan=3 
                        align=middle>只有设置过密保资料的才可以通过页面取回! <A 
                        href="#"><FONT 
                        color=blue>短信取回密码</FONT></A></TD></TR></TBODY></TABLE><BR></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></BODY>
                 <script type="text/javascript">
                 	function emailpassword()
                 	{
                 		var customername = $("#customerName").val();
                 		var carid = $("#cardid").val();
                 		var questionid = $("#questionid").val();
                 		var answer =$("#answervalue").val();
                 		var valuecode = $("#valuecode").val();
                 		
                 		if(customername=='')
                 		{
                 			alert("请填写用户名称！");
                 			return false;
                 		}
                 		if(carid=='')
                 		{
                 			alert("请填写身份证号！");
                 			return false;
                 		}
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
                 				return true;
                 			}
                 		}
                 	}
                 </script> 
                        
                        </HTML>
