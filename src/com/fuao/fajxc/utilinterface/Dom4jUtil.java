package com.fuao.fajxc.utilinterface;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.DOMReader;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

/**
 * @className:Dom4jUtil.java
 * @classDescription:dom4j操作类
 * @createTime:2012-7-24
 */
public class Dom4jUtil {
	// -----------------写------------------------------
	/**
	 * 将doc转换成String（默认为不换行，utf-8编码）
	 * 
	 * @param doc
	 *            Document对象
	 * @return String
	 */
	public static String docToString(Document doc) {
		return docToString(doc,false,"UTF-8");
	}
	/**
	 * 将doc转换成String（默认是UTF-8编码）
	 * 
	 * @param doc
	 *            Document对象
	 * @param newLine
	 *             是否换行
	 * @return String
	 */
	public static String docToString(Document doc,boolean newLine){
		return docToString(doc,newLine,"UTF-8");
	}
	/**
	 * 将doc转换成String(默认不换行)
	 * 
	 * @param doc 
	 *           Document对象
	 * @param encoding
	 *            字符编码
	 * @return String
	 */
	public static String docToString(Document doc,String encoding){
		return docToString(doc,false,encoding);
	}

	/**
	 * 将doc转换成String
	 * 
	 * @param doc Document对象
	 * @param newLine 是否换行
	 * @param encoding 字符编码
	 * @return String
	 */
	public static String docToString(Document doc,boolean newLine,String encoding){
		String str = "";
		try {
			// 使用输出流来进行转化
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			// 使用UTF-8编码--false 换行
			OutputFormat format = new OutputFormat("", newLine, encoding);
			XMLWriter writer = new XMLWriter(out, format);
			writer.write(doc);
			str = out.toString(encoding);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return str;
	}
	/**
	 * 将xml格式的字符串转换成Document对象
	 * 
	 * @param str
	 *            xml格式字符串(字符串编码必须为utf-8，否则会出现乱码)
	 * @return Document对象
	 */
	public static Document stringToDoc(String str) {
		Document doc = null;
		try {
			// 将xml格式化字符串转成Document对象
			doc = DocumentHelper.parseText(str);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return doc;
	}

	/**
	 * 将xml字符串保存为xml文件
	 * 
	 * @param xmlStr
	 *            xml格式的字符串
	 * @param fileName
	 *            保存的文件名
	 * @return true:保存成功 flase:失败
	 */
	public static boolean stringToXmlFile(String xmlStr, String fileName) {
		boolean flag = true;
		try {
			flag = docToXmlFile(stringToDoc(xmlStr), fileName);
		} catch (Exception ex) {
			flag = false;
			ex.printStackTrace();
		}
		return flag;
	}
	/**
	 * 将doc写入xml文件(默认为Utf-8编码)
	 * 
	 * @param doc document对象
	 * @param fileName 文件的全路径
	 * @return
	 */
	public static boolean docToXmlFile(Document doc, String fileName){
		return docToXmlFile(doc,fileName,"UTF-8");
	}
	/**
	 * 将doc写入xml文件
	 * 
	 * @param doc document对象
	 * @param fileName 文件的全路径
	 * @param encoding 编码
	 * @return
	 */
	public static boolean docToXmlFile(Document doc, String fileName,String encoding) {
		boolean flag = true;

		try {
			// 创建格式化类
			OutputFormat format = OutputFormat.createPrettyPrint();
			// 设置编码格式
			format.setEncoding(encoding);
			// 创建输出流
			OutputStreamWriter osw = new OutputStreamWriter(
					new FileOutputStream(fileName), encoding);
			FileWriter fw = new FileWriter(new File(fileName));
			// 创建xml输出流
			XMLWriter writer = new XMLWriter(osw, format);
			// 生成xml文件
			writer.write(doc);
			writer.close();
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}
		return flag;

	}

	/**
	 * 创建document
	 * 
	 * @return Document
	 */
	public static Document createDocument() {
		// 创建文档
		return DocumentHelper.createDocument();
	}
	//---------------------------读（sax）---------------------
	/**
	 * 使用sax加载xml文档（速度快-大文件）
	 * @param filename 绝对文件路径
	 * @return 成功返回Document对象，失败返回null
	 */
	public static Document loadForSax(String filename) {
		Document document = null;
		try {
			SAXReader saxReader = new SAXReader();
			document = saxReader.read(new File(filename));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return document;
	}
	//---------------------读（dom）--------------------
	/**
	 * 使用dom加载xml（速度快-小文件 适用于频繁操作xml）
	 * @param fileName
	 * @return
	 */
	public static Document loadForDom(String fileName){
		Document doc=null;
		try{
			//创建DoucmentBuilder工厂类(使用jaxp解析)
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db;
			db = dbf.newDocumentBuilder();
			//读取doc(首先将其转换成w3c的Document,然后在转成Dom4j的Document)
			org.w3c.dom.Document domDocument = db.parse(new File(fileName));
			DOMReader reader = new DOMReader();
			doc = reader.read(domDocument);
		}catch(Exception e){
			e.printStackTrace();
		}
		return doc; 

	}
	/**-------------------xpath查询语法------------
		bookstore	选取 bookstore 元素的所有子节点
		/bookstore	选取根元素 bookstore 注释：假如路径起始于正斜杠( / )，则此路径始终代表到某元素的绝对路径！
		bookstore/book	选取所有属于 bookstore 的子元素的 book 元素。
		//book	选取所有 book 子元素，而不管它们在文档中的位置。
		bookstore//book	选择所有属于 bookstore 元素的后代的 book 元素，而不管它们位于 bookstore 之下的什么位置。
		//@lang	选取所有名为 lang 的属性。
		/bookstore[@lang='我和你'] 选取bookstore lang属性等于'你和我'的所有元素
		/bookstore[@lang>2] 选取bookstore lang属性大于2的所有元素  如果不加@,那么就是元素比较
		/bookstore/book[price>35.00]/title
		/bookstore/*	选取 bookstore 元素的所有子节点
		//*	选取文档中的所有元素
		//title[@*]	选取所有带有属性的 title 元素。
		 “|”表示或  
   */	
	/**
	 * 根据xpath语法查询匹配的结果集（Element或者Attribute）
	 * @param doc Document对象
	 * @param xpathExp xpath查询语法，官方推荐
	 * @return List
	 */
	public static List findList(Document doc,String xpathExp){
		return doc.selectNodes(xpathExp);
		
	}
	
	
	
//	/**
//	 * 查询结果
//	 * @param doc
//	 * @param xpathExp
//	 * @return
//	 */
//	public static Node findSingleNode(Document doc,String xpathExp){
//		return doc.selectSingleNode(xpathExp);
//	}
//	/**
//	 * 根据xpath语法查询匹配的结果集（Element或者Attribute）
//	 * @param Element Element对象
//	 * @param xpathExp xpath查询语法，官方推荐
//	 * @return List
//	 */
//	public static List findList(Element el,String xpathExp){
//		return el.selectNodes(xpathExp);	
//	}
	
	public static void main(String[] args) {
		
		//Dom4jUtil.docToString(loadForDom("e://msn.xml"));

		//Document doc =Dom4jUtil.loadForDom("E://abc.xml");
		
//		List list=Dom4jUtil.findList(doc,"//skills/skill/@name");
//		for (Iterator it = list.iterator(); it.hasNext();) {
//			
//			Attribute attr = (Attribute) it.next();
//			Element el = (Element) it.next();
//		
//			System.out.println(attr.getValue());
//			//TODO
//		}
//--------增删改查都放到具体的操作中。
//		<GanttChart FileName="*.xml">
//		<Background>
//			<SolidColor>#00FFFFFF</SolidColor>	
//		</Background>
//		<Font Family="宋体" Size="12">
//			<Color>
//				<SolidColor>#000000</SolidColor>
//			</Color>
//		</Font>
			
		 //String str = "<GanttChart FileName='*.xml'><Background><SolidColor>#00FFFFFF</SolidColor></Background><Font Family='宋体' Size='12'><Color><SolidColor>#000000</SolidColor></Color></Font>";
	
		 //System.out.println(docToString(stringToDoc(str)));
		Document doc1 = Dom4jUtil.createDocument();
		Element gb=doc1.addElement("GanttChart");
		gb.addAttribute("FileName", "*.xml");
	    Element bck=gb.addElement("Background");
	    Element sol=bck.addElement("SolidColor");
	    sol.addText("#00FFFFFF");
	    Element font=gb.addElement("Font");
	    font.addAttribute("Family", "宋体");
	    font.addAttribute("Size", "12");
	    Element col= font.addElement("Color");
	    col.addElement("SolidColor");
	    col.addText("#000000");
	    
		Element e = gb.addElement("Columns");
        Element e1= e.addElement("GanttColumn");
        e1.addAttribute("FieldName", "Name");
        e1.addAttribute("Title", "项目名称");
        Element e2=e.addElement("GanttColumn");
        e2.addAttribute("FieldName", "PercentComplete");
        e2.addAttribute("Title", "完成进度");
        Element e3=e.addElement("GanttColumn");
        e3.addAttribute("FieldName", "Start");
        e3.addAttribute("Title", "开始时间");
        Element e4=e.addElement("GanttColumn");
        e4.addAttribute("FieldName", "Finish");
        e4.addAttribute("Title", "完成时间");
        Element e5=e.addElement("GanttColumn");
        e5.addAttribute("FieldName", "Resources");
        e5.addAttribute("Title", "参与人员");
    
		Element tasks=gb.addElement("Tasks");
		Element gant=tasks.addElement("GanttTask");
		gant.addAttribute("Id", "1");//唯一标识
		gant.addAttribute("Name", "OA项目管理");
		gant.addAttribute("OutlineNumber", "1");
		gant.addAttribute("OutlineLevel", "1");
		gant.addAttribute("Resources", "");
		gant.addAttribute("Start", "2012-01-01");
		gant.addAttribute("Finish", "2012-03-21");
		gant.addAttribute("PercentComplete", "6");
		
		Element gant1=tasks.addElement("GanttTask");
		gant1.addAttribute("Id", "2");//唯一标识
		gant1.addAttribute("Name", "立项申请");
		gant1.addAttribute("OutlineNumber", "1.1");
		gant1.addAttribute("OutlineLevel", "2");
		gant1.addAttribute("Resources", "");
		gant1.addAttribute("Start", "2012-01-01");
		gant1.addAttribute("Finish", "2012-01-30");
		gant1.addAttribute("PercentComplete", "20");
		
		Element gant2=tasks.addElement("GanttTask");
		gant2.addAttribute("Id", "3");//唯一标识
		gant2.addAttribute("Name", "袁天龙");
		gant2.addAttribute("OutlineNumber", "1.1.1");
		gant2.addAttribute("OutlineLevel", "3");
		gant2.addAttribute("Resources", "袁天龙");
		gant2.addAttribute("Start", "2012-01-01");
		gant2.addAttribute("Finish", "2012-01-10");
		gant2.addAttribute("PercentComplete", "60");
		gant2.addAttribute("PredecessorLink", "2");
		
		Element gant3=tasks.addElement("GanttTask");
		gant3.addAttribute("Id", "4");//唯一标识
		gant3.addAttribute("Name", "胡宝林");
		gant3.addAttribute("OutlineNumber", "1.1.2");
		gant3.addAttribute("OutlineLevel", "3");
		gant3.addAttribute("Resources", "胡宝林");
		gant3.addAttribute("Start", "2012-01-01");
		gant3.addAttribute("Finish", "2012-01-10");
		gant3.addAttribute("PercentComplete", "60");
		gant3.addAttribute("PredecessorLink", "2");
		
		Element gant4=tasks.addElement("GanttTask");
		gant4.addAttribute("Id", "5");//唯一标识
		gant4.addAttribute("Name", "王雄");
		gant4.addAttribute("OutlineNumber", "1.1.3");
		gant4.addAttribute("OutlineLevel", "3");
		gant4.addAttribute("Resources", "王雄");
		gant4.addAttribute("Start", "2012-01-01");
		gant4.addAttribute("Finish", "2012-01-20");
		gant4.addAttribute("PercentComplete", "0");
		gant4.addAttribute("PredecessorLink", "2");
		
		Element gant5=tasks.addElement("GanttTask");
		gant5.addAttribute("Id", "5");//唯一标识
		gant5.addAttribute("Name", "付飞翔");
		gant5.addAttribute("OutlineNumber", "1.1.4");
		gant5.addAttribute("OutlineLevel", "3");
		gant5.addAttribute("Resources", "付飞翔");
		gant5.addAttribute("Start", "2012-01-01");
		gant5.addAttribute("Finish", "2012-01-03");
		gant5.addAttribute("PercentComplete", "0");
		gant5.addAttribute("PredecessorLink", "2");
		
  
		Dom4jUtil.docToXmlFile(doc1, "E://bin-release//en_US//Engineering3.xml");


	}
}
