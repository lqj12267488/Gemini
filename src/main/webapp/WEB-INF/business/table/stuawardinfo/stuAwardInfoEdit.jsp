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
                        <span class="iconBtx">*</span>项目名称
                    </div>
                    <div class="col-md-9">
                        <input id="saiProNameEdit" value="${data.saiProName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>项目类别
                    </div>
                    <div class="col-md-9">
                        <select id="saiProTypeEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>级别
                    </div>
                    <div class="col-md-9">
                        <select id="saiLevelEdit"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>获奖日期
                    </div>
                    <div class="col-md-9">
                        <input id="awardTimeEdit" value="${data.awardTime}" type="date"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学生名单
                    </div>
                    <div class="col-md-9">
                        <input id="studentListEdit" value="${data.studentList}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>指导老师名单
                    </div>
                    <div class="col-md-9">
                        <input id="coachEdit" value="${data.coach}"/>
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
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=	XSHJXMLB", function (data) {
                addOption(data, 'saiProTypeEdit','${data.saiProType}');
            });
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=JB", function (data) {
                addOption(data, 'saiLevelEdit','${data.saiLevel}');
            });
    });

    function save() {
        if ($("#saiProNameEdit").val() == "" || $("#saiProNameEdit").val() == undefined || $("#saiProNameEdit").val() == null) {
            swal({
                title: "请填写项目名称（全称）！",
                type: "warning"
            });
            return;
        }
        if ($("#saiProTypeEdit").val() == "" || $("#saiProTypeEdit").val() == undefined || $("#saiProTypeEdit").val() == null) {
            swal({
                title: "请选择项目类别{	xshjxmlb}！",
                type: "warning"
            });
            return;
        }
        if ($("#saiLevelEdit").val() == "" || $("#saiLevelEdit").val() == undefined || $("#saiLevelEdit").val() == null) {
            swal({
                title: "请选择级别{jb}！",
                type: "warning"
            });
            return;
        }
        if ($("#awardTimeEdit").val() == "" || $("#awardTimeEdit").val() == undefined || $("#awardTimeEdit").val() == null) {
            swal({
                title: "请填写获奖日期！",
                type: "warning"
            });
            return;
        }
        if ($("#studentListEdit").val() == "" || $("#studentListEdit").val() == undefined || $("#studentListEdit").val() == null) {
            swal({
                title: "请填写学生名单！",
                type: "warning"
            });
            return;
        }
        if ($("#coachEdit").val() == "" || $("#coachEdit").val() == undefined || $("#coachEdit").val() == null) {
            swal({
                title: "请填写指导老师名单！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/StuAwardInfo/saveStuAwardInfo", {
            id: "${data.id}",
            saiProName: $("#saiProNameEdit").val(),
            saiProType: $("#saiProTypeEdit").val(),
            saiLevel: $("#saiLevelEdit").val(),
            awardTime: $("#awardTimeEdit").val(),
            studentList: $("#studentListEdit").val(),
            coach: $("#coachEdit").val(),
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



