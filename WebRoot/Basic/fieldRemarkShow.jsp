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
<!-- Style Start -->


<div>
	<!-- FieldRemark Start -->
	<c:if test="${listallf != null}">
	<c:forEach items="${listallf}" var="listfr" >
	<c:if test="${listfr.beanNames==beanName}">
    	<div class="divFJ" style="text-align:center;">
        	<div class="divHang" style="border-left:1px #9CF solid; text-align:left;background-color:#C9E9F1; ">
            	<div class="divLie" style="width:90%">
                	<font color="#1945F8" style="margin-left:10px; font-weight: bolder;">${listfr.name}</font>
                </div>
            </div>
            
        	<div class="divHang" >
            	<div class="divLie" style="width:80px; text-align:center;font-weight: bolder;color:#1945F8; ">
                	ÐòºÅ
                </div >
                <c:if test="${listfr.temp1 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp1}
                </div>
                </c:if>
                <c:if test="${listfr.temp2 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp2}
                </div>
                </c:if>
                <c:if test="${listfr.temp3 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp3}
                </div>
                </c:if>
                <c:if test="${listfr.temp4 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp4}
                </div>
                </c:if>
                <c:if test="${listfr.temp5 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp5}
                </div>
                </c:if>
                <c:if test="${listfr.temp6 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp6}
                </div>
                </c:if>
                <c:if test="${listfr.temp7 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp7}
                </div>
                </c:if>
                <c:if test="${listfr.temp8 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp8}
                </div>
                </c:if>
                <c:if test="${listfr.temp9 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp9}
                </div>
                </c:if>
                <c:if test="${listfr.temp10 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp10}
                </div>
                </c:if>
                <c:if test="${listfr.temp11 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp11}
                </div>
                </c:if>
                <c:if test="${listfr.temp12 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp12}
                </div>
                </c:if>
                <c:if test="${listfr.temp13 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp13}
                </div>
                </c:if>
                <c:if test="${listfr.temp14 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp14}
                </div>
                </c:if>
                <c:if test="${listfr.temp15 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp15}
                </div>
                </c:if>
                <c:if test="${listfr.temp16 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp16}
                </div>
                </c:if>
                <c:if test="${listfr.temp17 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp17}
                </div>
                </c:if>
                <c:if test="${listfr.temp18 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp18}
                </div>
                </c:if>
                <c:if test="${listfr.temp19 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp19}
                </div>
                </c:if>
                <c:if test="${listfr.temp20 != null}">
            	<div class="divLie" style="font-weight: bolder;color:#1945F8;">
                	${listfr.temp20}
                </div>
                </c:if>
            </div>
			
            <%int i=1; %>
            <c:if test="${listfr != null}">
            <c:forEach items="${listfr.fieldProperties}" var="item" varStatus="status">
            <c:if test="${item.beanUuid == empDetial.uuid}">
            <div id="branch" class="divHang" style="color:gray;">
            	<div class="divLie" style="width:80px; text-align:center;">
            		<%=i%>
                </div>
                <c:if test="${item.temp1 != null}">
            	<div class="divLie">
                	${item.temp1 }
                </div>
                </c:if>
                <c:if test="${item.temp2 != null}">
            	<div class="divLie">
                	${item.temp2 }
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
            </div>
            <%i++; %>
            </c:if>
            </c:forEach>
            <div style="border-left:1px #9CF solid; border-bottom:1px #9CF solid;"></div>
            </c:if>
        </div>
    </c:if>
    </c:forEach>
    </c:if>
    <!-- FieldRemark End -->
    </div>







