/**
 * 
 */
package com.fuao.fajxc.util;

/**
 * 统计bean
 * @author ok
 * @version 1.0 2009-07-15
 */
public class CountBean {

	private String userid;

	private String daynum;

	private Integer countnum;
	
	private String mobile;

	/**
	 * @return mobile
	 */
	public String getMobile() {
		return mobile;
	}

	/**
	 * @param mobile 要设置的 mobile
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	/**
	 * @return countnum
	 */
	public Integer getCountnum() {
		return countnum;
	}

	/**
	 * @param countnum 要设置的 countnum
	 */
	public void setCountnum(Integer countnum) {
		this.countnum = countnum;
	}

	/**
	 * @return daynum
	 */
	public String getDaynum() {
		return daynum;
	}

	/**
	 * @param daynum 要设置的 daynum
	 */
	public void setDaynum(String daynum) {
		this.daynum = daynum;
	}

	/**
	 * @return userid
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * @param userid 要设置的 userid
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

}
