<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="answerId" hidden value="${data.answerId}"/>
            <input id="questionId" hidden value="${data.questionId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="personId" value="${data.personId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="personDept" value="${data.personDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="answerType" value="${data.answerType}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        name
                    </div>
                    <div class="col-md-9">
                        <input id="answerResult" value="${data.answerResult}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {

    });


    function save() {
        var answerId = $("#answerId").val();
        var questionId = $("#questionId").val();
        var surveyId = $("#surveyId").val();
        var personId = $("#personId").val();
        var personDept = $("#personDept").val();
        var answerType = $("#answerType").val();
        var answerResult = $("#answerResult").val();
        if (answerId == "" || answerId == undefined || answerId == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (questionId == "" || questionId == undefined || questionId == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (surveyId == "" || surveyId == undefined || surveyId == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (personId == "" || personId == undefined || personId == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (personDept == "" || personDept == undefined || personDept == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (answerType == "" || answerType == undefined || answerType == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (answerResult == "" || answerResult == undefined || answerResult == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/survey/answer/saveSurveyAnswer", {
            answerId:answerId,
            questionId:questionId,
            surveyId:surveyId,
            personId:personId,
            personDept:personDept,
            answerType:answerType,
            answerResult:answerResult,
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



