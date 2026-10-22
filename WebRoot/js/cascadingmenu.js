
function DsyNational() 
{ 
this.ItemsNational = {}; 
} 

DsyNational.prototype.add = function(id,iArray) 
{ 
this.ItemsNational[id] = iArray; 
} 
DsyNational.prototype.Exists = function(id) 
{ 
if(typeof(this.ItemsNational[id]) == "undefined") return false; 
return true; 
}

function changeNational(v){ 
var str="0"; 
for(i=0;i<v;i++){ str+=("_"+(document.getElementById(national[i]).selectedIndex-1));}; 
var ss=document.getElementById(national[v]); 
with(ss){ 
length = 0; 
options[0]=new Option(optNational[v],optNational[v]); 
if(v && document.getElementById(national[v-1]).selectedIndex>0 || !v) 
{ 
   if(dsyNational.Exists(str)){ 
    ar = dsyNational.ItemsNational[str]; 
    for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]); 
    if(v)options[1].selected = true; 
   } 
} 
if(++v<national.length){changeNational(v);} 
} 
}

var dsyNational = new DsyNational();

dsyNational.add("0",["中国","韩国","日本","新加坡","马来西亚","菲律宾","沙特阿拉伯","朝鲜","越南","缅甸","德国","英国","法国","爱尔兰","波兰","西班牙","意大利","俄罗斯","荷兰","美国","加拿大","巴西","阿根廷","新西兰","澳大利亚","印度","埃及"]);

dsyNational.add("0_0",["安徽","北京","福建","甘肃","广东","广西","贵州","海南","河北","河南","黑龙江","湖北","湖南","吉林","江苏","江西","辽宁","内蒙古","宁夏","青海","山东","山西","陕西","上海","四川","天津","西藏","新疆","云南","浙江","重庆"]);

dsyNational.add("0_0_0",["安庆","蚌埠","巢湖","池州","滁州","阜阳","合肥","淮北","淮南","黄山","六安","马鞍山","宿州","铜陵","芜湖","宣城","亳州"]); 
dsyNational.add("0_0_1",["北京"]); 
dsyNational.add("0_0_2",["福州","龙岩","南平","宁德","莆田","泉州","三明","厦门","漳州"]); 
dsyNational.add("0_0_3",["白银","定西","甘南藏族自治州","嘉峪关","金昌","酒泉","兰州","临夏回族自治州","陇南","平凉","庆阳","天水","武威","张掖"]); 
dsyNational.add("0_0_4",["潮州","东莞","佛山","广州","河源","惠州","江门","揭阳","茂名","梅州","清远","汕头","汕尾","韶关","深圳","阳江","云浮","湛江","肇庆","中山","珠海"]); 
dsyNational.add("0_0_5",["百色","北海","崇左","防城港","桂林","贵港","河池","贺州","来宾","柳州","南宁","钦州","梧州","玉林"]); 
dsyNational.add("0_0_6",["安顺","毕节","贵阳","六盘水","黔东南苗族侗族自治州","黔南布依族苗族自治州","黔西南布依族苗族自治州","铜仁","遵义"]); 
dsyNational.add("0_0_7",["白沙黎族自治县","保亭黎族苗族自治县","昌江黎族自治县","澄迈县","定安县","东方","海口","乐东黎族自治县","临高县","陵水黎族自治县","琼海","琼中黎族苗族自治县","三亚","屯昌县","万宁","文昌","五指山","儋州"]); 
dsyNational.add("0_0_8",["保定","沧州","承德","邯郸","衡水","廊坊","秦皇岛","石家庄","唐山","邢台","张家口"]); 
dsyNational.add("0_0_9",["安阳","鹤壁","济源","焦作","开封","洛阳","南阳","平顶山","三门峡","商丘","新乡","信阳","许昌","郑州","周口","驻马店","漯河","濮阳"]); 
dsyNational.add("0_0_10",["大庆","大兴安岭","哈尔滨","鹤岗","黑河","鸡西","佳木斯","牡丹江","七台河","齐齐哈尔","双鸭山","绥化","伊春"]); 
dsyNational.add("0_0_11",["鄂州","恩施土家族苗族自治州","黄冈","黄石","荆门","荆州","潜江","神农架林区","十堰","随州","天门","武汉","仙桃","咸宁","襄樊","孝感","宜昌"]); 
dsyNational.add("0_0_12",["常德","长沙","郴州","衡阳","怀化","娄底","邵阳","湘潭","湘西土家族苗族自治州","益阳","永州","岳阳","张家界","株洲"]); 
dsyNational.add("0_0_13",["白城","白山","长春","吉林","辽源","四平","松原","通化","延边朝鲜族自治州"]); 
dsyNational.add("0_0_14",["常州","淮安","连云港","南京","南通","苏州","宿迁","泰州","无锡","徐州","盐城","扬州","镇江"]); 
dsyNational.add("0_0_15",["抚州","赣州","吉安","景德镇","九江","南昌","萍乡","上饶","新余","宜春","鹰潭"]); 
dsyNational.add("0_0_16",["鞍山","本溪","朝阳","大连","丹东","抚顺","阜新","葫芦岛","锦州","辽阳","盘锦","沈阳","铁岭","营口"]); 
dsyNational.add("0_0_17",["阿拉善盟","巴彦淖尔盟","包头","赤峰","鄂尔多斯","呼和浩特","呼伦贝尔","通辽","乌海","乌兰察布盟","锡林郭勒盟","兴安盟"]); 
dsyNational.add("0_0_18",["固原","石嘴山","吴忠","银川"]); 
dsyNational.add("0_0_19",["果洛藏族自治州","海北藏族自治州","海东","海南藏族自治州","海西蒙古族藏族自治州","黄南藏族自治州","西宁","玉树藏族自治州"]); 
dsyNational.add("0_0_20",["滨州","德州","东营","菏泽","济南","济宁","莱芜","聊城","临沂","青岛","日照","泰安","威海","潍坊","烟台","枣庄","淄博"]); 
dsyNational.add("0_0_21",["长治","大同","晋城","晋中","临汾","吕梁","朔州","太原","忻州","阳泉","运城"]); 
dsyNational.add("0_0_22",["安康","宝鸡","汉中","商洛","铜川","渭南","西安","咸阳","延安","榆林"]); 
dsyNational.add("0_0_23",["上海"]); 
dsyNational.add("0_0_24",["阿坝藏族羌族自治州","巴中","成都","达州","德阳","甘孜藏族自治州","广安","广元","乐山","凉山彝族自治州","眉山","绵阳","南充","内江","攀枝花","遂宁","雅安","宜宾","资阳","自贡","泸州"]); 
dsyNational.add("0_0_25",["天津"]); 
dsyNational.add("0_0_26",["阿里","昌都","拉萨","林芝","那曲","日喀则","山南"]); 
dsyNational.add("0_0_27",["阿克苏","阿拉尔","巴音郭楞蒙古自治州","博尔塔拉蒙古自治州","昌吉回族自治州","哈密","和田","喀什","克拉玛依","克孜勒苏柯尔克孜自治州","石河子","图木舒克","吐鲁番","乌鲁木齐","五家渠","伊犁哈萨克自治州"]); 
dsyNational.add("0_0_28",["保山","楚雄彝族自治州","大理白族自治州","德宏傣族景颇族自治州","迪庆藏族自治州","红河哈尼族彝族自治州","昆明","丽江","临沧","怒江傈傈族自治州","曲靖","思茅","文山壮族苗族自治州","西双版纳傣族自治州","玉溪","昭通"]); 
dsyNational.add("0_0_29",["杭州","湖州","嘉兴","金华","丽水","宁波","绍兴","台州","温州","舟山","衢州"]); 
dsyNational.add("0_0_30",["重庆"]);


