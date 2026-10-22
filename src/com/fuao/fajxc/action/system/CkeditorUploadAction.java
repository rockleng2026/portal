package com.fuao.fajxc.action.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class CkeditorUploadAction extends ActionSupport {   

    private String uploadContentType;   
       
    private String uploadFileName;   
       
    private String CKEditorFuncNum;   
       
    private String CKEditor;   
       
    private String langCode;   
       
    private File upload;   
       
    /** 
     * @return the upload 
     */ 
    public File getUpload() {   
        return upload;   
    }   

    /** 
     * @param upload the upload to set 
     */ 
    public void setUpload(File upload) {   
        this.upload = upload;   
    }   

    /** 
     * @return the cKEditorFuncNum 
     */ 
    public String getCKEditorFuncNum() {   
        return CKEditorFuncNum;   
    }   

    /** 
     * @param cKEditorFuncNum the cKEditorFuncNum to set 
     */ 
    public void setCKEditorFuncNum(String cKEditorFuncNum) {   
        CKEditorFuncNum = cKEditorFuncNum;   
    }   

    /** 
     * @return the cKEditor 
     */ 
    public String getCKEditor() {   
        return CKEditor;   
    }   

    /** 
     * @param cKEditor the cKEditor to set 
     */ 
    public void setCKEditor(String cKEditor) {   
        CKEditor = cKEditor;   
    }   

    /** 
     * @return the langCode 
     */ 
    public String getLangCode() {   
        return langCode;   
    }   

    /** 
     * @param langCode the langCode to set 
     */ 
    public void setLangCode(String langCode) {   
        this.langCode = langCode;   
    }   

    /** 
     * @return the uploadContentType 
     */ 
    public String getUploadContentType() {   
        return uploadContentType;   
    }   

    /** 
     * @param uploadContentType the uploadContentType to set 
     */ 
    public void setUploadContentType(String uploadContentType) {   
        this.uploadContentType = uploadContentType;   
    }   

    /** 
     * @return the uploadFileName 
     */ 
    public String getUploadFileName() {   
        return uploadFileName;   
    }   

    /** 
     * @param uploadFileName the uploadFileName to set 
     */ 
    public void setUploadFileName(String uploadFileName) {   
        this.uploadFileName = uploadFileName;   
    }   

    @Override 
    public String execute() throws Exception {   
        String strPath = ServletActionContext.getServletContext().getRealPath("/uploads");   
        File path = new File(strPath);   
        if(!path.exists()){   
            path.mkdirs();   
        }   
        String uuid = UUID.randomUUID().toString();
   String rt[] = this.getUploadFileName().split("\\.");
   System.out.println(rt[1]);
   uploadFileName = new String(uuid+"."+rt[1]);//解决上传中文图片、flash或含中文路径时服务器报错的问题。
        //FileImageInputStream is = new FileImageInputStream(this.upload);   
        //FileImageOutputStream os = new FileImageOutputStream(new File(strPath + File.separator + this.uploadFileName));
        //String newFolderStr= this.getUploadFileName();
        //newFolderStr=new String(newFolderStr.getBytes(), "gbk");
        InputStream is = new FileInputStream(this.upload); 
   System.out.println("上传的图片的类型："+ this.getUploadContentType()); 
        System.out.println("上传的源图片名："+uploadFileName);
          
        OutputStream os = new FileOutputStream(new File(strPath + File.separator + this.uploadFileName));   
        try {   
            int len;   
            byte[] buffer = new byte[1024];   
            while ((len=is.read(buffer)) > 0) {   
                os.write(buffer,0,len);   
            }   
        } catch (Exception e) {   
            e.printStackTrace();   
        } finally {   
            if(is!=null){   
                is.close();   
            }   
            if(os!=null){   
                os.close();   
            }   
        }   
        PrintWriter out = ServletActionContext.getResponse().getWriter();   
        //返回给ckeditor   
        out.write("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("+this.CKEditorFuncNum+", 'uploads/" + this.uploadFileName+"', '');</script>");   
        return Action.NONE;   
    }   
} 
