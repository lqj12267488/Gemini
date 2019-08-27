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
    <form id="dataForm" method="post" enctype="multipart/form-data">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px;">${head}&nbsp;</span>
                <input id="id" name="id" hidden value="${data.id}"/>
                <input name="teacherId" hidden/>
                <input name="teacherDeptId" hidden/>
            </div>
            <div class="modal-body clearfix">
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>姓名
                        </div>
                        <div class="col-md-9">
                            <input id="teacherId" value="${data.nameShow}" keycode="${data.teacherDeptId},${data.teacherId}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>开始时间
                        </div>
                        <div class="col-md-9">
                            <input id="startTime" name="startTime" type="date" value="${data.startTime}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>结束时间
                        </div>
                        <div class="col-md-9">
                            <input id="endTime" name="endTime" type="date" value="${data.endTime}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>授课内容
                        </div>
                        <div class="col-md-9">
                            <input id="content" name="content" value="${data.content}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>授课地点
                        </div>
                        <div class="col-md-9">
                            <input id="place" name="place" value="${data.place}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>授课人群
                        </div>
                        <div class="col-md-9">
                            <input id="crowd" name="crowd" value="${data.crowd}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>授课人数
                        </div>
                        <div class="col-md-9">
                            <input id="sum" name="sum" type="number" value="${data.sum}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>课时数
                        </div>
                        <div class="col-md-9">
                            <input id="timeSum" name="timeSum" type="number" value="${data.timeSum}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件上传
                        </div>
                        <div class="col-md-9">
                            <input type="button" name="file" value="点击上传" onclick="addFiles()"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件名称
                        </div>
                        <div class="col-md-9">
                            <span>${filesName}</span>
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
    </form>
</div>

<script>

    $(document).ready(function () {
        autoComplateOption("teacherId", "/common/getPersonDeptByPname");
    });


    function save() {
        var id = $("#id").val();
        var teacherId = $("#teacherId").attr("keycode").split(",")[1];
        var teacherDeptId = $("#teacherId").attr("keycode").split(",")[0];
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var content = $("#content").val();
        var place = $("#place").val();
        var crowd = $("#crowd").val();
        var sum = $("#sum").val();
        var timeSum = $("#timeSum").val();

        $("input[name=teacherId]").val(teacherId);
        $("input[name=teacherDeptId]").val(teacherDeptId);

        if (teacherId == "" || teacherId == undefined || teacherId == null) {
            swal({
                title: "请填写教师名称！",
                type: "info"
            });
            return;
        }
        if (startTime == "" || startTime == undefined || startTime == null) {
            swal({
                title: "请填写开始时间！",
                type: "info"
            });
            return;
        }
        if (endTime == "" || endTime == undefined || endTime == null) {
            swal({
                title: "请填写结束时间！",
                type: "info"
            });
            return;
        }
        if (content == "" || content == undefined || content == null) {
            swal({
                title: "请填写授课内容！",
                type: "info"
            });
            return;
        }
        if (place == "" || place == undefined || place == null) {
            swal({
                title: "请填写授课地点！",
                type: "info"
            });
            return;
        }
        if (crowd == "" || crowd == undefined || crowd == null) {
            swal({
                title: "请填写授课人群！",
                type: "info"
            });
            return;
        }
        if (sum == "" || sum == undefined || sum == null) {
            swal({
                title: "请填写授课人数！",
                type: "info"
            });
            return;
        }
        if (sum.indexOf(".") > -1) {
            swal({
                title: "授课人数只能输入整数！",
                type: "info"
            });
            return;
        }
        if (sum < 1) {
            swal({
                title: "授课人数只能输入正整数！",
                type: "info"
            });
            return;
        }
        if (timeSum == "" || timeSum == undefined || timeSum == null) {
            swal({
                title: "请填写课时数！",
                type: "info"
            });
            return;
        }
        if (timeSum < 1) {
            swal({
                title: "课时数只能正整数！",
                type: "info"
            });
            return;
        }
        if (timeSum.indexOf(".") > -1) {
            swal({
                title: "课时数只能输入整数！",
                type: "info"
            });
            return;
        }

        var from = new FormData(document.getElementById("dataForm"));

        $.ajax({
            type: "post",
            url: "<%=request.getContextPath()%>/educational/expatriateTeaching/updateExpatriateTeaching",
            processData: false,  //tell jQuery not to process the data
            contentType: false,  //tell jQuery not to set contentType
            data: from,
            success: function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $("#dialog").modal('hide');
                    $('#table').DataTable().ajax.reload();
                });
            }
        });
    }
    function addFiles() {
        var id = $("#id").val();
        $("#dialogFile").load("<%=request.getContextPath()%>/files/filesUpload?businessId="+id+"&businessType=TEST&tableName=T_JW_EXPATRIATE_TEACHING");
        $("#dialogFile").modal("show");
    }
</script>



