<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-在线进销存详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="litscloud/css/main.css" />
<script type="text/javascript" src="litscloud/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="litscloud/js/slides.jquery.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
</head>

<body>
<div class="ly_body" id="mainbody">
  <!------------------------------------------头部公用代码------------------------------------------------------------>
    <jsp:include page="/litscloud/tpl/top6.jsp"></jsp:include> 
    <!----------------------------------------------------------------内容开始------------------------------------------------------>
 <div class="ly_imiddle">
      <div class="ly_dh" style="height:4px; overflow:hidden;">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > 云应用
      </div>      
    <div class="ly_n_mbt">
       <div class="ly_n_mbtc">在线<br />进销存</div>
    </div>
    
    <div class="ly_jxc">
       <div class="ly_jxc_t">
          <div class="ly_jxc_tl"><img src="litscloud/images/ly_126.jpg" /></div>
          <div class="ly_jxc_tr">
             <div class="ly_jxc_trt">[管货] 用友-立云专版在线进销存</div>
             <div class="ly_jxc_trj">业务实时入账,单据个性化打印,采购一步式完成,往来核销精细化处理,支持多部门多人员异地实时办公,让财务决策及时响应老板需求,提升企业管理效率5倍以上!</div>
             <div class="ly_jxc_trb">
               <div class="ly_jxc_trb_l">版&nbsp;&nbsp;&nbsp;本:</div>
               <div class="ly_jxc_trb_r"><ul>
                  <li style="background-image:url(litscloud/images/ly_129.jpg); background-repeat:no-repeat;"><a href="#">1用户</a></li>
                  <li><a href="#">2用户</a></li>
                  <li><a href="#">3用户</a></li>
                  <li><a href="#">4用户</a></li>
                  <li><a href="#">5用户</a></li>
                  <li><a href="#">6用户</a></li>
               </ul></div>
             </div>
             <div class="ly_jxc_trb">
               <div class="ly_jxc_trb_l">服务期限:</div>
               <div class="ly_jxc_trb_r"><ul>
                  <li style="background-image:url(litscloud/images/ly_129.jpg); background-repeat:no-repeat;"><a href="#">12个月</a></li>
                  <li><a href="#">36个月</a></li>        
               </ul></div>
             </div> 
             <div class="ly_jxc_trc"><span>已选产品：</span>1用户/12个月</div>
             <div class="ly_jxc_trc"><span>总 价 格：</span><em>348</em> 元</div>
             <div class="ly_jxc_trd">
               <div class="ly_jxc_trd_gm"><a href="#">马上购买</a></div>
               <div class="ly_jxc_trd_sy"><a href="#">后台试用</a></div>
             </div>     
          </div>
       </div> 
       <DIV class="ly_jxc_D">
         <div class="ly_jxc_Dt">售后服务</div>
         <div class="ly_jxc_Dc">
           <div class="ly_jxc_Dc_l"></div>
           <div class="ly_jxc_Dc_r"></div>
         </div>
       </DIV> 
       <div class="ly_jxc_Dd"><ul>
         <li>
          <dl><a href="#"><img src="litscloud/images/ly_130.jpg" /></a></dl>
          <dt>客户日常使用方面</dt>
          <dd>提供7*10小时<br />
