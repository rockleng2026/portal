package com.fuao.fajxc.util;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class MyProperties implements Map{

	private Map contentMap = new LinkedHashMap();
	
	public MyProperties(){
		
	}
	
	public void load(InputStream is,String encode){
		try {
			InputStreamReader isr = new InputStreamReader(is,encode);
			readToMap(isr);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void load(InputStream is){
		load(is,"UTF-8");
	}
	
	
	public void store(OutputStream os,String encode){
		try {
			PrintWriter pw = new PrintWriter(new OutputStreamWriter(os,encode));
			Iterator it = contentMap.keySet().iterator();
			while(it.hasNext()){
				String key = (String)it.next();
				pw.println(key+"="+contentMap.get(key));
			}
			pw.flush();
			pw.close();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void store(OutputStream os){
		store(os,"UTF-8");
	}
	
	private void readToMap(Reader reader){
		BufferedReader br = new BufferedReader(reader);
		String line = null;
		try {
			while((line=br.readLine()) != null){
				if(line.startsWith("#")){
					continue;
				}
				int index = line.indexOf("=");
				if(index > 0 && index < line.length() - 1){
					contentMap.put(line.substring(0, index), line.substring(index + 1));
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		;
	}
	

	public void clear() {
		contentMap.clear();
	}

	public boolean containsKey(Object arg0) {
		return contentMap.containsKey(arg0);
	}

	public boolean containsValue(Object arg0) {
		return contentMap.containsValue(arg0);
	}

	public Set entrySet() {
		return contentMap.entrySet();
	}

	public boolean equals(Object arg0) {
		return contentMap.equals(arg0);
	}

	public Object get(Object arg0) {
		return contentMap.get(arg0);
	}
	
	public String getProperty(String name) {
		return (String)contentMap.get(name);
	}

	public int hashCode() {
		return contentMap.hashCode();
	}

	public boolean isEmpty() {
		return contentMap.isEmpty();
	}

	public Set keySet() {
		return contentMap.keySet();
	}
	
	public void setProperty(String key,String value){
		put(key,value);
	}

	public Object put(Object arg0, Object arg1) {
		return contentMap.put(arg0, arg1);
	}

	public void putAll(Map arg0) {
		contentMap.putAll(arg0);
	}

	public Object remove(Object arg0) {
		return contentMap.remove(arg0);
	}

	public int size() {
		return contentMap.size();
	}

	public Collection values() {
		return contentMap.values();
	}
	public static void main(String[] args) {
		try {
		InputStream is = null ;
		InputStream is2 = null ;
		java.net.URL  url = MyProperties.class.getResource("/proper.properties");   
		File file = null;
		try {
			file = new File(url.toURI());
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
		if (!file.exists())   
		file.createNewFile();   
		is = new FileInputStream(file);
		System.out.println(file.getAbsolutePath());
		//MyProperties mp = new MyProperties();
		Properties p = new Properties();
		//is = MyProperties.class.getResourceAsStream("/proper.properties");
		//mp.load(is);
		p.load(is);
	    is.close();
		System.out.println(p.getProperty("grade"));
//		mp.setProperty("grade", "6:董事,5:总经理,4:高级经理,3:经理,2:主管,1:组长,7:xxx");
//		p.setProperty("grade", "6:董事,5:总经理,4:高级经理,3:经理,2:主管,1:组长,7:xxx");
//		p.put("xxx", "yyy");
//		System.out.println(mp.getProperty("grade"));
//		FileOutputStream os = null;
//		os = new FileOutputStream("/proper.properties");
//		//mp.store(os, "UTF-8");
//		p.store(os, "Update '" + p.getProperty("grade") + "' value");   
//		System.out.println(mp.getProperty("grade"));
//		os.close();
//		is2 = MyProperties.class.getResourceAsStream("/proper.properties");
//		Properties p2 = new Properties();
//		p2.load(is2);
//		is2.close();
//		System.out.println(p2.getProperty("grade"));
		}catch (IOException e) {
			e.printStackTrace();
		}
	

//	        Properties prop = new Properties();
//	        InputStream fis = null;
//	        OutputStream fos = null;
//	        try {
//	              java.net.URL  url = MyProperties.class.getResource("/proper2.properties");
//	            File file = new File(url.toURI());
//	            if (!file.exists())
//	                file.createNewFile();
//	            fis = new FileInputStream(file);
//	            prop.load(fis);
//	            fis.close();//一定要在修改值之前关闭fis
//	            fos = new FileOutputStream(file);
//	            prop.setProperty("grade", "6:董事,5:总经理,4:高级经理,3:经理,2:主管,1:组长,7:xxx");
//	            prop.store(fos, "Update '" + "grade" + "' value");
//	            fos.close();
//	            
//	        } catch (IOException e) {
//	            System.err.println("Visit  for updating ");
//	        } catch (URISyntaxException e) {
//	            // TODO Auto-generated catch block
//	            e.printStackTrace();
//	        }
//	        finally{
//	            try {
//	                fos.close();
//	                fis.close();
//	            } catch (IOException e) {
//	                // TODO Auto-generated catch block
//	                e.printStackTrace();
//	            }
//	        }
	    } 
	
}