dsyNational.add("0_1",["汉城特別市","釜山广域市","大邱广域市","仁川广域市","光州广域市","大田广域市","蔚山广域市","京畿道","江原道","忠清北道","忠清南道","全罗北道","全罗南道","庆尚北道","庆尚南道","济州道"]); 
dsyNational.add("0_1_0",["汉城"]); 
dsyNational.add("0_1_1",["釜山","机张郡"]); 
dsyNational.add("0_1_2",["大邱","达城郡"]); 
dsyNational.add("0_1_3",["仁川","江华郡","瓮津郡"]); 
dsyNational.add("0_1_4",["光州"]); 
dsyNational.add("0_1_5",["大田"]); 
dsyNational.add("0_1_6",["蔚山","蔚州郡"]); 
dsyNational.add("0_1_7",["水原市","城南市","安山市","高阳市","安养市","富川市"]); 
dsyNational.add("0_1_8",["春川市","原州市","江陵市"]); 
dsyNational.add("0_1_9",["清州市"]); 
dsyNational.add("0_1_10",["天安市"]); 
dsyNational.add("0_1_11",["全州市","群山市","益山市"]); 
dsyNational.add("0_1_12",["木浦市","丽水市","顺天市"]); 
dsyNational.add("0_1_13",["浦项市","龟尾市","庆州市"]); 
dsyNational.add("0_1_14",["昌原市","马山市","晋州市"]); 
dsyNational.add("0_1_15",["济州市","西归浦市","北济州郡","南济州郡"]);


dsyNational.add("0_2",["东京都","神奈川县","大阪府","爱知县","北海道","兵库县","京都府","福冈县","神奈川县","埼玉县","广岛县","宫城县","福冈县","千叶县"]); 
dsyNational.add("0_2_0",["东京"]); 
dsyNational.add("0_2_1",["横滨市"]); 
dsyNational.add("0_2_2",["大阪市"]); 
dsyNational.add("0_2_3",["名古屋市 "]); 
dsyNational.add("0_2_4",["札幌市"]); 
dsyNational.add("0_2_5",["神戸市"]); 
dsyNational.add("0_2_6",["京都市"]); 
dsyNational.add("0_2_7",["福冈市"]); 
dsyNational.add("0_2_8",["川崎市"]); 
dsyNational.add("0_2_9",["埼玉市"]); 
dsyNational.add("0_2_10",["广岛市"]); 
dsyNational.add("0_2_11",["仙台市"]); 
dsyNational.add("0_2_12",["北九州市 "]); 
dsyNational.add("0_2_13",["千叶市"]);


dsyNational.add("0_3",["新加坡"]); 
dsyNational.add("0_3_0",["新加坡"]);


dsyNational.add("0_4",["吉打 Kedah","槟榔屿 Pulau Pinang","霹雳 Perak","吉兰丹 Kelantan","丁加奴 Terengganu","彭亨 Pahang","雪兰莪 Selangor","吉隆坡联邦直辖区 Kuala Lumpur","布特拉再也联邦直辖区 Putrajaya","森美兰 Sembilan","马六甲 Melaka","柔佛 Johor","斗湖省 Tawau","山打根省 Sandakan","西海岸省 Pantai Barat"]); 
dsyNational.add("0_4_0",["亚罗士打 Alor Setar","浮罗交怡 Langkawi","古邦巴素 Kubang Pasu","巴东得腊 Padang Terap","哥打士打 Kota Setar"]); 
dsyNational.add("0_4_1",["槟城 George Town","北区（北海） Utara (Butterworth)","中区（大山脚） Tengah (Bkt. Mertajam)","南区（高渊） Selatan (Nibong Tebal)","东北 Timur Laut"]); 
dsyNational.add("0_4_2",["怡保 Ipoh","拉律-马当 Larut & Matang","近打 Kinta","江沙 Kuala Kangsar"]); 
dsyNational.add("0_4_3",["哥打巴鲁 Kota Baharu","道北 Tumpat","哥登峇鲁 Kota Bharu","巴西马 Pasir Mas"]); 
dsyNational.add("0_4_4",["瓜拉丁加奴 Kuala Terengganu","勿述 Besut","瓜拉丁加奴 Kuala Terengganu","龙运 Dungun","甘马挽 Kemaman"]); 
dsyNational.add("0_4_5",["关丹 Kuantan","金马仑高原 Cameron Highlands","立卑 Lipis","关丹 Kuantan","而连突 Jerantut"]); 
dsyNational.add("0_4_6",["莎亚南 Shah Alam ","沙白安南 Sabak Bernam","乌鲁雪兰莪 Ulu Selangor","瓜拉雪兰莪 Kuala Selangor"]); 
dsyNational.add("0_4_7",["吉隆坡 Kuala Lumpur"]); 
dsyNational.add("0_4_8",["布特拉再也 Putrajaya"]); 
dsyNational.add("0_4_9",["芙蓉 Seremban","日叻务 Jelebu","仁保 Jempol"]); 
dsyNational.add("0_4_10",["马六甲 Melaka","亚罗牙也 Alor Gajah"]); 
dsyNational.add("0_4_11",["新山 Johor Baharu","昔加末 Segamat","丰盛港 Mersing","居銮 Keluang"]); 
dsyNational.add("0_4_12",["斗湖 Tawau","拿笃 Lahad Datu"]); 
dsyNational.add("0_4_13",["山打根 Sandakan","京那巴登岸 Kinabatangan"]); 
dsyNational.add("0_4_14",["哥打京那峇鲁（亚庇） Kota Kinabalu","兰脑 Ranau","古打毛律 Kota Belud","斗亚兰 Tuaran"]);


dsyNational.add("0_5",["伊罗戈斯 Ilocos","卡加延河谷 Cagayan","中央吕宋 Central Luzon","甲拉巴松 Calabarzon","比科尔 Bicol","西米沙鄢 Western Visayas","中米沙鄢 Central Visayas","东米沙鄢 Eastern Visayas","国家首都区 National Capital Region"]); 
dsyNational.add("0_5_0",["圣费尔南多* San Fernando"]); 
dsyNational.add("0_5_1",["土格加劳 Tuguegarao"]); 
dsyNational.add("0_5_2",["圣费尔南多* San Fernando"]); 
dsyNational.add("0_5_3",["奎松城 Quezon"]); 
dsyNational.add("0_5_4",["黎牙实比 Legaspi"]); 
dsyNational.add("0_5_5",["伊洛伊洛 Legaspi"]); 
dsyNational.add("0_5_6",["宿务 Cebu"]); 
dsyNational.add("0_5_7",["塔克洛班 Tacloban"]); 
dsyNational.add("0_5_8",["马尼拉 Manila"]);


dsyNational.add("0_6",["利雅得 Ar Riyad","麦加 Makkah","麦地那 Al Madinah","东部 Ash Sharqiyah","卡西姆 Al Qasim","哈伊勒 Ha'il","塔布克 Tabuk","北部边疆 Al Hudud ash Shamaliyah","吉赞 Jizan","纳季兰 Najran","巴哈 Al Bahah","朱夫 Al Jawf","阿西尔 ‘Asir"]); 
dsyNational.add("0_6_0",["利雅得 Riyad","海耶 Al-Kharj"]); 
dsyNational.add("0_6_1",["麦加 Makkah","吉达 Jiddah","塔伊夫 At-Ta'if"]); 
dsyNational.add("0_6_2",["麦地那 Madinah","延布 Yanbu' al-Bahr"]); 
dsyNational.add("0_6_3",["达曼 Dammam","胡富夫 Al-Hufūf","姆巴拉兹 Al-Mubarraz","朱拜勒 Al-Jubayl","哈费尔巴廷 Hafar al-Bātin"]); 
dsyNational.add("0_6_4",["布赖代 Buraydah"]); 
dsyNational.add("0_6_5",["哈伊勒 Ha'il"]); 
dsyNational.add("0_6_6",["塔布克 Tabuk"]); 
dsyNational.add("0_6_7",["阿尔阿尔 Ar'ar"]); 
dsyNational.add("0_6_8",["吉赞 Jizan"]); 
dsyNational.add("0_6_9",["纳季兰 Najran"]); 
dsyNational.add("0_6_10",["巴哈 Al Bahah"]); 
dsyNational.add("0_6_11",["塞卡卡 Sakaka"]); 
dsyNational.add("0_6_12",["艾卜哈 Abhā","海米斯穆谢特 Khamīs Mushayt"]);


