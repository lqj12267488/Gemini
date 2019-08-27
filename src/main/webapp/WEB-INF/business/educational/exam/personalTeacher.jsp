<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <input id="examId" name="examId" value="${examId}" hidden>
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
                                <select id="mid">
                                    <option value="">请选择系部</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <select id="bid">
                                    <option value="">请选择专业</option>
                                </select>
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
                                监考教师：
                            </div>
                            <div class="col-md-2">
                                <input id="tname">
                            </div>
                            <div class="col-md-1 tar" style="margin-left: 3PX;margin-top: 6px;">
                                教室：
                            </div>
                            <div class="col-md-2">
                                <input id="roomName"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar" style="margin-left: 3PX;margin-top: 6px;">
                                考试时间：
                            </div>
                            <div class="col-md-2">
                                <input id="d" type="date"/>
                            </div>
                        </div>
                        <div class="col-md-6 tar">
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
                        <br>
                    </div>
                    <table id="teacherArray" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
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
        table = $("#teacherArray").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/exam/array/getTeacherArrayList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "courseShow", "title": "考试科目"},
                {"data": "roomShow", "title": "教室"},
                {"data": "departmentShow", "title": "系部"},
                {"data": "majorShow", "title": "专业"},
                {"data": "classShow", "title": "班级"},
                {"data": "teacherPersonShow", "title": "监考教师"},
                {"data": "date", "title": "日期"},
                {"data": "startTime", "title": "考试开始时间"},
                {"data": "endTime", "title": "考试结束时间"},
            ],
            'order': [[1, 'desc']],
            "dom": 'rtlip',
            language: language
        });
    });


    function editTeacherArray(id) {
        $("#dialog").load("<%=request.getContextPath()%>/exam/arry/toEdit?id=" + id)
        $("#dialog").modal("show")
    }

    function delTeacherArray(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/exam/array/del", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#teacherArray').DataTable().ajax.reload();
            });
        })
    }

    function searchclear() {
        $("#did").val("");
        $("#mid").val("");
        $("#bid").val("");
        $("#cid").val("");
        $("#tname").val("");
        $("#d").val("");
        $("#roomName").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/array/getTeacherArrayList?examId=${examId}").load();
    }

    function search() {
        var did = $("#did option:selected").val();
        var mid = $("#mid option:selected").val();
        var bid = $("#bid option:selected").val();
        var cid = $("#cid option:selected").val();
        table.ajax.url("<%=request.getContextPath()%>/exam/array/getTeacherArrayList?departmentsId=" +
            did + "&majorCode=" + mid + "&classId=" + bid + "&courseId=" + cid + "&examId=${examId}&teacherPersonShow=" + $("#tname").val() +
            "&date=" + $("#d").val() + "&roomShow=" + $("#roomName").val()).load();
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/result/teacher");
    }

</script>