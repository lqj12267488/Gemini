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
            <input id="optionId" hidden value="${data.optionId}"/>
            <input id="surveyId" hidden value="${data.surveyId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        序号
                    </div>
                    <div class="col-md-9">
                        <input id="optionOrder" value="${data.optionOrder}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        选项内容
                    </div>
                    <div class="col-md-9">
                        <input id="optionValue" value="${data.optionValue}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        选项分值
                    </div>
                    <div class="col-md-9">
                        <input id="optionCode" value="${data.optionCode}"/>
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
        var optionId = $("#optionId").val();
        var surveyId = $("#surveyId").val();
        var optionCode = $("#optionCode").val();
        var optionValue = $("#optionValue").val();
        var optionOrder = $("#optionOrder").val();
        if (optionValue == "" || optionValue == undefined || optionValue == null) {
            swal({
                title: "请填写选项内容！",
                type: "info"
            });
            return;
        }
        if (optionOrder == "" || optionOrder == undefined || optionOrder == null) {
            swal({
                title: "请填写序号！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/survey/option/saveSurveyOption", {
            optionId:optionId,
            surveyId:surveyId,
            optionCode:optionCode,
            optionValue:optionValue,
            optionOrder:optionOrder,
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#optiontable').DataTable().ajax.reload();
            });
        })
    }
</script>