dsyNational.add("0_7",["平壤直辖市","罗先直辖市","平安南道","平安北道","慈江道","两江道","咸镜北道","咸镜南道","黄海北道","黄海南道","江原道"]); 
dsyNational.add("0_7_0",["平壤"]); 
dsyNational.add("0_7_1",["罗津"]); 
dsyNational.add("0_7_2",["南浦特级市","平城市","顺川市","德川市","安州市","价川市"]); 
dsyNational.add("0_7_3",["新义州市","龟城市","定州市"]); 
dsyNational.add("0_7_4",["江界市","满浦市","煕川市"]); 
dsyNational.add("0_7_5",["恵山市"]); 
dsyNational.add("0_7_6",["清津市","金策市","会宁市"]); 
dsyNational.add("0_7_7",["咸兴市","兴南市","新浦市","端川市"]); 
dsyNational.add("0_7_8",["沙里院市","松林市","开城市"]); 
dsyNational.add("0_7_9",["海州市"]); 
dsyNational.add("0_7_10",["元山市","文川市"]);


dsyNational.add("0_8",["河内市","山罗","奠边","谅山","河西","清化","义安","广南","嘉莱","多乐","平福","金瓯"]); 
dsyNational.add("0_8_0",["河内市"]); 
dsyNational.add("0_8_1",["山罗"]); 
dsyNational.add("0_8_2",["奠边府市","孟雷"]); 
dsyNational.add("0_8_3",["谅山市"]); 
dsyNational.add("0_8_4",["河东","山西"]); 
dsyNational.add("0_8_5",["清化市","岑山","拜尚"]); 
dsyNational.add("0_8_6",["荣市","扩路"]); 
dsyNational.add("0_8_7",["三歧","会安"]); 
dsyNational.add("0_8_8",["波来古市","安溪"]); 
dsyNational.add("0_8_9",["邦美蜀市"]); 
dsyNational.add("0_8_10",["东帅"]); 
dsyNational.add("0_8_11",["金瓯市"]);


dsyNational.add("0_9",["实皆省 Sagaing","望濑县 Monywa","勃固省 Bago","马圭省 Magway","曼德勒省 Mandalay","德林达依省 Tanintharyi","伊洛瓦底省 Ayeyarwady","仰光省 Yangon","克钦邦 Kachin","克耶邦 Kayah","克伦邦 Kayin","钦邦 Chin","孟邦 Mon","若开邦 Rakhine","掸邦 Shan"]); 
dsyNational.add("0_9_0",["实皆 Sagaing"]); 
dsyNational.add("0_9_1",["望濑 Monywa"]); 
dsyNational.add("0_9_2",["勃固 Bago"]); 
dsyNational.add("0_9_3",["马圭 Magway"]); 
dsyNational.add("0_9_4",["曼德勒 Mandalay"]); 
dsyNational.add("0_9_5",["土瓦 Dawei"]); 
dsyNational.add("0_9_6",["勃生 Pathein"]); 
dsyNational.add("0_9_7",["仰光 Yangan "]); 
dsyNational.add("0_9_8",["密支那 Myitkyina"]); 
dsyNational.add("0_9_9",["垒固 Loi-kaw"]); 
dsyNational.add("0_9_10",["巴安 Pa-an"]); 
dsyNational.add("0_9_11",["哈卡 Haka"]); 
dsyNational.add("0_9_12",["毛淡棉 Mawlamyine"]); 
dsyNational.add("0_9_13",["实兑 Akyab"]); 
dsyNational.add("0_9_14",["东枝 Taunggyi"]);


dsyNational.add("0_10",["巴登-符腾堡 Baden-Württemberg","拜恩（巴伐利亚） Bayern","柏 林 Berlin","勃兰登堡 Brandenburg","不来梅 Bremen","汉 堡 Hamburg","黑 森 Hessen","梅克伦堡-前波莫瑞 Mecklenburg-Vorpommern","下萨克森 Niedersachsen","北莱茵-威斯特法伦 Nordrhein-Westfalen","莱茵兰-普法尔茨 Rheinland-Pfalz","萨 尔 Saarland","萨克森 Sachsen","萨克森-安哈特 Sachsen-Anhalt","石勒苏益格-荷尔斯泰因 Schleswig-Holstein","图林根 Thüringen"]); 
dsyNational.add("0_10_0",["斯图加特 Stuttgart","卡尔斯鲁厄 Karlsruhe","弗赖堡 Freiburg","图宾根 Tübingen"]); 
dsyNational.add("0_10_1",["慕尼黑 München ","下拜恩 Niederbayern","上普法尔茨 Oberpfalz","上弗兰肯 Oberfranken","中弗兰肯 Mittelfranken","外弗兰肯 Unterfranken","施瓦本 Schwaben"]); 
dsyNational.add("0_10_2",["柏林 Berlin"]); 
dsyNational.add("0_10_3",["波茨坦 Potsdam"]); 
dsyNational.add("0_10_4",["不来梅 Bremen"]); 
dsyNational.add("0_10_5",["汉堡 Hamburg"]); 
dsyNational.add("0_10_6",["达姆施塔特 Darmstadt","吉森 Gieben","卡塞尔 Kassel"]); 
dsyNational.add("0_10_7",["什未林 Schwerin"]); 
dsyNational.add("0_10_8",["不伦瑞克 Braunschweig","汉诺威 Hannover"]); 
dsyNational.add("0_10_9",["杜塞尔多夫 Düsseldorf","科隆 Koln","明斯特 Münster","代特莫尔特 Detmold"]); 
dsyNational.add("0_10_10",["科布伦次 Koblenz ","特里尔 Trier","莱茵黑森-普法尔茨"]); 
dsyNational.add("0_10_11",["萨尔布吕肯 Saarbrücken"]); 
dsyNational.add("0_10_12",["开姆尼斯 Chemnitz","德累斯顿 Dresden","莱比锡 Leipzig"]); 
dsyNational.add("0_10_13",["德绍 Dessau","哈雷 Halle","马格德堡 Magdeburg"]); 
dsyNational.add("0_10_14",["基尔 Kiel"]); 
dsyNational.add("0_10_15",["埃尔富特 Erfurt"]);


dsyNational.add("0_11",["英格兰 England","威尔士 Wales","苏格兰 Scotland","北爱尔兰 Northern Ireland"]); 
dsyNational.add("0_11_0",["坎布里亚 Cumbria","兰开夏 Lancashire ","布莱克本 Blackburn with Darwen","大曼彻斯特 Greater Manchester","柴郡 Cheshire ","诺森伯兰 Northumberland","达勒姆 Durham","北约克郡 North Yorkshire","约克郡东区 East Riding of Yorkshire","西约克郡 West Yorkshire","南约克郡 South Yorkshire","林肯郡 Lincolnshire","诺丁汉郡 Nottinghamshire","斯塔福德郡 Staffordshire","诺福克 Norfolk","伦敦 London","白金汉郡 Buckinghamshire","牛津郡 Oxfordshire","格洛斯特郡 Gloucestershire"]); 
dsyNational.add("0_11_1",["康威 Conwy *","圭内斯 Gwynedd","锡尔迪金 Ceredigion","波伊斯 Powys","彭布罗克郡 Pembrokeshire","卡马森郡 Carmarthenshire"]); 
dsyNational.add("0_11_2",["苏格兰高地 Highland","马里 Moray","阿伯丁郡 Aberdeenshire","安格斯 Angus","珀斯-金罗斯 Perth and Kinross","法夫 Fife","斯特灵 Stirling","阿盖尔-比特 Argyll and Bute","苏格兰边界 Scottish Borders","邓弗里斯-加洛韦 Dumfries and Galloway"]); 
dsyNational.add("0_11_3",["阿兹 Ards","卡斯尔雷 Castlereagh","唐 Down","贝尔法斯特 Belfast, City of","利斯本 Lisburn","巴利米纳 Ballymena","莫伊尔 Moyle","阿马 Armagh"]);


