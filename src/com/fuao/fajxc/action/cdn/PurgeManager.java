package com.fuao.fajxc.action.cdn;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.Properties;
import org.apache.log4j.Logger;

import com.fuao.fajxc.util.StringUtil;

public class PurgeManager {
    String[] servers = {};
    private static Logger logger = Logger.getLogger(PurgeManager.class);
    private static PurgeManager pm = null;

    public synchronized static PurgeManager getInstance() {
        if (pm == null) {
            pm = new PurgeManager();
        }
        return pm;
    }  
    private PurgeManager() {
        InputStream inputStream = this.getClass().getResourceAsStream("/squid.properties");
        Properties p = new Properties();
        try {
            p.load(inputStream);
        } catch (IOException e1) {
            e1.printStackTrace();
        }
        String ipstr = p.getProperty("servers");
        //logger.error("ipstr=========" + ipstr);

        if (ipstr != null) {
            servers = ipstr.split(";");
        }
        try {
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
            logger.error(e);
        }
    }   
    public String purgeSquid(String url) {
        String message = "";
        String rtmsg = "";
        //logger.error("PURGE " + url);
        for (int i = 0; i < servers.length; i++) {
            String t[] = servers[i].split(":");
            if (t.length == 1 ){
            	message ="(节点"+i+"):"+doOneSquid(t[0], url);
            }else{
                message = "(节点"+i+"):"+doOneSquid(t[0], url, Integer.parseInt(t[1]));
                //LogBat***Method=delete***ParamType=dir***Parameter=http://www.litscloud.com/images|http://www.litscloud.com/201/***end
            }
            System.out.println(message);
            //logger.error("执行反馈:"+message);
            if(!StringUtil.isnull(message)){
            	String[] str = message.split("<br>");
            	rtmsg +=str[0]+"<br/>";
            }else{
            	logger.error("消息为空");
            }
            //testprint(msg);
        }
        
        //System.out.println(rtmsg);
        return rtmsg;
    }

   
    private static  String  testprint(String message) {
    	String rtmsg = "";
    	if(!StringUtil.isnull(message)){
        	String[] str = message.split("<br>");
        	//System.out.println("str[0]="+str[0]);
        	if(str[0].contains("200")){
        		rtmsg = "200";
        	}else if(str[0].contains("404")){
        		rtmsg = "404";
        			
        	}else if(str[0].contains("403")){
        		rtmsg = "403";
        	}else if(str[0].contains("500")){
        		rtmsg = "500";
        	}
        }else{
        	logger.error("消息为空");
        }
    	System.out.println(rtmsg);
    	return rtmsg;
	}


	private String doOneSquid(String serverip, String purl) {
        return doOneSquid(serverip, purl, 80);
    }
    private String doOneSquid(String serverip, String purl, int port) {
        String message = ""+purl;
        // 获取hostname
        String hname = parseHostNameFromUrl(purl);
        try {
        		Socket s = new Socket(serverip, port);
                InputStream is = s.getInputStream();
                OutputStream os = s.getOutputStream();

                BufferedReader in = new BufferedReader(new InputStreamReader(is));
                PrintWriter out = new PrintWriter(new OutputStreamWriter(os), true);
                BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(os, "gbk"));
                wr.write("PURGE " + purl + " HTTP/1.1\r\nConnection: Close\r\n\r\n");
  	    		wr.write("\r\n");
  	    		wr.flush();
                // String state = "PURGE " + purl + " HTTP/1.1";
//                String state = "PURGE " + purl + " HTTP/1.1\r\nConnection: Close\r\n\r\n";
//
//                out.println(state);
//               // out.println("HOST:" + hname);
//               // System.out.println("我执行了");
//                out.println();

                String downstr;
                while ((downstr = in.readLine()) != null) {
                    //System.out.println(downstr);
                    message += downstr + "<br>";
                }
                s.close();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e);
            message += "<br>操作失败！";
        }
        //logger.error(message);
        System.out.println(message);
        return message;
    }
    public String doOneSquid1(String serverip, String purl, int port) {
		logger.info("doOneSquid1 "+serverip+"  "+purl+"   "+port);
    	Socket socket = null;
		BufferedReader br = null;
		PrintWriter pw = null;
		String str="0";
		try {
			//客户端socket指定服务器的地址和端口号
			socket = new Socket(serverip, port);
			logger.info("doOneSquid2 ");
//			System.out.println("Socket=" + socket);
			//同服务器原理一样
			br = new BufferedReader(new InputStreamReader(
					socket.getInputStream()));
			pw = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
					socket.getOutputStream())));
//			for (int i = 0; i < 10; i++) {
				pw.println(purl);
				pw.flush();
				str = br.readLine();
				System.out.println(str);
				logger.info("doOneSquid return "+str);
//			}
			pw.println("END");
			pw.flush();
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("doOneSquid1 "+e.getMessage());
			str="-3";
		} 
		try {
				
				System.out.println("close......");
				br.close();
				pw.close();
				socket.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				if(str.equals("-3"))
				{
					return str;
				}
				str="-4";
				return str;
			
		}
			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			logger.info("doOneSquid1 e="+str);
		return str;
    }
   
    private String parseHostNameFromUrl(String purl) {
        if (purl == null)
            return "";
        int idx1 = 0;
        int idx2 = 0;
        if (purl.toLowerCase().startsWith("http://")) {
            idx1 = 7;
        }
        idx2 = purl.indexOf("/", idx1);
        if (idx2 == -1)
            idx2 = purl.length();
        return purl.substring(idx1, idx2);
    }

    public static void main(String[] args) {      
    PurgeManager pm=new PurgeManager();
    System.out.println("ssssss"+pm.doOneSquid1("192.1.23.6", "", 8080));
    }
    
public  static void tt1(){
    	
//    	try {
//			
//			String str = URLUtil.returnURLParam("http://192.168.1.200:8082/clogin.jsp","gbk");
//			
////			System.out.println(str);
////			System.out.println(str2);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
    }
   
    //登陆流程
    //验证码 http://uac.10010.com/portal/CreateImage

private String test(String serverip, String purl, int port) {
    String message = ""+purl;
    // 获取hostname
    //String hname = parseHostNameFromUrl(purl);
    try {
    		Socket s = new Socket(serverip, port);
            InputStream is = s.getInputStream();
            OutputStream os = s.getOutputStream();

            BufferedReader in = new BufferedReader(new InputStreamReader(is));
            PrintWriter out = new PrintWriter(new OutputStreamWriter(os,"gbk"), true);
            BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(os, "gbk"));
//            wr.write("GET "+purl+" HTTP/1.0\r\n");
//	    	wr.write("\r\n");
//	    	wr.flush();
           // String state = "PURGE " + purl + " HTTP/1.1";
//            String state = "PURGE " + purl + " HTTP/1.1\r\nConnection: Close\r\n\r\n";
//             "GET "+path+" HTTP/1.0\r\n");
//	    	// wr.write("Content-Length: "+data.length()+"\r\n");
//	    	// wr.write("Content-Type: application/x-www-form-urlencoded\r\n");
            String state = "";
            state ="GET "+purl+" HTTP/1.0\r\n";
           
            
            out.println(state);
           // out.println("HOST:" + hname);
           // System.out.println("我执行了");
            out.println();

            String downstr;
            while ((downstr = in.readLine()) != null) {
                //System.out.println(downstr);
                message += downstr + "<br>";
            }
            s.close();
    } catch (Exception e) {
        e.printStackTrace();
        logger.error(e);
        message += "<br>操作失败！";
    }
    //logger.error(message);
    return message;
}
}