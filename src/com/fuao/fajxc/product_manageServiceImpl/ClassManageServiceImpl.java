package com.fuao.fajxc.product_manageServiceImpl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.sql.HSQLCaseFragment;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.fuao.fajxc.product_manageDao.ClassManageDao;
import com.fuao.fajxc.product_manageService.ClassManageService;
import com.fuao.fajxc.util.Page;
import com.fuao.fajxc.util.Pager;
import com.fuao.fajxc.vo.GoodsClass_expand;
import com.fuao.fajxc.vo.Goods_dict;
import com.sun.jndi.url.iiopname.iiopnameURLContextFactory;

public class ClassManageServiceImpl implements ClassManageService{
    
	private ClassManageDao classManaDao;
	private Logger log=Logger.getLogger(ClassManageServiceImpl.class);
	private String allCode;
	public ClassManageDao getClassManaDao() {
		return classManaDao;
	}

	public void setClassManaDao(ClassManageDao classManaDao) {
		this.classManaDao = classManaDao;
	}

	public boolean delete(Object obj) {
		if(obj instanceof Integer){
		Integer id = (Integer) obj;
		try {
			List<Goods_dict> mli=this.classManaDao.selectByall("from Goods_dict where gdSuperId="+id);
			if (mli.size()==0) {
				Goods_dict goodsDict=(Goods_dict) this.classManaDao.selectById(id);
				this.classManaDao.delete(goodsDict);
			}else{
				return false;
			}
			
		} catch (Exception e) {
			//e.printStackTrace();
			return false;
		}
		return true;
		}else{
			try {
				this.classManaDao.delete(obj);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return true;
		}
	}

	public Object save(Object obj) throws Exception {
		return classManaDao.save(obj);
	}

	public Object selectById(int id) {
		// TODO Auto-generated method stub
		return classManaDao.selectById(id);
	}

	public List selectByall(String hql) {
		return classManaDao.selectByall(hql);
	}

	public List selectall() {
		// TODO Auto-generated method stub
		return null;
	}

	public Object update(Object obj) {
		return classManaDao.Update(obj);
	}
    public String castAfter(String cos){
    	String str = "";
    	if(cos.substring(0,1).equals("0")){
    		if(cos.substring(1,2).equals("0")){
    			if(cos.substring(2,3).equals("0")){
    				if(cos.substring(3,4).equals("9")){
    				    str="00"+(Integer.parseInt(cos.substring(3,4))+1);
    				}else{
    					str="000"+(Integer.parseInt(cos.substring(3,4))+1);
    				}
    			}else{
    				if(cos.substring(2,4).equals("99")){
    					  str="0"+(Integer.parseInt(cos.substring(2,4))+1);
    				}else{
    					 str="00"+(Integer.parseInt(cos.substring(2,4))+1);
    				}
    			}
    		}else{//不等于0/011
    		    int mid=Integer.parseInt(cos.substring(1,4));
    			if(mid==999){
    				str=(mid+1)+"";
    			}else{
                    str="0"+(mid+1);
    			}
    		}
    	}else{//不等于0/111
    		int mid=Integer.parseInt(cos.substring(0,4));
    		if(mid==9999){
				str="对不起编码已到了上限了，请通知管理员。";
			}else{
                str=(mid+1)+"";
			}
    	}
    	return str+"0000";
    }
	public String createCodes(String codes,String supers) {
		String reCode="";
		TreeSet<String> tStri= new TreeSet<String>(new Comparator<String>() {
			public int compare(String o1, String o2) {
				return o2.compareTo(o1);
			}
		});
		TreeSet<String> tsSet = new TreeSet<String>();
 		if(codes.equals("f")){
			List<Goods_dict> classList=classManaDao.selectByall("from Goods_dict where substring(gdcodes,-4)='0000' and CHAR_LENGTH(gdcodes)=8");
			if(classList.size()==0){
				reCode="00010000";
			}else{
				for (Goods_dict goodsDict : classList) {
					tStri.add(goodsDict.getGdcodes().substring(0,4));	
				}
			    for (Iterator iterator = tStri.iterator(); iterator
						.hasNext();) {
					String strmid = (String) iterator.next();
					reCode=castAfter(strmid);
					break;
				}
			}
			
		}
		if(codes.equals("c")){
			StringBuffer sbu=new StringBuffer();
			if(supers.substring((supers.length()-4),supers.length()).equals("0000") && supers.length()==8){
				List<Goods_dict> classList=classManaDao.selectByall("from Goods_dict where gdcodes='"+supers+"'");
				Goods_dict git=classList.get(0);
				List<Goods_dict> clasLi=classManaDao.selectByall("from Goods_dict where gdSuperId="+git.getGdId()+" order by gdId desc");
				if(clasLi.size()==0){
				  sbu.append(supers);
				  reCode=sbu.replace(sbu.lastIndexOf("0"),(sbu.lastIndexOf("0")+1),(Integer.parseInt(sbu.substring(supers.length()-1,supers.length())+1))+"").toString();
				}else{
					for (Goods_dict goodsDict : clasLi) {
						sbu.append(goodsDict.getGdcodes());
						reCode=sbu.replace((sbu.length()-1),(sbu.length()),(Integer.parseInt(sbu.substring(sbu.length()-1,sbu.length()))+1)+"").toString();
					    break;
					}
				}
				log.info(reCode);
			}else{//子类移做父类
				//String last1=supers.substring((supers.length()-4),supers.length());
				log.info(supers.substring((supers.length()-1),supers.length())+","+supers);
				sbu.append(supers);
				if(supers.substring((supers.length()-4),(supers.length()-3)).equals("0")){
					if(supers.substring((supers.length()-3),(supers.length()-2)).equals("0")){
						if(supers.substring((supers.length()-2),(supers.length()-1)).equals("0")){
							if(supers.substring((supers.length()-1),supers.length()).equals("9")){//000200010000
								String reCode1=sbu.replace((sbu.length()-2),supers.length(),Integer.parseInt(supers.substring((supers.length()-1),supers.length()))+1+"").toString(); 
								reCode=compareToDB(reCode1);
							}else{
								String strCode=sbu.replace((sbu.length()-1),supers.length(),Integer.parseInt(supers.substring((supers.length()-1),supers.length()))+1+"").toString();
								reCode=compareToDB(strCode);
							}
						}else{
							String strs=supers.substring((supers.length()-2),(supers.length()));
							if (strs.equals("99")) {
								String reCode2=sbu.replace((sbu.length()-3),supers.length(),Integer.parseInt(supers.substring((supers.length()-2),supers.length()))+1+"").toString();
								reCode=compareToDB(reCode2);
							}else{
								String reCode3=sbu.replace((sbu.length()-2),supers.length(),Integer.parseInt(supers.substring((supers.length()-2),supers.length()))+1+"").toString();
								reCode=compareToDB(reCode3); 
							}
						}
					}else{
						String strs=supers.substring((supers.length()-3),(supers.length()));
						if (strs.equals("999")) {
							String reCode4=sbu.replace((sbu.length()-4),supers.length(),Integer.parseInt(supers.substring((supers.length()-3),supers.length()))+1+"").toString();
							reCode=compareToDB(reCode4);
						}else{
							String reCode5=sbu.replace((sbu.length()-3),supers.length(),Integer.parseInt(supers.substring((supers.length()-3),supers.length()))+1+"").toString();
							reCode=compareToDB(reCode5);
						}
					}
				}else{
					String strs1=supers.substring((supers.length()-4),(supers.length()));
					if (strs1.equals("9999")) {
						reCode="对不起，子类编码已到上限。";
					}else{
						String reCode6=sbu.replace((sbu.length()-4),supers.length(),Integer.parseInt(supers.substring((supers.length()-4),supers.length()))+1+"").toString();
						reCode=compareToDB(reCode6);
					}
				}
			}
		}
		 log.info(reCode);
		return reCode;
	}
	public String compareToDB(String codes){
		StringBuffer stb=new StringBuffer(codes);
		List<Goods_dict> classList=classManaDao.selectByall("from Goods_dict where gdcodes='"+stb.toString()+"'");
		if(classList.size()>0){
			String strCode=stb.replace((stb.length()-1),stb.length(),Integer.parseInt(stb.substring((stb.length()-1),stb.length()))+1+"").toString();
			compareToDB(strCode);
		}else{
			allCode=codes;
			return allCode;
		}
		return allCode;
	}
	//通用拆除属性
	public GoodsClass_expand comentContent(String jsonStr){
		JSONArray jsonArray;
		GoodsClass_expand gExpand = new GoodsClass_expand();
		try {
			jsonArray = new JSONArray(jsonStr);
			for(int i=0;i<jsonArray.length(); i++){
				JSONObject jsonJ = jsonArray.getJSONObject(i); 
				for(int j=0;j<15;j++){
					String m=j+"";
					if(!jsonJ.getString(m).isEmpty()){
					  log.info(jsonJ.getString(m));
					  try {
					  if(j==0){
						  String string=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						  gExpand.setGeTemp1(string);
					  }
					  if(j==1){
						      String string1=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						      gExpand.setGeTemp2(string1);
						  }
					  if(j==2){
						     String string2=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp3(string2);
						  }
					  if(j==3){
						     String string3=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp4(string3);
						  }
					  if(j==4){
						     String string4=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp5(string4);
						  }
					  if(j==5){
						     String string5=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp6(string5);
						  }
					  if(j==6){
						     String string6=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp7(string6);
						  }
					  if(j==7){
						     String string7=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp8(string7);
						  }
					  if(j==8){
						      String string8=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp9(string8);
						  }
					  if(j==9){
						      String string9=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp10(string9);
						  }
					  if(j==10){
						      String string10=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp11(string10);
						  }
					  if(j==11){
						      String string11=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp12(string11);
						  }
					  if(j==12){
						     String string12=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp13(string12);
						  }
					  if(j==13){
						     String string13=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp14(string13);
						  }
					  if(j==14){
						     String string14=URLDecoder.decode(jsonJ.getString(m).toString(),"utf-8");
						     gExpand.setGeTemp15(string14);
						  }
					  } catch (UnsupportedEncodingException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}else{
						break;
					}
				}
			}
		} catch (JSONException e) {
			//e.printStackTrace();
		} 
		return gExpand;
	}

	public Object saleDoodsById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public int undercarriage(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateUpdate(String str, int id) {
		// TODO Auto-generated method stub
		return 0;
	}


	public int undercarriageup(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Page doSplit(int pageNo, int pagesize) {
		return classManaDao.doSplit(pageNo, pagesize);
	}

	public Page doSplit(int pageNo, int pagesize, String name) {
		return classManaDao.doSplit(pageNo, pagesize, name);
	}

	public int addAuditingOrder2(String otype, String oNo, String entityName,
			String filialemark) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List selSomeGoods_dict(String addhql) {
		// TODO Auto-generated method stub
		return null;
	}

	public List someauditingOrder(String addhql) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean checkemp(String orderNo, String empid) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean checkemp1(String orderNo, String empid) {
		// TODO Auto-generated method stub
		return false;
	}

	public int undercarriage(int id, String ms1, String ms2, String ms3) {
		// TODO Auto-generated method stub
		return 0;
	}


}
