package com.fuao.fajxc.util;


import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Random;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


/**
 * <p>
 * Title: 字符串工具类
 * </p>
 * <p>
 * Description: 一些方便的字符串工具方法.
 * </p>
 * <p>
 * Company: BeanSoft Studio
 * </p>
 */

public class StringUtil {
	public StringUtil() {
	}
	/**
	 * 将字符串 source 中的 oldStr 替换为 newStr, 并以大小写敏感方式进行查找
	 *
	 * @param source
	 *            需要替换的源字符串
	 * @param oldStr
	 *            需要被替换的老字符串
	 * @param newStr
	 *            替换为的新字符串
	 */
	public static String replace(String source, String oldStr, String newStr) {
		return source.replace(oldStr, newStr);
		//return replace(source, oldStr, newStr, true);
	}
	
	/**
	 * 将字符串 source 中的 oldStr 替换为 newStr, matchCase 为是否设置大小写敏感查找
	 *
	 * @param source
	 *            需要替换的源字符串
	 * @param oldStr
	 *            需要被替换的老字符串
	 * @param newStr
	 *            替换为的新字符串
	 * @param matchCase
	 *            是否需要按照大小写敏感方式查找
	 */
	public static String replace(String source, String oldStr, String newStr,
			boolean matchCase) {
		if (source == null) {
			return null;
		}
		// 首先检查旧字符串是否存在, 不存在就不进行替换
		if (source.toLowerCase().indexOf(oldStr.toLowerCase()) == -1) {
			return source;
		}
		int findStartPos = 0;
		int a = 0;
		while (a > -1) {
			int b = 0;
			String str1, str2, str3, str4, strA, strB;
			str1 = source;
			str2 = str1.toLowerCase();
			str3 = oldStr;
			str4 = str3.toLowerCase();
			if (matchCase) {
				strA = str1;
				strB = str3;
			} else {
				strA = str2;
				strB = str4;
			}
			a = strA.indexOf(strB, findStartPos);
			if (a > -1) {
				b = oldStr.length();
				findStartPos = a + b;
				StringBuffer bbuf = new StringBuffer(source);
				//利用StringBuffer对象的replace方法实现新旧字符串替换
				source = bbuf.replace(a, a + b, newStr).toString();
				// 新的查找开始点位于替换后的字符串的结尾
				findStartPos = findStartPos + newStr.length() - b;
			}
		}
		return source;
	}

	
	/**
	 * 滤除帖子中的危险 HTML 代码, 主要是脚本代码, 滚动字幕代码以及脚本事件处理代码
	 *
	 * @param content
	 *            需要滤除的字符串
	 * @return 过滤的结果
	 */
	public static String replaceHtmlCode(String content) {
		if (isEmpty(content)) {
			return "";
		}
		// 需要滤除的脚本事件关键字
		String[] eventKeywords = { "onmouseover", "onmouseout", "onmousedown",
				"onmouseup", "onmousemove", "onclick", "ondblclick",
				"onkeypress", "onkeydown", "onkeyup", "ondragstart",
				"onerrorupdate", "onhelp", "onreadystatechange", "onrowenter",
				"onrowexit", "onselectstart", "onload", "onunload",
				"onbeforeunload", "onblur", "onerror", "onfocus", "onresize",
				"onscroll", "oncontextmenu","中共辟谣","共产党","政府",
				"中共查禁","中共独裁","中共高层内斗","中共海外渗透","中共黑匣子",
				"中共谎言","中共解体","中共内幕","中共迫害","中共陷内斗","中共邪党",
				"中共邪恶","中共一党专制","中共政权","中国共产党亡","中国利益集团黑幕",
				"中国冤民大同盟","中国政府对达赖喇嘛进行无端指责","转法轮","自由亚洲电台",
				"宗教迫害","中共","反共" };
		content = replace(content, "<script", "&ltscript", false);
		content = replace(content, "</script", "&lt/script", false);
		content = replace(content, "<marquee", "&ltmarquee", false);
		content = replace(content, "</marquee", "&lt/marquee", false);
		content = replace(content, "\r\n", "<BR>");
		// 滤除脚本事件代码
		for (int i = 0; i < eventKeywords.length; i++) {
			content = replace(content, eventKeywords[i],
					"_" + eventKeywords[i], false); // 添加一个"_", 使事件代码无效
		}
		return replaceSql(content);
	}
//=============================
	/**
	 * 过滤内容中的脚本事件关键字，但保留脚本功能和滚动效果
	 * @return str
	 */
	public static String replaceKeyWord(String content,String keys) {
		if (isEmpty(content)) {
			return "";
		}
		// 需要滤除的脚本事件关键字
		/*String[] eventKeywords = { "onmouseover", "onmouseout", "onmousedown",
				"onmouseup", "onmousemove", "onclick", "ondblclick",
				"onkeypress", "onkeydown", "onkeyup", "ondragstart",
				"onerrorupdate", "onhelp", "onreadystatechange", "onrowenter",
				"onrowexit", "onselectstart", "onload", "onunload",
				"onbeforeunload", "onblur", "onerror", "onfocus", "onresize",
				"onscroll", "oncontextmenu","中共辟谣","共产党","政府",
				"中共查禁","中共独裁","中共高层内斗","中共海外渗透","中共黑匣子",
				"中共谎言","中共解体","中共内幕","中共迫害","中共陷内斗","中共邪党",
				"中共邪恶","中共一党专制","中共政权","中国共产党亡","中国利益集团黑幕",
				"中国冤民大同盟","中国政府对达赖喇嘛进行无端指责","转法轮","自由亚洲电台",
				"宗教迫害","中共","反共","枪" };*/
		String[] eventKeywords = {keys};
		content = replace(content, "<script", "&ltscript", false);
		content = replace(content, "</script", "&lt/script", false);
		content = replace(content, "<marquee", "&ltmarquee", false);
		content = replace(content, "</marquee", "&lt/marquee", false);
		content = replace(content, "\r\n", "<br>", false);
		content = replace(content, "\r", "<br>", false);
		content = replace(content, "\n", "<br>", false);
		content = replace(content, "<br/>", "", false);
		content = replace(content, "\"", "”", false);
		content = replace(content, "<BR>", "", false);
		
		// 滤除脚本事件代码
		for (int i = 0; i < eventKeywords.length; i++) {
			content = replace(content, eventKeywords[i],
					"***", false); // 添加一个"_", 使事件代码无效
		}
		return content;
	}
//=================================
//	=============================
	/**
	 * 过滤内容中的脚本事件关键字以及文中  样式，但保留脚本功能和滚动效果
	 * @return str
	 */
	public static String replaceKeyStyle(String content) {
		if (isEmpty(content)) {
			return "";
		}
		// 需要滤除的脚本事件关键字
		String[] eventKeywords = { "onmouseover", "onmouseout", "onmousedown",
				"onmouseup", "onmousemove", "onclick", "ondblclick",
				"onkeypress", "onkeydown", "onkeyup", "ondragstart",
				"onerrorupdate", "onhelp", "onreadystatechange", "onrowenter",
				"onrowexit", "onselectstart", "onload", "onunload",
				"onbeforeunload", "onblur", "onerror", "onfocus", "onresize",
				"onscroll", "oncontextmenu","style","class","font","中共辟谣",
				"中共查禁","中共独裁","中共高层内斗","中共海外渗透","中共黑匣子",
				"中共谎言","中共解体","中共内幕","中共迫害","中共陷内斗","中共邪党",
				"中共邪恶","中共一党专制","中共政权","中国共产党亡","中国利益集团黑幕",
				"中国冤民大同盟","中国政府对达赖喇嘛进行无端指责","转法轮","自由亚洲电台",
				"宗教迫害","中共" };
		content = replace(content, "<script", "&ltscript", false);
		content = replace(content, "</script", "&lt/script", false);
		content = replace(content, "<marquee", "&ltmarquee", false);
		content = replace(content, "</marquee", "&lt/marquee", false);
		content = replace(content, "共产党", "***", false);
		content = replace(content, "中国共产党", "***", false);
		content = replace(content, "胡锦涛", "***", false);
		content = replace(content, "温家宝", "***", false);
		content = replace(content, "\r\n", "<br>", false);
		content = replace(content, "<br/>", "", false);
		//content = replace(content, "<br />", "", false);
		content = replace(content, "<BR>", "", false);
		
		// 滤除脚本事件代码
		for (int i = 0; i < eventKeywords.length; i++) {
			content = replace(content, eventKeywords[i],
					"***" , false); // 添加一个"_", 使事件代码无效
		}
		return content;
	}
	/**
	 * 滤除 HTML 代码标签使其以文本形式显示.
	 */
	public static String replaceHtmlToText(String input) {
		if (isEmpty(input)) {
			return "";
		}
		return setBr(setTag(input));
	}

