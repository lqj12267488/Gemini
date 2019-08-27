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
                        <header>调查问卷填写</header>
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
                            <tr>
                                <td></td>
                                <c:forEach items="${optionList}" var="optionItem">
                                    <td>${optionItem.optionValue}</td>
                                </c:forEach>
                            </tr>
                            <c:forEach items="${questionList}" var="questionItem">
                                <tr>
                                    <td>
                                        ${questionItem.questionOrder}.${questionItem.questionName}
                                    </td>
                                    <c:forEach items="${optionList}" var="optionItem">
                                        <td>
                                            <label><input style="width: 20px" type="radio" value="${optionItem.optionId}" name="${questionItem.questionId}"/></label>
                                        </td>
                                    </c:forEach>
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
                    <div class="form-row" style="text-align: center ">
                        <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
                        </button>
                        <button type="button" class="btn btn-default btn-clean" onclick="back()">返回
                        </button>
                    </div>

                </div>
            </div>
        </div>
        <input hidden id="surveyId" value="${surveyId}">
    </div>
</div>
<script>

    var questionList =  eval('${questionListMap}');

    function save() {
        var surveyId = $("#surveyId").val();
        var answerResult ="";
        var msg = "";
        $.each(questionList, function (index, content) {
            var checkValue = $("input[name="+content.questionId+"]:checked").val();
            if(undefined != checkValue ){
                if(answerResult ==""){
                    answerResult = content.questionId+","+checkValue;
                }else{
                    answerResult = answerResult+"@"+content.questionId+","+checkValue;
                }
            }else{
                msg =  "请填写第"+content.questionOrder+"题";
                return;
            }
        })
        if( msg != ""){
            swal({title: msg, type: "info"});
            return;
        }

        console.log("   answerResult --> "+answerResult);

        $.post("<%=request.getContextPath()%>/survey/answer/saveSurveyAnswer", {
            surveyId:surveyId,
            answerResult:answerResult,
            answerType:'1',
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#right").load("<%=request.getContextPath()%>/survey/toSurveyListPerson");
            });
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/survey/toSurveyListPerson");
    }

</script>