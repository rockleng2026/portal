package com.fuao.fajxc.site;

public class EnumStaticPath {
	private   String TITLE_PIC ="";//头部图片路径
	private  String CONTENT_PIC ="";//内容中插入图片路径
	private   String REC_PIC ="";//推荐部分上传图片路径
	private   String COMMENT_ISCHECK ="FALSE";//评论是否审核 默认否
	private static EnumStaticPath  esp = null;

public static EnumStaticPath getInstance(){
	
	if( esp == null){
		esp = new EnumStaticPath();
	}
	return esp;
}

public String getTITLE_PIC() {
	return TITLE_PIC;
}

public void setTITLE_PIC(String title_pic) {
	TITLE_PIC = title_pic;
}

public String getCONTENT_PIC() {
	return CONTENT_PIC;
}

public void setCONTENT_PIC(String content_pic) {
	CONTENT_PIC = content_pic;
}

public String getREC_PIC() {
	return REC_PIC;
}

public void setREC_PIC(String rec_pic) {
	REC_PIC = rec_pic;
}

public EnumStaticPath getEsp() {
	return esp;
}

public void setEsp(EnumStaticPath esp) {
	this.esp = esp;
}

public String getCOMMENT_ISCHECK() {
	return COMMENT_ISCHECK;
}

public void setCOMMENT_ISCHECK(String comment_ischeck) {
	COMMENT_ISCHECK = comment_ischeck;
}
}

