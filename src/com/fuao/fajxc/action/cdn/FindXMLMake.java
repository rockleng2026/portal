package com.fuao.fajxc.action.cdn;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class FindXMLMake {

	

	public  String addDistrictAddressXML(String basePath){
//		String basePath="src/xml/DistrictAddress.xml";
//		String basePath="DistrictAddress.xml";
		//已经到src目录下，后面可接文件夹名，文件名
		String path = getClass().getResource("/").getPath();
		
		try{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = DocumentHelper.createDocument();
			Element root = doc.addElement("Address");
			for(;;){
				Element disE = root.addElement("districtName");
				disE.addAttribute("disName","diatrictName");
				for(;;)
				{
					Element smName=disE.addElement("Name");
					smName.setText("smName");
					break;
				}break;
			}
			XMLWriter write = new XMLWriter(new FileOutputStream(new File(basePath)));
			write.write(doc);
			write.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return "successmakexml";
	}
	/**
	 * 只读大地址
	 * **/
	public List<String> ReadDistrictAddress1(String basePath)
	{
		//已经到src目录下，后面可接文件夹名，文件名
	//	String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
		basePath=basePath;
		List<String> disname=new ArrayList<String>();
		try {
				File f = new File(basePath);
				SAXReader reader = new SAXReader();
				Document doc = reader.read(f);
				Element root = doc.getRootElement();
				Element foo;
				for (Iterator i = root.elementIterator("districtName"); i.hasNext();) 
				{
					foo = (Element) i.next();
					disname.add(foo.attribute("disName").getValue());
				}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return disname;
	}

	/**
	 * 根据传进来的大地址，找到所对应的小地址
	 * **/
	public String ReadDistrictAddress2(String basePath, String getname)
	{
		//已经到src目录下，后面可接文件夹名，文件名
//		String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
		basePath=basePath;
		StringBuffer strb=new StringBuffer();
		try {
				File f = new File(basePath);
				SAXReader reader = new SAXReader();
				Document doc = reader.read(f);
				Element root = doc.getRootElement();
				Element foo,child;
	//			List<String> smdisname=new ArrayList<String>();
				for (Iterator i = root.elementIterator("districtName"); i.hasNext();) 
				{
					foo = (Element) i.next();
					String din=foo.attribute("disName").getValue();
					if(getname.equals(din))
					{
						for(Iterator s=foo.elementIterator("Name");s.hasNext();)
						{
							child=(Element)s.next();
						//	strb.append(child.asXML());
						//	System.out.println(child.asXML());
						//	smdisname.add(child.getStringValue());
							strb.append(child.getStringValue()+",");
						}
						break;
					}
				}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return strb.toString();
	}
	/**
	 * 
	 * **/
	public void findDistrictName()
	{
		//已经到src目录下，后面可接文件夹名，文件名
//		String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
//		basePath=path+basePath;
		try {
			File f = new File("src/xml/DistrictAddress.xml");
//			System.out.println("f  "+f.isFile());
			FileInputStream fis=new FileInputStream(f);
			InputStreamReader isr=new InputStreamReader(fis);
			BufferedReader br=new BufferedReader(isr);
			String str=br.readLine();
//			System.out.println("xml--------------->>>  "+str);
			br.close();
			isr.close();
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	/**
	* 写内容到文件：返回0文件写入出错，返回1文件写入成功
    * @param fileName  文件名和路径   已经到src目录下
    * @param content   要的内容
	 * **/
	public int writeFile(String finleName,String content)
	{
		//已经到src目录下，后面可接文件夹名，文件名
//		String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
		finleName=finleName;
//		System.out.println("写文件路径："+finleName);
		try{
			FileOutputStream fos=new FileOutputStream(finleName);
			OutputStreamWriter osw=new OutputStreamWriter(fos);
			BufferedWriter bw=new BufferedWriter(osw);
			bw.write(content);
			bw.flush();
			bw.close();
			osw.close();
			fos.close();
			return 1;
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return 0;
	}
	 /**http://www.cnblogs.com/lovebread/archive/2009/11/23/1609122.html
     *读文件，传进来文件地址名称  已经到src目录下
     */
    public  String readFile(String fileName) {
    	//已经到src目录下，后面可接文件夹名，文件名
//		String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
		fileName=fileName;
//		System.out.println("读文件路径："+fileName);
    	StringBuffer str=new StringBuffer();
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            int line = 1;
            while ((tempString = reader.readLine()) != null) {
            	str.append(tempString+"\n");
            }
            reader.close();
            return str.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {e1.printStackTrace();}
            }
        }
        return str.toString();
    }
    /** 
    * 追加文件到末尾：使用FileWriter 返回0文件追加出错，返回1文件追加成功
    * @param fileName  文件名和路径   已经到src目录下
    * @param content   要追加的内容
    */  
    public  int appendMethod(String fileName, String content){ 
    	//已经到src目录下，后面可接文件夹名，文件名
//		String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
		fileName=fileName;
//		System.out.println(fileName);
//		System.out.println("追加文件路径："+fileName);
	    try {  
	    	File file=new File(fileName);
		    //打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件   
		    FileWriter writer = new FileWriter(fileName, true);  
		    writer.write(content);  
		    writer.close();
		    return 1;
	    } catch (IOException e) {  
	    	e.printStackTrace();
	    }  
	    return 0;
    }  
    /**
     * 文件修改     返回0文件写入出错，返回1文件写入成功
     * @param fileName  文件名和路径   已经到src目录下
     * @param oldCode 要替换的原内容
     * @param newCode 要替换的新内容
     * **/
    public int updataFile(String fileName,String oldCode,String newCode)
    {
    	int m=0;
    	String ss=readFile(fileName);
    	StringBuffer sb=new StringBuffer(ss);
    	int n=sb.indexOf(oldCode);
    	if(n>-1)
    	{
    		int le=oldCode.length();
        	m=writeFile(fileName,sb.toString().replace(oldCode, newCode));
    	}
    	
    	return m;
    }
    /**
     * 在forntCode的字符串后面增加一个字符串，   返回0文件写入出错，返回1文件写入成功
     * @param fileName  文件名和路径   已经到src目录下
     * @param forntCode  要找的字符串
     * @param newCode 	要添加的字符串
     * **/
    public int addNewCodeInBehind(String fileName,String behindCode,String newCode)
    {
    	int m=0;
    	String ss=readFile(fileName);
    	StringBuffer sb=new StringBuffer(ss);
    	int n=sb.indexOf(behindCode);
    	if(n>-1)
    	{
    		int le=behindCode.length();
        	sb.replace(n+le, n+le, "\n"+newCode);
        	m=writeFile(fileName,sb.toString());
    	}
    	return m;
    }
    /**
     * 在forntCode的字符串前面增加一个字符串，   返回0文件写入出错，返回1文件写入成功
     * @param fileName  文件名和路径   已经到src目录下
     * @param forntCode  要找的字符串
     * @param newCode 	要添加的字符串
     * **/
    public int addNewCodeInFront(String fileName,String frontCode,String newCode)
    {
    	int m=0;
    	String ss=readFile(fileName);
    	StringBuffer sb=new StringBuffer(ss);
    	int n=sb.indexOf(frontCode);
    	if(n>-1)
    	{
        	sb.replace(n, n, newCode);
        	m=writeFile(fileName,sb.toString());
    	}
    	return m;
    }
    /**
     * 专为nginx.conf文件的添加
     * @param fileName 文件名和路径   已经到src目录下
     * @param startflag  开始标签
     * @param endflag	结束标签
     * @param oldCode	原代码
     * @param newCode	新代码
     * 返回结果，0出错，1成功，2没有找到原代码，就已经找到结束标记   ,3没有找到结束标记  , 5没有找到开始标记
     * **/
    public int addForNginx(String fileName,String startflag,String endflag,String oldCode,String newCode)
    {
    	int m=0;
    	//已经到src目录下，后面可接文件夹名，文件名
//		String path = getClass().getProtectionDomain().getCodeSource().getLocation().getPath()+"/../../../../../../";
    	StringBuffer str=new StringBuffer();
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            int line = 5;
            while ((tempString = reader.readLine()) != null) 
            {
            	if(line==5)//查找标记开始
            	{
            		if(tempString.indexOf(startflag)>-1)
            			line=3;
            	}
            	if(line==3)
            	{
            		if(tempString.indexOf(oldCode)>-1)//查找原代码  并替换
            		{
            			line=1;
            			StringBuffer sb=new StringBuffer(tempString);
            	    	int n=sb.indexOf(oldCode);
            	    	if(n>-1)
            	    	{
            	    		int le=oldCode.length();
            	        	sb.replace(n, n+le, newCode);
            	        	tempString=sb.toString();
            	    	}
            		}
            		if(tempString.indexOf(endflag)>-1)//没有找到原代码，就找到了结束标签
            		{
            			//找到标记结束
            			m=0;line=2;
            		}
            	}
            	str.append("\n"+tempString+"\n");
            }
            reader.close();
            if(line==2||line==3||line==5)
            	return line;
            return writeFile(fileName,str.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    	return m;
    }
    
    /**
     * 判断是否已经存在这断代码
     * 0不存在，1已经存在
     * **/
    public int judgeStr(String filename,String str)
    {
    	int m=0;
    	String ss=readFile(filename);
    	StringBuffer sb=new StringBuffer(ss);
    	int n=sb.indexOf(str);
    	if(n>-1)
        	m=1;
    	return m;
    }
    
    
    
    public static void copyFile(File sourceFile, File targetFile) throws IOException {
        BufferedInputStream inBuff = null;
        BufferedOutputStream outBuff = null;
        try {
            // 新建文件输入流并对它进行缓冲
           inBuff = new BufferedInputStream(new FileInputStream(sourceFile));

            // 新建文件输出流并对它进行缓冲
           outBuff = new BufferedOutputStream(new FileOutputStream(targetFile));

            // 缓冲数组
           byte[] b = new byte[1024 * 5];
            int len;
            while ((len = inBuff.read(b)) != -1) {
                outBuff.write(b, 0, len);
            }
            // 刷新此缓冲的输出流
           outBuff.flush();
        } finally {
            // 关闭流
           if (inBuff != null)
                inBuff.close();
            if (outBuff != null)
                outBuff.close();
        }
    }

    
    

   /**
    * 删除文件
    * @param 需要删除的文件
    */ 
    public static void delete(File file) { 
        if (!file.exists()) return; 
        if (file.isFile()) { 
                 file.delete(); 
         } else { 
                for (File f : file.listFiles()) { 
                         delete(f); 
                 } 
                 file.delete(); 
         } 
 }



    
    
	public static void main(String[] args) {
		FindXMLMake xml=new FindXMLMake();
		
		xml.updataFile("D:/soft/Tomcat 6.0/webapps/FAJxc/WEB-INF/classes/file/dianxin/www_30_com.conf", "29.com", "30.com");	
		
		System.out.println("设置完成");
	}
}
