<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">考评任务：${taskName} &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;被考评人： ${empName} </h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <c:forEach items="${eList}" var="eListFri"><!-- 循环第一层-->
                <c:choose>
                    <c:when test="${eListFri.leafFlag == 0 }">
                        <div class="form-row">
                            <div class="col-md-12" style="background:#048ADB"><%--style="background: #2FC27B"--%>
                                <b>${eListFri.indexName}</b>(满分${eListFri.fullScore})
                            </div>
                        </div>
                        <c:forEach items="${eListFri.evalList}" var="evalListSe">
                            <c:choose>
                                <c:when test="${evalListSe.leafFlag == 0 }">
                                    <div class="form-row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-11"style="background:#13A4FB" ><%--style="background: #7968EC"--%>
                                                ${evalListSe.indexName}(满分${evalListSe.fullScore})
                                        </div>
                                    </div>
                                    <c:forEach items="${evalListSe.evalList}" var="evalListTre">
                                        <div class="form-row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-10" style="background:#69C5FC"><%--style="background:#DCA0DC"--%>
                                                    ${evalListTre.indexName}(满分${evalListTre.fullScore})
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-4 tar">
                                                评分:
                                            </div>
                                            <div class="col-md-8">
                                                    ${evalListTre.score}
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-4 tar">
                                                评语:
                                            </div>
                                            <div class="col-md-8">
                                                    ${evalListTre.score}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${evalListSe.leafFlag == 1 }">
                                    <div class="form-row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-11" style="background: #13A4FB"><%--style="background: #7968EC"--%>
                                                ${evalListSe.indexName}(满分${evalListSe.fullScore})
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-4 tar">
                                            评分:
                                        </div>
                                        <div class="col-md-8">
                                                ${evalListSe.score}
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-4 tar">
                                            评语:
                                        </div>
                                        <div class="col-md-8">
                                                ${evalListSe.remark}
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                    <c:when test="${eListFri.leafFlag == 1 }">
                        <div class="form-row">
                            <div class="col-md-12" style="background: #048ADB"><%--style="background: #2FC27B"--%>
                                    ${eListFri.indexName}(满分${eListFri.fullScore})
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                评分:
                            </div>
                            <div class="col-md-8">
                                    ${eListFri.score}
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4 tar">
                                评语:
                            </div>
                            <div class="col-md-8">
                                    ${eListFri.remark}
                            </div>
                        </div>
                    </c:when>
                </c:choose>
                </c:forEach><!--end 循环第一层-->
                <div class="form-row tar">
                    <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="taskId" value="${taskId}" hidden>
<input id="empPersonId" value="${empPersonId}" hidden>
<input id="empDeptId" value="${empDeptId}" hidden>
<input id="empName" value="${empName}" hidden>
<script>


</script>