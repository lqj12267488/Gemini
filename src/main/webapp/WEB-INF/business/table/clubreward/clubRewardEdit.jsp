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
                        <span class="iconBtx">*</span>社团名称
                    </div>
                    <div class="col-md-9">
                        <input id="nameEdit" value="${data.name}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获奖级别
                    </div>
                    <div class="col-md-9">
                        <select id="rewardLevelEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获奖日期
                    </div>
                    <div class="col-md-9">
                        <input id="rewardDateEdit" type="month"
                               class="validate[required,maxSize[100]] form-control"
                               value="${data.rewardDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>颁奖单位
                    </div>
                    <div class="col-md-9">
                        <input id="awardUnitEdit" value="${data.awardUnit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>指导教师名单
                    </div>
                    <div class="col-md-9">
                        <input id="guidanceTeacherEdit" value="${data.guidanceTeacher}" placeholder="最多输入5名知道教师"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=HJJB", function (data) {
                addOption(data, 'rewardLevelEdit','${data.rewardLevel}');
            });
    });

    function save() {
        if ($("#nameEdit").val() == "" || $("#nameEdit").val() == undefined || $("#nameEdit").val() == null) {
            swal({
                title: "请填写社团名称！",
                type: "warning"
            });
            return;
        }
        if ($("#rewardLevelEdit").val() == "" || $("#rewardLevelEdit").val() == undefined || $("#rewardLevelEdit").val() == null) {
            swal({
                title: "请选择获奖级别！",
                type: "warning"
            });
            return;
        }
        if ($("#rewardDateEdit").val() == "" || $("#rewardDateEdit").val() == undefined || $("#rewardDateEdit").val() == null) {
            swal({
                title: "请填写获奖日期！",
                type: "warning"
            });
            return;
        }
        if ($("#awardUnitEdit").val() == "" || $("#awardUnitEdit").val() == undefined || $("#awardUnitEdit").val() == null) {
            swal({
                title: "请填写颁奖单位！",
                type: "warning"
            });
            return;
        }
        if ($("#guidanceTeacherEdit").val() == "" || $("#guidanceTeacherEdit").val() == undefined || $("#guidanceTeacherEdit").val() == null) {
            swal({
                title: "请填写指导教师名单！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/clubreward/saveClubReward", {
            id: "${data.id}",
            name: $("#nameEdit").val(),
            rewardLevel: $("#rewardLevelEdit").val(),
            rewardDate: $("#rewardDateEdit").val(),
            awardUnit: $("#awardUnitEdit").val(),
            guidanceTeacher: $("#guidanceTeacherEdit").val(),
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



