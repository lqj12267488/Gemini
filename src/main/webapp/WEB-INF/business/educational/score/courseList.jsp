<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <input id="examId" name="examId" hidden value="${examId}"/>
        <div class="col-md-12">
            <div class="block">
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <br>
                    </div>
                    <table id="courseTable" cellpadding="0" cellspacing="0" width="100%"
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
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
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
        $("#did").change(function(){
            var major_sql = "(select distinct major_code || ',' || training_level code,major_name ||  '--' || FUNC_GET_DICVALUE(training_level, 'ZXZYPYCC') value from t_xg_major where 1=1  and valid_flag = 1";
            if($("#did option:selected").val()!="") {
                major_sql+= " and departments_id ='"+$("#did option:selected").val()+"' ";
            }
            major_sql+=")";
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
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
        //课程
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " course_id",
                text: " course_name ",
                tableName: "T_JW_COURSE",
                orderby: " order by COURSE_ID "
            },
            function (data) {
                addOption(data, "cid");
            });
        table = $("#courseTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreImport/getExamCourseList?examId=${examId}',
            },
            "destroy": true,
            "columns": [
                {"data": "examCourseId", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "examType", "visible": false},
                {"data": "courseType", "visible": false},
                {"data": "courseId", "visible": false},
                {"data": "departmentsId", "visible": false},
                {"data":"courseShow","title":"考试科目"},
                {"data":"courseTypeShow","title":"课程类型"},
                {"data":"startTime","title":"考试开始时间"},
                {"data":"endTime","title":"考试结束时间"},
                {"data":"examMinute","title":"考试时长"},
                {"data":"departmentShow","title":"系部"},
                {"data":"majorShow","title":"专业"},
                {"data":"examTypeShow","title":"考试形式"},
                {"data":"roomShow","title":"教室"}
            ],
            "dom": 'rtlip',
            language: language
        });
    })
    function back() {
        $("#right").load("<%=request.getContextPath()%>/scoreImport/examList");
    }
</script>