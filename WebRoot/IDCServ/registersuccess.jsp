<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0044)http://www.ebadu.com/sendpass.asp -->
<HTML><HEAD><TITLE>激活注册</TITLE>
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
        	 <td style="background-image: url('<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/bg_t.gif');"><font size="4">&nbsp;&nbsp;&nbsp;&nbsp;激活注册</font></td>
        </tr>
    </table>
   
    <table height="50">
    	<tr>
        	&nbsp;
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
                  <TABLE cellSpacing=1 cellPadding=2 width=600 bgColor=#cccccc 
                  align=center>
                    <FORM method=post name=AddForm action="getbackPasswordByEmailCustomerServer.do" onsubmit="emailpassword()">
                    <TBODY>
                    <TR>
                      <TD bgColor=#ffffff height=24 colSpan=3 
                        align=middle>激活注册</TD></TR>
                    <TR>
                      <TD bgColor=#ffffff colSpan=3 align="center" height="70">&nbsp;   
                     	
						${registerActiveMessage }
                        </TD>
                      </TR>
                      <TR>
                      <TD bgColor=#ffffff colSpan=3 align="center">&nbsp;
                          &nbsp;<font color="red">${errorMsg == null ? "" : errorMsg }</font>
                        </TD></TR>
                    <TR>
                      <TD bgColor=#ffffff height=30 colSpan=3 align=middle>
                      <INPUT width="250" class=bty value="进入客户系统 " type="button" onclick="login()"  name=Submit>&nbsp;&nbsp;&nbsp; </TD></TR><INPUT value=mail type=hidden name=SType /> </FORM>
                     
                    <TR>
                      <TD bgColor=#ffffff colSpan=3 
                        align=middle>&nbsp;</TD></TR></TBODY></TABLE><BR></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></BODY>
                        <script type="text/javascript">
                        	function login()
                        	{
                        		window.location.href = "<%=request.getContextPath() %>/IDCServ/loggin.jsp";
                        	}
                        </script>
                        </HTML>