dsyNational.add("0_12",["法兰西岛 Ile-de-France","香槟-阿登 Champagne-Ardenne","皮卡第 Picardie","上诺曼底 Haute-Normandie","中央 Centre","下诺曼底 Basse-Normandie","勃艮第 Bourgogne","北部-加莱海峡 Nord-pas-de-Calais","洛林 Lorraine","阿尔萨斯 Alsace","弗朗什孔泰 Franche-Comté","卢瓦尔河地区 Pays de la Loire","布列塔尼 Bretagne","普瓦图-夏朗德 Poitou-Charentes","阿基坦 Aquitaine","南部-比利牛斯 Midi-Pyrénées","利穆赞 Limousin","罗讷-阿尔卑斯 Rhone-Alpes","奥弗涅 Auvergne","朗格多克-鲁西永 Languedoc-Roussillon","普罗旺斯-阿尔卑斯-蓝色海岸 Provence-Alpes-Cote d'Azur","科西嘉 Corse"]); 
dsyNational.add("0_12_0",["巴黎 Paris"]); 
dsyNational.add("0_12_1",["兰斯 Reims"]); 
dsyNational.add("0_12_2",["亚眠 Ameiens"]); 
dsyNational.add("0_12_3",["鲁昂 Rouen"]); 
dsyNational.add("0_12_4",["奥尔良 Orléans"]); 
dsyNational.add("0_12_5",["卡昂 Caen"]); 
dsyNational.add("0_12_6",["第戎 Dijon"]); 
dsyNational.add("0_12_7",["里尔 Lille"]); 
dsyNational.add("0_12_8",["南锡 Nancy"]); 
dsyNational.add("0_12_9",["斯特拉斯堡 Strasbourg"]); 
dsyNational.add("0_12_10",["贝桑松 Besancon"]); 
dsyNational.add("0_12_11",["南特 Nantes"]); 
dsyNational.add("0_12_12",["雷恩 Rennes"]); 
dsyNational.add("0_12_13",["普瓦捷 Poitiers"]); 
dsyNational.add("0_12_14",["波尔多 Bordeaux"]); 
dsyNational.add("0_12_15",["图卢兹 Toulouse"]); 
dsyNational.add("0_12_16",["利摩日 Limoges"]); 
dsyNational.add("0_12_17",["里昂 Lyon"]); 
dsyNational.add("0_12_18",["克莱蒙费朗 Clerment-Ferrand"]); 
dsyNational.add("0_12_19",["蒙彼里埃 Montpellier"]); 
dsyNational.add("0_12_20",["马赛 Marseille"]); 
dsyNational.add("0_12_21",["阿雅克肖 Ajaccio"]);


dsyNational.add("0_13",["穆斯特省 Munster","康诺特省 Connacht","伦斯特省 Leinster","阿尔斯特省 Ulster"]); 
dsyNational.add("0_13_0",["科克 Cork","沃特福德 Waterford","利默里克 Limerick","凯里 Kerry","蒂珀雷里 Tipperary","克莱尔 Clare"]); 
dsyNational.add("0_13_1",["戈尔韦 Galway","梅奥 Mayo","罗斯康芒 Roscommon","利特里姆 Leitrim","斯莱戈 Sligo"]); 
dsyNational.add("0_13_2",["都柏林 Dublin","基尔代尔 Kildare","米斯 Meath","威克洛 Wicklow","西米斯 Westmeath","卡范 Cavan","朗福德 Longford","奥法利 Offaly","崂斯 Laoighis","卡洛 Carlow","基尔肯尼 Kilkenny","韦克斯福德 Wexford"]); 
dsyNational.add("0_13_3",["劳斯 Louth","多内加尔 Donegal","莫内根 Monaghan","阿马 Armagh","安特里姆 Antrim","德里 Derry","唐 Down","泰隆 Tyrone","弗马纳 Fermanagh"]);


dsyNational.add("0_14",["下西里西亚 Dolnoslaskie","库亚瓦滨海 Kujawsko-Pomorskie","罗兹 Lódzkie ","卢布林 Lubelskie","鲁布斯卡 Lubuskie","小波兰 Malopolskie","马佐夫舍 Mazowieckie","奥波莱 Opolskie","喀尔巴阡山 Podkarpackie","波德拉斯 Podlaskie","滨海 Pomorskie","西里西亚 Slaskie","圣十字 Swietokrzyskie","瓦尔米亚马祖尔 Warmińsko-Mazurskie","大波兰 Wielkopolskie","西滨海 Zachodniopomorskie"]); 
dsyNational.add("0_14_0",["弗罗茨瓦夫","耶莱尼亚古拉","瓦乌布日赫","莱格尼察"]); 
dsyNational.add("0_14_1",["比得哥什","托伦","格鲁琼兹","弗沃茨瓦韦克"]); 
dsyNational.add("0_14_2",["罗兹","彼得库夫","斯凯尔涅维采","谢拉兹"]); 
dsyNational.add("0_14_3",["卢布林","海乌姆","扎莫希奇","比亚瓦波德拉斯卡"]); 
dsyNational.add("0_14_4",["绿山城","大波兰地区戈茹夫"]); 
dsyNational.add("0_14_5",["克拉科夫","塔尔努夫","新松奇"]); 
dsyNational.add("0_14_6",["华沙","切哈努夫","普沃茨克","奥斯特罗文卡","谢德尔采","拉多姆"]); 
dsyNational.add("0_14_7",["奥波莱"]); 
dsyNational.add("0_14_8",["热舒夫","塔尔诺布热格","克罗斯诺","普热梅希尔"]); 
dsyNational.add("0_14_9",["比亚维斯托克","苏瓦乌基","沃姆扎"]); 
dsyNational.add("0_14_10",["格但斯克","格丁尼亚","索波特","斯武普斯克"]); 
dsyNational.add("0_14_11",["卡托维兹","琴斯托霍瓦","别尔斯科-比亚瓦","雷布尼克","索斯诺维茨","格利维采","比托姆"]); 
dsyNational.add("0_14_12",["凯尔采"]); 
dsyNational.add("0_14_13",["奥尔什丁","埃尔布隆格"]); 
dsyNational.add("0_14_14",["波兹南","皮瓦","卡利什","莱什诺","科宁"]); 
dsyNational.add("0_14_15",["什切青","科沙林","希维诺乌伊希切"]);


dsyNational.add("0_15",["安达卢西亚 Andalucía","阿拉贡 Aragón","阿斯图利亚斯 Asturias","巴利阿里群岛 Baleares","加那利 Canarias","坎塔布利亚 Cantábria","卡斯蒂利亚－拉曼恰 Castilla-La Mancha","卡斯蒂利亚－莱昂 Castilla y Léon","加泰罗尼亚* Cataluna","加利西亚* Galicia","马德里 Madrid"]); 
dsyNational.add("0_15_0",["阿尔梅里亚 Almería","加的斯 Cádiz","科尔多瓦 Córdoba","格拉纳达 Granada","韦尔瓦 Huelva","哈恩 Jáen","马拉加 Málaga","塞维利亚 Sevilla"]); 
dsyNational.add("0_15_1",["韦斯卡 Huesca","特鲁埃尔 Teruel","萨拉戈萨 Zaragoza"]); 
dsyNational.add("0_15_2",["奥维耶多 Oviedo"]); 
dsyNational.add("0_15_3",["巴利阿里 Baleares"]); 
dsyNational.add("0_15_4",["拉斯帕尔马斯 Las Palmas","圣克鲁斯-德特内里费 Santa Cruz de Tenerife"]); 
dsyNational.add("0_15_5",["桑坦德 Santander"]); 
dsyNational.add("0_15_6",["阿尔瓦塞特 Albacete","雷阿尔城 Ciudad Real","昆卡 Cuenca","瓜达拉哈拉 Guadalajara","托莱多 Toledo"]); 
dsyNational.add("0_15_7",["阿维拉 ávila","布尔戈斯 Burgos","莱昂 León","帕伦西亚 Palencia","萨拉曼卡 Salamanca","塞哥维亚 Segovia","索里亚 Soria","巴利亚多利德 Valladolid","萨莫拉 Zamora"]); 
dsyNational.add("0_15_8",["巴塞罗那 Barcelona","赫罗纳 Gerona","莱里达 Lérida","塔拉戈纳 Tarragona"]); 
dsyNational.add("0_15_9",["拉科鲁尼亚 A Coruna","卢戈 Lugo","奥伦塞 Ourense","蓬特韦德拉 Pontevedra"]); 
dsyNational.add("0_15_10",["马德里 Madrid"]);
 

