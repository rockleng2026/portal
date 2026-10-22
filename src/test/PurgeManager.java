package test;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Properties;
import java.util.regex.Pattern;

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
        System.out.println("ipstr=========" + ipstr);

        if (ipstr != null) {
            servers = ipstr.split(";");
        }
        try {
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

   
    public String purgeSquid(String url) {
        String msg = "";
        System.out.println("PURGE " + url);
        for (int i = 0; i < servers.length; i++) {
            String t[] = servers[i].split(":");
            if (t.length == 1 ){
            	doOneSquid(t[0], url);
            }else{
                msg = doOneSquid(t[0], url, Integer.parseInt(t[1]));
            	//System.out.println(t[0]+":"+t[1]);
            }
            testprint(msg);
        }
        return msg;
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
               // String state = "PURGE " + purl + " HTTP/1.1";
                String state = "PURGE " + purl + " HTTP/1.1\r\nConnection: Close\r\n\r\n";

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
        return message;
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
    	//System.out.println(PurgeManager.getInstance().
    	//parseHostNameFromUrl("db.com"));
    	
        String message = PurgeManager.getInstance().purgeSquid("http://www.dzxw.net/gcdt/jwx/201111/28141574.html");
        message = PurgeManager.getInstance().purgeSquid("http://www.dzxw.net/gcdt/hejian/201111/17140513.html");
        message = PurgeManager.getInstance().purgeSquid("http://www.dzxw.net/szyw/201112/142414.html");
    	//String message = "xxxx";
    	String rtmsg = "-1";
    	logger.info(message);
        if(!StringUtil.isnull(message)){
        	String[] str = message.split("<br>");
        	System.out.println("str[0]="+str[0]);
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
        //Pattern p = Pattern.compile(""); 
        System.out.println(message);
       
    }
}