<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部
                            </div>
                            <div class="col-md-2">
                                <select id="edit_deptName" onchange="onchangeDept()"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业
                            </div>
                            <div class="col-md-2">
                                <select id="edit_majorName" onchange="onchangemajor()"/>
                            </div>
                            <div class="col-md-1 tar">
                                班级
                            </div>
                            <div class="col-md-2">
                                <select id="edit_className" onchange="onchangeClass()"/>
                            </div>
                            <div class="col-md-1 tar">
                                学生姓名
                            </div>
                            <div class="col-md-2">
                                <select id="edit_student1"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                开始时间
                            </div>
                            <div class="col-md-2">
                                <input id="search_startTime" type="date"
                                       class="validate[required,maxSize[100]] form-control">
                            </div>
                            <div class="col-md-1 tar">
                                结束时间
                            </div>
                            <div class="col-md-2">
                                <input id="search_endTime" type="date"
                                       class="validate[required,maxSize[100]] form-control">
                            </div>
                            <div class="col-md-3 tar">

                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>

                            </div>
                        </div>

                    </div>
                </div>
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addExam()">新增
                        </button>
                        <br>
                    </div>
                    <table id="examTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="person_id" value="${person_id}" hidden>
<script>
    var personId = $("#person_id").val();
    var table;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select DEPT_ID id, DEPT_NAME text from T_SYS_DEPT where DEPT_TYPE='8' )",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_deptName", '${DormManage.buildingId}');
            });
        table = $("#examTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/dormmanage/DormManageList?dormManageType=1',
            },
            "destroy": true,
            "columns": [
                {"data": "manageId", "visible": false},
                {"data": "dormitoryId", "visible": false},
                {"data": "teacherId", "visible": false},
                {"data": "departmentsName", "title": "系部"},
                {"data": "majorCodeName", "title": "专业"},
                {"data": "className", "title": "班级"},
                {"data": "studentName", "title": "学生姓名"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {"data": "teacherName", "title": "登记老师姓名"},
                {"data": "remark", "title": "备注"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editExam("' + row.manageId + '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delExam("' + row.manageId + '","' + row.studentName + '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select b.id id , b.building_name text from t_jw_building b where b.id in " +
                "(select t.building_id from T_ZW_TEACHER_ORDEROFFICE t where t.teacher_id = '" + personId + "'))",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_buildingId", '${DormManage.buildingId}');
            });
    })

    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/editc")
        $("#dialog").modal("show")
    }

    function editExam(manageId) {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/editc?manageId=" + manageId)
        $("#dialog").modal("show")
    }

    function delExam(manageId, studentName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "学生姓名：" + studentName + "  删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dormmanage/delete", {
                manageId: manageId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#examTable').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#edit_deptName").val("");
        $("#edit_majorName").val("");
        $("#edit_className").val("");
        $("#edit_student1").val("");
        $("#search_startTime").val("");
        $("#search_endTime").val("");

        table.ajax.url("<%=request.getContextPath()%>/dormmanage/DormManageList?dormManageType=1").load();
    }

    function search() {
        var startTime = $("#search_startTime").val();
        var endTime = $("#search_endTime").val();
        var deparmentsId = $("#edit_deptName").val();
        var majorCodeId = $("#edit_majorName").val();
        var classId = $("#edit_className").val();
        var studentId = $("#edit_student1").val();
        if (endTime != "") {
            endTime = endTime;
        }
        if(startTime!=""){
            startTime = startTime;
        }
        table.ajax.url("<%=request.getContextPath()%>/dormmanage/DormManageList?dormManageType=1&type=1" + "&startTime=" + startTime + "&endTime=" + endTime+ "&deparmentsId=" + deparmentsId+ "&majorCodeId=" + majorCodeId+ "&classId=" + classId+ "&studentId=" + studentId).load();
    }

    function onchangeDept() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select MAJOR_CODE id,MAJOR_NAME text from T_XG_MAJOR where DEPARTMENTS_ID='" + $("#edit_deptName").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_majorName", '${teacherPlanJob.buildingId}');
            });
    }

    function onchangemajor() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select CLASS_ID id ,CLASS_NAME text from T_XG_CLASS where MAJOR_CODE='" + $("#edit_majorName").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_className", '${teacherPlanJob.buildingId}');
            });

    }

    function onchangemajor() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select CLASS_ID id ,CLASS_NAME text from T_XG_CLASS where MAJOR_CODE='" + $("#edit_majorName").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_className", '${teacherPlanJob.buildingId}');
            });

    }

    function onchangeClass() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " id",
                text: " text ",
                tableName: "(select s.STUDENT_ID id, s.NAME text from T_XG_STUDENT s, T_XG_CLASS c, T_xg_student_class sc where s.STUDENT_ID=sc.STUDENT_ID and c.CLASS_ID=sc.CLASS_ID and c.CLASS_ID='" + $("#edit_className").val() + "')",
                where: " ",
                orderby: " "
            },
            function (data) {
                addOption(data, "edit_student1", '${teacherPlanJob.buildingId}');
            });

    }


</script>