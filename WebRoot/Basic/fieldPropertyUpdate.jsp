<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- Style Start -->
<style>
.divFJ{ width:100%; font-size:12px;}
.divHang{ width:100%; height:30px; border-top:1px #9CF solid; border-right:1px #9CF solid;}
.divLie{ width:10%; height:30px; float:left; line-height:25px; border-left:1px #9CF solid;}
.divLieInput{ width:90%; margin-top:5px; border:0px;}
</style>
<!-- Style end -->


<div>
	<!-- FieldRemark Start -->
	<%int iHeaderCount = 1;%>
	<%int iListFpIndex = 0;%><!-- 下标 -->
	
	<c:if test="${listallf != null}">
	<!-- 外循环 开始-->
	<c:forEach items="${listallf}" var="listfr" varStatus="sta">
	<c:if test="${listfr.beanNames==beanName}">
    	<div id="signFrame" class="divFJ" style="text-align:center;">
        	<div class="divHang" style="border-left:1px #9CF solid; text-align:left;background-color:#9CF; ">
            	<div class="divLie" style="width:90%">
                	<font color="#1945F8" style="margin-left:10px; font-weight: bolder;">${listfr.id} ----------${listfr.name}</font>
                </div>
            </div>
            <%int iLie = 0; %>
            <!-- 标题循环（外循环） -->
        	<div id="divHangHeaderId<%=iHeaderCount%>-1" class="divHang" >
            	<div class="divLie" style="width:80px; text-align:center;font-weight: bolder;color:#1945F8; ">
                	序号
                </div>
                <c:if test="${listfr.temp1 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp1}
                </div>
                </c:if>
                <c:if test="${listfr.temp2 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp2}
                </div>
                </c:if>
                <c:if test="${listfr.temp3 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp3}
                </div>
                </c:if>
                <c:if test="${listfr.temp4 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp4}
                </div>
                </c:if>
                <c:if test="${listfr.temp5 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp5}
                </div>
                </c:if>
                <c:if test="${listfr.temp6 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp6}
                </div>
                </c:if>
                <c:if test="${listfr.temp7 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp7}
                </div>
                </c:if>
                <c:if test="${listfr.temp8 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp8}
                </div>
                </c:if>
                <c:if test="${listfr.temp9 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp9}
                </div>
                </c:if>
                <c:if test="${listfr.temp10 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp10}
                </div>
                </c:if>
                <c:if test="${listfr.temp11 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp11}
                </div>
                </c:if>
                <c:if test="${listfr.temp12 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp12}
                </div>
                </c:if>
                <c:if test="${listfr.temp13 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp13}
                </div>
                </c:if>
                <c:if test="${listfr.temp14 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp14}
                </div>
                </c:if>
                <c:if test="${listfr.temp15 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp15}
                </div>
                </c:if>
                <c:if test="${listfr.temp16 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp16}
                </div>
                </c:if>
                <c:if test="${listfr.temp17 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp17}
                </div>
                </c:if>
                <c:if test="${listfr.temp18 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp18}
                </div>
                </c:if>
                <c:if test="${listfr.temp19 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp19}
                </div>
                </c:if>
                <c:if test="${listfr.temp20 != null}"><%iLie++;%>
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp20}
                </div>
                </c:if>
                <!-- 修改的操作 -->
                <c:if test="${addshowemp == null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	操作
                </div>
                </c:if>
            </div>
			
			
			<!-- 修改显示 开始-->
            <%int iContentCount=0; %>
            <c:if test="${listfr != null && listfr.fieldProperties!=null}">
            <!-- 内循环 开始-->
            <c:forEach items="${listfr.fieldProperties}" var="item" varStatus="status">
            <c:if test="${item.beanUuid == showemp.uuid}">
            <!-- 内容循环（内循环）开始-->
            <div id="divHangContentId<%=iHeaderCount%>" class="divHang" style="color:gray;">
            	<div class="divLie" style="width:80px; text-align:center;">
            		<%=iContentCount+1%>
                </div>
                <%request.setAttribute("iListFpIndex",iListFpIndex);request.getAttribute("iListFpIndex"); %>
                <!-- FP主键ID -->
                <input type='hidden' name="listFieldProperty[<%=iListFpIndex%>].id" id="listFieldProperty[<%=iListFpIndex%>].id" value="${listFieldProperty[iListFpIndex].id}" />
                <!-- FP外键ID -->
                <input type='hidden' name="listFieldProperty[<%=iListFpIndex%>].fieldRemark.id" value="${listfr.id}" />FPID：${listFieldProperty[iListFpIndex].id}，下标：<%=iListFpIndex%> 
                <c:if test="${item.temp1 != null}">
            	<div class="divLie">
            		<input type='text' id="listFieldProperty[${status.index}].temp1" name="listFieldProperty[${status.index }].temp1" value="${item.temp1}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp2 != null }">
            	<div class="divLie">
                	${item.temp2}
                </div>
                </c:if>
                <c:if test="${item.temp3 != null}">
            	<div class="divLie">
                	${item.temp3 }
                </div>
                </c:if>
                <c:if test="${item.temp4 != null}">
            	<div class="divLie">
                	${item.temp4 }
                </div>
                </c:if>
                <c:if test="${item.temp5 != null}">
            	<div class="divLie">
                	${item.temp5 }
                </div>
                </c:if>
                <c:if test="${item.temp6 != null}">
            	<div class="divLie">
                	${item.temp6 }
                </div>
                </c:if>
                <c:if test="${item.temp7 != null}">
            	<div class="divLie">
                	${item.temp7 }
                </div>
                </c:if>
                <c:if test="${item.temp8 != null}">
            	<div class="divLie">
                	${item.temp8 }
                </div>
                </c:if>
                <c:if test="${item.temp9 != null}">
            	<div class="divLie">
                	${item.temp9 }
                </div>
                </c:if>
                <c:if test="${item.temp10 != null}">
            	<div class="divLie">
                	${item.temp10 }
                </div>
                </c:if>
                <c:if test="${item.temp11 != null}">
            	<div class="divLie">
                	${item.temp11 }
                </div>
                </c:if>
                <c:if test="${item.temp12 != null}">
            	<div class="divLie">
                	${item.temp12 }
                </div>
                </c:if>
                <c:if test="${item.temp13 != null}">
            	<div class="divLie">
                	${item.temp13 }
                </div>
                </c:if>
                <c:if test="${item.temp14 != null}">
            	<div class="divLie">
                	${item.temp14 }
                </div>
                </c:if>
                <c:if test="${item.temp15 != null}">
            	<div class="divLie">
                	${item.temp15 }
                </div>
                </c:if>
                <c:if test="${item.temp16 != null}">
            	<div class="divLie">
                	${item.temp16 }
                </div>
                </c:if>
                <c:if test="${item.temp17 != null}">
            	<div class="divLie">
                	${item.temp17 }
                </div>
                </c:if>
                <c:if test="${item.temp18 != null}">
            	<div class="divLie">
                	${item.temp18 }
                </div>
                </c:if>
                <c:if test="${item.temp19 != null}">
            	<div class="divLie">
                	${item.temp19 }
                </div>
                </c:if>
                <c:if test="${item.temp20 != null}">
            	<div class="divLie">
                	${item.temp20 }
                </div>
                </c:if>
                <!-- 修改的操作 -->
                <c:if test="${addshowemp == null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	<input type="checkbox" id="checkDel" name="checkDel" value=""/>
                </div>
                </c:if>
                
            </div>
            <%iContentCount++;%>
            <%iListFpIndex++;%>
            <!-- 内容行隐藏值 -->
            <input type="hidden" id="hiddenHangContent<%=iContentCount%>" name="hiddenHangContent" value="<%=iContentCount%>"/>
            <input type="hidden" id="hiddenHangContentCount" name="hiddenHangContentCount" value="<%=iContentCount%>"/>
            </c:if>
            </c:forEach>
             <!-- 内循环 结束-->
            
            <div style="border-left:1px #9CF solid; border-bottom:1px #9CF solid;"></div>
            </c:if>
            <!-- 修改显示 结束 -->
	     	
           
            <%int neiCount=0; %>
            <!-- button start-->
            <div id="divBtnwHang<%=iHeaderCount%>" class="divHang" style=" border-left:1px #9CF solid; border-bottom:1px #9CF solid; background-color:#89D9ED;">
            	<div style="float:right; width:50%; line-height:25px; height:30px; text-align:right;" >
                	 <input type="button" name="Submit" value="添加一行" onclick="AddSignRow('divHangContentId',<%=iHeaderCount %>,<%=iLie%>,'${listfr.id}')" /> 
                	 <input type="button" name="Submit" value="减少一行" onclick="DeleteSignRow('divHangContentId','<%=iHeaderCount%>')" />
				     <input type="hidden" id="count<%=iHeaderCount %>" name="count<%=iHeaderCount %>" value="<%=iContentCount%>"/>
                </div>
            </div>
            <!-- button end-->
        </div>
        
    </c:if>
    <div style=" height:5px;"></div>
    <input type="hidden" id="hiddenHangHeader" name="hiddenHangHeader" value="<%=iHeaderCount%>"/>
	<%iHeaderCount++; %>
    </c:forEach>
     <!-- 外循环 结束-->
    </c:if>
    <!-- FieldRemark End -->
</div>






<!-- JS -->
<script type="text/javascript">
var rowCount = 0;
//添加一行 参数：标题循环次数、每行内容中的列数
function AddSignRow(id,iHanCount,lie,fieldTypeId){
 rowCount++;	// 记录总共添加多少行（为ListFieldProperty下标）

 //获取标题行DIV元素
 var count = $("#count"+iHanCount).val();

 var bl = id+iHanCount+"-"+(parseInt(count)+1);

 var baseid = "divBtnwHang"+iHanCount;//以添加一行的div为基准

  var liediv = "";
 var newdiv = "<div id='"+bl+"' class=divHang style=color:gray;>"+
					"<div class='divLie' style='width:80px; text-align:center;'> HeaderId"+fieldTypeId+"-"+(parseInt(count)+1)+"</div>"+ (rowCount-1)+
					"<input type='hidden' name='listFieldProperty["+(rowCount-1)+"].fieldRemark.id' id='fieldTypeId' value='"+fieldTypeId+"'/> ";
	            	for(var i=0; i< lie; i++){
	            		liediv+="<div class='divLie'><input type='text' id='' name='listFieldProperty["+(rowCount-1)+"].temp"+(i+1)+"' value='Content"+fieldTypeId+"-"+(parseInt(count)+1)+"-"+(i+1)+"' class='divLieInput' /></div>";
	            	}
					newdiv += liediv+
					"</div>";

 $("#count"+iHanCount).attr("value",(parseInt(count)+1));
 // 在指定元素后面添加行
 ($("#"+baseid)).before(newdiv);
}

//删除指定行
function DeleteSignRow(id,iHanCount){

  var count = $("#count"+iHanCount).val();

  var nowRow = count-1;
    if( nowRow <= 0){
    	alert("至少有一行");
    	return false;
    }
    var tt = '#'+id+iHanCount+"-"+(nowRow+1);

 	$(tt).remove();
 	$("#count"+iHanCount).attr("value",nowRow);
}
</script>
