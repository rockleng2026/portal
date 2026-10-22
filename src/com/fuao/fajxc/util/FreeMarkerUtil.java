package com.fuao.fajxc.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import com.fuao.fajxc.vo.Users;



import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreeMarkerUtil {

	public static void analysisTemplate(String templatePath,    
            String templateName, String fileName, Map<?, ?> root) {    
        try {    
            //初使化FreeMarker配置    
            Configuration config = new Configuration();    
            // 设置要解析的模板所在的目录，并加载模板文件    
            config.setDirectoryForTemplateLoading(new File(templatePath));    
            // 设置包装器，并将对象包装为数据模型    
            config.setObjectWrapper(new DefaultObjectWrapper());    
   
            // 获取模板,并设置编码方式，这个编码必须要与页面中的编码格式一致    
            // 否则会出现乱码    
            Template template = config.getTemplate(templateName, "GBK");    
            // 合并数据模型与模板    
            FileOutputStream fos = new FileOutputStream(fileName);    
            Writer out = new OutputStreamWriter(fos, "GBK");    
            template.process(root, out);    
            out.flush();    
            out.close();    
        } catch (IOException e) {    
            e.printStackTrace();    
        } catch (TemplateException e) {    
            e.printStackTrace();    
        }    
    }    
	
	public static void main(String[] args) {    
        Users content = new Users();    
        content.setLoginName("wlq");
        content.setPassword("wlq");
   
        Map<String, Object> root = new HashMap<String, Object>();    
        root.put("content", "实体");    
        String templatesPath = "C:/Documents and Settings/Administrator/Workspaces/MyEclipse 8.5/FreeMarkerTeset/WebRoot/WEB-INF/Templates";    
        String templateFile = "user.ftl";    
        String htmlFile = templatesPath + "/firsthtml.html";    
        FreeMarkerUtil.analysisTemplate(templatesPath, templateFile, htmlFile,    
                root);    
    }    


}
