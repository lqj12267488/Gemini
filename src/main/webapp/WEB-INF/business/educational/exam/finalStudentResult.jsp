<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <input id="examId" name="examId" value="${examId}" hidden>
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${examName} > 查看考试安排</span>
                </div>
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="did"></select>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <select id="mid"></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <select id="bid"></select>
                            </div>
                            <div class="col-md-1 tar" style="margin-left: 3PX;margin-top: 6px;">
                                考试科目：
                            </div>
                            <div class="col-md-2">
                                <select id="cid"></select>
                            </div>
                        </div>
                        <div class="form-row">

                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="sname">
                            </div>
                            <div class="col-md-1 tar">
                                教室：
                            </div>
                            <div class="col-md-2">
                                <input id="roomShow">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>

                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="exportStudentArrayResult()">导出
                        </button>
                    </div>
                    <table id="studentArray" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="setRoom" tabindex="111" role="dialog" aria-labelledby="setRoom" aria-hidden="false"
     style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" onclick='$("#setRoom").modal("hide")' aria-hidden="true">×</button>
                <h4 class="modal-title">修改考场</h4>
            </div>
            <div class="modal-body clearfix">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 考场
                    </div>
                    <div class="col-md-9">
                        <input id="studentId" hidden>
                        <select id="roomId"></select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default btn-clean" onclick="updateStudentRoom()">保存</button>
                <button class="btn btn-default btn-clean" onclick='$("#setRoom").modal("hide")'>关闭</button>
            </div>
        </div>
    </div>
</div>
<script>

    function setRoom(id, examId) {
        $.get("<%=request.getContextPath()%>/eaxm/getRoom?id=" + id + "&examId=" + examId, function (data) {
            addOption(data, "roomId");
            $("#studentId").val(id);
            $("#setRoom").modal("show");
            $(".modal-backdrop").removeClass("modal-backdrop");
        });
    }

    function updateStudentRoom() {
        var id = $("#studentId").val();
        var roomId = $("#roomId").val();
        if (roomId == '' || roomId == undefined) {
            swal({
                title: "请选择教室",
                type: "info"
            });
            return;
        }
        $.get("<%=request.getContextPath()%>/eaxm/updateStudentRoom?id=" + id + "&roomId=" + roomId, function (data) {
            swal({
                title: data.msg,
                type: "info"
            });
            $("#setRoom").modal("hide");
            $("#studentArray").DataTable().ajax.reload();
        });
    }

    var table;
    $(document).ready(function () {
        //系部
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: " "
            },
            function (data) {
                addOption(data, "did");
            });
        //系部联动专业
        $("#did").change(function () {
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if ($("#did option:selected").val() != "") {
                major_sql += " and departments_id ='" + $("#did option:selected").val() + "' ";
            }
            major_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: major_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "mid");
                })
        });
        //专业联动班级
        $("#mid").change(function () {
            var class_sql = "(select class_id  code,class_name value from T_XG_CLASS where 1 = 1  and valid_flag = 1";
            if ($("#mid option:selected").val() != "") {
                class_sql += "and major_code ='" + $("#mid option:selected").val().split(",")[0] + "' and training_level='" + $("#mid option:selected").val().split(",")[1] + "' ";
            }
            class_sql += ")";
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " code ",
                    text: " value ",
                    tableName: class_sql,
                    where: " ",
                    orderby: " "
                },
                function (data) {
                    addOption(data, "bid");
                })
        });
        //课程
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " course_id",
                text: " course_name ",
                tableName: "T_JW_COURSE",
                orderby: " order by COURSE_ID "
            },
            function (data) {
                addOption(data, "cid");
            });
        table = $("#studentArray").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/array/student/getStudentArrayList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "courseShow", "title": "考试科目"},
                {"data": "roomName", "title": "教室"},
                {"data": "departmentShow", "title": "系部"},
                {"data": "majorShow", "title": "专业"},
                {"data": "classShow", "title": "班级"},
                {"data": "studentName", "title": "学生"},
                {"data": "date", "title": "日期"},
                {"data": "startTime", "title": "考试开始时间"},
                {"data": "endTime", "title": "考试结束时间"},
                // {"data": "ticketNumber", "title": "准考证号"},
                // {"data": "seatNumber", "title": "座位"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改考场" ' +
                            'onclick=setRoom("' + row.id + '","' + row.examId + '")/>&ensp;&ensp;'
                    }
                }
            ],
            'order': [[2, 'desc'], [3, 'desc'], [4, 'desc'], [5, 'desc'], [6, 'desc'], [7, 'desc'], [8]],
            "dom": 'rtlip',
            language: language
        });
    });

    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#bid").val("");
        $("#cid").val("");
        $("#sname").val("");
        $("#roomShow").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/array/student/getStudentArrayList?examId=${examId}").load();
    }

    function search() {
        var did = $("#did").val();
        var mid = $("#mid").val();
        var bid = $("#bid").val();
        var cid = $("#cid").val();
        var majorData = "";
        if (mid != null) {
            majorData = mid.split(",")[0];
        }
        var trainingLevel = "";
        table.ajax.url("<%=request.getContextPath()%>/exam/array/student/getStudentArrayList?departmentsId=" + did + "&majorCode=" + majorData + "&trainingLevel=" + trainingLevel
            + "&classId=" + bid + "&courseId=" + cid + "&examId=${examId}&studentId=" + $("#sname").val()
            + "&roomId=" + $("#roomShow").val()).load();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/result/student");
    }

    function exportStudentArrayResult() {
        window.location.href = "<%=request.getContextPath()%>/exam/export/studentResult?&examId=${examId}";
    }

</script>