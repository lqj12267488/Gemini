<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <header class="mui-bar mui-bar-nav">
                        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
                        <header>调查问卷预览</header>
                    </header>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <div class="form-row" style="text-align: center"><h1 class="mui-title"> ${data.surveyTitle}</h1></div>
                    <div class="form-row">
                        <div class="col-md-12"> &nbsp;&nbsp;开始时间：${data.startTime} &nbsp;&nbsp;结束时间：${data.endTime} &nbsp;&nbsp;</div>
                    </div>
                    <div class="form-row">
                        <table class="table table-bordered table-striped table-hover text-center" >
                            <c:forEach items="${questionList}" var="questionItem">
                                <tr>
                                    <td>
                                        <div class="form-row">
                                            <div class="col-md-4">
                                                    ${questionItem.questionOrder}.${questionItem.questionName}
                                            </div>
                                            <div class="col-md-8" style="text-align:left;">
                                                <c:choose>
                                                    <c:when test="${questionItem.questionType == '1' }">
                                                        <input name="${questionItem.questionId}" type="text">
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '2' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="checkbox-inline">
                                                                <label><div class="radio">
                                                                    <span><input type="radio" name="${option.questionId}" value="${option.optionValue}"/></span>
                                                                </div> ${option.optionValue}</label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '3' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="checkbox-inline">
                                                                <label><div class="checker">
                                                                    <span><input type="checkbox" name="${option.questionId}" value="${option.optionValue}"/></span>
                                                                </div> ${option.optionValue}</label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '4' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="checkbox-inline">
                                                                <label><div class="radio">
                                                                    <span><input type="radio" name="${option.questionId}" value="${option.optionCode}"/></span>
                                                                </div> ${option.optionValue}</label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:when test="${questionItem.questionType == '5' }">
                                                        <c:forEach items="${questionItem.optionList}" var="option">
                                                            <div class="checkbox-inline">
                                                                <label><div class="checker">
                                                                    <span><input type="checkbox" name="${option.questionId}" value="${option.optionCode}"/></span>
                                                                </div> ${option.optionValue}</label>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>

                                    </td>
<%--
                                    <c:forEach items="${optionList}" var="optionItem">
                                        <td>
                                            <div id="${questionItem.questionId}-${optionItem.optionId}">0.0%&nbsp;&nbsp;(&nbsp;0&nbsp;)</div>
                                        </td>
                                    </c:forEach>
--%>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <%--
                                            <c:choose>
                                                <c:when test="${indexListSe.leafFlag == 0 }">
                                                </c:when>
                                                <c:when test="${indexListSe.leafFlag == 1 }">
                                                </c:when>
                                            </c:choose>
                    --%>
                </div>
            </div>
        </div>
    </div>
    <input id="surveyId" hidden value="${surveyId}">
</div>
<script>
    $(document).ready(function (){
        $.get("<%=request.getContextPath()%>/survey/answer/getSurveyAnswerList?surveyId="+$("#surveyId").val(), function (data) {
            $.each(data.data, function (index, content) {
                $("#"+content.questionId+"-"+content.answerResult).html(
                    content.percentage+"&nbsp;(&nbsp;"+content.checkNum+"/"+content.sumNum+"&nbsp;)");
            })
        });
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/survey/toSurveyList");
    }


</script>