<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<link href="<%=request.getContextPath() %>/product_manage/css/outproperty.css" type="text/css"
			media="screen" rel="stylesheet">
<script type="text/javascript">
<!--
   function showp1(id,pm){
		 //  alert("at="+id+","+pm);
			if(pm==2){
			       //alert("m="+$('#grade'+id+'>ul>li').length+","+$('#py'+id).html());
					if($('#grade'+id+'>ul>li').length>0){
						$('#py'+id).show();
				    	$('#xz_k100').html($('#py'+id).html());
						$('#py'+id).hide();
					    $('#xz_k100').show();
					}else{
					    $('#sdp'+id).hide();
					    $('#xz_k100').hide(); 
					    $('#xz_k101').hide();
			        	$('#xz_k102').hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
					 }
			}else if(pm==3){
			   if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
					    $('#xz_k101').hide();
			        	$('#xz_k102').hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			   }else{
			    $('#py'+id).show();
			    $('#xz_k101').html($('#py'+id).html());
				$('#py'+id).hide();
				$('#xz_k101').show();
			  }
			}else if(pm==4){
			    if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k102').hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			   }else{
			    $('#py'+id).show();
			    $('#xz_k102').html($('#py'+id).html());
				$('#py'+id).hide();
				$('#xz_k102').show();
				}
			}else if(pm==5){
			   if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			    }else{
				    $('#py'+id).show();
				    $('#xz_k103').html($('#py'+id).html());
					$('#py'+id).hide();
					$('#xz_k103').show();
				}
			}else if(pm==6){
			    if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			    }else{
			   		 $('#py'+id).show();
			   		 $('#xz_k104').html($('#py'+id).html());
					 $('#py'+id).hide();
				     $('#xz_k104').show();
				}
			}else if(pm==7){
			    if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k105').hide();
			    }else{
				    $('#py'+id).show();
				    $('#xz_k105').html($('#py'+id).html());
					$('#py'+id).hide();
					$('#xz_k105').show();
				}
			}
			else{
				  
		    }
		}

//-->
</script>
<div id="mains2">
				<div class="bd_bj">
								<table border="0" cellspacing="0" cellpadding="0" id="tb_hg">
								  <tr> 
								    <td>
									 <div id="xz_k1">
									  <ul>
									    <c:if test="${empty gods_dt}">
									        <h3>暂未找到你想要的数据.</h3>
									        <div style="float: right;"><input type="button" value="返回类目" onclick="parent.showorhide()"/></div>
									    </c:if>
									    <c:if test="${gods_dt !=null}">
								         <c:forEach items="${gods_dt}" var="gods">
								         <li>
									    <a href="javascript:;" id="${gods.key}" 
										onclick="showp1(this.name,2)" name="${gods.key}"  ondblclick="parent.f2(this.name,2)"/>${gods.value }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${gods.key}">>></span></a>
										</li><!-- 111 -->
										<div id="py${gods.key}" style="display:none;">
									    <div id="grade${gods.key}">
									    <ul>
										<c:forEach items="${good_list }" var="gods1">
										      <c:if test="${gods1.gdSuperId eq gods.key}">
										      <li>
											    <a href="javascript:;" id="${gods1.gdId}" 
												 onclick="showp1(this.name,3)" name="${gods.key}&${gods1.gdId}"  ondblclick="parent.f2(this.name,2)"/>${gods1.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${gods1.gdId}">>></span></a>
												</li><!-- 111 -->
												<div id="py${gods1.gdId }" style="display:none;">
												    <div id="grade${gods1.gdId }">
												    <ul>
													<c:forEach items="${good_list }" var="gods2">
													      <c:if test="${gods2.gdSuperId eq gods1.gdId}">
													      <li>
														    <a href="javascript:;" id="${gods2.gdId}" 
															 onclick="showp1(this.name,4)" name="${gods.key}&${gods1.gdId}&${gods2.gdId}"  ondblclick="parent.f2(this.name,2)"/>${gods2.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${gods2.gdId}">>></span></a>
															</li><!-- 111 -->
															<div id="py${gods2.gdId }" style="display:none;">
															    <div id="grade${gods2.gdId }">
															    <ul>
																<c:forEach items="${good_list }" var="gods3">
																      <c:if test="${gods3.gdSuperId eq gods2.gdId}">
																      <li>
																	    <a href="javascript:;" id="${gods3.gdId}" 
																		 onclick="showp1(this.name,5)" name="${gods.key}&${gods1.gdId}&${gods2.gdId}&${gods3.gdId}"  ondblclick="parent.f2(this.name,2)"/>${gods3.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${gods3.gdId}">>></span></a>
																		</li><!-- 111 -->
																		<div id="py${gods3.gdId }" style="display:none;">
																		    <div id="grade${gods3.gdId }">
																		    <ul>
																			<c:forEach items="${good_list }" var="gods4">
																			      <c:if test="${gods4.gdSuperId eq gods3.gdId}">
																			      <li>
																				    <a href="javascript:;" id="${gods4.gdId}" 
																					 onclick="showp1(this.name,6)" name="${gods.key}&${gods1.gdId}&${gods2.gdId}&${gods3.gdId}&${gods4.gdId}"  ondblclick="parent.f2(this.name,2)"/>${gods4.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${gods4.gdId}">>></span></a>
																					</li><!-- 111 -->
																					<div id="py${gods4.gdId }" style="display:none;">
																					    <div id="grade${gods4.gdId }">
																					    <ul>
																						<c:forEach items="${good_list }" var="gods5">
																						      <c:if test="${gods5.gdSuperId eq gods4.gdId}">
																						      <li>
																							    <a href="javascript:;" id="${gods5.gdId}" 
																								 name="${gods.key}&${gods1.gdId}&${gods2.gdId}&${gods3.gdId}&${gods4.gdId}&${gods5.gdId}"  ondblclick="parent.f2(this.name,2)"/>${gods5.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${gods5.gdId}">>></span></a>
																								</li><!-- 111 -->
																						      </c:if>
																						</c:forEach>
																						</ul>
																						</div>
																						</div><!-- 66666-->
																			      </c:if>
																			</c:forEach>
																			</ul>
																			</div>
																			</div><!-- 55555-->
																      </c:if>
																</c:forEach>
																</ul>
																</div>
																</div><!-- 4444-->
													      </c:if>
													</c:forEach>
													</ul>
													</div>
													</div><!-- 33333-->
										      </c:if>
										</c:forEach>
										</ul>
										</div>
										</div><!-- 2222 -->
								        </c:forEach>
								        </c:if>
									  </ul>
									</div>
								 </td>
								 <td>
								     <div id="xz_k100"  style="display:none">
								     </div>
								 </td>
								 <td>
								      <div id="xz_k101"  style="display:none">
								     </div>
								 </td>
								 <td>
								     <div id="xz_k102"  style="display:none">
								     </div>
								 </td>
								 <td>
								     <div id="xz_k103"  style="display:none">
								     </div>
								 </td>
								 <td>
								     <div id="xz_k104"  style="display:none">
								     </div>
								 </td>
								  <td>
								     <div id="xz_k105"  style="display:none">
								     </div>
								</td>
							</tr>
							</table>
							</div>
</div>
