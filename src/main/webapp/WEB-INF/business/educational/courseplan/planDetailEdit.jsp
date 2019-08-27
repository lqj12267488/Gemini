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
            <input id="planDetailsId" hidden value="${data.id}"/>
            <input id="planId" hidden value="${data.planId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="courseType" onchange="changeCourse()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="courseName"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>教材名称
                    </div>
                    <div class="col-md-9">
                        <input id="textbookName" value="${data.textbookName}"/>
                        <input type="hidden" id="textBookId" value="${data.textbookId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 理论学时
                    </div>
                    <div class="col-md-9">
                        <input id="theoreticalHours" type="number" value="${data.theoreticalHours}"
                               onchange="changeTotalHours()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 实践学时
                    </div>
                    <div class="col-md-9">
                        <input id="practiceHours" type="number" value="${data.practiceHours}"
                               onchange="changeTotalHours()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 理实结合学时
                    </div>
                    <div class="col-md-9">
                        <input id="theoryPracticeHours" onchange="changeTotalHours()" type="number" value="${data.theoryPracticeHours}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        总学时
                    </div>
                    <div class="col-md-9">
                        <input id="totalHours" type="number" value="${data.theoreticalHours}" readonly/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考核方式
                    </div>
                    <div class="col-md-9">
                        <select id="examType"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学分
                    </div>
                    <div class="col-md-9">
                        <input id="credit" value="${data.credit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 理实实践地点
                    </div>
                    <div class="col-md-9">
                        <input id="practicePlace" value="${data.practicePlace}"/>
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
    var majorCode = '${majorCode}';
    var trainingLevel = '${trainingLevel}';

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', '${data.courseType}');
        });

        if ('${data.courseType}' != "") {
            var courseType = '${data.courseType}';
            var wh = "";
            var where = "";
            if (courseType == '1' || courseType == 1) {
                wh = " WHERE TEXTBOOK_TYPE = '1'";
                where = " WHERE COURSE_TYPE = '1'";
            } else {
                wh = " WHERE TEXTBOOK_TYPE != '1' and " +
                    "MAJOR_CODE ='" + majorCode + "' and TRAINING_LEVEL = '" + trainingLevel + "'";
                where = " WHERE COURSE_TYPE != '1' and " +
                    "MAJOR_CODE ='" + majorCode + "' and TRAINING_LEVEL = '" + trainingLevel + "'";
            }
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " COURSE_ID ",
                text: " COURSE_NAME ",
                tableName: "T_JW_COURSE ",
                where: where,
                orderby: "  "
            }, function (data) {
                addOption(data, 'courseName', '${data.courseId}');
            });
        } else {
            $("#courseName").append("<option value='' selected>请选择</option>")
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KHFS", function (data) {
            addOption(data, 'examType', '${data.examType}');
        });

    })
    $.get("<%=request.getContextPath()%>/courseplan/getTextBookAll",function (res) {
        $("#textbookName").autocomplete({
            source: res,
            select: function (event, ui) {
                $("#textbookName").val(ui.item.label);
                $("#textBookId").val(ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        };
    });



    function changeCourse() {
        var where = "";
        var courseType = $("#courseType").val();
        if (courseType == '1' || courseType == 1) {
            where = " WHERE COURSE_TYPE = '"+courseType+"'";
        } else {
            where = " WHERE COURSE_TYPE = "+courseType+" and " +
                "MAJOR_CODE ='" + majorCode+"'";
        }
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " COURSE_ID ",
            text: " COURSE_NAME ",
            tableName: "T_JW_COURSE ",
            where: where,
            orderby: "  "
        }, function (data) {
            addOption(data, 'courseName', '${data.courseId}');
        });
    }

    function save() {
        var id = $("#planDetailsId").val();
        var courseType = $("#courseType").val();
        var planId = $("#planId").val();
        var courseId = $("#courseName").val();
        var courseName = $("#courseName option:selected").text();
        var textbookId = $("#textBookId").val();
        var textbookName = $("#textbookName").val();
        var theoreticalHours = $("#theoreticalHours").val();
        var practiceHours = $("#practiceHours").val();
        var theoryPracticeHours = $("#theoryPracticeHours").val();
        var totalHours = $("#totalHours").val();
        var examType = $("#examType").val();
        var credit = $("#credit").val();
        var practicePlace = $("#practicePlace").val();
        if (courseType == "" || courseType == undefined || courseType == null) {
            swal({
                title: "请选择课程类型!",
                type: "info"
            });
            return;
        }
        if (courseId == "" || courseId == undefined || courseId == null) {
            swal({
                title: "请选择课程名称!",
                type: "info"
            });
            return;
        }
        if (textbookId == "" || textbookId == undefined || textbookId == null) {
            swal({
                title: "请正确选择教材名称!",
                type: "info"
            });
            return;
        }
        if (theoreticalHours == "" || theoreticalHours == undefined || theoreticalHours == null) {
            swal({
                title: "请填写理论学时!",
                type: "info"
            });
            return;
        }
        if (practiceHours == "" || practiceHours == undefined || practiceHours == null) {
            swal({
                title: "请填写实践学时!",
                type: "info"
            });
            return;
        }

        if (theoryPracticeHours == "" || theoryPracticeHours == undefined || theoryPracticeHours == null) {
            swal({
                title: "请填写理实结合学时!",
                type: "info"
            });
            return;
        }
        if (totalHours == "" || totalHours == undefined || totalHours == null) {
            swal({
                title: "请填写总学时!",
                type: "info"
            });
            return;
        }
        if (examType == "" || examType == undefined || examType == null) {
            swal({
                title: "请选择考核方式!",
                type: "info"
            });
            return;
        }
        if (credit == "" || credit == undefined || credit == null) {
            swal({
                title: "请填写学分!",
                type: "info"
            });
            return;
        }
        if (isNaN(theoreticalHours)) {
            swal({
                title: "理论学时请填写数字!",
                type: "info"
            });
            return;
        }
        if (theoreticalHours.indexOf(".") != -1) {
            swal({
                title: "理论学时只能为整数!",
                type: "info"
            });
            return;
        }
        if (theoreticalHours < 0) {
            swal({
                title: "理论学时不能为负数!",
                type: "info"
            });
            return;
        }
        if (isNaN(theoryPracticeHours)) {
            swal({
                title: "理实结合学时请填写数字!",
                type: "info"
            });
            return;
        }
        if (theoryPracticeHours.indexOf(".") != -1) {
            swal({
                title: "理实结合学时只能为整数!",
                type: "info"
            });
            return;
        }
        if (theoryPracticeHours < 0) {
            swal({
                title: "理实结合学时不能为负数!",
                type: "info"
            });
            return;
        }
        if (isNaN(practiceHours)) {
            swal({
                title: "实践学时请填写数字!",
                type: "info"
            });
            return;
        }
        if (practiceHours.indexOf(".") != -1) {
            swal({
                title: "实践学时只能为整数!",
                type: "info"
            });
            return;
        }
        if (practiceHours < 0) {
            swal({
                title: "实践学时不能为负数!",
                type: "info"
            });
            return;
        }
        if (isNaN(credit)) {
            swal({
                title: "学分请填写数字!",
                type: "info"
            });
            return;
        }
        if ($("#practicePlace").val() == "" || $("#practicePlace").val() == null) {
            swal({
                title: "请填写理实实践地点!",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/courseplan/savePlanDetail", {
            id: id,
            courseType: courseType,
            planId: planId,
            courseId: courseId,
            courseName: courseName,
            textbookId: textbookId,
            textbookName: textbookName,
            theoreticalHours: theoreticalHours,
            practiceHours: practiceHours,
            totalHours: totalHours,
            examType: examType,
            credit: credit,
            theoryPracticeHours: theoryPracticeHours,
            practicePlace: practicePlace
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

    function changeTotalHours() {
        var theoreticalHours = $("#theoreticalHours").val();
        var practiceHours = $("#practiceHours").val();
        var theoryPracticeHours = $("#theoryPracticeHours").val();
        if (!(practiceHours == "" || theoreticalHours == "")) {
            var totalHours = eval(theoreticalHours) + eval(practiceHours)
            if(!(theoryPracticeHours == "")){
                totalHours = totalHours + eval(theoryPracticeHours);
            }
            $("#totalHours").val(totalHours);
        }

    }
</script>



