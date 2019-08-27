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
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教师所属部门
                    </div>
                    <div class="col-md-9">
                        <select id="deptId" onchange="changeDeptId()"   class="validate[required,maxSize[100]] form-control" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教师姓名
                    </div>
                    <div class="col-md-9">
                        <select id="userId" class="validate[required,maxSize[100]] form-control" disabled/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentsId" onchange="changeDept()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorId" onchange="changeMajor()"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <select id="courseId"/>
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
                        课时
                    </div>
                    <div class="col-md-9">
                        <input id="period" value="${data.period}"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term', '${data.term}');
        });

        $.get("<%=request.getContextPath()%>/common/getSelectDept", function (data) {

            if ('${head}'=='新增'){
                addOption(data, 'deptId', '${requestDept}');
            } else {
               addOption(data, 'deptId', '${data.deptId}');
            }
            if ('${data.deptId}' != null && '${data.deptId}' != '')
                changeDeptId('${data.deptId}');
        });

        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
            if ('${data.departmentsId}' != null && '${data.departmentsId}' != '') {
                changeDept('${data.departmentsId}');
                changeMajor('${data.majorId}');
            }
        });

        if ('${head}'=='新增'){
            $.post("<%=request.getContextPath()%>/common/getSelectUserByDeptId", {
                deptId: '${requestDept}'
            }, function (data) {
                addOption(data, 'userId', '${requester}');
            });
        }
    });

    function changeDeptId(departmentsId) {
        var deptId = $("#deptId").val();
        if (departmentsId) {
            deptId = departmentsId;
        }
        $.post("<%=request.getContextPath()%>/common/getSelectUserByDeptId", {
            deptId: deptId
        }, function (data) {
            addOption(data, 'userId', '${data.userId}');
        });
    }

    function changeDept(departmentsId) {
        var deptId = $("#departmentsId").val();
        if (departmentsId) {
            deptId = departmentsId;
        }
        $.post("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId", {
            deptId: deptId
        }, function (data) {
            addOption(data, 'majorId', '${data.majorId}');
        });
    }

    function changeMajor(majorCode) {
        var majorId = $("#majorId").val();
        if (majorCode) {
            majorId = majorCode
        }
        $.post("<%=request.getContextPath()%>/common/getClassIdByMajor", {
            majorCode: majorId.split(",")[0],
            trainingLevel: majorId.split(",")[1],
        }, function (data) {
            addOption(data, 'classId', '${data.classId}');
        });
        var course_sql = "(select course_id  code,course_name value from T_JW_COURSE where 1 = 1 and  COURSE_TYPE='1' \n" +
            "union all  select course_id  code,course_name value from T_JW_COURSE where 1 = 1  and valid_flag = 1";
        if ($("#majorCodeSel option:selected").val() != "") {
            course_sql += " and major_code ='" + majorId.split(",")[0] + "' and training_level='" + majorId.split(",")[1] + "' ";
        }
        course_sql += ")";
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " code ",
                text: " value ",
                tableName: course_sql,
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "courseId");
            })
        if ("" != '${data.courseId}') {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: "course_id",
                text: "course_name",
                tableName: "T_JW_COURSE",
                where: " ",
                orderBy: ""
            }, function (data) {
                addOption(data, 'courseId', '${data.courseId}');
            });
        }
    }

    function save() {
        var id = $("#id").val();
        var term = $("#term").val();
        var userId = $("#userId").val();
        var deptId = $("#deptId").val();
        var departmentsId = $("#departmentsId").val();
        var majorId = $("#majorId").val();
        var courseId = $("#courseId").val();
        var classId = $("#classId").val();
        var period = $("#period").val();

        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if (userId == "" || userId == undefined || userId == null) {
            swal({
                title: "请选择教师姓名！",
                type: "info"
            });
            return;
        }
        if (deptId == "" || deptId == undefined || deptId == null) {
            swal({
                title: "请选择网站类型！",
                type: "info"
            });
            return;
        }
        if (departmentsId == "" || departmentsId == undefined || departmentsId == null) {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if (majorId == "" || majorId == undefined || majorId == null) {
            swal({
                title: "请选择专业！",
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
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }
        if (period == "" || period == undefined || period == null) {
            swal({
                title: "请填写课时！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/teachingplanNew/saveTeachingplanNew", {
            id: id,
            term: term,
            userId: userId,
            deptId: deptId,
            departmentsId: departmentsId,
            majorId: majorId,
            courseId: courseId,
            classId: classId,
            period: period,
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