	// 滤除 HTML 标记
	public static String setTag(String s) {
		int j = s.length();
		StringBuffer stringbuffer = new StringBuffer(j + 500);
		char ch;
		for (int i = 0; i < j; i++) {
		    ch = s.charAt(i);
			if (ch == '<') {
				stringbuffer.append("&lt");
			} else if (ch == '>') {
				stringbuffer.append("&gt");
			} else if (ch == '&') {
				stringbuffer.append("&amp");
			} else {
				stringbuffer.append(ch);
			}
		}

		return stringbuffer.toString();
	}

	/** 滤除 BR 代码 */
	public static String setBr(String s) {
		int j = s.length();
		StringBuffer stringbuffer = new StringBuffer(j + 500);
		for (int i = 0; i < j; i++) {

			if(s.charAt(i) == '\n' || s.charAt(i) == '\r') {
			    continue;
			} else {
				stringbuffer.append(s.charAt(i));
			}
		}

		return stringbuffer.toString();
	}

	/** 将' '这种形式的空格转换为&nbsp;格式 */
	public static String setNbsp(String s) {
		int j = s.length();
		StringBuffer stringbuffer = new StringBuffer(j + 500);
		for (int i = 0; i < j; i++) {
			if (s.charAt(i) == ' ') {
				stringbuffer.append("&nbsp;");
			} else {
				stringbuffer.append(s.charAt(i) + "");
			}
		}
		return stringbuffer.toString();
	}
	/** 滤除html代码 */
	 public static String Html2Text(String inputString) 
	 {
	        String htmlStr = inputString; //含html标签的字符串
	        String textStr ="";
	        java.util.regex.Pattern p_script;
	        java.util.regex.Matcher m_script;
	        java.util.regex.Pattern p_style;
	        java.util.regex.Matcher m_style;
	        java.util.regex.Pattern p_html;
	        java.util.regex.Matcher m_html;

	        try 
	        {
	         String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
	         String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; //定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style> }
	         //String regEx_html = "<[^>]+>"; //定义HTML标签的正则表达式
	         String regEx_FONT = "<[\\s]*?FONT[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?FONT[\\s]*?>"; //定义HTML标签的正则表达式

	         p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);
	         m_script = p_script.matcher(htmlStr);
	         htmlStr = m_script.replaceAll(""); //过滤script标签
//	         htmlStr = m_script.
	         
	         p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);
	         m_style = p_style.matcher(htmlStr);
	         htmlStr = m_style.replaceAll(""); //过滤style标签

/*	         p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);
	         m_html = p_html.matcher(htmlStr);
	         htmlStr = m_html.replaceAll(""); //过滤html标签
*/	         
	         p_html = Pattern.compile(regEx_FONT,Pattern.CASE_INSENSITIVE);
	         m_html = p_html.matcher(htmlStr);
	         htmlStr = m_html.replaceAll(""); //过滤font标签
	         
