package com.fuao.fajxc.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

public class ObjXmlBuildParse {
	private String filename = "temp.xml";
	private static String[] tablestr = new String[4];
	
	
	
	public static String[] getTablestr() {
		return tablestr;
	}

	/**
	 * 
	 * @param tablename[name,pktype]
	 *            
	 * @param ResultSet rs
	 *            
	 * @param path 
	 *            eg d:\\uploadxml
	 * @return true or false
	 */
	public static boolean convertResultSetToXML(String[] tablename, ResultSet rs,
			String path) {
		// boolean ischanged = true;

		try {
			String filename = tablename[0] + ".xml";
			Element root = new Element("government");// 创建跟节点
			Document doc = new Document(root);
			Date datestr = new Date();
			java.sql.ResultSetMetaData rsmd = rs.getMetaData();
			boolean isautocreated = rsmd.isAutoIncrement(1);
			
			
			if (rsmd.getColumnCount() >= 0) {
				
				while (rs.next()) {
					Element element = new Element(tablename[0]);
					element.setAttribute("pk",rsmd.getColumnName(1));
					element.setAttribute("value","" + rs.getObject(1));
					element.setAttribute("isauto",""+isautocreated);
//					element.setAttribute("type",SQLParamHelper.SQLType2JavaType(rsmd.getColumnType(1)));
					//根据表主键类型判断主键是否是自增 如果自增去掉主键
					for (int j=2 ; j <= rsmd.getColumnCount(); j++) {
						
						String type = rsmd.getColumnTypeName(j);
						Object value = rs.getObject(j);
						Element e = new Element(rsmd.getColumnName(j));
//						type = SQLParamHelper.SQLType2JavaType(rsmd.getColumnType(j));
						e.setAttribute("type", type);
						e.addContent("" + value);
						element.addContent(e);
					}
					System.out.println("有更新数据");
					root.addContent(element);
				}
			}
			rs.close();
			
			if (root.getChildren() != null && root.getChildren().size() > 0) {
				System.out.println("有数据");
				if (!outputXml(doc, path, filename)) {
					System.out.println("输出失败");
					return false;
				}
			} else {
				return false;
			}
		} catch (Exception e) {
			if(rs !=null){
				try {
					rs.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 
	 * @param path
	 *            eg d:\\download
	 * @param objlist
	 *            object list object
	 * @param filename
	 *            eg obj.xml
	 * @return true or false
	 */
	public boolean createXml(String path, List objlist, String filename) {
		this.filename = filename;
		System.out.println("create xml file");
		Element root = new Element("government");// 创建跟节点
		Document doc = new Document(root);
		Date datestr = new Date();
		System.out.println(objlist.size() + "get the listsize");
		for (int i = 0; i < objlist.size(); i++) {
			Object obj = (Object) objlist.get(i);
			Element element = new Element(obj.getClass().getSimpleName());
			element.setAttribute("classtype", obj.getClass().getName());
			Field[] fields = obj.getClass().getDeclaredFields();
			for (int j = 0; j < fields.length; j++) {
				try {
					String name = fields[j].getName();// get field name
					System.out.println(j + " " + name);
					String typename = fields[j].getType().getName();// get field
																	// type eg
																	// java.lang.String
					Method method = obj.getClass().getMethod(
							"get" + name.substring(0, 1).toUpperCase()
									+ name.substring(1), new Class[] {});
					System.out.println(name + "----" + method);
					Object result = method.invoke(obj, new Object[] {});
					Element key = new Element(name);
					key.setAttribute("value", "" + result);// set value of the
															// key
					key.setAttribute("type", typename);//
					element.addContent(key);
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			root.addContent(element);
		}

		if (objlist.size() > 0) {
			if (!outputXml(doc, path, filename)) {
				System.out.println("输出失败");
				return false;
			}
		} else {
			return false;
		}
		return true;
	}

	public static boolean outputXml(Document doc, String path, String filename) {
		try {
			XMLOutputter XMLOut = new XMLOutputter();

			System.out.println(path + File.separator + filename);
			File f = new File(path + File.separator + filename);
			if (f.exists()) {
				System.out.println("文件存在先删除");
				f.delete();
			}
			OutputStream  os = new FileOutputStream(path + File.separator
					+ filename);
			XMLOut.output(doc, os );
			System.out.println("build xml file success");
			os = null;
			doc=null;
			XMLOut=null;
			f= null;
		} catch (Exception ex) {
			System.out.println("build xml file" + ex);
			return false;
		}
		return true;
	}

	/**
	 * 解析文档
	 * 
	 * @param root
	 * @return List<Object>
	 * @throws Exception
	 */
	public static List XmlToObj(Element root) throws Exception {
		List objlist = new ArrayList();
		try {
			List classlist = root.getChildren();
			for (Iterator iterator = classlist.iterator(); iterator.hasNext();) {

				Element el = (Element) iterator.next();
				tablestr[0] = el.getName();
				tablestr[1] = el.getAttributeValue("pk");
				tablestr[2] = el.getAttributeValue("type");
//				tablestr[3] = el.getAttributeValue("value");
				tablestr[3] = el.getAttributeValue("isauto");
				
				String pkvalue = el.getAttributeValue("value");
				List filedlist = el.getChildren();
				
				if (filedlist != null && filedlist.size() > 0) {
					
					
					
					
					String[] filedname = new String[filedlist.size()]; 
					Map<String,Object> filedmap = new HashMap<String,Object>();
					Object objvalue = (pkvalue.trim().equals("null")?pkvalue:typeConvert(tablestr[2], pkvalue));
					filedmap.put(tablestr[1], pkvalue);
					for (int i = 0; i < filedlist.size(); i++) {
						
						Element e = (Element) filedlist.get(i);
						String filed = e.getName();
						String value = e.getText();
						String ftype = e.getAttributeValue("type");
//						System.out.println("field:   " + filed + "  value:  "
//								+ value + "   ftype:  " + ftype);
						objvalue = (value.trim().equals("null")?value:typeConvert(ftype, value));
						
						filedmap.put(filed, objvalue);
					}
					
					objlist.add(filedmap);
				} else {
					System.out.println("error no filed");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return objlist;
	}

	/**
	 * 解析文档
	 * 
	 * @param root
	 * @return List<Object>
	 * @throws Exception
	 */
	public static List getXmlList(Element root) throws Exception {
		List objlist = new ArrayList();
		List classlist = root.getChildren();
		for (Iterator iterator = classlist.iterator(); iterator.hasNext();) {
			Element el = (Element) iterator.next();
			String className = el.getAttributeValue("classtype");
			Class cls = null;
			try {
				cls = Class.forName(className);
				Object obj = cls.newInstance();
				List filedlist = el.getChildren();
				for (Iterator it = filedlist.iterator(); it.hasNext();) {
					Element e = (Element) it.next();
					String filed = e.getName();
					String value = e.getAttributeValue("value");
					String ftype = e.getAttributeValue("type");
					System.out.println("field:   " + filed + "  value:  "
							+ value + "   ftype:  " + ftype);
					Object valueObj = typeConvert(ftype, value);
					//
					if (ftype.equals("int")) {
						ftype = "java.lang.Integer";
					}
					String methodName = "set"
							+ Character.toUpperCase(filed.charAt(0))
							+ filed.substring(1);
					System.out.println(" methodName= " + methodName
							+ " , class= " + Class.forName(ftype));
					Method method = cls.getMethod(methodName, Class
							.forName(ftype));
					method.invoke(obj, new Object[] { valueObj });

				}
				objlist.add(obj);

			} catch (InstantiationException e) {
				throw new Exception("InstantiationException");
			} catch (IllegalAccessException e) {
				throw new Exception("IllegalAccessException");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				throw new Exception("ClassNotFoundException");
			}
		}
		return objlist;
	}

	public static Element getRoot(String fileName) {
		Document doc = null;
		SAXBuilder sax = new SAXBuilder(false);
		try {
			doc = sax.build(fileName);
		} catch (JDOMException ex) {
			System.out.println(ex);
		} catch (IOException ex) {
			System.out.println(ex);
		}
		Element root = doc.getRootElement();
		return root;
	}

	public static Object typeConvert(String className, String value) {
		if (className.equals("java.lang.String")) {
			return value;
		} else if (className.equals("java.lang.Integer")) {
			return Integer.valueOf(value);
		} else if (className.equals("java.lang.Long")) {
			return Long.valueOf(value);
		} else if (className.equals("java.lang.Boolean")) {
			return Boolean.valueOf(value);
		} else if (className.equals("java.util.Date")) {
			return new Date(value);
		} else if (className.equals("java.lang.Float")) {
			return Float.valueOf(value);
		} else if (className.equals("java.lang.Double")) {
			return Double.valueOf(value);
		} else if (className.equals("java.sql.Timestamp")) {
			return Timestamp.valueOf(value);
		} else if (className.equals("java.lang.Short")) {
			return Short.valueOf(value);
		} else if (className.equals("java.sql.Time")) {
			return Time.valueOf(value);
		} else if (className.equals("java.sql.Date")) {
			return java.sql.Date.valueOf(value);
		} else
			return null;
	}

	public static void main(String[] args) throws Exception {
		// test1();
		// test2();
		// test3();
		Element e = ObjXmlBuildParse.getRoot(ObjXmlBuildParse.class.getResource("/tempconfig.xml").getPath());
		test3(e,"game");
	}

	private static void test1() {
		ObjXmlBuildParse objectToXml = new ObjXmlBuildParse();
		// objectToXml.createXml("d:\\uploadxml", list,"personalInfo.xml");
}

	private static void test2() {
		ObjXmlBuildParse objectToXml = new ObjXmlBuildParse();
		try {
			List list = objectToXml.getXmlList(objectToXml
					.getRoot("d:\\uploadxml\\TbAbandonedbabyLocatedApp.xml"));
			Iterator it = list.iterator();
			System.out.println(it.next());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void test3(Element root ,String name ) {
		List rslist = new ArrayList();
		Element e  = root.getChild("template-config");
		e = e.getChild("game");
		List clist  = e.getChildren();
		//String[] tablestr = new String[4];
		for (Iterator it = clist.iterator(); it.hasNext();) {
			
			Element el = (Element) it.next();
			String[] tablestr = new String[4];
			tablestr[0] = el.getName();
			tablestr[1] = el.getAttributeValue("id");
			tablestr[2] = el.getAttributeValue("cname");
//			tablestr[3] = el.getAttributeValue("value");
			tablestr[3] = el.getValue();
			rslist.add(tablestr);
		}
		System.out.println(rslist.size());
		for (Iterator it = rslist.iterator(); it.hasNext();) {
			String[] obj = (String[]) it.next();
			System.out.println(obj[0]+"---"+obj[1]+"---"+obj[2]+"---"+obj[3]);
			
		}
	}

	private static void test4() throws Exception {
	}

	public static List<String[]> getLanmuList(Element element) {
		List rslist = new ArrayList();
		Element e  = element.getChild("template-config");
		e = e.getChild("game");
		List clist  = e.getChildren();
		//String[] tablestr = new String[4];
		for (Iterator it = clist.iterator(); it.hasNext();) {
			
			Element el = (Element) it.next();
			String[] tablestr = new String[4];
			tablestr[0] = el.getName();
			tablestr[1] = el.getAttributeValue("id");
			tablestr[2] = el.getAttributeValue("cname");
//			tablestr[3] = el.getAttributeValue("value");
			tablestr[3] = el.getValue();
			rslist.add(tablestr);
		}
		System.out.println(rslist.size());
		return rslist;
	}

}