dsyNational.add("0_16",["阿布鲁佐 Abruzzi","巴西利卡塔 Basilicata","卡拉布里亚 Calabria","坎帕尼亚 Campania","艾米利亚－罗马涅 Emilia-Romagna","弗留利－威尼斯·朱利亚* Friuli-Venezia Giulia","拉齐奥 Lazio","利古里亚 Liguria","伦巴第 Lombardia","马尔凯 Marche","莫利塞 Molise","皮埃蒙特 Piemonte","普利亚 Puglia","撒丁* Sardegna","西西里* Sicilia","托斯卡纳 Toscana","特伦蒂诺-上阿迪杰* Trentino-Alto Adige","翁布里亚 Umbria","瓦莱·达奥斯塔* Valle d'Aosta","威尼托 Veneto"]); 
dsyNational.add("0_16_0",["拉奎拉 L'Aquila"]); 
dsyNational.add("0_16_1",["波坦察 Potenza"]); 
dsyNational.add("0_16_2",["卡坦扎罗 Catanzaro"]); 
dsyNational.add("0_16_3",["那波利 Napoli"]); 
dsyNational.add("0_16_4",["博洛尼亚 Bologna"]); 
dsyNational.add("0_16_5",["的里雅斯特 Trieste"]); 
dsyNational.add("0_16_6",["罗马 Roma"]); 
dsyNational.add("0_16_7",["热那亚 Genova"]); 
dsyNational.add("0_16_8",["米兰 Milano"]); 
dsyNational.add("0_16_9",["安科纳 Ancona"]); 
dsyNational.add("0_16_10",["坎波巴索 Campobasso"]); 
dsyNational.add("0_16_11",["都灵 Torino"]); 
dsyNational.add("0_16_12",["巴里 Bari"]); 
dsyNational.add("0_16_13",["卡利亚里 Cagliari"]); 
dsyNational.add("0_16_14",["巴勒莫 Palermo"]); 
dsyNational.add("0_16_15",["佛罗伦萨 Firenze"]); 
dsyNational.add("0_16_16",["特伦托 Trento"]); 
dsyNational.add("0_16_17",["佩鲁贾 Perugia"]); 
dsyNational.add("0_16_18",["奥斯塔 Aosta"]); 
dsyNational.add("0_16_19",["威尼斯 Venezia"]);


dsyNational.add("0_17",["西北 Severo-Zapadnyj","中央 Central'nyj ","南方 Juznyj ","伏尔加 Privolzskij ","乌拉尔 Ural'skij","西伯利亚 Sibirskij","远东 Dal'nevostocnij"]); 
dsyNational.add("0_17_0",["阿尔汉格尔斯克州 Archangel'sk Obl.","涅涅茨自治区 Nenetskiy AOK","圣彼得堡市 Gorod Sankt-Peterburg","加里宁格勒州 Kaliningrad Obl.","卡累利阿共和国 Karelija ARep.","科米共和国 Komi ARep.","列宁格勒州 Leningrad Obl.","摩尔曼斯克州 Murmansk Obl.","诺夫哥罗德州 Novgorod Obl.","普斯科夫州 Pskov Obl.","沃洛格达州 Vologda Obl."]); 
dsyNational.add("0_17_1",["别尔哥罗德州 Belgorod Obl.","布良斯克州 Br'ansk Obl.","莫斯科市 Gorod Moskva.","伊万诺沃州 Ivanovo Obl.","雅罗斯拉夫尔州 Jaroslavl' Obl.","卡卢加州 Kaluga Obl.","库尔斯克州 Kursk Obl.","莫斯科州 Moskva Obl."]); 
dsyNational.add("0_17_2",["阿迪格共和国 Adygeja ARep.","阿斯特拉罕州 Astrachan' Obl.","车臣共和国 Cecenija ARep.","达吉斯坦共和国 Dagestan ARep.","印古什共和国 Ingusetija ARep.","卡巴尔达－巴尔卡尔共和国 Kabardino-Balkarija ARep.","卡尔梅克共和国 Kalmykija ARep.","卡拉恰耶夫－切尔克斯共和国 Karacajevo-Cerkesija ARep.","克拉斯诺达尔边疆区 Krasnodar Kraj.","罗斯托夫州 Rostov Obl.","北奥塞梯－阿兰社会主义共和国 Severnaja Osetija-Alanija ARep.","斯塔夫罗波尔边疆区 Stavropol' Kraj.","伏尔加格勒州 Volgograd Obl."]); 
dsyNational.add("0_17_3",["巴什科尔托斯坦共和国 Ba?kortostan ARep.","楚瓦什共和国 ?uva?ija ARep.","基洛夫州 Kirov Obl.","马里－埃尔共和国 Marij El ARep.","莫尔多瓦社会主义共和国 Mordovija ARep.","下诺夫哥罗德州 Niznij Novgorod Obl.","奥伦堡州 Orenburg Obl.","奔萨州 Penza Obl.","彼尔姆州 Perm' Obl."," 科米－彼尔米亚克自治区 Komi-Permyatskiy AOK","萨马拉州 Samara Obl.","萨拉托夫州 Saratov Obl."]); 
dsyNational.add("0_17_4",["车里雅宾斯克州 Cel'abinsk Obl.","库尔干州 Kurgan Obl.","斯维尔德洛夫斯克州 Sverdlovsk Obl.","秋明州 T'umen' Obl.","汉特－曼西自治区 Khanty-Mansiyskiy AOK","亚马尔－涅涅茨自治区 Yamalo-Nenetskiy AOK"]); 
dsyNational.add("0_17_5",["赤塔州 Cita Obl.","Чита г. 赤塔市","Балей 巴列伊市","Петровск-Забайкальский г. 外贝加尔的彼得罗夫斯克市","Борзя г. 博尔贾市","Краснокаменск г. 克拉斯诺卡缅斯克市","Северобайкальск г. 北贝加尔斯克市","Улан-Удэ г. 乌兰乌德市","Гусиноозерск г. 古西诺奥泽尔斯克市","伊尔库茨克州 Irkutsk Obl.","Усть-Кут г. 乌斯季库特市","Бодайбо 博代博市","Тайшет г. 泰舍特市","Братск г. 布拉茨克市","Нижнеудинск г. 下乌金斯克市","Тулун 图伦市","Саянск 萨彦斯克市","特瓦共和国 Tyva ARep.","克拉斯诺亚尔斯克边疆区 Krasnojarsk ARep.","哈卡斯共和国 Chakasija ARep.","阿尔泰共和国 Altaj ARep.","阿尔泰边疆区 Altaskij Kraj","克麦罗沃州 Kemerovo Obl.","新西伯利亚州 Novosibirsk Obl.","托木斯克州 Tomsk Obl.","鄂木斯克州 Omsk Obl."]); 
dsyNational.add("0_17_6",["滨海边疆区 Приморский край/ Primorskij Kraj.","哈巴罗夫斯克边疆区 Хабаровский край/ Chabarovsk Kraj.","犹太自治州 Еврейская автономная область/Jevrej AArea.","阿穆尔州 Amur Obl.","萨哈林州 Sakhalin Obl.","马加丹州 Magadan Obl.","勘察加州 Kamcatka Obl.","楚科奇自治专区 Cukotskij Avtonomnyj Okrug AArea.","萨哈（雅库特）共和国 Sacha (Jakutija) ARep."]);


dsyNational.add("0_18",["德伦特 Drenthe","弗莱福兰 Flevoland","弗里斯兰* Friesland","海尔德兰 Gelderland","格罗宁根 Groningen","林堡 Limburg","北布拉班特 Noord-Brabant","北荷兰 Noord-Holland ","上艾瑟尔 Overijssel","乌得勒支 Utrecht","泽兰 Zeeland","南荷兰 Zuid-Holland"]); 
dsyNational.add("0_18_0",["阿森 Assen","埃门 Emmen"]); 
dsyNational.add("0_18_1",["莱利斯塔德 Lelystad","阿尔梅勒 Almere"]); 
dsyNational.add("0_18_2",["吕伐登 Leeuwarden"]); 
dsyNational.add("0_18_3",["阿纳姆 Arnhem","阿珀尔多伦 Apeldoorn","埃德 Ede","奈梅亨 Nijmegen"]); 
dsyNational.add("0_18_4",["格罗宁根 Groningen"]); 
dsyNational.add("0_18_5",["马斯特里赫特 Maastricht"]); 
dsyNational.add("0_18_6",["斯海尔托亨博思 's-Hertogenbosch","布雷达 Breda","艾恩德霍芬 Eindhoven","蒂尔堡 Tilburg"]); 
dsyNational.add("0_18_7",["哈勒姆 Haarlem","阿姆斯特丹 Amsterdam","赞济科 Zaandijk","霍夫多尔普 Hoofddorp"]); 
dsyNational.add("0_18_8",["兹沃勒 Zwolle","恩斯赫德 Enschede"]); 
dsyNational.add("0_18_9",["乌得勒支 Utrecht","阿默斯福特 Amersfoort"]); 
dsyNational.add("0_18_10",["米德尔堡 Middelburg"]); 
dsyNational.add("0_18_11",["海牙 's-Gravenhage","鹿特丹 Rotterdam","多德雷赫特 Dordrecht","莱顿 Leiden","佐特尔梅 Zoetermeer"]);


