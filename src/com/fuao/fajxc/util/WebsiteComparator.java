package com.fuao.fajxc.util;

import java.util.Comparator;
/**
 * 我的桌面排序类
 * 
 * @aucom.fuao.fajxc.util ok 2009-06-19 v1.0
 */
public class WebsiteComparator implements Comparator {

	/* （非 Javadoc）
	 * @see java.util.Comparator#compare(java.lang.Object, java.lang.Object)
	 */
	public int compare(Object o1, Object o2) {
		// TODO 自动生成方法存根
		WebSiteContentBean c1 = (WebSiteContentBean) o1;   
		WebSiteContentBean c2 = (WebSiteContentBean) o2;  
		if(c1.getSelectflag()==c2.getSelectflag() && c1.getSelectflag()==1)
		{
		  if (c1.getLocation() > c2.getLocation()  )
		  {   
			  return 1;   
		  }else 
		  {   
	           if (c1.getLocation() == c2.getLocation() ) 
	           {   
	        	   return 0;   
			   } else 
			   {   
				   return -1;   
			   }      
		  }   
		}else
		{
			if(c1.getSelectflag()==0 && c2.getSelectflag()==1)
			{
				return 1;
			}else
			{
				return 0;
			}
		}
	}

}
