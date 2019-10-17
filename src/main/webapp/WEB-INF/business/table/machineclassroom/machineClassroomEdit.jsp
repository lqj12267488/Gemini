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
                        <span class="iconBtx">*</span>阅览室座位数（个）
                    </div>
                    <div class="col-md-9">
                        <input id="readingRoomSeatEdit" value="${data.readingRoomSeat}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>计算机数合计
                    </div>
                    <div class="col-md-9">
                        <input id="computerNumberEdit" value="${data.computerNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教学用计算机
                    </div>
                    <div class="col-md-9">
                        <input id="teachingComputerEdit" value="${data.teachingComputer}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>平板电脑
                    </div>
                    <div class="col-md-9">
                        <input id="tabletPcEdit" value="${data.tabletPc}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>公共机房
                    </div>
                    <div class="col-md-9">
                        <input id="publicComputerRoomEdit" value="${data.publicComputerRoom}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业机房
                    </div>
                    <div class="col-md-9">
                        <input id="professionalComputerEdit" value="${data.professionalComputer}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教室（间）
                    </div>
                    <div class="col-md-9">
                        <input id="classroomEdit" value="${data.classroom}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>网络多媒体教室
                    </div>
                    <div class="col-md-9">
                        <input id="multimediaClassroomEdit" value="${data.multimediaClassroom}"/>
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
        if ($("#readingRoomSeatEdit").val() == "" || $("#readingRoomSeatEdit").val() == undefined || $("#readingRoomSeatEdit").val() == null) {
            swal({
                title: "请填写阅览室座位数（个）！",
                type: "warning"
            });
            return;
        }
        if ($("#computerNumberEdit").val() == "" || $("#computerNumberEdit").val() == undefined || $("#computerNumberEdit").val() == null) {
            swal({
                title: "请填写计算机数合计！",
                type: "warning"
            });
            return;
        }
        if ($("#teachingComputerEdit").val() == "" || $("#teachingComputerEdit").val() == undefined || $("#teachingComputerEdit").val() == null) {
            swal({
                title: "请填写教学用计算机！",
                type: "warning"
            });
            return;
        }
        if ($("#tabletPcEdit").val() == "" || $("#tabletPcEdit").val() == undefined || $("#tabletPcEdit").val() == null) {
            swal({
                title: "请填写平板电脑！",
                type: "warning"
            });
            return;
        }
        if ($("#publicComputerRoomEdit").val() == "" || $("#publicComputerRoomEdit").val() == undefined || $("#publicComputerRoomEdit").val() == null) {
            swal({
                title: "请填写公共机房！",
                type: "warning"
            });
            return;
        }
        if ($("#professionalComputerEdit").val() == "" || $("#professionalComputerEdit").val() == undefined || $("#professionalComputerEdit").val() == null) {
            swal({
                title: "请填写专业机房！",
                type: "warning"
            });
            return;
        }
        if ($("#classroomEdit").val() == "" || $("#classroomEdit").val() == undefined || $("#classroomEdit").val() == null) {
            swal({
                title: "请填写教室（间）！",
                type: "warning"
            });
            return;
        }
        if ($("#multimediaClassroomEdit").val() == "" || $("#multimediaClassroomEdit").val() == undefined || $("#multimediaClassroomEdit").val() == null) {
            swal({
                title: "请填写网络多媒体教室！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/machineclassroom/saveMachineClassroom", {
            id: "${data.id}",
            readingRoomSeat: $("#readingRoomSeatEdit").val(),
            computerNumber: $("#computerNumberEdit").val(),
            teachingComputer: $("#teachingComputerEdit").val(),
            tabletPc: $("#tabletPcEdit").val(),
            publicComputerRoom: $("#publicComputerRoomEdit").val(),
            professionalComputer: $("#professionalComputerEdit").val(),
            classroom: $("#classroomEdit").val(),
            multimediaClassroom: $("#multimediaClassroomEdit").val(),
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



