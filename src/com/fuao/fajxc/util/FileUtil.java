package com.fuao.fajxc.util;
import java.io.*;

/**
  * @author Toby 复制文件夹或文件夹
 */
public  class FileUtil {

     public static void main(String args[]) throws IOException {
         // 源文件夹
       // String url1 = "D:/soft/Tomcat 6.0/webapps/FAJxc/WEB-INF/classes/file/dianxin/cesi_com.conf";
         // 目标文件夹
     //   String url2 = "D:/soft/Tomcat 6.0/webapps/FAJxc/WEB-INF/classes/file/dianxin/www_baidu_com.conf";
       
        String url1="E:/workspace/fajxc/src/file/dianxin/cesi_com.conf";
		String url2="E:/workspace/fajxc/src/file/swap/dianxin/cesi_com.conf";
		
        // 创建目标文件夹
        File file = new File(url1);
        File file2= new File(url2);
        file2.delete();
         // 获取源文件夹当前下的文件或目录
//        File[] file = (new File(url1)).listFiles();
//         for (int i = 0; i < file.length; i++) {
//             if (file[i].isFile()) {
//                 // 复制文件
//                String type = file[i].getName().substring(file[i].getName().lastIndexOf(".") + 1);
//
//                 if (type.equalsIgnoreCase("conf"))// 转码处理
//                    copyFile(file[i], new File(url2 + file[i].getName()));
//                 else
//                     copyFile(file[i], new File(url2 + file[i].getName()));
//             }
//             if (file[i].isDirectory()) {
//                 // 复制目录
//                String sourceDir = url1 + File.separator + file[i].getName();
//                 String targetDir = url2 + File.separator + file[i].getName();
//                 copyDirectiory(sourceDir, targetDir);
//             }
//         }
 
        
//        if (file.isFile()) {
//          // 复制文件
//         String type = file.getName().substring(file.getName().lastIndexOf(".") + 1);
//
//          if (type.equalsIgnoreCase("conf"))// 转码处理
//             copyFile(file, new File(url2 + file.getName()));
//          else
//              copyFile(file, new File(url2 + file.getName()));
//      }
  
          

        System.out.println("运行完成");
         
//        FileUtil.del(url2);
     }

     // 复制文件
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

     // 复制文件夹
    public static void copyDirectiory(String sourceDir, String targetDir) throws IOException {
         // 新建目标目录
        (new File(targetDir)).mkdirs();
         // 获取源文件夹当前下的文件或目录
        File[] file = (new File(sourceDir)).listFiles();
         for (int i = 0; i < file.length; i++) {
             if (file[i].isFile()) {
                 // 源文件
                File sourceFile = file[i];
                 // 目标文件
                File targetFile = new File(new File(targetDir).getAbsolutePath() + File.separator + file[i].getName());
                 copyFile(sourceFile, targetFile);
             }
             if (file[i].isDirectory()) {
                 // 准备复制的源文件夹
                String dir1 = sourceDir + "/" + file[i].getName();
                 // 准备复制的目标文件夹
                String dir2 = targetDir + "/" + file[i].getName();
                 copyDirectiory(dir1, dir2);
             }
         }
     }

     /**
      * 
      * @param srcFileName
      * @param destFileName
      * @param srcCoding
      * @param destCoding
      * @throws IOException
      */
     public static void copyFile(File srcFileName, File destFileName, String srcCoding, String destCoding) throws IOException {// 把文件转换为GBK文件
        BufferedReader br = null;
         BufferedWriter bw = null;
         try {
             br = new BufferedReader(new InputStreamReader(new FileInputStream(srcFileName), srcCoding));
             bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(destFileName), destCoding));
             char[] cbuf = new char[1024 * 5];
             int len = cbuf.length;
             int off = 0;
             int ret = 0;
             while ((ret = br.read(cbuf, off, len)) > 0) {
                 off += ret;
                 len -= ret;
             }
             bw.write(cbuf, 0, off);
             bw.flush();
         } finally {
             if (br != null)
                 br.close();
             if (bw != null)
                 bw.close();
         }
     }

     /**
      * 
      * @param filepath
      * @throws IOException
      */
     public static void del(String filepath) throws IOException {
         File f = new File(filepath);// 定义文件路径
        if (f.exists() && f.isDirectory()) {// 判断是文件还是目录
            if (f.listFiles().length == 0) {// 若目录下没有文件则直接删除
                f.delete();
             } else {// 若有则把文件放进数组，并判断是否有下级目录
                File delFile[] = f.listFiles();
                 int i = f.listFiles().length;
                 for (int j = 0; j < i; j++) {
                     if (delFile[j].isDirectory()) {
                         del(delFile[j].getAbsolutePath());// 递归调用del方法并取得子目录路径
                    }
                     delFile[j].delete();// 删除文件
                }
             }
         }
     }
     
     /**  
      *  新建文件  注意参数字符集 很重要 否则乱码
      *  @param  filePath  String  文件路径  如c:/folder
      *  @param  flieName String 文件名称  aaa.txt
      *  @param  fileContent  String  文件内容
      *  @param  charset 字符集   
      *  @return  boolean  
      */  
    public static void  newFile(String  filePath,String fileName,  String  fileContent,String charset)
    throws Exception{
     	   if(filePath.endsWith("/") || filePath.endsWith("\\")){
     		   filePath = filePath.substring(0,filePath.length()-1);
     	   }
            File dirs = new File(filePath);
 	   		//看文件夹是否存在，如果不存在新建目录
 	   	   if(!dirs.exists())
 	   			dirs.mkdirs();
 	   		
 	   		//拼凑文件完成路径
 	   		File myFilePath = new File(filePath+File.separator+fileName);
             if (!myFilePath.exists())  {  
                myFilePath.createNewFile();  
             }  
           String  strContent  =  fileContent;  
//           方法一
//           BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(myFilePath),charset));
//           bw.write(strContent);
//           bw.close();
// 			方法二
//            定义一个类RandomAccessFile的对象，并实例化 
           java.io.RandomAccessFile rf = new RandomAccessFile(dirs+File.separator+fileName,"rw");
           rf.write(strContent.getBytes(charset));
           rf.close();//关闭文件流 
        }
 }

