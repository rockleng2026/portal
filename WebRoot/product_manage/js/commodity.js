//showDictAttribute(this.name,1){}
/**
	*页面中设置了10个层次，如果类目超过10则此功能暂不能满足
	*@param gdid 当前类目的ID
	*@param sid  当前层次的类目序列ID
	*@param level 类目的层次
	*/
function build_dict_li(gdid,sid,level,dir){
//alert(gdid+"---"+sid+"---"+level+"---"+dir);
	//选中后的样式处理
	var num = $("#p_level"+level).val();//第level层集合的大小
	//alert(1111);
	//alert(num);
	var position = $("#p_position"+level).val();//第level层li的位置  (1第一列 2第二列 3第三列)
	//alert("position="+position);
	if(position == 1){//点击的是第一列
		if(level == 1){//第一层 无变化 
			position = 1;
			var temp ="<input type='hidden' id='p_level"+(level+2)+"' value='0'/><input type='hidden' id='p_position"+(level+2)+"' value='0'/>";
			$("#li_"+(level+2)).html(temp);//第三个的li内容初始化
			//alert(123);
		}else{//否则 第一列换成第二列 上一层li并成为第一列 原本第三列的li隐藏并设置position为0 
			position = 2;//将自己的位置变更为第二列
			$("#p_position"+(level-1)).val(1);//将上一层的position参数设置为1 
			$("#li_"+(level-1)).show();//将上一层显示出来
			$("#li_"+(level+2)).hide();//将上一层显示出来
		}
	}else if(position == 2){//点击的是第二列
		position = 2;
	}else if(position == 3){//点击的是第三列 后面分情况处理
		
	}
	
	//alert("num="+num);
	for(i=0;i<num;i++){
		$("#li_"+level+"_"+i).removeClass("fa_yes");
	}
	$("#li_"+level+"_"+sid).addClass("fa_yes");//innerli_4
	var url = dir+"/pdm/getSonDictsproductManager.do";
	//请求服务器得到新的集合  d1=集合的大小 d2=集合数据 id code name 是否有子类(0 1)
	//alert(url);
	$.post(url,{'gdid':gdid},function(data){
	         //alert(data);
    		if(data == ""){
    			if(position == 3){
    				var temp ="<input type='hidden' id='p_level"+(level+1)+"' value='0'/><input type='hidden' id='p_position"+(level+1)+"' value='0'/>"; 
    				$("#li_"+(level+1)).html(temp);//初始化内容
    				$("#li_"+(level+1)).hide();//隐藏
    			}else if(position == 2){
    				var temp = "无子类";
    				temp +="<input type='hidden' id='p_level"+(level+1)+"' value='0'/><input type='hidden' id='p_position"+(level+1)+"' value='3'/>"; 
    				//alert(temp);
    				$("#li_"+(level+1)).html(temp);
    			}else if(position == 1){
    				var temp = "无子类";
    				temp +="<input type='hidden' id='p_level"+(level+1)+"' value='0'/><input type='hidden' id='p_position"+(level+1)+"' value='2'/>"; 
    				$("#li_"+(level+1)).html(temp);
    				$("#li_"+(level+2)).html("<input type='hidden' id='p_level"+(level+2)+"' value='0'/><input type='hidden' id='p_position"+(level+2)+"' value='3'/>");//第三列的内容设置为初始化
    			}
    			return;
    		}else if(data == 0){
    			alert("传入值非法!");
    			return ;
    		}else{
    			var values=data.split(";");
    			//value[0]=集合的大小
    			var newlength = values[0];//第level+1层的集合的大小
    			//alert(newlength);
    			//value[1]=集合数据
    			var strs = values[1].split(",");
    			//alert(values[1]);
    			//组合下一层字符串 有数据 下一层的position一定是3
    			if(position ==1){
					var str  = "<input type='hidden' id='p_level"+(level+1)+"' value='"+newlength+"'/><input type='hidden' id='p_position"+(level+1)+"' value='2'/><ul class='fa_lei_li'>";	    				
    			}else{
    				$("#p_position"+(level-2)).val(0);//将第一列的position赋值为0 隐藏时的默认值
    				$("#p_position"+(level-1)).val(1);//将第一列的position赋值为0 隐藏时的默认值
    				$("#p_position"+level).val(2);//将第一列的position赋值为0 隐藏时的默认值
    				$("#li_"+(level-2)).hide();
    				var str  = "<input type='hidden' id='p_level"+(level+1)+"' value='"+newlength+"'/><input type='hidden' id='p_position"+(level+1)+"' value='3'/><ul class='fa_lei_li'>";
    			}
				//alert("str="+str);							
				for(i=0;i<strs.length;i++){
					var ss = strs[i].split("*")
					var newgdid = ss[0];
					var newgdname = ss[1];
					var gdchild = ss[2];
					var serial = ss[3];
					var ff="";
					if( gdchild != null &&gdchild == '1'){//有子类
						ff="<span onclick='shownext("+newgdid+","+serial+","+(level+1)+")' title='点击显示下一类目'>>></span>"
					}
					//<a href="javascript:void(0);" id="${goods.gdId}" onclick="showpp2(this.name,${status.index },1)" name="${goods.gdId}"  ondblclick="f2(this.name,1})">${goods.gdnames }<c:if test="${goods.gdSchilds == 1}"><span>>></span></c:if></a>
					str +="<li id='li_"+(level+1)+"_"+serial+"'><a href='javascript:void(0);' id='"+newgdid+"' name='"+newgdid+"' ondblclick='showDictAttribute(this.name,"+serial+","+(level+1)+",1,\""+newgdname+"\")'>"+newgdname+"</a>"+ff+"</li>";
				}
				str += "</ul>";
			    //alert(str);
			    //只显示3层
			    $("#li_"+(level+1)).html(str);////输出下一层数据
			    $("#li_"+(level+1)).show();////显示
			}
		});
}
var tag_i=[];
var tag_s=[];
var tag_c=[];
var tag_r=[];//i-input s-select c-checkbox r-radio
var label_i=[];
var label_s=[];
var label_c=[];
var label_r=[];

