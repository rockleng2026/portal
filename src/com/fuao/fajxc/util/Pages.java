package com.fuao.fajxc.util;

import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.lang.StringBuffer;

/**
 * 分页实体
 * @author ice.liu 2010-09-02
 *
 */
public class Pages {
	   /** 当前页 */  
	     private int pageNo;  
	  
	     /** 每页数据量 */  
	     private int pageSize;  
	   
	     /** 总数据量 */  
	     private int allCount;  
	   
	     /** 总页数 */  
	     private int allPage;  
	   
	     /** 每页开始 */  
	     private int recordStart;  
	   
	     /** 每页结束 */  
	     private int recordEnd;  
	   
	     /** 是否有上一页 */  
	     private boolean hasPrePage;  
   
	     /** 是否有下一页 */  
	     private boolean hasNextPage;  
	   
	     /** 显示页数 */  
	     private int showCount;  
   	     
	     private String url;
	     
	     private String html;
	     
	     private List<Object> pageList;   //所有条
         //在对应的日志管理要对，按日统计与月统计时分页我用的是List(Object[])对象集合。由于pages实体bean里没有这个对象进行分页操作。因此我在pages里新增加了List(Object[])属性。
	     private List<Object[]> pageLists;   
	     private HashMap<String,String> searchTerms;

				/**
			      * 创建pages对象
			      * @author ice.liu 2010-09-02
			      */
			      public Pages() {  
			    	         pageNo = 1;  
			    	         pageSize = 25;
			    	         allCount = 1;
			    	         allPage = 1;  
			    	         recordStart = 0;  
			    	         recordEnd = 0;  
			    	         hasPrePage = false;  
			    	         hasNextPage = false;  
			    	         try {  
			    	             excecute();  
			    	         } catch (Exception exception) {  
			    	        	 exception.printStackTrace();
			    	         }  
			    	     }  
	    	   
	      		/**
	      		 * 创建pages对象
	      		 * @author ice.liu 2010-09-02
	      		 * @param pageNo 当前页数
	      		 * @param allCount 总数量
	      		 * 默认每页25条
	      		 */
	    	     public Pages(int pageNo, int allCount) {  
	    	         this.pageNo = pageNo;  
	    	         this.pageSize = 25;  
	    	         this.allCount = allCount;  
	    	         this.allPage = 1;  
	    	         this.recordStart = 0;  
	    	         this.recordEnd = 0;  
	    	         hasPrePage = false;  
	    	         hasNextPage = false;  
	    	         try {  
	    	             excecute();  
	    	         } catch (Exception exception) {  
	    	         }  
	    	     }  
	    	   
	    	     /**
	    	      * 创建pages对象
	    	      * @author ice.liu 2010-09-02
	    	      * @param pageNo 当前页数
	    	      * @param pageSize 每页条数
	    	      * @param allCount 总条数
	    	      */
	    	     public Pages(int pageNo, int pageSize, int allCount) {  
	    	         this.pageNo = pageNo;  
	    	         this.pageSize = pageSize;  
	    	         this.allCount = allCount;  
	    	         this.allPage = 1;  
	    	         this.recordStart = 0;  
	    	         this.recordEnd = 0;  
	    	         hasPrePage = false;  
	    	         hasNextPage = false;  
	    	         try {  
	    	             excecute();  
	    	         } catch (Exception exception) {  
	    	         }  
	    	     } 
	    	     
	    	    /**
	    	      * 计算分页结果
	    	      *@author ice.liu 2010-09-02
	    	      *
	    	      */
	    	     public void excecute() {  
	    	         if (pageNo <= 0) {  
	    	             pageNo = 1;  
	    	         }  
	    	         recordStart = (pageNo - 1) * pageSize ;  
	    	         recordEnd = Math.min(recordStart + pageSize, allCount);  
	    	         if (allCount % pageSize == 0) {  
	    	             allPage = allCount / pageSize;  
	    	         } else {  
	    	             allPage = allCount / pageSize + 1;  
	    	         }  
	    	         if (pageNo > 1) {  
	    	             hasPrePage = true;  
	    	         }  
	    	         if (pageNo < allPage) {  
	    	             hasNextPage = true;  
	    	         }  
	    	         if (showCount <= 0) {  
	    	             showCount = 9;  
	    	         }  
	    	     }
	    	     
