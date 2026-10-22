package test;
import   java.io.BufferedReader; 
import   java.io.File; 
import   java.io.FileOutputStream; 
import   java.io.InputStream; 
import   java.io.InputStreamReader; 
import   java.io.PrintWriter; 
import   java.net.HttpURLConnection; 
import   java.net.URL; 
import   java.util.Date; 

/** 
  *   @author   Administrator 
  * 
  *   To   change   the   template   for   this   generated   type   comment   go   to 
  *   Window&gt;Preferences&gt;Java&gt;Code   Generation&gt;Code   and   Comments 
  */ 
public   class   MakeHtml   { 
private   static   long   star   =   0; 
private   static   long   end   =   0; 
private   static   long   ttime   =   0; 

//返回html代码 
public   static   String   getHtmlCode(String   httpUrl){ 
Date   before   =   new   Date(); 
star   =   before.getTime(); 
String   htmlCode   =   " "; 
try   { 
InputStream     in; 
URL   url   =   new   java.net.URL(httpUrl); 
HttpURLConnection   connection   =   (HttpURLConnection)url.openConnection(); 
connection   =   (HttpURLConnection)   url.openConnection(); 
connection.setRequestProperty( "User-Agent ", "Mozilla/5.0 "); 
connection.connect(); 
in   =   connection.getInputStream(); 
java.io.BufferedReader   breader   =   new   BufferedReader(new   InputStreamReader(in   ,   "GBK ")); 
String   currentLine; 
    while((currentLine=breader.readLine())!=null){ 
htmlCode+=currentLine; 
    } 
}   catch   (Exception   e)   { 
e.printStackTrace(); 
}finally{ 
Date   after   =   new   Date(); 
end   =   after.getTime(); 
ttime   =   end-star   ; 
System.out.println( "执行时间: "+ttime   + "秒 "); 
} 
return   htmlCode; 
} 
//存储文件 
public   static   synchronized   void   writeHtml(String   filePath,String   info,String   flag)   { 

PrintWriter   pw   =   null; 
try   { 
File   writeFile   =   new   File(filePath); 
boolean   isExit   =   writeFile.exists(); 
if   (isExit   !=   true)   { 
writeFile.createNewFile(); 
}   else   { 
if   (!flag.equals( "NO "))   { 
writeFile.delete(); 
writeFile.createNewFile(); 
}   
} 
pw   =   new   PrintWriter(new   FileOutputStream(filePath,   true)); 
pw.println(info); 
pw.close(); 
}   catch   (Exception   ex)   { 
System.out.println(ex.getMessage()); 
}finally{ 
pw.close(); 
} 
} 

public   static   void   main(String[]   args)   { 
String   url   =   "e:/a.jsp "; 
writeHtml( "e:/a.jsp ",getHtmlCode(url), "NO "); 
} 
} 
