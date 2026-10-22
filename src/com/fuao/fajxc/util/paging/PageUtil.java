package com.fuao.fajxc.util.paging;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class PageUtil { 

	// Use the origin page to create a new page


	public static Page createPage(Page page, int totalRecords) {
	return createPage(page.getEveryPage(), page.getCurrentPage(),
	totalRecords);
	}


	//the basic page utils not including exception handler


	public static Page createPage(int everyPage, int currentPage,
	int totalRecords) {
	everyPage = getEveryPage(everyPage);
	currentPage = getCurrentPage(currentPage);
	int beginIndex = getBeginIndex(everyPage, currentPage);
	int totalPage = getTotalPage(everyPage, totalRecords);
	boolean hasNextPage = hasNextPage(currentPage, totalPage);
	boolean hasPrePage = hasPrePage(currentPage);

	return new Page(hasPrePage, hasNextPage, everyPage, totalPage,
	currentPage, beginIndex, totalRecords);
	}

	private static int getEveryPage(int everyPage) {
	return everyPage == 0 ? 10 : everyPage;
	}

	private static int getCurrentPage(int currentPage) {
	return currentPage == 0 ? 1 : currentPage;
	}

	private static int getBeginIndex(int everyPage, int currentPage) {
	return (currentPage - 1) * everyPage;
	}

	private static int getTotalPage(int everyPage, int totalRecords) {
	int totalPage = 0;

	if (totalRecords % everyPage == 0)
	totalPage = totalRecords / everyPage;
	else
	totalPage = totalRecords / everyPage + 1;

	return totalPage;
	}

	private static boolean hasPrePage(int currentPage) {
	return currentPage == 1 ? false : true;
	}

	private static boolean hasNextPage(int currentPage, int totalPage) {
	return currentPage == totalPage || totalPage == 0 ? false : true;
	}
	
  public static void main(String[] args) {
	String jsonStr="{'tcorfc':'tc','lotteryId':'B001','autoGen':'1','enableBonusInvest':1,'stopCondition':{'stopType':'1'," +
			"'stopBonusLevel':'1','stopBonusValue':'2'},'records':[{'id':'2','issue':'2011138','timesCount':'1','codeRecords':" +
			"[{'id':'3','issue':'2011138','lotterySaleId':'1','code':'0001060716182930~08^','money':'200','timesCount':'1','investCount':'1','investType':'1'}]}]";
	try {
		JSONObject j = new JSONObject(jsonStr);
		System.out.println(j.get("tcorfc"));
		String jsonArray="[{'name':'小三', 'password':'111111'},{'name':'小4', 'password':'2222222'},{'name':'小5', 'password':'333333'}]";
	  JSONArray ja = new JSONArray(jsonArray);
	  for(int i=0;i<ja.length();i++)
	  {
		  JSONObject bb = ja.getJSONObject(i);
		  System.out.println(bb);
		  System.out.println(bb.get("password"));
	  }
	} catch (JSONException e) {
		
		e.printStackTrace();
	}
}
	}