dsyNational.add("0_19",["阿拉巴马 Alabama","阿拉斯加 Alaska","亚利桑那 Arizona","阿肯色 Arkansas","加利福尼亚 California","科罗拉多 Colorado","康涅狄格 Connecticut","特拉华 Delaware","哥伦比亚特区 District of Columbia","佛罗里达 Florida","乔治亚 Georgia","夏威夷 Hawaii","爱达荷 Idaho","伊利诺斯 Illinois","印地安那 Indiana","衣阿华 Iowa","堪萨斯 Kansas","肯塔基 Kentucky","路易斯安那 Louisiana","缅因 Maine","马里兰 Maryland","马萨诸塞 Massachusetts","密歇根 Michigan","明尼苏达 Minnesota","密西西比 Mississippi","密苏里 Missouri","蒙大拿 Montana","内布拉斯加 Nebraska","内华达 Nevada","新罕布什尔 New Hampshire","新泽西 New Jersey","新墨西哥 New Mexico","纽约 New York","犹他 Utah","华盛顿 Washington","威斯康星 Wisconsin"]); 
dsyNational.add("0_19_0",["蒙哥马利 Montgomery"]); 
dsyNational.add("0_19_1",["朱诺 Juneau"]); 
dsyNational.add("0_19_2",["菲尼克斯 Phoenix"]); 
dsyNational.add("0_19_3",["小石城 Little Rock"]); 
dsyNational.add("0_19_4",["萨克拉门多 Sacramento"]); 
dsyNational.add("0_19_5",["丹佛 Denver"]); 
dsyNational.add("0_19_6",["哈特福德 Hartford"]); 
dsyNational.add("0_19_7",["多佛 Dover"]); 
dsyNational.add("0_19_8",["华盛顿 Washington"]); 
dsyNational.add("0_19_9",["塔拉哈西 Tallahassee"]); 
dsyNational.add("0_19_10",["亚特兰大 Atlanta"]); 
dsyNational.add("0_19_11",["檀香山 Honolulu"]); 
dsyNational.add("0_19_12",["博伊亚 Boise"]); 
dsyNational.add("0_19_13",["斯普林菲尔德 Springfield"]); 
dsyNational.add("0_19_14",["印第安纳波利斯 Indianapolis"]); 
dsyNational.add("0_19_15",["得梅因 Des Moines"]); 
dsyNational.add("0_19_16",["托皮卡 Topeka"]); 
dsyNational.add("0_19_17",["法兰克福 Frankfort"]); 
dsyNational.add("0_19_18",["巴吞鲁日 Baton Rouge"]); 
dsyNational.add("0_19_19",["奥古斯塔 Augusta"]); 
dsyNational.add("0_19_20",["安纳波利斯 Annapolis"]); 
dsyNational.add("0_19_21",["波土顿 Boston"]); 
dsyNational.add("0_19_22",["兰辛 Lansing"]); 
dsyNational.add("0_19_23",["圣保罗 St.Paul"]); 
dsyNational.add("0_19_24",["杰克逊 Jackson"]); 
dsyNational.add("0_19_25",["杰斐逊城 Jefferson City"]); 
dsyNational.add("0_19_26",["赫勒纳 Helena"]); 
dsyNational.add("0_19_27",["林肯 Lincoln"]); 
dsyNational.add("0_19_28",["卡森城 Carson City"]); 
dsyNational.add("0_19_29",["康科德 Concord"]); 
dsyNational.add("0_19_30",["特伦顿 Trenton"]); 
dsyNational.add("0_19_31",["圣菲 Santa Fe"]); 
dsyNational.add("0_19_32",["奥尔巴尼 Albany"]); 
dsyNational.add("0_19_33",["盐湖城 Salt Lake City"]); 
dsyNational.add("0_19_34",["奥林匹亚 Olympia"]); 
dsyNational.add("0_19_35",["麦迪逊 Madison"]);


dsyNational.add("0_20",["新不伦瑞克省 New Brunswick","新斯科舍省 Nova Scotia","安大略省 Ontario","魁北克省 Québec","马尼托巴省 Manitoba","不列颠哥伦比亚省 British Columbia","爱德华王子岛省 Prince Edward Island","艾伯塔省 Alberta","萨斯喀彻温省 Saskatchewan","纽芬兰-拉布拉多省 Newfoundland-Labrador","西北地区 Northwest Territories","育空地区 Yukon Territory","努纳维特地区 Nunavut Territory"]); 
dsyNational.add("0_20_0",["弗雷德里顿 Fredericton"]); 
dsyNational.add("0_20_1",["哈利法克斯 Halifax","布列塔尼角 Cape Breton"]); 
dsyNational.add("0_20_2",["多伦多 Toronto","渥太华 Ottawa","哈密尔顿 Hamilton","基奇纳 Kitchener","伦敦 London","圣卡塔琳娜 St. Catharines","温莎 Windsor","奥沙瓦 Oshawa","巴里 Barrie","金斯敦 Kingston","圭尔夫 Guelph","萨德伯里 Sudbury","桑德贝 Thunder Bay"]); 
dsyNational.add("0_20_3",["魁北克 Québec","蒙特利尔 Montréal","舍布鲁克 Sherbrooke","钻石城 Trois-Rivières","希格蒂米 Chicoutimi"]); 
dsyNational.add("0_20_4",["温尼伯 Winnipeg"]); 
dsyNational.add("0_20_5",["维多利亚 Victoria","温哥华 Vancouver","阿伯茨福 Abbotsford","基劳纳 Kelowna"]); 
dsyNational.add("0_20_6",["夏洛特敦 Charlottetown"]); 
dsyNational.add("0_20_7",["埃德蒙顿 Edmonton","卡里加里 Calgary"]); 
dsyNational.add("0_20_8",["里贾纳 Regina","萨斯卡通 Saskatoon"]); 
dsyNational.add("0_20_9",["圣约翰斯 Saint-John's"]); 
dsyNational.add("0_20_10",["耶洛奈夫 Yellowknife"]); 
dsyNational.add("0_20_11",["怀特霍斯 Whitehorse"]); 
dsyNational.add("0_20_12",["伊魁特 Iqaluit"]);


