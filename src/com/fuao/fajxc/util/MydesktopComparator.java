package com.fuao.fajxc.util;
import java.util.Comparator;
/**
 * 我的桌面排序类
 * 
 * @aucom.fuao.fajxc.util ok 2009-06-19 v1.0
 */
public class MydesktopComparator implements Comparator {

	/* （非 Javadoc）
	 * @see java.util.Comparator#compare(java.lang.Object, java.lang.Object)
	 */
	public int compare(Object o1, Object o2) {
		// TODO 自动生成方法存根
		MydeskBean c1 = (MydeskBean) o1;   
		MydeskBean c2 = (MydeskBean) o2;   
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
		   
	}

}
