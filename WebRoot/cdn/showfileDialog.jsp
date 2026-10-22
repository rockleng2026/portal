<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk">
        <meta http-equiv="Content-Style-Type" content="text/css">
        <meta http-equiv="Content-Script-Type" content="text/javascript">

        <title>Rotating UI</title>

        <link rel="stylesheet" href="<%=request.getContextPath() %>/cdn/js/ui.tabs.css" type="text/css" media="print, projection, screen">
        <style type="text/css" media="screen, projection">
            /* Not required for Tabs, just to make this demo look better... */
            body, h1, h2 {
                font-family: "Trebuchet MS", Trebuchet, Verdana, Helvetica, Arial, sans-serif;
            }
            h1 {
                margin: 1em 0 1.5em;
                font-size: 18px;
            }
            h2 {
                margin: 2em 0 1.5em;
                font-size: 16px;
            }
            p {
                margin: 0;
            }
            pre, pre+p, p+p {
                margin: 1em 0 0;
            }
            code {
                font-family: "Courier New", Courier, monospace;
            }
        </style>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/handlejson.js"></script>
        <script src="<%=request.getContextPath() %>/cdn/js/jquery-1.2.3.pack.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath() %>/cdn/js/ui.tabs.pack.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath() %>/cdn/js/ui.tabs.ext.pack.js" type="text/javascript"></script>
         <script src="<%=request.getContextPath() %>/cdn/js/jquery.form.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(function() {
                $('#rotate > ul').tabs({ fx: { opacity: 'toggle' } }).tabs('rotate', 0);
            });
            function sumb()
            {
            	var queryString = $('#fileform').formSerialize();
            	$.post("savefileCDNsaleOrderAction.do", queryString,function(data){
            		var ss=data.substr(0,1);
            		var sg=data.substr(1,data.length);
            		alert(sg);
            		if(ss=="1")
            		{
                		window.close();
                	//	setTimeout(closeWindow, 5000);
                		return "0";
            		}
            	});	
            }
            
            
          var flag ;
		  var count = 0;      
			function addRow(){
				if(count < 11){
					var ht ="<tr><td align='right' valign='top'>选项"
						+count+
						"：<br /><br />描述：</td><td valign='top'><input name='items["+count+"].subtitle"
				        +
				        "' onblur="
				        +
				        "',null,true)\" id='items['"+count+"'].subTitle" 
				        +
				        "' size='64'><br /><textarea name='items["+count+"].description"
				        +
				        "' cols='45' rows='11' ></textarea></td><td align='left' valign='top'><div id='imgDiv"+count+"'></div></td></tr>";
					 $("#row4").before(ht);
					document.getElementById("itemCount").value=count;
					count++;
				}
			}  
         
        </script>  
    </head>
    <body>
        <h1>配置文件内容</h1>
        <div id="rotate">
            <ul>
                <li><a href="#fragment-1"><span>host文件</span></a></li>
                <li><a href="#fragment-2"><span>域名conf文件</span></a></li>          
            </ul>
			<form id="fileform" action="savefileCDNsaleOrderAction.do" method="post" >
				<input type="hidden" name="cdnid" value="${cdnid }">
				<div id="fragment-1">
					<table>
					<tr>
							<td>模板地址：</td><td><input style="width:428px;" type="text" id="" name="sourceFile"  value="${sourceFile}" /></td>
						</tr>
						<tr>
							<td>插入地址：</td><td><input style="width:428px;" type="text" id="" name="hostpath" value="${hostpath}" /></td>
						</tr>
						<tr><!-- <input type="text" id="" name="hostcontent" value="${hostcontent}" /> -->
							<td>追加内容：</td><td><textarea name="hostcontent" cols="58" rows="3">${hostcontent }</textarea></td>
						</tr>
					</table>
				</div>
				<div id="fragment-2">
					<table>
						<tr>
							<td>地址：</td><td><input style="width:428px;" type="text" id="" name="cachepath" value="${cachepath}" /></td>
						</tr>
						<tr>
							<td>名称：</td><td><input style="width:428px;" type="text" id="" name="cachepeeroldname" value="${cachepeeroldname}" /></td>
						</tr>
						<tr><!--<input type="text" id="" name="cachepeername" value="${cachepeername}" />  -->	
							<td>内容：</td><td><textarea name="cachepeername" cols="58" rows="3">${cachepeername }</textarea></td>
						</tr>
						<!-- ACL -->											
						<c:forEach items="${callist}" var="calldata" varStatus="din">
							<tr>
								<td>名称：</td><td><input style="width:428px;" type="text" id="" name="huancunflag${din.index }" value="${calldata[0]}" /></td>
							</tr>
							<tr><!--<input type="text" id="" name="cachecontent${din.index }" value="${calldata[1]}" />  -->	
								<td>内容：</td><td><textarea name="cachecontent${din.index }" cols="58" rows="3">${calldata[1] }</textarea></td>
							</tr>
						</c:forEach>
					</table>
				</div>				
				<table>
					</table>
				</div>				
						<tr>
						<td align="center"><input type="button" onclick="sumb()" value="确认提交"/></td><td><input type="reset" value="重置" /></td>
						<td align="center"><input type="button" value="添加一行" /></td><td><input type="button" value="删除一行" /></td>
					</tr>
				</table>
			</form>
        </div>
    </body>
</html>