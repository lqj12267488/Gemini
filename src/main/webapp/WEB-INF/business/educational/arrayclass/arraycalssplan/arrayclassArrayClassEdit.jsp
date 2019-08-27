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
            <input id="arrayId" hidden value="${data.arrayId}"/>
            <input id="arrayclassId" hidden value="${data.arrayclassId}"/>
            <input id="classId" hidden value="${data.classId}"/>
            <input id="roomIdHiden" hidden value="${data.roomId}"/>
            <input id="departmentsId" hidden value="${data.departmentsId}"/>
            <input id="majorCode" hidden value="${data.majorCode}"/>
            <input id="majorDirection" hidden value="${data.majorDirection}"/>
            <input id="trainingLevel" hidden value="${data.trainingLevel}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程类型
                    </div>
                    <div class="col-md-9">
                        <select id="courseType" onchange="changeCourseType()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        课程
                    </div>
                    <div class="col-md-9">
                        <select id="courseId" onchange="changeCourse()"/>
                    </div>
                </div>
                <c:if test="${data.roomId == null || data.roomId == ''}">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>
                            教室
                        </div>
                        <div class="col-md-9">
                            <select id="roomId"/>
                        </div>
                    </div>
                </c:if>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        授课教师
                    </div>
                    <div class="col-md-9">
                        <select id="teacherPersonId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        相连课时数
                    </div>
                    <div class="col-md-9">
                        <input id="connectHours" value="${data.connectHours}"/>
                    </div>
                </div>
                <%--<div class="form-row">
                    <div class="col-md-3 tar">
                        合班分组标识
                    </div>
                    <div class="col-md-9">
                        <select id="mergeFlag"/>
                    </div>
                </div>--%>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', '${data.courseType}');
        });
        if ('${data.courseType}' != "") {
            var courseType = '${data.courseType}';
            var majorCode = $("#majorCode").val();
            var majorDirection = $("#majorDirection").val();
            var trainingLevel = $("#trainingLevel").val();
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " DISTINCT t1.COURSE_ID ",
                text: " t2.COURSE_NAME ",
                tableName: "T_JW_ARRAYCLASS_COURSE t1,T_JW_COURSE t2 ",
                where: " where t1.COURSE_ID = t2.COURSE_ID and ARRAYCLASS_ID = '${data.arrayclassId}'  and t1.COURSE_TYPE = '" + courseType + "'",
                orderby: " "
            }, function (data) {
                addOption(data, 'courseId', '${data.courseId}');
            })
        } else {
            $("#courseId").append("<option value='' selected>请选择</option>")
        }

        if ("${data.teacherPersonId}" != "") {
            var courseId = '${data.courseId}';
            var majorCode = $("#majorCode").val();
            var trainingLevel = $("#trainingLevel").val();
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " DISTINCT t2.TEACHER_PERSON_ID || ',' || t2.TEACHER_DEPT_ID ",
                text: " t3.NAME ",
                tableName: " T_JW_ARRAYCLASS_TEACHER_COURSE t2, T_RS_EMPLOYEE t3 ",
                where: " WHERE t2.TEACHER_PERSON_ID = t2.TEACHER_PERSON_ID AND t2.TEACHER_PERSON_ID = t3.PERSON_ID " +
                " and t2.COURSE_ID = '" + courseId + "' and arrayclass_id = '${data.arrayclassId}'",
                orderby: " "
            }, function (data) {
                addOption(data, 'teacherPersonId', '${data.teacherPersonId},${data.teacherDeptId}');
            })
        } else {
            $("#teacherPersonId").append("<option value='' selected>请选择</option>")
        }
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ROOM_ID ",
            text: " ROOM_NAME ",
            tableName: "T_JW_ARRAYCLASS_ROOM ",
            where: " where CLASS_ID = '" + $("#classId").val() + "'",
            orderby: " "
        }, function (data) {
            addOption(data, 'roomId', '${data.roomId}');
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HBFZ", function (data) {
            addOption(data, 'mergeFlag', '${data.mergeFlag}');
        });

    });

    function changeCourseType() {
        var courseType = $("#courseType").val();
        var majorCode = $("#majorCode").val();
        var majorDirection = $("#majorDirection").val();
        var trainingLevel = $("#trainingLevel").val();
        var where = " where t1.COURSE_ID = t2.COURSE_ID and ARRAYCLASS_ID = '${data.arrayclassId}'  and t1.COURSE_TYPE = '" + courseType + "'";
        if (courseType != "1") {
            where += " and t1.MAJOR_CODE = '" + majorCode + "' and t1.TRAINING_LEVEL = '" + trainingLevel + "'";
        }
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " DISTINCT t1.COURSE_ID ",
            text: " t2.COURSE_NAME ",
            tableName: "T_JW_ARRAYCLASS_COURSE t1,T_JW_COURSE t2 ",
            where: where,
            orderby: " "
        }, function (data) {
            addOption(data, 'courseId');
        })
    }

    function changeCourse() {
        var courseId = $("#courseId").val();
        var majorCode = $("#majorCode").val();
        var trainingLevel = $("#trainingLevel").val();
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " DISTINCT t2.TEACHER_PERSON_ID || ',' || t2.TEACHER_DEPT_ID ",
            text: " t3.NAME ",
            tableName: " T_JW_ARRAYCLASS_TEACHER_COURSE t2, T_RS_EMPLOYEE t3 ",
            where: " WHERE t2.TEACHER_PERSON_ID = t2.TEACHER_PERSON_ID  AND t2.TEACHER_PERSON_ID = t3.PERSON_ID " +
            " and t2.COURSE_ID = '" + courseId + "' and arrayclass_id = '${data.arrayclassId}'",
            orderby: " "
        }, function (data) {
            addOption(data, 'teacherPersonId');
        })
    }

    function save() {
        var arrayId = $("#arrayId").val();
        var arrayclassId = $("#arrayclassId").val();
        var classId = $("#classId").val();
        var courseType = $("#courseType").val();
        var courseId = $("#courseId").val();
        var roomId = $("#roomIdHiden").val();
        var teacherPersonId = $("#teacherPersonId").val().split(",")[0];
        var teacherDeptId = $("#teacherPersonId").val().split(",")[1];
        var connectHours = $("#connectHours").val();
        var mergeFlag = $("#mergeFlag").val();
        var departmentsId = $("#departmentsId").val();
        var majorCode = $("#majorCode").val();
        var majorDirection = $("#majorDirection").val();
        var trainingLevel = $("#trainingLevel").val();
        if (courseType == "" || courseType == undefined || courseType == null) {
            swal({
                title: "请选择课程类型！",
                type: "info"
            });
            return;
        }
        if (courseId == "" || courseId == undefined || courseId == null) {
            swal({
                title: "请选择课程！",
                type: "info"
            });
            return;
        }
        <c:if test="${data.roomId == null || data.roomId == ''}">
        roomId = $("#roomId").val();
        if (roomId == "" || roomId == undefined || roomId == null) {
            swal({
                title: "请选择教室！",
                type: "info"
            });
            return;
        }
        </c:if>
        if (teacherPersonId == "" || teacherPersonId == undefined || teacherPersonId == null) {
            swal({
                title: "请选择授课教师！",
                type: "info"
            });
            return;
        }
        if (connectHours == "" || connectHours == undefined || connectHours == null) {
            swal({
                title: "请填写相连课时数！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/arrayclassplan/getCourseById", {
            arrayClassId: '${data.arrayclassId}',
            courseType: courseType,
            courseID: courseId,
            majorCode: majorCode,
            trainingLevel: trainingLevel,
        }, function (course) {
            var weekType = course.weekType;
            var startWeek = course.startWeek;
            var endWeek = course.endWeek;
            var weekHours = course.weekHours;
            $.post("<%=request.getContextPath()%>/arrayclassplan/saveArrayclassArray", {
                arrayId: arrayId,
                arrayclassId: arrayclassId,
                departmentsId: departmentsId,
                majorCode: majorCode,
                majorDirection: majorDirection,
                trainingLevel: trainingLevel,
                classId: classId,
                courseType: courseType,
                courseId: courseId,
                roomId: roomId,
                teacherPersonId: teacherPersonId,
                teacherDeptId: teacherDeptId,
                weekType: weekType,
                startWeek: startWeek,
                endWeek: endWeek,
                weekHours: weekHours,
                connectHours: connectHours,
                mergeFlag: mergeFlag,
            }, function (msg) {
                hideSaveLoading();
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            })
        })
    }
</script>