	    	     /**
	    	      * 打印分页条hitml
	    	      * @author ice.liu 2010-09-02
	    	      * @return String
	    	      */
	    	    
	    	     
	    	    /**
	    	     * 获取总条数
	    	     * @return int
	    	     */
				public int getAllCount() {
					return allCount;
				}
				
				public String getHtml() {
					 StringBuffer sb=new StringBuffer();
	    	    	 StringBuffer tUrl=new StringBuffer();
	    	    	 String mark ="&";
	    	    	 if(url.indexOf("?")==-1){
	    	    		 mark = "?";
	    	    	 }
	    	    	
	    	    	 if(searchTerms!=null){
		    	    	 for(Map.Entry<String, String> termss:searchTerms.entrySet()){
		    	    		 tUrl.append("&"+termss.getKey()+"="+termss.getValue());
		    	    	 }
	    	    	 }
	    	    	 

	    	    	 sb.append("<script type='text/javascript'>function go(){if(event.keyCode==13){forward();} } function forward(){var tz=$('#tzy').val();if(tz.length<=0){tz=1;} var zongcount=$('#zongcount').val(); if(parseInt(tz)>parseInt(zongcount)){tz=zongcount;}; var myurl=$('#myurl').val();window.location.href='../'+myurl+'pageNo='+tz;}</script><div align=\"center\">");
	    	    	 sb.append("<form action='' method='post'><div  class='foot'>[共"+this.getAllCount()+"条记录");
	    	    	 sb.append("<input type='hidden' id='myurl' value='"+this.url+mark+"' />");
	    	    	 sb.append("<input type='hidden' id='zongcount' value='"+this.getAllPage()+"' />");
	    	    	 sb.append("  <a href=\""+this.url+mark+"pageNo=1"+tUrl+"\">首页</a>");
	    	    	 if(this.isHasPrePage()){
	    	    		int prePage=this.getPageNo()-1;
	    	    		sb.append("  <a href=\""+this.url+mark+"pageNo="+prePage+tUrl+"\">上一页</a>");
	    	    	 }else{
	    	    		 sb.append("  上一页  ");
	    	    	 }
	    	    	 if(this.isHasNextPage()){
	    	    		 int nextPage = this.getPageNo()+1;
	    	    		 sb.append("  <a href=\""+this.url+mark+"pageNo="+nextPage+tUrl+"\">下一页</a>");
	    	    	 }else{
	    	    		 sb.append("  下一页  ");
	    	    	 }
	    	    	 sb.append("  <a href=\""+this.url+mark+"pageNo="+this.getAllPage()+tUrl+"\">尾页</a>");
	    	    	 sb.append(" 页数:"+this.getPageNo()+"/"+this.getAllPage()+"页");
	    	    	 sb.append(" 转到<input type='text' id='tzy' value='' onkeyup='go()' style='width:20px;height:15px;'/>页");
	    	    	 sb.append("  <input type='hidden' value='GO' width='20px' height='15px' onkeyup='go()' onclick='forward()' /> ]");
	    	    	 sb.append("</div></form>");
	    	    	 return sb.toString();
				}
				
