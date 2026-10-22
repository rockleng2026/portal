package test;

import java.util.UUID;

public class StringUtil {

	//private static Log logger = LogFactory.getLog(StringUtil.class);

	//国标码和区位码转换常量

	
	static final int GB_SP_DEFF = 160;

	//存放国标一级汉字不同读音的起始区位码


		static final int[] secPosvalueList = {
			1601, 1637, 1833, 2078, 2274, 2302, 2433, 2594, 2787,

			3106, 3212, 3472, 3635, 3722, 3730, 3858, 4027, 4086,

			4390, 4558, 4684, 4925, 5249, 5600
		};

	//存放国标一级汉字不同读音的起始区位码对应读音

	static final char[] firstLetter = {

	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j',

	'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',

    't', 'w', 'x', 'y', 'z'};

	//获取一个字符串的拼音码

	public static String getFirstLetter(String oriStr) {

	String str = oriStr.toLowerCase();

	StringBuffer buffer = new StringBuffer();

	char ch;

	char[] temp;

	for (int i = 0; i < str.length(); i++) { //依次处理str中每个字符

	ch = str.charAt(i);

	temp = new char[] {ch};

	byte[] uniCode = new String(temp).getBytes(); 
	if (uniCode[0] < 128 && uniCode[0] > 0) { // 非汉字
		buffer.append("123");
		} else {

		buffer.append(convert(uniCode));

		}

		}

		return buffer.toString();
}

		/** 获取一个汉字的拼音首字母。

		　* GB码两个字节分别减去160，转换成10进制码组合就可以得到区位码

		　　* 例如汉字“你”的GB码是0xC4/0xE3，分别减去0xA0（160）就是0x24/0x43

		　　* 0x24转成10进制就是36，0x43是67，那么它的区位码就是3667，在对照表中读音为‘n’

		　　*/
	static char convert(byte[] bytes) {
		
		char result = '-';
		
		int secPosValue = 0;
		
		int i;
		
		for( i =0; i < bytes.length; i++) {
			
			bytes[i] -= GB_SP_DEFF;
		}
		
		secPosValue = bytes[0] * 100 + bytes[1];
		
		for ( i = 0; i<23; i++) {
			
			if(secPosValue >= secPosvalueList[i] && secPosValue <secPosvalueList[i+1]) {
				
				result = firstLetter[i];
				
				break;
			}
		}
		return result;
	}
	
	public static int getSubNum(String a, String b)
	{  
		int num = 0; 
		String str = a; 
		int index = a.indexOf(b); 
		while (index != -1) 
		{   
			num++;  
			str = str.substring(index + b.length() - 1);   
			index = str.indexOf(b); 
		} 
		return num; 
	}
	
	public static  int getStringNum(String sA,String sB,int num){ 
		int weizhi = 0; 
		for (int i = 1; i < num; i++) { 
		if (weizhi == 0) { 
		weizhi = sA.toString().indexOf(sB); 
		} 
		// System.out.println(sB+" 在"+sA+" 中第"+i+"次出现的位置"+(weizhi+1)); 
		weizhi = sA.indexOf(sB, weizhi+1); 
		} 
		return weizhi+1; 
		}


	
	public static void main(String[] args) {
//		System.out.println(StringUtil.getFirstLetter("我爱北京天安门"));
//		int a[]={1,3,2};
//		int max=0;
//		int tmp=0;
//		for(int i=0;i<a.length;i++){
//			max=a[i];
//			for(int j=i+1;j<a.length-i;j++){
//				if(max<a[j]){
//					max=a[j];
//					tmp=a[i];
//					a[i]=max;
//					a[j]=tmp;
//				}
//			}
//		}
//		for(int i=0;i<a.length;i++){
//			System.out.println(a[i]);
//		}
		UUID  uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
	}
}