/**
	*
	*@param gdid 当前类目的ID
	*@param sid  当前层次的类目序列ID
	*@param level 类目的层次
	*@param flag 默认1
	*@dir 根路径
	*/
function build_attr_and_spec2(gdid,sid,level,flag,dir){
	//alert("build_attr_and_spec2");
	//build_dict_li(gdid,sid,level,dir){
	//样式处理
	var num = $("#p_level"+level).val();//第level层集合的大小
	//alert("num="+num);
	for(i=0;i<num;i++){
		$("#li_"+level+"_"+i).removeClass("fa_yes");
	}
	$("#li_"+level+"_"+sid).addClass("fa_yes");//innerli_4
	
	//处理数据
	 var url =dir+"/pdm/getDictAtrrproductManager.do";
	    $.post(url,{'gdid':gdid,'flags':flag},function(data){
	    	//alert(data);
	    	if(data == ""){//没有类目属性
				//do nothing
				alert("无类目属性");
				$("#dict_attr").html("无类目属性");
				return;
			}else if(data == "0"){//参数错误
				//
				alert("参数错误，请刷新后再试!");
				return;
			}else{//正式分割数据
				//alert("str="+data);
				//alert(22);
				var str = data.split("@");
				var html_attr_str = str[0];//最后组合生成的属性_字符串
				var html_spec_str = str[1];//最后组合生成的规格_字符串
				var cfgstr = str[2];
				var first_spect_str = str[3];
				var second_spect_str = str[4];
				//$("#txtarea").text(html_attr_str);//测试用
				$("#specarea").text(html_spec_str);//测试用
				$("#dict_attr").html(html_attr_str);
				$("#dict_spec").html(html_spec_str);
				$("#cfg_str").val(cfgstr);
				
				if(first_spect_str == "无"){
					//$("#first_spect_str").val("");
					//$("#second_spect_str").val("");
					
				}else if( first_spect_str == "无"){
					$("#first_spec_str").val(first_spect_str);
					$("#second_spec_str").val("");
				}else{
					$("#first_spec_str").val(first_spect_str);
					$("#second_spec_str").val(second_spect_str);
				}
				
				recheboxload();
			}
	    });
}
/**
*根据ID去得到类目属性并组合div
*@param gdid ---good_dict 类目id
*/
function build_attr_and_spec(gdid,flag,dir){
	tag_i=[];
	tag_s=[];
	tag_c=[];
	tag_r=[];//i-input s-select c-checkbox r-radio
    //alert("build_attr_and_spec");
    var path = dir;
    //alert(path);
    //alert(gdid);
    var url =path+"/pdm/getDictAtrrproductManager.do";
    $.post(url,{'gdid':gdid,'flags':flag},function(data){
		//alert(data);
		var html_attr_str = "";//最后组合生成的属性_字符串
		var html_spec_str = "";//最后组合生成的规格_字符串
		//2;线路环境：;请选择;1-2-3-4-5-7-;电信-网通-铁通-双线切换(电信 网通)-三线切换(电信 网通 铁通)-海外-|
		//2;带宽标准：;请选择;1-2-3-4-5-;5M及以下-6-10M-11-50M-51-100M-100M以上-|
		//2;付费方式：;请选择;1-2-3-4-;月付-季付-半年付-年付-|
		//2;省市：;请选择;1-2-3-4-5-6-7-;上海-北京-天津-重庆-安徽-珠海-德州-|
		//2;服务器结构：;请选择;1-2-3-4-5-6-7-8-;1U-2U-3U-4U-5U-6U-7U-8U-|
		//null|
		//null|     
		
		//4种模板  1文本框 2 下拉框  3多选框  4单选框
		//<dl><dt>服务器品牌：</dt><dd><input type="text" value="福奥春天系列"/><em>*请选择</em></dd></dl>
		//<dl><dt>服务器所在地：</dt><dd><select><option>北京xxxxxx</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>
		//<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>
		//<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>
		if(data == ""){//没有类目属性
			//do nothing
			//alert(1111);
			$("#dict_attr").html("无类目属性");
			return;
		}else if(data == "0"){//参数错误
			//
			alert("参数错误，请刷新后再试!");
			return;
		}else{//正式分割数据
			//
			var ge_temp = data.split("|");//第一次分割 得到ge_temp1 ge_temp2 ...ge_temp15
			//alert("ge_temp.length="+ge_temp.length);
			var specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
			for(j=0;j<ge_temp.length;j++){
				if(ge_temp[j] == null || ge_temp[j] == "" || ge_temp[j] == "null"){//如果ge_temp[i]为空则不去处理
					alert("为空不处理");
				}else{
					//alert("ge_temp["+j+"]="+ge_temp[j]);
					var str2 = ge_temp[j].split(";");//第二次分割 0 文本类型 1 标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
					//alert("str2.length="+str2.length);
					if(str2.length != 6){//去掉不规范数据
						//alert("数据不规范");
					}else{
						
						var tag =str2[0];
						
						var label = str2[1];
						var tips  = str2[2];
						var keystr  = str2[3];
						var valuestr  = str2[4];
						var specstr  = str2[5];
						
						//alert("第"+j+"轮,tag="+tag);
						//alert("第"+j+"轮,label="+label);
						//alert("第"+j+"轮,keystr="+keystr);
						//alert("第"+j+"轮,valuestr="+valuestr);
						//alert("第"+j+"轮,specstr="+specstr);
						var tagid = "";//标签的id值
						var tagname = "";//标签的name值
						if(tag == 1){//文本框
							//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
							tagid = "input"+j;
							tagname = "input"+j; 
							//这里keystr 在文本框中默认是1 不需要填入
							var str3_value = valuestr.split("-");
							var inputstr = "<dl><dt>"+label+"：</dt><dd><input type='text' id='"+tagid+"' name='"+tagname+"' value='"+ str3_value[0]+"'/><em>*"+tips+"</em></dd></dl>";
							html_attr_str +=inputstr;
							tag_i.push(j);
							label_i.push(label);
						}else if(tag ==2){//下拉框
							//var selectstr = "<dl><dt>服务器所在地：</dt><dd><select><option>北京xxxxxx</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>";
							//<dl><dt>服务器硬盘容量：</dt><dd><select><option>北京</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>
							tagid = "select"+j;
							tagname = "select"+j;
							var str3_key = keystr.split("-");//第三次分割
							var str3_value = valuestr.split("-");
							//alert(str3_key.length+"----"+str3_value.length);
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								alert("下拉框中的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							var selectstr = "<dl><dt>"+label+"：</dt><dd><select id='"+tagid+"' name='"+tagname+"'>";
							for(i=0;i<str3_key.length-1;i++){
							 selectstr += "<option value='"+str3_key[i]+"'>"+str3_value[i]+"</option>";
							}
							selectstr +="</select><em>*"+tips+"</em></dd></dl>";
							//alert("selectstr="+selectstr);
							html_attr_str +=selectstr;
							tag_s.push(j);
							label_s.push(label);
						}else if(tag ==3){//多选框
							//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
							tagid = "checkbox"+j;
							tagname = "checkbox"+j;
							
							var str3_key = keystr.split("-");//第三次分割
							var str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								alert("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							var checkboxstr = "<dl><dt>"+label+"：</dt><dd>";
							if(specstr == 0){
								for(i=0;i<str3_key.length-1;i++){
									checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"' />"+str3_value[i]+"";
								}
								checkboxstr += "<em>*"+tips+"</em></dd></dl>";
								html_attr_str +=checkboxstr;
								tag_c.push(j);
								label_c.push(label);
							}else if(specstr == 1){
								if(specnum == 0){//第一个规格属性
									for(i=0;i<str3_key.length-1;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchk(this.name)' value='"+str3_value[i]+"' />"+str3_value[i]+"";
									}
									checkboxstr += "<em>*"+tips+"</em></dd></dl>";
									specnum +=1;
									html_spec_str +=checkboxstr;
								}else if(specnum == 1){//第二个规格属性
									for(i=0;i<str3_key.length-1;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchxl(this.name)' value='"+str3_value[i]+"' />"+str3_value[i]+"";
									}
									checkboxstr += "<em>*"+tips+"</em></dd></dl>";
									specnum +=1;
									html_spec_str +=checkboxstr;
								}else if(specnum == 2){//超过2个规格属性
									alert("规格属性的数量已经达到2个，只取前2个");
								}else{//规格属性的值混乱 
									alert("规格数量标识错误");
								}
								
							}else{//规格鉴别标识错误
								alert("标识错误，无法识别出是属性还是规格,默认成属性");
								html_attr_str +=checkboxstr;
							}
							
						}else if(tag ==4){//单选框
							tagid = "radio"+j;
							tagname = "radio"+j;
							//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
							var str3_key = keystr.split("-");//第三次分割
							var str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								alert("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							var radiostr = "<dl><dt>"+label+"：</dt><dd>";
							for(i=0;i<str3_key.length-1;i++){
								radiostr +="<input type='radio' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"'/>"+str3_value[i]+"";
							}
							radiostr +="<em>*"+tips+"</em></dd></dl>";
							html_attr_str += radiostr;
							tag_r.push(j);
							label_r.push(label);
						}else{
							alert("文本类型标识解析错误，参数无法判断是哪种标签");
						}
					}
				}
			}
		}
		//alert(html_attr_str);
		//alert(html_spec_str);
		$("#txtarea").text(html_attr_str);
		$("#dict_attr").html(html_attr_str);
		$("#dict_spec").html(html_spec_str);
		
		//build_tag_str();
		
		
	});
	return ;
}
/**
*修改初始化属性和规格
*根据ID去得到类目属性并组合div
*@param gdid ---good_dict 类目id
*/
function build_attr_and_spec_modify_init(gdid,flag,dir,attrstr){
	tag_i=[];
	tag_s=[];
	tag_c=[];
	tag_r=[];//i-input s-select c-checkbox r-radio
	//1|0|IP地址|一个免费IP1;1|2|网卡|双千兆网卡;1|11|IP地址|5350元/月
	//@
	//2|3|服务器所在地|8;2|4|服务器支出CPU个数|9;2|5|服务器所在地|10;2|6|服务器支出CPU个数|7;2|7|服务器CPU类型|7;2|8|服务器硬盘类型|6;2|10|服务器硬盘容量|5;2|12|服务器内存大小|7;2|13|付费方式|5
	//@
	//无
	//@
	//无
	if(attrstr == ""){
		alert("此商品的属性为空,直接读取类目属性");
		build_attr_and_spec(gdid,flag,dir);
		return;
	}else{
		var attr1 = attrstr.split("@");//第一次分割
		if(attr1.length != 4){
			alert("此商品的属性字符串无法识别,直接读取类目属性");
			build_attr_and_spec(gdid,flag,dir);
			return;
		}
		if(attr1[0] == "无"){//无文本属性
			alert("无文本属性");
		}else{
			var inputstr = attr1[0].split(";");//第二次分割 解析文本框属性
			for(i=0;i<inputstr.length;i++){
				var tagstr = inputstr[i];//1|0|IP地址|一个免费IP1
				if(tagstr.length !=4){
					alert("该属性中的文本属性字符串格式不匹配");
					continue;//下面的不执行，继续循环
				}
				var serial = tagstr[0];//序号
				var tag = tagstr[1]//标签类型 这个可以不去匹配，第一个是文本标签
				var label = tagstr[2]//label
				var value = tagstr[3]//文本框的值                 
			}
		}
		
	}
	
	
	
    //alert("build_attr_and_spec_modify_init");
    var path = dir;
    ////alert(path);
    //alert(gdid);
    var url =path+"/pdm/getDictAtrrproductManager.do";
    $.post(url,{'gdid':gdid,'flags':flag},function(data){
		//alert(data);
		var html_attr_str = "";//最后组合生成的属性_字符串
		var html_spec_str = "";//最后组合生成的规格_字符串
		//2;线路环境：;请选择;1-2-3-4-5-7-;电信-网通-铁通-双线切换(电信 网通)-三线切换(电信 网通 铁通)-海外-|
		//2;带宽标准：;请选择;1-2-3-4-5-;5M及以下-6-10M-11-50M-51-100M-100M以上-|
		//2;付费方式：;请选择;1-2-3-4-;月付-季付-半年付-年付-|
		//2;省市：;请选择;1-2-3-4-5-6-7-;上海-北京-天津-重庆-安徽-珠海-德州-|
		//2;服务器结构：;请选择;1-2-3-4-5-6-7-8-;1U-2U-3U-4U-5U-6U-7U-8U-|
		//null|
		//null|     
		
		//4种模板  1文本框 2 下拉框  3多选框  4单选框
		//<dl><dt>服务器品牌：</dt><dd><input type="text" value="福奥春天系列"/><em>*请选择</em></dd></dl>
		//<dl><dt>服务器所在地：</dt><dd><select><option>北京xxxxxx</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>
		//<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>
		//<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>
		if(data == ""){//没有类目属性
			//do nothing
			//alert(1111);
			$("#dict_attr").html("无类目属性");
			return;
		}else if(data == "0"){//参数错误
			//
			alert("参数错误，请刷新后再试!");
			return;
		}else{//正式分割数据
			//
			var ge_temp = data.split("|");//第一次分割 得到ge_temp1 ge_temp2 ...ge_temp15
			//alert("ge_temp.length="+ge_temp.length);
			var specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
			for(j=0;j<ge_temp.length;j++){
				if(ge_temp[j] == null || ge_temp[j] == "" || ge_temp[j] == "null"){//如果ge_temp[i]为空则不去处理
					alert("为空不处理");
				}else{
					//alert("ge_temp["+j+"]="+ge_temp[j]);
					var str2 = ge_temp[j].split(";");//第二次分割 0 文本类型 1 标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
					//alert("str2.length="+str2.length);
					if(str2.length != 6){//去掉不规范数据
						//alert("数据不规范");
					}else{
						
						var tag =str2[0];
						
						var label = str2[1];
						var tips  = str2[2];
						var keystr  = str2[3];
						var valuestr  = str2[4];
						var specstr  = str2[5];
						
						//alert("第"+j+"轮,tag="+tag);
						//alert("第"+j+"轮,label="+label);
						//alert("第"+j+"轮,keystr="+keystr);
						//alert("第"+j+"轮,valuestr="+valuestr);
						//alert("第"+j+"轮,specstr="+specstr);
						var tagid = "";//标签的id值
						var tagname = "";//标签的name值
						if(tag == 1){//文本框
							//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
							tagid = "input"+j;
							tagname = "input"+j; 
							//这里keystr 在文本框中默认是1 不需要填入
							var str3_value = valuestr.split("-");
							var inputstr = "<dl><dt>"+label+"：</dt><dd><input type='text' id='"+tagid+"' name='"+tagname+"' value='"+ str3_value[0]+"'/><em>*"+tips+"</em></dd></dl>";
							html_attr_str +=inputstr;
							tag_i.push(j);
							label_i.push(label);
						}else if(tag ==2){//下拉框
							//var selectstr = "<dl><dt>服务器所在地：</dt><dd><select><option>北京xxxxxx</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>";
							//<dl><dt>服务器硬盘容量：</dt><dd><select><option>北京</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>
							tagid = "select"+j;
							tagname = "select"+j;
							var str3_key = keystr.split("-");//第三次分割
							var str3_value = valuestr.split("-");
							//alert(str3_key.length+"----"+str3_value.length);
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								alert("下拉框中的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							var selectstr = "<dl><dt>"+label+"：</dt><dd><select id='"+tagid+"' name='"+tagname+"'>";
							for(i=0;i<str3_key.length-1;i++){
							 selectstr += "<option value='"+str3_key[i]+"'>"+str3_value[i]+"</option>";
							}
							selectstr +="</select><em>*"+tips+"</em></dd></dl>";
							//alert("selectstr="+selectstr);
							html_attr_str +=selectstr;
							tag_s.push(j);
							label_s.push(label);
						}else if(tag ==3){//多选框
							//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
							tagid = "checkbox"+j;
							tagname = "checkbox"+j;
							
							var str3_key = keystr.split("-");//第三次分割
							var str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								alert("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							var checkboxstr = "<dl><dt>"+label+"：</dt><dd>";
							if(specstr == 0){
								for(i=0;i<str3_key.length-1;i++){
									checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"' />"+str3_value[i]+"";
								}
								checkboxstr += "<em>*"+tips+"</em></dd></dl>";
								html_attr_str +=checkboxstr;
								tag_c.push(j);
								label_c.push(label);
							}else if(specstr == 1){
								if(specnum == 0){//第一个规格属性
									for(i=0;i<str3_key.length-1;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchk(this.name)' value='"+str3_value[i]+"' />"+str3_value[i]+"";
									}
									checkboxstr += "<em>*"+tips+"</em></dd></dl>";
									specnum +=1;
									html_spec_str +=checkboxstr;
								}else if(specnum == 1){//第二个规格属性
									for(i=0;i<str3_key.length-1;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchxl(this.name)' value='"+str3_value[i]+"' />"+str3_value[i]+"";
									}
									checkboxstr += "<em>*"+tips+"</em></dd></dl>";
									specnum +=1;
									html_spec_str +=checkboxstr;
								}else if(specnum == 2){//超过2个规格属性
									alert("规格属性的数量已经达到2个，只取前2个");
								}else{//规格属性的值混乱 
									alert("规格数量标识错误");
								}
								
							}else{//规格鉴别标识错误
								alert("标识错误，无法识别出是属性还是规格,默认成属性");
								html_attr_str +=checkboxstr;
							}
							
						}else if(tag ==4){//单选框
							tagid = "radio"+j;
							tagname = "radio"+j;
							//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
							var str3_key = keystr.split("-");//第三次分割
							var str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								alert("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							var radiostr = "<dl><dt>"+label+"：</dt><dd>";
							for(i=0;i<str3_key.length-1;i++){
								radiostr +="<input type='radio' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"'/>"+str3_value[i]+"";
							}
							radiostr +="<em>*"+tips+"</em></dd></dl>";
							html_attr_str += radiostr;
							tag_r.push(j);
							label_r.push(label);
						}else{
							alert("文本类型标识解析错误，参数无法判断是哪种标签");
						}
					}
				}
			}
		}
		//alert(html_attr_str);
		//alert(html_spec_str);
		$("#txtarea").text(html_attr_str);
		$("#dict_attr").html(html_attr_str);
		$("#dict_spec").html(html_spec_str);
		
		//build_tag_str();
		
		
	});
	return ;
}

function build_tag_str(){
	//alert("build_tag_str");
	//alert(tag_i.length);
	//alert(tag_s.length);
	//alert(tag_c.length);
	//alert(tag_r.length);
	var i_str = "";
	var s_str = "";
	var c_str = "";
	var r_str = "";
	for(i=0;i<tag_i.length;i++){
		i_str += i+",";
	}
	for(i=0;i<tag_s.length;i++){
		s_str += i+",";
	}
	for(i=0;i<tag_c.length;i++){
		c_str += i+",";
	}
	for(i=0;i<tag_r.length;i++){
		r_str += i+",";
	}
	//alert(s_str);
	$("#i_str").val(i_str);
	$("#s_str").val(s_str);
	$("#c_str").val(c_str);
	$("#r_str").val(r_str);
	
	
}