				public String getHtml(String str ,int max) {
					 StringBuffer sb=new StringBuffer();
	    	    	 StringBuffer tUrl=new StringBuffer();
	    	    	 String mark ="&";
	    	    	 if(url.indexOf("?")==-1){
	    	    		 mark = "?";
	    	    	 }
	    	    	
	    	    	 if(searchTerms!=null){
		    	    	 for(Map.Entry<String, String> termss:searchTerms.entrySet()){
		    	    		 tUrl.append("&"+termss.getKey()+"="+termss.getValue());
		    	    	 }
	    	    	 }
	    	    	 

	    	    	 sb.append("<script type='text/javascript'>function go(){if(event.keyCode==13){forward();} } function forward(){var tz=$('#tzy').val();if(tz.length<=0){tz=1;} var zongcount=$('#zongcount').val(); if(parseInt(tz)>parseInt(zongcount)){tz=zongcount;}; var myurl=$('#myurl').val();var urlhead=$('#urlhead').val();window.location.href=urlhead+myurl+'pageNo='+tz;}</script><div align=\"center\">");
	    	    	 sb.append("<form action='' method='post'><div  class='foot'>[共"+this.getAllCount()+"条记录");
	    	    	 sb.append("<input type='hidden' id='myurl' value='"+this.url+mark+"' />");
	    	    	 sb.append("<input type='hidden' id='zongcount' value='"+this.getAllPage()+"' />");
	    	    	 sb.append("  <a href=\""+this.url+mark+"pageNo=1"+tUrl+"\">首页</a>");
	    	    	 if(this.isHasPrePage()){
	    	    		int prePage=this.getPageNo()-1;
	    	    		sb.append("  <a href=\""+this.url+mark+"pageNo="+prePage+tUrl+"\">上一页</a>");
	    	    	 }else{
	    	    		 sb.append("  上一页  ");
	    	    	 }
	    	    	 if(this.isHasNextPage()){
	    	    		 int nextPage = this.getPageNo()+1;
	    	    		 sb.append("  <a href=\""+this.url+mark+"pageNo="+nextPage+tUrl+"\">下一页</a>");
	    	    	 }else{
	    	    		 sb.append("  下一页  ");
	    	    	 }
	    	    	 sb.append("  <a href=\""+this.url+mark+"pageNo="+this.getAllPage()+tUrl+"\">尾页</a>");
	    	    	 sb.append(" 页数:"+this.getPageNo()+"/"+this.getAllPage()+"页");
	    	    	 sb.append(" 转到<input type='text' id='tzy' value='' onkeyup='go()' style='width:20px;height:15px;'/>页");
	    	    	 sb.append("  <input type='hidden' id='urlhead' value='"+str+"' > <input type='hidden' value='GO' width='20px' height='15px' onkeyup='go()' onclick='forward()' /> ]");
	    	    	 sb.append("</div></form>");
	    	    	 return sb.toString();
				}
				public String getHtml2() {
					 StringBuffer sb=new StringBuffer();
	    	    	 StringBuffer tUrl=new StringBuffer();
	    	    	 String mark ="&";
	    	    	 if(url.indexOf("?")==-1){
	    	    		 mark = "?";
	    	    	 }
	    	    	
	    	    	 if(searchTerms!=null){
		    	    	 for(Map.Entry<String, String> termss:searchTerms.entrySet()){
		    	    		 tUrl.append("&"+termss.getKey()+"="+termss.getValue());
		    	    	 }
	    	    	 }
	    	    	 
	    	    	 sb.append("<div align=\"center\">");
	    	    	 sb.append("<a onclick=\"completemission('"+this.url+mark+"pageNo=1"+tUrl+"','')\" href=\"#\">首页</a>");
	    	    	 if(this.isHasPrePage()){
	    	    		int prePage=this.getPageNo()-1;
	    	    		sb.append("<a onclick=\"completemission('"+this.url+mark+"pageNo="+prePage+tUrl+"','')\" href=\"#\">上一页</a>");
	    	    	 }else{
	    	    		 sb.append("  上一页  ");
	    	    	 }
	    	    	 if(this.isHasNextPage()){
	    	    		 int nextPage = this.getPageNo()+1;
	    	    		 sb.append("<a onclick=\"completemission('"+this.url+mark+"pageNo="+nextPage+tUrl+"','')\" href=\"#\">下一页</a>");
	    	    	 }else{
	    	    		 sb.append("  下一页  ");
	    	    	 }
	    	    	 sb.append("<a onclick=\"completemission('"+this.url+mark+"pageNo="+this.getAllPage()+tUrl+"','')\" href=\"#\">尾页</a>");
	    	    	 sb.append(" 总共"+this.getAllCount()+"条  ");
	    	    	 sb.append(" 共"+this.getAllPage()+"页");
	    	    	 sb.append(" 当前第"+this.getPageNo()+"页");
	    	    	 sb.append("</div>");
	    	    	 System.out.println("分页结果"+sb.toString());
	    	    	 return sb.toString();
				}
				/**
				 * litscloud cdn list (立云商城后台 用户cdn列表分页)
				 * @return 分页字符串
				 */
				public String getHtml3(String str) {
					 StringBuffer sb=new StringBuffer();
	    	    	 StringBuffer tUrl=new StringBuffer();
	    	    	 String mark ="&";
	    	    	 if(url.indexOf("?")==-1){
	    	    		 mark = "?";
	    	    	 }
	    	    	
	    	    	 if(searchTerms!=null){
		    	    	 for(Map.Entry<String, String> termss:searchTerms.entrySet()){
		    	    		 tUrl.append("&"+termss.getKey()+"="+termss.getValue());
		    	    	 }
	    	    	 }
	    	    	 

	    	    	 sb.append("<script type='text/javascript'>function go(){if(event.keyCode==13){forward();} } function forward(){var tz=$('#tzy').val();if(tz.length<=0){tz=1;} var zongcount=$('#zongcount').val(); if(parseInt(tz)>parseInt(zongcount)){tz=zongcount;}; var myurl=$('#myurl').val();var urlhead=$('#urlhead').val();window.location.href=urlhead+myurl+'pageNo='+tz;}</script>");
	    	    	 sb.append("<form action='' method='post'>[&nbsp;&nbsp;共"+this.getAllCount()+"条记录");
	    	    	 sb.append("<input type='hidden' id='myurl' value='"+this.url+mark+"' />");
	    	    	 sb.append("<input type='hidden' id='zongcount' value='"+this.getAllPage()+"' />");
//	    	    	 [ 共96条记录  <a href="#">首页</a> <a href="#">下一页</a> <a href="#">下一页</a>  <a href="#">尾页</a> 页数：1/15页  &nbsp;&nbsp; 转到<input type="text" value="" name="ssk" class="input_cs" /> 页 <a href="#">打印</a> ]
	    	    	 sb.append("  <a href=\""+this.url+mark+"pageNo=1"+tUrl+"\">首页</a>");
	    	    	 if(this.isHasPrePage()){
	    	    		int prePage=this.getPageNo()-1;
	    	    		sb.append("  <a href=\""+this.url+mark+"pageNo="+prePage+tUrl+"\">上一页</a>");
	    	    	 }else{
	    	    		 sb.append("  上一页  ");
	    	    	 }
	    	    	 if(this.isHasNextPage()){
	    	    		 int nextPage = this.getPageNo()+1;
	    	    		 sb.append("  <a href=\""+this.url+mark+"pageNo="+nextPage+tUrl+"\">下一页</a>");
	    	    	 }else{
	    	    		 sb.append("  下一页  ");
	    	    	 }
	    	    	 sb.append("  <a href=\""+this.url+mark+"pageNo="+this.getAllPage()+tUrl+"\">尾页</a>");
	    	    	 sb.append(" 页数:"+this.getPageNo()+"/"+this.getAllPage()+" 页");
	    	    	 sb.append(" 转到<input type='text'class='input_cs' id='tzy' value='' onkeyup='go()'/>页");
	    	    	 sb.append(" <input type='hidden' id='urlhead' value='"+str+"' > <input type='hidden' value='GO' width='20px' height='15px' onkeyup='go()' onclick='forward()' /> ]");
	    	    	 sb.append("</form>");
	    	    	 return sb.toString();
				}
				
