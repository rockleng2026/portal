package com.fuao.fajxc.util;

import java.util.Arrays;


public class ArrayContrast { 
	public static void main(String[] args) {
		ArrayContrast h = new ArrayContrast();
		String[] si = {"1","2","3","4","5"};
		String[] s2= {"1","2"};
		System.out.println(h.getDelArr(si,s2));
	}
	      
	    public String getDelArr(String a [],String b[]){  

	    	int c=1;
	    	  Arrays.sort(b);  
		      Arrays.sort(a); 
	        String srr="";
	        for( int i = 0, size = a.length; i < size; i++ ) {  
	            int index = Arrays.binarySearch(b, a[i]);  
	            if( index < 0 ) { 

	            	if(c==1)
	            	{
	            		srr+=a[i];
	            		c++;
	            		continue;
	            	}
	              srr+=","+a[i];  
	            }  
	        }  return srr;
	          
	    }  
	  

}
