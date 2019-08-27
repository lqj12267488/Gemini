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
            <input id="teacherPersonId" hidden value="${data.teacherPersonId}"/>
            <input id="teacherDeptId" hidden value="${data.teacherDeptId}"/>
            <input id="arrayclassTeacherId" hidden value="${arrayclassTeacherId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorCode" onchange="changeClass()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        班级
                    </div>
                    <div class="col-md-9">
                        <select id="classId"/>
                    </div>
                </div>
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
                        <select id="courseId" onchange="changeRoom()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        教室
                    </div>
                    <div class="col-md-9">
                        <select id="roomId" value="${data.roomId}"/>
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
                <div class="form-row">
                    <div class="col-md-3 tar">
                        合班分组标识
                    </div>
                    <div class="col-md-9">
                        <select id="mergeFlag"/>
                    </div>
                </div>
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
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var deptId = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCode', '${data.majorCode},${data.trainingLevel}');
            });
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }

        if ('${data.majorCode}' != "") {
            var majorCode = '${data.majorCode}';
            var trainingLevel = '${data.trainingLevel}';
            var majorDirection = '${data.majorDirection}';
            $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + majorCode + "&trainingLevel=" +
                trainingLevel, function (data) {
                addOption(data, 'classId', '${data.classId}');
            });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>")
        }
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KCLX", function (data) {
            addOption(data, 'courseType', '${data.courseType}');
        });
        if ('${data.courseType}' != "") {
            var courseType = '${data.courseType}';
            $.post("<%=request.getContextPath()%>/common/getTableDict", {
                id: " t1.COURSE_ID ",
                text: " t2.COURSE_NAME ",
                tableName: " T_JW_ARRAYCLASS_TEACHER_COURSE t1, T_JW_COURSE t2 ",
                where: " WHERE t1.COURSE_ID = t2.COURSE_ID AND t1.TEACHER_PERSON_ID = '" +
                $("#teacherPersonId").val() + "' AND t1.TEACHER_DEPT_ID = '" + $("#teacherDeptId").val() + "'",
                orderby: " "
            }, function (data) {
                addOption(data, 'courseId', '${data.courseId}');
            })
        } else {
            $("#courseId").append("<option value='' selected>请选择</option>")
        }

        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ROOM_ID ",
            text: " ROOM_NAME ",
            tableName: "T_JW_ARRAYCLASS_ROOM ",
            where: " where 1 = 1",
            orderby: " "
        }, function (data) {
            addOption(data, 'roomId', '${data.roomId}');
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=HBFZ", function (data) {
            addOption(data, 'mergeFlag', '${data.mergeFlag}');
        });
    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCode');
        });
    }

    function changeClass() {
        var majorCode = $("#majorCode").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + arr[0] + "&trainingLevel=" + arr[1], function (data) {
            addOption(data, 'classId');
        });
    }

    function changeRoom() {
        $.post("<%=request.getContextPath()%>/common/getTableDict", {
            id: " ROOM_ID ",
            text: " ROOM_NAME ",
            tableName: "T_JW_ARRAYCLASS_ROOM ",
            where: " where 1 = 1",
            orderby: " "
        }, function (data) {
            addOption(data, 'roomId');
        })
    }

    function changeCourseType() {
        var courseType = $("#courseType").val();
        var majorCode = $("#majorCode").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " DISTINCT t1.COURSE_ID ",
            text: " t2.COURSE_NAME ",
            tableName: "T_JW_ARRAYCLASS_COURSE t1,T_JW_COURSE t2 ",
            where: " where t1.COURSE_ID = t2.COURSE_ID  and t1.COURSE_TYPE = '" + courseType + "'",
            orderby: " "
        }, function (data) {
            addOption(data, 'courseId');
        })
    }

    function save() {
        var arrayId = $("#arrayId").val();
        var arrayclassId = $("#arrayclassId").val();
        var classId = $("#classId").val();
        var courseType = $("#courseType").val();
        var courseId = $("#courseId").val();
        var roomId = $("#roomId").val();
        var teacherPersonId = $("#teacherPersonId").val();
        var teacherDeptId = $("#teacherDeptId").val();
        var connectHours = $("#connectHours").val();
        var mergeFlag = $("#mergeFlag").val();
        var departmentsId = $("#departmentsId").val();
        var majorCode = $("#majorCode").val();
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
        if (roomId == "" || roomId == undefined || roomId == null) {
            swal({
                title: "请选择教室！",
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
        var arr = majorCode.split(",");

        showSaveLoading();

        $.post("<%=request.getContextPath()%>/arrayclassplan/getCourseById", {
            arrayClassId: '${data.arrayclassId}',
            courseType: courseType,
            courseID: courseId,
            majorCode: arr[0],
            trainingLevel: arr[2],
        }, function (course) {
            var weekType = course.weekType;
            var startWeek = course.startWeek;
            var endWeek = course.endWeek;
            var weekHours = course.weekHours;
            $.post("<%=request.getContextPath()%>/arrayclassplan/saveArrayclassArray", {
                arrayId: arrayId,
                arrayclassId: arrayclassId,
                departmentsId: departmentsId,
                majorCode: arr[0],
                majorDirection: arr[1],
                trainingLevel: arr[2],
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



