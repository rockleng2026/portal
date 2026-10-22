<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import="com.jspsmart.upload.*"%>   

<body>
<%     
    //定义标记
   	//Cookies cok = new Cookies();
   	//request对象获取Cookie
  	//String uid = cok.getCookie(request, "adminuid");
    SmartUpload sma=new SmartUpload();
    //System.out.println("测试："+uid);
    //long file_max_size=4000000;   
    String ext="",msg="",filename1=""; 
    String regtime=new java.text.SimpleDateFormat("yyyy-MM-dd").format(java.util.Calendar.getInstance().getTime());
    String url="upload/picshow/"+regtime+"/"; 
    sma.initialize(pageContext);  
    String saveurl="";
    sma.upload();
    try{     
        com.jspsmart.upload.File myf=sma.getFiles().getFile(0);
	    if(myf.isMissing()){
	    msg = "文件不存在！";
	    }
	    else{
		    Calendar cal=Calendar.getInstance();   
		    String filename=String.valueOf(cal.getTimeInMillis());
		    ext=myf.getFileExt().equals("")?"jpg":myf.getFileExt();
		    //System.out.println("ext:"+ext);			   
		    String saveurlA=request.getRealPath("/")+url;
		    File fdira= new File(saveurlA);
		    if(!fdira.exists())
			fdira.mkdir();
			saveurl=saveurlA+"/";
			File fdir= new File(saveurl);
		    if(!fdir.exists())
			fdir.mkdir();
			filename1="/"+url+filename+"."+ext;  
		    saveurl+=filename+"."+ext;
		    myf.saveAs(saveurl,sma.SAVE_PHYSICAL);
		    //pp.proce1(saveurl,240,240,1.0f,"_sl");//压缩图片为240*240
		    //if(myf.getSize()>150000){
		    //pp.proce1(saveurl,1024,768,1.0f,"");//压缩图片为240*240
		   // }
		    msg = filename+"."+ext;
	    }
    }catch(Exception e)
	{
	  msg = "图片上传失败！";
	  e.printStackTrace();
	}  
   out.println("<script>parent.picCallback('" + msg+ "','"+filename1+"')</script>"); 
    %>   
</body>