用友客户热线：<br />
<span>4006-600-566转9转1</span></dd>
         </li>
         <li>
          <dl><a href="#"><img src="litscloud/images/ly_131.jpg" /></a></dl>
          <dt>系统运维方面</dt>
          <dd>提供电信级的数据中心及系统运维安全保障，有专业的运维团队人员。</dd>
         </li>
         <li>
          <dl><a href="#"><img src="litscloud/images/ly_132.jpg" /></a></dl>
          <dt>数据安全方面</dt>
          <dd>提供日常备份管理；支持按权限导出数据功能</dd>
         </li>
       </ul></div>     
    </div>  
   <div class="ly_n_weibu" style="margin-bottom:50px;"></div>
   <div class="ly_cpjs">
     <div class="ly_cpjs_t"><div class="ly_cpjs_d"><ul>
       <li><a href="#" style="background-image:url(litscloud/images/ly_106.jpg); background-repeat:no-repeat; color:#fff;">产品介绍</a></li>
       <li><a href="#">功能介绍</a></li>
       <li><a href="#">常见问题</a></li>
       <li><a href="#">相关下载</a></li>
     </ul></div></div>
     <div class="ly_cpjs_c">
     
    
       <div class="ly_cpjs_cr" style="margin-top:42px;">
          <div class="ly_cpjs_crv"></div>
          <div class="ly_cpjs_crn">
          <div class="ly_cpjs_crt">身为小企业老板、管理人员、财务人员抑或不得不身兼多职的的，是否</div>
          <div class="ly_cpjs_crc"><span>遇</span>到过........</div>
          <div class="ly_cpjs_crm">
            <div class="ly_cpjs_crm_l"><img src="litscloud/images/ly_135.gif" /></div>
            <div class="ly_cpjs_crm_r"><ul>
              <li><span>1</span> 买回来的进销存软件太死板不灵活，操作无比繁杂<img src="litscloud/images/ly_136.gif" /></li>
              <li><span style="margin-left:20px;">2</span> 订单状态不清楚，异常状态无法及时发现<img src="litscloud/images/ly_138.gif" /></li>
              <li><span>3</span> 库存不清晰，爆款产品赔本卖，库存亏空无预警，到最后资金险些运   <img src="litscloud/images/ly_139.gif" />   转不起来</li>
              <li><span style="margin-left:20px;">4</span> 不同岗位重复操作，各部门之间反复对帐效率低下，你人欲哭无泪。<img src="litscloud/images/ly_140.gif" /></li>
            </ul></div>
          </div>
          <div class="ly_cpjs_crd">有什么办法让我从这一团乱麻中<span>解</span>脱出来<span>？</span></div>
          </div>
          <div class="ly_cpjs_crs"></div>
       </div>
       
       
       <div class="ly_cpjs_cl">
         <div class="ly_cpjs_clv"></div>
         <div class="ly_cpjs_cln"> 
          <div class="ly_cpjs_cl_t">教你如何挑选合适的进销存软件</div>
          <div class="ly_cpjs_cl_d">
           <div class="ly_cpjs_cl_dl"><img src="litscloud/images/ly_141.gif" /></div>
           <div class="ly_cpjs_cl_dr">
               <div class="ly_cpjs_cl_drt">进销存实施一直是一个热门话题，对于如何选择一个合适的进销存软件，业界已有流行的概念，</div>
                <div class="ly_cpjs_cl_drc">即：</div>
                 <div class="ly_cpjs_cl_drd"><ul>
                    <li><span>1</span>看进是否有先进管理理念</li>
                    <li><span style="margin-left:20px;">2</span>看是否功能齐全</li>
                    <li><span>3</span>看是否有成功案例和行业经验</li>
                    <li><span style="margin-left:20px;">4</span>看是否名气足够大</li>
                    <li><span>5</span>看价格</li>
                 </ul></div>
           </div>
          </div>
          </div>
         <div class="ly_cpjs_cls"></div> 
       </div>
       
       <div class="ly_cpjs_cr">
          <div class="ly_cpjs_crv"></div>
          <div class="ly_cpjs_crn">
              <div class="ly_cpjs_qsl"><img src="litscloud/images/ly_142.jpg" /></div>
              <div class="ly_cpjs_qsr">
                 <div class="ly_cpjs_qsr_t">用友-立云强强联手，针对中小企业推出专款     用友-立云专版在线进销存款存软件应用服务！只有立云云计算开放平台，才能为你提供从基础应用到财务管理提供从头至尾的全面支持，让你第一分钟起就能从容的把握您企业的进销存管理问题。
</div>
                 <div class="ly_cpjs_qsr_d"><ul>
                    <li><span>1</span>拥有16年互联网基础历史的立云携手名财务管理软件专家用友集团倾力打造用友立云在线进销存专版产品，力求从您拥
有网站的第一步就能构建良好的财务管理体系帮助您从4600万财务管理混乱中小企业中脱颖而出，赢在起跑线上。</li>
                    <li><span style="margin-left:20px;">2</span>用友-立云版在线进销存用独特的设计理念，恰到好处地解决中小企业财务管理中许多现实的问题，帮助中小企业老板
实现经营住处的全程把控、传递、记录和分析，为企业的经营管理提供决策依据。</li>
                    <li><span>3</span>你将享受到低于市场均价价,随着用户增加，我们提供更大额度的优惠。</li>
                 </ul></div>
              </div>              
          </div>
          <div class="ly_cpjs_crs"></div>
       </div> 
       
       
       <div class="ly_cpjs_cl">
         <div class="ly_cpjs_clv"></div>
         <div class="ly_cpjs_cln">
            <div class="ly_cpjs_zbt">用友-立云专版在线进销存优势介绍</div>
            <div class="ly_cpjs_zbc">
               <div class="ly_cpjs_zbcl"><img src="litscloud/images/ly_152.gif" /></div>
               <div class="ly_cpjs_zbcc"><img src="litscloud/images/ly_143.gif" /></div>
               <div class="ly_cpjs_zbcr"><h3>买即用、更方便、免安装、易操作、零维护</h3>
               业务单据例如采购入库单、销售出库单到的基础档案随用随录，降低了用户的门槛。<br />
