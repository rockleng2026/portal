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
	<%int iHeaderCount = 1;int iListFpIndex = 0;%>
	<c:if test="${listallf != null}">
	<!-- 外循环 开始-->
	<c:forEach items="${listallf}" var="listfr" varStatus="sta">
	<c:if test="${listfr.beanNames==beanName}">
    	<div id="signFrame" class="divFJ" style="text-align:center;">
        	<div class="divHang" style="border-left:1px #9CF solid; text-align:left;background-color:#9CF; ">
            	<div class="divLie" style="width:90%">
                	<font color="#1945F8" style="margin-left:10px; font-weight: bolder;">${listfr.name}</font>
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
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	操作
                </div>
            </div>
			
			
			<!-- 修改显示 开始-->
            <%int iContentCount=0; int iCH=0;%>
            <c:if test="${listfr != null && listfr.fieldProperties!=null}">
            <!-- 内循环 开始-->
            <c:forEach items="${listfr.fieldProperties}" var="item" varStatus="status">
            <c:if test="${item.beanUuid == showemp.uuid}">
            <!-- 内容循环（内循环）开始-->
            <div id="divHangContentId<%=iHeaderCount%>-<%=iCH+1%>" class="divHang" style="color:gray;">
            	<div class="divLie" style="width:80px; text-align:center;">
            		<%=iContentCount+1%>
                </div>
                <%request.setAttribute("iListFpIndex",iListFpIndex);request.getAttribute("iListFpIndex");%>
                <!-- FP主键ID -->
                <input type='hidden' name="listFieldProperty[<%=iListFpIndex%>].id" id="listFieldProperty[<%=iListFpIndex%>].id" value="${listFieldProperty[iListFpIndex].id}" />
                <!-- FP外键ID -->
                <input type='hidden' name="listFieldProperty[<%=iListFpIndex%>].fieldRemark.id" value="${listfr.id}" />
                
                <c:if test="${item.temp1 != null}">
            	<div class="divLie">
            		<input type='text' id="listFieldProperty[${iListFpIndex}].temp1" name="listFieldProperty[${iListFpIndex }].temp1" value="${item.temp1}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp2 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp2" name="listFieldProperty[${iListFpIndex }].temp2" value="${item.temp2}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp3 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp3" name="listFieldProperty[${iListFpIndex }].temp3" value="${item.temp3}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp4 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp4" name="listFieldProperty[${iListFpIndex }].temp4" value="${item.temp4}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp5 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp5" name="listFieldProperty[${iListFpIndex }].temp5" value="${item.temp5}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp6 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp6" name="listFieldProperty[${iListFpIndex }].temp6" value="${item.temp6}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp7 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp7" name="listFieldProperty[${iListFpIndex }].temp7" value="${item.temp7}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp8 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp8" name="listFieldProperty[${iListFpIndex }].temp8" value="${item.temp8}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp9 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp9" name="listFieldProperty[${iListFpIndex }].temp9" value="${item.temp9}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp10 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp10" name="listFieldProperty[${iListFpIndex }].temp10" value="${item.temp10}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp11 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp11" name="listFieldProperty[${iListFpIndex }].temp11" value="${item.temp11}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp12 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp12" name="listFieldProperty[${iListFpIndex }].temp12" value="${item.temp12}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp13 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp13" name="listFieldProperty[${iListFpIndex }].temp13" value="${item.temp13}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp14 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp14" name="listFieldProperty[${iListFpIndex }].temp14" value="${item.temp14}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp15 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp15" name="listFieldProperty[${iListFpIndex }].temp15" value="${item.temp15}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp16 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp16" name="listFieldProperty[${iListFpIndex }].temp16" value="${item.temp16}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp17 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp17" name="listFieldProperty[${iListFpIndex }].temp17" value="${item.temp17}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp18 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp18" name="listFieldProperty[${iListFpIndex }].temp18" value="${item.temp18}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp19 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp19" name="listFieldProperty[${iListFpIndex }].temp19" value="${item.temp19}" class="divLieInput" />
                </div>
                </c:if>
                <c:if test="${item.temp20 != null}">
            	<div class="divLie">
                	<input type='text' id="listFieldProperty[${iListFpIndex}].temp20" name="listFieldProperty[${iListFpIndex }].temp20" value="${item.temp20}" class="divLieInput" />
                </div>
                </c:if>
                <!-- 修改的操作按-->
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	<div class='divLie' style='width:80px; text-align:center;'><a href='javascript:void(0);' onclick ="DeleteLRow('divHangContentId',<%=iHeaderCount%>,<%=iCH+1%>)">删除</a></div>
                </div>
                
            </div>
            <%iContentCount++;iListFpIndex++;iCH++;%>
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
     <input type="hidden" id="iFpIndexCount" value="<%=iListFpIndex%>"/>
     <!-- 外循环 结束-->
    </c:if>
    <!-- FieldRemark End -->
</div>