				public String getHtml(String jsmethod) {
					 StringBuffer sb=new StringBuffer();
	    	    	 StringBuffer tUrl=new StringBuffer();
	    	    	 String mark ="&";
	    	    	 if(url!=null){
		    	    	 if(url.indexOf("?")==-1){
		    	    		 mark = "?";
		    	    	 }
	    	    	 }
	    	    	
	    	    	 if(searchTerms!=null){
		    	    	 for(Map.Entry<String, String> termss:searchTerms.entrySet()){
		    	    		 tUrl.append("&"+termss.getKey()+"="+termss.getValue());
		    	    	 }
	    	    	 }
	    	    	 
	    	    	 sb.append("<div align=\"center\">");
	    	    	 sb.append("<a href='javascript:void(0)' onclick='"+jsmethod+"("+1+")'>首页</a>");
	    	    	 if(this.isHasPrePage()){
	    	    		int prePage=this.getPageNo()-1;
	    	    		 sb.append("<a href='javascript:void(0)' onclick='"+jsmethod+"("+prePage+")'>上一页</a>");
	    	    	 }else{
	    	    		 sb.append("  上一页  ");
	    	    	 }
	    	    	 if(this.isHasNextPage()){
	    	    		 int nextPage = this.getPageNo()+1;
	    	    		 sb.append("<a href='javascript:void(0)' onclick='"+jsmethod+"("+nextPage+")'>下一页</a>");
	    	    	 }else{
	    	    		 sb.append("  下一页  ");
	    	    	 }
	    	    	 sb.append("<a href='javascript:void(0)' onclick='"+jsmethod+"("+this.getAllPage()+")'>尾页</a>");
	    	    	 sb.append(" 总共"+this.getAllCount()+"条  ");
	    	    	 sb.append(" 共"+this.getAllPage()+"页");
	    	    	 sb.append(" 当前第"+this.getPageNo()+"页");
	    	    	 sb.append("</div>");
	    	    	 return sb.toString();
				}
				
				
				