系统提供完成业务数据处理前所必需的所有基础数据的准备工作，实现快速上线。<br />
初始化向导功能的提供，使得新用户可以按照向导一步步完成系统的初始工作。           
               </div>
            </div>
            <div class="ly_cpjs_zbd">在线进销存支持跨地区、多仓库协作，无需额外添置设备运营，省钱、省心、更省力。</div> 
         </div> 
         <div class="ly_cpjs_cls"></div> 
       </div>
       
       
       <div class="ly_cpjs_cr">
          <div class="ly_cpjs_crv"></div>
          <div class="ly_cpjs_crn">
             <div class="ly_cpjs_zxt">用友-立云专版在线进销存优势介绍</div>
             <div class="ly_cpjs_zxd">
                <div class="ly_cpjs_zxd_l"><img src="litscloud/images/ly_145.gif" /> </div>
                <div class="ly_cpjs_zxd_c"><h3>业务住来核销，规俾库存风险</h3>
                通过往来核销处理，企业能明确哪些采购业务单据已经付了多少款，哪些销售业务单据已经收了多少款，以便于安排资金对采购付款，以及向客户催收应收款。           
                </div>
                <div class="ly_cpjs_zxd_r"><img src="litscloud/images/ly_144.gif" /></div>
             </div>
          </div>
          <div class="ly_cpjs_crs"></div>
       </div>
       
       
              <div class="ly_cpjs_cl">
         <div class="ly_cpjs_clv"></div>
         <div class="ly_cpjs_cln">
            <div class="ly_cpjs_zbt">良好的交互性</div>
            <div class="ly_cpjs_zbc" style="margin-bottom:40px;">
               <div class="ly_cpjs_zbcl"><img src="litscloud/images/ly_146.gif" /></div>
               <div class="ly_cpjs_zbcc"><img src="litscloud/images/ly_147.gif" /></div>
               <div class="ly_cpjs_zbcr">基于业务流程的图形导航页面，方便用户理解业务流程并找到所需功能。流程导航图附近还有相关的文字说明，大大降低了用户对使用新服务的陌生感。页面支持用户录入单据全键盘操作，以方便快速采集业务数据。                     
               </div>
            </div>
         </div> 
         <div class="ly_cpjs_cls"></div> 
       </div>
       
       
       <div class="ly_cpjs_cr">
          <div class="ly_cpjs_crv"></div>
          <div class="ly_cpjs_crn">
             <div class="ly_cpjs_zxt">用友-立云专版在线进销存亮点解析</div>
             <div class="ly_cpjs_zxd">
                <div class="ly_cpjs_zxd_l"><img src="litscloud/images/ly_149.gif" /> </div>
                <div class="ly_cpjs_zxd_c"><h3>简单、灵活的进销存业务流程</h3>
               在线进销存同时支持常规、简化的业务处理流程，一步式完成采购业务。                     
                </div>
                <div class="ly_cpjs_zxd_r"><img src="litscloud/images/ly_148.gif" /></div>
             </div>
          </div>
          <div class="ly_cpjs_crs"></div>
       </div>
       
       
           <div class="ly_cpjs_cl">
         <div class="ly_cpjs_clv"></div>
         <div class="ly_cpjs_cln">
            <div class="ly_cpjs_zbt">单据个性打印</div>
            <div class="ly_cpjs_zbc" style="margin-bottom:40px;">
               <div class="ly_cpjs_zbcl"><img src="litscloud/images/ly_151.gif" /></div>
               <div class="ly_cpjs_zbcc"><img src="litscloud/images/ly_150.gif" /></div>
               <div class="ly_cpjs_zbcr">用户可自行设置单据的打印模板，自行选择打印项目名称，单据抬头，单据体行数等。                
               </div>
            </div>
         </div> 
         <div class="ly_cpjs_cls"></div> 
       </div>     
       
       
       <DIV class="ly_jxc_D">
         <div class="ly_jxc_Dt">用友-万网专版在线进销存适用人群</div>
         <div class="ly_jxc_Dc">
           <div class="ly_jxc_Dc_l"></div>
           <div class="ly_jxc_Dc_r"></div>
         </div>
       </DIV>
       <div class="ly_jxc_fbt">青睐本产品企业类型分布</div>
       <div class="ly_jxc_fbd"><img src="litscloud/images/ly_153.jpg" /></div>
       <div class="ly_jxc_fbt">青睐本产品企业行业分布</div>
       <div class="ly_jxc_fbd"><img src="litscloud/images/ly_154.jpg" /></div>
       <div class="ly_jxc_fbt">青睐本产品的理由</div>
       <div class="ly_jxc_fbd"><img src="litscloud/images/ly_155.jpg" /></div>
     </div>
     
   </div>
   <div class="ly_n_weibu" style="margin-bottom:50px;"></div>
   </div>


<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
