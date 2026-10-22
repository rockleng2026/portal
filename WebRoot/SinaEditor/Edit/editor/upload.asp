<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
on error resume next
Server.ScriptTimeOut=5000
%>
<!--#include file="UpLoadClass.asp"-->
<%
if Request.QueryString("action")="upload" then
dim MyRequest,lngUpSize,SavePath
SavePath="../uploadfile/" '设置图片上传目录（可以是相对路径）
SavePath=replace(SavePath,"\","/")
Set MyRequest=new UpLoadClass
MyRequest.SavePath=SavePath

'判断上传目录是否存在，不存在则自动创建
FolderPath=server.MapPath(SavePath)
Set FSO=Server.CreateObject("Scripting.FileSystemObject")
if FSO.FolderExists(FolderPath)=false then
FSO.CreateFolder(FolderPath)
end if
Set FSO=nothing

'取得当前文件所在目录
FileName=Right(Request.Servervariables("Script_Name"),len(Request.Servervariables("Script_Name"))-InstrRev(Request.Servervariables("Script_Name"),"/"))
FileFolder=replace(Request.Servervariables("Script_Name"),FileName,"") 

'获取图片地址的根绝对路径
if left(SavePath,1)="/" then
PicturePath=SavePath
else
PicturePath=FileFolder&SavePath
end if

lngUpSize = MyRequest.Open()
  select case MyRequest.error
         case 0
		 response.Write("<script>window.parent.LoadIMG('"&PicturePath&MyRequest.form("file1")&"');</script>")
         case 1
		 response.Write("<script>alert('文件过大！');window.parent.$('divProcessing').style.display='none';history.back();</script>")
		 case 2
		 response.Write("<script>alert('不允许上传该类型的文件！');window.parent.$('divProcessing').style.display='none';history.back();</script>")
         case 3
		 response.Write("<script>alert('不允许上传该类型的文件！');window.parent.$('divProcessing').style.display='none';history.back();</script>")
		 case else
		 response.Write("<script>alert('文件上传出错！');window.parent.$('divProcessing').style.display='none';history.back();</script>")
  end select
end if
%>