dsyNational.add("0_21",["联邦首都 Distrito Federal","戈亚斯 Goiás","马托格罗索 Mato Grosso","南马托格罗索 Mato Grosso do Sul","阿拉戈斯 Alagoas","巴伊亚 Bahia","塞阿拉 Ceará","马拉尼昂 Maranhao","帕拉伊巴 Paraíba","伯南布哥 Pernambuco","皮奥伊 Piauí","北里奥格兰德 Rio Grande do Norte","塞尔希培 Sergipe","阿克里 Acre","阿马帕 Amapá","亚马孙 Amazonas","帕拉 Pará","朗多尼亚 Rondonia","罗赖马 Roraima","托坎廷斯 Tocantins","圣埃斯皮里图 Espírito Santo*","米纳斯吉拉斯 Minas Gerais","里约热内卢 Rio de Janeiro","圣保罗 Sao Paulo","巴拉那 Paraná","南里奥格兰德 Rio Grande do Sul**","圣卡塔琳娜 Santa Catarina"]); 
dsyNational.add("0_21_0",["巴西利亚 Brasília"]); 
dsyNational.add("0_21_1",["戈亚尼亚 Goiania"]); 
dsyNational.add("0_21_2",["库亚巴 Cuiabá"]); 
dsyNational.add("0_21_3",["大坎普 Campo Grande"]); 
dsyNational.add("0_21_4",["马塞约 Maceió"]); 
dsyNational.add("0_21_5",["萨尔瓦多 Salvador"]); 
dsyNational.add("0_21_6",["福塔莱萨 Fortaleza"]); 
dsyNational.add("0_21_7",["圣路易斯 Sao Luís"]); 
dsyNational.add("0_21_8",["若昂佩索阿 Joao Pessoa"]); 
dsyNational.add("0_21_9",["累西腓 Recife"]); 
dsyNational.add("0_21_10",["特雷西纳 Teresina"]); 
dsyNational.add("0_21_11",["纳塔尔 Natal"]); 
dsyNational.add("0_21_12",["阿拉卡茹 Aracaju"]); 
dsyNational.add("0_21_13",["里奥布朗库 Rio Branco"]); 
dsyNational.add("0_21_14",["马卡帕 Macapá"]); 
dsyNational.add("0_21_15",["马瑙斯 Manaus"]); 
dsyNational.add("0_21_16",["贝伦 Belém"]); 
dsyNational.add("0_21_17",["波多韦柳 Porto Velho"]); 
dsyNational.add("0_21_18",["沃阿维斯塔 Boa Vista"]); 
dsyNational.add("0_21_19",["帕尔马斯 Palmas"]); 
dsyNational.add("0_21_20",["维多利亚 Vitória"]); 
dsyNational.add("0_21_21",["贝洛奥里藏特 Belo Horizonte"]); 
dsyNational.add("0_21_22",["里约热内卢 Rio de Janeiro"]); 
dsyNational.add("0_21_23",["圣保罗 Sao Paulo"]); 
dsyNational.add("0_21_24",["库里蒂巴 Curitiba"]); 
dsyNational.add("0_21_25",["阿雷格里港 Porto Alegre"]); 
dsyNational.add("0_21_26",["弗洛里亚诺波利斯 Florianópolis"]); 
dsyNational.add("0_22",["联邦首都 Distrito Federal","布宜诺斯艾利斯 Buenos Aires","卡塔马卡 Catamarca","查科 Chaco","丘布特 Chubut","科尔多瓦 Córdoba","科连特斯 Corrientes","恩特雷里奥斯 Entre Ríos","福莫萨 Formosa","胡胡伊 Jujuy","拉潘帕 La Pampa","拉里奥哈 La Rioja","门多萨　Mendoza","米西奥斯内斯　Misiones","内乌肯　Neuquén","里奥内格罗 Río Negro","萨尔塔　Salta","圣胡安　San Juan","圣路易斯　San Luis","圣克鲁斯　Santa Cruz","圣菲　Santa Fe","圣地亚哥-德尔埃斯特罗 Santiago del Estero","火地岛　Tierra del Fuego","图库曼　Tucumán"]); 
dsyNational.add("0_22_0",["布宜诺斯艾利斯 Buenos Aires"]); 
dsyNational.add("0_22_1",["拉普拉塔 La Plata","布兰卡港 Bahía Blanca","马德普拉塔 Mar del Plata","圣尼古拉斯 San Nic+olás"]); 
dsyNational.add("0_22_2",["卡塔马卡 Catamarca"]); 
dsyNational.add("0_22_3",["雷西斯滕匹亚　Resistencia"]); 
dsyNational.add("0_22_4",["罗森 Rawson","特雷利乌Trelew","里瓦达维亚海军准将城 Comodoro Rivadavia"]); 
dsyNational.add("0_22_5",["科尔多瓦 Córdoba","里奥夸尔托 Río Cuarto"]); 
dsyNational.add("0_22_6",["科连特斯 Corrientes"]); 
dsyNational.add("0_22_7",["巴拉那　Paraná","肯考迪娅 Concordia"]); 
dsyNational.add("0_22_8",["福莫萨　Formosa"]); 
dsyNational.add("0_22_9",["胡胡伊 Jujuy"]); 
dsyNational.add("0_22_10",["圣罗莎　Santa Rosa"]); 
dsyNational.add("0_22_11",["拉里奥哈　La Rioja"]); 
dsyNational.add("0_22_12",["门多萨 Mendoza","圣拉斐尔 San Rafael"]); 
dsyNational.add("0_22_13",["波萨达斯　Posadas"]); 
dsyNational.add("0_22_14",["内乌肯　Neuquén"]); 
dsyNational.add("0_22_15",["别德马　Viedma"]); 
dsyNational.add("0_22_16",["萨尔塔　Salta"]); 
dsyNational.add("0_22_17",["圣胡安　San Juan","克劳斯城 Villa Krause (Rawson)","圣路易斯 San Luis"]); 
dsyNational.add("0_22_18",["圣路易斯　San Luis"]); 
dsyNational.add("0_22_19",["里奥加耶戈斯　Río Gallegos"]); 
dsyNational.add("0_22_20",["圣菲　Santa Fe","罗萨里奥 Rosario"]); 
dsyNational.add("0_22_21",["圣地亚哥-德尔埃斯特罗 Santiago del Estero"]); 
dsyNational.add("0_22_22",["乌斯怀亚　Ushuaia"]); 
dsyNational.add("0_22_23",["圣米格尔-德图库曼 San Miguel de Tucumán"]); 
dsyNational.add("0_23",["北地 Northland","奥克兰 Auckland","怀卡托 Waikato ","普伦蒂湾 Bay of Plenty","吉斯伯恩 Gisborne (A) ","霍克湾 Hawkes Bay ","玛纳瓦图/旺格努伊 Manawatu-Wanganui ","塔拉那基 Taranaki","惠灵顿 Wellington ","塔斯曼 Tasman (A)","纳尔逊 Nelson (B)","马尔伯勒 Blenheim (A)","西岸 West Coast","坎特伯雷 Canterbury ","奥塔戈 Otago ","南地 Southland"]); 
dsyNational.add("0_23_0",["旺阿雷 Whangarei ","北远 Far North ","凯帕拉 Kaipara"]); 
dsyNational.add("0_23_1",["奥克兰 Auckland","马努考 Manukau","北岸 North Shore","怀塔科拉 Waitakere","罗得尼 Rodney","帕帕库拉 Papakura","富兰克林 Franklin (1)"]); 
dsyNational.add("0_23_2",["哈密尔顿 Hamilton","怀卡托 Waikato","怀帕 Waipa","Otorohanga","Waitomo (7)","Thames-Coromandel","Hauraki"]); 
dsyNational.add("0_23_3",["Tauranga","Western Bay op Plenty","Rotorua (2)","Taupo (3)","瓦卡塔尼 Whakatane","Kawerau","Opotiki"]); 
dsyNational.add("0_23_4",["吉斯伯恩 Gisborne"]); 
dsyNational.add("0_23_5",["内皮尔 Napier","Wairoa","Taupo (3)","Hastings","Rangitikei (4)","Central Hawke's Bay"]); 
dsyNational.add("0_23_6",["北帕默斯顿 Palmerston North","Tararua (6)","Horowhenua","Manawatu","Rangitikei (4)","Ruapehu","Wanganui","斯特拉特福德 Stratford (5)"]); 
dsyNational.add("0_23_7",["新普利茅斯 New Plymouth","斯特拉特福德 Stratford (5)","南塔拉纳基 South Taranaki"]); 
dsyNational.add("0_23_8",["Wellington","Lower Hutt ( Hutt )","Porirua","Upper Hutt","Kapiti Coast","Masterton","Carterton","South Wairarapa"]); 
dsyNational.add("0_23_9",["里士满 Richmond"]); 
dsyNational.add("0_23_10",["纳尔逊 Nelson"]); 
dsyNational.add("0_23_11",["布莱尼姆 Blenheim"]); 
dsyNational.add("0_23_12",["格雷茅斯 Greymouth ","Buller","格雷 Grey","西地 Westland"]); 
dsyNational.add("0_23_13",["基督城 Christchurch","Kaikoura","Hurunui","班克斯半岛 Banks Peninsula","塞尔温 Selwyn"]); 
dsyNational.add("0_23_14",["达尼丁 Dunedin","中奥塔戈 Central Otago","Queenstown-Lakes"]); 
dsyNational.add("0_23_15",["因弗卡吉尔 Invercargill","Gore","南地 Southland"]); 
dsyNational.add("0_24",["新南威尔士州 New South Wales","昆士兰州 Queensland","南澳大利亚州 South Australia","塔斯马尼亚州 Tasmania","维多利亚州 Victoria","西澳大利亚州 Western Australia","澳大利亚首都地区 Australian Capital Territory","北部地区 Northern Territory"]); 
dsyNational.add("0_24_0",["悉尼 Sydney","伍伦贡 Wollongong","纽卡斯尔 Newcastle"]); 
dsyNational.add("0_24_1",["布里斯班 Brisbane","黄金海岸 Gold Coast","日光海岸 Caloundra","汤斯维尔 Townsville","凯恩斯 Cairns","图文巴 Toowoomba"]); 
dsyNational.add("0_24_2",["阿德莱德 Adelaide"]); 
dsyNational.add("0_24_3",["霍巴特 Hobart"]); 
dsyNational.add("0_24_4",["墨尔本 Melbourne","吉朗 Geelong "]); 
dsyNational.add("0_24_5",["珀斯 Perth"]); 
dsyNational.add("0_24_6",["堪培拉 Canberra"]); 
dsyNational.add("0_24_7",["达尔文 Darwin"]); 
dsyNational.add("0_25",["查谟和克什米尔* Jammu & Kashmīr","旁遮普 Punjub","昌迪加尔 Chandīgarh","喜马偕尔邦 Himāchal Pradesh","北安查尔 Uttaranchal","哈里亚纳 Haryāna","德里 Delhi","拉贾斯坦 Rājasthān","北方邦 Uttar Pradesh","中央邦 Madhya Pradesh","查蒂斯加尔 Chhatisgarh","比哈尔 Bihār","贾坎德 Jharkhand","锡金 Sikkim","阿鲁那恰尔邦* Arunāchal Pradesh","那加兰 Nāgāland","曼尼普尔 Manipur","米佐拉姆 Mizorām","特里普拉 Tripura","梅加拉亚 Meghālaya","阿萨姆 Assam","西孟加拉邦 West Bengal","奥里萨 Orissa","古吉拉特 Gujarāt","达曼和第乌 Damān & Diu","达德拉和纳加尔哈维利 Dādra & Nagar Haveli","马哈拉施特拉 Mahārāshtra","果阿 Goa","安得拉邦 Andhra Pradesh","卡纳塔克 Karnātaka","拉克沙群岛 Lakshadweep","喀拉拉 Kerala","泰米尔纳德 Tamil Nādu","本地治里 Pondicherry","安达曼和尼科巴群岛 Andaman & Nicobar Islands"]); 
dsyNational.add("0_25_0",["斯利那加 Srinagar"]); 
dsyNational.add("0_25_1",["昌迪加尔 Chandigarh"]); 
dsyNational.add("0_25_2",["昌迪加尔 Chandigarh"]); 
dsyNational.add("0_25_3",["西姆拉 Simla"]); 
dsyNational.add("0_25_4",["德拉敦 Dehra Dun"]); 
dsyNational.add("0_25_5",["昌迪加尔 Chandigarh"]); 
dsyNational.add("0_25_6",["德里 Delhi"]); 
dsyNational.add("0_25_7",["斋浦尔 Jaipur"]); 
dsyNational.add("0_25_8",["勒克瑙 Lucknow"]); 
dsyNational.add("0_25_9",["博帕尔 Bhopal"]); 
dsyNational.add("0_25_10",["赖布尔 Raipur"]); 
dsyNational.add("0_25_11",["巴特那 Patna"]); 
dsyNational.add("0_25_12",["兰契 Ranchi"]); 
dsyNational.add("0_25_13",["甘托克 Gangtok"]); 
dsyNational.add("0_25_14",["伊塔那噶 Itanagar"]); 
dsyNational.add("0_25_15",["科希马 Kohima"]); 
dsyNational.add("0_25_16",["因帕尔 Imphal"]); 
dsyNational.add("0_25_17",["艾藻尔 Aizawl"]); 
dsyNational.add("0_25_18",["阿加尔塔拉 Agartala"]); 
dsyNational.add("0_25_19",["西隆 Shillong"]); 
dsyNational.add("0_25_20",["迪斯布尔 Dispur"]); 
dsyNational.add("0_25_21",["加尔各答 Kolkata"]); 
dsyNational.add("0_25_22",["布巴内斯瓦尔 Bhubaneswar"]); 
dsyNational.add("0_25_23",["甘地讷格尔 Gandhinagar"]); 
dsyNational.add("0_25_24",["达曼 Daman"]); 
dsyNational.add("0_25_25",["锡尔瓦萨 Silvassa"]); 
dsyNational.add("0_25_26",["孟买 Mumbai"]); 
dsyNational.add("0_25_27",["帕那吉 Panaji"]); 
dsyNational.add("0_25_28",["海得拉巴 Hyderabad"]); 
dsyNational.add("0_25_29",["班加罗尔 Bangalore"]); 
dsyNational.add("0_25_30",["卡瓦拉蒂 Kavaratti"]); 
dsyNational.add("0_25_31",["特里凡得琅 Thiruvananthapuram"]); 
dsyNational.add("0_25_32",["金奈 Chennai"]); 
dsyNational.add("0_25_33",["本地治里 Pondicherry"]); 
dsyNational.add("0_25_34",["布莱尔港 Port Blair"]); 
dsyNational.add("0_26",["开罗 Al Qahirah","亚历山大 Al Iskandariyah","塞得港 Bur Sa`id","苏伊士 As Suways","卢克索 Al Uqsur","代盖赫利耶 Ad Daqahl?yah","布海拉 Al Buhayrah","西部 Al Gharbiyah","伊斯梅利亚 Al Isma`iliyah","米努夫 Al Minufiyah","盖勒尤卜 Al Qalyubiyah","东部 Ash Sharqiyah","杜姆亚特 Dumyat","谢赫村 Kafr ash Shaykh","吉萨 Al Jizah","明亚 Al Minya","贝尼苏韦夫 Bani Suwayf","法尤姆 Al Fayyum","艾斯尤特 Asyut","阿斯旺 Aswan","索哈杰 Suhaj","基纳 Qina","红海 Al Bahr al Ahmar","新河谷 Al Wadi al Jadid","马特鲁 Matruh","南西奈 Janub Sina","北西奈 Shamal Sina"]); 
dsyNational.add("0_26_0",["开罗 Al Qahirah"]); 
dsyNational.add("0_26_1",["亚历山大 Al Iskandariyah"]); 
dsyNational.add("0_26_2",["塞得港 Bur Sa`id"]); 
dsyNational.add("0_26_3",["苏伊士 As Suways"]); 
dsyNational.add("0_26_4",["卢克索 Al Uqsur"]); 
dsyNational.add("0_26_5",["曼苏拉 Al Mansurah","米特加穆尔 Mit Ghamr"]); 
dsyNational.add("0_26_6",["达曼胡尔 Damanhur","达沃 Kafr ad-Dawwar"]); 
dsyNational.add("0_26_7",["坦塔 Tanta","马哈拉库布拉 Al-Mahallah al-Kubra"]); 
dsyNational.add("0_26_8",["伊斯梅利亚 Al Isma`iliyah"]); 
dsyNational.add("0_26_9",["希宾库姆 Shibin al Kawm"]); 
dsyNational.add("0_26_10",["本哈 Banha","苏布拉开马 Shubra al-Khaymah"]); 
dsyNational.add("0_26_11",["宰加济格 Az Zaqaziq","比勒拜斯 Bilbays"]); 
dsyNational.add("0_26_12",["杜姆亚特 Dumyat"]); 
dsyNational.add("0_26_13",["谢赫村 Kafr ash Shaykh"]); 
dsyNational.add("0_26_14",["吉萨 Al Jizah"]); 
dsyNational.add("0_26_15",["明亚 Al Minya","迈莱维 Mallawi"]); 
dsyNational.add("0_26_16",["贝尼苏韦夫 Bani Suwayf"]); 
dsyNational.add("0_26_17",["法尤姆 Al Fayyum"]); 
dsyNational.add("0_26_18",["艾斯尤特 Asyut"]); 
dsyNational.add("0_26_19",["阿斯旺 Aswan"]); 
dsyNational.add("0_26_20",["索哈杰 Suhaj"]); 
dsyNational.add("0_26_21",["基纳 Qina"]); 
dsyNational.add("0_26_22",["古尔代盖 Al Ghurdaqah"]); 
dsyNational.add("0_26_23",["哈里杰 Al Kharijah"]); 
dsyNational.add("0_26_24",["马特鲁 Matruh"]); 
dsyNational.add("0_26_25",["图尔 Janub Sina"]); 
dsyNational.add("0_26_26",["阿里什 Al `Arish"]); 

var national=["national1","national2","national3"]; 
var optNational = ["国家","省份、州","地级市、县"]; 
function setup() 
{ 
for(i=0;i<national.length-1;i++) {
	document.getElementById(national[i]).onchange=new Function("changeNational("+(i+1)+")");
}
changeNational(0); 
} 