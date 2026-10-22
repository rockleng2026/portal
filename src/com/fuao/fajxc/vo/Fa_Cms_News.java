package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Fa_Cms_News {
	private Integer cid;
	private Integer classid;//CMS类型表ID
	private Integer sequence;//排序序号
	private String readnum;//阅读数量
	private String keyboard;//关键字
	private Integer userid;//用户ID
	private String username; //用户名
	private Integer status; //核审状态 0未审核 1审合通过 2审核失败
	private String author; //作者
	private String title;//标题
	private String titlepic;//标题
	private String titlepicThumb;//标题
	private Integer istop; //是否置顶
	private Integer ismember; //
	private String ftitle;// 副标题
	private String smalltext;//文章简介
	private String contents; //内容
	private String source; //来源
	private Integer delflag; //是否删除
	private Integer showflag; //是否显示
	private String senddate; //发送日期
	private String newsdate; //新闻日期
	private String editdate; //编辑日期
	private Integer hasFile; //
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String newUrl;//跳转到文章审核中.
	private Set<Fa_Cms_Rec_Info> recinfo = new HashSet<Fa_Cms_Rec_Info>();
	public String getNewUrl() {
		return newUrl;
	}
	public void setNewUrl(String newUrl) {
		this.newUrl = newUrl;
	}
	//文章对类别  多对一
	private Fa_Cms_Classes classes;
	//文章对评论(content_comment) 一对多
	private Set<Fa_Cms_Content_Comments> comments = new HashSet<Fa_Cms_Content_Comments>();
	public Fa_Cms_News(){}
	public Fa_Cms_News(Integer cid, Integer classid, String readnum,
			String keyboard, Integer userid, String username, Integer status,
			String author, String title, Integer istop, Integer ismember,
			String ftitle, String smalltext, String contents, String source,
			Integer delflag, Integer showflag, String senddate,
			String newsdate, String editdate, Integer hasFile, String tmp,
			String tmp1, String tmp2) {
		this.cid = cid;
		this.classid = classid;
		this.readnum = readnum;
		this.keyboard = keyboard;
		this.userid = userid;
		this.username = username;
		this.status = status;
		this.author = author;
		this.title = title;
		this.istop = istop;
		this.ismember = ismember;
		this.ftitle = ftitle;
		this.smalltext = smalltext;
		this.contents = contents;
		this.source = source;
		this.delflag = delflag;
		this.showflag = showflag;
		this.senddate = senddate;
		this.newsdate = newsdate;
		this.editdate = editdate;
		this.hasFile = hasFile;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Integer getClassid() {
		return classid;
	}
	public void setClassid(Integer classid) {
		this.classid = classid;
	}
	public String getReadnum() {
		return readnum;
	}
	public void setReadnum(String readnum) {
		this.readnum = readnum;
	}
	public String getKeyboard() {
		return keyboard;
	}
	public void setKeyboard(String keyboard) {
		this.keyboard = keyboard;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getIstop() {
		return istop;
	}
	public void setIstop(Integer istop) {
		this.istop = istop;
	}
	public Integer getIsmember() {
		return ismember;
	}
	public void setIsmember(Integer ismember) {
		this.ismember = ismember;
	}
	public String getFtitle() {
		return ftitle;
	}
	public void setFtitle(String ftitle) {
		this.ftitle = ftitle;
	}
	public String getSmalltext() {
		return smalltext;
	}
	public void setSmalltext(String smalltext) {
		this.smalltext = smalltext;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public Integer getDelflag() {
		return delflag;
	}
	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}
	public Integer getShowflag() {
		return showflag;
	}
	public void setShowflag(Integer showflag) {
		this.showflag = showflag;
	}
	public String getSenddate() {
		return senddate;
	}
	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}
	public String getNewsdate() {
		return newsdate;
	}
	public void setNewsdate(String newsdate) {
		this.newsdate = newsdate;
	}
	
	public String getEditdate() {
		return editdate;
	}
	public void setEditdate(String editdate) {
		this.editdate = editdate;
	}
	public Integer getHasFile() {
		return hasFile;
	}
	public void setHasFile(Integer hasFile) {
		this.hasFile = hasFile;
	}
	public String getTmp() {
		return tmp;
	}
	public void setTmp(String tmp) {
		this.tmp = tmp;
	}
	public String getTmp1() {
		return tmp1;
	}
	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}
	public String getTmp2() {
		return tmp2;
	}
	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}
	public Fa_Cms_Classes getClasses() {
		return classes;
	}
	public void setClasses(Fa_Cms_Classes classes) {
		this.classes = classes;
	}
	public Set<Fa_Cms_Content_Comments> getComments() {
		return comments;
	}
	public void setComments(Set<Fa_Cms_Content_Comments> comments) {
		this.comments = comments;
	}
	public String getTitlepic() {
		return titlepic;
	}
	public void setTitlepic(String titlepic) {
		this.titlepic = titlepic;
	}
	public String getTitlepicThumb() {
		return titlepicThumb;
	}
	public void setTitlepicThumb(String titlepicThumb) {
		this.titlepicThumb = titlepicThumb;
	}
	public Set<Fa_Cms_Rec_Info> getRecinfo() {
		return recinfo;
	}
	public void setRecinfo(Set<Fa_Cms_Rec_Info> recinfo) {
		this.recinfo = recinfo;
	}
	public Integer getSequence() {
		return sequence;
	}
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}
	
}
