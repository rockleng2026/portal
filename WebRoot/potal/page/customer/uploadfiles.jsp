<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script><!-- 
function AddMoreRow() 
{ 
    var oRow=event.srcElement.parentNode.parentNode; 
    var oTable=oRow.parentNode.parentNode; 
    oNewRow=oTable.insertRow(); 
    for(i=0;i<oRow.cells.length;i++) 
    { 
        oNewRow.insertCell().innerHTML=oRow.cells[i].innerHTML; 
    } 
    oRow.all("DelBtn").disabled=false; 
    oNewRow.all("DelBtn").disabled=false; 
} 
function DeleteMoreRow() 
{ 
    var oRow=event.srcElement.parentNode.parentNode; 
    var oTable=oRow.parentNode.parentNode; 
   if(oTable.rows.length>1) 
    { 
        oTable.deleteRow(oRow.rowIndex); 
        if(oTable.rows.length==1) 
        { 
           oTable.all("DelBtn").disabled=true; 
        } 
    } 
} 
function DisabledKeyInput() 
{ 
    if(event.keyCode!=8&&event.keyCode!=46) 
    { 
        event.returnValue=false; 
    } 
}


function uploadfj() {
	if(confirm("你确定要上传附件?")){
	     formfjs.submit();
	}
 	}


 
</script> 
<form method="post" enctype="multipart/form-data" id="formfj" action="doUploadupload.do" name="formfjs"> 
<table> 
<tr> 
<td nowrap="nowrap">文件路径*</td> 
<td><input type="file" name="filedata" size="15" onKeyDown="DisabledKeyInput()" /></td> 
<td><input type="button" value="增加" size="15" onclick="AddMoreRow()"></td> 
<td nowrap="nowrap">  
<input type="button" id="DelBtn" value="删除" disabled="disabled" onClick="DeleteMoreRow()"> 
</td> 

</tr> 
</table> 
<table> 
<tr align="center"> 
<td align="center"> 
<input type="button" id="savefj" onclick="uploadfj()" value="上传">  <input type="reset" id="cancelfj" value="取消"></td> 
</tr> 
</table> 
</form> 