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
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生id
                    </div>
                    <div class="col-md-9">
                        <input id="studentId" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               class="validate[required,maxSize[100]] form-control" value="${data.studentIdShow}"/>
                        <input id="studentIdEdit" type="hidden" value="${data.studentId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>资格证书
                    </div>
                    <div class="col-md-9">
                        <select id="qualificationIdEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>社会培训天数
                    </div>
                    <div class="col-md-9">
                        <input id="trainDayEdit" type="number" min="0" value="${data.trainDay}"/>
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

        $.get("<%=request.getContextPath()%>/qualification/getQualificationBySelect", function (data) {
            addOption(data, 'qualificationIdEdit','${data.qualificationId}');
        });
        $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
            $("#studentId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#studentId").val(ui.item.label.split(" ---- ")[0]);
                    $("#studentId").attr("keycode", ui.item.value);
                    $("#studentIdEdit").val(ui.item.value.split(",")[1]);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
    });

    function save() {
        if ($("#studentIdEdit").val() == "" || $("#studentIdEdit").val() == undefined || $("#studentIdEdit").val() == null) {
            swal({
                title: "请填写学生！",
                type: "warning"
            });
            return;
        }
        if ($("#qualificationIdEdit").val() == "" || $("#qualificationIdEdit").val() == undefined || $("#qualificationIdEdit").val() == null) {
            swal({
                title: "请填写资格证书！",
                type: "warning"
            });
            return;
        }
        if ($("#trainDayEdit").val() == "" || $("#trainDayEdit").val() == undefined || $("#trainDayEdit").val() == null) {
            swal({
                title: "请填写社会培训天数！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/qualificationtrain/saveQualificationTrain", {
            id: "${data.id}",
            studentId: $("#studentIdEdit").val(),
            qualificationId: $("#qualificationIdEdit").val(),
            trainDay: $("#trainDayEdit").val(),
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



