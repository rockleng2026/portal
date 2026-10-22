package com.fuao.fajxc.util;

public class ChangeChar {
    static String s;
    public static String getStr(String str){
      try{
        s=new String(str.getBytes("ISO8859_1"),"GBK");
    	//  s=str;
      }
      catch(Exception e)
      {
        //System.out.println("changechar error:"+e.getMessage());
      }
      return s;
    }
    /*
     * 获取文件后缀名
     */
    public String getFileType(String filepath){
    	String filetype="";
    	if(filepath.length()>1)
    	{
    	   int i=filepath.lastIndexOf(".");
    	   filetype=filepath.substring(i+1);
    	}
    	filetype=filetype.trim();
    	if(filetype.length()<1)
    		filetype="unknown";
    	return filetype;
    }
    /*
     * 去除文件名中的逗号和"|"号
     */
    public String getName(String name)
    {
    	String newname="";
    	for(int i=0;i<name.length();i++)
    	{
    		String temp=String.valueOf(name.charAt(i));
    		if(temp.equals(",")||temp.equals("|"))
    			temp="";
    		newname=newname+temp;
    	}
    	newname=newname.trim();
    	return newname;
    }
    public static String getBStr(String str){
        try{
          s=new String(str.getBytes("ISO8859_1"),"UTF-8");
        }
        catch(Exception e)
        {
          //System.out.println("changechar error:"+e.getMessage());
        }
        return s;
      }
}
