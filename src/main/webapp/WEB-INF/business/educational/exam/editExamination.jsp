<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <span style="font-size: 14px;">新增</span>
        </div>
        <form id="form">
            <div class="modal-body clearfix">
                <div id="layout"
                     style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span> 姓名：
                        </div>
                        <div class="col-md-4">
                            <input id="teacherInfoName" type="text" value="${examArray.teacherPersonShow}"/>
                            <input id="perId" type="hidden" value="${examArray.teacherPersonId}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>系部：
                        </div>
                        <div class="col-md-4">
                            <input id="departmentsIdSel" type="text" value="${examArray.departmentShow}" readonly/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>考试日期：
                        </div>
                        <div class="col-md-4">
                            <select id="edate"></select>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>开始时间：
                        </div>
                        <div class="col-md-4">
                            <select id="stime"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>结束时间：
                        </div>
                        <div class="col-md-4">
                            <select id="etime"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>位置：
                        </div>
                        <div class="col-md-4">
                            <input id="eplace" type="text" value="${examArray.roomShow}"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<input id="id" value="${id}" hidden>
<input id="examId" value="${examId}" hidden>
<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        addOption(eval('${select}'), "edate", '${edate}')
        $.get("<%=request.getContextPath()%>/common/getPersonDept?examId=${examId}", function (data) {
            $("#teacherInfoName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherInfoName").val(ui.item.label.split(" ---- ")[0]);
                    $("#departmentsIdSel").val(ui.item.label.split(" ---- ")[1]);
                    $("#teacherInfoName").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " START_TIME",
                text: " START_TIME ",
                tableName: "T_JW_EXAM_TIME",
                where: " WHERE EXAM_ID = '" + '${examId}' + "'",
                orderby: " order by START_TIME desc"
            },
            function (data) {
                addOption(data, "stime", '${examArray.startTime}');
            });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " END_TIME",
                text: " END_TIME ",
                tableName: "T_JW_EXAM_TIME",
                where: " WHERE EXAM_ID = '" + '${examId}' + "'",
                orderby: " order by END_TIME desc"
            },
            function (data) {
                addOption(data, "etime", '${examArray.endTime}');
            });

    });

    function save() {
        var deptId = $("#perId").val().split(",")[0];
        var personId = $("#perId").val().split(",")[1];
        if (personId == undefined) {
            deptId = '${examArray.departmentsId}';
            personId = '${examArray.teacherPersonId}';
        }
        if (personId == "" || personId == undefined || personId == null) {
            swal({
                title: "请填写教师！",
                type: "info"
            });
            return;
        }
        if ($("#edate").val() == "" || $("#edate").val() == undefined || $("#edate").val() == null) {
            swal({
                title: "请选择日期！",
                type: "info"
            });
            return;
        }
        if ($("#stime").val() == "" || $("#stime").val() == undefined || $("#stime").val() == null) {
            swal({
                title: "请选择开始时间！",
                type: "info"
            });
            return;
        }
        if ($("#etime").val() == "" || $("#etime").val() == undefined || $("#etime").val() == null) {
            swal({
                title: "请选择结束时间！",
                type: "info"
            });
            return;
        }
        if ($("#eplace").val() == "" || $("#eplace").val() == undefined || $("#eplace").val() == null) {
            swal({
                title: "请填写位置！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/exam/saveExamination", {
            id: $("#id").val(),
            teacherPersonId: personId,
            departmentsId: deptId,
            examDate: $("#edate").val(),
            startTime: $("#stime").val(),
            endTime: $("#etime").val(),
            roomShow: $("#eplace").val(),
            examId: '${examId}'
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#grid').DataTable().ajax.reload();
        })
    }
</script>



