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
            <span style="font-size: 14px;">${head}</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        授课计划
                    </div>
                    <div class="col-md-4">
                        <input id="planName" readonly value="${data.planName}"/>
                        <input id="planId" hidden value="${data.planId}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  周次
                    </div>
                    <div class="col-md-4">
                        <input id="week" value="${data.week}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>理论学时
                    </div>
                    <div class="col-md-4">
                        <input id="theoreticalHours" value="${data.theoreticalHours}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>实践学时
                    </div>
                    <div class="col-md-4">
                        <input id="practiceHours" value="${data.practiceHours}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 理实结合学时
                    </div>
                    <div class="col-md-4">
                        <input id="theoryPracticeHours" value="${data.theoryPracticeHours}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx"></span>
                    </div>
                    <div class="col-md-4">

                    </div>
                </div>


                <div class="col-md-8">

                </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 合计学时
                    </div>
                    <div class="col-md-4">
                        <input id="totalHours" value="${data.totalHours}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>实践上课地点
                    </div>
                    <div class="col-md-4">
                        <input id="practicePlace" value="${data.practicePlace}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 重点
                    </div>
                    <div class="col-md-4">
                        <input id="focus" value="${data.focus}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 难点
                    </div>
                    <div class="col-md-4">
                        <input id="difficulty" value="${data.difficulty}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 作业
                    </div>
                    <div class="col-md-10">
                        <input id="homework" value="${data.homework}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教学内容提要
                    </div>
                    <div class="col-md-10">
                        <textarea id="content">${data.content}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

    });


    function save() {
        var id = $("#id").val();
        var planId = $("#planId").val();
        var week = $("#week").val();
        var content = $("#content").val();
        var theoreticalHours = $("#theoreticalHours").val();
        var practiceHours = $("#practiceHours").val();
        var totalHours = $("#totalHours").val();
        var practicePlace = $("#practicePlace").val();
        var focus = $("#focus").val();
        var difficulty = $("#difficulty").val();
        var homework = $("#homework").val();
        var theoryPracticeHours= $("#theoryPracticeHours").val();

        if (planId == "" || planId == undefined || planId == null) {
            swal({
                title: "请填写授课计划！",
                type: "info"
            });
            return;
        }
        if (week == "" || week == undefined || week == null) {
            swal({
                title: "请填写周次！",
                type: "info"
            });
            return;
        }

        if (isNaN(week)) {
            swal({
                title: "周次只能为数字！",
                type: "info"
            });
            return;
        }
        if (theoreticalHours == "" || theoreticalHours == undefined || theoreticalHours == null) {
            swal({
                title: "请填写理论学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(theoreticalHours)) {
            swal({
                title: "理论学时只能为数字！",
                type: "info"
            });
            return;
        }
        if (practiceHours == "" || practiceHours == undefined || practiceHours == null) {
            swal({
                title: "请填写实践学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(practiceHours)) {
            swal({
                title: "实践学时只能为数字！",
                type: "info"
            });
            return;
        }
        if (totalHours == "" || totalHours == undefined || totalHours == null) {
            swal({
                title: "请填写合计学时！",
                type: "info"
            });
            return;
        }
        if (isNaN(totalHours)) {
            swal({
                title: "合计学时只能为数字！",
                type: "info"
            });
            return;
        }
        if (practicePlace == "" || practicePlace == undefined || practicePlace == null) {
            swal({
                title: "请填写实践上课地点！",
                type: "info"
            });
            return;
        }
        if (focus == "" || focus == undefined || focus == null) {
            swal({
                title: "请填写重点！",
                type: "info"
            });
            return;
        }
        if (difficulty == "" || difficulty == undefined || difficulty == null) {
            swal({
                title: "请填写难点！",
                type: "info"
            });
            return;
        }
        if (homework == "" || homework == undefined || homework == null) {
            swal({
                title: "请填写作业！",
                type: "info"
            });
            return;
        }
        if (content == "" || content == undefined || content == null) {
            swal({
                title: "请填写教学内容提要！",
                type: "info"
            });
            return;
        }
        if(theoryPracticeHours==""||theoryPracticeHours==undefined||theoryPracticeHours==null){
            swal({
                title: "请填写理实结合学时！",
                type: "info"
            });
            return;
        }

        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teachingPlanDetail/save", {
            id: id,
            planId: planId,
            week: week,
            content: content,
            theoreticalHours: theoreticalHours,
            practiceHours: practiceHours,
            totalHours: totalHours,
            practicePlace: practicePlace,
            focus: focus,
            difficulty: difficulty,
            homework: homework,
            theoryPracticeHours:theoryPracticeHours,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



