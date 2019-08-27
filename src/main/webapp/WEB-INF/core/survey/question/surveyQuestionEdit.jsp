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
            <input id="questionId" hidden value="${data.questionId}"/>
            <input id="parentQuestionId" hidden value="${data.parentQuestionId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        序号
                    </div>
                    <div class="col-md-9">
                        <input id="questionOrder" value="${data.questionOrder}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        问题
                    </div>
                    <div class="col-md-9">
                        <input id="questionName" value="${data.questionName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        答题方式
                    </div>
                    <div class="col-md-9">
                        <select id="questionType"  />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" value="${data.remark}"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DTFS", function (data) {
            addOption(data, 'questionType','${data.questionType}');
        });

    });


    function save() {
        var questionId = $("#questionId").val();
        var surveyId = $("#surveyId").val();
        var parentQuestionId = $("#parentQuestionId").val();
        var questionName = $("#questionName").val();
        var questionType = $("#questionType").val();
        var questionOrder = $("#questionOrder").val();
        var remark = $("#remark").val();
        if (questionOrder == "" || questionOrder == undefined || questionOrder == null) {
            swal({
                title: "请填写问题序号！",
                type: "info"
            });
            return;
        }
        if (questionName == "" || questionName == undefined || questionName == null) {
            swal({
                title: "请填写问题！",
                type: "info"
            });
            return;
        }
        if (questionType == "" || questionType == undefined || questionType == null) {
            swal({
                title: "请填写答题方式！",
                type: "info"
            });
            return;
        }
/*
        if (remark == "" || remark == undefined || remark == null) {
            swal({
                title: "请填写备注！",
                type: "info"
            });
            return;
        }
*/

        $.post("<%=request.getContextPath()%>/survey/question/saveSurveyQuestion", {
            questionId:questionId,
            surveyId:surveyId,
            parentQuestionId:parentQuestionId,
            questionName:questionName,
            questionType:questionType,
            questionOrder:questionOrder,
            remark:remark,
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#questiontable').DataTable().ajax.reload();
            });
        })
    }
</script>



