package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Sale_goods entity. @author MyEclipse Persistence Tools
 */

public class Sale_goods implements java.io.Serializable {

	// Fields

	private Integer sgId;
	private Goods_dict goods_dict;
	private String sgUsername;// 录入人
	private String sgname;// 商品名称
	private Double sgPrice;// 商品价格
	private String sgImg;// 商品的图片
	private String sgThumb;// 商品的图片
	private String sgcode;// 商品编码
	private String sgNorms;// 规格
	private String sgUnit;// 单位
	private Integer sgStat;// 状态
	private Integer sgCheckGoods;// 审核状态
	private String sgtime;// 创建时间
	private String sgPuttime;// 发布时间 发布审核通过的时间
	private Integer sgnumbers;// 数量
	private String sgspecifications;//商品规格
	private String erweima;//二维码

	private String sgDetails;// 商品详情
	private String sgVideo;// 商品视频

	private int sgInventory;// 商品库存
	private int sgQuantity;// 商品数量
	private int sgSalesVolume;// 总销量
	private String sgAttribute;// 商品属性
	private String sgchecks;
	private String sgchecks1;
	private String sgchecks2;
	private String selname; // 查询值
	private String isActivity; // 是否(活动)促销
	private Double activityPrice; // (活动)促销价格
	private Integer isDelivery; // 是否需要发货 0 1



	public Integer getIsDelivery() {
		return isDelivery;
	}

	public void setIsDelivery(Integer isDelivery) {
		this.isDelivery = isDelivery;
	}

	public String getIsActivity() {
		return isActivity;
	}

	public void setIsActivity(String isActivity) {
		this.isActivity = isActivity;
	}

	public Double getActivityPrice() {
		return activityPrice;
	}

	public void setActivityPrice(Double activityPrice) {
		this.activityPrice = activityPrice;
	}

	public String getActivityStart() {
		return activityStart;
	}

	public void setActivityStart(String activityStart) {
		this.activityStart = activityStart;
	}

	public String getActivityEnd() {
		return activityEnd;
	}

	public void setActivityEnd(String activityEnd) {
		this.activityEnd = activityEnd;
	}

	private String activityStart; // (活动)促销开始时间
	private String activityEnd; // 促销结束时间

	public String getSelname() {
		return selname;
	}

	public void setSelname(String selname) {
		this.selname = selname;
	}

	private Set saleGoods_midses = new HashSet(0);
	private Set tresourceCheck = new HashSet(0);

	// Constructors

	/** default constructor */

	public Sale_goods() {
	}

	public String getSgchecks() {
		return sgchecks;
	}

	public String getSgchecks1() {
		return sgchecks1;
	}

	public void setSgchecks1(String sgchecks1) {
		this.sgchecks1 = sgchecks1;
	}

	public String getSgchecks2() {
		return sgchecks2;
	}

	public void setSgchecks2(String sgchecks2) {
		this.sgchecks2 = sgchecks2;
	}

	public void setSgchecks(String sgchecks) {
		this.sgchecks = sgchecks;
	}

	public Integer getSgnumbers() {
		return sgnumbers;
	}

	public void setSgnumbers(Integer sgnumbers) {
		this.sgnumbers = sgnumbers;
	}

	/** minimal constructor */
	public Sale_goods(String sgUsername, String sgVideo, String sgDetails,
			String sgname, Double sgPrice, String sgImg, String sgcode,
			String sgNorms, String sgUnit) {
		this.sgUsername = sgUsername;
		this.sgname = sgname;
		this.sgPrice = sgPrice;
		this.sgImg = sgImg;
		this.sgcode = sgcode;
		this.sgNorms = sgNorms;
		this.sgUnit = sgUnit;
		this.sgVideo = sgVideo;
		this.sgDetails = sgDetails;
	}

	/** full constructor */
	public Sale_goods(Goods_dict goods_dict, int sgSalesVolume,
			String sgAttribute, int sgInventory, int sgQuantity,
			String sgVideo, String sgDetails, String sgUsername, String sgname,
			Double sgPrice, String sgImg, String sgcode, String sgNorms,
			String sgUnit, Integer sgStat, Integer sgCheckGoods, String sgtime,
			String sgPuttime, Set saleGoods_midses) {
		this.goods_dict = goods_dict;
		this.sgUsername = sgUsername;
		this.sgname = sgname;
		this.sgPrice = sgPrice;
		this.sgImg = sgImg;
		this.sgcode = sgcode;
		this.sgNorms = sgNorms;
		this.sgUnit = sgUnit;
		this.sgStat = sgStat;
		this.sgCheckGoods = sgCheckGoods;
		this.sgtime = sgtime;
		this.sgPuttime = sgPuttime;
		this.saleGoods_midses = saleGoods_midses;
		this.sgVideo = sgVideo;
		this.sgDetails = sgDetails;
		this.sgInventory = sgInventory;
		this.sgQuantity = sgQuantity;
		this.sgSalesVolume = sgSalesVolume;
		this.sgAttribute = sgAttribute;
	}