<!-- JS -->
<script type="text/javascript">
//添加一行 参数：标题循环次数、每行内容中的列数
function AddSignRow(id,iHanCount,lie,fieldTypeId){


var listFpIndexCount = new Array();
listFpIndexCount = document.getElementsByName("listFpIndexCount");
if(listFpIndexCount.length<1){
	listFpIndexCount[0] = 0;

}
var iFpIndexC = listFpIndexCount.length;


{	// 大括号开始
var rowCount = $("#iFpIndexCount").val();	// 获取内循环的总数下标


 var count = $("#count"+iHanCount).val();
 //alert(count);	// 每个内循环List的下标，从0开始
 var bl = id+iHanCount+"-"+(parseInt(count)+1);

 var baseid = "divBtnwHang"+iHanCount;//以添加一行的div为基准

	  var liediv = "";
	  var newdiv = "";
		  newdiv = "<div id='"+bl+"' class=divHang style=color:gray;>"+
		  				"<div id='fpRepIndex"+rowCount+"'>"+
							"<div class='divLie' style='width:80px; text-align:center;'> "+(parseInt(count)+1)+"</div> "+ 
							"<input type='hidden' name='listFpIndexCount' value='"+(parseInt(rowCount))+"'>"+
							"<input type='hidden' name='listFieldProperty["+(rowCount)+"].fieldRemark.id' id='listFieldProperty["+(rowCount)+"].fieldRemark.id' value='"+fieldTypeId+"'/> ";
			            	for(var i=0; i< lie; i++){
			            		liediv+="<div class='divLie'><input type='text' id='listFieldProperty["+(rowCount)+"].temp"+(i+1)+"' name='listFieldProperty["+(rowCount)+"].temp"+(i+1)+"' class='divLieInput' /></div>";
			            	}
							newdiv += liediv+
						"<div class='divLie' style='width:80px; text-align:center;'><a href='javascript:void(0);' onclick ='Delete("+rowCount+")'>删除</a></div></div>"+
					"</div>";
	  $("#count"+iHanCount).attr("value",(parseInt(count)+1));
	  // 在指定元素后面添加行
	  ($("#"+baseid)).before(newdiv);
	  $("#iFpIndexCount").val(parseInt(rowCount)+1);
}// 大括号结束

}
function DeleteLRow(delrowId,delz,delr){
	var vDelRow = delrowId+delz+"-"+delr;
	//alert(vDelRow);
	$("#"+vDelRow).remove();
}
//减少一行
function DeleteSignRow(id,iHanCount){

  var count = $("#count"+iHanCount).val();
  //alert("---"+count);
  var nowRow = count-1;
    if(count <= 0){
    	alert("至少有一行");
    	return false;
    }
    var rowCount = $("#iFpIndexCount").val();
  parseInt(rowCount);
  
  $("#iFpIndexCount").val(rowCount-1) ;
  //alert("rowCount = "+rowCount);
  //alert(id);
    var tt = '#'+id+iHanCount+"-"+(nowRow+1);
    //alert(tt); 
 	$(tt).remove();
 	$("#count"+iHanCount).attr("value",nowRow);
}

function Delete(rowCount){// 每次删除，把最后一个添加的DIV 下标改成现在删除的这个DIV
	var rowCountMax = $("#iFpIndexCount").val();// 获取最后的下标（最大下标）
	//alert(rowCountMax);// 获取最后的下标（最大下标）
	rowCount = parseInt(rowCount);// 获取要删除的
	//alert("获取要删除的行："+rowCount); // 获取要删除的
	rowCountMax = parseInt(rowCountMax);//转型
	//alert("最大的下标："+(rowCountMax-1));
	if(rowCountMax > rowCount){

	var inputs = new Array();
	inputs = document.getElementById("fpRepIndex"+(rowCountMax-1)).getElementsByTagName("input");
	var aTag = document.getElementById("fpRepIndex"+(rowCountMax-1)).getElementsByTagName("a");
	aTag[0].onclick=Function("Delete('"+rowCount+"')");
	//alert("aTag = "+aTag);
	// 先删除要删除的DIV元素，避免ID重复
	 $("#fpRepIndex"+rowCount).parent().remove();// 删除
	// 把之前删除的DIV元素的ID 赋值到最大的下标中
	$("#fpRepIndex"+(rowCountMax-1)).attr("id","fpRepIndex"+rowCount);
	
	var vv = $("#fpRepIndex"+(rowCountMax-1)).attr('id');
	//alert("获取最大的DIV的ID 更改后的值是："+vv);
	for(var i=0; i<inputs.length; i++){// 循环更改下标，还要更改DIV的ID
		var newname = inputs[i].name.replace("["+(rowCountMax-1)+"]","["+rowCount+"]")
		inputs[i].name=newname;
		//inputs[i].value = newname;
	}
    var divid = $("#fpRepIndex"+(rowCount)).parent().attr('id');
    //alert("divid="+divid);
    //$("#"+divid).remove();
    $("#iFpIndexCount").val(rowCountMax-1) ;

    }
}
</script>