				public void setHtml(String html) {
					this.html = html;
				}

				/**
				 * 设置总条数
				 * @param allCount
				 */
				public void setAllCount(int allCount) {
					this.allCount = allCount;
				}

				/**
				 * 获取总页数
				 * @return int
				 */
				public int getAllPage() {
					return allPage;
				}
				
				/**
				 * 设置总页数
				 * @param allPage
				 */
				public void setAllPage(int allPage) {
					this.allPage = allPage;
				}
				
				/**
				 * 是否有下一页
				 * @return boolean
				 */
				public boolean isHasNextPage() {
					return hasNextPage;
				}
				
				/**
				 * 设置是否有下一页
				 * @param hasNextPage
				 */
				public void setHasNextPage(boolean hasNextPage) {
					this.hasNextPage = hasNextPage;
				}
				
				/**
				 * 是否有上一页
				 * @return
				 */
				public boolean isHasPrePage() {
					return hasPrePage;
				}
				
				/**
				 * 设置是否有上一页
				 * @return
				 */
				public void setHasPrePage(boolean hasPrePage) {
					this.hasPrePage = hasPrePage;
				}
				
				/**
				 * 获取分页结果
				 * @return
				 */
				public List<Object> getPageList() {
					return pageList;
				}
				
				/**
				 * 设置分页结果
				 * @param pageList
				 */
				public void setPageList(List<Object> pageList) {
					this.pageList = pageList;
				}
				
				public List<Object[]> getPageLists() {
					return pageLists;
				}

				public void setPageLists(List<Object[]> pageLists) {
					this.pageLists = pageLists;
				}

				/**
				 * 获取当前页
				 * @return
				 */
				public int getPageNo() {
					return pageNo;
				}
				
				/**
				 * 设置当前页
				 * @param pageNo
				 */
				public void setPageNo(int pageNo) {
					this.pageNo = pageNo;
				}
				
				/**
				 * 每页数据条数
				 * @return
				 */
				public int getPageSize() {
					return pageSize;
				}
				
				/**
				 * 设置每页数据条数
				 * @param pageSize
				 */
				public void setPageSize(int pageSize) {
					this.pageSize = pageSize;
				}
				
				/**
				 * 每页结束
				 * @return
				 */
				public int getRecordEnd() {
					return recordEnd;
				}
				
				/**
				 * 设置每页结束
				 * @param recordEnd
				 */
				public void setRecordEnd(int recordEnd) {
					this.recordEnd = recordEnd;
				}
				
				/**
				 * 获取每页开始
				 * @return int
				 */
				public int getRecordStart() {
					return recordStart;
				}
				
				/**
				 * 设置每页开始
				 * @param recordStart
				 */
				public void setRecordStart(int recordStart) {
					this.recordStart = recordStart;
				}
				
				/**
				 * 显示条数
				 * @return int
				 */
				public int getShowCount() {
					return showCount;
				}
				
				/**
				 * 设置显示条数
				 * @param showCount
				 */
				public void setShowCount(int showCount) {
					this.showCount = showCount;
				}

				public String getUrl() {
					return url;
				}

				public void setUrl(String url) {
					this.url = url;
				}
			    public  HashMap<String,String> getSearchTerms() {
						return searchTerms;
				}

				public void setSearchTerms(HashMap<String,String> searchTerms) {
						this.searchTerms = searchTerms;
				}
				public static void main(String[] args) {
					String str = "ibmsunjavabbb";
					System.out.println(str.substring(6,10));
				}
}