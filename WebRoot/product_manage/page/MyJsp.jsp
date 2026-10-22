<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>

    <script>
        function CheckFileSize(obj){
               if(obj.value != ""){
               //检测类型
               var val = obj.value;
               alert(val);
               if(/^.*?/.(gif|png|jpg|jpeg|bmp|JPG)$/.test(val))

               {
               }

               else

               {
                     alert("只能上传gif, png, jpg, bmp格式的图片");
                     return false;
               }
        
               var img = new Image();
               var AllowImgWidth =90;//允许的宽度 90px
               var AllowImgHeight=120;//允许的高度 120px
               var ImgWidth=img.width;//取得图片的宽度
               var ImgHeight=img.height;//取得图片的高度
               //alert(this.ImgObj.width+"||||"+this.ImgObj.height);  ljx 测试弹出图片宽、高！
               if(AllowImgWidth!=0&&AllowImgWidth<ImgWidth)

               {
                      alert("/n图片宽度超过限制。请上传宽度小于"+AllowImgWidth+"px的文件，当前图片宽度为"+ImgWidth+"px");

               }
  
               if(this.AllowImgHeight!=0&&this.AllowImgHeight<this.ImgHeight)

               {
                      alert("/n图片高度超过限制。请上传高度小于"+AllowImgHeight+"px的文件，当前图片高度为"+ImgHeight+"px"); 

               }
  
               var imgSize=200;//图片要求的尺寸200k
               img.onreadystatechange = function(){
               if(img.readyState == "complete")

               {
                   var imgfileSize=Math.round(img.fileSize/1024*100)/100;
                    //alert(imgfileSize); //ljx 测试图片大小
                    if(img.fileSize <=0 || imgfileSize > imgSize)

                    {
                           alert("当前文件大小" + imgfileSize + "KB, 超出最大限制 " + imgSize+ "KB");
                    }
               }
        }
        img.src = obj.value;
    }
}

    
    
</script>

  </head>
  
  <body>
    This is my JSP page. <br>
    <input type="file" id="imgProduct" onchange="CheckFileSize(this);"/>

    <input type="button" onclick="onchange();">
  </body>
</html>
