package com.fuao.fajxc.erweima;


import javax.servlet.http.HttpServlet;
import java.io.IOException;  

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import com.fuao.fajxc.erweima.EncoderHandler; 
public class CodeServlet extends HttpServlet {  
	  
    private static final long serialVersionUID = 1L;  
      
    @Override  
    protected void service(HttpServletRequest requset, HttpServletResponse response)  
            throws ServletException, IOException {  
        String content = "ÐÕÃû:maysnow µç»°:123687495";  
        String contentnew=requset.getParameter("content");
        
        EncoderHandler encoder = new EncoderHandler();  
        encoder.encoderQRCoder(contentnew, response);  
    }  
  
}  