	// Property accessors

	public Integer getSgId() {
		return this.sgId;
	}

	public int getSgInventory() {
		return sgInventory;
	}

	public void setSgInventory(int sgInventory) {
		this.sgInventory = sgInventory;
	}

	public int getSgQuantity() {
		return sgQuantity;
	}

	public void setSgQuantity(int sgQuantity) {
		this.sgQuantity = sgQuantity;
	}

	public int getSgSalesVolume() {
		return sgSalesVolume;
	}

	public void setSgSalesVolume(int sgSalesVolume) {
		this.sgSalesVolume = sgSalesVolume;
	}

	public String getSgAttribute() {
		return sgAttribute;
	}

	public void setSgAttribute(String sgAttribute) {
		this.sgAttribute = sgAttribute;
	}

	public String getSgDetails() {
		return sgDetails;
	}

	public void setSgDetails(String sgDetails) {
		this.sgDetails = sgDetails;
	}

	public String getSgVideo() {
		return sgVideo;
	}

	public void setSgVideo(String sgVideo) {
		this.sgVideo = sgVideo;
	}

	public void setSgId(Integer sgId) {
		this.sgId = sgId;
	}

	public Goods_dict getGoods_dict() {
		return this.goods_dict;
	}

	public void setGoods_dict(Goods_dict goods_dict) {
		this.goods_dict = goods_dict;
	}

	public String getSgUsername() {
		return this.sgUsername;
	}

	public void setSgUsername(String sgUsername) {
		this.sgUsername = sgUsername;
	}

	public String getSgname() {
		return this.sgname;
	}

	public void setSgname(String sgname) {
		this.sgname = sgname;
	}

	public Double getSgPrice() {
		return this.sgPrice;
	}

	public void setSgPrice(Double sgPrice) {
		this.sgPrice = sgPrice;
	}

	public String getSgImg() {
		return this.sgImg;
	}

	public void setSgImg(String sgImg) {
		this.sgImg = sgImg;
	}

	public String getSgcode() {
		return this.sgcode;
	}

	public void setSgcode(String sgcode) {
		this.sgcode = sgcode;
	}

	public String getSgNorms() {
		return this.sgNorms;
	}

	public void setSgNorms(String sgNorms) {
		this.sgNorms = sgNorms;
	}

	public String getSgUnit() {
		return this.sgUnit;
	}

	public void setSgUnit(String sgUnit) {
		this.sgUnit = sgUnit;
	}

	public Integer getSgStat() {
		return this.sgStat;
	}

	public void setSgStat(Integer sgStat) {
		this.sgStat = sgStat;
	}

	public Integer getSgCheckGoods() {
		return this.sgCheckGoods;
	}

	public void setSgCheckGoods(Integer sgCheckGoods) {
		this.sgCheckGoods = sgCheckGoods;
	}

	public String getSgtime() {
		return sgtime;
	}

	public void setSgtime(String sgtime) {
		this.sgtime = sgtime;
	}

	public String getSgPuttime() {
		return sgPuttime;
	}

	public void setSgPuttime(String sgPuttime) {
		this.sgPuttime = sgPuttime;
	}

	public Set getSaleGoods_midses() {
		return this.saleGoods_midses;
	}

	public void setSaleGoods_midses(Set saleGoods_midses) {
		this.saleGoods_midses = saleGoods_midses;
	}

	public Set getTresourceCheck() {
		return tresourceCheck;
	}

	public void setTresourceCheck(Set tresourceCheck) {
		this.tresourceCheck = tresourceCheck;
	}

	public void setSgspecifications(String sgspecifications) {
		this.sgspecifications = sgspecifications;
	}

	public String getSgspecifications() {
		return sgspecifications;
	}

	public void setErweima(String erweima) {
		this.erweima = erweima;
	}

	public String getErweima() {
		return erweima;
	}

	public String getSgThumb() {
		return sgThumb;
	}

	public void setSgThumb(String sgThumb) {
		this.sgThumb = sgThumb;
	}

}