	         textStr = htmlStr;
	        }
	        catch(Exception e) 
	        {
	         System.err.println("Html2Text: " + e.getMessage());
	        }
	        return textStr;//返回文本字符串
	       } 
	 /**
		 * 滤除 HTML 代码标签(< > &)使其以文本形式显示.保留制表符和回车符
		 * 
		 */
		public static String replaceHtml2ToText(String input) {
			if (isEmpty(input)) {
				return "";
			}
			return setTag(input);
		}
	/**
	 * 判断字符串是否全是数字字符.
	 *
	 * @param input
	 *            输入的字符串
	 * @return 判断结果, true 为全数字, false 为还有非数字字符
	 */
	public static boolean isNumeric(String input) {
		if (isEmpty(input)) {
			return false;
		}

		for (int i = 0; i < input.length(); i++) {
			char charAt = input.charAt(i);

			if (!Character.isDigit(charAt)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 转换由表单读取的数据的内码(从 ISO8859 转换到 gb2312).
	 *
	 * @param input
	 *            输入的字符串
	 * @return 转换结果, 如果有错误发生, 则返回原来的值
	 */
	public static String toChi(String input) {
		try {
			byte[] bytes = input.getBytes("ISO8859-1");
			return new String(bytes, "GBK");
		} catch (Exception ex) {
		}
		return input;
	}

	/**
	 * 转换由表单读取的数据的内码到 ISO(从 GBK 转换到ISO8859-1).
	 *
	 * @param input
	 *            输入的字符串
	 * @return 转换结果, 如果有错误发生, 则返回原来的值
	 */
	public static String toISO(String input) {
		return changeEncoding(input, "GBK", "ISO8859-1");
	}

	/**
	 * 转换字符串的内码.
	 *
	 * @param input
	 *            输入的字符串
	 * @param sourceEncoding
	 *            源字符集名称
	 * @param targetEncoding
	 *            目标字符集名称
	 * @return 转换结果, 如果有错误发生, 则返回原来的值
	 */
	public static String changeEncoding(String input, String sourceEncoding,
			String targetEncoding) {
		if (input == null || input.equals("")) {
			return input;
		}

		try {
			byte[] bytes = input.getBytes(sourceEncoding);
			return new String(bytes, targetEncoding);
		} catch (Exception ex) {
		}
		return input;
	}

	/**
	 * 将单个的 ' 换成 ''; SQL 规则:
	 * 如果单引号中的字符串包含一个嵌入的引号,
	 * 可以使用两个单引号表示嵌入的单引号.
	 */

	public static String replaceSql(String input) {
		return replace(input, "'", ".");
	}

	/**
	 * 对给定字符进行 URL 编码
	 */
	public static String encode(String value) {
		if (isEmpty(value)) {
			return "";
		}
		try {
			value = java.net.URLEncoder.encode(value, "GB2312");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return value;
	}

	/**
	 * 对给定字符进行 URL 解码
	 *
	 * @param value
	 *            解码前的字符串
	 * @return 解码后的字符串
	 */
	public static String decode(String value) {
		if (isEmpty(value)) {
			return "";
		}

		try {
			return java.net.URLDecoder.decode(value, "GB2312");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return value;
	}

	
	/**
	 * 得到文件的扩展名.
	 *
	 * @param fileName
	 *            需要处理的文件的名字.
	 * @return the extension portion of the file's name.
	 */
	public static String getExtension(String fileName) {
		if (fileName != null) {
			int i = fileName.lastIndexOf('.');
			if (i > 0 && i < fileName.length() - 1) {
				return fileName.substring(i + 1).toLowerCase();
			}
		}
		return "";
	}

	/**
	 * 得到文件的前缀名.
	 *
	 * @param fileName
	 *            需要处理的文件的名字.
	 * @return the prefix portion of the file's name.
	 */
	public static String getPrefix(String fileName) {
		if (fileName != null) {
			int i = fileName.lastIndexOf('.');
			//文件名有时传过来是地址所以在这里进一步处理一下
			int k=fileName.lastIndexOf('/');
			if (i > 0 && i < fileName.length() - 1) {
				return fileName.substring(k+1, i);
			}
		}
		return "";
	}

	// ------------------------------------ 参数处理方法
	// ----------------------------------------------

	/**
	 * 根据 Cookie 名称得到请求中的 Cookie 值, 需要事先给 _request 一个初始值; 
	 * 如果 Cookie 值是 null, 则返回 ""
	 */
	public static String getCookieValue(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (cookies == null) {
			return "";
		}
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals(name)) {
				// 需要对 Cookie 中的汉字进行 URL 反编码, 适用版本: Tomcat 4.0
				return decode(cookie.getValue());
			}
		}
		return "";
	}	
	/**
	 * 删除指定的 Web 应用程序目录下所上传的文件
	 *
	 * @param application
	 *            JSP/Servlet 的 ServletContext
	 * @param filePath
	 *            相对文件路径
	 */
	public static void deleteFile(ServletContext application, String filePath) {
		if (!isEmpty(filePath)) {
			String physicalFilePath = application.getRealPath(filePath);
			if (!isEmpty(physicalFilePath)) {
				java.io.File file = new java.io.File(physicalFilePath);
				file.delete();
			}
		}
	}

	/**
	 * 在指定的 Web 应用程序目录下以指定路径创建文件
	 *
	 * @param application
	 *            JSP/Servlet 的 ServletContext
	 * @param filePath
	 *            相对文件路径
	 */
	public static boolean createFile(ServletContext application, String filePath) {
		if (!isEmpty(filePath)) {
			String physicalFilePath = application.getRealPath(filePath);
			if (!isEmpty(physicalFilePath)) {
				java.io.File file = new java.io.File(physicalFilePath);

				try {
					// 创建文件
					return file.createNewFile();
				} catch (IOException e) {
					System.err.println("Unable to create file "
							+ filePath);
				}
			}
		}

		return false;
	}

	/**
	 * 在指定的 Web 应用程序目录下以指定路径创建目录.
	 *
	 * @param application
	 *            JSP/Servlet 的 ServletContext
	 * @param filePath
	 *            相对文件路径
	 */
	public static boolean createDir(ServletContext application, String filePath) {
		if (!isEmpty(filePath)) {
			String physicalFilePath = application.getRealPath(filePath);
			if (!isEmpty(physicalFilePath)) {
				try {
					// 创建目录
					java.io.File dir = new java.io.File(application
							.getRealPath(filePath));
					return dir.mkdirs();
				} catch (Exception e) {
					System.err
							.println("Unable to create directory " + filePath);
				}
			}
		}

		return false;
	}
	//传入以获取的真是路径
	public static void createDir(String path)
	{
		int i1=path.lastIndexOf("\\");
		String name=path.substring(i1-8,i1);
		int intname=Integer.parseInt(name)-1;
		String delpath=path.substring(0,i1-8)+intname;
		
		File dir=new File(path);
		//System.out.print(i1+"ssssss"+delpath);
		if(!dir.exists())
		{	
			try
			{
				dir.mkdir();
				StringUtil.deletefile(delpath);
			}catch(Exception e){e.printStackTrace();}
		}	
	}//end method createdir
	/**
	 * 检查指定的 Web 应用程序目录下的文件是否存在.
	 *
	 * @param application
	 *            JSP/Servlet 的 ServletContext
	 * @param filePath
	 *            相对文件路径
	 * @return boolean - 文件是否存在
	 */
	public static boolean checkFileExists(ServletContext application, String filePath) {
		if (!isEmpty(filePath)) {
			String physicalFilePath = application.getRealPath(filePath);
			if (!isEmpty(physicalFilePath)) {
				java.io.File file = new java.io.File(physicalFilePath);
				return file.exists();
			}
		}

		return false;
	}
	/**
	 * 删除包含文件的文件夹
	 */
	public static boolean deletefile(String delpath) throws FileNotFoundException, IOException 
	{ 
		try 
		{ 
		  File file = new File(delpath); 
		  if (!file.isDirectory()) { 
		    file.delete(); 
		  } 
		  else if (file.isDirectory()) { 
		    String[] filelist = file.list(); 
		    for (int i = 0; i < filelist.length; i++) { 
		    File delfile = new File(delpath + "\\" + filelist[i]); 
		    if (!delfile.isDirectory()) 
		      delfile.delete(); 
		    else if (delfile.isDirectory()) 
		      deletefile(delpath + "\\" + filelist[i]); 
		    } 
		    file.delete(); 
		  } 
		} 
		catch (FileNotFoundException e) 
		{ 
		  e.printStackTrace(); 
		} 
		return true;   
    }  
	
	
	
	/**
	 * 判断字符串是否未空, 如果为 null 或者长度为0, 均返回 true.
	 */
	private static boolean isEmpty(String input) {
		return (input == null || input.length() == 0);
	}
	 
	/**
	 * 判断字符串是否为空或null 如果为空或null就返回true
	 * @param s
	 * @return
	 */
	public static boolean isnull(String s)
	{
		if(s==null||s.equals("")||s =="")
		{
			return true;
		}
		return false;
	}
	/**
	 * 输出分页显示的结果.
	 *
	 * @param page
	 *            当前页面
	 * @param recordCount
	 *            所有结果总数
	 * @param pageSize
	 *            一页显示的多少
	 * @param pageCountSize
	 *            前后跳页的多少
	 * @param linkpageurl
	 *            连接页面的 URL 字符串
	 * @return 分页结果的字符串.
	 */
	public static String paging(int page, int recordCount, int pageSize,
			int pageCountSize, String linkpageurl) {
		int PageCount = -1; //所有页面总数
		String LinkPageName = linkpageurl;
		String LinkText = "";//定义返回的参数
		int StartPage;//首页
		int TempPage;//上一个页面数
		int TempPageCount;//临时总页数
		TempPage = (page - 1) % pageCountSize; //上一个页面数
		StartPage = page - TempPage; //首页
		TempPageCount = recordCount % pageSize;//总页数
		if (TempPageCount == 0) {
			PageCount = recordCount / pageSize;//所有页面总数
		} else {
			PageCount = (recordCount / pageSize) + 1; //
		}
		String txtPrev = "前" + pageCountSize + "页";
		String txtNext = "后" + pageCountSize + "页";
		String txtStart = "首页";
		String txtEnd = "末页";
		//首页
		//if (StartPage - 1 > 0) {
		//判断他不是首页，就在linktext中添加首页连接
		if (page - 1 > 0) {
			LinkText += "<a href='" + LinkPageName + "&page=1' title='到首页'>"
					+ txtStart + "</a>";
		} else {
//			LinkText += txtStart;
			LinkText += "";
		}
		//如果首页大于
		if (StartPage - 1 > 0) {
			LinkText += "<a href='" + LinkPageName + "&page=" + (StartPage - 1)
					+ "' title='到第" + pageCountSize + "页'>" + txtPrev + "</a>";
		} else {
//			LinkText += txtPrev;
			LinkText += "";
		}
		
		int i=0;//向后读取做的标记
		int t=0;//向前读取的标记
		int j=0;//向后读取
		int n=0;
		if(page-pageCountSize<=0)
		{
		 	n=1;
		}else {
			n=page-pageCountSize;
		}		
		//向前读取
		for ( j=0,t=n; t<page ; t++,j++) {
			if(j==pageCountSize)
			{
				break;
			}
			System.out.println("t~~~~~~~~~~"+t);
			LinkText += "<a href='" + LinkPageName + "&page=";
			LinkText += t + "' title='" + t + "页'>";
			LinkText += t ;
			LinkText += "</a>";
		}
		//向后读取
		for ( j=0,i=page; i <= PageCount; i++,j++) {
				if(j==pageCountSize+1)
				{
					break;
				}
				if(i==page)
				{
					LinkText += "<a href='" + LinkPageName + "&page=";
					LinkText += i + "' title='" + i + "页'>";
					LinkText += "<font color='#FF0000'>"+i+"</font>" ;
					LinkText += "</a>";
				}else{
				System.out.println("i~~~~~~~~~~"+i);
				LinkText += "<a href='" + LinkPageName + "&page=";
				LinkText += i + "' title='" + i + "页'>";
				LinkText += i ;
				LinkText += "</a>";
				}
			}	
		//中间页面
		if (StartPage + pageCountSize - PageCount - 1 < 0) {
			LinkText += "<a href='" + LinkPageName + "&page="
					+ (StartPage + pageCountSize) + "' title='到第"
					+ pageCountSize + "页'>" + txtNext + "</a>";
		} else {
//			LinkText += txtNext;
			LinkText += "";
		}
		//最后一页
		//if (StartPage + pageCountSize <= PageCount) {
		if (page < PageCount) {
			if(PageCount>1)
			LinkText += "<a href='" + LinkPageName + "&page=" + PageCount
					+ "' title='最后一页'>" + txtEnd + "</a>";
		} else {
//			LinkText += txtEnd;
			LinkText += "";
		}
		return LinkText;
	}
	
	/**
	 * 输出分页显示的结果.
	 *
	 * @param page
	 *            当前页面
	 * @param recordCount
	 *            所有结果总数
	 * @param pageSize
	 *            一页显示的多少
	 * @param pageCountSize
	 *            前后跳页的多少
	 * @param linkpageurl
	 *            连接页面的 URL 字符串
	 * @return 分页结果的字符串.
	 */
	public static String paging2(int page, int recordCount, int pageSize,
			int pageCountSize, String linkpageurl) {
		int PageCount = -1; //所有页面总数
		String LinkPageName = linkpageurl;
		String LinkText = "";//定义返回的参数
		int StartPage;//首页
		int TempPage;//上一个页面数
		int TempPageCount;//临时总页数
		TempPage = (page - 1) % pageCountSize; //上一个页面数
		StartPage = page - TempPage; //首页
		TempPageCount = recordCount % pageSize;//总页数
		if (TempPageCount == 0) {
			PageCount = recordCount / pageSize;//所有页面总数
		} else {
			PageCount = (recordCount / pageSize) + 1; //
		}
		String txtPrev = "前" + pageCountSize + "页";
		String txtNext = "后" + pageCountSize + "页";
		String txtStart = "首页";
		String txtEnd = "末页";
		
		//最后一页
		//if (StartPage + pageCountSize <= PageCount) {
		if (page < PageCount) {
			if(PageCount>1)
			LinkText += "<a href='" + LinkPageName + "&page=" + PageCount
					+ "' title='最后一页'>" + txtEnd + "</a>";
		} else {
//			LinkText += txtEnd;
			LinkText += "";
		}
		
		//中间页面
		if (StartPage + pageCountSize - PageCount - 1 < 0) {
			LinkText += "<a href='" + LinkPageName + "&page="
					+ (StartPage + pageCountSize) + "' title='到第"
					+ pageCountSize + "页'>" + txtNext + "</a>";
		} else {
//			LinkText += txtNext;
			LinkText += "";
		}
		
		int i=0;//向后读取做的标记
		int t=0;//向前读取的标记
		int j=0;//向后读取
		int n=0;
		
		if(page-pageCountSize<=0)
		{
		 	n=1;
		}else {
			n=page-pageCountSize;
		}
		
		//向后读取
		for ( j=0,i=PageCount; i >=page ; i--,j++) {
				if(j==pageCountSize+1)
				{
					break;
				}
				if(i==page)
				{
					LinkText += "<a href='" + LinkPageName + "&page=";
					LinkText += i + "' title='" + i + "页'>";
					LinkText += "<font color='#FF0000'>"+i+"</font>" ;
					LinkText += "</a>";
				}else{
				System.out.println("i~~~~~~~~~~"+i);
				LinkText += "<a href='" + LinkPageName + "&page=";
				LinkText += i + "' title='" + i + "页'>";
				LinkText += i ;
				LinkText += "</a>";
				}
			}
		
		//向前读取
		for ( j=0,t=page-1; t>n ; t--,j++) {
			if(j==pageCountSize)
			{
				break;
			}
			System.out.println("t~~~~~~~~~~"+t);
			LinkText += "<a href='" + LinkPageName + "&page=";
			LinkText += t + "' title='" + t + "页'>";
			LinkText += t ;
			LinkText += "</a>";
		}
		
		//首页
		//if (StartPage - 1 > 0) {
		//判断他不是首页，就在linktext中添加首页连接
		if (page - 1 > 0) {
			LinkText += "<a href='" + LinkPageName + "&page=1' title='到首页'>"
					+ txtStart + "</a>";
		} else {
//			LinkText += txtStart;
			LinkText += "";
		}
		//如果首页大于
		if (StartPage - 1 > 0) {
			LinkText += "<a href='" + LinkPageName + "&page=" + (StartPage - 1)
					+ "' title='到第" + pageCountSize + "页'>" + txtPrev + "</a>";
		} else {
//			LinkText += txtPrev;
			LinkText += "";
		}
		
		return LinkText;
	}


	// -----------------------------------------------------------
	// ---------- 字符串和数字转换工具方法 --------
	//------------------------------------------------------------
	public static byte getByte(HttpServletRequest httpservletrequest, String s) {
		if (httpservletrequest.getParameter(s) == null
				|| httpservletrequest.getParameter(s).equals("")) {
			return 0;
		} else {
			return Byte.parseByte(httpservletrequest.getParameter(s));
		}
	}

	/**
	 * Reading a parameter as integer from the http servlet request.
	 *
	 */
	public static int getInt(HttpServletRequest httpservletrequest, String s) {
		if (httpservletrequest.getParameter(s) == null
				|| httpservletrequest.getParameter(s).equals("")) {
			return 0;
		} else {
			return Integer.parseInt(httpservletrequest.getParameter(s));
		}
	}

	public static long getLong(HttpServletRequest httpservletrequest, String s) {
		if (httpservletrequest.getParameter(s) == null
				|| httpservletrequest.getParameter(s).equals("")) {
			return 0L;
		} else {
			return Long.parseLong(httpservletrequest.getParameter(s));
		}
	}

	public static short getShort(HttpServletRequest httpservletrequest, String s) {
		if (httpservletrequest.getParameter(s) == null
				|| httpservletrequest.getParameter(s).equals("")) {
			return 0;
		} else {
			return Short.parseShort(httpservletrequest.getParameter(s));
		}
	}

	/**
	 * 将 TEXT 文本转换为 HTML 代码, 已便于网页正确的显示出来.
	 *
	 * @param input
	 *            输入的文本字符串
	 * @return 转换后的 HTML 代码
	 */
	public static String textToHtml(String input) {
		if (isEmpty(input)) {
			return "";
		}
		input = replace(input, "<", "&#60;");
		input = replace(input, ">", "&#62;");

		input = replace(input, "\n", "<br>\n");
		input = replace(input, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
		input = replace(input, "  ", "&nbsp;&nbsp;");

		return input;
	}
	
	/**
	 * 将 TEXT 文本转换为 HTML 代码, 已便于网页正确的显示出来.
	 * 去掉了屏蔽< >
	 * @param input
	 *            输入的文本字符串
	 * @return 转换后的 HTML 代码
	 */
	public static String textToHtml2(String input) {
		if (isEmpty(input)) {
			return "";
		}
//		input = replace(input, "<", "&#60;");
//		input = replace(input, ">", "&#62;");

		input = replace(input, "\n", "<br>\n");
		input = replace(input, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
		input = replace(input, "  ", "&nbsp;&nbsp;");

		return input;
	}

	public static String toQuoteMark(String s) {
		s = replaceString(s, "'", "&#39;");
		s = replaceString(s, "\"", "&#34;");
		s = replaceString(s, "\r\n", "\n");
		return s;
	}

	public static String replaceChar(String s, char c, char c1) {
		if (s == null) {
			return "";
		} else {
			return s.replace(c, c1);
		}
	}

	public static String replaceString(String s, String s1, String s2) {
		if (s == null || s1 == null || s2 == null) {
			return "";
		} else {
			return s.replaceAll(s1, s2);
		}
	}

	public static String toHtml(String s) {
		s = replaceString(s, "<", "&#60;");
		s = replaceString(s, ">", "&#62;");
		return s;
	}

	public static String toBR(String s) {
		s = replaceString(s, "\n", "<br>\n");
		s = replaceString(s, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
		s = replaceString(s, "  ", "&nbsp;&nbsp;");
		return s;
	}

	public static String toSQL(String s) {
		s = replaceString(s, "\r\n", "\n");
		return s;
	}

	public static String replaceEnter(String s) throws NullPointerException {
		return s.replaceAll("\n", "<br>");
	}

	public static String replacebr(String s) throws NullPointerException {
		return s.replaceAll("<br>", "\n");
	}

	public static String replaceQuote(String s) throws NullPointerException {
		return s.replaceAll("'", "''");
	}
	/**
	 * 返回一个由字符串转化的日期(不是有效日期,则返回NULL)
	 * 
	 * @param strDate
	 *            String
	 * @return Date
	 */
	public static Date toDate(String strDate) {
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			return (Date) df.parse(strDate);
		} catch (Exception ex) {
			return null;
		}
	}
	/**
	 * 一个字串的首字母大写
	 * 
	 * @param s
	 *            String
	 * @return String
	 */
	public static String toUpperCaseFirstLetter(String s) {
		return isNullStr(s) ? s : s.substring(0, 1).toUpperCase()
				+ s.substring(1);
	}
	/**
	 * 判断是否是空串
	 * 
	 * @param o
	 *            Object
	 * @return boolean
	 */
	public static boolean isNullStr(Object o) {
		return (o == null || o.toString().equals("null") || o.toString()
				.equals("")) ? true : false;
	}
   
	  /**
    去掉字符串两端的空白字符,并将字符串转化为中国的标准字符utf-8的字符串.CS
    */
   public static String TrimAndConvert(String str) { //去掉字符串2端的空白字符
       try {
           if (str == null)
               return "";
           str = str.trim();
           if (str == null)
               return "";
           str = new String(str.getBytes("8859_1"), "utf-8");
       }
       catch (Exception e) {
           System.out.println(e);
       }
       return str;
   }
   //过滤所有Html代码
   public static String clearContentsKey(String str,String keys){
	   StringBuffer s = new StringBuffer(8000);
	   StringBuffer ss = new StringBuffer(8000);
	   if(str!=null && !str.equals(""))
	   {
		   int count = 0;
		   int total = 1;
		   int sign1 = 0;
		   int sign2 = 0;
		   for(int i=0;i<str.length();i++){
		    char c = str.charAt(i);
		    if(c=='<'){
		     sign1 = total;
		    }
		    if(c=='>'){
		     sign2 = total;
		     ss.append(c);
		    }
		    if(sign2-sign1>0){
		     /*
		     if(ss.toString().equalsIgnoreCase("<br>")){
		      s.append("<br>");
		     }*/
		     ss.delete(0,total);
		     sign1 = 0;
		     sign2 = 0;
		     total = 1;
		     continue;
		    }
		    if(sign1!=0){
		     total++;
		     ss.append(c);
		     continue;
		    }
		    
		    count++;
		    s.append(c);
		    
		    if(count==8000){
		     break;
		    }
		   }
	   }
	   else
	   {
		   str="";
		   s.append(str);
	   }
	   return replaceSql(replaceKeyWord(s.toString(),keys));
	  }
   //过滤字符串字段
   public static String clearStr(String str){
	   StringBuffer s = new StringBuffer(8000);
	   StringBuffer ss = new StringBuffer(8000);
	   if(str!=null && !str.equals(""))
	   {
		   int count = 0;
		   int total = 1;
		   int sign1 = 0;
		   int sign2 = 0;
		   for(int i=0;i<str.length();i++){
		    char c = str.charAt(i);
		    if(c=='<'){
		     sign1 = total;
		    }
		    if(c=='>'){
		     sign2 = total;
		     ss.append(c);
		    }
		    if(sign2-sign1>0){
		     /*
		     if(ss.toString().equalsIgnoreCase("<br>")){
		      s.append("<br>");
		     }*/
		     ss.delete(0,total);
		     sign1 = 0;
		     sign2 = 0;
		     total = 1;
		     continue;
		    }
		    if(sign1!=0){
		     total++;
		     ss.append(c);
		     continue;
		    }
		    
		    count++;
		    s.append(c);
		    
		    if(count==8000){
		     break;
		    }
		   }
	   }
	   else
	   {
		   str="";
		   s.append(str);
	   }
	   return replaceSql(replaceKeyStyle(s.toString()));
	  }
   /**
	 * 主要是关键字串处理(部分替换:根据需要修改)
	 * 
	 * @param szSrc
	 *            String
	 * @return String 专用方法(为了调用方便,暂时放在该工具类中),
	 * 因为调用处较多,暂不拆分 本函数不属工具类函数(业务处理调用)
	 */
	public static String toKeyStr(String szSrc) {
		if (szSrc == null || szSrc.trim().equals(""))
			return "";
		String szTmp = szSrc.trim();
		szTmp = replace(szTmp, "\"", "");
		szTmp = replace(szTmp, "，", ",");
		szTmp = replace(szTmp, "；", ";");
		szTmp = replace(szTmp, "\uFF08", "(");
		szTmp = replace(szTmp, "\uFF09", ")");
		szTmp = replace(szTmp, "'", "''");
		szTmp = replace(szTmp, " and ", ",");
		szTmp = replace(szTmp, " or ", ";");
		szTmp = replace(szTmp, " ", "");

		szTmp = replace(szTmp, ",", " and ");
		szTmp = replace(szTmp, ";", " or ");
		return szTmp;
	}

	/**
	 * 把指定字串拆分为数组，以逗号分割。
	 * 
	 * @param list
	 *            String
	 * @return String[]
	 */
	public static String[] splitStr(String list) {
		String[] arrStr = null;
		Hashtable hb = null;
		String str = null;
		String key = null;
		Object obj = null;
		int iLen = 0;
		int iPos = -1;
		int iTmp = -1;
		if ((list == null) || list.trim().equals("")) {
			return new String[0];
		} else {
			str = list.trim();
		}

		hb = new Hashtable();
		iPos = str.indexOf(',');
		if (iPos < 0) {
			if (!str.equals("") && !hb.contains((Object) str)) {
				obj = hb.put(new Integer(iLen), str);
				iLen++;
			}
		}

		while ((iPos > -1)) {
			key = "";
			iTmp = str.indexOf(',', iPos + 1);
			if (iTmp > iPos) {
				key = str.substring(0, iPos);
				str = str.substring(iPos + 1);
				if (!key.equals("") && !hb.contains((Object) key)) {
					obj = hb.put(new Integer(iLen), key);
					iLen++;
				}
				iPos = str.indexOf(',');
			} else {
				key = str.substring(0, iPos);
				str = str.substring(iPos + 1);

				if (!key.equals("") && !hb.contains((Object) key)) {
					hb.put(new Integer(iLen), key);
					iLen++;
				}

				if (!str.equals("") && !hb.contains((Object) str)) {
					hb.put(new Integer(iLen), str);
					iLen++;
				}
				iPos = -1;
			}
		}

		arrStr = new String[iLen];
		for (int i = 0; i < iLen; i++) {
			arrStr[i] = (String) hb.get(new Integer(i));
		}
		return arrStr;
	}

	/**
	 * 取得指定连接的源码(主要用取得简历的SRC)
	 * 
	 * @param url
	 *            String
	 * @return String
	 */
	public static String getSrc(String url) {
		HttpURLConnection conn = null;
		BufferedReader in = null;
		PrintWriter out = null;
		Object obj = null;
		StringBuffer sb = new StringBuffer("");
		boolean bOpen = false;

		try {
			conn = (HttpURLConnection) (new URL(url)).openConnection();
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			bOpen = true;
		} catch (Exception e) {
			bOpen = false;
			System.out.println("Can not open HttpURLConnection! err:" + e);
		}
		try {
			if (bOpen) {
				String line = null;
				while ((line = in.readLine()) != null) {
					if (line.indexOf("javascript:window.print();") == -1)
						sb.append(line + "\n");
				}
			}
		} catch (Exception e) {
			System.out.println("Close Object err:" + e);
		} finally {
			try {
				if (in != null) {
					in.close();
					in = null;
				}
				if (conn != null) {
					conn.disconnect();
					conn = null;
				}
			} catch (Exception e) {
				System.out.println("Close Object err:" + e);
			}
		}
		return sb.toString();
	}

	/**
	 * 把指定字串拆分为数组，以逗号,分号,全角逗分割。
	 * 而以分号进行最终分割;这里去掉重复字串
	 * 
	 * @param list
	 *            String
	 * @return String[]
	 */
	public static String[] toStrArr(String list) {
		String[] arrStr = null;
		Hashtable hb = null;
		String str = null;
		String key = null;
		Object obj = null;
		int iLen = 0;
		int iPos = -1;
		int iTmp = -1;
		if ((list == null) || list.trim().equals("")) {
			return new String[0];
		} else {
			str = list.trim();
		}

		//可用扩展
		str = replace(str, ",", ";");
		str = replace(str, "；", ";");
		str = replace(str, "，", ";");
		str = replace(str,"（","(");
		str = replace(str,"）",")");
		str = replace(str,"-","");
		str = replace(str,"０","0");
		str = replace(str,"１","1");
		str = replace(str,"２","2");
		str = replace(str,"３","3");
		str = replace(str,"４","4");
		str = replace(str,"５","6");
		str = replace(str,"６","6");
		str = replace(str,"７","7");
		str = replace(str,"８","8");
		str = replace(str,"９","9");

		hb = new Hashtable();
		iPos = str.indexOf(';');
		if (iPos < 0) {
			if (!str.equals("") && !hb.contains((Object) str)) {
				obj = hb.put(new Integer(iLen), str);
				iLen++;
			}
		}

		while ((iPos > -1)) {
			key = "";
			iTmp = str.indexOf(';', iPos + 1);
			if (iTmp > iPos) {
				key = str.substring(0, iPos);
				str = str.substring(iPos + 1);
				if (!key.equals("") && !hb.contains((Object) key)) {
					obj = hb.put(new Integer(iLen), key);
					iLen++;
				}
				iPos = str.indexOf(';');
			} else {
				key = str.substring(0, iPos);
				str = str.substring(iPos + 1);

				if (!key.equals("") && !hb.contains((Object) key)) {
					hb.put(new Integer(iLen), key);
					iLen++;
				}

				if (!str.equals("") && !hb.contains((Object) str)) {
					hb.put(new Integer(iLen), str);
					iLen++;
				}
				iPos = -1;
			}
		}

		arrStr = new String[iLen];
		for (int i = 0; i < iLen; i++) {
			arrStr[i] = (String) hb.get(new Integer(i));
		}
		return arrStr;
	}

	/**
	 * 转化为alert不出错的字串(待修改)
	 * 
	 * @param str
	 *            String
	 * @return String
	 */
	public static String toAlertStr(String str) {
		if (str == null) {
			return "";
		}

		String szTmp = str;
		szTmp = replace(szTmp, "\\", "\\\\");
		szTmp = replace(szTmp, "=", "&#61;");
		szTmp = replace(szTmp, "\"", "\\\"");
		szTmp = replace(szTmp, "'", "\\\"");
		return szTmp;
	}
   //验证email 格式
	public  static boolean checkEmail(String mail){   
	    String regex = "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";   
	    Pattern   p   =   Pattern.compile(regex);   
	    Matcher   m   =   p.matcher(mail);   
	    return m.find();   
	}  
  //测试图片旋转
   public   static   final   int   J2D_ROTATE_90   =   90;   
   public   static   final   int   J2D_ROTATE_180   =   180;   
   public   static   final   int   J2D_ROTATE_270   =   270;   
   /**   
     *   旋转   -   参数指定目标图旋转角度。   
     *   @param   bufferedImage   BufferedImage   
     *   @param   radian   int   
     *   @param   hints   RenderingHints   
     *   @return   BufferedImage   
     */   
   public static BufferedImage rotateJ2D(BufferedImage  bufferedImage,int  radian, RenderingHints  hints)
   {
		    int width = bufferedImage.getWidth(); 
		   	int height = bufferedImage.getHeight();

           BufferedImage dstImage = null;   
           AffineTransform   affineTransform = new AffineTransform(); 

           if (radian == 180) { 
                   affineTransform.translate(width,height);   
                   dstImage   = new BufferedImage(width, height, bufferedImage.getType()); 
           } else if (radian == 90) {   
                   affineTransform.translate(height, 0);   
                   dstImage = new BufferedImage(height, width, bufferedImage.getType());   
           } else if (radian == 270) {   
                   affineTransform.translate(0, width);   
                   dstImage = new BufferedImage(height, width, bufferedImage.getType());   
           }   

           affineTransform.rotate(java.lang.Math.toRadians(radian));   
           AffineTransformOp   affineTransformOp = new AffineTransformOp(affineTransform,hints);   
   
           return   affineTransformOp.filter(bufferedImage, dstImage);   
//           return dstImage;
   }
   public static final java.util.Date toDates(String s){
		
		java.util.Date date = new java.util.Date();
		
		SimpleDateFormat sf =new SimpleDateFormat("yyyy-MM-DD hh:mm");
		try {
			date =  sf.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return date;
	}
   //时间转成字符串
   /**
    * return yyyy-MM-dd HH:mm格式字符串
    */
   public static final String formatDate(Date d){
		
		String date="";
		SimpleDateFormat sf =new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			date =  sf.format(d);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return date;
	}
 //匹配url
   public static final String setUrl(String str)
   {
	   String regex = "(http://|https://){1}[\\w\\.\\-/:?%&=,]+";
	   String x=getRandomString(5);
	   if(str==null || str.equals(""))
	   {
		   return str;
	   }else{
		   Pattern p = Pattern.compile(regex);   
		   Matcher m = p.matcher(str);
		   //String newstr=str;
		   StringBuffer sb=new StringBuffer();
		  // System.out.println("stringUtil.setUrl()"+m);
		  // if(m!=null){
		   if(m!=null && m.find())   
	       {   
			   //System.out.print(">>>>>");
	           int a=m.groupCount();
	           while((a--)>0){
	               if(m.group(a)!=null){
	               int i=str.indexOf(m.group(a));
	               String s=str.substring(0,i)+"<a href='"+m.group(a)+"' target='_blank' title='"+m.group(a)+"'>http://t.efjob.cn/"+x+"</a>";
	               str=str.substring(i+m.group(a).length());
	               sb.append(s+str);
	               //newstr=stringUtil.replace(newstr,m.group(a), "<a href='"+m.group(a)+"' target='_blank' alt='"+m.group(a)+"'>http://aligolf.cn/"+x+"</a>");	      
	               }
	           }
	      // } 
		   }else{
			   sb.append(str);
		   }
		   return sb.toString();
	   }
   }
  //获取随机字符串
   public static String getRandomString(int length) { 
	     StringBuffer buffer = new StringBuffer("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"); 
	     StringBuffer sb = new StringBuffer(); 
	     Random r = new Random(); 
	    int range = buffer.length(); 
	    for (int i = 0; i < length; i ++) { 
	         sb.append(buffer.charAt(r.nextInt(range))); 
	     } 
	    return sb.toString(); 
	}
 //检测字符串是否为数字串
	public static final boolean strIsDigital(String s) {
		boolean flag = false;
		boolean flag1 = true;
		if (s == null) {
			return false;
		}
		char ac[] = s.toCharArray();
		for (int i = 0; i < ac.length;) {
			if (!Character.isDigit(ac[i]))
				flag1 = false;
			break;
		}

		return flag1;
	}
 //把字符串转换为数字
	public static final int strToInt(String s, int i) {

		if (s == null)
			return i;
		if (!strIsDigital(s) || s.length() < 1)
			return i;
		try {
			return Integer.parseInt(s);
		} catch (Exception e) {
			return 0;
		}

	} 
	
	/**
	 * 数组转成字符串
	 * @author 阙超强 14015
	 * @time 2011-12-30 10:03:25
	 * @param object[]
	 * @return String
	 */
	public static String arrayToString(Object[] objects){
		String result = "";
		if(null != objects && !objects.equals(null)){
		        for(int i=0;i<objects.length;i++){
		    	    if( i == 0){
		    		        result += objects[i];
		    	    }else{
		    		        result += "," + objects[i];
		    	    }
		        }
	    }
	    return result;
	}
	
	
   public static void main(String []a)
   {
//	   boolean result= stringUtil.checkEmail("li@126.com");
//	   System.out.println(result);
//	   String str="http://baby.motherol.com/showInfo/showuser.jsp?uid=66951&action=showphoto&picid=183221&photoid=1";
	   /*String strnew=stringUtil.replace(str, "test", "good",true);
	   String oldStr="Test";*/
//	   System.out.println(stringUtil.getSrc(str));
/*	   try
	   {
	   File _file = new File("D:/5.jpg");
	   Image src = javax.imageio.ImageIO.read(_file);
	   int w=src.getWidth(null);
	   int h=src.getHeight(null);
	   BufferedImage bufferedImage = new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);
	   BufferedImage bi=stringUtil.rotateJ2D(bufferedImage, 90, null);
	   
	   Graphics g=bi.getGraphics();
//	   g.drawImage(img, 0, 0,bi.getWidth(), bi.getHeight(), null);
	   g.dispose();

	   javax.imageio.ImageIO.write(bi,"JPG",new File("D://a.jpg"));
	    
	   System.out.print("chenggong");
	   }
	   catch(Exception e)
	   {
		   e.printStackTrace();
	   }*/
	   
	   
	   String str="微博客时代 http://www.baidu.com/xx.html的到来!http://tech.sina.com.cn/i/2009-10-29/17083549571.shtml";
	   //String str="饭大家所的法律卡死的立法卡死";
	   str=StringUtil.setUrl(str);
	   //String s="<span class='xiao' id='otherinfo'><span class='k20'>  <p align='center'>";
	   //String str=stringUtil.subStr("<span class=\"xiao\" id=\"otherinfo\"><span class=\"k20\">  <p align=\"center\"><font face=\"Verdana\" size=\"2\"><strong>会籍分类及价格</strong></font></p>  <p align=\"center\"><font face=\"Verdana\">个人会籍：<font face=\"Verdana\">US$120,000<br />  <font face=\"Verdana\">公司两提名会籍：<font");
	  // String str=stringUtil.Html2Text("<html><body>< div style color=red><FONT face=隶书 color=#339966>fdasvcbv时的撒旦撒发生发生的fasdfasdfasdfa</FONT></div></body></html>");
	   System.out.println(str+"===============");
	   
	   
	   Object[] objects = {1,4,6,3,7};
	   String s = StringUtil.arrayToString(objects);
	   System.out.println(s);
   }//en
   
   /**
    * post方式 http请求
    * @param urlStr 请求url字符串eg http://localhost:8080/pay.do?id=1&name=zhanshan
    * @return 响应返回的字符串
    * @throws Exception
    */
   public static String returnURLParam(String urlStr,String charset) throws Exception{
		URL url = new URL(urlStr);
       HttpURLConnection connection = (HttpURLConnection) url.openConnection();
       connection.setDoInput(true); //设置可以进行输入操作
       connection.setDoOutput(true); //设置可以进行输出操作
       connection.setRequestMethod("POST"); //设置请求方式
       connection.setAllowUserInteraction(true); //设置可以进行交互操作
       connection.connect();
//       OutputStream outputStream = connection.getOutputStream();
//       OutputStreamWriter writer = new OutputStreamWriter(outputStream);
       
//       writer.write(str);
//       writer.flush(); //立即输出
//       writer.close();
       InputStream inputStream = connection.getInputStream();
       BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,charset)); //为了进行一行读取操作
       String strMessage ="";
       StringBuffer  buffer = new StringBuffer();
		while ((strMessage  = reader.readLine()) != null) {
            buffer.append(strMessage);
            buffer.append("\r");
       }
		//System.out.println(buffer+"获得的数据");
		return buffer.toString();
	}
}

