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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}</span>
            <input id="id" hidden value="${data.id}"/>
            <input id="planId" hidden value="${data.planId}"/>
            <input id="detailsId" hidden value="${data.detailsId}"/>
            <input id="courseId" hidden value="${data.courseId}"/>
            <input id="courseName" hidden value="${data.courseName}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学年
                    </div>
                    <div class="col-md-9">
                        <select id="schoolYear"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 理论周学时
                    </div>
                    <div class="col-md-9">
                        <input id="theoreticalHours" type="number" value="${data.theoreticalHours}" onchange="addHours()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 实践周学时
                    </div>
                    <div class="col-md-9">
                        <input id="practiceHours" type="number" value="${data.practiceHours}" onchange="addHours()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 理实周学时
                    </div>
                    <div class="col-md-9">
                        <input id="theorypracticeHours" type="number" value="${data.theorypracticeHours}" onchange="addHours()">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        总学时
                    </div>
                    <div class="col-md-9">
                        <input id="totleHours" value="${data.totleHours}" readonly="readonly">
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXN", function (data) {
            addOption(data, 'schoolYear', '${data.schoolYear}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data, 'term', '${data.term}');
        });
    });

    var weekNumber = 0;
    var totleHours = 0;
    var number = 0;
    var weekType = "";

    function save() {
        var id = $("#id").val();
        var planId = $("#planId").val();
        var detailsId = $("#detailsId").val();
        var courseId = $("#courseId").val();
        var courseName = $("#courseName").val();
        var schoolYear = $("#schoolYear").val();
        var term = $("#term").val();
        var totleHours = $("#totleHours").val();
        var theoreticalHours = $("#theoreticalHours").val();
        var practiceHours = $("#practiceHours").val();
        var theorypracticeHours = $("#theorypracticeHours").val();
        if (schoolYear == "" || schoolYear == undefined || schoolYear == null) {
            swal({
                title: "请填写学年!",
                type: "info"
            });
            return;
        }
        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请填写学期!",
                type: "info"
            });
            return;
        }
        if (theoreticalHours == "" || theoreticalHours == undefined || theoreticalHours == null) {
            swal({
                title: "请填写理论周学时!",
                type: "info"
            });
            return;
        }
        if (practiceHours == "" || practiceHours == undefined || practiceHours == null) {
            swal({
                title: "请填写实践周学时!",
                type: "info"
            });
            return;
        }
        if (theorypracticeHours == "" || theorypracticeHours == undefined || theorypracticeHours == null) {
            swal({
                title: "请填写理实周学时!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/courseplan/savePlanTerm", {
            id: id,
            planId: planId,
            detailsId: detailsId,
            courseId: courseId,
            courseName: courseName,
            schoolYear: schoolYear,
            term: term,
            totleHours: totleHours,
            weekType: weekType,
            theoreticalHours: theoreticalHours,
            practiceHours: practiceHours,
            theorypracticeHours: theorypracticeHours
        }, function (msg) {
            hideSaveLoading();
            swal({
                title: msg.msg,
                type: "success"
            });
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }

    function addHours() {
        var theoreticalHours = parseInt($('#theoreticalHours').val());
        var practiceHours = parseInt($('#practiceHours').val());
        var theorypracticeHours = parseInt($('#theorypracticeHours').val());
        if (isNaN(theoreticalHours)) {
            theoreticalHours = 0;
        }
        if (isNaN(practiceHours)) {
            practiceHours = 0;
        }
        if (isNaN(theorypracticeHours)) {
            theorypracticeHours = 0;
        }

        $('#totleHours').val(theoreticalHours + practiceHours + theorypracticeHours);
    }
</script>



